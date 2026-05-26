<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
	
	<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js"></script>

	<script type="text/javascript">
		/** 게시판 양식 리스트로 이동 */
		function fn_ModuleBbsFormList(){
			document.moduleBbsForm.action='<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/bbsForm/selectModuleBbsFormList.do';
			document.moduleBbsForm.submit();
		}
		
		/** 게시판 양식 등록 */
		function fn_ModuleBbsFormRegist(){
			oEditors.getById["formCn"].exec("UPDATE_CONTENTS_FIELD", []);

			if(!Validator.validate(document.moduleBbsForm)){
				return;
			}
			 
			$.ajax({
				type:'POST'
				, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/bbsForm/registModuleBbsFormAjax.do'
				, data:$("#moduleBbsForm").serialize()
				,success:function (result){
					$(result).find('value').each(function(){
						if($(this).text() == "success"){
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
							fn_ModuleBbsFormList();
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
						}
					})
				}
				, error:function (request, status, error) {
		              alert('<spring:message code="fail.common.msg" text="error" />');
		          }
			});
		}
		
		/** 게시판 리스트 출력(팝업) */
		function fn_bbsApplcList(){

			$('body').css({overflow:'hidden'});
	        
	        $.ajax({
	            type : 'POST'
	            , url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/bbsForm/selectBbsApplcListPopup.do'
	            , dataType : 'html'
	            , data : $("#popupRegistForm").serialize()
	            , success : function (result) {
	                	 //$("#divLayerPopup").html(result);
	       	    	 	 //$("#divLayerPopup").show();
	       	    	 	 var title = '<spring:message code="wzwg.cmm.word.bbs" /> <spring:message code="wzwg.cmm.word.list" />';
	       	    	 	 wzAjaxModal('popup_s', title, result);
	            }
	            , error : function (request, status, error) {
	                alert('<spring:message code="fail.common.msg" text="error" />');
	            }
	        });
		}
		
	</script>
	
	<!-- 레이어팝업 영역 Start -->
	<div id="divLayerPopup" class="pop-box"></div>
	<!-- 레이어팝업 영역 End -->
       
	<form id="popupRegistForm" name="popupRegistForm" method="post">
		<input type="hidden" name="formSttusCode" id="formSttusCode" value="regist"/>
	</form>
	
	<form id="moduleBbsForm" name="moduleBbsForm" method="post">
		<table class="basic mb0">
			<colgroup>
				<col width="20%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
				<tr>
					<th><spring:message code="wzwg.cmm.word.cl" /></th>
					<td>
						<select id="formClCode" name="formClCode" dir="required" title="<spring:message code="wzwg.cmm.word.cl" />">
							<c:forEach items="${codeList }" var="codeList">
								<option value="<c:out value='${codeList.code }'/>"><c:out value="${codeList.codeNm }"/></option>
							</c:forEach>
						</select>
						<span class="wz_tableguide mt10"><spring:message code="wzwg.cmm.msg.tip.MSG078" /></span>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.cmm.word.sj" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td class="txt-l">
						
						<c:set var="msg_txt">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.sj" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
						</c:set>
						
						<input type="text" name="formSj" class="w60" dir="required" title="<spring:message code="wzwg.cmm.word.sj" />" placeholder="<c:out value='${msg_txt}'/>"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.cmm.word.cn" /></th>
					<td class="txt-l">
						<textarea name="formCn" id="formCn" rows="30" class="w80" dir="required" title="<spring:message code="wzwg.cmm.word.cn" />" style="width:100%;"></textarea>
						<script type="text/javascript">
							var oEditors = [];
							nhn.husky.EZCreator.createInIFrame({
							    oAppRef: oEditors,
							    elPlaceHolder: "formCn",
							    sSkinURI: "<c:out value='${wzwg_contextPath}'/>/smartEditor2.8.2.1/smartEditor2Skin.do",
							    fCreator: "createSEditor2",
							    htParams: {
									fOnBeforeUnload : function(){}
									,aAdditionalFontList : [['NanumSquareR', 'NanumSquareR']]		// 추가 글꼴 목록
									}
							});
						</script>
					</td>
				</tr>
			</tbody>
		</table>
		
		<input type="hidden" name="bbsSeq" id="bbsSeq" value=""/>

		<table class="basic" style="border-top:none;">
			<colgroup>
				<col width="20%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
			<tr>
				<th><spring:message code="wzwg.module.word.bbsapplclist" /></th>
				<td class="txt-l">
					<a href="javascript:void(0);" onclick="fn_bbsApplcList();" class="wzbtn btn-edit"><spring:message code="wzwg.cmm.word.add" /></a><br>
					<textarea id="bbsNm" name="bbsNm" class="w100 fs16 p10 box-border mt10 dp-none" rows="4" readonly="readonly"></textarea>
					<div id="bbsNmWrap" class="categoryHashtag mt10"></div>
				</td>
			</tr>
			</tbody>
		</table>
	</form>
	
	<div class="rt-box">
		<a href="javascript:void(0);" onclick="fn_ModuleBbsFormRegist();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
		<a href="javascript:void(0);" onclick="fn_ModuleBbsFormList();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>
