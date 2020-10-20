var $;
layui.config({
    base: "js/"
}).use(['form', 'layer', 'jquery', 'laypage', 'table', 'laytpl', 'laydate'], function () {
    var form = layui.form, table = layui.table,
        layer = parent.layer === undefined ? layui.layer : parent.layer, laydate = layui.laydate,
        laypage = layui.laypage;
    $ = layui.jquery;
    var documentWidth = $(document).width();

    //数据表格
    table.render({
        id: 'adminList',
        elem: '#adminList'
        , url: ctx + '/admin/getAdminList' //数据接口
        , cellMinWidth: 80
        , height: 'full-105'
        , width:documentWidth-40
        , toolbar: true
        , title: '管理员信息表'
        , limit: 20//每页默认数
        , limits: [10, 20, 30, 40]
        , cols: [[ //表头
            {field: 'id', title: 'ID', sort: true, minWidth: 80, align: 'center'}
            , {field: 'username', title: '用户名', align: 'center'}
            , {
                field: 'image', title: '头像', align: 'center', event: 'seeImage', templet: function (d) {
                    return '<div><img src="' + d.image + '" style="height: 30px;line-height: 70px!important;border-radius: 100%"/></div>';
                }, minWidth: 80
            }
            , {field: 'nickname', title: '昵称', align: 'center'}
            , {field: 'email', title: '邮箱', align: 'center', minWidth: 180}
            , {field: 'sex', title: '性别', templet: '#sexTpl', align: 'center'}
            , {field: 'phone', title: '联系方式', align: 'center', minWidth: 120}
            , {field: 'roleName', title: '角色', align: 'center', minWidth: 120}
            , {
                field: 'createTime',
                title: '创建时间',
                align: 'center',
                templet: '<div>{{ formatTime(d.createTime,"yyyy-MM-dd hh:mm:ss")}}</div>',
                minWidth: 170
            }
            , {field: 'note', title: '签名', align: 'center', minWidth: 150}
            , {title: '操作', toolbar: '#barEdit', align: 'center', minWidth: 150}
        ]]
        , page: true // 开启分页
    });
    //监听工具条
    table.on('tool(test)', function (obj) {
        var data = obj.data, adminId = $("#adminId").val();

        //监听图片点击
        if (obj.event === 'seeImage') {
            layer.open({
                type: 1,
                skin: 'layui-layer-rim', //加上边框
                area: ['60%', '60%'], //宽高
                shadeClose: true, //开启遮罩关闭
                end: function (index, layero) {
                    return false;
                },
                content: '<div style="text-align:center"><img src="' + data.image + '" width="60%" height="60%" align="center" /></div>'
            });
        }


        if (obj.event === 'del') {
            if (data.id == adminId) {
                layer.msg("不允许删除自己！", {icon: 5});
                return;
            }
            layer.confirm('确定要删除 ' + data.username + ' 么？', function (index) {
                $.ajax({
                    url: ctx + '/admin/delAdminById/' + data.id,
                    type: "get",
                    success: function (d) {
                        if (d.code == 0) {
                            layer.msg("删除成功！", {icon: 1});
                            table.reload('adminList', {})
                        } else {
                            layer.msg("权限不足，联系超管！", {icon: 5});
                        }
                    }
                });
                layer.close(index);
            });
        } else if (obj.event === 'edit') {
            if (data.id == '1') {
                layer.msg("不允许编辑此用户！", {icon: 5});
                return;
            }
            if (data.id == adminId) {
                layer.msg("不允许编辑自己！", {icon: 5});
                return;
            }
            layer.open({
                type: 2,
                title: "编辑管理员",
                area: ['80%', '80%'],
                content: ctx + "/admin/editAdmin/" + data.id
            })
        }
    });


    //添加角色
    $(".adminAdd_btn").click(function () {
        var index = layui.layer.open({
            title: "添加管理员",
            type: 2,
            content: ctx + "/admin/addAdmin",
            area: ['80%', '80%']
        });
        //改变窗口大小时，重置弹窗的高度，防止超出可视区域（如F12调出debug的操作）
        $(window).resize(function () {
            layui.layer.full(index);
        })
    });
});

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
