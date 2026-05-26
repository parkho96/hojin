<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
	
<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js"></script>

<script type="text/javascript">
	
	/** 게시판 양식 상세정보로 이동 */
	function fn_moduleBbsFormDetail(){
		document.moduleBbsForm.action='<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/bbsForm/selectModuleBbsFormDetail.do';
		document.moduleBbsForm.submit();
	}
	
	/** 게시판 양식 수정 */
	function fn_moduleBbsFormModify(){
		oEditors.getById["formCn"].exec("UPDATE_CONTENTS_FIELD", []);

		if(!Validator.validate(document.moduleBbsForm)){
			return;
		}
		
		 
	    try {
	        elClickedObj.form.submit();
	    } catch(e) {console.log(e.message);}
		
		$.ajax({
			type:'POST'
			, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/bbsForm/modifyModuleBbsFormAjax.do'
			, data:$("#moduleBbsForm").serialize()
			,success:function (result){
				$(result).find('value').each(function(){
					if($(this).text() == "success"){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>');
						fn_moduleBbsFormDetail();
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
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
            , data : $("#bbsApplcListForm").serialize()
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
       
	<form name="bbsApplcListForm" id="bbsApplcListForm" method="post">
		<input type="hidden" name="formSttusCode" id="formSttusCode" value="modify"/>
		<input type="hidden" name="formSeq" id="formSeq" value="<c:out value='${moduleBbsFormVO.formSeq }'/>"/>
	</form>
	
	<form id="moduleBbsForm" name="moduleBbsForm" method="post">
		<input type="hidden" name="formSeq" id="formSeq" value="<c:out value='${moduleBbsFormVO.formSeq }'/>"/>
		<input type="hidden" name="formSttusCode" id="formSttusCode" value="modify"/>
		
		<input type="hidden" name="searchCondition" id="searchCondition" value="<c:out value="${paramVO.searchCondition}"/>" />
		<input type="hidden" name="searchKeyword" id="searchKeyword" value="<c:out value="${paramVO.searchKeyword}"/>" />
		<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex}"/>" />
		
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
								<option value="<c:out value='${codeList.code }'/>" <c:if test="${codeList.code eq moduleBbsFormVO.formClCode }">selected="selected"</c:if>>
									<c:out value="${codeList.codeNm }"/>
								</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.cmm.word.sj" /></th>
					<td class="txt-l">
						
						<c:set var="msg_txt">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.sj" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
						</c:set>
						
						<input type="text" name="formSj" class="w70" dir="required" title="<spring:message code="wzwg.cmm.word.sj" />" value="<c:out value='${moduleBbsFormVO.formSj }'/>" placeholder="<c:out value='${msg_txt}'/>"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.cmm.word.cn" /></th>
					<td class="txt-l">
						<textarea name="formCn" id="formCn" rows="30" class="w80" dir="required" title="<spring:message code="wzwg.cmm.word.cn" />" style="width:100%;">
							 <c:out value="${moduleBbsFormVO.formCn}" escapeXml="false"/>
						</textarea>
						<script type="text/javascript">
							var oEditors = [];
							nhn.husky.EZCreator.createInIFrame({
							    oAppRef: oEditors,
							    elPlaceHolder: "formCn",
							    sSkinURI: "/smartEditor2.8.2.1/smartEditor2Skin.do",
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
		
		<!-- 게시판 양식 수정시 게시판 적용 목록 -->
		<input type="hidden" name="bbsSeq" id="bbsSeq" value="<c:out value='${nttBbsMappingVO.bbsSeq}'/>"/>
		<input type="hidden" name="beforeBbsSeq" id="beforeBbsSeq" value="<c:out value='${nttBbsMappingVO.bbsSeq}'/>"/>
			
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
					<textarea id="bbsNm" name="bbsNm" class="w100 fs16 p10 box-border mt10 dp-none" rows="4" readonly="readonly"><c:out value="${nttBbsMappingVO.bbsNm }"/></textarea>
					<div id="bbsNmWrap" class="categoryHashtag mt10">
					<c:forEach items="${fn:split(nttBbsMappingVO.bbsNm, ',')}" var="bbsNm" varStatus="status">
			      		<div class="categoryCo"><c:out value="${bbsNm}"></c:out></div>
			      	</c:forEach>
					</div>
				</td>
			</tr>
			</tbody>
		</table>
	</form>
	
	<div class="rt-box">
		<a href="javascript:void(0);" onclick="fn_moduleBbsFormModify();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
		<a href="javascript:void(0);" onclick="fn_moduleBbsFormDetail();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>
