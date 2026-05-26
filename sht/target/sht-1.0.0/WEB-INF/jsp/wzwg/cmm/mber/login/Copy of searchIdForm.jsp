<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
 
<link type="text/css" href="/css/wzwg/cmm/mber/login/style.css" rel="stylesheet" />
<script type="text/javascript">
$(document).ready(function(){
    
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

function actionLogin() {
    if (document.loginForm.userId.value =="") {
        $("#userId").focus();
        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.id01" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
    } else if (document.loginForm.password.value =="") {
        $("#password").focus();
        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.password" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
    } else {
    	
        $.ajax({
            type:'POST'
            , url: '/actionLogin.do'
            , dataType: 'xml'
            , data:$("#loginForm").serialize()
            , success:function (result) {
              
                var value = "";
                
                $(result).find("value").each(function() {  
                    value = $(this).text();  
                });
                
                var frm = document.loginForm;
                
                if(value == 'success'){
                    frm.action = "/index.do";
                    frm.submit();
                    
                }else{
                	if(value == 'fail'){
                    	alert('<spring:message code="wzwg.cmm.msg.MSG043" />');
                	} else {
                		alert(value);
                	}
                }
              
            }
            , error:function (request, status, error) {
                alert('<spring:message code="fail.common.msg" text="error" />');
            }
        });    	

    }
}

function fnSearchId() {

	var frm = document.idForm;

	if($("#userNm").val() == ''){
        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.nm02" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
        return;
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
	
    $.ajax({
        type:'post'
        , url:'/searchIdResultAjax.do'
        , data:$("#idForm").serialize()
        , dataType: 'html'
        ,success:function (data){
            $('#searchResultArea').html(data);
        }
        , error:function (request, status, error) {
              alert('<spring:message code="fail.common.msg" text="error" />');
          }
    });
}
</script>

	<div class="subConall">
		<div class="login001 mt80"> <!-- login start -->
			 <h2><spring:message code="wzwg.cmm.word.id02" /> <spring:message code="wzwg.cmm.word.search02" /></h2>
			 <p><spring:message code="wzwg.cmm.msg.MSG238" /></p>
			 
	  			<form:form modelAttribute="paramVO" path="idForm" id="idForm" name="idForm" method="post">
				<form:hidden path="siteSeq" />					 
			 
		  <div class="login-line">
			 <h3><spring:message code="wzwg.cmm.word.id02" /> <spring:message code="wzwg.cmm.word.search02" /></h3>
			 <div class="id-search">
			   <div class="login-box">	
				<div class="input-idsearch">
					<span><spring:message code="wzwg.cmm.word.nm02" /></span><input type="text" class="login-name" id="userNm" name="userNm" />
				</div>
				<div class="input-idsearch">
					<form:hidden path="emailAdres" />
					<span><spring:message code="wzwg.cmm.word.email" /></span>
					<ul>
						<li><input type="text" id="emailId" maxlength="100" onkeyup="fnKeyUpEvent('emailId', '6');"/></li>
						<li><span>@</span></li>
						<li><input type="text" id="emailDomn" maxlength="50" onkeyup="fnKeyUpEvent('emailDomn', '6');" disabled/></li>
						<li class="ml3">
		                    <select id="selDomn">
		                        <option value=""><spring:message code="wzwg.cmm.word.choise" /></option>
		                        <option value="naver.com">naver.com</option>
		                        <option value="gmail.com">gmail.com</option>
		                        <option value="daum.net">daum.net</option>
		                        <option value="nate.com">nate.com</option>
		                        <option value="directInput"><spring:message code="wzwg.cmm.word.drtinp" /></option>
		                    </select>								
							
						</li>
					</ul>
				</div>
				<div class="ctr-box">
					<a href="javascript:void(0);" class="btn-a" onclick="fnSearchId();"><spring:message code="wzwg.cmm.word.id02" /> <spring:message code="wzwg.cmm.word.search02" /></a>
				</div>
			   </div>
			 </div>
			 
			 <div id="searchResultArea" class="mt10"></div>

		 </div>
		 
		 </form:form>

		</div> <!-- login end -->
		
		
	</div>
	
    <div class="sbscrb002">
        <div class="sbscrbTopbox">
            <ul class="typeTop">
                <li><a href="#" class="on">개인(내/외국인)</a></li>
                <li><a href="#">개인사업자</a></li>
            </ul>
        </div>
        <div class="sbscrbBtmbox">
            <ul class="typeBtn">
                <li>
                    <a href="#">
                        <img src="./img/sbscrbPhone01.png" alt="" />
                        <p>폰번호로 <spring:message code="wzwg.cmm.word.search02" /></p>
                        <span>본인인증<img src="./img/sbscrbArrow.png" alt="" /></span>
                    </a>    
                </li>
                <li>
                    <a href="#">
                        <img src="./img/sbscrbMail01.png" alt="" />
                        <p>이메일로 <spring:message code="wzwg.cmm.word.search02" /></p>
                        <span>본인인증<img src="./img/sbscrbArrow.png" alt="" /></span>
                    </a>    
                </li>
            </ul>
        </div>
    </div><!-- sbscrb002 end -->
    