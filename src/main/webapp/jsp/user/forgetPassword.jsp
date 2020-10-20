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
        <%--JS gloable varilible--%>
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

        .pro_name a{color: #4183c4;}
        .osc_git_title{background-color: #fff;}
        .osc_git_box{background-color: #fff;}
        .osc_git_box{border-color: #E3E9ED;}
        .osc_git_info{color: #666;}
        .osc_git_main a{color: #9B9B9B;}
    </style>
</head>
<body class="childrenBody">
    <div class="layui-row" style="margin-top: 50px;">
            <form class="layui-form" style="width: 80%;" action="">
                <div class="layui-form-item">
                    <label class="layui-form-label">用户名</label>
                    <div class="layui-input-block">
                        <input type="text" name="username" id="username" lay-verify="required" placeholder="请输入用户名" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">邮箱</label>
                    <div class="layui-input-block">
                        <input type="text" id="email" name="email" class="layui-input userName"
                               lay-verify="email" placeholder="请输入邮箱" value="">
                        <button style="position: absolute;top: 0;right: 0px;
    cursor: pointer;" type="button" class="layui-btn layui-btn-warm" id="sendCode">点击发送验证码</button>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label"></label>
                    <div class="layui-input-block">
                        <div id="slider"></div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">验证码</label>
                    <div class="layui-input-block">
                        <input type="text" name="code" id="code" lay-verify="required" lay-reqtext="验证码不能为空" placeholder="请输入邮箱验证码" autocomplete="off" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">密码</label>
                    <div class="layui-input-block">
                        <input type="password" id="password" class="layui-input userName"
                               lay-verify="pass" placeholder="请输入密码" name="password" value="">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">确认密码</label>
                    <div class="layui-input-block">
                        <input type="password" class="layui-input userName"
                               lay-verify="repass" placeholder="请输入确认密码" value="">
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                    </div>
                </div>
            </form>
    </div>
</body>
<script src="${ctx }/layui/layui.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctx }/js/user/forgetPassword.js" type="text/javascript" charset="utf-8"></script>
</html>