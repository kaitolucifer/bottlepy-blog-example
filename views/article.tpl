% include('header.tpl', login_status=login_status, refresh=None)
    <h2>単独ページ</h2>
    <div class="panel panel-info">
        <div class="panel-heading">
            <div class="btn-group" style="float:right;">
            	<button type="button" class="btn btn-primary dropdown-toggle {{'' if login_status else 'disabled'}}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            		<span span class="glyphicon glyphicon-cog" aria-hidden="true" tabindex="-1"></span>
            		<span class="sr-only">Toggle Dropdown</span>
            	</button>
            	<ul class="dropdown-menu">
            		<li><a href="/article/{{ article[0] }}/edit" tabindex="-1"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> 編集</a></li>
            		<li role="separator" class="divider"></li>
            		<li><a href="/article/{{ article[0] }}/delete" tabindex="-1"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span> 削除</a></li>
            	</ul>
            </div>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
            <div class="media">
                <div class="media-body">
                <p class="media-heading" style="font-weight:bold;color:#708090;font-size:250%;">{{ article[2] }}</p>
                <hr />
                {{! article[3] }}
                <div class="clearfix"></div>               
               </div>
            </div>
            <span class="label label-info" style="float:right;">{{ article[1] }}</span>
        </div>
    </div>
    % if article[0]-1 >= 1:
    <div class="btn-group btn-group-lg" role="group" style="float:left;">
        <a href="/article/{{ article[0]-1 }}" class="btn btn-default" role="button" style="float:left;">
            前の記事
        </a>
    </div>
    % end
    % if article[0]+1 <= article_num:
    <div class="btn-group btn-group-lg" role="group" style="float:right;">
        <a href="/article/{{ article[0]+1 }}" class="btn btn-default" role="button" style="float:right;">
            次の記事
        </a>
    </div>
    % end
% include('footer.tpl')