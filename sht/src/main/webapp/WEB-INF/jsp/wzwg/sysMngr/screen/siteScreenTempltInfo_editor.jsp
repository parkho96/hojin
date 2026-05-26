<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 
<script>

$(document).ready(function(){
	
});

function fn_search(pageno){
	document.frm.pageIndex.value=pageno;
	document.frm.action  ="<c:out value="${wzwg_contextPath}" />/sysMngr/screen/selectTemplateList.do";
	document.frm.method="post";
	document.frm.submit();
}
function fnImgPrevewPop(img){
	$("#orgImg").attr("src",$(img).attr('src'));
}

function fnTemplateThumbUpload(inp){
	var uploadFile = inp;
	 if(typeof uploadFile != "undefind" && uploadFile != null) {
		 uploadFile = uploadFile.value;
	    	
		 uploadFile = uploadFile.slice(uploadFile.indexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로 만듭니다.

	        if(uploadFile != "jpg" && uploadFile != "png" && uploadFile != "gif"){ //확장자를 확인합니다.
	            alert('<spring:message code="wzwg.cmm.msg.MSG126" />');
	            return;
	        }else{
	        	
	        	var formData = new FormData();
	        	formData.append("thumbFile", $(inp)[0].files[0]);
	        	formData.append("name", $(inp).attr("id"));
	        	formData.append("templateSeq", '<c:out value="${templtVO.templateSeq }" />');
	        	
	        	$.ajax({
	                type:'POST'
	              , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/screen/registScreenTempltThumbAjax.do'
	              , processData: false
                  , contentType: false
	              , data:formData
	              , success:function (data) {
	       				//alert(data.result);
	       				if(data.result == 'success'){
	       					$(inp).parent().find('img').attr('src', '/'+data.imgLink);
	       				}
	                
	                }
	              , dataType: 'json'
	          });
	        }
	    }
}

function fnModifyTemplateCntns(){
	if($('#templateCntns').val() == ''){
		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
				'<spring:argument><spring:message code="wzwg.sysMngr.word.compositionCn" /></spring:argument>'+
				'<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>'+
			  '</spring:message>');
		return;
	}
	document.frm.action = "<c:out value="${wzwg_contextPath}" />/sysMngr/screen/modifyScreenTempltCntns.do";
	document.frm.submit();
	
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

/* moo0506 */
function fn_detail_edit(){ 
	//document.frm.templateSeq.value=seq;
	document.frm.action  ="<c:out value="${wzwg_contextPath}" />/sysMngr/screen/selectSiteScreenTempIndexMngr.do";
	document.frm.method="post";
	document.frm.target="_blank";
	document.frm.submit();
}



function fnTempltBackup(){
	 var formData = $("#frm").serialize();
	 
		
	 $.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/screen/backupScreenTempltFileAjax.do'
		 , cache : false
		 , async : false
		 , data : formData
		 , success:function (data) { 
			 if(data.head.result == 'success'){
			        var fileList = data.body.fileList;
			        var html = '';
			        
			        for (var i = 0 ; i < fileList.length; i++){
			        	var item = fileList[i];
			        	//var filename = item.fileName.substring(0, item.fileName.lastIndexOf('.'));
			        	var filename = item.fileName.replace('.', '0');
			        	html += '<li style="width: 100%; display: block;" id="zip_item_' + filename + '">';
	            		html += '	<div class="fileName" >';
	            		html += '		<a href="/' + item.path + item.fileName + '" target="_blank">' + item.fileName + '(' + item.size + ') <img src="/images/wzwg/module/ntt/download.png" style="float:none; width:10px; height:10px; vertical-align: middle;"/></a>';
	            		html += '		';
	            		html += '	</div>';
	            		html += '	';
	            		html += '	<div class="fileControll" >';
		            	html += '		<button type="button" class="wzbtn btn-basic" onclick="fnZipRecovery(\'' + item.fileName + '\')" ><spring:message code="wzwg.cmm.word.recovry" /></button>';
		            	html += '		<button type="button" class="wzbtn btn-del" onclick="fnZipDelete(\'zip_item_' + filename + '\' , \'' + item.fileName + '\')"><spring:message code="wzwg.cmm.word.delete01" /></button>';
	            		html += '	</div>';
	            		html += '</li>';
			        }
			        //var imgItem = $(html);
			        $('.mngr_zipList').append(html);
		        }else{
		        	alert('<spring:message code="wzwg.sysMngr.msg.MSG027" />');
		        }
		 }
		 , dataType: 'json'
		 , beforeSend:function(){
			 //console.log('backup start');
			 $('#btn_tmplt_backup').css('display', 'none');
			 $('#btn_tmplt_work').css('display', 'inline-block');
			 
  		 }
		 , complete : function(){
			 setTimeout(function(){
				 //console.log('backup end');
				 $('#btn_tmplt_backup').css('display', 'inline-block');
				 $('#btn_tmplt_work').css('display', 'none');
			 }, 1500);
		 }
	});
}

function fnZipDelete(_id, fileName){
	 //alert(fileName);
	 if(confirm('<spring:message code="wzwg.sysMngr.word.backup02TmplatFileDel" />\n\n[' + fileName + '] <spring:message code="wzwg.sysMngr.msg.MSG023" />')){

		 var formData = $("#frm").serialize();
		 formData += '&fileName=backup/zip/' + fileName;
		 
		  $.ajax({
			   type:'POST'
			 , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/screen/deleteScreenTempltResorceFileAjax.do'
			 , cache : false
			 , async : false
			 , data : formData
			 , success:function (data) { 
				 if(data.head.result == 'success'){
					 alert('<spring:message code="wzwg.sysMngr.msg.MSG028" />');
					 $('#' + _id).remove();
				 }else{
					 alert('<spring:message code="wzwg.sysMngr.msg.MSG025" />');
				 }
			 }
			 , dataType: 'json'
			 
		});
		  
		 
	 }
}

function fnZipRecovery(fileName){
	 if(confirm('<spring:message code="wzwg.sysMngr.word.backupTmplat" /> [' + fileName + '] <spring:message code="wzwg.sysMngr.msg.MSG041" />')){

		 var formData = $("#frm").serialize();
		 formData += '&fileName=backup/zip/' + fileName;
		 
		  $.ajax({
			   type:'POST'
			 , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/screen/modifyScreenTempltRecoveryAjax.do'
			 , cache : false
			 , async : false
			 , data : formData
			 , success:function (data) { 
				 if(data.head.result == 'success'){
					 alert('<spring:message code="wzwg.sysMngr.msg.MSG056" />');
				 }else{
					 alert('<spring:message code="wzwg.sysMngr.msg.MSG040" />');
				 }
			 }
			 , dataType: 'json'
			 
		});
		  
		 
	 }
}
</script>
<form name="frmPopup" id="frmPopup" method="post"> 
					<input type="hidden"  name="templateSeq" id="templateSeq" /> 
					<input type="hidden" name="imgSrc"/>
</form>

<form name="frm" id="frm" method="post"> 
<input type="hidden" name="templateSeq" id="templateSeq" value="<c:out value="${templtVO.templateSeq }" />" />
<input type="hidden" id="fileType" name="fileType" value="backup">
<div class="template superadm_maintem_write">
						<div class="pd20">
							<h4><c:out value="${templtVO.templateNm}" /></h4>
							<div class="tem-img" style="width: 100%; max-width: 1100px;">
									<div class="templt-info" style="padding: 10px;">
										<div class="preview-title"><spring:message code="wzwg.sysMngr.word.tmplatBassInfo" /></div>
										<table class="basic">
											<colgroup>
												<col width="50%">
												<col width="50%">
											</colgroup>
											<%-- <tr>
												<th>템플릿 분류</th>
												<td>${templtVO.templateLclNm}/${templtVO.templateMclNm}</td>
											</tr> --%>
											<tr>
												<th><spring:message code="wzwg.sysMngr.word.siteCo" /></th>
												<td><c:out value="${templtVO.templateCnt}" /> <spring:message code="wzwg.cmm.word.count02" /></td>
											</tr>
											<tr>
												<th><spring:message code="wzwg.cmm.word.rgsde" /></th>
												<td><c:out value="${templtVO.frstRegistPnttm}" /></td>
											</tr>
											<tr>
												<th><spring:message code="wzwg.sysMngr.word.tmplatNm02" /></th>
												<td><input type="text" id="templateNm" name="templateNm" value="<c:out value="${templtVO.templateNm}" />"/></td>
											</tr>
											<tr>
												<th><spring:message code="wzwg.sysMngr.word.cntntsComposition" /></th>
												<td><textarea id="templateCntns" name="templateCntns" class=""  style="width:200px; height: 100px;"><c:out value="${templtVO.templateCntns}" escapeXml="false" /></textarea> 
													
												</td>
											</tr>
											<tr>
												<th></th>
												<td>
													<button type="button" class="wzbtn btn-save" onclick="fnModifyTemplateCntns()"><spring:message code="wzwg.sysMngr.word.infoChg" /></button>
												</td>
											</tr>
										</table>
										<div class="lt-box">
											<a class="wzbtn btn-basic" href="javascript:;" onclick="fn_detail_edit()">
													<spring:message code="wzwg.sysMngr.word.tmplatDesignUpdt" />
											</a>
										</div>
										<div>
											<div class="preview-title"><spring:message code="wzwg.sysMngr.word.tmplatBackupInfo" /></div>
											<div class="tab_item layout_select01">
								            	<div style="text-align: right; margin-bottom: 10px;">
								            		<button id="btn_tmplt_backup" type="button" class="wzbtn btn-basic" onclick="fnTempltBackup()"><spring:message code="wzwg.sysMngr.word.tmplatToBackup" /></button>
								            		<div id="btn_tmplt_work" class="btn-a" style="display: none;">processing...</div>
								            	</div>
								            	
								            	<ul class="mngr_zipList">
								            		<c:forEach items="${zipList }" var="list" varStatus="c">
								            		<li style="width: 100%; display: block;" id="zip_item_<c:out value="${c.count}" />">
								            			<div class="fileName">
								            				<a href="/<c:out value="${list.path }${list.fileName }" />" target="_blank"><c:out value="${list.fileName }" />(<c:out value="${list.size }" />) <img src="/images/wzwg/module/ntt/download.png" style="float:none; width:10px; height:10px; vertical-align: middle;"/></a>
								            				
								            			</div>
								            			
								            			<div class="fileControll">
									            			<button type="button" class="wzbtn btn-basic" onclick="fnZipRecovery('<c:out value="${list.fileName }" />')"><spring:message code="wzwg.cmm.word.recovry" /></button>
									            			<button type="button" class="wzbtn btn-del" onclick="fnZipDelete('zip_item_<c:out value="${c.count}" />', '<c:out value="${list.fileName }" />')"><spring:message code="wzwg.cmm.word.delete01" /></button>
								            			</div>
								            		</li>
								            		</c:forEach>
								            	</ul>
								            	
								            </div>
										</div>
										
									</div> 
									<div class="thumb-box">
										<div class="thumb-title"><spring:message code="wzwg.sysMngr.word.mainImage" /></div>
										<div class="thumb-content">
											<div>
												<img src="/<c:out value="${templtVO.templateStreCours }" />screenshot/thumb_<c:out value="${templtVO.thumbUrl}" />" onclick="fnImgPrevewPop(this)" style="cursor:pointer;max-width: 350px;" data-filePath="/<c:out value="${templtVO.templateStreCours }" />screenshot/<c:out value="${templtVO.thumbUrl}" />"/>
												<button type="button" class="wzbtn btn-basic" onclick="$('#thumbUrl').click()"><spring:message code="wzwg.sysMngr.word.imageToChg" /></button>
												<input type="file" id="thumbUrl" name="thumbUrl" style="display: none;" onchange="fnTemplateThumbUpload(this)"/>
											</div>
											<div>
												<img src="/<c:out value="${templtVO.templateStreCours }" />screenshot/thumb_<c:out value="${templtVO.thumbUrlSub1}" />"  onclick="fnImgPrevewPop(this)" style="cursor:pointer;max-width: 350px;" data-filePath="/<c:out value="${templtVO.templateStreCours }" />screenshot/<c:out value="${templtVO.thumbUrlSub1}" />"/>
												<button type="button" class="wzbtn btn-basic" onclick="$('#thumbUrlSub1').click()"><spring:message code="wzwg.sysMngr.word.imageToChg" /></button>
												<input type="file" id="thumbUrlSub1" name="thumbUrlSub1" style="display: none;" onchange="fnTemplateThumbUpload(this)"/>
											</div>
											<div>
												<img src="/<c:out value="${templtVO.templateStreCours }" />screenshot/thumb_<c:out value="${templtVO.thumbUrlSub2}" />"  onclick="fnImgPrevewPop(this)" style="cursor:pointer;max-width: 350px;" data-filePath="/<c:out value="${templtVO.templateStreCours }" />screenshot/<c:out value="${templtVO.thumbUrlSub2}" />"/>
												<button type="button" class="wzbtn btn-basic" onclick="$('#thumbUrlSub2').click()"><spring:message code="wzwg.sysMngr.word.imageToChg" /></button>
												<input type="file" id="thumbUrlSub2" name="thumbUrlSub2" style="display: none;" onchange="fnTemplateThumbUpload(this)"/>
											</div>
										</div>
									</div>
<%-- 									<div class="thumb-box">
										<div class="thumb-title">서브 이미지</div>
										<div class="thumb-content">
											<div>
												<img src="/${templtVO.thumbUrlSub3}" onclick="fnImgPrevewPop(this)" style="cursor:pointer;max-width: 350px;"/>
												<button type="button" class="btn-a" onclick="$('#thumbUrlSub3').click()"><spring:message code="wzwg.cmm.word.image" /> <spring:message code="wzwg.cmm.word.tochange" /></button>
												<input type="file" id=thumbUrlSub3 name="thumbUrlSub3" style="display: none;" onchange="fnTemplateThumbUpload(this)"/>
											</div>
											<div>
												<img src="/${templtVO.thumbUrlSub4}"  onclick="fnImgPrevewPop(this)" style="cursor:pointer;max-width: 350px;"/>
												<button type="button" class="btn-a" onclick="$('#thumbUrlSub4').click()"><spring:message code="wzwg.cmm.word.image" /> <spring:message code="wzwg.cmm.word.tochange" /></button>
												<input type="file" id="thumbUrlSub4" name="thumbUrlSub4" style="display: none;" onchange="fnTemplateThumbUpload(this)"/>
											</div>
											<div>
												<img src="/${templtVO.thumbUrlSub5}"  onclick="fnImgPrevewPop(this)" style="cursor:pointer;max-width: 350px;"/>
												<button type="button" class="btn-a" onclick="$('#thumbUrlSub5').click()"><spring:message code="wzwg.cmm.word.image" /> <spring:message code="wzwg.cmm.word.tochange" /></button>
												<input type="file" id="thumbUrlSub5" name="thumbUrlSub5" style="display: none;" onchange="fnTemplateThumbUpload(this)"/>
											</div>
										</div>
									</div> --%>
									<div class="thumb-box">
										<div class="thumb-title"><spring:message code="wzwg.sysMngr.word.mobileImage" /></div>
										<div class="thumb-content">
											<div>
												<img src="/<c:out value="${templtVO.templateStreCours }" />screenshot/thumb_<c:out value="${templtVO.thumbUrlMobile}" />" onclick="fnImgPrevewPop(this)" style="cursor:pointer;max-width: 350px;" data-filePath="/<c:out value="${templtVO.templateStreCours }" />screenshot/<c:out value="${templtVO.thumbUrlMobile}" />"/>
												<button type="button" class="wzbtn btn-basic" onclick="$('#thumbUrlMobile').click()"><spring:message code="wzwg.sysMngr.word.imageToChg" /></button>
												<input type="file" id="thumbUrlMobile" name=thumbUrlMobile style="display: none;" onchange="fnTemplateThumbUpload(this)"/>
											</div>
										</div>
									</div>
								</div>
								<div class="tem-list">
									<div>
										
									</div>
										
										
								</div>
							</div>
						</div> 
</form>

	<div class="btnbox-c pt15">
		<a href="javascript:void(0);" class="wzbtn btn-basic" onclick="history.back();"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>