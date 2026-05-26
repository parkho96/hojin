<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ taglib prefix="c"           uri="http://java.sun.com/jsp/jstl/core" %>
<script>
   
<c:choose>
<c:when test="${!empty niceSuccessMap.sDupInfo}">
   var retDi = "<c:out value="${niceSuccessMap.sDupInfo}" />"; 
    
   opener.document.stplatFrm.crtfctDn.value = retDi;
   opener.fnEstbsPass();
</c:when>
<c:otherwise>
   opener.fnCrtfcRetMessage('<c:out value="${niceSuccessMap.sMessage}" />');
</c:otherwise>
</c:choose>
   
   window.close();


</script>
