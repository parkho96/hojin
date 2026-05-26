<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"           uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"          uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring"      uri="http://www.springframework.org/tags" %>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<div class="subMenu">
    <h3 class="menuNm"><span><spring:message code="wzwg.cmm.word.mberinfo" /></span></h3>
    <ul class="slidebar tendina">


 <c:if test="${fn:indexOf(nowUrl, '/adLoginForm.do') > -1}">
  <li class="selected">
     <a href="<c:out value="${wzwg_contextPath}" />/adLoginForm.do" data-href="menuLinkSeq" data-attr="menuNm" class="<c:if test="${fn:indexOf(nowUrl, '/adLoginForm.do') > -1}">on</c:if>"><spring:message code="wzwg.cmm.word.mngrlogin" /></a>
  </li>
  </c:if>
  <c:if test="${fn:indexOf(nowUrl, '/adLoginForm.do') eq -1}">
          
        <c:if test="${empty sessionScope.loginVO}">
        <li class="<c:if test="${fn:indexOf(nowUrl, '/loginForm.do') > -1}">selected</c:if>">
            <a href="<c:out value="${wzwg_contextPath}" />/loginForm.do" data-href="menuLinkSeq" data-attr="menuNm" class="<c:if test="${fn:indexOf(nowUrl, '/loginForm.do') > -1}">on</c:if>"><spring:message code="wzwg.cmm.word.login" /></a>
        </li>
        
        <li class="<c:if test="${fn:indexOf(nowUrl, '/selectSbscrbUsrTy.do') > -1 || fn:indexOf(nowUrl, '/selectSbscrbForm.do') > -1 || fn:indexOf(nowUrl, '/selectSbscrbComptPage.do') > -1 || fn:indexOf(nowUrl, '/selectSbscrbStplat.do') > -1}">selected</c:if>">
            <a href="<c:out value="${wzwg_contextPath}" />/cmm/mber/sbscrb/selectSbscrbUsrTy.do" data-href="menuLinkSeq" data-attr="menuNm" class="<c:if test="${fn:indexOf(nowUrl, '/selectSbscrbUsrTy.do') > -1 || fn:indexOf(nowUrl, '/selectSbscrbForm.do') > -1 || fn:indexOf(nowUrl, '/selectSbscrbComptPage.do') > -1 || fn:indexOf(nowUrl, '/selectSbscrbStplat.do') > -1}">on</c:if>"><spring:message code="wzwg.cmm.word.signup" /></a>
        </li>
        </c:if>
        
        <c:if test="${!empty sessionScope.loginVO}">
        <li class="<c:if test="${fn:indexOf(nowUrl, '/cmm/mber/myPage/') > -1 || fn:indexOf(nowUrl, '/searchIdForm.do') > -1 || fn:indexOf(nowUrl, '/searchId.do') > -1 || fn:indexOf(nowUrl, '/searchPwForm.do') > -1 || fn:indexOf(nowUrl, '/cmm/mber/search/modifyPwForm.do') > -1 || fn:indexOf(nowUrl, '/cmm/mber/search/searchPwCrtfcForm.do') > -1 || fn:indexOf(nowUrl, '/selectMyStplatAgreDetail.do') > -1 || fn:indexOf(nowUrl, '/selectMyStplatAgreList.do') > -1}">selected</c:if>">
        <a href="#" data-href="menuLinkSeq" data-attr="menuNm" class="<c:if test="${fn:indexOf(nowUrl, '/cmm/mber/myPage/') > -1 || fn:indexOf(nowUrl, '/searchIdForm.do') > -1 || fn:indexOf(nowUrl, '/searchId.do') > -1 || fn:indexOf(nowUrl, '/searchPwForm.do') > -1 || fn:indexOf(nowUrl, '/cmm/mber/search/modifyPwForm.do') > -1 || fn:indexOf(nowUrl, '/cmm/mber/search/searchPwCrtfcForm.do') > -1 || fn:indexOf(nowUrl, '/selectMyStplatAgreDetail.do') > -1 || fn:indexOf(nowUrl, '/selectMyStplatAgreList.do') > -1}">on</c:if>"><spring:message code="wzwg.cmm.word.mber" /> <spring:message code="wzwg.cmm.word.info" /> <span></span></a>
            <ul class="<c:if test="${fn:indexOf(nowUrl, '/cmm/mber/myPage/') > -1}">selected</c:if>" style="display: <c:if test="${fn:indexOf(nowUrl, '/cmm/mber/myPage/') > -1}">block</c:if>;">
                <c:if test="${!empty sessionScope.loginVO}">
                <li class="deepest">
                    <a href="<c:out value="${wzwg_contextPath}" />/cmm/mber/myPage/selectMyPageMain.do" data-href="menuLinkSeq" data-attr="menuNm" class="<c:if test="${fn:indexOf(nowUrl, '/selectMyPageMain.do') > -1 || fn:indexOf(nowUrl, '/selectMyPageForm.do') > -1}">on</c:if>">
                        <span class="bull">•</span> <spring:message code="wzwg.cmm.word.youracct" />
                    </a>
                </li>
                <li class="deepest">
                    <a href="<c:out value="${wzwg_contextPath}" />/cmm/mber/myPage/selectMyStplatAgreList.do" data-href="menuLinkSeq" data-attr="menuNm" class="<c:if test="${fn:indexOf(nowUrl, '/selectMyStplatAgreList.do') > -1 || fn:indexOf(nowUrl, '/selectMyStplatAgreDetail.do') > -1}">on</c:if>">
                        <span class="bull">•</span> <spring:message code="wzwg.cmm.word.stplatagrehist" />
                    </a>
                </li>
                <li class="deepest">
                    <a href="<c:out value="${wzwg_contextPath}" />/cmm/mber/myPage/selectMyWritngInc.do" data-href="menuLinkSeq" data-attr="menuNm" class="<c:if test="${fn:indexOf(nowUrl, '/selectMyWritngInc.do') > -1}">on</c:if>">
                        <span class="bull">•</span> <spring:message code="wzwg.cmm.word.writngnttanswer" />
                    </a>
                </li>
                <%-- <li class="deepest">
                    <a href="${wzwg_contextPath}/cmm/mber/myPage/selectMyScrapInc.do" data-href="menuLinkSeq" data-attr="menuNm" class="<c:if test="${fn:indexOf(nowUrl, '/selectMyScrapInc.do') > -1}">on</c:if>">
                        <span class="bull">•</span> <spring:message code="wzwg.cmm.word.scrap" /> <spring:message code="wzwg.cmm.word.list" />
                    </a>
                </li> --%>
                </c:if>
                <c:if test="${empty sessionScope.loginVO}">
                <li class="deepest">
                    <a href="<c:out value="${wzwg_contextPath}" />/searchIdForm.do" data-href="menuLinkSeq" data-attr="menuNm" class="<c:if test="${fn:indexOf(nowUrl, '/searchIdForm.do') > -1 || fn:indexOf(nowUrl, '/searchId.do') > -1}">on</c:if>">
                        <span class="bull">•</span> <spring:message code="wzwg.cmm.word.findi" />
                    </a>
                </li>
                <li class="deepest">
                    <a href="<c:out value="${wzwg_contextPath}" />/searchPwForm.do" data-href="menuLinkSeq" data-attr="menuNm" class="<c:if test="${fn:indexOf(nowUrl, '/searchPwForm.do') > -1 || fn:indexOf(nowUrl, '/cmm/mber/search/modifyPwForm.do') > -1 || fn:indexOf(nowUrl, '/cmm/mber/search/searchPwCrtfcForm.do') > -1}">on</c:if>">
                        <span class="bull">•</span> <spring:message code="wzwg.cmm.word.findp" />
                    </a>
                </li>
                </c:if>
            </ul>
        </li>
        </c:if>
        <li class="<c:if test="${fn:indexOf(nowUrl, '/selectStplatLogList.do') > -1 || fn:indexOf(nowUrl, '/selectPolicyLogList.do') > -1 }">selected</c:if>">
        <a href="#" data-href="menuLinkSeq" data-attr="menuNm"  class="<c:if test="${fn:indexOf(nowUrl, '/selectStplatLogList.do') > -1 || fn:indexOf(nowUrl, '/selectPolicyLogList.do') > -1 }">on</c:if>" ><spring:message code="wzwg.cmm.word.stplatandpolicy" /><span></span></a>
            <ul class="<c:if test="${fn:indexOf(nowUrl, '/selectStplatLogList.do') > -1 || fn:indexOf(nowUrl, '/selectPolicyLogList.do') > -1}">selected</c:if>" style="display: <c:if test="${fn:indexOf(nowUrl, '/private.do') > -1}">block</c:if>;">
                <li class="<c:if test="${fn:indexOf(nowUrl, '/stplatLog/selectStplatLogList.do') > -1 }">deepest</c:if>">
                    <a href="<c:out value="${wzwg_contextPath}" />/module/stplatLog/selectStplatLogList.do" data-href="menuLinkSeq" data-attr="menuNm" class="<c:if test="${fn:indexOf(nowUrl, '/selectStplatLogList.do') > -1}">on</c:if>">
                        <span class="bull">•</span> <spring:message code="wzwg.cmm.word.stplathist" />
                    </a>
                </li>
                <li class="<c:if test="${fn:indexOf(nowUrl, '/stplatLog/selectPolicyLogList.do') > -1 }">deepest</c:if>">
                    <a href="<c:out value="${wzwg_contextPath}" />/module/stplatLog/selectPolicyLogList.do" data-href="menuLinkSeq" data-attr="menuNm" class="<c:if test="${fn:indexOf(nowUrl, '/selectPolicyLogList.do') > -1}">on</c:if>">
                        <span class="bull">•</span> <spring:message code="wzwg.cmm.word.policyhist" />
                    </a>
                </li>
<%--                 <li class="deepest">
                    <a href="/module/stplatLog/selectStplatPrivate.do" data-href="menuLinkSeq" data-attr="menuNm" class="<c:if test="${fn:indexOf(nowUrl, '/private.do') > -1}">on</c:if>">
                        <span class="bull">•</span> <spring:message code="wzwg.cmm.word.pivply" />
                    </a>
                </li> --%>
            </ul>            
        </li>
    </ul>
    
    </c:if>
</div>
                    