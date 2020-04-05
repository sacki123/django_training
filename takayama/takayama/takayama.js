var datatable = {};
var checkbox_checked = false;
var form_main = 'form_main';
$(document).ready(function(){
    document_ready();
    disabled_button();
})

function document_ready(){
    $.ajax({
        url: 'load_page',
        type: 'post',
        data: '',
        dataType: 'json'
    }).done(function(results){
        include_html(results, form_main);
        datetimepicker_load();
    }).fail(function(error){
        alert(error)['message'];
    })
}

function load_page(json, form){
    var h = "";
    d = 0;
    var items = json['items'];
    for (var i in items){
        if (d % 2 == 0){
            h+= "<div class='form-group row'>";
        }
        h+= "<label for='name' class='col-md-3 col-form-label'>" + items[i]['logic_name'] + '</label>';
        if (items[i]['type_data'] == 'IntegerField' || items[i]['type_data'] == 'TextField'){
            h+= "<div class='col-md-3'>";
            h += "<input class='form-control' name=" + "'" + items[i]['name']+ "'" +  " type='text'/> </div>";
        }
        else if (items[i]['type_data'] == 'DateField'){
            h += "<div class='col-md-3'> <div class='input-group date datetimepicker-master' id=" + "'" + items[i]['name'] + "_" + form + "'" + " data-target-input='nearest'>" ;
            h += "<input class='form-control datetimepicker-input' data-target=" + "'#" + items[i]['name'] + "_" + form + "'" + 'name=' + "'" + items[i]['name'] + "'" +  " type='text'/>";
            h += "<div class='input-group-prepend' data-target=" + "'#" + items[i]['name'] + "_" + form + "'" + " data-toggle='datetimepicker'>";
            h += "<div class='input-group-text'><i class='fa fa-calendar-alt'></i></div></div></div></div>" 
        }
        d ++;
        if (d % 2 == 0){
            h += "</div>"
        }      
    }
    return h;
}

function include_html(json, form){
    var h = "";
    h = load_page(json, form);
    $("#" + form).prepend(h); 
}

function disabled_button(){
    $('#btn_edit_main').attr('disabled', true);
    $('#btn_delete_main').attr('disabled', true);
    $('#btn_export_main').attr('disabled', true);
}

function enabled_button(){
    $('#btn_edit_main').removeAttr('disabled');
    $('#btn_delete_main').removeAttr('disabled');
    $('#btn_export_main').removeAttr('disabled');
}

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
    $('#btn_create').attr('disabled', true);
    var data = $('#'+'form_modal').serialize();
    $.ajax({
        url: 'create',
        type: 'post',
        data: data,
        dataType: 'json',
        cache: false
        
    }).done(function(results){
        if (results['status'] == 200){
            alert(results['message']);
            $('#modal_show').modal('hide');
            search_event();
        }
    }).fail(function(results){
        alert(results['error']);
    });
}

function search_event(){
    disabled_button();
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
    if (datatable['search']){
        datatable['search'].destroy();
    }
    $.fn.dataTable.ext.errMode = 'none';
    var riddata = [];
    var displaystart = 0;
    var data_table_option = {
        "processing": true,
        "serverSide": true,
        "destroy": true,
        "pageLength": 5,
        "paging": true,
        "searching": true,
        "ordering": true,
        "autoFill": true,
        "stateSave": true,
        "autoWidth": true,
        "scrollX": true,
        "scrollY": 350,
        "scrollColapse": true,
        "lengthMenu": [[5, 10, 15, 20, -1], ['5', '10', '15', '20', "全件"]],
        "language": {
            "lengthMenu": "表示件数 _MENU_",
            "sProcessing": "処理中...",
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
            "data": function(d){
                return $.extend({}, d, {'data_table': data, 'display_start': displaystart});
            },
            "dataSrc": function(json){
                riddata.length = 0;
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
        },
        "columns": results['header'],
    };
    table = $('#search_list').DataTable(data_table_option);
    datatable['search'] = table;
    table.off('search.dt');
    table.off('init.dt');
    table.off('select.dt');
    table.off('deselect.dt');
    table.on('search.dt', function(e, settings) {
        var lastsort = settings.aLastSort[0];
        var sorting = settings.aaSorting[0];
        if (lastsort.col == sorting[0] && lastsort.dir == sorting[1]) {
          displaystart = settings._iDisplayStart;
        } else {
          displaystart = 0;
        }
      });
    $('#search_list tbody').on('click', 'tr', function(){
        if (!$(this).hasClass('selected')){
            enabled_button(); 
        }
        else {
            disabled_button();
        }
    })
}

function get_data_for_modal(event){
    items = [];
    var selects = datatable['search'].rows({
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
        url: 'modal_show',
        type: 'post',
        data: {'rid':items[0]},
        dataType: 'json',
        cache: false,
        async: false
    }).done(function(results) {
        modal_edit_delete(event, results);
    }).fail(function(error){
        alert(error['error']);
    })
}

function edit_delete_execute(id, rid){
    var conf = true;
    $('#bt_' + id).attr('disabled', true);
    if (id == 'delete'){
        conf = confirm('削除したいですか?')
    }
    if (id == 'edit'){
        conf = confirm('編集したいですか?') 
    }    
    if (conf == true){
        data = $('#form_modal_' + id).serialize();
        data += '&rid=' + rid;
        $.ajax({
            url: id + '_execute',
            type: 'post',
            data: data,
            dataType: 'json'
        }).done(function(results){
            alert(results['message']);
            $('#modal_'+ id).modal('hide');
            clear_html("form_modal_" + id);
            search_event();
        }).fail(function(error){
            alert(error['message']);
        })
    }
    else $('#bt_' + id).removeAttr('disabled', true);
};

function get_name_model(){
    items = [];
    checkbox_checked = false;
    var selects = datatable['search'].rows({
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
        url: 'name_model',
        type: 'post',
        data: {'rid':items[0]},
        dataType: 'json',
        cache: false
    }).done(function(results) {
        modal_export(results);
    }).fail(function(error){
        alert(error['error']);
    })
};

function export_file(rid){
    // $('#bt_export').attr('disabled', true);
    data = $('#form_modal_export').serialize();
    data += '&rid=' + rid;
    $.ajax({
        url: 'excel',
        type: 'post',
        data: data,
        dataType: 'json'
    }).done(function(results){
        location.href = results['url'];
    }).fail(function(error){
        alert(error['message']);
    })
};

function checkbox_all(){
    
    if (checkbox_checked == false){
        checkbox = $('.checkbox_export').prop('checked', true);
        checkbox_checked = true;
        btn_checkbox = $('#select_all');
        btn_checkbox.text('未チェック');
        btn_checkbox.removeClass('btn-info');
        btn_checkbox.addClass('btn-danger');
    }
    else {
        checkbox = $('.checkbox_export').prop('checked', false);
        checkbox_checked = false;
        btn_checkbox = $('#select_all');
        btn_checkbox.text('チェック済み');
        btn_checkbox.removeClass('btn-danger');
        btn_checkbox.addClass('btn-info');
    }
}

// function modal_show(id, data){
//     var h ="";
//     h += "<script type='text/javascript'>datetimepicker_load();</script>";
//     h += "<div class= 'modal fade' id=" + "'modal_" + id + "'" + "role='dialog'>";
//     h += "<div class='modal-dialog modal-dialog-centered modal-xl text-center'>";
//     h += "<div class='modal-content'>";
//     h += "<div class='modal-header'>";
//     h += "<button type='button' class='close' data-dismiss='modal'>&times;</button></div>";
//     h += "<h4 class='text-info' style='text-align: left; padding-left: 35px;'><i class='far fa-edit'></i>保険者　改定</h4>";
//     h += "<div class='modal-body'>";
//     h += "<div class='container'>";
//     h += "<div class='card text-center text-dark w-100 mx-auto'>";
//     h += "<div class='card-body mx-auto mt-3'>";
// 	h += "<form role='form' id='form_modal_" + id + "'" + ">";
//     h += "<div class='form-group row'>";
// 	h += "<label for='name' class='col-md-3 col-form-label'>保険種別TCD</label>";
// 	h += "<div class='col-md-3'>";
// 	h += "<input class='form-control' name='insurance_category_tcd' type='text'" + ' value="'+ data['items']['insurance_category_tcd']+'"' +"/></div>";																									
//     h += "<label for='name' class='col-md-3 col-form-label'>保険者法別番号</label>";
//     h += "<div class='col-md-3'>";
//     h += "<input class='form-control' name='insurer_law_number' type='text'" + ' value="'+ data['items']['insurer_law_number']+'"' +"/></div></div>";	
//     h += "<div class='form-group row'>";
//     h += "<label for='name' class='col-md-3 col-form-label'>保険者都道府県番号</label>";
//     h += "<div class='col-md-3'>";
//     h += "<input class='form-control' name='insurer_pref_number' type='text'" + ' value="'+ data['items']['insurer_pref_number']+'"' +"/></div>";	
//     h += "<label for='name' class='col-md-3 col-form-label'>電話番号</label>";
//     h += "<div class='col-md-3'>";
//     h += "<input class='form-control' name='phone_number' type='text'" + ' value="'+ data['items']['phone_number']+'"' +"/></div></div>";
//     h += "<div class='form-group row'>";
//     h += "<label for='name' class='col-md-3 col-form-label'>保険者番号</label>";
//     h += "<div class='col-md-3'>";
//     h += "<input class='form-control' name='insurer_number' type='text'" + ' value="'+ data['items']['insurer_number']+'"' +"/></div></div>";
//     h += "<div class='form-group row'>";
//     h += "<label for='name' class='col-md-3 col-form-label'>作成者</label>";
//     h += "<div class='col-md-3'>";
//     h += "<input class='form-control' name='create_user' type='text'" + ' value="'+ data['items']['create_user']+'"' +"/></div></div>";
//     h += "<div class='form-group row'>";
//     h += "<label for='name' class='col-md-3 col-form-label'>作成日</label>";
//     h += "<div class='col-md-4'>";
//     h += "<div class='input-group date datetimepicker-master' id='datetimepicker-edit-1-1' data-target-input='nearest'>";
//     h += "<input class='form-control datetimepicker-input' data-target='#datetimepicker-edit-1-1' name='create_date' type='text'" + ' value="'+ data['items']['create_date']+'"' +"/>";
//     h += "<div class='input-group-prepend' data-target='#datetimepicker-edit-1-1' data-toggle='datetimepicker'>";
//     h += "<div class='input-group-text'><i class='fa fa-calendar-alt'></i></div></div></div></div></div>";
//     h += "<div class='form-group row'>";
//     h += "<label for='name' class='col-md-3 col-form-label'>更新者</label>";
//     h += "<div class='col-md-3'>";
//     h += "<input class='form-control' name='update_user' type='text'" + ' value="'+ data['items']['update_user']+'"' +"/></div></div>";
//     h += "<div class='form-group row'>";
//     h += "<label for='name' class='col-md-3 col-form-label'>更新日</label>";
//     h += "<div class='col-md-4'>";
//     h += "<div class='input-group date datetimepicker-master' id='datetimepicker-edit-2-1' data-target-input='nearest'>";
//     h += "<input class='form-control datetimepicker-input' data-target='#datetimepicker-edit-2-1' name='update_date' type='text'" + ' value="'+ data['items']['update_date']+'"' +"/>";
//     h += "<div class='input-group-prepend' data-target='#datetimepicker-edit-2-1' data-toggle='datetimepicker'>";
//     h += "<div class='input-group-text'><i class='fa fa-calendar-alt'></i></div></div></div></div></div>";
//     h += "</form></div></div></div></div>";
//     h += "<div class='modal-footer'>";
//     h += "<button id='bt_" + id + "'" + "type='button' class='btn btn-info' data-toggle='modal'" + 'onclick=edit_delete_execute(' + "'" + id + "'" + ',' + "'" + data['rid'] + "'" + ');> 実行</button>'
// 	h += "<button id='bt_close' type='button' class='btn btn-info' data-dismiss='modal'" + 'onclick=search_event(); >閉じる</button></div>'
// 	h += "</div></div></div></div>";									
//     $('body').prepend(h);
//     modal = $('#modal_'+ id).modal({
//         'backdrop': 'static',
//         'keyboard': false,
//         'show': true,
//         'focus': false
//     });
// }

function modal_export(data){
    h = "";
    h += "<div class= 'modal fade' id='modal_export' role='dialog'>";
    h += "<div class='modal-dialog modal-dialog-centered modal-xl'>";
    h += "<div class='modal-content'>";
    h += "<div class='modal-header'style='background-color: mediumseagree;'>";
    h += "<button type='button' class='close' data-dismiss='modal'>&times;</button></div>";
    h += "<h4 class='text-info' style='text-align: left; padding-left: 35px;'><i class='fa fa-edit'></i>保険者　エクスポート</h4>";
    h += "<div class='modal-body'>";
    h += "<div class='container'>";
    h += "<div class='row-fluid'>";
	h += "<form class='form-horizontal' role='form' id='form_modal_export'>";
    h += "<div class='form-group'>";
	h += "<label for='name' class='col-xs-3 col-md-2 col-form-label'>ファイル形式<span class='badge badge-pill badge-danger'>必須</span></label>";
	h += "<div class='col-xs-8 col-md-7'>";
    h += "<select class='form-control input-xlarge' id='select_export' name='choice'>";
    h += "<option value='excel' selected>EXCEL</option>";
    h += "<option value='json'>JSON</option></select></div></div>";
    h += "<div class='col-xs-8 col-md-2'>";
    h += "<button type='button' id='select_all' class='btn btn-info' onclick='checkbox_all()'>チェック済み</button></div>";
    h += "<div class='form-group checkbox_master'>";
    for (var key in data['name']){
        h += '<label class="form-check-label"><input' + " class='checkbox_export'" + ' name='+ "'" + key +"'" + ' id='+ "'" + key +"'" + " type='checkbox'/>" + data['name'][key] + '</label>';
    }
    h += "</form></div></div></div>";
    h += "<div class='modal-footer'>";
    h += "<button type='button' id='bt_export' class='btn btn-info'" + 'onclick=export_file(' + "'" + data['rid'] + "'" + ");>実行</button>"
    h += "<button id='bt_close' type='button' class='btn btn-info' data-dismiss='modal'" + 'onclick=search_event(); >閉じる</button></div>'
    h += "</div></div></div></div>";
    $('body').prepend(h);
    $('#modal_export').modal({
        'backdrop': 'static',
        'keyboard': false,
        'show': true,
        'focus': false
    });
}

function modal_dialog(data){
    h = "";
    h += "<div class='modal-dialog modal-dialog-centered modal-xl' role='document'>";
    h += "<div class='modal-content'>";
    h += "<div class='modal-header'style='background-color: mediumseagree;'>";
    h += "<button type='button' class='close' data-dismiss='modal'>&times;</button></div>";
    h += "<h4 class='text-info' style='text-align: left; padding-left: 35px;'><i class='far fa-edit'></i>保険者　エクスポート</h4>";
    h += "<div class='modal-body'>";
    h += "<div class='container'>";
    h += "<div class='card text-center text-dark w-100 mx-auto'>";
    h += "<div class='card-body mx-auto mt-3'>";
	h += "<form role='form' id='form_modal_" + id + "'" + ">";
}
// Show Modal
function modal_show(){
    var form_modal = 'form_modal';
    $.ajax({
        url: 'load_page',
        type: 'post',
        data: '',
        dataType: 'json',
        cache: false,
        async: false
    }).done(function(results){
        var h = "";
        h = load_page(results, form_modal);
        $('#form_modal').prepend(h); 
        datetimepicker_load();
    }).fail(function(error){
        alert(error['message']);
    })
}
// Show Modal Create
function modal_create(){
    modal_show();
    $('#btn_modal_action').attr('onclick', "create_event();")
}
// Show Modal Edit
function modal_edit_delete(event, json){
    var items = json['items'];
    modal_show();
    for (var value in items){
        if ((value == 'rid') || (value == 'did')){
            continue
        }
        $('#form_modal' + ' [name=' + value + ']').attr('value', items[value]);
    }
    $('#btn_modal_action').attr('onclick', "edit_delete_execute();")


}

function clear_html(form_id){
   $('#' + form_id).children().remove();
}
