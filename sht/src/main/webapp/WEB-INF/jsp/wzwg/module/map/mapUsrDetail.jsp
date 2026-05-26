<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<div>
	<c:out value="${result.mapCn}" escapeXml="false"/>
</div>

<div class="mt20">
	<c:import url="${wzwg_contextPath}/usr/cntnts/cntPagadiEstbs/selectCntPagadiEstbsUsrAjax.do">
		<c:param name="frstRegistPnttm" value="<c:out value='${result.frstRegistPnttm}'/>" />
	</c:import>
</div>

<%-- <div style="width: 100%; text-align: center; overflow: auto;">
	<a href="http://map.naver.com/index.nhn?query=${result.mapAddr }&tab=1&level=2" target="_blank" class="btn-a">
		네이버 지도 바로가기
	</a>
</div> --%>