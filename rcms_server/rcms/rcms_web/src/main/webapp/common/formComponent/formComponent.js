$(function(){
	init();
	//表单校验依赖common.js和layer.js。执行前先判断该文件是否加载，未加载则，加载这两个文件。
	$("form").each(function(m,n){
		var isCheck = $(n).attr("isCheck");
		if(isCheck==true ||isCheck=="true"){
			bindCheck(n);
		}
	});
});

function init(){
	//点击下拉图标或输入框时显示下拉列表
	$(".selectBox .select").click(function(){
		var options = $(this).siblings(".options"),
		available = $(this).find("input").attr("disabled");
		if(available){
			return;
		}
		
		if(options.css("display")=="none"){
			$(options).show();
		}else{
			$(options).hide();
		}
	});
	
	//鼠标离开选择框区域时，隐藏下拉列表
	$(".selectBox").bind("mouseleave",function(){
		$(this).children(".options").hide();
	});
	
	//点击选项
	$(".selectBox .options ul li").click(function(event){
		event.preventDefault();
		//将选项的值赋给输入框
		$(this).parents(".selectBox").find("input").val($(this).text()).attr("code",$(this).attr("code")).blur();
		//隐藏下拉列表
		$(this).parents(".options").hide();
	});
	
	
	
	//输入框只读
	$(".selectBox .select input").attr("readonly","readonly");
	
	//添加背景
	$(".select,.inputBox").addClass("trueInput");
	//添加背景
	$(".textareaBox").addClass("trueTextArea");
}

//为表单绑定校验事件
function bindCheck(obj){
	if(typeof layer=="undefined"){
		alert("layer.js未加载");
		return;
	}else if(typeof ParamsMap=="undefined"){
		alert("commom.js未加载");
		return;
	}
	var layerIndex = 0;
	//为表单对象绑定校验失败事件
	$(obj).find(":text").bind("checkFailed",function(event,msg){
		$(this).parent().attr("msg",msg);
		$(this).parent().removeClass("trueInput").addClass("errorInput");
	//为表单对象绑定校验通过事件
	}).bind("checkPass",function(){
		$(this).parent().removeAttr("msg");
		$(this).parent().removeClass("errorInput").addClass("trueInput");
		$(".inputBoxLong").removeClass("trueInput");
	//当表单对象值改变时执行校验
	}).bind("blur",function(event){
		checkComponents(this,new ParamsMap());
	});
	
	//鼠标悬浮时提示错误信息
	$(obj).find(".select,.inputBox,.textareaBox").hover(function(){
		var msg = $(this).attr("msg");
		if(msg && msg!=""){
			layerIndex =layer.tips(msg,this,{guide:1,maxWidth:200});
		}
	//鼠标移除时隐藏错误信息
	},function(){
		if(layerIndex!=0){
			layer.close(layerIndex);
		}
	});
	
	$(obj).find("textarea").bind("checkFailed",function(event,msg){
		$(this).parent().attr("msg",msg);
		$(this).parent().removeClass("trueTextArea").addClass("errorTextArea");
	//为表单对象绑定校验通过事件
	}).bind("checkPass",function(){
		$(this).parent().removeAttr("msg");
		$(this).parent().removeClass("errorTextArea").addClass("trueTextArea");
	//当表单对象值改变时执行校验
	}).bind("change",function(event){
		checkComponents(this,new ParamsMap());
	});
	
	$(obj).find("textarea").each(function(m,n){
		var maxChar = $(n).attr("maxChar");
		if(maxChar&&maxChar>0){
			$(n).bind("keydown",function(event){
				var maxChar1 = $(this).attr("maxChar");
				var length = $(this).val().length;
				var errLengthMsg = $.trim($(this).attr("errLengthMsg"));
				if(length > maxChar1){
					$(this).trigger("checkFailed",[errLengthMsg]);
				}else{
					$(this).trigger("checkPass");
				}
			});
		}
	});
	
	//如果表单内使用了自定义组件，则禁止默认提交事件
	$(obj).submit(function(){
		return false;
	});
	$(obj).find(":reset").click(function(event){
		event.preventDefault();
		$(obj).find(".inputBox :text,.textareaBox textarea").val("");
		$(obj).find(".select :text").attr("code","-1").val("--请选择--");
	});
	
}



function checkForm(context){
	//表单ID
	var formId = "";
	//表单校验成功执行的函数
	var success = "";
	//表单校验失败执行的函数
	var failure = "";
	//函数返回值
	var data = new Object();
	//表单是否需要检验
	var isCheck = false;
	
	//校验成功失败标志
	var flag = true;

	if(context['formId']!= null){
		formId="#"+context['formId'];
	}
	
	if(context['success']!=null){
		success = context['success'];
	}
	
	if(context['failure']!=null){
		failure = context['failure'];
	}
	
	//待校验表单元素
	var fc = $(formId+" :text,"+formId+" textarea");
	//迭代校验表单元素
	for(var i = 0;i<fc.length; i++){
		//校验不通过
		if(!checkComponents(fc[i],data)){
			flag = false;
		}
	}
	isCheck = $(formId).attr("isCheck");
	if(isCheck!=true && isCheck !="true"){
		flag=true;
	}
	if(flag){
		if(success!=""){
			success(data);
		}
	}else{
		if(failure!=""){
			failure(data);
		}
	}
}

function checkComponents(obj,data){
	var fcObj = $(obj);
	var name = $.trim(fcObj.attr("name"));
	//输入框
	if(fcObj.attr("mType")=="input"){
		var value = $.trim(fcObj.val());
		var errNullMsg = $.trim(fcObj.attr("errNullMsg"));
		var expression = $.trim(fcObj.attr("expression"));
		var errExpMsg =$.trim(fcObj.attr("errExpMsg"));
		//如果定义了errNullMsg并且不为""，则进行空值校验
		if(errNullMsg && errNullMsg!=""){
			//如果value未定义或者值为"",则校验失败，添加校验失败样式及提示
			if(!value || value == ""){
				fcObj.trigger("checkFailed",[errNullMsg]);
				data[name]=value;
				return false;
			}
		}
		//如果定义了expression并且不为""，则进行正则表达式校验
		if(expression && expression!=""){
			var exp = new RegExp(expression+"");
			if(!exp.test(value)){
				fcObj.trigger("checkFailed",[errExpMsg]);
				data[name]=value;
				return false;
			}
		}
		fcObj.trigger("checkPass");
		data[name]=value;
		return true;
	//选择框
	}else if(fcObj.attr("mType")=="select"){
		var code = $.trim(fcObj.attr("code"));
		var errNullMsg = $.trim(fcObj.attr("errNullMsg"));
		if(errNullMsg && errNullMsg!= ""){
			if(!code || code=="-1"){
				fcObj.trigger("checkFailed",[errNullMsg]);
				data[name]=code;
				return false;
			}
		}
		fcObj.trigger("checkPass");
		data[name]=code;
		return true;
	//文本域
	}else if(fcObj.attr("mType")=="textArea"){
		var value = fcObj.val();//文本域不去首位空格
		var errNullMsg = $.trim(fcObj.attr("errNullMsg"));
		var expression = $.trim(fcObj.attr("expression"));
		var errExpMsg =$.trim(fcObj.attr("errExpMsg"));
		var maxChar = $.trim(fcObj.attr("maxChar"));
		var errLengthMsg = $.trim(fcObj.attr("errLengthMsg"));
		var length = value.length;
		
		//如果value未定义或者值为"",则校验失败，添加校验失败样式及提示
		if(errNullMsg && errNullMsg!=""){
			if(!value || value == ""){
				fcObj.trigger("checkFailed",[errNullMsg]);
				data[name]=value;
				return false;
			}
		}
		//如果定义了expression并且不为""，则进行正则表达式校验
		if(expression && expression!=""){
			var exp = new RegExp(expression+"");
			if(!exp.test(value)){
				fcObj.trigger("checkFailed",[errExpMsg]);
				data[name]=value;
				return false;
			}
		}
		//如果定义了最大长度，则进行长度验证
		if(maxChar && maxChar>0){
			if(length>maxChar){
				fcObj.trigger("checkFailed",[errLengthMsg]);
				data[name]='too long';
				return false;
			}
		}
		fcObj.trigger("checkPass");
		data[name]=value;
		return true;
		
	}
}