<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<script>

opener.stplatFrm.crtfctSeCode.value = '<c:out value="${paramVO.crtfctSeCode}"/>';
 opener.stplatFrm.crtfctDn.value = '<c:out value="${paramVO.crtfctDn}"/>';
opener. actionSnsLogin();
 this.close();
 </script>
</head>

 