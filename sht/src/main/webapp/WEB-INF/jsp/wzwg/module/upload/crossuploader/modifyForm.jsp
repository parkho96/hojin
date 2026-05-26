<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

    <!-- NamoCrossUploader Client HTML5 Edition 이 동작하기 위한 필수 파일입니다. -->
    <link rel="stylesheet" type="text/css" href="/crossuploader/app/lib/slick/css/slick.grid.css" />
    <link rel="stylesheet" type="text/css" href="/crossuploader/app/lib/slick/css/smoothness/jquery-ui-1.8.16.custom.css" />
    <link rel="stylesheet" type="text/css" href="/crossuploader/app/lib/slick/css/theme.css" />
    <link rel="stylesheet" type="text/css" href="/crossuploader/app/css/namocrossuploader.css" />
    <link rel="stylesheet" type="text/css" href="/crossuploader/app/lib/contextmenu/jquery.contextMenu.css" />
    <script type="text/javascript" src="/crossuploader/app/lib/jquery.event.drag-2.2.js"></script>
    <script type="text/javascript" src="/crossuploader/app/lib/slick/slick.core.js"></script>
    <script type="text/javascript" src="/crossuploader/app/lib/slick/slick.grid.js"></script>
    <script type="text/javascript" src="/crossuploader/app/lib/slick/plugins/slick.checkboxselectcolumn.js"></script>
    <script type="text/javascript" src="/crossuploader/app/lib/slick/plugins/slick.rowselectionmodel.js"></script>
    <script type="text/javascript" src="/crossuploader/app/js/namocrossuploader-config.js"></script>
    <script type="text/javascript" src="/crossuploader/app/js/namocrossuploader.js"></script>
    <script type="text/javascript" src="/crossuploader/app/lib/contextmenu/jquery.contextMenu.js"></script>
	<script type="text/javascript" src="/crossuploader/app/lib/contextmenu/jquery.ui.position.js"></script>
	
	<input type="hidden" id="atchFileId" name="atchFileId" value="<c:out value="${fileVO.atchFileId}" />" />
	<input type="hidden" id="uploadedFilesInfo" name="uploadedFilesInfo" />
	<input type="hidden" id="modifiedFilesInfo" name="modifiedFilesInfo" />
	
	<div class="red mb10"><strong>※ [<spring:message code="wzwg.cmm.word.lmtt"/>] <spring:message code="wzwg.module.word.indvdlzcpcty"/> : <c:out value="${resultList[0].fileCpcty}" />M, <spring:message code="wzwg.module.word.allcpcty"/> : <c:out value="${resultList[0].fileAllCpcty}" />M, <spring:message code="wzwg.module.word.filecount"/> : <c:out value="${fileVO.posblAtchFileNumber}" /> <spring:message code="wzwg.cmm.word.count02" /></strong></div>
	
    <div id="uploaderContainer" class="form_area">

        <script type='text/javascript'>

            /**
            * NamoCrossUploader Event를 설정합니다.
            * 아래의 Event 이름들은 namocrossuploader-config.js 파일에서 변경하실 수 있습니다.
            */

            /**
            * 업로드 시작 시 호출됩니다.
            */
            var onStartUploadCu = function () {
                //alert('업로드가 시작됐습니다.');
            }

            /**
            * 개별 파일에 대한 업로드 시작 시 호출됩니다.
            */
            var onStartUploadItemCu = function (rowIndex) {
                /*
                var obj = jQuery.parseJSON(uploader.getFileInfoAt(rowIndex));
                alert("[" + rowIndex + "번째 파일의 정보]\n" +
                    "FileType : " + obj.fileType + " (NORMAL:파일, UPLOADED:업로드된 파일)\n" +
                    "FileId : " + obj.fileId + "\n" +
                    "FileName : " + obj.fileName + "\n" +
                    "FileSize : " + obj.fileSize + "\n" +
                    "Status : " + obj.status + "\n" +
                    "IsDeleted : " + obj.isDeleted + "\n\n" +
                    "FileType, FileId, IsDeleted 게시판 수정모드에 활용되는 속성입니다."
                    );
                */ 
            }

            /**
            * 개별 파일에 대한 업로드 완료 시 호출됩니다.
            */
            var onEndUploadItemCu = function (rowIndex) {
                /*
                var obj = jQuery.parseJSON(uploader.getFileInfoAt(rowIndex));
                alert("[" + rowIndex + "번째 파일의 정보]\n" +
                    "FileType : " + obj.fileType + " (NORMAL:파일, UPLOADED:업로드된 파일)\n" +
                    "FileId : " + obj.fileId + "\n" +
                    "FileName : " + obj.fileName + "\n" +
                    "FileSize : " + obj.fileSize + "\n" +
                    "Status : " + obj.status + "\n" +
                    "IsDeleted : " + obj.isDeleted + "\n\n" +
                    "FileType, FileId, IsDeleted 게시판 수정모드에 활용되는 속성입니다."
                    );
                    */ 
            }

            /**
            * 업로드 완료 시 호출됩니다.
            */
            var onEndUploadCu = function () {
                //alert('업로드가 완료됐습니다.');
            }

            /**
            * 전송창이 닫힐 때 호출됩니다.
            */
            var onCloseMonitorWindowCu = function () {
                // 데이터 처리 페이지로 업로드 결과를 전송합니다.
                // onEndUploadCu 나 onCloseMonitorWindowCu 이벤트 시점에 처리하시면 되며,
                // onCloseMonitorWindowCu 시에는 getUploadStatus()를 호출하여 업로드 완료되어 있는지 체크해 주십시오.
                if (uploader.getUploadStatus() == 'COMPLETION') {

                    // 업로드된 전체 파일의 정보를 가져옵니다.
                    var uploadedFilesInfo = uploader.getUploadedFilesInfo();
                    var modifiedFilesInfo = uploader.getModifiedFilesInfo(JSON); 

                    /**
                    * 필요 시, 아래처럼 사용해 주십시오. (JSON으로 넘오올 경우)
                    */
                   /*  var obj = jQuery.parseJSON(uploadedFilesInfo);
                    alertTimeout(obj.length);
                    alertTimeout(obj[0].name); */
                    
					//alert(uploadedFilesInfo); 
                    
/* 
					var existingIDs = [];
					modifiedFilesInfo = $.grep(modifiedFilesInfo, function(v) {
					    if ($.inArray(v.id, existingIDs) !== -1) {
					        return false;
					    }
					    else {
					        existingIDs.push(v.id);
					        return true;
					    }
					});
					
					modifiedFilesInfo.sort(function(a, b) {
					    var akey = a.id, bkey = b.id;
					    if(akey > bkey) return 1;
					    if(akey < bkey) return -1;
					    return 0;
					});
 */
                    // 데이터 처리 페이지로 업로드 결과를 전송합니다.
                    document.getElementById('uploadedFilesInfo').value = uploadedFilesInfo;
                    document.getElementById('modifiedFilesInfo').value = modifiedFilesInfo;
                    fnFileUploader();
                   // document.dataForm.action = window.namoCrossUploaderConfig.productPath + "Upload/BasicFileUpload/DataProcess.jsp";
                   // document.dataForm.submit();
                }
            }

            /**
            * 개별 파일에 대한 업로드 취소 시 호출됩니다.
            */
            var onCancelUploadItemCu = function (rowIndex) {
                /*
                var obj = jQuery.parseJSON(uploader.getFileInfoAt(rowIndex));
                alert('[개별 파일에 대한 업로드 취소 정보]\n' +
                    'FileName : '				+ obj.fileName + '\n' +
                    'FileSize : '				+ obj.fileSize + '\n'
                );
                */
            }

            /**
            * 예외 발생 시 호출됩니다.
            */
            var onExceptionCu = function () {
                // 300~ : 일반적 예외
                // 400~ : 시스템 예외
                // 500~ : 서측에서 발생한 예외
                // 필요한 예외정보만 고객에서 보여주십시오.
                var exceptionInfo = uploader.getLastExceptionInfo();
                var obj = jQuery.parseJSON(exceptionInfo);
                alert('[예외 정보]\n' + 'code : ' + obj.code + '\n' + 'message : ' + obj.message + '\n' + 'detailMessage : ' + obj.detailMessage);

                if (parseInt(obj.code, 10) > 400000) {
                    var uploadedFilesInfo = uploader.getUploadedFilesInfo();
                    document.getElementById('uploadedFilesInfo').value = uploadedFilesInfo;
                    document.dataForm.action = window.namoCrossUploaderConfig.productPath + "Upload/ErrorProcess.jsp";
                    document.dataForm.submit();
                }
            }

            /**
            * NamoCrossUploader 객체를 생성합니다.
            */
            // NamoCrossUploader 전역 객체
            var namoCrossUploader = new __NamoCrossUploader();
            var uploadUrl = window.namoCrossUploaderConfig.productPath + 'Upload/UploadProcess.jsp?idx=<c:out value="${idx}" />&mvpSe=<c:out value="${fileVO.mvpSe}" />';
            var managerProperties = new Object();
            managerProperties.width = '98%';                    // FileUploadManager 너비
            managerProperties.height = '280';                   // FileUploadManager 높이
            managerProperties.containerId = 'uploaderContainer';// FileUploadManager 객체가 생성될 html div 태그 id
            managerProperties.uploadUrl = uploadUrl;                   // 파일 업로드 처리 페이지 경로
            managerProperties.uploadButtonDisplayStyle = "none"; 		 // 업로드 버튼 Visible 상태

            var monitorProperties = new Object();
            monitorProperties.monitorLayerClass = 'monitorLayer';      // FileUploadMonitor 창의 스타일입니다. (namocrossuploader.css 파일에 정의, 변경 가능)
            monitorProperties.monitorBgLayerClass = 'monitorBgLayer';  // FileUploadMonitor 창의 백그라운드 스타일입니다. (namocrossuploader.css 파일에 정의, 변경 가능)
            monitorProperties.closeMonitorCheckBoxChecked = true;      // 전송 완료 후 FileUploadMonitor 창 닫기 설정

            var uploader = namoCrossUploader.createUploader(
                JSON.stringify(managerProperties),                          // FileUploadManager 프로퍼티를 JSON 문자열로 전달
                JSON.stringify(monitorProperties),                          // FileUploadMonitor 프로퍼티를 JSON 문자열로 전달
                JSON.stringify(window.namoCrossUploaderConfig.eventNames)); // 이벤트 이름을 JSON 문자열로 전달
			
                //파일 UI Setting 관련
			namoCrossUploader.setUploaderProperties(
				JSON.stringify(managerProperties),                          // FileUploadManager 프로퍼티를 JSON 문자열로 전달
				JSON.stringify(monitorProperties));                         // FileUploadMonitor 프로퍼티를 JSON 문자열로 전달
			
            var fileEstbsExtsn = "";
            var tmpEstbsExtsn = "";
            var fileCpcty = "";
            var fileFilter = "";
			
            <c:if test="${fileVO.mvpSe ne 'W'}">
				<c:forEach var="resultList" items="${resultList}" varStatus="status">
					fileEstbsExtsn += "<c:out value="${resultList.fileEstbsExtsn}" />" + ",";
				</c:forEach>
					
				fileEstbsExtsn = fileEstbsExtsn.substring(0, fileEstbsExtsn.length - 1);
				tmpEstbsExtsn = fileEstbsExtsn.split(",");
				
				var allowedFileExtension = "";
				
				for(var i = 0; i < tmpEstbsExtsn.length; i++){
					allowedFileExtension += tmpEstbsExtsn[i] + ";";
					fileFilter += "." + tmpEstbsExtsn[i] + ",";
				}
				
				allowedFileExtension = allowedFileExtension.substring(0, allowedFileExtension.length - 1);
				fileFilter = fileFilter.substring(0, fileFilter.length - 1);
			</c:if>
			
			<c:if test="${fileVO.mvpSe eq 'W'}">
				fileFilter 				= ".mp4";
				allowedFileExtension 	= "mp4;";
			</c:if>
			
			//alert(allowedFileExtension);
				
          	/**
            * 파일 필터 설정
            * 명시적 파일 확장자(.gif, .jpg, .png, .doc) 또는 아래와 같은 타입들을 콤마(,)로 연결하여 입력해 주십시오. 
            * - 'audio/*'	
            * - 'video/*'
            * - 'image/*'	
            * - 'media_type' 
            */
            uploader.setFileFilter(fileFilter);
          //  uploader.setFileFilter('.txt,video/*');

            /**
            * 허용하지 않을 파일 확장자 설정
            * setFileFilter로 설정한 것과는 별개로, 실제 업로드 할 수 있는 확장자는 아래와 같이 제한됩니다. 
            */
            //uploader.setAllowedFileExtension('exe;cgi;sql', 'REVERSE'); 
            // 허용할 파일 확장자 기준으로 File Extension을 설정하려면 setAllowedFileExtension 메소드의 두번째 파라미터에 'FORWARD'를 입력해 주십시오.
            uploader.setAllowedFileExtension(allowedFileExtension, 'FORWARD');

            /**
            /* 파일 크기, 개수 제한
            */ 
            
            <c:if test="${fileVO.mvpSe ne 'W'}">
	            uploader.setMaxFileCount('<c:out value="${fileVO.posblAtchFileNumber}" />');   					// 파일 개수 제한
	        </c:if>
	            
	        <c:if test="${fileVO.mvpSe eq 'W'}">
		        uploader.setMaxFileCount(1);   						// 파일 개수 제한
	           // uploader.setMaxFileSize(1024 * 1024 * 500);       	// 개별 파일 크기를 500MB로 제한
	            //uploader.setMaxTotalFileSize(1024 * 1024 * 500); 	// 전체 파일 크기를 500MB로 제한
	        </c:if>
	            
	        uploader.setMaxFileSize(1024 * 1024 * '<c:out value="${resultList[0].fileCpcty}" />');       		// 개별 파일 크기를 설정한 크기로 제한
            uploader.setMaxTotalFileSize(1024 * 1024 * '<c:out value="${resultList[0].fileAllCpcty}" />'); 	// 전체 파일 크기를 설정한 크기로 제한
            
			var onStartUpload = function () {
				var totalFileCount = uploader.getTotalFileCount();
				
				if(totalFileCount > 0){
					uploader.startUpload();
				}else{
					
					if('<c:out value="${fileVO.mvpSe}" />' == 'W'){
						alert('<spring:message code="wzwg.cmm.msg.MSG491" />');
						return;
					}
					
					fnFileUploader();
				}
			}
			
			/**
			* 기존에 업로드 된 파일정보 추가
			*/
			<c:forEach var="resultList" items="${fileList}" varStatus="status">
				var uploadedFileInfo = new Object();
				uploadedFileInfo.fileId 	= '<c:out value="${resultList.atchFileId}" />';
				uploadedFileInfo.fileSn 	= '<c:out value="${resultList.fileSn}" />';
				uploadedFileInfo.fileName 	= '<c:out value="${resultList.orignlFileNm}" />';
				uploadedFileInfo.fileSize 	= '<c:out value="${resultList.fileMg}" />';
			
				uploader.addUploadedFile(JSON.stringify(uploadedFileInfo));
			</c:forEach>
			
			
			//접근성 조치를 위해 tabindex 제거 2019.12.31 조원권    
	          $('#uploaderContainer').find('div[tabindex]').removeAttr('tabindex');
		      $('#uploaderContainer').find('div[hidefocus]').removeAttr('hidefocus');
	          $('#downloaderContainer').find('div[tabindex]').removeAttr('tabindex');
		      $('#downloaderContainer').find('div[hidefocus]').removeAttr('hidefocus');
        </script>
    </div>