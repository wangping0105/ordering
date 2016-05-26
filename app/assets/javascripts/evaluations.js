$(function(){
    $("[name=evaluation]").on("change",function(){
        var _this = $(this)
        $.ajax({
            url: "/evaluations",
            type: 'post',
            dataType: 'json',
            data:{
                evaluation:{
                    evaluatable_id:  $(this).parent().attr("data-id"),
                    evaluatable_type: "Meal",
                    types: $(this).val()
                }
            },
            success: function(data){
                if(data.code==0){
                    alert("评价成功!");
                    location.reload();
                    $(_this).parent().remove();
                }
            }
        })
    })
})