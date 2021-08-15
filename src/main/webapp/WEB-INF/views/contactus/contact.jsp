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
    <link rel="stylesheet" href="//at.alicdn.com/t/font_2702840_dk6znqsmu64.css">
    <link rel="stylesheet" type="text/css" href="bootstrap_3.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/CommonStyle/base.css">
    <link rel="stylesheet" href="css/CommonStyle/reset.css">
    <link rel="stylesheet" href="css/room/room.css">
    <link rel="stylesheet" href="css/contactus/contact.css">
    <title>联系我们</title>
    <style>
     
    </style>
    <script>
        $(function () {

            // 导航栏动画
            $(document).ready(function () {
                $('#push').on('click', function () {
                    $('#push, #pushed-center, #pushed-left-1, #pushed-right-1, #pushed-right-2').toggleClass('move');
                    $('#push').toggleClass('rotate');
                });
            });
       

            // 提交按钮
            $("#btn").click(function () {
                console.log( $("#name").val())
               if( $("#name").val().trim().replace(/\s/g,"") ==''){
                     $("#name").attr("style"," border: 1px solid red;")
                     return false
               }else if( $("#email").val().trim().replace(/\s/g,"") ==''){
                     $("#email").attr("style"," border: 1px solid red;")
                     return false
               }
               else if( $("#phone").val().trim().replace(/\s/g,"") ==''){
                     $("#phone").attr("style"," border: 1px solid red;")
                     return false
               }else if( $("#type").val().trim().replace(/\s/g,"") ==''){
                     $("#type").attr("style"," border: 1px solid red;")
                     return false
               }
              //提交函数写这 
                $.ajax({
                    url:"frontend/toemail.do",
                    type:"post",
                    data:{
                        "name":$("#name").val(),
                        "email":$("#email").val(),
                        "phone":$("#phone").val(),
                        "type":$("#type").val(),
                        "textarea":$("#textarea").val()
                    },
                    dataType:"json",
                    success:function (data) {
                        if (data.success){
                            alert("发送成功")
                        } else{
                            alert("发送失败")
                        }
                    }
                })

              })
            $("li>input").click(function () {
                $(this).removeAttr("style")
                $(this).val('')
              })
        })
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

    <!-- 头部 -->
    <div class="heard cleafix">
        <div class="heard-img cleafix">
            <div class="heard-title cleafix">
                <h2>联系我们</h2>
                <h3>CONTACT ME...</h3>
            </div>
        </div>
    </div>

    <!-- 中间部分 -->
    <div class="center cleafix">
        <div class="center-content cleafix">
            <div class="content-left cleafix">
                <h3>给我们留言</h3>
                <img src="images/contact-img1.jpg" alt="">
            </div>
            <div class="content-right cleafix">
                <ul>
                    <li><input type="text" placeholder="名字" id="name"/></li>
                    <li><input type="text" placeholder="电子邮件" id="email" /></li>
                    <li><input type="text" placeholder="电话" id="phone" /></li>
                    <li><input type="text" placeholder="主题" id="type" /></li>
                    <li><textarea name="" id="textarea" cols="30" rows="10" placeholder="输入消息"></textarea></li>
                    <li><button id="btn">发送消息</button></li>
                </ul>
            </div>
        </div>
        
    </div>
</body>

</html>