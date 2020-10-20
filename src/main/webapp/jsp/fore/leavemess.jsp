<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/page/include/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>吾悦云笔记-云上的笔,随处可记</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="icon" href="${ctx}/image/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="${ctx}/layui/css/layui.css">
    <link href="${ctx}/css/fore/global.css" rel="stylesheet"/>
    <link href="${ctx}/css/fore/about.css" rel="stylesheet"/>
    <script>
        var ctx = "${ctx}";
    </script>
</head>
<body>
<jsp:include page="header.jsp"/>
<!-- 主体（一般只改变这里的内容） -->
<div class="blog-body">
    <div class="blog-container">
        <div class="blog-main layui-tab-brief">
            <div class="layui-tab-content">
                <div class="aboutinfo">
                    <div class="aboutinfo-contact">
                        <p style="font-size:2em;">沟通交流，拉近你我！</p>
                    </div>
                    <fieldset class="layui-elem-field layui-field-title">
                        <legend>Leave a message</legend>
                        <div class="layui-field-box">
                            <div class="leavemessage" style="text-align:initial">
                                <form class="layui-form blog-editor" action="">
                                    <div class="layui-form-item">
                                                <textarea name="content" lay-verify="content" id="remarkEditor"
                                                          placeholder="请输入内容"
                                                          class="layui-textarea layui-hide"></textarea>
                                        <div style="display: none" name="userId"
                                             id="userId">${sessionScope.admin.id}</div>
                                        <input type="hidden" name="noteId" value="0"/>
                                        <div style="display: none" name="parentId"></div>
                                        <input type="hidden" name="isParent" value="101"/>
                                        <input type="hidden" name="isLeaveMess" value="101"/>
                                    </div>
                                    <div class="layui-form-item">
                                        <button class="layui-btn" lay-submit="formLeaveMessage"
                                                lay-filter="formLeaveMessage">提交留言
                                        </button>
                                    </div>
                                </form>
                                <ul class="blog-comment">
                                    <ul class="blog-comment">
                                        <div id="temp"></div>
                                    </ul>
                                    <!--分页模块-->
                                    <div id="page" style="text-align: center"></div>
                                </ul>
                            </div>
                        </div>
                    </fieldset>
                </div><!--留言墙End-->
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>
<!-- 全局脚本 -->
<script src="${ctx}/js/fore/global.js"></script>
<!-- 本页脚本 -->
<script src="${ctx}/js/fore/about.js"></script>
</body>
</html>


