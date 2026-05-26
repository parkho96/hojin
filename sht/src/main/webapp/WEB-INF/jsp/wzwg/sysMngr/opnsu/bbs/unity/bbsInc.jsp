<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">

	$(document).ready(function(){

		// 관리자화면
		<c:if test="${sysMngrAt eq 'Y'}">
		fnTabLink('dataManage');
		</c:if>
		
		// 사용자화면
		<c:if test="${sysMngrAt eq 'N'}">
		fnTabLink('dataManage');
		</c:if>
		
	});

	function fnBbsChage(val){
		var frm = document.bbsFrm;
		var arrVal = val.split("|");
		frm.bbsSeq.value = arrVal[0];
		frm.sitecntntsSeq.value = arrVal[1];

		fnTabLink($('#tabTyCode').val());
	}
	
	function fnTabLink(val){
		
		var pageUrl = "";

		if(val == 'bassInfo'){
			pageUrl = '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/bbs/unity/selectUnityBbsBassInfoAjax.do';
		}
		
		if(val == 'dataManage'){			
			pageUrl = '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/unity/selectNttListAjax.do';
		}
		
		if(document.getElementById('pmode').value == "detail") {
			document.getElementById('pmode').value = "";
			document.getElementById('nttSeq').value = "<c:out value="${param.nttSeq}" />";
			pageUrl = '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/unity/selectNttDetailAjax.do';
			val = 'dataManage';
		}	
		
		if(document.getElementById('pmode').value == "list") {
			document.getElementById('pmode').value = "";
			pageUrl = '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/unity/selectNttListAjax.do';
			val = 'dataManage';
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
	      , data:$("#bbsFrm").serialize()
	      , success:function (data) {
	    	  $('#bbs_area').html(data);
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
 
 	<form:form modelAttribute="paramVO" path="bbsFrm" name="bbsFrm" id="bbsFrm" method="post" onsubmit="return false;">
		<form:hidden path="siteSeq" />
        <form:hidden path="bbsSeq" />
		<form:hidden path="pageIndex" />
		<form:hidden path="searchCondition" />
		<form:hidden path="searchKeyword" />
		<form:hidden path="menuSeq" />
		<input type="hidden" id="nttSeq" name="nttSeq" />
        <form:hidden path="sitecntntsSeq" />
    	<input type="hidden" id="tabTyCode" name="tabTyCode" />
    	<input type="hidden" id="sysMngrAt" name="sysMngrAt" value="<c:out value="${sysMngrAt}" />" />
    	<input type="hidden" id="pmode" name="pmode" value="<c:out value="${param.pmode}" />" />
    	
	    <!-- 레이어팝업 영역 Start -->
		<div id="bbs_layer" class="pop-box"></div>
		<!-- 레이어팝업 영역 End -->

		<!-- 관리자 영역 Start -->
		<c:if test="${sysMngrAt eq 'Y'}">
    	<!-- 관리자 탭 -->
	    <div class="step wztab underLine theme-blue">
	    	<ul class="tapMenu">		
				<li><a href="javascript:void(0);" onclick="fnTabLink('dataManage');" 	title="<spring:message code="wzwg.sysMngr.word.dataMng" />" 	id="dataManage" name="bbsTab"><spring:message code="wzwg.sysMngr.word.dataMng" /></a></li>
				<li><a href="javascript:void(0);" onclick="fnTabLink('bassInfo');" 		title="<spring:message code="wzwg.sysMngr.word.ctgry02Mng" />" 	id="bassInfo" 	name="bbsTab"><spring:message code="wzwg.sysMngr.word.ctgry02Mng" /></a></li>
			</ul>
		</div>
		</c:if>
		<!-- 관리자 영역 End -->

		<!-- body -->	    
		<div id="bbs_area" class="w100"></div>
    		
    </form:form>
    