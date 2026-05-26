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
		 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/menu/registSiteMenuMngrFrmAjax.do'
		// , data:{'menuNo':menuNo,'menuTyCode':menuTyCode,'siteId':siteId} 
		 , success:function (data) {
			 	//$("#divLayerPopup").html(data);
	    	  	//$("#divLayerPopup").show();
					 // 부모코드 셋팅 
					// fnGetMenuList();
					 
				//	 document.getElementById("menuNm").focus();
			 			wzAjaxModal('popup_s', '<spring:message code="wzwg.site.menu.msg.MSG028" />', data);
				   }
		 , dataType: 'html'
	});
}

function fnSelectMenuAjax(menuSeq) {
	var siteId = document.getElementById("siteId").value;
	
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/menu/modifySiteMenuMngrFrmAjax.do'
		 , data:{'menuSeq':menuSeq} 
		 , success:function (data) {
			 	//$("#divLayerPopup").html(data);
	    	  	//$("#divLayerPopup").show();
					 // 부모코드 셋팅 
					// fnGetMenuList();
				//	 document.getElementById("menuNm").focus();
			 			wzAjaxModal('popup_s', '<spring:message code="wzwg.site.menu.msg.MSG029" />', data);
				   }
		 , dataType: 'html'
	});
}

function fnListAjax(){
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/menu/selectSiteMenuMngrListAjax.do'
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
		 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/menu/registSiteMenuMngrFrmAjax.do'
		// , data:{'menuNo':menuNo,'menuTyCode':menuTyCode,'siteId':siteId} 
		 , success:function (data) {
			 	//$("#divLayerPopup").html(data);
	    	  	//$("#divLayerPopup").show();
					 // 부모코드 셋팅 
					// fnGetMenuList();
					 
				//	 document.getElementById("menuNm").focus();
			 			//wzAjaxModal('popup_s', '<spring:message code="wzwg.site.menu.msg.MSG028" />', data);
			 			$('.wzpopup .pop-container').html(data);  
				   }
		 , dataType: 'html'
	});
}

function fnCntntsBassForm(paramModuleSeq){
	
	var moduleSeq = paramModuleSeq ;
	var mngrUrl = "";

	if(paramModuleSeq == "10000000211"){ // 온라인설문
		mngrUrl = "<c:out value="${wzwg_contextPath}"/>/mngr/module/onlineQustnr/selectOnlineQustnrInfoList.do";
	}else{
		alert('<spring:message code="wzwg.cmm.msg.MSG329" />');
		return ;
	}
	
	location.href = mngrUrl;
	
}

function fnSelectModuleFilter(chkbox){
	if($(chkbox).is(':checked')){
		//$('#sitecntntsSeq').find('option[data-menuat="Y"]').css('display', 'none');
		//<option value="10000002556" data-menuat="Y" class="bg-grey" style="">일반게시판</option>
		$('#sitecntntsSeq').find('option[data-menuat="Y"]').each(function(){
			var value = $(this).attr('value');
			var menuat = $(this).attr('data-menuat');
			var cls = $(this).attr('class');
			var cntnts = $(this).html();
			
			var optNon = '<option_none value="' + value + '" data-menuat="' + menuat + '" class="' + cls + '" style="">' + cntnts + '</option_none>'
			$('#sitecntntsSeq').append(optNon);
			$(this).remove();
		});
		//console.log('option remove');
		$('#sitecntntsSeq').select2('destroy');
		$('#sitecntntsSeq').select2();
	}else{
		//$('#sitecntntsSeq').find('option').css('display', '');
		$('#sitecntntsSeq').find('option_none').each(function(){
			var value = $(this).attr('value');
			var menuat = $(this).attr('data-menuat');
			var cls = $(this).attr('class');
			var cntnts = $(this).html();
			
			var opt = '<option value="' + value + '" data-menuat="' + menuat + '" class="' + cls + '" style="">' + cntnts + '</option>'
			$('#sitecntntsSeq').append(opt);
			$(this).remove();
		});
		//console.log('option append');
		$('#sitecntntsSeq').select2('destroy');
		$('#sitecntntsSeq').select2();
	}
	//console.log(chkbox);
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
	<p class="admpg-subp w100 fl mb15">
	  <span class="circle_no bg-red-strong vert-m mr5">?</span><bclass="fs17"><spring:message code="wzwg.cmm.mngr.guid.MSG0050" /></b>
	</p>
	<ul class="wd100 mb50 fs17 bg-lightgrey p20 box-border brsolid brwd1 br-red fl">
		<li>· <b><spring:message code="wzwg.site.dashboard.msg.MSG011" /></b> : <spring:message code="wzwg.cmm.mngr.guid.MSG005" /></li>
		<li>· <b><spring:message code="wzwg.cmm.word.menu" /></b> : <spring:message code="wzwg.cmm.mngr.guid.MSG006" /></li>
		<li class="mt15 red pl15"><b><spring:message code="wzwg.cmm.mngr.guid.MSG007" /></b></li>
	</ul>
	
	
	<h4 class="admpg-tit2"><spring:message code="wzwg.site.menu.msg.MSG033" /></h4>
	<div class="wd100 box-border pl10">
		<ul class="wd100 mt20">
				  <li class="admpg-subp wd100">· <b><spring:message code="wzwg.cmm.msg.tip.MSG006" /></b></li>
				  <li class="admpg-subp wd100">· <b>↕</b><spring:message code="wzwg.cmm.msg.tip.MSG007" /></li>
				  <li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG008" /></li>
			    
				  <li class="admpg-subp wd100 mt50"><strong class="fs17"><spring:message code="wzwg.site.menu.msg.MSG034" /></strong></li>
				  <li class="admpg-subp wd100 linehgt150 grey"><strong><spring:message code="wzwg.cmm.word.group" /></strong><br>
				        <p>- <spring:message code="wzwg.cmm.msg.tip.MSG009" /></p>
				        <p>- <spring:message code="wzwg.cmm.msg.tip.MSG010" /></p>
				        <p>- <spring:message code="wzwg.cmm.msg.tip.MSG011" /></p>
			    </li>
			    <li class="admpg-subp wd100 mt20 grey"><strong><spring:message code="wzwg.cmm.word.link" /></strong> <spring:message code="wzwg.cmm.msg.tip.MSG012" /></li>
			    <li class="admpg-subp wd100 mt20 linehgt150 grey"><strong><spring:message code="wzwg.cmm.word.anchor" /></strong> <br>
			          <p>- <spring:message code="wzwg.cmm.msg.tip.MSG013" /></p>
			          <p>- <spring:message code="wzwg.cmm.msg.tip.MSG014" /></p></li>
			    <li class="admpg-subp wd100 mt20 linehgt150 grey"><strong><spring:message code="wzwg.cmm.msg.tip.MSG015" /></strong> <br>
			          <p>- <spring:message code="wzwg.cmm.msg.tip.MSG016" /></p>
			          <p>- <spring:message code="wzwg.cmm.msg.tip.MSG017" /></p>
			    </li>
		  </ul>
	  </div>
</div>

	