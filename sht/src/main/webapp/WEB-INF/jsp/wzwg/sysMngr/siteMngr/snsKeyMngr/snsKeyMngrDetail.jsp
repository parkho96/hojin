<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">

$(document).ready(function(){
	<c:if test="${!empty resultList}">
		<c:forEach items="${resultList}" var="result" varStatus="status">
	 		<c:if test="${not empty result.siteSeq}">
	 			$("input[name='snsTyCodeArr']:input[value='<c:out value="${result.snsTyCode}" />']").trigger("click");
	 		</c:if>
		</c:forEach>
	</c:if>
});

function fnRegist() {

    var chkCnt = 0;
    
    $('.snsTyCodeArr').each(function(idx){
       
        if (this.checked) {
            
            if ($('.clientIdArr').eq(idx).val().trim() == '') {
                chkCnt++;
                return alert('<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument>CLIENT_ID</spring:argument></spring:message>');
            }
            if ($('.clientSecretArr').eq(idx).val().trim() == '') {
                chkCnt++;
                return alert('<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument>CLIENT_SECRET</spring:argument></spring:message>');
            }
        }
    });
    
    if (chkCnt > 0) return;
    
    $.ajax({
        type:'POST'
        , url:'<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/snsKeyMngr/registSnsKeyMngrAjax.do'
        , data:$("#frmInfo").serialize()
        , success:function (result){
            $(result).find('value').each(function(){
                if($(this).text() == "success"){
                    $('.snsTyCodeArr').each(function(idx){
                        if (!this.checked) {
                        	$('.clientIdArr').eq(idx).val('');
                        	$('.clientSecretArr').eq(idx).val('');
                        }
                    });
                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>');
                }else{
                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
                }
            })
        }
    });
}
/* 
function fnSnsTyCodeChk(obj, cnt) {
	
    if (obj.checked) {
        $('.clientIdArr').eq(cnt).attr('disabled', false);
        $('.clientSecretArr').eq(cnt).attr('disabled', false);
    } else {
        $('.clientIdArr').eq(cnt).attr('disabled', true);
        $('.clientSecretArr').eq(cnt).attr('disabled', true);
    }
}
 */
function fnSnsTyCodeChk(obj, cnt) {
	
	
    if (obj.checked) {
        $('.clientIdArr').eq(cnt).attr('disabled', false);
        $('.clientSecretArr').eq(cnt).attr('disabled', false);
        $('.tdEventId').eq(cnt).removeAttr('onclick');
        $('.tdEventSecret').eq(cnt).removeAttr('onclick');
    } else {
        $('.clientIdArr').eq(cnt).attr('disabled', true);
        $('.clientSecretArr').eq(cnt).attr('disabled', true);
        $('.tdEventId').eq(cnt).attr('onclick', 'fnClientChk('+cnt+')');
        $('.tdEventSecret').eq(cnt).attr('onclick', 'fnClientChk('+cnt+')');     
    }
}

function fnClientChk(cnt) {
    $('.snsTyCodeArr').eq(cnt).trigger('click');
}
</script>

<div class="wz_notice brbox bg-white br-blue-strong">
    <ul class="wd100">
        <li class="admpg-subp wd100">· <b><spring:message code="wzwg.cmm.msg.tip.MSG091" /></b></li>
        <li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG092" /></li>
        <li class="admpg-subp wd100 mb0 grey">· <a href="/pdf/guide/SNS_API_guide(200226)_wizbuilder.pdf" class="underline grey" target="_blank"><spring:message code="wzwg.cmm.msg.tip.MSG093" /></a></li>
    </ul>
</div>

                <form id="frmInfo" name="frmInfo" method="post">
                    <!--기본정보 table// -->
                    
                    <table class="basic-table">
                        <colgroup>
                            <col width="5%"/>
                            <col width="20%"/>
                            <col width="15%"/>
                            <col width="*"/>
                        </colgroup>
                        	<thead>
	                        	<tr>
	                        		<th><spring:message code="wzwg.cmm.word.use" /></th>
	                        		<th><spring:message code="wzwg.cmm.word.cl" /></th>
	                        		<th colspan="2"><spring:message code="wzwg.sysMngr.word.clientInfo" /></th>
	                        	</tr>
	                        </thead>
                        <c:if test="${!empty resultList}">
                        <c:forEach items="${resultList}" var="result" varStatus="status">
	                        <tbody>
		                        <tr>
		                        	<th rowspan="2"><ul class="wzForm"><li><label><input type="checkbox" id="snsTyCodeArr" name="snsTyCodeArr" class="snsTyCodeArr" value="<c:out value="${result.snsTyCode}" />" onclick="fnSnsTyCodeChk(this, <c:out value="${status.count-1}" />)" /><span class="spanLabel"></span></label></li></ul></th>
		                            <th rowspan="2">
		                                <c:out value="${result.snsTyCodeNm}" />
		                            </th>
		                            <td class="txt-l">CLIENT_ID</td>
		                            <td class="tdEventId" onclick="fnClientChk(<c:out value="${status.count-1}" />)">
		                                <input type="text" id="clientIdArr" name="clientIdArr" dir="required" class="w70 clientIdArr" value="<c:out value="${result.clientId}" />" disabled />
		                            </td>
		                        </tr>
		                        <tr>
		                            <td class="txt-l">CLIENT_SECRET</td>
		                            <td class="tdEventSecret" onclick="fnClientChk(<c:out value="${status.count-1}" />)"><input type="text" id="clientSecretArr" name="clientSecretArr" dir="required" class="w70 clientSecretArr" value="<c:out value="${result.clientSecret}" />" disabled /></td>
		                        </tr>
	                        </tbody>
                        </c:forEach>
                        </c:if>
                    </table>
                    <!--//기본정보 table -->
                </form>
                
                <div class="rt-box">
                    <a href="javascript:void(0);" onclick="fnRegist();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
                </div>
