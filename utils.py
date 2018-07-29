import re
import sys
import markdown as md
import micawber


# Markdownをhtmlに変換
def md2html(article):
    # Markdown拡張
    exts = ['markdown.extensions.extra', 'markdown.extensions.codehilite',
            'markdown.extensions.tables', 'markdown.extensions.toc']
    content = article[3]
    # Markdownに使われる[xxx](http://xxx.xxx)とHTMLタグの中のURLを除外する
    pattern = re.compile(r'''(?<!\]\(|.>|=")https?://[\w/:%#\$&\?~\.=\+\-@]+(?!\)|<|">)''', re.S | re.M)
    urls = list(set(re.findall(pattern, content)))
    # urlをリッチコンテンツに変換するparser
    providers = micawber.bootstrap_basic()
    for url in urls:
        # urlをリッチurlに変更(youtubeなどの動画が表示される)
        rich_url = micawber.parse_text(url, providers)
        content = content.replace(url, rich_url)
    content = md.markdown(content, extensions=exts)
    return article[:3] + (content,)

# コマンド引数でホストとポートを指定
def get_arg(index, default):
    try:
        sys.argv[index]
    except IndexError:
        return default
    else:
        return sys.argv[index]