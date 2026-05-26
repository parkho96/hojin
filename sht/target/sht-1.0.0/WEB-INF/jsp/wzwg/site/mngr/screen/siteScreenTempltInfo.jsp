<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 
<script>
function fn_siteTempltChange(templateSeq){
	if(confirm('<spring:message code="wzwg.cmm.msg.MSG278" />')){
		document.frmPopup.templateSeq.value=templateSeq;
		document.frmPopup.action  ="<c:out value="${wzwg_contextPath}"/>/mngr/screen/changeSiteScreenTemplt.do";
		document.frmPopup.method="post";
		document.frmPopup.submit();
	}
}

function fn_siteTempTemplt(templateSeq){
	if(confirm('<spring:message code="wzwg.cmm.msg.MSG279" />')){
	document.frmPopup.templateSeq.value=templateSeq;
	document.frmPopup.action  ="<c:out value="${wzwg_contextPath}"/>/mngr/screen/selectSiteScreenTempIndexMngr.do"; 
//	document.frmPopup.action  ="/mngr/screen/selectSiteScreenFrameMngr.do";
	document.frmPopup.method="post";
	document.frmPopup.target="_blank";
	document.frmPopup.submit();
	}
}

function fnLoadTemplatInit(templateSeq){ 
	if(confirm('<spring:message code="wzwg.cmm.msg.MSG280" />')){
	document.frmPopup.templateSeq.value=templateSeq;
	document.frmPopup.action="<c:out value="${wzwg_contextPath}"/>/mngr/screen/selectSiteScreenTemplateInitMngr.do";
	document.frmPopup.method="post";
	document.frmPopup.target="_blank";
	document.frmPopup.submit();
	}
}

function fnImgPrevewPop(img){
	var viewImg = new Image();
	$(viewImg).attr('src', $(img).attr('data-filePath'));
	var imgsrc = $(img).attr('data-filePath');
	//var imgsrc = $(img).attr('src');

	
//	var width = $(img)[0].naturalWidth;
//	var height = $(img)[0].naturalHeight;
	var width = $(viewImg)[0].naturalWidth;
	var height = $(viewImg)[0].naturalHeight;
	var frm = document.frmPopup;
	frm.imgSrc.value = imgsrc;
	
	
	var frmResult = window.open("", "popForm", "width=" + width + ",height=" + height + ",toolbars=no,menubars=no,scrollbars=yes,left=50,top=400");
	
	frm.target='popForm';
	frm.action='/sample/img/imgViewer.jsp';
	frm.submit();
}

$(document).ready(function(){
	$('.main-design-edit-popup').draggable({ handle: ".pop-id-sch" });
	$(".pop-id-sch").css('cursor', 'move');
})
</script>





			<!-- 여기부터 팝업안 컨텐츠 내용입니당. -->
			<form name="frmPopup" id="frmPopup" method="post"> 
				<input type="hidden"  name="templateSeq" id="templateSeq" /> 
				<input type="hidden" name="imgSrc"/>
				
				
				<div class="temDesignPOP bg-lightgrey">
					<ul class="txt-c pt30 bg-white fl">
						<li class="wd25 mr1 i-block ver-t mb30">
							<p class="admpg-tit2 mb10"><spring:message code="wzwg.cmm.word.main" /></p>
							<div class="thumImg">
								<img src="/<c:out value="${templtVO.templateStreCours }"/>screenshot/thumb_<c:out value="${templtVO.thumbUrl}"/>">
								<div class="hoverLayer blck">
	    							<a class="hoverbtn_circle closeUp" onclick="fnImgPrevewPop(this)" data-filepath="/<c:out value="${templtVO.templateStreCours }"/>screenshot/<c:out value="${templtVO.thumbUrl}"/>" title="<spring:message code="wzwg.site.screen.msg.MSG128"/>"><spring:message code="wzwg.site.screen.msg.MSG129"/></a>
	    						</div>
							</div>
						</li>
						<li class="wd25 mr1 i-block vert-t mb30">
							<p class="admpg-tit2 mb10"><spring:message code="wzwg.cmm.word.sub" /></p>
							<div class="thumImg">
								<img src="/<c:out value="${templtVO.templateStreCours }"/>screenshot/thumb_<c:out value="${templtVO.thumbUrlSub1}"/>">
								<div class="hoverLayer blck">
	    							<a class="hoverbtn_circle closeUp" onclick="fnImgPrevewPop(this)" data-filepath="/<c:out value="${templtVO.templateStreCours }"/>screenshot/<c:out value="${templtVO.thumbUrlSub1}"/>" title="<spring:message code="wzwg.site.screen.msg.MSG128"/>"><spring:message code="wzwg.site.screen.msg.MSG129"/></a>
	    						</div>
							</div>
						</li>
						<li class="wd25 mr1 i-block vert-t mb30">
							<p class="admpg-tit2 mb10"><spring:message code="wzwg.site.screen.msg.MSG127" /></p>
							<div class="thumImg">
								<img src="/<c:out value="${templtVO.templateStreCours }"/>screenshot/thumb_<c:out value="${templtVO.thumbUrlSub2}"/>">
								<div class="hoverLayer blck">
	    							<a class="hoverbtn_circle closeUp"  onclick="fnImgPrevewPop(this)" data-filepath="/<c:out value="${templtVO.templateStreCours }"/>screenshot/<c:out value="${templtVO.thumbUrlSub2}"/>" title="<spring:message code="wzwg.site.screen.msg.MSG128"/>"><spring:message code="wzwg.site.screen.msg.MSG129"/></a>
	    						</div>
							</div>
						</li>
						<li class="wd15 i-block vert-t mb30">
							<p class="admpg-tit2 mb10"><spring:message code="wzwg.cmm.word.mobile" /></p>
							<div class="thumImg">
								<img src="/<c:out value="${templtVO.templateStreCours }"/>screenshot/<c:out value="${templtVO.thumbUrlMobile}"/>">
								<div class="hoverLayer blck">
	    							<a class="hoverbtn_circle closeUp" onclick="fnImgPrevewPop(this)" data-filepath="/<c:out value="${templtVO.templateStreCours }"/>screenshot/<c:out value="${templtVO.thumbUrlMobile}"/>" title="<spring:message code="wzwg.site.screen.msg.MSG128"/>"><spring:message code="wzwg.site.screen.msg.MSG129"/></a>
	    						</div>	
							</div>
						</li>
					</ul>

					<ul class="p30 box-border wd100 fl">
						<li class="wd49 mr1 fl fs17">
							<a href="javascript:void(0);" onclick="javascript:fn_siteTempTemplt('<c:out value="${templtVO.templateSeq}"/>');" class="wzbtn-lg wzbtn-block btn-grey black"><spring:message code="wzwg.cmm.word.toupdt" /></a>
							<p class="wz_tableguide w100 fl mt10 txt-c"><span class="circle_no bg-grey blue fw600">?</span><spring:message code="wzwg.cmm.msg.MSG102" /></p>
						</li>
						<li class="wd49 fl fs17">
							<a href="javascript:void(0);" onclick="javascript:fnLoadTemplatInit('<c:out value="${templtVO.templateSeq}"/>')" class="wzbtn-lg wzbtn-block btn-blue"><spring:message code="wzwg.cmm.word.newopert" /></a>
							<p class="wz_tableguide w100 fl mt10 txt-c"><span class="circle_no bg-grey blue fw600">?</span><spring:message code="wzwg.cmm.msg.MSG103" /></p>
						</li>
					</ul>
				</div>
				
				
			</form>

				<!-- 팝업안 컨텐츠 내용 끝 -->


