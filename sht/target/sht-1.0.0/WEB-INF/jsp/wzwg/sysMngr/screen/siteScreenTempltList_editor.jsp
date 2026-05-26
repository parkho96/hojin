<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 
 <script src="/js/wzwg/cmm/jquery.form.min.js"></script> 
 <noscript><link rel="stylesheet" href="/jquery/css/jquery.fileupload-ui-noscript.css"></noscript>
 
<script>
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
			alert('<spring:message code="wzwg.sysMngr.msg.MSG020"/>');
			return;
		 }
		 
		 if(!rFilter.test($(inp)[0].files[i].type)) {
			 alert("<spring:message code="wzwg.sysMngr.msg.MSG044"/>");
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
				alert("<spring:message code="wzwg.sysMngr.msg.MSG044"/>");
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
</script>

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
		
		<div class="ctr-box tem-list01">
				
				<h4><span>01</span><spring:message code="wzwg.sysMngr.word.tmplatTyChoise" /></h4>
				<ul>
				<c:forEach items="${layoutList}" var="layout" varStatus="status">
					<li>
						<img src="/images/wzwg/site/mngr/layout/<c:out value="${layout.codeAbrvNm}" />.jpg" alt="" />
						<span><label><input type="radio" name="layoutSeCode" id="layoutSeCode" value="<c:out value="${layout.code}" />" onclick="fn_search(1)" <c:if test="${layout.code eq paramVO.layoutSeCode }">checked="checked"</c:if>>
							<c:if test="${status.count == 1 }">A : <spring:message code="wzwg.cmm.word.gnrl" /> <c:out value="${layout.cnt}" /><spring:message code="wzwg.cmm.word.count02" /></c:if>
							<c:if test="${status.count == 2 }">B : <spring:message code="wzwg.sysMngr.word.left01MenuTy02" /> <c:out value="${layout.cnt}" /><spring:message code="wzwg.cmm.word.count02" /></c:if>
							<c:if test="${status.count == 3 }">C : <spring:message code="wzwg.cmm.word.wide" /> <c:out value="${layout.cnt}" /><spring:message code="wzwg.cmm.word.count02" /></c:if>
							<c:if test="${status.count == 4 }">D : <spring:message code="wzwg.cmm.word.cmpnd" /> <c:out value="${layout.cnt}" /><spring:message code="wzwg.cmm.word.count02" /></c:if></label>
						</span>
					</li> 
				</c:forEach>
				</ul>
			</div>
		
		<div style="margin: 20px;">&nbsp;</div>
		
		<div class="template">
			<div id="templtListDiv">
			<div class="main-menu-bar">
				<h4><span>02</span> <spring:message code="wzwg.sysMngr.word.tmplatDesignChoise" /></h4>
			</div>
							<ul>
							<c:choose>
				<c:when test="${!empty templtList }">
					<c:forEach items="${templtList}" var="resultList" varStatus="status">
								<li>
									<div>
										<a href="javascript:;" onclick="fn_detail('<c:out value="${resultList.templateSeq}" />')">	<%-- <img src="/${resultList.thumbUrl}" width="100%"/> --%><img src="/<c:out value="${resultList.templateStreCours }" />screenshot/<c:out value="${resultList.thumbUrl}" />" width="100%"/></a>
										<%-- <a class="btn-a" href="javascript:;" onclick="fn_detail_edit('${resultList.templateSeq}')"><spring:message code="wzwg.cmm.word.template" /> <spring:message code="wzwg.cmm.word.updt" /></a> --%>
									</div>
									<table>
										<colgroup>
											<col width="50%">
											<col width="50%">
										</colgroup>
										<tr>
											<th><spring:message code="wzwg.sysMngr.word.tmplatNm01" /></th>
											<td><c:out value="${resultList.templateNm}" /></td>
										</tr>
										<%-- <tr>
											<th><spring:message code="wzwg.cmm.word.template" /> <spring:message code="wzwg.cmm.word.cl" /></th>
											<td>${resultList.templateLclNm}/${resultList.templateMclNm}</td>
										</tr> --%>
										<tr>
											<th><spring:message code="wzwg.sysMngr.word.siteCo" /></th>
											<td><c:out value="${resultList.templateCnt}" /><spring:message code="wzwg.cmm.word.count02" /></td>
										</tr>
										<tr>
											<th><spring:message code="wzwg.cmm.word.rgsde" /></th>
											<td><c:out value="${resultList.frstRegistPnttm}" /></td>
										</tr> 
										<tr>
											<th colspan="2"><a href="javascript:;" class="wzbtn btn-basic" onclick="fn_detail('<c:out value="${resultList.templateSeq}" />')"><spring:message code="wzwg.sysMngr.word.detailView"/></a></th> 
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
					<option value="1"><spring:message code="wzwg.sysMngr.word.tmplatNm01" /></option> 
				</select>
				<input type="text" class="txt" name="searchKeyword"/>
				<a href="javascript:void(0);"  onclick="fn_search('1')" class="btn-s"><spring:message code="wzwg.cmm.word.search01" /></a>
		</div>
		</div>
</form>
		
	<div class="ctr-box tem-list01">
		<h4><span>03</span><spring:message code="wzwg.sysMngr.word.tmplatAdd" /><a href="/sysMngr/screen/selectDownloadMasterTempltAjax.do" target="_new" class="wzbtn-table btn-basic" style="margin-left: 10px;"><spring:message code="wzwg.sysMngr.word.masterFileDwld" /></a></h4>
		<div style="padding: 15px 30px;">
          		<form id="mngrZipForm">
          		<input type="hidden" id="templateSeq" name="templateSeq" value="<c:out value="${paramVO.templateSeq }" />">
          		<input type="hidden" name="fileType" value="img">
          		<div style="float: left; width: 80%">
            	<div class="addImgArea" style="height: 34px; border: solid 1px #999; border-radius: 6px; line-height: 34px; position: relative; overflow: hidden;">
            		<div style="position: absolute; width: 100%" ><spring:message code="wzwg.sysMngr.word.clickOrDrag" /></div>
            		<input name="zipFile" id="zipFile" type="file" style="position: absolute; width: 100%; height: 100%; opacity: 0; left: 0;" onchange="fnZipReady(this)"/>
	            	<div id="uploadImgProgressbar" style="position: absolute; height: 100%; left: 0; background: rgba(58, 197, 49, 0.8); text-align: center; width: 0%; color: white; overflow: hidden;">
	            		UPLOADING <span id="uploadImgStatus">0%</span>
	            	</div>
            	</div>
            	<div id="uploadImgNames" style="text-align: left; padding-left: 10px; margin-top: 5px;"></div>
           	</div>
           	<div style="float: left; width: 20%">
           		<button type="button" class="wzbtn btn-black" onclick="fnZipFileUpload()" style="width: 100%; margin: 0 7px; text-align: center;"><spring:message code="wzwg.cmm.word.upload" /></button>
           	</div>
           	</form>
        </div>
	</div>
