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
            var logIndex = new Vue({
                el: "#logIndex",
                data() {
                    return {
                        screenType: false,
                        currencyList: {},
                        typeList: {},
                        orderTypeList: {},
                        logList: [],
                        currentPage: 1,
                        totalPage: 0,
                        offset: 0,
                        limit: 10,
                        // form搜索
                        searchForm: {
                            currency: '',
                            type: '',
                            order_type: '',
                            createtime: [moment().startOf('day').format('YYYY-MM-DD HH:mm:ss'), moment().endOf('day').format('YYYY-MM-DD HH:mm:ss')],
                            form_2_key: "user_id",
                            form_2_value: "",
                        },
                        countData: {
                            withdraw_total_money : 0,
                            total_logs : 0,
                            total_pay_money : 0,
                            total_money : 0,
                            currency : '---',
                        },
                        searchFormInit: {
                            currency: '',
                            type: '',
                            order_type: '',
                            createtime: [moment().startOf('day').format('YYYY-MM-DD HH:mm:ss'), moment().endOf('day').format('YYYY-MM-DD HH:mm:ss')],
                            form_2_key: "user_id",
                            form_2_value: "",
                        },
                        searchOp: {
                            createtime: "range",
                            currency: "=",
                            type: '=',
                            order_type: '=',
                            user_id: "=",
                            nickname: "like",
                            user_email: "like",
                        },

                        focusi: false,

                        resellerUserLimit: 6,
                        resellerUserOffset: 0,
                        resellerUserCurrentPage: 1,
                        resellerUserTotalPage: 0,
                        resellerUserSearchPage: '',
                        aboutResellerUserOptions: [],
                    }
                },
                mounted() {
                    this.currencyList = Config.currencyList;
                    this.typeList = Config.typeList;
                    this.orderTypeList = Config.orderTypeList;
                    if (new URLSearchParams(location.search).get('datetimerange')) {
                        this.searchForm.createtime = new URLSearchParams(location.search).get('datetimerange').split(' - ');
                    }
                    this.getData();
                },
                methods: {
                    cellStyle(row,column,rowIndex,columnIndex){
                        if (row.column.label===__('Type')){
                            if(row.row.type == 'direct'){
                                return 'color:#9C27B0';
                            }else if(row.row.type == 'indirect'){
                                return 'color:#009688';
                            }
                        }
                    },
                    delItem(ids) {
                        var that = this;
                        that.$confirm(__('Are you sure you want to delete this item?'), __('Warning'), {
                            confirmButtonText: __('Ok'),
                            cancelButtonText: __('Cancel'),
                            type: 'warning'
                        }).then(() => {
                            Fast.api.ajax({
                                url: 'dramas/reseller_log/del/ids/' + ids,
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
                            if (key != 'createtime' && key != 'form_2_key' && key != 'form_2_value') {
                                if (that.searchForm[key] != '' && that.searchForm[key] != 0) {
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
                            url: 'dramas/reseller_log/index',
                            loading: true,
                            type: 'GET',
                            data: {
                                filter: JSON.stringify(filter),
                                op: JSON.stringify(op),
                                offset: that.offset,
                                limit: that.limit,
                            }
                        }, function (ret, res) {
                            that.logList = res.data.rows;
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
                    goLogRefresh() {
                        this.focusi = true;
                        this.getData()
                    },

                    // 筛选短剧
                    getResellerUser() {
                        var that = this;
                        Fast.api.ajax({
                            url: `dramas/user/select`,
                            loading: false,
                            type: 'GET',
                            data: {
                                limit: that.resellerUserLimit,
                                offset: that.resellerUserOffset,
                                search: that.resellerUserSearchPage,
                                user_type: 'reseller',
                            }
                        }, function (ret, res) {
                            that.aboutResellerUserOptions = res.data.rows;
                            that.resellerUserTotalPage = res.data.total
                            return false;
                        })
                    },
                    changeResellerUser(val) {
                        this.dataFilter('')
                    },
                    debounceFilter: debounce(function () {
                        this.getResellerUser()
                    }, 1000),
                    dataFilter(val) {
                        this.resellerUserSearchPage = val;
                        // this.resellerUserLimit = 6;
                        // this.resellerUserOffset = 0;
                        // this.resellerUserCurrentPage = 1;
                        this.debounceFilter();
                    },
                    //分页
                    pageSizeChange(val) {
                        this.resellerUserOffset = 0;
                        this.resellerUserLimit = val;
                        this.resellerUserCurrentPage = 1;
                        this.getResellerUser();
                    },
                    pageCurrentChange(val) {
                        this.resellerUserOffset = (val - 1) * 6;
                        this.resellerUserLimit = 6;
                        this.resellerUserCurrentPage = 1;
                        this.getResellerUser();
                    },
                },
            })
        },
    };
    return Controller;
});