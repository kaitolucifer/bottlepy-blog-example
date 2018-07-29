% include('header.tpl', login_status=login_status, refresh=True)
    <div class="row">
        % if error:
        <div class="alert alert-danger" role="alert">{{ message }}</div>
        % else:
        <div class="alert alert-success" role="alert">{{ message }}</div>
        % end
        <p style="color:DimGray;font-size:90%">3秒後Homeに自動ジャンプする。</p>
    </div>
% include('footer.tpl')