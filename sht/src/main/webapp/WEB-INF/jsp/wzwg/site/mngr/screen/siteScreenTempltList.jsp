<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 

		<c:if test="${not empty templtList }">
			<ul class="temDesignSel wd100">
			<c:forEach items="${templtList}" var="resultList" varStatus="status">
			<li class="wd33 wm100 p15 box-border">
				<p class="admpg-tit2"><c:out value="${resultList.templateNm}"/></p>
				<c:if test="${resultList.reflctCnt ne '0'}">
					<div class="templateUsrInfo" >(<spring:message code="wzwg.site.screen.msg.MSG130" /> : <c:out value="${resultList.reflctCnt}"/><spring:message code="wzwg.cmm.word.count04" /> <spring:message code="wzwg.cmm.word.lastapplcde" />:<c:out value="${resultList.reflctPnttm}"/>)</div>
				</c:if>
				<div class="temBox thumImg">
					<div class="wd100 fl">
						<img src="/<c:out value="${resultList.templateStreCours }"/>screenshot/thumb_<c:out value="${resultList.thumbUrl}"/>">
					</div>
					<div class="hoverLayer">
						<div class="i-block wd100 linehgt150 vert-m txt-l">
   							<a href="javascript:void(0);" onclick="fn_detail('<c:out value="${resultList.templateSeq}"/>', '<c:out value="${resultList.templateNm}"/>')" class="circleRTxt"><span class="hoverbtn_circle closeUp"></span><spring:message code="wzwg.site.screen.msg.MSG129" /></a>
   							<a href="javascript:void(0);" onclick="fn_siteTempTempltCallMain('<c:out value="${resultList.templateSeq}"/>');" class="circleRTxt"><span class="hoverbtn_circle modify"></span><spring:message code="wzwg.cmm.word.toupdt" /></a>
   							<a href="javascript:void(0);" onclick="fnLoadTemplatInitCallMain('<c:out value="${resultList.templateSeq}"/>');" class="circleRTxt"><span class="hoverbtn_circle new"></span><spring:message code="wzwg.cmm.word.newopert" /></a>
  						</div>
  					</div>
				</div>
				
			</li>
			</c:forEach>
			</ul>
		</c:if>
		
		<c:if test="${empty templtList }">
			<p class="txt-c"><spring:message code="wzwg.cmm.msg.MSG097" /></p>
		</c:if>	
		
		<c:if test="${not empty templtList }">
		<div class="ctr-box" id="pageInfo">
			<ul class="num mobile-none">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
			</ul>
			
			<ul class="num pc-none">
				<ui:pagination paginationInfo="${mobilePaginationInfo}" type="image" jsFunction="fn_search" />
			</ul>
		</div>
		</c:if>

