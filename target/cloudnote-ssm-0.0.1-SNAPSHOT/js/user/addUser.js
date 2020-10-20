var $;
var $form;
var form;
layui.config({
    base: ctx + "/js/"
}).use(['form', 'layer', 'jquery', 'upload','sliderVerify'], function () {
    var sliderVerify = layui.sliderVerify,
        layer = parent.layer === undefined ? layui.layer : parent.layer,
        laypage = layui.laypage,
        $ = layui.jquery,
        form = layui.form,
        upload = layui.upload;

    var slider = sliderVerify.render({
        elem: '#slider'
    });

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
                type: "post",
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

    form.on("submit(addUser)", function (data) {
        //弹出loading
        var index = layer.load(1, {
            shade: [0.5, '#000']
        });
        $.ajax({
            type: "post",
            url: ctx + "/admin/insertUser",
            data: data.field,
            dataType: "json",
            success: function (d) {
                if (d.code == 0) {
                    layer.close(index);
                    slider.reset();
                    sessionStorage.removeItem('vcode');
                    layer.msg("注册成功");
                } else {
                    layer.close(index);
                    slider.reset();
                    sessionStorage.removeItem('vcode');
                    layer.msg(d.msg);
                }
            }
        });
        setTimeout(function () {
            parent.location.reload();
        }, 2000);
        return false;
    });

    $("#sendCode").click(function () {
        if (slider.isOk()) {
            sendEmail();
            run();
        } else {
            layer.msg("请先通过滑块验证");
        }
        return false;
    });

//发送验证码
    function sendEmail(){
        //获取收件邮箱
        var email = document.getElementById('email').value;
        if(email==null || email==""){
            return;
        }
        //发送请求
        $.post(ctx + "/code",{email:email},function(data){
        },"text");
    }

//邮箱验证码计时
    var btn = document.getElementById('sendCode');
    function run(){
        var time = 60;//定义时间变量。用于倒计时用
        var timer = null;//定义一个定时器；
        timer = setInterval(function(){///开启定时器。函数内执行
            btn.disabled = true;
            btn.innerText = time+"秒后可重新发送";    //点击发生后，按钮的文本内容变成之前定义好的时间值。
            time--;//时间值自减
            if(time ==0){     //判断,当时间值小于等于0的时候
                btn.innerText='点击重新发送';
                btn.disabled = false;
                clearInterval(timer); //清除定时器
            }
        },1000)

    }
});



//Base64加密
var Base64 = {
    _keyStr: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",
    encode: function(e) {
        var t = "";
        var n, r, i, s, o, u, a;
        var f = 0;
        e = Base64._utf8_encode(e);
        while (f < e.length) {
            n = e.charCodeAt(f++);
            r = e.charCodeAt(f++);
            i = e.charCodeAt(f++);
            s = n >> 2;
            o = (n & 3) << 4 | r >> 4;
            u = (r & 15) << 2 | i >> 6;
            a = i & 63;
            if (isNaN(r)) {
                u = a = 64
            } else if (isNaN(i)) {
                a = 64
            }
            t = t + this._keyStr.charAt(s) + this._keyStr.charAt(o) + this._keyStr.charAt(u) + this._keyStr.charAt(a)
        }
        return t
    },
    decode: function(e) {
        var t = "";
        var n, r, i;
        var s, o, u, a;
        var f = 0;
        e=e.replace(/[^A-Za-z0-9+/=]/g,"");
        while (f < e.length) {
            s = this._keyStr.indexOf(e.charAt(f++));
            o = this._keyStr.indexOf(e.charAt(f++));
            u = this._keyStr.indexOf(e.charAt(f++));
            a = this._keyStr.indexOf(e.charAt(f++));
            n = s << 2 | o >> 4;
            r = (o & 15) << 4 | u >> 2;
            i = (u & 3) << 6 | a;
            t = t + String.fromCharCode(n);
            if (u != 64) {
                t = t + String.fromCharCode(r)
            }
            if (a != 64) {
                t = t + String.fromCharCode(i)
            }
        }
        t = Base64._utf8_decode(t);
        return t
    },
    _utf8_encode: function(e) {
        e = e.replace(/rn/g, "n");
        var t = "";
        for (var n = 0; n < e.length; n++) {
            var r = e.charCodeAt(n);
            if (r < 128) {
                t += String.fromCharCode(r)
            } else if (r > 127 && r < 2048) {
                t += String.fromCharCode(r >> 6 | 192);
                t += String.fromCharCode(r & 63 | 128)
            } else {
                t += String.fromCharCode(r >> 12 | 224);
                t += String.fromCharCode(r >> 6 & 63 | 128);
                t += String.fromCharCode(r & 63 | 128)
            }
        }
        return t
    },
    _utf8_decode: function(e) {
        var t = "";
        var n = 0;
        var r = c1 = c2 = 0;
        while (n < e.length) {
            r = e.charCodeAt(n);
            if (r < 128) {
                t += String.fromCharCode(r);
                n++
            } else if (r > 191 && r < 224) {
                c2 = e.charCodeAt(n + 1);
                t += String.fromCharCode((r & 31) << 6 | c2 & 63);
                n += 2
            } else {
                c2 = e.charCodeAt(n + 1);
                c3 = e.charCodeAt(n + 2);
                t += String.fromCharCode((r & 15) << 12 | (c2 & 63) << 6 | c3 & 63);
                n += 3
            }
        }
        return t
    }
}