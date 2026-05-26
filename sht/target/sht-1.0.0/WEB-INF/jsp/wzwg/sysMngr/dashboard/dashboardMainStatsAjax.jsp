<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script src="/js/wzwg/cmm/chart.min.js"></script> 
<% 
	pageContext.setAttribute("cn", "\n"); 
	pageContext.setAttribute("CR", "\r");
	pageContext.setAttribute("CRLF", "\r\n");

%>
<script type="text/javascript">
	$(function () {
		 
		var labels = [
			<c:forEach items="${siteStatList}" var="resultList" varStatus="status">'<c:out value="${fn:replace(fn:replace(resultList.siteNm, cn, \"\"), CR, \"\")}" escapeXml="true"/>' <c:if test="${!status.last}">,</c:if></c:forEach>
			];
		var data = {
				  labels: labels,
				  datasets: [
				    {
				      label: '<spring:message code="wzwg.sysMngr.word.sbscrberCo" />',
				      data: [
				    	  <c:forEach items="${siteStatList}" var="resultList" varStatus="status">${resultList.usrCnt} <c:if test="${!status.last}">,</c:if></c:forEach> 
				      ], 
				      backgroundColor: 'rgba(255, 99, 132, 0.2)',
				    },
				    {
				      label: '<spring:message code="wzwg.sysMngr.word.visitrCo" />',
				      data: [
				    	  <c:forEach items="${siteStatList}" var="resultList" varStatus="status">${resultList.visitCnt} <c:if test="${!status.last}">,</c:if></c:forEach>	  
					      ], 
				      backgroundColor: 'rgba(54, 162, 235, 0.2)',
				    },
				    {
					      label: '<spring:message code="wzwg.sysMngr.word.registPostCo" />',
					      data: [
					    	  <c:forEach items="${siteStatList}" var="resultList" varStatus="status">${resultList.bbsCnt} <c:if test="${!status.last}">,</c:if></c:forEach>  	  
						      ], 
					      backgroundColor: 'rgba(255, 206, 86, 0.2)',
					},
				    {
					      label: '<spring:message code="wzwg.sysMngr.word.menuUse02Co" />',
					      data: [
					    	  <c:forEach items="${siteStatList}" var="resultList" varStatus="status">${resultList.menuCnt} <c:if test="${!status.last}">,</c:if></c:forEach>    	  
						      ], 
					      backgroundColor:  'rgba(75, 192, 192, 0.2)',
					}
				  ]
				};
		
		var config = {
				  type: 'bar',
				  data: data,
				  options: {
				    responsive: false,
				    plugins: {
				      legend: {
				        position: 'top',
				      },
				      title: {
				        display: true,
				        text: '<spring:message code="wzwg.sysMngr.word.bysiteSttus02" />'
				      }
				    }
				  },
				};
		var myChart = new Chart(
			    document.getElementById('siteStat'),
			    config
			  );
		 
	});
</script>
  
<div>
  <canvas id="siteStat" style="width:100%; height: 400px;"></canvas>
</div>