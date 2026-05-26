<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<div id="sidebar" style="margin-top:0px;">
					<div class="login_time sessIntvl" >
						    <div class="mngr_info">
						         <p><c:out value="${loginVO.userNm}" /></p>
						         <c:if test="${not empty sessionScope.SADMIN_AT and sessionScope.SADMIN_AT}">
									<a href="<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrInfo/modifyUsrInfoForm.do?siteSeq=10000000001&usrSeq=<c:out value="${sessionScope.loginVO.usrSeq}" />" title="<spring:message code="wzwg.cmm.word.infochange" />">
										<spring:message code="wzwg.cmm.word.infochange" />
	    							</a>
								  </c:if>
								  <c:if test="${not empty sessionScope.NADMIN_AT and sessionScope.NADMIN_AT}">
							 		<a href="<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrInfo/modifyUsrInfoForm.do?siteSeq=<c:out value="${sessionScope.SITE_SEQ}" />&usrSeq=<c:out value="${sessionScope.loginVO.usrSeq}" />" title="<spring:message code="wzwg.cmm.word.infochange" />">
							 			<spring:message code="wzwg.cmm.word.infochange" />
	    							</a>
							 	  </c:if>
						    </div>
						    <c:if test="${not empty sessintvl and sessintvl ne '0' }">
						    <button type="button" class="time_limit" onclick="fnAddSessionTime()">
						         <p><i class="fa fa-clock-o"></i> <span class="lognTimer" style="color:white;">05:29</span></p>
						         <spring:message code="wzwg.cmm.word.extended" />
						    </button>
						    </c:if>
						    <div class="logout">
							<a href="<c:out value="${wzwg_contextPath}${subPrefix}/subsite/${subsiteKey}" />/actionMngrLogout.do"></a>
						    </div>
					</div>
						
					<ul>
						<li id="mngr_mn_1">
							<img src="/images/wzwg/site/mngr/menu/design.png" alt="<spring:message code="wzwg.cmm.word.template" /> <spring:message code="wzwg.cmm.word.manage" />" />
							<a href="<c:out value="${wzwg_contextPath}" />/subMngr/subsite/<c:out value="${sessionScope.subsiteKey}" />/template/subSiteTemplateMain.do"><spring:message code="wzwg.cmm.cntnts.templatemanage" /></a>
							<div class="menu_help">
								<img src="/images/wzwg/site/mngr/ico_help.png" alt="<spring:message code="wzwg.cmm.word.menu" /> <spring:message code="wzwg.cmm.word.hpcm" />">
								<div class="help_pop">
										<spring:message code="wzwg.cmm.msg.MSG252" /> 
								</div>
							</div>
						</li>
						<li id="mngr_mn_1">
							<img src="/images/wzwg/site/mngr/menu/subpage.png" alt="<spring:message code="wzwg.cmm.word.menu" /> <spring:message code="wzwg.cmm.word.manage" />" />
							<a href="<c:out value="${wzwg_contextPath}" />/subMngr/subsite/<c:out value="${sessionScope.subsiteKey}" />/menu/selectSubSiteMenuList.do"><spring:message code="wzwg.cmm.cntnts.menumanage" /></a>
							<div class="menu_help">
								<img src="/images/wzwg/site/mngr/ico_help.png" alt="<spring:message code="wzwg.cmm.word.menu" /> <spring:message code="wzwg.cmm.word.hpcm" />">
								<div class="help_pop">
										<spring:message code="wzwg.cmm.msg.MSG253" /> 
								</div>
							</div>
						</li>
					</ul>
				</div>
<div class="menu_fade"></div> <!-- 새로 추가해준 부분. 심수정 0315. -->