<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />

<title>::: <spring:message code="wzwg.cmm.word.sysmngr" /> :::</title>

<!-- <link rel="stylesheet" href="/css/wzwg/sysMngr/dashboard/main.css" type="text/css" />
<link rel="stylesheet" href="/css/wzwg/sysMngr/dashboard/contents.css" type="text/css" />
<link rel="stylesheet" href="/css/wzwg/cmm/common.css" type="text/css" />
<link rel="stylesheet" href="/css/wzwg/sysMngr/dashboard/style.css" type="text/css" />
<link rel="stylesheet" href="/css/wzwg/sysMngr/dashboard/form.css" type="text/css" />
 -->
<link rel="stylesheet" href="/css/wzwg/site/mngr/main.css" type="text/css" />
<link rel="stylesheet" href="/css/wzwg/site/mngr/contents.css" type="text/css" />
<link rel="stylesheet" href="/css/wzwg/cmm/common.css" type="text/css" />
<link rel="stylesheet" href="/css/wzwg/site/mngr/style.css" type="text/css" />
<link rel="stylesheet" href="/css/wzwg/site/mngr/form.css" type="text/css" />


<script type="text/javascript" src="/js/wzwg/cmm/jquery-latest.min.js"></script>
<script type="text/javascript" src="/js/wzwg/cmm/resize.js"></script>

<% 
	pageContext.setAttribute("cr", "\r"); 
	pageContext.setAttribute("lf", "\n"); 
%>

	<form:form modelAttribute="resultVO" path="previewFrm" id="previewFrm" name="previewFrm" method="post">
		
		<h2><spring:message code="wzwg.sysMngr.word.sbscrbInfoPreview" /></h2>
		
		<table class="basic">
			<colgroup>
				<col width="15%"/>
			</colgroup>
			<tbody>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.sbscrbInfo" /></th>
					<td>
						<p class="mg20 mb20"><c:out value="${fn:replace(resultVO.sbscrbGuidCn, cr, '<br />')}" escapeXml="false" /></p>
					</td>
				</tr>
				
				<c:if test="${resultVO.sbscrbQestnEstbsAt eq 'Y'}">
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.sbscrbQestn" /></th>
					<td>
						<c:if test="${!empty qesitmList}">
							<c:forEach var="qesitmList" items="${qesitmList}" varStatus="qesitmStatus">
							<p class="mt20"><spring:message code="wzwg.cmm.word.qestn" /> <c:out value="${qesitmStatus.index + 1}" /> :
								<c:if test="${qesitmList.qesitmSe eq 'S'}"> <!-- 주관식일경우 -->
									<c:out value="${qesitmList.qesitmSj}" />
									<textarea rows="2" style="width:90%;resize:none;" readonly="readonly"></textarea>
								</c:if>
								
								<c:if test="${qesitmList.qesitmSe eq 'O'}"> <!-- 객관식일경우 -->
									<c:out value="${qesitmList.qesitmSj}" />
									<c:if test="${!empty iemList}">
					 					<c:forEach var="iemList" items="${iemList}" varStatus="iemStatus">
											<p><input type="radio" name="sbscrbiemSeq" value="<c:out value="${iemList.sbscrbiemSeq}" />" /> <c:out value="${iemList.iemSj}" /></p>
										</c:forEach>
									</c:if>
								</c:if>
							</p>
							<c:if test="${qesitmStatus.last}"><br /></c:if>
							</c:forEach>
						</c:if>
					</td>
				</tr>
				</c:if>
				
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.sbscrbCnd" /></th>
					<td>
						<p>
							<c:if test="${resultVO.sbscrbCndAgeLmttAt eq 'N'}"><b><c:out value="${resultVO.sbscrbAgeBeginYear}" /></b><spring:message code="wzwg.cmm.msg.MSG185" /> <b><c:out value="${resultVO.sbscrbAgeEndYear}" /></b><spring:message code="wzwg.cmm.msg.MSG186" /> </c:if>
							<c:choose> 
								<c:when test="${resultVO.sbscrbCndSexdstn eq 'M'}"><b><spring:message code="wzwg.cmm.word.male" /></b><spring:message code="wzwg.cmm.msg.MSG184" /></c:when>
								<c:when test="${resultVO.sbscrbCndSexdstn eq 'F'}"><b><spring:message code="wzwg.cmm.word.female" /></b><spring:message code="wzwg.cmm.msg.MSG184" /></c:when>
								<c:otherwise><spring:message code="wzwg.cmm.word.person02" /></c:otherwise>
							</c:choose>
						</p>
					</script>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.cmm.word.crtfc" /> <spring:message code="wzwg.cmm.word.mth" /></th>
					<td>
						<%-- <c:if test="${resultVO.lsftCrtfcAt eq 'Y'}"><p>□ 실명인증</p></c:if> --%>
						<c:if test="${resultVO.moblphonCrtfcAt eq 'Y'}"><p>□ <spring:message code="wzwg.sysMngr.word.moblphonCrtfc" /></p></c:if>
						<c:if test="${resultVO.crtfctCrtfcAt eq 'Y'}"><p>□ <spring:message code="wzwg.sysMngr.word.crtfctCrtfc" /></p></c:if>
					</td>
				</tr>
			</tbody>
		</table>
	</form:form>
				
	<div class="ctr-box">
		<a href="javascript:void(0);" onclick="window.close();" class="btn-a"><spring:message code="wzwg.cmm.word.close" /></a>
	</div>
