<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
 
		<c:if test="${not empty resultVO.bbsPrface}">
		<div class="mb30">
			<c:out value='${fn:replace(resultVO.bbsPrface, cn, "<br />")}' escapeXml="false" />
		</div>
		</c:if>
			 
			<%-- <c:set var="tableCss" value="basic-table02 txt-c"/>
			<c:if test="${paramVO.mngrAt eq 'N'}">
				<c:set var="tableCss" value="basic-table01"/>
			</c:if>		 --%>	
			
			<c:set var="tableCss" value="basic-table01"/>
				
			
			<c:set var="expsrAtNoAt" value="N"/>
			<c:set var="expsrAtWrtrAt" value="N"/>
			<c:set var="expsrAtRgsdAt" value="N"/>
			<c:set var="expsrAtIngrAt" value="N"/>
			
			<c:forEach items="${fn:split(resultVO.expsrAt, ',')}" var="expsrArr">
				<c:choose>
					<c:when test="${expsrArr eq 'N'}"><c:set var="expsrAtNoAt" value="Y"/></c:when>
					<c:when test="${expsrArr eq 'W'}"><c:set var="expsrAtWrtrAt" value="Y"/></c:when>
					<c:when test="${expsrArr eq 'R'}"><c:set var="expsrAtRgsdAt" value="Y"/></c:when>
					<c:when test="${expsrArr eq 'I'}"><c:set var="expsrAtIngrAt" value="Y"/></c:when>
					<c:otherwise></c:otherwise>
				</c:choose>
	    	</c:forEach>


			<table class="<c:out value='${tableCss}'/>" id="div-exceldown-table">
				  <colgroup>
					<c:if test="${adminAuthAt eq 'Y'}">
						<col width="5%"/>						
					</c:if>
					<c:if test="${mobileAt eq 'N'}">
						<col width="10%"/>
						<c:forEach items="${fieldList }" var="list">
							<c:if test="${list.listAt eq 'Y' and list.useAt eq 'Y'}">
							<col width="*"/>
							</c:if>
						</c:forEach>
						<col width="10%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="10%"/>
					</c:if>
					<c:if test="${mobileAt eq 'Y'}">
						<c:forEach items="${fieldList }" var="list">
							<c:if test="${list.listAt eq 'Y' and list.useAt eq 'Y'}">
							<col width="*"/>
							</c:if>
						</c:forEach>
						<col width="20%"/>
						<col width="20%"/>
					</c:if>
			      </colgroup>
				  <thead>
					<tr>
						<c:if test="${adminAuthAt eq 'Y'}">
							<th><input type="checkbox" name="nttAllChk" id="nttAllChk" /></th>					
						</c:if>
						<c:if test="${mobileAt eq 'N' and expsrAtNoAt eq 'Y'}">
							<th><span><spring:message code="wzwg.cmm.word.no" /></span></th>
						</c:if>
						<c:forEach items="${fieldList }" var="list">
							<c:if test="${list.listAt eq 'Y' and list.useAt eq 'Y'}">
							<th><span><c:out value="${list.fieldNm }"/></span></th>
							</c:if>
						</c:forEach>
						<!-- <th><span><spring:message code="wzwg.cmm.word.sj" /></span></th> -->
						<c:if test="${expsrAtWrtrAt eq 'Y' }">
							<th><span><spring:message code="wzwg.cmm.word.wrter" /></span></th>
						</c:if>
						<c:if test="${expsrAtRgsdAt eq 'Y' }">
						<th>
						<c:if test="${funcVO.usrScrinTy eq 'W'}">
							<span>	<spring:message code="wzwg.cmm.word.rgsde02" /> </span>
						</c:if>
						<c:if test="${funcVO.usrScrinTy ne 'W'}">
							<span id="frstRegistPnttm_asc"><spring:message code="wzwg.cmm.word.rgsde02" /></span>
						</c:if>
						</th>
						</c:if>
						<c:if test="${mobileAt eq 'N' and expsrAtIngrAt eq 'Y'}">
							<th>
							<c:if test="${funcVO.usrScrinTy eq 'W'}">
							<span><spring:message code="wzwg.cmm.word.inqire" /> </span>
							</c:if>
							<c:if test="${funcVO.usrScrinTy ne 'W'}">
								<span id="inqireCnt_asc"><spring:message code="wzwg.cmm.word.inqire" /></span>
							</c:if>
							</th>
						</c:if>
					</tr>
					
					<script type="text/javascript">
						var showAt = "N";
						function fnShowHeadListLayer() {
							if(showAt == "N") {
								showAt = "Y";
								$('#headListLayer').show();
							} else {
								showAt = "N";
								$('#headListLayer').hide();
							}
						}
					</script>
								
					<div class="ly_sbjt" id="headListLayer" style="left:12px;top:23px;display:none;z-index:1000;">
						<c:if test="${!empty subospecList}">
							<ul> 
							<li><a href="javascript:void(0);" onclick="fnSubospecSelect('');"><span><spring:message code="wzwg.module.word.allview" /></span></a></li>
							<c:forEach var="subospecList" items="${subospecList}" varStatus="status">
								<li><a href="javascript:void(0);" onclick="fnSubospecSelect('<c:out value="${subospecList.subospecSeq}"/>');"><span><c:out value="${subospecList.subospecSj}"/></span></a></li>
							</c:forEach>
							</ul>										
						</c:if>
					</div>							
					
			      </thead>
				  <tbody>
	
					<!-- 공지 게시물 목록 -->
					<c:if test="${!empty noticeList && (paramVO.subospecSeq eq null or paramVO.subospecSeq eq '')}">
						<c:forEach var="noticeList" items="${noticeList}" varStatus="status">		
						
						<c:set var="noticeDetAuthAt" value="" />
						
						<c:if test="${loginVO.usrSeq eq noticeList.ntcrSeq or nttAuthVO.authorSe eq 'R' or nttAuthVO.authorSe eq 'W' or adminAuthAt eq 'Y' or cmntAuthR eq 'Y' or cmntAuthW eq 'Y'}">
							<c:set var="noticeDetAuthAt" value="Y" />
						</c:if>							
											
						<tr id="noti-row-excel-${noticeList.nttSeq}" data-fileid="${noticeList.atchFileId}" >
							<c:if test="${adminAuthAt eq 'Y'}">
								<td>
									<a title="<spring:message code="wzwg.cmm.word.notice01" /> <spring:message code="wzwg.module.word.postsdelete" />" href="javascript:void(0);" onclick="fnDelNotice('<c:out value="${noticeList.nttSeq}"/>');">
										<img class="icoCenter" src="/images/wzwg/cmm/btn-del.gif" alt="<spring:message code="wzwg.module.word.deleteicon" />" />
									</a>
								</td>				
							</c:if>
			
							<c:if test="${mobileAt eq 'N' and expsrAtNoAt eq 'Y'}">
			
							<td><img class="icoCenter" src="/images/wzwg/module/ntt/icoNotice.png" alt="<spring:message code="wzwg.cmm.word.notice02" />" /></td>
							
							</c:if>
							
							<%-- 커스텀 필드세팅 --%>
							<c:forEach items="${fieldList }" var="list">
								<%-- <spring:message code="wzwg.cmm.word.sj" /> 필드일 경우 --%>
								<c:if test="${list.listAt eq 'Y' and list.useAt eq 'Y' and list.fieldTy eq 'title'}">
								<td class="txt-l">
									<c:choose>
										<c:when test="${!empty noticeList.nttSj}">
											<c:if test="${fn:length(noticeList.nttSj) > 43}">
												<c:set var="nttSj" value="${fn:substring(noticeList.nttSj, 0, 43)}..." />
											</c:if>
											<c:if test="${fn:length(noticeList.nttSj) < 44}">
												<c:set var="nttSj" value="${noticeList.nttSj}" />
											</c:if>
										</c:when>
										<c:otherwise>
											<c:set var="nttSj"><spring:message code="wzwg.cmm.word.untitle"/></c:set>
										</c:otherwise>
									</c:choose>		
									
									<c:if test="${!empty noticeList.subospecSj}">
										<span class="red fw900">[<c:out value="${noticeList.subospecSj}"/>]</span>
									</c:if>
									
									<c:if test="${noticeList.secretAt eq 'Y'}">
										<img src="/images/wzwg/module/ntt/ico-secret.png" alt="<spring:message code="wzwg.module.word.secretposts" />" />
									</c:if>
									
									<c:choose>
										<c:when test="${noticeDetAuthAt eq 'Y'}">
											<a href="javascript:void(0);" class="notice_p" onclick="fnView('<c:out value="${noticeList.nttSeq}"/>', '<c:out value="${noticeList.ntcrId}"/>', '<c:out value="${noticeList.secretAt}"/>', '<c:out value="${noticeList.parntsNttSeq}"/>');"><c:out value="${nttSj}"/></a>
											<c:if test="${noticeList.answerCnt > 0}">
													<span class="colorRed">[<c:out value="${noticeList.answerCnt}"/>]</span>
											</c:if>							
										</c:when>
										<c:otherwise>
											<a href="javascript:void(0);" class="notice_p" onclick="alert('<spring:message code="wzwg.cmm.msg.MSG084" />');"><c:out value="${nttSj}"/></a>
											<c:if test="${noticeList.answerCnt > 0}">
												<a href="javascript:void(0);" onclick="alert('<spring:message code="wzwg.cmm.msg.MSG084" />');">
													<span class="colorRed">[<c:out value="${noticeList.answerCnt}"/>]</span>
												</a>
											</c:if>								
										</c:otherwise>
									</c:choose>
									
									<c:if test="${noticeList.atchFileCnt ne '0'}">
										<img src="/images/wzwg/module/ntt/ico-file.gif" />
									</c:if>
								</td>
								</c:if>
								
								<%-- <spring:message code="wzwg.cmm.word.sj" /> 필드가 아닌경우 --%>
								<c:if test="${list.listAt eq 'Y' and list.useAt eq 'Y' and list.fieldTy ne 'title'}">
								<td data-nm="${list.fieldNm }" data-id="${list.fieldId}" data-ty="${list.fieldTy }">
									
								</td>
								</c:if>
							</c:forEach>
							<c:if test="${expsrAtWrtrAt eq 'Y' }">
								<td><spring:message code="wzwg.cmm.word.mngr" /></td>
							</c:if>
							<c:if test="${expsrAtRgsdAt eq 'Y' }">
							<td><c:out value="${noticeList.frstRegistPnttm}"/></td>
							</c:if>
							
							<c:if test="${mobileAt eq 'N' and expsrAtIngrAt eq 'Y'}">
							
							<td><c:out value="${noticeList.inqireCnt}"/></td>
							</c:if>
						</tr>
									
									
								<%-- 인터넷에서 어디 이상한놈이 해놓은거 잘됨 --%>
								<c:set var="myContent"><c:out value='${noticeList.nttCn}'/></c:set>
							    <c:set var="singlequote" value="'"/>
							    <c:set var="backslash" value="\\"/>
							    <c:if test="${fn:contains(myContent, singlequote) && !fn:contains(myContent,backslash)}">
							            <c:set var="search" value="'" />
							            <c:set var="replace" value="&apos;" />
							            <c:set var="myContent" value="${fn:replace(myContent, search, replace)}"/>
							    </c:if>
							    <c:if test="${fn:contains(myContent, backslash) && !fn:contains(myContent,singlequote)}">
							            <c:set var="search" value="\\" />
							            <c:set var="replace" value="\\\\" />
							            <c:set var="myContent" value="${fn:replace(myContent, search, replace)}"/>
							    </c:if>
							    <c:if test="${fn:contains(myContent, singlequote) && fn:contains(myContent,backslash)}">
							            <c:set var="search" value="\\"/>
							            <c:set var="replace" value="\\\\" />
							            <c:set var="myContent" value="${fn:replace(myContent, search, replace)}"/>
							            <c:set var="find" value="'"/>
							            <c:set var="change" value="\\'" />
							            <c:set var="myContent" value="${fn:replace(myContent, find, change)}"/>
							    </c:if>
								
								<script class="customScript">
								ntDataExcel.push('<c:out value="${myContent}"/>');
								</script>
						</c:forEach>
					</c:if>		<%-- 공지사항 끝 --%>		  
				  
					<c:if test="${!empty resultList}">
			
						<c:forEach var="resultList" items="${resultList}" varStatus="status">		
						
						<c:set var="listDetAuthAt" value="" />	
						
						<c:if test="${loginVO.usrSeq eq resultList.ntcrSeq or nttAuthVO.authorSe eq 'R' or nttAuthVO.authorSe eq 'W' or adminAuthAt eq 'Y' or cmntAuthR eq 'Y' or cmntAuthW eq 'Y'}">
							<c:set var="listDetAuthAt" value="Y" />
						</c:if>									
						
						<c:choose>
							<c:when test="${listDetAuthAt eq 'Y'}">
								<c:set var="trClick">fnView('<c:out value="${resultList.nttSeq}"/>', '<c:out value="${resultList.ntcrId}"/>', '<c:out value="${resultList.secretAt}"/>', '<c:out value="${resultList.parntsNttSeq}"/>');</c:set>
							</c:when>
							<c:otherwise>
								<c:set var="trClick">alert('<spring:message code="wzwg.cmm.msg.MSG084" />');</c:set>
							</c:otherwise>
						</c:choose>
							<c:if test="${funcVO.nolognAt eq 'Y' and adminAuthAt ne 'Y'}">
								<c:set var="trPwChk">passwordPoopupOpen('<c:out value="${resultList.nttSeq}"/>');</c:set>
							</c:if>
						
						<%-- <tr id="row-excel-${resultList.nttSeq}" onclick="${trClick}" style="cursor: pointer;"> --%>
						<tr id="row-excel-${resultList.nttSeq}" data-click="${trClick}" data-pwchk="${trPwChk}" data-fileid="${resultList.atchFileId}" style="cursor: pointer;">
							
							<c:if test="${adminAuthAt eq 'Y'}">
								<td><input type="checkbox" name="nttChk" value="${resultList.nttSeq}" /></td>				
							</c:if>						
			
							<c:if test="${mobileAt eq 'N' and expsrAtNoAt eq 'Y'}">
		
							<td>
							<c:choose>
								<c:when test="${resultVO.listNumCode eq 'P'}">
									<c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.recordCountPerPage + status.count) + 1}"/>
								</c:when>
								<c:otherwise>
									<c:out value="${resultList.nttSeq}"/>
								</c:otherwise>
							</c:choose>
							</td>
							
							</c:if>
							
							<%-- 커스텀 필드세팅 --%>
							<c:forEach items="${fieldList }" var="list">
								<%-- <spring:message code="wzwg.cmm.word.sj" /> 필드일 경우 --%>
								<c:if test="${list.listAt eq 'Y' and list.useAt eq 'Y' and list.fieldTy eq 'title'}">
								<td class="txt-l">
										<c:choose>
											<c:when test="${!empty resultList.nttSj}">
												<c:if test="${fn:length(resultList.nttSj) > 43}">
													<c:set var="nttSj" value="${fn:substring(resultList.nttSj, 0, 43)}..." />
												</c:if>
												<c:if test="${fn:length(resultList.nttSj) < 44}">
													<c:set var="nttSj" value="${resultList.nttSj}" />
												</c:if>
											</c:when>
											<c:otherwise>
												<c:set var="nttSj"><spring:message code="wzwg.cmm.word.untitle"/></c:set>
											</c:otherwise>
										</c:choose>
								
										<c:if test="${resultList.lv > 1}">
											<c:set var="pd_reply_class" value="${(10 * resultList.lv) - 10}" />
											<img src="/images/wzwg/module/ntt/icoReply.png" style="margin-left:${pd_reply_class}px;" alt="<spring:message code="wzwg.cmm.word.answer03" />" />
										</c:if>
									
										<c:if test="${!empty resultList.subospecSj}">
											<span>[<c:out value="${resultList.subospecSj}"/>]</span>
										</c:if>
										
										<c:if test="${resultList.secretAt eq 'Y'}">
											<img src="/images/wzwg/module/ntt/ico-secret.png" alt="<spring:message code="wzwg.module.word.secretposts" />" />
										</c:if>
									
										<c:choose>
											<c:when test="${listDetAuthAt eq 'Y'}">
												<%-- <a href="javascript:void(0);" onclick="fnView('${resultList.nttSeq}', '${resultList.ntcrId}', '${resultList.secretAt}', '${resultList.parntsNttSeq}');">${nttSj}</a> --%>
												<c:out value="${nttSj}"/>							
												<c:if test="${resultList.answerCnt > 0}">
													<span class="colorRed">[<c:out value="${resultList.answerCnt}"/>]</span>
												</c:if>					
											</c:when>
											<c:otherwise>
												<a href="javascript:void(0);" onclick="alert('<spring:message code="wzwg.cmm.msg.MSG084" />');"><c:out value="${nttSj}"/></a>							
												<c:if test="${resultList.answerCnt > 0}">
													<a href="javascript:void(0);" onclick="alert('<spring:message code="wzwg.cmm.msg.MSG084" />');">
														<span class="colorRed">[<c:out value="${resultList.answerCnt}"/>]</span>
													</a>								
												</c:if>							
											</c:otherwise>
										</c:choose>	
										
										<c:if test="${resultList.nttNew eq 'Y'}">
											<img src="/images/wzwg/module/ntt/new.png" />
										</c:if>
										
										<c:if test="${resultList.atchFileCnt ne '0'}">
											<img src="/images/wzwg/module/ntt/ico-file.gif" />
										</c:if>	
								</td>
								</c:if>
								
								<%-- <spring:message code="wzwg.cmm.word.sj" /> 필드가 아닌경우 --%>
								<c:if test="${list.listAt eq 'Y' and list.useAt eq 'Y' and list.fieldTy ne 'title'}">
								<td data-nm="${list.fieldNm }" data-id="${list.fieldId}" data-ty="${list.fieldTy }">
									
								</td>
								</c:if>
							</c:forEach>
							
							<c:if test="${expsrAtWrtrAt eq 'Y' }">
								<td>
									<c:if test="${resultList.annymtyAt eq 'Y'}"><spring:message code="wzwg.cmm.word.annymty" /></c:if>
									<c:if test="${resultList.annymtyAt ne 'Y'}"><c:out value="${resultList.ntcrNm}"/></c:if>							
								</td>
							</c:if>
							<c:if test="${expsrAtRgsdAt eq 'Y' }">
								<td><c:out value="${resultList.frstRegistPnttm}"/></td>
							</c:if>
							
							<c:if test="${mobileAt eq 'N' and expsrAtIngrAt eq 'Y'}">
								<td><c:out value="${resultList.inqireCnt}"/></td>
							</c:if>
							
						</tr>	
						<%-- <c:set var="squot">'</c:set>
						<c:set var="afterSquot">\'</c:set>
						<c:set var="pushdata">${fn:replace(resultList.nttCn, '\\"', '\\\\"')}</c:set>
						<c:set var="pushdata">${fn:replace(pushdata, squot, afterSquot)}</c:set>
						<c:set var="pushdata">${fn:replace(pushdata, '\\', '\\\\')}</c:set> --%>
						<%-- 인터넷에서 어디 이상한놈이 해놓은거 잘됨 --%>
						<c:set var="myContent" value="${resultList.nttCn}"/>
					    <c:set var="singlequote" value="'"/>
					    <c:set var="backslash" value="\\"/>
					    <c:if test="${fn:contains(myContent, singlequote) && !fn:contains(myContent,backslash)}">
					            <c:set var="search" value="'" />
					            <c:set var="replace" value="\\'" />
					            <c:set var="myContent" value="${fn:replace(myContent, search, replace)}"/>
					    </c:if>
					    <c:if test="${fn:contains(myContent, backslash) && !fn:contains(myContent,singlequote)}">
					            <c:set var="search" value="\\" />
					            <c:set var="replace" value="\\\\" />
					            <c:set var="myContent" value="${fn:replace(myContent, search, replace)}"/>
					    </c:if>
					    <c:if test="${fn:contains(myContent, singlequote) && fn:contains(myContent,backslash)}">
					            <c:set var="search" value="\\"/>
					            <c:set var="replace" value="\\\\" />
					            <c:set var="myContent" value="${fn:replace(myContent, search, replace)}"/>
					            <c:set var="find" value="'"/>
					            <c:set var="change" value="\\'" />
					            <c:set var="myContent" value="${fn:replace(myContent, find, change)}"/>
					    </c:if>
						
						<script class="customScript">
						ctDataExcel.push('<c:out value="${myContent}"/>');
						</script>
						</c:forEach>
					</c:if>		
					
					<c:set var="colCnt" value="6" />
					<c:if test="${adminAuthAt eq 'Y'}">
						<c:set var="colCnt" value="7" />
					</c:if>
					
					<c:if test="${mobileAt eq 'Y'}">
						<c:set var="colCnt" value="${colCnt - 2}" />
				 	</c:if>
							
					<c:set var="colCnt" value="${colCnt - 1}" /><%-- 기존 <spring:message code="wzwg.cmm.word.sj" /> 칸수 제거 --%>
					<c:forEach items="${fieldList }" var="list">
						<c:if test="${list.listAt eq 'Y' and list.useAt eq 'Y' }">
						<c:set var="colCnt" value="${colCnt + 1}" />
						</c:if>
					</c:forEach>
					<c:if test="${empty resultList}">
						<tr>
							<td colspan="${colCnt}"><spring:message code="wzwg.cmm.msg.MSG085" /></td>
						</tr>
					</c:if>	

				  </tbody>
			</table>
			<!-- 
			<div id="password_popup" style="position: absolute; top: 0; left: 0; height:100%; width:100%; background: rgba(50,50,50, 0.25); display:none;">
				<div style="border: solid 1px #f1f1f1; border-radius: 4px; margin: 10%; background: #fff;">
					<div><spring:message code="wzwg.cmm.word.password" /> <spring:message code="wzwg.cmm.word.input" /> <span onclick="passwordPopupClose()">X</span></div>
					<div>
						<input type="password" id="pwPassword">
						<input type="hidden" id="selectTrId">
					</div>
					<div><button type="button"><spring:message code="wzwg.cmm.word.cancl" /></button><button type="button" onclick="passwordCheckAction()"><spring:message code="wzwg.cmm.word.cnfirm" /></button></div>
				</div>
			</div>
 -->
	 
			 	
			
	
		<c:if test="${not empty resultVO.bbsCnclsn}">
		<div class="mt30">
			<c:out value='${fn:replace(resultVO.bbsCnclsn, cn, "<br />")}' escapeXml="false" />
		</div>
		</c:if>

		
		<script>
		customDataParseExcel();
		</script>