<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="A project created by Bottle-py and Bootstrap">
	<meta name="author" content="kaito">
	% if refresh:
	<meta http-equiv="refresh" content="3;url=/">
	% end
	<link rel="icon" type="image/ico" href="/favicon.ico">		
	<title>Kaito's Blog</title>
	<link rel="stylesheet" type="text/css" href="/static/bootstrap.min.css">
	<link rel="stylesheet" href="/static/styles.css">
	<link rel="stylesheet" href="/static/custom.css">
	<script type="text/javascript" src="/static/jquery.min.js"></script>
	<script type="text/javascript" src="/static/bootstrap.min.js"></script>
	<script src='https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-MML-AM_CHTML' async></script>
	<script type="text/x-mathjax-config">
		MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$']], displayMath: [['$$','$$']]}});
	</script>
</head>
<body>
	<nav class="navbar navbar-default navbar-static-top">
		<div class="container">
			<div class="row">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="/">Kaito's Blog</a>
				</div>
				<div id="navbar" class="navbar-collapse collapse">
					<ul class="nav navbar-nav navbar-center">
						<li><a href="/">Home</a></li>
						<li><a href="/articles">記事一覧</a></li>
						<li><a href="/write">記事を書く</a></li>
						% if not login_status:
						<li><a href="/login">ログイン</a></li>
						% else:
						<li><a href="/logout">ログアウト</a></li>
						% end
					</ul>
					% if login_status:
					<form class="navbar-form navbar-right" id="search-form" action="/articles" method="get" role="search">
						<div class="input-group">
							<input class="form-control" name="q" placeholder="記事検索" required>
							<span class="input-group-btn">
								<button type="submit" class="btn btn-default"><i class="glyphicon glyphicon-search"></i></button>
							</span>
						</div>
					</form>
					% end
				</div>
			</div>
		</div>
	</nav>
	<div class="container">