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
                <input type="text" id="nickname" value="" placeholder="请输入昵称"
                       class="layui-input search_input ">
            </div>
            <div class="layui-input-inline" style="margin-left: 10px">
                <select name="sex" class="" id="sex">
                    <option value="-1">请选择性别</option>
                    <option value="1">男</option>
                    <option value="0">女</option>
                    <option value="2">保密</option>
                </select>
            </div>
            <div class="layui-input-inline" style="margin-left: 10px">
                <select name="status" class="" id="status">
                    <option value="-1">请选择用户状态</option>
                    <option value="100">禁用</option>
                    <option value="101">正常</option>
                </select>
        </div>
        <div style="margin-top: 1%">
            <div class="layui-inline">
                <input type="text" id="createTimeStart" class="layui-input"
                       name="createTimeStart" placeholder="创建时间(开始)" value="">
            </div>
            -
            <div class="layui-inline">
                <input type="text" id="createTimeEnd" class="layui-input"
                       name="createTimeEnd" placeholder="创建时间(结束)" value="">
            </div>
            <a style="margin-left: 10px" class="layui-btn search_btn" lay-submit="" data-type="search"
               lay-filter="search">查询</a>
        </div>
        </div>
    </form>
</blockquote>
        <table id="userList" lay-filter="userList"></table>
<script type="text/html" id="sexTpl">
    {{#  if(d.sex == 0){ }}
    <span style="color: #F581B1;">女</span>
    {{#  } else if(d.sex == 1){ }}
    <span style="color: #1e9fff;">男</span>
    {{#  } else{ }}
    <span style="color: #08f55f;">保密</span>
    {{#  } }}
</script>
<script type="text/html" id="statusTpl">
    <input type="checkbox" name="status" value="{{d.id}}" lay-skin="switch" lay-text="正常|禁用" lay-filter="statusSwitch"
           {{ d.status== 101 ? 'checked' : '' }}>
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">
        编辑
    </a>
    <a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete">
        删除
    </a>
</script>
<script type="text/javascript" src="${ctx }/layui/layui.js"></script>
<script type="text/javascript" src="${ctx }/js/user/userList.js"></script>
</body>

</html>
