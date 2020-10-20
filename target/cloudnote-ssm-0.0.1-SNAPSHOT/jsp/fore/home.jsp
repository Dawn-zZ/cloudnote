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
    <link href="${ctx}/css/fore/home.css" rel="stylesheet"/>
    <script>
        var ctx = "${ctx}";
    </script>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="header">
    <div class="container">
        <h2>云上的笔，随处可记</h2>
        <s></s>
        <br/> <br/> <br/>
        <div class="container">
            <a href="${ctx}/admin/person">
                <button type="button" class="fa-btn btn-1 btn-1e " id="testList">记录生活</button>
            </a>
        </div>
    </div>
</div>
<div class="introduct" id="arrow">
    <div class="container">
        <h2>为什么要创建云笔记呢</h2>
        <span> </span>
        <p>不论什么情况下，你随时都有才思突现，灵感袭来的时刻，俗话说：好记性不如烂笔头，可是我们身边又没有可以记录的工具怎么办？
            而云笔记，云上的笔，随处可记！随时记录你的精彩生活。</p>
    </div>
</div>

<jsp:include page="footer.jsp"/>
<script src="${ctx}/js/fore/global.js"></script>
</body>
</html>
