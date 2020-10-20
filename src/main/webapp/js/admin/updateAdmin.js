layui.use(['form', 'layer', 'upload'], function () {
    var layer = parent.layer === undefined ? layui.layer : parent.layer, $ = layui.jquery, form = layui.form, upload = layui.upload;

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

    // 监听提交
    form.on("submit(updateAdmin)", function (data) {
        var index = top.layer.msg('数据提交中，请稍候', {icon: 16, time: false, shade: 0.8});
        $.ajax({
            url: ctx + "/admin/updateAdmin",
            type: "post",
            data: data.field,
            dataType: "json",
            success: function (data) {
                if (data.code == 0) {
                    layer.msg("修改成功!");
                } else {
                    layer.msg("修改失败，请重试！");
                }
            }
        });
        setTimeout(function () {
            top.layer.close(index);
            layer.closeAll();
            parent.location.reload();
        }, 2000);
        return false;
    });

});