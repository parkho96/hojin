<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<jsp:include page="/WEB-INF/jsp/wzwg/webModule/editorTool.jsp"></jsp:include>

<%-- [머릿말 입력폼]<br>
${mdSeq}/${mdNm}/${formTy} --%>
<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js" charset="utf-8"></script>
<script>
	function fnRegistAddform(id){
		var formCn = oEditors.getById[id].getIR();
		
		$.ajax({
            type : 'POST'
            , url : '/mngr/module/cmm/addform/registMngrAddform.do'
            , dataType : 'html'
            , data : {
            			formCn : formCn
            		  , mdSeq : '<c:out value="${paramVO.mdSeq}"/>'
            		  , mdNm : '<c:out value="${paramVO.mdNm}"/>'
            		  , formTy : '<c:out value="${paramVO.formTy}"/>'
            		 }
            , success : function (data) {
              	//alert(data.head.result);
              	if(data.head.result == 'success'){
              		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
              	}else{
	                alert('<spring:message code="fail.common.msg" text="error" />');
              	}
            }
            , error : function (request, status, error) {
                alert('<spring:message code="fail.common.msg" text="error" />');
            }
        });
	}
</script>
	<%-- ${paramVO } --%>
		<textarea id="form_<c:out value="${paramVO.formTy}"/>" rows="17" style="width:100%;"><c:out value='${addformVO.formCn }'/></textarea>

		<script type="text/javascript">
			if(oEditors == undefined){
				var oEditors = [];
			}
			
			nhn.husky.EZCreator.createInIFrame({
				oAppRef: oEditors,
				elPlaceHolder: "form_<c:out value="${paramVO.formTy}"/>",
				sSkinURI: "/smartEditor2.8.2.1/smartEditor2Skin.do",
				fCreator: "createSEditor2",
				htParams: {fOnBeforeUnload : function(){},aAdditionalFontList : [['NanumSquareR', 'NanumSquareR']]}
			});
			WzwgEditorTool.instance("form_<c:out value="${paramVO.formTy}"/>");
			
		</script>
		
		<div class="rt-box"> 
            <button type="button" onclick="fnRegistAddform('form_<c:out value="${paramVO.formTy}"/>');" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></button>
        </div>