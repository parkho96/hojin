<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />

<title>::: <spring:message code="wzwg.cmm.word.preview" /> :::</title>

<link rel="stylesheet" href="/css/wzwg/sysMngr/dashboard/main.css" type="text/css" />
<link rel="stylesheet" href="/css/wzwg/sysMngr/dashboard/contents.css" type="text/css" />
<link rel="stylesheet" href="/css/wzwg/cmm/common.css" type="text/css" />
<link rel="stylesheet" href="/css/wzwg/sysMngr/dashboard/style.css" type="text/css" />
<link rel="stylesheet" href="/css/wzwg/sysMngr/dashboard/form.css" type="text/css" />
<link rel="stylesheet" href="/css/wzwg/site/mngr/style.css" type="text/css" />
	
	<table class="basic">
		<colgroup>
			<col width="*"/>
		</colgroup>
		<tbody>
			<tr>
				<td>
					<img src='<c:out value="${cntntsStyleVO.prevewPath }"/>' width="750" heigth="465"/>
				</td>
			</tr>
		</tbody>
	</table>
	
	<div class="ctr-box">
		<a href="javascript:void(0);" onclick="self.close();"><span class="btn-a"><spring:message code="wzwg.cmm.word.close" /></span></a>
	</div>
	