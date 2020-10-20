var $;
var $form;
var form;
layui.config({
    base: "js/"
}).use(['form', 'layer', 'jquery', 'upload'], function () {
    var layer = parent.layer === undefined ? layui.layer : parent.layer,
        upload = layui.upload;
    $ = layui.jquery;
    form = layui.form;


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
            console.log(fileupload.attr("value"));
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

    form.on("submit(updUser)", function (data) {
        //弹出loading
        var index =top.layer.load(1, {
            shade: [0.5, '#000']
        });
        var msg;
        $.ajax({
            type: "post",
            url: ctx + "/admin/updateUser",
            data: data.field,
            dataType: "json",
            success: function (d) {
                if (d.code == 0) {
                    top.layer.close(index);
                    layer.msg("更新成功");
                    parent.location.reload();
                } else {
                    top.layer.close(index);
                    layer.msg(d.msg);
                }

            }
        });
        return false;
    })

});