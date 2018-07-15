/**
 * 使用ztree的方式操作树
 * 1、提供属性
 * 	treeId:树挂载组件的id，不能为空
 * 	treeType:树类型
 *  queryMore:树初始化后，是否允许多次查询。true允许多次查询，默认true
 *  lazy:是否立即查询，默认false，不及时查询，需要调用loadRootNode方法。
 *  isExpandQuery:点击节点是否查询子节点。true查询，默认true
 * 	treeRootUrl:查询根节点的url,不能为空
 *  defaultSelectedNode:默认选中节点，如果为空，则选择树形结构的第一个根节点
 *  notQueryAfterInit：初始化指挥，是否查询。默认不查询（true）
 * 	treeRootKey:后台返回根节点的key，默认值为treeRootList
 * 	treeChildUrl:查询子节点的url，不能为空
 * 	treeChildKey:后台返回子节点的key，默认值为treeChildList
 *  check:复选框格式
 *  rootParameter:父节点查询参数扩展
 *  childParameter:子节点查询参数扩展
 *  
 * 2、回调函数
 * 	onClick:单击树名称的回调函数，返回被单击的节点
 * 	onCheck:如果有复选框，返回被选择的节点
 * 
 * 3、返回值
 *  tree
 */
(function($) {
	
	$.beTree = function(options) {
		if (!valid(options)) {
			return this;
		}
		var tree = treeInit();
		init(tree,options);
//		if(!options.lazy){
			tree.loadRootNode();
//		}

		function valid(options) {
			options = options || {};
			if (options.treeId === undefined) {
				alert("树组件挂载标签的id参数【treeId】不能为空。别问我为什么，我是程序员，任性！！！");
				return false;
			}
			if (options.treeRootUrl === undefined) {
				alert("查询树根节点的url参数【treeRootUrl】不能为空。别问我为什么，我是程序员，任性！！！");
				return false;
			}
			
			options.treeRootKey = _undef(options.treeRootKey, "treeRootList");
			options.treeChildKey = _undef(options.treeChildKey, "treeChildList");
			
			options.defaultSelectedNode = _undef(options.defaultSelectedNode,null);
			options.notQueryAfterInit = _undef(options.notQueryAfterInit,true);
			
			options.treeType = _undef(options.treeType, "");
			options.check = options.check || {};
			options.onClick = options.onClick || function() {};
			options.onCheck = options.onCheck || function() {};
			options.rootParameter = options.rootParameter ||{};
			options.childParameter = options.childParameter ||{};
//			options.lazy = _undef(options.lazy,false);
			options.isExpandQuery = _undef(options.isExpandQuery,false);
			options.queryMore = _undef(options.queryMore,true);
			return true;
		}

		function init(tree,options) {
			tree.treeId = options.treeId;
			tree.queryMore = options.queryMore;
			tree.treeType = options.treeType;
			tree.isExpandQuery = options.isExpandQuery;
			tree.treeRootUrl = options.treeRootUrl;
			tree.treeRootKey = options.treeRootKey;
			
			tree.defaultSelectedNode = options.defaultSelectedNode;
			tree.notQueryAfterInit = options.notQueryAfterInit;
			
			tree.treeChildKey = options.treeChildKey;
			tree.rootParameter = options.rootParameter;
			tree.childParameter = options.childParameter;

			tree.setting.check = options.check;
			tree.onClick = options.onClick;
			tree.onCheck = options.onCheck;
		}
		
		return tree;
	}

	function _undef(val, defaultVal) {
		return val === undefined ? defaultVal : val;
	}
	
	function _isFunction(val) {
		if (!val) {
			return false;
		}
		return Object.prototype.toString.call(val) === '[object Function]';
	}
	
	function treeInit(){
		var tree = {
				treeId : '',
				treeType : '',
				isExpandQuery:true,
				treeRootUrl : '',
				treeRootKey : '',
				
				defaultSelectedNode: null,
				notQueryAfterInit:true,
				
				treeChildKey : '',
				parameter:{},
				onClick : null,
				onCheck : null,

				zTree : '',
				pNode : '',
				setting : {
					data: {
						simpleData: {
							enable: true,
							idKey: "dataId",
							pIdKey: "parentId",
							rootPId: 0
						}
					},
					view: {
						showLine : true,
					},
					check : {},
					callback : { // 回调函数
//						/**
//						 * event:鼠标事件 treeId：树的容器id treeNode：当前点击的节点
//						 */
//						onExpand : function(event, treeId, treeNode) {
//							tree.pNode = treeNode;
//							if(tree.isExpandQuery){
//								tree.loadNodeByPNode();
//							}
//						},
						onClick : function(event, treeId, treeNode) {
							if (typeof tree.onClick === "function") {
								var pNodes = treeNode.getPath();
								var name = "";
								for(var i = 0;i<pNodes.length;i++){
									name = name + pNodes[i].name +">>";
								}
								treeNode.nodePathEx = name.substring(0,name.length-2);
								
								var zTree = $.fn.zTree.getZTreeObj(tree.treeId)
								zTree.selectNode(treeNode);
								tree.onClick(treeNode);
							}
						},
						onCheck : function(event, treeId, treeNode) {
							if (typeof tree.onCheck === "function") {
								var zTree = $.fn.zTree.getZTreeObj(tree.treeId);// 获取ztree对象
								var nodes = zTree.getCheckedNodes(true);
								if (nodes.length > 0) {
									tree.onCheck(nodes);
								}
							}
						}
					},
				},

				/**
				 * 一般情况下，如果一段代码中要用到一个变量 而这个变量的值是在回调函数中赋值的 这个时候要保证使用这个变量的时候回调函数已经执行了
				 */
				loadRootNode : function() { // 加载根节点
					var parameter = {
						//dirType : tree.treeType,
						//auth_dataId_boom : '1',
						//auth_dataType_boom : tree.treeType
					};
					
					var treeObj = $.fn.zTree.getZTreeObj(tree.treeId);
					if( !tree.queryMore && treeObj != null ){
						return;
					}
					$.post(tree.treeRootUrl, $.extend(tree.rootParameter,parameter), function(data) {
						tree.zTree = $.fn.zTree.init($("#" + tree.treeId),
								tree.setting, data.RSP_BODY.Data[tree.treeRootKey]);
						var zTree = $.fn.zTree.getZTreeObj(tree.treeId);// 获取ztree对象
						zTree.expandAll(true);
						var nodes = zTree.getNodes();
						var selectedNode = null;
						if (nodes.length > 0) {
							if(tree.defaultSelectedNode == null){
								selectedNode = nodes[0];
								zTree.selectNode(selectedNode);// 选择点
							}else{
								selectedNode = tree.defaultSelectedNode;
								zTree.selectNode(selectedNode);
							}
							/*初始化树后调用查询*/
							if(!tree.notQueryAfterInit){
								zTree.setting.callback.onClick(null, zTree.setting.treeId,selectedNode);// 调用事件
							}
						}
					});
				},
				
			};
		return tree;
	}
})(jQuery);