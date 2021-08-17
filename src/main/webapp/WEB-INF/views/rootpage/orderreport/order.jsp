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
    <script src="bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="bootstrap_3.3.0/css/bootstrap.min.css">
    <link rel="stylesheet Icon" type=" image/x-icon" href="images/hotel.png">
    <link rel="stylesheet" href="css/CommonStyle/base.css">
    <link rel="stylesheet" href="css/CommonStyle/reset.css">
    <%--日期插件--%>
    <link href="js/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="js/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript" src="js/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
    <%--分页插件--%>
    <link rel="stylesheet" type="text/css" href="js/bs_pagination/jquery.bs_pagination.min.css">
    <script type="text/javascript" src="js/bs_pagination/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript" src="js/bs_pagination/en.js"></script>
    <title>订单报表</title>
</head>
<script>
    $(function () {
        getRoomType()

        $("#find-Btn").click(function () {
            pageList(1,10)
        })
        })
    function getRoomType(){
        $.ajax({
            url:"order/getRoomType.do",
            type:"get",
            dataType:"json",
            success:function (data) {
                var html = '<option></option>'
                $.each(data,function (i,n) {
                  html+='<option value="'+n.id+'">'+n.roomType+'</option>'
                })
                $("#roomType").html(html)
                pageList(1,10)
            }
        })
    }

    //分页查询事件
    function pageList(pageNo,pageSize) {
        $.ajax({
            url:"order/getOrderAll.do",
            type:"post",
            data:{
                "floorId":$("#roomType").val().trim(),
                "c_name":$("#c_name").val(),
                "order_id":$("#order_id").val(),
                "start_time":$("#start_time").val().trim(),
                "orderState":$("#orderState").val(),
                "pageNo":pageNo,
                "pageSize":pageSize
            },
            dataType:"json",
            success:function (data) {
                var  html=""
                $.each(data.list,function (i,n) {
                    html+='<tr class="text-nowrap">'
                    html+='<td><input type="checkbox" value="'+n.id+'" name="dx"/></td>'
                    html+='<td>'+n.roomType+'</td>'
                    html+='<td>'+n.roomId+'</td>'
                    html+='<td>'+n.c_name+'</td>'
                    html+='<td>'+n.idcard+'</td>'
                    html+='<td>'+n.order_id+'</td>'
                    html+='<td>'+n.start_time+'</td>'
                    html+='<td>'+n.totalPrice+'</td>'
                    html+='<td>'+(n.orderState==0?"订单已失效":"订单有效")+'</td>'
                    html+='</tr>'
                })
                $("#orderlist").html(html);

                //分页插件
                $("#activityPage").bs_pagination({
                    currentPage: pageNo, // 页码
                    rowsPerPage: pageSize, // 每页显示的记录条数
                    maxRowsPerPage: 20, // 每页最多显示的记录条数
                    totalPages: data.pages, // 总页数
                    totalRows: data.total, // 总记录条数
                    visiblePageLinks: 3, // 显示几个卡片
                    showGoToPage: true,
                    showRowsPerPage: true,
                    showRowsInfo: true,
                    showRowsDefaultInfo: true,

                    onChangePage : function(event, data){
                        pageList(data.currentPage , data.rowsPerPage);
                    }
                });
            }
        })
    }
</script>
<body>
<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>订单报表</h3>
        </div>
    </div>
</div>
<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

        <div class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">房间类型</div>
                        <select class="form-control" id="roomType">

                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">用户名</div>
                        <input class="form-control" type="text" id="c_name">
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">订单号</div>
                        <input class="form-control" type="text" id="order_id">
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">订单创建时间</div>
                        <input class="form-control" type="text" id="start_time">
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">订单状态</div>
                        <select class="form-control" id="orderState">
                            <option></option>
                            <option value="0">已失效</option>
                            <option value="1">有效订单</option>
                        </select>
                    </div>
                </div>
                <button type="button" class="btn btn-default" id="find-Btn">查询</button>

            </form>
        </div>
        <div class="btn-toolbar" role="toolbar"
             style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-danger"  id="deleteUserBtn">
                    <span class="glyphicon glyphicon-minus"></span> 删除订单
                </button>
            </div>

        </div>
        <div style="position: relative;top: 10px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input type="checkbox" name="qx"/></td>
                    <td>房间类型</td>
                    <td>房间号</td>
                    <td>用户名</td>
                    <td>身份证</td>
                    <td>订单号</td>
                    <td>订单创建时间</td>
                    <td>订单价格</td>
                    <td>订单状态</td>
                </tr>
                </thead>
                <tbody id="orderlist">

                </tbody>
            </table>
        </div>

        <div style="height: 50px; position: relative;top: 30px;">
            <div id="activityPage">

            </div>
        </div>

    </div>

</div>
</body>
</html>