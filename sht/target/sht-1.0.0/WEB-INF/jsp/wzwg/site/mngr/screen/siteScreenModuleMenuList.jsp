<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags" %>
 <div id="boardLinkUrlDiv" style="z-index: 999;">
 		<p class="linkUrlTit"><spring:message code="wzwg.site.screen.msg.MSG048" /></p>
		<div class= "linkSelect pop_link">
				<ul id="boardMenuList">
					<c:forEach items="${moduleMenuList}" var="oneDepth" varStatus="status">
						<c:if test="${empty oneDepth.upperMenuSeq or oneDepth.upperMenuSeq eq '0' }">
							<li class="wz-collapse" data-for=".scrinMdMnu_<c:out value="${oneDepth.menuSeq }"/>">
							 <c:choose>
							 	<c:when test="${oneDepth.menuDivision eq 'group' }">
							 		<a href="javascript:void(0);" data-ty="group"><c:out value="${oneDepth.menuNm }"/></a>
							 	</c:when>
							 	<c:otherwise>
							 		<a href="javascript:void(0);" onclick="fnModuleData(<c:out value="${oneDepth.menuSeq}"/>, '<c:out value="${oneDepth.menuNm}"/>')"><c:out value="${oneDepth.menuNm }"/></a>	
							 	</c:otherwise>
							 </c:choose>
								<ul class="scrinMdMnu_<c:out value="${oneDepth.menuSeq }"/>" style="display: none;">
								<c:forEach items="${moduleMenuList}" var="twoDepth" varStatus="status">
								<c:if test="${oneDepth.menuSeq eq twoDepth.upperMenuSeq}">
									<li class="wz-collapse" data-for=".scrinMdMnu_<c:out value="${twoDepth.menuSeq }"/>">
										<c:choose>
										 	<c:when test="${twoDepth.menuDivision eq 'group' }">
										 		<a href="javascript:void(0);" data-ty="group"><c:out value="${twoDepth.menuNm }"/></a>
										 	</c:when>
										 	<c:otherwise>
										 		<a href="javascript:void(0);" onclick="fnModuleData(<c:out value="${twoDepth.menuSeq}"/>, '<c:out value="${twoDepth.menuNm}"/>')"><c:out value="${twoDepth.menuNm }"/></a>	
										 	</c:otherwise>
										 </c:choose>
										<ul class="scrinMdMnu_<c:out value="${twoDepth.menuSeq }"/>" style="display: none;">
										<c:forEach items="${moduleMenuList}" var="threeDepth" varStatus="status">
										<c:if test="${twoDepth.menuSeq eq threeDepth.upperMenuSeq}"> 
											<c:if test="${threeDepth.menuDivision ne 'group' }">
													<li>
													 		<a href="javascript:void(0);" onclick="fnModuleData(<c:out value="${threeDepth.menuSeq}"/>, '<c:out value="${threeDepth.menuNm}"/>')"><c:out value="${threeDepth.menuNm }"/></a>	
													</li>
											</c:if>
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
		
		<p class="linkUrlTit"><spring:message code="wzwg.site.screen.msg.MSG049" /></p>
		<div class= "linkSelect pop_link">
				<ul id="boardMenuList">
					<c:forEach items="${tabMenuGrpList}" var="tabGrp" varStatus="status">
						<li class="wz-collapse" data-for=".scrinClMnu_<c:out value="${tabGrp.bbsSeq }"/>">
							<a href="javascript:void(0);" data-ty="group"><c:out value="${tabGrp.cntntsNm }"/></a>
							<ul class="scrinClMnu_<c:out value="${tabGrp.bbsSeq }"/>" style="display: none;">
							<c:forEach items="${tabMenuModuleList}" var="tabMenuList" varStatus="status">
							<c:if test="${tabGrp.bbsSeq eq tabMenuList.bbsSeq }">
								<li>
									<a href="javascript:void(0);" onclick="fnModuleData('','','<c:out value="${tabMenuList.sysmoduleSeq}"/>', '<c:out value="${tabMenuList.sitecntntsSeq}"/>', 'tabMenu', '<c:out value="${tabMenuList.bbsSeq }"/>', '<c:out value="${tabMenuList.nttSeq }"/>')"><c:out value="${tabMenuList.nttSj }"/></a>
								</li>
							</c:if>
							</c:forEach>
							</ul>
						</li>
					</c:forEach>
				</ul>
		</div>
</div>