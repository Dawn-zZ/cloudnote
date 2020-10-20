var $;
layui.use(['laypage', 'jquery'], function () {
    var laypage = layui.laypage;
    $ = layui.jquery;
    //画canvas
    DrawCanvas();
    //最热文章获取
    $.getJSON(ctx+"/getHotNote",function(res){
        var content="";
        $.each(res, function (i, hotNote) {
            content+="<li><i class=\"layui-icon\">&#xe609;</i> <a href=\""+ctx+"/detail/"+hotNote.id+"\">"+hotNote.title+"</a></li>";
        });
        $('#hotNote').html(content);
    });

    var url = ctx + "/note";
    var config = {page: 1, limit: 5};//page:起始页;limit:页面容量;

    showForeNote(url, config);

    //前台获取共享笔记列表
    function showForeNote(url, config) {

        $.ajax({
            url: url,
            data:config,
            type:'post',
            success:function (res) {
                laypage.render({
                    elem: 'page',
                    count: res.count, //总条数
                    limit: config.limit, //每页条数
                    theme: '#009688', //自定义颜色
                    jump: function (obj, first) {
                        if (!first) { //首次则不进入
                            config.page = obj.curr;
                            getNoteListByPage(url, config);
                        }
                    }
                });
                parseNoteList(res, config.page);
            }
        });
    }

    //监听搜索按钮
    $(".search-btn").click(function () {
        var title = $('#title').val();
        config = {page: 1, limit: 5, title: title};
        showForeNote(url, config);
    });

});

function getNoteListByPage(url, config) {
    $.ajax({
        url: url,
        data:config,
        type:'post',
        success:function (res) {
            parseNoteList(res, config.page);
        }
    });
}

//向前端输出数据
function parseNoteList(res, currPage) {
    var content = "";
    $.each(res.data, function (i, o) {
        content += "<div class='article shadow'>" +
            "<div class='article-left'>" +
            "<img src='" + o.image + "'/>" +
            "</div>" +
            "<div class='article-right'>" +
            "<div class='article-title'>" +
            "<a href='" + ctx + "/detail/" + o.id + "'>" + o.title + "</a>" +
            "</div>" +
            "<div class='article-abstract'>" +
            "" + o.abstr + "" +
            "</div>" +
            "</div>" +
            "<div class='clear'></div>" +
            "<div class='article-footer'>" +
            "<span><i class='layui-icon'>&#xe60e;</i>&nbsp;&nbsp;" + formatTime(o.createTime, "yyyy-MM-dd hh:mm:ss") + "</span>" +
            "<span class='article-author'><i class='layui-icon'>&#xe612;</i>&nbsp;&nbsp;" + o.author + "</span>" +
            "<span class='article-viewinfo'><i class='layui-icon'>&#xe615;</i>&nbsp;&nbsp;" + o.viewNum + "</span>" +
            "</div>" +
            "</div>";
    });
    $('.note').html(content);
}

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


function DrawCanvas() {
    var $ = layui.jquery;
    var canvas = document.getElementById('canvas-banner');
    canvas.width = window.document.body.clientWidth;    //需要重新设置canvas宽度，因为dom加载完毕后有可能没有滚动条
    var ctx = canvas.getContext('2d');

    ctx.strokeStyle = (new Color(150)).style;

    var dotCount = 20; //圆点数量
    var dotRadius = 70; //产生连线的范围
    var dotDistance = 70;   //产生连线的最小距离
    var screenWidth = screen.width;
    if (screenWidth >= 768 && screenWidth < 992) {
        dotCount = 130;
        dotRadius = 100;
        dotDistance = 60;
    } else if (screenWidth >= 992 && screenWidth < 1200) {
        dotCount = 140;
        dotRadius = 140;
        dotDistance = 70;
    } else if (screenWidth >= 1200 && screenWidth < 1700) {
        dotCount = 140;
        dotRadius = 150;
        dotDistance = 80;
    } else if (screenWidth >= 1700) {
        dotCount = 200;
        dotRadius = 150;
        dotDistance = 80;
    }
    //默认鼠标位置 canvas 中间
    var mousePosition = {
        x: 50 * canvas.width / 100,
        y: 50 * canvas.height / 100
    };
    //小圆点
    var dots = {
        count: dotCount,
        distance: dotDistance,
        d_radius: dotRadius,
        array: []
    };

    function colorValue(min) {
        return Math.floor(Math.random() * 255 + min);
    }

    function createColorStyle(r, g, b) {
        return 'rgba(' + r + ',' + g + ',' + b + ', 0.8)';
    }

    function mixComponents(comp1, weight1, comp2, weight2) {
        return (comp1 * weight1 + comp2 * weight2) / (weight1 + weight2);
    }

    function averageColorStyles(dot1, dot2) {
        var color1 = dot1.color,
            color2 = dot2.color;

        var r = mixComponents(color1.r, dot1.radius, color2.r, dot2.radius),
            g = mixComponents(color1.g, dot1.radius, color2.g, dot2.radius),
            b = mixComponents(color1.b, dot1.radius, color2.b, dot2.radius);
        return createColorStyle(Math.floor(r), Math.floor(g), Math.floor(b));
    }

    function Color(min) {
        min = min || 0;
        this.r = colorValue(min);
        this.g = colorValue(min);
        this.b = colorValue(min);
        this.style = createColorStyle(this.r, this.g, this.b);
    }

    function Dot() {
        this.x = Math.random() * canvas.width;
        this.y = Math.random() * canvas.height;

        this.vx = -.5 + Math.random();
        this.vy = -.5 + Math.random();

        this.radius = Math.random() * 2;

        this.color = new Color();
    }

    Dot.prototype = {
        draw: function () {
            ctx.beginPath();
            ctx.fillStyle = "#fff";
            ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2, false);
            ctx.fill();
        }
    };

    function createDots() {
        for (i = 0; i < dots.count; i++) {
            dots.array.push(new Dot());
        }
    }

    function moveDots() {
        for (i = 0; i < dots.count; i++) {

            var dot = dots.array[i];

            if (dot.y < 0 || dot.y > canvas.height) {
                dot.vx = dot.vx;
                dot.vy = -dot.vy;
            } else if (dot.x < 0 || dot.x > canvas.width) {
                dot.vx = -dot.vx;
                dot.vy = dot.vy;
            }
            dot.x += dot.vx;
            dot.y += dot.vy;
        }
    }

    function connectDots1() {
        var pointx = mousePosition.x;
        for (i = 0; i < dots.count; i++) {
            for (j = 0; j < dots.count; j++) {
                i_dot = dots.array[i];
                j_dot = dots.array[j];

                if ((i_dot.x - j_dot.x) < dots.distance && (i_dot.y - j_dot.y) < dots.distance && (i_dot.x - j_dot.x) > -dots.distance && (i_dot.y - j_dot.y) > -dots.distance) {
                    if ((i_dot.x - pointx) < dots.d_radius && (i_dot.y - mousePosition.y) < dots.d_radius && (i_dot.x - pointx) > -dots.d_radius && (i_dot.y - mousePosition.y) > -dots.d_radius) {
                        ctx.beginPath();
                        ctx.strokeStyle = averageColorStyles(i_dot, j_dot);
                        ctx.moveTo(i_dot.x, i_dot.y);
                        ctx.lineTo(j_dot.x, j_dot.y);
                        ctx.stroke();
                        ctx.closePath();
                    }
                }
            }
        }
    }

    function drawDots() {
        for (i = 0; i < dots.count; i++) {
            var dot = dots.array[i];
            dot.draw();
        }
    }

    function animateDots() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        moveDots();
        connectDots1()
        drawDots();

        requestAnimationFrame(animateDots);
    }

    //鼠标在canvas上移动
    $('canvas').on('mousemove', function (e) {
        mousePosition.x = e.pageX;
        mousePosition.y = e.pageY;
    });

    //鼠标移出canvas
    $('canvas').on('mouseleave', function (e) {
        mousePosition.x = canvas.width / 2;
        mousePosition.y = canvas.height / 2;
    });

    createDots();

    requestAnimationFrame(animateDots);
}

//监听窗口大小改变
window.addEventListener("resize", resizeCanvas, false);

//窗口大小改变时改变canvas宽度
function resizeCanvas() {
    var canvas = document.getElementById('canvas-banner');
    canvas.width = window.document.body.clientWidth;
    canvas.height = window.innerHeight * 1 / 3;
}