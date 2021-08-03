<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="js/jquery-1.11.1-min.js"></script>
    <link rel="stylesheet" href="//at.alicdn.com/t/font_2702840_12op6n1gh1yr.css">
    <link rel="stylesheet" href="css/login/register.css">
    <title>用户注册</title>
    <script type="text/javascript">
        $(function () {
            $("#register").click(function () {
                // 账号输入不能为空
                if ($("#phone").val().trim().length == 0 || $("#phone").val() == "") {
                    $(".prompt").removeClass("xianshi")
                    $(".prompt>span").html("手机号不能为空")
                    return false
                } else if ($("#username").val().trim().length == 0 || $("#username").val() == "") {
                    $(".prompt").removeClass("xianshi")
                    $(".prompt>span").html("账号不能为空")
                    return false
                } else if ($("#password").val().trim().length == 0 || $("#password").val() == "") {
                    $(".prompt").removeClass("xianshi")
                    $(".prompt>span").html("密码不能为空")
                    return false
                } else if ($("#ispassword").val().trim().length == 0 || $("#ispassword").val() == "") {
                    $(".prompt").removeClass("xianshi")
                    $(".prompt>span").html("确认密码不能为空")
                    return false
                } else if ($("#password").val().trim() != $("#ispassword").val().trim()) {
                    $(".prompt").removeClass("xianshi")
                    $(".prompt>span").html("密码不一样")
                    return false
                }
                // 提交函数写这
                alert("asfdaf")
                $.ajax({
                    url: "register.do",
                    type: "post",
                    data: {
                        "username": $("#username").val().trim(),
                        "password": $("#password").val().trim(),
                        "phone": $("#phone").val().trim()
                    },
                    dataType: "json",
                    success: function (data) {
                        //    {"title":"","success":"true/false"
                        if (data.success) {
                            alert("注册成功")
                        } else {
                            alert("注册失败")
                        }
                    }
                })
                $(".prompt>span").html("");
            })

            //账号输入框获得鼠标事件
            $("#phone").focus(function () {
                clear($("#phone"))
            })
            $("#username").focus(function () {
                clear($("#username"))
            })
            $("#password").focus(function () {
                clear($("#password"))
            })
            $("#ispassword").focus(function () {
                clear($("#ispassword"))
            })
            $("#captcha").focus(function () {
                clear($("#captcha"))
            })

            function clear(e) {
                if ($(".prompt>span").html() != "") {
                    // 需要清空
                    e.val("")
                    $(".prompt>span").html("")
                    $(".prompt").addClass("xianshi")
                }
                e.val().trim()
            }
        })
    </script>
</head>

<body>
<div class="loginBox">
    <h2>注册</h2>
    <div class="item">
        <input type="text" id="phone" name="phone">
        <label for="">手机号</label>
    </div>
    <div class="item">
        <input type="text" id="username" name="username">
        <label for="">账号</label>
    </div>
    <div class="item">
        <input type="password" id="password" name="password">
        <label for="">密码</label>
    </div>
    <div class="item">
        <input type="password" id="ispassword" name="ispassword">
        <label for="">确认密码</label>
    </div>
    <div class="prompt xianshi">
        <i class="iconfont icon-jinggaozhuyi" style="color: red;"></i>
        <span style="color: red;"></span>
    </div>
    <button class="btn" id="register">注册
        <span></span>
        <span></span>
        <span></span>
        <span></span>
    </button>
    <div class="msg">
        已有账号？
        <a id="login" href="login.jsp">点击登录</a>
    </div>
</div>
</body>

</html>
