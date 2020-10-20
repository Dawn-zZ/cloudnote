var $;
layui.use(['jquery'], function () {
    $ = layui.jquery;
    $("#a1").click(function () {
        $("#test").attr("src", "${ctx}/admin/addNote");
    });
    $("#a2").click(function () {
        $("#test").attr("src", "${ctx}/admin/personalDate");
    });
    $("#a3").click(function () {
        $("#test").attr("src", "${ctx}/admin/changePassword");
    });
    $("#a4").click(function () {
        $("#test").attr("src", "${ctx}/admin/userNoteList");
    });
    $("#a5").click(function () {
        $("#test").attr("src", "${ctx}/admin/sMNote");
    });
    $("#a6").click(function () {
        $("#test").attr("src", "${ctx}/admin/cGNote");
    });
    $("#a7").click(function () {
        $("#test").attr("src", "${ctx}/admin/getRemark");
    });

    $('.list-box dd').click(function () {
        $('.list-box dd').removeClass('new');
        $(this).addClass('new');
    });


    $('.list-box dt').on('click', function () {
        if ($(this).attr('off')) {
            $(this).removeClass('active').siblings('dd').show()
            $(this).attr('off', '')
        } else {
            $(this).addClass('active').siblings('dd').hide()
            $(this).attr('off', true)
        }
    })

});