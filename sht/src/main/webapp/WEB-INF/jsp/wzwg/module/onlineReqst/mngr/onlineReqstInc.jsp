<%@page import="egovframework.com.cmm.service.Globals"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<!-- 셀렉트 검색 라이브러리 -->
<link href="/js/wzwg/cmm/select2/select2.css" rel="stylesheet" />
<script src="/js/wzwg/cmm/select2/select2.js"></script>

<script type="text/javascript">

	$(document).ready(function(){

		fnTabLink('bassInfo');

		$('#onlineReqstSel').select2();
	});
	
	function fnOnlineReqstChage(val){
		var frm = document.onlineReqstFrm;
		var arrVal = val.split("|");
		frm.reqstSeq.value = arrVal[0];
		frm.cntntsSeq.value = frm.reqstSeq.value;
		frm.sitecntntsSeq.value = arrVal[1];

		fnTabLink($('#tabTyCode').val());
	}
	
	function fnTabLink(val){

		var pageUrl = "";

		if(val == 'bassInfo'){
			pageUrl = '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineReqst/selectOnlineReqstInfoFormAjax.do';
		}
		
		if(val == 'dataManage'){			
			pageUrl = '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineReqst/selectOnlineReqstNttListAjax.do';
		}
		
		if(val == 'author'){
	        pageUrl = '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/cntnts/cntntsAuth/selectCntntsAuthListAjax.do';
		}
		
		if(val == 'charger'){
	        pageUrl = '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/cntnts/cntntsCharger/selectCntntsChargerAjax.do';
		}
		
		if(val == 'fileEstbs'){
			pageUrl = '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/fileEstbs/selectFileEstbsInfoFormAjax.do';
		}
		
        if(val == 'cntPagadiEstbs'){
            pageUrl = '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/cntnts/cntPagadiEstbs/selectCntPagadiEstbsAjax.do';
        }
		
		$('#tabTyCode').val(val);
		
		document.getElementById('searchCondition').value = '';
		document.getElementById('searchKeyword').value = '';
		document.getElementById('pageIndex').value = 1;

		$.ajax({
	        type:'POST'
	      , url:pageUrl
	      , cache : false
	      , async : false
	      , data:$("#onlineReqstFrm").serialize()
	      , success:function (data) {
	    	  $('#onlineReqst_area').html(data);
	          $(".step > .tapMenu > li > a").removeClass("on");
	          $("#"+val).addClass("on");
	          $("#content").css("height",$(document).height());
			  $(window).scrollTop(0);
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
			
	}

</script>
  	<c:set var="pageadiAt" value="<%=Globals.CNTNTS_PAGEADI_USEAT %>"/>
 
 	<form:form modelAttribute="paramVO" path="onlineReqstFrm" name="onlineReqstFrm" id="onlineReqstFrm" method="post" onsubmit="return false;">
		<form:hidden path="siteSeq" />
        <form:hidden path="reqstSeq" />
		<form:hidden path="pageIndex" />
		<form:hidden path="searchCondition" />
		<form:hidden path="searchKeyword" />
		<form:hidden path="menuSeq" />
		<input type="hidden" id="reqstnttSeq" name="reqstnttSeq" />
        <form:hidden path="sitecntntsSeq" />
        <form:hidden path="cntntsSeq" />
    	<input type="hidden" id="tabTyCode" name="tabTyCode" />
    	<input type="hidden" id="mngrAt" name="mngrAt" value="<c:out value="${mngrAt}" />" />
    	
	    <!-- 레이어팝업 영역 Start -->
		<div id="onlineReqst_layer" class="modal fade bs-example-modal-sm in" tabindex="-1" role="dialog" aria-hidden="false"></div>
		<!-- 레이어팝업 영역 End -->
		
		<!-- 관리자 영역 Start -->
		<c:if test="${sessionScope.SYSMNGR_AT eq 'Y' or mngrAt eq 'Y'}">
		
			<!-- 온라인신청 목록 selecbox -->	    
	    	<select id="onlineReqstSel" class="w20 mg_b30" onchange="fnOnlineReqstChage(this.value);">
				<c:forEach var="resultList" items="${onlineReqstInfoList}">
					<option value="<c:out value="${resultList.cntntsSeq}" />|<c:out value="${resultList.sitecntntsSeq}" />" <c:if test="${paramVO.reqstSeq eq resultList.cntntsSeq}">selected="selected"</c:if>><c:out value="${resultList.cntntsNm}" /></option>
				</c:forEach>
			</select>
	
	    	<!-- 관리자 탭 -->
		    <div class="step wztab underLine theme-blue adminIcon">
		    	<ul class="tapMenu wztab-list">
					<li class="wztab-item"><span class="ico-info"></span><a href="javascript:void(0);" onclick="fnTabLink('bassInfo');" 		title="<spring:message code="wzwg.cmm.menu.bassinfo" />" 		id="bassInfo" 			name="onlineReqstTab"><spring:message code="wzwg.cmm.menu.bassinfo" /></a></li>
					<c:if test="${sessionScope.SYSMNGR_AT ne 'Y' and pageadiAt eq 'Y'}">
					<li class="wztab-item"><span class="ico-info"></span><a href="javascript:void(0);" onclick="fnTabLink('cntPagadiEstbs');" 	title="<spring:message code="wzwg.module.word.addestbs" />" 	id="cntPagadiEstbs" 	name="bbsTab"><spring:message code="wzwg.module.word.addestbs" /></a></li>
					</c:if>
					<c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
					<li class="wztab-item"><span class="ico-data"></span><a href="javascript:void(0);" onclick="fnTabLink('dataManage');" 		title="<spring:message code="wzwg.cmm.menu.datamanage" />" 		id="dataManage"			name="onlineReqstTab"><spring:message code="wzwg.cmm.menu.datamanage" /></a></li>
					</c:if>
					<li class="wztab-item"><span class="ico-auth"></span><a href="javascript:void(0);" onclick="fnTabLink('author');" 			title="<spring:message code="wzwg.cmm.word.author" />" 			id="author" 			name="onlineReqstTab"><spring:message code="wzwg.cmm.word.author" /></a></li>				 
				</ul>
			</div>
			
		</c:if>
		<!-- 관리자 영역 End -->
		
		<!-- body -->	    
		<div id="onlineReqst_area"></div>
    		
	</form:form>




	   
	   			

	
