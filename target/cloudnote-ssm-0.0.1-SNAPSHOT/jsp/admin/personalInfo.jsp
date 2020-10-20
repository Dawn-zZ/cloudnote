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
    <style type="text/css">
        .layui-input-inline {
            padding: 6px 0px;
        }
    </style>
</head>

<body>
    <div class="layui-card-body" pad15="">
            <div class="layui-form-item">
                <label class="layui-form-label">用户名：</label>
                <div class="layui-input-inline">
                    <span>${admin.username }</span>
                </div>
            </div>
            <input type="hidden" name="image" class="image" value="${admin.image}">
            <div class="layui-form-item">
                <label class="layui-form-label ">头像：</label>
                <img class="layui-upload-img" id="demo1" src="${admin.image}"
                             width="80px" height="80px">

            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">昵称：</label>
                <div class="layui-input-inline">
                    <span>${admin.nickname }</span>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">性别：</label>
                <div class="layui-input-inline">
                    <c:if test="${admin.sex==0 }">
                        <span>女</span>
                    </c:if>
                    <c:if test="${admin.sex==1 }">
                        <span>男</span>
                    </c:if>
                    <c:if test="${admin.sex==2 }">
                        <span>保密</span>
                    </c:if>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">手机：</label>
                <div class="layui-input-inline">
                    <span>${admin.phone }</span>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">邮箱：</label>
                <div class="layui-input-inline">
                    <span>${admin.email }</span>
                </div>
                <button type="button" id="replaceEmail" class="layui-btn layui-btn-warm">点击换绑</button>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">签名：</label>
                <div class="layui-input-inline">
                    <span>${admin.note }</span>
                </div>
            </div>
            <div class="layui-card-header"></div>
            <div class="layui-card-body" pad12="6">
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button type="button" id="updateInfo" class="layui-btn">修改信息</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
<script type="text/javascript" src="${ctx }/layui/layui.js"></script>
    <script type="text/javascript" src="${ctx }/js/admin/personalInfo.js"></script>
</body>

</html>