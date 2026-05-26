<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
	
<script type="text/javascript">
	function fnSearch(){
		var frm = document.sysMngrUsrTyForm;
		frm.action='<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/usrTy/selectUsrTyList.do';
		frm.submit();
	}
	
	function fn_usrTyRegistForm(){
		var frm = document.sysMngrUsrTyForm;
        frm.code.value = "";
        
        frm.action='<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/usrTyCode/selectUsrTyCodeForm.do';
		frm.submit();
	}
	
	function fn_usrTyDetail(code){
		var frm = document.sysMngrUsrTyForm;
		frm.code.value = code;
		
        frm.action='<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/usrTyCode/selectUsrTyCodeForm.do';
		frm.submit();
	}
	
	function fnPage(paramPageIndex){
		document.sysMngrUsrTyForm.pageIndex.value = paramPageIndex;
		document.sysMngrUsrTyForm.action='<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/usrTyCode/selectUsrTyCodeList.do';
		document.sysMngrUsrTyForm.submit();
	}
	
</script>

    
	<form id="sysMngrUsrTyForm" name="sysMngrUsrTyForm" method="post">
		<input type="hidden" name="code" id="code" value=""/>
		<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex}" />" />
	
		<table class="basic-table">
			<colgroup>
				<col width="10%" />
		        <col width="*" />
				<col width="12%" />
		        <col width="15%" />
		        <col width="10%" />
			</colgroup>
			<thead>
			  <tr>
			  	<th>No</th>
				<th><spring:message code="wzwg.sysMngr.word.mberTy" /></th>
				<th><spring:message code="wzwg.sysMngr.word.siteMngUseAt" /></th>
				<th><spring:message code="wzwg.sysMngr.word.creatDe" /></th>
				<th><spring:message code="wzwg.cmm.word.manage" /></th>
			  </tr>
			</thead>
			<tbody>
			<c:choose>
				<c:when test="${!empty resultList}">
					<c:forEach items="${resultList}" var="result" varStatus="status">
						<tr>
							<td>
								<c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.pageSize + status.count) + 1}"/>
							</td>
							<td class="txt-l"><c:out value="${result.codeNm}"/></td>
							<td>
	                            <c:choose>
	                            <c:when test="${result.useAt eq 'Y'}"><spring:message code="wzwg.cmm.word.use" /></c:when>
	                            <c:otherwise><spring:message code="wzwg.cmm.word.unuse" /></c:otherwise>
	                            </c:choose>
							</td>
							<td>
	                            <c:out value="${result.frstRegistPnttm}"/>
							</td>
							<td><a href="javascript:void(0);" onclick="fn_usrTyDetail('<c:out value="${result.code}" />')" class="iconOnlyBtn btn-basic btn-setting" title="<spring:message code="wzwg.cmm.word.estbs" />"><spring:message code="wzwg.cmm.word.estbs" /></a></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<td colspan="5"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
				</c:otherwise>
			</c:choose>
			</tbody>
	  	</table>
	 </form>
	 <%-- 
	 <c:if test="${!empty resultList}">
	 	<div class="ctr-box">
			<ul class="num">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnPage" />
			</ul>
		</div>
	 </c:if> --%>

	 <div class="rt-box">
		<a href="javascript:void(0);" onclick="fn_usrTyRegistForm();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.regist" /></a>
	 </div>
