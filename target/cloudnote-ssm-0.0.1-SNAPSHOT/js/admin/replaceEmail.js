layui.config({
    base: ctx + "/js/"
}).use(['form', 'layer', 'jquery', 'step'], function () {
    var layer = parent.layer === undefined ? layui.layer : parent.layer,
        $ = layui.jquery,
        form = layui.form,
        step = layui.step;


    $("#email2").blur(function () {
        var email = Base64.encode($("#email2").val());
        if (email != "") {
            $.ajax({
                type: "get",
                url: ctx + "/admin/checkUserEmail/" + email,
                success: function (data) {
                    if (data.code != 0) {
                        top.layer.msg(data.msg);
                        $("#email2").val("");
                        $("#email2").focus();
                    }
                }
            });
        }
    });

    $("#sendCode1").click(function () {
        sendEmail();
        run();
    });

    $("#sendCode2").click(function () {
        sendEmail2();
        run2();
    });

//发送验证码
    function sendEmail() {
        //获取收件邮箱
        var email = document.getElementById('email1').value;
        if (email == null || email == "") {
            return;
        }
        //发送请求
        $.post(ctx + "/code", {email: email}, function (data) {
        }, "text");
    }

    //发送验证码
    function sendEmail2() {
        //获取收件邮箱
        var email = document.getElementById('email2').value;
        if (email == null || email == "") {
            return;
        }
        //发送请求
        $.post(ctx + "/code", {email: email}, function (data) {
        }, "text");
    }

//邮箱验证码计时
    var btn = document.getElementById('sendCode1');

    function run() {
        var time = 60;//定义时间变量。用于倒计时用
        var timer = null;//定义一个定时器；
        timer = setInterval(function () {///开启定时器。函数内执行
            btn.disabled = true;
            btn.innerText = time + "秒后可重新发送";    //点击发生后，按钮的文本内容变成之前定义好的时间值。
            time--;//时间值自减
            if (time == 0) {     //判断,当时间值小于等于0的时候
                btn.innerText = '点击重新发送';
                btn.disabled = false;
                clearInterval(timer); //清除定时器
            }
        }, 1000)

    }

    //邮箱验证码计时
    var btn2 = document.getElementById('sendCode2');

    function run2() {
        var time = 60;//定义时间变量。用于倒计时用
        var timer = null;//定义一个定时器；
        timer = setInterval(function () {///开启定时器。函数内执行
            btn2.disabled = true;
            btn2.innerText = time + "秒后可重新发送";    //点击发生后，按钮的文本内容变成之前定义好的时间值。
            time--;//时间值自减
            if (time == 0) {     //判断,当时间值小于等于0的时候
                btn2.innerText = '点击重新发送';
                btn2.disabled = false;
                clearInterval(timer); //清除定时器
            }
        }, 1000)

    }


    step.render({
        elem: '#stepForm',
        filter: 'stepForm',
        width: '100%', //设置容器宽度
        stepWidth: '750px',
        height: '500px',
        stepItems: [{
            title: '换绑确认'
        }, {
            title: '提交邮箱'
        }, {
            title: '完成'
        }]
    });


    form.on('submit(formStep)', function (data) {
        $.ajax({
            type: "post",
            url: ctx + "/admin/confirmEmail",
            data: data.field,
            dataType: "json",
            success: function (d) {
                if (d.code == 0) {
                    step.next('#stepForm');
                    sessionStorage.removeItem('vcode');
                } else {
                    top.layer.msg(d.msg);
                }
            }
        });
        return false;
    });

    form.on('submit(formStep2)', function (data) {
        $.ajax({
            type: "post",
            url: ctx + "/admin/updateEmail",
            data: data.field,
            success: function (d) {
                if (d.code == 0) {
                    step.next('#stepForm');
                    sessionStorage.removeItem('vcode');
                } else {
                    top.layer.msg(d.msg);
                }
            }
        });
        return false;
    });

    $('.close').click(function () {
        layer.closeAll();
        parent.location.reload();
    });

});


//Base64加密
var Base64 = {
    _keyStr: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",
    encode: function (e) {
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
    decode: function (e) {
        var t = "";
        var n, r, i;
        var s, o, u, a;
        var f = 0;
        e = e.replace(/[^A-Za-z0-9+/=]/g, "");
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
    _utf8_encode: function (e) {
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
    _utf8_decode: function (e) {
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