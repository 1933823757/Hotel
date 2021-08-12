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
    <link rel="stylesheet" href="bootstrap_3.3.0/css/bootstrap.min.css">
    <script src="js/jquery-1.11.1-min.js"></script>
    <script src="bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/CommonStyle/base.css">
    <link rel="stylesheet" href="css/CommonStyle/reset.css">
    <title>主页</title>
    <style>
        .content{
            width: 100%;
        }
        .content-list{
            width: 90%;
            margin: 0px auto;
            /*margin-top: 20px;*/
        }
        .content-list ul{
            display: flex;
            flex-wrap: wrap;
        }
        .content-list ul li{
            width: 12%;
            height: 120px;
            text-align: center;
            margin-top: 30px;
           border-radius: 40px;
           margin-right: 10px;
           margin-left: 35px;
           box-shadow: 5px 5px 10px rgba(10, 10, 10, 0.466);
           transition: 0.7s;
        
        }
        .content-list ul li:hover{
            box-shadow: none;
            transform: translateY(5px);
            border-radius: 30px;
            border: 1px solid rgba(161, 161, 161, 0.466);
            transition: 0.7s;
        }
        .content-list ul li h3,.content-list ul li span{
            display: block;
            margin-top: 20%;
            font-size: 20px;
        }
        .content-list ul li h3{
            font-size: 27px;
        }
        .checkin{
            background-color: rgb(236, 145, 163);
            color: rgb(235, 5, 51);
        }
        .fixin{
            background-color: rgb(132, 184, 236);
            color: rgb(236, 253, 255);
        }
    </style>
    <script>
        $(function () {

        })
    </script>
</head>
<body>
    <div class="content cleafix">
        <div class="content-list cleafix">
            <ul class="cleafix">
                <li class="checkin"><div><h3>单人房</h3><span>空闲中</span></div></li>
                <li class="fixin"><div><h3>单人房</h3><span>空闲中</span></div></li>
                <li><div><h3>单人房</h3><span>空闲中</span></div></li>
                <li><div><h3>单人房</h3><span>空闲中</span></div></li>
                <li><div><h3>单人房</h3><span>空闲中</span></div></li>
                <li><div><h3>单人房</h3><span>空闲中</span></div></li>
                <li><div><h3>单人房</h3><span>空闲中</span></div></li>
                <li><div><h3>单人房</h3><span>空闲中</span></div></li>
                <li><div><h3>单人房</h3><span>空闲中</span></div></li>
                <li><div><h3>单人房</h3><span>空闲中</span></div></li>
                <li><div><h3>单人房</h3><span>空闲中</span></div></li>
                <li><div><h3>单人房</h3><span>空闲中</span></div></li>
                <li><div><h3>单人房</h3><span>空闲中</span></div></li>
                <li><div><h3>单人房</h3><span>空闲中</span></div></li>
                <li><div><h3>单人房</h3><span>空闲中</span></div></li>
                <li><div><h3>单人房</h3><span>空闲中</span></div></li>
            </ul>
        </div>
        
    </div>
</body>
</html>