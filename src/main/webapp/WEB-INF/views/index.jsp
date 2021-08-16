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
    <link rel="stylesheet" href="css/CommonStyle/reset.css">
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="//at.alicdn.com/t/font_2702840_fmjcjts8vzk.css">
    <link rel="stylesheet Icon" type=" image/x-icon" href="images/hotel.png">
    <script src="js/jquery-1.11.1-min.js"></script>
    <link rel="stylesheet" href="css/CommonStyle/base.css">
 
    <title>XXX酒店</title>
    <style>

    </style>
    <script>
        $(function () {

            getRoom()
            //总距离
            var totalDistance1 = 310;
            // 滑动动画标记
            var isSlide = false
            // 评论自动滑动动画
            var huaDong = setInterval(function () {

                slide(false)
            }, 4000)
            // 鼠标移入评论里滑动暂停
            $(".content-list").hover(function () {
                clearInterval(huaDong)
            }, function () {
                huaDong = setInterval(function () {
                    slide(false)
                }, 4000)
            })
            // 左边箭头切换动画函数
            $(".slide>button:first").click(function () {
                slide(true)
            })
            // 右边箭头切换动画函数
            $(".slide>button:last").click(function () {
                slide(false)
            })
            function slide(isdirection) {
                if (isSlide) {
                    return
                }
                isSlide = true
                // 1ms 移动的距离
                var toraDistance = 1;
                var zong = 0

                // 当前第div左边距离
                var distance = $(".owl-stage").position().left;
                // 获取div的个数
                var q = $(".owl-item").length
                if (q<=3){
                    return
                }
                if (isdirection) {
                    // 判断divleft是否为零，是的话换回到最右边
                    if (distance == -0) {
                        distance = -q * 310
                    }
                    //判断按钮方向
                    var actualDistance = isdirection ? toraDistance : -toraDistance;
                    var timerId = setInterval(function () {
                        zong += toraDistance
                        distance += actualDistance
                        if (zong == totalDistance1) {
                            clearInterval(timerId)
                            isSlide = false
                        }
                        $(".owl-stage").css("left", distance)
                    }, 1)
                } else {
                    // 判断div left是否为倒数第三个的left，是的话换回到最左边
                    if (distance == -(q - 3) * 310) {
                        distance = 310
                    }
                    //判断按钮方向
                    var actualDistance = isdirection ? toraDistance : -toraDistance;
                    var timerId = setInterval(function () {
                        zong += toraDistance
                        distance += actualDistance
                        if (zong == totalDistance1) {
                            clearInterval(timerId)
                            isSlide = false
                        }
                        $(".owl-stage").css("left", distance)
                    }, 1)
                }


            }
            //滚轮监听事件
            $(window).bind("scroll", function () {
                var top = $(this).scrollTop(); // 当前窗口的滚动距离
                if (top > 900) {
                    $(".middle-content").stop().slideDown(2000)
                }
                if (top == 0) {
                    // $(".header").removeClass("fixedTopMenu");
                }
            });
            // 内容鼠标移入动画
            $(".middle").mouseenter(function () {
                $(".middle-content").stop().slideDown(2000)
            })
            // 头像点击展开列表事件
            $("#iconfont").click(function () {
                $(".setUser-list").stop().slideToggle(500)
            })
            $(".top-center").click(function () {
                $(".setUser-list").stop().slideUp(500)
            })
            // 主页淡入定时器动画
            var index = 1;
            var idiv = setInterval(function () {
                var $text = $(".text" + index)
                if (index == 3) {
                    clearInterval(idiv)
                }
                jiazai($text)
                index += 1
            }, 600)
            //订购按钮事件
            $(".text3").click(function () {
                //订购房间跳转
                    location.href="frontend/toroom.do"
            })
            // 淡入动画函数
            function jiazai(next) {
                next.slideDown(1300)
            }
        })
        //获取正在空闲的房间
        function getRoom() {
            $.ajax({
                url:"frontend/getRooms.do",
                type:"get",
                dataType:"json",
                success:function (data) {
                    var html=''
                    var html2=''
                $.each(data.list,function (i,n) {
                        html+='<div class="content cleafix">'
                        html+='<a href="frontend/toroom.do"><img src="'+n.roomImgPath+'" alt=""></a>'
                        html+='<div class="text">'
                        html+='<a href="frontend/toroom.do">'
                        html+='<h3>'+n.roomType+'</h3>'
                        html+='</a>'
                        html+='<div class="rating">'
                        // html+='<i class="iconfont icon-xingxing"></i>'
                        // html+='<i class="iconfont icon-xingxing"></i>'
                        // html+='<i class="iconfont icon-xingxing"></i>'
                        // html+='<i class="iconfont icon-xingxing"></i>'
                        // html+='<i class="iconfont icon-xingxing"></i>'
                        html+='</div>'
                        html+='<ul>'
                        html+='<li>'+n.roomPrice+'</li>'
                        html+='<li> / 每晚</li>'
                        html+='</ul>'
                        html+='</div>'
                        html+='</div>'
                })
                    $.each(data.commentlist,function (i,n) {
                            html2+='<div class="owl-item cleafix">'
                            html2+='<div class="testimonials-item cleafix">'
                            html2+='<i class="iconfont icon-pinglun"></i>'
                            html2+='<p>'+n.comment+'</p>'
                            html2+='<ul>'
                            html2+='<li><img src="'+n.start_time+'" alt=""></li>'
                            html2+='<li>'
                            html2+='<h3>'+n.c_name+'</h3>'
                            html2+='</li>'
                            html2+='<li><span>'+n.id+'</span></li>'
                            html2+='</ul>'
                            html2+='</div>'
                            html2+='</div>'
                        })
                    $("#roomList").html(html);
                    $("#commentList").html(html2);
                }
            })
        }
    </script>
</head>

<body>
    <!-- 顶部 -->
    <header class="cleafix">
        <div class="top">
            <div class="logo">
                <img src="images/logo.png" alt="logo">
            </div>
            <div class="top-content">
                <ul>
                    <li><a href="index.do">酒店首页</a></li>
                    <li><a href="frontend/toroom.do">房间订购</a></li>
                    <li><a href="frontend/todeluxe_room.do">豪华套房</a></li>
                    <%--<li><a href="">合作资讯</a></li>--%>
                    <li><a href="frontend/tocontact.do">联系我们</a></li>
                </ul>
            </div>
            <div class="top-right">
                <div>
                    <a href="javascript:;" class="iconfont icon-user" id="iconfont"></a>
                    <span>${sessionScope.user.username}</span>
                    <div class="setUser-list">
                        <ul>
                            <li><a href="frontend/touserlist.do" data-transition="pop" data-inline="true">个人中心</a></li>
                            <li><a href="login.jsp">退出系统</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- 中间内容 -->
        <div class="top-center cleafix">
            <div class="text1">
                <p>为你打造舒适的生活环境</p>
            </div>
            <div class="text2">
                <p>小七酒店 舒兴生活</p>
            </div>
            <div class="text3 cleafix">
                <button id="orderBtn">订购房间</button>
            </div>
        </div>
    </header>
    <div class="middle">
        <div class="middle-center cleafix">
            <div class="middle-img cleafix">
                <div class="cleafix">
                    <img src="images/about-img.jpg" alt="">
                </div>
            </div>
            <div class="middle-text cleafix">
                <div class="middle-content cleafix">
                    <div class="middle-title cleafix">
                        <span>关于我们</span>
                        <h2>精心设计，营造一个远离喧嚣的避风港</h2>
                        <p>我们意识到社会自身是建筑意念的主要来源，通过创造与交流来认知我们所生活的世界，并依据生命的功能诠释出具有生命力的形式。我们打破传统酒店场景，用品味卓越的生活空间、精彩纷呈的艺术文化活动，连接每一位追求品质生活方式的宾客，共同探索、发现并创造美好生活的各种可能。</p>
                    </div>
                    <ul class="middle-list">
                        <li>
                            <i class="iconfont icon-home"></i>
                            <div>
                                <h3>餐厅设施</h3>
                                <span>餐饮庆典的尊荣之选，调动品位，运用感官，小七酒店，给你舒适的用餐环境</span>
                            </div>
                        </li>
                        <li>
                            <i class="iconfont icon-wifi"></i>
                            <div>
                                <h3>wifi覆盖</h3>
                                <span>我们在每个房间里面部署了wifi热点发射器，力求确保整个房间都有wifi网络信号的覆盖</span>
                            </div>
                        </li>
                    </ul>
                    <a href="frontend/toreadmore.do"><span>阅读更多</span></a>
                </div>
            </div>
        </div>
    </div>
    <!-- 服务导航栏 -->
    <div class="Content-service-bar">
        <div class="service-title">
            <span>我们的服务</span>
            <h3>我们在全球市场上为客户提供预订服务</h3>
        </div>
        <div class="service-content">
            <div>
                <div><i class="iconfont icon-jiudiancanting-1"></i></div>
                <a href="frontend/toservices.do" class="service">
                    <h3>豪华酒吧</h3>
                </a>
                <p>
                    一饰情真，为爱沉醉，七七酒吧，缔造一生的承诺，纵享恒久的情缘
                </p>
                <a href="frontend/toservices.do" >获取服务</a>
            </div>
            <div>
                <div><i class="iconfont icon-jiudiancanting-2"></i></div>
                <a href="frontend/toservices.do" class="service">
                    <h3>随时入住</h3>
                </a>
                <p>
                    行走万水千山，小七如影相伴，用今夜的好梦来充电白天的疲劳
                </p>
                <a href="frontend/toservices.do">获取服务</a>
            </div>
            <div>
                <div><i class="iconfont icon-jiudiancanting-"></i></div>
                <a href="frontend/toservices.do" class="service">
                    <h3>办公娱乐</h3>
                </a>
                <p>
                    大、中、小型会议室、现代化办公空间充分满足各类商务聚会的需要，一流的硬件配置和人性化服务为你精心准备
                </p>
                <a href="frontend/toservices.do">获取服务</a>
            </div>
        </div>
    </div>
    <!-- 简介布局 -->
    <div class="brief cleafix">
        <div class="brief-content cleafix">
            <div class="content-text cleafix">
                <a href="#">
                    <h3>拉近成功的距离，放大格调生活的细节</h3>
                </a>
                <p>光线抚摸出天鹅绒窗帘的温柔，儒雅桃木椅上的精致镂花也散发芬芳，光与影构建的繁华，梦和梦交织的地方，还有安详的灯光、绵绵的地毯……就在这样的清晨醒来，忘了身在何处</p>
                <a href="frontend/toroom.do">快速预定</a>
            </div>
            <div class="brief-img cleafix">
                <img src="images/reservation-img.jpg" alt="">
            </div>
        </div>
    </div>
    <!-- 专业 -->
    <div class="major cleafix">
        <div class="major-content cleafix">
            <div class="major-title cleafix">
                <span>专业</span>
                <h3>我们的专业领域 » 所有其他详细信息</h3>
            </div>
            <div class="major-center cleafix">
                <div class="major-img cleafix">
                    <img src="images/specialty-img1.jpg" alt="">
                </div>
                <div class="major-list cleafix">
                    <div class="cleafix">
                        <div class="cleafix"><i class="iconfont icon-jiudian1 "></i></div>
                        <h3>艺术装饰</h3>
                        <p>建筑只是凝固的艺术，小七酒店更懂得生活的艺术</p>
                    </div>
                    <div class="cleafix">
                        <div class="cleafix"><i class="iconfont icon-jiuba"></i></div>
                        <h3>豪华酒吧</h3>
                        <p>您可以以合理的价格轻松享受超级明星酒吧的免费入场。</p>
                    </div>
                    <div class="cleafix">
                        <div class="cleafix"><i class="iconfont icon-haoping"></i></div>
                        <h3>生活休闲港</h3>
                        <p>热爱生活，更加专注工作，用心工作，用心享受生活</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 房间 -->
    <div class="room-layout cleafix">
        <div class="room-content cleafix">
            <div class="room-title cleafix">
                <span>房间</span>
                <h3>房间和价格</h3>
            </div>
            <div class="room-center cleafix" id="roomList">

            </div>
        </div>
    </div>
    <!-- 评论布局 -->
    <div class="comment cleafix">
        <div class="comment-content cleafix">
            <div class="room-title cleafix">
                <span>推荐</span>
                <h3>客户对我们的最新评论</h3>
            </div>

            <div class="content-list cleafix">
                <div class="owl-stage-outer cleafix">

                    <div class="owl-stage cleafix" id="commentList">

                    </div>
                </div>
                <div class="slide cleafix">
                    <button class="iconfont icon-left button-left"></button>
                    <button class="iconfont icon-arrow-right button-right"></button>
                </div>
            </div>
        </div>
    </div>
    <!-- 底部 -->
        <div class="bottom cleafix">
            <div class="cleafix">
                <h3>本网页只供学习使用</h3>
                <span>如有侵权联系QQ1933823757</span>
            </div>
        </div>
</body>

</html>