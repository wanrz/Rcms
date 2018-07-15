/**
 * 解决在页面非输入框中按下回退键【Backspace】时页面会跳转到上一页的bug
 *作者：q821424508@sina.com
 *使用说明：
 *1.页面必须含有body标签
 *2.放到任意一个页面引用的js文件中【直接放到文件的最开始或最后】
*/

window.onload=function(){  
    document.getElementsByTagName("body")[0].onkeydown =function(){  
        //获取事件对象  
        var elem = event.relatedTarget || event.srcElement || event.target ||event.currentTarget; 
        if(event.keyCode==8){//判断按键为backSpace键  

                //判断是否需要阻止按下键盘的事件默认传递  
                var name = elem.nodeName;  
                if(name!='INPUT' && name!='TEXTAREA'){  
                    return _stopIt(event);  
                }  
                var type_e = elem.type.toUpperCase();  
                if(name=='INPUT' && (type_e!='TEXT' && type_e!='TEXTAREA' && type_e!='PASSWORD' && type_e!='FILE')){  
                        return _stopIt(event);  
                }  
                if(name=='INPUT' && (elem.readOnly==true || elem.disabled ==true)){  
                        return _stopIt(event);  
                }  
            }  
        };
    }; 
function _stopIt(e){  
        if(e.returnValue){  
            e.returnValue = false ;  
        }  
        if(e.preventDefault ){  
            e.preventDefault();  
        }                 
  
        return false;  
} 
