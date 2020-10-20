<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/page/include/taglib.jsp" %>
<html>
<head>
    <script>
        var ctx = "${ctx}";
    </script>
</head>
<body>
<script type="text/javascript" src="${ctx }/layui/layui.js"></script>
<script>
    layui.use('layer', function() {
        var $ = layui.jquery, layer = layui.layer;
        //设置一个自动跳转
        layer.msg('登录后才可访问！', {
            time: 3000, //3s后自动跳转
            btn: ['确定'],
            btnAlign: 'c'
        },function () {
            window.location=ctx+'/admin/login';
        });
    });
</script>
</body>
</html>
