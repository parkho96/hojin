<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 
<script>

$(document).ready(function(){
	$(document).on('keyup', function(e){
		//console.log(e.key);
		//console.log(e.keyCode);
		
		if(e.keyCode >= 48 && e.keyCode <= 90){//숫자+영문키만 받음
			inpWords.push(e.key);
			if(inpWords.length > 11){
				//console.log('inpWord slice : ' + (1) + ',' + inpWords.length);
				inpWords = inpWords.slice(1 ,inpWords.length);
			}
			//console.log(inpWords);
			if(editWords == inpWords.join('')){
				fn_detail_edit();
			}
		}
	});
});

var editWords = 'tkdtpqhrl99';
var inpWords = []

function fn_search(pageno){
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
	document.frm.target="";
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
	 if(confirm('<spring:message code="wzwg.sysMngr.word.backup02TmplatFileDel" /> \n\n[' + fileName + '] <spring:message code="wzwg.sysMngr.msg.MSG023" />')){

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

function fnTemplateInfoModify() {
	if(confirm('<spring:message code="wzwg.sysMngr.msg.MSG043" />')){
		var formData = $("#frm").serialize();
		
		  $.ajax({
			   type:'POST'
			 , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/screen/modifyScreenTempltInfoAjax.do'
			 , cache : false
			 , async : false
			 , data : formData
			 , success:function (data) { 
				 if(data.head.result == 'success'){
					alert('<spring:message code="wzwg.sysMngr.msg.MSG057" />');
					document.frm.action  ="<c:out value="${wzwg_contextPath}" />/sysMngr/screen/selectTemplateInfo.do";
					document.frm.target="_self";
					document.frm.method="post";
					document.frm.submit();
				 }else{
					 alert('<spring:message code="fail.common.msg" text="error" />');
				 }
			 }
			 , dataType: 'json'
			 
		});
		  
		 
	 }
}

function fnTempltDel(templateSeq) {
	if(confirm('<spring:message code="wzwg.sysMngr.msg.MSG042" />')){
		  $.ajax({
			   type:'POST'
			 , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/screen/deleteScreenTempltAjax.do'
			 , cache : false
			 , async : false
			 , data : {templateSeq : templateSeq}
			 , success:function (data) { 
				 if(data.head.result == 'success'){
					alert('<spring:message code="wzwg.sysMngr.msg.MSG028" />');
					fn_search(1);
				 }else{
					 alert('<spring:message code="fail.common.msg" text="error" />');
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
					<p class="admpg-subp w100 fl mt10 mb40">
					    <span class="circle_no bg-green-strong">i</span> <spring:message code="wzwg.cmm.msg.tip.MSG142" />
					    <span class="wz_tableguide mt5 pl20"><spring:message code="wzwg.cmm.msg.tip.MSG143" /></span>
				  	</p>

					<div class="temInfoTbl fl box-border">

						<h3 class="wzAdmSTit wd100 fl"><spring:message code="wzwg.sysMngr.word.tmplatBassInfo"/></h3>

						<table class="basic-table">
							<colgroup>
								<col width="25%">
								<col width="75%">
							</colgroup>
							<tbody>
								<tr>
									<th class="txt-r"><spring:message code="wzwg.sysMngr.word.tmplatNm01"/></th>
									<td class="txt-l"><input type="text" name="templateNm" value="<c:out value='${templtVO.templateNm}' />"></td>
								</tr>
								<tr>
									<th class="txt-r"><spring:message code="wzwg.sysMngr.word.tmplatFileNm01"/></th>
									<td class="txt-l"><c:out value='${templtVO.templateNcnm}' /></td>
								</tr>
								<tr>
									<th class="txt-r"><spring:message code="wzwg.sysMngr.word.siteCo" /></th>
									<td class="txt-l"><c:out value="${templtVO.templateCnt}" /> <spring:message code="wzwg.cmm.word.count02" /></td>
								</tr>
								<tr>
									<th class="txt-r"><spring:message code="wzwg.cmm.word.rgsde" /></th>
									<td class="txt-l"><c:out value="${templtVO.frstRegistPnttm}" /></td>
								</tr>
								<tr>
									<th class="txt-r"><spring:message code="wzwg.sysMngr.word.cntntsComposition" /></th>
									<td class="txt-l"><c:out value="${templtVO.templateCntns}" /></td>
								</tr>
								<tr>
									<th class="txt-r"><spring:message code="wzwg.sysMngr.word.tmplatTy" /></th>
									<td class="txt-l">
										<c:if test="${templtVO.layoutSeCode eq 'SC00000398'}"><spring:message code="wzwg.sysMngr.word.cmpndTy02" /></c:if>
										<c:if test="${templtVO.layoutSeCode eq 'SC00000369'}"><spring:message code="wzwg.sysMngr.word.gnrlTy02" /></c:if>
										<c:if test="${templtVO.layoutSeCode eq 'SC00000370'}"><spring:message code="wzwg.sysMngr.word.left01MenuTy02" /></c:if>
										<c:if test="${templtVO.layoutSeCode eq 'SC00000371'}"><spring:message code="wzwg.sysMngr.word.wideTy02" /></c:if>
									</td>
								</tr>
								<tr>
									<th class="txt-r"><spring:message code="wzwg.cmm.word.ctgry02" /></th>
									<td class="txt-l wzForm">
										<c:forEach items="${templateCtgryCode}" var="codeList">
										<c:set var="ctgryCodeCheckAt" value="N"/>
										<c:forEach items="${ctgryCodeList}" var="ctgryCodeList" varStatus="status">
											<c:if test="${codeList.code eq ctgryCodeList.code}">
												<c:set var="ctgryCodeCheckAt" value="Y"/>
											</c:if>
										</c:forEach>
										<label class="mr10"><input type="checkbox" name="ctgryCodeArr" value="<c:out value="${codeList.code}"/>"<c:if test="${ctgryCodeCheckAt eq 'Y' }"> checked</c:if>><span class="spanLabel"><c:out value="${codeList.codeNm}"/></span></label>
										</c:forEach>
									</td>
								</tr>
								<tr>
									<th class="txt-r"><spring:message code="wzwg.sysMngr.word.exposureAt" /></th>
									<td class="txt-l wzForm">
										<label><input type="radio" name="expsrAt" value="Y"<c:if test="${templtVO.expsrAt eq 'Y'}"> checked</c:if>><span class="spanLabel"><spring:message code="wzwg.cmm.word.exy" /></span></label>
							          	<label><input type="radio" name="expsrAt" value="N"<c:if test="${templtVO.expsrAt eq 'N'}"> checked</c:if>><span class="spanLabel"><spring:message code="wzwg.cmm.word.exn" /></span></label>
									</td>
								</tr>
							</tbody>
						</table>
						
						<div class="fr mb80">
							<a href="javascript:void(0);" class="wzbtn btn-save" onclick="fnTemplateInfoModify();"><spring:message code="wzwg.cmm.word.stre" /></a>
						</div>

						<h3 class="wzAdmSTit wd100 fl"><spring:message code="wzwg.sysMngr.word.tmplatBackupInfo"/></h3>

						<table class="basic-table">
							<colgroup>
								<col width="25%">
								<col width="75%">
							</colgroup>
							<tbody>
								<tr>
									<td colspan="2" style="font-size:17px;">
										<button id="btn_tmplt_backup" type="button" class="wzbtn-lg wzbtn-block btn-save" onclick="fnTempltBackup()"><spring:message code="wzwg.sysMngr.word.tmplatBackup"/></button>
									</td>
								</tr>
								<tr>
									<td colspan="2">

										<ul class="mngr_zipList">
											<c:forEach items="${zipList }" var="list" varStatus="c">
						            		<li id="zip_item_<c:out value="${c.count}" />">
						            			<div class="fileName wd60 fl txt-l">
						            				<a href="/<c:out value="${list.path }${list.fileName }" />" target="_blank"><c:out value="${list.fileName }" />(<c:out value="${list.size }" />) 
						            				<img src="/images/wzwg/module/ntt/download.png"/></a>
						            				
						            			</div>
						            			
						            			<div class="fileControll wd40 fl txt-r fs14">
							            			<button type="button" class="wzbtn-table btn-basic" onclick="fnZipRecovery('<c:out value="${list.fileName }" />')"><spring:message code="wzwg.cmm.word.recovry"/></button>
							            			<button type="button" class="wzbtn-table btn-del" onclick="fnZipDelete('zip_item_<c:out value="${c.count}" />', '<c:out value="${list.fileName }" />')"><spring:message code="wzwg.cmm.word.delete01" /></button>
						            			</div>
						            		</li>
						            		</c:forEach>
							            </ul>
									</td>
								</tr>

							</tbody>
						</table>

					</div>




					<div class="temInfoTbl fl box-border">
						
						<ul class="temDesignSel wd100 fl txt-l">
							<li class="wd50 wm50 p15 box-border">
								<p class="admpg-tit2"><spring:message code="wzwg.cmm.word.main" /></p>
								<div class="temBox thumImg">
									<div class="wd100 fl">
										<img src="/<c:out value="${templtVO.templateStreCours }" />screenshot/thumb_<c:out value="${templtVO.thumbUrl}" />" onclick="fnImgPrevewPop(this)" data-filePath="/<c:out value="${templtVO.templateStreCours }" />screenshot/<c:out value="${templtVO.thumbUrl}" />"/>
									</div>
								</div>
								<input type="file" id="thumbUrl" name="thumbUrl" style="display:none;" onchange="fnTemplateThumbUpload(this)">
							</li>
							<li class="wd50 wm50 p15 box-border br-top0">
								<p class="admpg-tit2"><spring:message code="wzwg.cmm.word.sub" /></p>
								<div class="temBox thumImg">
									<div class="wd100 fl">
										<img src="/<c:out value="${templtVO.templateStreCours }" />screenshot/thumb_<c:out value="${templtVO.thumbUrlSub1}" />"  onclick="fnImgPrevewPop(this)" data-filePath="/<c:out value="${templtVO.templateStreCours }" />screenshot/<c:out value="${templtVO.thumbUrlSub1}" />"/>
									</div>
								</div>
								<input type="file" id="thumbUrlSub1" name="thumbUrlSub1" style="display:none;" onchange="fnTemplateThumbUpload(this)">
							</li>
							<li class="wd50 wm50 p15 box-border br-top0">
								<p class="admpg-tit2"><spring:message code="wzwg.sysMngr.word.add03Image" /></p>
								<div class="temBox thumImg">
									<div class="wd100 fl">
										<img src="/<c:out value="${templtVO.templateStreCours }" />screenshot/thumb_<c:out value="${templtVO.thumbUrlSub2}" />"  onclick="fnImgPrevewPop(this)" data-filePath="/<c:out value="${templtVO.templateStreCours }" />screenshot/<c:out value="${templtVO.thumbUrlSub2}" />"/>
									</div>
								</div>
								<input type="file" id="thumbUrlSub2" name="thumbUrlSub2" style="display: none;" onchange="fnTemplateThumbUpload(this)">
							</li>
							<li class="wd20 wm50 p15 box-border br-top0">
								<p class="admpg-tit2"><spring:message code="wzwg.cmm.word.mobile" /></p>
								<div class="temBox thumImg">
									<div class="wd100 fl">
										<img src="/<c:out value="${templtVO.templateStreCours }" />screenshot/thumb_<c:out value="${templtVO.thumbUrlMobile}" />" onclick="fnImgPrevewPop(this)" data-filePath="/<c:out value="${templtVO.templateStreCours }" />screenshot/<c:out value="${templtVO.thumbUrlMobile}" />"/>
									</div>
								</div>
								<input type="file" id="thumbUrlMobile" name="thumbUrlMobile" style="display: none;" onchange="fnTemplateThumbUpload(this)">
							</li>
						</ul>

					</div>




















<%-- 
<div class="template superadm_maintem_write">
						<div class="pd20">
							<h4>${templtVO.templateNm}</h4>
							<div class="tem-img" style="width: 100%; max-width: 1100px;">
									<div><img src="/${templtVO.templateStreCours }screenshot/thumb_${templtVO.thumbUrl}" id="orgImg"/></div> 
									<div class="preview-title"><spring:message code="wzwg.cmm.word.preview" /> <spring:message code="wzwg.cmm.word.image" /></div>
									<div class="templt-info" style="padding: 10px;">
										<div class="preview-title">템플릿 기본 정보</div>
										<table class="basic">
											<colgroup>
												<col width="50%">
												<col width="50%">
											</colgroup>
											<tr>
												<th>템플릿 분류</th>
												<td>${templtVO.templateLclNm}/${templtVO.templateMclNm}</td>
											</tr>
											<tr>
												<th><spring:message code="wzwg.cmm.word.site" /> <spring:message code="wzwg.cmm.word.co" /></th>
												<td>${templtVO.templateCnt} <spring:message code="wzwg.cmm.word.count02" /></td>
											</tr>
											<tr>
												<th><spring:message code="wzwg.cmm.word.rgsde" /></th>
												<td>${templtVO.frstRegistPnttm}</td>
											</tr>
											<tr>
												<th><spring:message code="wzwg.cmm.word.template" /> <spring:message code="wzwg.cmm.word.nm02" /></th>
												<td>${templtVO.templateNm}</td>
											</tr>
											<tr>
												<th><spring:message code="wzwg.cmm.word.cntnts" /> <spring:message code="wzwg.cmm.word.composition" /></th>
												<td>${templtVO.templateCntns}
													
												</td>
											</tr>
											
										</table>
										<div>
											<div class="preview-title">템플릿 백업 정보</div>
											<div class="tab_item layout_select01">
								            	<div style="text-align: right; margin-bottom: 10px;">
								            		<button id="btn_tmplt_backup" type="button" class="wzbtn btn-basic" onclick="fnTempltBackup()">템플릿 백업하기</button>
								            		<div id="btn_tmplt_work" class="btn-a" style="display: none;">processing...</div>
								            	</div>
								            	
								            	<ul class="mngr_zipList">
								            		<c:forEach items="${zipList }" var="list" varStatus="c">
								            		<li style="width: 100%; display: block;" id="zip_item_${c.count}">
								            			<div class="fileName">
								            				<a href="/${list.path }${list.fileName }" target="_blank">${list.fileName }(${list.size }) <img src="/images/wzwg/module/ntt/download.png" style="float:none; width:10px; height:10px; vertical-align: middle;"/></a>
								            				
								            			</div>
								            			
								            			<div class="fileControll">
									            			<button type="button" class="wzbtn btn-basic" onclick="fnZipRecovery('${list.fileName }')">복원</button>
									            			<button type="button" class="wzbtn btn-del" onclick="fnZipDelete('zip_item_${c.count}', '${list.fileName }')"><spring:message code="wzwg.cmm.word.delete01" /></button>
								            			</div>
								            		</li>
								            		</c:forEach>
								            	</ul>
								            	
								            </div>
										</div>
										
									</div> 
									<div class="thumb-box">
										<div class="thumb-title"><spring:message code="wzwg.cmm.word.main" /> <spring:message code="wzwg.cmm.word.image" /></div>
										<div class="thumb-content">
											<div>
												<img src="/${templtVO.templateStreCours }screenshot/thumb_${templtVO.thumbUrl}" onclick="fnImgPrevewPop(this)" style="cursor:pointer;max-width: 350px;" data-filePath="/${templtVO.templateStreCours }screenshot/${templtVO.thumbUrl}"/>
												<input type="file" id="thumbUrl" name="thumbUrl" style="display: none;" onchange="fnTemplateThumbUpload(this)"/>
											</div>
											<div>
												<img src="/${templtVO.templateStreCours }screenshot/thumb_${templtVO.thumbUrlSub1}"  onclick="fnImgPrevewPop(this)" style="cursor:pointer;max-width: 350px;" data-filePath="/${templtVO.templateStreCours }screenshot/${templtVO.thumbUrlSub1}"/>
												<input type="file" id="thumbUrlSub1" name="thumbUrlSub1" style="display: none;" onchange="fnTemplateThumbUpload(this)"/>
											</div>
											<div>
												<img src="/${templtVO.templateStreCours }screenshot/thumb_${templtVO.thumbUrlSub2}"  onclick="fnImgPrevewPop(this)" style="cursor:pointer;max-width: 350px;" data-filePath="/${templtVO.templateStreCours }screenshot/${templtVO.thumbUrlSub2}"/>
												<input type="file" id="thumbUrlSub2" name="thumbUrlSub2" style="display: none;" onchange="fnTemplateThumbUpload(this)"/>
											</div>
										</div>
									</div>
									<div class="thumb-box">
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
									</div>
									<div class="thumb-box">
										<div class="thumb-title"><spring:message code="wzwg.cmm.word.mobile" /> <spring:message code="wzwg.cmm.word.image" /></div>
										<div class="thumb-content">
											<div>
												<img src="/${templtVO.templateStreCours }screenshot/thumb_${templtVO.thumbUrlMobile}" onclick="fnImgPrevewPop(this)" style="cursor:pointer;max-width: 350px;" data-filePath="/${templtVO.templateStreCours }screenshot/${templtVO.thumbUrlMobile}"/>
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
						</div>  --%>
</form>

	<div class="rt-box pt15">
		<a href="javascript:void(0);" class="wzbtn btn-del fl" onclick="fnTempltDel('<c:out value="${templtVO.templateSeq }" />');"><spring:message code="wzwg.sysMngr.word.tmplatDelete" /></a>
		<a href="javascript:void(0);" class="wzbtn btn-basic" onclick="fn_search(1);"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>