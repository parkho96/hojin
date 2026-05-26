<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>  
<c:choose>
	<c:when test="${subPrefix eq '/subMngr' or subPrefix eq '/subsite' }">
		<c:import url="/WEB-INF/jsp/site/${sessionScope.SITE_SEQ}/subsite/${subsiteKey}/subHead.jsp"></c:import>
		<c:import url="/subsite/${subsiteKey}/topMenu.do"></c:import>
	</c:when>
	<c:otherwise>
		<c:import url="/WEB-INF/jsp/site/${sessionScope.SITE_SEQ}/subHead.jsp"></c:import>
		<c:import url="/site/${sessionScope.SITE_SEQ}/topMenu.do"></c:import>
	</c:otherwise>
</c:choose>


<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incSubMenuSetting.jsp" %>

<form name="menuFrm" id="menuFrm" method="post">
<input type="hidden" name="menuSeq" id="menuSeq" value="${menuSeq}"/>
<input type="hidden" name="menuNm" id="menuNm" value="${menuNm}"/>
<input type="hidden" name="menuPath" id="menuPath" value="${menuPath }"/>
<input type="hidden" name="menuPathSeq" id="menuPathSeq" value="${menuPathSeq }"/>
<input type="hidden" name="menuDc" id="menuDc" value="${menuDc }"/>
</form>
<!-- middle_contents -->
 


	<!--  -->
	<!--  -->
	<div class="inner">

		<div id="sub_visual" class="mainBanner topSubImgOrign"> 
			<img src="/sample/template/wide/wide038/img/mv_03.jpg" alt="" />
			<div class="bluebg">
				<div class="sub_titbox bTextAlign">
					<p class="bTitle"></p>
					<strong class="bContent"></strong>
				</div>
			</div>
		</div>

		<div class="sub_div_wrap">
			<c:choose>
				<c:when test="${subPrefix eq '/subMngr' or subPrefix eq '/subsite' }">
				    <c:import url="/subsite/${subsiteKey}/${menuSeq}/leftMenu.do"></c:import>
				</c:when>
				<c:otherwise>
				    <c:import url="/site/${sessionScope.SITE_SEQ}/${menuSeq}/leftMenu.do"></c:import>
				</c:otherwise>
			</c:choose>
               <div class="subCon">
				<ul class="location" id="menuLocationPath">
					<li class="home"><a href="/">HOME</a></li>
					<!-- <li>MENU</li>
					<li class="ftbd" id="menuSubTitle">SUBMENU</li> -->
				</ul>

				<h4 class="tit" id="menuTitle"></h4>
				<p  id="menuInfo"></p>
				<div>
				<c:import url="${url}"></c:import>
				</div>
			</div>
		</div>


	</div><!-- inner 끝 --> 
		 
<c:choose>
	<c:when test="${subPrefix eq '/subMngr' or subPrefix eq '/subsite' }">
	    <c:import url="/WEB-INF/jsp/site/${sessionScope.SITE_SEQ}/subsite/${subsiteKey}/footerMenu.jsp"></c:import>
	</c:when>
	<c:otherwise>
		<c:import url="/WEB-INF/jsp/site/${sessionScope.SITE_SEQ}/footerMenu.jsp"></c:import>
	</c:otherwise>
</c:choose>
 
