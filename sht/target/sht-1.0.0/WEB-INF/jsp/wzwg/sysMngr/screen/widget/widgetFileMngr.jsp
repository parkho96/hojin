<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 

 <link rel="stylesheet" href="/css/wzwg/site/mngr/popupzone.css" type="text/css" />
 <noscript><link rel="stylesheet" href="/jquery/css/jquery.fileupload-ui-noscript.css"></noscript>

 <script>
 
 $(document).ready(function(e){
 	$('#modal-fileMngr').draggable({ handle: "#modal-fileMngr-move-handler" });
 	$("#modal-fileMngr-move-handler").css('cursor', 'move');
 });
 
 
 function fnImgPrevewPop(id){
		var imgsrc = $('#' + id).attr('src');

		
		var width = $('#' + id)[0].naturalWidth;
		var height = $('#' + id)[0].naturalHeight;
		var frm = document.frmImgPreview;
		frm.imgSrc.value = imgsrc;
		
 	
		var frmResult = window.open("", "popForm", "width=" + width + ",height=" + height + ",toolbars=no,menubars=no,scrollbars=yes,left=50,top=400");
		
		frm.target='popForm';
		frm.action='/sample/img/imgViewer.jsp';
		frm.submit();
 }
 
 function fnImgReady(inp){
	 var fileNames ='';
	 //console.log($(inp)[0].files);
	 var fileCnt = $(inp)[0].files.length;
	 
	 
	 for(var i = 0 ; i < fileCnt ; i++){
		 var nm = $(inp)[0].files[i].name;
		 if(filenameHanChk(nm) == false){
			alert(wz_msg('wzwg.sysMngr.msg.MSG020'));
			return;
		 }
		 
		 if(!rFilter.test($(inp)[0].files[i].type)) {
			alert(wz_msg('wzwg.sysMngr.msg.MSG021'));
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
 
 var rFilter = /^(image\/bmp|image\/gif|image\/jpg|image\/jpeg|image\/png)$/i;
// var nameCheck = /[0-9]|[a-z]|[A-Z]/;
// var nameCheck = /^[_.A-Za-z0-9+]*$/;
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
 
 function fnImgUpload(){
	 
	 var fileCnt = $('#imgfiles')[0].files.length;
	 
	 for(var i = 0 ; i < fileCnt ; i++){
		 if (!rFilter.test($('#imgfiles')[0].files[i].type)) {
				alert(wz_msg('wzwg.sysMngr.msg.MSG021'));
				return;
			}	 
		 //var filename = $('#imgfiles')[0].files[i].name;
	 	
	 }
	 
	 
	 
	 $('#mngrImgForm').ajaxForm({
		    type:'POST'
		    , url:'/sysMngr/screenHidden/registWidgetImageFileAjax.do'
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
			        $('#uploadImgNames').html("upload complate");
			        var fileList = data.body.fileList;
			        var html = '';
			        
			        for (var i = 0 ; i < fileList.length; i++){
			        	var item = fileList[i];
			        	//var filename = item.fileName.substring(0, item.fileName.lastIndexOf('.'));
			        	var filename = item.fileName.replace('.', '0');
				        html += '<li style="width: 100%; display: block;" id="img_item_' + filename + '">                                                                                                                    ';
		        		html += '	<div class="fileName" style="float: left; width: 50%; line-height: 34px;">                                                                                ';
		        		html += '		' + item.path + '<span class="fileHighright" style="color: blue; font-weight: bold;">' + item.fileName + '</span>                                            ';
		        		html += '		                                                                                                                                                      ';
		        		html += '	</div>                                                                                                                                                    ';
		        		html += '	<div class="fileImgView" style="float: left; width: 20%;  overflow: hidden; height: 34px; line-height: 34px; text-align: center;"> ';
		        		html += '		<img src="' + item.path + item.fileName + '" style="max-height: 34px; width: auto; vertical-align: middle; background: #eee;" id="tmp_img_' + filename + '">                                ';
		        		html += '	</div>                                                                                                                                                    ';
		        		html += '	<div class="fileControll" style="float: left; width: 29%;">                                                                                               ';
		            	html += '		<button type="button" class="wzbtn btn-basic" onclick="fnImgPrevewPop(\'tmp_img_' + filename + '\')">' + wz_msg('wzwg.cmm.word.preview') + '</button>          ';
		            	html += '		<button type="button" class="wzbtn btn-del" onclick="fnImgDelete(\'img_item_' + filename + '\' , \'' + item.fileName + '\')">' + wz_msg('wzwg.cmm.word.delete01') + '</button>                                                        ';
		        		html += '	</div>                                                                                                                                                    ';
		        		html += '</li>                                                                                                                                                        ';
			        }
			        //var imgItem = $(html);
			        $('.mngr_imgList').prepend(html);
		        }else{
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
	 
	 $('#mngrImgForm').submit();
 }
 
 //var bar = $('.bar');
 //var percent = $('.percent');
 //var status = $('#status');
 
 function fnImgDelete(_id, fileName){
	 //alert(fileName);
	 if(confirm(wz_msg('wzwg.sysMngr.msg.MSG022') + '\n\n[' + fileName + '] '+ wz_msg('wzwg.sysMngr.msg.MSG023'))){

		 var formData = $("#mngrImgForm").serialize();
		 formData += '&fileName=' + fileName;
		 
		  $.ajax({
			   type:'POST'
			 , url:'/sysMngr/screenHidden/deleteWidgetImageFileAjax.do'
			 , cache : false
			 , async : false
			 , data : formData
			 , success:function (data) { 
				 if(data.head.result == 'success'){
					 alert(wz_msg('wzwg.sysMngr.msg.MSG024'));
					 $('#' + _id).remove();
				 }else{
					 alert(wz_msg('wzwg.sysMngr.msg.MSG025'));
				 }
			 }
			 , dataType: 'json'
		});
		  
		 
	 }
 }
 
 function fnLoadTempltCss(cssPath, fileName){
	 var tmpCss = $('<div></div>');
	 $(tmpCss).load(cssPath, function(){
		 $('#cssEdit').val($(this).html());
		 $(this).remove();
		 $('#cssFileName').val(fileName);
	 });
	 
	 
 }
 
 function fnCssEditViewToggle(){
	 if($('#cssEditView').css('position') == 'fixed'){
		 $('#cssEditView').css('position', '');
		 $('#cssEdit').css('height', '300px');
		 $('body').css('overflow', '');
	 }else{
		 var h = $(window).height() - 25;
		 $('#cssEdit').css('height', h + 'px');
		 $('#cssEditView').css('position', 'fixed');
		 $('body').css('overflow', 'hidden');
	 }
 }
 
 function fnCssSave(){
	 var formData = $("#mngrCssForm").serialize();
	 
	
	 $.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/screen/registScreenTempltCssAjax.do'
		 , cache : false
		 , async : false
		 , data : formData
		 , success:function (data) { 
			 if(data.head.result == 'success'){
				 alert(wz_msg('wzwg.sysMngr.msg.MSG003'));
			 }
		 }
		 , dataType: 'json'
	});
 }
 
 function fnTempltBackup(){
	 var formData = $("#mngrBackupForm").serialize();
	 
		
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
	            		html += '	<div class="fileName" style="float: left; width: 70%; line-height: 34px;">';
	            		html += '		' + item.fileName + '(' + item.size + ')';
	            		html += '		';
	            		html += '	</div>';
	            		html += '	';
	            		html += '	<div class="fileControll" style="float: left; width: 29%;">';
		            	html += '		<a class="btn-a" href="/' + item.path + item.fileName + '" target="_blank">다운로드</a>';
		            	html += '		<button type="button" class="btn-b" onclick="fnZipDelete(\'zip_item_' + filename + '\' , \'' + item.fileName + '\')">' + wz_msg('wzwg.cmm.word.delete01') + '</button>';
	            		html += '	</div>';
	            		html += '</li>';
			        }
			        //var imgItem = $(html);
			        $('.mngr_zipList').prepend(html);
		        }else{
		        	alert(wz_msg('wzwg.sysMngr.msg.MSG027'));
		        }
		 }
		 , dataType: 'json'
		 , beforeSend:function(){
			 //console.log('backup start');
			 $('#btn_tmplt_backup').hide();
			 $('#btn_tmplt_work').show();
			 
   		 }
		 , complete : function(){
			 setTimeout(function(){
				 //console.log('backup end');
				 $('#btn_tmplt_backup').show();
				 $('#btn_tmplt_work').hide();
			 }, 1500);
		 }
	});
 }
 
 function fnZipDelete(_id, fileName){
	 //alert(fileName);
	 if(confirm(wz_msg('wzwg.sysMngr.word.backup02TmplatFileDel') + '\n\n[' + fileName + '] ' + wz_msg('wzwg.sysMngr.msg.MSG023'))){

		 var formData = $("#mngrBackupForm").serialize();
		 formData += '&fileName=backup/zip/' + fileName;
		 
		  $.ajax({
			   type:'POST'
			 , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/screen/deleteScreenTempltResorceFileAjax.do'
			 , cache : false
			 , async : false
			 , data : formData
			 , success:function (data) { 
				 if(data.head.result == 'success'){
					 alert(wz_msg('wzwg.sysMngr.msg.MSG028'));
					 $('#' + _id).remove();
				 }else{
					 alert(wz_msg('wzwg.sysMngr.msg.MSG025'));
				 }
			 }
			 , dataType: 'json'
			 
		});
		  
		 
	 }
 }
</script>
								
<form id="frmImgPreview" name="frmImgPreview" style="display: none;" method="post">
	<input type="hidden" name="imgSrc"/>
</form>

				<div class="pop-conts">
					 <div class="pop-tab fileMngr">
					 		<p class="admpg-subp w100 fl txt-l mb15 mt15 pl20">
								<span class="circle_no bg-red-strong">i</span>
								<span><spring:message code="wzwg.sysMngr.msg.MSG029" /></span><br>
							 </p>
				            <input id="tab_img" type="radio" name="add_layer_tab" checked="checked"/>
				            <!-- <input id="tab_backup" type="radio" name="add_layer_tab" style="display: none;"/> -->
				            <section class="buttons">
				                <label for="tab_img">IMG</label>
				                <!-- <label for="tab_backup">BACKUP</label> -->
				            </section>
							
		
		
							<!-- IMG 탭 -->
				            <div class="tab_item layout_select01">
				            	<div style="padding: 15px 30px;">
				            		<form id="mngrImgForm">
									
									<input type="hidden" name="layoutcntntsSeq" value="<c:out value="${paramVO.layoutcntntsSeq}" />">
									<input type="hidden" name="layoutcntntsworkSeq" value="<c:out value="${paramVO.layoutcntntsworkSeq}" />">
									
				            		<input type="hidden" name="fileType" value="img">
				            		<div style="float: left; width: 80%">
						            	<div class="addImgArea" style="height: 34px; border: solid 1px #999; border-radius: 6px; line-height: 34px; position: relative; overflow: hidden;">
						            		<div style="position: absolute; width: 100%" ><spring:message code="wzwg.sysMngr.word.imgAtchClickOrDrag" /></div>
						            		<input name="imgfiles" id="imgfiles" type="file" style="position: absolute; width: 100%; height: 100%; opacity: 0; left: 0;" multiple="multiple" onchange="fnImgReady(this)"/>
							            	<div id="uploadImgProgressbar" style="position: absolute; height: 100%; left: 0; background: rgba(58, 197, 49, 0.8); text-align: center; width: 0%; color: white; overflow: hidden;">
							            		UPLOADING <span id="uploadImgStatus">0%</span>
							            	</div>
						            	</div>
						            	<div id="uploadImgNames" style="text-align: left; padding-left: 10px; margin-top: 5px;"></div>
					            	</div>
					            	<div style="float: left; width: 20%">
					            		<button type="button" class="wzbtn btn-black" onclick="fnImgUpload()"><spring:message code="wzwg.cmm.word.upload" /></button>
					            	</div>
					            	</form>
				            	</div>
				            	<ul class="mngr_imgList">
				            		<c:forEach items="${imgList }" var="list" varStatus="c">
				            		<li style="width: 100%; display: block;" id="img_item_<c:out value="${c.count}" />">
				            			<div class="fileName" style="float: left; width: 50%; line-height: 34px;">
				            				<c:out value="${list.path }" /><span class="fileHighright" style="color: blue; font-weight: bold;"><c:out value="${list.fileName }" /></span>
				            				
				            			</div>
				            			<div class="fileImgView" style="float: left; width: 20%; overflow: hidden; height: 34px; line-height: 34px; text-align: center;">
				            				<img src="<c:out value="${list.path }${list.fileName }" />" style="max-height: 34px; width: auto; vertical-align: middle; background: #eee;" id="tmp_img_<c:out value="${c.count }" />">
				            			</div>
				            			<div class="fileControll" style="float: left; width: 29%;">
					            			<button type="button" class="wzbtn btn-basic" onclick="fnImgPrevewPop('tmp_img_<c:out value="${c.count }" />')"><spring:message code="wzwg.cmm.word.preview" /></button>
					            			<button type="button" class="wzbtn btn-del" onclick="fnImgDelete('img_item_<c:out value="${c.count }" />', '<c:out value="${list.fileName }" />')"><spring:message code="wzwg.cmm.word.delete01" /></button>
				            			</div>
				            		</li>
				            		</c:forEach>
				            	</ul>
				            </div>		
				            
				            
				            
				            
				     </div>
		
		
		
				</div>
