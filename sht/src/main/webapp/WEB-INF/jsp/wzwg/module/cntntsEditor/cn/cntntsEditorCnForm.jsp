<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<jsp:include page="/WEB-INF/jsp/wzwg/webModule/editorTool.jsp"></jsp:include>

<!-- <script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js"></script> -->

	<script src="/js/wzwg/cmm/0028_farbtastic.js"></script>
    <script src="/js/wzwg/cmm/slick/slick.js"></script> 
  	<script src="/jquery/js/jquery.form.min.js"></script>
	<script src="/js/wzwg/cmm/jquery.contextMenu.js"></script>

	<!-- codeMirror 리소스 -->
  	<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/lib/codemirror.css">
  	<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/material.css">
	<script src="/js/wzwg/cmm/codemirror/lib/codemirror.js"></script>
	<script src="/js/wzwg/cmm/codemirror/mode/xml/xml.js"></script>
	<script src="/js/wzwg/cmm/codemirror/mode/javascript/javascript.js"></script>
	<script src="/js/wzwg/cmm/codemirror/mode/css/css.js"></script>
	<script src="/js/wzwg/cmm/codemirror/mode/vbscript/vbscript.js"></script>
	<script src="/js/wzwg/cmm/codemirror/mode/htmlmixed/htmlmixed.js"></script>
	<script src="/js/wzwg/cmm/codemirror/lib/formatting.js"></script>

	<!-- wizonEditor 용 리소스 -->
	<link rel="stylesheet" href="/wizonEditor/css/template_part.css" type="text/css" />
	<link rel="stylesheet" href="/wizonEditor/css/wizonCntnts.css" type="text/css" />
	<link rel="stylesheet" href="/wizonEditor/css/wizonEditorBase.css" type="text/css" />
  	<script src="/wizonEditor/js/wizonEditorBase.js"></script>
  	<script src="/wizonEditor/js/wizonEditorAction.js"></script>
  	<script src="/wizonEditor/js/wzwgTableEditor.js"></script>
  	<script src="/wizonEditor/js/wfSel.js"></script>
  	<script src="/wizonEditor/js/codeMirrorApp.js"></script>



<script type="text/javascript">
	$(document).ready(function(){
		fnTmplatDivChange('<c:out value="${tmplatVO.tmplatSeq}"/>','<c:out value="${tmplatVO.atchFileId}"/>','<c:out value="${tmplatVO.tmplatSj}"/>');
		
		var opt = {}
			opt.editType = 'contents'; 
			 
			opt.contentmove = 'drag';
			opt.fileStore = 'true';
			opt.imageStore = 'true';
			console.log(opt);
			
  		$('#cntntsEditor').wizonEditor(opt);
	});
	
	/* 컨텐츠 내용 등록 */
	function fnCntntsCnRegist(){
	    
	    //oEditors.getById["cntntsCn"].exec("UPDATE_CONTENTS_FIELD", []);

		if(!Validator.validate(document.cntntsCnListFrm)){
			return;
		}
		 
		$.ajax({
	        type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/cntntsEditor/registModuleCntntsCnAjax.do'
			, data : $("#cntntsCnListFrm").serialize()
			, success : function (result) {
				$(result).find('value').each(function(){
					if($(this).text() == "success"){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
						fn_init();
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
					}
				})
			}
			, error : function (request, status, error) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
		});

	}
	
	/** 템플릿 리스트 조회 */
	function fn_tmplatSearch(){
    	$.ajax({
    		   type:'POST'
    		 , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/cntntsEditor/selectCntntsTmplatListSearchAjax.do'
    		 , data : $("#cntntsCnListFrm").serialize()
    		 , success:function (data) {
    	    	  	var title = '<spring:message code="wzwg.cmm.word.cntnts" /> <spring:message code="wzwg.cmm.word.template" /> <spring:message code="wzwg.cmm.word.estbs" />';
    			 	wzAjaxModal('popup_l', title, data);
    			}
    		 , dataType: 'html'
    	});
	}

	/** 템플릿 썸네일 */
    function fnTmplatDivChange(paramSeq, paramFileId, tmplatSj) {
    	$("#tmplatDiv").empty();
    	if(paramSeq != "" && paramSeq != null){
    		$('#tmplatSeq').val(paramSeq);
			if(paramFileId != "" && paramFileId != null){
				$("#tmplatDiv").append("<img src=<c:url value='/module/upload/file/selectImageView.do'/>?atchFileId="+paramFileId+"&fileSn=0 style='width: 100px !important;'/><span class='tmplatNm'>"+tmplatSj+"</span>");
			}else{
				$("#tmplatDiv").append("<spring:message code="wzwg.cmm.msg.MSG137" />");
			}
    	}else{
    		$("#tmplatDiv").append("<spring:message code="wzwg.cmm.msg.MSG136" />");
    	}
    }    
	
</script>

	<!-- 레이어팝업 영역 Start -->
	<!-- <div id="divLayerPopup" class="pop-box" style="display: ;"></div> -->
	<!-- 레이어팝업 영역 End -->
	
		<form:form modelAttribute="paramVO" path="cntntsCnListFrm" name="cntntsCnListFrm" id="cntntsCnListFrm" method="post">
			<form:hidden path="cntntsSeq"/>
			<input type="hidden" name="target" value="cnDetail"/>
			<input type="hidden" id="tmplatSeq" name="tmplatSeq" value="<c:out value='${tmplatVO.tmplatSeq}'/>"/>
			
			<div class="tableWrap row mg_t20">
				<table class="basic">
					<colgroup>
						<col width="15%"/>
						<col width="*"/>
					</colgroup>
					<tbody>
						<tr>
							<td colspan="2" class="rt-box">
								<div class="rt-box">
									<a href="javascript:void(0);" onclick="fnCntntsCnRegist();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
									<a href="javascript:void(0);" onclick="fn_init();" class="wzbtn btn-del"><spring:message code="wzwg.cmm.word.cancl" /></a>
								</div>
							</td>
						</tr>
						<tr>
							<th><spring:message code="wzwg.cmm.word.template" /></th>
							<td>
							
		 						<select name="searchCondition" id="searchCondition" class="w30">
		 							<option value=""><spring:message code="wzwg.cmm.word.unsel" /></option>
									<c:forEach items="${codeList }" var="codeList">
										<option value="<c:out value='${codeList.code }'/>" <c:if test="${resultVO.tmplatClSeq eq codeList.code }">selected="selected"</c:if>>
											<c:out value="${codeList.codeNm }"/>
										</option> 
									</c:forEach>
		 						</select>
								<input type="text" name="searchKeyword" id="searchKeyword" class="w30" />
								<a class="wzbtn-table btn-srch" href="javascript:void(0);" onclick="fn_tmplatSearch();"><spring:message code="wzwg.cmm.word.search01" /></a>
								
							</td>
						</tr>
						<tr>
							<th><spring:message code="wzwg.cmm.word.applc" /> <spring:message code="wzwg.cmm.word.template" /></th>
							<td><div id="tmplatDiv"></div></td>
						</tr>
						<tr>
							<th><spring:message code="wzwg.cmm.word.cn" /></th>
							<td>
								<input type="hidden" name="cntntsCn" id="cntntsCn" rows="60" class="w90" dir="required" title="<spring:message code="wzwg.cmm.word.cn" />" style="display: hidden;">
								
								<div id="cntntsEditor">
									<c:if test="${empty paramVO.cntntsCnSeq}"><c:out value="${tmplatVO.cntntsCn }" escapeXml="false"/></c:if>
									<c:if test="${not empty paramVO.cntntsCnSeq}"><c:out value="${resultVO.cntntsCn }" escapeXml="false"/></c:if>
								</div>
								<%-- 
								<script type="text/javascript">
									var oEditors = [];
									nhn.husky.EZCreator.createInIFrame({
										oAppRef: oEditors,
										elPlaceHolder: "cntntsCn",
										sSkinURI: "<c:out value='${wzwg_contextPath}'/>/smartEditor2.8.2.1/smartEditor2Skin.do",
										fCreator: "createSEditor2",
										htParams: {
											fOnBeforeUnload : function(){}
											,aAdditionalFontList : [['NanumSquareR', 'NanumSquareR']]		// 추가 글꼴 목록
										}
									});
									
									WzwgEditorTool.instance("cntntsCn");
								</script>
								 --%>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</form:form>
			
		
		<!-- 게시물 목록 -->
		<h3 class="wzAdmSTit wd100 fl"><spring:message code="wzwg.cmm.word.historycntnts" /></h3>
		<table class="basic-table">
			<colgroup>
				<col width="80%"/>
				<col width="*"/>
			</colgroup>
			<thead>
				<tr>
					<th>작성일시</th>
					<th><spring:message code="wzwg.cmm.word.rm" /></th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${!empty cntntsCnList }">
						<c:forEach items="${cntntsCnList }" var="cntntsCnList" varStatus="status">
							<tr>
								<td><c:out value="${cntntsCnList.frstRegistPnttm }"/></td>
								<td>
									<a href="javascript:void(0);" onclick="fn_modifyCntntsCnForm('<c:out value="${cntntsCnList.cntntsCnSeq}"/>');" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.recovry" /></a>
									<a href="javascript:void(0);" onclick="fn_deleteCntntsCn('<c:out value="${cntntsCnList.cntntsCnSeq}"/>');" class="wzbtn btn-del"><spring:message code="wzwg.cmm.word.delete" /></a>
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<td colspan="2"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
			