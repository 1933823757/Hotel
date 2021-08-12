<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    <%--图片上传插件--%>
    <link rel="stylesheet" href="bootstrap-fileinput/fileinput.min.css">
    <script src="bootstrap-fileinput/fileinput.min.js"></script>
    <script src="bootstrap-fileinput/zh.js"></script>

    <%--分页插件--%>
    <link rel="stylesheet" type="text/css" href="js/bs_pagination/jquery.bs_pagination.min.css">
    <script type="text/javascript" src="js/bs_pagination/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript" src="js/bs_pagination/en.js"></script>
    <title>房间管理</title>
</head>
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
<script>
    $(function () {
        pageList(1,5)

        //创建按钮打开模态窗口前事件
        $("#addBtn").click(function () {
            $.ajax({
                url:"getFloorId.do",
                type:"get",
                dataType:"json",
                success:function (data) {
                    var html="";
                    $.each(data.success,function (i,n) {
                        html+='<option value="'+n.id+'">'+n.floorId+'</option>'
                    })
                    $("#floorId").html(html);
                    $("#createActivityModal").modal("show");
                }
            })
        })
        //创建按钮事件
        $("#createBtn").click(function () {
           var $roomId =  $("#roomId");
            var $roomPrice =  $("#roomPrice");
            var $roomSuggest =  $("#roomSuggest");
            if ($roomId.val() !='' && $roomPrice.val() !='' && $roomSuggest.val() !=''){
                    $.ajax({
                        url:"addRoom.do",
                        type:"get",
                        data:{
                        "roomId":$roomId.val().trim(),
                        "roomPrice":$roomPrice.val().trim(),
                        "roomSuggest":$roomSuggest.val().trim(),
                        "floorId":$("#floorId").val().trim()
                        },
                        dataType:"json",
                        success:function (data) {
                            if (data.success){
                                alert(data.title)
                                pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
                                $("#createActivityModal").modal("hide")
                                $roomId.val("")
                                $roomPrice.val("")
                                $roomSuggest.val("")
                            } else{
                              alert(data.title)
                            }
                        }
                    })
                $("#floorId").val()
            }else{
                alert("请完善信息")
            }

        })
        //添加按钮关闭模态窗口事件
        $("#closeBtn").click(function () {
            $("#createActivityModal").modal("hide")
            $("#roomId").val("")
            $("#roomPrice").val("")
            $("#roomSuggest").val("")
        })
        //房间图片上传插件
        $(".myfile").fileinput({
            language : 'zh',
            uploadUrl:"uploadFile.do", //接受请求地址
            showUpload : true, //是否显示上传按钮,跟随文本框的那个
            showRemove : false, //显示移除按钮,跟随文本框的那个
            showCaption : true,//是否显示标题,就是那个文本框
            showPreview : true, //是否显示预览,不写默认为true
            dropZoneEnabled : false,//是否显示拖拽区域，默认不写为true，但是会占用很大区域
            //minImageWidth: 50, //图片的最小宽度
            //minImageHeight: 50,//图片的最小高度
            //maxImageWidth: 1000,//图片的最大宽度
            //maxImageHeight: 1000,//图片的最大高度
            //maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
            //minFileCount: 0,
            maxFileCount: 10,//表示允许同时上传的最大文件个数
            enctype : 'multipart/form-data',
            validateInitialCount : true,
            previewFileIcon : "<i class='glyphicon glyphicon-king'></i>",
            msgFilesTooMany : "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
            allowedFileTypes : [ 'image' ],//配置允许文件上传的类型
            allowedPreviewTypes : [ 'image' ],//配置所有的被预览文件类型
            allowedPreviewMimeTypes : [ 'jpg', 'png', 'gif' ]//控制被预览的所有mime类型
        })
        //异步上传返回结果处理
        $('.myfile').on('fileerror', function(event, data, msg) {
            console.log("fileerror");
            console.log(data);
        });
        //异步上传返回结果处理
        $(".myfile").on("fileuploaded", function(event, data, previewId, index) {
            console.log("fileuploaded");
        })
        //上传前
        $('.myfile').on('filepreupload', function(event, data, previewId, index) {
            console.log("filepreupload");
        });
        //查询按钮事件
        $("#roomFindBtn").click(function () {
           pageList(1,5)
        })

        //修改按钮点击打开模态窗口前事件
        $("#editBtn").click(function () {
            if($("input[name=dx]:checked").length>0){
                if($("input[name=dx]:checked").length>1){
                    alert("请选择一条记录")
                }else{
                    $.ajax({
                        url:"getRoomAll.do",
                        type:"get",
                        data:{
                        "id":$("input[name=dx]:checked").val()
                        },
                        dataType:"json",
                        success:function (data) {
                            console.log(data)
                            $("#editroomId").val(data.roomId)
                            $("#editRoomPrice").val(data.roomPrice)
                            $("#editRoomSuggest").val(data.roomSuggest)
                            $("#editFloorId").val(data.floorId)
                            $("#editId").val(data.id)
                            $("#editActivityModal").modal("show")
                        }
                    })

                }
            }else{
                alert("请选择你需要更改的记录")
            }
        })

        $("input[name=qx]").click(function () {
            $("input[name=dx]").prop("checked",this.checked)
        })
        $("#roomList").on("click",$("input[name=dx]"),function(){
            $("input[name=qx]").prop("checked",$("input[name=dx]").length==$("input[name=dx]:checked").length)
        })
        //删除按钮事件
        $("#deleteRoomBtn").click(function () {
            if ($("input[name=dx]:checked").length>0){
                var $input =$("input[name=dx]:checked");
                var param=''
                for (var i=0;i<$input.length;i++){
                    param+="id="+$input[i].value
                    if (i<$input.length-1){
                        param+="&"
                    }
                }
                if (confirm("确定删除吗？")) {

                    $.ajax({
                        url:"deleteRoom.do",
                        type:"get",
                        data:param,
                        dataType:"json",
                        success:function (data) {
                            if (data.success){
                                alert("删除成功")
                                pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
                            } else{
                                alert("删除失败")
                            }
                        }
                    })
                }
            } else{
                alert("请选择你需要删除的记录")
            }
        })

        //修改模态窗口的更新按钮事件
        $("#editAddBtn").click(function () {
            $.ajax({
                url:"updateRoom.do",
                type:"post",
                data:{
                "id":$("#editId").val(),
                "roomPrice":$("#editRoomPrice").val(),
                "roomSuggest":$("#editRoomSuggest").val(),
                "floorId":$("#editFloorId").val(),
                "roomId":$("#editroomId").val()
                },
                dataType:"json",
                success:function (data) {
                    if (data.success){
                        alert(data.title)
                        pageList(1,10)
                        $("#editActivityModal").modal("hide")
                    } else{
                        alert(data.title)
                    }
                }
            })
        })
    })

    //分页查询事件
    function pageList(pageNo,pageSize) {
        $.ajax({
            url:"RoomPagelist.do",
            type:"post",
            data:{
                "roomId":$("#findroomId").val().trim(),
                "roomType":$("#roomType").val(),
                "pageNo":pageNo,
                "pageSize":pageSize
            },
            dataType:"json",
            success:function (data) {
                var  html=""
                $.each(data.roomList,function (i,n) {
                    html+='<tr class="text-nowrap">'
                    html+='<td><input type="checkbox" value="'+n.object.id+'" name="dx"/></td>'
                    html+='<td>'+n.object.roomId+'</td>'
                    html+='<td>'+n.object.roomType+'</td>'
                    html+='<td>'+n.object.roomPrice+'</td>'
                    html+='<td><span>'+n.object.roomSuggest+'</span></td>'
                    html+='<td>'
                    $.each(n.imgPathList,function (i,n) {
                        html+='<img src="'+n+'" alt="" class="img-rounded"style="width: 50px; height: 50px;">'
                    });
                    html+='</td>'
                    html+='</tr>'
                })
                $("#roomList").html(html);

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
    <!-- 创建房间的模态窗口 -->
    <div class="modal fade" id="createActivityModal" role="dialog">
        <div class="modal-dialog" role="document" style="width: 85%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel1">创建房间</h4>
                </div>
                <div class="modal-body">

                    <form class="form-horizontal" role="form" enctype="multipart/form-data">

                        <div class="form-group">
                            <label for="create-marketActivityOwner" class="col-sm-2 control-label">房间号</span></label>
                            <div class="col-sm-9" style="width: 300px;">
                                <input type="text" class="form-control" id="roomId" name="roomId">
                            </div>
                            <label for="create-marketActivityName" class="col-sm-2 control-label">楼层号</span></label>
                            <div class="col-sm-9" style="width: 300px;">
                                <select class="form-control" id="floorId">

                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="create-marketActivityOwner" class="col-sm-2 control-label">房间价格</span></label>
                            <div class="col-sm-9" style="width: 300px;">
                                <input type="text" class="form-control" id="roomPrice">
                            </div>
                            <label for="create-marketActivityName" class="col-sm-2 control-label">房间图片</span></label>
                            <div class="col-sm-9" style="width: 300px;">
                                <input type="file" name="file"  class="myfile" multiple/>
                            </div>

                        </div>
                        <div class="form-group">
                            <label for="create-marketActivityOwner" class="col-sm-2 control-label">房间介绍</span></label>
                            <div class="col-sm-9" style="width: 600px;">
                                <textarea class="form-control" rows="3" id="roomSuggest"></textarea>
                            </div>
                        </div>
                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" id="closeBtn">关闭</button>
                    <button type="button" class="btn btn-primary" id="createBtn">创建</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 修改房间的模态窗口 -->
    <div class="modal fade" id="editActivityModal" role="dialog">
        <div class="modal-dialog" role="document" style="width: 85%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel1">修改房间</h4>
                </div>
                <div class="modal-body">

                    <form class="form-horizontal" role="form">

                        <div class="form-group">
                            <input type="hidden" id="editId">
                            <label for="create-marketActivityOwner" class="col-sm-2 control-label">房间号</span></label>
                            <div class="col-sm-9" style="width: 300px;">
                                <input type="text" class="form-control" id="editroomId">
                            </div>
                            <label for="create-marketActivityName" class="col-sm-2 control-label">楼层号</span></label>
                            <div class="col-sm-9" style="width: 300px;">
                                <select class="form-control" id="editFloorId" >
                                    <option></option>
                                    <c:forEach items="${sessionScope.floor}" var="a">
                                        <option value="${a.id}">${a.floorId}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="create-marketActivityOwner" class="col-sm-2 control-label">房间价格</span></label>
                            <div class="col-sm-9" style="width: 300px;">
                                <input type="text" class="form-control" id="editRoomPrice">
                            </div>
                            <label for="create-marketActivityName" class="col-sm-2 control-label">房间图片</span></label>
                            <div class="col-sm-9" style="width: 300px;">
                                <input type="file" name="file"  class="myfile" multiple/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="create-marketActivityOwner" class="col-sm-2 control-label">房间介绍</span></label>
                            <div class="col-sm-9" style="width: 600px;">
                                <textarea class="form-control" rows="3" id="editRoomSuggest"></textarea>
                            </div>
                        </div>
                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="editAddBtn">保存</button>
                </div>
            </div>
        </div>
    </div>




    <div>
        <div style="position: relative; left: 10px; top: -10px;">
            <div class="page-header">
                <h3>房间管理</h3>
            </div>
        </div>
    </div>
    <div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
        <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

            <div class="btn-toolbar" role="toolbar" style="height: 80px;">
                <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

                    <div class="form-group">
                        <div class="input-group">
                            <div class="input-group-addon">房间号</div>
                            <input class="form-control" type="text" id="findroomId">
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="input-group">
                            <div class="input-group-addon">客房类型</div>
                            <select class="form-control" id="roomType">
                                <option></option>
                                <c:forEach items="${sessionScope.floor}" var="a">
                                    <option value="${a.roomType}">${a.roomType}</option>
                                </c:forEach>

                            </select>
                        </div>
                    </div>
                    <button type="button" class="btn btn-default" id="roomFindBtn">查询</button>

                </form>
            </div>
            <div class="btn-toolbar" role="toolbar"
                style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
                <div class="btn-group" style="position: relative; top: 18%;">
                    <button type="button" class="btn btn-primary" id="addBtn"><span class="glyphicon glyphicon-plus"></span> 创建房间</button>
                    <button type="button" class="btn btn-default" id="editBtn"><span class="glyphicon glyphicon-pencil"></span> 修改房间</button>
                    <button type="button" class="btn btn-danger" data-toggle="modal" id="deleteRoomBtn"><span class="glyphicon glyphicon-minus"></span> 删除房间</button>
                </div>

            </div>
            <div>
                <table class=" table-hover">
                    <thead>
                        <tr style="color: #B3B3B3;">
                            <td><input type="checkbox" name="qx"/></td>
                            <td>房间号</td>
                            <td>房型</td>
                            <td>价格</td>
                            <td>房间介绍</td>
                            <td>房间图片</td>
                        </tr>
                    </thead>
                    <tbody class="tbody-list" id="roomList">

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