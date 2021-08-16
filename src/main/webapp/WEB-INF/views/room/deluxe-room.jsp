<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + 	request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="js/jquery-1.11.1-min.js"></script>
    <link rel="stylesheet" type="text/css" href="bootstrap_3.3.0/css/bootstrap.min.css">
    <script src="js/textyleF.js"></script>
    <link rel="stylesheet Icon" type=" image/x-icon" href="images/hotel.png">
    <script src="css/fenye/jqPaginator.js"></script>

    <link rel="stylesheet" href="css/room/deluxe-room.css">
    <link rel="stylesheet" href="//at.alicdn.com/t/font_2702840_dk6znqsmu64.css">
    <link rel="stylesheet" href="css/CommonStyle/base.css">
    <link rel="stylesheet" href="css/CommonStyle/reset.css">
    <title>总统套房</title>
</head>

<body>
    <!-- 顶部 -->
    <div class="top-home cleafix">
        <ul class="menu">
            <li id="push">
                <i class="iconfont icon-shouye"></i>
            </li>
            <li id="pushed-left-1">
                <a href="index.do"> <span>
                        首页
                    </span></a>

            </li>
            <li id="pushed-center">
                <a href="frontend/toservices.do"><span>
                        服务
                    </span></a>
            </li>
            <li id="pushed-right-1">
                <a href="frontend/touserorder.do"><span>
                        订单
                    </span></a>
            </li>
            <li id="pushed-right-2">
                <a href="frontend/touserlist.do"><span>
                        信息
                    </span></a>
            </li>
        </ul>
    </div>

    <div class="top cleafix">
        <div class="top-bg cleafix">
            <div class="top-title cleafix">
                <h2>欢迎订购总统套房</h2>
                <span>始于2014年的豪华公寓德尔夫特有1个愿景，从来没有改变。我们的愿景是为客人提供体验。不只是一个简单的夜晚。我们所做的一切都是为了创造一种哇的感觉。跳出框框思考，让你感觉很特别。</span>
                <div class="title-img"></div>
            </div>
        </div>
    </div>
    <div class="content cleafix">
        <div class="content-h2 cleafix">
            <h2>关于我们</h2>
        </div>
        <div class="content-span cleafix">
            <span>了创造这种体验，我们设计了精美的公寓，为他们提供所有的豪华装备，并将其安置在德尔夫特市中心。
                我们的豪华公寓提供休闲和商务服务。适合同一公寓的 2 至 12
                位客人入住。步行即可到达所有美丽的纪念碑和商店。靠近公寓的豪华公寓Delft提供美味的自助早餐，包括新鲜的橙汁、新鲜的平底锅蛋糕、羊角面包、酸奶、玉米片、奈斯派索咖啡、茶等。</span>
        </div>
    </div>

    <!-- 房间订购页 -->
    <div class="room-layout cleafix">
        <div class="room-content cleafix">
            <div class="room-title cleafix">
                <span>房间</span>
                <h3>房间和价格</h3>
            </div>
            <div class="room-center cleafix">

            </div>
        </div>
        <!-- 分页 -->
        <nav class="pagination-outer" aria-label="Page navigation">
            <ul class="pagination">

            </ul>
        </nav>
    </div>

    <!-- 底部 -->
    <div class="bottom cleafix">
        <div class="cleafix">
            <h3>本网页只供学习使用</h3>
            <span>如有侵权联系&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
                    href="https://qm.qq.com/cgi-bin/qm/qr?k=OD1io72em7cmwBZtSk12nwGGFnzomMNN&noverify=0"
                    target="blank">QQ1933823757</a></span>
        </div>
    </div>

    <script>
        $(function () {
            pageList(1,true);
            // 导航栏动画
            $(document).ready(function () {
                $('#push').on('click', function () {
                    $('#push, #pushed-center, #pushed-left-1, #pushed-right-1, #pushed-right-2').toggleClass('move');
                    $('#push').toggleClass('rotate');
                });
            });
        })

        //分页
        function pageList(pageNo,isfist) {
            $.ajax({
                url: "frontend/getDeluxe.do",
                type: "post",
                data: {
                    "pageNo": pageNo,
                    "pageSize": 6
                },
                dataType: "json",
                success: function (data) {
                    var html = ""
                    if (data.list == ''){
                        html+='<h2 style="font-size: 20px; text-align: center;color: red; margin-top: 30px">房间已被预定完，请联系管理员</h2>'

                    } else{
                        $.each(data.list, function (i, n) {
                            //写ajax发送请求数据
                            html+='<div class="content cleafix">'
                            html+=' <a href="frontend/toroomOrder.do?id='+n.id+'"><img src="'+n.roomImgPath+'" alt=""></a>'
                            html+='<div class="text">'
                            html+=' <a href="frontend/toroomOrder.do?id='+n.id+'">'
                            html+='<h3>'+n.roomType+'</h3>'
                            html+='</a>'
                            html+='<div class="rating">'
                            // html+='<i class="iconfont icon-xingxing " style="color: rgba(181, 105, 82, 0.863);"></i>'
                            // html+='<i class="iconfont icon-xingxing" style="color: rgb(181, 105, 82, 0.863);"></i>'
                            // html+='<i class="iconfont icon-xingxing" style="color: rgb(181, 105, 82, 0.863);"></i>'
                            // html+='<i class="iconfont icon-xingxing"></i>'
                            // html+='<i class="iconfont icon-xingxing"></i>'
                            html+=' </div>'
                            html+='<ul><li>'+n.roomPrice+'</li><li> / 每晚</li></ul>'
                            html+=' </div> </div>'
                        })
                    }
                    console.log(html)
                    $(".room-center").html(html)
                    if (isfist) {
                        // 分页
                        $('.pagination').jqPaginator({
                            // 总页数
                            totalPages:(data.pages == 0?1:data.pages),
                            //显示多少页
                            visiblePages: 4,
                            //初始化停在的页数
                            currentPage: 1,
                            // first:'<li class="page-item"><a class="page-link" href="javascript:void(0);">末</a></li>',
                            prev: '<li class="page-item " ><a class="page-link" href="javascript:void(0);"> <span aria-hidden="true">«</span></a></li>',
                            next: '<li class="page-item"><a class="page-link" href="javascript:void(0);"><span aria-hidden="true">»</span></a></li>',
                            // last: '<li class="page-item"><a class="page-link" href="javascript:void(0);">末</a></li>',
                            page: '<li class="page-item"><a class="page-link" href="javascript:void(0);">{{page}}</a></li>',
                            onPageChange: function (page, type) {
                                if (type == "change") { //如果点击页数，type=change
                                    //alert(num);
                                    pageList(page,false);
                                }
                            }
                        });

                    }
                }
            })
        }
    </script>
</body>

</html>