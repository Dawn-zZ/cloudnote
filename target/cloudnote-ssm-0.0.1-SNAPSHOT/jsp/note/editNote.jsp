<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/page/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${ctx}/layui/css/layui.css" media="all"/>
    <link rel="stylesheet" href="${ctx}/css/main.css" media="all"/>
    <script>
        var ctx = "${ctx}";
    </script>
    <style>
        .layui-layedit-tool .layui-colorpicker-xs {
            border: 0;
        }

        .layui-layedit-tool .layui-colorpicker-trigger-span i {
            display: none !important;
        }
    </style>
</head>
<body class="childrenBody">
<form class="layui-form layui-row layui-col-space10">
    <div class="layui-col-md9 layui-col-xs12">
        <div class="layui-row layui-col-space10">
            <div class="layui-col-md9 layui-col-xs7">
                <div class="layui-form-item magt3">
                    <input type="hidden" name="id" value="${note.id }"/>
                    <label class="layui-form-label">笔记标题</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input title" value="${note.title }" name="title" lay-verify="title" placeholder="请输入标题">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">内容摘要</label>
                    <div class="layui-input-block">
                        <input type="hidden" value="" id="temp_abstr">
                        <textarea placeholder="请输入内容摘要" class="layui-textarea abstract" name="abstr">${note.abstr }</textarea>
                    </div>
                </div>
            </div>
            <input type="hidden" name="image" class="image" value="${note.image }">
            <div class="layui-col-md3 layui-col-xs5">
                <div class="layui-upload-list thumbBox mag0 magt3">
                    <img class="layui-upload-img thumbImg" src="${note.image }">
                </div>
            </div>
        </div>
        <div class="layui-form-item magb0">
            <label class="layui-form-label">笔记内容</label>
            <div class="layui-input-block">
                <div style="display: none" id="temp_content">${note.content }</div>
                <textarea class="layui-textarea layui-hide" name="content" lay-verify="content" id="note_content"></textarea>
            </div>
        </div>
    </div>
    <div class="layui-col-md3 layui-col-xs12">
        <blockquote class="layui-elem-quote title magt10"><i class="layui-icon">&#xe609;</i> 发布</blockquote>
        <div class="border">
            <div class="layui-form-item">
                <label class="layui-form-label"><i class="layui-icon">&#xe60e;</i> 状　态</label>
                <div class="layui-input-block newsStatus">
                    <c:if test="${note.uploadStatus==100 }">
                    <select name="uploadStatus" lay-verify="required">
                        <option value="101">立即发布</option>
                        <option value="100" selected>保存草稿</option>
                    </select>
                    </c:if>
                    <c:if test="${note.uploadStatus==101 }">
                        <select name="uploadStatus" lay-verify="required">
                            <option value="101" selected>立即发布</option>
                            <option value="100">保存草稿</option>
                        </select>
                    </c:if>
                </div>
            </div>
            <div class="layui-form-item openness">
                <label class="layui-form-label"><i class="layui-icon">&#xe663;</i> 公开度</label>
                <div class="layui-input-block">
                    <c:if test="${note.isOpen==101 }">
                        <input type="radio" name="isOpen" value="101" title="开放浏览" lay-skin="primary" checked/>
                        <input type="radio" name="isOpen" value="100" title="私密浏览" lay-skin="primary"/>
                    </c:if>
                    <c:if test="${note.isOpen==100 }">
                        <input type="radio" name="isOpen" value="101" title="开放浏览" lay-skin="primary"/>
                        <input type="radio" name="isOpen" value="100" title="私密浏览" lay-skin="primary" checked/>
                    </c:if>

                </div>
            </div>
            <hr class="layui-bg-gray"/>
            <div class="layui-right">
                <a class="layui-btn layui-btn-sm" lay-filter="updNote" lay-submit=""><i
                        class="layui-icon">&#xe609;</i>更新</a>
            </div>
        </div>
    </div>
</form>
<script type="text/javascript" src="${ctx}/js/ace.js"></script>
<script type="text/javascript" src="${ctx}/layui/layui.js"></script>
<script type="text/javascript" src="${ctx}/js/note/editNote.js"></script>
</body>
</html>

