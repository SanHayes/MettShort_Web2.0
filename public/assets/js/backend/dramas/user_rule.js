define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        select: function () {
            var linkSelect = new Vue({
                el: "#linkSelect",
                data() {
                    return {
                        linkData: [],
                        searchWhere: '',
                        activeIndex: 0,
                        selectedid: null,
                        rowData: {},
                        multiple: new URLSearchParams(location.search).get('multiple'),
                        dialogVisible: false,
                        isAll:false

                    }
                },
                mounted() {
                    this.getData();
                    this.$nextTick(() => {
                        $('.scroll-item').each(function (i, element) {
                            var h = $(element).height();
                        });

                    });
                    window.addEventListener('scroll', this.handleScroll, true)
                },
                methods: {
                    checkedAll(val) {
                        this.isAll = val;
                        this.rowData=[];
                        this.linkData.forEach(i => {
                            if(i.children && i.children.length>0){
                                i.children.forEach(j=>{
                                    j.selected=val
                                })
                            }
                        })
                        if(val){
                            this.linkData.forEach(i => {
                                if(i.children && i.children.length>0){
                                    i.children.forEach(j=>{
                                        this.rowData.push(j)
                                    })
                                }
                            })
                        }
                        this.$forceUpdate();
                    },
                    getData() {
                        let that = this;
                        Fast.api.ajax({
                            url: 'dramas/user_rule/select',
                            type: "GET",
                        }, function (ret, res) {
                            that.linkData = res.data;
                            return false;
                        })
                    },
                    operation(type, rows, index, idx) {
                        let multiple = false;
                        let that = this;
                        switch (type) {
                            case 'cancel':
                                Fast.api.close({
                                    data: {},
                                    multiple: multiple
                                });
                                break;
                            case 'define':
                                let row = this.rowData;
                                if (that.multiple == 'true') {
                                    if (row.length > 0) {
                                        var multiplePath = []
                                        row.forEach(r => {
                                            r.path_name = r.title;
                                            multiplePath.push(r.name)
                                        })
                                        row = {
                                            path: multiplePath.join(',')
                                        }
                                        Fast.api.close({
                                            data: row,
                                            multiple: multiple
                                        });
                                    }
                                } else {
                                    Fast.api.close({
                                        data: row,
                                        multiple: multiple
                                    });
                                }
                                break;
                            case 'select':
                                if (that.multiple == 'true') {
                                    this.linkData[index].children[idx].selected = !this.linkData[index].children[idx].selected;
                                    let rowsArr = []
                                    this.linkData.forEach(e => {
                                        if (e.children && e.children.length > 0) {
                                            e.children.forEach(i => {
                                                if (i.selected) {
                                                    rowsArr.push(i)
                                                }
                                            })
                                        }
                                    });
                                    this.rowData = rowsArr;
                                } else {
                                    this.linkData.forEach(e => {
                                        if (e.children && e.children.length > 0) {
                                            e.children.forEach(i => {
                                                i.selected = false;
                                            })
                                        }
                                    });
                                    this.linkData[index].children[idx].selected = !this.linkData[index].children[idx].selected;
                                    this.rowData = rows;
                                    let row = JSON.parse(JSON.stringify(this.rowData));
                                    switch (row.name) {
                                        case '/pages/video/list':
                                            Fast.api.open("dramas/category/select?from=group&type=video", __('Choose'), {
                                                callback: function (data) {
                                                    row.path_name = row.title + '-' + data.data.category_name
                                                    row.path = row.name + '?id=' + data.data.id.toString()
                                                    that.rowData = row;
                                                }
                                            });
                                            break;
                                        case '/pages/video/play':
                                            parent.Fast.api.open("dramas/video/select?multiple=" + false, __('Choose'), {
                                                callback: function (data) {
                                                    row.path_name = row.title + '-' + data.data.title
                                                    row.path = row.name + '?id=' + data.data.id.toString()
                                                    that.rowData = row;
                                                }
                                            });
                                            break;
                                        case '/pages/user/richtext':
                                            Fast.api.open("dramas/richtext/select", __('Choose'), {
                                                callback: function (data) {
                                                    row.path_name = row.title + '-' + data.data.title
                                                    row.path = row.name + '?id=' + data.data.id.toString()
                                                    that.rowData = row;
                                                }
                                            });
                                            break;
                                        case '/pages/public/share/index':
                                            that.dialogVisible = true;
                                            that.rowData = row;
                                            break;
                                        default:
                                            row.path = row.name
                                            row.path_name = row.title
                                            that.rowData = row;
                                    }
                                }

                                this.$forceUpdate();
                                break;
                        }
                    },
                    selected(index) {
                        location.href = "#" + index
                        this.activeIndex = index;
                    },
                    posterUser() {
                        let that = this;
                        let row = that.rowData;
                        that.dialogVisible = false;
                        row.path_name = __('Poster user')
                        row.path = row.name + '?posterType=user'
                        that.rowData = row;
                    },
                    posterVideo() {
                        let that = this;
                        let row = that.rowData;
                        that.dialogVisible = false;
                        parent.Fast.api.open("dramas/video/select?multiple=" + false, __('Choose'), {
                            callback: function (data) {
                                row.path_name = __('Poster video')
                                row.path = row.name + '?posterType=video&id=' + data.data.id.toString()
                                that.rowData = row;
                            }
                        });
                    },
                    handleScroll() {
                        let arr = [];
                        let heightArr = [];
                        $('.scroll-item').each(function (i, element) {
                            var v = $(element).offset().top;
                            var h = $(element).outerHeight(true);
                            arr.push(v);
                            heightArr.push(h)
                        });
                        let handel = [];
                        let indexs = [];
                        arr.forEach((i, index) => {
                            if (i > 0) {
                                handel.push(i);
                                indexs.push(index);
                            }
                        })
                        if (handel[0] < heightArr[indexs[0]] / 2) {
                            this.activeIndex = indexs[0];
                        } else {
                            this.activeIndex = indexs[0] - 1;
                        }
                    },

                },
            })
        },
    };
    return Controller;
});
