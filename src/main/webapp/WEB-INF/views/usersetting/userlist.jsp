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
    <link rel="stylesheet" href="usercss/style.min.css">
    <link rel="stylesheet" href="css/CommonStyle/base.css">
    <script src="js/jquery-1.11.1-min.js"></script>
    <link rel="stylesheet" href="bootstrap_3.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/CommonStyle/reset.css">
    <script src="usercss/materialMenu.min.js"></script>
    <title>个人中心</title>
    <style>
        body {
            background-color: rgb(221, 219, 217);
        }

        .wrapper{
            width: 100%;
            height: 1000px; 
        }
        .mm-menu__header{
            background-color: rgb(94, 93, 93);
        }
    </style>

</head>

<body>

    <div id="wrapper" class="wrapper cleafix">
        <iframe name="workareaFrame" style="border-width: 0px;  width: 100%; height: 100%;"></iframe>
        </iframe>
        
    </div>

    <button id="mm-menu-toggle" class="mm-menu-toggle">菜单按钮</button>
    <nav id="mm-menu" class="mm-menu">
        <div class="mm-menu__header">
            <h2 class="mm-menu__title">更多信息</h2>
        </div>
        <ul class="mm-menu__items ">
            <li class="mm-menu__item ">
                <a class="mm-menu__link " href="frontend/touser.do" target="workareaFrame">
                    <span class="mm-menu__link-text"><i class="md md-inbox"></i> 个人主页</span>
                </a>
            </li>
            <li class="mm-menu__item">
                <a class="mm-menu__link" href="frontend/touserorder.do" target="workareaFrame">
                    <span class="mm-menu__link-text"><i class="md md-person"></i> 个人订单</span>
                </a>
            </li>
           
            <li class="mm-menu__item">
                <a class="mm-menu__link" href="index.do" >
                    <span class="mm-menu__link-text"><i class="md md-home"></i> 主页</span>
                </a>
            </li>
        </ul>
    </nav>

   
    <script>
      
        $(function () {
            $(".mm-menu__link-text:first").trigger("click");
            var menu = new Menu;
            $(".mm-menu__item:first").addClass("active");
            $(".mm-menu__item").click(function(){
			//移除所有菜单项的激活状态
			$(".mm-menu__item").removeClass("active");
			//当前项目被选中
			$(this).addClass("active");

			//拿订单信息

		});
		
        })
    </script>
</body>

</html>