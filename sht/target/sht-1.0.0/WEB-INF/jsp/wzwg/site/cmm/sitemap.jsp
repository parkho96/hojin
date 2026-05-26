<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script type="text/javascript">
try{document.title = '<spring:message code="wzwg.cmm.word.sitemap" />';}catch(e){console.log(e.message);}	
</script>
<link rel="stylesheet" href="/css/wzwg/module/cmm/sitemap.css"> 
<div class="sitemap001 mg10"> <!-- sitemap start -->
						 <h2><spring:message code="wzwg.cmm.word.sitemap" /></h2>
						 <p><spring:message code="wzwg.cmm.msg.MSG288" /></p>
						 <div class="sitemap_wrap pd_t10">
							<ul class="allMenuContents">
							   <c:forEach items="${resultList}" var="oneDepth" varStatus="status">
							   <c:if test="${empty oneDepth.upperMenuSeq or oneDepth.upperMenuSeq eq '0' }">
								<li>
									<c:choose>
										<c:when test="${subPrefix eq '/subMngr' or subPrefix eq '/subsite'}">
											<c:choose>
												<c:when test="${oneDepth.menuDivision eq 'anchor'}">
													<a href="<c:out value="${wzwg_contextPath}"/>/subsite/<c:out value="${subsiteKey}"/>#.anc_<c:out value="${oneDepth.menuSeq}"/>" data-type="anchor" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}"/>"><c:out value="${oneDepth.menuNm }"/></a>
												</c:when>
												<c:when test="${oneDepth.menuDivision eq 'link'}">
													<a href="<c:out value="${oneDepth.menuLinkUrl}"/>" <c:if test="${fn:indexOf(oneDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin="/>"</c:if> data-type="link" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}"/>"><c:out value="${oneDepth.menuNm }"/></a>
												</c:when>
												<c:when test="${oneDepth.menuDivision eq 'group'}">
													<a href="javascript:void(0);" data-type="link" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}"/>"  title="<spring:message code="wzwg.site.cmm.msg.MSG004"/>"><c:out value="${oneDepth.menuNm }"/></a>
												</c:when>
												<c:otherwise>
													<a href="<c:out value="${wzwg_contextPath}"/>/subsite/<c:out value="${subsiteKey}"/>/subList/<c:out value="${oneDepth.menuLinkSeq}"/>" data-type="subPage" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}"/>"><c:out value="${oneDepth.menuNm }"/></a>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${oneDepth.sysmoduleSeq eq '888888888888' }">
													<a href="<c:out value="${oneDepth.menuLinkUrl}"/>" data-type="anchor" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}"/>"><c:out value="${oneDepth.menuNm }"/></a>
												</c:when>
												<c:when test="${oneDepth.menuDivision eq 'link' }">
													<a href="<c:out value="${oneDepth.menuLinkUrl}"/>" <c:if test="${fn:indexOf(oneDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin="/>"</c:if> data-type="link" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}"/>"><c:out value="${oneDepth.menuNm }"/></a>
												</c:when>
												<c:when test="${oneDepth.menuDivision eq 'group'}">
													<a href="javascript:void(0);" data-type="link" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}"/>"  title="<spring:message code="wzwg.site.cmm.msg.MSG004"/>"><c:out value="${oneDepth.menuNm }"/></a>
												</c:when>
												<c:otherwise>
														<a href="<c:out value="${wzwg_contextPath}"/>/subList/<c:out value="${oneDepth.menuLinkSeq}"/>" data-type="subPage" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}"/>"><c:out value="${oneDepth.menuNm }"/></a>
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
									<ul>
									<c:forEach items="${resultList}" var="twoDepth" varStatus="status">
									<c:if test="${oneDepth.menuSeq eq twoDepth.upperMenuSeq}">
										<li>
											<c:choose>
												<c:when test="${subPrefix eq '/subMngr' or subPrefix eq '/subsite'}">
													<c:choose>
														<c:when test="${twoDepth.menuDivision eq 'anchor'}">
															<a href="<c:out value="${wzwg_contextPath}"/>/subsite/<c:out value="${subsiteKey}"/>#.anc_<c:out value="${twoDepth.menuSeq}"/>" data-type="anchor" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}"/>"><c:out value="${twoDepth.menuNm }"/></a>
														</c:when>
														<c:when test="${twoDepth.menuDivision eq 'link'}">
															<a href="<c:out value="${twoDepth.menuLinkUrl}"/>" <c:if test="${fn:indexOf(twoDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin="/>"</c:if> data-type="link" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}"/>"><c:out value="${twoDepth.menuNm }"/></a>
														</c:when>
														<c:when test="${twoDepth.menuDivision eq 'group'}">
															<a href="javascript:void(0);" data-type="link" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}"/>"  title="<spring:message code="wzwg.site.cmm.msg.MSG004"/>"><c:out value="${twoDepth.menuNm }"/></a>
														</c:when>
														<c:otherwise>
															<a href="<c:out value="${wzwg_contextPath}"/>/subsite/<c:out value="${subsiteKey}"/>/subList/<c:out value="${twoDepth.menuLinkSeq}"/>" data-type="subPage" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}"/>"><c:out value="${twoDepth.menuNm }"/></a>
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${twoDepth.sysmoduleSeq eq '888888888888' }">
															<a href="<c:out value="${twoDepth.menuLinkUrl}"/>" data-type="anchor" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}"/>"><c:out value="${twoDepth.menuNm }"/></a>
														</c:when>
														<c:when test="${twoDepth.menuDivision eq 'link' }">
															<a href="<c:out value="${twoDepth.menuLinkUrl}"/>" <c:if test="${fn:indexOf(twoDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin="/>"</c:if> data-type="link" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}"/>"><c:out value="${twoDepth.menuNm }"/></a>
														</c:when>
														<c:when test="${twoDepth.menuDivision eq 'group'}">
															<a href="javascript:void(0);" data-type="link" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}"/>"  title="<spring:message code="wzwg.site.cmm.msg.MSG004"/>"><c:out value="${twoDepth.menuNm }"/></a>
														</c:when>
														<c:otherwise>
																<a href="<c:out value="${wzwg_contextPath}"/>/subList/<c:out value="${twoDepth.menuLinkSeq}"/>" data-type="subPage" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}"/>"><c:out value="${twoDepth.menuNm }"/></a>
														</c:otherwise>
													</c:choose>
												</c:otherwise>
											</c:choose>
											<ul>
											<c:forEach items="${resultList}" var="threeDepth" varStatus="status">
											  <c:if test="${twoDepth.menuSeq eq threeDepth.upperMenuSeq}"> 
												<li>
													<c:choose>
														<c:when test="${subPrefix eq '/subMngr' or subPrefix eq '/subsite'}">
															<c:choose>
																<c:when test="${threeDepth.menuDivision eq 'anchor'}">
																	<a href="<c:out value="${wzwg_contextPath}"/>/subsite/<c:out value="${subsiteKey}"/>#.anc_<c:out value="${threeDepth.menuSeq}"/>" data-type="anchor" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}"/>"><c:out value="${threeDepth.menuNm }"/></a>
																</c:when>
																<c:when test="${threeDepth.menuDivision eq 'link'}">
																	<a href="<c:out value="${threeDepth.menuLinkUrl}"/>" <c:if test="${fn:indexOf(threeDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin="/>"</c:if> data-type="link" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}"/>"><c:out value="${threeDepth.menuNm }"/></a>
																</c:when>
																<c:otherwise>
																	<a href="<c:out value="${wzwg_contextPath}"/>/subsite/<c:out value="${subsiteKey}"/>/subList/<c:out value="${threeDepth.menuLinkSeq}"/>" data-type="subPage" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}"/>"><c:out value="${threeDepth.menuNm }"/></a>
																</c:otherwise>
															</c:choose>
														</c:when>
														<c:otherwise>
															<c:choose>
																<c:when test="${threeDepth.sysmoduleSeq eq '888888888888' }">
																	<a href="<c:out value="${threeDepth.menuLinkUrl}"/>" data-type="anchor" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}"/>"><c:out value="${threeDepth.menuNm }"/></a>
																</c:when>
																<c:when test="${threeDepth.menuDivision eq 'link' }">
																	<a href="<c:out value="${threeDepth.menuLinkUrl}"/>" <c:if test="${fn:indexOf(threeDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin="/>"</c:if> data-type="link" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}"/>"><c:out value="${threeDepth.menuNm }"/></a>
																</c:when>
																<c:otherwise>
																	<a href="<c:out value="${wzwg_contextPath}"/>/subList/<c:out value="${threeDepth.menuLinkSeq}"/>" data-type="subPage" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}"/>"><c:out value="${threeDepth.menuNm }"/></a>
																</c:otherwise>
															</c:choose>
														</c:otherwise>
													</c:choose>
												</li>
											</c:if>
											</c:forEach>
											</ul>
										</li>
									</c:if>
									</c:forEach>	 
									</ul>  
								</li>  
								</c:if>
								</c:forEach>
							 </ul>
						 </div>
						</div><!-- sitemap end -->
