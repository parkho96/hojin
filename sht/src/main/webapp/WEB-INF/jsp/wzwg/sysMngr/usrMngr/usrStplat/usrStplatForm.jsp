<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

	<script type="text/javascript">

	function fnSearch(){
		
		var frm = document.frmSrh;
		
		frm.pageIndex.value = 1;
		
		frm.action = "<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/usrStplat/selectUsrStplatList.do";
		frm.target = "_self";
		frm.submit();
		
	}
	
	/** 가입정보 설정 페이지 이동 */
	function fnSbscrbForm(siteSeq){
		var frm = document.frmSrh;
		frm.siteSeq.value = siteSeq;
		frm.action = "<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/usrStplat/selectUsrStplatForm.do";
		frm.target = "_self";
		frm.submit();
	}
	
	</script>
		<form:form modelAttribute="paramVO" path="frmSrh" name="frmSrh" id="frmSrh" method="post" onsubmit="return false;">
			<form:hidden path="siteSeq" />
			<form:hidden path="pageIndex" />
                    
					<!--//게시판명 table -->
					<div class="search mg_t20">
					<c:set var="msg_title_txt01"> 
							 <spring:message code="wzwg.sysMngr.word.sch01Se" /> 
					</c:set>
						<form:select path="searchCondition" title="${fn:escapeXml(msg_title_txt01)}" cssClass="form-control w10">
							<form:option value=""><label for="all"><spring:message code="wzwg.cmm.word.all" /></label></form:option>
							<form:option value="1"><label for="sitenm01"><spring:message code="wzwg.sysMngr.word.siteNm01" /></label></form:option>
						</form:select>
						
				
						<c:set var="srchwrd">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
						</c:set>
						<form:input path="searchKeyword" placeholder="${fn:escapeXml(srchwrd)}" class="form-control w30" onkeydown="if(event.keyCode == 13){fnSearch();}" />
						<span class="btn btn_search btn_xs" onclick="fnSearch();"><a href="javascript:void(0);"><spring:message code="wzwg.cmm.word.search01" /></a></span>
					</div>
					
					<!--//게시판 설정 table -->
					<div class="tableWrap mg_t20">
					  <table>
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
							<td><c:out value="${resultList.siteFullNm}" />(<c:out value="${resultList.siteAbrvNm}" />)</td>
							<td><c:out value="${resultList.creatDe}" /></td>
							<td class="ta_c">
                                <a href="javascript:void(0);" class="btn btn_default btn_xs" onclick="fnSbscrbForm('<c:out value="${resultList.siteSeq}" />'); return false;"><spring:message code="wzwg.cmm.word.estbs" /></a>
							</td>
						</tr>
						</c:forEach>
						</tbody>
					  </table>
				  </div>
				  <c:if test="${!empty resultList}">
				  	<div class="of mg_t20">
						<div class="paging">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnPage" />
						</div>
					</div>
				  </c:if>
				  
		</form:form>