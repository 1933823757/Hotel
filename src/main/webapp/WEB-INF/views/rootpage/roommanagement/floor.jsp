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
    <%--分页插件--%>
    <link rel="stylesheet" type="text/css" href="js/bs_pagination/jquery.bs_pagination.min.css">
    <script type="text/javascript" src="js/bs_pagination/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript" src="js/bs_pagination/en.js"></script>
    <title>楼层管理</title>
    <script type="text/javascript">
        $(function () {
             pagelist(1,10);

             //多选框事件
            $("input[name=qx]").click(function () {
                $("input[name=dx]").prop("checked",this.checked)
            })
            $("#tbody1").on("click",$("input[name=dx]"),function(){
                $("input[name=qx]").prop("checked",$("input[name=dx]").length==$("input[name=dx]:checked").length)
            })

            //创建楼层按钮事件
            $("#createbtn").click(function () {
               $("#createFloorModal").modal("show")
            })
            //保存按钮事件
            $("#addFloorbtn").click(function () {
                //判断输入是否为空
                if ($("#floorId").val().trim() ==''  || $("#roomType").val().trim() == ''){
                    alert("请填写内容")
                } else{
                    //保存ajax
                    $.ajax({
                        url:"addFloor.do",
                        type:"post",
                        data:{
                            "floorId":$("#floorId").val().trim(),
                            "roomType":$("#roomType").val().trim()
                        },
                        dataType:"json",
                        success:function (data) {
                            if (data.success){
                                alert("添加成功")
                                pagelist(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
                                $("#floorId").val('')
                                $("#roomType").val('')
                                $("#createFloorModal").modal("hide")
                            }else{
                                alert("添加失败，楼层不能重复添加")
                            }
                        }
                    })
                }
            })
            //查询按钮事件
            $("#findBtn").click(function () {
               pagelist(1,5);
            })
            //修改按钮事件
            $("#editbtn").click(function () {
                if ($("input[name=dx]:checked").length>1){
                    alert("请选择一条记录")
                }else if($("input[name=dx]:checked").length ==0){
                    alert("请选择您要修改的记录")
                }else{
                    $.ajax({
                        url:"getFrool.do",
                        type:"post",
                        data:{
                        "id":$("input[name=dx]:checked").val()
                        },
                        dataType:"json",
                        success:function (data) {
                            $("#edit-floorId").val(data.floorId)
                            $("#edit-roomType").val(data.roomType)
                            $("#editId").val(data.id)
                        }
                    })

                    $("#editActivityModal").modal("show")

                }

            })
            //更新按钮事件
            $("#updateBtn").click(function () {
                $.ajax({
                    url:"updataFloor.do",
                    type:"get",
                    data:{
                        "id":$("#editId").val(),
                        "floorId":$("#edit-floorId").val(),
                        "roomType":$("#edit-roomType").val()
                    },
                    dataType:"json",
                    success:function (data) {
                        if(data.success){
                            alert("修改成功")
                            pagelist(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
                            $("input[name=dx]:checked").prop("checked",false)
                            $("#editActivityModal").modal("hide")
                        }else{
                            alert("修改失败")
                            $("#editActivityModal").modal("hide")
                        }
                    }
                })
            })
            //删除按钮事件
            $("#deletebtn").click(function () {
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
                           url:"deleteFloorAndRoom.do",
                           type:"get",
                           data:param,
                           dataType:"json",
                           success:function (data) {
                            if (data.success){
                                alert("删除成功")
                                pagelist(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
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
        })
        //pageNo 页码
        //pageSize 每页展示的记录条数
        function pagelist(pageNo,pageSize) {

            $.ajax({
                url:"getFloorList.do",
                type:"get",
                data:{
                    "floorId": $("#findFloorId").val(),
                    "roomType":$("#findRoomType").val().trim(),
                    "pageNo":pageNo,
                    "pageSize":pageSize
                },
                dataType:"json",
                success:function (data) {
                //    data:[{"1"},{"2}]
                    var html=''
                $.each(data.floorList,function (i,n) {
                        html+='<tr >'
                        html+='<td><input type="checkbox" name="dx" value="'+n.id+'"/></td>'
                        html+='<td>'+n.floorId+'</td>'
                        html+='<td>'+n.roomType+'</td>'
                        html+='<td>'+n.roomCount+'</td>'
                        html+='</tr>'
                })

                    $("#tbody1").html(html);
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
                            pagelist(data.currentPage , data.rowsPerPage);
                        }
                    });

                }
            })
        }
    </script>
</head>
<body>
    <!-- 创建楼层的模态窗口 -->
<div class="modal fade" id="createFloorModal" role="dialog">
 <div class="modal-dialog" role="document" style="width: 85%;">
     <div class="modal-content">
         <div class="modal-header">
             <button type="button" class="close" data-dismiss="modal">
                 <span aria-hidden="true">×</span>
             </button>
             <h4 class="modal-title" id="myModalLabel1">创建楼层</h4>
         </div>
         <div class="modal-body">
         
             <form class="form-horizontal" role="form">
             
                 <div class="form-group">
                     <label for="create-FloorId" class="col-sm-2 control-label">楼层号</span></label>
                     <div class="col-sm-9" style="width: 300px;">
                         <input type="text" class="form-control" id="floorId">
                     </div>
                     <label for="create-RoomType" class="col-sm-2 control-label">房型</span></label>
                     <div class="col-sm-9" style="width: 300px;">
                         <input type="text" class="form-control" id="roomType">
                     </div>
                 </div>
                 

             </form>
             
         </div>
         <div class="modal-footer">
             <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
             <button type="button" class="btn btn-primary" id="addFloorbtn">保存</button>
         </div>
     </div>
 </div>
</div>

<!-- 修改预定客房的模态窗口 -->
<div class="modal fade" id="editActivityModal" role="dialog">
 <div class="modal-dialog" role="document" style="width: 85%;">
     <div class="modal-content">
         <div class="modal-header">
             <button type="button" class="close" data-dismiss="modal">
                 <span aria-hidden="true">×</span>
             </button>
             <h4 class="modal-title" id="myModalLabel2">修改楼层信息</h4>
         </div>
         <div class="modal-body">
         
            <form class="form-horizontal" role="form">
             
                <div class="form-group">
                    <input type="hidden" id="editId"/>
                    <label for="edit-marketActivityOwner" class="col-sm-2 control-label">楼层号</span></label>
                    <div class="col-sm-9" style="width: 300px;">
                        <input type="text" class="form-control" id="edit-floorId">
                    </div>
                    <label for="edit-marketActivityName" class="col-sm-2 control-label">房型</span></label>
                    <div class="col-sm-9" style="width: 300px;">
                        <input type="text" class="form-control" id="edit-roomType">
                    </div>
                </div>
            </form>
             
         </div>
         <div class="modal-footer">
             <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
             <button type="button" class="btn btn-primary" id="updateBtn">更新</button>
         </div>
     </div>
 </div>
</div>




<div>
 <div style="position: relative; left: 10px; top: -10px;">
     <div class="page-header">
         <h3>楼层管理</h3>
     </div>
 </div>
</div>
<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
 <div style="width: 100%; position: absolute;top: 5px; left: 10px;">
 
     <div class="btn-toolbar" role="toolbar" style="height: 80px;">
         <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
           
           <div class="form-group">
             <div class="input-group">
               <div class="input-group-addon">楼层号</div>
               <input class="form-control" type="text" id="findFloorId">
             </div>
           </div>
           
         <div class="form-group">
             <div class="input-group">
               <div class="input-group-addon">客房类型</div>
                 <input class="form-control" type="text" id="findRoomType">
             </div>
           </div>
           <button type="button" class="btn btn-default" id="findBtn">查询</button>
           
         </form>
     </div>
     <div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
         <div class="btn-group" style="position: relative; top: 18%;">
           <button type="button" class="btn btn-primary" id="createbtn"><span class="glyphicon glyphicon-plus"></span> 创建楼层</button>
           <button type="button" class="btn btn-default" id="editbtn"><span class="glyphicon glyphicon-pencil"></span> 修改楼层</button>
           <button type="button" class="btn btn-danger" id="deletebtn"><span class="glyphicon glyphicon-minus"></span> 删除楼层</button>
         </div>
         
     </div>
     <div style="position: relative;top: 10px;">
         <table class="table table-hover">
             <thead>
                 <tr style="color: #B3B3B3;">
                     <td><input type="checkbox"  name="qx"/></td>
                     <td>楼层号</td>
                     <td>房型</td>
                     <td>总房间数</td>
                 </tr>
             </thead>
             <tbody id="tbody1">
                 <%--<tr class="active">--%>
                     <%--<td><input type="checkbox" /></td>--%>
                     <%--<td>1</td>--%>
                     <%--<td>普通单间</td>--%>
                     <%--<td>20</td>--%>
                 <%--</tr>--%>
                 <%--<tr class="active">--%>
                    <%--<td><input type="checkbox" /></td>--%>
                     <%--<td>1</td>--%>
                     <%--<td>普通单间</td>--%>
                     <%--<td>20</td>--%>
                 <%--</tr>--%>
                 <%--<tr class="active">--%>
                    <%--<td><input type="checkbox" /></td>--%>
                     <%--<td>1</td>--%>
                     <%--<td>普通单间</td>--%>
                     <%--<td>20</td>--%>
                 <%--</tr>--%>
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