<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script type="text/javascript" src="/js/egovframework/com/cmm/fms/EgovMultiFile.js" ></script>

<script type="text/javascript">
$(document).ready(function(){
	if($(":input:radio[name=srvcAt]:checked").val() == 'N'){
		fnSiteSrvcAt('N');
	}else{
		$('#previewBtn').hide();
	}
});

function fnSiteSttusRegist() {
    var frm = document.frmReg;
    
    if($(":input:radio[name=srvcAt]:checked").val() == 'N'){
    	oEditors.getById["opertCn"].exec("UPDATE_CONTENTS_FIELD", []);

	    if($("input[name=opertBgnde]").val() == $("input[name=opertEndde]").val()){
	    	if($("select[name=beginTime]").val() > $("select[name=endTime]").val()){
	    		alert("<spring:message code="wzwg.cmm.msg.MSG096" />");
	    		$("select[name=beginTime]").focus();
	    		return;
	    	}
	    }
    }
    
    if($("input[name=opertBgnde]").val() == ''){
    	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument><spring:message code="wzwg.cmm.word.bgnde" /></spring:argument></spring:message>');
    	$('input[name=opertBgnde]').focus();
		return;
    }
    
    if($("input[name=opertEndde]").val() == ''){
    	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument><spring:message code="wzwg.cmm.word.endde" /></spring:argument></spring:message>');
    	$('input[name=opertEndde]').focus();
		return;
    }

	if(!Validator.validate(frm)){
		return;
	}
		
	frm.target="_self";
    frm.action="<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/modifySiteSttus.do";
    frm.submit();
}

function fnSiteSrvcAt(paramValue){
	if(paramValue == 'Y'){
		$('#previewBtn').hide();
		$('#srvcStpgeDiv').empty();
	}else{
		
		$('#previewBtn').show();
		
		$.ajax({
			   type:'POST'
			 , url:'<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectSiteSrvcAtChangeAjax.do'
			 , data:$("#resultVO").serialize() 
			 , success:function (data) {
					 $('#srvcStpgeDiv').html(data);
				   }
			 , dataType: 'html'
		});
	}
}

function fnSiteSttusPreview(){

	var frm = document.frmReg;
 
	if(frm.opertNm.value == ''){
		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.sysMngr.word.stpgeSj" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
		return;
	}
	
	if(frm.opertBgnde.value == ''){
		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
				'<spring:argument><spring:message code="wzwg.sysMngr.word.stpgePdBgnde" /></spring:argument>'+
				'<spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument>'+
				'</spring:message>');
		return;
	}
	
	if(frm.opertEndde.value == ''){
		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
				'<spring:argument><spring:message code="wzwg.sysMngr.word.stpgePdEndde" /></spring:argument>'+
				'<spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument>'+
				'</spring:message>');
		return;
	}
	
	oEditors.getById['opertCn'].exec("UPDATE_CONTENTS_FIELD", []);
	
	if(frm.opertCn.value == ''){
		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.sysMngr.word.stpgeWords" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
		return;
	}
	
	var frmResult = window.open("", "previewPop", "width=850,height=700,toolbars=no,menubars=no,scrollbars=yes");
	
	frm.target='previewPop';
	frm.action='<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectSiteSrvcAtChangePreviewPopup.do';
	frm.submit();
	
}

</script>

            <c:choose>
            <c:when test="${!empty paramVO.siteSeq}">
                <jsp:include page="/WEB-INF/jsp/wzwg/sysMngr/siteMngr/siteInfo/siteInfoTab.jsp"></jsp:include>
            </c:when>
            <c:otherwise>
                <h3><spring:message code="wzwg.sysMngr.word.siteSttusInfo" /></h3>
            </c:otherwise>
            </c:choose>
                    
                <form:form modelAttribute="resultVO" name="frmReg" method="post">
                <c:choose>
                <c:when test="${empty resultVO.siteSeq}">
                <input type="hidden" id="siteSeq" name="siteSeq" value="<c:out value="${paramVO.siteSeq}" />" />
                </c:when>
                <c:otherwise>
                <form:hidden path="siteSeq" name="siteSeq" />
                <input type="hidden" name="opertSeq" value="<c:out value="${opertSeq }" />"/>
                </c:otherwise>
                </c:choose>
					
					<!--기본정보 table// -->
                    
                    <c:if test="${empty resultVO.siteSeq}">
                    </c:if>
					<table summary="<spring:message code="wzwg.sysMngr.word.sttusInfo" />" class="basic">
						<colgroup>
							<col width="13%"/>
							<col width="*"/>
						</colgroup>
						<tbody>
                            <tr>
                                <th><spring:message code="wzwg.sysMngr.word.lastInfoUpdtDe" /></th>
                                <td>
                                    <c:out value="${resultVO.lastUpdtPnttm}" />
                                </td>
                            </tr>
                            <tr>
                                <th><spring:message code="wzwg.sysMngr.word.creatDe01" /></th>
                                <td>
                                    <c:out value="${resultVO.creatDe}" />
                                </td>
                            </tr>
                            <tr>
                                <th><spring:message code="wzwg.sysMngr.word.srvcAt" /> (<spring:message code="wzwg.sysMngr.word.updtDe01" />)</th>
                                <td>
                                	<ul class="wzForm">
                                		<li>
                                			<label><form:radiobutton path="srvcAt" value="Y" onchange="fnSiteSrvcAt(this.value);" /><span class="spanLabel"><spring:message code="wzwg.sysMngr.word.srcvOpen02" /></span></label>
                                		</li>
                                		<li>
                                			<label><form:radiobutton path="srvcAt" value="N" onchange="fnSiteSrvcAt(this.value);"/><span class="spanLabel"><spring:message code="wzwg.sysMngr.word.srvcStpge" /> <span class="fs15 grey">(<c:out value="${resultVO.srvcBeginDe}" />)</span></span></label>
                                		</li>
                                	</ul>
									<span class="wz_tableguide mt10 wd100 fl"><spring:message code="wzwg.cmm.msg.MSG4193" /></span>
                                </td>
                            </tr>
                            <c:if test="${sessionScope.SYSMNGR_AT eq 'Y' and sysChekYn eq 'N'}">
                            <tr>
                                <th><spring:message code="wzwg.sysMngr.word.clsAt" /> (<spring:message code="wzwg.sysMngr.word.updtDe01" />)</th>
                                <td>
                                    <ul class="wzForm">
                                    	<li><label><form:radiobutton path="ablEnncAt" value="Y" /><span class="spanLabel"><spring:message code="wzwg.sysMngr.word.siteCls" /></span></label></li>
                                    	<li><label><form:radiobutton path="ablEnncAt" value="N" /><span class="spanLabel"><spring:message code="wzwg.sysMngr.word.siteOpen02" /> <span class="fs15 grey">(<c:out value="${resultVO.ablDe}" />)</span></span></label></li>
                                    </ul>
                                </td>
                            </tr>
                            </c:if>
						</tbody>
					</table>
					<div id="srvcStpgeDiv"> </div>
					<!--//기본정보 table -->
				</form:form>
				
				<div class="rt-box">
					<a href="javascript:void(0);" onclick="fnSiteSttusPreview(); return false;" id="previewBtn" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.preview" /></a>
					<a href="javascript:void(0);" onclick="fnSiteSttusRegist(); return false;" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
				</div>
