<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

                 <table class="sbscrbTable">
                     <colgroup>
                         <col width="15%">
                         <col width="*">
                         <col width="15%">
                         <col width="35%">
                     </colgroup>
                     <tbody>
                     
                     <tr>
                         <th><spring:message code="wzwg.cmm.word.opertnDe" /></th>
                         <td><c:out value="${resultVO.opertnDe}" /></td>
                         <th><spring:message code="wzwg.cmm.word.endde" /></th>
                         <td><c:out value="${resultVO.endDe}" /></td>
                     </tr>
                     <tr>
                         <th><spring:message code="wzwg.module.word.detailstplatNm" /></th>
                         <td colspan="3"><c:out value="${resultVO.stplatSj}" /></td>
                     </tr>
                     <tr>
                         <th><spring:message code="wzwg.module.word.stplatcn" /></th>
                         <td colspan="3"><c:out value="${resultVO.stplatCn}" /></td>
                     </tr>
                 </tbody></table>
