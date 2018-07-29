% include('header.tpl', login_status=login_status, refresh=None)
		<div class="row">
			<h2>利用説明</h2>
			<div class="well">
				ログアウト状態では記事の閲覧のみが可能です。<br/>
				まず、<font class="intro">ログイン</font>をクッリクして、デフォルトアカウントの<font class="intro"></font>「admin, 1026」</font>でログインしてください。
				<font class="intro">記事を書く</font>をクッリクして、記事を投稿してみてください。<font class="intro">Markdown記法</font>が使えます。
				また、Youtube動画などそのまま貼り付ければ<font class="intro">リッチコンテンツ</font>に変換されます。
				<font class="intro">記事一覧</font>では投稿した記事はすべて表示されます。記事一覧ページの右上に<font class="intro">検索バー</font>も利用できます。
				<font class="intro">続きを読む</font>をクリックすると、記事の<font class="intro">個別ページ</font>にアクセスできます。
				記事一覧と記事個別ページの右上にボタンがあるが、クリックして<font class="intro">編集</font>と<font class="intro">削除</font>ができます。</div>
			</div>
		<div class="row">
			<h2>最新投稿</h2>
			% for article in articles:
			<div class="panel panel-info">
				<div class="panel-body">
					<div class="media">
						<div class="media-body">
						<a href="/article/{{ article[0] }}" class="media-heading" style="font-weight:bold;color:#708090;font-size:250%;">{{ article[2] }}</a>
						<hr />
						{{! article[3] }}
						<div class="clearfix"></div>               
						</div>
					</div>
					% if article[0]:
					<div class="btn-group btn-group-sm" style="float:left;">
						<a class="btn btn-default" href="/article/{{ article[0] }}">
							<span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>
						</a>
					</div>
					<span class="label label-info" style="float:right;">{{ article[1] }}</span>
					% end
				</div>
			</div>
			% end
		</div>
% include('footer.tpl')