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
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <link rel="stylesheet" href="bootstrap_3.3.0/css/bootstrap.min.css">
    <script src="js/jquery-1.11.1-min.js"></script>
    <script src="bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/CommonStyle/base.css">
    <link rel="stylesheet" href="css/CommonStyle/reset.css">

    <%--分页插件--%>
    <link rel="stylesheet" type="text/css" href="js/bs_pagination/jquery.bs_pagination.min.css">
    <script type="text/javascript" src="js/bs_pagination/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript" src="js/bs_pagination/en.js"></script>
    <title>评论管理</title>
    <style>
        table {
            margin-left: 20px;
            margin-top: 30px;
            width: 95%;
        }
        thead {
            height: 50px;
            border-bottom: 1px solid rgb(172, 170, 170);
            font-size: 20px;
        }

        .tbody-list tr {

            width: 20%;
            height: 100px;
            border-bottom: 1px solid rgb(172, 170, 170);
        }

        .tbody-list tr td:first-child {
            width: 5%;
            vertical-align: middle;
        }

        .tbody-list tr td {
            width: 10%;
            vertical-align: middle;
        }

        .tbody-list tr td:nth-child(5) {
            width: 55%;
            line-height: 30px;
            padding-right: 20px;
        }

        .tbody-list tr td:nth-child(5) span {
            white-space: pre-wrap;
            width: 800px;
            height: 100px;
            font-size: 14px;
            font-family: '黑体';
            text-align: left;
            vertical-align: middle;
        }
    </style>
</head>
    <script>
        $(function () {
            pageList(1, 10)
            //查询按钮事件
            $("#find-Btn").click(function () {
                pageList(1,10)
            })

            //单选框事件
            $("input[name=qx]").click(function () {
                $("input[name=dx]").prop("checked", this.checked)
            })
            $("#commentlist").on("click", $("input[name=dx]"), function () {
                $("input[name=qx]").prop("checked", $("input[name=dx]").length == $("input[name=dx]:checked").length)
            })
            //修改按钮
            $("#editUserBtn").click(function () {
                if ($("input[name=dx]:checked").length > 0) {
                    if ($("input[name=dx]:checked").length > 1) {
                        alert("请选择一条记录")
                    } else {
                        $.ajax({
                            url: "userlist/getCommentById.do",
                            type: "get",
                            data: {
                                "id": $("input[name=dx]:checked").val()
                            },
                            dataType: "json",
                            success: function (data) {
                                $("#edit-username").val(data.c_name)
                                $("#edit-phone").val(data.c_phone)
                                $("#edit-comment").val(data.comment)
                                $("#edit-start_time").val(data.start_time)
                                $("#hiddeId").val(data.id)
                                $("#editActivityModal").modal("show")
                            }
                        })

                    }
                } else {
                    alert("请选择你需要更改的记录")
                }

            })

            //修改关闭按钮事件
            $("#editCloseBtn").click(function () {
                $("#edit-comment").val('')
                $("#editActivityModal").modal("hide")
            })
            //修改保存按钮事件
            $("#editBtn").click(function () {
                $.ajax({
                    url: "userlist/updateComment.do",
                    type: "post",
                    data: {
                        "comment":$("#edit-comment").val(),
                        "id":$("#hiddeId").val()
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data.success){
                            alert(data.title)
                            pageList(1, 10)
                            $("input[name=dx]").prop("checked",false);
                            $("input[name=qx]").prop("checked",false);
                            $("#editActivityModal").modal("hide")
                        } else{
                            alert(data.title)
                        }
                    }
                })
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
                            url:"userlist/deleteComment.do",
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
        function pageList(pageNo, pageSize) {
            $.ajax({
                url: "userlist/getComment.do",
                type: "post",
                data: {
                    "c_name": $("#findUsername").val(),
                    "c_phone": $("#findPhone").val(),
                    "pageNo": pageNo,
                    "pageSize": pageSize
                },
                dataType: "json",
                success: function (data) {
                    var html = ""
                    $.each(data.list, function (i, n) {
                        html += '<tr >'
                        html += '<td><input type="checkbox" name="dx" value="' + n.id + '"/></td>'
                        html += '<td>' + n.c_name + '</td>'
                        html += '<td>' + n.c_phone + '</td>'
                        html += '<td>' + n.roomId+ '</td>'
                        html += '<td>' + n.comment+ '</td>'
                        html += '<td>' +n.start_time + '</td>'
                        html += '</tr>'
                    })
                    $("#commentlist").html(html);

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
   

<!-- 管理评论的模态窗口 -->
<div class="modal fade" id="editActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">管理评论</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" role="form">

                    <div class="form-group">
                        <input type="hidden" id="hiddeId"/>
                        <label for="create-marketActivityOwner" class="col-sm-2 control-label">用户名</span></label>
                        <div class="col-sm-9" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-username" readonly>
                        </div>
                        <label for="create-marketActivityName" class="col-sm-2 control-label">手机号</span></label>
                        <div class="col-sm-9" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-phone" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-marketActivityOwner" class="col-sm-2 control-label">评论</span></label>
                        <div class="col-sm-9" style="width: 300px;">
                            <textarea class="form-control" rows="3" id="edit-comment"></textarea>
                        </div>
                        <label for="create-marketActivityName" class="col-sm-2 control-label">创建时间</span></label>
                        <div class="col-sm-9" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-start_time" readonly>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="editCloseBtn">关闭</button>
                <button type="button" class="btn btn-primary" id="editBtn">保存</button>
            </div>
        </div>
    </div>
</div>


<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>评论管理</h3>
        </div>
    </div>
</div>
<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

        <div class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">用户名</div>
                        <input class="form-control" type="text" id="findUsername">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">手机号</div>
                        <input class="form-control" type="text" id="findPhone">
                    </div>
                </div>
                <button type="button" class="btn btn-default" id="find-Btn">查询</button>

            </form>
        </div>
        <div class="btn-toolbar" role="toolbar"
             style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-default" id="editUserBtn"><span
                        class="glyphicon glyphicon-pencil"></span> 修改评论
                </button>
                <button type="button" class="btn btn-danger"  id="deleteUserBtn">
                    <span class="glyphicon glyphicon-minus"></span> 删除评论
                </button>
            </div>

        </div>
        <div style="position: relative;top: 10px;">
            <table class="table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input type="checkbox" name="qx"/></td>
                    <td>用户名</td>
                    <td>手机号</td>
                    <td>房间号</td>
                    <td>评论</td>
                    <td>创建时间</td>
                </tr>
                </thead>
                <tbody id="commentlist" class="tbody-list">

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