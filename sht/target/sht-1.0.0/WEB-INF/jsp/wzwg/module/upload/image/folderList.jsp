<%@page import="egovframework.wzwg.cmm.util.CmmSessionUtil"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script>

	function fnFolderSearch(folderId){
		$('#folderListUl').find("strong").each(function(){
			$(this).css("color","#36404a")
		});
		$('#folder_'+folderId).css("color","#2996cc");
		$('#imgfolderId').val(folderId);
		$('#image_scroll').scrollTop(0);
		pageLoaded = 0;
		
		$.ajax({
		    type:'POST'
			, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/image/selectImageList.do'
			, cache : false
			, data:"searchSiteSeq="+$('#searchSiteSeq').val()+"&searchFolderId="+folderId+"&mode=<c:out value="${param.mode}" />&id=<c:out value="${param.id}" />"
			, success:function (data) {
				$('#image_area').html(data);
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
			, dateType: 'html'
		});
	
	}
	
	function fnRegistFolder(){
	
		if($('#folderNew').val() == ''){
			alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
					'<spring:argument><spring:message code="wzwg.module.word.foldernm" /></spring:argument>'+
					'<spring:argument><spring:message code="wzwg.cmm.word.input" text="input" /></spring:argument>'+
				  '</spring:message>');
			return;
		}
		
		$('#imgfolderNm').val($('#folderNew').val());
		
		$.ajax({
		    type:'POST'
			, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/image/registFolder.do'
			, data:$("#fileupload").serialize()
			, success:function (data) {
				$('#folder_area').html(data);
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
			, dateType: 'html'
		});
	
	}
	
	function fnRegistSubFolder(parntsImgfolderId){
		
		if($('#subFolderNew').val() == ''){
			alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
					'<spring:argument><spring:message code="wzwg.module.word.foldernm" /></spring:argument>'+
					'<spring:argument><spring:message code="wzwg.cmm.word.input" text="input" /></spring:argument>'+
				  '</spring:message>');
			return;
		}
		
		$('#imgfolderNm').val($('#subFolderNew').val());
		$('#parntsImgfolderId').val(parntsImgfolderId);
		
		$.ajax({
		    type:'POST'
			, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/image/registFolder.do'
			, data:$("#fileupload").serialize()
			, success:function (data) {
				$('#folder_area').html(data);
				$('#parntsImgfolderId').val("");
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
			, dateType: 'html'
		});
	
	}
	
	function fnAddFolder(){
		
		document.getElementById('addFolder').innerHTML = "";
		
		var tag  = "<li class='mg_b5 mg_l5'>· <input type='text' id='folderNew' style='width:80px;' onkeydown='if(event.keyCode==13) return false;' onsubmit='return false;' />";
		tag 	+= "<a href='javascript:void(0);' onclick='fnRegistFolder();' class='wzbtn btn-plus'><span class='' style='width:20px;height:16px;'><spring:message code="wzwg.cmm.word.stre" /></span></a>";
		tag 	+= "<a href='javascript:void(0);' onclick='fnDeleteNewFolder();' class='wzbtn btn-delete'><span class=''><spring:message code="wzwg.cmm.word.delete" /></span></a>";
		tag 	+= "</li>";
		
		document.getElementById('addFolder').innerHTML = tag;
		
	}
	
	function fnAddSubFolder(parntsImgfolderId){
		document.getElementById('addSubFolder_'+parntsImgfolderId).innerHTML = "";
		
		var tag  = "<li class='mg_b5 mg_l5'>· <input type='text' id='subFolderNew' style='width:80px;' onkeydown='if(event.keyCode==13) return false;' onsubmit='return false;' />";
		tag 	+= "<a href='javascript:void(0);' onclick='fnRegistSubFolder("+parntsImgfolderId+");' class='wzbtn btn-plus'><span class='' style='width:20px;height:16px;'><spring:message code="wzwg.cmm.word.stre" /></span></a>";
		tag 	+= "<a href='javascript:void(0);' onclick='fnDeleteNewSubFolder("+parntsImgfolderId+");' class='wzbtn btn-delete'><span class=''><spring:message code="wzwg.cmm.word.delete" /></span></a>";
		tag 	+= "</li>";
		
		document.getElementById('addSubFolder_'+parntsImgfolderId).innerHTML = tag;
	}
	
	function fnDeleteNewFolder(){
		document.getElementById('addFolder').innerHTML = "";
	}
	
	function fnDeleteNewSubFolder(parntsImgfolderId){
		document.getElementById('addSubFolder_'+parntsImgfolderId).innerHTML = "";
	}
	
	function fnDeleteFolder(folderId, folderNm, subCnt){
		
		if(subCnt > 0){
			if(!confirm('<spring:message code="wzwg.cmm.msg.MSG433" /> \n[ ' + folderNm + ' ] <spring:message code="wzwg.cmm.cmmMsg.CMG006"><spring:argument><spring:message code="wzwg.cmm.word.folder" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
				return;
			}	
		}else{
			if(!confirm('<spring:message code="wzwg.cmm.msg.MSG094" /> \n[ ' + folderNm + ' ] <spring:message code="wzwg.cmm.cmmMsg.CMG006"><spring:argument><spring:message code="wzwg.cmm.word.folder" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
				return;
			}
		}
		
		$.ajax({
		    type:'POST'
			, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/image/deleteFolder.do'
			, data:"imgfolderId="+folderId
			, success:function (data) {
				fnFolderSearch('');
				$('#folder_area').html(data);
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
			, dateType: 'html'
		});
		
	}
	
	function fnModifyFolderForm(imgfolderId, imgfolderNm){
	
		document.getElementById("li_"+imgfolderId).innerHTML = "";
		
		var tag  = "<li id='li_"+imgfolderId+"' class='mg_b5'>· <input type='text' id='"+imgfolderId+"_nm' value='"+imgfolderNm+"' style='width:80px;'>";
		tag 	+= "<a href='javascript:void(0);' onclick='fnModifyFolder("+imgfolderId+");'><span class='wzbtn btn-plus' style='width:20px;height:16px;'><spring:message code="wzwg.cmm.word.stre" /></span></a>";
		tag 	+= "</li>";

		document.getElementById("li_"+imgfolderId).innerHTML = tag;
		
	}
	
	function fnModifyFolder(imgfolderId){
		$.ajax({
		    type:'POST'
			, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/image/modifyFolder.do'
			, data:"imgfolderId="+imgfolderId+"&imgfolderNm="+$('#'+imgfolderId+'_nm').val()
			, success:function (data) {
				$('#folder_area').html(data);
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
			, dateType: 'html'
		});
	}

	
</script>
	
	<input type="hidden" id="searchFolderId" name="searchFolderId" />

	<div style="overflow:scoll; overflow-y:auto; height:180px;text-align:left;">
		<ul id="folderListUl">
			<li class="mg_t10 mg_b10 mg_l5"><a href="javascript:void(0);" onclick="fnFolderSearch('');"><strong>· <spring:message code="wzwg.cmm.word.all" /> (<c:out value="${totCnt}" />)</strong></a></li>
			
			<c:forEach var="resultList" items="${folderList}" varStatus="status">
			<li id="li_<c:out value="${resultList.imgfolderId}" />" class="mg_b5 mg_l5">  
				<a href="javascript:void(0);" onclick="fnFolderSearch('<c:out value="${resultList.imgfolderId}" />');"><strong id="folder_<c:out value="${resultList.imgfolderId}"/>" >· <c:out value="${resultList.imgfolderNm}" />(<c:out value="${resultList.imageCnt}" />)</strong></a>
                <c:if test="${sessionScope.SYSMNGR_AT eq 'Y' or resultList.siteSeq eq sessionScope.SITE_SEQ}">
					<a href="javascript:void(0);" onclick="fnModifyFolderForm('<c:out value="${resultList.imgfolderId}" />', '<c:out value="${resultList.imgfolderNm}" />');" class="wzbtn btn-modify"><span class=""><spring:message code="wzwg.cmm.word.updt" /></span></a>
					<a href="javascript:void(0);" onclick="fnDeleteFolder('<c:out value="${resultList.imgfolderId}" />', '<c:out value="${resultList.imgfolderNm}" />', '<c:out value="${resultList.subCnt}" />');" class="wzbtn btn-delete"><span class=""><spring:message code="wzwg.cmm.word.delete" /></span></a>
					<a href="javascript:void(0);" onclick="fnAddSubFolder('<c:out value="${resultList.imgfolderId}"/>');" class="btn-folder"><spring:message code="wzwg.module.word.folderadd" /></a>
                </c:if>
                
                <ul class="depth2">
                	<c:forEach var="subFolderList" items="${subFolderList}" varStatus="status">
                	<c:if test="${subFolderList.parntsImgfolderId eq resultList.imgfolderId}">
                	<li id="li_<c:out value="${subFolderList.imgfolderId}" />">
                		<a href="javascript:void(0);" onclick="fnFolderSearch('<c:out value="${subFolderList.imgfolderId}" />');"><strong id="folder_<c:out value="${subFolderList.imgfolderId}"/>" >· <c:out value="${subFolderList.imgfolderNm}" />(<c:out value="${subFolderList.imageCnt}" />)</strong></a>
                		<c:if test="${sessionScope.SYSMNGR_AT eq 'Y' or resultList.siteSeq eq sessionScope.SITE_SEQ}">
							<a href="javascript:void(0);" onclick="fnModifyFolderForm('<c:out value="${subFolderList.imgfolderId}" />', '<c:out value="${subFolderList.imgfolderNm}" />');" class="wzbtn btn-modify"><span class=""><spring:message code="wzwg.cmm.word.updt" /></span></a>
							<a href="javascript:void(0);" onclick="fnDeleteFolder('<c:out value="${subFolderList.imgfolderId}" />', '<c:out value="${subFolderList.imgfolderNm}" />');" class="wzbtn btn-delete"><span class=""><spring:message code="wzwg.cmm.word.delete" /></span></a>
		                </c:if>
                	</li>
                	</c:if>
                	</c:forEach>
                	
                	<div id="addSubFolder_<c:out value="${resultList.imgfolderId}" />"></div>
                </ul>
                
			</li>
			</c:forEach>
			
			<div id="addFolder"></div>
			
		</ul>
		
	</div>
	
	<div class="ta_c">
		<a href="javascript:void(0);" onclick="fnAddFolder();" class="wzbtn-table"><span class="" style=""><spring:message code="wzwg.module.word.folderadd" /></span></a>
	</div>
	
