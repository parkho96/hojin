<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script type="text/javascript" src="/js/egovframework/com/cmm/fms/EgovMultiFile.js" ></script>
<script type="text/javascript">

var dplctFlag = false;
var legacyDomn = "";

$(document).ready(function(){
    $('.checkall').click(function(){
        if($('.checkall').prop('checked')){
            $('input[name=domnSeqArr]').prop('checked', true);
        }else{
            $('input[name=domnSeqArr]').prop('checked', false);
        }
    });
    <c:if test="${empty resultVO.useLangCode }">checked="checked"</c:if>
    
    if('<c:out value="${resultVO.useLangCode}" />' == ""){
    	$('#useLangCode1').prop('checked', true);
    }
    
    if('<c:out value="${resultVO.siteUrl}" />' != ""){
    	dplctFlag = true;
    	legacyDomn = "<c:out value="${resultVO.siteUrl}" />"; 
    }
    <c:if test="${not empty param.domnSeq}">
    $('#domnEstbsTitle').html('<spring:message code="wzwg.sysMngr.word.domnTochange" />');
    $('#domnEstbsTitle').show();
    $('#domnEstbsTable').show();
    </c:if>
});

function fnSiteDomnRegist() {

	if(!Validator.validate(document.frmReg)){
		return;
	}
	
	if(dplctFlag != true){
		alert('<spring:message code="wzwg.cmm.msg.MSG201" />');
		return ;
	}
	
	var frm = document.frmReg;
console.log($("#siteUrl").val());
    frm.action="<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/registSiteDomn.do";
    frm.submit();
}

function fnSiteDomnClear() {
    var frm = document.frmReg;

    frm.domnSeq.value = "";
    frm.domnSeCode.value = "";
    frm.useLangCode[0].checked = true;
    frm.siteUrl.value = "";
    $('#domnEstbsTitle').html('<spring:message code="wzwg.sysMngr.word.domnNewAdd" />');
    $('#domnEstbsTitle').show();
    $('#domnEstbsTable').show();
}

function fnSiteDomnDetail(domnSeq) {
	var frm = document.frmReg;
	
	frm.domnSeq.value = domnSeq;
	
    frm.action="<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectSiteDomnList.do";
    frm.submit();
}

function fnSiteDomnDelete() {

	if( $(':checkbox[name="domnSeqArr"]:checked').length < 1 ){
	    alert('<spring:message code="wzwg.cmm.msg.MSG202" />');
	    return;
	}
	
	if (confirm('<spring:message code="wzwg.cmm.msg.MSG203" />')) {
		var frm = document.frmList;
		
	    frm.action="<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/deleteSiteDomn.do";
	    frm.submit();
	}
}

function fnReprsntDomnChange(domnSeq){
	if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006">'+
					'<spring:argument><spring:message code="wzwg.cmm.word.reprsnt" /> URL</spring:argument>'+
					'<spring:argument><spring:message code="wzwg.cmm.word.estbs" /></spring:argument>'+
				  '</spring:message>')){
		return ;
	}else{
		$.ajax({
			type:'POST'
			, url:'<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/modifySiteReprsntDomnAjax.do'
			, data:{'domnSeq':domnSeq,'siteSeq':'<c:out value="${paramVO.siteSeq}" />'}
			,success:function (result){
				$(result).find('value').each(function(){
					if($(this).text() == "success"){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.change" /></spring:argument></spring:message>');
						fnTabLink(2);
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.change" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
					}
				})
			}
			, error:function (request, status, error) {
	              alert('<spring:message code="fail.common.msg" text="error" />');
	          }
		});
	}

}

function fnDplctChk(){
	
	if($("#siteUrl").val() != ""){
		
		if(legacyDomn != "" && $("#siteUrl").val() == legacyDomn){
			alert('<spring:message code="wzwg.cmm.msg.MSG204" />');
			dplctFlag = true;
			return ;
		}
		
		$.ajax({
			type:'POST'
			, url:'<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectSiteDomnDplctChkAjax.do'
			, data:{'siteUrl':$("#siteUrl").val()}
			,success:function (result){
				$(result).find('value').each(function(){
					if($(this).text() == "success"){
						alert('<spring:message code="wzwg.cmm.msg.MSG205" />');
						dplctFlag = true;
					}else{
						alert('<spring:message code="wzwg.cmm.msg.MSG206" />');
						$("#siteUrl").val("");
						$("#siteUrl").focus();
					}
				})
			}
			, error:function (request, status, error) {
	              alert('<spring:message code="fail.common.msg" text="error" />');
	          }
		});
	}else{
		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
				'<spring:argument>URL</spring:argument>'+
				'<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>'+
			  '</spring:message>');
		$("#siteUrl").focus();
		return;
	}
}

function fnDplctInit(){
	if($("#siteUrl").val() == legacyDomn){
		dplctFlag = true;
	}else{
		dplctFlag = false;
	}
}

function fnStrChk(){
	
	var inputVal = $('#siteUrl').val();
	
	var count = (inputVal.match(/,/g) || []).length;
	
	if(count > 9){
		alert('<spring:message code="wzwg.cmm.msg.MSG317" />');
		
		var strArr = inputVal.split(",");
		$('#siteUrl').val(strArr.slice(0, 10));
		return;
	}

	var RegExp = /[ \{\}\[\]\/?;:|\)*~`!^\_+┼<>@\#$%&\'\"\\\(\=\s]/gi;
	$('#siteUrl').val(inputVal.replace(RegExp, ''));
}
</script>

            <c:choose>
            <c:when test="${!empty paramVO.siteSeq}">
                <jsp:include page="/WEB-INF/jsp/wzwg/sysMngr/siteMngr/siteInfo/siteInfoTab.jsp"></jsp:include>
            </c:when>
            <c:otherwise>
                <h3 class="table_tit"><spring:message code="wzwg.sysMngr.word.siteDomnInfo" /></h3>
            </c:otherwise>
            </c:choose>
                    
            <!--//게시판 설정 table -->
            <form id="frmList" name="frmList" method="post">
             <c:choose>
             <c:when test="${empty resultVO.siteSeq}">
             <input type="hidden" id="siteSeq" name="siteSeq" value="<c:out value="${paramVO.siteSeq}" />" />
             </c:when>
             <c:otherwise>
             <input type="hidden" id="siteSeq" name="siteSeq" value="<c:out value="${resultVO.siteSeq}" />" />
             </c:otherwise>
             </c:choose>
             <table class="basic-table">
                <colgroup>
                    <c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}"><col width="5%" /></c:if>
                    <!-- <col width="15%" /> -->
                    <col width="*" />
					<col width="10%" />
                    <col width="15%" />
                    <col width="12%" /> 
                    <col width="10%" />
                </colgroup>
                <thead>
                  <tr>
					<c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}"><th><input type="checkbox" id="domnSeqArr" name="domnSeqArr" value="" class="checkall"></th></c:if>
                    <%-- <th><spring:message code="wzwg.cmm.word.se" /></th> --%>
                    <th>URL</th>
					<th><spring:message code="wzwg.cmm.word.lang" /></th>
                    <th><spring:message code="wzwg.cmm.word.rgsde" /></th>
                    <th><spring:message code="wzwg.sysMngr.word.reprsntUrlEstbs" /></th>
                    <th><spring:message code="wzwg.cmm.word.manage" /></th>
                  </tr>
                </thead>
                <tbody>
                <c:if test="${empty resultList}">
                <tr>
                	<td colspan="5"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
                </tr>
                </c:if>
                <c:forEach items="${resultList}" var="list" varStatus="status">
                <tr>
                	<c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
                	<td>
						<input type="checkbox" id="domnSeqArr" name="domnSeqArr" class="chkDomnSeq" value="<c:out value="${list.domnSeq}" />" />
					</td>
					</c:if>
                    <%-- <td style="cursor:pointer;" onclick="fnSiteDomnDetail('${list.domnSeq}'); return false;"><c:out value="${list.domnSeCodeNm}" /></td> --%>
                    <td class="txt-l" style="padding-left:15px;"><c:out value="${list.siteUrl}" /></td>
					<td><c:out value="${list.useLangCodeNm}" /></td>
                    <td><c:out value="${list.frstRegistPnttm }"/></td>
                    <td>
                   	<c:choose>
                   		<c:when test="${list.reprsntDomnAt eq 'Y'}">
                    		<spring:message code="wzwg.cmm.word.reprsnt" /> URL
                    		<input type="hidden" id="reprsntDomnAt" name="reprsntDomnAt" value="<c:out value="${list.reprsntDomnAt }" />">
                   		</c:when>
                   		<c:otherwise>
                   			<a href="javascript:void(0);" onclick="fnReprsntDomnChange('<c:out value="${list.domnSeq}" />');" class="iconOnlyBtnSameSize btn-basic"><spring:message code="wzwg.sysMngr.word.reprsntEstbs" /></a>
                   		</c:otherwise>
                   	</c:choose>
                    </td>
                    <td><a href="javascript:void(0);" onclick="fnSiteDomnDetail('<c:out value="${list.domnSeq}" />'); return false;" class="iconOnlyBtn btn-basic btn-modify" title="<spring:message code="wzwg.cmm.word.updt" />"><spring:message code="wzwg.cmm.word.updt" /></a></td>
                </tr>
                </c:forEach>
                </tbody>
           </table>
          </form>
           <c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
			<div class="lt-box">
				<button onclick="fnSiteDomnDelete(); return false;" class="wzbtn btn-del"><spring:message code="wzwg.sysMngr.word.choiseDelete" /></button>
				<button class="wzbtn btn-basic fr" onclick="fnSiteDomnClear(); return false;"><spring:message code="wzwg.cmm.word.new" /></button>
			</div>
	
<%--           <c:if test="${!empty resultList}"> --%>
<%--             <div class="ctr-box">
                <ul class="num">
                    <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnPage" />
                </ul>
            </div> --%>
          </c:if>
			
			<h3 class="wzAdmSTit  wd100 fl" id="domnEstbsTitle" style="display:none;"><spring:message code="wzwg.sysMngr.word.domnDetailSet" /></h3>
		
                <form:form modelAttribute="resultVO" name="frmReg" method="post">
                <form:hidden path="domnSeq" id="domnSeq" />
                <c:choose>
                <c:when test="${empty resultVO.siteSeq}">
                <input type="hidden" id="siteSeq" name="siteSeq" value="<c:out value="${paramVO.siteSeq}" />" />
                </c:when>
                <c:otherwise>
                <form:hidden path="siteSeq" name="siteSeq" />
                </c:otherwise>
                </c:choose>
					
					<!--기본정보 table// -->
                    <c:if test="${empty resultVO.siteSeq}">
                    </c:if>
                    <input type="hidden" name="domnSeCode" value="SC00000001">
					<table class="basic" id="domnEstbsTable" style="display:none;">
						<colgroup>
							<col width="13%"/>
							<col width="*"/>
						</colgroup>
						<tbody>
                            <%-- <tr>
                                <th><spring:message code="wzwg.cmm.word.se" /></th>
                                <td>
                                    <form:select path="domnSeCode" name="domnSeCode" dir="required" title="분류">
                                        <form:option value="">::<spring:message code="wzwg.cmm.word.choise" />::</form:option>
                                        <form:options items="${fn:escapeXml(domnSeCodeList)}" itemLabel="codeNm" itemValue="code" />
                                    </form:select>
                                </td>
                            </tr> --%>
                            <tr>
                                <th><spring:message code="wzwg.sysMngr.word.useLang" /></th>
                                <td>
                                    <form:radiobuttons path="useLangCode" items="${useLangCodeList}" itemLabel="codeNm" itemValue="code" dir="required" />
									<span class="wz_tableguide mt10"><spring:message code="wzwg.cmm.msg.MSG4192" /></span>
                                </td>
                            </tr>
                            <tr>
                                <th>URL<span class="red">*</span></th>
                                <td>
                                	<c:set var="msg_txt01">
										<spring:message code="wzwg.cmm.cmmMsg.CMG011">
											<spring:argument>URL</spring:argument>
											<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
										</spring:message>
									</c:set>
                                    http:// <form:input path="siteUrl" id="siteUrl" name="siteUrl" title="URL" dir="required" cssClass="w70" onkeyup="fnStrChk();" onchange="fnDplctInit();" placeholder="${fn:escapeXml(msg_txt01)}"/>
                                    <a href="javascript:void(0);" onclick="fnDplctChk();" class="wzbtn-table btn-basic"><spring:message code="wzwg.sysMngr.word.dplctCeck" /></a>
                                    <a href="javascript:void(0);" class="wzbtn-hgt40 btn-save" onclick="fnSiteDomnRegist(); return false;"><spring:message code="wzwg.cmm.word.stre" /></a>
                                </td>
                            </tr>
						</tbody>
					</table>
					<!--//기본정보 table -->
				</form:form>
				<div class="rt-box">
					<c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
					<p class="admpg-subp w100 fl mt10 txt-l">
						<span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.MSG419" />
						<span class="wz_tableguide mt5 pl15"><spring:message code="wzwg.cmm.msg.MSG4191" />
							<a class="grey fw600" href="/mngr/opnsu/bbs/qna/selectBbsInc.do?bbsSeq=10000000003" target="_blank">
							[<spring:message code="wzwg.cmm.cntnts.hmpgoper" /> &gt; <spring:message code="wzwg.cmm.cntnts.opnsu" /> &gt; <spring:message code="wzwg.cmm.cntnts.qna" />]</a><spring:message code="wzwg.cmm.msg.MSG371" />
						</span>
					</p>
					</c:if>
				</div>
<%-- 			</c:if> --%>

<script>
$(window).on('load', function(){
    var reprsntDomn = $('#reprsntDomnAt').val();
    if(reprsntDomn == undefined || reprsntDomn == ''){
    	alert('<spring:message code="wzwg.cmm.msg.MSG426" />');
    }
    
});

</script>