<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<% 
    pageContext.setAttribute("stplatCn", "\n"); 
%>

	<div class="clauseTxt">
		<c:if test="${!empty resultList}">
	    <c:forEach items="${resultList}" var="result" varStatus="status">
	    <c:if test="${status.first}">
	    	<h3><c:out value="${result.stplatSj}" /></h3>
	        <p><%--<c:out value="${result.stplatCn}" /> --%> <span>[<spring:message code="wzwg.cmm.word.opertnDe" />] <c:out value="${result.opertnDe}" /> ~ <c:out value="${result.endDe}" /></span></p>
	        <ul class="ContentsWrap">
	        	<li>
	            	<p><%-- <c:out value="${result.stplatSj}" /> --%></p>
	                <ul class="ContentsList">
	                	<li tabindex="0">
	                    	<%-- <c:out value='${fn:replace(result.stplatCn, stplatCn, "<br />")}' escapeXml="false" /> --%>
	                    	<c:out value='${result.stplatCn}' escapeXml="false" />
	                    </li>
	                </ul>
	            </li>
	        </ul>
	   </c:if>
	   </c:forEach>
	   </c:if>
	</div>
     
    <div class="sbscrbWrap">
       
       <c:if test="${paramVO.stplatTyCode eq 'SC00000453' }">
        	<c:set var="stplatLogCaption"><spring:message code="wzwg.module.word.stplathistofstplatNm" /></c:set>
       </c:if>
       <c:if test="${paramVO.stplatTyCode eq 'SC00000454' }">
       		<c:set var="stplatLogCaption"><spring:message code="wzwg.module.word.policyhistofpolicynm" /></c:set>
       </c:if>
       <table class="sbscrbTable tblclause">
       <caption><spring:message code="wzwg.cmm.cmmMsg.CMG024"><spring:argument><c:out value="${stplatLogCaption}" />, <spring:message code="wzwg.cmm.word.opertnDe" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.wa.table" /></spring:argument></spring:message></caption>
       <colgroup>
           <col width="5%">
           <col width="*">
           <col width="30%">
       </colgroup>
       <thead>
       <tr>
           <th scope="col">No</th>
           <c:if test="${paramVO.stplatTyCode eq 'SC00000453' }">
           <th scope="col"><spring:message code="wzwg.cmm.word.stplatNm" /></th>
           </c:if>
           <c:if test="${paramVO.stplatTyCode eq 'SC00000454' }">
           <th scope="col"><spring:message code="wzwg.cmm.word.policynm" /></th>
           </c:if>
           <th scope="col"><spring:message code="wzwg.cmm.word.opertnDe" /></th>
       </tr>
       </thead>
       <tbody>
       
       <c:choose>
       <c:when test="${!empty resultList}">
       <c:forEach items="${resultList}" var="result" varStatus="status">
       <c:if test="${!status.first}">
       <tr>
           <td><c:out value="${fn:length(resultList)-status.count+1}" /></td>
           <td><a href="javascript:void(0);" onclick="fnTdStplatCnCtrl('<c:out value="${status.count}" />', this);" style="cursor:pointer;" title="<c:out value="${result.stplatSj}" /> <spring:message code="wzwg.module.word.cnopen" />"><c:out value="${result.stplatSj}" /></a></td>
           <td><c:out value="${result.opertnDe}" /> ~ <c:out value="${result.endDe}" /></td>
       </tr>
       <tr class="tdLogCn stplatCn<c:out value="${status.count}" />" style="display:none;">
           <td colspan="3">
               <h3><c:out value="${result.stplatSj}" /></h3>
               <c:out value='${fn:replace(result.stplatCn, stplatCn, "<br />")}' escapeXml="false" />
           </td>
       </tr>
       </c:if>
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
   
	</div>
            
                          
