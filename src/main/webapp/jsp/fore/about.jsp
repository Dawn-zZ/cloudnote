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
        <div class="blog-main">
            <div class="layui-tab layui-tab-brief shadow" lay-filter="tabAbout">
                <ul class="layui-tab-title">
                    <li lay-id="1" class="layui-this">关于网站</li>
                    <li lay-id="2">关于作者</li>
                </ul>
                <div class="layui-tab-content">
                    <div class="layui-tab-item">
                        <div class="aboutinfo">
                            <p class="aboutinfo-nickname">吾悦云笔记</p>
                            <p class="aboutinfo-introduce">一个支持共享的云笔记平台，记录自己的私密生活，分享经历的多彩人生！正如网站的描述一般：云上的笔，随处可记。</p>

                            <fieldset class="layui-elem-field layui-field-title">
                                <legend></legend>
                                <div class="layui-field-box aboutinfo-abstract">
                                    <p style="text-align:center;"></p>
                                    <h1>第一</h1>
                                    <p>这是充数内容这是充数内容这是充数内容这是充数内容这是充数内容这是充数内容这是充数内容
                                        </p>
                                    <h1>第二</h1>
                                    <p>这是充数内容这是充数内容这是充数内容这是充数内容这是充数内容这是充数内容这是充数内容
                                        </p>
                                    <h1>版权问题</h1>
                                    <p>如侵犯他人著作权、名誉权、隐私权及肖像权等请联系本站删除。</p>
                                    <h1 style="text-align:center;">The End</h1>
                                </div>
                            </fieldset>
                        </div>
                    </div><!--关于网站End-->
                    <div class="layui-tab-item">
                        <div class="aboutinfo">
                            <p class="aboutinfo-nickname">Dawn</p>
                            <p class="aboutinfo-introduce">一枚大四学生，即将遭受社会的毒打，目前热衷于java开发，略懂前端</p>
                            <fieldset class="layui-elem-field layui-field-title">
                                <legend></legend>
                                <div class="layui-field-box aboutinfo-abstract abstract-bloger">
                                    <h1>个人资料</h1>
                                    <p>常用名：Dawn</p>
                                    <p>年龄：96年生人</p>
                                    <p>职业：学生</p>
                                    <p>QQ：1032958367</p>
                                    <p></p>
                                    <p>多数人都拥有自己不了解的能力和机会，都有可能做到未曾梦想的事情。</p>
                                    <h1>个人介绍</h1>
                                    <p>一个没有故事的男同学，没什么介绍......</p>
                                    <h1 style="text-align:center;">The End</h1>
                                </div>
                            </fieldset>
                        </div>
                    </div><!--关于作者End-->
                </div>
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

