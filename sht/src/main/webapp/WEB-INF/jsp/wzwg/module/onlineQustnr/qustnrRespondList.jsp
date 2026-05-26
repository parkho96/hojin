<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

	<link type="text/css" href="/css/wzwg/module/onlineQustnr/onlineQustnr.css" rel="stylesheet" /> 
	
	<script type="text/javascript">
		try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.cmm.word.list" />';}catch(e){console.log(e.message);}
		
		$(document).ready(function(){
	  		$('#contentsCaption').html($('#menuNm').val() + ' <spring:message code="wzwg.module.word.qestnrlist" />');
		})
		
		function fnRegistForm(paramSeq, btn){
			document.qustnrFrm.qustnrSeq.value = paramSeq;
			
	    	$.ajax({
	    		   type:'POST'
	    		 , url:'<c:out value="${wzwg_contextPath}" />/module/onlineQustnr/selectOnlineQustnrRespondFormPopup.do'
	    		 , data: $("#qustnrFrm").serialize()
	    		 , success:function (data) {
					wzAjaxModal('popup_l', '<spring:message code="wzwg.module.word.onlinequstnrregist" />', data, true, btn);
				 }
				 , error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				 }
	    		 , dataType: 'html'
	    	});
		}
	</script>
	
	<form id="qustnrFrm" name="qustnrFrm" method="post">
		<input type="hidden" name="qustnrSeq" id="qustnrSeq" value=""/>
		<input type="hidden" name="pageIndex" id="pageIndex" value="1"/>
	</form>
	
	<table class="basic-table01">
		<caption id="contentsCaption"><spring:message code="wzwg.module.word.qestnrlist" /></caption>
		<colgroup>
		  	<col width="10%" />
			<col width="25%" />
			<col width="*" />
			<col width="15%"/>
			<col width="15%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">No</th>
				<th scope="col"><spring:message code="wzwg.module.word.qustnrnm" /></th>
				<th scope="col"><spring:message code="wzwg.module.word.qustnrpd" /></th>
				<th scope="col" class="mediaDs"><spring:message code="wzwg.cmm.word.sttus" /></th>
				<th scope="col"><spring:message code="wzwg.cmm.word.partcptn" /></th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
			<c:when test="${!empty resultList }">
				<c:forEach items="${resultList }" var="resultList" varStatus="status">
				<tr>
					<td>
						<c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.pageSize + status.count) + 1}"/>
					</td>
					<td>
						<c:out value="${resultList.qustnrNm }"/>
					</td>
					<td>
						<c:out value="${resultList.bgnde }"/><spring:message code="wzwg.cmm.word.hour" /> ~ <c:out value="${resultList.endde }"/><spring:message code="wzwg.cmm.word.hour" />
					</td>
					<td>
                    	<c:if test="${resultList.qustnrSttus eq '대기'}"><spring:message code="wzwg.cmm.word.wait" /></c:if>
		  				<c:if test="${resultList.qustnrSttus eq '종료'}"><spring:message code="wzwg.cmm.word.end" /></c:if>
		  				<c:if test="${resultList.qustnrSttus eq '진행중'}"><spring:message code="wzwg.cmm.word.ongo" /></c:if>
					</td>
					<td>
						<c:set var="str_respond"><spring:message code="wzwg.cmm.word.ongo" /></c:set>
						
						<c:if test="${!empty loginVO}">
							<c:if test="${resultList.respondAt ne 0 }">
								<spring:message code="wzwg.module.word.partcptncompt" />
							</c:if>
							<c:if test="${resultList.qustnrSttus eq str_respond and resultList.respondAt eq 0}">
								<a href="javascript:void(0);" class="wzbtn-table btn-black" onclick="fnRegistForm('<c:out value="${resultList.qustnrSeq}" />', this);"><spring:message code="wzwg.module.word.qustnrpartcptn" /></a>
							</c:if>
						</c:if>
					</td>
				</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="6"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
				</tr>
			</c:otherwise>
			</c:choose>
		</tbody>
	</table>

	<c:if test="${!empty resultList }">
	<div class="ctr-box" id="pageInfo">
		<ul class="num mobile-none">
			<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnPage" />
		</ul>
		
		<ul class="num pc-none">
			<ui:pagination paginationInfo="${mobilePaginationInfo}" type="image" jsFunction="fnPage" />
		</ul>
	</div>
	</c:if>
