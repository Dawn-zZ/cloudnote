var $;
layui.use(['element', 'jquery', 'form', 'layedit','laypage'], function () {
    var element = layui.element;
    var form = layui.form;
    $ = layui.jquery;
    var layedit = layui.layedit;
    var laypage = layui.laypage;

    //评论和留言的编辑器
    var editIndex = layedit.build('remarkEditor', {
        height: 150,
        tool: ['face', '|', 'left', 'center', 'right', '|', 'link'],
    });
    //评论和留言的编辑器的验证
    form.verify({
        content: function (value) {
            value = $.trim(layedit.getText(editIndex));
            if (value == "") return "自少得有一个字吧";
            layedit.sync(editIndex);
        }
    });

    //Hash地址的定位
    var layid = location.hash.replace(/^#tabIndex=/, '');
    if (layid == "") {
        element.tabChange('tabAbout', 1);
    }
    element.tabChange('tabAbout', layid);

    element.on('tab(tabAbout)', function (elem) {
        location.hash = 'tabIndex=' + $(this).attr('lay-id');
    });

    //监听留言提交
    form.on('submit(formLeaveMessage)', function (data) {
        //弹出loading
        var index = top.layer.msg('数据提交中，请稍候', {icon: 16, time: false, shade: 0.8});
        var msg;
        $.ajax({
            type: "post",
            url: ctx + "/insRemark",
            data: data.field,
            dataType: "json",
            success: function (d) {
                if (d.code == 0) {
                    layer.msg("留言成功", {icon: 1});
                } else {
                    layer.msg(d.msg);
                }
            }
        });
        setTimeout(function () {
            top.layer.close(index);
            layer.closeAll("iframe");
            //刷新父页面
            parent.location.reload();
        }, 1000);
        return false;
    });

    //监听留言回复提交
    form.on('submit(formReply)', function (data) {
        //弹出loading
        var index = top.layer.msg('数据提交中，请稍候', {icon: 16, time: false, shade: 0.8});
        var msg;
        $.ajax({
            type: "post",
            url: ctx + "/insRemark",
            data: data.field,
            dataType: "json",
            success: function (d) {
                if (d.code == 0) {
                    layer.msg("回复成功", {icon: 1});
                } else {
                    layer.msg(d.msg);
                }
            }
        });
        setTimeout(function () {
            top.layer.close(index);
            layer.closeAll("iframe");
            //刷新父页面
            parent.location.reload();
        }, 1000);
        return false;
    });


    var url = ctx + "/getLeaveMess";
    var config = {page: 1, limit: 20};//page:起始页;limit:页面容量;

    $.getJSON(url, config, function (res) {

        laypage.render({
            elem: 'page',
            count: res.count, //总条数
            limit: config.limit, //每页条数
            theme: '#009688', //自定义颜色
            jump: function (obj, first) {
                if (!first) { //首次则不进入
                    config.page = obj.curr;
                    getNoteListByPage(url, config);
                }
            }
        });
        parseNoteList(res, config.page);
    });

});

function getNoteListByPage(url, config) {
    $.getJSON(url, config, function (res) {
        parseNoteList(res, config.page);
    });
}

//向前端输出数据
function parseNoteList(res, currPage) {
    var content = "";
    var userId = $('#userId').text();
    var url2 = ctx + "/getLeaveMessReply";

    $.getJSON(url2,function (res2) {

        $.each(res.data, function (i, remark) {
            if(remark.isParent==101){
                content += "<li>" +
                    "<div class=\"comment-parent\">" +
                    "<img src=" + remark.image + " />" +
                    "<div class=\"info\">" +
                    "<span class=\"username\">" + remark.nickname + "</span>" +
                    "<span class=\"time\">" + formatTime(remark.createTime, "yyyy-MM-dd hh:mm:ss") + "</span>" +
                    "</div>" +
                    "<div class=\"content\">" + remark.content + "</div>" +
                    "<p class=\"info info-footer\">\n" +
                    "<a class=\"btn-reply\" href=\"javascript:;\" onclick=\"btnReplyClick(this," + remark.remarkId + ")\">回复</a>\n" +
                    "</p>" +
                    "</div>" +
                    "<hr/>";
            }

            $.each(res2, function (i, reply) {

                if(reply.parentId==remark.remarkId && reply.isParent==100){
                    content +="<div class=\"comment-child\">\n" +
                        "<img src=\"" + reply.image + "  \" />\n" +
                        "<div class=\"info\">\n" +
                        "<span class=\"username\">" + reply.nickname + "</span><span>" + reply.content + "</span>\n" +
                        "</div>\n" +
                        "<p class=\"info\"><span class=\"time\">" + formatTime(reply.createTime, "yyyy-MM-dd hh:mm:ss") + "</span></p>\n" +
                        "</c:if></div>";
                }
            });
            content+="<div class=\"replycontainer layui-hide\">\n" +
                "<form class=\"layui-form\" action=\"\">\n" +
                "<div class=\"layui-form-item\">\n" +
                "<textarea name=\"content\" lay-verify=\"replyContent\"\n" +
                "placeholder=\"请输入回复内容\" class=\"layui-textarea\"\n" +
                "style=\"min-height:80px;\"></textarea>\n" +
                "<div style=\"display: none\" name=\"userId\">"+userId+"</div>\n" +
                "<input type=\"hidden\" name=\"noteId\" value=\"0\"/>\n" +
                "<input type=\"hidden\" name=\"parentId\" class='parentId' value=\"\"/>\n" +
                "<input type=\"hidden\" name=\"isParent\" value=\"100\"/>\n" +
                "<input type=\"hidden\" name=\"isLeaveMess\" value=\"101\"/>"+
                "</div>\n" +
                "<div class=\"layui-form-item\">\n" +
                "<button class=\"layui-btn layui-btn-mini\"\n" +
                "lay-submit=\"formReply\" lay-filter=\"formReply\">提交\n" +
                "</button>\n" +
                "</div>\n" +
                "</form>\n" +
                "</div></li>";
        });
        $('#temp').html(content);
    });

}

function btnReplyClick(elem, id) {
    var $ = layui.jquery;
    $(elem).parent('p').parent('.comment-parent').siblings('.replycontainer').toggleClass('layui-hide');
    if ($(elem).text() == '回复') {
        $(".parentId").attr("value", id);
        $(elem).text('收起')
    } else {
        $(".parentId").attr("value",0);
        $(elem).text('回复')
    }
}


// 格式化时间
function formatTime(datetime, fmt) {
    if (datetime == null || datetime == 0) {
        return "";
    }
    if (parseInt(datetime) == datetime) {
        if (datetime.length == 10) {
            datetime = parseInt(datetime) * 1000;
        } else if (datetime.length == 13) {
            datetime = parseInt(datetime);
        }
    }
    datetime = new Date(datetime);
    var o = {
        "M+": datetime.getMonth() + 1, // 月份
        "d+": datetime.getDate(), // 日
        "h+": datetime.getHours(), // 小时
        "m+": datetime.getMinutes(), // 分
        "s+": datetime.getSeconds(), // 秒
        "q+": Math.floor((datetime.getMonth() + 3) / 3), // 季度
        "S": datetime.getMilliseconds()
        // 毫秒
    };
    if (/(y+)/.test(fmt))
        fmt = fmt.replace(RegExp.$1, (datetime.getFullYear() + "")
            .substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt))
            fmt = fmt.replace(RegExp.$1,
                (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k])
                    .substr(("" + o[k]).length)));
    return fmt;
}