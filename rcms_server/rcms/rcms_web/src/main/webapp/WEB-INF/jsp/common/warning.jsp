<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="modal"  id="modalAlert" tabindex="-1"
		role="dialog" aria-labelledby="addModalLabel"
		aria-hidden="true" style="z-index:10000;margin:0px auto;text-align: center">
		<div class="warning-dialog" style="width: 100%;height:0%;">
		<div class="modal-content warning-content" >
			<div class="warning-header" >
				<p  style="align:center">提示信息</p>
<!-- 				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
			</div>
			<div class="warning-body" style="overflow:auto">
<!-- 				<div  style="width:30%;float:left;text-align:right;position:absolute;bottom:20px"> -->
<%-- 					<img src="<%=request.getContextPath()%>/images/common/alert.jpg" alt="AlertImage" > --%>
<!-- 				</div> -->
<!-- 				<div style="width:55%;float:left;position:absolute;bottom:20px;right:15px"> -->
					<p id="warning" style="text-align:center;"></p>
<!-- 				</div> -->
			</div>
			
			<div class="warning-footer" >
				<button type="button" id="confirm-button" data-dismiss="modal"  style="display:none" >取消</button>
				<button type="button" id="warning-button" data-dismiss="modal"  >确定</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(function(){
	/* 模态框居中 */
	 $('.modal').on('show.bs.modal', centerModals);
	 $(window).on('resize', centerModals);
})
function warning(message){
	$("#warning").html(message);
	$("#modalAlert").modal('show');
}


function confirmFcn(message,onclickFcn){
	$("#warning").html(message);
	$("#warning-button").bind("click",onclickFcn);
	$("#confirm-button").css("display","block");
	$("#modalAlert").modal('show');
}

/* 模态框居中 */
	function centerModals() {
	    $('.modal').each(
	            function(i) {
	                var $clone = $(this).clone().css('display', 'block')
	                        .appendTo('body');
	                var top = Math.round(($clone.height() - $clone.find(
	                        '.modal-content').height()) / 2);
	                top = top > 0 ? top : 0;
	                $clone.remove();
	                $(this).find('.modal-content').css("margin-top",
	                        top - 50);
	            });
	}
</script>
