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
	<title>客房预定新增</title>
</head>
<style>
    .page-header h3{
        width: 100%;
        font-size: 30px;
       text-align: center;
    }
</style>
<script>
	$(function () {
		pageList(1,10)
		//日期插件初始化
		$(".time").datetimepicker({
			minView: "month",
			language:  'zh-CN',
			format: 'yyyy-mm-dd',
			autoclose: true,
			todayBtn: true,
			pickerPosition: "bottom-left"
		});

		//创建按钮打开模态窗口事件
        $("#createBtn").click(function () {
            //点击按钮前去拿所有的房间号
            $.ajax({
                url:"putup/getRoomIdAll.do",
                type:"get",
                dataType:"json",
                success:function (data) {
                    var html="";
                    $.each(data.success,function (i,n) {
                        html+='<option value="'+n.id+'">'+n.roomId+'</option>'
                    })
                    $("#roomId").html(html);
                    $("#createActivityModal").modal("show");
                }
            })

        })
		//创建按钮里面更新的按钮事件
		$("#createaddBtn").click(function () {
			var $cname =  $("#create-cname");
			var $fixTime =  $("#create-fixTime");
			var $endTime =  $("#create-endTime");
			var $roomId =  $("#roomId");
			var $idCard = $("#create-idCard");
			var $c_tel = $("#create-tel");
			if ( $cname.val() !='' && $fixTime.val() !='' && $endTime.val() !='' &&  $idCard.val() !='' && $c_tel.val() !=''){
				//判断预定时间是否小于今天时间
				var fixTime = $fixTime.val().replace(/\-/g, "")
				var endTime =  $endTime.val().replace(/\-/g, "")
				var nowTime =  show().replace(/\-/g, "")
				if (fixTime<nowTime){
					alert("预定时间不能小于今天")
				}else if (fixTime<endTime) {
					$.ajax({
						url:"putup/addEngage.do",
						type:"post",
						data:{
						"c_tel":$c_tel.val(),
						"idCard":$idCard.val(),
						"start_time":$fixTime.val(),
						"close_time":$endTime.val(),
						"c_name":$cname.val(),
						"roomId":$roomId.val()
						},
						dataType:"json",
						success:function (data) {
							if (data.success){
								alert("预定成功")

								$("#createActivityModal").modal("hide");
								pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
								$c_tel.val('')
								$idCard.val('')
								$fixTime.val('')
								$endTime.val('')
								$cname.val('')
							} else{
								alert("预定失败")
							}
						}
					})
				}else{
					alert("退订时间不能小于预定时间")
				}
			}else{
				alert("输入框不能为空")
			}
		})
		//查询按钮事件
		$("#getBtn").click(function () {
			pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));

		})
		//单选框事件
		$("input[name=qx]").click(function () {
			$("input[name=dx]").prop("checked",this.checked)
		})
		$("#EngageList").on("click",$("input[name=dx]"),function(){
			$("input[name=qx]").prop("checked",$("input[name=dx]").length==$("input[name=dx]:checked").length)
		})
		//修改按钮事件
		$("#editBtn").click(function () {
			if($("input[name=dx]:checked").length>0){
				if($("input[name=dx]:checked").length>1){
					alert("请选择一条记录")
				}else{
					$.ajax({
						url:"putup/getEngageById.do",
						type:"get",
						data:{
							"id":$("input[name=dx]:checked").val()
						},
						dataType:"json",
						success:function (data) {
							console.log(data)
							$("#hiddenId").val(data.engage.id)
							$("#edit-cname").val(data.engage.c_name)
							$("#edit-fixTime").val(data.engage.start_time)
							$("#edit-endTime").val(data.engage.close_time)
							$("#edit-idCard").val(data.engage.idCard)
							$("#edit-tel").val(data.engage.c_tel)
							var html='<option value="'+data.engage.roomId+'">'+data.engage.roomId+'</option>'
							$.each(data.roomList,function (i,n) {
								html+='<option value="'+n.id+'">'+n.roomId+'</option>'
							})
							$("#edit-roomId").html(html)
							$("#editActivityModal").modal("show")
						}
					})

				}
			}else{
				alert("请选择你需要更改的记录")
			}
		})
		//修改按钮保存事件
		$("#editaddBtn").click(function () {
			$.ajax({
				url:"putup/editEngage.do",
				type:"post",
				data:{
					"c_name":$("#edit-cname").val(),
					"start_time":$("#edit-fixTime").val(),
					"close_time":$("#edit-endTime").val(),
					"roomId":$("#edit-roomId").val(),
					"idCard":$("#edit-idCard").val(),
					"c_tel":$("#edit-tel").val(),
					"id":$("#hiddenId").val()
				},
				dataType:"json",
				success:function (data) {
					if(data.success){
						alert("修改成功")
						pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
						$("input[name=dx]:checked").prop("checked",false)
						$("#editActivityModal").modal("hide")
					}else{
						alert("修改失败")
						$("input[name=dx]").prop("checked",false);
						$("#editActivityModal").modal("hide")
					}
				}
			})
		})
		//修改关闭按钮事件
		$("#edit-closeBtn").click(function () {
			$("#edit-cname").val('');
			$("#edit-fixTime").val('');
			$("#edit-endTime").val('');
			$("#edit-idCard").val('');
			$("#edit-tel").val('');
			$("#editActivityModal").modal("hide")
		})

		//删除按钮事件
		$("#deleteBtn").click(function () {
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
						url:"putup/deleteEnage.do",
						type:"post",
						data:param,
						dataType:"json",
						success:function (data) {
							if (data.success){
								alert("删除成功")
								$("input[name=dx]").prop("checked",false);
								pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
							} else{
								alert("删除失败")
								$("input[name=dx]").prop("checked",false);
							}
						}
					})
				}
			} else{
				alert("请选择你需要删除的记录")
			}
		})
	})
	//获取时间js函数
	function show(){
		var mydate = new Date();
		var str = "" + mydate.getFullYear() + "-";
		str += (mydate.getMonth()+1)<10?"0"+(mydate.getMonth()+1):(mydate.getMonth()+1) + "-";
		str += mydate.getDate() + "-";
		return str;
	}

	function pageList(pageNo,pageSize) {
		$.ajax({
			url:"putup/getEngage.do",
			type:"post",
			data:{
				"c_name":$("#c_name").val().trim(),
				"idCard":$("#idCard").val(),
				"start_time":$("#start_time").val(),
				"pageNo":pageNo,
				"pageSize":pageSize
			},
			dataType:"json",
			success:function (data) {
				var  html=""
				$.each(data.list,function (i,n) {
							html+='<tr >'
							html+='<td><input type="checkbox" value="'+n.id+'" name="dx"/></td>'
							html+='<td>'+n.c_name+'</td>'
							html+='<td>'+n.idCard+'</td>'
					        html+='<td>'+n.c_tel+'</td>'
							html+='<td>'+n.roomId+'</td>'
							html+='<td>'+n.roomType+'</td>'
							html+='<td>'+n.start_time+'</td>'
							html+='<td>'+n.close_time+'</td>'
							html+='<td>'+n.managerName+'</td>'
							html+='</tr>'
				})
				$("#EngageList").html(html);

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
    	<!-- 创建预定客房的模态窗口 -->
	<div class="modal fade" id="createActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">客房预定新增</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="create-cname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-9" style="width: 300px;">
                                <input type="text" class="form-control" id="create-cname">
							</div>
                            <label for="create-marketActivityName" class="col-sm-2 control-label">预定时间<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-9" style="width: 300px;">
                                <input type="text" class="form-control time" id="create-fixTime">
                            </div>
						</div>
						
						<div class="form-group">
							<label for="create-startTime" class="col-sm-2 control-label">退房时间</label>
							<div class="col-sm-9" style="width: 300px;">
								<input type="text" class="form-control time" id="create-endTime">
							</div>
							<label for="create-endTime" class="col-sm-2 control-label">房间号</label>
							<div class="col-sm-10" style="width: 300px;">
                                <select class="form-control" id="roomId">

                                </select>
							</div>
						</div>
                        <div class="form-group">
                            <label for="create-startTime" class="col-sm-2 control-label">身份证</label>
							<div class="col-sm-9" style="width: 300px;">
								<input type="text" class="form-control" id="create-idCard">
							</div>
                            <label for="create-cost" class="col-sm-2 control-label">电话号码</label>
                            <div class="col-sm-9" style="width: 300px;">
                                <input type="text" class="form-control" id="create-tel">
                            </div>
                        </div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="createaddBtn">保存</button>
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
					<h4 class="modal-title" id="myModalLabel2">客房预定新增</h4>
				</div>
				<div class="modal-body">

					<form class="form-horizontal" role="form">

						<div class="form-group">
							<input type="hidden" id="hiddenId">
							<label for="create-cname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-9" style="width: 300px;">
								<input type="text" class="form-control" id="edit-cname">
							</div>
							<label for="create-marketActivityName" class="col-sm-2 control-label">预定时间<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-9" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-fixTime">
							</div>
						</div>

						<div class="form-group">
							<label for="create-startTime" class="col-sm-2 control-label">退房时间</label>
							<div class="col-sm-9" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-endTime">
							</div>
							<label for="create-endTime" class="col-sm-2 control-label">房间号</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-roomId">

								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="create-startTime" class="col-sm-2 control-label">身份证</label>
							<div class="col-sm-9" style="width: 300px;">
								<input type="text" class="form-control" id="edit-idCard">
							</div>
							<label for="create-cost" class="col-sm-2 control-label">电话号码</label>
							<div class="col-sm-9" style="width: 300px;">
								<input type="text" class="form-control" id="edit-tel">
							</div>
						</div>
					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" id="edit-closeBtn">关闭</button>
					<button type="button" class="btn btn-primary" id="editaddBtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>客房预定新增</h3>
			</div>
		</div>
	</div>
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">预定的姓名</div>
				      <input class="form-control" type="text" id="c_name">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">预定身份证</div>
				      <input class="form-control" type="text" id="idCard">
				    </div>
				  </div>


				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">预定时间</div>
					  <input class="form-control time" type="text" id="start_time" />
				    </div>
				  </div>
				  
				  <button type="button" class="btn btn-default" id="getBtn">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="createBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" name="qx"/></td>
							<td>姓名</td>
							<td>身份证</td>
							<td>手机号</td>
                            <td>房间号</td>
							<td>房间类型</td>
                            <td>预定时间</td>
							<td>退房时间</td>
							<td>创建人</td>
						</tr>
					</thead>
					<tbody id="EngageList">
						<%--<tr class="active">--%>
							<%--<td><input type="checkbox" /></td>--%>
							<%--<td>姓名</td>--%>
							<%--<td>身份证</td>--%>
							<%--<td>房间号</td>--%>
							<%--<td>房间类型</td>--%>
							<%--<td>预定天数</td>--%>
							<%--<td>预定时间</td>--%>
							<%--<td>退房时间</td>--%>
							<%--<td>创建人</td>--%>
						<%--</tr>--%>
                        <%--<tr class="active">--%>
                            <%--<td><input type="checkbox" /></td>--%>
							<%--<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.html';">李四</a></td>--%>
                            <%--<td>101</td>--%>
							<%--<td>标准单间</td>--%>
                            <%--<td>2</td>--%>
							<%--<td>2020-10-20</td>--%>
                            <%--<td>200</td>--%>
                        <%--</tr>--%>
                        <%--<tr class="active">--%>
                            <%--<td><input type="checkbox" /></td>--%>
							<%--<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.html';">李四</a></td>--%>
                            <%--<td>101</td>--%>
							<%--<td>标准单间</td>--%>
                            <%--<td>2</td>--%>
							<%--<td>2020-10-20</td>--%>
                            <%--<td>200</td>--%>
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