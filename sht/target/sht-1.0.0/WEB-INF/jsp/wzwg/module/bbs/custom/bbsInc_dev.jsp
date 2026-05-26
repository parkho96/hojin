<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<c:if test="${mngrAt eq 'N'}">
	<link type="text/css" href="/css/wzwg/module/ntt/unityBoard.css" rel="stylesheet">
	<link type="text/css" href="/css/wzwg/site/mngr/form.css" rel="stylesheet" />
</c:if>



<script type="text/javascript">

	$(document).ready(function(){
		
		// 관리자화면
		<c:if test="${mngrAt eq 'Y'}">
		fnTabLink('bassInfo');
		</c:if>
		
		// 사용자화면
		<c:if test="${mngrAt eq 'N'}">
		fnTabLink('dataManage');
		</c:if>
        
        var reqMode = '<c:out value="${param.mode}"/>';
        
        if (reqMode == 'ADD') {
            fnCallRegistForm();
        }
		
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
			pageUrl = '<c:out value="${prefix}"/>/module/bbs/custom/selectUnityBbsBassInfoAjax.do';
		}
		
		if(val == 'dataManage'){			
			if("<c:out value='${param.pmode}'/>" == "detail") {
				document.getElementById('nttSeq').value = "<c:out value='${param.nttSeq}'/>'";
				pageUrl = '<c:out value="${prefix}"/>/module/ntt/custom/selectNttDetailAjax.do';
			} else {
				pageUrl = '<c:out value="${prefix}"/>/module/ntt/custom/selectNttListAjax.do';
			}
		}
		
		if(val == 'author'){
		    //document.getElementById('sitecntntsSeq').value = $.urlParam('sitecntntsSeq');
            pageUrl = '<c:out value="${prefix}"/>/cntnts/cntntsAuth/selectCntntsAuthListAjax.do';
		}
		
		if(val == 'charger'){
            //document.getElementById('sitecntntsSeq').value = $.urlParam('sitecntntsSeq');
            pageUrl = '<c:out value="${prefix}"/>/cntnts/cntntsCharger/selectCntntsChargerAjax.do';
		}
		
		if(val == 'dataRecycle'){
			pageUrl = '<c:out value="${prefix}"/>/module/ntt/custom/selectNttRecycleListAjax.do';
		}		
		
		if(val == 'fileEstbs'){
			pageUrl = '<c:out value="${prefix}"/>/module/upload/fileEstbs/selectFileEstbsInfoFormAjax.do';
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
        <form:hidden path="sitecntntsSeq" />
        
		<input type="hidden" id="nttSeq" name="nttSeq" />
    	<input type="hidden" id="tabTyCode" name="tabTyCode" />
    	<input type="hidden" id="mngrAt" name="mngrAt" value="<c:out value='${mngrAt}'/>" />
    	
	    <!-- 레이어팝업 영역 Start -->
		<div id="bbs_layer" class="pop-box"></div>
		<!-- 레이어팝업 영역 End -->
		
		<!-- 관리자 영역 Start -->
		<c:if test="${mngrAt eq 'Y'}">
		
			<!-- 게시판 목록 selecbox -->	    
	    	<select id="bbsSel" class="w20 mg_b30" onchange="fnBbsChage(this.value);">
				<c:forEach var="resultList" items="${bbsList}">
					
					<c:if test="${fn:indexOf(resultList.pckagePath, 'custom') > -1}">
						<option value="<c:out value='${resultList.cntntsSeq}'/>|<c:out value='${resultList.sitecntntsSeq}'/>" <c:if test="${paramVO.bbsSeq eq resultList.cntntsSeq}">selected="selected"</c:if>><c:out value="${resultList.cntntsNm}"/></option>
					</c:if>
					
				</c:forEach>
			</select>
	
	    	<!-- 관리자 탭 -->
		    <div class="step">
		    	<ul class="tapMenu"> 
					<li><a href="javascript:void(0);" onclick="fnTabLink('bassInfo');" 		title="<spring:message code="wzwg.cmm.menu.bassinfo" />" 		id="bassInfo" 		name="bbsTab"><spring:message code="wzwg.cmm.menu.bassinfo" /></a></li>
					<c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
					<li><a href="javascript:void(0);" onclick="fnTabLink('dataManage');" 	title="<spring:message code="wzwg.cmm.menu.datamanage" />" 		id="dataManage" 	name="bbsTab"><spring:message code="wzwg.cmm.menu.datamanage" /></a></li>
					</c:if>
					<li><a href="javascript:void(0);" onclick="fnTabLink('author');" 		title="<spring:message code="wzwg.cmm.menu.author" />" 			id="author" 		name="bbsTab"><spring:message code="wzwg.cmm.menu.author" /></a></li>
					<c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
					<li><a href="javascript:void(0);" onclick="fnTabLink('charger');" 		title="<spring:message code="wzwg.cmm.menu.charger" />" 		id="charger" 		name="bbsTab"><spring:message code="wzwg.cmm.menu.charger" /></a></li>
					<li><a href="javascript:void(0);" onclick="fnTabLink('dataRecycle');" 	title="<spring:message code="wzwg.cmm.menu.dataRecycle" />" 	id="dataRecycle" 	name="bbsTab"><spring:message code="wzwg.cmm.menu.dataRecycle" /></a></li>
					<li><a href="javascript:void(0);" onclick="fnTabLink('fileEstbs');" 	title="<spring:message code="wzwg.cmm.menu.atchfilemanage" />" 	id="fileEstbs" 		name="bbsTab"><spring:message code="wzwg.cmm.menu.atchfilemanage" /></a></li>
					</c:if>
				</ul>
			</div>
	
		</c:if>
		<!-- 관리자 영역 End -->
		
		<c:choose>
			<c:when test="${mngrAt eq 'N'}">
				<div class="allbox">
					<div id="bbs_area"></div>
				</div>
			</c:when>
			<c:otherwise>
				<div id="bbs_area"></div>
			</c:otherwise>	
		</c:choose>

		<!-- body -->	    
		
		
		<c:if test="${mngrAt eq 'N'}">
			</div>
		</c:if>
    		
    </form:form>
    