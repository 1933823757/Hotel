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
	<%--日期插件--%>
	<link href="js/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="js/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript" src="js/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
	<%--分页插件--%>
	<link rel="stylesheet" type="text/css" href="js/bs_pagination/jquery.bs_pagination.min.css">
	<script type="text/javascript" src="js/bs_pagination/jquery.bs_pagination.min.js"></script>
	<script type="text/javascript" src="js/bs_pagination/en.js"></script>
    <title>住宿登记</title>
</head>
<script type="text/javascript">
	$(function () {

		getRoomIdAll()

		//日期插件初始化
		$(".time").datetimepicker({
			minView: "month",
			language:  'zh-CN',
			format: 'yyyy-mm-dd',
			autoclose: true,
			todayBtn: true,
			pickerPosition: "bottom-left"
		});
		//单选框事件
		$("input[name=qx]").click(function () {
			$("input[name=dx]").prop("checked",this.checked)
		})
		$("#moveRoomList").on("click",$("input[name=dx]"),function(){
			$("input[name=qx]").prop("checked",$("input[name=dx]").length==$("input[name=dx]:checked").length)
		})

		//查询按钮事件
		$("#findBtn").click(function () {
			pageList(1,10)
		})
		//登记按钮事件
		$("#addMoveRoomBtn").click(function () {
			if($("input[name=dx]:checked").length>0){
				if($("input[name=dx]:checked").length>1){
					alert("请选择需要一条记录")
				}else{
					$.ajax({
						url:"putup/getmr.do",
						type:"post",
						data:{
							"id":$("input[name=dx]:checked").val()
						},
						dataType:"json",
						success:function (data) {
							console.log(data)
							$("#create-roomId").val(data.roomId)
							$("#create-roomType").val(data.roomType)
							$("#create-roomPrice").val(data.roomPrice)
							$("#State").val(data.state)
							$("#create-c_name").val(data.c_name)
							$("#create-fix_time").val(data.fix_time)
							$("#create-start_time").val(data.start_time)
							$("#create-close_time").val(data.close_time)
							$("#create-idCard").val(data.idCard)
							$("#hiddenMoveRoomId").val(data.id)
							$("#create-c_tel").val(data.c_tel)
							$("#createActivityModal").modal("show")
						}
					})
				}
			}else{
				alert("请选择你需要登记的记录")
			}
		})
		//保存按钮事件
		$("#addBtn").click(function () {
			if ($("#create-start_time").val()==''){
				alert("请输入入住日期")
			} else{
				//预定日期
				var fixtime = $("#create-fix_time").val().replace(/\-/g, "")
				//退房日期
				var closetime = $("#create-close_time").val().replace(/\-/g, "")
				//入住日期
				var starttime = $("#create-start_time").val().replace(/\-/g, "")
				if (starttime >=fixtime && starttime <closetime){
					$.ajax({
						url:"putup/updateRoom.do",
						type:"post",
						data:{
							"id":$("#hiddenMoveRoomId").val(),
							"c_name":$("#create-c_name").val(),
							"c_tel":$("#create-c_tel").val(),
							"idCard":$("#create-idCard").val(),
							"start_time":$("#create-start_time").val(),
							"close_time":$("#create-close_time").val(),
							"state":$("#State").val()
						},
						dataType:"json",
						success:function (data) {
							if (data.success){
								alert("登记成功")
								$("input[name=dx]").prop("checked",false);
								pageList(1,10)
								$("#createActivityModal").modal("hide")
							} else{
								alert("登记失败")
							}
						}
					})
				} else{
					alert("入住日期不许低于预定日期/入住日期不能超过离店日期")
				}
			}

		})
		//保存关闭按钮事件
		$("#create-closeBtn").click(function () {
			$("input[name=dx]").prop("checked",false);
			$("#createActivityModal").modal("hide")
		})
		//修改按钮打开模态窗口事件
		$("#editOpenModel").click(function () {
			if($("input[name=dx]:checked").length>0){
				if($("input[name=dx]:checked").length>1){
					alert("请选择需要一条记录")
				}else{
					$.ajax({
						url:"putup/getmr.do",
						type:"post",
						data:{
							"id":$("input[name=dx]:checked").val()
						},
						dataType:"json",
						success:function (data) {
							console.log(data)
							$("#edit-roomId").val(data.roomId)
							$("#edit-roomType").val(data.roomType)
							$("#edit-roomPrice").val(data.roomPrice)
							$("#edit-state").val(data.state)
							$("#edit-c_name").val(data.c_name)
							$("#edit-fix_time").val(data.fix_time)
							$("#edit-start_time").val(data.start_time)
							$("#edit-close_time").val(data.close_time)
							$("#edit-idCard").val(data.idCard)
							$("#edit-hiddenMoveRoomId").val(data.id)
							$("#edit-c_tel").val(data.c_tel)
							$("#editActivityModal").modal("show")
						}
					})
				}
			}else{
				alert("请选择你需要登记的记录")
			}
		})
		//修改关闭按钮事件
		$("#editCloseBtn").click(function () {
			$("input[name=dx]").prop("checked",false);
			$("#editActivityModal").modal("hide")
		})
		//修改更新按钮事件
		$("#editBtn").click(function () {
			if ($("#edit-start_time").val()==''){
				alert("请输入入住日期")
			} else{
				//预定日期
				var fixtime = $("#edit-fix_time").val().replace(/\-/g, "")
				//退房日期
				var closetime = $("#edit-close_time").val().replace(/\-/g, "")
				//入住日期
				var starttime = $("#edit-start_time").val().replace(/\-/g, "")
				if (starttime >=fixtime && starttime <closetime){
					$.ajax({
						url:"putup/moveRoomUpdate.do",
						type:"post",
						data:{
							"id":$("#edit-hiddenMoveRoomId").val(),
							"c_name":$("#edit-c_name").val(),
							"c_tel":$("#edit-c_tel").val(),
							"idCard":$("#edit-idCard").val(),
							"start_time":$("#edit-start_time").val(),
							"fix_time":$("#edit-fix_time").val(),
							"close_time":$("#edit-close_time").val(),
							"state":$("#edit-state").val(),
							"roomId":$("#edit-roomId").val()
						},
						dataType:"json",
						success:function (data) {
							if (data.success){
								alert("修改成功")
								pageList(1,10)
								$("input[name=dx]").prop("checked",false);
								$("#editActivityModal").modal("hide")
							} else{
								alert("修改失败")
							}
						}
					})
				} else{
					alert("入住日期不许低于预定日期/入住日期不能超过离店日期")
				}
			}

		})
	})

	function pageList(pageNo,pageSize) {
		$.ajax({
			url:"putup/getMoveRoomFenYe.do",
			type:"post",
			data:{
				"c_name":$("#c_name").val().trim(),
				"idCard":$("#idCard").val(),
				"c_tel":$("#c_tel").val(),
				"roomId":$("#fint-roomId").val(),
				"state":$("#find-State").val(),
				"pageNo":pageNo,
				"pageSize":pageSize
			},
			dataType:"json",
			success:function (data) {
				var  html=""
				$.each(data.list,function (i,n) {
					var State = '';
					if (Number(n.state)>0){
						if (Number(n.state)==1){
							State = "已预定"
						} else if (Number(n.state)==2){
							State = "入住中"
						}
					} else{
						State="已退房"
					}
					html+='<tr class="active">'
					html+='<td><input type="checkbox" value="'+n.id+'" name="dx"/></td>'
					html+='<td>'+n.c_name+'</td>'
					html+='<td>'+n.c_tel+'</td>'
					html+='<td>'+n.idCard+'</td>'
					html+='<td>'+n.roomId+'</td>'
					html+='<td>'+n.roomType+'</td>'
					html+='<td>'+n.roomPrice+'</td>'
					html+='<td>'+n.fix_time+'</td>'
					html+='<td>'+(n.start_time==null?"未入住":n.start_time)+'</td>'
					html+='<td>'+(n.close_time==null?"未入住":n.close_time)+'</td>'
					html+='<td>'+State+'</td>'
					html+='</tr>'
				})
				$("#moveRoomList").html(html);

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
	//获取所有的房间号
	function getRoomIdAll() {
		$.ajax({
			url:"putup/selectRoomAll.do",
			type:"get",
			dataType:"json",
			success:function (data) {
				var html="<option ></option>";
				$.each(data.success,function (i,n) {
				html+='<option value="'+n.id+'">'+n.roomId+'</option>'
				})
				$("#fint-roomId").html(html)
				pageList(1,5)
			}
		})
	}
</script>
<body>
       	<!-- 创建客房入住的模态窗口 -->
	<div class="modal fade" id="createActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">详细信息</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<input type="hidden" id="hiddenMoveRoomId"/>
							<label for="create-marketActivityOwner" class="col-sm-2 control-label">房间</span></label>
							<div class="col-sm-9" style="width: 300px;">
								<input type="text" class="form-control " id="create-roomId" readonly>
							</div>
							<label for="create-startTime" class="col-sm-2 control-label">类型</label>
							<div class="col-sm-9" style="width: 300px;">
								<input type="text" class="form-control" id="create-roomType" readonly>
							</div>
						</div>

						<div class="form-group">
							<label for="create-marketActivityOwner" class="col-sm-2 control-label">姓名</span></label>
							<div class="col-sm-9" style="width: 300px;">
								<input type="text" class="form-control" id="create-c_name">
							</div>
							<label for="create-startTime" class="col-sm-2 control-label">手机号</label>
							<div class="col-sm-9" style="width: 300px;">
								<input type="text" class="form-control" id="create-c_tel">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-startTime" class="col-sm-2 control-label">入住价格</label>
							<div class="col-sm-9" style="width: 300px;">
								<input type="text" class="form-control" id="create-roomPrice" readonly>
							</div>
							<label for="create-endTime" class="col-sm-2 control-label" >预定日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" readonly id="create-fix_time">
							</div>
						</div>
                        <div class="form-group">
                            <label for="create-startTime" class="col-sm-2 control-label">身份证</label>
							<div class="col-sm-9" style="width: 300px;">
								<input type="text" class="form-control" id="create-idCard">
							</div>
                            <label for="create-cost" class="col-sm-2 control-label">入住日期</label>
                            <div class="col-sm-9" style="width: 300px;">
                                <input type="text" class="form-control time" id="create-start_time">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="create-startTime" class="col-sm-2 control-label">离店日期</label>
							<div class="col-sm-9" style="width: 300px;">
								<input type="text" class="form-control " readonly id="create-close_time">
							</div>
                            <label for="create-cost" class="col-sm-2 control-label">状态</label>
                            <div class="col-sm-9" style="width: 300px;">
                                <select class="form-control" id="State">
									<option value="1">已预定</option>
									<option value="2">入住中</option>
                                </select>
                            </div>
                        </div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" id="create-closeBtn">关闭</button>
					<button type="button" class="btn btn-primary" id="addBtn">保存</button>
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
					<h4 class="modal-title" id="myModalLabel1">详细信息修改</h4>
				</div>
				<div class="modal-body">

					<form class="form-horizontal" role="form">

						<div class="form-group">
							<input type="hidden" id="edit-hiddenMoveRoomId"/>
							<label for="create-marketActivityOwner" class="col-sm-2 control-label">房间</span></label>
							<div class="col-sm-9" style="width: 300px;">
								<input type="text" class="form-control " id="edit-roomId" readonly>
							</div>
							<label for="create-startTime" class="col-sm-2 control-label">类型</label>
							<div class="col-sm-9" style="width: 300px;">
								<input type="text" class="form-control" id="edit-roomType" readonly>
							</div>
						</div>

						<div class="form-group">
							<label for="create-marketActivityOwner" class="col-sm-2 control-label">姓名</span></label>
							<div class="col-sm-9" style="width: 300px;">
								<input type="text" class="form-control" id="edit-c_name">
							</div>
							<label for="create-startTime" class="col-sm-2 control-label">手机号</label>
							<div class="col-sm-9" style="width: 300px;">
								<input type="text" class="form-control" id="edit-c_tel">
							</div>
						</div>

						<div class="form-group">
							<label for="create-startTime" class="col-sm-2 control-label">入住价格</label>
							<div class="col-sm-9" style="width: 300px;">
								<input type="text" class="form-control" id="edit-roomPrice" readonly>
							</div>
							<label for="create-endTime" class="col-sm-2 control-label" >预定日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" readonly id="edit-fix_time">
							</div>
						</div>
						<div class="form-group">
							<label for="create-startTime" class="col-sm-2 control-label">身份证</label>
							<div class="col-sm-9" style="width: 300px;">
								<input type="text" class="form-control" id="edit-idCard">
							</div>
							<label for="create-cost" class="col-sm-2 control-label">入住日期</label>
							<div class="col-sm-9" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-start_time">
							</div>
						</div>
						<div class="form-group">
							<label for="create-startTime" class="col-sm-2 control-label">离店日期</label>
							<div class="col-sm-9" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-close_time">
							</div>
							<label for="create-cost" class="col-sm-2 control-label">状态</label>
							<div class="col-sm-9" style="width: 300px;">
								<select class="form-control" id="edit-state">
									<option value="1">已预定</option>
									<option value="2">入住中</option>
								</select>
							</div>
						</div>

					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" id="editCloseBtn">关闭</button>
					<button type="button" class="btn btn-primary" id="editBtn">更新</button>
				</div>
			</div>
		</div>
	</div>
	

	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>入住管理</h3>
			</div>
		</div>
	</div>
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">入住姓名</div>
				      <input class="form-control" type="text" id="c_name">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">身份证号</div>
				      <input class="form-control" type="text" id="idCard">
				    </div>
				  </div>


				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">手机号码</div>
					  <input class="form-control" type="text" id="c_tel" />
				    </div>
				  </div>

                  
                <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">房间号</div>
                      <select class="form-control" id="fint-roomId">

                    </select>
				    </div>
				  </div>

                  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">状态</div>
                      <select class="form-control" id="find-State">
                        <option></option>
						 <option value="1">已预定</option>
                        <option value="2">入住中</option>
                        <option value="0">已退房</option>
                      
                    </select>
				    </div>
				  </div>
				  <button type="button" class="btn btn-default" id="findBtn">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="addMoveRoomBtn"><span class="glyphicon glyphicon-plus"></span> 登记入住</button>
				  <button type="button" class="btn btn-default" data-toggle="modal" id="editOpenModel"><span class="glyphicon glyphicon-pencil"></span> 修改入住</button>
				  <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteActivityModal"><span class="glyphicon glyphicon-minus"></span> 登记退房</button>
				</div>
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" name="qx" /></td>
							<td>姓名</td>
							<td>手机号</td>
							<td>身份证</td>
							<td>房间</td>
                            <td>房型</td>
							<td>总价格</td>
							<td>预定日期</td>
                            <td>入住日期</td>
                            <td>离店日期</td>
                            <td>状态</td>
						</tr>
					</thead>
					<tbody id="moveRoomList">
						<%--<tr class="active">--%>
							<%--<td><input type="checkbox" /></td>--%>
							<%--<td>101</td>--%>
                            <%--<td>总统套房</td>--%>
							<%--<td>1090</td>--%>
							<%--<td>李四</td>--%>
                            <%--<td>34531212</td>--%>
                            <%--<td>3452342342</td>--%>
                            <%--<td>2021-02-19</td>--%>
                            <%--<td>2021-03-01</td>--%>
                            <%--<td>已退房</td>--%>
                            <%--<td>2021-01-01</td>--%>
						<%--</tr>--%>
                        <%--<tr class="active">--%>
                            <%--<td><input type="checkbox" /></td>--%>
							<%--<td>101</td>--%>
                            <%--<td>总统套房</td>--%>
							<%--<td>1090</td>--%>
							<%--<td>李四</td>--%>
                            <%--<td>34531212</td>--%>
                            <%--<td>3452342342</td>--%>
                            <%--<td>2021-02-19</td>--%>
                            <%--<td>2021-03-01</td>--%>
                            <%--<td>已退房</td>--%>
                            <%--<td>2021-01-01</td>--%>
                        <%--</tr>--%>
                        <%--<tr class="active">--%>
                            <%--<td><input type="checkbox" /></td>--%>
							<%--<td>101</td>--%>
                            <%--<td>总统套房</td>--%>
							<%--<td>1090</td>--%>
							<%--<td>李四</td>--%>
                            <%--<td>34531212</td>--%>
                            <%--<td>3452342342</td>--%>
                            <%--<td>2021-02-19</td>--%>
                            <%--<td>2021-03-01</td>--%>
                            <%--<td>已退房</td>--%>
                            <%--<td>2021-01-01</td>--%>
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