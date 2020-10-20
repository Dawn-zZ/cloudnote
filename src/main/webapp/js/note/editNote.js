layui.use(['form','layer','layedit','laydate','upload','jquery'],function(){
    var form = layui.form,
    layer = parent.layer === undefined ? layui.layer : top.layer,
        laypage = layui.laypage,
        upload = layui.upload,
        layedit = layui.layedit,
        laydate = layui.laydate,
        $ = layui.jquery;

    layedit.set({
        //暴露layupload参数设置接口 --详细查看layupload参数说明
        uploadImage: {
            url: ctx + '/uploadImage',
            accept: 'image',
            acceptMime: 'image/*',
            exts: 'jpg|png|gif|bmp|jpeg',
            size: 1024 * 10,
        }
        , rightBtn: {
            type: "layBtn",//default|layBtn|custom  浏览器默认/layedit右键面板/自定义菜单 default和layBtn无需配置customEvent
            customEvent: function (targetName, event) {
                //根据tagName分类型设置
                switch (targetName) {
                    case "img":
                        alert("this is img");
                        break;
                    default:
                        alert("hello world");
                        break;
                };
                //或者直接统一设定
                //alert("all in one");
            }
        }
        //测试参数
        , backDelImg: true
        //开发者模式 --默认为false
        , devmode: true
        //是否自动同步到textarea
        , autoSync: true
        //内容改变监听事件
        , onchange: function (content) {
        }
        //插入代码设置 --hide:false 等同于不配置codeConfig
        , codeConfig: {
            hide: true,  //是否隐藏编码语言选择框
            default: 'javascript', //hide为true时的默认语言格式
            encode: true //是否转义
            ,class:'layui-code' //默认样式
        }
        //新增iframe外置样式和js
        , quote:{
            //js: ['/Content/Layui-KnifeZ/lay/modules/jquery.js']
        }
        , facePath: 'https://knifez.gitee.io/kz.layedit/Content/Layui-KnifeZ/'

        , tool: [
            'html'
            , 'code', 'strong', 'italic', 'underline', 'del'
            , 'addhr'
            , '|','removeformat', 'fontFomatt', 'fontfamily','fontSize'
            , 'fontBackColor', 'colorpicker', 'face'
            , '|', 'left', 'center', 'right', '|', 'link', 'unlink'
            , 'image_alt'
            , 'anchors'
            , '|'
            , 'table'
            , 'fullScreen'
            ,'preview'
        ]
        , height: '500px'
    });
    var ieditor = layedit.build('note_content');

    var temp_content = $('#temp_content').html();
    layedit.setContent(ieditor, temp_content, false);





    //上传缩略图
    var uploadInst = upload.render({
        elem: '.thumbBox',
        url: ctx + '/uploadImage',
        done: function(res, index, upload){
            if (res.code > 0) {
                return layer.msg('上传失败');
            }
            $('.thumbImg').attr('src',res.data.src);
            $('.thumbBox').css("background","#fff");
            $('.image').attr('value',res.data.src);
        }
    });

    form.verify({
        title : function(val){
            if(val == ''){
                return "标题不能为空";
            }
        }
        ,content : function(val){
            if(val == ''){
                return "内容不能为空";
            }
        }
    });
    form.on("submit(updNote)",function(data){
        //弹出loading
        var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
        var msg;
        $.ajax({
            type: "post",
            url: ctx + "/admin/updateNote",
            data: data.field,
            dataType: "json",
            success: function (d) {
                if (d.code == 0) {
                    msg = "更新成功！";
                } else {
                    msg = d.msg;
                }
                layer.msg(msg);
            }
        });
        setTimeout(function(){
            top.layer.close(index);
            //top.layer.msg(msg);
            layer.closeAll("iframe");
            //刷新父页面
            parent.location.reload();
        },2000);
        return false;
    });

});