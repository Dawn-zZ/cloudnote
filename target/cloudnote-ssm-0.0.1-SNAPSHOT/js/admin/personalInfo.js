layui.use(['layer'], function () {
    var layer = parent.layer === undefined ? layui.layer : parent.layer, $ = layui.jquery;

    $("#replaceEmail").click(function () {
        top.layer.open({
            type: 2,
            title: "邮箱绑定",
            area: ['80%', '80%'],
            content: ctx + "/admin/replaceEmail"
        })
    });
    $("#updateInfo").click(function () {
        top.layer.open({
            type: 2,
            title: "修改个人信息",
            area: ['80%', '80%'],
            content: ctx + "/admin/updateInfo/"
        })
    });

});