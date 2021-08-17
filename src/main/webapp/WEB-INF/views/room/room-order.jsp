<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + 	request.getServerPort() + request.getContextPath() + "/";
   String[] imgpaths = (String[]) request.getAttribute("imgpaths");
%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="js/jquery-1.11.1-min.js"></script>
    <script src="js/textyleF.js"></script>
    <script src="bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="bootstrap_3.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/room/room-order.css">
    <link rel="stylesheet" href="//at.alicdn.com/t/font_2702840_tgb8uoz038r.css">
    <link rel="stylesheet" href="css/CommonStyle/base.css">
    <link rel="stylesheet" href="css/CommonStyle/reset.css">
    <link rel="stylesheet Icon" type=" image/x-icon" href="images/hotel.png">

    <!-- <%--日期插件--%> -->
    <link href="js/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css"
        rel="stylesheet" />
    <script type="text/javascript" src="js/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript"
        src="js/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
    <title>房间详情</title>


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
    <div class="header cleafix">
        <div class="header-content cleafix">
            <div class="header-title cleafix">
                <h3>ROOM DETAILS</h3>
                <h3 class="title2">尊贵享受，至尊服务</h3>
            </div>
        </div>

    </div>

    <!-- 中间房间订购详情 -->
    <div class="order-box cleafix">
        <div class="order-content cleafix">
            <div class="content-left cleafix">
                <div class="left-content cleafix">
                    <!-- 左边顶部 -->
                    <div class="left-content-top cleafix">
                        <h3>预定表</h3>
                        <form>
                            <input type="hidden" id="roomId" value="${requestScope.room.id}">
                            <h4>登记</h4>
                            <input type="text" class="time " id="register" autocomplete="off"/><i class="iconfont icon-rili1"></i>
                            <h4>退房</h4>
                            <input type="text" class="time" id="checkout" autocomplete="off"/><i class="iconfont icon-rili1"></i>
                            <h4>身份证</h4>
                            <input type="text" id="idcard" autocomplete="off"/><i class="iconfont icon-shenfenzheng"></i>
                            <h4>人数</h4>
                            <select class="select" id="select1">
                                <option value="1">01</option>
                                <option value="2">02</option>
                                <option value="3">03</option>
                                <option value="4">04</option>
                                <option value="5">05</option>
                            </select>
                            <button id="oderbtn">立即预定</button>
                        </form>
                    </div>
                    <!-- 左边底部 -->
                    <div class="left-content-bottom cleafix">
                        <h3>基本计划设施</h3>
                        <ul>
                            <li>早餐设施</li>
                            <li>午餐设施</li>
                            <li>户外厨房</li>
                            <li>洗发水和肥皂</li>
                            <li>晚餐设施</li>
                            <li>无线连接</li>
                            <li>双人床</li>
                            <li>5星美食</li>
                        </ul>
                        <h3>高级计划设施</h3>
                        <ul>
                            <li>洗衣设备</li>
                            <li>高清投影</li>
                            <li>迷你吧</li>
                            <li>健身房</li>
                            <li>游泳馆</li>
                            <li>空调设施</li>
                            <li>自助晚餐</li>
                            <li>私人影院</li>

                        </ul>
                    </div>
                </div>
            </div>
            <!-- 轮播图 -->
            <div class="content-right cleafix">
                <div class="right-imglsit">
                    <div id="carousel-example-generic" style="border-radius: 20px;" class="carousel slide"
                        data-ride="carousel">
                        <!-- 小圆点 -->
                        <ol class="carousel-indicators">
                            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                            <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                        </ol>

                        <!-- 图片区-->
                        <div class="carousel-inner"  role="listbox">
                            <div class="item active">
                                <img src="<%=imgpaths[0]%>" style="width: 700px; height: 500px;" alt="...">
                            </div>
                            <div class="item">
                                <img src="<%=imgpaths[1]%>" style="width: 700px; height: 500px; " alt="...">
                            </div>
                            <div class="item">
                                <img src="<%=imgpaths[2]%>" style="width: 700px; height: 500px;" alt="...">
                            </div>
                        </div>

                        <!-- 左右两边的坐标 -->
                        <a class="jiantou left " href="#carousel-example-generic" role="button" data-slide="prev">
                            <span class="glyphicon iconfont icon-left" aria-hidden="true"></span>
                            <!-- <span class="sr-only">Previous</span> -->
                        </a>
                        <a class="jiantou2 right " href="#carousel-example-generic" role="button" data-slide="next">
                            <span class="glyphicon iconfont icon-arrow-right" aria-hidden="true"></span>
                            <!-- <span class="sr-only">Next</span> -->
                        </a>
                    </div>
                </div>
                <!-- 正文标题 -->
                <div class="right-title">
                    <h3>${requestScope.room.roomType}</h3>
                    <!-- 总价格 -->
                    <input id="zongMoney" type="hidden" />
                    <h4>￥<span id="money">${requestScope.room.roomPrice}</span>/晚</h4>
                    <hr />
                </div>
                <!-- 正文内容 -->
                <div class="right-content">
                    <p>${requestScope.room.roomSuggest}</p>
                    <p></p>
                    <hr />
                </div>
                <!-- 评论 -->
                <div class="room-review">
                    <h3>客户评价</h3>
                    <!-- 星星评价等级存放输入框 -->
                    <input type="hidden" id="grade" />
                    <div class="rating-stars-container">
                        <span>你的审查:</span>
                        <div class="rating-star">
                            <i class="iconfont icon-xingxing"></i>
                        </div>
                        <div class="rating-star">
                            <i class="iconfont icon-xingxing"></i>
                        </div>
                        <div class="rating-star">
                            <i class="iconfont icon-xingxing"></i>
                        </div>
                        <div class="rating-star">
                            <i class="iconfont icon-xingxing"></i>
                        </div>
                        <div class="rating-star">
                            <i class="iconfont icon-xingxing"></i>
                        </div>
                    </div>
                    <div class="rows">
                        <div class="rows-content">
                            <textarea class="textcontent" name="message" id="comment" cols="30" rows="10"
                                placeholder="您的评论"></textarea>
                        </div>
                        <button class="rows-button" id="commentBtn">提交审核</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
      <!-- 评论布局 -->
      <div class="comment cleafix">
        <div class="comment-content cleafix">
            <div class="room-title cleafix">
                <h3>最新的评论</h3>
            </div>

            <div class="content-list cleafix">
                <div class="owl-stage-outer cleafix">

                    <div class="owl-stage cleafix" id="commentList">

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
            <span>如有侵权联系&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
                    href="https://qm.qq.com/cgi-bin/qm/qr?k=OD1io72em7cmwBZtSk12nwGGFnzomMNN&noverify=0"
                    target="blank">QQ1933823757</a></span>
        </div>
    </div>
</body>
<script>

    $(function () {
        getComment()

        //提交审核按钮事件
        $("#commentBtn").click(function () {
            var comment = $("#comment").val()
            if (comment == ''){
                alert("请输入你的评价")
            } else{
                $.ajax({
                    url:"frontend/addComment.do",
                    type:"get",
                    data:{
                    "c_name":"${sessionScope.user.username}",
                    "c_phone":"${sessionScope.user.phone}",
                    "comment":comment,
                    "userId":"${sessionScope.user.id}",
                    "roomId":$("#roomId").val()
                    },
                    dataType:"json",
                    success:function (data) {
                        if (data.success){
                            getComment()
                            $("#comment").val('')
                            alert("添加成功")

                        }else{
                            alert("添加失败")
                        }
                    }
                })
            }

        })




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

        $(".left-content-top input").on("focus", function () {
            $(this).removeAttr("style")
        })
        // 立即预定按钮提交函数
        $("#oderbtn").click(function () {
            var $register = $("#register")
            var $checkout = $("#checkout")
            var $idcard = $("#idcard")
            if ($register.val() != '' && $checkout.val() != '' && $idcard.val() != '') {
                var nowTime = show().replace(/\-/g, "")
                var register = $register.val().replace(/\-/g, "")
                var checkout = $checkout.val().replace(/\-/g, "")



                if (register >= nowTime){
                    if (checkout >register) {
                        if($("#idcard").val().length <=18){
                        $.ajax({
                            url:"frontend/addEngage.do",
                            type:"post",
                            data:{
                                "start_time":$("#register").val(),
                                "close_time":$("#checkout").val(),
                                "c_name":"${sessionScope.user.username}",
                                "c_tel":"${sessionScope.user.phone}",
                                "roomId":$("#roomId").val(),
                                "managerName":"${sessionScope.user.username}",
                                "idCard":$("#idcard").val(),
                            },
                            dataType:"json",
                            success:function (data) {
                                if (data.success){
                                    $("#register").val('')
                                    $("#checkout").val('')
                                    $("#idcard").val('')
                                    alert(data.title)
                                } else{
                                    alert(data.title)
                                }
                            }
                        })
                        return false
                        }else{
                            alert("身份证长度超过18位数")
                            return false
                        }
                } else{
                        $register.attr("style", "  border: 2px solid red;")
                        return false
                    }
                } else {
                  alert("预定开始时间不能小于现在时间")
                    return false
                }
            } else if ($register.val() == '') {
                $register.attr("style", "  border: 2px solid red;")
                return false
            } else if ($checkout.val() == '') {
                $checkout.attr("style", "  border: 2px solid red;")
                return false
            } else if ($idcard.val() == '') {
                $idcard.attr("style", "  border: 2px solid red;")
                return false
            }
        })

        // 星星评分函数
        var XxValue;
        $(".rating-star").mouseenter(function () {
            //获得当前鼠标停留的下标
            let index = $(this).index()
            //循环遍历所有星星
            $(".rating-star").each(function (i) {
                //判断星星是否小于当前小标，小于则为实星星
                if (i < index) {
                    $(this).addClass("xingxingcolor")
                } else {
                    //否则为黑色星星
                    $(this).removeClass("xingxingcolor")
                }
            })
        })
        $(".rating-star").mouseleave(function () {
            //遍历所有星星
            $(".rating-star").each(function (i) {
                //获取当前星星的class样式
                var str = $(this).attr("class")
                //判断样式里没有黄色样式
                if (str.indexOf("xingxingcolor") == -1) {
                    //没有黄色样式说明当前下标为分界点，则赋值给隐藏输入框
                    XxValue = $(this).index() - 1
                    return false;
                }
                XxValue = 5;
            })
            $("#grade").val(XxValue)
        })

        //  轮播图
        $('#carousel-example-generic').carousel({
            interval: 2000
        })
        //时间插件
        $(".time").datetimepicker({
            minView: "month",
            language: 'zh-CN',
            format: 'yyyy-mm-dd',
            autoclose: true,
            todayBtn: true,
            pickerPosition: "bottom-left"
        });

        // 头部标题动画
        $('.header-title>h3:first').textyleF();
        $('.header-title>.title2').textyleF({
            duration: 2000,
            delay: 200,
            easing: 'cubic-bezier(0.785, 0.135, 0.15, 0.86)',
            callback: function () {
                $(this).css({
                    color: '#f9c03d',
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
    })
    function getComment() {
        $.ajax({
            url:"frontend/getCommentById.do",
            type:"get",
            data:{
                "roomId":$("#roomId").val()
            },
            dataType:"json",
            success:function (data) {
                var html2=''
                if (data.list == ''){
                    html2+='<h2 style="font-size: 20px; text-align: center;color: red; margin-top: 30px">还没有人发表评论哦~</h2>'
                }else{
                    $.each(data.commentlist,function (i,n) {
                        html2+='<div class="owl-item cleafix">'
                        html2+='<div class="testimonials-item cleafix">'
                        html2+='<i class="iconfont icon-pinglun"></i>'
                        html2+='<p>'+n.comment+'</p>'
                        html2+='<ul>'
                        html2+='<li><img src="'+n.userId+'" alt=""></li>'
                        html2+='<li>'
                        html2+='<h3>'+n.c_name+'</h3>'
                        html2+='</li>'
                        html2+='<li><span>'+n.start_time+'</span></li>'
                        html2+='</ul>'
                        html2+='</div>'
                        html2+='</div>'
                    })
                }


                $("#commentList").html(html2)

            }
        })
    }
    //获取时间js函数
    function show(){
        var mydate = new Date();
        var str = "" + mydate.getFullYear() + "-";
        str += (mydate.getMonth()+1)<10?"0"+(mydate.getMonth()+1):(mydate.getMonth()+1) + "-";
        str += mydate.getDate() + "-";
        return str;
    }
</script>

</html>