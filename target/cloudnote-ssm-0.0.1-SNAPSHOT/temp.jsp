<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/page/include/taglib.jsp" %>
<html>
<head>
    <script>
        var ctx = "${ctx}";
    </script>
</head>
<!--跳转到springmvc控制器!-->
<body onload="javascript:window.location=ctx+'/home';">
</body>
</html>
