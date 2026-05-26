<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ taglib prefix="c"           uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/js/wzwg/cmm/jquery-latest.min.js"></script>
<script>

    <c:choose>
    <c:when test="${!empty snsCrtfcMap.crtfctDn}">
    opener.document.stplatFrm.crtfctDn.value = '<c:out value="${snsCrtfcMap.crtfctDn}" />';
    if ($(opener.document).find('#stplatFrm').find('#crtfc_name').length > 0) opener.document.stplatFrm.crtfc_name.value = '<c:out value="${snsCrtfcMap.crtfc_name}" />';
    if ($(opener.document).find('#stplatFrm').find('#crtfc_email').length > 0) opener.document.stplatFrm.crtfc_email.value = '<c:out value="${snsCrtfcMap.crtfc_email}" />';
    if ($(opener.document).find('#stplatFrm').find('#crtfcSns').length > 0) opener.document.stplatFrm.crtfcSns.value = '<c:out value="${snsCrtfcMap.crtfcSns}" />';
    if ($(opener.document).find('#stplatFrm').find('#crtfcSe').length > 0) opener.document.stplatFrm.crtfcSe.value = '<c:out value="${snsCrtfcMap.crtfcSe}" />';
    opener.fnEstbsPass();
    </c:when>
    <c:otherwise>
       opener.fnCrtfcRetMessage('<c:out value="${message}" />');
    </c:otherwise>
    </c:choose>
    window.close();


</script>