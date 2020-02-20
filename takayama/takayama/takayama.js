function create_event(){
    var data = $('#'+'form_modal_create').serialize();
    $.ajax({
        url: 'create',
        type: 'post',
        data: data,
        dataType: 'json',
        cache: false
        
    }).done(function(results){
        alert(results['message']);
    }).fail(function(results){
        alert(results['message']);
    });
}
// function create_event(){
//     var data = $('#'+'form_modal_create').serialize();
//     $.ajax({
//         url: 'create',
//         type: 'post',
//         data: data,
//         cache: false,
//         success: function(data1){
//         com.msg.popup.danger("Success");},
//         error: function(data1){
//         com.msg.popup.danger("Error");
//     }
// })
// }