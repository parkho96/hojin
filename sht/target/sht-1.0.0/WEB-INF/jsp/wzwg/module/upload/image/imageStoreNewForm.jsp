<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 
 <script src="/js/wzwg/cmm/upload/modernizr.js?v=1.4.22"></script>
    <!-- Compiled CSS -->
    <link rel="stylesheet" href="/css/wzwg/cmm/upload/site.css?v=1.4.22">
    <!-- Compiled JS -->
    <script src="/js/wzwg/cmm/upload/site.js?v=1.4.22"></script>
<div style="width:100%;">  
    
    <!-- blueimp Gallery styles -->
    <link rel="stylesheet" href="/jquery/css/gallery.min.css">
    
    <!-- CSS to style the file input field as button and adjust the Bootstrap progress bars -->
    <link rel="stylesheet" href="/jquery/css/jquery.fileupload.css">
    <link rel="stylesheet" href="/jquery/css/jquery.fileupload-ui.css"> 
     
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
			 
			
			$('#image_scroll').scroll( function() {
				
				if ($('#image_scroll').scrollTop() == $('#image_scroll').prop("scrollHeight") - $('#image_scroll').height()) {
					
					pageLoaded = pageLoaded + 1; 
					
					var searchSiteSeq = $('#searchSiteSeq').val();
					var searchFolderId = $('#imgfolderId').val();
					
					// ajax를 추가해서 목록을 받아온다
					$.post("<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/image/selectImageList.do?mode=<c:out value="${param.mode}" />&searchSiteSeq="+searchSiteSeq+"&searchFolderId="+searchFolderId+"&scrollPageIdx="+pageLoaded,
			            function(data){
			                if (data != ""){
			                	$('#image_area').append(data);
			                }
			            }
			        );
				}
				
			});

		  
		}); 
		   Formstone.Ready(function() {
				
               $(".upload").upload({
                       maxSize: 5000000 ,
                       beforeSend: onBeforeSend,
                       action: '<c:out value="${wzwg_contextPath}" />/mngr/module/upload/image/uploadImage.do',
                       accept:  /(\.|\/)(gif|jpe?g|png)$/i,
                       multiple : true
                   })
                   .on("filecomplete.upload", onComplete);

           });
		   

           function onComplete(e, file, response) { 
        	   const obj = JSON.parse(response); 
        	   if(obj.msg !=''){
              	 alert(obj.msg);
              	 }else{
              		 fnImageLayer();
              	 }
           }
           
		   function onBeforeSend(formData, file){ 
			   if($('#imgfolderId').val() =='' || $('#imgfolderId').val() ==0 ){
	        		alert('<spring:message code="wzwg.cmm.msg.MSG492" />');
	        		return false;
	        		
	        	} 
			   formData.append("imgfolderId",$('#imgfolderId').val());
			   formData.append("siteSEq",'<c:out value="${sessionScope.SITE_SEQ}" />');
			   return formData;
		   }
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
        
			<div class="modal-img-content-box" style="width:95%">	
					<div style="padding-left:5px; margin-top:10px; text-align:left;">
						<div style="margin-bottom:10px;">
						<c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
							<span class="mr10"><spring:message code="wzwg.module.word.searchsitechoise" /></span>
					        <select id="selSiteSeq" class="w40" onchange="fnSearchSiteFolder(this.value);">
					        	<option value="10000000001"><spring:message code="wzwg.cmm.word.sysmngr" /> ( sysmngr.wiz-builder.com )</option>
					        	<c:forEach var="resultList" items="${searchSiteList}">
					        		<option value="<c:out value="${resultList.siteSeq}" />"><c:out value="${resultList.siteFullNm}" /> ( <c:out value="${resultList.siteUrl}" /> )</option>
					        	</c:forEach>
					        </select>
				        </c:if>
				        </div>
				        
				        <div>
				        	※ <spring:message code="wzwg.cmm.msg.MSG095" />
				        </div>
					</div>
        
        			<div></div>
			        <div style="width:100%;">
			    
			            
			        </div>
			        <div class="upload w100 box-border mb10 bg-white" style="">
				     
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
		
		