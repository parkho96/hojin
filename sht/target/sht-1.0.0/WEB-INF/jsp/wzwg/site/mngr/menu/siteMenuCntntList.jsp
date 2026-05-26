<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 
<select id="sitecntntsSeq" name="sitecntntsSeq" onchange="changeCntntsSeq(this)" class="w70">
	<option value="" data-menuat=""><spring:message code="wzwg.cmm.word.choise" /></option>
	  <c:if test="${param.moduleTyCode eq 'SC00000030' or param.moduleTyCode eq 'SC00000031' or param.moduleTyCode eq 'SC00000032' }">
	  <c:if test="${param.sysmoduleSeq ne '10000000238' and param.sysmoduleSeq ne '10000000215'}">
	   <option value="bass"><spring:message code="wzwg.cmm.cntnts.cntntAutoConect" /></option>
	   </c:if>
	  </c:if>
	<c:forEach items="${menuCntntList}" var="list" varStatus="status">
	<option value="<c:out value="${list.sitecntntsSeq }"/>" <c:if test="${not empty list.menuSeq}">data-menuat="Y" class="bg-grey"</c:if>><c:out value="${list.cntntsNm}" escapeXml="false"/></option>
	</c:forEach>
</select>
<div>
	<ul class="wzForm wd100 fl">
		<%-- <span class="circle_no bg-green-strong">i</span>
		<spring:message code="wzwg.cmm.msg.MSG384"/> --%>
		<li><label class="block ml5 mt5"><input type="checkbox" onchange="fnSelectModuleFilter(this)"><span class="spanLabel"><spring:message code="wzwg.cmm.msg.MSG385"/></span></label></li>
	</ul>
</div>
<span class="wz_tableguide mt5 red fl" style="text-indent: -25px; padding-left: 23px;"><span class="circle_no bg-red-strong vert-m" style="text-indent:0;">i</span><spring:message code="wzwg.cmm.msg.tip.MSG065" /></span> <!-- 안내문구 추가 -->

<script>
$(document).ready(function(){
	$('#sitecntntsSeq').select2();
})
</script>