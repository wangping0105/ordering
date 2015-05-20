

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
    var inp=$(value).parent().parent().find('input');
    if($(inp[2]).val()==""){
        alert('数量不能为空！');
        return false;
    }
    $(value).parent().parent().find('form').submit();

}
