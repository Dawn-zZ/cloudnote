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
    <link rel="stylesheet" href="${ctx}/css/main.css">
    <link href="${ctx}/css/fore/global.css" rel="stylesheet"/>
    <script>
        var ctx = "${ctx}";
    </script>
    <style>
        .new {
            background: #5FB878;
        }

        #test {
            position: absolute;
            border: #0C0C0C;
            width: calc(99% - 170px);
            height: 97%;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"/>
<!-- 主体（一般只改变这里的内容） -->
<div class="blog-body">
    <div class="blog-container">
        <div class="blog-main" style="background: #FFFFFF">
            <div class="layui-tab-content">
                <div class="content content-nav-base commodity-content">
                    <div class="commod-cont-wrap">
                        <div class="commod-cont w1200 layui-clear">
                            <div class="left-nav">
                                <div class="title">个人中心</div>
                                <div class="list-box">
                                    <dl>
                                        <dd class="new"><a href="javascript:;" id="a1">新建笔记</a></dd>
                                    </dl>
                                    <dl>
                                        <dt>我的面板</dt>
                                        <dd><a href="javascript:;" id="a2">个人信息</a></dd>
                                        <dd><a href="javascript:;" id="a3">修改密码</a></dd>
                                    </dl>
                                    <dl>
                                        <dt>笔记管理</dt>
                                        <dd><a href="javascript:;" id="a4">公开笔记</a></dd>
                                        <dd><a href="javascript:;" id="a5">私密笔记</a></dd>
                                        <dd><a href="javascript:;" id="a6">草稿箱</a></dd>
                                    </dl>
                                    <dl>
                                        <dt>评论留言</dt>
                                        <dd><a href="javascript:;" id="a7">我的评论</a></dd>
                                    </dl>
                                </div>
                            </div>
                            <div class="right-cont-wrap">
                                <iframe src="${ctx}/admin/addNote" frameborder="0" id="test"></iframe>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var $;
    layui.use(['jquery'], function () {
        $ = layui.jquery;
        $("#a1").click(function () {
            $("#test").attr("src", "${ctx}/admin/addNote");
        });
        $("#a2").click(function () {
            $("#test").attr("src", "${ctx}/admin/personalData");
        });
        $("#a3").click(function () {
            $("#test").attr("src", "${ctx}/admin/changePassword");
        });
        $("#a4").click(function () {
            $("#test").attr("src", "${ctx}/admin/userNoteList");
        });
        $("#a5").click(function () {
            $("#test").attr("src", "${ctx}/admin/sMNote");
        });
        $("#a6").click(function () {
            $("#test").attr("src", "${ctx}/admin/cGNote");
        });
        $("#a7").click(function () {
            $("#test").attr("src", "${ctx}/admin/getRemark");
        });

        $('.list-box dd').click(function () {
            $('.list-box dd').removeClass('new');
            $(this).addClass('new');
        });


        $('.list-box dt').on('click', function () {
            if ($(this).attr('off')) {
                $(this).removeClass('active').siblings('dd').show()
                $(this).attr('off', '')
            } else {
                $(this).addClass('active').siblings('dd').hide()
                $(this).attr('off', true)
            }
        })

    });
</script>
<!-- 全局脚本 -->
<script src="${ctx}/js/fore/global.js"></script>
<jsp:include page="footer.jsp"/>
</body>
</html>
