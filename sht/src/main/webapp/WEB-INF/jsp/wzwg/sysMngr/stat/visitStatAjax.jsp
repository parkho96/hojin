<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script src="/js/wzwg/cmm/chart.min.js"></script>
<script src="/js/wzwg/cmm/chartjs-plugin-datalabels.min.js"></script>
<script>
    $(function () {


    	var labels = [
    		 <c:forEach items="${statList}" var="resultList" varStatus="status">'<c:out value="${resultList.statDate}" />' <c:if test="${!status.last}">,</c:if></c:forEach>
			];
		var data = {
				  labels: labels,
				  datasets: [
				    {
				      label: '<spring:message code="wzwg.sysMngr.word.visitrCo" />',
				      data: [
				    	  <c:forEach items="${statList}" var="resultList" varStatus="status"><c:out value="${resultList.cnt}" /> <c:if test="${!status.last}">,</c:if></c:forEach>
				      ],
				      datalabels: {align: 'end', anchor: 'end'},
				      backgroundColor: 'rgba(54, 162, 235, 0.5)',
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
				        text:  '<spring:message code="wzwg.sysMngr.word.periodbyVisitrSttus02" />'
				      }
				    }
				  },
				};
		var myChart = new Chart(
			    document.getElementById('statChartDiv'),
			    config
			  );

  });
</script>
     <canvas id="statChartDiv" style="width:100%; height: 400px; "></canvas>
