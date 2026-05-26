<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
                    
                  <h3 class="wzAdmSTit  wd100 fl"><spring:message code="wzwg.cmm.word.groupLinkList"/></h3>
                  <table class="basic-table">
                    <colgroup>
                        <col width="5%" />
                        <col width="15%" />
                        <col width="*" />
                        <col width="15%" />
                        <col width="12%" />
                    </colgroup>
                    <thead>
                      <tr class="bg-white">
                        <th><ul class="wzForm"><li><label><input type="checkbox" id="checkAll" name="checkAll" class="checkall" onclick="javascript:fnCheckAll();" /><span class="spanLabel"></span></label></li></ul></th>
                        <th><spring:message code="wzwg.site.menu.msg.MSG010" /></th>
                        <th><spring:message code="wzwg.cmm.word.url" /></th>
                        <th><spring:message code="wzwg.cmm.word.sort" /></th>
                        <th><spring:message code="wzwg.cmm.word.rgsde" /></th>
                      </tr>
                    </thead>
                    <tbody>
                    <c:if test="${empty resultList}">
                    <tr>
                        <td colspan="5">
                            <spring:message code="wzwg.cmm.cmmMsg.CMG014">
                                <spring:argument><spring:message code="wzwg.cmm.word.dtartv" /></spring:argument>
                            </spring:message>
                        </td>
                    </tr>
                    </c:if>
                    <c:forEach items="${resultList}" var="result" varStatus="status">
                    <tr>
                        <td><ul class="wzForm"><li><label><input type="checkbox" id="linkSeqArr" name="linkSeqArr" value="<c:out value="${result.linkSeq}"/>" /><span class="spanLabel"></span></label></li></ul></td>
                        <td><c:out value="${result.linkNm}" /></td>
                        <td><c:out value="${result.linkUrl}" /></td>
                        <td class="linkSortBtns">
                        	<button class="btn-basic iconOnlyBtn btn-sortUp" onclick="fnSiteLinkGrpOrdr('U','<c:out value="${result.linkSeq}"/>','<c:out value="${result.ordr}"/>')" title="<spring:message code="wzwg.cmm.word.up"/>">▲</button>
							<button class="btn-basic iconOnlyBtn btn-sortDown" onclick="fnSiteLinkGrpOrdr('D','<c:out value="${result.linkSeq}"/>','<c:out value="${result.ordr}"/>')" title="<spring:message code="wzwg.cmm.word.down"/>">▼</button>
                        </td>
                        <td><c:out value="${result.frstRegistPnttm}" /></td>
<!--                         <td> -->
<%--                             <c:if test="${not status.first }"> --%>
<%--                                 <a href="javascript:void(0);" onclick="fn_ordrChange('<c:out value="${result.linkSeq}"/>','<c:out value="${result.ordr}"/>');"><img src="/images/wzwg/module/qustnr/ordr_up.gif"/></a> --%>
<%--                             </c:if> --%>
<%--                             <c:if test="${not status.last }"> --%>
<%--                                 <a href="javascript:void(0);" onclick="fn_ordrChange('<c:out value="${result.linkSeq}"/>','<c:out value="${result.ordr}"/>');"><img src="/images/wzwg/module/qustnr/ordr_down.gif"/></a> --%>
<%--                             </c:if> --%>
<!--                         </td> -->
                    </tr>
                    </c:forEach>
                    </tbody>
                  </table>
