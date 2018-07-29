% include('header.tpl', login_status=login_status, refresh=None)
	<form class="form-horizontal" method="post">
		<div class="form-group">
			<label for="title" class="col-sm-2 control-label"><h2>編集</h2></label>
		</div>
		<div class="form-group">
			<label for="title" class="col-sm-2 control-label">タイトル</label>
			<div class="col-sm-10">
				<textarea class="form-control" id="title" name="title" style="height:35px;" placeholder="タイトルは必須" required="required"}>{{ article[2] }}</textarea>
			</div>
		</div>
		<div class="form-group">
			<label for="Content" class="col-sm-2 control-label">内容</label>
			<div class="col-sm-10">
				<textarea class="form-control" id="content" name="content" style="height:500px;" placeholder="Markdown記法が利用可能" required="required">{{ article[3] }}</textarea>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button class="btn btn-primary" type="submit">確認</button>
				<a class="btn btn-default" href="/article/{{ article[0] }}">キャンセル</a>
			</div>
		</div>
	</form>
% include('footer.tpl')