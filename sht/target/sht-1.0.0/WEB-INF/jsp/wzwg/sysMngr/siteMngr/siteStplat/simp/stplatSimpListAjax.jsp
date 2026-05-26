<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
                    
                  <table class="basic-table">
                    <colgroup>
                        <col width="5%" />
                        <col width="5%" />
                        <col width="*" />
                        <col width="15%" />
                        <col width="15%" />
                        <col width="15%" />
                        <col width="10%" />
                    </colgroup>
                    <thead>
                      <tr class="bg-white">
                        <th><ul class="wzForm"><li><label><input type="checkbox" id="checkAll" name="checkAll" class="checkall" onclick="javascript:fnCheckAll();" /><span class="spanLabel"></span></label></li></ul></th>
                        <th>No</th>
                        <th><spring:message code="wzwg.sysMngr.word.detail02StplatSj" /></th>
                        <th><spring:message code="wzwg.cmm.word.opertnDe" /></th>
                        <th><spring:message code="wzwg.cmm.word.endde" /></th>
                        <th><spring:message code="wzwg.cmm.word.rgsde" /></th>
                        <th><spring:message code="wzwg.cmm.word.manage" /></th>
                      </tr>
                    </thead>
                    <tbody>
                    <c:if test="${empty resultList}">
                    <input type="hidden" id="lastRegistOpertnDe" value=""/>
                    <tr>
                        <td colspan="7">
                        <spring:message code="wzwg.cmm.cmmMsg.CMG014">
                            <spring:argument><spring:message code="wzwg.cmm.word.dtartv" /></spring:argument>
                        </spring:message>
                        </td>
                    </tr>
                    </c:if>
                    <c:forEach items="${resultList}" var="list" varStatus="status">
                    <c:if test="${status.first }">
                    	<input type="hidden" id="lastRegistOpertnDe" value="<c:out value="${list.opertnDe }" />"/>
                    </c:if>
                    <tr>
                        <td><ul class="wzForm"><li><label><input type="checkbox" id="stplatsimpSeqArr" name="stplatsimpSeqArr" value="<c:out value="${list.stplatsimpSeq}" />" /><span class="spanLabel"></span></label></li></ul></td>
                        <td><c:out value="${(fn:length(resultList) - status.count) + 1}" /></td>
                        <td><c:out value="${list.stplatSj}" /></td>
                        <td><c:out value="${list.opertnDe}" /></td>
                        <td><c:out value="${list.endDe}" /></td>
                        <td><c:out value="${list.frstRegistPnttm}" /></td>
                        <td><a href="javascript:void(0);" onclick="fnStplatsimpDetail('<c:out value="${list.stplatsimpSeq}" />');" class="iconOnlyBtn btn-basic btn-modify" title="<spring:message code="wzwg.cmm.word.updt" />"><spring:message code="wzwg.cmm.word.updt" /></a></td>
                    </tr>
                    </c:forEach>
                    </tbody>
                  </table>
