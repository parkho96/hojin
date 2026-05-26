<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
	
	<script type="text/javascript">
		 function fnDetail(inqrydtlsSeq){
			 var frm = document.frmList;
			 
			 frm.inqrydtlsSeq.value = inqrydtlsSeq;
			 frm.action='<c:out value="${wzwg_contextPath}"/>/mngr/inqryDtls/selectSiteInqryDtlsDetail.do';
			 frm.submit(); 
		}
		 
		 function fnList(pageIndex){
			if(isNaN(pageIndex)){console.log('잘못된 페이지호출');return;}
			var frm = document.frmList;
			
            frm.pageIndex.value = pageIndex;
			
			frm.action='<c:out value="${wzwg_contextPath}"/>/mngr/inqryDtls/selectSiteInqryDtlsList.do';
			frm.submit();
		}
	</script>
	
	<div class="wz_notice brbox bg-white br-blue-strong" style="overflow: visible;">	
	        <ul class="wd100">
	                <li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG028" /></li>
	                <li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG029" /></li>
	                <li class="admpg-subp wd100 wzAdmSTit p0 mb0" style="background: transparent;">· <spring:message code="wzwg.site.inqrydtls.msg.MSG002" />
	                        <div class="menu_help">
		                <img src="/images/wzwg/site/mngr/ico_help_grey.png" alt="">
		                <div class="help_pop">
		                            <img src="/images/wzwg/site/mngr/helpimg_contact.jpg" class="mxwd100" alt="">
	                                </div>
	                        </div>
	                </li>	
	        </ul>
	</div>
		
	<form id="frmList" name="frmList" method="post">
  	    <input type="hidden" name="inqrydtlsSeq" id="inqrydtlsSeq" />
  	    <input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex}"/>"/>
		<div class="main-menu-bar">
			<select name="searchCondition" id="searchCondition">
				<option value="0" <c:if test="${empty paramVO.searchCondition || paramVO.searchCondition eq '0'}">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.sj"/>+<spring:message code="wzwg.cmm.word.cn"/></option>
				<option value="1" <c:if test="${paramVO.searchCondition eq '1'}">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.sj"/></option>
                <option value="2" <c:if test="${paramVO.searchCondition eq '2'}">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.cn"/></option>
                <option value="3" <c:if test="${paramVO.searchCondition eq '3'}">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.wrter"/></option>
			</select>
			
			<c:set var="msg_txt01">
				<spring:message code="wzwg.cmm.cmmMsg.CMG011">
					<spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument>
					<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
				</spring:message>
			</c:set>
			
			<input type="text" name="searchKeyword" id="searchKeyword" placeholder="<c:out value="${msg_txt01}"/>" class="txt" onkeypress="if(window.event.keyCode == 13) {fnList(1);}" <c:if test="${!empty paramVO.searchKeyword}">value="<c:out value="${paramVO.searchKeyword}"/>"</c:if> />
	 		<a href="javascript:void(0);" class="wzbtn-table btn-srch" onclick="fnList(1);"><spring:message code="wzwg.cmm.word.search01"/></a>
		</div>
	
		<table class="basic-table">
			<colgroup>
				<col width="10%" />
		        <col width="*" />
		        <col width="15%" />
		        <col width="15%" />
		        <col width="20%" />
			</colgroup>
			<thead>
			  <tr>
			  	<th>No</th>
				<th><spring:message code="wzwg.cmm.word.sj"/></th>
                <th><spring:message code="wzwg.cmm.word.wrter"/></th>
                <th><spring:message code="wzwg.cmm.word.cttpc"/></th>
                <th><spring:message code="wzwg.cmm.word.rgsde02"/></th>
			  </tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${!empty resultList}">
						<c:forEach items="${resultList}" var="result" varStatus="status">
							<tr onclick="fnDetail('<c:out value="${result.inqrydtlsSeq}"/>');" style="cursor:pointer;">
								<td>
									<c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.pageSize + status.count) + 1}"/>
								</td>
								<td class="txt-l"><c:out value="${result.inqrySj}"/></td>
                                <td><c:out value="${result.waterNm}" /></td>
								<td><c:out value="${result.waterCttpl}" /></td>
								<td><c:out value="${result.frstRegistPnttm}" /></td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="5">
                                <spring:message code="wzwg.cmm.cmmMsg.CMG014">
                                    <spring:argument><spring:message code="wzwg.cmm.word.dtartv" /></spring:argument>
                                </spring:message>
                            </td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</form>
	 
	 <c:if test="${!empty resultList}">
	 	<div class="ctr-box" id="pageInfo">
			<ul class="num mobile-none">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnList" />
			</ul>
			
			<ul class="num pc-none">
				<ui:pagination paginationInfo="${mobilePaginationInfo}" type="image" jsFunction="fnList" />
			</ul>
		</div>
	 </c:if>
