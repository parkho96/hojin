<%@page import="egovframework.com.cmm.service.Globals"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<%-- <c:if test="${mngrAt eq 'N'}"> --%>
	<link type="text/css" href="/css/wzwg/module/ntt/unityBoard.css" rel="stylesheet">
	<link type="text/css" href="/css/wzwg/site/mngr/form.css" rel="stylesheet" />
<%-- </c:if> --%>

<link href="/css/wzwg/cmm/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>

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
		
        $('#bbsSel').select2();
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
			pageUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/custom/selectUnityBbsBassInfoAjax.do';
		}
		
		if(val == 'dataManage'){			
			if("<c:out value='${param.pmode}'/>" == "detail") {
				document.getElementById('nttSeq').value = "<c:out value='${param.nttSeq}'/>";
				pageUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/selectNttDetailAjax.do';
			} else {
				if('<c:out value="${mngrAt}"/>' =='N'){
					if('<c:out value="${funcVO.usrScrinTy}"/>'=='W'){
						pageUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/registNttFormAjax.do';
					}else{
						pageUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/selectNttListAjax.do';
					}
				}else{
				pageUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/selectNttListAjax.do';
				}
			}
		}
		
		if(val == 'author'){
		    //document.getElementById('sitecntntsSeq').value = $.urlParam('sitecntntsSeq');
            pageUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/cntnts/cntntsAuth/selectCntntsAuthListAjax.do';
		}
		
		if(val == 'charger'){
            //document.getElementById('sitecntntsSeq').value = $.urlParam('sitecntntsSeq');
            pageUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/cntnts/cntntsCharger/selectCntntsChargerAjax.do';
		}
		
		if(val == 'dataRecycle'){
			pageUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/selectNttRecycleListAjax.do';
		}		
		
		if(val == 'fileEstbs'){
			pageUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/upload/fileEstbs/selectFileEstbsInfoFormAjax.do';
		}		
		
        if(val == 'cntPagadiEstbs'){
            pageUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/cntnts/cntPagadiEstbs/selectCntPagadiEstbsAjax.do';
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
   	<c:set var="pageadiAt" value="<%=Globals.CNTNTS_PAGEADI_USEAT %>"/>
 
    <c:set var="pageIndex" value="1" />
    <c:if test="${!empty paramVO.pageIndex}">
    <c:set var="pageIndex" value="${paramVO.pageIndex}" />
    </c:if>
    
 	<form name="bbsFrm" id="bbsFrm" method="post" onsubmit="return false;">
		<input type="hidden" name="siteSeq" 		 id="siteSeq" 		  value="<c:out value='${paramVO.siteSeq }'/>"/>
        <input type="hidden" name="bbsSeq"  		 id="bbsSeq"  		  value="<c:out value='${paramVO.bbsSeq }'/>"/>
		<input type="hidden" name="pageIndex" 		 id="pageIndex" 		  value="<c:out value='${pageIndex}'/>"/>
		<input type="hidden" name="searchCondition"  id="searchCondition"   value="<c:out value='${paramVO.searchCondition }'/>"/>
		<input type="hidden" name="searchKeyword" 	 id="searchKeyword" 	  value="<c:out value='${paramVO.searchKeyword }'/>"/>
		<input type="hidden" name="menuSeq" 		 id="menuSeq" 		  value="<c:out value='${paramVO.menuSeq }'/>"/>
        <input type="hidden" name="sitecntntsSeq" 	 id="sitecntntsSeq" 	  value="<c:out value='${paramVO.sitecntntsSeq }'/>"/>
        
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
		    <div class="step wztab underLine theme-blue adminIcon">
		    	<ul class="tapMenu wztab-list"> 
					<li class="wztab-item"><span class="ico-info"></span><a href="javascript:void(0);" onclick="fnTabLink('bassInfo');" 		title="<spring:message code="wzwg.cmm.menu.bassinfo" />" 		id="bassInfo" 		name="bbsTab"><spring:message code="wzwg.cmm.menu.bassinfo" /></a></li>
					<c:if test="${sessionScope.SYSMNGR_AT ne 'Y' and pageadiAt eq 'Y'}">
					<li class="wztab-item"><span class="ico-info"></span><a href="javascript:void(0);" onclick="fnTabLink('cntPagadiEstbs');" title="<spring:message code="wzwg.module.word.addestbs" />" 	id="cntPagadiEstbs" 	name="bbsTab"><spring:message code="wzwg.module.word.addestbs" /></a></li>
					</c:if>
					<c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
					<li class="wztab-item"><span class="ico-data"></span><a href="javascript:void(0);" onclick="fnTabLink('dataManage');" 	title="<spring:message code="wzwg.cmm.menu.datamanage" />" 		id="dataManage" 	name="bbsTab"><spring:message code="wzwg.cmm.menu.datamanage" /></a></li>
					</c:if>
					<li class="wztab-item"><span class="ico-auth"></span><a href="javascript:void(0);" onclick="fnTabLink('author');" 		title="<spring:message code="wzwg.cmm.menu.author" />" 			id="author" 		name="bbsTab"><spring:message code="wzwg.cmm.menu.author" /></a></li>
					<c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
					<li class="wztab-item"><span class="ico-manager"></span><a href="javascript:void(0);" onclick="fnTabLink('charger');" 		title="<spring:message code="wzwg.cmm.menu.charger" />" 		id="charger" 		name="bbsTab"><spring:message code="wzwg.cmm.menu.charger" /></a></li>
					<li class="wztab-item"><span class="ico-trash"></span><a href="javascript:void(0);" onclick="fnTabLink('dataRecycle');" 	title="<spring:message code="wzwg.cmm.menu.dataRecycle" />" 	id="dataRecycle" 	name="bbsTab"><spring:message code="wzwg.cmm.menu.dataRecycle" /></a></li>
					<li class="wztab-item"><span class="ico-file"></span><a href="javascript:void(0);" onclick="fnTabLink('fileEstbs');" 	title="<spring:message code="wzwg.cmm.menu.atchfilemanage" />" 	id="fileEstbs" 		name="bbsTab"><spring:message code="wzwg.cmm.menu.atchfilemanage" /></a></li>
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
    		
    </form>
    