<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 
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
</script>
<form name="frmPopup" id="frmPopup" method="post"> 
<input type="hidden"  name="templateSeq" id="templateSeq" /> 
</form> 
<div class="pop-box">
		<div class="layer3" >				
					<div class="pop-id-sch">
						<span><spring:message code="wzwg.site.screen.msg.MSG003" /></span>
						<button class="close" type="button" onclick="fnLayerPopupClose();"><img src="/images/wzwg/site/mngr/pop-close.png" alt="<spring:message code="wzwg.cmm.word.close" />" /></button>
					</div>
					<div class="pop-container">
						<div class="pop-conts">
								<div>
									<div>
										<label style="position: relative; left: 0;"><input type="radio" name="group"><spring:message code="wzwg.site.screen.msg.MSG011" /></label>
										<label style="position: relative; left: 0;"><input type="radio" name="group"><spring:message code="wzwg.site.screen.msg.MSG012" /></label>
									</div>
									<div>
										<label style="position: relative; left: 0;"><input type="checkbox"><spring:message code="wzwg.cmm.word.bbs" /></label>
										<label style="position: relative; left: 0;"><input type="checkbox"><spring:message code="wzwg.cmm.cntnts.banner" /></label>
										<label style="position: relative; left: 0;"><input type="checkbox"><spring:message code="wzwg.cmm.cntnts.quickmenu" /></label>
										<label style="position: relative; left: 0;"><input type="checkbox"><spring:message code="wzwg.cmm.cntnts.etc" /></label>
									</div>
								</div>
								<!--content //-->
								<ul class="temlayUl01">
								<div id="loadContentHtml" style="display: none;"></div>
								<c:forEach items="${templateLayoutList}" var="list" varStatus="status">
										<li>
											<h4><c:out value="${list.layoutNm}"/></h4>
											<div class="temlay01 mt10">
													<img src="/<c:out value="${list.thumbPath}"/>" id="orgImg"  style="width:100%;height:220px"/>
											</div>
											<a href="javascript:;" onclick="fnAddContents('<c:out value="${list.sourcPath}"/>')" class="btn-a fr mt5"><spring:message code="wzwg.cmm.word.add02" /></a>
										</li>
										</c:forEach>
										 
										</ul>
										<ul class="temlayUl02">
										<c:forEach items="${commLayoutList}" var="list" varStatus="status">
										<li>
									<h4><c:out value="${list.layoutNm}"/></h4>
									<div class="temlay02 mt10">
										<img src="/<c:out value="${list.thumbPath}"/>" id="orgImg"   style="width:440px;height:170px"/>
									</div>
									<a href="javascript:;" onclick="fnAddContents('<c:out value="${list.sourcPath}"/>')" class="btn-a fr mt5"><spring:message code="wzwg.cmm.word.add02" /></a>
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
 