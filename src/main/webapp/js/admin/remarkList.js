layui.use(['form', 'layer', 'jquery', 'laypage', 'table', 'laytpl', 'laydate'], function () {
    var layer = parent.layer === undefined ? layui.layer : parent.layer, $ = layui.jquery, form = layui.form,
        table = layui.table, laydate = layui.laydate, laypage = layui.laypage;
    var nowTime = new Date().valueOf();
    var max = null;
    var documentWidth = $(document).width();
    active = {
        search: function () {
            var isLeaveMess = $('#isLeaveMess option:selected');

            table.reload('remarkList', {
                page: {
                    curr: 1
                },
                where: {
                    isLeaveMess: isLeaveMess.val()
                }
            });
        }
    };


    table.render({
        id: 'remarkList'
        , elem: '#remarkList'
        , url: ctx + '/admin/getRemarksList'// 数据接口
        , toolbar: true
        , cellMinWidth: 80
        , method: 'post'
        , height: 'full-105'
        , width:documentWidth-40
        , title: '用户信息表'
        , limit: 20// 每页默认数
        , limits: [10, 20, 30, 40]
        , cols: [[ // 表头
            {field: 'remarkId', title: 'ID', sort: true, minWidth: 80, align: 'center'}
            , {
                field: 'image', title: '作者头像', align: 'center', event: 'seeImage', templet: function (d) {
                    return '<div><img src="' + d.image + '" style="height: 30px;border-radius: 100%"/></div>';
                }, minWidth: 80
            }
            , {field: 'nickname', title: '作者昵称', align: 'center'}
            , {field: 'content', title: '内容', align: 'center',minWidth: 180}
            , {field: 'isLeaveMess', title: '类别',templet: '#sexTpl', align: 'center', minWidth: 80}
            , {
                field: 'createTime',
                title: '创建时间',
                align: 'center',
                templet: '<div>{{ formatTime(d.createTime,"yyyy-MM-dd hh:mm:ss")}}</div>',
                minWidth: 170
            }
            , {title: '操作', toolbar: '#barDemo', align: 'center', minWidth: 150}
        ]]
        , page: true // 开启分页
    });

    table.on('tool(remarkList)', function (obj) {
        var data = obj.data;
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

        if (obj.event === 'delete') {
            layer.confirm('确定要删除么？', function (index) {
                $.ajax({
                    url: ctx + '/admin/delRemarkById/' + data.remarkId,
                    type: "get",
                    success: function (d) {
                        if (d.code == 0) {
                            layer.msg("删除成功！", {icon: 1});
                            table.reload('remarkList', {})
                        } else {
                            layer.msg("删除失败！", {icon: 5});
                        }
                    }
                });
                layer.close(index);
            });
        }
    });

    $(".search_btn").click(function () {
        var type = $(this).data('type');
        active[type] ? active[type].call(this) : '';
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
