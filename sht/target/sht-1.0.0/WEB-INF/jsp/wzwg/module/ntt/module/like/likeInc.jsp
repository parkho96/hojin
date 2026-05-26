<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>   

<li>
	<a href="javascript:void(0);" id="like_ctrl_btn" title="<spring:message code="wzwg.cmm.msg.wa.MSG003" />">
		<font id="like_txt" class="font_txt"><spring:message code="wzwg.cmm.word.like" /> <span id="like_list_ordr">▲</span></font>
	</a>
</li>
<li>
	<div id="like_regist_div">
		<a href="javascript:void(0);" id="like_regist_btn" class="btn_likeit" title="<spring:message code="wzwg.module.word.likepush" />">
			<!-- 좋아요가 0 일 경우 -->
			<c:if test="${likeCnt eq 0}">
				<span class="red fw900">♡ </span> 0
			</c:if>
			
			<!-- 좋아요가 0 이 아니고, 좋아요를 누르지 않은 경우 -->
			<c:if test="${likeCnt ne 0}">
				<span id="regist_like_cnt" class="red fw900">♡ </span> <c:out value="${likeCnt}"/>
			</c:if>
		</a>
	</div>
	
	<div id="like_delete_div">
		<a href="javascript:void(0);" id="like_delete_btn" class="btn_likeit" title="<spring:message code="wzwg.module.word.likepushrelis" />">
			<font  class="red fw900">♥
				<span id="delete_like_cnt" class="red fw900"><c:out value="${likeCnt}"/></span>
			</font>
		</a>
	</div>
</li>