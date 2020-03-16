
var datatable = ""
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
}

function create_datatable(results){
    var data = $('#'+'form_main').serialize();
    var riddata = []
    $.fn.dataTable.ext.errMode = 'none';
    var data_table_option = {
        "destroy": true,
        "processing": true,
        "serverSide": true,
        "columns": results['header'],
        "paging": true,
        "searching": true,
        "ordering": true,
        "autoFill": true,
        "stateSave": true,
        "autoWidth": true,
        "scrollX": true,
        "scrollY": 350,
        "scrollColapse": true,
        "lengthMenu": [5, 10, 15, 20, -1],
        "language": {
            "lengthMenu": "表示件数 _MENU_",
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
                for (var i in json.riddata){
                    riddata.push(json.riddata[i])
                }
                return json.data;
            }
        },
        "select": "single",
        "createdRow": function(row, data, dataIndex){
            $(row).attr('id',dataIndex);
            $(row).attr('dataid',riddata[dataIndex])
        }
    };
    table = $('#search_list').DataTable(data_table_option);
    datatable = table;
    table.off('search.dt');
    table.off('init.dt');
    table.off('select.dt');
    table.off('deselect.dt');
}

function edit_event(){
    items = [];
    var selects = datatable.rows({
        selected: true
    });
    for (var key in selects[0])
        select = selects[0][key];
        try {
            var item = $('#'+ select);
            var i = item.attr('dataid');
            items.push(i);
        } catch (e) {
            console.log(e);
        }
    $.ajax({
        url: 'edit',
        type: 'post',
        data: {'rid':items[0]},
        dataType: 'json',
        cache: false
    }).done(function(results) {
        modal_show(results)
    }).fail(function(error){

    })
}

function modal_show(data){
    var h ="";
    h += "<div class= 'modal fade' id='modal_edit' role='dialog'>";
    h += "<div class='modal-content'>";
    h += "<div class='modal-header'>";
    h += "<button type='button' class='close' data-dismiss='modal'>&times;</button></div>";
    h += "<div class='modal-body'>";
    h += "<form role='form'>";
    h += "<div class='from-group'> <label for='TEST'>TEST</label> <input type='text' class='form-control' id='test'></div>";
    h += "</div></div></div>";
    modal = $('#modal_edit').modal();
}