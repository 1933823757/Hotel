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
    <title>订单</title>
    <style>
        html { overflow: hidden; }
        body{
            background-color: rgb(211, 211, 211);
        }
        .heard-box {
            width: 100%;
            height: 300px;
            background-color: rosybrown;
        }

        .heard-img {
            width: 100%;
            height: 100%;
            background-image: url(images/pexelsphoto262367.jpeg);
            background-position: 50% 50%;
            background-size: cover;
        }
        .content{
            width: 100%;
            height: 700px;
        }
        .content-center{
            width: 70%;
            margin: 50px auto;
        }
        table{
            border: 1px solid rgb(243, 243, 243);
            box-shadow: 3px 3px 10px rgba(88, 88, 88, 0.692);
        }
        .table thead{
            color: snow;
            text-align: center;
            font-size: 30px;
            font-family: 'Courier New', Courier, monospace;
            background-color: rgb(94, 93, 93);
        }
        .table tbody{
            font-size: 20px;
            font-family: 'Courier New', Courier, monospace;
            text-align: center;
            color: rgb(0, 0, 0);
        }
    </style>
</head>
<script>
    $(function () {
        getOrder()
    })
    //删除订单的函数
    function removeClueRemark(id) {
        if (confirm("确定要删除吗?")){
            $.ajax({
                url:"frontend/deleteOrder.do",
                type:"post",
                data:{
                    "id":id
                },
                dataType:"json",
                success:function (data) {
                    if (data.success){
                        alert("删除成功")
                        getOrder()
                    } else {
                        alert("删除失败")
                    }
                }
            })
        }

    }
    function getOrder() {
        $.ajax({
            url:"frontend/getOrderUser.do",
            type:"post",
            data:{
                "id":"${sessionScope.user.id}"
            },
            dataType:"json",
            success:function (data) {
                var html=''
                $.each(data,function (i,n) {
                    html+='<input type="hidden" value="'+n.id+'" />'
                    html+='<tr>'
                    html+='<td>'+n.c_name+'</td>'
                    html+='<td>'+n.userId+'</td>'
                    html+='<td>'+n.roomId+'</td>'
                    html+='<td>'+n.totalPrice+'</td>'
                    html+='<td>'+n.start_time+'</td>'
                    html+='<td>'+n.order_id+'</td>'
                    html+='<td><button class="btn btn-danger" onclick="removeClueRemark(\''+n.id+'\')"></span>删除订单</button></td>'
                    html+='</tr>'
                })
                $("#orderList").html(html);
            }
        })
    }
</script>
<body>
    <div class="heard-box">
        <div class="heard-img">

        </div>
    </div>
    <div class="content">
        <div class="content-center">
            <div>
                <table class="table table-hover">
                    <thead >
                        <tr >
                           
                            <td>账号</td>
                            <td>手机号</td>
                            <td>客房类型</td>
                            <td>交易金额</td>
                            <td>下单时间</td>
                            <td>订单单号</td>
                            <td>编辑</td>
                        </tr>
                    </thead>
                    <tbody id="orderList">

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>

</html>