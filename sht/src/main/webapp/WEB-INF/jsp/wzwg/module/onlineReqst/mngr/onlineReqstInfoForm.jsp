<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>


<script type="text/javascript">

    function fnRegist(callGubun) {

        var ajaxUrl = '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineReqst';
        ajaxUrl += (callGubun != 'M')? '/registOnlineReqstInfoAjax.do':'/modifyOnlineReqstInfoAjax.do';
        
        if(callGubun != 'M') {
        	$("#cntntsNm").val($("#reqstNm").val());
        }
        
        if(!confirm('<spring:message code="wzwg.cmm.msg.MSG135" />')){
            return;
        }else{

			if(!Validator.validate(document.regForm)){
				return;
			}

            $.ajax({
                type : 'POST'
                , url : ajaxUrl
                , dataType: 'xml'
                , data : $("#regForm").serialize()
                , success : function (result) {
                  
                    var value = "";
                    
                    $(result).find("value").each(function() {  
                        value = $(this).text();  
                    });
                    
                    if(value == 'success'){
                        if (callGubun != 'M') {
                            fnCntntsRegist();   
                        } else {
                            alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.menu.bassinfo" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
							//fnList();
                            location.reload();
                            //fnReload();
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
    
    function fnReload() {

	    $.ajax({
	        type : 'POST'
	        , url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineReqst/selectOnlineReqstInfoFormAjax.do'
	        , dataType : 'html'
	        , data : $("#regForm").serialize()
	        , success : function (data) {
	            $(".cocntainer_tabs > a").removeClass("active");
	            $("#bassInfo").addClass("tab active");
	            $('#onlineReqst_area').html(data);
	        }
	        , error : function (request, status, error) {
	            alert('<spring:message code="fail.common.msg" text="error" />');
	        }
	    });
    }    
    
    function fnReset_btn() {
    	document.regForm.action='<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/cntnts/cntntsInfo/selectCntntsInfoList.do';
        document.regForm.submit();
    }
</script>
        
        <form:form modelAttribute="resultVO" path="regForm" id="regForm" name="regForm" method="post">
            <form:hidden path="sitecntntsSeq" />
            <form:hidden path="siteSeq" />
            <form:hidden path="reqstSeq" />
                    
            <!--기본정보 table// -->
            <table class="basic">
            <colgroup>
                <col width="15%"/>
                <col width="*"/>
            </colgroup>
            <tbody>
                <tr>
                    <th><spring:message code="wzwg.cmm.word.cntnts" /> <spring:message code="wzwg.cmm.word.nm01" /></th>
                    <td colspan="3">
                    	<c:set var="temp_cntntsnm"><spring:message code="wzwg.module.word.cntntsnm" /></c:set>
                    	<c:set var="titleName" value="${fn:escapeXml(temp_cntntsnm)}" />
                        <form:input path="reqstNm" id="reqstNm" cssClass="w70" dir="required" title="${fn:escapeXml(cntntsnm)}" />
                    </td>
                </tr>
            </tbody>
            </table>
            <!--//기본정보 table -->
            
        </form:form>
                
        <div class="rt-box">
            <a href="javascript:void(0);" id="regist_btn" onclick="javascript:fnRegist('M');" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
            <a href="javascript:void(0);" id="reset_btn" onclick="javascript:fnReset_btn();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
        </div>
