define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'dramas/block/index' + location.search,
                    add_url: 'dramas/block/add',
                    edit_url: 'dramas/block/edit',
                    del_url: 'dramas/block/del',
                    multi_url: 'dramas/block/multi',
                    import_url: 'dramas/block/import',
                    table: 'dramas_block',
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
                        {field: 'image', title: __('Image'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.image},
                        {field: 'parsetpl', title: __('Parsetpl'), searchList: {"0":__('Parsetpl 0'),"1":__('Parsetpl 1')}, formatter: Table.api.formatter.normal},
                        {field: 'url', title: __('Url'), operate: false, formatter: function (value, row, index) {
                                var urlObj = $.extend({}, this);
                                if(row['parsetpl'] == 0){
                                    return Table.api.formatter.url.call(urlObj, value, row, index);
                                }else{
                                    return row['url_title'];
                                }
                            }},
                        {field: 'weigh', title: __('Weigh'), operate: false},
                        {field: 'updatetime', title: __('Updatetime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'status', title: __('Status'), searchList: {"normal":__('Status normal'),"hidden":__('Status hidden')}, formatter: Table.api.formatter.status},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate}
                    ]
                ]
            });

            $(document).on('click', '.btn-sync', function () {
                Layer.confirm(__('Import test data'), {icon: 3, title: __('Import'), btn: [__('Ok'), __('Cancel')]}, function () {
                    Fast.api.ajax({
                        url: 'dramas/block/sync',
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
                $(document).on("change", "#c-lang_id", function(){
                    // $("#c-video_id").data("params", function (obj) {
                    //     //obj为SelectPage对象
                    //     return {custom: {lang_id: $("#c-lang_id").val()}};
                    // });
                });
                $("#c-lang_id").trigger("change", true);

                $(document).on("change", "#c-parsetpl", function () {
                    if($(this).val() == 0){
                        $("#parsetpl_url").removeClass('input-group pull-left')
                        $(".chooseButton").hide();
                        setTimeout(() => {
                            if($("#c-url_title").val() != ''){
                                $("#c-url").val('')
                            }
                            $("#c-url_title").val('');
                        }, 100)
                        document.getElementById('c-url_title').setAttribute('type', 'hidden');
                        document.getElementById('c-url').setAttribute('type', 'text');
                    }else{
                        $("#parsetpl_url").addClass('input-group pull-left')
                        $(".chooseButton").show();
                        setTimeout(() => {
                            if($("#c-url_title").val() == ''){
                                $("#c-url").val('')
                            }
                        }, 100)
                        document.getElementById('c-url').setAttribute('type', 'hidden');
                        document.getElementById('c-url_title').setAttribute('type', 'text');
                    }
                });
                if ($("#c-parsetpl").val() >= 0) {
                    $("#c-parsetpl").trigger("change", true);
                }

                //选择链接Path
                $(document).on("click", ".choosePath", function () {
                    var that = this;
                    var multiple = $(this).data("multiple") ? $(this).data("multiple") : false;
                    parent.Fast.api.open("dramas/user_rule/select?multiple=" + multiple, __('Select'), {
                        callback: function (data) {
                            $("#c-url").val(data.data.path)
                            $("#c-url_title").val(data.data.path_name)
                        }
                    });
                    return false;
                })

                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});
