<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<c:if test="${editorSe eq 'C'}">
	<script type="text/javascript" src="/crosseditor/js/namo_scripteditor.js"></script>
	<script type="text/javascript">	
		
		var bEditor_<c:out value="${editorNm}"/> = new NamoSE("<c:out value='${editorNm}'/>");
		
		var UploadFileSizeLimit 	= "file:31457280,image:5242880,flash:524288000,movie:524288000";
		var TagBlockList 			= ["form", "option"];
		var AttributeBlockList 		= ["onclick", "onload", "onchange"]; 
		var UploadFileExtBlockList 	= ["zip", "exe", "jsp", "asp", "php", "html"];
		var ImageSavePath			= "/crosseditor/binary";
		var UploadFileExecutePath 	= "/crosseditor/websource/jsp/ImageUpload.jsp";
		var toolbar_base 			= "fontname|fontsize|word_style|word_color|word_justify|hyperlink|word_listset";
		var toolbar_custom 			= "undo|redo|cut|copy|paste|pastetext|spacebar|image|spacebar|hyperlink|inserthorizontalrule|specialchars|emoticon|spacebar|enter|word_style|space|word_color|cancelattribute|spacebar|word_justify|word_listset|spacebar|tableinsert|tabledraginsert|tablerowinsert|tablerowdelete|tablecolumninsert|tablecolumndelete|tablecellmerge|tablecellsplit|spacebar|tablecellattribute|enter|fontname|fontsize|lineheight|spacebar|blockquote|word_script|spacebar|help";

		bEditor_<c:out value="${editorNm}"/>.params.Width 					= "100%";
		bEditor_<c:out value="${editorNm}"/>.params.Height					= "400px";
		bEditor_<c:out value="${editorNm}"/>.params.UserLang 				= "auto";
		bEditor_<c:out value="${editorNm}"/>.params.SetFocus 				= false;
		bEditor_<c:out value="${editorNm}"/>.params.FullScreen 				= false;
		bEditor_<c:out value="${editorNm}"/>.params.CreateToolbar 			= toolbar_<c:out value="${editorTy}"/>;
		bEditor_<c:out value="${editorNm}"/>.params.AjaxCacheSetup 			= false;
		bEditor_<c:out value="${editorNm}"/>.params.TagBlockList 			= TagBlockList;
		bEditor_<c:out value="${editorNm}"/>.params.AttributeBlockList 		= AttributeBlockList;
		bEditor_<c:out value="${editorNm}"/>.params.UploadFileExtBlockList 	= UploadFileExtBlockList;
		bEditor_<c:out value="${editorNm}"/>.params.ParentEditor 			= document.getElementById("editor_<c:out value='${editorNm}'/>");
		bEditor_<c:out value="${editorNm}"/>.params.UploadFileSizeLimit 		= UploadFileSizeLimit;
		bEditor_<c:out value="${editorNm}"/>.params.ImageSavePath 			= ImageSavePath;
		bEditor_<c:out value="${editorNm}"/>.params.UploadFileExecutePath 	= UploadFileExecutePath;
		bEditor_<c:out value="${editorNm}"/>.EditorStart();
	    
		this.OnInitCompleted = function(e){
			e.editorTarget.SetBodyValue(document.getElementById(e.editorName).value);
		}
		
	</script>
	<div id="editor_<c:out value='${editorNm}'/>"></div>
</c:if> 

<c:if test="${editorSe eq 'S'}">
	<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js" charset="utf-8"></script>
	<script type="text/javascript">
		var seSkinUrl = "<c:out value='${wzwg_contextPath}'/>/smartEditor2.8.2.1/smartEditor2Skin.do"
		if('<c:out value="${param.param_bbsSeq}"/>' != ''){
			//커스텀 게시판 비회원 글쓰기용
			seSkinUrl += '?bbsSeq=<c:out value="${param.param_bbsSeq}"/>'; 
		}
		if(oEditors == undefined){
		var oEditors = [];
		}
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: "<c:out value='${editorNm}'/>",
			sSkinURI: seSkinUrl,
			fCreator: "createSEditor2",
			htParams: {fOnBeforeUnload : function(){},aAdditionalFontList : [['NanumSquareR', 'NanumSquareR']]}
		});
	</script>
</c:if>
