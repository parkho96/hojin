<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>


	<c:if test="${!empty subospecList}">
	<script>
	function subospecSjTxt(txt){
		if('<c:out value="${paramVO.cateTy}"/>' == 'L'){
			return;
		}
		if('<c:out value="${paramVO.cateTy}"/>' == ''){
			return;
		}

		var subSjTxt = $('#subospecSj_txt');
		if(subSjTxt.length == 1){
			subSjTxt.html(txt);
		}else{
			$('#bbs_area table').eq(0).before('<h6 id="subospecSj_txt">' + txt + '</h6>');
		}
	}
	
	subospecSjTxt(wz_msg('wzwg.cmm.word.all'));
	</script>
	
		<c:set var="ctgrySeTit"><spring:message code="wzwg.module.word.ctgryse" /></c:set>
		<c:if test="${paramVO.cateTy eq 'L' or empty paramVO.cateTy}">
		
		<c:set var="temp_ctgrySeTit"><c:out value="${ctgrySeTit}" /></c:set>
		<select name="subospecSeq" id="subospecSeq" title="<c:out value='${temp_ctgrySeTit}'/>">
		    <option value=""><spring:message code="wzwg.module.word.ctgrychoise" /></option>
		    <c:forEach var="subospecList" items="${subospecList}" varStatus="status">
		        <c:set var="temp_suboSeq"><c:out value="${subospecList.subospecSeq}" /></c:set>
		        <c:set var="temp_suboSj"><c:out value="${subospecList.subospecSj}" /></c:set>
		        <option value="<c:out value='${temp_suboSeq}'/>">
		            <c:out value="${temp_suboSj}"/>
		        </option>
		    </c:forEach>
		</select>
		
		<button type="button" class="wzbtn btn-basic" id="btn_subospecSeq"><spring:message code="wzwg.cmm.word.search" /></button>
		</c:if>
		
		<c:if test="${paramVO.cateTy eq 'T'}">
			<input type="hidden" name="subospecSeq" id="subospecSeq" value="<c:out value='${paramVO.subospecSeq}'/>">
			<input type="hidden" name="subospecSj" id="subospecSj" value="<c:out value='${paramVO.subospecSj}'/>">
			<div class="wztab board">
				<ul class="wztab-list">
						<li class="wztab-item<c:if test="${empty paramVO.subospecSeq }"> active</c:if>">
							<button type="button" onclick="fnSubospecSeq('');subospecSjTxt('<spring:message code="wzwg.cmm.word.all" />');"><spring:message code="wzwg.cmm.word.all" /></button>
						</li>
					<c:forEach var="subospecList" items="${subospecList}" varStatus="status">
						<li class="wztab-item<c:if test="${paramVO.subospecSeq eq subospecList.subospecSeq}"> active</c:if>">
							<button type="button" onclick="fnSubospecSeq('<c:out value="${subospecList.subospecSeq}"/>');subospecSjTxt('<c:out value="${subospecList.subospecSj}"/>');" id="tabBtn-<c:out value='${subospecList.subospecSeq }'/>"><c:out value="${subospecList.subospecSj}"/></button>
						</li>
					</c:forEach>
				</ul>
			</div>
			<script>
				$(document).ready(function(){
					wzTabInit();
				})
			</script>
		</c:if>
		
	</c:if>
	
	