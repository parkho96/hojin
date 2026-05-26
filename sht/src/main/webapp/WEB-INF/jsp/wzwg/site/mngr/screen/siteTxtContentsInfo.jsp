<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 
	<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js"></script> 
<style>
.pop-id-sch{cursor: move;}
</style>
<script> 
$(document).ready(function(){
	$(".btn").click(function(){
		$(".pop-box").toggle()

	});
	
	$(".hide").click(function(){
		$(".pop-box").hide();
		fnLayerPopupClose();
	});
	$("#formCn").val(selectDiv.find(".bContent").html());
	
	$('#modal-text-context-box').draggable({ handle: ".pop-id-sch" });
	
});
</script>
<form name="frmPopup" id="frmPopup" method="post"> 
<input type="hidden"  name="templateSeq" id="templateSeq" /> 
</form> 
<div class="pop-box">
		<div id="modal-text-context-box" class="layer3" >				
					<div class="pop-id-sch">
						<span><spring:message code="wzwg.site.screen.msg.MSG072" /></span>
						<button class="close" type="button" onclick="fnLayerPopupClose();"><img src="/images/wzwg/site/mngr/pop-close.png" alt="<spring:message code="wzwg.cmm.word.close" />" /></button>
					</div>
					<div class="pop-container">
						<div class="pop-conts">
								<!--content //-->
								<ul class="temlayUl01"> 
										<li> 
											<div class="temlay01 mt10" style="height:420px;">
													<textarea name="formCn" id="formCn" rows="25" class="w100" dir="required"></textarea>
													<script type="text/javascript">
														nhn.husky.EZCreator.createInIFrame({
														    oAppRef: oEditors,
														    elPlaceHolder: "formCn",
														    sSkinURI: "<c:out value="${wzwg_contextPath}"/>/smartEditor2.8.2.1/smartEditor2Skin.do",
														    fCreator: "createSEditor2",
														    htParams: {
																fOnBeforeUnload : function(){}
																,aAdditionalFontList : [['NanumSquareR', 'NanumSquareR']]		// 추가 글꼴 목록
																}
														});
													</script>
											</div>
											<a href="javascript:;" onclick="modifyContentsTxt()" class="btn-a fr mt5"><spring:message code="wzwg.cmm.word.tochange" /></a>
										</li>
										 
										</ul> 
								<div class="txt-c">
									<a href="javascript:;" onclick="fnLayerPopupClose();" class="btn-b"><spring:message code="wzwg.cmm.word.close" /></a>
								</div><!--close btn //-->
						</div> <!-- pop-conts end -->
				</div> <!-- pop-container end -->
			</div> <!-- layer1 end -->
	</div> <!-- 레이어팝업 end -->
 