function create_event(){
    var data = $('#'+'form_modal_create').serialize();
    $.ajax({
        url: 'create',
        type: 'post',
        data: data,
        dataType: 'json',
        cache: false
        
    }).done(function(results){
        if (results['status'] == 200){
            alert(results['message']);
        }
    }).fail(function(results){
        alert(results['error']);
    });
}
function search_event(){
    
    $.ajax({
        url: 'header',
        type: 'post',
        data: '',
        dataType: 'json',
        cache: false,
    }).done(function(results){    
        create_datatable(results);
    }).fail(function(results){
        com.msg.popup.danger("Error");
    });
        
function create_datatable(results){
    var data = $('#'+'form_main').serialize();
    var data_table_option = {
        "processing": true,
        "serverSide": true,
        "colums": results['header'],
        "paging": true,
        "pageLength": 1,
        "searching": true,
        "ordering": true,
        "info": true,
        "autoWidth": true,
        "scrollX": true,
        "scrollY": 400,
        "scrollColapse": true,
        "ajax": {
            "url": "create_table",
            "type": "post",
            "data": data
        },
        "select": {
            "style": "single"
        }
    };
    $('#' + 'search_list').DataTable(data_table_option);
}
}