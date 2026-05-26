<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
 
<script type="text/javascript">
 opener.stplatFrm.crtfc_name.value = '<c:out value="${paramVO.crtfc_name}" />'; 
 opener.stplatFrm.crtfctDn.value = '<c:out value="${paramVO.crtfctDn}" />';
 opener.stplatFrm.action="<c:out value="${wzwg_contextPath}" />/cmm/mber/sbscrb/selectSbscrbForm.do";
 opener.stplatFrm.submit();
 this.close();
</script>
</head> 
    