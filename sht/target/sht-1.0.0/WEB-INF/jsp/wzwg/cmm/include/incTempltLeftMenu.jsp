<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>  
<%@ page trimDirectiveWhitespaces="true" %>				
	<c:choose>
		<c:when test="${subPrefix eq '/subMngr' or subPrefix eq '/subsite' }">
			<div class="subMenu">
				<h3 class="menuNm"><c:out value="${leftMenuList[0].menuNm}" escapeXml="false" /><span></span></h3>
					<ul class="slidebar">
						<c:forEach items="${leftMenuList}" var="oneDepth" varStatus="status">
			   			<c:if test="${oneDepth.menuLv eq '2' }">
					    <li <c:if test="${menuSeq eq oneDepth.menuLinkSeq}">class="deepest"</c:if>>
					    	<c:if test="${oneDepth.menuDivision eq 'link'}">
								<a href="<c:out value="${oneDepth.menuLinkUrl}" />" target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />" data-href="menuLinkSeq" data-attr="menuNm">
									<c:out value="${oneDepth.menuNm }" escapeXml="false" /> <c:if test="${oneDepth.menuDivision eq 'group' }"><span></span></c:if>
								</a>
							</c:if>
							<c:if test="${oneDepth.menuDivision ne 'link'}">
								<a href="<c:out value="${wzwg_contextPath}" />/subsite/<c:out value="${subsiteKey}" />/subList/<c:out value="${oneDepth.menuLinkSeq}" />"  data-href="menuLinkSeq" data-attr="menuNm" <c:if test="${menuSeq eq oneDepth.menuLinkSeq}">class="on"</c:if>>
									<c:out value="${oneDepth.menuNm }" escapeXml="false" /> <c:if test="${oneDepth.menuDivision eq 'group' }"><span></span></c:if>
								</a>
		                    </c:if>
							<ul>
								<c:forEach items="${leftMenuList}" var="twoDepth" varStatus="status">
								<c:if test="${oneDepth.menuSeq eq twoDepth.upperMenuSeq}">
							  	<li <c:if test="${menuSeq eq twoDepth.menuLinkSeq}">class="deepest"</c:if>>
							  		<c:if test="${twoDepth.menuDivision eq 'link'}">
		                          		<a href="<c:out value="${twoDepth.menuLinkUrl}" />" target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />"  data-href="menuLinkSeq" data-attr="menuNm">
		                          			<c:if test="${twoDepth.menuDivision eq 'group' }"><span class="bull">&bull;</span></c:if><c:out value="${twoDepth.menuNm }" escapeXml="false" />
		                          		</a>
		                            </c:if>   
			                        <c:if test="${twoDepth.menuDivision ne 'link'}">
			                        	<a href="<c:out value="${wzwg_contextPath}" />/subsite/<c:out value="${subsiteKey}" />/subList/<c:out value="${twoDepth.menuLinkSeq}" />"  data-href="menuLinkSeq" data-attr="menuNm" <c:if test="${menuSeq eq twoDepth.menuLinkSeq}">class="on"</c:if>>
			                        		<c:if test="${twoDepth.menuDivision eq 'group' }"><span class="bull">&bull;</span></c:if> <c:out value="${twoDepth.menuNm }" escapeXml="false" />
			                        	</a>
			                        </c:if>
							  	</li>
							  	</c:if>
							  	</c:forEach>
							</ul>
					    </li>
					    </c:if>
					    </c:forEach>
					</ul>
				</div>
		</c:when>
		<c:otherwise>
		
			<div class="subMenu">
				<h3 class="menuNm"><c:out value="${leftMenuList[0].menuNm}" escapeXml="false" /><span></span></h3>
					<ul class="slidebar">
						<c:forEach items="${leftMenuList}" var="oneDepth" varStatus="status">
			   			<c:if test="${oneDepth.menuLv eq '2' }">
					    <li <c:if test="${menuSeq eq oneDepth.menuLinkSeq}">class="deepest"</c:if>>
					    	<c:if test="${oneDepth.menuDivision eq 'link'}">
								<a href="<c:out value="${oneDepth.menuLinkUrl}" />" target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />"  data-href="menuLinkSeq" data-attr="menuNm">
									<c:out value="${oneDepth.menuNm }" escapeXml="false" /> <c:if test="${oneDepth.menuDivision eq 'group' }"><span></span></c:if>
								</a>
							</c:if>   
							<c:if test="${oneDepth.menuDivision ne 'link'}">
								<a href="<c:out value="${wzwg_contextPath}" />/subList/<c:out value="${oneDepth.menuLinkSeq}" />"  data-href="menuLinkSeq" data-attr="menuNm" <c:if test="${menuSeq eq oneDepth.menuLinkSeq}">class="on"</c:if>>
									<c:out value="${oneDepth.menuNm }" escapeXml="false" />  <c:if test="${oneDepth.menuDivision eq 'group' }"><span></span></c:if>
								</a>
		                    </c:if>
								<c:set var="towDepthUl" value="false"/>
								<c:forEach items="${leftMenuList}" var="twoDepth" varStatus="status">
								<c:if test="${oneDepth.menuSeq eq twoDepth.upperMenuSeq}">
								
								<c:if test="${not towDepthUl }"><ul <c:if test="${menuSeq ne twoDepth.menuLinkSeq}">style="display:none;"</c:if>><c:set var="towDepthUl" value="true"/></c:if>
							  	<li <c:if test="${menuSeq eq twoDepth.menuLinkSeq}">class="deepest"</c:if>>
							  		<c:if test="${twoDepth.menuDivision eq 'link'}">
		                          		<a href="<c:out value="${twoDepth.menuLinkUrl}" />" target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />"  data-href="menuLinkSeq" data-attr="menuNm">
		                          			<c:if test="${oneDepth.menuDivision eq 'group' }"><span class="bull">&bull;</span></c:if> <c:out value="${twoDepth.menuNm }" escapeXml="false" />
		                          		</a>
		                            </c:if>   
			                        <c:if test="${twoDepth.menuDivision ne 'link'}">
			                        	<a href="<c:out value="${wzwg_contextPath}" />/subList/<c:out value="${twoDepth.menuLinkSeq}" />"  data-href="menuLinkSeq" data-attr="menuNm" <c:if test="${menuSeq eq twoDepth.menuLinkSeq}">class="on"</c:if>>
			                        		<c:if test="${oneDepth.menuDivision eq 'group' }"><span class="bull">&bull;</span></c:if> <c:out value="${twoDepth.menuNm }" escapeXml="false" />
			                        	</a>
			                        </c:if>
							  	</li>
							  	</c:if>
							  	</c:forEach>
							  	<c:if test="${towDepthUl }"></ul></c:if>							
					    </li>
					    </c:if>
					    </c:forEach>
					</ul>
				</div>
		</c:otherwise>
	</c:choose>
	
