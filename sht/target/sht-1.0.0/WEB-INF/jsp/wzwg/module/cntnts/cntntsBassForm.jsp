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
                            alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.menu.bassinfo" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
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
 		document.cntntsBassForm.action='<c:out value="${wzwg_contextPath}${prefix}"/>/cntnts/cntntsInfo/selectCntntsInfoList.do';
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
				, url : '<c:out value="${prefix}"/>/module/cntnts/selectCntntsTmplatListAjax.do'
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
    		 , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/cntnts/selectCntntsTmplatListSearchAjax.do'
    		 , data : $("#cntntsBassForm").serialize()
    		 , success:function (data) {
    			 	//$("#divLayerPopup").html(data);
    	    	  	//$("#divLayerPopup").show();
    	    	  	var title = '<spring:message code="wzwg.module.word.cntntstemplateestbs" />';
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
				$("#tmplatDiv").append("<img src=<c:url value='/module/upload/file/selectImageView.do'/>?atchFileId="+paramFileId+"&fileSn=0 style='width: 150px; height: 200px; cursor:pointer;' onclick='fn_tmplatPrevew();'/> <a href='javascript:void(0);' onclick='fn_tmplatDelete();' class='wzbtn-table btn-del'><spring:message code="wzwg.module.word.templatedelete" /></a>");
			}else{
				$("#tmplatDiv").append("<spring:message code="wzwg.cmm.msg.MSG137" /> <a href='javascript:void(0);' onclick='fn_tmplatDelete();' class='wzbtn-table btn-del'><spring:message code="wzwg.module.word.templatedelete" /></a>");
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
	<div id="divLayerPopup" class="pop-box"></div>
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
					<th><spring:message code="wzwg.module.word.cntntsnm" /></th>
					<td>
						<input type="text" name="cntntsNm" id="cntntsNm" class="w70" value="<c:out value='${resultVO.cntntsNm }'/>" dir="required" title="<spring:message code="wzwg.module.word.cntntsnm" />"/>
					</td>
				</tr>
				<input type="hidden" name="cntntsVer" value="1">
			</tbody>
		</table>
	</form>
	
	<div class="rt-box">
        <a href="javascript:void(0);" id="regist_btn" onclick="javascript:fnRegist('M');" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
		<a href="javascript:void(0);" id="reset_btn" onclick="javascript:fnCancel();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>
	