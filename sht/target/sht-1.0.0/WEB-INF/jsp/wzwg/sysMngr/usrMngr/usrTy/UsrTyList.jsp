<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
	
<script type="text/javascript">
	function fnSearch(){
		var frm = document.sysMngrUsrTyForm;
		frm.action='<c:out value="${wzwg_contextPath}"/>/mngr/usrMngr/usrTy/selectUsrTyList.do';
		frm.submit();
	}
	
	function fn_usrTyRegistForm(){
		var frm = document.sysMngrUsrTyForm;
		frm.action='<c:out value="${wzwg_contextPath}"/>/mngr/usrMngr/usrTy/registUsrTyForm.do';
		frm.submit();
	}
	
	function fn_usrTyDetail(paramSeq){
		var frm = document.sysMngrUsrTyForm;
		frm.usrTySeq.value = paramSeq;
		
        frm.action='<c:out value="${wzwg_contextPath}"/>/mngr/usrMngr/usrTy/modifyUsrTyForm.do';
		frm.submit();
	}
	
	function fnPage(paramPageIndex){
		
		if(isNaN(paramPageIndex)){
			console.log('잘못된 페이지호출');
			return;
		}
		document.sysMngrUsrTyForm.pageIndex.value = paramPageIndex;
		document.sysMngrUsrTyForm.action='<c:out value="${wzwg_contextPath}"/>/mngr/usrMngr/usrTy/selectUsrTyList.do';
		document.sysMngrUsrTyForm.submit();
		
	}
	
</script>
	<div class="wz_notice brbox bg-white br-blue-strong">	
	        <ul class="wd100">
	                <li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG039" /></li>
	                <li class="admpg-subp wd100 mb0 grey">· <spring:message code="wzwg.cmm.msg.tip.MSG040" /></li>
	         </ul>
	</div>
		
	<form id="sysMngrUsrTyForm" name="sysMngrUsrTyForm" method="post">
		<input type="hidden" name="usrTySeq" id="usrTySeq" value=""/>
		<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex}"/>" />
	
	<!--//게시판 설정 table -->
	
	  <table class="basic-table">
		<colgroup>
			<col width="10%" />
	        <col width="*" />
            <col width="10%" />
            <col width="10%" />
			<col width="10%" />
	        <col width="17%" />
	        <col width="10%" />
		</colgroup>
		<thead>
		  <tr>
		  	<th>No</th>
			<th><spring:message code="wzwg.sysMngr.word.tyNm01" /></th>
			<th class="word_kp"><spring:message code="wzwg.sysMngr.word.bassMberGroup" /></th>
            <th class="word_kp"><spring:message code="wzwg.cmm.word.ExpsrMber" /></th>
			<th><spring:message code="wzwg.sysMngr.word.useAt" /></th>
			<th><spring:message code="wzwg.sysMngr.word.creatDe" /></th>
			<th><spring:message code="wzwg.cmm.word.manage" /></th>
		  </tr>
		</thead>
		<tbody>
		<c:choose>
			<c:when test="${!empty usrTyList }">
				<c:forEach items="${usrTyList }" var="usrTyList" varStatus="status">
					<tr>
						<td>
							<c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.pageSize + status.count) + 1 }"/>
						</td>
						<td class="txt-l"><c:out value="${usrTyList.tyNm }"/></td>
						<td>
                            <c:out value="${usrTyList.bassGroupNm }"/>
                        </td>
                        <td>
                            <c:choose>
                            <c:when test="${usrTyList.sbscrbTrgetAt eq 'Y'}"><span class="circle_badge bg-blue-strong br3 vert-m"><spring:message code="wzwg.cmm.word.use" /></span></c:when>
                            <c:otherwise><span class="circle_badge bg-grey-strong br3 vert-m"><spring:message code="wzwg.cmm.word.unuse" /></span></c:otherwise>
                            </c:choose>
                        </td>
                       
						<td>
                            <c:choose>
                            <c:when test="${usrTyList.useAt eq 'Y'}"><span class="circle_badge bg-blue-strong br3 vert-m"><spring:message code="wzwg.cmm.word.use" /></span></c:when>
                            <c:otherwise><span class="circle_badge bg-grey-strong br3 vert-m"><spring:message code="wzwg.cmm.word.unuse" /></span></c:otherwise>
                            </c:choose>
						</td>
						<td>
                            <span class="fs14"><c:out value="${usrTyList.frstRegistPnttm }"/></span>
						</td>
						<td><a href="javascript:void(0);" onclick="fn_usrTyDetail('<c:out value="${usrTyList.usrTySeq}"/>')" class="iconOnlyBtn btn-basic btn-setting" title="<spring:message code="wzwg.cmm.word.estbs" />"><spring:message code="wzwg.cmm.word.estbs" /></a></td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<td colspan="7"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
			</c:otherwise>
		</c:choose>
		</tbody>
	  </table>
	 </form>
	 
	 <c:if test="${!empty usrTyList}">
	 	<div class="ctr-box" id="pageInfo">
			<ul class="num mobile-none">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnPage" />
			</ul>
			
			<ul class="num pc-none">
				<ui:pagination paginationInfo="${mobilePaginationInfo}" type="image" jsFunction="fnPage" />
			</ul>
		</div>
	 </c:if>

	 <div class="rt-box">
		<a href="javascript:void(0);" class="wzbtn btn-save" onclick="fn_usrTyRegistForm();"><spring:message code="wzwg.cmm.word.regist" /></a>
	 </div>
