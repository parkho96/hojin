<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<link href="/css/wzwg/cmm/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />


<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>" ></script>
<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript" src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>


<script type="text/javascript">
try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.cmm.word.toreqst" />';}catch(e){console.log(e.message);}

	$(document).ready(function(){
		$('#contentsCaption').html($('#menuNm').val() + ' <spring:message code="wzwg.cmm.word.list" />');
		
		<c:if test="${onlineReqstNttVO.trgterUsrtyAt eq 'Y'}">

		fnRceptDetail();
		
		function fnRceptDetail(){
			$.ajax({
				  type : 'POST'
				, dataType : 'html'
				, url : "<c:out value="${wzwg_contextPath}" />/module/onlineReqst/selectOnlineReqstRceptDetailAjax.do"
				, cache : false
				, async : false
				, data : $("#detFrm").serialize()
				, success : function(data) {
					$('#onlineReqstRcept_area').html(data);
				}
				, error : function(data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});			
		}	

		</c:if>
		
	});
	
	function fnReqstNttList(){
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}" />/module/onlineReqst/selectOnlineReqstNttListAjax.do'
			, cache : false
			, async : false
			, data : $("#searchFrm").serialize()
			, success : function(data) {
				$('#onlineReqst_area').html(data);
			}
			, error : function(data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});	
	};			
	
	function fnDownReqstNttFile(atchFileId, fileSn){
		window.open("<c:url value='/module/upload/file/fileDown.do?atchFileId="+atchFileId+"&fileSn="+fileSn+"'/>");
	}	

</script>


	<form id="searchFrm" name="searchFrm" method="post">
		<input type="hidden" name="pageIndex" value="<c:out value="${paramVO.pageIndex}" />"/>
		<input type="hidden" name="pageUnit" value="<c:out value="${paramVO.pageUnit}" />"/>
		<input type="hidden" name="progrsSttusCode" value="<c:out value="${paramVO.progrsSttusCode}" />"/>
		<input type="hidden" name="searchCondition" value="<c:out value="${paramVO.searchCondition}" />"/>
		<input type="hidden" name="searchKeyword" value="<c:out value="${paramVO.searchKeyword}" />"/>
		<input type="hidden" name="reqstSeq" value="<c:out value="${paramVO.reqstSeq}" />" />
		<input type="hidden" name="reqstnttSeq" value="<c:out value="${paramVO.reqstnttSeq}" />" />
	</form>

	<div style=""><!-- 내용 start -->
	
	<form:form modelAttribute="paramVO" path="detFrm" id="detFrm" name="detFrm" method="post" enctype="multipart/form-data" >
		<form:hidden path="reqstSeq"/>
		<form:hidden path="reqstnttSeq"/>
		
		<h5 class="pb10 pt20"><spring:message code="wzwg.cmm.cntnts.onlinereqst" /></h5>	
		<table class="basic-table01">
		  <caption><spring:message code="wzwg.cmm.cmmMsg.CMG024"><spring:argument><spring:message code="wzwg.module.word.onlinereqstprogrssttus" />, <spring:message code="wzwg.module.word.reqstnm" />, <spring:message code="wzwg.cmm.word.pd" />, <spring:message code="wzwg.cmm.word.psncpa" />, <spring:message code="wzwg.module.word.confmmthd" />, <spring:message code="wzwg.module.word.reqsttrgter" />, <spring:message code="wzwg.cmm.word.cn" />, <spring:message code="wzwg.module.word.reqstform" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.wa.table" /></spring:argument></spring:message></caption>
		  <colgroup>
			<col width="20%" />
			<col width="80%" />
	      </colgroup>
		  <tbody>
			<tr>
				<th scope="row"><spring:message code="wzwg.module.word.progrssttus" /></th>
				<td class="txt-l">
					<c:forEach items="${reqpscList}" var="reqpscList" varStatus="status">
						<c:if test="${reqpscList.code eq onlineReqstNttVO.progrsSttusCode}">
							<c:out value="${reqpscList.codeNm}"/>
						</c:if>	
					</c:forEach>				
				</td>
			</tr>
			<tr>
				<th scope="row"><spring:message code="wzwg.module.word.reqstnm" /></th>
				<td class="txt-l"><c:out value="${onlineReqstNttVO.reqstnttSj}"/></td>
			</tr>
			<tr>
				<th scope="row"><spring:message code="wzwg.module.word.reqstpd" /></th>
				<td class="txt-l">
					<c:out value="${onlineReqstNttVO.bgnde}" /> <c:out value="${onlineReqstNttVO.beginTime}" /><spring:message code="wzwg.cmm.word.hour" /> 
					~ 
					<c:out value="${onlineReqstNttVO.endde }" /> <c:out value="${onlineReqstNttVO.endTime}" /><spring:message code="wzwg.cmm.word.hour" />				
				</td>
			</tr>
			<tr>
				<th scope="row"><spring:message code="wzwg.cmm.word.psncpa" /></th>
				<td class="txt-l">
					<c:if test="${onlineReqstNttVO.psncpa > 0}">
						<c:out value="${onlineReqstNttVO.psncpa}"/><spring:message code="wzwg.cmm.word.person" />
					</c:if>
					<c:if test="${onlineReqstNttVO.psncpa == 0}">
						-
					</c:if>	
				</td>
			</tr>
			<tr>
				<th scope="row"><spring:message code="wzwg.module.word.confmmthd" /></th>
				<td class="txt-l">
					<c:forEach items="${reqcmcList}" var="reqcmcList" varStatus="status">
						<c:if test="${reqcmcList.code eq onlineReqstNttVO.confmMthdCode}">
							<c:choose>
								<c:when test="${nowUrl.indexOf('/mngr') > -1 }">
									<c:out value="${reqcmcList.codeNm}"/>
								</c:when>
								<c:otherwise>
									<c:if test="${onlineReqstNttVO.confmMthdCode eq 'SC00000109'}"><spring:message code="wzwg.cmm.word.fcfs" /></c:if>
									<c:if test="${onlineReqstNttVO.confmMthdCode eq 'SC00000110'}"><spring:message code="wzwg.cmm.word.audit" /></c:if>
								</c:otherwise>		
							</c:choose>
						</c:if>	
					</c:forEach>				
				</td>
			</tr>
			<tr>
				<th scope="row"><spring:message code="wzwg.module.word.reqsttrgter" /></th>
				<td class="txt-l"><c:out value="${onlineReqstNttVO.trgterUsrty}" /></td>
			</tr>
			<tr>
				<th scope="row"><spring:message code="wzwg.module.word.reqstcn" /></th>
				<td class="txt-l"><c:out value='${fn:replace(onlineReqstNttVO.reqstnttCn, cn, "<br />")}' escapeXml="false" /></td>
			</tr>
			<tr>
				<th scope="row"><spring:message code="wzwg.module.word.reqstform" /></th>
				<td class="txt-l">
					<c:if test="${!empty onlineReqstNttVO.atchFileId}">
						<div>
							<ul>
							<c:forEach var="NttFileVO" items="${fileList}" varStatus="status">
								<li>
									<a href="javascript:fnDownReqstNttFile('<c:out value="${NttFileVO.atchFileId}"/>','<c:out value="${NttFileVO.fileSn}"/>')" title="<spring:message code="wzwg.module.word.filedwld" />">
										<c:out value="${NttFileVO.orignlFileNm}"/>&nbsp;[<fmt:formatNumber value="${NttFileVO.fileMg/1024}" pattern="#,###" />&nbsp;KB]
									</a>
								</li>	
							</c:forEach>
							</ul>	
						</div>				
					</c:if>				
				</td>
			</tr>
		  </tbody>
		</table>
		
	</form:form>
		
	<div id="onlineReqstRcept_area">
		<div class="rt-box">
			<a href="javascript:void(0);" onclick="fnReqstNttList();" class="btn-a"><spring:message code="wzwg.cmm.word.list" /></a>	
		</div>		
	</div>
	
	</div><!-- 내용 end -->




