<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>


<script type="text/javascript">

	$(document).ready(function(){
	    
	    $('#subospec_add_btn').click(function(){
	
	        if($('#addSubospecSj').val() == ''){
	            alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
						'<spring:argument><spring:message code="wzwg.sysMngr.word.ctgry02Sj" /></spring:argument>'+
						'<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>'+
					  '</spring:message>');
	            $('#addSubospecSj').focus();
	            return;
	        }
	        
	        $('#subospecSj').val($('#addSubospecSj').val());
	        
	        $.ajax({
	            type : 'POST'
	            , url : '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/bbs/cmmn/registBbsSubospecAjax.do'
	            , dataType : 'xml'
	            , data : $("#regForm").serialize()
	            , success : function (result) {
	              
	                var value = "";
	                
	                $(result).find("value").each(function() {  
	                    value = $(this).text();  
	                });
	                
	                if(value == 'success'){
	                    
	                    $.ajax({
	                        type : 'POST'
	                        , url : '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/bbs/cmmn/selectBbsSubospecListAjax.do'
	                        , dataType : 'html'
	                        , data : $("#regForm").serialize()
	                        , success : function (data) {
	                            $('#subospecList').html(data);
	                            $('#addSubospecSj').val("");
	                        }
	                        , error : function (request, status, error) {
	                            alert('<spring:message code="fail.common.msg" text="error" />');
	                        }
	                    });
	                    
	                }else{
	                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
	                }
	              
	            }
	            , error : function (request, status, error) {
	                alert('<spring:message code="fail.common.msg" text="error" />');
	            }
	        });
	        
	    });
	    
	});

    function fnRegist(callGubun) {

        var ajaxUrl = '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/bbs/qna';
        ajaxUrl += (callGubun != 'M')? '/registBbsBassInfoAjax.do':'/modifyBbsBassInfoAjax.do';

        if(!confirm('<spring:message code="wzwg.cmm.msg.MSG135" />')){
            return;
        }else{
            
            $.ajax({
                type : 'POST'
                , url : ajaxUrl
                , dataType : 'xml'
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
                            alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.sysMngr.word.bassInfo" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
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
    
    function fnReset_btn() {
        
        if(!confirm('<spring:message code="wzwg.cmm.msg.MSG305" />')){
            return;
        }else{
            $.ajax({
                type : 'POST'
                , url : '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/bbs/qna/selectQnaBbsBassInfoAjax.do'
                , dataType : 'html'
                , data : $("#regForm").serialize()
                , success : function (data) { 
                    $(".cocntainer_tabs > a").removeClass("active");
                    $("#bassInfo").addClass("tab active");
                    $('#bbs_area').html(data);
                }
                , error : function (request, status, error) {
                    alert('<spring:message code="fail.common.msg" text="error" />');
                }
            });
        }
    }
	
</script>

		<form:form modelAttribute="resultVO" path="regForm" id="regForm" name="regForm" method="post">
            <form:hidden path="sitecntntsSeq" />
			<form:hidden path="siteSeq" />
			<form:hidden path="bbsSeq" />
			<form:hidden path="bbsNm" />
			<form:hidden path="bbsDc" />
			
			<input type="hidden" id="subospecSj" name="subospecSj" />
			
			<div class="wz-box txt-c bg-grey p15 br-grey">
            	<span class="fs18"><spring:message code="wzwg.cmm.word.ctgry02" /></span>
            	 <input type="text" id="addSubospecSj" name="addSubospecSj" class="w50 ml10" />
	             <a href="javascript:void(0);" id="subospec_add_btn" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.add" /></a>
            </div>
            
            <div id="subospecList" class="mt10">	
                <c:import url="${wzwg_contextPath}${prefix}/opnsu/bbs/cmmn/selectBbsSubospecListAjax.do" charEncoding="utf-8">
                    <c:param name="param_bbsSeq" value="${resultVO.bbsSeq}" />
                </c:import>
            </div>
                            
            <%--                 
			<div class="rt-box">
					<a href="javascript:void(0);" class="wzbtn btn-del fl" id="reset_btn" onclick="javascript:fnReset_btn();"><spring:message code="wzwg.cmm.word.cancl" /></a>
					<a href="javascript:void(0);" class="wzbtn btn-save" id="regist_btn" onclick="javascript:fnRegist('M');"><spring:message code="wzwg.cmm.word.stre" /></a>
			</div>    			
			 --%>		

			
		</form:form>
				
