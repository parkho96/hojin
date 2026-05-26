<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 
	<div class="layout_wrap changeBg" style="border:1px dashed #b9cde5 !important;">
		<div class="axebox">X</div> <!-- 레이아웃 삭제버튼 -->
		<div class="div_wrap layout_block4">
		<c:set var="widthList" value="${fn:split(layout.widthCssNm,',')}"/>
			<c:forEach items="${widthList}" var="width">
			<div class="<c:out value="${width}"/> <c:out value="${layout.vrticlCssNm}"/>" style="border:2px dashed #1376b9 !important;" data-widthCssNm="<c:out value="${width}"/>" data-vrticlCssNm="<c:out value="${layout.vrticlCssNm}"/>" data-attr="<spring:message code="wzwg.site.screen.msg.MSG193"/>">
			<div class="axebox">X</div> <!-- 삭제버튼 --> 
			</div>
			</c:forEach> 
		</div>
	</div>
	 