<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp"%>

<%
     //치환 변수 선언합니다.
      pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
      pageContext.setAttribute("br", "<br/>"); //br 태그
%> 

	<tbody>
		<input type="hidden"  id="orgInfoMemTbdy" name="orgInfoMemTbdy" value="<c:out value="${paramVO.orgnztSeq}" />"/>

		<c:forEach items="${orgnztInfoMemList}" var="list" varStatus="status">
		<tr>
			<td class="normalTh"><c:out value="${list.orgnztNmKr}" /></td>
			<td style="width: 15%;">
				<div class="dragMember br5 wz-box br-grey" data-orgMemSeq="<c:out value="${list.orgnztmberSeq}" />" style="cursor: move;margin-bottom: 0px;position: relative;padding: 5px;">
					<span class="bg-grey fl grey" style="height: 100%;position: absolute;left: 0;width: 24px;top: 0;font-size: 22px;line-height: 27px;font-weight: bold;">≡</span><strong><c:out value="${list.orgnztmberNm}" /></strong>
				</div>
			</td>
			<td><c:out value="${list.orgnztmberClsf}" /></td>
			<td>
				<ul style="width: auto; display: inline-block;">
				<c:forEach items="${fn:split(list.chrgJob, crcn)}" var="chrgJob"><li><c:out value="${chrgJob}" /></li></c:forEach> 
				</ul>
			</td>
			<td class="mobile-none">
				<ul style="width: auto; display: inline-block;">
						<c:if test="${not empty list.telno}"><li>Tel : <c:out value="${list.telno}" /></li></c:if>
						<c:if test="${not empty list.faxnum}"><li>Fax : <c:out value="${list.faxnum}" /></li></c:if>
						<c:if test="${not empty list.emailAdres}"><li>E-mail : <c:out value="${list.emailAdres}" /></li></c:if>
					</ul>
			</td>
			<td class="ordBtns">
				<button type="button" class="btn-basic iconOnlyBtn btn-sortUp" data-orgMemSeq="<c:out value="${list.orgnztmberSeq}" />" onclick="fnOrgMemOrdrChange('prev', this)" title="<spring:message code="wzwg.cmm.word.up" />">▲</button>
				<button type="button" class="btn-basic iconOnlyBtn btn-sortDown" data-orgMemSeq="<c:out value="${list.orgnztmberSeq}" />" onclick="fnOrgMemOrdrChange('next', this)" title="<spring:message code="wzwg.cmm.word.down" />">▼</button>
			</td>
			
			<td>
				<button type="button" class="iconOnlyBtn btn-basic btn-modify" onclick="fnModifyOrgInfoMemForm('<c:out value="${list.orgnztSeq}" />','<c:out value="${list.orgnztmberSeq}" />','<c:out value="${list.orgnztNmKr}" />','<c:out value="${list.orgnztTySe}" />');" title="<spring:message code="wzwg.cmm.word.updt" />">
					<spring:message code="wzwg.cmm.word.updt" />
				</button>
			</td>
		</tr>
		</c:forEach>
		
		<c:if test="${empty orgnztInfoMemList}">
		<tr>
			<td colspan="9" class="txt-c"><spring:message code="wzwg.cmm.module.org.MSG006"/></td>
		</tr>
		</c:if>
	
	</tbody>		
	
	