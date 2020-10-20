layui.use(['form', 'layer'], function () {
    var layer = parent.layer === undefined ? layui.layer : parent.layer, $ = layui.jquery, form = layui.form;

    form.verify({
        newPassword1: [/(.+){6,16}$/, '密码必须6到16位'],
        newPassword2: function (value) {
            var repassvalue = $('#newPassword1').val();
            if (value != repassvalue) {
                return '两次输入的密码不一致!';
            }
        }
    });

    // 监听提交
    form.on("submit(changePassword)", function (data) {
        //弹出loading
        var index = top.layer.msg('数据提交中，请稍候', {icon: 16, time: false, shade: 0.8});
        $.ajax({
            url: ctx + "/admin/changeAdminPassword",
            async: false,
            type: "post",
            data: data.field,
            dataType: "json",
            success: function (data) {
                if (data.code == 0) {
                    layer.msg("修改成功，请重新登录！");
                    setTimeout(function (){
                        parent.window.location.href= ctx+'/admin/login';//整体跳转到登录页面
                    }, 2000);
                    $('#cpwd')[0].reset();
                } else {
                    layer.msg(data.msg);
                    $('#cpwd')[0].reset()
                }
            }
        });
        setTimeout(function () {
            top.layer.close(index);
        }, 2000);
        return false;
    });

});