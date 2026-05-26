<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>


		<tr id="dataList">
		
			<!-- 1차그룹 없을 때, 생성되는 추가 버튼 -->	
			<c:if test="${fn:length(orgnztInfoList) eq 0}">
				<td class="mt20 mr20 mb20 ml20">
					<button type="button"  onmousedown="javascript:fnOrgInfoRegistFrmAjax(1, null, null);" class="iconOnlyBtnSameSize btn-save white ml0"><spring:message code="wzwg.cmm.word.add" /></button>
				</td>
			</c:if>
	
	
	
		 	<c:if test="${fn:length(orgnztInfoList) ne 0}">
			<td>
			<div>
				<!-- 1Depth -->
				<c:forEach items="${orgnztInfoList}" var="oneDepth">
					<c:if test="${oneDepth.orgnztLv eq 1}">
					<c:set var="oneDepth_cssClssNm" value="${fn:escapeXml(oneDepth.cssClssNm)}" />
					<ul id="orgDataRoot">
						<li class="w100">
												
							<div class="orgDataBox mr20 mb10 dropGroup ${fn:escapeXml(oneDepth_cssClssNm)}" data-orgInfoSeq="<c:out value="${oneDepth.orgnztSeq }" />">
								<div class="orgNmBox">
									<span class="orgnztNmKr fw400 mr10 <c:if test="${fn:indexOf(oneDepth.cssClssNm, 'strong') >= 0 }">white</c:if>">
										<!-- <a class="" href="javascript:void(0);" onclick="fnGetOrgInfoMemList('<c:out value="${oneDepth.orgnztSeq}" />','<c:out value="${oneDepth.orgnztNmKr}" />','<c:out value="${oneDepth.orgnztTySe}" />');"><c:out value="${oneDepth.orgnztNmKr}"/></a> -->
										<c:out value="${oneDepth.orgnztNmKr}"/>
									</span>
								</div>	
								
								<div class="orgBtnPop">
									<span class="btn3dot"><span class="icon"><i></i><i></i><i></i></span></span>
									<div class="wzbtn-group">
										<button type="button"  onmousedown="javascript:fnOrgInfoRegistFrmAjax(2, '<c:out value="${oneDepth.orgnztSeq}" />','<c:out value="${oneDepth.orgnztNmKr}" />')"><spring:message code="wzwg.cmm.word.orgaddsubGrp" /></button>
										<button type="button"  onmousedown="javascript:fnOrgInfoModifyFrmAjax('<c:out value="${oneDepth.orgnztSeq}" />')"><spring:message code="wzwg.cmm.word.orgdptSet" /></button>
									</div>			
								</div>		
							</div>   
							
							<div class="TwodpthDiv">
							<!-- 2Depth -->
							<c:forEach items="${orgnztInfoList}" var="twoDepth">
								<c:if test="${twoDepth.orgnztLv eq 2 and oneDepth.orgnztSeq eq twoDepth.parntsOrgnztSeq}">
								<c:set var="twoDepth_cssClssNm" value="${fn:escapeXml(twoDepth.cssClssNm)}" />
								<ul>
									<li>
										<button type="button" class="btn-plus iconOnlyBtn btn-basic ml0" onclick="$(this).siblings().filter('ul').slideToggle();"></button>
										<div class="orgDataBox group dropGroup mb10 ${fn:escapeXml(twoDepth_cssClssNm)}" data-orgInfoSeq="<c:out value="${twoDepth.orgnztSeq }" />" style="border-color:#9baec8;">
											<div class="orgNmBox">
												<span class="orgnztNmKr fw400 mr15 <c:if test="${fn:indexOf(twoDepth.cssClssNm, 'strong') >= 0 }">white</c:if>">
													<!--<a class="" href="javascript:void(0);" onclick="fnGetOrgInfoMemList('<c:out value="${twoDepth.orgnztSeq}" />','<c:out value="${twoDepth.orgnztNmKr}" />', '<c:out value="${twoDepth.orgnztTySe}" />');"><c:out value="${twoDepth.orgnztNmKr}"/></a>-->
													<c:out value="${twoDepth.orgnztNmKr}"/>
												</span>
											</div>
											
											<div class="orgBtnPop">
												<span class="btn3dot"><span class="icon"><i></i><i></i><i></i></span></span>
												<div class="wzbtn-group">
													<button type="button" class="btn-basic iconOnlyBtn btn-sortUp ml0" data-orgInfoSeq="<c:out value="${twoDepth.orgnztSeq}" />" onclick="fnOrgInfoOrdrChange('prev', this);" title="<spring:message code="wzwg.cmm.word.up"/>">▲</button>	    		
													<button type="button" class="btn-basic iconOnlyBtn btn-sortDown ml0" data-orgInfoSeq="<c:out value="${twoDepth.orgnztSeq}" />" onclick="fnOrgInfoOrdrChange('next', this);" title="<spring:message code="wzwg.cmm.word.down"/>">▼</button>
													
													
													<c:if test="${twoDepth.orgnztTySe ne 'ctrd'}">	
														<button type="button" onmousedown="javascript:fnOrgInfoRegistFrmAjax(3, '<c:out value="${twoDepth.orgnztSeq}" />','<c:out value="${twoDepth.orgnztNmKr}" />');"><spring:message code="wzwg.cmm.word.orgaddsubGrp" /></button>
													</c:if>
													
													<button type="button" onmousedown="javascript:fnOrgInfoModifyFrmAjax('<c:out value="${twoDepth.orgnztSeq}" />')"><spring:message code="wzwg.cmm.word.orgdptSet" /></button>
													<a href="javascript:void(0);" onclick="fnGetOrgInfoMemList('<c:out value="${twoDepth.orgnztSeq}" />','<c:out value="${twoDepth.orgnztNmKr}" />', '<c:out value="${twoDepth.orgnztTySe}" />');"><spring:message code="wzwg.cmm.word.orgMberSet" /></a>
												</div>
											</div>
										</div>
										
										
										<!-- 3Depth -->
										<c:forEach items="${orgnztInfoList}" var="threeDepth">
											<c:if test="${threeDepth.orgnztLv eq 3 and twoDepth.orgnztSeq eq threeDepth.parntsOrgnztSeq}" >
											<c:set var="cssClssNm" value="${fn:escapeXml(threeDepth.cssClssNm)}" />
											<ul style="clear: both; display:none;">
												<li>
													<c:choose>
														<c:when test="${threeDepth.orgnztTySe ne 'ctrd'}">
															<div class="orgDataBox dropGroup mb10 ${fn:escapeXml(cssClssNm)}" data-orgInfoSeq="<c:out value="${threeDepth.orgnztSeq }" />" style="border-color:#d9e1e8;">
														</c:when>
														<c:otherwise>
															<div class="orgDataBox dropGroupCtrd mb10 ${fn:escapeXml(cssClssNm)}" data-orgInfoSeq="<c:out value="${threeDepth.orgnztSeq }" />" data-orgnztTySe="<c:out value="${threeDepth.orgnztTySe}" />" style="border-color:#d9e1e8;">
														</c:otherwise>
													</c:choose>	

														    <div class="orgNmBox">
															    <span class="orgnztNmKr fw400 mr15 <c:if test="${fn:indexOf(threeDepth.cssClssNm, 'strong') >= 0 }">white</c:if>">
															    	<c:choose>
																    	<c:when test="${threeDepth.orgnztTySe ne 'ctrd'}">
																			<!-- <a class="<c:if test="${fn:indexOf(threeDepth.cssClssNm, 'strong') >= 0 }">white</c:if>" href="javascript:void(0);" onclick="fnGetOrgInfoMemList('<c:out value="${threeDepth.orgnztSeq}" />','<c:out value="${threeDepth.orgnztNmKr}" />', '<c:out value="${threeDepth.orgnztTySe}" />');" ><c:out value="${threeDepth.orgnztNmKr}"/></a> -->
																			<c:out value="${threeDepth.orgnztNmKr}"/>
																		</c:when>
																		<c:otherwise>
																			<!-- <a class="<c:if test="${fn:indexOf(threeDepth.cssClssNm, 'strong') >= 0 }">white</c:if>" href="javascript:void(0);" onclick="fnGetOrgInfoMemList('<c:out value="${threeDepth.orgnztSeq}" />','<c:out value="${threeDepth.orgnztNmKr}" />', '<c:out value="${threeDepth.orgnztTySe}" />');"><c:out value="${threeDepth.orgnztNmKr}"/></a> -->
																			<c:out value="${threeDepth.orgnztNmKr}"/>
																		</c:otherwise>	
																	</c:choose>
																</span>
															</div>
															
															<div class="orgBtnPop">
																<span class="btn3dot"><span class="icon"><i></i><i></i><i></i></span></span>
															    <div class="wzbtn-group">
																    <button type="button" class="btn-basic iconOnlyBtn btn-sortUp ml0" data-orgInfoSeq="<c:out value="${threeDepth.orgnztSeq}" />" onclick="fnOrgInfoOrdrChange('prev', this)" title="<spring:message code="wzwg.cmm.word.up"/>">▲</button>	    		
																    <button type="button" class="btn-basic iconOnlyBtn btn-sortDown ml0" data-orgInfoSeq="<c:out value="${threeDepth.orgnztSeq}" />" onclick="fnOrgInfoOrdrChange('next', this)" title="<spring:message code="wzwg.cmm.word.down"/>">▼</button>	    		
																	
																	<c:if test="${threeDepth.orgnztTySe ne 'ctrd'}">	
																		<button type="button" onmousedown="javascript:fnOrgInfoRegistFrmAjax(4, '<c:out value="${threeDepth.orgnztSeq}" />','<c:out value="${threeDepth.orgnztNmKr}" />');"><spring:message code="wzwg.cmm.word.orgaddsubGrp" /></button>
																	</c:if>
																	<button type="button" onmousedown="javascript:fnOrgInfoModifyFrmAjax('<c:out value="${threeDepth.orgnztSeq}" />')"><spring:message code="wzwg.cmm.word.orgdptSet" /></button>
																	<a class="<c:if test="${fn:indexOf(threeDepth.cssClssNm, 'strong') >= 0 }">white</c:if>" href="javascript:void(0);" onclick="fnGetOrgInfoMemList('<c:out value="${threeDepth.orgnztSeq}" />','<c:out value="${threeDepth.orgnztNmKr}" />', '<c:out value="${threeDepth.orgnztTySe}" />');" ><spring:message code="wzwg.cmm.word.orgMberSet" /></a>
																</div>
															</div>
														
														</div>
											       	
												       	
												    <!-- 4Depth -->   	
													<c:forEach items="${orgnztInfoList}" var="fourDepth">
														<c:if test="${fourDepth.orgnztLv eq 4 and threeDepth.orgnztSeq eq fourDepth.parntsOrgnztSeq}">
														<c:set var="cssClssNm" value="${fn:escapeXml(fourDepth.cssClssNm)}" />
														<ul style="clear: both;">	
															<li data-orgInfoSeq="<c:out value="${fourDepth.orgnztSeq }" />" style="margin-right: 0px;">
																<div class="orgDataBox wz-box br5 br-grey dropGroup mb10" data-orgInfoSeq="<c:out value="${fourDepth.orgnztSeq }" />" data-orgnztTySe="<c:out value="${fourDepth.orgnztTySe}" />" style="border-color:#2b90d9;">

																	<div class="orgNmBox">
																		<div class="colorBox ${fn:escapeXml(cssClssNm)}"></div>																			
																		<span class="orgnztNmKr fw400 mr15">
																			<!--<a class="<c:if test="${fn:indexOf(fourDepth.cssClssNm, 'strong') >= 0 }">white</c:if>" href="javascript:void(0);" onclick="fnGetOrgInfoMemList('<c:out value="${fourDepth.orgnztSeq}" />','<c:out value="${fourDepth.orgnztNmKr}" />','<c:out value="${fourDepth.orgnztTySe}" />');"><c:out value="${fourDepth.orgnztNmKr}"/></a>-->
																			<c:out value="${fourDepth.orgnztNmKr}"/>
																		</span>
																	</div>	
																	
																	<div class="orgBtnPop">
																		<span class="btn3dot"><span class="icon"><i></i><i></i><i></i></span></span>
																		<div class="wzbtn-group">
																			<button type="button" class="btn-basic iconOnlyBtn btn-sortUp ml0" data-orgInfoSeq="<c:out value="${fourDepth.orgnztSeq}" />" onclick="fnOrgInfoOrdrChange('prev', this)" title="<spring:message code="wzwg.cmm.word.up"/>">▲</button>	    		
																   			<button type="button" class="btn-basic iconOnlyBtn btn-sortDown ml0" data-orgInfoSeq="<c:out value="${fourDepth.orgnztSeq}" />" onclick="fnOrgInfoOrdrChange('next', this)" title="<spring:message code="wzwg.cmm.word.down"/>">▼</button>	 
																    			
																			<button type="button" onmousedown="javascript:fnOrgInfoModifyFrmAjax('<c:out value="${fourDepth.orgnztSeq}" />')"><spring:message code="wzwg.cmm.word.orgdptSet" /></button>
																			<a class="<c:if test="${fn:indexOf(fourDepth.cssClssNm, 'strong') >= 0 }">white</c:if>" href="javascript:void(0);" onclick="fnGetOrgInfoMemList('<c:out value="${fourDepth.orgnztSeq}" />','<c:out value="${fourDepth.orgnztNmKr}" />','<c:out value="${fourDepth.orgnztTySe}" />');"><spring:message code="wzwg.cmm.word.orgMberSet" /></a>
																		</div>
																	</div>
																
																</div>
															</li>
														</ul> 
												     	</c:if>
												     </c:forEach><!-- // 4Depth -->
												     
											     
												</li>
											</ul>
											</c:if>
										</c:forEach><!-- // 3Depth -->


									</li>
								</ul>
							   	</c:if>
							</c:forEach><!-- // 2Depth --> 
							</div>
						
						
						</li>
				    </ul>
				  	</c:if>
				</c:forEach><!-- // 1Depth -->
			
		</div>
		</td>
		</c:if>
		
	</tr>
		
			
			
		
		
		
