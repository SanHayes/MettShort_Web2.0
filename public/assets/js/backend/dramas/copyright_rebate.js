define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'dramas/copyright_rebate/index' + location.search,
                    add_url: 'dramas/copyright_rebate/add',
                    edit_url: 'dramas/copyright_rebate/edit',
                    del_url: 'dramas/copyright_rebate/del',
                    multi_url: 'dramas/copyright_rebate/multi',
                    import_url: 'dramas/copyright_rebate/import',
                    table: 'dramas_copyright_rebate',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                fixedColumns: true,
                fixedRightNumber: 1,
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {field: 'copyright_id', title: __('Copyright_id'),
                            visible: false,
                            addclass: 'selectpage',
                            extend: 'data-source="dramas/copyright/index" data-field="name"',
                            operate: '=',
                            formatter: Table.api.formatter.search
                        },
                        {field: 'copyright.name', title: __('Copyright_id'), operate: false},
                        {field: 'fee', title: __('Fee')},
                        {field: 'rebate', title: __('Rebate'), operate:'BETWEEN'},
                        {field: 'updatetime', title: __('Updatetime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'createtime', title: __('Createtime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate}
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        recyclebin: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    'dragsort_url': ''
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: 'dramas/copyright_rebate/recyclebin' + location.search,
                pk: 'id',
                sortName: 'id',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {
                            field: 'deletetime',
                            title: __('Deletetime'),
                            operate: 'RANGE',
                            addclass: 'datetimerange',
                            formatter: Table.api.formatter.datetime
                        },
                        {
                            field: 'operate',
                            width: '140px',
                            title: __('Operate'),
                            table: table,
                            events: Table.api.events.operate,
                            buttons: [
                                {
                                    name: 'Restore',
                                    text: __('Restore'),
                                    classname: 'btn btn-xs btn-info btn-ajax btn-restoreit',
                                    icon: 'fa fa-rotate-left',
                                    url: 'dramas/copyright_rebate/restore',
                                    refresh: true
                                },
                                {
                                    name: 'Destroy',
                                    text: __('Destroy'),
                                    classname: 'btn btn-xs btn-danger btn-ajax btn-destroyit',
                                    icon: 'fa fa-times',
                                    url: 'dramas/copyright_rebate/destroy',
                                    refresh: true
                                }
                            ],
                            formatter: Table.api.formatter.operate
                        }
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },

        add: function () {
            Controller.api.bindevent(1);
        },
        edit: function () {
            Controller.api.bindevent(0);
        },
        api: {
            bindevent: function (type) {
                if(type){
                    $(document).on("change", "#c-copyright_id", function(){
                        var copyright_id = $("#c-copyright_id").val();
                        if(copyright_id){
                            Fast.api.ajax({
                                url: 'dramas/copyright_rebate/get_rebate_fee?copyright_id='+copyright_id,
                            }, function (data, ret) {
                                $("#c-rebate_fee").val(data['rebate']);
                                var data_rule = "required;range(1~);range(~"+data['rebate']+")"
                                $("#c-fee").attr('data-rule', data_rule)
                                return false;
                            });
                        }else{
                            $("#c-rebate_fee").val(0);
                        }
                    });
                }

                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});
