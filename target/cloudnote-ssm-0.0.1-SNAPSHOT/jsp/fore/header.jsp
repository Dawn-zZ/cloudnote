<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/page/include/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <script>
        var ctx = "${ctx}";
    </script>
</head>
<body>
<!-- 导航 -->
<nav class="blog-nav layui-header">
    <div class="blog-container">
        <!-- 用户登录信息 -->
        <c:if test="${empty sessionScope.admin}">
            <a href="${ctx}/admin/login" class="blog-user" style="line-height: 64px;">登录</a>
        </c:if>
        <c:if test="${not empty sessionScope.admin}">
            <div class="dropdown blog-user">
                <div>
                    <img src="${admin.image}"/>&nbsp;&nbsp;<span
                        style="line-height: 64px;display: inline-block">${admin.nickname}&nbsp;&nbsp;&nbsp;&nbsp;</span>
                </div>
                <div class="layui-anim layui-anim-up">
                    <c:if test="${admin.isAdmin ==101}">
                        <div class="dropdown-content">
                            <a href="${ctx}/admin/index"><i class="layui-icon">&#xe7ae;</i><cite>进入后台</cite></a>
                            <a href="${ctx}/admin/loginOut"><i class="layui-icon">&#x1007;</i><cite>退出</cite></a>
                        </div>
                    </c:if>
                    <c:if test="${admin.isAdmin ==100}">
                        <div class="dropdown-content">
                            <a href="${ctx}/admin/loginOut"><i class="layui-icon">&#x1007;</i><cite>退出</cite></a>
                        </div>
                    </c:if>
                </div>
            </div>
        </c:if>
        <a class="blog-logo" href="${ctx}/home"><img src="${ctx}/image/logo.png" width="35px" height="35px">吾悦云笔记</a>
        <!-- 导航菜单 -->
        <ul class="layui-nav" lay-filter="nav">
            <li class="layui-nav-item">
                <a href="${ctx}/home" style="color: black"><i class="layui-icon">&#xe68e;</i>&nbsp;网站首页</a>
            </li>
            <li class="layui-nav-item">
                <a href="${ctx}/noteList" style="color: black"><i class="layui-icon">&#xe705;</i>&nbsp;共享笔记</a>
            </li>
            <li class="layui-nav-item">
                <a href="${ctx}/leavemessage" style="color: black"><i class="layui-icon">&#xe636;</i>&nbsp;博采众议</a>
            </li>
            <li class="layui-nav-item">
                <a href="${ctx}/about" style="color: black"><i class="layui-icon">&#xe60b;</i>&nbsp;关于本站</a>
            </li>
            <li class="layui-nav-item">
                <a href="${ctx}/admin/person" style="color: black"><i class="layui-icon">&#xe66f;</i>&nbsp;个人中心</a>
            </li>
        </ul>
        <!-- 手机和平板的导航开关 -->
        <a class="blog-navicon" href="javascript:;">
            <i class="layui-icon">&#xe66b;</i>
        </a>
    </div>
</nav>
<!--侧边导航-->
<ul class="layui-nav layui-nav-tree layui-nav-side blog-nav-left layui-hide" lay-filter="nav">
    <li class="layui-nav-item">
        <a href="${ctx}/home" style="color: black"><i class="layui-icon">&#xe68e;</i>&nbsp;网站首页</a>
    </li>
    <li class="layui-nav-item">
        <a href="${ctx}/noteList" style="color: black"><i class="layui-icon">&#xe705;</i>&nbsp;共享笔记</a>
    </li>
    <li class="layui-nav-item">
        <a href="${ctx}/leavemessage" style="color: black"><i class="layui-icon">&#xe636;</i>&nbsp;博采众议</a>
    </li>
    <li class="layui-nav-item">
        <a href="${ctx}/about" style="color: black"><i class="layui-icon">&#xe60b;</i>&nbsp;关于本站</a>
    </li>
    <li class="layui-nav-item">
        <a href="${ctx}/admin/person" style="color: black"><i class="layui-icon">&#xe66f;</i>&nbsp;个人中心</a>
    </li>
</ul>

<!--遮罩-->
<div class="blog-mask animated layui-hide"></div>
<script src="${ctx}/layui/layui.js"></script>
<script>
    layui.use('element', function () {
        var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块
    });
</script>
</body>
</html>
