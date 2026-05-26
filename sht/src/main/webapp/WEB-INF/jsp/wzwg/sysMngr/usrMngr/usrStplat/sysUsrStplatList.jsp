<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

	<script type="text/javascript">

	function fnSearch(pageNum){
		
		if(isNaN(pageNum)){
			console.log('잘못된 페이지호출');
			return;
		}
		
		var frm = document.frmSrh;
		
		frm.pageIndex.value = pageNum;
		
		frm.action = "<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/usrStplat/selectSysUsrStplatList.do";
		frm.target = "_self";
		frm.submit();
		
	}
	
	/** 가입정보 설정 페이지 이동 */
	function fn_registForm(usrstplatSeq){
		var frm = document.frmSrh;
		frm.usrstplatSeq.value = usrstplatSeq;
		frm.action = "<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/usrStplat/selectSysUsrStplatForm.do";
		frm.submit();
	}
	
	</script>
		<form:form modelAttribute="paramVO" path="frmSrh" name="frmSrh" id="frmSrh" method="post" onsubmit="return false;">
			<form:hidden path="usrstplatSeq" />
			<form:hidden path="pageIndex" />
                  
			<!--//게시판명 table -->
			<div class="main-menu-bar">
				<form:select path="searchCondition"> 
					<form:option value=""><label for="option1"><spring:message code="wzwg.cmm.word.all" /></label></form:option>
					<form:option value="1"><label for="option2"><spring:message code="wzwg.sysMngr.word.stplatNm01" /></label></form:option>
				</form:select>
				
				<c:set var="srchwrd">
					<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
				</c:set>
				<form:input path="searchKeyword" placeholder="<c:out value="${srchwrd}" />" class="txt" onkeydown="if(event.keyCode == 13){fnSearch();}" />
				<a href="javascript:void(0);" onclick="fnSearch(1);" class="btn-c"><spring:message code="wzwg.cmm.word.search01" /></a>
			</div>
			
			<!--//게시판 설정 table -->
		  	<table class="basic-table">
				<colgroup>
				<col width="10%" />
                  	   <col width="15%" />
                  	   <col width="*" />
                  	   <col width="15%" />
                  	   <col width="15%" />
                  	   <col width="15%" />
				</colgroup>
				<thead>
				  <tr>
					<th>No</th>
					<th><spring:message code="wzwg.sysMngr.word.stplatTy" /></th>
					<th><spring:message code="wzwg.sysMngr.word.stplatNm01" /></th>
                 	<th><spring:message code="wzwg.cmm.word.se" /></th>
                  	<th><spring:message code="wzwg.sysMngr.word.estbsDe" /></th>
					<th><spring:message code="wzwg.cmm.word.lastupdtde" /></th>
				  </tr>
				</thead>
				<tbody>
				<c:if test="${empty resultList}">
				<tr>
					<td colspan="6"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
				</tr>
				</c:if>
				<c:forEach items="${resultList}" var="result" varStatus="status">
				<tr style="cursor:pointer;" onclick="fn_registForm('<c:out value="${result.usrstplatSeq}" />')">
					<td><c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.recordCountPerPage + status.count) + 1}" /></td>
					<td><c:out value="${result.stplatTyCodeNm}" /></td>
					<td><c:out value="${result.stplatSj}" /></td>
                       <td>
						<c:if test="${result.stplatEstbsSe eq 'E'}"><spring:message code="wzwg.cmm.word.essntl" /></c:if>
                           <c:if test="${result.stplatEstbsSe eq 'S'}"><spring:message code="wzwg.cmm.word.choise" /></c:if>
                           <c:if test="${result.stplatEstbsSe eq 'N'}"><spring:message code="wzwg.cmm.word.unuse" /></c:if>
                       </td>
                       <td><c:out value="${result.stplatEstbsPnttm}" /></td>
                       <td><c:out value="${result.lastUpdtPnttm}" /></td>
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

			<div class="rt-box">
				<a href="javascript:void(0);" onclick="fn_registForm('');" class="btn-a"><spring:message code="wzwg.cmm.word.regist" /></a>
	     	</div>
					  
		</form:form>