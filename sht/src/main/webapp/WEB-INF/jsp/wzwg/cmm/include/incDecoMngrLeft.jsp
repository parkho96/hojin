<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<%--
사이트관리			SM	10000000001
홈페이지만들기		SC	10000000002
메뉴서브페이지관리	MS	10000000003
회원관리			UM	10000000004
홈페이지운영		OS	10000000005
 --%>
<c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
<div class="mngr_top_menu">
	<ul>
		<p class="menu_help" id="btn_favToggle">
			<button type="button" class="btn_fav_toggle fa fa-star-o"></button>
			<spring:message code="wzwg.cmm.word.quikNavi" />
			<span class="help_pop" style="text-indent: 0px;top: 44px;left: 27px;">
				<spring:message code="wzwg.cmm.msg.tip.MSG160" />
			</span>
			
		</p>
		<a href="<c:out value="${wzwg_contextPath}" />/" class="wzbtn-table btn-basic" target="_blank"><spring:message code="wzwg.cmm.menu.hmpgopen" /></a> <!-- 새로 추가해준 부분. 심수정 0315. -->
      
        <c:import url="${wzwg_contextPath}/mngr/cmm/decorators/leftMenu/selectMngrBkmkMenu.do" />
        
        <c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
		<li class="mngr_top_lang">
                      		<select id="useLang-m" name="useLang" onchange="fnChangeLang(this.value);" >
				<option value="SC00000016" data-image="/images/wzwg/cmm/ico-kor.png" <c:if test="${sessionScope.useLangCode eq 'SC00000016'}">selected</c:if>>한국어</option>
				<option value="SC00000019" data-image="/images/wzwg/cmm/ico-eng.png" <c:if test="${sessionScope.useLangCode eq 'SC00000019'}">selected</c:if>>English</option>
<%-- 									<option value="SC00000017" data-image="/images/wzwg/cmm/ico-jap.png" data-title="<spring:message code="wzwg.cmm.word.langjap" />" <c:if test="${sessionScope.useLangCode eq 'SC00000017'}">selected</c:if>></option>
									<option value="SC00000018" data-image="/images/wzwg/cmm/ico-chi.png" data-title="<spring:message code="wzwg.cmm.word.langchi" />" <c:if test="${sessionScope.useLangCode eq 'SC00000018'}">selected</c:if>></option> --%>
			</select>
        </li>
        </c:if>
		<!-- <li id="mngr_top_menuAll">
			<a href="javascript:void(0)" onclick="fn_mngr_menu_view_all()"><spring:message code="wzwg.cmm.menu.menuallview" /></a>
		</li> -->
	</ul>
</div>
<script>

	var mngrCacheTopmenuNumbers;
	var mngrMenuFlag = false;
	function fn_mngr_authgrp_view(){
		$('#sidebar>ul>li>ul').css("display","none"); 
			if($('#sidebar>ul>.active>ul>li').size()>0){
				$('#sidebar>ul>.active>ul').click();
			} 
	} 

	$(document).ready(function(){ 
		fn_mngr_authgrp_view();
		
		$("#btn_favToggle").click(function() {
			$('button.btn_fav').toggleClass('fav_btn_on');
		})
			
		 
	});

</script>
</c:if>

    
     	<c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}"><c:set var="icoNm" value="ico_help_sys.png"/></c:if>
    	<c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}"><c:set var="icoNm" value="ico_help_mngr.png"/></c:if>
    	
		<c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
			<div id="sidebar" class="sysSidebar" style="margin-top:0px;">
						<div class="radiusBoxFX"></div>
						<div class="login_time sessIntvl" >
						    <div class="mngr_info">
						         <p><c:out value="${loginVO.userNm}"/></p>
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
							<a href="<c:out value="${wzwg_contextPath}" />/cmm/mber/login/actionMngrLogout.do"></a>
						    </div>
						</div>
						
						
					<ul>
						<li id="mngr_mn_1"<c:if test="${fn:indexOf(nowUrl, '/selectDashboardMain.do') > -1 }"> class="active"</c:if>>
							<img src="/images/wzwg/site/mngr/menu/home.png" alt="<spring:message code="wzwg.cmm.word.home" />" />
							<a href="<c:out value="${wzwg_contextPath}${prefix}" />/selectDashboardMain.do" ><span><spring:message code="wzwg.cmm.cntnts.dashboard" /></span></a>
							<div class="menu_help">
								<img src="/images/wzwg/site/mngr/<c:out value="${icoNm}" />" alt="<spring:message code="wzwg.cmm.word.menu" /> <spring:message code="wzwg.cmm.word.hpcm" />">
								<div class="help_pop">
										<spring:message code="wzwg.cmm.msg.MSG219" />
								</div>
							</div>
						</li>
						<li id="mngr_mn_2" class="on01">
							<img src="/images/wzwg/site/mngr/menu/site.png" alt="<spring:message code="wzwg.cmm.cntnts.sitemanage" /> <spring:message code="wzwg.cmm.word.image" />" />
							<a href="javascript:void(0);"><span><spring:message code="wzwg.cmm.cntnts.sitemanage" /></span></a>
							<div class="menu_help">
								<img src="/images/wzwg/site/mngr/<c:out value="${icoNm}" />" alt="<spring:message code="wzwg.cmm.word.menu" /> <spring:message code="wzwg.cmm.word.hpcm" />">
								<div class="help_pop">
										<spring:message code="wzwg.cmm.msg.MSG221" /> 
								</div>
							</div>
							<ul class="side-mu01" style="<c:if test="${fn:indexOf(nowUrl, '/siteMngr/') > -1}">display:block;</c:if>">
								<li><a href="<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectSiteInfoList.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/siteMngr/siteInfo/') > -1 || fn:indexOf(nowUrl, '/siteMngr/siteStplat/') > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.bassinfomanage" /></a></li>
								<li><a href="<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/siteGroup/selectSiteGroupList.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/siteMngr/siteGroup/') > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.groupmanage" /></a></li>
								<li><a href="<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/siteOpert/selectSysOpertNtcList.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/siteMngr/siteOpert/') > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.opertmanage" /></a></li>
                                <li><a href="<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/menuEstbs/selectMenuEstbsList.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/siteMngr/menuEstbs/') > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.menuestbsmanage" /></a></li>
                                <li><a href="<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/menu/selectSiteMngrMenuMngrList.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/siteMngr/menu/') > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.sitemngrmenumanage" /></a></li>
                                <li><a href="<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/sysSiteStplat/info/selectSysStplatInfoList.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/siteMngr/sysSiteStplat/') > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.sysStplatPolicy" /></a></li>
                                <li><a href="<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/bbsDataMngr/selectBbsDataForm.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/siteMngr/bbsDataMngr/') > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.dataarng" /></a></li>
                                <li><a href="<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/snsKeyMngr/selectSnsKeyMngr.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/siteMngr/snsKeyMngr/') > -1}">on</c:if>">SNS KEY</a></li>
							</ul>
						</li>
						  
						<li id="mngr_mn_4" class="on03">
							<img src="/images/wzwg/site/mngr/menu/subpage.png" alt="<spring:message code="wzwg.cmm.cntnts.modulemanage" />" />
							<a href="javascript:void(0);"><span><spring:message code="wzwg.cmm.cntnts.modulemanage" /></span></a>
							<div class="menu_help">
								<img src="/images/wzwg/site/mngr/<c:out value="${icoNm}" />" alt="<spring:message code="wzwg.cmm.word.menu" /> <spring:message code="wzwg.cmm.word.hpcm" />">
								<div class="help_pop">
									<spring:message code="wzwg.cmm.msg.MSG224" /> 
								</div>
							</div>
							<ul class="side-mu03" style="<c:if test="${fn:indexOf(nowUrl, '/moduleMngr/') > -1 || fn:indexOf(nowUrl, '/cntntsMngr/') > -1}">display:block;</c:if>">
								<li><a href="<c:out value="${wzwg_contextPath}" />/sysMngr/cntntsMngr/cntntnsTmplat/selectCntntsTmplatList.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/cntntsMngr/cntntnsTmplat/') > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.cntntstemplate" /></a></li>
								<li><a href="<c:out value="${wzwg_contextPath}" />/sysMngr/cntntsMngr/cntntnsStyle/selectCntntsStyleList.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/cntntsMngr/cntntnsStyle/') > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.moduleskin" /></a></li>
							</ul>
						</li>
						<li id="mngr_mn_5"<c:if test="${fn:indexOf(nowUrl, '/sysMngr/screen/selectTemplateList.do') > -1 }"> class="active"</c:if>>
							<img src="/images/wzwg/site/mngr/menu/home.png" alt="<spring:message code="wzwg.cmm.word.home" />" />
							<a href="<c:out value="${wzwg_contextPath}"/>/sysMngr/screen/selectTemplateList.do"><span><spring:message code="wzwg.cmm.cntnts.templatemanage" /></span></a>
							<div class="menu_help">
								<img src="/images/wzwg/site/mngr/<c:out value="${icoNm}" />" alt="<spring:message code="wzwg.cmm.word.menu" /> <spring:message code="wzwg.cmm.word.hpcm" />">
								<div class="help_pop">
									<spring:message code="wzwg.cmm.msg.MSG225" /><br/>
								</div>
							</div>
						</li>
						 
						<li id="mngr_mn_6" class="on08">
							<img src="/images/wzwg/site/mngr/menu/subpage.png" alt="<spring:message code="wzwg.cmm.cntnts.subpage" />" />
							<a href="javascript:void(0);"><span><spring:message code="wzwg.cmm.cntnts.subpage" /></span></a>
							<div class="menu_help">
								<img src="/images/wzwg/site/mngr/<c:out value="${icoNm}" />" alt="<spring:message code="wzwg.cmm.word.menu" /> <spring:message code="wzwg.cmm.word.hpcm" />">
								<div class="help_pop">
									<spring:message code="wzwg.cmm.msg.MSG227" />
								</div>
							</div>
							<ul class="side-mu08" style="<c:if test="${fn:indexOf(nowUrl, '/cntnts/cntntsInfo/') > -1 || fn:indexOf(nowUrl, '/module/bbs/') > -1 || fn:indexOf(nowUrl, '/module/schdul/') > -1 
																		|| fn:indexOf(nowUrl, '/module/cntnts/') > -1 || fn:indexOf(nowUrl, '/module/onlineReqst/') > -1 || fn:indexOf(nowUrl, '/module/onlineQustnr/') > -1 
																		|| fn:indexOf(nowUrl, '/module/map/') > -1 || fn:indexOf(nowUrl, '/module/calc/') > -1 || fn:indexOf(nowUrl, '/module/tabMenu/') > -1 }">display:block;</c:if>">
								<c:import url="${wzwg_contextPath}/cmm/decorators/leftMenu/selectCntntsMngr.do" />
							</ul>
					 
						</li>
					  
						<li id="mngr_mn_9" class="on02">
							<img src="/images/wzwg/site/mngr/menu/member.png" alt="<spring:message code="wzwg.cmm.cntnts.mbermanage" /> <spring:message code="wzwg.cmm.word.image" />" />
							<a href="javascript:void(0);"><span><spring:message code="wzwg.cmm.cntnts.mbermanage" /></span></a>
							<div class="menu_help">
								<img src="/images/wzwg/site/mngr/<c:out value="${icoNm}" />" alt="<spring:message code="wzwg.cmm.word.menu" /> <spring:message code="wzwg.cmm.word.hpcm" />">
								<div class="help_pop">
									<c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
										<spring:message code="wzwg.cmm.msg.MSG231" />
									</c:if>
									<c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
										<spring:message code="wzwg.cmm.msg.MSG232" />
									</c:if>
								</div>
							</div>
							<ul class="side-mu02" style="<c:if test="${fn:indexOf(nowUrl, '/usrMngr/') > -1}">display:block;</c:if>">
							
                           
                                <li><a href="<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/usrInfo/selectUsrInfoList.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/usrMngr/usrInfo/') > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.mberinfo" /></a></li>
                                <li><a href="<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/usrTyCode/selectUsrTyCodeList.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/usrMngr/usrTyCode/') > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.mberty" /></a></li>
                                <!-- 
                                <li><a href="/sysMngr/usrMngr/usrStplat/selectSysUsrStplatList.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/usrMngr/usrStplat/') > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.stplatestbs" /></a></li> 
                                  --> 
                                <li><a href="<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/usrPrefces/selectusrPrefcesList.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/usrMngr/usrPrefces/') > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.envrnestbs" /></a></li>
							</ul>
						</li>
						<li id="mngr_mn_10" class="on04">
							<img src="/images/wzwg/site/mngr/menu/setting.png" alt="<spring:message code="wzwg.cmm.cntnts.oprtrmanage" /> <spring:message code="wzwg.cmm.word.image" />" />
							<a href="javascript:void(0);"><span><spring:message code="wzwg.cmm.cntnts.oprtrmanage" /></span></a>
							<div class="menu_help">
								<img src="/images/wzwg/site/mngr/<c:out value="${icoNm}" />" alt="<spring:message code="wzwg.cmm.word.menu" /> <spring:message code="wzwg.cmm.word.hpcm" />">
								<div class="help_pop">
										<spring:message code="wzwg.cmm.msg.MSG233" />
								</div>
							</div>
							<ul class="side-mu04" style="<c:if test="${fn:indexOf(nowUrl, '/module/popup/') > -1 || fn:indexOf(nowUrl, '/module/banner/') > -1  || fn:indexOf(nowUrl, '/module/calc/') > -1 || fn:indexOf(nowUrl, '/module/upload/imageStore/') > -1 || fn:indexOf(nowUrl, '/module/upload/usr/file/') > -1 || fn:indexOf(nowUrl, '/mngr/inqryDtls/') > -1 || fn:indexOf(nowUrl, '/module/upload/fileMngr/fileEstbs/') > -1 || fn:indexOf(nowUrl, '/sysMngr/usrLog/') > -1}">display:block;</c:if>">
								<li><a href="<c:out value="${wzwg_contextPath}${prefix}" />/module/popup/selectModulePopupList.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/module/popup/') > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.popupmanage" /></a></li>
 								<li><a href="<c:out value="${wzwg_contextPath}${prefix}" />/module/banner/selectModuleBannerInfoList.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/module/banner/') > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.bannermanage" /></a></li>
                                <li><a href="<c:out value="${wzwg_contextPath}${prefix}" />/module/upload/imageStore/imageForm.do?mode=5" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/module/upload/imageStore/imageForm.do') > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.imgstore" /></a></li>
                                <li><a href="<c:out value="${wzwg_contextPath}${prefix}" />/module/upload/usr/file/selectFileStore.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/module/upload/usr/file/selectFileStore.do') > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.filestore" /></a></li>
							 
								<!-- 2018.03.30 첨부파일관리 기능 추가 --> 
                                <li><a href="<c:out value="${wzwg_contextPath}" />/module/upload/fileMngr/fileEstbs/selectFileEstbsMngrForm.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/module/upload/fileMngr/fileEstbs/selectFileEstbsMngrForm.do') > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.atchfilemanage" /></a></li>
                                <li><a href="<c:out value="${wzwg_contextPath}" />/sysMngr/usrLog/selectSiteUsrLogList.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/sysMngr/usrLog/selectSiteUsrLogList.do') > -1}">on</c:if>"><spring:message code="wzwg.cmm.menu.usrlogmanage" /></a></li>
								<li><a href="<c:out value="${wzwg_contextPath}" />/sysMngr/usrLog/selectSiteMngrLoginLogList.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/sysMngr/usrLog/selectSiteMngrLoginLogList.do') > -1}">on</c:if>"><spring:message code="wzwg.cmm.menu.mngrconectlogmanage" /></a></li>
								<%-- <li><a href="/module/api/reqst/reqstApiForm.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/module/api/reqst/reqstApiForm.do') > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.apimanage" /></a></li> --%>
							</ul>
						</li>
						
						<li id="mngr_mn_11" class="on05">
							<img src="/images/wzwg/site/mngr/menu/statistics.png" alt="<spring:message code="wzwg.cmm.cntnts.statsmanage" /> <spring:message code="wzwg.cmm.word.image" />" />
							<a href="javascript:void(0);"><span><spring:message code="wzwg.cmm.cntnts.statsmanage" /></span></a>
							<div class="menu_help">
								<img src="/images/wzwg/site/mngr/<c:out value="${icoNm}" />" alt="<spring:message code="wzwg.cmm.word.menu" /> <spring:message code="wzwg.cmm.word.hpcm" />">
								<div class="help_pop">
									<spring:message code="wzwg.cmm.msg.MSG235" />
								</div>
							</div>
							<ul class="side-mu05" style="<c:if test="${fn:indexOf(nowUrl, '/stat/') > -1}">display:block;</c:if>">
								<li><a href="<c:out value="${wzwg_contextPath}" />/sysMngr/stat/selectVisitStat.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/sysMngr/stat/selectVisitStat.do') > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.visitrsttus" /></a></li>
								<li><a href="<c:out value="${wzwg_contextPath}" />/sysMngr/stat/selectUsrStat.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/sysMngr/stat/selectUsrStat.do') > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.signupsttus" /></a></li>
								<li><a href="<c:out value="${wzwg_contextPath}" />/sysMngr/stat/selectBbsStat.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/sysMngr/stat/selectBbsStat.do') > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.nttregiststtus" /></a></li>
							</ul>
						</li>
						<li id="mngr_mn_12" class="on06">
							<img src="/images/wzwg/site/mngr/menu/operation.png" alt="<spring:message code="wzwg.cmm.cntnts.opnsu" /> <spring:message code="wzwg.cmm.word.image" />" />
							<a href="javascript:void(0);"><span><spring:message code="wzwg.cmm.cntnts.opnsu" /></span></a>
							<div class="menu_help">
								<img src="/images/wzwg/site/mngr/<c:out value="${icoNm}" />" alt="<spring:message code="wzwg.cmm.word.menu" /> <spring:message code="wzwg.cmm.word.hpcm" />">
								<div class="help_pop">
										<spring:message code="wzwg.cmm.msg.MSG236" />
								</div>
							</div>
							<ul class="side-mu06" style="<c:if test="${fn:indexOf(nowUrl, '/opnsu/bbs/') > -1}">display:block;</c:if>">
								<li><a href="<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/bbs/unity/selectBbsInc.do?bbsSeq=10000000001" class="side-submenu <c:if test="${fn:indexOf(param.bbsSeq, 10000000001) > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.notice" /></a></li>
								<li><a href="<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/bbs/unity/selectBbsInc.do?bbsSeq=10000000002" class="side-submenu <c:if test="${fn:indexOf(param.bbsSeq, 10000000002) > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.recsroom" /></a></li>
								<li><a href="<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/bbs/qna/selectBbsInc.do?bbsSeq=10000000003" class="side-submenu <c:if test="${fn:indexOf(param.bbsSeq, 10000000003) > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.qna" /></a></li>
								<li><a href="<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/bbs/unity/selectBbsInc.do?bbsSeq=10000000004" class="side-submenu <c:if test="${fn:indexOf(param.bbsSeq, 10000000004) > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.faq" /></a></li>
							</ul>
						</li>
					</ul>
				</div>
		</c:if>
 		<c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
 				<div id="sidebar" >
 						<div class="radiusBoxFX"></div>
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
							<a href="<c:out value="${wzwg_contextPath}" />/cmm/mber/login/actionMngrLogout.do"></a>
						    </div>
						</div>
						
						
					<ul>
						<li id="mngr_mn_1"<c:if test="${fn:indexOf(nowUrl, '/selectDashboardMain.do') > -1 }"> class="active"</c:if>>
							<img src="/images/wzwg/site/mngr/menu/home.png" alt="<spring:message code="wzwg.cmm.word.home" />" />
							<a href="<c:out value="${wzwg_contextPath}${prefix}" />/selectDashboardMain.do" ><span><spring:message code="wzwg.cmm.cntnts.dashboard" /></span></a>
							<div class="menu_help">
								<img src="/images/wzwg/site/mngr/<c:out value="${icoNm}" />" alt="<spring:message code="wzwg.cmm.word.menu" /> <spring:message code="wzwg.cmm.word.hpcm" />">
								<div class="help_pop">
									<c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
										<spring:message code="wzwg.cmm.msg.MSG219" />
									</c:if>
									<c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
										<spring:message code="wzwg.cmm.msg.MSG220" />
									</c:if>
								</div>
							</div>
						</li>
						<c:import url="${wzwg_contextPath}/cmm/decorators/leftMenu/selectMngrMenu.do" />
					</ul>
				</div>
 </c:if>
<div class="menu_fade"></div> <!-- 새로 추가해준 부분. 심수정 0315. -->

<script>
	if($('#sidebar').find('.on').length != 0) {
		$('li').removeClass('active');
		var activeLi = $('#sidebar').find('.on').parents('li')[1];
		$(activeLi).addClass('active');
	}
</script>