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
    <script src="/bootstrap/js/bootstrap.js"></script>
    
    <!-- blueimp Gallery script -->
    <script src="/jquery/js/jquery.blueimp-gallery.min.js"></script>
    
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
        input, select{font-family:NanumGothic; font-size:12px; color:#888; font-weight:normal;} 
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
		      , url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/image/selectImageList.do?mode=<c:out value="${param.mode}" />&scrollPageIdx=0'
			  , processData: false
			  , contentType: false
		      , data : formData
		      , mimeType: 'multipart/form-data'
		      , success:function (data) {
		    	  $('#image_area').html(data);
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
					$.post("<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/image/selectImageList.do?mode=<c:out value="${param.mode}" />&searchSiteSeq="+searchSiteSeq+"&searchFolderId="+searchFolderId+"&scrollPageIdx="+pageLoaded,
			            function(data){
			                if (data != ""){
			                	  if (data.indexOf("<a") >-1){
			                	$('#image_area').append(data);
			                	  }
			                }
			            }
			        );
				}
				
			});
			
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
						      , url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/image/selectImageList.do?mode=<c:out value="${param.mode}" />'
							  , processData: false
							  , contentType: false
						      , data : formData
						      , mimeType: 'multipart/form-data'
						      , success:function (data) {
						    	  $('#image_area').html(data);
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
				, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/image/selectImageList.do?mode=<c:out value="${param.mode}" />&searchFolderId='+searchFolderId
				, processData: false
				, contentType: false
				, data : formData
				, mimeType: 'multipart/form-data'
				, success:function (data) {
					$('#image_area').html(data);
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
			
			form.imgfolderId.value = "";
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
				, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/image/selectImageList.do?mode=<c:out value="${param.mode}" />&scrollPageIdx=0'
				, processData: false
				, contentType: false
				, data : formData
				, mimeType: 'multipart/form-data'
				, success:function (data) {
					$('#image_area').html(data);
				}
				, error:function (data) {
					alert('<spring:message code="wzwg.module.word.imageerror" />');
				}
				, dateType: 'html'
			});
		 }
		 
		 var selectDiv;
		 function selectImgLoad(link, ele, mode, paramId){
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
		<form:hidden path="imgfolderId" id="imgfolderId" />
		<form:hidden path="imgfolderNm" />
		<form:hidden path="imagePath" value="/upload/image/" />
		<form:hidden path="searchSiteSeq" />
        <form:hidden path="parntsImgfolderId" />
		        
        
        <div class="wz_notice brbox bg-white br-blue-strong">	
		    <ul class="wd100">
		    	<c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
			    <li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG148" /></li>
			    <li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG149" /></li>
			    <li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG157" /></li>
			    </c:if>
			    <c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
			    <li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG148" /></li>
			    <li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG158" /></li>
			    <li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG157" /></li>
			    </c:if>
			    <li class="admpg-subp wd100 mb0 red">· ※ <spring:message code="wzwg.cmm.msg.tip.MSG164" /></li>
		    </ul>
		</div>
        <c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
        	<div class="wd100 mb20">
				<span class="mr10 fs16 fw600"><spring:message code="wzwg.module.word.searchsitechoise" /> : </span>
		        <select id="selSiteSeq" class="w40 fs15" onchange="fnSearchSiteFolder(this.value);">
		        	<option value="10000000001"><spring:message code="wzwg.cmm.word.sysmngr" /> ( sysmngr.wiz-builder.com )</option>
		        	<c:forEach var="resultList" items="${searchSiteList}">
		        		<option value="<c:out value="${resultList.siteSeq}" />"><c:out value="${resultList.siteFullNm}" /> ( <c:out value="${resultList.siteUrl}" /> )</option>
		        	</c:forEach>
		        </select>
	        </div>
        </c:if>
        
			<div class="modal-img-content-box" style="width:95%">	
					<div style="padding-left:5px; margin-top:10px; text-align:left;">
						<div style="margin-bottom:10px;">
						
				        </div>
				        
				        <div>
				        	※ <spring:message code="wzwg.cmm.msg.MSG095" />
				        </div>
					</div>
        
        			<div></div>
			        <div style="width:100%;">
			    
			            <!-- Redirect browsers with JavaScript disabled to the origin page -->
			            <noscript><input type="hidden" name="redirect" value="<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/image/selectImageList.do"></noscript>
			                
			            <!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
			            <div class="row fileupload-buttonbar" style="padding-left:10px; margin-top:5px; text-align:left;">
			                <div class="col-lg-6">
			                    <!-- The fileinput-button span is used to style the file input field as button -->
			                    <span class="fileinput-button">
			                        <i class="glyphicon glyphicon-plus"></i>
									<a href="javascript:void(0);"><span class="wzbtn wzbtn-block btn-save"><spring:message code="wzwg.module.word.fileadd" /></span></a>
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
			                    <div class="progress-extended">&nbsp;</div>
			                </div>
			                
			            </div>
			            
			        </div>
			        <div class="fileDrop w100 box-border mb10 bg-white" style="">
				        <div style="overflow:hidden;height:130px; padding:0 0 17px 0; margin-bottom:10px;">
				        <span style="float:none;margin-top:0;line-height: 150px;" class="i-block wd100 linehgt150">Drop Images Here</span>
				            <!-- The table listing the files available for upload/download -->
				            <table role="presentation" class="table table-striped"><tbody class="files"></tbody></table>
				        </div>
			        </div>    
			        
			        <div style="padding-left:5px; margin-right:5px; clear:both; overflow:hidden;">
			            <div class="fl" style="overflow:scoll; overflow-y:auto; height:220px; width:25%; border:1px solid #8EA8DB;">
			                <div id="folder_area"></div>
			            </div>
			
			            <div id="image_scroll" class="fr" style="overflow:scoll; overflow-y:auto; height:220px; width:74%; border:1px solid #8EA8DB;">
			                <div id="image_area"></div>
			            </div>
			        </div>
				   
				    	
<!-- 			    	<div class="ta_c mg_t10"> -->
<!-- 						<a href="javascript:;" onclick="$('#imgDiv').hide();"><span class="btn btn_primary btn_xs" style="margin:10px 10px;"><spring:message code="wzwg.cmm.word.close" /></span></a> -->
<!-- 					</div> -->
					
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
				</div>	
    </form:form>
		
		