/**
 * EMS系统公用方法
 * Author: yangbao
**/

/**
	ajax请求传输的参数集，类似java.util.Map
**/
function ParamsMap(){
    var data=new Array();
    this.put = function(key, value){
    	var k=key.toString();
    	data[k] = value;
    };
    this.get = function(key){
    	return data[key.toString()];
	};
	this.keys=function(){
    	var arr=new Array();
    	var i=0;
    	for(var key in data){
    		if(data[key]!=null){
    			arr[i]=key;
    			i++;
    		}
    	}
    	return arr;
	};
	this.clear = function(){
    	data = new Array();
	};
}

/**
	将ajax请求传输的参数集转换成JSON格式
**/
function paramsMap2Json(paramMap){			
//	var params = "REQ_MESSAGE={\"REQ_HEAD\":{},\"REQ_BODY\":{";
	var params = "{";
	if(typeof paramMap == "object"){
		var i = 0;
		var keys = [];
		for(var key in paramMap){
			keys.push(key);
			if(i>0){
				params += ",";
			}
			params += keys[i] + ":\"" + paramMap[keys[i]] + "\"";
			i++;
		}
	}	
//	params += "}}";
	params += "}";
	return JSON.stringify(params);
}


function toJumpJsonString(obj){
	if ( obj === null ){
		obj = {};
	}
	var ret = "{\"REQ_HEAD\":{\"TRAN_PROCESS\":\"\",\"TRAN_ID\":\"\"},\"REQ_BODY\":" + JSON.stringify(obj) + "}";
	return {REQ_MESSAGE: ret};
	
}

function form2Json(formId){
	var formElement = $("#"+formId+" :input[type='hidden']");
	var jsonObject = {};
	for(var i = 0;i<formElement.size();i++){
		var cur = formElement[i];
		var value = $(cur).val();
		if(value!=""){
			jsonObject[$(cur).attr("id")] = value;
		}
	}
	return jsonObject;
}

function json2Form(formId,jsonObject){
	var formElement = $("#"+formId+" :input[type='hidden']");
	for(var i = 0;i<formElement.size();i++){
		var cur = formElement[i];
		var value = jsonObject[$(cur).attr("id")];
		if(value && value!=""){
			$(cur).val(value);
		}
	}
}

//后台使用了JSONObject的fromObject方法后，时间格式会发生变化，调用此方法对时间格式进行转换
function JSONDate2String(date){
	//年
	var s_year = parseInt(date.year)+1900;
	//月
	var month = parseInt(date.month)+1;
	if(month<10){
		month = "0"+month;
	}
	//日
	var day = parseInt(date.day);
	if(day<10){
		day = "0"+day;
	}
	
	//时
	var hours = parseInt(date.hours);
	if(hours<10){
		hours = "0"+hours;
	}
	
	//分
	var minutes = parseInt(date.minutes);
	if(minutes<10){
		minutes = "0" + minutes;
	}
	
	var seconds = parseInt(date.seconds);
	if(seconds<10){
		seconds = "0" + seconds;
	}
	return s_year+"-" + month + "-" + day +"&nbsp;"+hours+":"+minutes+":"+ seconds;
}


/**
 * 动态加载外部文件，包括JS文件和CSS文件
 * */
function loadFile(path){
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

/**
 * 多级IFRAME下自适应高度
 * 由于IFRMAE加载的顺序是从顶层到底层逐层加载，最顶层的IFRMAE最后加载
 * 因此该方法必须放在最底层的IFRAME加载完成后执行
 * */
function autoHeight(){
	var doc = document;
	var p = window;
	//如果该页面存在父页面，则重置父页面高度
	while(p=p.parent){
		//获得父页面的所有IFRAME
		var frames = p.frames;
		var frame;
		var i=0;
		//获取页面高度，重置父页面高度
		while(frame = frames[i++]) {
			if(frame.document==doc){
				frame.frameElement.height=doc.body.clientHeight;
				if(frame.frameElement.height < 768){
					frame.frameElement.height = 768;
				}
				doc = p.document;
				break;
			}
		}
		//如果该窗口时最顶层元素，则退出循环
		if(p==top){
			break;
		}
	}
}

function getProjName(){
	 //获取当前网址，如： http://localhost:8083/myproj/view/my.jsp
	   var curWwwPath=window.document.location.href;
	   //获取主机地址之后的目录，如： myproj/view/my.jsp
	  var pathName=window.document.location.pathname;
	  var pos=curWwwPath.indexOf(pathName);
	  //获取主机地址，如： http://localhost:8083
	  var localhostPaht=curWwwPath.substring(0,pos);
	  //获取带"/"的项目名，如：/myproj
	  var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
	  
	  return projectName;
}
/**
 * tips工具，用来弹出图标提示
 * 依赖layer,jQuery
 * */
(function($){
	//备份ajax方法
	var _ajax=$.ajax;  
    //重写jquery的ajax方法  
    $.ajax=function(opt){  
       //备份opt中的_success方法
        var _success = function(data, textStatus){};
        //备份opt中的error方法
        var _optError = function(data, textStatus){};
        var _error = function(data, textStatus){
        	window.top.$.layer({
					 title:"系统提示",
					 dialog:{btns : 1,
						 	btn:["确定"],
							msg :data.responseText,
							yes:function(index){
								window.top.layer.closeAll();
								_optError(data,textStatus);
							}
						},
					close:function(index){
						window.top.layer.closeAll();
						_optError(data,textStatus);
					}	
        	});
        };
        if(opt.error){
        	_optError = opt.error;
        	opt.error = _error;
        }
        if(opt.success){  
            _success = opt.success; 
            //success处理增强，如果后台跑出一场，则弹出异常
            opt.success = function(data,textStatus){
            	//后期添加RSP_HEAD后，修改为下面代码；
//            	window.top.layer.closeAll();
//            	_success(data,textStatus);
            	if(data.RSP_HEAD.Type == "0"&& data.RSP_BODY.ErrorMessage!=""){
            		window.top.$.layer({
	   					 title:"系统提示",
	   					 dialog:{btns : 1,
	   						 	btn:["确定"],
	   							msg :data.RSP_BODY.ErrorMessage,
	   							yes:function(index){
	   								window.top.layer.closeAll();
	   								_optError(data,textStatus);
	   								if(data.RSP_BODY.ForwardUrl != null){
	   		   							var projectName=getProjName();
	   									window.location.href = projectName + data.RSP_BODY.ForwardUrl;
	   		   						}
	   							}
	   						},
	   					close:function(index){
	   						window.top.layer.closeAll();
	   						_optError(data,textStatus);
	   						if(data.RSP_BODY.ForwardUrl != null){
	   							var projectName=getProjName();
								window.location.href = projectName + data.RSP_BODY.ForwardUrl;
	   						}
	   					}	
            		});
            	}else{
            		_success(data,textStatus);
            	}
            };
        }  
        _ajax(opt);  
    };  
	
	$.fn.extend({
		toolTips:function(type){
			if(type>=0&&type<=3){
			}else{
				type=0;
			}
			this.each(function(){
				var msg = $.trim($(this).attr("alt"));
				if(msg!=""){
					$(this).hover(function(){
						layer.tips(msg,this,{guide:type,style:["background-color:#FFF;border:1px solid #CCC;word-break:break-all;word-wrap:break-word;width:auto;text-align:center;",""],maxWidth :250});
					},function(){
						layer.closeAll();
					});
				}
			});
		}
	});
})(jQuery);


(function($){
	$.ajaxSetup({
		  type: "post",
		  dataType:"json",
		  error:function(data){
			window.top.alert("请求失败，请联系系统管理员！\n"+data.responseText);
		  }
	});
})(jQuery);;