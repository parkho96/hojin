<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>     

<script>

	function fnDetail(){
		var frm = document.detFrm;
		
		frm.action = "<c:out value="${wzwg_contextPath}" />/subList/" + frm.menuSeq.value;
		frm.submit();
	}
	
</script>

	<div class="layer1">
		<form:form modelAttribute="paramVO" path="detFrm" id="detFrm" name="detFrm" method="post" enctype="multipart/form-data" >
			<form:hidden path="siteSeq"/>
			<form:hidden path="reqstSeq"/>
			<form:hidden path="reqstnttSeq"/>
			<input type="hidden" id="menuSeq" name="menuSeq" value="<c:out value="${onlineReqstNttVO.menuSeq}" />" />
			
					<table class="basic">
					<caption><spring:message code="wzwg.cmm.cmmMsg.CMG024"><spring:argument><spring:message code="wzwg.cmm.word.online" /> <spring:message code="wzwg.cmm.word.reqst" /> <spring:message code="wzwg.cmm.word.schdul" /> <spring:message code="wzwg.cmm.word.wa.of" /> <spring:message code="wzwg.module.word.progrssttus" />, <spring:message code="wzwg.module.word.reqstnm" />, <spring:message code="wzwg.module.word.reqstpd" />, <spring:message code="wzwg.cmm.word.psncpa" />, <spring:message code="wzwg.module.word.confmmthd" />, <spring:message code="wzwg.module.word.reqsttrgter" />, <spring:message code="wzwg.module.word.reqstcn" />, <spring:message code="wzwg.module.word.reqstform" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.wa.table"/></spring:argument></spring:message></caption>
					<colgroup>
						<col width="25%;">
						<col width="*;">
					</colgroup>
					<tbody>
					<tr>
						<th scope="row"><spring:message code="wzwg.module.word.progrssttus" /></th>
						<td>
							<c:forEach items="${reqpscList}" var="reqpscList" varStatus="status">
								<c:if test="${reqpscList.code eq onlineReqstNttVO.progrsSttusCode}">
									<c:out value="${reqpscList.codeNm}"/>
								</c:if>	
							</c:forEach>							
						</td>
					</tr>						
					<tr>
						<th scope="row"><spring:message code="wzwg.module.word.reqstnm" /></th>
						<td><c:out value="${onlineReqstNttVO.reqstnttSj}"/></td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="wzwg.module.word.reqstpd" /></th>
						<td>
							<c:out value="${onlineReqstNttVO.bgnde}" /> <c:out value="${onlineReqstNttVO.beginTime}" /><spring:message code="wzwg.cmm.word.hour" />
							~ 
							<c:out value="${onlineReqstNttVO.endde }" /> <c:out value="${onlineReqstNttVO.endTime}" /><spring:message code="wzwg.cmm.word.hour" />			
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="wzwg.cmm.word.psncpa" /></th>
						<td>
							<c:if test="${onlineReqstNttVO.psncpa > 0}">
								<c:out value="${onlineReqstNttVO.psncpa}"/> <spring:message code="wzwg.cmm.word.person" />
							</c:if>
							<c:if test="${onlineReqstNttVO.psncpa == 0}">
								-
							</c:if>					
						</td>
					</tr>						
					<tr>
						<th scope="row"><spring:message code="wzwg.module.word.confmmthd" /></th>
						<td>
							<c:forEach items="${reqcmcList}" var="reqcmcList" varStatus="status">
								<c:if test="${reqcmcList.code eq onlineReqstNttVO.confmMthdCode}">
									<c:out value="${reqcmcList.codeNm}"/>
								</c:if>	
							</c:forEach>							
						</td>
					</tr>				
					<tr>
						<th scope="row"><spring:message code="wzwg.module.word.reqsttrgter" /></th>
						<td>
							<c:out value="${onlineReqstNttVO.trgterUsrty}" />						
						</td>
					</tr>						
					<tr>
						<th scope="row"><spring:message code="wzwg.module.word.reqstcn" /></th>
						<td>
							<c:out value='${fn:replace(onlineReqstNttVO.reqstnttCn, cn, "<br />")}' escapeXml="false" />					
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="wzwg.module.word.reqstform" /></th>
						<td>				
							<c:if test="${!empty onlineReqstNttVO.atchFileId}">
								<c:import url="${wzwg_contextPath}/module/upload/file/selectFileInc.do" charEncoding="utf-8">
									<c:param name="param_atchFileId" 	value="${onlineReqstNttVO.atchFileId}" />
									<c:param name="param_updateFlag" 	value="N" />
									<c:param name="param_atchFileNumber" value="1" />
									<c:param name="param_cntntsSeq" 	value="${paramVO.reqstSeq}" />
								</c:import>				
							</c:if>			
						</td>
					</tr>
					
					</tbody>
					</table>
				
			        <!--//기본정보 table -->
				
					<div class="rt-box">
						<c:if test="${fn:indexOf(nowUrl, '/mngr/') < 0 and onlineReqstNttVO.trgterUsrtyAt eq 'Y' and onlineReqstNttVO.progrsSttusCode eq 'SC00000112'}">
							<a href="javascript:void(0);" onclick="fnDetail();" class="wzbtn btn-basic"><spring:message code="wzwg.module.word.reqstposbl" /></a>
						</c:if>
						<a href="javascript:void(0);" onclick="javascript:fnLayerPopupClose();" class="wzbtn btn-basic pop-close"><spring:message code="wzwg.cmm.word.list" /></a> 
					</div>
			
		</form:form>
	</div>
       