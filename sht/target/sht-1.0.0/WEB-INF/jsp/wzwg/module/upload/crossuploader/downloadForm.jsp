<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

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

    <div id="downloaderContainer" class="form_area">

        <script type='text/javascript'>
        	/**
	        * 다운로드 할 파일 추가
	        */
	        var addFiles = function ()
	        {
	        	var fileIdArray, fileNameArray, fileSizeArray;
	        	
	        	<c:forEach var="resultList" items="${fileList}" varStatus="status">
	        		
	        		var fileInfo = new Object();
	        		
	        		fileInfo.fileId 	= '<c:out value="${resultList.atchFileId}" />';
	        		fileInfo.fileSn 	= '<c:out value="${resultList.fileSn}" />';
	                fileInfo.fileName 	= '<c:out value="${resultList.orignlFileNm}" />';
	                fileInfo.fileSize 	= '<c:out value="${resultList.fileMg}" />';
	                fileInfo.fileUrl 	= '<c:out value="${resultList.fileStreCours}" />' + '<c:out value="${resultList.streFileNm}" />';
	                
	                downloader.addFile(JSON.stringify(fileInfo));
	                
	        	</c:forEach>
	            
				downloader.scrollRow(0); // 첫번째 파일 위치로 스크롤 이동
	        }
     	
	        /**
	        * 전체 파일 삭제
	        */
	        var deleteAllFiles = function ()
	        {
	        	downloader.deleteAllFiles();
			}
        	
        	
        	/**
            * NamoCrossDownloader 객체를 생성합니다.
            */
            var namoCrossUploader = new __NamoCrossUploader();
            var downloadUrl = window.namoCrossUploaderConfig.productPath + 'Download/DownloadProcess.jsp';
            //var downloadUrl = "/module/upload/crossuploader/fileDown.do";
            var managerProperties = new Object();
            managerProperties.width = '98%';                       // FileDownloadManager 너비
            managerProperties.height = '280';                       // FileDownloadManager 높이
            managerProperties.containerId = 'downloaderContainer';  // FileDownloadManager 객체가 생성될 html div 태그 id
            managerProperties.uiMode = 'MULTIPLE';                  // FileDownloadManager UI 모드 설정
            managerProperties.downloadUrl = downloadUrl;            // 다운로드 처리 페이지 

            var downloader = namoCrossUploader.createDownloader(
                JSON.stringify(managerProperties));                 // FileDownloadManager 프로퍼티를 JSON 문자열로 전달

            /**
            * 다운로드 할 파일 추가
            */ 
            addFiles();
                
          //접근성 조치를 위해 tabindex 제거 2019.12.31 조원권    
          $('#uploaderContainer').find('div[tabindex]').removeAttr('tabindex');
	      $('#uploaderContainer').find('div[hidefocus]').removeAttr('hidefocus');
          $('#downloaderContainer').find('div[tabindex]').removeAttr('tabindex');
	      $('#downloaderContainer').find('div[hidefocus]').removeAttr('hidefocus');
        </script>

    </div>
