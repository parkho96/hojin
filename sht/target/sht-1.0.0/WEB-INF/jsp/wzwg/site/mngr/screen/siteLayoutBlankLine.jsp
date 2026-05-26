<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 
<script>
function fnAddContents(layoutSe,widthCssNm ,vrticlCssNm){
		if(layoutSe =='L'){
			var line ='<div class="between_line" style="border:1px dashed #b9cde5;">'
					+' <div class="div_wrap">'
					+' <div class="axebox"><spring:message code="wzwg.site.screen.msg.MSG010" /></div>'
					+' <div class="'+widthCssNm+' '+vrticlCssNm+'"></div>'
					+' </div>'
					+' </div>';
					$("#layoutCn").val($("#layoutCn").val()+line);
		}
		
		if(layoutSe =='B'){
			if(widthCssNm !='' ||  vrticlCssNm !=''){
			var blank ='<div class="'+widthCssNm+' '+vrticlCssNm+' changeBg" style="border:1px dashed #b9cde5;"> '
					+' <div class="axebox">X</div>'
					+' </div> ';
					$("#layoutCn").val($("#layoutCn").val()+blank);
			}
		}  
		 $(".addContentZone").append($("#layoutCn").val());
		// fnDivJsonDataRead();
		 editInit();	
		 
		 $(".axebox").click(function(){
			 if( $(this).parents(".removeAxeboxZone").size() >0){
				 $(this).parents(".removeAxeboxZone").remove();
			 }else{
				 //$(this).next("div").remove();
				 //$(this).remove();
			 }
		 });
		 
		 $(".axeboxboot").click(function(){
			 $(this).nextt("div").remove();
			 $(this).remove();
		 });
		 
		 $("#template00 .axebox").html("X");
		 $("#template00 .axeboxboot").html("X"); 
	 
}
$(document).ready(function(){
	$(".btn").click(function(){
		$(".pop-box").toggle()

	});
	
	$(".hide").click(function(){
		$(".pop-box").hide();
		fnLayerPopupClose();
	});
});
</script>
<form name="frmPopup" id="frmPopup" method="post"> 
<input type="hidden"  name="layoutSeq" id="layoutSeq" /> 
<input type="hidden"  name="layoutCn" id="layoutCn" value="<c:out value="${paramVO.layoutCn}"/>"/>
</form> 
<div class="pop-box">
		<div class="layer3" >				
					<div class="pop-id-sch">
						<span><spring:message code="wzwg.site.screen.msg.MSG003" /></span>
						<button class="close" type="button" onclick="fnLayerPopupClose();"><img src="/images/wzwg/site/mngr/pop-close.png" alt="<spring:message code="wzwg.cmm.word.close" />" /></button>
					</div>
					<div class="pop-container">
						<div class="pop-conts"> 
								<!--content //--> 
								<ul class="temlayUl02">
								<h3><spring:message code="wzwg.cmm.word.scrin.blankSpace" /></h3>
								 <c:forEach items="${blankList}" var="list" varStatus="status">
										<li>
									<h4><c:out value="${list.layoutNm}"/></h4>
									<div class="temlay02 mt10">
										<img src="<c:out value="${list.thumbStreCours}${list.thumbFileNm}"/>" id="orgImg"  style="width:100%;"/>
									</div>
									<a href="javascript:;" onclick="fnAddContents('<c:out value="${list.layoutSe}"/>','<c:out value="${list.widthCssNm}"/>','<c:out value="${list.vrticlCssNm}"/>')" class="btn-a fr mt5"><spring:message code="wzwg.cmm.word.add02" /></a>
									</li>
								</c:forEach>			 
								</ul>
								<ul class="temlayUl02">
								<h3>구분선</h3>
								 <c:forEach items="${lineList}" var="list" varStatus="status">
										<li>
									<h4><c:out value="${list.layoutNm}"/></h4>
									<div class="temlay02 mt10">
										<img src="<c:out value="${list.thumbStreCours}${list.thumbFileNm}"/>" id="orgImg"  style="width:100%;"/>
									</div>
									<a href="javascript:;" onclick="fnAddContents('<c:out value="${list.layoutSe}"/>','<c:out value="${list.widthCssNm}"/>','<c:out value="${list.vrticlCssNm}"/>')" class="btn-a fr mt5"><spring:message code="wzwg.cmm.word.add02" /></a>
									</li>
								</c:forEach>			 
								</ul>
								<div class="txt-c">
									<a href="javascript:;" onclick="fnLayerPopupClose();" class="btn-b"><spring:message code="wzwg.cmm.word.close" /></a>
								</div><!--close btn //-->
						</div> <!-- pop-conts end -->
				</div> <!-- pop-container end -->
			</div> <!-- layer1 end -->
	</div> <!-- 레이어팝업 end -->
 