define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'dramas/usable/index' + location.search,
                    add_url: 'dramas/usable/add',
                    edit_url: 'dramas/usable/edit',
                    del_url: 'dramas/usable/del',
                    multi_url: 'dramas/usable/multi',
                    import_url: 'dramas/usable/import',
                    table: 'dramas_usable',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'weigh',
                fixedColumns: true,
                fixedRightNumber: 1,
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {field: 'lang_id', title: __('Lang_id'), searchList: Config.langList, formatter: function (value, row, index) {
                                return Config.langList[value];
                            }},
                        {field: 'title', title: __('Title'), operate: 'LIKE'},
                        // {field: 'image', title: __('Image'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.image},
                        {field: 'flag', title: __('Flag'), operate: 'LIKE', formatter: Table.api.formatter.flag},
                        {field: 'desc', title: __('Desc'), operate: 'LIKE'},
                        {field: 'usable', title: __('Usable')},
                        {field: 'original_usable', title: __('Original_usable'), operate:false},
                        {field: 'give_usable', title: __('Give_usable'), operate:false},
                        {field: 'price', title: __('Price'), operate:'BETWEEN'},
                        {field: 'give_price', title: __('Give_price'), operate:false},
                        // {field: 'first_price', title: __('First_price'), operate:'BETWEEN'},
                        {field: 'original_price', title: __('Original_price'), operate:'BETWEEN'},
                        {field: 'status', title: __('Status'), searchList: {"0":__('Status 0'),"1":__('Status 1')}, formatter: Table.api.formatter.status},
                        {field: 'weigh', title: __('Weigh'), operate: false},
                        {field: 'updatetime', title: __('Updatetime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate}
                    ]
                ]
            });

            $(document).on('click', '.btn-sync', function () {
                Layer.confirm(__('Import test data'), {icon: 3, title: __('Import'), btn: [__('Ok'), __('Cancel')]}, function () {
                    Fast.api.ajax({
                        url: 'dramas/usable/sync',
                    }, function (data, ret) {
                        $(".btn-refresh").trigger("click");
                        Layer.closeAll();
                    });
                });
                return false;
            });
            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        add: function () {
            Controller.api.bindevent();
        },
        edit: function () {
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});