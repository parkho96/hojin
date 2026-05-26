<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<c:choose>
<c:when test="${fn:indexOf(prefix, '/mngr') > -1 || fn:indexOf(prefix, '/sysMngr') > -1}">
            
        <c:if test="${!empty qesitmList}">
        <div class="joinUs_box pt10">
            <h3 class="wzAdmSTit  wd100 fl"><spring:message code="wzwg.cmm.word.adiinfo" /></h3>

            <input type="hidden" id="sbscrbinfoSeq" name="sbscrbinfoSeq" value="<c:out value="${resultVO.sbscrbinfoSeq}" />" />
            
            <table class="basic">
            <colgroup>
                <col width="10%">
                <col width="90%">
            </colgroup>
            <tbody>
            <jsp:include page="/WEB-INF/jsp/wzwg/cmm/mber/sbscrb/siteSbscrbAdiForm.jsp" />
            </tbody>
            </table>
        
        </div>
        </c:if>   
</c:when>
<c:otherwise>


<script type="text/javascript" src="/js/wzwg/cmm/common.js" ></script>
<script type="text/javascript" src="/js/wzwg/cmm/mber/sbscrb.js" ></script>
<script type="text/javascript">
try{document.title = '<spring:message code="wzwg.cmm.word.signup" />-<spring:message code="wzwg.cmm.word.input" />';}catch(e){console.log(e.message);}

$(document).ready(function(){
    
    $("#dplct_btn").click(function(){
        
        if($("#inputUserId").val() == ''){
            alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.id02" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
            $("#inputUserId").focus();
            return;
        }else{
            var regex = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
            
            if(regex.test($("#inputUserId").val())){
                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG003"><spring:argument><spring:message code="wzwg.cmm.word.korid" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.use" /></spring:argument></spring:message>');
                $("#inputUserId").val("");
                $("#inputUserId").focus();
                return;
            }                   
        }
        
        $("#userId").val($("#inputUserId").val());
        
        $.ajax({
            type:'POST'
            , url: '<c:out value="${wzwg_contextPath}" />/cmm/mber/sbscrb/selectSbscrbUserIdDplctCeckAjax.do'
            , dataType: 'xml'
            , data:$("#frmReg").serialize()
            , success:function (result) {
              
                var value = "";
                
                $(result).find("value").each(function() {  
                    value = $(this).text();  
                });
                
                if(value == 'dplctN'){
                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG017"><spring:argument><spring:message code="wzwg.cmm.word.id02" /></spring:argument></spring:message>');
                    $("#dplctYn").val("N");
                    $("#userId").val("");
                    $("#dplct_div").hide();
                    $("#inputUserId").val("");
                    $("#inputUserId").focus();
                }else{
                    if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006"><spring:argument><spring:message code="wzwg.cmm.word.id02" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.use" /></spring:argument></spring:message>')) {
                        $("#dplctYn").val("N");
                        $("#userId").val("");
                        $("#dplct_div").hide();
                        $("#inputUserId").val("");
                        $("#inputUserId").focus();
                    }else{
                        $("#dplctYn").val("Y");
                        $("#userId").val($("#inputUserId").val());
                        $("#userIdTmp").val($("#inputUserId").val());
                        $("#dplct_div").show();
                        //$("#inputUserId").css('background', '#dddddd');
                    }
                }
              
            }
            , error:function (request, status, error) {
                alert('<spring:message code="fail.common.msg" text="error" />');
            }
        });
    });
    
    $(".nextBtn").click(function(){
        
        if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.signup" /></spring:argument></spring:message>')){
            alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.cancl" /></spring:argument></spring:message>');
            return;
        }else{
            

            <c:if test="${empty unityUsr}">
                if($("#userNm").val() == ''){
                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.nm02" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
                    return;
                }
            
                if($("#dplctYn").val() != 'Y'){
                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG012"><spring:argument><spring:message code="wzwg.cmm.word.id01" /></spring:argument></spring:message>');
                    return;
                }
                
                if($("#userIdTmp").val() != $("#inputUserId").val()){
                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG012"><spring:argument><spring:message code="wzwg.cmm.word.id01" /></spring:argument></spring:message>');
                    return;
                }
                
                <c:if test="${empty paramVO.crtfctSeCode or paramVO.crtfctSeCode eq 'SC00000306'}"> 
                if(document.frmReg.password.value == "") {
                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument><spring:message code="wzwg.cmm.word.password" /></spring:argument></spring:message>');
                    return;
                }
                
                if(document.frmReg.password.value != "") {
                    if(!fn_checkPassword(document.frmReg.userId, document.frmReg.password, document.frmReg.passwordCnfirm)){
                        return;
                    }
                }
                </c:if>
                

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

                <c:if test="${result.mberSbsfrmCode eq 'SC00000088' && result.qesitmEstbsSe eq 'E'}">
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
            
            var rspnsArr = new Array();
            
            for(var i = 1; i <= $('#sbscrbSiteArea input[name=qesitmSeq]').length; i++){
                 
                var rspns_data = new Object();
                
                rspns_data.sbscrbinfoSeq    = $('#sbscrbSiteArea input[id=sbscrbinfoSeq'+i+']').val();
                rspns_data.sbscrbqesitmSeq  = $('#sbscrbSiteArea input[id=qesitmSeq'+i+']').val();
                rspns_data.qesitmSe         = $('#sbscrbSiteArea input[id=qesitmSe'+i+']').val();
                
                if(rspns_data.qesitmSe == 'S'){
                    rspns_data.sbjctRspns   = $('#sbscrbSiteArea textarea[id=sbjctRspns'+i+']').val();
                }
                
                if(rspns_data.qesitmSe == 'O'){
                    rspns_data.sbscrbiemSeq = $('#sbscrbSiteArea input[id=sbscrbiemSeq'+i+'][type=radio]:checked').val();
                }
                
                rspnsArr.push(rspns_data);
            }
            
            var frm = document.frmReg;
            frm.rspnsArr.value = JSON.stringify(rspnsArr);
            
            $.ajax({
                type:'POST'
                <c:choose>
                <c:when test="${!empty unityUsr && unityUsr}">
                , url: '<c:out value="${wzwg_contextPath}" />/cmm/mber/sbscrb/registUnityUsrSbscrbInfoAjax.do'
                </c:when>
                <c:otherwise>
                , url: '<c:out value="${wzwg_contextPath}" />/cmm/mber/sbscrb/registUsrSbscrbInfoAjax.do'
                </c:otherwise>
                </c:choose>
                , dataType: 'xml'
                , data:$("#frmReg").serialize()
                , success:function (result) {
                  
                    var value = "";
                    
                    $(result).find("value").each(function() {  
                        value = $(this).text();  
                    });
                    
                    if(value == 'success'){
                        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.sbscrb" /></spring:argument></spring:message>');
                        //$("#cancle_btn").click();
                        
                        var frm = document.frmReg;
                        frm.action = "<c:out value="${wzwg_contextPath}" />/cmm/mber/sbscrb/selectSbscrbComptPage.do";
                        frm.submit();
                    }else{
                        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG002"><spring:argument><spring:message code="wzwg.cmm.word.sbscrb" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.null" /></spring:argument></spring:message>\n<spring:message code="wzwg.cmm.cmmMsg.CMG001"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument></spring:message>');
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
        var frm = document.frmReg;
        frm.action = "<c:out value="${wzwg_contextPath}" />/cmm/mber/sbscrb/selectSbscrbUsrTy.do";
        frm.submit();
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
});
</script>
             
    <form:form modelAttribute="paramVO" id="frmReg" name="frmReg" method="post">
    <form:hidden path="usrtySeq" id="usrtySeq" />
    <form:hidden path="usrTyCode" id="usrTyCode" />
    <form:hidden path="userId" id="userId" />
    <form:hidden path="crtfctDn" id="crtfctDn" />
    <form:hidden path="crtfctSeCode" id="crtfctSeCode" />
    <form:hidden path="stplatArr" id="stplatArr" /> 
    
    <input type="hidden" name="dplctYn" id="dplctYn" />
    <input type="hidden" name="userIdTmp" id="userIdTmp" />
    <input type="hidden" name="rspnsArr" id="rspnsArr" />
    
    <form:hidden path="crtfcSns" id="crtfcSns" /> 
    
    <input type="hidden" id="sbscrbinfoSeq" name="sbscrbinfoSeq" value="<c:out value="${resultVO.sbscrbinfoSeq}" />" />
    
    <h4 class="tit mb0"><spring:message code="wzwg.cmm.word.signup" /></h4>
    <!-- sbscrbWrap start -->  
    <div class="sbscrbWrap">        
        <ul class="sbscrbStep">
            <li class="stepOn">
            	<div class="stepBox">
	                <p class="num">01</p>
	                <p class="txt">
	                    <span><spring:message code="wzwg.cmm.word.stplat" /></span>
	                    <span class="blind"><spring:message code="wzwg.cmm.word.nowstep" /></span> 
	                </p>
                </div>
            </li>
            <li class="stepOn">
            	<div class="stepBox">
	                <p class="num">02</p>
	                <p class="txt">
	                    <span><spring:message code="wzwg.cmm.word.crtfc" /></span>
	                </p>
                </div>
            </li>
            <li class="stepOn">
            	<div class="stepBox">
	                <p class="num">03</p>
	                <p class="txt">
	                    <span><spring:message code="wzwg.cmm.word.input" /></span>
	                </p>
                </div>
            </li>
            <li>
            	<div class="stepBox">
	                <p class="num">04</p>
	                <p class="txt">
	                    <span><spring:message code="wzwg.cmm.word.compt" /></span>
	                </p>
                </div>
            </li>
        </ul>
        
        <div class="sbscrbText fs17 fw400 linehgt140 txt-c mb50">
       		<span><spring:message code="wzwg.cmm.msg.member.MSG004" /></span><br />
       		<span><spring:message code="wzwg.cmm.msg.member.MSG005" /></span>
       	</div>
       	
		<div class="sbscrbNaming">
			<spring:message code="wzwg.cmm.word.bassinfo" />
		</div>
         
        <%@include file="/WEB-INF/jsp/wzwg/cmm/mber/sbscrb/siteSbscrbForm.jsp" %>   
        
        <div class="sbscrbBtnbox">
	        <div class="sbscrbBtnwidth">
	            <a href="#" class="cancelBtn"><spring:message code="wzwg.cmm.word.cancl" /></a>
	            <a href="#" class="nextBtn"><spring:message code="wzwg.cmm.word.signup" /></a>
	        </div>
        </div>
    </div>
	<!-- sbscrbWrap end-->  
    </form:form>
</c:otherwise>
</c:choose>

    
    
    
    

        