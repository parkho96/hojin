<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<html>
<head>
 
</head>
<body>
<form name="lincenseFrm" id="lincenseFrm" method="post" action="/genLicenseInfo.do">
<table>
<tr><td>ip </td><td><input type="text" name="ip" id="ip" value="999.999.999.999"/></td></tr>
<tr><td>date </td><td><input type="text" name="date" id="date" value="9999.99.99"/></td></tr>
<tr><td>siteCnt </td><td><input type="text" name="siteCnt" id="siteCnt " value="99999"/></td></tr>
</table>
<input type="submit"/>
</form>

</body>
</html>