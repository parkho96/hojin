<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

	<script type="text/javascript">
	
		function fn_search(paramPageIndex){
			if(isNaN(paramPageIndex)){console.log('잘못된 페이지호출');return;}
			document.searchForm.pageIndex.value = paramPageIndex;
			document.searchForm.action='<c:out value="${wzwg_contextPath}${prefix}"/>/module/api/selectModuleApiList.do';
			document.searchForm.submit();
		}
		
		function fn_selectForm(paramSeq, paramCode){
			document.searchForm.apiSeq.value = paramSeq;
			document.searchForm.apiSeCode.value = paramCode;
			document.searchForm.action='<c:out value="${wzwg_contextPath}${prefix}"/>/module/api/selectModuleApiForm.do';
			document.searchForm.submit();
		}
		
		
	</script>

	<form id="searchForm" name="searchForm" method="post">
		<input type="hidden" id="apiSeq" name="apiSeq" value=""/>
		<input type="hidden" id="apiSeCode" name="apiSeCode" value=""/>
		<input type="hidden" id="pageIndex" name="pageIndex" value="<c:out value='${paramVO.pageIndex}'/>"/>
	  	<table class="basic-table">
			<colgroup>
				<col width="20%" />
				<col width="*" />
			</colgroup>
			<thead>
			  	<tr>
					<th>분류</th>
					<th>API 키값</th>
	  			</tr>	
			</thead>
			<tbody>
			<c:choose>
				<c:when test="${!empty resultList }">
					<c:forEach items="${resultList }" var="resultList" varStatus="status">
						<tr style="cursor: pointer;" onclick="fn_selectForm('<c:out value="${resultList.apiSeq}"/>','<c:out value="${resultList.apiSeCode }"/>');">
							<td><c:out value="${resultList.apiSeCodeNm }"/></td>
							<td><c:out value="${resultList.apiCrtfcKey }"/></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<td colspan="2"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
				</c:otherwise>
			</c:choose>
			</tbody>
		</table>
	 </form>
	 
	 <c:if test="${!empty resultList}">
	 	<div class="ctr-box">
	 		<ul class="num">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
			</ul>
		</div>
	 </c:if>

