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
    <title>楼层管理</title>
</head>
<body>
    <!-- 创建楼层的模态窗口 -->
<div class="modal fade" id="createActivityModal" role="dialog">
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
                     <label for="create-marketActivityOwner" class="col-sm-2 control-label">楼层号</span></label>
                     <div class="col-sm-9" style="width: 300px;">
                         <input type="text" class="form-control" id="name">
                     </div>
                     <label for="create-marketActivityName" class="col-sm-2 control-label">房型</span></label>
                     <div class="col-sm-9" style="width: 300px;">
                         <select class="form-control">
                             <option></option>
                             <option>普通单间</option>
                             <option>普通双人间</option>
                             <option>豪华大床房</option>
                             <option>豪华双人间</option>
                             <option>总统套房</option>
                             <option>商务房</option>
                         </select>
                     </div>
                 </div>
                 

             </form>
             
         </div>
         <div class="modal-footer">
             <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
             <button type="button" class="btn btn-primary" data-dismiss="modal">保存</button>
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
                    <label for="create-marketActivityOwner" class="col-sm-2 control-label">楼层号</span></label>
                    <div class="col-sm-9" style="width: 300px;">
                        <input type="text" class="form-control" id="name">
                    </div>
                    <label for="create-marketActivityName" class="col-sm-2 control-label">房型</span></label>
                    <div class="col-sm-9" style="width: 300px;">
                        <select class="form-control">
                            <option></option>
                            <option>普通单间</option>
                            <option>普通双人间</option>
                            <option>豪华大床房</option>
                            <option>豪华双人间</option>
                            <option>总统套房</option>
                            <option>商务房</option>
                        </select>
                    </div>
                </div>
            </form>
             
         </div>
         <div class="modal-footer">
             <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
             <button type="button" class="btn btn-primary" data-dismiss="modal">更新</button>
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
               <input class="form-control" type="text">
             </div>
           </div>
           
         <div class="form-group">
             <div class="input-group">
               <div class="input-group-addon">客房类型</div>
               <select class="form-control">
                 <option></option>
                 <option>普通单间</option>
                 <option>普通双人间</option>
                 <option>豪华大床房</option>
                 <option>豪华双人间</option>
                 <option>总统套房</option>
                 <option>商务房</option>
             </select>
             </div>
           </div>
           <button type="submit" class="btn btn-default">查询</button>
           
         </form>
     </div>
     <div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
         <div class="btn-group" style="position: relative; top: 18%;">
           <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createActivityModal"><span class="glyphicon glyphicon-plus"></span> 创建楼层</button>
           <button type="button" class="btn btn-default" data-toggle="modal" data-target="#editActivityModal"><span class="glyphicon glyphicon-pencil"></span> 修改楼层</button>
           <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteActivityModal"><span class="glyphicon glyphicon-minus"></span> 删除楼层</button>
         </div>
         
     </div>
     <div style="position: relative;top: 10px;">
         <table class="table table-hover">
             <thead>
                 <tr style="color: #B3B3B3;">
                     <td><input type="checkbox" /></td>
                     <td>楼层号</td>
                     <td>房型</td>
                     <td>价格</td>
                     <td>总房间数</td>
                 </tr>
             </thead>
             <tbody>
                 <tr class="active">
                     <td><input type="checkbox" /></td>
                     <td>1</td>
                     <td>101</td>
                     <td>普通单间</td>
                     <td>234</td>
                     <td>20</td>
                 </tr>
                 <tr class="active">
                    <td><input type="checkbox" /></td>
                    <td>1</td>
                    <td>101</td>
                    <td>普通单间</td>
                    <td>234</td>
                    <td>20</td>
                 </tr>
                 <tr class="active">
                    <td><input type="checkbox" /></td>
                    <td>1</td>
                    <td>101</td>
                    <td>普通单间</td>
                    <td>234</td>
                    <td>20</td>
                 </tr>
             </tbody>
         </table>
     </div>
     
     <div style="height: 50px; position: relative;top: 30px;">
         <div>
             <button type="button" class="btn btn-default" style="cursor: default;">共<b>50</b>条记录</button>
         </div>
         <div class="btn-group" style="position: relative;top: -34px; left: 110px;">
             <button type="button" class="btn btn-default" style="cursor: default;">显示</button>
             <div class="btn-group">
                 <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                     10
                     <span class="caret"></span>
                 </button>
                 <ul class="dropdown-menu" role="menu">
                     <li><a href="#">20</a></li>
                     <li><a href="#">30</a></li>
                 </ul>
             </div>
             <button type="button" class="btn btn-default" style="cursor: default;">条/页</button>
         </div>
         <div style="position: relative;top: -88px; left: 285px;">
             <nav>
                 <ul class="pagination">
                     <li class="disabled"><a href="#">首页</a></li>
                     <li class="disabled"><a href="#">上一页</a></li>
                     <li class="active"><a href="#">1</a></li>
                     <li><a href="#">2</a></li>
                     <li><a href="#">3</a></li>
                     <li><a href="#">4</a></li>
                     <li><a href="#">5</a></li>
                     <li><a href="#">下一页</a></li>
                     <li class="disabled"><a href="#">末页</a></li>
                 </ul>
             </nav>
         </div>
     </div>
     
 </div>
 
</div>
</body>
</html>