<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<% 
    pageContext.setAttribute("cn", "\n"); 
%>
<link type="text/css" href="/css/wzwg/cmm/mber/sbscrb/style.css" rel="stylesheet" />
<script type="text/javascript">
$(document).ready(function(){	
	
	if(document.crtfcFrm.usrtySeq.value=="") {
		alert("<spring:message code="wzwg.cmm.msg.MSG120" />");
		document.crtfcFrm.action = "/cmm/mber/sbscrb/selectSbscrbUsrTy.do";
		document.crtfcFrm.submit();
	}
    
    /** 취소 */
    $("#cancle_btn").click(function(){
        var frm = document.crtfcFrm;
        frm.action = "/loginForm.do";
        frm.submit();
    });
    
});


/** 가입폼으로 이동 */
function fnNext(val) {
    var frm = document.crtfcFrm;

    frm.action = "/cmm/mber/sbscrb/selectSbscrbForm.do";
    frm.submit();
};

</script>



 	<div class="subConall">
		 <div class="joinUs001 mg10">
			 <ul class="joinTop_ul mb40">
					<li><span>1. <spring:message code="wzwg.cmm.word.tmacnd" /> <spring:message code="wzwg.cmm.word.cnfirm" /></span></li>
					<li><span class="sign_menu_on">2. <spring:message code="wzwg.cmm.word.bass" /> <spring:message code="wzwg.cmm.word.info" /> <spring:message code="wzwg.cmm.word.input" /></span></li>
					<li><span>3. <spring:message code="wzwg.cmm.word.signup" /> <spring:message code="wzwg.cmm.word.compt" /></span></li>
			 </ul>
			 <h2><spring:message code="wzwg.cmm.word.signup" /></h2>
			 <p><spring:message code="wzwg.cmm.msg.MSG115" /></p>
			 
	        <form:form modelAttribute="paramVO" path="crtfcFrm" id="crtfcFrm" name="crtfcFrm" method="post">
	        <form:hidden path="siteSeq" />
	        <form:hidden path="usrtySeq" />
	        <form:hidden path="usrTyCode" />	
	        <form:hidden path="usrgroupSeq" />
	        <input type="hidden" id="stplatArr" name="stplatArr" value="<c:out value="${paramVO.stplatArr}" />"/>	

			 <div class="joinUs_wrap pt40">
			 		<ul class="type3">
						<li>
							<a href="javascript:void(0);" onclick="fnNext('1');">
								<span><spring:message code="wzwg.cmm.word.adult" /></span>
								<p><spring:message code="wzwg.cmm.cmmMsg.CMG019"><spring:argument><spring:message code="wzwg.cmm.word.adult" /> <spring:message code="wzwg.cmm.word.ty" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.sbscrb" /></spring:argument></spring:message></p>
								<div class="a1"><spring:message code="wzwg.cmm.word.shrtcut" /></div>
							</a>
						</li>
						<li>
							<a href="javascript:void(0);" onclick="fnNext('2');">
								<span><spring:message code="wzwg.cmm.word.yngbgs" /></span>
								<p><spring:message code="wzwg.cmm.cmmMsg.CMG019"><spring:argument><spring:message code="wzwg.cmm.word.yngbgs" /> <spring:message code="wzwg.cmm.word.ty" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.sbscrb" /></spring:argument></spring:message></p>
								<div class="a2"><spring:message code="wzwg.cmm.word.shrtcut" /></div>
							</a>	
						</li>
						<li>
							<a href="javascript:void(0);" onclick="fnNext('3');">
								<span><spring:message code="wzwg.cmm.word.infnt" /></span>
								<p><spring:message code="wzwg.cmm.cmmMsg.CMG019"><spring:argument><spring:message code="wzwg.cmm.word.infnt" /> <spring:message code="wzwg.cmm.word.ty" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.sbscrb" /></spring:argument></spring:message></p>
								<div class="a3"><spring:message code="wzwg.cmm.word.shrtcut" /></div>
							</a>	
						</li>
					</ul>				
			 </div>
			 
			 </form:form>
			 

			 <ul class="joinUs_ul mt60">
				<li><a class="sign_ftbt_on" href="javascript:void(0);" id="cancle_btn"><spring:message code="wzwg.cmm.word.cancl" /></a></li>
			 </ul>

		</div><!-- 회원가입 end -->
 	</div>

    