<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

	<script type="text/javascript">
		/** 컨텐츠 CSS 등록 폼 */
		function fn_cntntsStyleRegistForm(){
			document.cntntsStyleForm.action='<c:out value="${wzwg_contextPath}${prefix}" />/cntntsMngr/cntntnsStyle/registCntntsStyleForm.do';
			document.cntntsStyleForm.submit();
		}
		
		/** 컨텐츠 CSS 상세조회 */
		function fn_cntntsStyleDetail(paramSeq){
			document.cntntsStyleForm.cssSeq.value = paramSeq;
			document.cntntsStyleForm.action='<c:out value="${wzwg_contextPath}${prefix}" />/cntntsMngr/cntntnsStyle/selectCntntsStyleDetail.do';
			document.cntntsStyleForm.submit();
		}
		
		/** 컨텐츠 CSS 미리보기 */
		function fn_cntntsStylePrevew(paramSeq){
			var frm = document.cntntsStylePopup;
			frm.cssSeq.value = paramSeq;
			
			var frmResult = window.open("", "popForm", "width=800,height=600,toolbars=no,menubars=no,scrollbars=yes");
			
			frm.target='popForm';
			frm.action='<c:out value="${wzwg_contextPath}${prefix}" />/cntntsMngr/cntntnsStyle/selectCntntsStylePrevewPopup.do';
			frm.submit();
		}
		
		/** 페이징 */
		function fnPage(paramPageIndex){
			
			if(isNaN(paramPageIndex)){
				console.log('잘못된 페이지호출');
				return;
			}
			
			document.cntntsStyleForm.pageIndex.value = paramPageIndex;
			document.cntntsStyleForm.action='<c:out value="${wzwg_contextPath}${prefix}" />/cntntsMngr/cntntnsStyle/selectCntntsStyleList.do';
			document.cntntsStyleForm.submit();
		}
		
		/** 검색 */
		function fnSearch(){
			document.cntntsStyleForm.pageIndex.value = 1;
			document.cntntsStyleForm.action='<c:out value="${wzwg_contextPath}${prefix}" />/cntntsMngr/cntntnsStyle/selectCntntsStyleList.do';
			document.cntntsStyleForm.submit();
		}
		$(document).ready(function(){
			$('input[name=searchKeyword]').focus();
		});
	</script>

	<form id="cntntsStylePopup" name="cntntsStylePopup" method="post">
		<input type="hidden" id="cssSeq" name="cssSeq" value=""/> 
	</form>

	<form id="cntntsStyleForm" name="cntntsStyleForm" method="post">
		<input type="hidden" name="cssSeq" id="cssSeq" value=""/>
		<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex}" />" />
		<input type="hidden" name="pageUnit" value="10" />
		
		<div class="wz_notice brbox bg-white br-blue-strong" style="overflow: visible;">
	        <ul class="wd100">
	               <li class="admpg-subp wd100 mb0">· <spring:message code="wzwg.cmm.msg.tip.MSG140" /></li>
	        </ul>
		</div>
		
		<div class="main-menu-bar">
			<select name="searchCondition" id="searchCondition">
				<option value="0"  <c:if test="${empty paramVO.searchCondition || paramVO.searchCondition eq '0' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.choise" /></option>
				<option value="1" <c:if test="${paramVO.searchCondition eq '1' }">selected="selected"</c:if>><spring:message code="wzwg.sysMngr.word.skinNm01" /></option>
				<option value="2" <c:if test="${paramVO.searchCondition eq '2' }">selected="selected"</c:if>>CSS <spring:message code="wzwg.sysMngr.word.fileNm01" /></option>
			</select>
			
			<c:set var="srchwrd">
				<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
			</c:set>
			
			<input type="text" name="searchKeyword" id="searchKeyword" placeholder="<c:out value="${srchwrd}" />" class="txt" onkeypress="if(window.event.keyCode == 13) {fnSearch();}" <c:if test="${!empty paramVO.searchKeyword}">value="<c:out value="${paramVO.searchKeyword }" />"</c:if> />
	 		<span  onclick="fnSearch();"><a class="wzbtn-table btn-srch" href="javascript:void(0);"><spring:message code="wzwg.cmm.word.search01" /></a></span>
		</div>
	
	
	  	<table class="basic-table">
			<colgroup>
				<col width="10%" />
				<col width="15%" />
				<col width="15%" />
				<col width="15%" />
				<col width="*" />
				<col width="15%" />
			</colgroup>
			<thead>
			  	<tr>
			  		<th>No</th>
					<th><spring:message code="wzwg.sysMngr.word.mdNm01" /></th>
					<th><spring:message code="wzwg.sysMngr.word.skinNm01" /></th>
					<th><spring:message code="wzwg.sysMngr.word.cssFileNm01" /></th>
					<th>CSS <spring:message code="wzwg.cmm.word.cours" /></th>
					<th><spring:message code="wzwg.cmm.word.manage" /></th>
	  			</tr>	
			</thead>
			<tbody>
			<c:choose>
				<c:when test="${!empty cntntsStyleList }">
					<c:forEach items="${cntntsStyleList }" var="cntntsStyleList" varStatus="status">
						<tr>
							<td>
								<c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.pageSize + status.count) + 1 }"/>
							</td>
							<td>
								<c:if test="${sessionScope.LANG eq 'SC00000016' }">
									<c:out value="${cntntsStyleList.moduleNm} "/>
								  </c:if>
								  <c:if test="${sessionScope.LANG ne 'SC00000016' }">
									<c:out value="${cntntsStyleList.moduleNmEng} "/>
								  </c:if>
							</td>
							<td><c:out value="${cntntsStyleList.cssNm }"/></td>
							<td>
								<c:out value="${cntntsStyleList.cssFileNm }"/>
							</td>
							<td class="txt-l">
								<c:out value="${cntntsStyleList.cssPath }"/>
							</td>
							<td>
								<a href="javascript:void(0);" onclick="fn_cntntsStylePrevew('<c:out value="${cntntsStyleList.cssSeq}" />');" class="iconOnlyBtnSameSize btn-basic"><spring:message code="wzwg.cmm.word.preview" /></a>
								<a href="javascript:void(0);" onclick="fn_cntntsStyleDetail('<c:out value="${cntntsStyleList.cssSeq}" />')" class="iconOnlyBtn btn-basic btn-modify" title="<spring:message code="wzwg.cmm.word.updt" />"><spring:message code="wzwg.cmm.word.updt" /></a>
							</td>
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
	 
	 <c:if test="${!empty cntntsStyleList}">
	 	<div class="ctr-box" id="pageInfo">
			<ul class="num mobile-none">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnPage" />
			</ul>
			
			<ul class="num pc-none">
				<ui:pagination paginationInfo="${mobilePaginationInfo}" type="image" jsFunction="fnPage" />
			</ul>
		</div>
	 </c:if>
	 <div class="fr">
		 <div class="rt-box">
		 		<a href="javascript:void(0);" onclick="fn_cntntsStyleRegistForm();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.regist" /></a>
		 </div>
	 </div>
