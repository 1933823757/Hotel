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
    <link rel="stylesheet Icon" type=" image/x-icon" href="images/hotel.png">
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
           border-radius: 20px;
           margin-right: 10px;
           margin-left: 35px;
           box-shadow: 5px 5px 10px rgba(10, 10, 10, 0.466);
           transition: 0.7s;
        
        }
        .content-list ul li:hover{
            box-shadow: none;
            transform: translateY(5px);
            border-radius: 10px;
            border: 1px solid rgba(161, 161, 161, 0.466);
            transition: 0.7s;
        }
        .content-list ul li h3,.content-list ul li span{
            display: block;
            font-size: 20px;
        }
        .content-list ul li span:first-child{
            margin-top: 15px;
        }
        .content-list ul li h3{
            font-family: "幼圆";
            font-size: 24px;
            margin-top: 13px;
        }
        .content-list ul li span:last-child{
              margin-top: 10px;
          }
        .checkin{
            background-color: #f9d3e3;
            color: rgb(236, 253, 255);
        }
        .fixin{
            background-color: rgb(132, 184, 236);
            color: rgb(236, 253, 255);
        }
    </style>
    <script>
        $(function () {
            $.ajax({
                url:"putup/getRoomList.do",
                type:"get",
                dataType:"json",
                success:function (data) {

                    var html='';
                    $.each(data.list,function (i,n) {
                        var roomState = ''
                        var yangshi =''
                        if (n.state == null){
                            roomState = '空闲中'
                        } else{
                            if (n.state == '1'){
                                roomState = '已预定'
                                yangshi = "fixin"
                            } else{
                                roomState = '入住中'
                                yangshi = "checkin"
                            }
                        }
                        html+='<li class="'+yangshi+'"><div><span>'+n.c_name+'</span><h3>'+n.roomType+'</h3><span>'+roomState+'</span></div></li>'
                    })
                    $("#navUl").html(html)
                }
            })
        })
    </script>
</head>
<body>
    <div class="content cleafix">
        <div class="content-list cleafix">
            <ul class="cleafix" id="navUl">
                <%--<li class="checkin"><div><h3>单人房</h3><span>空闲中</span></div></li>--%>
                <%--<li class="fixin"><div><h3>单人房</h3><span>空闲中</span></div></li>--%>
                <%--<li><div><h3>单人房</h3><span>空闲中</span></div></li>--%>
                <%--<li><div><h3>单人房</h3><span>空闲中</span></div></li>--%>

            </ul>
        </div>
        
    </div>
</body>
</html>