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
        alert(results['message']);
    });
        
function create_datatable(results){
    var data = $('#'+'form_main').serialize();
    var data_table_option = {
        "destroy": true,
        "processing": true,
        "serverSide": true,
        "columns": results['header'],
        "paging": true,
        "pageLength": 10,
        "searching": true,
        "ordering": true,
        "info": true,
        "autoFill": true,
        "stateSave": true,
        "autoWidth": true,
        "scrollX": true,
        "scrollY": 400,
        "scrollColapse": true,
        "language": {
            "lengthMenu": "表示件数 _MENU_",
            "loadingRecords": "読みこみ中・・・",
            "zeroRecords": "該当するデータがありませんでした。",
            "info": "_PAGE_ページ目 / 全_PAGES_ページ中",
            "infoEmpty": "該当するデータがありませんでした。",
            "infoFiltered": " [全_MAX_件からフィルタ中]",
            "search": "検索 ",
            "searchPlaceholder": "キーワード",
            "paginate": {
              "first": "最初",
              "last": "最後",
              "next": "次へ",
              "previous": "戻る"
            }
          },
        "ajax": {
            "url": "create_table",
            "type": "post",
            "data": {
                'data_table': data
            },
            "dataSrc": function(json){
                return json.data;
            }
        },
        "select": "single",
        "createdRow": function(row, data, dataIndex){
            $(row).attr('id',dataIndex);
            // $(row).attr('dataid',)
        }
    };
    table = $('#search_list').DataTable(data_table_option);
    table.off('search.dt');
    table.off('init.dt')
    table.off('select.dt')
    table.off('deselect.dt')
}
}