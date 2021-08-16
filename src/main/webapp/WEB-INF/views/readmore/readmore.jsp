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
    <link rel="stylesheet Icon" type=" image/x-icon" href="images/hotel.png">
    <script src="js/textyleF.js"></script>
    <script src="css/fenye/jqPaginator.js"></script>
    <link rel="stylesheet" type="text/css" href="bootstrap_3.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="//at.alicdn.com/t/font_2702840_2rfwrqa5xsn.css">
    <link rel="stylesheet" href="css/CommonStyle/base.css">
    <link rel="stylesheet" href="css/CommonStyle/reset.css">
    <link rel="stylesheet" href="css/readmore/readmore.css">
    <title>酒店详情</title>
    <script>
        $(function () {
            // 头部标题动画
            $('.header-title>h3:first').textyleF();
            $('.header-title>.title2').textyleF({
                duration: 2000,
                delay: 200,
                easing: 'cubic-bezier(0.785, 0.135, 0.15, 0.86)',
                callback: function () {
                    $(this).css({
                        color: 'rgb(238, 120, 108)',
                        transition: '1s',
                    });
                }
            });
            // 导航栏动画
            $(document).ready(function () {
                $('#push').on('click', function () {
                    $('#push, #pushed-center, #pushed-left-1, #pushed-right-1, #pushed-right-2').toggleClass('move');
                    $('#push').toggleClass('rotate');
                });
            });
        })();
    </script>
</head>

<body>
    <!-- 顶部 -->
    <div class="top cleafix">
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

    <!-- 头部图片 -->
    <div class="heard cleafix">
        <div class="heard-img cleafix">
        </div>
        <div class="heard-title cleafix">
            <h3>酒店装修风格</h3>
            <h3>Hotel decoration style</h3>
        </div>
    </div>
    <!-- 中间 -->
    <div class="mian-content cleafix">
        <div class="main-center cleafix">
            <div class="content-title cleafix">
                <h2>现代风格</h2>
                <h3>Modern style</h3>
                <img src="images/d733302d101b0f5d5e6455486e01dcfe.jpg" alt="">
            </div>
        </div>
    </div>
    <div class="text cleafix">
        <div class="text-p cleafix">
            <div class="text-box cleafix">
                <p> 现代风格即现代主义风格，一般用在描述建筑和室内作品及设计作品，
                    是一种比较流行的风格。追求时尚与潮流，
                    非常注重居室空间的布局与使用功能的完美结合。
                    造型简洁，反对多余装饰，崇尚合理的构成工艺，
                    尊重材料的特性，讲究精品酒店装修设计材料自身的质地和色彩的配置效果，
                    强调设计与工业生产的联系。
                    打造酒店现代风格有三个需要满足的特点：
                    1.充分展示现代物质文明成果
                    2.完美舒适的生活设施与返璞归真的点缀装饰
                    3.追求造型新颖独特
                </p>
            </div>
            <div class="text-img">

            </div>
        </div>
    </div>

    <!-- 多图展示 -->
    <div class="center-box cleafix">
        <div class="center-content cleafix">
            <div class="title-3 cleafix">
                <h3>多色内饰</h3>
                <span>简单配色，带来视觉盛宴</span>
            </div>
           <ul class="img-list">
               <li><img src="images/pexels-photo-3965505.jpeg"></li>
               <li><img src="images/pexels-photo-3965511.jpeg"></li>
               <li><img src="images/pexels-photo-3965509.jpeg"></li>
           </ul>
        </div>
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
</body>

</html>