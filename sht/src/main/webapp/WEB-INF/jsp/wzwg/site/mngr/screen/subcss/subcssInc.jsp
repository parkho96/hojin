<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 

<!-- subcssinc.jsp -->

<%-- 코드에디터 (codemirror) 로드 --%>
<c:import url="/WEB-INF/jsp/wzwg/webModule/codemirrorInc.jsp"></c:import>


<script>
	$(document).ready(function(){
		cssCM = cmStart('cssEdit', 'css');
		 
		cssCM.setOption("theme", 'material');
		
		cmSetWebSorceText(cssCM, '<c:out value="${paramVO.subCss }"/>');
		
		fnHistoryRefresh();
	});
	
	var cssCM;
	
	
	function fnRegistCssContents(){
		var cssContents = cmGetText(cssCM);
		if(cssContents == '' && confirm('CSS 내용이 없습니다.\n이대로 저장 합니까?') == false){
			//alert('저장 안함');
			return;
		}
		
		$('#cssEdit').val(cssContents);
		//alert('저장함');
		//return;
		$.ajax({
	        type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/subCss/registSubCssAjax.do'
			, data : $("#frmCss").serialize()
			, success : function (result) {
				//console.log(result);
				if(result.head.result == 'success'){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>\n<spring:message code="wzwg.site.screen.msg.MSG001"/>');
					fnHistoryRefresh()
				}else{
					alert(result.head.msg);
				}
			}
			, error : function (request, status, error) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
		});
	}
	
	function fnHistoryRefresh(){
		$.ajax({
	        type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/subCss/selectSubCssSaveFileListAjax.do'
			, data : {}
			, success : function (result) {
				//console.log(result);
				var opt = '';
				var cssList = result.body.resultList;
				
				//console.log(cssList);
				
				if(cssList.length == 0){
					opt += '<option value=""><spring:message code="wzwg.cmm.msg.MSG413"/></option>';
				}else{
					for (var i = 0; i < cssList.length; i++) {
						var cssName = cssList[i];
						var cssViewNm = '';
						cssViewNm += cssName.substring(4,8)+'.'; //년
						cssViewNm += cssName.substring(8,10)+'.'; //월
						cssViewNm += cssName.substring(10,12)+' '; //일
						cssViewNm += cssName.substring(12,14)+':'; //시
						cssViewNm += cssName.substring(14,16)+':'; //분
						cssViewNm += cssName.substring(16,18); //초
						
						
						opt += '<option value="' + cssName + '">' + cssViewNm + '</option>';
					}
				}
				
				$('#cssHistory').empty();
				$('#cssHistory').append(opt);
				
			}
			, error : function (request, status, error) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
		});
	}
	
	function fnLoadCssHistory(){
		//alert($('#cssHistory').val());
		
		var cssPath = '/upload/subCss/<c:out value="${sessionScope.SITE_SEQ}"/>/bak/' + $('#cssHistory').val();
		
		cmSetWebSorceText(cssCM, cssPath);
	}
	
	var cacheCss = {}
	function fnExpendCssEdit(){
		var scrollWidth = wzScrollbarWidth();
		
		if($('#cssEditDiv').attr('data-expend') == 'true'){
			//확장중이면 축소
			
			$('#cssEditDiv').css(cacheCss);
			$('#cssEditDiv').css('position', '');
			$('#cssEditDiv').css('top', '');
			$('#cssEditDiv').css('left', '');
			
			$('.CodeMirror.CodeMirror-wrap').css('height', '');
			$('.CodeMirror.CodeMirror-wrap').css('margin-left', '');
			wzShowScrollbar();
			$('#cssEditDiv').attr('data-expend', 'false');
			$('#btn-expend').html('<spring:message code="wzwg.cmm.word.viwLarg"/>');
			
		}else{
			//기본상태면 확장
			cacheCss['width'] = $('#cssEditDiv').css('width');
			cacheCss['height'] = $('#cssEditDiv').css('height');
			cacheCss['max-width'] = $('#cssEditDiv').css('max-width');
			var css = {'position' : 'absolute'
					 , 'top' : '0px'
					 , 'left' : '0px'
					 , 'width' : '100%'
					 , 'height' : '100%'
					 , 'max-width' : '100%'
					}
			
			$('#cssEditDiv').css(css);
			$('.CodeMirror.CodeMirror-wrap').css({
				  'height' : 'calc(100% - 140px)'
		    	, 'margin-left' : scrollWidth + 'px'
			});
			wzHideScrollbar();
			$('#cssEditDiv').attr('data-expend', 'true');
			$('#btn-expend').html('<spring:message code="wzwg.cmm.word.viwSmal"/>');
		}
	}
</script>

<div class="wz_notice brbox bg-white br-blue-strong">
  <ul class="wd100">
    <li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG030"/></li>
    <li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG031"/></li>
    <li class="admpg-subp wd100 mt20">· <spring:message code="wzwg.cmm.msg.tip.MSG032"/></li>
    <li class="admpg-subp wd100 mb0">· <spring:message code="wzwg.cmm.msg.tip.MSG033"/></li>
  </ul>
</div>

<form id="frmCss">
	<div class="cssForm bg-white" id="cssEditDiv" style="width: inherit; overflow-x: auto; max-width: 1300px;">
		<div class="rt-box mt10 mb10">
			<span><spring:message code="wzwg.cmm.msg.MSG412"/></span>
			<select id="cssHistory">
				<option value=""><spring:message code="wzwg.cmm.msg.MSG413"/></option>
			</select>
			<button type="button" class="wzbtn btn-edit mr10" onclick="fnLoadCssHistory()"><spring:message code="wzwg.cmm.word.import02"/></button>
			<button type="button" class="wzbtn btn-basic" id="btn-expend" onclick="fnExpendCssEdit()"><spring:message code="wzwg.cmm.word.viwLarg"/></button>
		</div>
		<textarea id="cssEdit" name="contents" style="min-height: 70%;"></textarea>
		
		<div class="rt-box mt10">
				<!-- <a href="javascript:void(0);" onclick="fn_usrInfoDelete();" class="wzbtn btn-del fl">선택 삭제</a> -->
				<a href="javascript:void(0);" onclick="fnRegistCssContents();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.regist" /></a>
		</div>
	</div>
	
</form>