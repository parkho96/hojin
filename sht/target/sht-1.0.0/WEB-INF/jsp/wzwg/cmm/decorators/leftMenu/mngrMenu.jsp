<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<c:set var="icoNm" value="ico_help_mngr.png"/>
	<c:forEach items="${resultList['MENU_LIST']}" var="oneDepth" varStatus="status">
    <c:if test="${oneDepth.menuLv eq '1' }"> 
    	<li id="mngr_mn_<c:out value="${status.count}" />" class="<c:if test="${fn:indexOf(nowUrl, oneDepth.menuLinkUrl) > -1 }"> active</c:if>">
			<img src="/images/wzwg/site/mngr/menu/<c:out value="${oneDepth.mngrMenuSeq}"/>.png" onerror="this.src='/images/wzwg/site/mngr/menu/site.png'" alt="<c:out value="${oneDepth.mngrMenuNm}" /> <spring:message code="wzwg.cmm.word.image" />" />
			<c:if test="${oneDepth.mngrMenuDivision eq 'group'}">
			<a href="javascript:void(0);"><span><c:out value="${oneDepth.mngrMenuNm}"/></span></a>
			</c:if>
			<c:if test="${oneDepth.mngrMenuDivision eq 'link'}">
			<a href="<c:out value="${wzwg_contextPath}${oneDepth.menuLinkUrl}" />" >
				<c:choose>
					<c:when test="${empty oneDepth.mngrBkmkSeq }">
        				<button type="button"  class="btn_fav" data-mngrmenuseq="<c:out value='${oneDepth.mngrMenuSeq}' />" data-mngrBkmkSeq="<c:out value='${oneDepth.mngrBkmkSeq}' />">
        					<i class="fa fa-star-o btn_fav" aria-hidden="true" data-mngrmenuseq="<c:out value='${oneDepth.mngrMenuSeq}' />" data-mngrBkmkSeq="<c:out value='${oneDepth.mngrBkmkSeq}' />"></i>
        				</button>
					</c:when>
					<c:otherwise>
						<button type="button"  class="btn_fav" data-mngrmenuseq="<c:out value='${oneDepth.mngrMenuSeq}' />" data-mngrBkmkSeq="<c:out value='${oneDepth.mngrBkmkSeq}' />">
        					<i class="fa fa-star btn_fav" aria-hidden="true" data-mngrmenuseq="<c:out value='${oneDepth.mngrMenuSeq}' />" data-mngrBkmkSeq="<c:out value='${oneDepth.mngrBkmkSeq}' />"></i>
        				</button>
					</c:otherwise>
				</c:choose>
				<span><c:out value="${oneDepth.mngrMenuNm}" /></span>
			</a>
			</c:if>
			<c:if test="${not empty oneDepth.menuDc}"> 
			<div class="menu_help">
				<img src="/images/wzwg/site/mngr/<c:out value="${icoNm}" />" alt="<spring:message code="wzwg.cmm.word.menuhpcm" />">
				<div class="help_pop">
					<c:out value="${oneDepth.menuDc}" escapeXml="false"/>
				</div>
			</div>
			</c:if>
			<ul class="side-mu01" style="<c:if test="${fn:indexOf(nowUrl, '/siteMngr/') > -1}">display:block;</c:if>">
			   <c:forEach items="${resultList['MENU_LIST']}" var="twoDepth" varStatus="cnt">
	        		<c:if test="${oneDepth.mngrMenuSeq eq twoDepth.upperMenuSeq}">
	        			<li>
	        				<c:set var="menuPrefixArr" value="${fn:split(twoDepth.menuPrefix, ',')}" />
	        				<c:set var="menuOnClass" value="" />
        					<c:forEach var="menuPrefix" items="${menuPrefixArr}">
        						<c:if test="${fn:indexOf(nowUrl, menuPrefix) > -1 }">
        				 			<c:set var="menuOnClass" value="on" />
        						</c:if>
        					</c:forEach>
						<c:if test="${fn:indexOf(twoDepth.menuPrefix, 'bbsSeq') < 0}">
	        				<a href="<c:out value="${wzwg_contextPath}${twoDepth.menuLinkUrl}" />" class="side-submenu <c:out value="${menuOnClass }"/>">
	        					<c:choose>
									<c:when test="${empty twoDepth.mngrBkmkSeq }">
				        				<button type="button"   class="btn_fav" data-mngrmenuseq="<c:out value='${twoDepth.mngrMenuSeq}' />" data-mngrBkmkSeq="<c:out value='${twoDepth.mngrBkmkSeq}' />">
				        					<i class="fa fa-star-o btn_fav" aria-hidden="true" data-mngrmenuseq="<c:out value='${twoDepth.mngrMenuSeq}' />" data-mngrBkmkSeq="<c:out value='${twoDepth.mngrBkmkSeq}' />"></i>
				        				</button>
									</c:when>
									<c:otherwise>
										<button type="button"  class="btn_fav" data-mngrmenuseq="<c:out value='${twoDepth.mngrMenuSeq}' />" data-mngrBkmkSeq="<c:out value='${twoDepth.mngrBkmkSeq}' />">
				        					<i class="fa fa-star btn_fav" aria-hidden="true" data-mngrmenuseq="<c:out value='${twoDepth.mngrMenuSeq}' />" data-mngrBkmkSeq="<c:out value='${twoDepth.mngrBkmkSeq}' />"></i>
				        				</button>
									</c:otherwise>
								</c:choose>
								<span><c:out value="${twoDepth.mngrMenuNm}" /></span>
	        				</a>
						</li>
						</c:if>
						<c:if test="${fn:indexOf(twoDepth.menuPrefix, 'bbsSeq') > -1}">
							<li>
								<a href="<c:out value="${wzwg_contextPath}${twoDepth.menuLinkUrl}" />" class="side-submenu <c:if test="${fn:indexOf(twoDepth.menuPrefix, param.bbsSeq) > 0 }">on</c:if>">
									<c:choose>
										<c:when test="${empty twoDepth.mngrBkmkSeq }">
					        				<button type="button"  class="btn_fav" data-mngrmenuseq="<c:out value='${twoDepth.mngrMenuSeq}' />" data-mngrBkmkSeq="<c:out value='${twoDepth.mngrBkmkSeq}' />">
					        					<i class="fa fa-star-o btn_fav" aria-hidden="true" data-mngrmenuseq="<c:out value='${twoDepth.mngrMenuSeq}' />" data-mngrBkmkSeq="<c:out value='${twoDepth.mngrBkmkSeq}' />"></i>
					        				</button>
										</c:when>
										<c:otherwise>
											<button type="button"  class="btn_fav" data-mngrmenuseq="<c:out value='${twoDepth.mngrMenuSeq}' />" data-mngrBkmkSeq="<c:out value='${twoDepth.mngrBkmkSeq}' />">
					        					<i class="fa fa-star btn_fav" aria-hidden="true" data-mngrmenuseq="<c:out value='${twoDepth.mngrMenuSeq}' />" data-mngrBkmkSeq="<c:out value='${twoDepth.mngrBkmkSeq}' />"></i>
					        				</button>
										</c:otherwise>
									</c:choose>
									<c:out value="${twoDepth.mngrMenuNm}" />
								</a>
							</li>
						</c:if>
	                </c:if>
                </c:forEach>
			</ul>
		</li>
	</c:if>
	</c:forEach>		 