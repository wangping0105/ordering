function delete_order(id){
            $.ajax({
                type : 'get',
                url:'/destory',
                dataType:"text",
                data  :"id=" + id,
                success:function(data){
                    location.reload();
                }
            });
}
function check_num(value){
    var inp=$(value).parent().parent().find('#order_num');
    if(inp.val()==""){
        alert('数量不能为空！');
        return false;
    }
    $(value).parents("tr").find('form').submit();

}
//head 用的
function get_now_time(time_str){
    var d = new moment();
    var d1 = parseInt(time_str);
    var i = d/1000 - d1
    var h = parseInt(i/3600, 10);
    var m = parseInt(i/60, 10) - h*60;
    var s = parseInt(i, 10)- h*3600- m*60;
    //console.log(s)
    var time = "距离点餐开始已经："+h+"小时"+m+"分"+s+'秒';
    var str = '星期'+'日一二三四五六'.charAt(new Date().getDay());
    return time;
}
