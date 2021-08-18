<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
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
    <link rel="stylesheet Icon" type=" image/x-icon" href="images/hotel.png">
    <script src="bootstrap-fileinput/fileinput.min.js"></script>
    <script src="bootstrap-fileinput/zh.js"></script>
    <link rel="stylesheet" href="bootstrap-fileinput/fileinput.min.css">
    <%--日期插件--%>
    <link href="js/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css"
          rel="stylesheet"/>
    <script type="text/javascript" src="js/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript"
            src="js/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
    <%--分页插件--%>
    <link rel="stylesheet" type="text/css" href="js/bs_pagination/jquery.bs_pagination.min.css">
    <script type="text/javascript" src="js/bs_pagination/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript" src="js/bs_pagination/en.js"></script>
    <title>用户列表</title>
</head>
<script>
    $(function () {
        pageList(1, 10)
        //单选框事件
        $("input[name=qx]").click(function () {
            $("input[name=dx]").prop("checked", this.checked)
        })
        $("#userlist").on("click", $("input[name=dx]"), function () {
            $("input[name=qx]").prop("checked", $("input[name=dx]").length == $("input[name=dx]:checked").length)
        })

        $("#find-Btn").click(function () {
            pageList(1,10)
        })
        //删除按钮事件
        $("#deleteUserBtn").click(function () {
            if($("input[name=dx]:checked").length>0){
                var $input =$("input[name=dx]:checked");
                var param=''
                for (var i=0;i<$input.length;i++){
                    param+="id="+$input[i].value
                    if (i<$input.length-1){
                        param+="&"
                    }
                }

                if (confirm("确定要删除吗？")) {
                    $.ajax({
                        url:"customer/deleteCustomer.do",
                        type:"post",
                        data: param,
                        dataType:"json",
                        success:function (data) {
                            if (data.success){
                                alert(data.title)
                                $("input[name=dx]").prop("checked",false);
                                pageList(1,10)
                            } else {
                                alert(data.title)
                                $("input[name=dx]").prop("checked",false);
                            }

                        }
                    })
                }
            }else{
                alert("请选择你需要删除的记录")
            }
        })
    })

    //分页
    function pageList(pageNo,pageSize) {
        $.ajax({
            url: "customer/getCustomerList.do",
            type: "post",
            data: {
                "c_name": $("#c_name").val(),
                "c_tel": $("#c_tel").val(),
                "idCard":$("#idCard").val(),
                "pageNo": pageNo,
                "pageSize": pageSize
            },
            dataType: "json",
            success: function (data) {
                var html = ""
                $.each(data.list, function (i, n) {
                    var t='';
                    if (n.state>0){
                        if (n.state == 1){
                            t="已预定"
                        } else{
                            t="入住中"
                        }
                    } else {
                        t="已退房"
                    }
                    html += '<tr >'
                    html += '<td><input type="checkbox" name="dx" value="' + n.id + '"/></td>'
                    html += '<td>' + n.c_name + '</td>'
                    html += '<td>' + n.c_tel + '</td>'
                    html += '<td>' + n.c_start_time + '</td>'
                    html += '<td>' + n.idCard+ '</td>'
                    html += '<td>' + n.roomId + '</td>'
                    html += '<td>' + n.order_id + '</td>'
                    html += '<td>' + t+ '</td>'
                    html += '</tr>'
                })
                $("#userlist").html(html);
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

                    onChangePage: function (event, data) {
                        pageList(data.currentPage, data.rowsPerPage);
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
            <h3>客户管理</h3>
        </div>
    </div>
</div>
<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

        <div class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">客户名称</div>
                        <input class="form-control" type="text" id="c_name">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">手机号</div>
                        <input class="form-control" type="text" id="c_tel">
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">身份证</div>
                        <input class="form-control" type="text" id="idCard">
                    </div>
                </div>
                <button type="button" class="btn btn-default" id="find-Btn">查询</button>

            </form>
        </div>
        <div class="btn-toolbar" role="toolbar"
             style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-danger"  id="deleteUserBtn">
                    <span class="glyphicon glyphicon-minus"></span> 删除客户
                </button>
            </div>

        </div>
        <div style="position: relative;top: 10px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input type="checkbox" name="qx"/></td>
                    <td>客户名称</td>
                    <td>手机号</td>
                    <td>创建时间</td>
                    <td>身份证</td>
                    <td>房间号</td>
                    <td>订单编号</td>
                    <td>状态</td>
                </tr>
                </thead>
                <tbody id="userlist">

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