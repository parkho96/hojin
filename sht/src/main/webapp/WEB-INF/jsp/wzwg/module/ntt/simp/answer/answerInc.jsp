<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>   

	<div id="module_inc_<c:out value='${nttSimpAnswerVO.simpnttSeq}'/>">
		<ul>
			<li>
				<a href="javascript:void(0);" id="answer_ctrl_btn" class="red fw900" title="<spring:message code="wzwg.module.word.answerinputwindowopen" />">
					<font><spring:message code="wzwg.cmm.word.answer02" /> <span id="answer_cnt_txt_<c:out value='${nttSimpAnswerVO.simpnttSeq}'/>"><c:out value="${answerCnt}"/></span></font>
				</a>
			</li>
		</ul>
	</div>	

