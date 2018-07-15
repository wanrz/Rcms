/**
 * Description: 动态数据网格，自带分页；默认显示第一页,默认每页10条,最大可支持每页50条;
 * 
 * 该JS文件在jQuery的基础上扩展四个函数
 * 1、crateTable(options) 在div上创建数据网格；该方法返回对象本身
   例如：$("#myTabel").createTable({
			dataHeader:dataHeader,//数组，每列的属性（必须）
			root:"examList",//返回数据的key（必须）
			url:"queryExamList.ajax",//请求数据地址（必须）
			pagination:true,//是否分页(默认false)
			
			frozenHeader:true,//是否固定表头(非必须)
			
			param:function(){//查询参数（非必须）
				return {"gender":"0","name":'haha'};//最终返回JSON对象
			}//请求参数，返回JSON对象(非必须)
		});
 * 2、loadData();加载数据，无参数；该方法只能在调用createTable(options)后方可调用；该方法返回对象本身
 * 3、getSelectItems();获取被选中的数据；返回一个数组
 * 4、getDataProvider();获取所有数据；返回一个数组
 * 5、loadDataCallBack();表格数据渲染后调用
 * 
 * author 杨宝
 * version 2014-12-18 上午10:33:58
 */
(function($){
	/**
	 * 动态加载外部文件，包括JS文件和CSS文件
	 * */
	var loadFile = function(path){
		var head = window.document.getElementsByTagName("head")[0];
		if(!path || path.length===0){
			throw new Error('argument "path" is required!');
		}
		var type = path.substr(path.lastIndexOf(".")+1);
		switch(type){
			case "css":
				var link = window.document.createElement("link");
				link.href = path;
				link.rel = "stylesheet";
				link.type = "text/css";
				head.appendChild(link);
				break;
			case "js":
				var script = window.document.createElement("script");
				script.src = path;
				script.type = "text/javascript";
				head.appendChild(script);
				break;
			default:
				throw new Error(type + " is not support");
		} 
	
	};
	//获取本文件目录 
	var js = document.scripts || $('script'), jsPath = js[js.length - 1].src;
	 var basePath = jsPath.substring(0, jsPath.lastIndexOf("/") + 1);
	
	//加载样式文件
	loadFile(basePath+"dataGrid.css");
	
	/**
	 * 设置table单元格样式
	 * */
	function setAttr(target,options){
		var width = options.width,
		align = options.align,
		valign = options.valign,
		className = options.className;
		if(typeof width ==="string" && width!==""){
			target.attr("width",width);
		}
		if(typeof align ==="string" && align!==""){
			target.attr("align",align);
		}
		if(typeof valign ==="string" && valign!==""){
			target.attr("valign",valign);
		}
		if(typeof className ==="string" && className!==""){
			target.attr("class",className);
		}
	};
	
	/**
	 * 初始化分页按钮
	 * */
	function initPagination(target){
		var outerDivId = target[0].id;
		//初始化 
		var page = $.trim(target.find("#page"+outerDivId).val());//当前页码
		var total = $.trim(target.find("#total"+outerDivId).text());//共多少页
		
		page = parseInt(page);
		total = parseInt(total);
		
		if(isNaN(page)||isNaN(total)){
			page = 1;
			total = 0;
		}
		
		if(page<=1){//首页、上一页禁用
			target.find("#first"+outerDivId+" img").attr("src",basePath+"images/page-first-disabled.gif");
			target.find("#prev"+outerDivId+" img").attr("src",basePath+"images/page-prev-disabled.gif");
			disableMouseHover($("#prev"+outerDivId+",#first"+outerDivId));
		}else{//首页、上一页可用
			target.find("#first"+outerDivId+" img").attr("src",basePath+"images/page-first.gif");
			target.find("#prev"+outerDivId+" img").attr("src",basePath+"images/page-prev.gif");
			enableMouseHover($("#prev"+outerDivId+",#first"+outerDivId));
			$("#first"+outerDivId).unbind("click").bind("click",function(){
				target.find("#page"+outerDivId).val(1);
				target.loadData();
			});
			
			$("#prev"+outerDivId).unbind("click").bind("click",function(){
				target.find("#page"+outerDivId).val(page-1);
				target.loadData();
			});
		} 
		
		if(page>=total){//尾页、下一页禁用
			target.find("#next"+outerDivId+" img").attr("src",basePath+"images/page-next-disabled.gif");
			target.find("#last"+outerDivId+" img").attr("src",basePath+"images/page-last-disabled.gif");
			disableMouseHover($("#next"+outerDivId+",#last"+outerDivId));
		}else{//尾页、下一页可用
			target.find("#next"+outerDivId+" img").attr("src",basePath+"images/page-next.gif");
			target.find("#last"+outerDivId+" img").attr("src",basePath+"images/page-last.gif");
			enableMouseHover($("#next"+outerDivId+",#last"+outerDivId));
			$("#last"+outerDivId).unbind("click").bind("click",function(){
				target.find("#page"+outerDivId).val(total);
				target.loadData();
			});
			
			$("#next"+outerDivId).unbind("click").bind("click",function(){
				target.find("#page"+outerDivId).val(page+1);
				target.loadData();
			});
		}
		
		if(total==0){//刷新不可用，输入框不可用
			disableMouseHover($("#refresh"+outerDivId));
			disableInput();
		}else{//刷新可用,输入框可用
			enableMouseHover($("#refresh"+outerDivId));
			enableInput();
			$("#refresh"+outerDivId).unbind("click").bind("click",function(){
				target.loadData();
			});
		}
		
		/**
		 * btn可用
		 * */
		function enableMouseHover(obj){
			obj.unbind("mouseover mouseleave").bind("mouseover",function(){
				$(this).removeClass("p_btn_over").addClass("p_btn_over");
			}).bind("mouseleave",function(){
				$(this).removeClass("p_btn_over");
			});
		}
		
		/**
		 * btn不可用
		 * */
		function disableMouseHover(obj){
			obj.unbind("mouseover click");
		}
		
		function disableInput(){
			$("#limit"+outerDivId+",#page"+outerDivId).attr("disabled","disabled");
		}
		
		/**
		 * 输入框控制
		 * */
		function enableInput(){
			$("#limit"+outerDivId+",#page"+outerDivId).removeAttr("disabled");
			target.find("#limit"+outerDivId).unbind("check").bind("check",function(){
				var value = $(this).val();
				if(isNaN(value)|| value<=0){
					$(this).val(10);
				}
				if(value>500){
					$(this).val(500);
				}
			});
		
			target.find("#page"+outerDivId).unbind("check").bind("check",function(){
				var value = $(this).val();
				if(isNaN(value)|| value<=0){
					$(this).val(1);
				}
				if(value>total){
					$(this).val(total);
				}
			});
			
			target.find("#limit"+outerDivId).unbind("keyup").bind("keyup",function(event){
				var keyCode = event.keyCode;
				if(keyCode==13){
					target.find("#page"+outerDivId).val(1);
					target.loadData();
				}
				
			});
			
			target.find("#page"+outerDivId).unbind("keyup").bind("keyup",function(event){
				var keyCode = event.keyCode;
				if(keyCode==13){
					target.loadData();
				}
			});
		}
	}
	
	$.fn.extend({
		/**
		 * 动态创建table
		 * */
		createTable:function(options){
			if(this[0].tagName.toLocaleLowerCase() !='div'){
				alert("使用div标签嵌套表格。别问我为什么，我是程序员，任性！！！");
				return this;
			}
			
			if(this[0].id == null || this[0].id == ''){
				alert("div标签的id不能为空。别问我为什么，我是程序员，任性！！！");
				return this;
			}
			
			//只支持单个创建
			if(this.size()!=1){
				return this;
			}
			
			//如果已存在table，则不创建
			if(this.find("table").size()>=1){
				return this;
			}
			
			//表格外层div的id
			var outerDivId = this[0].id;
			
			//保存创建参数，供后续使用
			options.loadDataCallBack = options.loadDataCallBack || function(){return {};},
			this.data("options",options);
			
			var width = options.width||"100%";
			var dataGrid_box = $('<div class="dataGrid"></div>');
			
			//创建表头
			var dg_head = $('<div class="dataGrid_head"><table class="dataGrid_body table table-striped table-bordered dataTable" id="myBootDataGrid'+outerDivId+'" cellpadding="0" cellspacing="0" border="0"><thead class="dataGrid_thead"><tr role="row"></tr></thead>');
			var dg_head_end = $("</table></div>");
			var dataHeader = options.dataHeader || [];
			
			//创建表头列
			for(var i in dataHeader){
				var thead_col = dataHeader[i];
				var th = $('<th class="center" style="border:0px;" role="columnheader" tabindex="0" aria-controls="myBootDataGrid'+outerDivId+'" rowspan="1" colspan="1"></th>');
				var label = thead_col["label"];;
				if(label==="checkbox"){
					th.append('<input type="checkbox" class="center"/>');
				}else{
					th.text(label);
				}
				setAttr(th,thead_col);
				dg_head.find("tr").append(th);
			}
			//创建表格内容
			//var dg_body = $('<tbody class="dataGrid_body" role="alert" aria-live="polite" aria-relevant="all"></tbody>');
			
			
			var pageSize = options.limit || 10;
			if(isNaN(pageSize)){
				pageSize = 10;
			}
			//dg_body.css({"height":pageSize*46.5+"px"});
			
			//dg_body.css({"width":width});
			dg_head.css({"width":width});
			
			dataGrid_box.append(dg_head);
			//dataGrid_box.append(dg_body);
			dataGrid_box.append(dg_head_end);
			this.append(dataGrid_box);
			
			var pagination = options.pagination;
			
			if(pagination===undefined){
				pagination = true;
			}
			if(pagination!==false){
				//创建分页工具栏
				var pagination = $(
					'<div class="">'
					+'<ul class="pagination-20161212">'
					+'<li id="first'+outerDivId+'" class="p_btn"><img src="'+ basePath +'images/page-first-disabled.gif" alt="首页"/></li>'
					+'<li id="prev'+outerDivId+'" class="p_btn"><img src="'+ basePath +'images/page-prev-disabled.gif" alt="上一页"/></li>'
					+'<li class="p_split"><img src="'+ basePath +'images/grid-split.gif"/></li>'
					+'<li class="p_input">第<input type="text" value="1" id="page'+outerDivId+'"/>页/共<span id="total'+outerDivId+'">0</span>页</li>'
					+'<li class="p_split"><img src="'+ basePath +'images/grid-split.gif"/></li>'
					+'<li id="next'+outerDivId+'" class="p_btn"><img src="'+ basePath +'images/page-next-disabled.gif" alt="下一页"/></li>'
					+'<li id="last'+outerDivId+'" class="p_btn"><img src="'+ basePath +'images/page-last-disabled.gif" alt="尾页"/></li>'
					+'<li id="refresh'+outerDivId+'" class="p_btn"><img src="'+ basePath +'images/refresh.gif" alt="刷新"/></li>'
					+'<li class="p_split"><img src="'+ basePath +'images/grid-split.gif"/></li>'
					+'<li class="p_input">每页显示<input value="'+pageSize+'" id="limit'+outerDivId+'" type="text"/>条</li>'
					+'<li class="p_desc">当前显示<span id="start'+outerDivId+'">0</span>-<span id ="end'+outerDivId+'">0</span>条,共<span id="count'+outerDivId+'">0</span>条</li>'
				+'</ul></div>'
				);
				dg_head.append(pagination);
				this.find("img").toolTips(2);
			}
			return this;
		},
		//修复查询时分页控件没有初始化的bug
		initData:function(){
			this.find("#page"+outerDivId).val("1");
		},
		/**
		 * 加载数据
		 * */
		loadData:function(){
			//不支持多个同时创建
			if(this.size()!=1){
				return this;
			}
			//盒模型里不能有多个table
			if(this.find(".dataGrid_body").size()!=1){
				return this;
			}
			
			//表格外层div的id
			var outerDivId = this[0].id;
			
			//定义变量
			var options = this.data("options"),
			root = options.root || "",
			url = options.url || "",
			param = {},
			param_func = options.param || function(){return {};},
			loadDataCallBack = options.loadDataCallBack,
			dataHeader = options.dataHeader || [],
			_this = this,

			table = this.find(".dataGrid_body"),
			pagination = options.pagination,
			initialize = options.initialize;
			
			if(typeof param_func ==="function"){
				param = param_func();
				if(!param){
					param = {};
				}
			}
						
			if(pagination !==false){
				_this.find("#limit"+outerDivId+",#page"+outerDivId).trigger("check");

				//封装分页参数
				var pageCond = {};
				
				var limit = _this.find("#limit"+outerDivId).val();
				var page = _this.find("#page"+outerDivId).val();
				limit = parseInt(limit);
				page = parseInt(page);
				
				if(isNaN(page) || isNaN(limit)){
					page = 1;
					limit = 10;
				}
				
				param["pageCond.start"] = limit*(page-1)+1;
				param["pageCond.limit"] = limit;
			}
			
			//显示遮罩
			window.top.layer.load(0,1);
			//请求数据
			$.ajax({
				url:url,
				data:param,
				success:function(data){
					data = data.RSP_BODY;//后期添加RSP_BODY后需要修改为data=data.RSP_BODY
					//关闭遮罩
					window.top.layer.close(window.top.layer.index);
					//绑定数据源
					_this.data("dataProvider",data["Data"][root]);
					//清空上次查询的数据
					table.find("tbody").remove();
					
					//获取分页参数
					var pageCond = data["PageCond"];
					//分页参数校验
					if(pageCond){
						//对分页插件重新赋值
						var count = parseInt(pageCond.count);
						limit = parseInt(pageCond.limit);
						var start = parseInt(pageCond.start);
						var end = start-1 + ((count-start+1)>=limit ? limit : (count % limit));
						if(count==0){
							start = 0;
							end = 0;
						}
						var total = Math.ceil(count/limit);
						_this.find("#total"+outerDivId).text(total);
						_this.find("#end"+outerDivId).text(end);
						_this.find("#count"+outerDivId).text(count);
						_this.find("#start"+outerDivId).text(start);
						
						initPagination(_this);
					}
					
					//渲染数据
//					if(data["Data"][root] && data["Data"][root].length>0){
//						callback(data["Data"][root]);
//						
//					}
					callback(data["Data"][root],loadDataCallBack);
					
					if(typeof initialize ==="function"){
						initialize();
					}
					 
				}
			});
			
			
			
			/**
			 * 后台获取到数据后对表格进行渲染
			 * */
			function callback(jsonArray,loadDataCallBack,limit){
				//先创建表格，默认10行
				var tbody = $('<tbody class="dataGrid_tbody" role="alert" aria-live="polite" aria-relevant="all"></tbody>');
				var cnt = 0;
				//循环替换表格内容
				if(jsonArray.length > 0){
					for(var i in jsonArray){
						var tr = $("<tr></tr>");
						//tr.addClass("tr"+(i%2));
						if(i%2 != 0){
							tr.addClass("gradeA odd");
						}else{
							tr.addClass("gradeA even");
						}
						for(var j in dataHeader){
							var td = $("<td class='center'></td>");
							setAttr(td,dataHeader[j]);
							tr.append(td);
							var label = dataHeader[j]["label"];
							var text = jsonArray[i]["isChecked"];
							if(label ==="checkbox"){
								var checkBox = $('<input type="checkbox" />');
								checkBox.data("_index",i);
								if(text==="true" || text ===true){
									checkBox.attr("checked","checked");
									cnt++;
								}
								td.html(checkBox);
							}else if(label==="序号"){
								td.text(1+parseInt(i));
							}else{
								var filter = dataHeader[j]["filter"] || "";
								if(filter){
									var func_filter = window[filter];
									func_filter(jsonArray[i],td);
								}else{
									var text = jsonArray[i][dataHeader[j]["dataField"]];
									var dict = dataHeader[j]["dict"];
									if(dict){
										var dict_data = window.user_data[dict];
										td.html(dict_data[text]);
										
									}else{
										td.html(text);
									}
									
								}
							}
						}
						tbody.append(tr);
					}
				}else{
					var td = $("<td class='center'>暂无数据</td>");
					td.attr("colspan",dataHeader.length);
					var tr = $("<tr></tr>");
					tr.addClass("gradeA odd");
					tr.append(td);
					tbody.append(tr);
				}
				
				table.append(tbody);
				
				//判断是否被全选
				if(cnt===jsonArray.length && cnt !=0){
					_this.find(".dataGrid_thead th :checkbox").attr("checked","checked");
				}else{
					_this.find(".dataGrid_thead th :checkbox").removeAttr("checked");
				}
				//重新初始化复选框
				if(_this.find(":checkbox").size()>0){
					initCheckBox(_this);
				}
				
				if(jsonArray.length > 0){
					loadDataCallBack();
				}
			}
			
			
			
			//初始化复选框
			function initCheckBox(target){
				//全选复选框
				var chooseAll = target.find(".dataGrid_thead th :checkbox");
				//每条记录上的复选框
				var choose = target.find(".dataGrid_tbody :checkbox");
				//每条记录上的双击
				var dblclikcTr = target.find(".dataGrid_tbody tr");
				//获取数据
				var dataProvider = target.data("dataProvider");
				
				//点击全选复选框
				chooseAll.unbind("click").bind("click",function(){
					if(this.checked){
						for(var i in dataProvider){
							dataProvider[i]["isChecked"] = true;
							choose[i].checked = true;
						};
					}else{
						for(var i in dataProvider){
							dataProvider[i]["isChecked"] = false;
							choose[i].checked = false;
						};
					}
					target.data("dataProvider",dataProvider);
				});
				
				//点击复选框
				choose.unbind("click").bind("click",function(){
					var _index = $(this).data("_index");
					if(this.checked){
						dataProvider[_index]["isChecked"] = true;
						for(var i in dataProvider){
							if(dataProvider[i]["isChecked"]!==true && dataProvider[i]["isChecked"]!=="true"){
								return;
							}
						}
						chooseAll.get(0).checked = true;
					}else{
						chooseAll.get(0).checked = false;
						dataProvider[_index]["isChecked"] = false;
					}
					target.data("dataProvider",dataProvider);
				});
				
				//tr的双击
				dblclikcTr.unbind("dblclick").bind("dblclick",function(){
					var _index = $(this).find(":checkbox").data("_index");
					if(!$(this).find(":checkbox")[0].checked){
						dataProvider[_index]["isChecked"] = true;
						$(this).find(":checkbox")[0].checked = true;
						target.data("dataProvider",dataProvider);
						for(var i in dataProvider){
							if(dataProvider[i]["isChecked"]!==true && dataProvider[i]["isChecked"]!=="true"){
								return;
							}
						}
						chooseAll.get(0).checked = true;
					}else{
						chooseAll.get(0).checked = false;
						dataProvider[_index]["isChecked"] = false;
						$(this).find(":checkbox")[0].checked = false;
					}
					target.data("dataProvider",dataProvider);
				});
			}
			
			return _this;
		},
		
		/**
		 * 返回选中的数据。注意：此处返回的是数据副本，对返回结果的操作不会影响原始数据。
		 * */
		getSelectItems:function(){
			var result = new Array();
			try{
				var dataProvider = this.data("dataProvider");
				var k = 0;
				for ( var i in dataProvider) {
					var tmp = dataProvider[i];
					if(tmp.isChecked==="true" || tmp.isChecked===true){
						//对数组内每个元素进行复制，避免对返回的结果的操作影响元数据
						result[k] = $.extend(true,{},tmp);
						result[k].isChecked = undefined;
						k++;
					}
				}
			}catch(e){
			}
			return result;
		},
		/**
		 * 返回所有数据。注意：此处返回的是数据副本，对返回结果的操作不会影响原始数据。
		 * */
		getDataProvider:function(){
			var result = new Array();
			var dataProvider = this.data("dataProvider");
			try {
				var k = 0;
				for(var i in dataProvider){
					var tmp = dataProvider[i];
					//对数组内每个元素进行复制，避免对返回的结果的操作影响元数据
					result[k] = $.extend(true,{},tmp);
					result[k].isChecked = undefined;
					k++;
				}
			} catch (e) {
			}
			return result;
		}
		
	});
})(jQuery);