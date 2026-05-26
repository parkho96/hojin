<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

				<table class="basic-table">
				<caption><spring:message code="wzwg.site.cntnts.msg.MSG003" /></caption>
				<colgroup>
					<col width="5%"/>
                    <col width="20%"/>
                    <col width="20%"/>
                    <col width="20%"/>
                    <col width="*"/>
				</colgroup>
				<thead>
				<tr>
					<th class="ta_c">No</th>
                    <th><spring:message code="wzwg.cmm.word.id02" /></th>
                    <th><spring:message code="wzwg.cmm.word.nm02" /></th>
                    <th><spring:message code="wzwg.site.cntnts.msg.MSG004" /></th>
                    <th><spring:message code="wzwg.cmm.word.rm" /></th>
				</tr>
				</thead>
				
				<tbody>
				<c:if test="${!empty resultList}">
				<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
                    <td><c:out value="${fn:length(resultList)-status.count+1}" /></td>
                    <td class="tdUsrId"><c:out value="${result.usrId}" /></td>
                    <td><c:out value="${result.usrNm}" /></td>
                    <td><c:out value="${result.frstRegistPnttm}" /></td>
                    <td><a href="javascript:void(0);" onclick="javascript:fnDelete('<c:out value="${result.cntntschrgSeq}"/>');"><span class="iconOnlyBtn btn-basic btn-delete" title="<spring:message code="wzwg.cmm.word.delete" />"><spring:message code="wzwg.cmm.word.delete" /></span></a></td>
				</tr>
				</c:forEach>
				</c:if>
				<c:if test="${empty resultList}">
					<tr>
						<td colspan="5"><spring:message code="wzwg.cmm.msg.MSG246" /></td>
					</tr> 	
				</c:if>
				</tbody>
				</table>
