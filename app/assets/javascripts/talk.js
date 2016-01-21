function show_each_1s(url){
    $.ajax({
        url: url,
        type:'get',
        dataType: 'script',
        success:function(){

        }
    })
}

function send_btn(obj){
    var c =$(obj).parents("form").find("input[name=content]").val();
    if($.trim(c)==""){
        alert("内容不能为空！");
        $(obj).parents("form").preventDefault()
        return false;
    }
}