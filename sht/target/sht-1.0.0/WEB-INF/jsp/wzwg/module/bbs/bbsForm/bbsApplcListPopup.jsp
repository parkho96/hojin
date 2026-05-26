<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
	// 체크박스 체크 
  	$(document).ready(function(){
  			
  			var splitBbsSeq;
  			splitBbsSeq = $("#moduleBbsForm").find("#bbsSeq").val();
  			
  			if(!splitBbsSeq) {
 				splitBbsSeq = '<c:out value="${nttBbsMappingVO.bbsSeq}"/>'; 
  			}
  			
			var bbsSeqList = new Array();
			
			bbsSeqList = splitBbsSeq.split(",");
			for(var i=0; i<bbsSeqList.length; i++){
				if(document.getElementById(bbsSeqList[i])){
					document.getElementById(bbsSeqList[i]).checked="checked";
				}
			} 
	});
 
	/** 게시판 양식 적용 */
	function fn_bbsApplcListRegist(){
		var selectChecked = document.getElementsByName("chk");
		var bbsSeqList = new Array();
		var bbsNmList  = new Array();
		var mappingCount = 0;
		
		for(var i=0; i<selectChecked.length; i++){
			if(selectChecked[i].checked == true){
				var arrList = selectChecked[i].value.split("///");
				bbsSeqList.push(arrList[0]);
				bbsNmList.push(arrList[1]);
				mappingCount += parseInt(arrList[2]);
			}
		}
		
		if(0 < mappingCount){
			if(confirm('<spring:message code="wzwg.cmm.msg.MSG108" />')){
				
			}else{
				return;
			}
		}
		
 		var formSttusCode = '<c:out value="${paramVO.formSttusCode}"/>';
	
 		if(formSttusCode == 'list'){
 			
			document.bbsApplcForm.bbsSeq.value  = bbsSeqList;
			
			$.ajax({
				type:'POST'
				, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/bbsForm/modifyBbsApplcListAjax.do'
				, data:$("#bbsApplcForm").serialize()
				,success:function (result){
					$(result).find('value').each(function(){
						if($(this).text() == "success"){
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>');
							
							fnSearch();
							
							fnLayerPopupClose();
							
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
						}
					})
				}
				, error:function (request, status, error) {
		              alert('<spring:message code="fail.common.msg" text="error" />');
		          }
			});
			
		}else{
			
			$("#moduleBbsForm").find("#bbsSeq").val(bbsSeqList);
			$("#moduleBbsForm").find("#bbsNm").val(bbsNmList);
			
			$("#moduleBbsForm").find('#bbsNmWrap').empty();
			$(bbsNmList).each(function(idx, el){
				$("#moduleBbsForm").find('#bbsNmWrap').append('<div class="categoryCo">'+el+'</div>');
			})
			
			fnLayerPopupClose();
		}
	}

    function fnLayerPopupClose() {
	    //$("#divLayerPopup").hide();
	    //$("#divLayerPopup").empty();
	    //$('body').css({overflow:'auto'});
	    wzModalClose();
	}
	
</script>

				<form id="bbsApplcForm" name="bbsApplcForm" method="post">
				<input type="hidden" name="formSeq" id="formSeq" value="<c:out value='${paramVO.formSeq}'/>"/>
				<input type="hidden" name="bbsSeq" id="bbsSeq" value=""/>
				<input type="hidden" name="beforeBbsSeq" id="beforeBbsSeq" value="<c:out value='${nttBbsMappingVO.bbsSeq}'/>"/>
				<input type="hidden" name="formSttusCode" id="formSttusCode" value="<c:out value='${paramVO.formSttusCode }'/>"/>
			
				<table class="basic-table">
					<colgroup>
						<col width="10%"/>
						<col width="*"/>
					</colgroup>
					<thead>
						<tr>
							<th><spring:message code="wzwg.cmm.word.choise" /></th>
							<th><spring:message code="wzwg.module.word.bbsnm" /></th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${!empty bbsList }">
								<c:forEach items="${bbsList }" var="bbsList" varStatus="status">
									<tr>
										<td>
											<ul class="wzForm"><li><label><input type="checkbox" name="chk" id="<c:out value='${bbsList.bbsSeq }'/>" value="<c:out value='${bbsList.bbsSeq }'/>///<c:out value='${bbsList.bbsNm}'/>///<c:out value='${bbsList.mappingApplcAt}'/>"/><span class="spanLabel"></span></label></li></ul>
										</td>
										<td class="txt-l">
											<c:out value="${bbsList.bbsNm }"/>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="2"><spring:message code="wzwg.cmm.msg.MSG109" /></td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				</form>
		
		<div class="rt-box">
			<c:if test="${!empty bbsList }">
				<a href="javascript:void(0);" onclick="fn_bbsApplcListRegist();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
			</c:if>
			<%-- <a href="javascript:void(0);" onclick="fnLayerPopupClose();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.close" /></a> --%>
		</div>
		
