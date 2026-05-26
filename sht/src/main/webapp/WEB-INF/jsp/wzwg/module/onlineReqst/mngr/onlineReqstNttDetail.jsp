<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<link href="/css/wzwg/cmm/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />


<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>" ></script>
<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript" src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>


<script type="text/javascript">

	$(document).ready(function(){
		
		fnInit();
		
		function fnInit(){
			$.ajax({
				  type : 'POST'
				, dataType: 'html'
				, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineReqst/selectOnlineReqstRceptListAjax.do'
				, cache : false
				, async : false
				, data:$("#detFrm").serialize()
				, success:function (data) {
					$('#onlineReqstRcept_area').html(data);
				}
				, error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});			
		}		

		$('#modify_btn').click(function(){
			
			$.ajax({
				  type : 'POST'
				, dataType : 'html'
				, url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineReqst/modifyOnlineReqstNttFormAjax.do'
				, cache : false
				, async : false
				, data : $("#detFrm").serialize()
				, success : function(data) {
					$('#onlineReqst_area').html(data);
				}
				, error : function(data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});				

		});	
		
		$('#cancle_btn').click(function(){
			$.ajax({
				  type : 'POST'
				, dataType: 'html'
				, url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineReqst/selectOnlineReqstNttListAjax.do'
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
		});		
		
		$(".datePicker").datepicker({ 		
		     dateFormat: 'yy-mm-dd',
		     monthNamesShort: ['1<spring:message code="wzwg.cmm.word.mt" />','2<spring:message code="wzwg.cmm.word.mt" />','3<spring:message code="wzwg.cmm.word.mt" />','4<spring:message code="wzwg.cmm.word.mt" />','5<spring:message code="wzwg.cmm.word.mt" />','6<spring:message code="wzwg.cmm.word.mt" />','7<spring:message code="wzwg.cmm.word.mt" />','8<spring:message code="wzwg.cmm.word.mt" />','9<spring:message code="wzwg.cmm.word.mt" />','10<spring:message code="wzwg.cmm.word.mt" />','11<spring:message code="wzwg.cmm.word.mt" />','12<spring:message code="wzwg.cmm.word.mt" />'],
		     dayNamesMin: ['<spring:message code="wzwg.cmm.word.sun01" />','<spring:message code="wzwg.cmm.word.mon01" />','<spring:message code="wzwg.cmm.word.tue01" />','<spring:message code="wzwg.cmm.word.wed01" />','<spring:message code="wzwg.cmm.word.thu01" />','<spring:message code="wzwg.cmm.word.fri01" />','<spring:message code="wzwg.cmm.word.sat01" />'],
		     weekHeader: 'Wk',
		     changeMonth: true, 	//월변경가능
		     changeYear: true, 	//년변경가능
		     yearRange:'-10:+10', 	// 연도 셀렉트 박스 범위(현재와 같으면 1988~현재년)
		     showMonthAfterYear: true, 	//년 뒤에 월 표시
		     buttonImageOnly: false, //이미지표시  
		     buttonText: '<spring:message code="wzwg.cmm.msg.MSG088" />', 
		     autoSize: false	 //오토리사이즈(body등 상위태그의 설정에 따른다)
		  });
	});

	nowPageTop = screen.availWidth;
	nowPageLeft = screen.availHeight;
	popupPageTop = 600;
	popupPageLeft = 600;
	resultTop = (nowPageTop - popupPageTop) / 2;
	resultLeft = (nowPageLeft - popupPageLeft) / 2;
	popOption = 'width=' + popupPageTop + ', height=' + popupPageLeft
			+ ', resizable=no, scrollbars=no, status=no, top=' + resultLeft
			+ ', left=' + resultTop + ';';


</script>


	<form id="searchFrm" name="searchFrm" method="post">
		<input type="hidden" name="pageIndex" value="<c:out value="${paramVO.pageIndex}" />"/>
		<input type="hidden" name="pageUnit" value="<c:out value="${paramVO.pageUnit}" />"/>
		<input type="hidden" name="progrsSttusCode" value="<c:out value="${paramVO.progrsSttusCode}" />"/>
		<input type="hidden" name="searchCondition" value="<c:out value="${paramVO.searchCondition}" />"/>
		<input type="hidden" name="searchKeyword" value="<c:out value="${paramVO.searchKeyword}" />"/>
		<input type="hidden" name="reqstSeq" value="<c:out value="${paramVO.reqstSeq}" />" />
	</form>
	
	<form:form modelAttribute="paramVO" path="detFrm" id="detFrm" name="detFrm" method="post" enctype="multipart/form-data" >
	<form:hidden path="reqstSeq"/>
	<form:hidden path="reqstnttSeq"/>

	<table class="basic">
			<colgroup>
				<col width="20%" />
				<col width="80%" />
			</colgroup>
		  <tbody>
			<tr>
				<th><spring:message code="wzwg.module.word.progrssttus" /></th>
				<td>
					<c:forEach items="${reqpscList}" var="reqpscList" varStatus="status">
						<c:if test="${reqpscList.code eq onlineReqstNttVO.progrsSttusCode}">
							<c:out value="${reqpscList.codeNm}"/>
						</c:if>	
					</c:forEach>							
				</td>
			</tr>						
			<tr>
				<th><spring:message code="wzwg.module.word.reqstnm" /></th>
				<td><c:out value="${onlineReqstNttVO.reqstnttSj}"/></td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.module.word.reqstpd" /></th>
				<td>
					<c:out value="${onlineReqstNttVO.bgnde}" /> <c:out value="${onlineReqstNttVO.beginTime}" /><spring:message code="wzwg.cmm.word.hour" /> 
					~ 
					<c:out value="${onlineReqstNttVO.endde }" /> <c:out value="${onlineReqstNttVO.endTime}" /><spring:message code="wzwg.cmm.word.hour" />				
				</td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.cmm.word.psncpa" /></th>
				<td>
					<c:if test="${onlineReqstNttVO.psncpa > 0}">
						<c:out value="${onlineReqstNttVO.psncpa}"/><spring:message code="wzwg.cmm.word.person" />
					</c:if>
					<c:if test="${onlineReqstNttVO.psncpa == 0}">
						-
					</c:if>					
				</td>
			</tr>						
			<tr>
				<th><spring:message code="wzwg.module.word.confmmthd" /></th>
				<td>
					<c:forEach items="${reqcmcList}" var="reqcmcList" varStatus="status">
						<c:if test="${reqcmcList.code eq onlineReqstNttVO.confmMthdCode}">
							<c:out value="${reqcmcList.codeNm}"/>
						</c:if>	
					</c:forEach>							
				</td>
			</tr>				
			<tr>
				<th><spring:message code="wzwg.module.word.reqsttrgter" /></th>
				<td>
					<c:out value="${onlineReqstNttVO.trgterUsrty}" />						
				</td>
			</tr>						
			<tr>
				<th><spring:message code="wzwg.module.word.reqstcn" /></th>
				<td>
					<c:out value='${fn:replace(onlineReqstNttVO.reqstnttCn, cn, "<br />")}' escapeXml="false" />					
				</td>
			</tr>
			<tr>
				<th rowspan="2"><spring:message code="wzwg.module.word.reqstform" /></th>
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

	</form:form>
	
	<div id="onlineReqstRcept_area" class="mg_t30"></div>



