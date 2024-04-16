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
            var walletIndex = new Vue({
                el: "#walletIndex",
                data() {
                    return {
                        screenType: false,
                        walletTypeList: {},
                        operTypeList: {},
                        typeList: {},
                        walletList: [],
                        currentPage: 1,
                        totalPage: 0,
                        offset: 0,
                        limit: 10,
                        // form搜索
                        searchForm: {
                            wallet_type: 'usable',
                            type: '',
                            user_id: '',
                            createtime: [moment().startOf('day').format('YYYY-MM-DD HH:mm:ss'), moment().endOf('day').format('YYYY-MM-DD HH:mm:ss')],
                        },
                        countData: {
                            surplus_coins : 0,
                            add_coins : 0,
                            consumption_coins : 0,
                        },
                        searchFormInit: {
                            wallet_type: 'usable',
                            type: '',
                            user_id: '',
                            createtime: [moment().startOf('day').format('YYYY-MM-DD HH:mm:ss'), moment().endOf('day').format('YYYY-MM-DD HH:mm:ss')],
                        },
                        searchOp: {
                            wallet_type: '=',
                            type: '=',
                            createtime: "range",
                            user_id: "=",
                        },

                        focusi: false,

                        userLimit: 6,
                        userOffset: 0,
                        userCurrentPage: 1,
                        userTotalPage: 0,
                        userSearchPage: '',
                        aboutUserOptions: [],
                    }
                },
                mounted() {
                    this.walletTypeList = Config.walletTypeList;
                    this.operTypeList = Config.operTypeList;
                    this.typeList = Config.typeList;
                    if (new URLSearchParams(location.search).get('datetimerange')) {
                        this.searchForm.createtime = new URLSearchParams(location.search).get('datetimerange').split(' - ');
                    }
                    this.getUser();
                    this.getData();
                },
                methods: {
                    cellStyle(row,column,rowIndex,columnIndex){
                        if (row.column.label===__('Type')){
                            if(row.row.type == 'wallet_pay'){
                                return 'color:#F44336';
                            }else if(row.row.type == 'recharge'){
                                return 'color:#E91E63';
                            }else if(row.row.type == 'cash'){
                                return 'color:#9C27B0';
                            }else if(row.row.type == 'cash_error'){
                                return 'color:#673AB7';
                            }else if(row.row.type == 'wallet_refund'){
                                return 'color:#3F51B5';
                            }else if(row.row.type == 'commission_income'){
                                return 'color:#2196F3';
                            }else if(row.row.type == 'commission_back'){
                                return 'color:#03A9F4';
                            }else if(row.row.type == 'task'){
                                return 'color:#00BCD4';
                            }else if(row.row.type == 'usersign'){
                                return 'color:#009688';
                            }else if(row.row.type == 'vip_usable'){
                                return 'color:#4CAF50';
                            }else if(row.row.type == 'vip_everyday'){
                                return 'color:#8BC34A';
                            }else if(row.row.type == 'vip_everyday_plug'){
                                return 'color:#FFEB3B';
                            }else if(row.row.type == 'replenish_usersign'){
                                return 'color:#FFC107';
                            }else if(row.row.type == 'used_video'){
                                return 'color:#FF9800';
                            }else if(row.row.type == 'recharge_usable'){
                                return 'color:#FF5722';
                            }else if(row.row.type == 'first_recharge_usable'){
                                return 'color:#795548';
                            }else if(row.row.type == 'cryptocard'){
                                return 'color:#9E9E9E';
                            }else if(row.row.type == 'admin_recharge'){
                                return 'color:#607D8B';
                            }else if(row.row.type == 'admin_deduct'){
                                return 'color:#1E14E0';
                            }
                        }else if (row.column.label===__('Wallet_type')){
                            if(row.row.wallet_type == 'usable'){
                                return 'color:#13986C';
                            }else if(row.row.wallet_type == 'usable'){
                                return 'color:#E0B163';
                            }
                        }else if (row.column.label===__('Oper_type')){
                            if(row.row.oper_type == 'user'){
                                return 'color:#487EE5';
                            }else if(row.row.oper_type == 'admin'){
                                return 'color:#EC9371';
                            }else if(row.row.oper_type == 'system'){
                                return 'color:#D75125';
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
                            url: 'dramas/user_wallet_log/index',
                            loading: true,
                            type: 'GET',
                            data: {
                                filter: JSON.stringify(filter),
                                op: JSON.stringify(op),
                                offset: that.offset,
                                limit: that.limit,
                            }
                        }, function (ret, res) {
                            that.walletList = res.data.rows;
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
                    goWalletRefresh() {
                        this.focusi = true;
                        this.getData()
                    },

                    // 筛选短剧
                    getUser() {
                        var that = this;
                        Fast.api.ajax({
                            url: `dramas/user/select`,
                            loading: false,
                            type: 'GET',
                            data: {
                                limit: that.userLimit,
                                offset: that.userOffset,
                                search: that.userSearchPage
                            }
                        }, function (ret, res) {
                            that.aboutUserOptions = res.data.rows;
                            that.userTotalPage = res.data.total
                            return false;
                        })
                    },
                    changeUser(val) {
                        this.dataFilter('')
                    },
                    debounceFilter: debounce(function () {
                        this.getUser()
                    }, 1000),
                    dataFilter(val) {
                        this.userSearchPage = val;
                        // this.userLimit = 6;
                        // this.userOffset = 0;
                        // this.userCurrentPage = 1;
                        this.debounceFilter();
                    },
                    //分页
                    pageSizeChange(val) {
                        this.userOffset = 0;
                        this.userLimit = val;
                        this.userCurrentPage = 1;
                        this.getUser();
                    },
                    pageCurrentChange(val) {
                        this.userOffset = (val - 1) * 6;
                        this.userLimit = 6;
                        this.userCurrentPage = 1;
                        this.getUser();
                    },

                },
            })
        },
    };
    return Controller;
});