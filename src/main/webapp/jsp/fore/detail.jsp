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
    <!-- 比较好用的代码着色插件 -->
    <link href="${ctx}/css/fore/prettify.css" rel="stylesheet"/>
    <!-- 本页样式表 -->
    <link href="${ctx}/css/fore/detail.css" rel="stylesheet"/>
    <script>
        var ctx = "${ctx}";
    </script>
</head>
<body>
<jsp:include page="header.jsp"/>
<!-- 主体（一般只改变这里的内容） -->
<div class="blog-body">
    <div class="blog-container">
        <div class="blog-main">
            <div class="blog-main-left">
                <!-- 文章内容 -->
                <div class="article-detail shadow">
                    <div style="display: none" id="id">${note.id}</div>
                    <div class="article-detail-title">
                        ${note.title}
                    </div>
                    <div class="article-detail-info">
                        <span>编辑时间：<fmt:formatDate value="${note.createTime}" type="both"/></span>
                        <span>作者：${note.author}</span>
                        <span class="viewNum">浏览量：${note.viewNum}</span>
                    </div>
                    <div class="article-detail-content">
                        ${note.content}
                    </div>
                </div>

                <!-- 评论区域 -->
                <div class="blog-module shadow" style="box-shadow: 0 1px 8px #a6a6a6;">
                    <fieldset class="layui-elem-field layui-field-title" style="margin-bottom:0">
                        <legend>来说两句吧</legend>
                        <div class="layui-field-box">
                            <form class="layui-form blog-editor" action="">
                                <div class="layui-form-item">
                                    <textarea name="content" lay-verify="content" id="remarkEditor"
                                              placeholder="请输入内容" class="layui-textarea layui-hide"></textarea>
                                    <div style="display: none" name="userId" id="userId">${sessionScope.admin.id}</div>
                                    <input type="hidden" name="noteId" value="${note.id}"/>
                                    <div style="display: none" name="parentId"></div>
                                    <input type="hidden" name="isParent" value="101"/>
                                    <input type="hidden" name="isLeaveMess" value="100"/>
                                </div>
                                <div class="layui-form-item">
                                    <button class="layui-btn" lay-submit="formRemark" lay-filter="formRemark">提交评论
                                    </button>
                                </div>
                            </form>
                        </div>
                    </fieldset>
                    <ul class="blog-comment">
                        <div id="temp"></div>
                    </ul>
                    <!--分页模块-->
                    <div id="page" style="text-align: center"></div>
                </div>
            </div>
            <div class="blog-main-right">
                <div class="blog-module shadow">
                    <div class="blog-module-title">公告栏</div>
                    <dl class="footprint">
                        <jsp:include page="notice.jsp"/>
                    </dl>
                </div>
                <div class="blog-module shadow">
                    <div class="blog-module-title">最热文章</div>
                    <ul class="fa-ul blog-module-ul">
                        <div id="hotNote"></div>
                    </ul>
                </div>
            </div>
            <div class="clear"></div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>
<!-- 全局脚本 -->
<script src="${ctx}/js/fore/global.js"></script>
<!-- 比较好用的代码着色插件 -->
<script src="${ctx}/js/fore/prettify.js"></script>
<!-- 本页脚本 -->
<script src="${ctx}/js/fore/detail.js"></script>
<script src="${ctx}/js/jquery-1.9.1.min.js"></script>
<script src="${ctx}/js/jquery.cookie.js"></script>
<script type="text/javascript">
    //增加浏览量（单页刷新及反复点击同一页面只生效一次）
    function increaseViewNum() {
        if ($.cookie("viewId") !=${note.id}) {
            $.ajax({
                url: ctx + '/updateNoteViewNumById',
                type: "get",
                data: {
                    viewNum: ${note.viewNum}+1,
                    id: ${note.id}
                },
                success: function (d) {
                    var viewNum = ${note.viewNum}+1;
                    $(".viewNum").html("浏览量：" + viewNum);
                    $.cookie(
                        "viewId",
                        ${note.id},//需要cookie写入的业务
                        {
                            "path": "/", //cookie的默认属性
                        }
                    );
                }
            })
        }

    }

    increaseViewNum();
</script>
</body>
</html>
