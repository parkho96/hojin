<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
 <meta charset="UTF-8"/>
 <meta name="viewport" content="width=device-width, initial-scale=1"/>
 <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1"/> 
<title><spring:message code="wzwg.cmm.word.sitemap" /></title>
<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">

<!-- <link type="text/css" href="/css/wzwg/cmm/common.css" rel="stylesheet" /> -->
<link type="text/css" href="/css/wzwg/cmm/common.css" rel="stylesheet" />
<link type="text/css" href="/css/wzwg/cmm/mber/sitemap/style.css" rel="stylesheet" />

</head>

<body>
	 
	<div class="sitemap001 mg_10">
	 
		<h2><spring:message code="wzwg.cmm.word.sitemap" /></h2>
		<p><spring:message code="wzwg.cmm.msg.MSG288" /></p>
	 
		<div class="sitemap_wrap pd_t10">
		 	<ul class="sitemap_ul">
		 	
		 		<c:forEach items="${menuList }" var="menuListLv1" varStatus="status">
		 			<c:if test="${menuListLv1.menuLv eq 1}">
		 				<li>
		 					<p><c:out value="${menuListLv1.menuNm }"/></p>
	 						<ul>	
		 					<c:forEach items="${menuList }" var="menuListLv2">
		 						<c:if test="${menuListLv1.menuSeq eq menuListLv2.upperMenuSeq }">
		 							<li>
		 								<a href="<c:out value="${wzwg_contextPath}" />/subList/<c:out value="${menuListLv2.menuSeq }" />"><c:out value="${menuListLv2.menuNm }"/></a>
		 							</li>
		 						</c:if>
		 					</c:forEach>
	 						</ul>
		 				</li>
		 			</c:if>
		 		</c:forEach>
		 	
		 	</ul>
	 	</div>
	</div>

</body>
</html>
