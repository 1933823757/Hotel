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
    <script src="bootstrap-fileinput/fileinput.min.js"></script>
    <script src="bootstrap-fileinput/zh.js"></script>
    <link rel="stylesheet" href="bootstrap-fileinput/fileinput.min.css">
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
        $(".myfile").fileinput({
            uploadUrl: "text.html", //接受请求地址
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
            maxFileCount: 3, //表示允许同时上传的最大文件个数
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
            console.log("文件上传错误"+data);
        });

        //异步上传返回结果处理
        $(".myfile").on("fileuploaded", function (event, data, previewId, index) {
            console.log("fileuploaded");
            var ref = $(this).attr("data-ref");
            $("input[name='" + ref + "']").val(data.response.url);
            console.log("上传成功"+data.respone.url)

        });
    })
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

                    <form class="form-horizontal" role="form">

                        <div class="form-group">
                            <label for="create-marketActivityOwner" class="col-sm-2 control-label">房间号</span></label>
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
                        <div class="form-group">
                            <label for="create-marketActivityOwner" class="col-sm-2 control-label">房间价格</span></label>
                            <div class="col-sm-9" style="width: 300px;">
                                <input type="text" class="form-control" id="name">
                            </div>
                            <label for="create-marketActivityName" class="col-sm-2 control-label">房间图片</span></label>
                            <div class="col-sm-9" style="width: 300px;">
                                <input type="file" class="myfile">
                            </div>

                        </div>
                        <div class="form-group">
                            <label for="create-marketActivityOwner" class="col-sm-2 control-label">房间介绍</span></label>
                            <div class="col-sm-9" style="width: 600px;">
                                <textarea class="form-control" rows="3"></textarea>
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
                    <h4 class="modal-title" id="myModalLabel1">修改房间</h4>
                </div>
                <div class="modal-body">

                    <form class="form-horizontal" role="form">

                        <div class="form-group">
                            <label for="create-marketActivityOwner" class="col-sm-2 control-label">房间号</span></label>
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
                        <div class="form-group">
                            <label for="create-marketActivityOwner" class="col-sm-2 control-label">房间价格</span></label>
                            <div class="col-sm-9" style="width: 300px;">
                                <input type="text" class="form-control" id="name">
                            </div>
                            <label for="create-marketActivityName" class="col-sm-2 control-label">房间图片</span></label>
                            <div class="col-sm-9" style="width: 300px;">
                                <input type="file" class="myfile">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="create-marketActivityOwner" class="col-sm-2 control-label">房间介绍</span></label>
                            <div class="col-sm-9" style="width: 600px;">
                                <textarea class="form-control" rows="3"></textarea>
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
            <div class="btn-toolbar" role="toolbar"
                style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
                <div class="btn-group" style="position: relative; top: 18%;">
                    <button type="button" class="btn btn-primary" data-toggle="modal"
                        data-target="#createActivityModal"><span class="glyphicon glyphicon-plus"></span> 创建房间</button>
                    <button type="button" class="btn btn-default" data-toggle="modal"
                        data-target="#editActivityModal"><span class="glyphicon glyphicon-pencil"></span> 修改房间</button>
                    <button type="button" class="btn btn-danger" data-toggle="modal"
                        data-target="#deleteActivityModal"><span class="glyphicon glyphicon-minus"></span> 删除房间</button>
                </div>

            </div>
            <div>
                <table class=" table-hover">
                    <thead>
                        <tr style="color: #B3B3B3;">
                            <td><input type="checkbox" /></td>
                            <td>房间号</td>
                            <td>房型</td>
                            <td>价格</td>
                            <td>房间介绍</td>
                            <td>房间图片</td>
                        </tr>
                    </thead>
                    <tbody class="tbody-list">
                        <tr class="active text-nowrap">
                            <td><input type="checkbox" /></td>
                            <td>101</td>
                            <td>总统套房</td>
                            <td>2342</td>
                            <td><span>非常不错good，建议预定</span></td>
                            <td><img src="images/room-img2.jpg" alt="" class="img-rounded"
                                    style="width: 50px; height: 50px;">
                                <img src="images/room-img2.jpg" alt="" class="img-rounded"
                                    style="width: 50px; height: 50px;">
                                <img src="images/room-img2.jpg" alt="" class="img-rounded"
                                    style="width: 50px; height: 50px;">
                            </td>
                        </tr>
                        <tr class="active text-nowrap">
                            <td><input type="checkbox" /></td>
                            <td>101</td>
                            <td>总统套房</td>
                            <td>2342</td>
                            <td><span>非常不错good，建议预定</span></td>
                            <td><img src="images/room-img2.jpg" alt="" class="img-rounded"
                                    style="width: 50px; height: 50px;">
                                <img src="images/room-img2.jpg" alt="" class="img-rounded"
                                    style="width: 50px; height: 50px;">
                                <img src="images/room-img2.jpg" alt="" class="img-rounded"
                                    style="width: 50px; height: 50px;">
                            </td>
                        </tr>
                        <tr class="active text-nowrap">
                            <td><input type="checkbox" /></td>
                            <td>101</td>
                            <td>总统套房</td>
                            <td>2342</td>
                            <td><span>非常不错good，建议预定</span></td>
                            <td><img src="images/room-img2.jpg" alt="" class="img-rounded"
                                    style="width: 50px; height: 50px;">
                                <img src="images/room-img2.jpg" alt="" class="img-rounded"
                                    style="width: 50px; height: 50px;">
                                <img src="images/room-img2.jpg" alt="" class="img-rounded"
                                    style="width: 50px; height: 50px;">
                            </td>
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