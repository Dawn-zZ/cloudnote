layui.use(['form', 'layer', 'jquery', 'laypage', 'table', 'laytpl', 'laydate'], function () {
    var layer = parent.layer === undefined ? layui.layer : parent.layer, $ = layui.jquery, form = layui.form,
        table = layui.table, laydate = layui.laydate, laypage = layui.laypage,laytpl = layui.laytpl;
    var nowTime = new Date().valueOf();
    var max = null;
    var documentWidth = $(document).width();
    active = {
        search: function () {
            var title = $('#noteTitle');

            table.reload('checkNoteList', {
                page: {
                    curr: 1
                },
                where: {
                    noteTitle: title.val()
                }
            });
        }
    };

    table.render({
        id: 'checkNoteList'
        , elem: '#checkNoteList'
        , url: ctx + '/admin/checkNoteList'   // 数据接口
        , cellMinWidth: 80
        , method: 'post'
        , height: 'full-100'
        , width:documentWidth-40
        , title: '待审核笔记'
        , limit: 20// 每页默认数
        , limits: [10, 20, 30, 40]
        , cols: [[ // 表头
            {field: 'id', title: 'ID', sort: true, minWidth: 80, align: 'center'}
            , {
                field: 'image', title: '封面', align: 'center', event: 'seeImage', templet: function (d) {
                    return '<div><img src="'+ d.image +'" height="30px"/></div>';
                }, minWidth: 90
            }
            , {field: 'title', title: '标题', align: 'center',minWidth:120}
            , {field: 'abstr', title: '摘要', align: 'center',minWidth:160}
            , {field: 'content', title: '笔记内容', align: 'center', minWidth: 180}
            , {
                field: 'createTime',
                title: '创建时间',
                align: 'center',
                templet: '<div>{{ formatTime(d.createTime,"yyyy-MM-dd hh:mm:ss")}}</div>',
                minWidth: 170
            }
            , {title: '操作', toolbar: '#barDemo', align: 'center', minWidth: 190}
        ]]
        , page: true // 开启分页
    });

    table.on('tool(checkNoteList)', function (obj) {
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

        if (obj.event === 'no') {
            layer.confirm('确定要毙掉该笔记么？', function (index) {
                $.ajax({
                    url: ctx + '/admin/updateNoteCheckStatusById',
                    type: "get",
                    data: {
                        checkStatus: -1,
                        id: data.id
                    },
                    success: function (d) {
                        if (d.code == 0) {
                            layer.msg("更新状态成功！");
                            table.reload('checkNoteList', {})
                        } else {
                            layer.msg("更新状态失败！", {
                                icon: 5
                            });
                        }
                    }
                });
                layer.close(index);
            });
        } else if (obj.event === 'yes') {
            layer.confirm('确定要通过该笔记么？', function (index) {
                $.ajax({
                    url: ctx + '/admin/updateNoteCheckStatusById',
                    type: "get",
                    data: {
                        checkStatus: 101,
                        id: data.id
                    },
                    success: function (d) {
                        if (d.code == 0) {
                            layer.msg("更新状态成功！");
                            table.reload('checkNoteList', {})
                        } else {
                            layer.msg("更新状态失败！", {
                                icon: 5
                            });
                        }
                    }
                });
                layer.close(index);
            });
        }else if (obj.event ==='look'){
            var editIndex = layer.open({
                type: 2,
                title: "查看笔记",
                area: ['80%', '80%'],
                content: ctx + "/admin/showNote/" + data.id,
                success: function (layero, index) {

                }
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
