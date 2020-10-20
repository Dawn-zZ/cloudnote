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
    <link rel="stylesheet"
          href="${ctx}/layui/css/layui.css">
    <script>
        var ctx = "${ctx}";
    </script>
</head>

<body>
<div class="layui-card-body" pad15="">
    <form class="layui-form">
        <input type="hidden" name="id" value="${admin.id }"/>
        <input type="hidden" name="roleId" value="${admin.roleId }"/>
        <input type="hidden" name="email" value="${admin.email }"/>
        <input type="hidden" name="status" value="${admin.status}"/>
        <input type="hidden" name="isAdmin" value="${admin.isAdmin}"/>
        <div class="layui-form-item">
            <label class="layui-form-label">用户名:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" name="username"
                       value="${admin.username }" disabled="disabled"/>
            </div>
        </div>
        <input type="hidden" name="image" class="image" value="${admin.image}">
        <div class="layui-form-item">
            <label class="layui-form-label ">头像</label>
            <div class="layui-upload">
                <button type="button" class="layui-btn" id="test1">修改头像</button>
                <div class="layui-upload-list">
                    <label class="layui-form-label "></label>
                    <img class="layui-upload-img" id="demo1" src="${admin.image}"
                         width="80px" height="80px">
                </div>
                <label class="layui-form-label"></label>
                <p id="demoText"></p>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">昵称</label>
            <div class="layui-input-inline">
                <input type="text" name="nickname" value="${admin.nickname }"
                       lay-verify="nickname" autocomplete="off" placeholder="请输入昵称"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-block">
                <c:if test="${admin.sex==0 }">
                    <input type="radio" name="sex" value="1" title="男">
                    <input type="radio" name="sex" value="0" title="女" checked>
                    <input type="radio" name="sex" value="2" title="保密">
                </c:if>
                <c:if test="${admin.sex==1 }">
                    <input type="radio" name="sex" value="1" title="男" checked>
                    <input type="radio" name="sex" value="0" title="女">
                    <input type="radio" name="sex" value="2" title="保密">
                </c:if>
                <c:if test="${admin.sex==2 }">
                    <input type="radio" name="sex" value="1" title="男">
                    <input type="radio" name="sex" value="0" title="女">
                    <input type="radio" name="sex" value="2" title="保密" checked>
                </c:if>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">手机</label>
            <div class="layui-input-inline">
                <input type="text" name="phone" value="${admin.phone }"
                       lay-verify="required|phone" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">签名</label>
            <div class="layui-input-block">
                <textarea name="note" class="layui-textarea" placeholder="请输入个人签名">${admin.note }</textarea>
            </div>
        </div>
        <div class="layui-card-header"></div>
        <div class="layui-card-body" pad12="6">
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="updateAdmin">确认修改</button>
                </div>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript" src="${ctx }/layui/layui.js"></script>
<script type="text/javascript" src="${ctx }/js/admin/updateAdmin.js"></script>
</body>

</html>
