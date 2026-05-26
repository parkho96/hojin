<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
	$(document).ready(function(){ 
		
	});
	
	/** 등록 */
	function fnRegist(callGubun){
		if(!confirm('<spring:message code="wzwg.cmm.msg.MSG135" />')){
            return;
        }else{

			if(!Validator.validate(document.calcBassForm)){
				return;
			}
			 
        	var ajaxUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/calc';
        	ajaxUrl += (callGubun != 'M')? '/registModuleCalcInfoAjax.do':'/modifyModuleCalcInfoAjax.do';
            
            $.ajax({
                type : 'POST'
                , url : ajaxUrl
                , data : $("#calcBassForm").serialize()
                , success : function (result) {
                  
                    var value = "";
                    
                    $(result).find("value").each(function() {  
                        value = $(this).text();  
                    });
                    
                    if(value == 'success'){
                         if (callGubun != 'M') {
                        	document.frmInfo.cntntsNm.value = document.calcBassForm.calcNm.value;
                            fnCntntsRegist();   
                        } else {
                            alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.menu.bassinfo" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
                            fnTabChange('bassInfo');
                            location.reload();
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
 		document.cntntsBassForm.action='<c:out value="${wzwg_contextPath}${prefix}"/>/module/map/selectMapDetailAjax.do';
		document.cntntsBassForm.submit();
	}
  
	
    
    
    
</script>

	<form id="calcBassForm" name="calcBassForm" method="post">
        <input type="hidden" name="sitecntntsSeq" id="sitecntntsSeq" value="<c:out value='${resultVO.sitecntntsSeq}'/>"/>
		<input type="hidden" name="calcinfoSeq" id="calcinfoSeq" value="<c:out value='${resultVO.calcinfoSeq }'/>"/>
		<%-- <input type="hidden" name="cntntsSeq" id="cntntsSeq" value="<c:out value='${resultVO.mapinfoSeq }'/>"/> --%>
		<input type="hidden" name="codeSeq" id="codeSeq" value=""/>
			
		<table class="basic">
			<colgroup>
				<col width="15%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
				<tr>
					<th>페이지명</th>
					<td>
						<input type="text" name="calcNm" id="calcNm" class="w70" value="<c:out value='${resultVO.calcNm }'/>" dir="required" title="페이지명"/>
					</td>
				</tr>
		</table>
	</form>
	
	<div class="rt-box">
        <a href="javascript:void(0);" id="regist_btn" onclick="javascript:fnRegist('M');" class="btn-a"><spring:message code="wzwg.cmm.word.stre" /></a>
		<a href="javascript:void(0);" id="reset_btn" onclick="javascript:fnCancel();" class="btn-b"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>
	