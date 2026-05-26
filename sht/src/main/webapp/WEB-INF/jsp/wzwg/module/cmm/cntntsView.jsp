<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<link rel="stylesheet" href="/css/wzwg/cmm/jquery-ui.css">
<script src="/js/wzwg/cmm/jquery-ui.js"></script>

<link href="/css/wzwg/cmm/jquery.contextMenu.css" rel="stylesheet" type="text/css" />
<script src="/js/wzwg/cmm/jquery.contextMenu.js" type="text/javascript"></script>

<link rel="stylesheet" href="/design/module/sample/css/swiper.min.css" type="text/css">
<!-- <script src="/design/module/sample/js/swiper.jquery.min.js"></script> -->
<!-- <script src="/js/wzwg/cmm/swiper.jquery.min.js"></script> -->

<!-- <script src="/js/wzwg/site/editFunc.js" type="text/javascript"></script> -->

<%-- <c:import url="/WEB-INF/jsp/wzwg/webModule/wzwgContextMenu.jsp"></c:import> --%>

<link rel="stylesheet" href="/css/wzwg/cmm/layout.css" type="text/css" />
<link rel="stylesheet" href="/css/wzwg/cmm/empty_line.css" type="text/css" />
<link rel="stylesheet" href="/css/wzwg/module/cntnts/cntnts.css" type="text/css" />
<c:if test="${cntntsInfo.sysmoduleSeq eq 10000000240}"><%-- 컨텐츠에디터일경우 --%>
<link rel="stylesheet" href="/wizonEditor/css/wizonCntnts.css" type="text/css" />
<link rel="stylesheet" href="/js/wzwg/cmm/slick/slick.css" type="text/css">
<script src="/js/wzwg/cmm/slick/slick.js"></script>
</c:if>

<script src="/js/wzwg/screen/usrScreen.js"></script>
<c:set var="repCntntsNm">${fn:replace(cntntsInfo.cntntsNm, "'", "\\'")}</c:set>


<div id="cntntsCn"><c:out value="${cntntsData.cntntsCn}" escapeXml="false" /></div>
<c:if test="${not empty cntntsData.cntntsSeq}">
<div class="mt20">
	<c:choose>
		<c:when test="${not empty param.sitecntntsSeq }">
			<c:import url="${wzwg_contextPath}/usr/cntnts/cntPagadiEstbs/selectCntPagadiEstbsUsrAjax.do">
				<c:param name="cntntsSeq" value="${cntntsData.cntntsSeq }"/>
				<c:param name="frstRegistPnttm" value="${cntntsData.frstRegistPnttm }" />
			</c:import>
		</c:when>
		<c:otherwise>
			<c:import url="${wzwg_contextPath}/usr/cntnts/cntPagadiEstbs/selectCntPagadiEstbsUsrAjax.do">
				<c:param name="cntntsSeq" value="${cntntsData.cntntsSeq }"/>
				<c:param name="frstRegistPnttm" value="${cntntsData.frstRegistPnttm }" />
				<c:param name="sitecntntsSeq" value="${cntntsInfo.sitecntntsSeq }" />
			</c:import>
		</c:otherwise>
	</c:choose>
</div>
</c:if>


<c:if test="${paramVO.mngrAt ne 'Y'}">
	<script>
	try{document.title = $('#menuPath').val().replace(/>/gi,'-').slice(0,-1);}catch(e){console.log(e.message);}
		$(document).ready(function(){
		
			// 게시물 공유 버튼
			$('#cnrs_btn').click(function(){
				$.ajax({
			        type:'POST'
			      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/cmm/snsCnrs/selectSnsCnrsPopup.do'
			      , cache : false
			      , async : false
			      , data:'param_menuSeq=<c:out value="${cntntsInfo.menuSeq}"/>&param_nttSj=<c:out value="${repCntntsNm}"/>&param_mobileAt=<c:out value="${mobileAt}"/>'
			      , success:function (data) {
			    	  var title = '<spring:message code="wzwg.cmm.word.cnrs" />';
			    	  wzAjaxModal('popup_la', title, data, true);
			      }
			      , error:function (request, status, error) {
			    	  alert('<spring:message code="fail.common.msg" text="error" />');
			      }
			      , dataType: 'html'
			 	});
			});
		
			// 인쇄 버튼
			$('#print_btn').click(function(){
				var printWindow = window.open("", "_blank");
				var printContents = $('#cntntsCn').html();
				
				printWindow.document.write('<head>');
				printWindow.document.write($('head').html());
				printWindow.document.write('</head>');
				
				printWindow.document.write('<div>');
				printWindow.document.write(printContents);
				printWindow.document.write('</div>');
				
				printWindow.print();
				printWindow.document.close();
			});
			
		});
		
		if('<c:out value="${cntntsInfo.sysmoduleSeq eq 10000000240}"/>' == 'true'){			
			wzwgSwiperAll();
		}
		
	</script>
	
	<c:if test="${!empty loginVO}">
		<p class="fr">
			<%-- <a href="javascript:void(0);" id="print_btn"><img src="/images/wzwg/cmm/ico-print.png" title='<spring:message code="wzwg.cmm.word.prntng" />' alt='<spring:message code="wzwg.cmm.word.prntng" />'></a> --%>
			<a href="javascript:void(0);" id="cnrs_btn"><img src="/images/wzwg/cmm/cnrs_btn.png" alt='<spring:message code="wzwg.cmm.word.cnrs" />'></a>
		</p>
	</c:if>
	
</c:if>