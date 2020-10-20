<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/page/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link href="${ctx}/css/fore/prettify.css" rel="stylesheet" />
    <style>
        .title,.info {
            text-align: center;
        }
        /*代码区域*/
        pre {
            background-color: #f5f5f5 !important;
            border-radius: 0px !important;
            border: 1px solid #ccc !important;
            font-size: 13px !important;
        }
    </style>
</head>
<body>
<div>
    <div class="title">
        <h1>${note.title}</h1>
    </div>
    <div class="info">
        <span>编辑时间：<fmt:formatDate value="${note.createTime}" type="both"/></span>
        <span>作者：${note.author}</span>
        <span>浏览量：${note.viewNum}</span>
    </div>
    <div class="content">
        ${note.content}
    </div>
</div>
<script src="${ctx}/js/fore/prettify.js"></script>
</body>
</html>
