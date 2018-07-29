% include('header.tpl', login_status=login_status, refresh=None)
    <div class="row">
        <div class="alert alert-warning" role="alert">
            この記事を削除しますか？
            <a class="btn btn-primary" href="/article/{{ id }}/delete?confirm=yes">確認</a>
            <a class="btn btn-default" href="/article/{{ id }}">キャンセル</a>
        </div>
    </div>
% include('footer.tpl')