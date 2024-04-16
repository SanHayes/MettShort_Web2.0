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
                el: "#orderIndex",
                data() {
                    return {
                        screenType: false,
                        langList: {},
                        statusList: {},
                        platformList: {},
                        typeList: {},
                        currencyList: {},
                        orderList: [],
                        currentPage: 1,
                        totalPage: 0,
                        offset: 0,
                        limit: 10,
                        // form搜索
                        searchForm: {
                            status: "all",
                            lang_id: "",
                            createtime: [moment().startOf('day').format('YYYY-MM-DD HH:mm:ss'), moment().endOf('day').format('YYYY-MM-DD HH:mm:ss')],
                            form_1_key: "order_sn",
                            form_1_value: "",
                            platform: "",
                            dispatch_type: "",
                            type: "",
                            pay_type: "",
                            form_2_key: "user_id",
                            form_2_value: "",
                        },
                        countData: {
                            total_usable : 0,
                            total_orders : 0,
                            pay_orders : 0,
                            nopay_orders : 0,
                            total_fee : 0,
                            pay_fee : 0,
                            currency : '---',
                        },
                        searchFormInit: {
                            status: "all",
                            lang_id: "",
                            createtime: [moment().startOf('day').format('YYYY-MM-DD HH:mm:ss'), moment().endOf('day').format('YYYY-MM-DD HH:mm:ss')],
                            form_1_key: "order_sn",
                            form_1_value: "",
                            platform: "",
                            dispatch_type: "",
                            type: "",
                            pay_type: "",
                            form_2_key: "user_id",
                            form_2_value: "",
                        },
                        searchOp: {
                            status: "=",
                            lang_id: "=",
                            createtime: "range",
                            order_sn: "like",
                            id: "=",
                            aftersale_sn: "=",
                            transaction_id: "=",
                            platform: "=",
                            dispatch_type: "=",
                            type: "=",
                            pay_type: "=",
                            user_id: "=",
                            nickname: "like",
                            user_email: "like",
                            consignee: "like",
                            phone: "like",

                        },


                        focusi: false,

                    }
                },
                mounted() {
                    this.langList = Config.langList;
                    this.statusList = Config.statusList;
                    this.platformList = Config.platformList;
                    this.typeList = Config.payTypeList;
                    this.currencyList = Config.currencyList;
                    if (new URLSearchParams(location.search).get('datetimerange')) {
                        this.searchForm.createtime = new URLSearchParams(location.search).get('datetimerange').split(' - ');
                    }
                    this.getData();
                },
                methods: {
                    goDetail(id) {
                        Fast.api.open('dramas/usable_order/detail?id=' + id, __('Detail'));
                    },
                    goRecycle() {
                        Fast.api.open('dramas/usable_order/recyclebin', __('Recycle bin'));
                    },
                    delItem(ids) {
                        var that = this;
                        that.$confirm(__('Are you sure you want to delete this item?'), __('Warning'), {
                            confirmButtonText: __('Ok'),
                            cancelButtonText: __('Cancel'),
                            type: 'warning'
                        }).then(() => {
                            Fast.api.ajax({
                                url: 'dramas/usable_order/del/ids/' + ids,
                                loading: true,
                                type: 'POST',
                            }, function (ret, res) {
                                that.getData();
                                return false;
                            });
                        }).catch(() => {
                            that.$message({
                                type: 'info',
                                message: __('Cancel')
                            });
                        });
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
                            if (key != 'status' && key != 'createtime' && key != 'form_1_key' && key != 'form_1_value' && key != 'form_2_key' && key != 'form_2_value') {
                                if (that.searchForm[key] != '' && that.searchForm[key] != 'all') {
                                    filter[key] = that.searchForm[key];
                                }
                            } else if (key == 'form_1_value') {
                                if (that.searchForm[key] != '') {
                                    filter[that.searchForm.form_1_key] = that.searchForm[key];
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
                            } else if (key == 'status') {
                                if (that.searchForm[key] != '' && that.searchForm[key] != 'all') {
                                    filter[key] = that.searchForm[key];
                                }
                            }
                        }
                        for (key in filter) {
                            op[key] = that.searchOp[key]
                        }
                        Fast.api.ajax({
                            url: 'dramas/usable_order/index',
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
                    goOrderRefresh() {
                        this.focusi = true;
                        this.getData()
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
                url: 'dramas/usable_order/recyclebin' + location.search,
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
                                    url: 'dramas/usable_order/restore',
                                    refresh: true
                                },
                                {
                                    name: 'Destroy',
                                    text: __('Destroy'),
                                    classname: 'btn btn-xs btn-danger btn-ajax btn-destroyit',
                                    icon: 'fa fa-times',
                                    url: 'dramas/usable_order/destroy',
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
        detail: function () {
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
            var vue = new Vue({
                el: "#orderDetail",
                data() {
                    return {
                        orderId: new URLSearchParams(location.search).get('id'),
                        orderDetail: [],
                        payment_json: [],
                    }
                },
                mounted() {
                    this.getDetail();
                },
                methods: {
                    getDetail() {
                        let that = this;
                        Fast.api.ajax({
                            url: `dramas/usable_order/detail?id=${that.orderId}`,
                            loading: true,
                            data: {}
                        }, function (ret, res) {
                            that.orderDetail = res.data;
                            if(res.data.payment_json){
                                that.payment_json = JSON.parse(res.data.payment_json);
                            }
                            return false;
                        })
                    },
                    goUserDetail(user_id) {
                        Fast.api.open('dramas/user/profile?id=' + user_id, __('Detail'));
                    },
                    goUsableDetail(usable_id) {
                        Fast.api.open('dramas/usable/edit?ids=' + usable_id, __('Edit'));
                    },
                },
            })
        },
    };
    return Controller;
});
