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
    <script>
        var ctx = "${ctx}";
    </script>
    <style type="text/css">
        .layui-form-item .layui-inline {
            width: 33.333%;
            float: left;
            margin-right: 0;
        }

        @media ( max-width: 1240px) {
            .layui-form-item .layui-inline {
                width: 100%;
                float: none;
            }
        }
    </style>
</head>
<body class="childrenBody">
<br/>
<form class="layui-form" style="width: 80%;">
    <!-- 管理员id -->
    <input type="hidden" name="id" value="${ad.id }"/>
    <div class="layui-form-item">
        <label class="layui-form-label">用户名</label>
        <div class="layui-input-block">
            <input type="text" id="username" class="layui-input"
                   lay-verify="required" readonly="readonly" name="username" value="${ad.username }">
        </div>
    </div>
    <input type="hidden" name="image" class="image" value="${ad.image}">
    <div class="layui-form-item">
        <label class="layui-form-label ">头像</label>
        <div class="layui-upload">
            <button type="button" class="layui-btn" id="test1">上传图片</button>
            <div class="layui-upload-list">
                <label class="layui-form-label "></label>
                <img class="layui-upload-img" id="demo1" src="${ad.image}" width="80px"
                     height="80px">
            </div>
            <label class="layui-form-label"></label>
            <p id="demoText"></p>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">昵称</label>
        <div class="layui-input-block">
            <input type="text" name="nickname" class="layui-input"
                   lay-verify="required" placeholder="请输入昵称" value="${ad.nickname }">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">邮箱</label>
        <div class="layui-input-block">
            <input type="text" name="email" id="email" class="layui-input"
                   lay-verify="email" placeholder="请输入邮箱" value="${ad.email }">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">性别</label>
        <div class="layui-input-block">
            <c:if test="${ad.sex==0 }">
                <input type="radio" name="sex" value="1" title="男">
                <input type="radio" name="sex" value="0" title="女" checked>
                <input type="radio" name="sex" value="2" title="保密">
            </c:if>
            <c:if test="${ad.sex==1}">
                <input type="radio" name="sex" value="1" title="男" checked>
                <input type="radio" name="sex" value="0" title="女">
                <input type="radio" name="sex" value="2" title="保密">
            </c:if>
            <c:if test="${ad.sex==2}">
                <input type="radio" name="sex" value="1" title="男">
                <input type="radio" name="sex" value="0" title="女">
                <input type="radio" name="sex" value="2" title="保密" checked>
            </c:if>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">手机号</label>
        <div class="layui-input-block">
            <input type="text" name="phone" class="layui-input"
                   lay-verify="phone" placeholder="请输入手机号" value="${ad.phone }">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">分配角色</label>
        <div class="layui-input-block">
            <select name="roleId">
                <option value="">请选择</option>
                <c:forEach items="${roles }" var="r">
                    <c:if test="${r.roleId!=21}">
                        <c:if test="${ad.roleId==r.roleId }">
                            <option value="${r.roleId }" selected>${r.roleName }</option>
                        </c:if>
                        <c:if test="${ad.roleId!=r.roleId }">
                            <option value="${r.roleId }">${r.roleName }</option>
                        </c:if>
                    </c:if>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">签名</label>
        <div class="layui-input-block">
            <textarea name="note" class="layui-textarea" placeholder="请输入个人签名">${ad.note }</textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="" lay-filter="updAdmin">立即保存</button>
        </div>
    </div>
</form>
<script type="text/javascript" src="${ctx }/layui/layui.js"></script>
<script type="text/javascript" src="${ctx }/js/admin/editAdmin.js"></script>
</body>
</html>