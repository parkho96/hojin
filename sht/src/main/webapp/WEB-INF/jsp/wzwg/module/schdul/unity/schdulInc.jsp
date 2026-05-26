<%@page import="egovframework.com.cmm.service.Globals"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<link href="/css/wzwg/cmm/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="/js/wzwg/site/jqueryDatepickerWaAction.js"></script>
<script language="javascript" type="text/javascript" src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>

<!-- 셀렉트 검색 라이브러리 -->
<link href="/js/wzwg/cmm/select2/select2.css" rel="stylesheet" />
<script src="/js/wzwg/cmm/select2/select2.js"></script>

<script type="text/javascript">

	$(document).ready(function(){

		fnTabLink('bassInfo');
		
		$('#schdulSel').select2();
	});

	function fnschdulChage(val){
		var frm = document.schdulFrm;
		var arrVal = val.split("|");
		frm.schdulSeq.value = arrVal[0];
		frm.sitecntntsSeq.value = arrVal[1];
		frm.cntntsSeq.value = arrVal[0];
		
		fnTabLink($('#tabTyCode').val());
	}
		
	
	function fnTabLink(val){
		
		var pageUrl = "";
		
		if(val == 'bassInfo'){
			pageUrl = '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/schdul/selectSchdulBassInfoAjax.do';
		}
		
		if(val == 'dataManage'){
			pageUrl = '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/ntt/schdul/selectSchdulNttInitAjax.do';
		}
		
		if(val == 'author'){
		    //document.getElementById('sitecntntsSeq').value = $.urlParam('sitecntntsSeq');
            pageUrl = '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/cntnts/cntntsAuth/selectCntntsAuthListAjax.do';
		}
		
		if(val == 'charger'){
           // document.getElementById('sitecntntsSeq').value = $.urlParam('sitecntntsSeq');
            pageUrl = '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/cntnts/cntntsCharger/selectCntntsChargerAjax.do';
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
	      , data:$("#schdulFrm").serialize()
	      , success:function (data) {
	    	  $('#schdul_area').empty();
	    	  $('#schdul_area').html(data);
	          $(".step > .tapMenu > li > a").removeClass("on");
	          $("#"+val).addClass("on");
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
	
</script>
 	<c:set var="pageadiAt" value="<%=Globals.CNTNTS_PAGEADI_USEAT %>"/>
 
 	<form:form modelAttribute="paramVO" path="schdulFrm" name="schdulFrm" id="schdulFrm" method="post" onsubmit="return false;">
		<form:hidden path="siteSeq" />
        <form:hidden path="schdulSeq" />
		<form:hidden path="pageIndex" />
		<form:hidden path="searchCondition" />
		<form:hidden path="searchKeyword" />
		<input type="hidden" name="sitecntntsSeq" id="sitecntntsSeq" value="<c:out value="${paramVO.sitecntntsSeq}" />" />
    	<input type="hidden" id="tabTyCode" name="tabTyCode" />
    	
    	<!-- 추가설정 cntseq -->
		<input type="hidden" name="cntntsSeq" id="cntntsSeq" value="<c:out value="${paramVO.schdulSeq}" />"/>
    	
	    <!-- 레이어팝업 영역 Start -->
		<div id="schdul_layer" class="modal fade bs-example-modal-sm in" tabindex="-1" role="dialog" aria-hidden="false"></div>
		<!-- 레이어팝업 영역 End -->
		
		<!-- 게시판 목록 selecbox -->	    
    	<select id="schdulSel" class="w20" onchange="fnschdulChage(this.value);">
			<c:forEach var="resultList" items="${schdulList}">
					<option value="<c:out value="${resultList.cntntsSeq}" />|<c:out value="${resultList.sitecntntsSeq}" />" <c:if test="${paramVO.schdulSeq eq resultList.cntntsSeq}">selected="selected"</c:if>><c:out value="${resultList.cntntsNm}" /></option>
			</c:forEach>
		</select>
    
    	<!-- 관리자 탭 -->
	    <div class="step wztab underLine theme-blue adminIcon">
	    	<ul class="tapMenu wztab-list">
				<li class="wztab-item"><span class="ico-info"></span><a href="javascript:void(0);" onclick="fnTabLink('bassInfo');" 		title="<spring:message code="wzwg.cmm.menu.bassinfo" />" 	id="bassInfo" 	name="schdulTab"><spring:message code="wzwg.cmm.menu.bassinfo" /></a></li>
				<c:if test="${sessionScope.SYSMNGR_AT ne 'Y' and pageadiAt eq 'Y'}">
				<li class="wztab-item"><span class="ico-info"></span><a href="javascript:void(0);" onclick="fnTabLink('cntPagadiEstbs');" title="<spring:message code="wzwg.module.word.addestbs" />" 	id="cntPagadiEstbs" 	name="bbsTab"><spring:message code="wzwg.module.word.addestbs" /></a></li>
				</c:if>
				<c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
				<li class="wztab-item"><span class="ico-data"></span><a href="javascript:void(0);" onclick="fnTabLink('dataManage');" 	title="<spring:message code="wzwg.cmm.menu.datamanage" />" 	id="dataManage" name="schdulTab"><spring:message code="wzwg.cmm.menu.datamanage" /></a></li>
				</c:if>
				<li class="wztab-item"><span class="ico-auth"></span><a href="javascript:void(0);" onclick="fnTabLink('author');" 		title="<spring:message code="wzwg.cmm.menu.author" />" 		id="author" 	name="schdulTab"><spring:message code="wzwg.cmm.menu.author" /></a></li>
			</ul>
		</div>

		<!-- body -->	    
		<div id="schdul_area" class="w100"></div>
    		
    </form:form>
    