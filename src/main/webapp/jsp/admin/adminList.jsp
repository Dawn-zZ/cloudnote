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
    <link rel="stylesheet" href="${ctx }/layui/css/layui.css" media="all"/>
    <link rel="stylesheet" href="${ctx }/css/font_eolqem241z66flxr.css"
          media="all"/>
    <link rel="stylesheet" href="${ctx }/css/list.css" media="all"/>
    <script>
        var ctx = "${ctx}";
    </script>
</head>
<body class="childrenBody">
<input type="hidden" id="adminId"
       value="${admin.id }"/>
<blockquote class="layui-elem-quote list_search" id="Block">
    <div class="layui-inline">
        <a class="layui-btn layui-btn-normal adminAdd_btn"><i
                class="layui-icon">&#xe608;</i> 添加管理员</a>
    </div>
</blockquote>
    <table id="adminList" lay-filter="test"></table>
<script type="text/javascript" src="${ctx }/layui/layui.js"></script>
<script type="text/javascript" src="${ctx }/js/admin/adminList.js"></script>
<script type="text/html" id="barEdit">
    <a class="layui-btn layui-btn-xs" lay-event="edit">
        编辑
    </a>
    <a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">
        删除
    </a>
</script>
<script type="text/html" id="sexTpl">
    {{#  if(d.sex == 0){ }}
    <span style="color: #F581B1;">女</span>
    {{#  } else if(d.sex == 1){ }}
    <span style="color: #1e9fff;">男</span>
    {{#  } else{ }}
    <span style="color: #08f55f;">保密</span>
    {{#  } }}
</script>
</body>
</html>