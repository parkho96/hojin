<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>


<script>

	function fnTabQnaLink(num) {
		
		var tabUrl = ["<c:out value="${wzwg_contextPath}${prefix}" />/module/ntt/qna/selectNttListAjax.do"
		              , "<c:out value="${wzwg_contextPath}${prefix}" />/module/ntt/qna/selectNttFaqListAjax.do"];
		
		var frm = document.frmTab;
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : tabUrl[num]
			, cache : false
			, async : false
			, data:$("#frmTab").serialize()
			, success:function (data) {
				$('#bbs_area').html(data);
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
</script>
 
    <form id="frmTab" name="frmTab" method="post">
        <input type="hidden" id="siteSeq" name="siteSeq" value="<c:out value="${paramVO.siteSeq}" />" />
        <input type="hidden" id="bbsSeq" name="bbsSeq" value="<c:out value="${paramVO.bbsSeq}" />" />
        <input type="hidden" id="sysMngrAt" name="sysMngrAt" value="<c:out value="${paramVO.sysMngrAt}" />" />
    </form>

	<div class="step1">
		<ul class="tapMenu">
			<c:if test="${fn:indexOf(nowUrl, 'NttList') > -1}">
				<li><a class="on" href="javascript:void(0);" onclick="fnTabQnaLink(0);"><span class="ico">▼</span><spring:message code="wzwg.sysMngr.word.allQestnAnswr01" /></a></li>
				<li><a href="javascript:void(0);" onclick="fnTabQnaLink(1);"><spring:message code="wzwg.cmm.word.faq" /></a></li>
			</c:if> 
			<c:if test="${fn:indexOf(nowUrl, 'NttFaqList') > -1}">
				<li><a href="javascript:void(0);" onclick="fnTabQnaLink(0);"><spring:message code="wzwg.sysMngr.word.allQestnAnswr01" /></a></li>
				<li><a class="on" href="javascript:void(0);" onclick="fnTabQnaLink(1);"><span class="ico">▼</span><spring:message code="wzwg.cmm.word.faq" /></a></li>
			</c:if> 
		</ul>
	</div>    