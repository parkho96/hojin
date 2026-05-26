<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<% 
    pageContext.setAttribute("cn", "\n"); 
%>
<!DOCTYPE html>
<html lang="en">
<head>
 <meta charset="UTF-8"/>
 <meta name="viewport" content="width=device-width, initial-scale=1"/>
 <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1"/> 
<title><spring:message code="wzwg.cmm.word.stplat" /> <spring:message code="wzwg.cmm.word.agre" /></title>
<link type="text/css" href="/css/wzwg/cmm/mber/sbscrb/style.css" rel="stylesheet" />
<link type="text/css" href="/css/wzwg/cmm/common.css" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
</head>

<body>
     

    <div class="signUp001 mg_10">
    <c:if test="${!empty resultList}">
    <c:forEach var="result" items="${resultList}" varStatus="status">
    <c:if test="${status.first}">
    <h2><c:out value="${result.stplatNm}" /></h2>
<%--     <p><c:out value="${result.stplatDc}" /></p> --%>
    </c:if>
    </c:forEach>
    </c:if>
     
    <div class="signUp_wrap pd_t10">

        <form:form modelAttribute="paramVO" path="stplatFrm" id="stplatFrm" name="stplatFrm" method="post">
        <form:hidden path="siteSeq" />
        <input type="hidden" id="stplatArr" name="stplatArr" />
                   
        <c:if test="${!empty resultList}">
        <c:forEach var="resultList" items="${resultList}" varStatus="status">
            <div class="signUp_box pd_t10">
                <h3><c:out value="${resultList.stplatSj}" /></h3>
                <div class="signText pd_10">
                    <c:out value='${fn:replace(resultList.stplatDetailCn, cn, "<br />")}' escapeXml="true" />
                </div>
            </div>
        </c:forEach>
        </c:if>
            
        </form:form>
     </div>
    </div>

</body>
</html>
    