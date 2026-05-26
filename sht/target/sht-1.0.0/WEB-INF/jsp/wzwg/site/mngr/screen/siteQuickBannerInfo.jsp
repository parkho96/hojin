<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 
<script>

function fnQuickIconUpload(){
	var formData = new FormData($('#uploadFrm')[0]);
		$.ajax({
		 url: '<c:out value="${wzwg_contextPath}"/>/mngr/screen/uploadSiteQuickBannerAjax.do',
		 processData: false,
		 contentType: false,
		 data: formData,
		 type: 'POST',
		 success: function(data){
				fnAddQuickBanner(data.paramVO.thumbUrl);
		 }
	
		});
	}
$(document).ready(function(){
	
	$(".btn").click(function(){
		$(".pop-box1").toggle()
	});

	$(".hide").click(function(){
		$(".pop-box1").hide();
		fnLayerPopupClose();
	});

	$(".reon").click(function(){
		$(".pop-box2").toggle();
		$(".pop-box1").hide();
		$(".pop-box3").hide();
	});

	$(".rcon").click(function(){
		$(".pop-box1").toggle();
		$(".pop-box2").hide();
		$(".pop-box3").hide();
	});

	$(".rcon1").click(function(){
		$(".pop-box3").toggle();
		$(".pop-box1").hide();
		$(".pop-box2").hide();
	});

	$(".rcon2").click(function(){
		$(".pop-box2").toggle();
		$(".pop-box1").hide();
		$(".pop-box3").hide();
	});

	$(".hid").click(function(){
		$(".pop-box2, .pop-box1, .pop-box3").hide();
		fnLayerPopupClose();
	});

});
</script>
<form name="frmPopup" id="frmPopup" method="post"> 
<input type="hidden"  name="templateSeq" id="templateSeq" /> 
</form> 
<div class="pop-box1">
			<div class="layer1" >				
				<div class="pop-id-sch">
					<span><spring:message code="wzwg.site.screen.msg.MSG013" /></span>
					<button class="close hid" type="button" onclick=""><img src="/images/wzwg/site/mngr/pop-close.png" alt="<spring:message code="wzwg.cmm.word.close" />" /></button>
				</div>
				<div class="pop-container">
							<div class="pop-conts">
								<!--content //-->
									<div class="main-menu-bar">
										<ul class="pop-tab">
											<li><a href="javascript:;" class="pop-on"><spring:message code="wzwg.site.screen.msg.MSG014" /></a></li>
											<li><a href="javascript:;" class="reon"><spring:message code="wzwg.site.screen.msg.MSG015" /></a></li>
											<li><a href="javascript:;" class="rcon1"><spring:message code="wzwg.site.screen.msg.MSG016" /></a></li>
										</ul>
									</div>
									<h4><spring:message code="wzwg.site.screen.msg.MSG014" /></h4>
									<div class="pop-main-con">
										<ul>
										<c:forEach items="${tempBannerList}" var="iconList" varStatus="status">
											<li><a href="javascript:;" onclick="fnAddQuickBanner('<c:out value="${tempBannerDirStr}"/>/<c:out value="${iconList}"/>')"><img src="<c:out value="${tempBannerDirStr}"/>/<c:out value="${iconList}"/>" alt="<spring:message code="wzwg.cmm.word.icon" />" /></a></li>
										</c:forEach>	 
										</ul>
									</div>
									<div class="ctr-box">
										<a href="javascript:;" class="hid btn-a" style="line-height:10px"><spring:message code="wzwg.cmm.word.close" /></a>
									</div><!--close btn //-->
							</div> <!-- pop-conts end -->
				</div> <!-- pop-container end -->
			</div> <!-- layer1 end -->
		</div> <!-- 레이어팝업 end -->

		<div class="pop-box2">
			<div class="layer1" >				
				<div class="pop-id-sch">
					<span><spring:message code="wzwg.site.screen.msg.MSG013" /></span>
					<button class="close hid" type="button" onclick=""><img src="/images/wzwg/site/mngr/pop-close.png" alt="<spring:message code="wzwg.cmm.word.close" />" /></button>
				</div>
				<div class="pop-container">
							<div class="pop-conts">
								<!--content //-->
									<div class="main-menu-bar">
										<ul class="pop-tab">
											<li><a href="javascript:;" class="rcon"><spring:message code="wzwg.site.screen.msg.MSG014" /></a></li>
											<li><a href="javascript:;" class="pop-on"><spring:message code="wzwg.site.screen.msg.MSG015" /></a></li>
											<li><a href="javascript:;" class="rcon1"><spring:message code="wzwg.site.screen.msg.MSG016" /></a></li>
										</ul>
									</div>
										<h4><spring:message code="wzwg.site.screen.msg.MSG015" /></h4>
										<div class="pop-main-con">
											<ul>
												<c:forEach items="${commBannerList}" var="iconList" varStatus="status">
													<li><a href="javascript:;"  onclick="fnAddQuickBanner('<c:out value="${commBannerDirStr}"/>/<c:out value="${iconList}"/>')"><img src="<c:out value="${commBannerDirStr}"/>/<c:out value="${iconList}"/>" alt="<spring:message code="wzwg.cmm.word.icon" />" style="width:  58px;height: 47px;"/></a></li>
												</c:forEach>	 
											</ul>
										</div>
									<div class="ctr-box">
										<a href="javascript:;" class="hid btn-a" style="line-height:10px"><spring:message code="wzwg.cmm.word.close" /></a>
									</div><!--close btn //-->
							</div> <!-- pop-conts end -->
				</div> <!-- pop-container end -->
			</div> <!-- layer1 end -->
		</div> <!-- 레이어팝업 end -->

		<div class="pop-box3">
			<div class="layer1" >				
				<div class="pop-id-sch">
					<span><spring:message code="wzwg.site.screen.msg.MSG013" /></span>
					<button class="close hid" type="button" onclick=""><img src="/images/wzwg/site/mngr/pop-close.png" alt="<spring:message code="wzwg.cmm.word.close" />" /></button>
				</div>
				<div class="pop-container">
							<div class="pop-conts">
								<!--content //-->
									<div class="main-menu-bar">
										<ul class="pop-tab">
											<li><a href="javascript:;" class="rcon"><spring:message code="wzwg.site.screen.msg.MSG014" /></a></li>
											<li><a href="javascript:;" class="rcon2"><spring:message code="wzwg.site.screen.msg.MSG015" /></a></li>
											<li><a href="javascript:;" class="pop-on"><spring:message code="wzwg.site.screen.msg.MSG016" /></a></li>
										</ul>
									</div>
									<div class="pop-main-reon">
										<form name="uploadFrm" id="uploadFrm" method="post" enctype="multipart/form-data">
									<input type="hidden" name="cmntSeq" id="cmntSeq" value="<c:out value="${result.cmntSeq}"/>"/>
									<div class="pop-main-reon">
										<input type="file" name="file1" id="file1" style="float:left;margin:0 20px;width:70%"/><a href="javascript:;" onclick="fnQuickIconUpload()" class="btn-a" style="line-height:10px;float:left"><spring:message code="wzwg.cmm.word.direct" /> <spring:message code="wzwg.cmm.word.regist" /></a>
									</div>
									</form>
									</div>
									<div class="ctr-box">
										<a href="javascript:;" class="hid btn-a" style="line-height:10px"><spring:message code="wzwg.cmm.word.close" /></a>
									</div><!--close btn //-->
							</div> <!-- pop-conts end -->
				</div> <!-- pop-container end -->
			</div> <!-- layer1 end -->
		</div> <!-- 레이어팝업 end -->