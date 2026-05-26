<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<link type="text/css" href="/css/wzwg/module/tabMenu/tabMenu.css" rel="stylesheet" />
 
<link href="/css/wzwg/cmm/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>
<script type="text/javascript" src="/js/wzwg/cmm/jquery.easing.1.3.js"> </script>

<script type="text/javascript" src="/js/wzwg/site/siteWizbuilder.js"> </script>

<!-- 셀렉트 검색 라이브러리 -->
<link href="/js/wzwg/cmm/select2/select2.css" rel="stylesheet" />
<script src="/js/wzwg/cmm/select2/select2.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
		
		/*
		$(document).bind('keydown',function(e){
			if(e.keyCode == 123){
				e.preventDefault();
				e.returnValue = false;
			}
		});
		
		$("body").attr({"oncontextmenu":"return false;", "onselectstart":"return false;", "ondragstart":"return false;"});
		*/
		// 관리자화면
		<c:if test="${mngrAt eq 'Y'}">
		fnClTabLink('bassInfo');
		</c:if>
		
		// 사용자화면
		<c:if test="${mngrAt eq 'N'}">
		fnClTabLink('dataManage');
		</c:if>
		
		$('#bbsSel').select2();
	});

	function fnBbsChage(val){
		var frm = document.clBbsFrm;
		var arrVal = val.split("|");
		frm.tabSeq.value = arrVal[0];
		frm.sitecntntsSeq.value = arrVal[1];

		fnClTabLink($('#tabTyCode').val());
	}
	
	function fnClTabLink(val){
		
		var pageUrl = "";
		
		if(val == 'bassInfo'){
			pageUrl = '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/tabMenu/selectTabMenuInfoAjax.do';
		}
		
		if(val == 'dataManage'){			
				pageUrl = '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/tabMenu/selectTabMenuDataListAjax.do';
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
	      , data:$("#clBbsFrm").serialize()
	      , success:function (data) {
	    	  $('#tabMenuArea').html(data);
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
 
 	<form:form modelAttribute="paramVO" path="clBbsFrm" name="clBbsFrm" id="clBbsFrm" method="post" onsubmit="return false;">
		<form:hidden path="siteSeq" />
        <form:hidden path="tabSeq" />
		<form:hidden path="pageIndex" />
		<form:hidden path="searchCondition" />
		<form:hidden path="searchKeyword" />
		<form:hidden path="menuSeq" />
		<!-- <input type="hidden" id="nttSeq" name="nttSeq" /> -->
        <form:hidden path="sitecntntsSeq" />
    	<input type="hidden" id="tabTyCode" name="tabTyCode" />
    	<input type="hidden" id="mngrAt" name="mngrAt" value="<c:out value="${mngrAt}" />" />
    	
	    <!-- 레이어팝업 영역 Start -->
		<div id="bbs_layer" class="pop-box"></div>
		<!-- 레이어팝업 영역 End -->
		
		<!-- 관리자 영역 Start -->
		<c:if test="${mngrAt eq 'Y'}">
		
			<!-- 게시판 목록 selecbox -->	    
	    	<select id="bbsSel" class="w20 mg_b30" onchange="fnBbsChage(this.value);">
				<c:forEach var="resultList" items="${tabMenuList}">
					
					<c:if test="${fn:indexOf(resultList.pckagePath, 'tabMenu') > -1}">
						<option value="<c:out value="${resultList.cntntsSeq}" />|<c:out value="${resultList.sitecntntsSeq}" />" <c:if test="${paramVO.tabSeq eq resultList.cntntsSeq}">selected="selected"</c:if>><c:out value="${resultList.cntntsNm}" /></option>
					</c:if>
					
				</c:forEach>
			</select>
	
	    	<!-- 관리자 탭 -->
		    <div class="step wztab underLine theme-blue adminIcon">
		    	<ul class="tapMenu wztab-list"> 
					<li class="wztab-item"><span class="ico-info"></span><a href="javascript:void(0);" onclick="fnClTabLink('bassInfo');" 		title="<spring:message code="wzwg.cmm.menu.bassinfo" />" 		id="bassInfo" 		name="bbsTab"><spring:message code="wzwg.cmm.menu.bassinfo" /></a></li>
					<c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
					<li class="wztab-item"><span class="ico-data"></span><a href="javascript:void(0);" onclick="fnClTabLink('dataManage');" 	title="<spring:message code="wzwg.cmm.menu.datamanage" />" 		id="dataManage" 	name="bbsTab"><spring:message code="wzwg.cmm.menu.datamanage" /></a></li>
					</c:if>
				</ul>
			</div>
	
		</c:if>
		<!-- 관리자 영역 End -->
		
		<div id="tabMenuArea"></div>
    		
    </form:form>
    