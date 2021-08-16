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
    <link rel="stylesheet Icon" type=" image/x-icon" href="images/hotel.png">
    <link rel="stylesheet" href="css/CommonStyle/base.css">
    <link rel="stylesheet" href="css/CommonStyle/reset.css">
    <script src="ECharts/echarts.min.js"></script>
    <title>财务统计</title>
</head>
<style>
    body{
        width: 100%;
        height: 100%;
    }
    #box{
        width: 1010px;
        height: 1010px;
        margin: 100px auto;
    }
    .title{
        width: 100%;
        height: 120px;
        float: left;
    }
    .title ul{
        width: 100%;
        height: 100%;
    }
    .title ul li{
        float: left;
        width: 33.33%;
        height: 70%;
        text-align: center;
        border-top: 1px solid gainsboro;
        border-bottom: 1px solid gainsboro;
    }
    .title ul li h2{
        font-size: 25px;
        margin-top: 7%;
    }
</style>
<script>
    $(function() {
        var myChart = echarts.init(document.getElementById('main'));
        var myChart1 = echarts.init(document.getElementById('main1'));
        $.ajax({
            url:"getInvalidOrder.do",
            type:"get",
            dataType:"json",
            success:function (data) {
                $("#shixiao").html(data.count)
                $("#sunMoney").html(data.sunMoney)
                $("#count").html(data.sum)
                var option = {
                    title: {
                        text: '失效订单',
                        subtext: '总价格'
                    },
                    xAxis: {
                        type: 'category',
                        data: data.roomType
                    },
                    tooltip: {
                        trigger: 'axis', //坐标轴触发，主要在柱状图，折线图等会使用类目轴的图表中使用
                        axisPointer: {// 坐标轴指示器，坐标轴触发有效
                            type: 'line' // 默认为直线，可选为：'line' | 'shadow'
                        },
                        formatter: '{b} : {c} <br/>'
                    },
                    yAxis: {
                        type: 'value'
                    },
                    series: [{
                        data: data.totalPrice,
                        type: 'line',
                        color: ['#37A2DA']
                    }]
                };
                // 使用刚指定的配置项和数据显示图表。
                myChart.setOption(option);
                myChart2(data.myChart2)


            }
        })
        // 基于准备好的dom，初始化echarts实例

        function myChart2(data) {
            var option1 = {
                title: {
                    text: '有效订单',
                    subtext: '总价格'
                },
                legend: {
                    top: 'bottom'
                },
                toolbox: {
                    show: true,
                    feature: {
                        mark: {show: true},
                        dataView: {show: true, readOnly: false},
                        restore: {show: true},
                        saveAsImage: {show: true}
                    }
                },
                tooltip: {//提示框组件
                    trigger: 'item', //item数据项图形触发，主要在散点图，饼图等无类目轴的图表中使用。
                    axisPointer: {
                        // 坐标轴指示器，坐标轴触发有效
                        type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
                    },
                    formatter: '{b} : {c} <br/>百分比 : {d}%' //{a}（系列名称），{b}（数据项名称），{c}（数值）, {d}（百分比）
                },
                series: [
                    {
                        name: '面积模式',
                        type: 'pie',
                        radius: [50, 250],
                        center: ['50%', '50%'],
                        roseType: 'area',
                        itemStyle: {
                            borderRadius: 8
                        },
                        data: data
                    }
                ]
            };

            myChart1.setOption(option1);

        }


    });
</script>
<body>
    <div id="box cleafix">
        <div class="title cleafix">
            <ul>
                <li><h2>酒店总盈利：<span id="sunMoney"></span></h2></li>
                <li><h2>总订单：<span id="count"></span></h2></li>
                <li><h2>失效订单：<span id="shixiao"></span></h2></li>
            </ul>
        </div>
        <div id="main" style="width: 50%;height:500px; float: left;text-align: center"></div>
        <div id="main1" style="width: 50%;height:500px;float: left"></div>
    </div>
</body>
</html>
