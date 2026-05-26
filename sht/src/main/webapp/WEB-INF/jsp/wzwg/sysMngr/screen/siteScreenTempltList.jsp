<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 
 <script src="/js/wzwg/cmm/jquery.form.min.js"></script> 
 <noscript><link rel="stylesheet" href="/jquery/css/jquery.fileupload-ui-noscript.css"></noscript>
 
<script>
$(document).ready(function()
		{
			$("#allCnt").html('<b>' + $("#totalCnt").val()+'</b><spring:message code="wzwg.cmm.word.count02" />');
		//	fn_search('1');
		});
function fn_search(pageno){
	
	if(isNaN(pageno)){
		console.log('잘못된 페이지호출');
		return;
	}
	
	document.frm.pageIndex.value=pageno;
	document.frm.action  ="<c:out value="${wzwg_contextPath}" />/sysMngr/screen/selectTemplateList.do";
	document.frm.target="_self";
	document.frm.method="post";
	document.frm.submit();
}

function fn_detail(seq){ 
	document.frm.templateSeq.value=seq;
	document.frm.action  ="<c:out value="${wzwg_contextPath}" />/sysMngr/screen/selectTemplateInfo.do";
	document.frm.target="_self";
	document.frm.method="post";
	document.frm.submit();
}

/* moo0506 */
function fn_detail_edit(seq){ 
	document.frm.templateSeq.value=seq;
	document.frm.action  ="<c:out value="${wzwg_contextPath}" />/sysMngr/screen/selectSiteScreenTempIndexMngr.do";
	document.frm.method="post";
	document.frm.target="_blank";
	document.frm.submit();
}


function fnZipReady(inp){
	 var fileNames ='';
	 //console.log($(inp)[0].files);
	 var fileCnt = $(inp)[0].files.length;
	 
	 
	 for(var i = 0 ; i < fileCnt ; i++){
		 var nm = $(inp)[0].files[i].name;
		 if(filenameHanChk(nm) == false){
			alert('<spring:message code="wzwg.sysMngr.msg.MSG020" />');
			return;
		 }
		 
		 if(!rFilter.test($(inp)[0].files[i].type)) {
			 alert("<spring:message code="wzwg.sysMngr.msg.MSG044" />");
			return;
		 }
		 
		 if(i > 0){
			 fileNames += ',';
		 }
		 fileNames += nm;
//		 fileNames += $(inp)[0].files[i].name;
//		 fileNames += $(inp)[0].files[i].type;


	 }
	 
	 $('#uploadImgNames').html(fileNames);
}

var nameCheck = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]*/gi;//한글체크

function filenameHanChk(filename){
	 //console.log(chkname + ':' + nameCheck.test(chkname));
	 //console.log(filename + ':' + nameCheck.test(filename));
	 for(var i = 0 ; i < filename.length; i++){
		 if(nameCheck.test(filename.charAt(i)) == false){
			 return false;
		 }
	 }
	 return true;
}

//var rFilter = /^(image\/bmp|image\/gif|image\/jpg|image\/jpeg|image\/png)$/i;
var rFilter = /^(application\/x-zip-compressed)$/i;
function fnZipFileUpload(){
	 
	 var fileCnt = $('#zipFile')[0].files.length;
	 
	 for(var i = 0 ; i < fileCnt ; i++){
		 if (!rFilter.test($('#zipFile')[0].files[i].type)) {
				alert("<spring:message code="wzwg.sysMngr.msg.MSG044" />");
				return;
			}	 
		 //var filename = $('#imgfiles')[0].files[i].name;
	 	
	 }
	 
	 
	 
	 $('#mngrZipForm').ajaxForm({
		    type:'POST'
		    , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/screen/registScreenTempltInstallAjax.do'
		    , beforeSend: function() {
		        //status.empty();
		        var percentVal = '0%';
		        $('#uploadImgProgressbar').css('width', percentVal);
		        $('#uploadImgProgressbar').show();
		        $('#uploadImgStatus').html(percentVal)
		        //bar.width(percentVal)
		        //percent.html(percentVal);
		    }
		    , uploadProgress: function(event, position, total, percentComplete) {
		        var percentVal = percentComplete + '%';
		        $('#uploadImgProgressbar').css('width', percentVal);
		        $('#uploadImgStatus').html(percentVal)
		        //bar.width(percentVal)
		        //percent.html(percentVal);
				//console.log(percentVal, position, total);
		    }
		    , success: function(data) {
		        var percentVal = '100%';
		        $('#uploadImgProgressbar').css('width', percentVal);
		        $('#uploadImgStatus').html(percentVal)
		        $('#uploadImgProgressbar').fadeOut(1200);
		        //console.log(data);

		        if(data.head.result == 'success'){
			       alert('성공');
			       location.reload();
		        }else{
		        	alert(data.head.msg);
		        	$('#uploadImgNames').html("upload fail");
		        }
		        
		        //bar.width(percentVal)
		        //percent.html(percentVal);
		    }
			, complete: function(xhr) {
				//status.html(xhr.responseText);
			}
		    , dataType: 'json'
		}); 
	 
	 $('#mngrZipForm').submit();
}

$(document).ready(function(){
	$(document).on('keyup', function(e){
		//console.log(e.key);
		//console.log(e.keyCode);
		
		if(e.keyCode >= 48 && e.keyCode <= 90){//숫자+영문키만 받음
			inpWords.push(e.key);
			if(inpWords.length > widgetWords.length){
				//console.log('inpWord slice : ' + (1) + ',' + inpWords.length);
				inpWords = inpWords.slice(1 ,inpWords.length);
			}
			//console.log(inpWords);
			if(widgetWords == inpWords.join('')){
				//let widgetPw = prompt('비밀번호를 입력하세요','');
				//alert(widgetPw);
				wzHtmlModal('popup_la', '<spring:message code="wzwg.sysMngr.word.widgUpdtScrinEnter" />', 'widgetFrm');
				$('#widgetPw').focus();
			}
			$( ".wzpopup" ).css( "overflow", "hidden" );
		}
	});
	

	$('#layout_all').click('on', function() {
		$('input[name=layoutSeCode]').val('');
		$('input[name=code]').val('');
		fn_search(1);
	});
});

function widgetEditOpen(){
	$.ajax({
		   type:'POST'
		 , url:'/sysMngr/screen/widget/selectWidgetMngrAuth.do'
		 , cache : false
		 , async : false
		 , data : {widgetPw : $('#widgetPw').val()}
		 , success:function (data) { 
			 if(data.head.result == 'success'){
				 //window.open('/sysMngr/screenHidden/widget/screen/widgetEditor.do','_blank');
				 location.href = '/sysMngr/screen/widget/widgetMngr.do';
				 wzModalClose();
			 }else{
				 alert('<spring:message code="wzwg.cmm.msg.MSG050"/>');
			 }
		 }
		 , dataType: 'json'
	});
}


var widgetWords = 'dnlwpt999';
var inpWords = [];
</script>
<div id="widgetPopup" style="display:none;">
	<form name="widgetFrm" id="widgetFrm" method="post" class="mg20">
	<p class="mb20 wd100 txt-c"><spring:message code="wzwg.sysMngr.msg.MSG045" /></p>
	<input type="password" name="widgetPw" id="widgetPw" onkeyup="if(window.event.keyCode == 13){widgetEditOpen();}" autocomplete="off">
	<button type="button" class="wzbtn btn-save" onclick="widgetEditOpen()"><spring:message code="wzwg.cmm.word.input" /></button>
	</form>
</div>

<form name="frm" id="frm" method="post">
<input type="hidden"  name="templateSeq" id="templateSeq" />
<input type="hidden"  name="pageIndex" id="pageIndex" value="0" />

		<%-- <div class="main-menu-bar">
			<select name="templateLclCode" id="templateLclCode" onchange="fn_search('1')">
				<option value="">분위기</option>
				<c:forEach items="${templateLclCode}" var="result" varStatus="status" >
				<option value="${result.code}" <c:if test="${paramVO.templateLclCode eq result.code }">selected</c:if>>${result.codeNm}</option>
				 </c:forEach>
			</select>
			<select name="templateMclCode" id="templateMclCode"  onchange="fn_search('1')">
				<option value="">색상</option>
				<c:forEach items="${templateMclCode}" var="result" varStatus="status" >
				<option value="${result.code}" <c:if test="${paramVO.templateMclCode eq result.code }">selected</c:if>>${result.codeNm}</option>
				 </c:forEach>
			</select>
		</div> --%>
		
		
		<div class="designAdm_tem">
			<form name="frmList" id="frmList" method="post">
				<%-- <h3 class="wzAdmSTit wd100 fl"><span>01. </span><spring:message code="wzwg.cmm.word.template" /> <spring:message code="wzwg.cmm.word.ty" /> <spring:message code="wzwg.cmm.word.choise" /></h3> --%>
<%-- 
				<ul class="temTypeSel wzForm wd100 fl txt-c">
					<li class="i-block txt-l">
						<input type="radio" name="layoutSeCode" id="layout_all" value="" onclick="fn_search(1)" checked="checked">
						<label for="layout_all">
							<div class="txtbox">
    							<p class="title"><spring:message code="wzwg.cmm.word.all" /></p>
    							<p class="no" id="allCnt"></p>
	    					</div>
<!-- 							<img src="/images/wzwg/site/mngr/layout/2020_layout_all.png" alt=""> -->
						</label>
					</li>
				
					<c:forEach items="${layoutList}" var="layout" varStatus="status">
					<c:set var="layoutTotalCnt" value="${layoutTotalCnt + layout.cnt}"/>
					<li class="i-block txt-l">
						<input type="radio" name="layoutSeCode" id="<c:out value="${layout.codeAbrvNm}_${layout.code}" />" value="<c:out value="${layout.code}" />" onclick="fn_search(1)" <c:if test="${layout.code eq paramVO.layoutSeCode }">checked="checked"</c:if>>
						<label for="<c:out value="${layout.codeAbrvNm}_${layout.code}" />">
							<div class="txtbox">
	    						<c:if test="${layout.codeAbrvNm eq 'layout1' }"><p class="title"><spring:message code="wzwg.cmm.word.gnrl" /><spring:message code="wzwg.cmm.word.ty02" /></p><p class="no"><b><c:out value="${layout.cnt}" /></b><spring:message code="wzwg.cmm.word.count02" /></p></c:if>
	    						<c:if test="${layout.codeAbrvNm eq 'layout2' }"><p class="title"><spring:message code="wzwg.cmm.word.left01" /><spring:message code="wzwg.cmm.word.menu" /><spring:message code="wzwg.cmm.word.ty02" /></p><p class="no"><b><c:out value="${layout.cnt}" /></b><spring:message code="wzwg.cmm.word.count02" /></p></c:if>
	    						<c:if test="${layout.codeAbrvNm eq 'layout3' }"><p class="title"><spring:message code="wzwg.cmm.word.wide" /><spring:message code="wzwg.cmm.word.ty02" /></p><p class="no"><b><c:out value="${layout.cnt}" /></b><spring:message code="wzwg.cmm.word.count02" /></p></c:if>
	    						<c:if test="${layout.codeAbrvNm eq 'layout6' }"><p class="title"><spring:message code="wzwg.cmm.word.cmpnd" /><spring:message code="wzwg.cmm.word.ty02" /></p><p class="no"><b><c:out value="${layout.cnt}" /></b><spring:message code="wzwg.cmm.word.count02" /></p></c:if>
	    						
	    						<c:if test="${status.count == 1 }">A : <spring:message code="wzwg.cmm.word.gnrl" /> ${layout.cnt}<spring:message code="wzwg.cmm.word.count02" /></c:if>
								<c:if test="${status.count == 2 }">B : <spring:message code="wzwg.cmm.word.left01" /><spring:message code="wzwg.cmm.word.menu" /> ${layout.cnt}<spring:message code="wzwg.cmm.word.count02" /></c:if>
								<c:if test="${status.count == 3 }">C : <spring:message code="wzwg.cmm.word.wide" /> ${layout.cnt}<spring:message code="wzwg.cmm.word.count02" /></c:if>
								<c:if test="${status.count == 4 }">D : <spring:message code="wzwg.cmm.word.cmpnd" /> ${layout.cnt}<spring:message code="wzwg.cmm.word.count02" /></c:if></label>
	    					</div>
							<img src="/images/wzwg/site/mngr/layout/2020_<c:out value="${layout.codeAbrvNm}" />.png" alt="">
						</label>
					</li>
					</c:forEach>
					<input type="hidden" id="totalCnt" value="<c:out value="${layoutTotalCnt}" />">
				</u --%>

				<div class="wz_notice brbox bg-white br-blue-strong mb30" style="overflow: visible;">	
						<ul class="wd100">
							<li class="admpg-subp wd100 mb0">· <spring:message code="wzwg.cmm.msg.tip.MSG141" /></li>
						</ul>
				</div>

				<div class="admDesignSet">
				  <div class="ctgryBox mb50">
				    <strong>
					    <select name="expsrAt" onchange="fn_search(1)" class="fr">
					    	<option value="" selected><spring:message code="wzwg.sysMngr.word.exposureAt" /></option>
					    	<option value="Y"<c:if test="${paramVO.expsrAt eq 'Y'}"> selected</c:if>><spring:message code="wzwg.cmm.word.use" /></option>
					    	<option value="N"<c:if test="${paramVO.expsrAt eq 'N'}"> selected</c:if>><spring:message code="wzwg.cmm.word.unuse" /></option>
					    </select>
				    </strong>
				    
				    <div class="mainTemCtgryWrap">
				      <ul>
				      	<li>
				      		<button id="layout_all" type="button" class="ctgryBtn ctgryBtnAll<c:if test="${empty paramVO.code and empty paramVO.layoutSeCode}"> on</c:if>"><spring:message code="wzwg.cmm.word.all" /></button>
				      	</li>
				      	<c:forEach items="${templateCtgryCode}" var="codeList">
				        <li>
				          	<input type="radio" name="code" id="<c:out value="${codeList.codeAbrvNm}_${codeList.code}" />" value="<c:out value="${codeList.code}" />" onclick="fn_search(1)" <c:if test="${codeList.code eq paramVO.code}">checked="checked"</c:if>>
				          	<label for="<c:out value="${codeList.codeAbrvNm}_${codeList.code}" />" class="ctgryBtn">#<c:out value="${codeList.codeNm}"/>
					          	<c:if test="${fn:indexOf(codeList.codeAbrvNm, 'layout') > -1}">
					          		<div class="menu_help">
					              		<span class="circle_no bg-grey blue fw600">?</span>
					              		<div class="help_pop">
							              	<img src="/images/wzwg/site/mngr/layout/2020_<c:out value="${codeList.codeAbrvNm}" />.png" alt="" class="fl">
							                <c:if test="${codeList.codeAbrvNm eq 'layout1' }"><span><spring:message code="wzwg.cmm.msg.tip.MSG144" /></span></c:if>
						    				<c:if test="${codeList.codeAbrvNm eq 'layout2' }"><span><spring:message code="wzwg.cmm.msg.tip.MSG145" /></span></c:if>
						    				<c:if test="${codeList.codeAbrvNm eq 'layout3' }"><span><spring:message code="wzwg.cmm.msg.tip.MSG146" /></span></c:if>
						    				<c:if test="${codeList.codeAbrvNm eq 'layout6' }"><span><spring:message code="wzwg.cmm.msg.tip.MSG147" /></span></c:if>
					              		</div>
					            	</div>
					          	</c:if>
				          </label>
				        </li>
				        </c:forEach>
				      </ul>
				  	  
				  	  
				      <ul style="display: none;">
				      	<c:forEach items="${layoutList}" var="layout" varStatus="status">
				        <li>
				          <input type="radio" name="layoutSeCode" id="<c:out value="${layout.codeAbrvNm}_${layout.code}" />" value="<c:out value="${layout.code}" />" onclick="fn_search(1)" <c:if test="${layout.code eq paramVO.layoutSeCode }">checked="checked"</c:if>>
				          <label for="<c:out value="${layout.codeAbrvNm}_${layout.code}" />" class="ctgryBtn">
				          	<c:if test="${layout.codeAbrvNm eq 'layout1' }">#<spring:message code="wzwg.sysMngr.word.gnrlTy02" /></c:if>
		    				<c:if test="${layout.codeAbrvNm eq 'layout2' }">#<spring:message code="wzwg.sysMngr.word.left01MenuTy02" /></c:if>
		    				<c:if test="${layout.codeAbrvNm eq 'layout3' }">#<spring:message code="wzwg.sysMngr.word.wideTy02" /></c:if>
		    				<c:if test="${layout.codeAbrvNm eq 'layout6' }">#<spring:message code="wzwg.sysMngr.word.cmpndTy02" /></c:if>
				            <div class="menu_help">
				              <span class="circle_no bg-grey blue fw600">?</span>
				              <div class="help_pop">
				              	<img src="/images/wzwg/site/mngr/layout/2020_<c:out value="${layout.codeAbrvNm}" />.png" alt="" class="fl">
				                <c:if test="${layout.codeAbrvNm eq 'layout1' }"><span><spring:message code="wzwg.cmm.msg.tip.MSG144" /></span></c:if>
			    				<c:if test="${layout.codeAbrvNm eq 'layout2' }"><span><spring:message code="wzwg.cmm.msg.tip.MSG145" /></span></c:if>
			    				<c:if test="${layout.codeAbrvNm eq 'layout3' }"><span><spring:message code="wzwg.cmm.msg.tip.MSG146" /></span></c:if>
			    				<c:if test="${layout.codeAbrvNm eq 'layout6' }"><span><spring:message code="wzwg.cmm.msg.tip.MSG147" /></span></c:if>
				              </div>
				            </div>
				          </label>
				        </li>
				        </c:forEach>
				      </ul>
				    </div>
				  </div>
				</div>
				
				<%-- <h3 class="wzAdmSTit wd100 fl"><span>02. </span> <spring:message code="wzwg.cmm.word.template" /> <spring:message code="wzwg.cmm.word.design" /> <spring:message code="wzwg.cmm.word.choise" /></h3> --%>
				<div id="templtListArea">
				<ul class="temDesignSel wd100">
				<c:if test="${not empty templtList }">
					<c:forEach items="${templtList}" var="resultList" varStatus="status"> 
					<li class="wd33 wm100 p15 box-border">
						<p class="admpg-tit2"><c:out value="${resultList.templateNm}" /></p>
						<c:if test="${resultList.reflctCnt ne '0'}">
							<div class="templateUsrInfo" >(<spring:message code="wzwg.sysMngr.word.applcCo02" /> : <c:out value="${resultList.reflctCnt}" /><spring:message code="wzwg.cmm.word.count04" /> <spring:message code="wzwg.cmm.word.lastapplcde" />:<c:out value="${resultList.reflctPnttm}" />)</div>
						</c:if>
						<div class="temBox thumImg">
							<div class="wd100 fl">
								<img src="/<c:out value="${resultList.templateStreCours }" />screenshot/thumb_<c:out value="${resultList.thumbUrl}" />">
							</div>
							<div class="hoverLayer">
								<div class="i-block wd100 linehgt150 vert-m txt-l">
									<a href="javascript:;" class="circleRTxt" onclick="fn_detail('<c:out value="${resultList.templateSeq}" />')"><span class="hoverbtn_circle closeUp"></span><spring:message code="wzwg.sysMngr.word.detailView"/></a>
		  					</div>
						</div>
						
					</li>
					</c:forEach>
				</c:if>
				<c:if test="${empty templtList }">
					<li class="wd33 wm100 p15 box-border">
						<p class="admpg-tit2"><spring:message code="wzwg.cmm.msg.MSG097" /></p>
					</li>
				</c:if>
				</ul>	
				</div>
				
				<c:if test="${not empty templtList }">
				<ul class="num">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
				</ul>
				</c:if>
			</form>






				<h3 class="wzAdmSTit wd100 fl mt50"><span>※ </span><spring:message code="wzwg.sysMngr.word.tmplatAdd" /></h3>
				
				<form id="mngrZipForm">
	          		<input type="hidden" id="templateSeq" name="templateSeq" value="<c:out value="${paramVO.templateSeq }" />">
	          		<input type="hidden" name="fileType" value="img">
					<div class="addImgArea fs17">
						<div class="wd80 fl linehgt50 txt-c brwd2 brdashed br-lightgrey box-border" style="position: relative;">
		            		<input name="zipFile" id="zipFile" type="file" style="position: absolute; width: 100%; height: 100%; opacity: 0; left: 0;" onchange="fnZipReady(this)">
		            		<div><spring:message code="wzwg.cmm.word.click" /> <spring:message code="wzwg.cmm.word.or" /> <spring:message code="wzwg.cmm.word.drag" /></div>
			            	<div id="uploadImgProgressbar" style="position: absolute; height: 100%; left: 0; background: rgba(58, 197, 49, 0.8); text-align: center; width: 0%; color: white; overflow: hidden;">
			            		UPLOADING <span id="uploadImgStatus">0%</span>
			            	</div>
		            	</div>
		            	<button type="button" class="wzbtn-lg btn-save wd20 fl" onclick="fnZipFileUpload()"><spring:message code="wzwg.cmm.word.upload"/></button>
	            	</div>
	            </form>

		</div>
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		<%-- 
		
		
		<div class="ctr-box tem-list01">
				
				<h4><span>01</span><spring:message code="wzwg.cmm.word.template" /> <spring:message code="wzwg.cmm.word.ty" /> <spring:message code="wzwg.cmm.word.choise" /></h4>
				<ul>
				<c:forEach items="${layoutList}" var="layout" varStatus="status">
					<li>
						<img src="/images/wzwg/site/mngr/layout/${layout.codeAbrvNm}.jpg" alt="" />
						<span><label><input type="radio" name="layoutSeCode" id="layoutSeCode" value="${layout.code}" onclick="fn_search(1)" <c:if test="${layout.code eq paramVO.layoutSeCode }">checked="checked"</c:if>>
							<c:if test="${status.count == 1 }">A : <spring:message code="wzwg.cmm.word.gnrl" /> ${layout.cnt}<spring:message code="wzwg.cmm.word.count02" /></c:if>
							<c:if test="${status.count == 2 }">B : <spring:message code="wzwg.cmm.word.left01" /><spring:message code="wzwg.cmm.word.menu" /> ${layout.cnt}<spring:message code="wzwg.cmm.word.count02" /></c:if>
							<c:if test="${status.count == 3 }">C : <spring:message code="wzwg.cmm.word.wide" /> ${layout.cnt}<spring:message code="wzwg.cmm.word.count02" /></c:if>
							<c:if test="${status.count == 4 }">D : <spring:message code="wzwg.cmm.word.cmpnd" /> ${layout.cnt}<spring:message code="wzwg.cmm.word.count02" /></c:if></label>
						</span>
					</li> 
				</c:forEach>
				</ul>
			</div>
		
		<div style="margin: 20px;">&nbsp;</div>
		
		<div class="template">
			<div id="templtListDiv">
			<div class="main-menu-bar">
				<h4><span>02</span> <spring:message code="wzwg.cmm.word.template" /> <spring:message code="wzwg.cmm.word.design" /> <spring:message code="wzwg.cmm.word.choise" /></h4>
			</div>
							<ul>
							<c:choose>
				<c:when test="${!empty templtList }">
					<c:forEach items="${templtList}" var="resultList" varStatus="status">
								<li>
									<div>
										<a href="javascript:;" onclick="fn_detail('${resultList.templateSeq}')">	<img src="/${resultList.thumbUrl}" width="100%"/><img src="/${resultList.templateStreCours }screenshot/${resultList.thumbUrl}" width="100%"/></a>
										<a class="btn-a" href="javascript:;" onclick="fn_detail_edit('${resultList.templateSeq}')"><spring:message code="wzwg.cmm.word.template" /> <spring:message code="wzwg.cmm.word.updt" /></a>
									</div>
									<table>
										<colgroup>
											<col width="50%">
											<col width="50%">
										</colgroup>
										<tr>
											<th><spring:message code="wzwg.cmm.word.template" /> <spring:message code="wzwg.cmm.word.nm01" /></th>
											<td>${resultList.templateNm}</td>
										</tr>
										<tr>
											<th><spring:message code="wzwg.cmm.word.template" /> <spring:message code="wzwg.cmm.word.cl" /></th>
											<td>${resultList.templateLclNm}/${resultList.templateMclNm}</td>
										</tr>
										<tr>
											<th><spring:message code="wzwg.cmm.word.site" /> <spring:message code="wzwg.cmm.word.co" /></th>
											<td>${resultList.templateCnt}<spring:message code="wzwg.cmm.word.count02" /></td>
										</tr>
										<tr>
											<th><spring:message code="wzwg.cmm.word.rgsde" /></th>
											<td>${resultList.frstRegistPnttm}</td>
										</tr> 
										<tr>
											<th colspan="2"><a href="javascript:;" class="wzbtn btn-basic" onclick="fn_detail('${resultList.templateSeq}')">상세보기</a></th> 
										</tr>
									</table>
								</li>
								</c:forEach>
					</c:when>
					<c:otherwise>
							<li><spring:message code="wzwg.cmm.msg.MSG097" /></li>
					</c:otherwise>
				</c:choose> 

							</ul>
						</div> 
	  <div class="of mg_t20">
			<div class="ctr-box">
			<ul class="num">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
			</ul>
			</div>
		</div>
		<div class="ctr-box" style="display: none;">
				<select name="searchCondition"  id="searchCondition">
					<option value="" selected><spring:message code="wzwg.cmm.word.all" /></option>
					<option value="1"><spring:message code="wzwg.cmm.word.template" /> <spring:message code="wzwg.cmm.word.nm01" /></option> 
				</select>
				<input type="text" class="txt" name="searchKeyword"/>
				<a href="javascript:void(0);"  onclick="fn_search('1')" class="btn-s"><spring:message code="wzwg.cmm.word.search01" /></a>
		</div>
		</div>
</form>
		
	<div class="ctr-box tem-list01">
		<h4><span>03</span><spring:message code="wzwg.cmm.word.template" /> <spring:message code="wzwg.cmm.word.add" /></h4>
		<div style="padding: 15px 30px;">
          		<form id="mngrZipForm">
          		<input type="hidden" id="templateSeq" name="templateSeq" value="${paramVO.templateSeq }">
          		<input type="hidden" name="fileType" value="img">
          		<div style="float: left; width: 80%">
            	<div class="addImgArea" style="height: 34px; border: solid 1px #999; border-radius: 6px; line-height: 34px; position: relative; overflow: hidden;">
            		<div style="position: absolute; width: 100%" >클릭 또는 드래그</div>
            		<input name="zipFile" id="zipFile" type="file" style="position: absolute; width: 100%; height: 100%; opacity: 0; left: 0;" onchange="fnZipReady(this)"/>
	            	<div id="uploadImgProgressbar" style="position: absolute; height: 100%; left: 0; background: rgba(58, 197, 49, 0.8); text-align: center; width: 0%; color: white; overflow: hidden;">
	            		UPLOADING <span id="uploadImgStatus">0%</span>
	            	</div>
            	</div>
            	<div id="uploadImgNames" style="text-align: left; padding-left: 10px; margin-top: 5px;"></div>
           	</div>
           	<div style="float: left; width: 20%">
           		<button type="button" class="wzbtn btn-black" onclick="fnZipFileUpload()" style="width: 100%; margin: 0 7px; text-align: center;">업로드</button>
           	</div>
           	</form>
        </div>
	</div>
 --%>