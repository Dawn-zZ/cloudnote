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
<blockquote class="layui-elem-quote news_search">
    <form class="layui-form">
        <div class="layui-inline">
            <div class="layui-input-inline">
                <input type="text" id="noteTitle" value="" placeholder="请输入标题"
                       class="layui-input search_input ">
            </div>
            <a style="margin-left: 10px" class="layui-btn search_btn" lay-submit="" data-type="search"
               lay-filter="search">查询</a>
        </div>
    </form>
</blockquote>
    <div class="layui-form">
        <table id="noteList" lay-filter="noteList"></table>
    </div>
<script type="text/html" id="uploadTpl">
    {{#  if(d.uploadStatus == 100){ }}
    <span style="color: darkgray;">草稿</span>
    {{#  } else if(d.uploadStatus == 101){ }}
    <span style="color: green;">已发布</span>
    {{#  } }}
</script>
<script type="text/html" id="checkTpl">
    {{#  if(d.checkStatus == 100){ }}
    <span style="color: darkgray;">待审核</span>
    {{#  } else if(d.checkStatus == 101){ }}
    <span style="color: green;">审核通过</span>
    {{#  } else if(d.checkStatus == -1){ }}
    <span style="color: red;">审核不通过</span>
    {{#  } }}
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-sm" lay-event="look">
        查看
    </a>
    <a class="layui-btn layui-btn-sm layui-btn-danger" lay-event="delete">
        删除
    </a>
</script>
<script type="text/javascript" src="${ctx }/layui/layui.js"></script>
<script type="text/javascript" src="${ctx }/js/note/noteList.js"></script>
</body>

</html>
