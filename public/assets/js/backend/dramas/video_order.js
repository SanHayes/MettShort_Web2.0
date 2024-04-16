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
                        platformList: {},
                        orderList: [],
                        currentPage: 1,
                        totalPage: 0,
                        offset: 0,
                        limit: 10,
                        // form搜索
                        searchForm: {
                            lang_id: 0,
                            copyright_id: '',
                            vid: '',
                            createtime: [moment().startOf('day').format('YYYY-MM-DD HH:mm:ss'), moment().endOf('day').format('YYYY-MM-DD HH:mm:ss')],
                            platform: "",
                            form_2_key: "user_id",
                            form_2_value: "",
                        },
                        countData: {
                            total_orders : 0,
                            total_fee : 0,
                        },
                        searchFormInit: {
                            lang_id: 0,
                            copyright_id: '',
                            vid: '',
                            createtime: [moment().startOf('day').format('YYYY-MM-DD HH:mm:ss'), moment().endOf('day').format('YYYY-MM-DD HH:mm:ss')],
                            platform: "",
                            form_2_key: "user_id",
                            form_2_value: "",
                        },
                        searchOp: {
                            createtime: "range",
                            lang_id: "=",
                            copyright_id: "=",
                            vid: "=",
                            platform: "=",
                            user_id: "=",
                            nickname: "like",
                            user_email: "like",
                        },

                        focusi: false,

                        videoLimit: 6,
                        videoOffset: 0,
                        videoCurrentPage: 1,
                        videoTotalPage: 0,
                        videoSearchPage: '',
                        aboutVideoOptions: [],

                        //版权分润
                        is_copyright: false,
                        aboutCopyrightOptions: [],

                        limitCopyright: 6,
                        offsetCopyright: 0,
                        currentPageCopyright: 1,
                        totalPageCopyright: 0,
                        searchPage: '',
                    }
                },
                mounted() {
                    this.is_copyright = Config.is_copyright;
                    this.langList = Config.langList;
                    this.platformList = Config.platformList;
                    if (new URLSearchParams(location.search).get('datetimerange')) {
                        this.searchForm.createtime = new URLSearchParams(location.search).get('datetimerange').split(' - ');
                    }
                    this.getVideo();
                    this.getData();
                },
                methods: {
                    goRecycle() {
                        Fast.api.open('dramas/video_order/recyclebin', __('Recycle bin'));
                    },
                    delItem(ids) {
                        var that = this;
                        that.$confirm(__('Are you sure you want to delete this item?'), __('Warning'), {
                            confirmButtonText: __('Ok'),
                            cancelButtonText: __('Cancel'),
                            type: 'warning'
                        }).then(() => {
                            Fast.api.ajax({
                                url: 'dramas/video_order/del/ids/' + ids,
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
                            url: 'dramas/video_order/index',
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

                    // 筛选短剧
                    getVideo() {
                        var that = this;
                        Fast.api.ajax({
                            url: `dramas/video/select`,
                            loading: false,
                            type: 'GET',
                            data: {
                                limit: that.videoLimit,
                                offset: that.videoOffset,
                                search: that.videoSearchPage,
                                lang_type: that.searchForm.lang_id
                            }
                        }, function (ret, res) {
                            that.aboutVideoOptions = res.data.rows;
                            that.videoTotalPage = res.data.total
                            return false;
                        })
                    },
                    changeVideo(val) {
                        this.dataFilter('')
                    },
                    debounceFilter: debounce(function () {
                        this.getVideo()
                    }, 1000),
                    dataFilter(val) {
                        this.videoSearchPage = val;
                        // this.videoLimit = 6;
                        // this.videoOffset = 0;
                        // this.videoCurrentPage = 1;
                        this.debounceFilter();
                    },
                    //分页
                    pageSizeChange(val) {
                        this.videoOffset = 0;
                        this.videoLimit = val;
                        this.videoCurrentPage = 1;
                        this.getVideo();
                    },
                    pageCurrentChange(val) {
                        this.videoOffset = (val - 1) * 6;
                        this.videoLimit = 6;
                        this.videoCurrentPage = 1;
                        this.getVideo();
                    },

                    // 版权分润
                    getCopyright() {
                        var that = this;
                        Fast.api.ajax({
                            url: `dramas/copyright/select`,
                            loading: false,
                            type: 'GET',
                            data: {
                                limit: that.limitCopyright,
                                offset: that.offsetCopyright,
                                search: that.searchPage
                            }
                        }, function (ret, res) {
                            that.aboutCopyrightOptions = res.data.rows;
                            that.totalPageCopyright = res.data.total
                            return false;
                        })
                    },
                    changeCopyright() {
                        this.dataFilterCopyright('')
                    },
                    debounceFilterCopyright: debounce(function () {
                        this.getCopyright()
                    }, 1000),
                    dataFilterCopyright(val) {
                        this.searchPage = val;
                        // this.limitCopyright = 6;
                        // this.offsetCopyright = 0;
                        // this.currentPageCopyright = 1;
                        this.debounceFilterCopyright();
                    },
                    //分页
                    pageSizeChangeCopyright(val) {
                        this.offsetCopyright = 0;
                        this.limitCopyright = val;
                        this.currentPageCopyright = 1;
                        this.getCopyright();
                    },
                    pageCurrentChangeCopyright(val) {
                        this.offsetCopyright = (val - 1) * 6;
                        this.limitCopyright = 6;
                        this.currentPageCopyright = 1;
                        this.getCopyright();
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
                url: 'dramas/video_order/recyclebin' + location.search,
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
                                    url: 'dramas/video_order/restore',
                                    refresh: true
                                },
                                {
                                    name: 'Destroy',
                                    text: __('Destroy'),
                                    classname: 'btn btn-xs btn-danger btn-ajax btn-destroyit',
                                    icon: 'fa fa-times',
                                    url: 'dramas/video_order/destroy',
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