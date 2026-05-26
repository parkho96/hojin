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
<title><spring:message code="wzwg.module.word.stplatagre" /></title>
<link type="text/css" href="/css/wzwg/cmm/mber/sbscrb/style.css" rel="stylesheet" />
<link type="text/css" href="/css/wzwg/cmm/common.css" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
</head>

<body>
     

    <div class="signUp001 mg_10">
    <c:if test="${!empty resultList}">
    <c:forEach var="resultList" items="${resultList}" varStatus="status">
    <c:if test="${status.first}">
    <h2><c:out value="${resultList.stplatNm}" /></h2>
    <p><c:out value="${resultList.stplatDc}" /></p>
    </c:if>
    </c:forEach>
    <c:if test="${!empty resultVO}">
    <h2><c:out value="${resultVO.stplatNm}" /></h2>
    <p><c:out value="${resultVO.stplatDc}" /></p>
    </c:if>
    </c:if>
     
    <div class="signUp_wrap pd_t10">

        <form:form modelAttribute="paramVO" path="stplatFrm" id="stplatFrm" name="stplatFrm" method="post">
        <form:hidden path="siteSeq" />
        <input type="hidden" id="stplatArr" name="stplatArr" />
                   
        <c:if test="${!empty resultList}">
        <c:forEach var="resultList" items="${resultList}" varStatus="status">
            <div class="signUp_box pd_t10">
                <input type="hidden" id="stplatSeq<c:out value="${status.index + 1}" />" name="stplatSeq" value="<c:out value="${resultList.stplatSeq}" />" />
                <input type="hidden" id="stplatdetailSeq<c:out value="${status.index + 1}" />" name="stplatdetailSeq" value="<c:out value="${resultList.stplatdetailSeq}" />" />
                <h3><c:out value="${resultList.stplatNm}" /></h3>
                <div class="signClick mg_t10 pd_10">
                    <div class="fl_l">
                        <span><c:out value="${resultList.stplatDetailNm}" /></span>
                        <c:choose>
                        <c:when test="${resultList.essntlAgreAt eq 'Y'}"><font color="#FF2424">(<spring:message code="wzwg.cmm.word.essntl" />)</font></c:when>
                        <c:otherwise>(<spring:message code="wzwg.cmm.word.choise" />)</c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="signText pd_10">
                    <c:out value='${fn:replace(resultList.stplatDetailCn, cn, "<br />")}' escapeXml="true" />
                </div>
            </div>
        </c:forEach>
        </c:if>
        <c:if test="${!empty resultVO}">
            <div class="signUp_box pd_t10">
                <input type="hidden" id="stplatSeq" name="stplatSeq" value="<c:out value="${resultVO.stplatSeq}" />" />
                <input type="hidden" id="stplatsimpSeq" name="stplatsimpSeq" value="<c:out value="${resultVO.stplatsimpSeq}" />" />
                <h3><c:out value="${resultVO.stplatNm}" /></h3>
                <div class="signText pd_10">
                    <c:out value='${fn:replace(resultVO.stplatCn, cn, "<br />")}' escapeXml="true" />
                </div>
            </div>
        </c:if>
            
        </form:form>
     </div>
     <ul class="signUp_ul mg_t60">
        <li id="cancle_btn"><a class="sign_ftbt_on" href="javascript:void(0);" onclick="javascript:window.close();"><spring:message code="wzwg.cmm.word.close" /></a></li>
     </ul>
    </div>

</body>
</html>
    