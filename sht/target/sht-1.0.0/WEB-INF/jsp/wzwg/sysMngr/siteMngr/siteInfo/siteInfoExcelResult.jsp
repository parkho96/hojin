<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
                    
					<!--//게시판 설정 table -->
					<table class="basic-table">
						<colgroup>
						<col width="5%" />
                        <col width="10%" />
                        <col width="10%" />
                        <col width="15%" />
                        <col width="10%" />
                        <col width="*" />
                        <col width="5%" />
                        <col width="5%" />
                        <col width="10%" />
						</colgroup>
						<thead>
						  <tr>
							<th><spring:message code="wzwg.cmm.word.sn" /></th>
                            <th><spring:message code="wzwg.sysMngr.word.cnfmNo" /></th>
                            <th><spring:message code="wzwg.sysMngr.word.siteNm01" />(<spring:message code="wzwg.cmm.word.title" />)</th>
                            <th>URL</th>
							<th><spring:message code="wzwg.cmm.word.telno" /></th>
							<th><spring:message code="wzwg.cmm.word.adres" /></th>
							<th><spring:message code="wzwg.sysMngr.word.siteRegistAt" /></th>
                            <th><spring:message code="wzwg.sysMngr.word.domnRegistAt" /></th>
                            <th><spring:message code="wzwg.cmm.word.rm" /></th>
						  </tr>
						</thead>
						<tbody>
                        <c:if test="${!empty resultList}">
						<c:forEach items="${resultList}" var="list" varStatus="status">
						<tr>
							<td><c:out value="${status.count}" /></td>
                            <td>
                                <c:out value="${list.C}" />
                            </td>
							<td class="txt-l">
                                <c:out value="${list.A}" />(<c:out value="${list.B}" />)
                            </td>
                            <td class="txt-l">
                                <c:out value="${list.H}" />
                            </td>
							<td>
                                <c:out value="${list.G}" />
                            </td>
							<td class="txt-l">(<c:out value="${list.D}" />) <c:out value="${list.E}" /> <c:out value="${list.F}" /></td>
							<td>
                                <c:choose>
                                <c:when test="${fn:indexOf(list.siteInfoResult, 'ERROR') > -1}"><spring:message code="wzwg.cmm.word.error" /></c:when>
                                <c:otherwise>
                                <c:if test="${list.siteInfoResult eq '1'}"><spring:message code="wzwg.cmm.word.compt" /></c:if>
                                <c:if test="${list.siteInfoResult eq '0'}"><spring:message code="wzwg.cmm.word.failr" /></c:if>
                                </c:otherwise>
                                </c:choose>
                            </td>
							<td>
                                <c:choose>
                                <c:when test="${fn:indexOf(list.siteInfoResult, 'ERROR') > -1}"><spring:message code="wzwg.cmm.word.error" /></c:when>
                                <c:otherwise>
                                <c:if test="${list.siteInfoResult eq '1'}"><spring:message code="wzwg.cmm.word.compt" /></c:if>
                                <c:if test="${list.siteInfoResult eq '0'}"><spring:message code="wzwg.cmm.word.failr" /></c:if>
                                </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                            	<c:set var="msg_txt01">
									<spring:message code="wzwg.cmm.cmmMsg.CMG011">
										<spring:argument><spring:message code="wzwg.cmm.word.domn" /></spring:argument>
										<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
									</spring:message>
								</c:set>
                                <c:if test="${list.siteInfoResult eq 'DOMN_ERROR'}"><c:out value="${msg_txt01}" /></c:if>
                                
                                <c:set var="msg_txt02">
									<spring:message code="wzwg.cmm.cmmMsg.CMG011">
										<spring:argument><spring:message code="wzwg.sysMngr.word.cnfmNo" /></spring:argument>
										<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
									</spring:message>
								</c:set>
                                <c:if test="${list.siteInfoResult eq 'ACCNO_ERROR'}"><c:out value="${msg_txt02}" /></c:if>
                                <c:if test="${list.siteInfoResult eq 'DOMN_CNT_ERROR'}"><spring:message code="wzwg.cmm.msg.MSG207" /></c:if>
                                <c:if test="${list.siteInfoResult eq 'ACCNO_CNT_ERROR'}"><spring:message code="wzwg.cmm.msg.MSG208" /></c:if>
                            </td>
						</tr>
						</c:forEach>
                        </c:if>
						</tbody>
					</table>
					  
