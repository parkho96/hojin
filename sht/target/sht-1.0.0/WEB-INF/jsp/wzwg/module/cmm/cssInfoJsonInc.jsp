<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<link rel="stylesheet" href="/css/wzwg/module/cmm/cssInfoListPop.css" type="text/css" />
<%-- <%
Enumeration<String> e = request.getParameterNames();

while (e.hasMoreElements()){
	String key = e.nextElement();
	out.println(key + " : " + request.getParameter(key) + "<br>");
}
%> --%>
<%-- [${param.cssPath}] --%>
<script>
var cssPath = '<c:out value="${param.cssPath}"/>';
var jsonPath = cssPath.substring(0, cssPath.lastIndexOf(".")) + '.json'
var cssInfoJ = null;
var cssNmInp = null;

$(document).ready(function(){
	cssNmInp = $('#<c:out value="${param.cssId}"/>');
	
	$.ajax({
	    type : 'GET'
		, url : jsonPath
		, async : false
		, dataType : 'json'
		, success : function (data) {
			//$("#imgDiv").html(data);
			//$("#imgDiv").show();
			//console.log(data);
			cssInfoJ = data
		}
		, error : function (request, status, error) {
			alert('error');
		}
	}); 
	
	fnUseCssInfo();
});

function fnUseCssInfo(){
	//console.log(cssInfoJ);
	if(cssNmInp.val() == ''){
		$('#useCssInfo h4').hide();
		$('#useDefaultCssNm').show();
		$('#useCssClass').hide();
	}else{
		
		$('#useCssInfo h4').show();
		$('#useDefaultCssNm').hide();
		$('#useCssClass').show();

		var useCssData;
		$(cssInfoJ).each(function(idx){
			if( cssInfoJ[idx].classname == cssNmInp.val()){
				useCssData = cssInfoJ[idx];
			}
		})
		if(useCssData == undefined || useCssData == null){
			$('#useCssClass img').attr('src', '/images/wzwg/site/noImg/noImageLogo_s.jpg');
			$('#useCssInfo h4').html(cssNmInp.val());
		}else{
			$('#useCssClass img').attr('src', useCssData.thumbnail);
			$('#useCssInfo h4').html(useCssData.classname);
		}
		
		
	}
	
	$('#useCssInfo').show();
}

function fnCssStylePopup(){
	var title = '<spring:message code="wzwg.module.word.skinestbs" />';
	wzHtmlModal('popup_l', title, 'cssInfoListPop');
	
	$('.cssInfoList').empty();
	$(cssInfoJ).each(function(idx){
		var sample = $('#cssInfoSample').children().clone();
		//console.log(cssInfoJ[idx].classname + " / " + cssInfoJ[idx].thumbnail);
		$(sample).find('img').attr('src', cssInfoJ[idx].thumbnail);
		$(sample).find('a').attr('data-classname', cssInfoJ[idx].classname);
		$(sample).find('.h4Tit').html(cssInfoJ[idx].classname);
		
		if( cssInfoJ[idx].classname == cssNmInp.val()){
			sample.addClass('active');
		}
		
		$('.cssInfoList').append(sample);
	})
}

function fnCssChange(_btn){
	var classname = $(_btn).attr('data-classname');
	cssNmInp.val(classname);
	fnUseCssInfo();
	wzModalClose();
}

function fnImgPrevewPop(img){
	console.log(img);
	var viewImg = new Image();
	$(viewImg).attr('src', img.attr('src'));
	var imgsrc = img.attr('src');
	//var imgsrc = $(img).attr('src');

	
//	var width = $(img)[0].naturalWidth;
//	var height = $(img)[0].naturalHeight;
	var width = $(viewImg)[0].naturalWidth;
	var height = $(viewImg)[0].naturalHeight;
	var frm = $('<form id="imgSamplePop"><input type="hidden" name="imgSrc"></form>');
	//frm.imgSrc.value = imgsrc;
	frm.find('input').val(imgsrc);
	
	
	var frmResult = window.open("", "popForm", "width=" + width + ",height=" + height + ",toolbars=no,menubars=no,scrollbars=yes,left=50,top=400");
	
	frm.attr('target', 'popForm');
	frm.attr('action', '/sample/img/imgViewer.jsp');
	
	$('body').append(frm);
	//frm.submit();
	
	$('#imgSamplePop').submit();
	$('#imgSamplePop').remove();
	
	
}
</script>
<input type="hidden" name="imgSrc"/>


<div id="cssInfo">
	<div id="useCssInfo" style="display:none;">
		<div class="pd20">
			<div id="useDefaultCssNm"><spring:message code="wzwg.cmm.msg.MSG299" /></div>
			<h4></h4>
			<div id="useCssClass">
				<a href="javascript:void(0);" onclick="fnImgPrevewPop($(this).find('img'))">
					<img src='<c:out value="${moduleBbsCssVO.prevewPath}"/>' id="orgImg" style="width:250px;"/>
				</a>
			</div>
			<div class="lt-box">
				<a href="javascript:void(0);" onclick="fnCssStylePopup();" class="wzbtn btn-edit"><spring:message code="wzwg.cmm.word.change" text="change" /></a> 
			</div>
		</div>
	</div>	
</div>

<div style="display:none;">
	<div id="cssInfoListPop">
	<ul class="cssInfoList"></ul>
	</div>
	<ul id="cssInfoSample">
		<li>
			<div class="pd20">
				<h4 class="h4Tit"></h4>
				<div class="tem-img pb20" style="">
					<div>
						<a href="javascript:void(0);" onclick="fnImgPrevewPop($(this).find('img'))">
							<img src='/images/wzwg/site/noImg/noImageLogo_s.jpg' style="width:250px;"/>
						</a>
					</div>
				</div>
				<div class="tem-list" style="">
					<div class="rt-box">
						 <a href="javascript:void(0);" onclick="fnCssChange(this);" class="wzbtn btn-save" data-classname><spring:message code="wzwg.cmm.word.choise" text="choise" /></a> 
					</div>
				</div>
			</div>
		</li>
	</ul>
</div>
