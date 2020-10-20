layui.use(['form', 'layer', 'jquery', 'table'], function () {
    var layer = layui.layer, $ = layui.jquery, form = layui.form, table = layui.table;
    var documentWidth = $(document).width();

    table.render({
        id: 'logList'
        , elem: '#adminLogList'
        , url: ctx + '/admin/getAdminLogList'//数据接口
        , toolbar: true
        , height: 'full-30'
        , cellMinWidth:80
        , title: '管理员登录日志表'
        , width:documentWidth-40
        , limit: 20//每页默认数
        , limits: [10, 20, 30, 40]
        , cols: [[ //表头
            {field: 'id', title: 'ID', minWidth: 80, sort: true, align: 'center'}
            , {field: 'adminUsername', title: '登录名', align: 'center'}
            , {field: 'roleName', title: '角色', align: 'center',minWidth:120}
            , {field: 'loginIp', title: '登录IP', align: 'center'}
            , {
                field: 'loginTime',
                title: '登录时间',
                align: 'center',
                minWidth: 170,
                templet: '<div>{{ formatTime(d.loginTime,"yyyy-MM-dd hh:mm:ss")}}</div>'
            }
        ]]
        , page: true //开启分页
        , loading: true
    });
});

//格式化时间
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
