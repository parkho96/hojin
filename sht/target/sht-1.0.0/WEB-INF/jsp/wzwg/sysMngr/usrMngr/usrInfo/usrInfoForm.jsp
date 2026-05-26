<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

	<script type="text/javascript">
	
		function fnRegist() {
			alert('아직은 때가 아니야!!!!');
			return;
		}
		
		function fnList() {
			document.regForm.action = "<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/usrInfo/selectUsrInfoList.do";
			document.regForm.submit();
		}
	
	</script>


				사용자정보관리 수정 화면!!!					
				
				<div class="ta_c mg_t20">
					<a href="javascript:void(0);"><span class="btn btn_primary btn_lg" onclick="fnRegist();"><spring:message code="wzwg.cmm.word.tostre" /></span></a>
					<a href="javascript:void(0);"><span class="btn btn_default btn_lg" onclick="fnList();"><spring:message code="wzwg.cmm.word.cancl" /></span></a>
				</div>
