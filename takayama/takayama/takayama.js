var datatable = ""

$(document).ready(function(){
    datetimepicker_load()
})

function datetimepicker_load(){
    $('.datetimepicker-master').datetimepicker({
        dayViewHeaderFormat: 'YYYY年 M月',
        tooltips: {
            close: '閉じる',
            selectMonth: '月を選択',
            prevMonth: '前月',
            nextMonth: '次月',
            selectYear: '年を選択',
            prevYear: '前年',
            nextYear: '次年',
            selectTime: '時間を選択',
            selectDate: '日付を選択',
            prevDecade: '前期間',
            nextDecade: '次期間',
            selectDecade: '期間を選択',
            prevCentury: '前世紀',
            nextCentury: '次世紀'
        },
        format: 'YYYY年MM月DD日',
        locale: moment.locale('ja', {
            week: {
                dow: 0
            }
        }),
        viewMode: 'days',
        buttons: {
            showClose: true
        }
    });
}

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

function edit_execute(rid){
    data = $('#form_modal_edit').serialize();
    data += '&rid=' + rid
    $.ajax({
        url: 'edit_execute',
        type: 'post',
        data: data,
        dataType: 'json'
    }).done(function(results){
        alert(results['message'])
    }).fail(function(error){

    })
}

function modal_show(data){
    var h ="";
    h += "<script type='text/javascript'>datetimepicker_load();</script>";
    h += "<div class= 'modal fade' id='modal_edit' role='dialog'>";
    h += "<div class='modal-dialog modal-dialog-centered modal-xl text-center'>";
    h += "<div class='modal-content'>";
    h += "<div class='modal-header'>";
    h += "<button type='button' class='close' data-dismiss='modal'>&times;</button></div>";
    h += "<h4 class='text-info' style='text-align: left; padding-left: 35px;'><i class='far fa-edit'></i>保険者　改定</h4>";
    h += "<div class='modal-body'>";
    h += "<div class='container'>";
    h += "<div class='card text-center text-dark w-100 mx-auto'>";
    h += "<div class='card-body mx-auto mt-3'>";
	h += "<form id='form_modal_edit' onsubmit='create_event()'>";
    h += "<div class='form-group row'>";
	h += "<label for='name' class='col-md-3 col-form-label'>保険種別TCD</label>";
	h += "<div class='col-md-3'>";
	h += "<input class='form-control' name='insurance_category_tcd' type='text'" + ' value="'+ data['items']['insurance_category_tcd']+'"' +"/></div>";																									
    h += "<label for='name' class='col-md-3 col-form-label'>保険者法別番号</label>";
    h += "<div class='col-md-3'>";
    h += "<input class='form-control' name='insurer_law_number' type='text'" + ' value="'+ data['items']['insurer_law_number']+'"' +"/></div></div>";	
    h += "<div class='form-group row'>";
    h += "<label for='name' class='col-md-3 col-form-label'>保険者都道府県番号</label>";
    h += "<div class='col-md-3'>";
    h += "<input class='form-control' name='insurer_pref_number' type='text'" + ' value="'+ data['items']['insurer_pref_number']+'"' +"/></div>";	
    h += "<label for='name' class='col-md-3 col-form-label'>電話番号</label>";
    h += "<div class='col-md-3'>";
    h += "<input class='form-control' name='phone_number' type='text'" + ' value="'+ data['items']['phone_number']+'"' +"/></div></div>";
    h += "<div class='form-group row'>";
    h += "<label for='name' class='col-md-3 col-form-label'>保険者番号</label>";
    h += "<div class='col-md-3'>";
    h += "<input class='form-control' name='insurer_number' type='text'" + ' value="'+ data['items']['insurer_number']+'"' +"/></div></div>";
    h += "<div class='form-group row'>";
    h += "<label for='name' class='col-md-3 col-form-label'>作成者</label>";
    h += "<div class='col-md-3'>";
    h += "<input class='form-control' name='create_user' type='text'" + ' value="'+ data['items']['create_user']+'"' +"/></div></div>";
    h += "<div class='form-group row'>";
    h += "<label for='name' class='col-md-3 col-form-label'>作成日</label>";
    h += "<div class='col-md-4'>";
    h += "<div class='input-group date datetimepicker-master' id='datetimepicker-edit-1-1' data-target-input='nearest'>";
    h += "<input class='form-control datetimepicker-input' data-target='#datetimepicker-edit-1-1' name='create_date' type='text'" + ' value="'+ data['items']['create_date']+'"' +"/>";
    h += "<div class='input-group-prepend' data-target='#datetimepicker-edit-1-1' data-toggle='datetimepicker'>";
    h += "<div class='input-group-text'><i class='fa fa-calendar-alt'></i></div></div></div></div></div>";
    h += "<div class='form-group row'>";
    h += "<label for='name' class='col-md-3 col-form-label'>更新者</label>";
    h += "<div class='col-md-3'>";
    h += "<input class='form-control' name='update_user' type='text'" + ' value="'+ data['items']['update_user']+'"' +"/></div></div>";
    h += "<div class='form-group row'>";
    h += "<label for='name' class='col-md-3 col-form-label'>更新日</label>";
    h += "<div class='col-md-4'>";
    h += "<div class='input-group date datetimepicker-master' id='datetimepicker-edit-2-1' data-target-input='nearest'>";
    h += "<input class='form-control datetimepicker-input' data-target='#datetimepicker-edit-2-1' name='update_date' type='text'" + ' value="'+ data['items']['update_date']+'"' +"/>";
    h += "<div class='input-group-prepend' data-target='#datetimepicker-edit-2-1' data-toggle='datetimepicker'>";
    h += "<div class='input-group-text'><i class='fa fa-calendar-alt'></i></div></div></div></div></div>";
    h += "</form></div></div></div></div>";
    h += "<div class='modal-footer'>";
    h += "<button type='button' class='btn btn-info' data-toggle='modal'" + 'onclick=edit_execute("' + data['rid']+ '");> 実行</button>'
	h += "<button type='button' class='btn btn-info' data-dismiss='modal'>閉じる</button></div>"
	h += "</div></div></div></div>";									
    $('body').prepend(h);
    modal = $('#modal_edit').modal();
}

