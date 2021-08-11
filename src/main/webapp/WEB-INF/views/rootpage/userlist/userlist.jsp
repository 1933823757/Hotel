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
        $(".myfile").fileinput({
            uploadUrl: "userlist/addImg.do", //接受请求地址
            uploadAsync: true, //默认异步上传
            showUpload: true, //是否显示上传按钮,跟随文本框的那个
            showRemove: false, //显示移除按钮,跟随文本框的那个
            showCaption: true,//是否显示标题,就是那个文本框
            showPreview: true, //是否显示预览,不写默认为true
            dropZoneEnabled: false,//是否显示拖拽区域，默认不写为true，但是会占用很大区域
            //minImageWidth: 50, //图片的最小宽度
            //minImageHeight: 50,//图片的最小高度
            //maxImageWidth: 1000,//图片的最大宽度
            //maxImageHeight: 1000,//图片的最大高度
            //maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
            //minFileCount: 0,
            maxFileCount: 1, //表示允许同时上传的最大文件个数
            enctype: 'multipart/form-data',
            validateInitialCount: true,
            previewFileIcon: "<i class='glyphicon glyphicon-king'></i>",
            msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
            allowedFileTypes: ['image'],//配置允许文件上传的类型
            allowedPreviewTypes: ['image'],//配置所有的被预览文件类型
            allowedPreviewMimeTypes: ['jpg', 'png', 'gif'],//控制被预览的所有mime类型
            language: 'zh'
        })
        //异步上传返回结果处理
        $('.myfile').on('fileerror', function (event, data, msg) {
            console.log("fileerror");
            console.log(data.msg);
        });
        //异步上传返回结果处理
        $(".myfile").on("fileuploaded", function (event, data, previewId, index) {
            console.log("fileuploaded");
            console.log(data.msg)
        });
        //查询按钮事件
        $("#find-Btn").click(function () {
            pageList(1,10)
        })
        //保存按钮事件
        $("#create-btn").click(function () {
            var user = $("#create-user").val();
            var password = $("#create-password").val();
            var phone = $("#create-phone").val();
            var sex = $("#create-sex").val();
            if (user == '' && password == '' && phone == '' && sex == '') {
                alert("选项不能为空")
            } else {
                $.ajax({
                    url: "userlist/addUser.do",
                    type: "post",
                    data: {
                        "username": $("#create-user").val(),
                        "password": $("#create-password").val(),
                        "phone": $("#create-phone").val(),
                        "sex": $("#create-sex").val()
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data.success) {
                            alert(data.title)
                            pageList(1, 10)
                            $("input[name=dx]").prop("checked",false);
                            $("#createActivityModal").modal("hide")
                            $("#create-user").val('')
                            $("#create-password").val('')
                            $("#create-phone").val('')
                            $("#create-sex").val('')
                        } else {
                            alert(data.title)
                        }
                    }
                })
            }
        })
        //单选框事件
        $("input[name=qx]").click(function () {
            $("input[name=dx]").prop("checked", this.checked)
        })
        $("#userlist").on("click", $("input[name=dx]"), function () {
            $("input[name=qx]").prop("checked", $("input[name=dx]").length == $("input[name=dx]:checked").length)
        })
        //修改用户按钮
        $("#editUserBtn").click(function () {
            if ($("input[name=dx]:checked").length > 0) {
                if ($("input[name=dx]:checked").length > 1) {
                    alert("请选择一条记录")
                } else {
                    $.ajax({
                        url: "userlist/getUserById.do",
                        type: "get",
                        data: {
                            "id": $("input[name=dx]:checked").val()
                        },
                        dataType: "json",
                        success: function (data) {
                            $("#edit-username").val(data.username)
                            $("#edit-phone").val(data.phone)
                            $("#edit-sex").val(data.sex)
                            $("#edit-idCard").val(data.idcard)
                            $("#edit-name").val(data.name)
                            $("#hiddeId").val(data.id)
                            $("#editActivityModal").modal("show")
                        }
                    })

                }
            } else {
                alert("请选择你需要更改的记录")
            }

        })
        //添加关闭按钮事件
        $("#createBtn").click(function () {
            $("#create-username").val('')
            $("#create-phone").val('')
            $("#create-password").val('')
            $("#createActivityModal").modal("hide")
        })
        //修改关闭按钮事件
        $("#editCloseBtn").click(function () {
            $("#edit-username").val('')
            $("#edit-phone").val('')
            $("#edit-password").val('')
            $("#edit-idCard").val('')
            $("#edit-name").val('')
            $("#editActivityModal").modal("hide")
        })
        //修改保存按钮事件
        $("#editBtn").click(function () {
            $.ajax({
                url: "userlist/updateUser.do",
                type: "post",
                data: {
                    "username":$("#edit-username").val(),
                    "password":$("#edit-password").val(),
                    "phone":$("#edit-phone").val(),
                    "sex":$("#edit-sex").val(),
                    "idcard":$("#edit-idCard").val(),
                    "name":$("#edit-name").val(),
                    "id":$("#hiddeId").val()
                },
                dataType: "json",
                success: function (data) {
                    if (data.success){
                        alert(data.title)
                        pageList(1, 10)
                        $("input[name=dx]").prop("checked",false);
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
                            url:"userlist/deleteUser.do",
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
            url: "userlist/getUserList.do",
            type: "post",
            data: {
                "username": $("#findUsername").val(),
                "phone": $("#findPhone").val(),
                "pageNo": pageNo,
                "pageSize": pageSize
            },
            dataType: "json",
            success: function (data) {
                var html = ""
                $.each(data.list, function (i, n) {
                    html += '<tr class="active">'
                    html += '<td><input type="checkbox" name="dx" value="' + n.id + '"/></td>'
                    html += '<td>' + n.username + '</td>'
                    html += '<td>' + n.phone + '</td>'
                    html += '<td>' + (n.sex == 0 ? "男" : "女") + '</td>'
                    html += '<td>' + (n.idcard == null ? "未设置" : n.idcard) + '</td>'
                    html += '<td>' + (n.name == null ? "未设置" : n.name) + '</td>'
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
<!-- 创建用户的模态窗口 -->
<div class="modal fade" id="createActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">创建新用户</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" role="form" enctype="multipart/form-data">

                    <div class="form-group">
                        <label for="create-marketActivityOwner" class="col-sm-2 control-label">用户名</span></label>
                        <div class="col-sm-9" style="width: 300px;">
                            <input type="text" class="form-control" id="create-user">
                        </div>
                        <label for="create-marketActivityName" class="col-sm-2 control-label">密码</span></label>
                        <div class="col-sm-9" style="width: 300px;">
                            <input type="text" class="form-control" id="create-password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-marketActivityOwner" class="col-sm-2 control-label">手机号码</span></label>
                        <div class="col-sm-9" style="width: 300px;">
                            <input type="text" class="form-control" id="create-phone">
                        </div>
                        <label for="create-marketActivityName" class="col-sm-2 control-label">头像</span></label>
                        <div class="col-sm-9" style="width: 300px;">
                            <input type="file" name="file" class="myfile" multiple/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-marketActivityOwner" class="col-sm-2 control-label">性别</span></label>
                        <div class="col-sm-9" style="width: 300px;">
                            <select class="form-control" id="create-sex">
                                <option></option>
                                <option value="0">男</option>
                                <option value="1">女</option>
                            </select>
                        </div>

                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="createBtn">关闭</button>
                <button type="button" class="btn btn-primary" id="create-btn">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改用户的模态窗口 -->
<div class="modal fade" id="editActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">添加用户</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" role="form">

                    <div class="form-group">
                        <input type="hidden" id="hiddeId"/>
                        <label for="create-marketActivityOwner" class="col-sm-2 control-label">用户名</span></label>
                        <div class="col-sm-9" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-username">
                        </div>
                        <label for="create-marketActivityName" class="col-sm-2 control-label">密码</span></label>
                        <div class="col-sm-9" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-marketActivityOwner" class="col-sm-2 control-label">名称</span></label>
                        <div class="col-sm-9" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-name">
                        </div>
                        <label for="create-marketActivityName" class="col-sm-2 control-label">身份证</span></label>
                        <div class="col-sm-9" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-idCard">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-marketActivityOwner" class="col-sm-2 control-label">手机号码</span></label>
                        <div class="col-sm-9" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-phone">
                        </div>
                        <label for="create-marketActivityName" class="col-sm-2 control-label">头像</span></label>
                        <div class="col-sm-9" style="width: 300px;">
                            <input type="file" name="file" class="myfile" multiple/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-marketActivityOwner" class="col-sm-2 control-label">性别</span></label>
                        <div class="col-sm-9" style="width: 300px;">
                            <select class="form-control" id="edit-sex">
                                <option></option>
                                <option value="0">男</option>
                                <option value="1">女</option>
                            </select>
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
            <h3>用户管理</h3>
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
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createActivityModal">
                    <span class="glyphicon glyphicon-plus"></span> 添加用户
                </button>
                <button type="button" class="btn btn-default" id="editUserBtn"><span
                        class="glyphicon glyphicon-pencil"></span> 修改用户
                </button>
                <button type="button" class="btn btn-danger"  id="deleteUserBtn">
                    <span class="glyphicon glyphicon-minus"></span> 删除用户
                </button>
            </div>

        </div>
        <div style="position: relative;top: 10px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input type="checkbox" name="qx"/></td>
                    <td>用户名</td>
                    <td>手机号</td>
                    <td>性别</td>
                    <td>身份证</td>
                    <td>名称</td>
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