% include('header.tpl', login_status=login_status, refresh=None)
	<form class="form-horizontal" method="post">
		<div class="form-group">
			<label for="title" class="col-sm-2 control-label"><h2>記事を書く</h2></label>
		</div>
		<div class="form-group">
			<label for="title" class="col-sm-2 control-label">タイトル</label>
			<div class="col-sm-10">
			<textarea class="form-control" id="title" name="title" style="height:35px;" placeholder="タイトルは必須" required="required"}></textarea>
			</div>
		</div>
		<div class="form-group">
			<label for="Content" class="col-sm-2 control-label">内容</label>
			<div class="col-sm-10">
			<textarea class="form-control" id="content" name="content" style="height:500px" placeholder="Markdown記法が利用可能" required="required"></textarea>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
			<button class="btn btn-primary" type="submit">投稿</button>
			<a class="btn btn-default" href="/">キャンセル</a>
			</div>
		</div>
	</form>
% include('footer.tpl')