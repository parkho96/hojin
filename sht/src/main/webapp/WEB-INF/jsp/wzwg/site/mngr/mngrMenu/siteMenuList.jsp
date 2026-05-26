<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script src="/jquery/js/jquery.nestable.js"></script>
<link rel="stylesheet" href="/css/wzwg/cmm/jquery.nestable.css" type="text/css" />

<!-- 셀렉트 검색 라이브러리 -->
<link href="/js/wzwg/cmm/select2/select2.css" rel="stylesheet" />
<script src="/js/wzwg/cmm/select2/select2.js"></script>

<script>
$(document).ready(function()
{
	
	fnListAjax();
});

//메뉴 정보를 조회
function fnRegistMenuAjax() {
	
	var siteId = document.getElementById("siteId").value;
	
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}"/>/sysMngr/siteMngr/menu/registSiteMngrMenuMngrFrmAjax.do'
		// , data:{'menuNo':menuNo,'menuTyCode':menuTyCode,'siteId':siteId} 
		 , success:function (data) {
			 	//$("#divLayerPopup").html(data);
	    	  	//$("#divLayerPopup").show();
					 // 부모코드 셋팅 
					// fnGetMenuList();
					 
				//	 document.getElementById("menuNm").focus();
			 			wzAjaxModal('popup_s', '<spring:message code="wzwg.site.menu.msg.MSG047" />', data);
				   }
		 , dataType: 'html'
	});
}

function fnSelectMenuAjax(menuSeq) {
	var siteId = document.getElementById("siteId").value;
	
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}"/>/sysMngr/siteMngr/menu/modifySiteMngrMenuMngrFrmAjax.do'
		 , data:{'mngrMenuSeq':menuSeq} 
		 , success:function (data) {
			 	//$("#divLayerPopup").html(data);
	    	  	//$("#divLayerPopup").show();
					 // 부모코드 셋팅 
					// fnGetMenuList();
				//	 document.getElementById("menuNm").focus();
			 			wzAjaxModal('popup_s', '<spring:message code="wzwg.site.menu.msg.MSG056" />', data);
				   }
		 , dataType: 'html'
	});
}

function fnListAjax(){
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}"/>/sysMngr/siteMngr/menu/selectSiteMngrMenuMngrListAjax.do'
		 , success:function (data) {
			 	$("#nestable1").html(data);
					 // 부모코드 셋팅 
					// fnGetMenuList();
					 
				//	 document.getElementById("menuNm").focus();
				   }
		 , dataType: 'html'
	});
} 

function fnLayerPopupClose() {
       //$("#divLayerPopup").hide();
       //$("#divLayerPopup").empty();
       //$('body').css({overflow:'auto'});
	   $('.wzpopup .close').click();

   }

function fnAllCelar(){
	var siteId = document.getElementById("siteId").value;
	
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}"/>/sysMngr/siteMngr/menu/registSiteMngrMenuMngrFrmAjax.do'
		// , data:{'menuNo':menuNo,'menuTyCode':menuTyCode,'siteId':siteId} 
		 , success:function (data) {
			 	//$("#divLayerPopup").html(data);
	    	  	//$("#divLayerPopup").show();
					 // 부모코드 셋팅 
					// fnGetMenuList();
					 
				//	 document.getElementById("menuNm").focus();
			 			//wzAjaxModal('popup_s', '<spring:message code="wzwg.site.menu.msg.MSG047" />', data);
			 			$('.wzpopup .pop-container').html(data);  
				   }
		 , dataType: 'html'
	});
}

function fnCntntsBassForm(paramModuleSeq){
	
	var moduleSeq = paramModuleSeq ;
	var mngrUrl = "";

	if(paramModuleSeq == "10000000211"){ // 온라인설문
		mngrUrl = "<c:out value="${wzwg_contextPath}"/>/sysMngr/siteMngr/module/onlineQustnr/selectOnlineQustnrInfoList.do";
	}else{
		alert('<spring:message code="wzwg.cmm.msg.MSG329" />');
		return ;
	}
	
	location.href = mngrUrl;
	
} 
</script>

<!-- 레이어팝업 영역 Start -->
<div id="divLayerPopup" class="pop-box"></div>
<!-- 레이어팝업 영역 End -->

	<div class="mngrMenu cntntsFrm">
		<h3 class="table_tit"><spring:message code="wzwg.site.menu.msg.MSG030" /></h3>
		<form name="menuForm" id="menuForm" method="post">
		<input type="hidden" name="siteId" id="siteId" value="<c:out value="${siteId}"/>" />
		<menu id="nestable-menu">
			<a data-action="expand-all" href="javascript:void(0);" class="wzbtn btn-basic btn-bottom"><spring:message code="wzwg.site.menu.msg.MSG031" /></a>
			<a data-action="collapse-all" href="javascript:void(0);" class="wzbtn btn-basic btn-top"><spring:message code="wzwg.site.menu.msg.MSG032" /></a>
			<!-- <a  href="javascript:void(0);" class="btn btn_default btn_xs" onclick="fnInsertMenuAllAjax();">정렬 저장</a> -->
			<a  href="javascript:void(0);" class="wzbtn btn-plus txt-l" onclick="fnRegistMenuAjax();"><img src="/images/wzwg/site/mngr/layout/menuadminLink.png" alt="" class="vert-m mr5"> <spring:message code="wzwg.cmm.word.cnctmenu" /></a>
		</menu>
		
	 	<div class="dd" id="nestable1"></div>
		</form>
	</div>
	
<div class="wz_notice brbox bg-white clnone fl">
	<h4 class="admpg-tit2"><spring:message code="wzwg.site.menu.msg.MSG048" /></h4>
	<ul class="wd100 mt20">
			  <li class="admpg-subp wd100">· <b><spring:message code="wzwg.cmm.msg.tip.MSG113" /></b></li>
			  <li class="admpg-subp wd100">· <b><spring:message code="wzwg.cmm.msg.tip.MSG114" /></b></li>
			  <li class="admpg-subp wd100">· <b>↕</b><spring:message code="wzwg.cmm.msg.tip.MSG007" /></li>
			  <li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG008" /></li>
		    
			  <li class="admpg-subp wd100 mt50"><strong class="fs17"><spring:message code="wzwg.site.menu.msg.MSG034" /></strong></li>
			  <li class="admpg-subp wd100 linehgt150 grey"><strong><spring:message code="wzwg.cmm.word.group" /></strong><br>
			        <p>- <spring:message code="wzwg.cmm.msg.tip.MSG009" /></p>
			        <p>- <spring:message code="wzwg.cmm.msg.tip.MSG010" /></p>
			        <p>- <spring:message code="wzwg.cmm.msg.tip.MSG011" /></p>
		    </li>
		    <li class="admpg-subp wd100 mt20 grey"><strong><spring:message code="wzwg.cmm.word.link" /></strong> <spring:message code="wzwg.cmm.msg.tip.MSG012" /></li>
		     
	  </ul>
</div>

	