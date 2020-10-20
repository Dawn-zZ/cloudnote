var $;
var $form;
var form;
layui.config({
    base: "js/"
}).use(['form', 'layer', 'jquery', 'upload'], function () {
    var layer = parent.layer === undefined ? layui.layer : parent.layer,
        laypage = layui.laypage,
        $ = layui.jquery,
        form = layui.form,
        upload = layui.upload;

    //普通图片上传
    var uploadInst = upload.render({
        elem: '#test1'
        , url: ctx + '/uploadImage'
        , accept: 'images'
        , size: 50000
        , before: function (obj) {

            obj.preview(function (index, file, result) {

                $('#demo1').attr('src', result);
            });
        }
        , done: function (res) {
            //如果上传失败
            if (res.code > 0) {
                return layer.msg('上传失败');
            }
            //上传成功
            var demoText = $('#demoText');
            demoText.html('<span style="color: #4cae4c;">上传成功</span>');

            var fileupload = $(".image");
            fileupload.attr("value", res.data.src);
        }
        , error: function () {
            //演示失败状态，并实现重传
            var demoText = $('#demoText');
            demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
            demoText.find('.demo-reload').on('click', function () {
                uploadInst.upload();
            });
        }
    });
    //自定义验证规则
    form.verify({
        pass: [/(.+){6,16}$/, '密码必须6到16位']
        , repass: function (value) {
            var repassvalue = $('#password').val();
            if (value != repassvalue) {
                return '两次输入的密码不一致!';
            }
        }
    });

    $("#username").blur(function () {
        var username = $("#username").val();
        if (username !="") {
            $.ajax({
                type: "get",
                url: ctx + "/admin/checkAdminName/" + username,
                success: function (data) {
                    if (data.code != 0) {
                        top.layer.msg(data.msg);
                        $("#username").val("");
                        $("#username").focus();
                    }
                }
            });
        }
    });

    $("#email").blur(function () {
        var email = Base64.encode($("#email").val());
        if (email !="") {
            $.ajax({
                type: "get",
                url: ctx + "/admin/checkUserEmail/" + email,
                success: function (data) {
                    if (data.code != 0) {
                        top.layer.msg(data.msg);
                        $("#email").val("");
                        $("#email").focus();
                    }
                }
            });
        }
    });

    form.on("submit(addAdmin)", function (data) {
        //弹出loading
        var index = top.layer.msg('数据提交中，请稍候', {icon: 16, time: false, shade: 0.8});
        var msg;
        $.ajax({
            type: "post",
            url: ctx + "/admin/insAdmin",
            data: data.field,
            dataType: "json",
            success: function (d) {
                if (d.code == 0) {
                    msg = "添加成功！";
                } else {
                    msg = d.msg;
                }
                layer.msg(msg);
            }
        });
        setTimeout(function () {
            top.layer.close(index);
            //top.layer.msg(msg);
            layer.closeAll("iframe");
            //刷新父页面
            parent.location.reload();
        }, 2000);
        return false;
    })

})