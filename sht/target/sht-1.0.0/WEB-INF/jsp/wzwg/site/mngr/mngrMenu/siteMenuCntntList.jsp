<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 
<select id="sitecntntsSeq" name="sitecntntsSeq" onchange="changeCntntsSeq(this)" class="w70">
	<option value="" data-menuat=""><spring:message code="wzwg.cmm.word.choise" /></option>
	<c:forEach items="${menuCntntList}" var="list" varStatus="status">
	<option value="<c:out value="${list.sitecntntsSeq }"/>" <c:if test="${not empty list.menuSeq}">data-menuat="Y" class="bg-grey"</c:if>><c:out value="${list.cntntsNm}"/></option>
	</c:forEach>
</select>
<div>
	<span class="wz_tableguide mt10">
		<%-- <span class="circle_no bg-green-strong">i</span>
		<spring:message code="wzwg.cmm.msg.MSG384"/> --%>
		<label class="block ml5"><input type="checkbox" onchange="fnSelectModuleFilter(this)"><spring:message code="wzwg.cmm.msg.MSG385"/></label>
	</span>
</div>
<span class="wz_tableguide mt10 red"><spring:message code="wzwg.cmm.msg.tip.MSG065" /></span> <!-- 안내문구 추가 -->

<script>
$(document).ready(function(){
	$('#sitecntntsSeq').select2();
})
</script>