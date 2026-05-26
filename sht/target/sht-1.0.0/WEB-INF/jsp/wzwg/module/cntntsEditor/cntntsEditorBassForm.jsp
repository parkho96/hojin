<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
	$(document).ready(function(){
		fnTmplatDivChange('<c:out value="${resultVO.tmplatSeq}"/>','<c:out value="${resultVO.atchFileId}"/>');
		/* fn_changeCodeList('<c:out value="${resultVO.tmplatClSeq}"/>'); */
		$('#cntntsNm').focus();
		
		$('#cntntsVer').val('<c:out value="${resultVO.cntntsVer}"/>');
		fnModeChange('<c:out value="${resultVO.cntntsVer}"/>');
	});
	
	/** 등록 */
	function fnRegist(callGubun){
		$('#cntntsDc').val($('#cntntsNm').val());
		
		if(!confirm('<spring:message code="wzwg.cmm.msg.MSG135" />')){
            return;
        }else{

			if(!Validator.validate(document.cntntsBassForm)){
				return;
			}
			 
        	var ajaxUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/cntnts';
        	ajaxUrl += (callGubun != 'M')? '/registModuleCntntsAjax.do':'/modifyModuleCntntsAjax.do';
            
            $.ajax({
                type : 'POST'
                , url : ajaxUrl
                , data : $("#cntntsBassForm").serialize()
                , success : function (result) {
                  
                    var value = "";
                    
                    $(result).find("value").each(function() {  
                        value = $(this).text();  
                    });
                    
                    if(value == 'success'){
                         if (callGubun != 'M') {
                        	document.frmInfo.cntntsNm.value = document.cntntsBassForm.cntntsNm.value;
                            fnCntntsRegist();   
                        } else {
                            alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.word.bass" /> <spring:message code="wzwg.cmm.word.info" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
//                             fnTabChange('bassInfo');
                            fnPageReload();
//                             location.reload();
                        } 
                    }else{
                        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
                    }
                  
                }
                , error : function (request, status, error) {
                    alert('<spring:message code="fail.common.msg" text="error" />');
                }
            });
        
        }
	}
	
	/** 취소 */
    function fnCancel() {
 		document.cntntsBassForm.action='<c:out value="${wzwg_contextPath}${prefix}"/>/cntntsEditor/cntntsInfo/selectCntntsInfoList.do';
		document.cntntsBassForm.submit();
	}

	/** 컨텐츠 템플릿 미리보기 */
	function fn_tmplatPrevew(){
		var frm = document.cntntsBassForm;
		
		var frmResult = window.open("", "popForm", "width=800,height=600,toolbars=no,menubars=no,scrollbars=yes");
		
		frm.target='popForm';
		frm.action='<c:out value="${wzwg_contextPath}"/>/sysMngr/cntntsMngr/cntntnsTmplat/selectCntntsTmplatPrevewPopup.do';
		frm.submit();
	}
/* 
	function fn_changeCodeList(paramSeq){
		if(!paramSeq == ""){
			document.cntntsBassForm.codeSeq.value = paramSeq;

			$.ajax({
				  type : 'POST'
				, dataType: 'xml'
				, url : '<c:out value="${prefix}"/>/module/cntntsEditor/selectCntntsTmplatListAjax.do'
				, data : $("#cntntsBassForm").serialize()
				, success : function(xml, status, request) {
					
					$("#tmplatSeq").find("option").remove();
					$(xml).find("item").each(function(){
						var tmprTmplatSeq = $(this).find('name').text();
						var tmprTmplatNm = $(this).find('value').text();
						
						if(tmprTmplatSeq != '<c:out value="${resultVO.tmplatSeq}"/>'){
							$("#tmplatSeq").append("<option value="+tmprTmplatSeq+">"+tmprTmplatNm+"</option>")
						}else{
							$("#tmplatSeq").append("<option value="+tmprTmplatSeq+" selected='selected'>"+tmprTmplatNm+"</option>")
						}
						
					});
					
					document.cntntsBassForm.codeSeq.value = "";
				}
				, error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});
		}else{
			document.cntntsBassForm.codeSeq.value = "";
			$("#tmplatSeq").find("option").remove();
		}
	} */
	
	/** 템플릿 리스트 조회 */
	function fn_tmplatSearch(){
    	$.ajax({
    		   type:'POST'
    		 , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/cntntsEditor/selectCntntsTmplatListSearchAjax.do'
    		 , data : $("#cntntsBassForm").serialize()
    		 , success:function (data) {
    			 	//$("#divLayerPopup").html(data);
    	    	  	//$("#divLayerPopup").show();
    	    	  	var title = '<spring:message code="wzwg.cmm.word.cntnts" /> <spring:message code="wzwg.cmm.word.template" /> <spring:message code="wzwg.cmm.word.estbs" />';
    			 	wzAjaxModal('popup_l', title, data);
    			}
    		 , dataType: 'html'
    	});
	}
    
	/** 레이어팝업 닫기 */
	function fnLayerPopupClose() {
	    //$("#divLayerPopup").hide();
	    //$("#divLayerPopup").empty();
	    //$('body').css({overflow:'auto'});
	    wzModalClose();
	}
	
	/** 템플릿 썸네일 */
    function fnTmplatDivChange(paramSeq, paramFileId) {
    	$("#tmplatDiv").empty();
    	if(paramSeq != "" && paramSeq != null){
			if(paramFileId != "" && paramFileId != null){
				$("#tmplatDiv").append("<img src=<c:url value='/module/upload/file/selectImageView.do'/>?atchFileId="+paramFileId+"&fileSn=0 style='width: 150px; height: 200px; cursor:pointer;' onclick='fn_tmplatPrevew();'/> <a href='javascript:void(0);' onclick='fn_tmplatDelete();' class='wzbtn-table btn-del'><spring:message code="wzwg.cmm.word.template" /> <spring:message code="wzwg.cmm.word.delete" /></a>");
			}else{
				$("#tmplatDiv").append("<spring:message code="wzwg.cmm.msg.MSG137" /> <a href='javascript:void(0);' onclick='fn_tmplatDelete();' class='wzbtn-table btn-del'><spring:message code="wzwg.cmm.word.template" /> <spring:message code="wzwg.cmm.word.delete" /></a>");
			}
    	}else{
    		$("#tmplatDiv").append("<spring:message code="wzwg.cmm.msg.MSG136" />");
    	}
    }    
	
	/** 템플릿 삭제 */
	function fn_tmplatDelete(){
		document.cntntsBassForm.tmplatSeq.value = "";
		fnTmplatDivChange("","");
	}
	
	function fnModeChange(input){
		var modeValue = $(input).val();
		if(!modeValue || modeValue == ''){
			modeValue = input;
		}
		
		//console.log(modeValue);
		if(modeValue == '1'){
			$('.cntntsVer_1').show();
		}else if(modeValue == '2'){
			$('.cntntsVer_1').hide();
		}
	}

	</script>

	<!-- 레이어팝업 영역 Start -->
	<div id="divLayerPopup" class="pop-box" style="display: ;"></div>
	<!-- 레이어팝업 영역 End -->

	<form id="cntntsBassForm" name="cntntsBassForm" method="post">
        <input type="hidden" name="sitecntntsSeq" id="sitecntntsSeq" value="<c:out value='${resultVO.sitecntntsSeq}'/>"/>
		<input type="hidden" name="cntntsSeq" id="cntntsSeq" value="<c:out value='${resultVO.cntntsSeq }'/>"/>
		<input type="hidden" name="codeSeq" id="codeSeq" value=""/>
		<input type="hidden" name="tmplatSeq" id="tmplatSeq" value="<c:out value='${resultVO.tmplatSeq }'/>"/>
			
		<table class="basic">
			<colgroup>
				<col width="15%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
				<tr>
					<th><spring:message code="wzwg.cmm.word.cntnts" /> <spring:message code="wzwg.cmm.word.nm01" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td>
						<input type="text" name="cntntsNm" id="cntntsNm" class="w70" value="<c:out value='${resultVO.cntntsNm }'/>" dir="required" title="<spring:message code="wzwg.module.word.cntntsnm" />"/>
					</td>
				</tr>
				<%-- <tr>
					<th>컨텐츠설명</th>
					<td>
						<input type="text" name="cntntsDc" id="cntntsDc" class="w70" value="<c:out value='${resultVO.cntntsDc }'/>" dir="required" title="설명" />
					</td>
				</tr> --%>
				<%-- <tr>
					<th>컨텐츠설명</th>
					<td>
						<input type="text" name="cntntsDc" id="cntntsDc" class="w70" value="<c:out value='${resultVO.cntntsDc }'/>" dir="required" title="설명" />
					</td>
				</tr> --%>
				<%--
				<tr>
					<th>컨텐츠 편집모드</th>
					<td>
						<p>
							<label><input type="radio" name="cntntsVer" value="1" onclick="fnModeChange(this)" <c:if test="${resultVO.cntntsVer eq '1' }">checked</c:if>>일반</label>
							<span class="hint">(일반 웹에디터를 통해 컨텐츠 페이지를 제작합니다.)</span>
						</p>
						<p>
							<label><input type="radio" name="cntntsVer" value="2" onclick="fnModeChange(this)" <c:if test="${resultVO.cntntsVer eq '2' }">checked</c:if>>컨텐츠에디터</label>
							<span class="hint">(레이아웃 기반의 다양한 위젯을 이용하여 컨텐츠 페이지를 제작합니다.)</span>
						</p>
					</td>
				</tr>
				 --%>
				<input type="hidden" name="cntntsVer" value="1">
<%-- 			
				<tr class="cntntsVer_1" style="display:none">
					<th><spring:message code="wzwg.cmm.word.template" /></th>
					<td>
		
						<select name="codeList" id="codeList" onchange="fn_changeCodeList(this.value);" class="w30" title="템플릿">
							<option value=""><spring:message code="wzwg.cmm.word.unsel" /></option>
							<c:forEach items="${codeList }" var="codeList">
								<option value="${codeList.code }" <c:if test="${resultVO.tmplatClSeq eq codeList.code }">selected="selected"</c:if>>
									<c:out value="${codeList.codeNm }"/>
								</option> 
							</c:forEach>
						</select>
						
						<select name="tmplatSeq" id="tmplatSeq" class="w30" title="템플릿" >
						</select>
						<a href="javascript:void(0);" onclick="fn_cntntsTmplatPrevew();" class="btn-c"><spring:message code="wzwg.cmm.word.preview" /></a>
 
 						<select name="searchCondition" id="searchCondition" onchange="fn_changeCodeList(this.value);" class="w30">
 							<option value=""><spring:message code="wzwg.cmm.word.unsel" /></option>
							<c:forEach items="${codeList }" var="codeList">
								<option value="${codeList.code }" <c:if test="${resultVO.tmplatClSeq eq codeList.code }">selected="selected"</c:if>>
									<c:out value="${codeList.codeNm }"/>
								</option> 
							</c:forEach>
 						</select>
						<input type="text" name="searchKeyword" id="searchKeyword" class="w30" />
						<a class="wzbtn-table btn-srch" href="javascript:void(0);" onclick="fn_tmplatSearch();"><spring:message code="wzwg.cmm.word.search01" /></a>
					</td>
				</tr>
				<tr class="cntntsVer_1" style="display:none">
					<th><spring:message code="wzwg.cmm.word.applc" /> <spring:message code="wzwg.cmm.word.template" /></th>
					<td>
						<div id="tmplatDiv"> </div>
					</td>
				</tr>
--%>
			</tbody>
		</table>
	</form>
	
	<div class="rt-box">
        <a href="javascript:void(0);" id="regist_btn" onclick="javascript:fnRegist('M');" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
		<a href="javascript:void(0);" id="reset_btn" onclick="javascript:fnCancel();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>
	