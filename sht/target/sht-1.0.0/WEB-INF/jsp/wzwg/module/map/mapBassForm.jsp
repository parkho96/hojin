<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
	$(document).ready(function(){ 
		fn_changeCodeList('<c:out value="${resultVO.tmplatClSeq}"/>');
		document.mapFrm.mapTmplatSeq.value = '<c:out value="${resultVO.tmplatSeq}"/>';
	});
	
	/** 등록 */
	function fnRegist(callGubun){
		if(!confirm('<spring:message code="wzwg.cmm.msg.MSG135" />')){
            return;
        }else{

			if(!Validator.validate(document.mapBassForm)){
				return;
			}
			 
        	var ajaxUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/map';
        	ajaxUrl += (callGubun != 'M')? '/registModuleMapInfoAjax.do':'/modifyModuleMapInfoAjax.do';
            
            $.ajax({
                type : 'POST'
                , url : ajaxUrl
                , data : $("#mapBassForm").serialize()
                , success : function (result) {
                  
                    var value = "";
                    
                    $(result).find("value").each(function() {  
                        value = $(this).text();  
                    });
                    
                    if(value == 'success'){
                         if (callGubun != 'M') {
                        	document.frmInfo.cntntsNm.value = document.mapBassForm.mapNm.value;
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
    	document.mapBassForm.action='<c:out value="${wzwg_contextPath}${prefix}"/>/cntnts/cntntsInfo/selectCntntsInfoList.do';
		document.mapBassForm.submit();
	}
  
	
    function fn_changeCodeList(paramSeq){
		
    	if(!paramSeq == ""){
			document.mapBassForm.codeSeq.value = paramSeq;

			$.ajax({
				  type : 'POST'
				, dataType: 'xml'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/cntnts/selectCntntsTmplatListAjax.do'
				, data : $("#mapBassForm").serialize()
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
					
					document.mapBassForm.codeSeq.value = "";
				}
				, error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});
		}else{
			document.mapBassForm.codeSeq.value = "";
			$("#tmplatSeq").find("option").remove();
		}
    }
    
    /** 컨텐츠 템플릿 미리보기 */
	function fn_cntntsTmplatPrevew(){
    	if($('#codeList').val()) {
			var frm = document.mapBassForm;
			
			var frmResult = window.open("", "popForm", "width=800,height=600,toolbars=no,menubars=no,scrollbars=yes");
			
			frm.target='popForm';
			frm.action='<c:out value="${wzwg_contextPath}"/>/sysMngr/cntntsMngr/cntntnsTmplat/selectCntntsTmplatPrevewPopup.do';
			frm.submit();
    	}
	}
    
    
</script>

	<form id="mapBassForm" name="mapBassForm" method="post">
        <input type="hidden" name="sitecntntsSeq" id="sitecntntsSeq" value="<c:out value='${resultVO.sitecntntsSeq}'/>"/>
		<input type="hidden" name="mapinfoSeq" id="mapinfoSeq" value="<c:out value='${resultVO.mapinfoSeq}'/>"/>
		<%-- <input type="hidden" name="cntntsSeq" id="cntntsSeq" value="<c:out value='${resultVO.mapinfoSeq}'/>"/> --%>
		<input type="hidden" name="codeSeq" id="codeSeq" value=""/>
			
		<table class="basic">
			<colgroup>
				<col width="15%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
				<tr>
					<th><spring:message code="wzwg.module.word.mapnm" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td>
						<input type="text" name="mapNm" id="mapNm" class="w70" value="<c:out value='${resultVO.mapNm}'/>" dir="required" title="<spring:message code="wzwg.module.word.mapnm" />"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.cmm.word.template" /></th>
					<td>
						<select name="codeList" id="codeList" onchange="fn_changeCodeList(this.value);" class="w30" title="<spring:message code="wzwg.cmm.word.template" />">
							<option value=""><spring:message code="wzwg.cmm.word.unsel" /></option>
							<c:forEach items="${codeList }" var="codeList">
 								<option value="<c:out value='${codeList.code}'/>" <c:if test="${resultVO.tmplatClSeq eq codeList.code }">selected="selected"</c:if>>
								<%-- <option value="${codeList.code }"> --%>
									<c:out value="${codeList.codeNm }"/>
								</option> 
							</c:forEach>
						</select>
						
						<select name="tmplatSeq" id="tmplatSeq" class="w30" title="<spring:message code="wzwg.cmm.word.template" />" >
						</select>
						<a href="javascript:void(0);" onclick="fn_cntntsTmplatPrevew();" class="wzbtn-table btn-basic"><spring:message code="wzwg.cmm.word.preview" /></a>
					</td>
				</tr>
		</table>
	 <%-- (<c:out value='${resultVO.tmplatSeq}'/> / <c:out value='${resultVO.tmplatClSeq}'/>) --%>
	</form>
	
	<div class="rt-box">
        <a href="javascript:void(0);" id="regist_btn" onclick="javascript:fnRegist('M');" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
		<a href="javascript:void(0);" id="reset_btn" onclick="javascript:fnCancel();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>
	