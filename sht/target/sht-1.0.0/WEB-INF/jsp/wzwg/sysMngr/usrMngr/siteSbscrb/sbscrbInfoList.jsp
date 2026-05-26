<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

	<script type="text/javascript">

	function fnSearch(){
		
		var frm = document.frmSrh;
		
		frm.pageIndex.value = 1;
		
		frm.action = "<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/siteSbscrb/selectSbscrbInfoList.do";
		frm.target = "_self";
		frm.submit();
		
	}
	
	/** 가입정보 설정 페이지 이동 */
	function fnSbscrbForm(siteSeq){
		var frm = document.frmSrh;
		frm.siteSeq.value = siteSeq;
		frm.action = "<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/siteSbscrb/selectSbscrbInfoForm.do";
		frm.target = "_self";
		frm.submit();
	}
	
	/** 미리보기 */
	function fnPreview(siteSeq){
		var frm = document.frmSrh;
		document.frmSrh.siteSeq.value = siteSeq;
		window.open("", "previewPopup", "width=800,height=600,toolbars=no,menubars=no,scrollbars=yes");
		frm.action = "<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/siteSbscrb/sbscrbInfoPreviewPopup.do";
		frm.target = "previewPopup";
		frm.submit();
	}

	/** 페이징 */
	function fnPage(paramPageIndex){
		
		if(isNaN(paramPageIndex)){
			console.log('잘못된 페이지호출');
			return;
		}
		document.frmSrh.pageIndex.value = paramPageIndex;
		document.frmSrh.action='<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/siteSbscrb/selectSbscrbInfoList.do';
		document.frmSrh.submit();
		
	}
	
	</script>
		<form:form modelAttribute="paramVO" path="frmSrh" name="frmSrh" id="frmSrh" method="post" onsubmit="return false;">
			<form:hidden path="siteSeq" />
			<form:hidden path="pageIndex" />
                    
					<!--//게시판명 table -->
					<div class="main-menu-bar">
						<form:select path="searchCondition"> 
							<form:option value=""><label for="all"><spring:message code="wzwg.cmm.word.all" /></label></form:option>
							<form:option value="1"><label for="sitenm01"><spring:message code="wzwg.sysMngr.word.siteNm01" /></label></form:option>
						</form:select>
						
						<c:set var="srchwrd">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
						</c:set>
						<form:input path="searchKeyword" placeholder="<c:out value="${srchwrd}" />" class="txt" onkeydown="if(event.keyCode == 13){fnSearch();}" />
						<a href="javascript:void(0);" onclick="fnSearch();" class="btn-c"><spring:message code="wzwg.cmm.word.search01" /></a>
					</div>
					
					<!--//게시판 설정 table -->
					<table class="basic-table">
						<colgroup>
							<col width="10%" />
                	        <col width="*" />
                	        <col width="15%" />
                	        <col width="20%" />
						</colgroup>
						<thead>
						  <tr>
							<th><spring:message code="wzwg.cmm.word.sn" /></th>
							<th><spring:message code="wzwg.sysMngr.word.siteNm01" />(<spring:message code="wzwg.cmm.word.abrv" />)</th>
							<th><spring:message code="wzwg.sysMngr.word.creatDe01" /></th>
							<th><spring:message code="wzwg.cmm.word.manage" /></th>
						  </tr>
						</thead>
						<tbody>
						<c:if test="${empty resultList}">
						<tr>
							<td colspan="4"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
						</tr>
						</c:if>
						<c:forEach items="${resultList}" var="resultList" varStatus="status">
						<tr>
							<td><c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.recordCountPerPage + status.count) + 1}" /></td>
							<td class="txt-l"><c:out value="${resultList.siteFullNm}" />(<c:out value="${resultList.siteAbrvNm}" />)</td>
							<td><c:out value="${resultList.creatDe}" /></td>
							<td>
                                <a href="javascript:void(0);" onclick="fnSbscrbForm('<c:out value="${resultList.siteSeq}" />'); return false;" class="btn-c"><spring:message code="wzwg.cmm.word.estbs" /></a>
                                <c:if test="${resultList.useAt eq 'Y'}">
                                	<a href="javascript:void(0);" onclick="fnPreview('<c:out value="${resultList.siteSeq}" />');" class="btn-c"><spring:message code="wzwg.cmm.word.preview" /></a>
                                </c:if>
							</td>
						</tr>
						</c:forEach>
						</tbody>
				  </table>
				  <c:if test="${!empty resultList}">
				  	<div class="ctr-box">
						<ul class="num">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnPage" />
						</ul>
					</div>
				  </c:if>
				  
		</form:form>