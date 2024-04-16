requirejs.config({
	paths: {
		// vue: "/assets/addons/dramas/libs/vue",
		g2: "/assets/addons/dramas/libs/antv"
	}
});
define(['jquery', 'bootstrap', 'backend', 'table', 'form', 'g2'], function ($, undefined, Backend, Table, Form, G2) {

	var Controller = {
		index: function () {
			var vueChart = new Vue({
				el: "#antv-con",
				data() {
					return {
						chartsData: [],
						dataList: [{
							title: __('Reseller order'),
							num: 0,
							checked: true,
							id: 1,
							type: 'reseller',
							color: '#02C1FF',
							unit: __('Orders')
						}, {
							title: __('Vip order'),
							num: 0,
							checked: true,
							id: 5,
							type: 'vip',
							color: '#7299FF',
							unit: __('Orders')
						}, {
							title: __('Usable order'),
							num: 0,
							checked: false,
							id: 2,
							type: 'usable',
							color: '#4BD067',
							unit: __('Orders')
						}, {
							title: __('Withdrawal order'),
							num: 0,
							checked: false,
							id: 6,
							type: 'walletApply',
							color: '#9682FF',
							unit: __('Orders')
						},
						{
							title: __('Withdrawal points'),
							num: 0,
							checked: false,
							id: 3,
							type: 'wallet',
							color: '#FFA800',
							unit: __('Point')
						},
						{
							title: __('Commission points'),
							num: 0,
							checked: false,
							id: 4,
							type: 'resellerLog',
							color: '#FF7D61',
							unit: __('Point')
						}],

						selectInputs: [],
						dropdownList: [{
							date: 'yesterday',
							name: __('Yesterday')
						}, {
							date: 'today',
							name: __('Today')
						}, {
							date: 'week',
							name: __('Week')
						}, {
							date: 'month',
							name: __('Month')
						}, {
							date: 'year',
							name: __('Year')
						}],
						dropdownName: __('Today'),
						dropdownDate: 'today',
						searchTime: [new Date(), new Date()],
						ringRightData: [
							{ item: __('PaypalPay'), type: 'paypalPay', count: 0, percent: 0 },
							{ item: __('StripePay'), type: 'stripePay', count: 0, percent: 0 },
							{ item: __('OtherPay'), type: 'otherPay', count: 0, percent: 0 }
						],
						tableData: [],
						value2: [new Date(), new Date()],
						//环图总数
						allOrderNum: 0,
						//成交比例
						tranPeople: 0,
						tranPeoplescale: 0,
						//支付比例					
						allOrderPayNum: 0,
						transcale: 0,
						orderFinish: {},
						payedFinish: {},
						loading: true
					};
				},
				mounted() {
					//请求数据
					this.changeTime();
				},
				methods: {
					//折线
					charts() {
						$("#main-chart").empty();
						const chart = new G2.Chart({
							container: 'main-chart',
							autoFit: true,
							height: 360,
							animate: true,
						});
						chart.data(this.chartsData);
						var dataBoxNum = 0;
						this.selectInputs.forEach(e => {
							if (e.checked) {
								dataBoxNum++;
							}
						});
						if (dataBoxNum == 1) {
							let title;
							this.selectInputs.forEach(i => {
								if (i.checked) {
									title = i.title;
								}
							});
							chart.scale({
								date: {
									alias: ' ',
								},
								y2: {
									alias: title,
									min: 0,
									sync: true,
									nice: true,
								},
							});
							chart
								.area()
								.position('date*y2')
								.color(this.selectInputs[0].color).tooltip(false).shape('smooth');
							chart
								.line()
								.position('date*y2')
								.color(this.selectInputs[0].color).shape('smooth');
						} else if (dataBoxNum == 2) {
							chart.scale({
								date: {
									alias: ' ',
								},
								y2: {
									alias: this.selectInputs[1].title,
									sync: true,
									nice: true,
									min: 0
								},
								y1: {
									alias: this.selectInputs[0].title,
									sync: true,
									nice: true,
									min: 0
								},
							});

							chart
								.area()
								.position('date*y1')
								.color(this.selectInputs[0].color).tooltip(false).shape('smooth');
							chart
								.line()
								.position('date*y1')
								.color(this.selectInputs[0].color).shape('smooth');
							chart
								.area()
								.position('date*y2')
								.color(this.selectInputs[1].color).tooltip(false).shape('smooth');
							chart
								.line()
								.position('date*y2')
								.color(this.selectInputs[1].color).shape('smooth');

						} else {
							return false;
						}
						var margin = 1 / this.chartsData.length;
						chart.axis('date', {
							range: [margin / 4, 1 - margin / 4]

						});
						chart.axis('y1', {
							grid: null,
							title: {},
						});
						chart.axis('y2', {
							title: {},
						});

						chart.tooltip({
							showCrosshairs: true, //展示辅助线
							shared: true,
						});
						chart.render();
					},
					//选择显示数据
					selectLine(idx) {
						this.dataList[idx].checked = !this.dataList[idx].checked;
						if (this.dataList[idx].checked == true) {
							this.selectInputs.push(this.dataList[idx]);
							if (this.selectInputs.length > 2) {
								this.selectInputs[0].checked = false;
								this.selectInputs.shift();
							}
						} else {
							this.selectInputs.forEach((item, index) => {
								if (this.dataList[idx].id == item.id)
									this.selectInputs.splice(index, 1);
							});
						}
						this.countOrderData();
						// this.charts()
					},
					//环图
					ringRight() {
						var that = this;
						$("#ring-right").empty();
						const chart = new G2.Chart({
							container: 'ring-right',
							autoFit: true,
							height: 300,
							width: 260,
							padding: [0, 0, 50, 0]
						});
						chart.data(this.ringRightData);
						chart.scale('percent', {
							formatter: (val) => {
								val = val * 100 + '%';
								return val;
							},
						});
						chart.coordinate('theta', {
							radius: 0.85,
							innerRadius: 0.8,
						});
						chart.tooltip({
							showTitle: false,
							showMarkers: false,
							itemTpl: '<li class="g2-tooltip-list-item"><span style="background-color:{color};" class="g2-tooltip-marker"></span>{name}: {value}({count})</li>',
						});
						// 辅助文本
						chart
							.annotation()
							.text({
								position: ['50%', '50%'],
								content: this.allOrderNum,
								style: {
									fontSize: 36,
									fill: '#753ECD',
									textAlign: 'center',
								},
								offsetX: -10,
								offsetY: -20,
							})
							.text({
								position: ['50%', '50%'],
								content: __('Orders'),
								style: {
									fontSize: 16,
									fill: '#753ECD',
									textAlign: 'center',
								},
								offsetY: -20,
								offsetX: 30,
							})
							.text({
								position: ['50%', '50%'],
								content: __('Payment orders'),
								style: {
									fontSize: 16,
									fill: '#753ECD',
									textAlign: 'center',
								},
								offsetY: 20,
							});
						chart
							.interval()
							.adjust('stack')
							.position('percent')
							.color('item', ['#38C769', '#627EFC', '#FF826C', '#F7B500'])
							.tooltip('item*percent', (item, percent) => {
								let counts = Math.round(that.allOrderNum * percent);
								percent = percent * 100 + '%';
								return {
									name: item,
									value: percent,
									count: counts
								};
							});

						chart.render();
					},
					//表格
					tableRowClassName({ row, rowIndex }) {
						if (rowIndex % 2 == 0) {
							return 'gray-row';
						}
						return '';
					},
					//选择时间段
					changeTime(index = 1) {
						this.dropdownDate = this.dropdownList[index].date;
						this.dropdownName = this.dropdownList[index].name;
						this.searchTime = this.getTimeSlot();
						this.getDataInfo();
					},
					//选择请求数据
					getDataInfo() {
						this.loading = true;
						let that = this;
						let timeSlot = moment(that.searchTime[0]).format("YYYY-MM-DD HH:mm:ss") + ' - ' + moment(that.searchTime[1]).format("YYYY-MM-DD HH:mm:ss");
						Fast.api.ajax({
							url: 'dramas/dashboard/index',
							loading: false,
							data: {
								datetimerange: timeSlot
							},
							success: function (res, ret) {
								let data = res.data;
								that.tableData = data.videoList;
								that.orderFinish = data.orderFinish;
								that.payedFinish = data.payedFinish;
								that.dataList.forEach(d => {
									d.num = data[d.type + 'PayOrderNum'];
									d.item = data[d.type + 'PayOrderArr'];
								});
								that.allOrderNum = data.allTypePay;
								that.ringRightData.forEach(p => {
									if (p.type != 'otherPay') {
										p.count = data[p.type];
										p.percent = that.scaleFunc(data[p.type], data.allTypePay);
									} else {
										p.count = data.allTypePay - data.paypalPay - data.stripePay;
										p.percent = that.scaleFunc(p.count, data.allTypePay);
									}
								});
								that.ringRight();
								//判断是否选中
								that.selectInputs = [];
								that.dataList.forEach((item, index) => {
									if (item.checked == true) that.selectInputs.push(item);
								});
								// 请求数据
								that.countOrderData();
							}
						});
					},

					countOrderData() {
						let that = this;
						let time = (
							new Date(moment(that.searchTime[1]).format("YYYY-MM-DD HH:mm:ss").replace(/-/g, "/")).getTime() - new Date(moment(that.searchTime[0]).format("YYYY-MM-DD HH:mm:ss").replace(/-/g, "/")).getTime()
						) / 1000 + 1;
						let kld = '';
						let interval = 0;
						if (time <= 60 * 60) {
							interval = parseInt(time / 60);

							kld = 'minutes';
						} else if (time <= 60 * 60 * 24) {
							interval = parseInt(time / (60 * 60));

							kld = 'hours';
						} else if (time <= 60 * 60 * 24 * 30 * 1.5) {
							interval = parseInt(time / (60 * 60 * 24));

							kld = 'days';

						} else if (time < 60 * 60 * 24 * 30 * 24) {
							interval = parseInt(time / (60 * 60 * 24 * 30));

							kld = 'months';

						} else if (time >= 60 * 60 * 24 * 30 * 24) {
							interval = parseInt(time / (60 * 60 * 24 * 30 * 12));

							kld = 'years';

						}
						this.drawX(interval, kld);

					},
					drawX(interval, kld) {
						let that = this;
						let x = [];
						let selectInputLeng = 0;
						this.selectInputs.forEach(e => {
							if (e.checked) {
								selectInputLeng++;
							}
						});
						for (let i = 0; i <= interval; i++) {
							if (kld == 'minutes' || kld == 'hours') {
								x.push({
									date: moment(that.searchTime[0]).add(i, kld).format("DD HH:mm"),
									timeStamp: moment(that.searchTime[0]).add(i, kld).valueOf(),
									y2: 0,
									y1: 0
								});
							} else if (kld == 'days') {
								x.push({
									date: moment(that.searchTime[0]).add(i, kld).format("YYYY-MM-DD"),
									timeStamp: moment(that.searchTime[0]).add(i, kld).valueOf(),
									y2: 0,
									y1: 0
								});
							} else if (kld == 'months') {
								x.push({
									date: moment(that.searchTime[0]).add(i, kld).format("YYYY-MM"),
									timeStamp: moment(that.searchTime[0]).add(i, kld).valueOf(),
									y2: 0,
									y1: 0
								});
							} else {
								x.push({
									date: moment(that.searchTime[0]).add(i, kld).format("YYYY"),
									timeStamp: moment(that.searchTime[0]).add(i, kld).valueOf(),
									y2: 0,
									y1: 0
								});
							}
						}
						if (selectInputLeng == 1) {
							for (var y = 0; y < x.length; y++) {
								let y2 = 0;
								let selectItem = [];
								let id = 0;
								this.selectInputs.forEach(element => {
									if (element.checked == true) {
										selectItem = element.item;
										id = element.id;
									}
								});
								if (id == 6) {
									let arr = JSON.parse(JSON.stringify(selectItem));
									selectItem.forEach(se => {
										if (y == x.length - 1) {
											y2 = x[x.length - 2].y2;
										} else {
											if (se.createtime <= x[y + 1].timeStamp) {
												flag2 = true;
												y2 = 0;
												arr.forEach(aa => {
													if (aa.createtime <= se.createtime) {
														y2++;
													}
												});
											}
										}
									});
								} else {
									selectItem.forEach(se => {
										if (y != x.length - 1) {
											if (se.createtime > x[y].timeStamp && se.createtime <= x[y + 1].timeStamp) {
												y2 += Number(se.counter);
											}
										} else {
											if (se.createtime > x[y].timeStamp) {
												y2 += Number(se.counter);
											}
										}
									});
								}
								x[y].y2 = y2;
							}
						}
						if (selectInputLeng == 2) {
							for (var y = 0; y < x.length; y++) {
								let y1 = 0;
								let y2 = 0;
								this.selectInputs.forEach((si, sindex) => {
									if (si.id == 6) {
										let arr = JSON.parse(JSON.stringify(si.item));
										si.item.forEach(se => {
											if (y == x.length - 1) {
												if (sindex == 0) {
													y1 = x[x.length - 2].y1;
												} else {
													y2 = x[x.length - 2].y2;
												}
											} else {
												if (se.createtime <= x[y + 1].timeStamp) {
													if (sindex == 0) {
														y1 = 0;
														arr.forEach(aa => {
															if (aa.createtime <= se.createtime) {
																y1++;
															}
														});
													} else {
														y2 = 0;
														arr.forEach(aa => {
															if (aa.createtime <= se.createtime) {
																y2++;
															}
														});
													}

												}
											}
										});
									} else {
										si.item.forEach(se => {
											if (y != x.length - 1) {
												if (se.createtime > x[y].timeStamp && se.createtime <= x[y + 1].timeStamp) {
													if (sindex == 0) {
														y1 += Number(se.counter);
													} else {
														y2 += Number(se.counter);
													}
												}
											} else {
												if (se.createtime > x[y].timeStamp) {
													if (sindex == 0) {
														y1 += Number(se.counter);
													} else {
														y2 += Number(se.counter);
													}
												}
											}
										});
									}
								});
								x[y].y1 = y1;
								x[y].y2 = y2;
							}
						}
						that.chartsData = x;
						that.loading = false;
						that.charts();
					},
					//获取时间
					getTimeSlot() {
						let beginTime = '';
						let endTime = moment().format('YYYY-MM-DD');
						switch (this.dropdownDate) {
							case 'yesterday':
								endTime = moment().subtract(1, 'days').format('YYYY-MM-DD');
								beginTime = endTime;
								break;
							case 'today':
								beginTime = endTime;
								break;
							case 'week':
								beginTime = moment().subtract(1, 'weeks').format('YYYY-MM-DD');
								break;
							case 'month':
								beginTime = moment().subtract(1, 'months').format('YYYY-MM-DD');
								break;
							case 'year':
								beginTime = moment().subtract(1, 'years').format('YYYY-MM-DD');
								break;
						}
						let timeSlot = [beginTime + ' 00:00:00', endTime + ' 23:59:59'];
						return timeSlot;
					},
					goDetail(id) {
						let that = this;
						let url = '';
						let title = __('Detail');
						let times = encodeURI(that.searchTime.join(" - "));
						switch (id) {
							case 1:
								title = __('Reseller order');
								url = 'dramas/reseller_order?datetimerange=' + times;
								break;
							case 2:
								title = __('Usable order');
								url = 'dramas/usable_order?datetimerange=' + times;
								break;
							case 4:
								title = __('Reseller log');
								url = 'dramas/reseller_log?datetimerange=' + times;
								break;
							case 5:
								title = __('Vip order');
								url = 'dramas/vip_order?datetimerange=' + times;
								break;
							case 6:
								title = __('Withdrawal order');
								url = 'dramas/user_wallet_apply?datetimerange=' + times;
								break;
						}
						// parent.Fast.api.open(url, __('Detail'), { callback: function (data) { } });
						parent.Backend.api.addtabs(url, title)
						return false;
					},
					scaleFunc(a, b) {
						return (a <= 0 ? 0 : a / b).toFixed(2) - 0;
					}
				},
			});
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
				url: 'dramas/decorate/recyclebin' + location.search,
				pk: 'id',
				sortName: 'id',
				columns: [
					[
						{ checkbox: true },
						{ field: 'id', title: __('Id') },
						{ field: 'name', title: __('Name'), align: 'left' },
						{
							field: 'deletetime',
							title: __('Deletetime'),
							operate: 'RANGE',
							addclass: 'datetimerange',
							formatter: Table.api.formatter.datetime
						},
						{
							field: 'operate',
							width: '130px',
							title: __('Operate'),
							table: table,
							events: Table.api.events.operate,
							buttons: [
								{
									name: 'Restore',
									text: __('Restore'),
									classname: 'btn btn-xs btn-info btn-ajax btn-restoreit',
									icon: 'fa fa-rotate-left',
									url: 'dramas/decorate/restore',
									refresh: true
								},
								{
									name: 'Destroy',
									text: __('Destroy'),
									classname: 'btn btn-xs btn-danger btn-ajax btn-destroyit',
									icon: 'fa fa-times',
									url: 'dramas/decorate/destroy',
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