<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<%
     //치환 변수 선언합니다.
      pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
      pageContext.setAttribute("br", "<br/>"); //br 태그
%> 


		
   	<tbody>
		<input type="hidden"  id="orgInfoMemTbdy" name="orgInfoMemTbdy" value="<c:out value="${paramVO.orgnztSeq}" />"/>
		
		
		<c:if test="${(paramVO.orgnztTySe ne 'ctrd') or (paramVO.orgnztTySe eq 'allTySe')}">
			<c:forEach items="${orgnztInfoMemList}" var="list" varStatus="status">
			<tr>
				<td class="normalTh mobile-none"><c:out value="${list.orgnztNmKr}" /></td>
				<td><c:out value="${list.orgnztmberNm}" /></td>
				<td><c:out value="${list.orgnztmberClsf}" /></td>
				<td class="txt-l">
					<ul style="width: auto; display: inline-block;">
					<c:forEach items="${fn:split(list.chrgJob, crcn)}" var="chrgJob"><li><c:out value="${chrgJob}" /></li></c:forEach> 
					</ul>
				</td>
				<td class="txt-c">
					<ul style="width: auto; display: inline-block;">
						<c:if test="${not empty list.telno}"><li style="list-style:none;">Tel : <c:out value="${list.telno}" /></li></c:if>
						<c:if test="${not empty list.faxnum}"><li style="list-style:none;">Fax : <c:out value="${list.faxnum}" /></li></c:if>
						<c:if test="${not empty list.emailAdres}"><li style="list-style:none;">E-mail : <c:out value="${list.emailAdres}" /></li></c:if>
					</ul>
				</td>
			</tr>
			</c:forEach>
			
		</c:if>
		
		<c:if test="${empty orgnztInfoMemList}" >
			<tr>
				<td colspan="9" class="txt-c"><spring:message code="wzwg.cmm.module.org.MSG006"/></td>
			</tr>
		</c:if>
	
	</tbody>		
	
	
