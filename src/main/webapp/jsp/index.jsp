<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/page/include/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

    <title>吾悦云笔记-云上的笔,随处可记-后台管理</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="icon" href="${ctx}/image/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="${ctx}/layui/css/layui.css">
    <link rel="stylesheet"
          href="https://at.alicdn.com/t/font_tnyc012u2rlwstt9.css" media="all"/>
    <link rel="stylesheet" href="${ctx }/css/main.css" media="all"/>
    <link rel="stylesheet"
          href="${ctx }/css/font-awesome.min.css">
    <script>
        var ctx = "${ctx}";
    </script>
</head>
<body class="main_body">
<div class="layui-layout layui-layout-admin">
    <!-- 顶部 -->
    <div class="layui-header header">
        <div class="layui-main">
            <a class="logo" style="left: 0;" href="index.jsp"> <span
                    style="font-size: 22px;"><img src="../image/logo.png"
                                                  style="width: 35px;height: 35px;border-radius: 100%"/>&nbsp;&nbsp;吾悦云笔记</span>
            </a>
            <!-- 显示/隐藏菜单 -->
            <a href="javascript:;" class="iconfont hideMenu icon-menu1"></a>
            <!-- 顶部右侧菜单 -->
            <ul class="layui-nav top_menu">
                <li class="layui-nav-item"><a href="javascript:;"><img
                        src="${admin.image}"
                        style="width: 35px;height: 35px;border-radius: 100%"> <span
                        id="nickname">${admin.nickname }</span></a>
                    <dl class="layui-nav-child">
                        <dd>
                            <a href="${ctx }/home"><i class="layui-icon">&#xe7ae;</i><cite>回到前台</cite></a>
                        </dd>
                        <dd>
                            <a href="${ctx }/admin/loginOut"
                               class="signOut"><i class="iconfont icon-loginout"></i><cite>退出</cite></a>
                        </dd>
                    </dl>
                </li>
                </li>
            </ul>
        </div>
    </div>
    <!-- 左侧导航 -->
    <div class="layui-side layui-bg-black">
        <div class="navBar"></div>
    </div>
    <!-- 右侧内容 -->
    <div class="layui-body layui-form">
        <div class="layui-tab marg0" lay-filter="bodyTab" id="top_tabs_box">
            <ul class="layui-tab-title top_tab" id="top_tabs">
                <li class="layui-this" lay-id=""><i class="iconfont icon-computer"></i><cite>后台首页</cite></li>
            </ul>
            <!-- 当前页面操作 -->
            <ul class="layui-nav closeBox">
                <li class="layui-nav-item">
                    <a href="javascript:;"><i class="iconfont icon-caozuo"></i> 页面操作</a>
                    <dl class="layui-nav-child">
                        <dd>
                            <a href="javascript:;" class="refresh refreshThis"><i class="layui-icon">&#xe669;</i>
                                刷新当前</a>
                        </dd>
                        <dd>
                            <a href="javascript:;" class="closePageOther"><i class="iconfont icon-prohibit"></i>
                                关闭其他</a>
                        </dd>
                        <dd>
                            <a href="javascript:;" class="closePageAll"><i class="iconfont icon-guanbi"></i> 关闭全部</a>
                        </dd>
                    </dl>
                </li>
            </ul>
            <!-- 中间内容区域 -->
            <div class="layui-tab-content clildFrame">
                <div class="layui-tab-item layui-show">
                    <iframe src="${ctx }/admin/main"></iframe>
                </div>
            </div>
        </div>
    </div>
    <!-- 底部版权声明 -->
    <div class="layui-footer footer footer-demo" id="admin-footer">
        <div class="layui-main">
            <p><span>Copyright</span><span>&nbsp;&copy;&nbsp;</span><span>2020</span>&nbsp;<a href="https://ciyintang.vip" target="_blank">Dawn.</a><span>ALL RIGHTS RESERVED.</span></p>
        </div>
    </div>
</div>
<div class="site-tree-mobile layui-hide">
    <i class="layui-icon">&#xe602;</i>
</div>
<div class="site-mobile-shade"></div>
<script type="text/javascript" src="${ctx }/layui/layui.js"></script>
<script type="text/javascript" src="${ctx }/js/leftNav.js"></script>
<script type="text/javascript" src="${ctx }/js/index.js"></script>
</body>
</html>