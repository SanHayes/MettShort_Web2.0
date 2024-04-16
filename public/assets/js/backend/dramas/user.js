define(['jquery', 'bootstrap', 'backend', 'table', 'form', 'toastr'], function ($, undefined, Backend, Table, Form, Toastr) {

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
                    }, delay);
                };
            }
            var userIndex = new Vue({
                el: "#userIndex",
                data() {
                    return {
                        data: [],
                        chooseType: 0,
                        groupId: 0,
                        joinTime: [],
                        loginTime: [],
                        searchKey: '',
                        mode: 'all',
                        tabsList: [{
                            name: 'all',
                            label: __('All')
                        },{
                            name: 'user',
                            label: __('User')
                        },{
                            name: 'guest',
                            label: __('Guest')
                        }],
                        groupList: [],
                        sort: '',
                        order: '',

                        offset: 0,
                        limit: 10,
                        totalPage: 0,
                        currentPage: 1,

                    };
                },
                created() {
                    if (new URLSearchParams(location.search).get('jointimerange')) {
                        this.chooseType = '1';
                        this.joinTime = new URLSearchParams(location.search).get('jointimerange').split(' - ');
                        this.operation('filter');
                    }
                    if (new URLSearchParams(location.search).get('logintimerange')) {
                        this.chooseType = '1';
                        this.loginTime = new URLSearchParams(location.search).get('logintimerange').split(' - ');
                        this.operation('filter');
                    }

                    this.groupList = Config.groupList;
                    this.getData();
                },
                methods: {
                    sortChange(column){
                        this.sort = column.prop;
                        if(column.order == 'descending'){
                            this.order = 'desc';
                        }else{
                            this.order = 'asc';
                        }
                        this.getData();
                    },
                    getData() {
                        let that = this;
                        let filter = {};
                        let op = {};
                        if(that.mode != 'all'){
                            filter['mode'] = that.mode;
                            op['mode'] = '=';
                        }
                        if(that.groupId != 0){
                            filter['group_id'] = that.groupId;
                            op['group_id'] = '=';
                        }
                        if(that.joinTime.length > 0){
                            filter['jointime'] = that.joinTime.join(' - ');
                            op['jointime'] = 'RANGE';
                        }
                        if(that.loginTime.length > 0){
                            filter['logintime'] = that.loginTime.join(' - ');
                            op['logintime'] = 'RANGE';
                        }
                        let datas = {
                            searchWhere: that.searchKey,
                            offset: that.offset,
                            limit: that.limit,
                            filter: JSON.stringify(filter),
                            op: JSON.stringify(op)
                        };
                        if(that.sort != '' && that.order != ''){
                            datas['sort'] = that.sort;
                            datas['order'] = that.order;
                        }
                        Fast.api.ajax({
                            url: 'dramas/user/index',
                            loading: true,
                            type: 'GET',
                            data: datas,
                        }, function (ret, res) {
                            that.data = res.data.rows;
                            that.totalPage = res.data.total;
                            return false;
                        });
                    },
                    operation(type, id) {
                        let that = this;
                        switch (type) {
                            case 'group':
                                that.groupId = id;
                                break;
                            case 'filter':
                                that.offset = 0;
                                that.limit = 10;
                                that.currentPage = 1;
                                that.getData();
                                break;
                            case 'clear':
                                that.groupId = 0;
                                that.joinTime = "";
                                that.loginTime = "";
                                break;
                            case 'edit':
                                Fast.api.open('dramas/user/profile?id=' + id, __('View'), {
                                    callback() {
                                        that.getData();
                                    }
                                });
                                break;
                            case 'del':
                                that.$confirm(__('Are you sure you want to delete this item?'), __('Warning'), {
                                    confirmButtonText: __('OK'),
                                    cancelButtonText: __('Cancel'),
                                    type: 'warning'
                                }).then(() => {
                                    Fast.api.ajax({
                                        url: 'dramas/user/del/ids/' + id,
                                        loading: true,
                                        type: 'POST',
                                    }, function (ret, res) {
                                        that.getData();

                                    });
                                    return false;
                                }).catch(() => {
                                    that.$message({
                                        type: 'info',
                                        message: __('Delete canceled')
                                    });
                                });
                                break;
                            default:
                                Fast.api.open('dramas/user/profile?id=' + type.id, __('View'), {
                                    callback() {
                                        that.getData();
                                    }
                                });
                                break;
                        }
                    },
                    handleSizeChange(val) {
                        this.offset = 0;
                        this.limit = val;
                        this.currentPage = 1;
                        this.getData();
                    },
                    handleCurrentChange(val) {
                        this.currentPage = val;
                        this.offset = (val - 1) * this.limit;
                        this.getData();
                    },
                    tabshandleClick(value) {
                        this.offset = 0;
                        this.limit = 10;
                        this.totalPage = 0;
                        this.currentPage = 1;
                        this.getData();
                    },
                    isShoose() {
                        this.chooseType == 0 ? 1 : 0;
                        if (this.chooseType == 0) {
                            this.activityType = 'all';
                            this.priceFrist = "";
                            this.priceLast = "";
                        }
                    },
                    tableRowClassName({
                        rowIndex
                    }) {
                        if (rowIndex % 2 == 1) {
                            return 'bg-color';
                        }
                        return '';
                    },
                    tableCellClassName({
                        columnIndex
                    }) {
                        if (columnIndex == 2 || columnIndex == 9) {
                            return 'cell-left';
                        }
                        return '';
                    },
                    debounceFilter: debounce(function () {
                        this.getData();
                    }, 1000),
                },
                watch: {
                    searchKey(newVal, oldVal) {
                        if (newVal != oldVal) {
                            this.offset = 0;
                            this.limit = 10;
                            this.currentPage = 1;
                            this.debounceFilter();
                        }
                    },
                },
            });
        },
        recyclebin: function () { },
        add: function () { },
        profile: function () {
            function debounce(handle, delay) {
                let time = null;
                return function () {
                    let self = this,
                        arg = arguments;
                    clearTimeout(time);
                    time = setTimeout(function () {
                        handle.apply(self, arg);
                    }, delay);
                };
            }
            let formatterHtml = {
                time: (row, value) => {
                    return `${moment(row.createtime * 1000).format('YYYY-MM-DD HH:mm:ss')}`;
                },
                memo: (row, value) => {
                    return row.memo ? `${__(row.memo)}` : '';
                },
                image: (row, value) => {
                    return `<img src="/assets/addons/dramas/img/decorate/${row.platform}.png" />`;
                },
                shareUser: (row, value) => {
                    if (row.user) {
                        return `<img style="width:24px;height:24px;margin-right:10px" src="${Fast.api.cdnurl(row.user.avatar)}" /><div>${row.user.nickname}</div>`;
                    }
                },
                changeNumber: (row, value) => {
                    let str = "";
                    if (row.money) {
                        str = `${row.money > 0 ? '+' + row.money : row.money}`;
                    } else if (row.score) {
                        str = `${row.score > 0 ? '+' + row.score : row.score}`;
                    } else if (row.usable) {
                        str = `${row.usable > 0 ? '+' + row.usable : row.usable}`;
                    }
                    return str;
                },
                shareMessage: (row, value) => {
                    // page  page_id
                    let str = "";
                    return str;
                },
                goods: (row, value) => {
                    if (row.goods) {
                        return `<img style="width:24px;height:24px;margin-right:10px" src="${Fast.api.cdnurl(row.goods.image)}" /><div class="flex-1 ellipsis-item" style="text-align:left">${row.goods.title}</div>`;
                    }
                },
                coupon: (row, value) => {
                    if (row.coupons) {
                        return `${row.coupons[value.field]}`;
                    }
                },
                couponStatus: (row, value) => {
                    let str = '';
                    if (row.usetime) {
                        str = 1;
                    } else {
                        str = 0;
                    }
                    return str;
                },
                operUser: (row) => {
                    let htmls = '';
                    if (row.oper) {
                        if (row.oper.avatar) {
                            htmls += `<img style="width:24px;height:24px;margin-right:10px" src="${Fast.api.cdnurl(row.oper.avatar)}" />`;
                        }
                        if (row.oper.name) {
                            htmls += `<div class="ellipsis-item">${row.oper.name}</div>`;
                        }
                    }
                    return htmls;
                },
                operType: (row) => {
                    return row.oper ? row.oper.type : '';
                },
            };
            var userDetail = new Vue({
                el: "#userDetail",
                data() {
                    return {
                        data: {},
                        groupList: [],
                        upPassword: '',

                        activeStatus: 'money_log',
                        logList: [],
                        columns: {
                            'money_log': [{
                                type: 'time',
                                field: 'createtime',
                                title: __('Transaction time'),
                                width: '160px',
                                formatter: formatterHtml.time,
                            }, {
                                type: 'text',
                                field: 'wallet',
                                title: __('Variable balance'),
                                width: '120px',
                            }, {
                                type: 'text',
                                field: 'before',
                                title: __('Before the change'),
                                width: '120px',
                            }, {
                                type: 'text',
                                field: 'after',
                                title: __('After the change'),
                                width: '120px',
                            }, {
                                type: 'htmls',
                                field: 'oper.type',
                                title: __('Oper type'),
                                width: '120px',
                                formatter: formatterHtml.operType,
                            }, {
                                type: 'htmls',
                                field: 'oper',
                                title: __('Oper'),
                                width: '200px',
                                formatter: formatterHtml.operUser,
                            }, {
                                type: 'htmls',
                                field: 'memo',
                                title: __('Remarks'),
                                width: '400px',
                                align: 'left',
                                formatter: formatterHtml.memo,
                            }],
                            'usable_log': [{
                                type: 'time',
                                field: 'createtime',
                                title: __('Transaction time'),
                                width: '160px',
                                formatter: formatterHtml.time,
                            }, {
                                type: 'text',
                                field: 'wallet',
                                title: __('Variable theater points'),
                                width: '120px',
                            }, {
                                type: 'text',
                                field: 'before',
                                title: __('Before the change'),
                                width: '120px',
                            }, {
                                type: 'text',
                                field: 'after',
                                title: __('After the change'),
                                width: '120px',
                            }, {
                                type: 'htmls',
                                field: 'oper.type',
                                title: __('Oper type'),
                                width: '120px',
                                formatter: formatterHtml.operType,
                            }, {
                                type: 'htmls',
                                field: 'oper',
                                title: __('Oper'),
                                width: '200px',
                                formatter: formatterHtml.operUser,
                            }, {
                                type: 'htmls',
                                field: 'memo',
                                title: __('Remarks'),
                                width: '400px',
                                align: 'left',
                                formatter: formatterHtml.memo,
                            }],
                            'vip_order_log': [{
                                type: 'time',
                                field: 'createtime',
                                title: __('Order time'),
                                width: '160px',
                                formatter: formatterHtml.time,
                            }, {
                                type: 'vip_order',
                                field: 'order_sn',
                                title: __('Order sn'),
                                width: '220px',
                            }, {
                                type: 'image',
                                field: 'platform',
                                title: __('Order platform'),
                                width: '100px',
                                formatter: formatterHtml.image,
                            }, {
                                type: 'price',
                                field: 'total_fee',
                                title: __('Total free'),
                                width: '140px',
                            }, {
                                type: 'price',
                                field: 'pay_fee',
                                title: __('Pay free'),
                                width: '140px',
                            }, {
                                type: 'text',
                                field: 'status_text',
                                title: __('Order status'),
                                width: '100px',
                            }],
                            'reseller_order_log': [{
                                type: 'time',
                                field: 'createtime',
                                title: __('Order time'),
                                width: '160px',
                                formatter: formatterHtml.time,
                            }, {
                                type: 'reseller_order',
                                field: 'order_sn',
                                title: __('Order sn'),
                                width: '220px',
                            }, {
                                type: 'image',
                                field: 'platform',
                                title: __('Order platform'),
                                width: '100px',
                                formatter: formatterHtml.image,
                            }, {
                                type: 'price',
                                field: 'total_fee',
                                title: __('Total free'),
                                width: '140px',
                            }, {
                                type: 'price',
                                field: 'pay_fee',
                                title: __('Pay free'),
                                width: '140px',
                            }, {
                                type: 'text',
                                field: 'status_text',
                                title: __('Order status'),
                                width: '100px',
                            }],
                            'share_log': [{
                                type: 'time',
                                field: 'createtime',
                                title: __('Share time'),
                                width: '160px',
                                formatter: formatterHtml.time,
                            }, {
                                type: 'shareUser',
                                field: 'person',
                                title: __('Shared users'),
                                width: '160px',
                                formatter: formatterHtml.shareUser,
                            }, {
                                type: 'image',
                                field: 'platform',
                                title: __('Platform'),
                                width: '120px',
                                formatter: formatterHtml.image,
                            }],
                        },

                        page: 1,
                        limit: 10,
                        totalPage: 0,
                        currentPage: 1,
                        // 设置分销商
                        dialogListReseller: [],
                        // 设置vip
                        dialogListVip: [],
                        // 更换推荐人
                        dialogList: [],
                        agentDialogVisible: false,
                        vipDialogVisible: false,
                        resellerDialogVisible: false,
                        poffset: 0,
                        plimit: 5,
                        ptotalPage: 0,
                        pcurrentPage: 1,
                        parentFilterForm: {
                            status: "normal",
                            form_1_key: "id",
                            form_1_value: ""
                        },
                        parentFilterFormInit: {
                            status: "normal",
                            form_1_key: "id",
                            form_1_value: ""
                        },
                        parentFilterOp: {
                            status: "=",
                            id: "=",
                            nickname: "like",
                            email: "like",
                        },
                        selectParentAgentId: null,
                        noRecommendationChecked: false,
                        vip_id: '',
                        reseller_id: '',
                    };
                },
                created() {
                    this.data = JSON.parse(JSON.stringify(Config.row));
                    this.groupList = Config.groupList;
                    this.getListData(this.activeStatus);
                },
                methods: {
                    getprofile() {
                        let that = this;
                        Fast.api.ajax({
                            url: 'dramas/user/profile?id=' + Config.row.id,
                            loading: true,
                            type: 'GET',
                            data: {},
                        }, function (ret, res) {
                            Config.row = res.data;
                            that.data = JSON.parse(JSON.stringify(Config.row));
                            return false;
                        });
                    },
                    //列表
                    radioChange(val) {
                        this.logList = [];
                        this.activeStatus = val;
                        this.page = 1;
                        this.limit = 10;
                        this.currentPage = 1;
                        this.getListData(val);
                    },
                    getListData(val) {
                        let that = this;
                        Fast.api.ajax({
                            url: 'dramas/user/' + val + '?user_id=' + Config.row.id,
                            loading: true,
                            type: 'GET',
                            data: {
                                page: that.page,
                                limit: that.limit,
                            },
                        }, function (ret, res) {
                            that.logList = res.data.data;
                            that.totalPage = res.data.total;
                            return false;
                        });
                    },
                    operation(type, id) {
                        let that = this;
                        switch (type) {
                            case 'avatar':
                                parent.Fast.api.open("general/attachment/select?multiple=false", __('Select'), {
                                    callback: function (data) {
                                        that.data.avatar = data.url;
                                    }
                                });
                                break;
                            case 'money':
                                Fast.api.open('dramas/user/money_recharge?id=' + Config.row.id, __('Recharge money'), {
                                    callback(data) {
                                        that.getprofile();
                                        that.getListData(that.activeStatus);
                                    }
                                });
                                break;
                            case 'usable':
                                Fast.api.open('dramas/user/usable_recharge?id=' + Config.row.id, __('Recharge usable'), {
                                    callback(data) {
                                        that.getprofile();
                                        that.getListData(that.activeStatus);
                                    }
                                });
                                break;
                            case 'reset':
                                that.data = JSON.parse(JSON.stringify(Config.row));
                                break;
                            case 'save':
                                subData = JSON.parse(JSON.stringify(that.data));
                                if (that.upPassword) {
                                    subData.password = that.upPassword;
                                }
                                Fast.api.ajax({
                                    url: 'dramas/user/update',
                                    loading: true,
                                    data: {
                                        data: JSON.stringify(subData)
                                    }
                                }, function (ret, res) {
                                    Config.row = res.data;
                                    that.upPassword = '';
                                });
                                break;
                            case 'platformname':
                                let type = '';
                                switch (id) {
                                    case 'H5':
                                        type = 'H5';
                                        break;
                                    case 'App':
                                        type = 'App';
                                        break;
                                    default:
                                        type = id;
                                }
                                return type;
                                break;
                            case 'vipOrder':
                                Fast.api.open('dramas/vip_order/detail?id=' + id, __('Order log'));
                                break;
                            case 'resellerOrder':
                                Fast.api.open('dramas/reseller/order_detail?id=' + id, __('Order log'));
                                break;
                            case 'shareUser':
                                Fast.api.open('dramas/user/profile?id=' + id, __('View'));
                                break;
                        }
                    },
                    openAgentProfile(agent_id) {
                        let that = this;
                        Fast.api.open(`dramas/user/profile?id=${agent_id}`, __('Detail'), {
                            callback(data) {
                                that.getListData();
                            }
                        });
                    },

                    openDialogVip() {
                        this.getVipIndex();
                    },
                    closeDialogVip(opttype) {
                        if (opttype == true) {
                            this.reqUserChangeVip();
                        } else {
                            this.vipDialogVisible = false;
                            this.vip_id = '';
                        }
                    },
                    getVipIndex() {
                        let that = this;
                        Fast.api.ajax({
                            url: 'dramas/vip/select',
                            loading: false,
                            type: 'GET',
                        }, function (ret, res) {
                            that.dialogListVip = res.data.rows;
                            that.vipDialogVisible = true;
                            return false;
                        });
                    },
                    reqUserChangeVip() {
                        let that = this;
                        if (!that.vip_id) {
                            return false;
                        }
                        Fast.api.ajax({
                            url: 'dramas/user/changeVip?id=' + Config.row.id,
                            loading: false,
                            type: 'POST',
                            data: {
                                value: that.vip_id
                            },
                        }, function (ret, res) {
                            that.vip_id = '';
                            that.vipDialogVisible = false;
                            that.getprofile();
                        }, function (ret, res) {
                            that.vip_id = '';
                            that.vipDialogVisible = false;
                        });
                    },

                    openDialogReseller() {
                        this.getResellerIndex();
                    },
                    closeDialogReseller(opttype) {
                        if (opttype == true) {
                            this.reqUserChangeReseller();
                        } else {
                            this.resellerDialogVisible = false;
                            this.reseller_id = '';
                        }
                    },
                    getResellerIndex() {
                        let that = this;
                        Fast.api.ajax({
                            url: 'dramas/reseller/select',
                            loading: false,
                            type: 'GET',
                        }, function (ret, res) {
                            that.dialogListReseller = res.data.rows;
                            that.resellerDialogVisible = true;
                            return false;
                        });
                    },
                    reqUserChangeReseller() {
                        let that = this;
                        if (!that.reseller_id) {
                            return false;
                        }
                        Fast.api.ajax({
                            url: 'dramas/user/changeReseller?id=' + Config.row.id,
                            loading: false,
                            type: 'POST',
                            data: {
                                value: that.reseller_id
                            },
                        }, function (ret, res) {
                            that.reseller_id = '';
                            that.resellerDialogVisible = false;
                            that.getprofile();
                        }, function (ret, res) {
                            that.reseller_id = '';
                            that.resellerDialogVisible = false;
                        });
                    },

                    // 更换
                    openDialog() {
                        this.getAgentIndex();
                    },
                    closeDialog(opttype) {
                        if (opttype == true) {
                            this.reqUserChangeParentUser();
                        } else {
                            this.agentDialogVisible = false;
                            this.noRecommendationChecked = false;
                        }
                    },
                    reqUserChangeParentUser() {
                        let that = this;
                        if (!that.selectParentAgentId && that.selectParentAgentId != 0) {
                            return false;
                        }
                        Fast.api.ajax({
                            url: 'dramas/user/changeParentUser?id=' + Config.row.id,
                            loading: false,
                            type: 'POST',
                            data: {
                                value: that.selectParentAgentId
                            },
                        }, function (ret, res) {
                            that.selectParentAgentId = null;
                            that.agentDialogVisible = false;
                            that.parentFilterForm.form_1_value = "";
                            that.parentFilterForm.form_1_key = "id";
                            that.noRecommendationChecked = false;
                            that.getprofile();
                        }, function (ret, res) {
                            that.selectParentAgentId = null;
                            that.agentDialogVisible = false;
                            that.parentFilterForm.form_1_value = "";
                            that.parentFilterForm.form_1_key = "id";
                            that.noRecommendationChecked = false;
                        });
                    },
                    // init推荐人
                    initAgentData(id) {
                        if (id === true) {
                            this.selectParentAgentId = 0;
                        } else if (id === false) {
                            this.selectParentAgentId = null;
                        } else {
                            this.selectParentAgentId = id;
                            this.noRecommendationChecked = false;
                        }
                    },
                    // 推荐人列表
                    getAgentIndex() {
                        let that = this;
                        let filter = {};
                        let op = {};
                        for (key in that.parentFilterForm) {
                            if (key == 'form_1_value') {
                                if (that.parentFilterForm[key] != '') {
                                    filter[that.parentFilterForm.form_1_key] = that.parentFilterForm[key];
                                }
                            } else if (key == 'status') {
                                if (that.parentFilterForm[key] != '' && that.parentFilterForm[key] != 'all') {
                                    filter[key] = that.parentFilterForm[key];
                                }
                            }
                        }
                        for (key in filter) {
                            op[key] = that.parentFilterOp[key];
                        }
                        Fast.api.ajax({
                            url: 'dramas/user/select',
                            loading: false,
                            type: 'GET',
                            data: {
                                offset: that.poffset,
                                limit: that.plimit,
                                filter: JSON.stringify(filter),
                                op: JSON.stringify(op)
                            },
                        }, function (ret, res) {
                            that.dialogList = res.data.rows;
                            that.ptotalPage = res.data.total;
                            that.agentDialogVisible = true;
                            return false;
                        });
                    },
                    parentDebounceFilter: debounce(function () {
                        this.getAgentIndex();
                    }, 1000),
                    phandleCurrentChange(val) {
                        this.pcurrentPage = val;
                        this.poffset = (val - 1) * this.plimit;
                        this.getAgentIndex();
                    },
                    handleSizeChange(val) {
                        this.page = 0;
                        this.limit = val;
                        this.currentPage = 1;
                        this.getListData(this.activeStatus);
                    },
                    handleCurrentChange(val) {
                        this.currentPage = val;
                        this.page = val;
                        this.getListData(this.activeStatus);
                    },
                    tableRowClassName({
                        rowIndex
                    }) {
                        if (rowIndex % 2 == 1) {
                            return 'bg-color';
                        }
                        return '';
                    },
                },
            });
        },
        select: function () {
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
            var userSelect = new Vue({
                el: "#userSelect",
                data() {
                    return {
                        searchWhere: '',
                        userList: [],
                        totalPage: 0,
                        offset: 0,
                        currentPage: 1,

                        multiple: new URLSearchParams(location.search).get('multiple'),
                        selectedIds: [],
                        mode: 'all'
                    }
                },
                mounted() {
                    if (new URLSearchParams(location.search).get('ids')) {
                        this.selectedIds = new URLSearchParams(location.search).get('ids').split(',')
                    }
                    if (new URLSearchParams(location.search).get('mode')) {
                        this.mode = new URLSearchParams(location.search).get('mode')
                    }
                    this.getList();
                },
                methods: {
                    getList() {
                        let that = this;
                        let url = "dramas/user/select";
                        Fast.api.ajax({
                            url: url,
                            data: {
                                limit: 10,
                                offset: that.offset,
                                search: that.searchWhere,
                                mode: that.mode
                            },
                            type: 'GET'
                        }, function (ret, res) {
                            that.userList = res.data.rows;
                            that.userList.forEach(g => {
                                that.$set(g, 'checked', false)
                            })
                            let selectData = []
                            that.userList.forEach(g => {
                                if (that.selectedIds.includes(g.id + '')) {
                                    selectData.push(g)
                                }
                            })
                            that.$nextTick(() => {
                                selectData.forEach(row => {
                                    that.$refs.multipleTable.toggleRowSelection(row);
                                });
                            })
                            that.totalPage = res.data.total;
                            return false;
                        })
                    },
                    singleSelectionChange(row) {
                        this.selectedIds = []
                        this.selectedIds.push(row.id)
                        this.userList.forEach(g => {
                            if (g.id == row.id) {
                                this.$set(g, 'checked', true)
                            } else {
                                this.$set(g, 'checked', false)
                            }
                        })
                        this.$forceUpdate()
                    },
                    multipleSelectionChange(val) {
                        if(val.length == 0){
                            this.selectedIds = [];
                        }
                        val.forEach(g => {
                            if (!this.selectedIds.includes(g.id + '')) {
                                this.selectedIds.push(g.id + '')
                            }
                        })
                    },
                    SelectionChange(selection, row) {
                        if (this.selectedIds.indexOf(row.id + '') != -1) {
                            this.selectedIds.splice(this.selectedIds.indexOf(row.id + ''), 1)
                        }
                    },
                    changeClick(val) {
                        this.currentPage = val;
                        this.offset = 10 * (val - 1);
                        this.getList()
                    },
                    operation() {
                        let that = this;
                        if (this.selectedIds.length == 0) {
                            return false
                        }
                        let ids = this.multiple == 'true' ? this.selectedIds.join(',') : this.selectedIds[this.selectedIds.length - 1]
                        Fast.api.ajax({
                            url: 'dramas/user/lists?user_ids=' + ids,
                            loading: false,
                        }, function (ret, res) {
                            Fast.api.close({
                                data: that.multiple == 'true' ? res.data.data : res.data.data[0],
                            });
                            return false;
                        }, function () {
                            return false;
                        })
                    },
                    debounceFilter: debounce(function () {
                        this.getList()
                    }, 1000),
                },
                watch: {
                    searchWhere(newVal, oldVal) {
                        if (newVal != oldVal) {
                            this.offset = 0;
                            this.currentPage = 1;
                            this.debounceFilter();
                        }
                    },
                },
            })
        },
        money_recharge: function () {
            Controller.rechangeInit('money');
        },
        score_recharge: function () {
            Controller.rechangeInit('score');
        },
        usable_recharge: function () {
            Controller.rechangeInit('usable');
        },
        rechangeInit: function (type) {
            function urlParmas(par) {
                let value = "";
                window.location.search.replace("?", '').split("&").forEach(i => {
                    if (i.split('=')[0] == par) {
                        value = JSON.parse(decodeURI(i.split('=')[1]));
                    }
                });
                return value;
            }
            var recharge = new Vue({
                el: "#recharge",
                data() {
                    return {
                        rechargeType: type,
                        rechargeForm: {
                            user_id: urlParmas('id'),
                            money: '',
                            score: '',
                            usable: '',
                            remarks: '',
                        },
                        rechargeFormInit: {
                            user_id: urlParmas('id'),
                            money: '',
                            usable: '',
                            remarks: '',
                        },
                        rules: {
                            money: [{
                                required: true,
                                message: __('Please enter the recharge amount'),
                                trigger: 'blur'
                            },],
                            usable: [{
                                required: true,
                                message: __('Please input recharge theater points'),
                                trigger: 'blur'
                            },],
                        }
                    };
                },
                mounted() { },
                methods: {
                    submitForm(type, check) {
                        let that = this;
                        if (type == 'yes') {
                            that.$refs[check].validate((valid) => {
                                if (valid) {
                                    let subData = JSON.parse(JSON.stringify(that.rechargeForm));
                                    if (that.rechargeType == 'score') {
                                        delete subData.money;
                                        delete subData.usable;
                                        Fast.api.ajax({
                                            url: 'dramas/user/score_recharge',
                                            loading: true,
                                            data: subData
                                        }, function (ret, res) {
                                            that.rechargeType = null;
                                            that.rechargeForm = JSON.parse(JSON.stringify(that.rechargeFormInit));
                                            Fast.api.close();
                                        });
                                    } else if (that.rechargeType == 'usable') {
                                        delete subData.money;
                                        delete subData.score;
                                        Fast.api.ajax({
                                            url: 'dramas/user/usable_recharge',
                                            loading: true,
                                            data: subData
                                        }, function (ret, res) {
                                            that.rechargeType = null;
                                            that.rechargeForm = JSON.parse(JSON.stringify(that.rechargeFormInit));
                                            Fast.api.close();
                                        });
                                    } else if (that.rechargeType == 'money') {
                                        delete subData.score;
                                        delete subData.usable;
                                        Fast.api.ajax({
                                            url: 'dramas/user/money_recharge',
                                            loading: true,
                                            type: "POST",
                                            data: subData
                                        }, function (ret, res) {
                                            that.rechargeType = null;
                                            that.rechargeForm = JSON.parse(JSON.stringify(that.rechargeFormInit));
                                            Fast.api.close();
                                        });
                                    }
                                } else {
                                    return false;
                                }
                            });
                        } else {
                            that.rechargeForm = JSON.parse(JSON.stringify(that.rechargeFormInit));
                            that.rechargeType = null;
                        }
                    },
                }
            });
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        },

    };
    return Controller;
});