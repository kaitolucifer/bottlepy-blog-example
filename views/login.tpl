% include('header.tpl', login_status=login_status, refresh=None)
    <div class="row">
        <form class="col-sm-4 col-sm-offset-4 login_bg" method="post">
        <h2>ログイン</h2>
            <div class="form-group">
                <input type="text" placeholder="ユーザー名" name="login_user_name" id="login_user_name" class="form-control">
            </div>
            <div class="form-group">
                <input type="password" placeholder="パスワード" name="login_user_password" id="login_user_password" class="form-control">
            </div> 
            <input type="submit" name="login_btn" id="login_btn" class="btn btn-primary btn-block login_btn" value="確認"/>
        <p style="color:red;font-size:90%;">{{ message }}</p>
        </form>
    </div>
% include('footer.tpl')