% include('header.tpl', login_status=login_status, refresh=None)
    <h2>{{ head }}</h2>
    % for article in articles:
    <div class="pane panel panel-info">
        <div class="panel-body">
            <div class="media">
                % import re
                % pattern = re.compile(r'!\[.*\]\((.+)\)')
                % match = re.search(pattern, article[3])
                % if match:
                <div class="col-xs-8 col-md-4">
                    <a class="media-left media-middle thumbnail" href="/article/{{ article[0] }}">
                        <img src={{! match.group(1)}}>
                    </a>
                </div>
                <!-- % pattern = re.compile('<img.*?>') -->
                <!-- % content = re.sub(pattern, '[画像非表示]', article[3]) -->
                <!-- % else: -->
                <!-- % content = article[3] -->
                % end
                <div class="media-body">
                    <a href="/article/{{ article[0] }}" class="media-heading" style="font-weight:bold;color:#708090;font-size:250%;">{{ article[2] }}</a>
                    <hr />
                    <a href="/article/{{ article[0] }}" style="color:#778899;">{{ article[3][:200] }}...</a>
                    <div class="btn-group btn-group-sm"><a class="btn btn-default" href="/article/{{ article[0] }}">続きを読む</a></div>
                    <div class="clearfix"></div>               
                </div>
            </div>
            <span class="label label-info" style="float:right;">{{ article[1] }}</span>
        </div>
    </div>
    % end
    % if page_num != None:
    <nav aria-label="Page navigation" class="pull-right">
        <ul class="pagination">
            <li><a href="/articles">最初へ</a></li>
            % if current_page > 0:
            <li><a href="/articles/{{ current_page-1 }}" aria-label="Previous"><span aria-hidden="true">«</span></a></li>
            % else:
            <li class="disabled"><a href="#" aria-label="Previous"><span aria-hidden="true">«</span></a></li>
            % end
            % for i in range(page_num):
            % if i == current_page:
            <li class="active"><a = href='/articles/{{ i }}'>{{ i+1 }}</a></li>
            % else:
            <li><a = href='/articles/{{ i }}'>{{ i+1 }}</a></li>
            % end
            % end
            % if current_page == page_num - 1:
            <li class="disabled"><a href="#" aria-label ="Next"><span aria-hidden="true">»</span></a></li>
            % else:
            <li class><a href="/articles/{{ current_page+1 }}" aria-label ="Next"><span aria-hidden="true">»</span></a></li>
            % end
            <li><a href="/articles/{{ page_num-1 }}">最後へ</a></li>
        </ul>
    </nav>
    % end
% include('footer.tpl')