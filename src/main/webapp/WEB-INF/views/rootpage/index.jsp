<%@ page import="com.xiaojie.hotel.domian.Manager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + 	request.getServerPort() + request.getContextPath() + "/";
	Manager name = (Manager) session.getAttribute("manager");

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
	<title>酒店管理后台</title>
</head>
<script type="text/javascript">

	//页面加载完毕
	$(function () {

		//导航中所有文本颜色为黑色
		$(".liClass > a").css("color", "black");

		//默认选中导航菜单中的第一个菜单项
		$(".liClass:first").addClass("active");

		//第一个菜单项的文字变成白色
		$(".liClass:first > a").css("color", "white");

		//给所有的菜单项注册鼠标单击事件
		$(".liClass").click(function () {
			//移除所有菜单项的激活状态
			$(".liClass").removeClass("active");
			//导航中所有文本颜色为黑色
			$(".liClass > a").css("color", "black");
			//当前项目被选中
			$(this).addClass("active");
			//当前项目颜色变成白色
			$(this).children("a").css("color", "white");
		});


		window.open("main/index.html", "workareaFrame")

	});

</script>
<style>
	#top {
		width: 100%;
		height: 80px;
		background-color: rgb(49, 49, 49);
	}

	.ulstyle {
		position: absolute;
		top: 56px;
	}
</style>

<body>
	<!-- 我的资料 -->
	<div class="modal fade" id="myInformation" role="dialog">
		<div class="modal-dialog" role="document" style="width: 30%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">我的资料</h4>
				</div>
				<div class="modal-body">
					<div style="position: relative; left: 40px;">
						姓名：<b>张三</b><br><br>
						登录帐号：<b>zhangsan</b><br><br>
						组织机构：<b>1005，市场部，二级部门</b><br><br>
						邮箱：<b>zhangsan@bjpowernode.com</b><br><br>
						失效时间：<b>2017-02-14 10:10:10</b><br><br>
						允许访问IP：<b>127.0.0.1,192.168.100.2</b>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 修改密码的模态窗口 -->
	<div class="modal fade" id="editPwdModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 70%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">修改密码</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="oldPwd" class="col-sm-2 control-label">原密码</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="oldPwd" style="width: 200%;">
							</div>
						</div>

						<div class="form-group">
							<label for="newPwd" class="col-sm-2 control-label">新密码</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="newPwd" style="width: 200%;">
							</div>
						</div>

						<div class="form-group">
							<label for="confirmPwd" class="col-sm-2 control-label">确认密码</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="confirmPwd" style="width: 200%;">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal"
						onclick="window.location.href='../login.html';">更新</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 退出系统的模态窗口 -->
	<div class="modal fade" id="exitModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 30%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">离开</h4>
				</div>
				<div class="modal-body">
					<p>您确定要退出系统吗？</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal"
						onclick="window.location.href='../login.html';">确定</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 顶部 -->
	<div id="top">
		<div
			style="position: absolute; top: 25px; left: 20px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">
			酒店后台管理系统 &nbsp;<span style="font-size: 12px;"></span></div>
		<div style="position: absolute; top: 15px; right: 15px;">
			<ul>
				<li class="dropdown user-dropdown">
					<a href="javascript:void(0)" style="text-decoration: none; color: white;" class="dropdown-toggle"
						data-toggle="dropdown">
						<span class="glyphicon glyphicon-user" style="margin-top: 20px;">${manager.managerName}</span><span
							class="caret" style="margin-right: 20px;"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</a>
					<ul class="dropdown-menu  ulstyle">
						<li><a href="../settings/index.html"><span class="glyphicon glyphicon-wrench"></span> 系统设置</a>
						</li>
						<li><a href="javascript:void(0)" data-toggle="modal" data-target="#myInformation"><span
									class="glyphicon glyphicon-file"></span> 我的资料</a></li>
						<li><a href="javascript:void(0)" data-toggle="modal" data-target="#editPwdModal"><span
									class="glyphicon glyphicon-edit"></span> 修改密码</a></li>
						<li><a href="javascript:void(0);" data-toggle="modal" data-target="#exitModal"><span
									class="glyphicon glyphicon-off"></span> 退出</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>

	<!-- 中间 -->
	<div id="center" style="position: absolute;top: 53px; bottom: 30px; left: 0px; right: 0px;">

		<!-- 导航 -->
		<div id="navigation" style="top:27px;left: 0px; width: 18%; position: relative; height: 100%; overflow:auto;">

			<ul id="no1" class="nav nav-pills nav-stacked">
				<li class="liClass"><a href="main/index.html" target="workareaFrame"><span
							class="glyphicon glyphicon-home"></span> 工作台</a></li>
				<li class="liClass">
					<a href="#n1" class="collapsed" data-toggle="collapse"><span
							class="glyphicon glyphicon-tag"></span> 房间管理</a>
					<ul id="n1" class="nav nav-pills nav-stacked collapse">
						<li class="liClass"><a href="tofloor.do"
								target="workareaFrame">&nbsp;&nbsp;&nbsp;<span
									class="glyphicon glyphicon-chevron-right"></span> 楼层管理</a></li>
						<li class="liClass"><a href="toroommanagement.do"
								target="workareaFrame">&nbsp;&nbsp;&nbsp;<span
									class="glyphicon glyphicon-chevron-right"></span> 房间管理</a></li>
					</ul>
				</li>
				<li class="liClass">
					<a href="#no2" class="collapsed" data-toggle="collapse"><span
							class="glyphicon glyphicon-time"></span> 住宿管理</a>
					<ul id="no2" class="nav nav-pills nav-stacked collapse">
						<li class="liClass"><a href="putup/toputupbook.do"
								target="workareaFrame">&nbsp;&nbsp;&nbsp;<span
									class="glyphicon glyphicon-chevron-right"></span> 客房预定</a></li>
						<li class="liClass"><a href="putup/toHotelRegistraTion.do"
								target="workareaFrame">&nbsp;&nbsp;&nbsp;<span
									class="glyphicon glyphicon-chevron-right"></span> 住宿登记</a></li>
					</ul>
				</li>
				<li class="liClass">
					<a href="#no3" class="collapsed" data-toggle="collapse"><span
							class="glyphicon glyphicon-usd"></span> 财务管理</a>

					<ul id="no3" class="nav nav-pills nav-stacked collapse">
						<li class="liClass"><a href="chart/activity/index.html"
								target="workareaFrame">&nbsp;&nbsp;&nbsp;<span
									class="glyphicon glyphicon-chevron-right"></span> 财务统计</a></li>
					</ul>
				</li>
				<li class="liClass">
					<a href="#no4" class="collapsed" data-toggle="collapse"><span
							class="glyphicon glyphicon-user"></span> 用户管理</a>

					<ul id="no4" class="nav nav-pills nav-stacked collapse">
						<li class="liClass"><a href="./userlist/userlist.html"
								target="workareaFrame">&nbsp;&nbsp;&nbsp;<span
									class="glyphicon glyphicon-chevron-right"></span> 用户列表</a></li>
					</ul>
				</li>
				<li class="liClass">
					<a href="#no5" class="collapsed" data-toggle="collapse"><span
							class="glyphicon glyphicon-user"></span> 客户管理</a>

					<ul id="no5" class="nav nav-pills nav-stacked collapse">
						<li class="liClass"><a href="chart/activity/index.html"
								target="workareaFrame">&nbsp;&nbsp;&nbsp;<span
									class="glyphicon glyphicon-chevron-right"></span> 客户列表</a></li>
					</ul>
				</li>

			</ul>

			<!-- 分割线 -->
			<div id="divider1"
				style="position: absolute; top : 0px; right: 0px; width: 1px; height: 100% ; background-color: #B3B3B3;">
			</div>
		</div>

		<!-- 工作区 -->
		<div id="workarea" style="position: absolute; top : 27px; left: 18%; width: 82%; height: 100%;">
			<iframe style="border-width: 0px; width: 100%; height: 100%;" name="workareaFrame"></iframe>
		</div>

	</div>

	<div id="divider2" style="height: 1px; width: 100%; position: absolute;bottom: 30px; background-color: #B3B3B3;">
	</div>

	<!-- 底部 -->
	<div id="down" style="height: 30px; width: 100%; position: absolute;bottom: 0px;"></div>

</body>

</html>