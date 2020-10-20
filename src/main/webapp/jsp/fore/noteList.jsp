<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/page/include/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>吾悦云笔记-云上的笔,随处可记</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="icon" href="${ctx}/image/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="${ctx}/layui/css/layui.css">
    <link href="${ctx}/css/fore/global.css" rel="stylesheet"/>
    <link href="${ctx}/css/fore/noteList.css" rel="stylesheet"/>
    <script>
        var ctx = "${ctx}";
    </script>
</head>
<body>
<jsp:include page="header.jsp"/>
<!-- 主体（一般只改变这里的内容） -->
<div class="blog-body">
    <!-- canvas -->
    <canvas id="canvas-banner" style="background: #393D49;"></canvas>
    <!--为了及时效果需要立即设置canvas宽高，否则就在home.js中设置-->
    <script type="text/javascript">
        var canvas = document.getElementById('canvas-banner');
        canvas.width = window.document.body.clientWidth - 10;//减去滚动条的宽度
        if (screen.width >= 992) {
            canvas.height = window.innerHeight * 1 / 3;
        } else {
            canvas.height = window.innerHeight * 2 / 7;
        }
    </script>
    <!-- 这个一般才是真正的主体内容 -->
    <div class="blog-container">
        <div class="blog-main">
            <!--左边文章列表-->
            <div class="blog-main-left">
                <div class="note"></div>
                <!--分页模块-->
                <div id="page" style="text-align: center"></div>
            </div>


            <!--右边小栏目-->
            <div class="blog-main-right">
                <div class="blog-search">
                    <form class="layui-form">
                        <div class="layui-form-item">
                            <div class="search-keywords  shadow">
                                <input type="text" id="title" placeholder="输入标题关键字搜索"
                                       autocomplete="off" class="layui-input">
                            </div>
                            <div class="search-submit  shadow">
                                <a class="search-btn" lay-submit="" lay-filter="search"><i
                                        class="layui-icon">&#xe615;</i></a>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="blog-module shadow">
                    <div class="blog-module-title">公告栏</div>
                    <dl class="footprint">
                        <jsp:include page="notice.jsp"/>
                    </dl>
                </div>
                <div class="blog-module shadow">
                    <div class="blog-module-title">最热文章</div>
                    <ul class="fa-ul blog-module-ul">
                        <div id="hotNote"></div>
                    </ul>
                </div>

            </div>
            <div class="clear"></div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>
<!-- 全局脚本 -->
<script src="${ctx}/js/fore/global.js"></script>
<!-- 本页脚本 -->
<script src="${ctx}/js/fore/noteList.js"></script>
</body>
</html>
