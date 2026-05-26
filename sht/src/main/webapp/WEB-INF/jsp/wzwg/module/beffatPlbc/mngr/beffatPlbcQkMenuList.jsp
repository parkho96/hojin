<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

	<c:forEach items="${beffatPlbcQkMenuList }" var="list">
		<li class="w30 i-block">
			<div class="wzbtn-group w100">
			<button type="button" class="wzbtn btn-blue fl ml5 w80" onclick="fnSelectPblbcListToPblcSn('<c:out value="${list.pblcSn}"/>')">
				<c:choose>
					<c:when test="${fn:length(list.beffatPblcSj) > 18 }"><c:out value="${fn:substring(list.beffatPblcSj, 0 , 18) }..."/></c:when>
					<c:otherwise><c:out value="${list.beffatPblcSj }"/></c:otherwise>
				</c:choose>
			</button>
			<button type="button" class="wzbtn btn-del fl ml5 pl10 pr10" onclick="fnDelQuickItem('<c:out value="${list.pblcSn}"/>')">X</button>
			</div>
		</li>
	</c:forEach>