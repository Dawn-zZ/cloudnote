<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/page/include/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="stylesheet" href="${ctx}/layui/css/layui.css">
    <link rel="stylesheet" href="${ctx }/css/list.css" media="all"/>
    <link rel="stylesheet" href="${ctx }/css/font_eolqem241z66flxr.css"
          media="all"/>
    <script>
        var ctx = "${ctx}";
    </script>
</head>
<body class="childrenBody">
    <form class="layui-form">
        <div class="layui-inline">
            <select name="isLeaveMess" class="" id="isLeaveMess">
                <option value="-1">请选择类别</option>
                <option value="101">留言</option>
                <option value="100">评论</option>
            </select>
        </div>
        <a style="margin-left: 10px" class="layui-btn search_btn" lay-submit="" data-type="search"
           lay-filter="search">查询</a>
    </form>
<table id="remarkList" lay-filter="remarkList"></table>
<script type="text/html" id="sexTpl">
    {{#  if(d.isLeaveMess == 100){ }}
    <span style="color: #F581B1;">评论</span>
    {{#  } else if(d.isLeaveMess == 101){ }}
    <span style="color: #1e9fff;">留言</span>
    {{#  } }}
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete">
        删除
    </a>
</script>
<script type="text/javascript" src="${ctx }/layui/layui.js"></script>
<script type="text/javascript" src="${ctx }/js/admin/selfRemarkList.js"></script>
</body>

</html>
