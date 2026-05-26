<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<link rel="stylesheet" href="/css/wzwg/module/cmnt/community.css"> 

<script type="text/javascript">
try{document.title = cmntNm+'-<spring:message code="wzwg.module.word.cmmntymanage" />-<spring:message code="wzwg.module.word.stplatmanage" />';}catch(e){console.log(e.message);}
	$(document).ready(function(){ 
		$('#provisicaption').html('<spring:message code="wzwg.cmm.cmmMsg.CMG024"><spring:argument>'+cmntNm+' <spring:message code="wzwg.cmm.word.wa.of"/> <spring:message code="wzwg.cmm.word.stplat" /> <spring:message code="wzwg.module.word.useat" />, <spring:message code="wzwg.module.word.stplatcn" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.wa.table" /></spring:argument></spring:message>')
	});
	   
	function fn_registProvision(){ 
		oEditors.getById["cmntProvisionInfo"].exec("UPDATE_CONTENTS_FIELD", []);
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}"/>/cmnt/mngr/cmnt/info/modifyCmntProvisionAjax.do'
	      , data:$("#mngrFrm").serialize()
	      , cache : false
	      , async : false 
	      , success:function (data) { 
	    	  alert('<spring:message code="wzwg.cmm.msg.MSG080" text="changed" />');
	    	  fn_provision();
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
	
</script>
		
		<h5 class="fs24 pt20 pb20 fn wd100 clboth"><spring:message code="wzwg.module.word.stplatmanage" /></h5>
		<div class="joinUs_box mt5">	
		<form name="mngrFrm" id="mngrFrm">
		<input type="hidden" name="cmntSeq" id="cmntSeq" value="<c:out value='${result.cmntSeq}'/>"/>
			<table>
				<caption id="provisicaption"><spring:message code="wzwg.cmm.cmmMsg.CMG024"><spring:argument><spring:message code="wzwg.module.word.useat" />, <spring:message code="wzwg.module.word.stplatcn" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.wa.table" /></spring:argument></spring:message></caption>
				<colgroup>
					<col width="10%">
					<col width="38%">
					<col width="12%">
					<col width="40%">
				</colgroup>
				<tr>
					<th scope="row"><spring:message code="wzwg.cmm.word.use" text="use" /></th>
					<td colspan="3">
						<ul class="wzForm">
							<li><label><input type="radio" name="cmntProvisionAt" id="cmntProvisionAt" value="Y" <c:if test="${result.cmntProvisionAt eq 'Y' }">checked="true"</c:if> title="<spring:message code="wzwg.cmm.word.use" />" ><span class="spanLabel"><spring:message code="wzwg.cmm.word.use" text="use" /></span></label></li>
							<li><label><input type="radio" name="cmntProvisionAt" id="cmntProvisionAt" value="N" <c:if test="${result.cmntProvisionAt eq 'N' }">checked="true"</c:if> title="<spring:message code="wzwg.cmm.word.unuse" />"><span class="spanLabel"><spring:message code="wzwg.cmm.word.unuse" text="unused" /></span></label></li>
						</ul>
					</td>
				</tr>
				<tr>
					<th scope="row"><spring:message code="wzwg.cmm.word.cn" text="content" /></th>
					<td colspan="3">
					 <textarea name="cmntProvisionInfo" id="cmntProvisionInfo" rows="30" class="w80" dir="required"title="<spring:message code="wzwg.module.word.cninpcmpt" />"><c:out value='${result.cmntProvisionInfo }'/></textarea>
						<script type="text/javascript">
							var oEditors = [];
							nhn.husky.EZCreator.createInIFrame({
							    oAppRef: oEditors,
							    elPlaceHolder: "cmntProvisionInfo",
							    sSkinURI: "<c:out value='${wzwg_contextPath}'/>/smartEditor2.8.2.1/smartEditor2Skin.do",
							    fCreator: "createSEditor2"
							    ,htParams: {
									fOnBeforeUnload : function(){}
									,aAdditionalFontList : [['NanumSquareR', 'NanumSquareR']]		// 추가 글꼴 목록
								}
							});
						</script>
					</td>
				</tr>
			</table>
		</form>
			<div class="btnbox-c mb50 mt30">
				<a href="javascript:fn_registProvision();" class="wzbtn btn-save"><spring:message code="button.save" text="save" /></a>
			</div>
	 	</div><!-- joinUs_box end -->