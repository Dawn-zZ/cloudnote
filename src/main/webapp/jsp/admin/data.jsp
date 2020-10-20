<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/page/include/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${ctx}/layui/css/layui.css"/>
    <script>
        <%--JS gloable varilible--%>
        var ctx = "${ctx}";
    </script>
    <style>
        .layui-top-box {
            padding: 40px 20px 20px 20px;
            color: #fff
        }

        .panel {
            margin-bottom: 17px;
            background-color: #fff;
            border: 1px solid transparent;
            border-radius: 3px;
            -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
            box-shadow: 0 1px 1px rgba(0, 0, 0, .05)
        }

        .panel-body {
            padding: 15px
        }

        .panel-title {
            margin-top: 0;
            margin-bottom: 0;
            font-size: 14px;
            color: inherit
        }

        .label {
            display: inline;
            padding: .2em .6em .3em;
            font-size: 75%;
            font-weight: 700;
            line-height: 1;
            color: #fff;
            text-align: center;
            white-space: nowrap;
            vertical-align: baseline;
            border-radius: .25em;
            margin-top: .3em;
        }

        .layui-red {
            color: red
        }

        .main_btn > p {
            height: 40px;
        }

        .pull-right {
            float: right;
        }
    </style>
</head>

<body>

<div class="layuimini-container">
    <div class="layuimini-main layui-top-box">
        <div class="layui-row layui-col-space10">

            <div class="layui-col-md3">
                <div class="col-xs-6 col-md-3">
                    <div class="panel layui-bg-cyan">
                        <div class="panel-body">
                            <div class="panel-title">
                                <span class="label pull-right layui-bg-blue">实时</span>
                                <h5>用户统计</h5>
                            </div>
                            <div class="panel-content">
                                <h1 class="no-margins">${data.usercount}</h1>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="layui-col-md3">
                <div class="col-xs-6 col-md-3">
                    <div class="panel layui-bg-blue">
                        <div class="panel-body">
                            <div class="panel-title">
                                <span class="label pull-right layui-bg-cyan">实时</span>
                                <h5>公开笔记统计</h5>
                            </div>
                            <div class="panel-content">
                                <h1 class="no-margins">${data.notecount}</h1>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="layui-col-md3">
                <div class="col-xs-6 col-md-3">
                    <div class="panel layui-bg-green">
                        <div class="panel-body">
                            <div class="panel-title">
                                <span class="label pull-right layui-bg-orange">实时</span>
                                <h5>浏览量统计</h5>
                            </div>
                            <div class="panel-content">
                                <h1 class="no-margins">${data.viewcount}</h1>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-col-md3">
                <div class="col-xs-6 col-md-3">
                    <div class="panel layui-bg-orange">
                        <div class="panel-body">
                            <div class="panel-title">
                                <span class="label pull-right layui-bg-green">实时</span>
                                <h5>登录统计</h5>
                            </div>
                            <div class="panel-content">
                                <h1 class="no-margins">${data.logcount}</h1>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="layui-col-md6">
        <div class="layui-card">
            <div class="layui-card-header">ECharts</div>
            <div class="layui-card-body">
                <div id="container1" style="height:350px;"></div>
            </div>
        </div>
    </div>
    <div class="layui-col-md6">
        <div class="layui-card">
            <div class="layui-card-header">ECharts</div>
            <div class="layui-card-body">
                <div id="main" style="height:350px;"></div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.bootcss.com/echarts/4.1.0.rc2/echarts.min.js"></script>
<script type="text/javascript" src="${ctx}/layui/layui.js"></script>
<script>
    layui.use(['jquery'], function () {
        var $ = layui.jquery,
            layer = layui.layer;

        var intervalIndex = setInterval(function () {
            if (echarts === undefined) {
                return;
            }
            // 如果eacharts加载完成，则清除循环
            clearInterval(intervalIndex);
            //echarts
            // 基于准备好的dom，初始化echarts实例
            var myChart = echarts.init(document.getElementById('main'));
            // 指定图表的配置项和数据
            var option = {
                title: {
                    text: '数量统计'
                },
                tooltip: {},
                legend: {
                    data: ['总量']
                },
                xAxis: {
                    data: ["用户量", "公开笔记", "浏览量", "登录次数"]
                },
                yAxis: {},
                series: [{
                    name: '总量',
                    type: 'bar',
                    data: [${data.usercount}, ${data.notecount}, ${data.viewcount}, ${data.logcount}]
                }]
            };
            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option);

            // echarts 1
            var myChart1 = echarts.init(document.getElementById("container1"));
            var app1 = {};
            option1 = null;
            app1.title = '极坐标系下的堆叠柱状图';

            option1 = {
                title: {
                    text: '用户笔记类型统计',
                    subtext: '数据来自吾悦云笔记后台',
                    x: 'center'
                },
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                legend: {
                    orient: 'vertical',
                    left: 'left',
                    data: ['公开', '私密']
                },
                series: [{
                    name: '访问来源',
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '60%'],
                    data: [{
                        value: ${data.opencount},
                        name: '公开'
                    }, {
                        value: ${data.closecount},
                        name: '私密'
                    }],
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }]
            };
            if (option1 && typeof option1 === "object") {
                myChart1.setOption(option1, true);
            }

            $(window).on('resize', function () {
                myChart.resize();
                myChart1.resize();
            });
        }, 50);
    });
</script>
<style scoped/>
</body>
</html>
