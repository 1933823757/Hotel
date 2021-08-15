<%@ page import="com.xiaojie.hotel.domian.User" %>
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
    <link rel="stylesheet" href="css/CommonStyle/base.css">
    <script src="js/jquery-1.11.1-min.js"></script>
    <link rel="stylesheet" href="bootstrap_3.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/CommonStyle/reset.css">
    <link rel="stylesheet" href="css/usersetting/user.css">
    <title>用户信息</title>
    <style>
     
    </style>
</head>
<body>
    <div class="content cleafix">
        <iframe  name="stop" style="display:none;"></iframe>
        <form action="frontend/updateUser.do" method="post" enctype="multipart/form-data" id="userForm" >
            <input type="hidden" name="id" value="${sessionScope.user.id}">
        <div class="content-touxiang cleafix">
            <span><img src="${sessionScope.user.imgpath}" alt=""></span>
            <a href="javascript:;" class="a-upload">
                <input type="file" name="file" >更换头像
            </a>
        </div>
        <div class="user-text cleafix">
            <ul class="cleafix">
                <li><span>昵称:</span><input type="text" readonly="true" name="name" value="${sessionScope.user.name}" id="username" ></li>
                <li><span>手机号:</span><input type="text" readonly="true" name="phone" value="${sessionScope.user.phone}" id="phone"></li>
                <li>
                    <span>性别:</span>
                    <input type="radio" name="sex" value="0"  >男
                    <input type="radio" name="sex" value="1"  >女
                </li>
                <li><span>身份证:</span><input type="text" name="idcard" value="${sessionScope.user.idcard}" readonly="true" id="idcard"></li>
            </ul>
            <div class="user-btn cleafix">
                <button id="setUserbtn">更改信息</button>
                <button id="addUserbtn">保存</button>
            </div>
        </div>
        </form>
    </div>
    <script>
        $(function () {
            if ("${sessionScope.user.sex}" == 1){
                $("input[name=sex]:last-child").prop("checked",true)
            }else{
                $("input[name=sex]:first").prop("checked",true)
            }

            var flag =false;
            // 更该按钮事件
            $("#setUserbtn").click(function () {
               $("input[name=sex]").removeAttr("readonly")
                $(".user-text input").removeAttr("readonly")
                $(".user-text input[type=text]").attr("style","border-bottom: 1px solid rgba(10, 10, 10, 0.699);")
                flag=true;
                return false
            })

            // 保存按钮事件
            $("#addUserbtn").click(function () {
                if (flag){
                    $("#userForm").submit()
                    $(".user-text input[type=text]").attr("style","")
                    $("input[name=sex]").attr("readonly","true")
                    $(".user-text input").attr("readonly","true")
                    flag=false
                    alert("修改成功")
                    location.reload(true);
                } else{
                    alert('请先修改信息再点保存')
                    return false
                }
              })

        })

    </script>
</body>
</html>