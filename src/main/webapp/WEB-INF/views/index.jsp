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
    <script src="js/jquery-1.11.1-min.js"></script>
    <link rel="stylesheet" href="css/CommonStyle/base.css">
 
    <title>XXX酒店</title>
    <style>

    </style>
    <script>
        $(function () {
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
                alert("sdf")
            })
            // 淡入动画函数
            function jiazai(next) {
                next.slideDown(1300)
            }
        })
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
                    <li><a href="#">酒店首页</a></li>
                    <li><a href="#">房间订购</a></li>
                    <li><a href="#">新闻资讯</a></li>
                    <li><a href="#">合作资讯</a></li>
                    <li><a href="#">联系我们</a></li>
                </ul>
            </div>
            <div class="top-right">
                <div>
                    <a href="javascript:;" class="iconfont icon-user" id="iconfont"></a>
                    <span>${sessionScope.user.phone}</span>
                    <div class="setUser-list">
                        <ul>
                            <li><a href="#" data-transition="pop" data-inline="true">个人中心</a></li>
                            <li><a href="register.html">注册</a></li>
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
                <p>XXX酒店 舒兴生活</p>
            </div>
            <div class="text3 cleafix">
                <button>订购房间</button>
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
                        <h2>我们有超过20%的全球经验,我们有很多理由选择我们</h2>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum tristique augue quis
                            neque ornare fermentum. In sit amet mattis diam. Sed id aliquam nulla. In porttitor et
                            turpis non pretium.</p>
                    </div>
                    <ul class="middle-list">
                        <li>
                            <i class="iconfont icon-home"></i>
                            <div>
                                <h3>餐厅设施</h3>
                                <span>我们是全球市场上最好的公司之一，我们为所有导游和所有客人提供餐厅设施。</span>
                            </div>
                        </li>
                        <li>
                            <i class="iconfont icon-wifi"></i>
                            <div>
                                <h3>免费无线设施</h3>
                                <span>这是一个地方，你会得到一个免费的wifi区在一个合理的价格，这将有助于你使一个丰富多彩的快乐时刻。</span>
                            </div>
                        </li>
                    </ul>
                    <a href="javascript:;"><span>阅读更多</span></a>
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
                <a href="#" class="service">
                    <h3>度假村预订进入合适的地方</h3>
                </a>
                <p>
                    您可以根据需要在合适的地方轻松预订度假客房。这样就能产生好的感觉了。
                </p>
                <a href="#" >获取服务</a>
            </div>
            <div>
                <div><i class="iconfont icon-jiudiancanting-2"></i></div>
                <a href="#" class="service">
                    <h3>酒店客房预订进入欲望的地方</h3>
                </a>
                <p>
                    您可以根据需要在合适的地方轻松预订酒店客房。这样就能产生好的感觉了。
                </p>
                <a href="#">获取服务</a>
            </div>
            <div>
                <div><i class="iconfont icon-jiudiancanting-"></i></div>
                <a href="#" class="service">
                    <h3>在适当的地方预订杂草大厅</h3>
                </a>
                <p>
                    杂草大厅预订是可能的，在一个合适的地方，你想。这样就能产生好的感觉了。
                </p>
                <a href="#">获取服务</a>
            </div>
        </div>
    </div>
    <!-- 简介布局 -->
    <div class="brief cleafix">
        <div class="brief-content cleafix">
            <div class="content-text cleafix">
                <a href="#">
                    <h3>你很容易保留哪些让你所有幸福快乐的东西</h3>
                </a>
                <p>这是最重要和最关键的事实之一，有助于我们轻松预订。此预订将帮助您轻松完成旅程和旅行周期。这将帮助你使旅行更容易，更容易的旅行对你更有用。那么，让我们开始吧！</p>
                <a href="#">快速预定</a>
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
                        <h3>井装饰</h3>
                        <p>我们非常小心我们的房间和所有的度假村装饰。所以，试试我们。</p>
                    </div>
                    <div class="cleafix">
                        <div class="cleafix"><i class="iconfont icon-jiuba"></i></div>
                        <h3>豪华酒吧</h3>
                        <p>您可以以合理的价格轻松享受超级明星酒吧的免费入场。</p>
                    </div>
                    <div class="cleafix">
                        <div class="cleafix"><i class="iconfont icon-haoping"></i></div>
                        <h3>5 星雷廷斯</h3>
                        <p>阿托利是一个众所周知的机构，该机构是最好的五星级审查之一。</p>
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
            <div class="room-center cleafix">
                <div class="content cleafix">
                    <a href="#"><img src="images/room-img1.jpg" alt=""></a>
                    <div class="text">
                        <a href="#">
                            <h3>单人房</h3>
                        </a>
                        <div class="rating">
                            <i class="iconfont icon-xingxing"></i>
                            <i class="iconfont icon-xingxing"></i>
                            <i class="iconfont icon-xingxing"></i>
                            <i class="iconfont icon-xingxing"></i>
                            <i class="iconfont icon-xingxing"></i>
                        </div>
                        <ul>
                            <li>1111xx</li>
                            <li> / 每晚</li>
                        </ul>

                    </div>
                </div>
                <div class="content cleafix">
                    <a href="#"><img src="images/room-img2.jpg" alt=""></a>
                    <div class="text">
                        <a href="#">
                            <h3>单人房</h3>
                        </a>
                        <div class="rating">
                            <i class="iconfont icon-xingxing"></i>
                            <i class="iconfont icon-xingxing"></i>
                            <i class="iconfont icon-xingxing"></i>
                            <i class="iconfont icon-xingxing"></i>
                            <i class="iconfont icon-xingxing"></i>
                        </div>
                        <ul>
                            <li>xx</li>
                            <li> / 每晚</li>
                        </ul>
                    </div>
                </div>
                <div class="content cleafix">
                    <a href="#"><img src="images/room-img3.jpg" alt=""></a>
                    <div class="text">
                        <a href="#">
                            <h3>单人房</h3>
                        </a>
                        <div class="rating">
                            <i class="iconfont icon-xingxing"></i>
                            <i class="iconfont icon-xingxing"></i>
                            <i class="iconfont icon-xingxing"></i>
                            <i class="iconfont icon-xingxing"></i>
                            <i class="iconfont icon-xingxing"></i>
                        </div>
                        <ul>
                            <li>xx</li>
                            <li> / 每晚</li>
                        </ul>
                    </div>
                </div>
                <div class="content cleafix">
                    <a href="#"><img src="images/room-img4.jpg" alt=""></a>
                    <div class="text">
                        <a href="#">
                            <h3>单人房</h3>
                        </a>
                        <div class="rating">
                            <i class="iconfont icon-xingxing"></i>
                            <i class="iconfont icon-xingxing"></i>
                            <i class="iconfont icon-xingxing"></i>
                            <i class="iconfont icon-xingxing"></i>
                            <i class="iconfont icon-xingxing"></i>
                        </div>
                        <ul>
                            <li>xx</li>
                            <li> / 每晚</li>
                        </ul>
                    </div>
                </div>
                <div class="content cleafix">
                    <a href="#"><img src="images/room-img5.jpg" alt=""></a>
                    <div class="text">
                        <a href="#">
                            <h3>单人房</h3>
                        </a>
                        <div class="rating">
                            <i class="iconfont icon-xingxing"></i>
                            <i class="iconfont icon-xingxing"></i>
                            <i class="iconfont icon-xingxing"></i>
                            <i class="iconfont icon-xingxing"></i>
                            <i class="iconfont icon-xingxing"></i>
                        </div>
                        <ul>
                            <li>xx</li>
                            <li> / 每晚</li>
                        </ul>
                    </div>
                </div>
                <div class="content cleafix">
                    <a href="#"><img src="images/room-img6.jpg" alt=""></a>
                    <div class="text">
                        <a href="#">
                            <h3>单人房</h3>
                        </a>
                        <div class="rating">
                            <i class="iconfont icon-xingxing"></i>
                            <i class="iconfont icon-xingxing"></i>
                            <i class="iconfont icon-xingxing"></i>
                            <i class="iconfont icon-xingxing"></i>
                            <i class="iconfont icon-xingxing"></i>
                        </div>
                        <ul>
                            <li>xx</li>
                            <li> / 每晚</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 评论布局 -->
    <div class="comment cleafix">
        <div class="comment-content cleafix">
            <div class="room-title cleafix">
                <span>推荐</span>
                <h3>我们最新的推荐和我们的客户说什么</h3>
            </div>

            <div class="content-list cleafix">
                <div class="owl-stage-outer cleafix">

                    <div class="owl-stage cleafix">
                        <div class="owl-item cleafix">
                            <div class="testimonials-item cleafix">
                                <i class="iconfont icon-pinglun"></i>
                                <p>你可以很容易地从这个机构作出良好和容易最好的服务。这是我们最好的和关键的服务之一。</p>
                                <ul>
                                    <li><img src="images/testimonials-img1.jpg" alt=""></li>
                                    <li>
                                        <h3>111111111小杰</h3>
                                    </li>
                                    <li><span>湖南省</span></li>
                                </ul>
                            </div>
                        </div>
                        <div class="owl-item cleafix">
                            <div class="testimonials-item cleafix">
                                <i class="iconfont icon-pinglun"></i>
                                <p>你可以很容易地从这个机构作出良好和容易最好的服务。这是我们最好的和关键的服务之一。</p>
                                <ul>
                                    <li><img src="images/testimonials-img1.jpg" alt=""></li>
                                    <li>
                                        <h3>小杰</h3>
                                    </li>
                                    <li><span>湖南省</span></li>
                                </ul>
                            </div>
                        </div>
                        <div class="owl-item cleafix">
                            <div class="testimonials-item cleafix">
                                <i class="iconfont icon-pinglun"></i>
                                <p>你可以很容易地从这个机构作出良好和容易最好的服务。这是我们最好的和关键的服务之一。</p>
                                <ul>
                                    <li><img src="images/testimonials-img1.jpg" alt=""></li>
                                    <li>
                                        <h3>小杰</h3>
                                    </li>
                                    <li><span>湖南省</span></li>
                                </ul>
                            </div>
                        </div>
                        <div class="owl-item cleafix">
                            <div class="testimonials-item cleafix">
                                <i class="iconfont icon-pinglun"></i>
                                <p>你可以很容易地从这个机构作出良好和容易最好的服务。这是我们最好的和关键的服务之一。</p>
                                <ul>
                                    <li><img src="images/testimonials-img1.jpg" alt=""></li>
                                    <li>
                                        <h3>小杰</h3>
                                    </li>
                                    <li><span>湖南省</span></li>
                                </ul>
                            </div>
                        </div>

                        <div class="owl-item cleafix">
                            <div class="testimonials-item cleafix">
                                <i class="iconfont icon-pinglun"></i>
                                <p>你可以很容易地从这个机构作出良好和容易最好的服务。这是我们最好的和关键的服务之一。</p>
                                <ul>
                                    <li><img src="images/testimonials-img1.jpg" alt=""></li>
                                    <li>
                                        <h3>小杰</h3>
                                    </li>
                                    <li><span>湖南省</span></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="slide">
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