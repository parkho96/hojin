<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<link type="text/css" href="/css/wzwg/module/cmm/layer_popup.css" rel="stylesheet" />

<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("#cancle_btn").click(function (){
	    	$('body').css({overflow:'auto'});
	    	$("#bbs_layer").html("");
	   		$('#bbs_layer').hide();	
		});	
		
		$("#close_btn").click(function (){
	    	$('body').css({overflow:'auto'});
	    	$("#bbs_layer").html("");
	   		$('#bbs_layer').hide();	
		});	
		
		$("#move_btn_pop").click(function (){
			
			if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006"><spring:argument><spring:message code="wzwg.cmm.word.ntt" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.mvmn" /></spring:argument></spring:message>')){
				return
			}else{
				$.ajax({
			        type:'POST'
					, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cmmn/mvmnNttAjax.do'
					, cache : false
					, data:$("#mvmnFrm").serialize()
					, success:function (result) {
						var value = "";
						
						$(result).find("value").each(function() {  
							value = $(this).text();  
						});
						
						if(value == 'success'){
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.word.ntt" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.mvmn" /></spring:argument></spring:message>');
							
							$('body').css({overflow:'auto'});
							
							if($('#checkNttSeq').val() == ''){	// 상세정보에서 이동
								fnBbsList();
							}else{								// 목록에서 이동
								fnPage(1);
							}
							
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
						}
			    	  
						//$("#close_btn").click();
						$(".close").click();
					}
					, error:function (data) {
					    alert('<spring:message code="fail.common.msg" text="error" />');
					}
					, dataType: 'xml'
			 	});
			}
			
		});
	});
	
	function fnLayerPopupClose() {
       $("#bbs_layer").hide();
       $("#bbs_layer").empty();
       $('body').css({overflow:'auto'});
	}		
	
</script>

	<c:set var="adminAuthAt" value="N"/>
	
	<c:if test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or sessionScope.CNTNTS_ADMIN_AT}">
		<c:set var="adminAuthAt" value="Y"/>
	</c:if>
	
	<c:set var="popupViewAuthAt" value="N" />
	
	<c:if test="${adminAuthAt eq 'Y'}">
		<c:set var="popupViewAuthAt" value="Y" />
	</c:if>	
	
	<c:if test="${popupViewAuthAt ne 'Y'}">
		<script type="text/javascript">
			$("#close_btn").click();
			alert("<spring:message code="wzwg.cmm.msg.MSG084" />");
		</script>
	</c:if>	
	
		
			<div class="pop-conts" style="overflow-y:auto;">
				<form:form modelAttribute="paramVO" name="mvmnFrm" id="mvmnFrm" method="post">
					<form:hidden path="siteSeq" />
					<form:hidden path="bbsSeq" />
					<form:hidden path="nttSeq" />
					<form:hidden path="checkNttSeq" />	
					
					<table class="basic">
						<colgroup>
							<col width="20%" />
							<col width="80%" />
						</colgroup>
						  <tbody>					
							<tr>
								<th><spring:message code="wzwg.module.word.nttchoise" /></th>
								<td>
									<c:set var="bbsse"><spring:message code="wzwg.module.word.bbsse" /></c:set>
									<form:select path="searchBbsSeq" cssClass="w70" title="${fn:escapeXml(bbsse)}">
										<c:forEach var="resultList" items="${bbsList}" varStatus="status">
									        <form:option value="${fn:escapeXml(resultList.bbsSeq)}" label="[${fn:escapeXml(resultList.moduleNm)}] ${fn:escapeXml(resultList.bbsNm)}" />
									    </c:forEach>
									</form:select>							
								</td>
							</tr>
						  </tbody>
					</table>
		
				</form:form>
			</div>
		
		<div class="rt-box">
			<a href="javascript:void(0);" class="wzbtn btn-save" id="move_btn_pop"><spring:message code="wzwg.cmm.word.mvmn" /></a>
			<%-- <a href="javascript:void(0);" class="wzbtn btn-basic" id="cancle_btn"><spring:message code="wzwg.cmm.word.close" /></a> --%>
		</div>
			
	       