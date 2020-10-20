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
          href="${ctx}/layui/css/layui.css" media="all">
    <link rel="stylesheet"
          href="${ctx}/css/step.css" media="all">
    <script>
        var ctx = "${ctx}";
    </script>
</head>

<body>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-body" style="padding-top: 40px;">
            <div class="layui-carousel" id="stepForm" lay-filter="stepForm" style="margin: 0 auto;">
                <div carousel-item>
                    <div>
                        <form class="layui-form" style="margin: 0 auto;max-width: 460px;padding-top: 40px;">
                            <input type="hidden" name="id" value="${admin.id}">
                            <div class="layui-form-item">
                                <label class="layui-form-label">邮箱确认</label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" name="email" id="email1" lay-verify="email" value="${admin.email}" />
                                    <button style="position: absolute;top: 0;right: 0px;
    cursor: pointer;" type="button" class="layui-btn layui-btn-warm" id="sendCode1">点击发送验证码</button>
                                </div>
                            </div>

                            <div class="layui-form-item">
                                <label class="layui-form-label">验证码</label>
                                <div class="layui-input-block">
                                    <input type="text" name="code" id="code1" placeholder="请填写邮箱验证码" class="layui-input" lay-verify="required" lay-reqtext="验证码不能为空">
                                </div>
                            </div>

                            <div class="layui-form-item">
                                <div class="layui-input-block">
                                    <button class="layui-btn" lay-submit lay-filter="formStep">
                                        &emsp;下一步&emsp;
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div>
                        <form class="layui-form" style="margin: 0 auto;max-width: 460px;padding-top: 40px;">
                            <input type="hidden" name="id" value="${admin.id}">
                            <div class="layui-form-item">
                                <label class="layui-form-label">邮箱</label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" name="email" id="email2" lay-verify="email" />
                                    <button style="position: absolute;top: 0;right: 0px;
    cursor: pointer;" type="button" class="layui-btn layui-btn-warm" id="sendCode2">点击发送验证码</button>
                                </div>
                            </div>

                            <div class="layui-form-item">
                                <label class="layui-form-label">验证码</label>
                                <div class="layui-input-block">
                                    <input type="text" name="code" id="code2" placeholder="请填写邮箱验证码" value="" class="layui-input" lay-verify="required" lay-reqtext="验证码不能为空">
                                </div>
                            </div>

                            <div class="layui-form-item">
                                <div class="layui-input-block">
                                    <button class="layui-btn" lay-submit lay-filter="formStep2">
                                        &emsp;确认换绑&emsp;
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div>
                        <div style="text-align: center;margin-top: 90px;">
                            <i class="layui-icon layui-circle"
                               style="color: white;font-size:30px;font-weight:bold;background: #52C41A;padding: 20px;line-height: 80px;">&#xe605;</i>
                            <div style="font-size: 24px;color: #333;font-weight: 500;margin-top: 30px;">
                                邮箱换绑成功
                            </div>
                        </div>
                        <div style="text-align: center;margin-top: 50px;">
                            <button class="layui-btn close">关闭</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${ctx}/layui/layui.js"></script>
<script src="${ctx}/js/step.js"></script>
<script src="${ctx}/js/admin/replaceEmail.js"></script>
</body>

</html>
