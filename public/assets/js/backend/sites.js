define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'sites/index' + location.search,
                    add_url: 'sites/add',
                    edit_url: 'sites/edit',
                    del_url: 'sites/del',
                    multi_url: 'sites/multi',
                    import_url: 'sites/import',
                    table: 'sites',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'site_id',
                sortName: 'site_id',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'site_id', title: __('ID')},
                        {field: 'admin.username', title: __('Admin.username'), operate: false},
                        {field: 'admin.nickname', title: __('Admin.nickname'), operate: false},
                        {field: 'admin.mobile', title: __('Admin.mobile'), operate: false},
                        {field: 'sign', title: __('Sign'), operate: false, formatter: function (value, row, index) {
                                if(row['is_default'] == 1){
                                    return __('Default Site');
                                }else{
                                    return value;
                                }
                            }},
                        {field: 'h5', title: __('Wap'), operate: false, formatter: function (value, row, index) {
                                if(row['domain']){
                                    return Table.api.formatter.url(window.location.protocol+'//'+row['domain']+'/h5/');
                                }else if(row['is_default'] == 1){
                                    return Table.api.formatter.url(window.location.protocol+'//'+window.location.hostname+'/h5/');
                                }else{
                                    return Table.api.formatter.url(window.location.protocol+'//'+window.location.hostname+'/h5/?sign='+row['sign']+'#/');
                                }
                            }},
                        {field: 'status', title: __('Status'), searchList: {"normal":__('Status normal'),"hidden":__('Status hidden')}, formatter: Table.api.formatter.status},
                        {field: 'console',
                            title: __('Authorization'),
                            custom: {0: 'danger', 1: 'success'},
                            searchList: {0:__('Unauthorized'),1:__('Authorized')},
                            formatter: Table.api.formatter.label,
                            operate: false},
                        {field: 'expiretime', title: __('Expiretime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'createtime', title: __('Createtime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate, buttons: [
                                {
                                    name: 'site',
                                    text: __('Management'),
                                    classname: 'btn btn-xs btn-success btn-magic btn-click',
                                    click: function (index, row) {
                                        top.window.location.href = 'sites/to_site?site_id='+row['site_id'];
                                    }
                                }
                            ]
                        }
                    ]
                ]
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