<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 
<link rel="stylesheet" href="/css/wzwg/cmm/layout.css" type="text/css" />
<script>
function fnAddContents(sourc){
	 $("#loadContentHtml").load("/"+sourc,function(){
		 $(".addContentZone").append($("#loadContentHtml").html());
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
	 });
	 
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

function addLayoutInfo(layoutSeq){
	document.frmLayoutInfo.layoutSeq.value =layoutSeq;
	$.ajax({
		   type:'POST'
		 , url:'/mngr/screen/selectSiteLayoutInfoAjax.do'
		 , data:$("#frmLayoutInfo").serialize()
		 , success:function (data) { 
			 	$("#divLayerPopup").html(data);
	    	  	$("#divLayerPopup").show();
	    	  	$(".pop-box").toggle();
					 // 부모코드 셋팅 
					// fnGetMenuList();
					 
				//	 document.getElementById("menuNm").focus();
				   }
		 , dataType: 'html'
	});
}

function changePreView(layoutSeq,optionAt){
	document.frmLayoutInfo.layoutSeq.value =layoutSeq;
	$.ajax({
		   type:'POST'
		 , url:'/mngr/screen/selectSiteLayoutInfoAjax.do'
		 , data:$("#frmLayoutInfo").serialize()
		 , success:function (data) { 
			 	 	$("#preViewLayout").html(data);
			 	 	$(".layOptn").css("display","none");
			 	 	if(optionAt =='Y'){
			 	 		$("#layOptn"+layoutSeq).css("display","");
			 	 	}
				   }
		 , dataType: 'html'
	});
}

function changePreViewCss(blankAt,vrticlCssNm){ 
		if(blankAt =='Y'){
			$("#preViewLayout  .div_wrap").addClass("layout_padding");
		}else if(blankAt =='N'){
			$("#preViewLayout  .div_wrap").removeClass("layout_padding");
		}
		if(vrticlCssNm !=''){
			$("#preViewLayout   .div_wrap").children("div").removeClass("layout_height_L");
			$("#preViewLayout   .div_wrap").children("div").removeClass("layout_height_M");
			$("#preViewLayout   .div_wrap").children("div").removeClass("layout_height_H");
			$("#preViewLayout   .div_wrap").children("div").addClass(vrticlCssNm);
		}
}
function fnNextLayout(){
	$("#layoutCn").val($("#preViewLayout").html());
	$.ajax({
		   type:'POST'
		 , url:'/mngr/screen/selectSiteLayoutBlankLineAjax.do'
		 , data:$("#frmLayoutInfo").serialize()
		 , success:function (data) { 
			 	$("#divLayerPopup").html(data);
	    	  	$("#divLayerPopup").show();
	    	  	$(".pop-box").toggle();
					 // 부모코드 셋팅 
					// fnGetMenuList();
					 
				//	 document.getElementById("menuNm").focus();
				   }
		 , dataType: 'html'
	});
}
</script>
<form name="frmLayoutInfo" id="frmLayoutInfo" method="post"> 
<input type="hidden"  name="layoutSeq" id="layoutSeq" />
<input type="hidden"  name="layoutCn" id="layoutCn" /> 
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
								<ul class="temlayUl01">
									<li>
										<h4><spring:message code="wzwg.cmm.word.preview" /></h4>
										<div class="temlay01 mt10" id="preViewLayout">
										
										</div>
									 </li>
								</ul>
								<ul class="temlayUl01">
								<div id="loadContentHtml" style="display: none;"></div>
								<c:forEach items="${layoutList}" var="list" varStatus="status">
										<li>
										
										<c:if test="${status.first}"> 
											<h4><input type="radio" name="layoutSeq" value="<c:out value="${list.layoutSeq}"/>" onclick="changePreView('<c:out value="${list.layoutSeq}"/>','N')"/><c:out value="${list.layoutNm}"/></h4>
										</c:if>
										<c:if test="${!status.first}"> 
										<h4><input type="radio" name="layoutSeq" value="<c:out value="${list.layoutSeq}"/>" onclick="changePreView('<c:out value="${list.layoutSeq}"/>','Y')"/><c:out value="${list.layoutNm}"/></h4>
										</c:if>
											<div class="temlay01 mt10">
													<img src="<c:out value="${list.thumbStreCours}${list.thumbFileNm}"/>" id="orgImg"  style="width:100%;height:220px"/>
											</div>
											<c:if test="${!status.first}"> 
											<div class="temlay01 mt10 layOptn" id="layOptn<c:out value="${list.layoutSeq}"/>" style="display: none;">
													<h3>옵션 선택하기</h3>
													<ul>
														<li>컨텐츠간 양 옆 여백 : <input type="radio" name="blankAt<c:out value="${list.layoutSeq}"/>" value="N"  checked="checked" onclick="changePreViewCss('N','')"/>없음  <input type="radio" name="blankAt<c:out value="${list.layoutSeq}"/>" value="Y" onclick="changePreViewCss('Y','')"/>있음 </li>
														<li>컨텐츠 박스의 높이 : <input type="radio" name="vrticlCssNm<c:out value="${list.layoutSeq}"/>" value="layout_height_L" checked="checked"  onclick="changePreViewCss('','layout_height_L')"/>낮음  <input type="radio" name="vrticlCssNm<c:out value="${list.layoutSeq}"/>" value="layout_height_M"  onclick="changePreViewCss('','layout_height_M')"/>중간<input type="radio" name="vrticlCssNm<c:out value="${list.layoutSeq}"/>" value="layout_height_H" onclick="changePreViewCss('','layout_height_H')"/>높음 </li>
													</ul>
											</div> 
											</c:if>
										</li>
										</c:forEach>
										 
										</ul>
								<div class="txt-c">
									<a href="javascript:;" onclick="fnNextLayout();" class="btn-b">다음단계</a>
									<a href="javascript:;" onclick="fnLayerPopupClose();" class="btn-b"><spring:message code="wzwg.cmm.word.close" /></a>
								</div><!--close btn //-->
						</div> <!-- pop-conts end -->
				</div> <!-- pop-container end -->
			</div> <!-- layer1 end -->
	</div> <!-- 레이어팝업 end -->
 