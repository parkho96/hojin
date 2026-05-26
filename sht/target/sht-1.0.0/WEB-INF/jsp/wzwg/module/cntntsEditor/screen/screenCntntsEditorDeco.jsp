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
<input type="hidden" name="menuSeq" id="menuSeq" value="${fn:escapeXml(menuSeq)}"/>
<input type="hidden" name="menuNm" id="menuNm" value="${fn:escapeXml(menuNm)}"/>
<input type="hidden" name="menuPath" id="menuPath" value="메뉴>서브메뉴>">
<input type="hidden" name="menuPathSeq" id="menuPathSeq" value="10000003669>10000003750">
<input type="hidden" name="menuDc" id="menuDc" value="${fn:escapeXml(menuDc)}"/>
</form>
<!-- middle_contents -->

	<div class="inner">

		<div id="sub_visual" class="mainBanner topSubImgOrign"> 
			<img src="/sample/template/basic/basic006/img/mv_03.jpg" alt="서브페이지 샘플 이미지" style="opacity: 0.3"/>
			<div class="bluebg">
				<div class="sub_titbox bTextAlign">
					<p class="bTitle">서브페이지 샘플 이미지 입니다</p>
					<strong class="bContent">해당 서브페이지 이미지 및 텍스트 변경은 [디자인관리] - 템플릿 편집화면 에서 진행해 주세요 </strong>
				</div>
			</div>
		</div>

		<div class="sub_div_wrap">
		   
		   	<!-- 더미 leftmenu -->
		  	 <div class="subMenu">
				<h3 class="menuNm">메뉴<span></span></h3>
					<ul class="slidebar">
					    <li class="deepest">
								<a href="javascript:void(0);"  data-href="menuLinkSeq" data-attr="menuNm" class="on">
									서브메뉴
								</a>
							<ul>
							  	<li>
			                        	<a href="javascript:void(0);"  data-href="menuLinkSeq" data-attr="menuNm" class="on">
			                        		서브메뉴
			                        	</a>
							  	</li>
							</ul>
					    </li>
					</ul>
				</div>
		   
		   
		   
               <div class="subCon">
				<ul class="location" id="menuLocationPath">
					<li class="home"><a href="/">HOME</a></li>
					<!-- <li>MENU</li>
					<li class="ftbd" id="menuSubTitle">SUBMENU</li> -->
				</ul>

				<h4 class="tit" id="menuTitle"></h4>
				<p  id="menuInfo"> </p>
				<div style="position: relative;">
				<c:import url="${subHomeCnUrl}"></c:import>
				<%-- <c:import url="/wizonEditor/sample.jsp"></c:import> --%>
				<!-- 서브홈 모듈 노출영역 -->
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
 
