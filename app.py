import os, sys
from math import ceil
from bottle import (run, route, error, get, post, view, template,
                    response, request, abort, redirect, static_file)
import webbrowser as web
import datetime as dt
import sqlite3
from utils import md2html, get_arg


# パス調整
dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(dirname)
os.chdir(dirname)

# データベースに接続
conn = sqlite3.connect('blog.db')
c = conn.cursor()
try:
    c.execute("CREATE TABLE IF NOT EXISTS articles (date TEXT, title TEXT, content TEXT)")
except sqlite3.Error as e:
    print(f'sqlite3エラーが発生しました: {e.args[0]}')

# 定数の宣言
USERNAME = 'admin'
PASSWORD = '1026'
# SECRET_KEY = os.environ['SECRET_KEY']
SECRET_KEY = 'fakekey'
PER_PAGE = 10


# 静的ファイル
@route('/static/<filename:re:.*\.css>')
def send_css(filename):
    return static_file(filename, root='static/css')

@route('/static/<filename:re:.*\.js>')
def send_js(filename):
    return static_file(filename, root='static/js')

@route('/<filename:re:.*\.ico>')
def send_favicon(filename):
    return static_file(filename, root='static/')

@route('/fonts/<filename>')
def send_font(filename):
    return static_file(filename, root='static/fonts')

# エラーページ
@error(404)
def error404(error):
    login_status = request.get_cookie('login_status', False, secret=SECRET_KEY)
    return template('message_page', login_status=login_status, error=True, message='404エラー：お探しのページは見つかりませんでした。')

@error(500)
def error500(error):
    login_status = request.get_cookie('login_status', False, secret=SECRET_KEY)
    return template('message_page', login_status=login_status, error=True, message='500エラー：内部サーバーエラー。')

# ルートページ
@route('/')
@view('index')
def index():
    login_status = request.get_cookie('login_status', False, secret=SECRET_KEY)
    article_num = c.execute('SELECT COUNT(*) FROM articles').fetchone()[0]
    if article_num:
        articles = c.execute('SELECT rowid, * FROM articles WHERE rowid >= ?', (article_num-2,)).fetchall()
        # 最新投稿3件を新しい順に表示
        articles = [md2html(article) for article in articles[::-1]]
        return dict(login_status=login_status, articles=articles)
    else:
        return dict(login_status=login_status, articles=[('', '', '', '記事がありません。')])

# ログインページ
@route('/login')
@view('login')
def login():
    return dict(message='', login_status=False)

@post('/login')
def do_login():
    username = request.forms.get('login_user_name')
    password = request.forms.get('login_user_password')
    if (username, password) == (USERNAME, PASSWORD):
        # cookie生存時間を1時間に設定
        response.set_cookie('login_status', True, max_age=3600, secret=SECRET_KEY)
        return template('message_page', login_status=True, error=False, message='ログインしました。')
    else:
        return template('login', message="ユーザー名またはパスワードが正しくありません。", 
                        login_status=False)

# ログアウトページ
@route('/logout')
@view('message_page')
def logout():
    response.delete_cookie('login_status', secret=SECRET_KEY)
    return dict(login_status=False, error=False, message='ログアウトしました。')

# 「記事を書く」ページ
@route('/write')
@view('write')
def write():
    login_status = request.get_cookie('login_status', False, secret=SECRET_KEY)
    if login_status:
        return dict(login_status=login_status)
    else:
        redirect('/login')

@post('/write')
@view('message_page')
def do_write():
    title = request.forms.title # request.forms.get()でインプット取得すると文字化けするので要注意
    content = request.forms.content
    date = '公開日時：' + str(dt.datetime.now()).split('.')[0]
    c.execute('INSERT INTO articles VALUES (?, ?, ?)', (date, title, content))
    conn.commit()
    return dict(login_status=True, error=False, message='記事を投稿しました。')

# 「記事一覧」ページ
@route('/articles')
@route('/articles/<page:int>')
def articles_list(page=0):
    login_status = request.get_cookie('login_status', False, secret=SECRET_KEY)
    query = request.query.q
    # 検索機能
    if query and login_status:
        articles = c.execute(f"SELECT rowid, * FROM articles WHERE title LIKE '%{query}%' OR content LIKE '%{query}%'").fetchall()
        if not articles:
            return template('message_page', login_status=login_status, error=True, message='一致した記事がありません。')
        page_num = None
    # 記事一覧
    else:
        article_num = c.execute('SELECT COUNT(*) FROM articles').fetchone()[0]
        page_num = ceil(article_num / PER_PAGE)
        # ページが存在しないとき
        if page > page_num - 1:
            return template('message_page', login_status=login_status, error=True, message='記事がありません。')
        # 1ページに表示される記事をSELECT
        start, end = article_num - (page+1)*PER_PAGE, article_num - page*PER_PAGE
        # 新しい順にする
        articles = c.execute('SELECT rowid, * FROM articles WHERE rowid > ? AND rowid <= ?', (start, end)).fetchall()[::-1]

    # 引数をまとめる
    head = '記事一覧' if page_num else '検索結果'
    params = dict(zip(('login_status', 'head', 'articles', 'page_num', 'current_page'), (login_status, head, articles, page_num, page)))
    return template('articles', **params)

# 記事単独ページ
@route('/article/<id:int>')
@view('article')
def article_page(id):
    login_status = request.get_cookie('login_status', False, secret=SECRET_KEY)
    article_num = c.execute('SELECT COUNT(*) FROM articles').fetchone()[0]
    article = c.execute('SELECT rowid, * FROM articles WHERE rowid == ?', (id,)).fetchall()
    if not article:
        abort(404)
    article = md2html(article[0])
    return dict(login_status=login_status, article=article, article_num=article_num)

# 記事の削除
@get('/article/<id:int>/delete')
def delete(id):
    login_status = request.get_cookie('login_status', False, secret=SECRET_KEY)
    if login_status:
        confirm = request.query.confirm
        if confirm == 'yes':
            c.execute("DELETE FROM articles WHERE rowid == ?", (id,))
            # python3.6におけるpysqliteのisolation_levelバグ対策
            conn.isolation_level = None
            # rowidをリセットする
            conn.execute('VACUUM')
            # isolation_levelを元に戻す
            conn.isolation_level = ''
            conn.commit()
            return template('message_page', login_status=True, error=False, message='記事を削除しました。')
        return template('delete', id=id, login_status=True)
    else:
        redirect('/login')

# 記事の編集
@route('/article/<id:int>/edit')
@view('edit')
def edit(id):
    login_status = request.get_cookie('login_status', False, secret=SECRET_KEY)
    if login_status:
        article = c.execute('SELECT rowid, * FROM articles WHERE rowid == ?', (id,)).fetchall()
        return dict(login_status=login_status, article=article[0])
    else:
        redirect('/login')

@post('/article/<id:int>/edit')
@view('message_page')
def do_edit(id):
    title = request.forms.title
    content = request.forms.content
    date = str(dt.datetime.now()).split('.')[0]
    c.execute('UPDATE articles SET date = ?, title = ?, content = ? WHERE rowid == ?', ('最終更新日時：' + date, title, content, id))
    conn.commit()
    return dict(login_status=True, error=False, message='記事を編集しました。')


if __name__ == '__main__':
    host = get_arg(1, 'localhost')
    port = int(get_arg(2, 5000))
    web.open(f'http://{host}:{port}') # ブラウザーを開く
    run(host=host, port=port, debug=True)
