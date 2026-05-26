<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript" src="/js/wzwg/cmm/common.js" ></script>
<script type="text/javascript" src="/js/wzwg/cmm/mber/sbscrb.js" ></script>

<script type="text/javascript">
<c:if test="${empty infoVO or sessionScope.SADMIN_AT or sessionScope.NADMIN_AT}">
	alert('<spring:message code="wzwg.cmm.msg.member.MSG008" />\n<spring:message code="wzwg.cmm.msg.member.MSG009" />');
	location.href='<c:out value="${wzwg_contextPath}" />/index.do';
</c:if>

<c:if test="${not empty infoVO}">
try{document.title = '<spring:message code="wzwg.cmm.word.mberinfo" />-<spring:message code="wzwg.cmm.word.youracct" />';}catch(e){console.log(e.message);}
$(document).ready(function(){
    
    /** 저장하기 */
    $(".nextBtn").click(function(){
        
        if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>')){
            alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.cancl" text="cancle" /></spring:argument></spring:message>');
            return;
        }else{

            <c:if test="${paramVO.unitySbscrbYn ne 'Y'}">
            
    		if(document.usrInfoForm.password.value != "") {
    			if(!fn_checkPassword(document.usrInfoForm.userId, document.usrInfoForm.password, document.usrInfoForm.passwordCnfirm)){
    				return;
    			}
    		}
            
            if($("#emailId").val() == ''){
                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.email" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
                return;
            }
			if($("#emailDomn").val() == ''){
                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.email" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
                return;
            }            
			
			$("#emailAdres").val($("#emailId").val()+"@"+$("#emailDomn").val());   
    		
            <c:if test="${!empty sbsFormList}">
            <c:forEach items="${sbsFormList}" var="result">
            
            
				<c:if test="${result.mberSbsfrmCode eq 'SC00000085' && result.qesitmEstbsSe eq 'E'}">					
				
 				if($("#bassAdres").val() != $("#bassAdres").val()){
                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.basadr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
                    return;
                }
 				if($("#detailAdres").val() != $("#detailAdres").val()){
                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.detailadr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
                    return;
                }

			</c:if>
			
				<c:if test="${result.mberSbsfrmCode eq 'SC00000086' && result.qesitmEstbsSe eq 'E'}">

				if($("#mTelnoF").val() == ''){
	                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.cttpc" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
	                return;
	            }
				if($("#mTelnoC").val() == ''){
	                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.cttpc" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
	                return;
	            }
				if($("#mTelnoL").val() == ''){
	                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.cttpc" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
	                return;
	            }

				</c:if>		
				
				<c:if test="${result.mberSbsfrmCode eq 'SC00000087' && result.qesitmEstbsSe eq 'E'}">			

				if($("#hTelnoF").val() == ''){
	                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.mbtlnum" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
	                return;
	            }
				if($("#hTelnoC").val() == ''){
	                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.mbtlnum" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
	                return;
	            }
				if($("#hTelnoL").val() == ''){
	                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.mbtlnum" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
	                return;
	            } 						

            </c:if>

            <c:if test="${result.mberSbsfrmCode eq 'SC00000088' && result.qesitmEstbsSe ne 'N'}">
            if($("#email").val() == ''){
                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.email" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
                return;
            }
            if($("#typeInput").val() == ''){
                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.email" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
                return;
            }
        
            $("#emailAdres").val($("#email").val()+"@"+$("#typeInput").val());  
            </c:if>

            </c:forEach>
            </c:if>	        		

        </c:if>
        
        <c:if test="${paramVO.unitySbscrbYn eq 'Y'}">
            $("#userId").val('<c:out value="${paramVO.userId}" />');
        </c:if>        	
            
            var rspnsArr = new Array();
            
            for(var i = 1; i <= $('#sbscrbSiteArea input[name=qesitmSeq]').length; i++){
                // 객체 생성
                var rspns_data = new Object();
                
                rspns_data.sbscrbinfoSeq    = $('#sbscrbSiteArea input[id=sbscrbinfoSeq'+i+']').val();
                rspns_data.sbscrbqesitmSeq  = $('#sbscrbSiteArea input[id=qesitmSeq'+i+']').val();
                rspns_data.qesitmSe         = $('#sbscrbSiteArea input[id=qesitmSe'+i+']').val();
                rspns_data.sbscrbrspns      = $('#sbscrbSiteArea input[id=sbscrbrspns'+i+']').val();
                
                if(rspns_data.qesitmSe == 'S'){
                    rspns_data.sbjctRspns   = $('#sbscrbSiteArea textarea[id=sbjctRspns'+i+']').val();
                }
                
                if(rspns_data.qesitmSe == 'O'){
                    rspns_data.sbscrbiemSeq = $('#sbscrbSiteArea input[name=sbscrbiemSeq'+i+'][type=radio]:checked').val();
                }
                
                // 리스트에 생성된 객체 삽입
                rspnsArr.push(rspns_data);
            }
            
            var frm = document.usrInfoForm;
            frm.rspnsArr.value = JSON.stringify(rspnsArr);
            
            $.ajax({
                type:'POST'
                , url: '<c:out value="${wzwg_contextPath}" />/cmm/mber/myPage/modifyUsrInfoAjax.do'
                , dataType: 'xml'
                , data:$("#usrInfoForm").serialize()
                , success:function (result) {
                  
                    var value = "";
                    
                    $(result).find("value").each(function() {  
                        value = $(this).text();  
                    });
                    
                    if(value == 'success'){
                        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>');
                        
                    }else{
                        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
                    }
                  
                }
                , error:function (request, status, error) {
                    alert('<spring:message code="fail.common.msg" text="error" />');
                }
            });
        }
            
    });
    
    /** 취소 */
    $(".cancelBtn").click(function(){
    	var frm = document.usrInfoForm;
    	if(confirm('<spring:message code="wzwg.cmm.msg.MSG255" />')) {
    		frm.reset();
    	}
    });
    
    /* 이메일 도메인 변경 */
    $("#selDomn").change(function(){
        
        if($("#selDomn").val() == "directInput"){
            $("#emailDomn").prop("disabled", false);
            $("#emailDomn").val("");
            $("#emailDomn").focus();
        }else{
            $("#emailDomn").prop("disabled", true);
            $("#emailDomn").val($("#selDomn").val());               
        }
        
    });
    
 
        var topHeight=0;
        $("#content > div").each(function(){
               if(topHeight< Number($(this).css("top").replace("px",""))+ Number($(this).css("height").replace("px",""))){
                   topHeight = Number($(this).css("top").replace("px",""))+ Number($(this).css("height").replace("px",""));
               }
           });
        
        if($("#content").css("height")=='100%'){
            $("#content").css("height",topHeight);
        }
        
        $("#content").css("height",$(document).height());

//         fnUsrFormChange();
});

// function fnUsrFormChange() {
//     var frm = document.frmCode;
    
//     frm.frmGubun.value = "M";
    
//     $.ajax({
//         type:'post'
//         , url:'/selectSbscrbForm.do'
//         , data:$("#frmCode").serialize()
//         , dataType: 'html'
//         ,success:function (data){
//             $('#sbscrbSiteArea').html(data);
//         }
//         , error:function (request, status, error) {
//               alert('<spring:message code="fail.common.msg" text="error" />');
//           }
//     });
// }

function fn_checkPassword(paramId, paramPassword, paramPasswordCnfirm){
	if (paramPassword.value != paramPasswordCnfirm.value) {
		alert("<spring:message code="wzwg.cmm.msg.MSG003" />"); 
		return false;
	}
	if (paramPassword.value.length < 10 || paramPassword.value.length > 16) {
		alert("<spring:message code="wzwg.cmm.msg.MSG052" />");
		return false;
	}
	if (!paramPassword.value
			.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/)) {
		alert("<spring:message code="wzwg.cmm.msg.MSG052" />");
		return false;
	}

	if (paramId.value.indexOf(paramPassword) > -1) {
		alert("<spring:message code="wzwg.cmm.msg.MSG055" />");
		return false;
	}

	var SamePass_0 = 0; // 동일문자 카운트
	var SamePass_1 = 0; // 연속성(+) 카운드
	var SamePass_2 = 0; // 연속성(-) 카운드

	var chr_pass_0;
	var chr_pass_1;
	var chr_pass_2;

	for (var i = 0; i < paramPassword.value.length; i++) {
		chr_pass_0 = paramPassword.value.charAt(i);
		chr_pass_1 = paramPassword.value.charAt(i + 1);

		// 동일문자 카운트
		if (chr_pass_0 == chr_pass_1) {
			SamePass_0 = SamePass_0 + 1
		}

		chr_pass_2 = paramPassword.value.charAt(i + 2);
		// 연속성(+) 카운드
		if (chr_pass_0.charCodeAt(0) - chr_pass_1.charCodeAt(0) == 1
				&& chr_pass_1.charCodeAt(0) - chr_pass_2.charCodeAt(0) == 1) {
			SamePass_1 = SamePass_1 + 1
		}

		// 연속성(-) 카운드
		if (chr_pass_0.charCodeAt(0) - chr_pass_1.charCodeAt(0) == -1
				&& chr_pass_1.charCodeAt(0) - chr_pass_2.charCodeAt(0) == -1) {
			SamePass_2 = SamePass_2 + 1
		}
	}
	if (SamePass_0 > 1) {
		alert("<spring:message code="wzwg.cmm.msg.MSG054" />");
		return false;
	}

	if (SamePass_1 > 1 || SamePass_2 > 1) {
		alert("<spring:message code="wzwg.cmm.msg.MSG056" />");
		return false;
	}
	return true;
	
}

function numkeyCheck(e) { 
    var keyValue = event.keyCode; 
    if( ((keyValue >= 48) && (keyValue <= 57)) ) {
        return true;
    } else {
        return false; 
    }
}

function fnUsrSecsn(){
	if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.wa.really" /> <spring:message code="wzwg.cmm.word.secsn" /></spring:argument></spring:message>')) {
        $.ajax({
            type:'POST'
            , url: '<c:out value="${wzwg_contextPath}" />/cmm/mber/myPage/modifyUsrSecsnAjax.do'
            , dataType: 'xml'
            , data:$("#usrInfoForm").serialize()
            , success:function (result) {
              
                var value = "";
                
                $(result).find("value").each(function() {  
                    value = $(this).text();  
                });
                
                if(value == 'success'){
                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.secsn" /> <spring:message code="wzwg.cmm.word.process" /></spring:argument></spring:message>');
                    location.href="<c:out value="${wzwg_contextPath}" />/index.do";
                }else{
                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG010"><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
                }
              
            }
            , error:function (request, status, error) {
                alert('<spring:message code="fail.common.msg" text="error" />');
            }
        }); 
	}
}
</c:if>
</script>

    <form:form modelAttribute="paramVO" id="usrInfoForm" name="usrInfoForm" method="post">
    <input type="hidden" name="siteSeq" id="siteSeq" value="<c:out value="${infoVO.siteSeq}" />"/>
    <input type="hidden" name="usrSeq" id="usrSeq" value="<c:out value="${infoVO.usrSeq }" />"/>
    <input type="hidden" name="userId" id="userId" value="<c:out value="${infoVO.userId }" />"/>
    <input type="hidden" name="rspnsArr" /> 
    <form:hidden path="usrTyCode" />
    <form:hidden path="usrtySeq" />
    <form:hidden path="usrgroupSeq" />
    
    <!-- sbscrbBox start -->
    <div class="sbscrbWrap">
    	<h4 class="fs40 fw400 txt-c mb50"><spring:message code="wzwg.cmm.word.youracct" /></h4>
    	
        <div class="sbscrbLoginbox"> 
        
	        <div class="sbscrbNaming">
				<spring:message code="wzwg.cmm.word.bassinfo" />
			</div>
         
        	<%@include file="/WEB-INF/jsp/wzwg/cmm/mber/sbscrb/siteSbscrbForm.jsp" %>   
        
	        <div class="sbscrbBtnbox">
				<div class="sbscrbBtnwidth">
					<a href="javascript:void(0);" class="nextBtn"><spring:message code="wzwg.cmm.word.stre" /></a>
					<!-- <a href="javascript:void(0);" class="cancelBtn"><spring:message code="wzwg.cmm.word.cancl" /></a> -->
					<a href="javascript:void(0);" class="cancelBtn" onclick="fnUsrSecsn();"><spring:message code="wzwg.cmm.word.secsn" /></a>
				</div>
	         </div>
          
    	</div>
    <div>
	<!-- sbscrbBox end -->
	
    </form:form>