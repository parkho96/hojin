<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
function fnRegistFrom() {
    var frm = document.frmSrh; 
    
	frm.action="<c:out value="${wzwg_contextPath}"/>/sysMngr/moduleMngr/sysModuleInfo/selectSysModuleInfoForm.do";
	frm.submit();
}

function fnDetail(sysmoduleSeq) {
    var frm = document.frmInfo;
    
    frm.sysmoduleSeq.value = sysmoduleSeq;
    
    frm.action="<c:out value="${wzwg_contextPath}"/>/sysMngr/moduleMngr/sysModuleInfo/selectSysModuleInfoDetail.do";
    frm.submit();
}

function fnSearch(pageIndex) {
	
	if(isNaN(pageIndex)){
		console.log('잘못된 페이지호출');
		return;
	}
	
    var frm = document.frmSrh;
    
	frm.pageIndex.value = pageIndex;
	
	frm.action="<c:out value="${wzwg_contextPath}"/>/sysMngr/moduleMngr/sysModuleInfo/selectSysModuleInfoList.do";
	frm.submit();
}
</script>
                    <form name="frmInfo" id="frmInfo" method="post">
                        <input type="hidden" name="sysmoduleSeq" />
                    </form>
                    
					<!--//게시판명 table -->
                    <form:form modelAttribute="paramVO" id="frmSrh" name="frmSrh" method="post">
                    <form:hidden path="pageIndex" />
					<div class="main-menu-bar">
                        <form:select path="searchModuleSeq" onchange="javascript:fnSearch(1);">
                            <form:option value=""><spring:message code="wzwg.cmm.word.all" /></form:option>
						    <c:forEach var="module" items="${moduleTyCodeList}">
						        <form:option value="${fn:escapeXml(module.code)}" label="${fn:escapeXml(module.codeNm)}" />
						    </c:forEach>
                        </form:select>
                        <c:set var="msg_title_txt01">
							 <spring:message code="wzwg.sysMngr.word.sch01Se" /> 
						</c:set>
                        <form:select path="searchCondition" title="${fn:escapeXml(msg_title_txt01)}"> 
                            <option value="1"><spring:message code="wzwg.sysMngr.word.mdNm01" /></option>
                        </form:select>
                        
						
						<c:set var="srchwrd">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
						</c:set>
                        <form:input path="searchKeyword" cssClass="txt" onkeydown="if(event.keyCode == 13){fnSearch(1);}" placeholder="${fn:escapeXml(srchwrd)}" />
                        <a href="javascript:void(0);" onclick="fnSearch(1);" class="btn-c"><spring:message code="wzwg.cmm.word.search01" /></a>
					</div>
                    </form:form>
					
					<!--//게시판 설정 table -->
					<table class="basic-table">
						<colgroup>
						<col width="5%" />
                        <col width="10%" />
                        <col width="15%" />
                        <col width="20%" />
                        <col width="30%" />
                        <col width="*" />
						</colgroup>
						<thead>
						  <tr>
							<th><spring:message code="wzwg.cmm.word.sn" /></th>
							<th><spring:message code="wzwg.sysMngr.word.mdTy03" /></th>
							<th><spring:message code="wzwg.sysMngr.word.mdNm01" /></th>
							<th><spring:message code="wzwg.sysMngr.word.instncNm01" /></th>
							<th><spring:message code="wzwg.sysMngr.word.pckageCours" /></th>
							<th><spring:message code="wzwg.cmm.word.manage" /></th>
						  </tr>
						</thead>
						<tbody>
						<c:if test="${empty resultList}">
						<tr>
							<td colspan="9"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
						</tr>
						</c:if>
						<c:forEach items="${resultList}" var="list" varStatus="status">
						<tr>
							<td><c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.recordCountPerPage + status.count) + 1}"/></td>
							<td><c:out value="${list.moduleTyNm}" /></td>
							<td><c:out value="${list.moduleNm}" /></td>
							<td><c:out value="${list.instcNm}" /></td>
                            <td><c:out value="${list.pckagePath}" /></td>
							<td>
								<a href="javascript:void(0);" onclick="fnDetail('<c:out value="${list.sysmoduleSeq}" />');" class="btn-c"><spring:message code="wzwg.cmm.word.detail" /></a>
							</td>
						</tr>
						</c:forEach>
						</tbody>
					</table>
				  <c:if test="${!empty resultList}">
				  	<div class="ctr-box">
						<ul class="num">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnSearch" />
						</ul>
					</div>
				  </c:if>
					  
				<!--// button --> 
				<div class="rt-box">
					<a href="javascript:void(0);" onclick="fnRegistFrom(); return false;" class="btn-a"><spring:message code="wzwg.cmm.word.regist" /></a>
				</div>
