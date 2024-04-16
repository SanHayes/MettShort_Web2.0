define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            function debounce(handle, delay) {
                let time = null;
                return function () {
                    let self = this,
                        arg = arguments;
                    clearTimeout(time);
                    time = setTimeout(function () {
                        handle.apply(self, arg);
                    }, delay)
                }
            }
            var orderIndex = new Vue({
                el: "#adLogIndex",
                data() {
                    return {
                        screenType: false,
                        langList: {},
                        platformList: {},
                        orderList: [],
                        currentPage: 1,
                        totalPage: 0,
                        offset: 0,
                        limit: 10,
                        // form搜索
                        searchForm: {
                            lang_id: 0,
                            ad_id: '',
                            status: '',
                            createtime: [moment().startOf('day').format('YYYY-MM-DD HH:mm:ss'), moment().endOf('day').format('YYYY-MM-DD HH:mm:ss')],
                            form_2_key: "user_id",
                            form_2_value: "",
                        },
                        countData: {
                            total_orders : 0,
                            total_fee : 0,
                        },
                        searchFormInit: {
                            lang_id: 0,
                            ad_id: '',
                            status: '',
                            createtime: [moment().startOf('day').format('YYYY-MM-DD HH:mm:ss'), moment().endOf('day').format('YYYY-MM-DD HH:mm:ss')],
                            form_2_key: "user_id",
                            form_2_value: "",
                        },
                        searchOp: {
                            createtime: "range",
                            lang_id: "=",
                            ad_id: "=",
                            status: '=',
                            user_id: "=",
                            nickname: "like",
                            user_email: "like",
                        },

                        focusi: false,

                        adItemLimit: 6,
                        adItemOffset: 0,
                        adItemCurrentPage: 1,
                        adItemTotalPage: 0,
                        adItemSearchPage: '',
                        aboutAdItemOptions: [],
                    }
                },
                mounted() {
                    this.langList = Config.langList;
                    this.platformList = Config.platformList;
                    if (new URLSearchParams(location.search).get('datetimerange')) {
                        this.searchForm.createtime = new URLSearchParams(location.search).get('datetimerange').split(' - ');
                    }
                    this.getData();
                },
                methods: {
                    cellStyle(row,column,rowIndex,columnIndex){
                        if (row.column.label===__('Status')){
                            if(row.row.status == 1){
                                return 'color:#13986C';
                            }else if(row.row.status == 0){
                                return 'color:#E0B163';
                            }
                        }
                    },

                    //请求
                    getData(offset, limit) {
                        var that = this;
                        that.offset = offset >= 0 ? offset : that.offset;
                        that.limit = limit || that.limit;
                        that.currentPage = that.offset / that.limit + 1;
                        let filter = {}
                        let op = {}
                        for (key in that.searchForm) {
                            if (key != 'createtime' && key != 'form_2_key' && key != 'form_2_value' && key != 'status') {
                                if (that.searchForm[key] != '' && that.searchForm[key] != 0) {
                                    filter[key] = that.searchForm[key];
                                }
                            } else if (key == 'status') {
                                if (that.searchForm[key] !== '') {
                                    filter[key] = that.searchForm[key];
                                }
                            } else if (key == 'form_2_value') {
                                if (that.searchForm[key] != '') {
                                    filter[that.searchForm.form_2_key] = that.searchForm[key];
                                }
                            } else if (key == 'createtime') {
                                if (that.searchForm[key]) {
                                    if (that.searchForm[key].length > 0) {
                                        filter[key] = that.searchForm[key].join(' - ');
                                    }
                                }
                            }
                        }
                        for (key in filter) {
                            op[key] = that.searchOp[key]
                        }
                        Fast.api.ajax({
                            url: 'dramas/ad_log/index',
                            loading: true,
                            type: 'GET',
                            data: {
                                filter: JSON.stringify(filter),
                                op: JSON.stringify(op),
                                offset: that.offset,
                                limit: that.limit,
                            }
                        }, function (ret, res) {
                            that.orderList = res.data.rows;
                            that.totalPage = res.data.total;
                            that.countData = res.data.count;
                            that.focusi = false;
                            that.aboutAdItemOptions = [];
                            that.adItemTotalPage = 0;
                            that.getAdItem();
                            return false;
                        })
                    },
                    handleSizeChange(val) {
                        this.offset = 0
                        this.limit = val
                        this.currentPage = 1;
                        this.getData()
                    },
                    handleCurrentChange(val) {
                        this.offset = (val - 1) * this.limit;
                        this.currentPage = 1;
                        this.getData()
                    },
                    //筛选
                    changeSwitch() {
                        this.screenType = !this.screenType;
                    },
                    screenEmpty() {
                        this.searchForm = JSON.parse(JSON.stringify(this.searchFormInit))
                        this.getData(0, 10)
                    },
                    goAdItemRefresh() {
                        this.focusi = true;
                        this.getData()
                    },

                    // 筛选
                    getAdItem() {
                        var that = this;
                        Fast.api.ajax({
                            url: `dramas/ad/select`,
                            loading: false,
                            type: 'GET',
                            data: {
                                limit: that.adItemLimit,
                                offset: that.adItemOffset,
                                search: that.adItemSearchPage,
                            }
                        }, function (ret, res) {
                            that.aboutAdItemOptions = res.data.rows;
                            that.adItemTotalPage = res.data.total
                            return false;
                        })
                    },
                    changeAdItem(val) {
                        this.dataFilter('')
                    },
                    debounceFilter: debounce(function () {
                        this.getAdItem()
                    }, 1000),
                    dataFilter(val) {
                        this.adItemSearchPage = val;
                        // this.adItemLimit = 6;
                        // this.adItemOffset = 0;
                        // this.adItemCurrentPage = 1;
                        this.debounceFilter();
                    },
                    //分页
                    pageSizeChange(val) {
                        this.adItemOffset = 0;
                        this.adItemLimit = val;
                        this.adItemCurrentPage = 1;
                        this.getAdItem();
                    },
                    pageCurrentChange(val) {
                        this.adItemOffset = (val - 1) * 6;
                        this.adItemLimit = 6;
                        this.adItemCurrentPage = 1;
                        this.getAdItem();
                    },

                },
            })
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
                url: 'dramas/ad_log/recyclebin' + location.search,
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
                                    url: 'dramas/ad_log/restore',
                                    refresh: true
                                },
                                {
                                    name: 'Destroy',
                                    text: __('Destroy'),
                                    classname: 'btn btn-xs btn-danger btn-ajax btn-destroyit',
                                    icon: 'fa fa-times',
                                    url: 'dramas/ad_log/destroy',
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
    };
    return Controller;
});