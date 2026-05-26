<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>   

<li>
	<a href="javascript:void(0);" id="answer_ctrl_btn" class="red fw900" title="<spring:message code="wzwg.module.word.answerinputwindowopen" />">
		<font><spring:message code="wzwg.cmm.word.answer02" /> <span id="answer_cnt_txt"><c:out value="${answerCnt}"/></span></font>
	</a>
</li>
<input type="hidden" id="answerCnt" name="answerCnt" value="<c:out value='${answerCnt}'/>">
<%-- <li>
	<a href="javascript:void(0);" id="answer_ordr_btn" title="<spring:message code="wzwg.cmm.word.answer02"/> <spring:message code="wzwg.cmm.word.rgsde"/> <spring:message code="wzwg.cmm.word.wa.ascOrdr"/>">
		<span class="ordr_desc" style="display:none;"><spring:message code="wzwg.cmm.word.rgsde" /> ▼</span>
		<span class="ordr_asc"><spring:message code="wzwg.cmm.word.rgsde" /> ▲</span>
	</a>
</li> --%>