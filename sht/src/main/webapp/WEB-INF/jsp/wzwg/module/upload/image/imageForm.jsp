<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 

    
    <!-- blueimp Gallery styles -->
    <link rel="stylesheet" href="/jquery/css/gallery.min.css">
    
    <!-- CSS to style the file input field as button and adjust the Bootstrap progress bars -->
    <link rel="stylesheet" href="/jquery/css/jquery.fileupload.css">
    <link rel="stylesheet" href="/jquery/css/jquery.fileupload-ui.css">
    
    <!-- CSS adjustments for browsers with JavaScript disabled -->
    <noscript><link rel="stylesheet" href="/jquery/css/jquery.fileupload-noscript.css"></noscript>
    <noscript><link rel="stylesheet" href="/jquery/css/jquery.fileupload-ui-noscript.css"></noscript>
    
    <style type="text/css">
        
        body {padding-top: 60px;}
    
        .fc {float:center;}
        .fl {float:left;}
        .fr {float:right;}
        
    </style>
    
    <!-- The template to display files available for upload -->
    <script id="template-upload" type="text/x-tmpl">
    {% for (var i=0, file; file=o.files[i]; i++) { %}
        <tr class="template-upload fade">
            <td>
                <span class="preview" style="width:32px;height:32px;"></span>
            </td>
            <td>
                {%=file.name%}
                <strong class="error text-danger"></strong>
            </td>
   			<!--
         	<td>
                Processing...
                <div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="progress-bar progress-bar-success" style="width:0%;"></div></div>
            </td>
			-->
            <td style='text-align:right;'>
                {% if (!i && !o.options.autoUpload) { %}
                    <button class="btn btn-primary start" disabled>
                        <i class="glyphicon glyphicon-upload"></i>
                        <a href="javascript:void(0);"><span class="btn btn_primary btn_xs"><spring:message code="wzwg.cmm.word.upload" /></span></a>
                    </button>
                {% } %}

                {% if (!i) { %}
                    <button class="btn btn-warning cancel">
                        <i class="glyphicon glyphicon-ban-circle"></i>
                        <a href="javascript:void(0);"><span class="btn btn_warning btn_xs"><spring:message code="wzwg.cmm.word.cancl" /></span></a>
                    </button>
                {% } %}
            </td>
        </tr>
    {% } %}
    </script>
    
    <!-- The template to display files available for download -->
    <script id="template-download" type="text/x-tmpl">
    {% for (var i=0, file; file=o.files[i]; i++) { %}
        <tr class="template-download fade">
            <td>
                <span class="preview">
                    {% if (file.thumbnailUrl) { %}
                        <a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" data-gallery><img src="{%=file.thumbnailUrl%}"></a>
                    {% } %}
                </span>
            </td>
            <td>
				{% if (file.url) { %}
					<a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" {%=file.thumbnailUrl?'data-gallery':''%}>{%=file.name%}</a>
				{% } else { %}
					<span>{%=file.name%}</span>
				{% } %}

                {% if (file.error) { %}
                    <div><span class="label label-danger">Error</span> {%=file.error%}</div>
                {% } %}
            </td>
            <td colspan="2">
                <span class="size">{%=o.formatFileSize(file.size)%}</span>
            </td>
        </tr>
    {% } %}
    </script>
    
    <!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
    <script src="/jquery/js/vendor/jquery.ui.widget.js"></script>
    
    <!-- The Templates plugin is included to render the upload/download listings -->
    <script src="/jquery/js/tmpl.min.js"></script>
    
    <!-- The Load Image plugin is included for the preview images and image resizing functionality -->
    <script src="/jquery/js/load-image.all.min.js"></script>
    
    <!-- The Canvas to Blob plugin is included for image resizing functionality -->
    <script src="/jquery/js/canvas-to-blob.min.js"></script>
    
    <!-- Bootstrap JS is not required, but included for the responsive demo navigation -->
    <!-- <script src="/bootstrap/js/bootstrap.js"></script> -->
    
    <!-- blueimp Gallery script -->
    <!-- <script src="/jquery/js/jquery.blueimp-gallery.min.js"></script> -->
    
    <!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
    <script src="/jquery/js/jquery.iframe-transport.js"></script>
    
    <!-- The basic File Upload plugin -->
    <script src="/jquery/js/jquery.fileupload.js"></script>
    
    <!-- The File Upload processing plugin -->
    <script src="/jquery/js/jquery.fileupload-process.js"></script>
    
    <!-- The File Upload image preview & resize plugin -->
    <script src="/jquery/js/jquery.fileupload-image.js"></script>
    
    <!-- The File Upload audio preview plugin -->
    <script src="/jquery/js/jquery.fileupload-audio.js"></script>
    
    <!-- The File Upload video preview plugin -->
    <script src="/jquery/js/jquery.fileupload-video.js"></script>
    
    <!-- The File Upload validation plugin -->
    <script src="/jquery/js/jquery.fileupload-validate.js"></script>
    
    <!-- The File Upload user interface plugin -->
    <script src="/jquery/js/jquery.fileupload-ui.js"></script>
    
    <!-- The main application script -->
    <script src="/jquery/js/main.js"></script>

    <style>
        /* css reset */
        body,div,p,h1,h2,h3,h4,h5,h6,ul,ol,li,dl,dt,dd,table,th,td,form,fieldset,legend,input,textarea,button,select{margin:0;padding:0}
        address,caption,cite,code,dfn,em,var {font-style:normal;font-weight:normal}
        body,th,td,input,select,textarea,button {font-size:12px;/*line-height:1.25em*/}
        ul, ol, li{list-style: none}
        fieldset, img {border: none}
        /* input, select, img {vertical-align:middle;} */
        input, select{font-family:NanumGothic;font-size:12px; color:#888; font-weight:normal;} 
        button {border:0 none;background-color:transparent;cursor:pointer}
        body{-webkit-text-size-adjust:none;height:100%}
        body a {color:#000;text-decoration: none;}
        body a:hover, body a:active,body a:focus {text-decoration: none;}
        table {margin:0;padding:0;border-spacing:0;border-collapse:collapse;border:0;word-break:break-all;word-wrap:break-word;}
        td {text-align:left;}
        /* hr {display:none} */
        caption, legend{position:absolute;width:0;height:0;overflow:hidden;visibility:hidden;display: none;text-indent:-9999px;font-size:0;}
                
                
        .sub-modal-header{cursor: move;}
    </style>

	<script>
	
    
		var pageLoaded = 0; //현재 페이지
		
		var _prevImgSrc = ''; //기존 선택 이미지 주소
		var _selectImgSrc = ''; //선택 이미지 주소
		
		$(document).ready(function(){
			 
			 $("#cancle_btn").click(function (){
		    	$('body').css({overflow:'auto'});
		    	$("#bbs_layer").html("");
		   		$('#bbs_layer').hide();	
			});	
			
			$("#close_btn").click(function (){
		    	$('body').css({overflow:'auto'});
		    	$('#imgDiv').hide();
			});	
			
			
			var form = document.getElementById("fileupload");
			var formData = new FormData(form);

			$.ajax({
		        type:'POST'
		      , url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/image/selectFolderList.do?mode=<c:out value="${param.mode}" />&id=<c:out value="${param.id}" />'
			  , processData: false
			  , contentType: false
		      , data : formData
		      , mimeType: 'multipart/form-data'
		      , success:function (data) {
		    	  $('#folder_area').html(data);
		      }
		      , error:function (data) {
		          alert('<spring:message code="wzwg.module.word.foldererror" />');
		      }
		      , dateType: 'html'
		 	});
			
			$.ajax({
		        type:'POST'
		      , url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/image/selectImageList.do?mode=<c:out value="${param.mode}" />&id=<c:out value="${param.id}" />'
			  , processData: false
			  , contentType: false
		      , data : formData
		      , mimeType: 'multipart/form-data'
		      , success:function (data) {
		    	  $('#image_area').html(data);
		    	  fnSelectImgDeco(_prevImgSrc);
		      }
		      , error:function (data) {
		          alert('<spring:message code="wzwg.module.word.imageerror" />');
		      }
		      , dateType: 'html'
		 	});
			
			$('#modal-img-content-box').draggable({ handle: ".sub-modal-header" });
			
			$('#image_scroll').scroll( function() {
				
				if ($('#image_scroll').scrollTop() == $('#image_scroll').prop("scrollHeight") - $('#image_scroll').height()) {
					
					pageLoaded = pageLoaded + 1; 
					
					var searchSiteSeq = $('#searchSiteSeq').val();
					var searchFolderId = $('#imgfolderId').val();
					
					// ajax를 추가해서 목록을 받아온다
					$.post("<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/image/selectImageList.do?mode=<c:out value="${param.mode}" />&id=<c:out value="${param.id}" />&searchSiteSeq="+searchSiteSeq+"&searchFolderId="+searchFolderId+"&scrollPageIdx="+pageLoaded,
			            function(data){
			                if (data != ""){
			                	  if (data.indexOf("<a") >-1){
			                		$('#image_area').append(data);
			                	 }
			                	fnSelectImgDeco();
			                }
			            }
			        );
				}
				
			});
			
			
			//미리보기 기능 추가 2021.06.18 조원권
			if(typeof selectDiv != 'undefined'){
				if($(selectDiv).is('img')){
					//$('#prevImg').attr('src', $(selectDiv).attr('src'));
					_prevImgSrc = $(selectDiv).attr('src');
					_selectImgSrc = _prevImgSrc;
				}else{
					$('#prevImg').attr('src', selectDiv.find('img').attr('src'));
					_prevImgSrc = selectDiv.find('img').attr('src');
					_selectImgSrc = _prevImgSrc;
				}
			}
			
			
			
		}); 
		 
		 function fnDeleteImage(usrimgId, imageStreCours, streImageNm){
			
			if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
				return;	
			}else{
				
				document.getElementById('usrimgId').value = usrimgId;
				document.getElementById('imageStreCours').value = imageStreCours;
				document.getElementById('streImageNm').value = streImageNm;
				 
				var form = document.getElementById("fileupload");
				var formData = new FormData(form);
				
				$.ajax({
					type:'POST'
					, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/image/deleteImage.do'
					, processData: false
					, contentType: false
					, data : formData
					, mimeType: 'multipart/form-data'
					, success:function (result) {
						
						var value = "";
						
						$(result).find("value").each(function() {  
							value = $(this).text();  
						});
						
						if(value == 'success'){
							$.ajax({
						        type:'POST'
						      , url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/image/selectImageList.do?mode=<c:out value="${param.mode}" />&id=<c:out value="${param.id}" />'
							  , processData: false
							  , contentType: false
						      , data : formData
						      , mimeType: 'multipart/form-data'
						      , success:function (data) {
						    	  $('#image_area').html(data);
						    	  fnSelectImgDeco();
						      }
						      , error:function (data) {
						          alert('<spring:message code="wzwg.module.word.imageerror" />');
						      }
						      , dateType: 'html'
						 	});
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
						}
						
					}
					, error:function (data) {
						alert('<spring:message code="wzwg.module.word.imageerror" />');
					}
					, dateType: 'html'
				});
				
			}
		 }
			        
		 function fnImageLayer(){
			var form = document.getElementById("fileupload");
			
			var searchFolderId = $('#imgfolderId').val();
			var formData = new FormData(form);
			
			$.ajax({
				type:'POST'
				, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/image/selectFolderList.do?mode=<c:out value="${param.mode}" />&id=<c:out value="${param.id}" />'
				, processData: false
				, contentType: false
				, data : formData
				, mimeType: 'multipart/form-data'
				, success:function (data) {
					$('#folder_area').html(data);
				}
				, error:function (data) {
					alert('<spring:message code="wzwg.module.word.foldererror" />');
				}
				, dateType: 'html'
		 	});
				
			$.ajax({
				type:'POST'
				, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/image/selectImageList.do?mode=<c:out value="${param.mode}" />&id=<c:out value="${param.id}" />&searchFolderId='+searchFolderId
				, processData: false
				, contentType: false
				, data : formData
				, mimeType: 'multipart/form-data'
				, success:function (data) {
					$('#image_area').html(data);
					fnSelectImgDeco();
				}
				, error:function (data) {
					alert('<spring:message code="wzwg.module.word.imageerror" />');
				}
				, dateType: 'html'
			});
			
			alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.word.upload" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.compt" /></spring:argument></spring:message>');
			
		 }
		 
		 function fnSearchSiteFolder(val){
			var form = document.getElementById("fileupload");
			
			form.searchSiteSeq.value = val;
			
			var formData = new FormData(form);
			
			$.ajax({
				type:'POST'
				, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/image/selectFolderList.do?mode=<c:out value="${param.mode}" />&id=<c:out value="${param.id}" />'
				, processData: false
				, contentType: false
				, data : formData
				, mimeType: 'multipart/form-data'
				, success:function (data) {
					$('#folder_area').html(data);
				}
				, error:function (data) {
					alert('<spring:message code="wzwg.module.word.foldererror" />');
				}
				, dateType: 'html'
		 	}); 
			
			$.ajax({
				type:'POST'
				, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/image/selectImageList.do?mode=<c:out value="${param.mode}" />&id=<c:out value="${param.id}" />&scrollPageIdx=0'
				, processData: false
				, contentType: false
				, data : formData
				, mimeType: 'multipart/form-data'
				, success:function (data) {
					$('#image_area').html(data);
					fnSelectImgDeco();
				}
				, error:function (data) {
					alert('<spring:message code="wzwg.module.word.imageerror" />');
				}
				, dateType: 'html'
			});
		 }
		 
		 /*
		 function selectImgAppend(){
			 var link = $('#selectImg').attr('src');
			 
			 if(_mode == '1'){	addImg(link);
				 
			 }else if(_mode == '2'){ 	addImgSilder(link, _ele);
				 
			 }else if(_mode == '3'){	setBackgroundImg(link, _ele);
				 
			 }else if(_mode == '4'){	addImgTop(link, _ele);
				 
			 }else if(_mode == '5'){	mainImgSilder(link, _ele);
				 
			 }else if(_mode == '6'){	mainBanner(link, _ele);
				 
			 }else if(_mode == '7'){	mainImgBootSilder(link, _ele);
				 
			 }else if(_mode == '999'){	mainBannerAll(link, _ele);
				 
			 }else if(_mode == '990'){	addImgTarget(link, _ele);
			 
			 }else if(_mode == '100'){	addImgEditor(link, _paramId);
			 }
			 
			 wzModalClose();
			 
		 }
		 
		 var _ele, _mode, _paramId; 
		 function selectImgLoad(link, ele, mode, paramId){
			 _ele = ele;
			 _mode = mode;
			 _paramId = paramId;
			 $('#selectImg').attr('src', link);
			 $('#btn-acceptImg').fadeIn(200);
		 }
		 
		 */
		 
		 function selectImgLoad(link, _ele, _mode, _paramId){
			 //_ele = ele;
			 //_mode = mode;
			 //_paramId = paramId;
			 //$('#selectImg').attr('src', link);
			 //$('#btn-acceptImg').fadeIn(200);
			 
			 if(_mode == '1'){	addImg(link);
			 
			 }else if(_mode == '2'){ 	addImgSilder(link, _ele);
				 
			 }else if(_mode == '3'){	setBackgroundImg(link, _ele);
				 
			 }else if(_mode == '4'){	addImgTop(link, _ele);
				 
			 }else if(_mode == '5'){	mainImgSilder(link, _ele);
				 
			 }else if(_mode == '6'){	mainBanner(link, _ele);
				 
			 }else if(_mode == '7'){	mainImgBootSilder(link, _ele);
				 
			 }else if(_mode == '999'){	mainBannerAll(link, _ele);
				 
			 }else if(_mode == '990'){	addImgTarget(link, _ele);
			 
			 }else if(_mode == '100'){	addImgEditor(link, _paramId);
			 }
			 
			 var toastOption = {'accAt' : false, 'timeOut' : 1000};
			 wzToast(wz_msg('wzwg.cmm.msg.screen.MSG028'), toastOption);
			 _selectImgSrc = link;
			 fnSelectImgDeco();
			 
		 }
		 
		 function fnRestoreImg(){
			 console.log(selectDiv);
			 if($(selectDiv).is('img')){
				 $(selectDiv).attr('src', _prevImgSrc);
			 }else{
				 $(selectDiv).find('img').attr('src', _prevImgSrc);
			 }
		 }
		 
		 function fnSelectImgDeco(link){
			 var imgSrc = '';
			 if(link != undefined){
				 imgSrc = link;
			 }else{
				 imgSrc = _selectImgSrc;
			 }
			 //console.log('fnSelectImgDeco v2: (' + imgSrc + ')');
			 var selImg = $('#image_area img').filter('[src="' + imgSrc + '"]');
			 //console.log(selImg);
			 if(selImg.length == 1){
				 $('#image_area td').removeClass('br-blue-strong');
				 $('#image_area td').css('border-style', '');
				 
				 var parentTD = selImg.parent().parent().parent();
				 parentTD.addClass('br-blue-strong');
				 parentTD.css('border-style', 'solid');
			 }
		 }
		 
		 function fnImgSizeView(img){
			var h = img.naturalHeight;
	  		var w = img.naturalWidth;
	  		var p = $('<p></p>');
	  		p.html(w + 'x' + h);
	  		$(img).parent().parent().parent().find('.i-size-data').html(p);
		 }
		 
	</script>
		
    
    <form:form modelAttribute="paramVO" paht="fileupload" id="fileupload" name="fileupload" method="post"  enctype="multipart/form-data">
        <form:hidden path="siteSeq" />
        <form:hidden path="usrimgId" />
        <form:hidden path="imageStreCours"/>
        <form:hidden path="streImageNm"  />
		<form:hidden path="imgfolderId"  />
		<form:hidden path="imgfolderNm" />
		<form:hidden path="imagePath" value="/upload/image/" />
        <form:hidden path="searchSiteSeq" />
        <form:hidden path="parntsImgfolderId" />
        
        	<div class="modal-img-content-box">
					<div class="topGuideBox">
						<div>
						<c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
							<span class="mr10"><spring:message code="wzwg.module.word.searchsitechoise" /></span>
					        <select id="selSiteSeq" class="w40" onchange="fnSearchSiteFolder(this.value);">
					        	<c:forEach var="resultList" items="${searchSiteList}">
					        		<option value="<c:out value="${resultList.siteSeq}" />"><c:out value="${resultList.siteFullNm}" /> ( <c:out value="${resultList.siteUrl}" /> )</option>
					        	</c:forEach>
					        </select>
				        </c:if>
				        </div>
				        
				       <!-- 
				        <div>
				        	※ <spring:message code="wzwg.cmm.msg.MSG095" />
				        </div>
				         -->
				        <div class="red linehgt130 fs15"> 
				        	<c:if test="${param.mode eq '990' or param.mode eq '6'}">
								<%-- 화면편집 모드에서만 노출 --%>
								<p>
									<span class="circle_no bg-red-strong">!</span>
									<spring:message code="wzwg.cmm.msg.tip.MSG056"></spring:message>
								</p>
								<p>
									<span class="circle_no bg-red-strong">!</span>
									<spring:message code="wzwg.cmm.msg.tip.MSG057"></spring:message>
								</p>
								<p>
									<span class="circle_no bg-red-strong">!</span>
									<spring:message code="wzwg.cmm.msg.tip.MSG157"></spring:message>
								</p>
																						
								<button type="button" class="wzbtn-table btn-undo" onclick="fnRestoreImg()"><spring:message code="wzwg.cmm.msg.tip.MSG058"></spring:message></button>
							</c:if>
				       </div>
				         
				         
					</div>
					
					<div class="wd100 prevBox mt10 mb20">
						
						<div style="width:100%; height:auto; position:relative;" class="i-block vert-t">
						
							<div class="fileDrop w100 box-border" style="">
						        <div style="height:auto; position:relative;">
						            <!-- The table listing the files available for upload/download -->
						            <span style="margin-top:0;height:90px;line-height:55px;" class="i-block wd100 linehgt150">Drop Images Here</span>
						            <table role="presentation" class="table table-striped"><tbody class="files"></tbody></table>
						        </div>
					        </div>
						
							<!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
				            <div class="row fileupload-buttonbar w100" style="position:absolute; bottom:0; right:0;">
				                <div class="col-lg-6">
				                    <!-- The fileinput-button span is used to style the file input field as button -->
				                    <span class="fileinput-button">
				                        <i class="glyphicon glyphicon-plus"></i>
										<a href="javascript:void(0);" class="wzbtn wzbtn-block btn-save"><span class=""><spring:message code="wzwg.module.word.fileadd" /></span></a>
				                        <input type="file" name="files[]" multiple>
				                    </span>
				                    <!--
				                    <button type="submit" class="btn btn_primary start">
				                        <i class="glyphicon glyphicon-upload"></i>
				                        <a href="javascript:alert(1);return;"><span class="btn btn_primary btn_xs"><spring:message code="wzwg.cmm.word.upload" /></span></a>
				                    </button>
				                    
				                     <button type="reset" class="cancel">
				                        <i class="glyphicon glyphicon-ban-circle"></i>
				                        <a href="javascript:void(0);"><span class="btn btn_primary btn_xs"><spring:message code="wzwg.cmm.word.stpge" /></span></a>
				                    </button>  -->
				                    <!--     <button type="button" class="btn btn-danger delete">
				                    <i class="glyphicon glyphicon-trash"></i>
				                        <span><spring:message code="wzwg.cmm.word.delete" /></span>
				                    </button>
				                    <input type="checkbox" class="toggle"> -->
				                    <!-- The global file processing state -->
				                    
				                    <span class="fileupload-process"></span>
				                </div>
				                
				                <!-- The global progress state -->
				                <div class="col-lg-6 fileupload-progress fade">
				                    <div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
				                        <div class="progress-bar progress-bar-success" style="width:0%;"></div>
				                    </div>
				                    <div class="progress-extended" style="height:0;">&nbsp;</div>
				                </div>
				                
				            </div>
						</div>
						
						<!-- 
						<c:if test="${param.mode eq '990' or param.mode eq '6'}">
						<%-- 화면편집 모드에서만 노출 --%>
						<div class="wz_notice block vert-t p10 fs15 mg10">
							<div>
								<spring:message code="wzwg.cmm.msg.tip.MSG056"></spring:message>
								<br><spring:message code="wzwg.cmm.msg.tip.MSG057"></spring:message>
							</div>
							<button type="button" class="wzbtn-table btn-basic fr" onclick="fnRestoreImg()"><spring:message code="wzwg.cmm.msg.tip.MSG058"></spring:message></button>
						</div>
						</c:if>
						 -->
					</div>
					
					
					
					
					
					
        
			        <div>
			    
			            <!-- Redirect browsers with JavaScript disabled to the origin page -->
			            <noscript><input type="hidden" name="redirect" value="<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/image/selectImageList.do"></noscript>
			                
			            
			            
			        </div>
			        
			        <div style="padding-left:5px; margin-right:5px; clear:both; overflow:hidden;">
			        </div>    
			        
			        <div id="main_div" style="padding-left:5px; margin-right:5px; clear:both; overflow:hidden;">
			            <div class="fl" style="overflow:scoll; overflow-y:auto; height:170px; width:25%; border:1px solid #8EA8DB;">
			                <div id="folder_area"></div>
			            </div>
			
			            <div id="image_scroll" class="fr" style="overflow:scoll; overflow-y:auto; height:170px; width:74%; border:1px solid #8EA8DB;">
			                <div id="image_area"></div>
			            </div>
			        </div>
				        
				    	
			    	<%-- <div class="ta_c mg_t10">
						<a href="javascript:;" onclick="$('#imgDiv').hide();"><span class="btn btn_primary btn_xs" style="margin:10px 10px;"><spring:message code="wzwg.cmm.word.close" /></span></a>
					</div> --%>
					
				    <!-- The blueimp Gallery widget -->
				    <div id="blueimp-gallery" class="blueimp-gallery blueimp-gallery-controls" data-filter=":even">
				        <div class="slides"></div>
				        <h3 class="title"></h3>
				        <a class="prev">‹</a>
				        <a class="next">›</a>
				        <a class="close">×</a>
				        <a class="play-pause"></a>
				        <ol class="indicator"></ol>
				    </div>
			</div><!-- end modal-img-content-box -->		
    </form:form>
		