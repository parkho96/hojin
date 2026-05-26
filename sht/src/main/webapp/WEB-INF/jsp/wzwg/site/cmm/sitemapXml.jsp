<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">	
	<c:forEach items="${resultList}" var="list" varStatus="status">
		<c:if test="${list.menuDivision ne 'link' and list.menuDivision ne 'group'}">
		<url>
			<loc><c:out value="${domain}"/><c:out value="${wzwg_contextPath}"/>/subList/<c:out value="${list.menuLinkSeq}"/></loc>
			<changefreq>weekly</changefreq> 
		</url>
		</c:if>
	</c:forEach>
</urlset>