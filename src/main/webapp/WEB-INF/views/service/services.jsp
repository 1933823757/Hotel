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
    <script src="js/textyleF.js"></script>
    <script src="css/fenye/jqPaginator.js"></script>
    <link rel="stylesheet" type="text/css" href="bootstrap_3.3.0/css/bootstrap.min.css">
    <link rel="stylesheet Icon" type=" image/x-icon" href="images/hotel.png">
    <link rel="stylesheet" href="//at.alicdn.com/t/font_2702840_2rfwrqa5xsn.css">
    <link rel="stylesheet" href="css/CommonStyle/base.css">
    <link rel="stylesheet" href="css/CommonStyle/reset.css">
    <link rel="stylesheet" href="css/service/service.css">
    <title>服务</title>
    <style>
     
    </style>
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
    <!-- 背景图片区 -->
    <!-- 头部图片 -->
    <div class="header cleafix">
        <div class="header-content cleafix">
            <div class="header-title cleafix">
                <h3>HOTEL</h3>
                <h3 class="title2">全新概念，全新服务</h3>
            </div>
        </div>

    </div>

    <!-- 中间部分 -->
    <div class="nav-content">
        <div class="nav-center">
            <div class="center-left">
                <img src="images/houseofsilencemariamarinina03.jpg" alt="">
            </div>
            <div class="center-right">
                <h3>New concept New service</h3>
                <span>酒店致力于建立一个让您放心入住的居停环境,酒店采用了一系列卫生安全规程和预防措施.</span>
            </div>
            <div class="right-bottom">
                <ul>
                    <li><img src="images/0b9197768e07408ee6921743ae247a5f.jpg"></li>
                    <li><img src="images/0ee610f6080f69b8179888943e49b794.jpg"></li>
                    <li><img src="/images/78689472ff8c4a1eb0f9b8d0f539f1a6.jpg"></li>
                </ul>
            </div>
        </div>
    </div>


    <!-- 房间订购页 -->
    <div class="room-layout cleafix">
        <div class="room-content cleafix">
            <div class="room-title cleafix">
                <span>服务业</span>
                <h3>我们的服务</h3>
            </div>
            <div class="room-center cleafix">
                <div class="cleafix">
                    <div class="cleafix"><i class="iconfont icon-e-bike-2-fill "></i></div>
                    <h3><a href="">交通服务</a></h3>
                    <span>接机服务 租车 叫车服务 代客泊车 </span>
                    <button>获取服务</button>
                </div>
                <div>
                    <div><i class="iconfont icon-fuwuzhongjiewuye"></i></div>
                    <h3><a href="">前台服务</a></h3>
                    <span>行李寄存 24小时前台 前台贵重物品保险柜 唤醒服务 专职行李员 24小时大堂经理 快速办理入住/退房手续</span>
                    <button>获取服务</button>
                </div>
                <div>
                    <div><i class="iconfont icon-jiudiancanting-7"></i></div>
                    <h3><a href="">餐饮服务</a></h3>
                    <span>酒吧 婚宴服务 西式餐厅 餐厅 送餐服务</span>
                    <button>获取服务</button>
                </div>
                <div>
                    <div><i class="iconfont icon-jiudiancanting-8"></i></div>
                    <h3><a href="">通用设施</a></h3>
                    <span>电梯 空调 新风系统 24小时热水 吹风机</span>
                    <button>获取服务</button>
                </div>
                <div>
                    <div><i class="iconfont icon-qingjie"></i></div>
                    <h3><a href="">清洁服务</a></h3>
                    <span>打扫卫生：1天1扫
                        毛巾更换：1天1换被单更换：1天1换 洗衣服务熨衣服务外送洗衣服务 干洗 干衣机 熨斗/挂烫机 洗衣房</span>
                    <button>获取服务</button>
                </div>
                <div>
                    <div><i class="iconfont icon-shangwu"></i></div>
                    <h3><a href="">商务服务</a></h3>
                    <span>会议室 多功能厅 投影设备 商务中心 商务服务 专用展览厅 多媒体演示系统 传真/复印</span>
                    <button>获取服务</button>
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

</html>