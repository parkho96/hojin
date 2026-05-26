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

			if(!Validator.validate(document.kocwForm)){
				return;
			}
			 
            if (callGubun != 'M') {
                <c:if test="${!empty selModuleVO.sitecntntsSeq}">
                return alert('이미 생성된 모듈입니다.\nAPI모듈은 하나의 사이트에 1개의 모듈만 생성할 수 있습니다.');
                </c:if>
                document.frmInfo.cntntsNm.value = document.kocwForm.sitecntntsNm.value;
                fnCntntsRegist();   
            } else {
                $.ajax({
                    type : 'POST'
                    , url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/kocw/modifyKocwAjax.do'
                    , data : $("#kocwForm").serialize()
                    , success : function (result) {
                      
                        var value = "";
                        
                        $(result).find("value").each(function() {  
                            value = $(this).text();  
                        });
                        
                        if(value == 'success'){
                            
                            alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.word.bass" /> <spring:message code="wzwg.cmm.word.info" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
                            fnTabChange('bassInfo');
                            location.reload();
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
	}
	
	/** 취소 */
    function fnCancel() {
    	document.kocwForm.action='<c:out value="${wzwg_contextPath}${prefix}"/>/cntnts/cntntsInfo/selectCntntsInfoList.do';
		document.kocwForm.submit();
	}
  
</script>

	<form id="kocwForm" name="kocwForm" method="post">
        <input type="hidden" name="sitecntntsSeq" id="sitecntntsSeq" value="<c:out value='${resultVO.sitecntntsSeq}'/>"/>
			
		<table class="basic">
			<colgroup>
				<col width="15%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
				<tr>
					<th>KOCW <spring:message code="wzwg.cmm.word.menu" /> <spring:message code="wzwg.cmm.word.sj" /></th>
					<td>
						<input type="text" name="sitecntntsNm" id="sitecntntsNm" class="w70" value="<c:out value='${resultVO.cntntsNm}'/>" dir="required" title="KOCW <spring:message code="wzwg.cmm.word.menu" /> <spring:message code="wzwg.cmm.word.sj" />"/>
					</td>
				</tr>
		</table>
	</form>
	
	<div class="rt-box">
        <a href="javascript:void(0);" id="regist_btn" onclick="javascript:fnRegist('M');" class="btn-a"><spring:message code="wzwg.cmm.word.stre" /></a>
		<a href="javascript:void(0);" id="reset_btn" onclick="javascript:fnCancel();" class="btn-b"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>
	