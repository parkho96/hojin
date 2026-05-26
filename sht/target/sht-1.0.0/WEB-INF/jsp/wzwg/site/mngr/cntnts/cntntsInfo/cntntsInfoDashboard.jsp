<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script>
function fnSelectCntntsinfoList(moduleSeq){
	$('#searchModuleSeq').val(moduleSeq);
	
	$('#frmSrh').submit();
	
}

function fnRegistCntntnsForm(moduleSeq, moduleTyCode){
	$('#frmCntntsInfo #sysmoduleSeq').val(moduleSeq);
	$('#frmCntntsInfo #moduleTyCode').val(moduleTyCode);
	
	if(moduleTyCode == 'SC00000030' || moduleTyCode == 'SC00000031' || moduleTyCode == 'SC00000032'){
		$('#frmCntntsInfo').attr('action','<c:out value="${wzwg_contextPath}"/>/mngr/cntnts/cntntsInfo/selectCntntsInfoForm.do');
	}else if(moduleSeq == '10000000211'){
		$('#frmCntntsInfo').attr('action', '<c:out value="${wzwg_contextPath}"/>/mngr/module/onlineQustnr/registOnlineQustnrInfoForm.do');
	}
	
	$('#frmCntntsInfo').submit();
}

$(document).ready(function(){
	var cnt = 0;
	$('.cntnts_cnt').each(function(){
		cnt += parseInt($(this).text());
	});
	
	$('.cntnts_allcnt').html(cnt);
})
</script>

<form id="frmSrh" name="frmSrh" action="<c:out value="${wzwg_contextPath}"/>/mngr/cntnts/cntntsInfo/selectCntntsInfoList.do" method="post">
	<input id="pageIndex" name="pageIndex" type="hidden" value="1">
	<input id="sysmoduleSeq" name="sysmoduleSeq" type="hidden" value="">
	<input id="moduleNmOrdr" name="moduleNmOrdr" type="hidden" value="">
	<input id="cntntsNmOrdr" name="cntntsNmOrdr" type="hidden" value="">
	<input id="frstRegistPnttmOrdr" name="frstRegistPnttmOrdr" type="hidden" value="D">
	<input id="searchModuleSeq" name="searchModuleSeq" type="hidden" value="">
	<input id="searchCondition" name="searchCondition" type="hidden" value="">
	<input id="searchKeyword" name="searchKeyword" type="hidden" value="">
</form>
            
            
<form id="frmCntntsInfo" name="frmCntntsInfo" method="post">
	<input id="cntntsNm" name="cntntsNm" type="hidden" value="">
	<input id="moduleTyCode" name="moduleTyCode" type="hidden" value="">
	<input id="sysmoduleSeq" name="sysmoduleSeq" type="hidden" value="">
</form>
            
            			<!-- 전체 서브페이지 수 -->
						<div class="subWrap allbox">
							<div class="txtbox">
								<p class="tit"><spring:message code="wzwg.site.cntnts.msg.MSG005" /></p>
								<p class="no"><b class="cntnts_allcnt">00</b><spring:message code="wzwg.cmm.word.count06" /></p>
							</div>
						</div>
						<!-- /전체 서브페이지 수 -->
						
						
						
						<!-- 서브대시보드  -->
						<div class="subWrap site-groupAll wd100">
						
							<!-- 컨텐츠  -->
	                        <div class="subDashbox">
	                            <h3 class="wd100 subDashtit cntnts"><spring:message code="wzwg.cmm.word.cntnts" /></h3>
	                            <div class="wd100">
	
	                                <ul class="subDashbrd">
										
										<!-- 일반 컨텐츠 -->
	                                    <li class="subModule">
	                                        <div class="iconbox cntnts"></div>
	                                        <div class="txtbox">
	                                            <div class="title"><spring:message code="wzwg.site.cntnts.msg.MSG006" /></div>
	                                            
	                                            <div class="btnMore">
                                            		<span class="num">
                                            			<b class="cntnts_cnt"><c:out value="${moduleCntMap['10000000105'].moduleCnt  + 0}"/></b>
                                            			<spring:message code="wzwg.cmm.word.count06" />
                                            		</span>
                                            		<!-- 메뉴 보기 -->
                                            		<span><spring:message code="wzwg.site.cntnts.msg.MSG007" /></span>
                                            		<strong class="iconList"><span class="icon"><i></i><i></i><i></i></span></strong>
                                            		
                                            		<ul class="hoverBtn">
						    							<li>
						    								<a class="add" href="javascript:void(0);" onclick="fnRegistCntntnsForm('10000000105', 'SC00000032')">
																<!-- 생성 -->
																<spring:message code="wzwg.cmm.word.creat01" />
															</a>
														</li>
						    							<li>
						    								<a class="list" href="javascript:void(0);" onclick="fnSelectCntntsinfoList('10000000105')">
						    									<!-- 목록 -->
						    									<spring:message code="wzwg.cmm.word.list" />
						    								</a>
						    							</li>
						    						</ul>
	                                            </div>
	                                            
	                                            <div class="coInfo"><spring:message code="wzwg.cmm.mngr.subDshBrd.MSG002" /></div>
	                                        </div>
	                                    </li>
	                                    <!-- /일반 컨텐츠 -->
	                                    
	                                    <!-- 탭 메뉴 -->
	                                    <li class="subModule">
	                                        <div class="iconbox tab"></div>
	                                        <div class="txtbox">
	                                            <div class="title"><spring:message code="wzwg.site.cntnts.msg.MSG008" /></div>
	                                            
	                                            <div class="btnMore">
                                            		<span class="num">
	                                            		<b class="cntnts_cnt"><c:out value="${moduleCntMap['10000000238'].moduleCnt  + 0}"/></b>
														<spring:message code="wzwg.cmm.word.count06" />
                                            		</span>
                                            		<!-- 메뉴 보기 -->
                                            		<span><spring:message code="wzwg.site.cntnts.msg.MSG007" /></span>
                                            		<strong class="iconList"><span class="icon"><i></i><i></i><i></i></span></strong>
                                            		
                                            		<ul class="hoverBtn">
						    							<li>
							    							<a class="add" href="javascript:void(0);" onclick="fnRegistCntntnsForm('10000000238', 'SC00000030')">
							    								<!-- 생성 -->
							    								<spring:message code="wzwg.cmm.word.creat01" />
							    							</a>
						    							</li>
						    							<li>
						    								<a class="list" href="javascript:void(0);" onclick="fnSelectCntntsinfoList('10000000238')">
						    									<!-- 목록 -->
						    									<spring:message code="wzwg.cmm.word.list" />
						    								</a>
						    							</li>
						    						</ul>
	                                            </div>
	                                            
	                                            <div class="coInfo"><spring:message code="wzwg.cmm.mngr.subDshBrd.MSG010" /></div>
	                                        </div>
	                                    </li>
	                                    <!-- /탭 메뉴 -->
	                                    
	                                    <!-- 지도 -->
	                                    <li class="subModule">
	                                        <div class="iconbox map"></div>
	                                        <div class="txtbox">
	                                            <div class="title"><spring:message code="wzwg.cmm.word.map" /></div>
	                                            
	                                            <div class="btnMore">
                                            		<span class="num">
                                            			<b class="cntnts_cnt"><c:out value="${moduleCntMap['10000000213'].moduleCnt  + 0}"/></b>
                                            			<spring:message code="wzwg.cmm.word.count06" />
                                            		</span>
                                            		<!-- 메뉴 보기 -->
                                            		<span><spring:message code="wzwg.site.cntnts.msg.MSG007" /></span>
                                            		<strong class="iconList"><span class="icon"><i></i><i></i><i></i></span></strong>
                                            		
                                            		<ul class="hoverBtn">
						    							<li>
							    							<a class="add" href="javascript:void(0);" onclick="fnRegistCntntnsForm('10000000213', 'SC00000031')">
							    								<!-- 생성 -->
							    								<spring:message code="wzwg.cmm.word.creat01" />
							    							</a>
						    							</li>
						    							<li>
						    								<a class="list" href="javascript:void(0);" onclick="fnSelectCntntsinfoList('10000000213')">
						    									<!-- 목록 -->
						    									<spring:message code="wzwg.cmm.word.list" />
						    								</a>
						    							</li>
						    						</ul>
	                                            </div>
	                                            
	                                            <div class="coInfo"><spring:message code="wzwg.cmm.mngr.subDshBrd.MSG003" /></div>
	                                        </div>
	                                    </li>
	                                    <!-- /지도 -->
	
	                                </ul>
	
	                            </div>
	                        </div>
	                        <!-- /컨텐츠 -->
	                        
	                        <!-- 게시판  -->
	                        <div class="subDashbox">
	                        	<h3 class="wd100 subDashtit bbs"><spring:message code="wzwg.cmm.word.bbs01" /></h3>
	                        
	                            <div class="wd100">
	
	                                <ul class="subDashbrd">
	                                
	                                	<!-- btn 게시물 양식설정 -->
	                                    <li class="subModule postform">
	                                        <div class="iconbox form"></div>
	                                        <div class="menu_help">
												<span class="circle_no vert-m">?</span>
												<div class="help_pop txt-l">
													<spring:message code="wzwg.cmm.mngr.subDshBrd.MSG001" />
												</div>
											</div>
	                                        <div class="txtbox">
	                                            <div class="title">
	                                            	<spring:message code="wzwg.site.cntnts.msg.MSG009" />
	                                            </div>
	                                            <div class="btnMore">	 
                                            		<!-- 메뉴 보기 -->
                                            		<span><spring:message code="wzwg.site.cntnts.msg.MSG007" /></span>
                                            		<strong class="iconList"><span class="icon"><i></i><i></i><i></i></span></strong>
                                            		
                                            		<ul class="hoverBtn">
						    							<li>
						    								<a class="add" href="<c:out value="${wzwg_contextPath}"/>/mngr/module/bbs/bbsForm/registModuleBbsFormForm.do">
																<!-- 양식 설정 -->
																<spring:message code="wzwg.cmm.word.regist" />
															</a>
														</li>
						    							<li>
						    								<a class="list" href="<c:out value="${wzwg_contextPath}"/>/mngr/module/bbs/bbsForm/selectModuleBbsFormList.do">
						    									<!-- 양식 목록 -->
						    									<spring:message code="wzwg.cmm.word.list" />
						    								</a>
						    							</li>
						    						</ul>
	                                            </div>
	                                        </div>
	                                    </li>
	                                    <!-- /게시물 양식설정 -->
										
										<!-- 일반 게시판 -->
	                                    <li class="subModule">
	                                        <div class="iconbox gnrl"></div>
	                                        <div class="txtbox">
	                                            <div class="title"><spring:message code="wzwg.site.cntnts.msg.MSG010" /></div>
	                                            
	                                            <div class="btnMore">
                                            		<span class="num">
	                                            		<b class="cntnts_cnt"><c:out value="${moduleCntMap['10000000003'].moduleCnt  + 0}"/></b>
	                                            		<spring:message code="wzwg.cmm.word.count06" />
                                            		</span>
                                            		<!-- 메뉴 보기 -->
                                            		<span><spring:message code="wzwg.site.cntnts.msg.MSG007" /></span>
                                            		<strong class="iconList"><span class="icon"><i></i><i></i><i></i></span></strong>
                                            		
                                            		<ul class="hoverBtn">
						    							<li>
						    								<a class="add" href="javascript:void(0);" onclick="fnRegistCntntnsForm('10000000003', 'SC00000030')">
																<!-- 게시판 생성 -->
																<spring:message code="wzwg.cmm.word.creat01" />
															</a>
														</li>
						    							<li>
						    								<a class="list" href="javascript:void(0);" onclick="fnSelectCntntsinfoList('10000000003')">
						    									<!-- 게시판 목록 -->
						    									<spring:message code="wzwg.cmm.word.list" />
						    								</a>
						    							</li>
						    						</ul>
	                                            </div>
	                                            
	                                            <div class="coInfo"><spring:message code="wzwg.cmm.mngr.subDshBrd.MSG008" /></div>
	                                        </div>
	                                    </li>
	                                    <!-- /일반 게시판 -->
	                                    
	                                    <!-- 이미지 게시판 -->
	                                    <li class="subModule">
	                                        <div class="iconbox image"></div>
	                                        <div class="txtbox">
	                                            <div class="title"><spring:message code="wzwg.site.cntnts.msg.MSG011" /></div>
	                                            
	                                            <div class="btnMore">
                                            		<span class="num">
	                                            		<b class="cntnts_cnt"><c:out value="${moduleCntMap['10000000237'].moduleCnt  + 0}"/></b>
	                                            		<spring:message code="wzwg.cmm.word.count06" />
                                            		</span>
                                            		<!-- 메뉴 보기 -->
                                            		<span><spring:message code="wzwg.site.cntnts.msg.MSG007" /></span>
                                            		<strong class="iconList"><span class="icon"><i></i><i></i><i></i></span></strong>
                                            		
                                            		<ul class="hoverBtn">
						    							<li>
						    								<a class="add" href="javascript:void(0);" onclick="fnRegistCntntnsForm('10000000237', 'SC00000030')">
																<!-- 게시판 생성 -->
																<spring:message code="wzwg.cmm.word.creat01" />
															</a>
														</li>
						    							<li>
						    								<a class="list" href="javascript:void(0);" onclick="fnSelectCntntsinfoList('10000000237')">
						    									<!-- 게시판 목록 -->
						    									<spring:message code="wzwg.cmm.word.list" />
						    								</a>
						    							</li>
						    						</ul>
	                                            </div>
	                                            
	                                            <div class="coInfo"><spring:message code="wzwg.cmm.mngr.subDshBrd.MSG016" /></div>
	                                        </div>
	                                    </li>
	                                    <!-- /이미지 게시판 -->
	                                    
	                                    <!-- 커스텀 게시판 -->
	                                    <li class="subModule">
	                                        <div class="iconbox custom"></div>
	                                        <div class="txtbox">
	                                            <div class="title"><spring:message code="wzwg.site.cntnts.msg.MSG012" /></div>
	                                            
	                                            <div class="btnMore">
                                            		<span class="num">
	                                            		<b class="cntnts_cnt"><c:out value="${moduleCntMap['10000000215'].moduleCnt  + 0}"/></b>
	                                            		<spring:message code="wzwg.cmm.word.count06" />
                                            		</span>
                                            		<!-- 메뉴 보기 -->
                                            		<span><spring:message code="wzwg.site.cntnts.msg.MSG007" /></span>
                                            		<strong class="iconList"><span class="icon"><i></i><i></i><i></i></span></strong>
                                            		
                                            		<ul class="hoverBtn">
						    							<li>
						    								<a class="add" href="javascript:void(0);" onclick="fnRegistCntntnsForm('10000000215', 'SC00000030')">
																<!-- 게시판 생성 -->
																<spring:message code="wzwg.cmm.word.creat01" />
															</a>
														</li>
						    							<li>
						    								<a class="list" href="javascript:void(0);" onclick="fnSelectCntntsinfoList('10000000215')">
						    									<!-- 게시판 목록 -->
						    									<spring:message code="wzwg.cmm.word.list" />
						    								</a>
						    							</li>
						    						</ul>
	                                            </div>
	                                            
	                                            <div class="coInfo"><spring:message code="wzwg.cmm.mngr.subDshBrd.MSG009" /></div>
	                                        </div>
	                                    </li>
	                                    <!-- /커스텀 게시판 -->
	                                    
	                                    <!-- 동영상 게시판 -->
	                                    <li class="subModule">
	                                        <div class="iconbox mvp"></div>
	                                        <div class="txtbox">
	                                            <div class="title"><spring:message code="wzwg.site.cntnts.msg.MSG013" /></div>
	                                            
	                                            <div class="btnMore">
                                            		<span class="num">
                                            			<b class="cntnts_cnt"><c:out value="${moduleCntMap['10000000204'].moduleCnt  + 0}"/></b>
														<spring:message code="wzwg.cmm.word.count06" />
                                            		</span>
                                            		<!-- 메뉴 보기 -->
                                            		<span><spring:message code="wzwg.site.cntnts.msg.MSG007" /></span>
                                            		<strong class="iconList"><span class="icon"><i></i><i></i><i></i></span></strong>
                                            		
                                            		<ul class="hoverBtn">
						    							<li>
						    								<a class="add" href="javascript:void(0);" onclick="fnRegistCntntnsForm('10000000204', 'SC00000030')">
																<!-- 게시판 생성 -->
																<spring:message code="wzwg.cmm.word.creat01" />
															</a>
														</li>
						    							<li>
						    								<a class="list" href="javascript:void(0);" onclick="fnSelectCntntsinfoList('10000000204')">
						    									<!-- 게시판 목록 -->
						    									<spring:message code="wzwg.cmm.word.list" />
						    								</a>
						    							</li>
						    						</ul>
	                                            </div>
	                                            
	                                            <div class="coInfo"><spring:message code="wzwg.cmm.mngr.subDshBrd.MSG011" /></div>
	                                        </div>
	                                    </li>
	                                    <!-- /동영상 게시판 -->
	                                    
	                                    <!-- Q&A 게시판 -->
	                                    <li class="subModule">
	                                        <div class="iconbox qna"></div>
	                                        <div class="txtbox">
	                                            <div class="title">Q&amp;A <spring:message code="wzwg.cmm.word.bbs01" /></div>
	                                            
	                                            <div class="btnMore">
                                            		<span class="num">
                                            			<b class="cntnts_cnt"><c:out value="${moduleCntMap['10000000101'].moduleCnt  + 0}"/></b>
                                            			<spring:message code="wzwg.cmm.word.count06" />
                                            		</span>
                                            		<!-- 메뉴 보기 -->
                                            		<span><spring:message code="wzwg.site.cntnts.msg.MSG007" /></span>
                                            		<strong class="iconList"><span class="icon"><i></i><i></i><i></i></span></strong>
                                            		
                                            		<ul class="hoverBtn">
						    							<li>
						    								<a class="add" href="javascript:void(0);" onclick="fnRegistCntntnsForm('10000000101', 'SC00000030')">
																<!-- 게시판 생성 -->
																<spring:message code="wzwg.cmm.word.creat01" />
															</a>
														</li>
						    							<li>
						    								<a class="list" href="javascript:void(0);" onclick="fnSelectCntntsinfoList('10000000101')">
						    									<!-- 게시판 목록 -->
						    									<spring:message code="wzwg.cmm.word.list" />
						    								</a>
						    							</li>
						    						</ul>
	                                            </div>
	                                            
	                                            <div class="coInfo"><spring:message code="wzwg.cmm.mngr.subDshBrd.MSG012" /></div>
	                                        </div>
	                                    </li>
	                                    <!-- /Q&A 게시판 -->
	                                    
	                                    <!-- FAQ 게시판 -->
	                                    <li class="subModule">
	                                        <div class="iconbox faq"></div>
	                                        <div class="txtbox">
	                                            <div class="title">FAQ <spring:message code="wzwg.cmm.word.bbs01" /></div>
	                                            
	                                            <div class="btnMore">
                                            		<span class="num">
                                            			<b class="cntnts_cnt"><c:out value="${moduleCntMap['10000000220'].moduleCnt  + 0}"/></b>
                                            			<spring:message code="wzwg.cmm.word.count06" />
                                            		</span>
                                            		<!-- 메뉴 보기 -->
                                            		<span><spring:message code="wzwg.site.cntnts.msg.MSG007" /></span>
                                            		<strong class="iconList"><span class="icon"><i></i><i></i><i></i></span></strong>
                                            		
                                            		<ul class="hoverBtn">
						    							<li>
						    								<a class="add" href="javascript:void(0);" onclick="fnRegistCntntnsForm('10000000220', 'SC00000030')">
																<!-- 게시판 생성 -->
																<spring:message code="wzwg.cmm.word.creat01" />
															</a>
														</li>
						    							<li>
						    								<a class="list" href="javascript:void(0);" onclick="fnSelectCntntsinfoList('10000000220')">
						    									<!-- 게시판 목록 -->
						    									<spring:message code="wzwg.cmm.word.list" />
						    								</a>
						    							</li>
						    						</ul>
	                                            </div>
	                                            
	                                            <div class="coInfo"><spring:message code="wzwg.cmm.mngr.subDshBrd.MSG013" /></div>
	                                        </div>
	                                    </li>
	                                    <!-- /FAQ 게시판 -->
	                                    
	                                    <!-- 링크 게시판 -->
	                                    <li class="subModule">
	                                        <div class="iconbox link"></div>
	                                        <div class="txtbox">
	                                            <div class="title"><spring:message code="wzwg.site.cntnts.msg.MSG014" /></div>
	                                            
	                                            <div class="btnMore">
                                            		<span class="num">
                                            			<b class="cntnts_cnt"><c:out value="${moduleCntMap['10000000218'].moduleCnt  + 0}"/></b>
                                            			<spring:message code="wzwg.cmm.word.count06" />
                                            		</span>
                                            		<!-- 메뉴 보기 -->
                                            		<span><spring:message code="wzwg.site.cntnts.msg.MSG007" /></span>
                                            		<strong class="iconList"><span class="icon"><i></i><i></i><i></i></span></strong>
                                            		
                                            		<ul class="hoverBtn">
						    							<li>
						    								<a class="add" href="javascript:void(0);" onclick="fnRegistCntntnsForm('10000000218', 'SC00000030')">
																<!-- 게시판 생성 -->
																<spring:message code="wzwg.cmm.word.creat01" />
															</a>
														</li>
						    							<li>
						    								<a class="list" href="javascript:void(0);" onclick="fnSelectCntntsinfoList('10000000218')">
						    									<!-- 게시판 목록 -->
						    									<spring:message code="wzwg.cmm.word.list" />
						    								</a>
						    							</li>
						    						</ul>
	                                            </div>
	                                            
	                                            <div class="coInfo"><spring:message code="wzwg.cmm.mngr.subDshBrd.MSG014" /></div>
	                                        </div>
	                                    </li>
	                                    <!-- /링크 게시판 -->
	                                    
	                                    <!-- 간단 게시판 -->
	                                    <li class="subModule">
	                                        <div class="iconbox simple"></div>
	                                        <div class="txtbox">
	                                            <div class="title"><spring:message code="wzwg.site.cntnts.msg.MSG015" /></div>
	                                            
	                                            <div class="btnMore">
                                            		<span class="num">
                                            			<b class="cntnts_cnt"><c:out value="${moduleCntMap['10000000103'].moduleCnt  + 0}"/></b>
                                            			<spring:message code="wzwg.cmm.word.count06" />
                                            		</span>
                                            		<!-- 메뉴 보기 -->
                                            		<span><spring:message code="wzwg.site.cntnts.msg.MSG007" /></span>
                                            		<strong class="iconList"><span class="icon"><i></i><i></i><i></i></span></strong>
                                            		
                                            		<ul class="hoverBtn">
						    							<li>
						    								<a class="add" href="javascript:void(0);" onclick="fnRegistCntntnsForm('10000000103', 'SC00000030')">
																<!-- 생성 -->
																<spring:message code="wzwg.cmm.word.creat01" />
															</a>
														</li>
						    							<li>
						    								<a class="list" href="javascript:void(0);" onclick="fnSelectCntntsinfoList('10000000103')">
						    									<!-- 목록 -->
						    									<spring:message code="wzwg.cmm.word.list" />
						    								</a>
						    							</li>
						    						</ul>
	                                            </div>
	                                            
	                                            <div class="coInfo"><spring:message code="wzwg.cmm.mngr.subDshBrd.MSG015" /></div>
	                                        </div>
	                                    </li>
	                                    <!-- /간단 게시판 -->
	                                    
	                                </ul>
	                            </div>
	                        </div>
	                        <!-- /게시판 -->
	                        
	                        <!-- 기타 모듈 -->
	                        <div class="subDashbox">
	                        	<h3 class="wd100 subDashtit etc"><spring:message code="wzwg.cmm.word.etc" /></h3>
	                            <div class="wd100">
	
	                                <ul class="subDashbrd">
										
										<!-- 일정 -->
	                                    <li class="subModule">
	                                        <div class="iconbox schdul"></div>
	                                        <div class="txtbox">
	                                            <div class="title"><spring:message code="wzwg.cmm.word.schdul" /></div>
	                                            
	                                            <div class="btnMore">
                                            		<span class="num">
                                            			<b class="cntnts_cnt"><c:out value="${moduleCntMap['10000000104'].moduleCnt  + 0}"/></b>
														<spring:message code="wzwg.cmm.word.count06" />
                                            		</span>
                                            		<!-- 메뉴 보기 -->
                                            		<span><spring:message code="wzwg.site.cntnts.msg.MSG007" /></span>
                                            		<strong class="iconList"><span class="icon"><i></i><i></i><i></i></span></strong>
                                            		
                                            		<ul class="hoverBtn">
						    							<li>
						    								<a class="add" href="javascript:void(0);" onclick="fnRegistCntntnsForm('10000000104', 'SC00000031')">
																<!-- 생성 -->
																<spring:message code="wzwg.cmm.word.creat01" />
															</a>
														</li>
						    							<li>
						    								<a class="list" href="javascript:void(0);" onclick="fnSelectCntntsinfoList('10000000104')">
						    									<!-- 목록 -->
						    									<spring:message code="wzwg.cmm.word.list" />
						    								</a>
						    							</li>
						    						</ul>
	                                            </div>
	                                            
	                                            <div class="coInfo"><spring:message code="wzwg.cmm.mngr.subDshBrd.MSG004" /></div>
	                                        </div>
	                                    </li>
	                                    <!-- /일정 -->
	                                    
	                                    <!-- 온라인 신청 -->
	                                    <li class="subModule">
	                                        <div class="iconbox reqst"></div>
	                                        <div class="txtbox">
	                                            <div class="title"><spring:message code="wzwg.site.cntnts.msg.MSG016" /></div>
	                                            
	                                            <div class="btnMore">
                                            		<span class="num">
                                            			<b class="cntnts_cnt"><c:out value="${moduleCntMap['10000000210'].moduleCnt  + 0}"/></b>
														<spring:message code="wzwg.cmm.word.count06" />
                                            		</span>
                                            		<!-- 메뉴 보기 -->
                                            		<span><spring:message code="wzwg.site.cntnts.msg.MSG007" /></span>
                                            		<strong class="iconList"><span class="icon"><i></i><i></i><i></i></span></strong>
                                            		
                                            		<ul class="hoverBtn">
						    							<li>
						    								<a class="add" href="javascript:void(0);" onclick="fnRegistCntntnsForm('10000000210', 'SC00000031')">
																<!-- 생성 -->
																<spring:message code="wzwg.cmm.word.creat01" />
															</a>
														</li>
						    							<li>
						    								<a class="list" href="javascript:void(0);" onclick="fnSelectCntntsinfoList('10000000210')">
						    									<!-- 목록 -->
						    									<spring:message code="wzwg.cmm.word.list" />
						    								</a>
						    							</li>
						    						</ul>
	                                            </div>
	                                            
	                                            <div class="coInfo"><spring:message code="wzwg.cmm.mngr.subDshBrd.MSG005" /></div>
	                                        </div>
	                                    </li>
	                                    <!-- /온라인 신청 -->
	                                    
	                                    <!-- 온라인 설문 -->
	                                    <li class="subModule">
	                                        <div class="iconbox qustnr"></div>
	                                        <div class="txtbox">
	                                            <div class="title"><spring:message code="wzwg.site.cntnts.msg.MSG017" /></div>
	                                            
	                                            <div class="btnMore">
                                            		<span class="num">
                                            			<b class="cntnts_cnt"><c:out value="${moduleCntMap['qustnr'].moduleCnt  + 0}"/></b>
														<spring:message code="wzwg.cmm.word.count06" />
                                            		</span>
                                            		<!-- 메뉴 보기 -->
                                            		<span><spring:message code="wzwg.site.cntnts.msg.MSG007" /></span>
                                            		<strong class="iconList"><span class="icon"><i></i><i></i><i></i></span></strong>
                                            		
                                            		<ul class="hoverBtn">
						    							<li>
						    								<a class="add" href="javascript:void(0);" onclick="fnRegistCntntnsForm('10000000211', 'SC00000033')">
																<!-- 생성 -->
																<spring:message code="wzwg.cmm.word.creat01" />
															</a>
														</li>
						    							<li>
						    								<a class="list" href="/mngr/module/onlineQustnr/selectOnlineQustnrInfoList.do" onclick="fnSelectCntntsinfoList('10000000210')">
						    									<!-- 목록 -->
						    									<spring:message code="wzwg.cmm.word.list" />
						    								</a>
						    							</li>
						    						</ul>
	                                            </div>
	                                            
	                                            <div class="coInfo"><spring:message code="wzwg.cmm.mngr.subDshBrd.MSG006" /></div>
	                                        </div>
	                                    </li>
	                                    <!-- /온라인 설문 -->
	                                    
	                                    <!-- 커뮤니티 관리 -->
	                                    <li class="subModule">
	                                        <div class="iconbox cmmnty"></div>
	                                        <div class="txtbox">
	                                            <div class="title"><spring:message code="wzwg.site.cntnts.msg.MSG018" /></div>
	                                            
	                                            <div class="btnMore">
                                            		<span class="num">
                                            			<b class="cntnts_cnt"><c:out value="${moduleCntMap['cmnt'].moduleCnt  + 0}"/></b>
														<spring:message code="wzwg.cmm.word.count06" />
                                            		</span>
                                            		<!-- 메뉴 보기 -->
                                            		<span><spring:message code="wzwg.site.cntnts.msg.MSG007" /></span>
                                            		<strong class="iconList"><span class="icon"><i></i><i></i><i></i></span></strong>
                                            		
                                            		<ul class="hoverBtn">
						    							<li>
						    								<a class="add" href="/mngr/cmnt/info/registCmntInfoForm.do">
																<!-- 생성 -->
																<spring:message code="wzwg.cmm.word.creat01" />
															</a>
														</li>
						    							<li>
						    								<a class="list" href="/mngr/cmnt/info/selectCmntInfoList.do">
						    									<!-- 목록 -->
						    									<spring:message code="wzwg.cmm.word.list" />
						    								</a>
						    							</li>
						    							<li>
						    								<a class="list" href="/mngr/cmnt/config/selectCmntCfgForm.do">
						    									<!-- 설정 -->
						    									<spring:message code="wzwg.cmm.word.set" />
						    								</a>
						    							</li>
						    						</ul>
	                                            </div>
	                                            
	                                            <div class="coInfo"><spring:message code="wzwg.cmm.mngr.subDshBrd.MSG007" /></div>
	                                        </div>
	                                    </li>
	                                    <!-- /커뮤니티 관리 -->
	                                    
	                                </ul>
	                                
	                            </div>
	                        </div>
	                        <!-- /기타 모듈 -->
	                        
                        </div>
