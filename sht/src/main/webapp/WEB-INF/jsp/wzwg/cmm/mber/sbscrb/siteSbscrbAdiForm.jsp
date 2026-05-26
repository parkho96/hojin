<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<c:if test="${!empty qesitmList}">
<c:if test="${fn:indexOf(prefix, '/mngr') == -1 }">
<p class="sbscrbNaming"><spring:message code="wzwg.cmm.word.adiinfo" />
<span><spring:message code="wzwg.cmm.msg.MSG073" /> <c:out value="${prefix}" /></span></p>
</c:if>
<table class="sbscrbTable basic" id="sbscrbSiteArea">
<colgroup>
    <col width="20%">
     <col width="80%">
</colgroup>
<c:forEach var="qesitmList" items="${qesitmList}" varStatus="qesitmStatus">     
<tr>
    <th scope="row">
        <input type="hidden" id="sbscrbinfoSeq<c:out value="${qesitmStatus.index + 1}" />" name="sbscrbinfoSeq" value="<c:out value="${qesitmList.sbscrbinfoSeq}" />" />
        
        	<c:if test="${paramVO.frmGubun eq 'M'}"><c:set var="labeltarget" value="sbscrbrspns${qesitmStatus.index + 1}" /></c:if>
        	<c:if test="${qesitmList.qesitmSe eq 'S'}"><c:set var="labeltarget" value="sbjctRspns${qesitmStatus.index + 1}" /></c:if>
        	<c:if test="${qesitmList.qesitmSe eq 'O'}"><c:set var="labeltarget" value="sbscrbiemSeq${qesitmStatus.index + 1}" /></c:if>
        
        <label for="<c:out value="${labeltarget}" />"><c:out value="${qesitmList.qesitmSj}" /></label>
    </th>
    <td>
        <input type="hidden" id="qesitmSe<c:out value="${qesitmStatus.index + 1}" />" name="qesitmSe" value="<c:out value="${qesitmList.qesitmSe}" />" />
        <input type="hidden" id="qesitmSeq<c:out value="${qesitmStatus.index + 1}" />" name="qesitmSeq" value="<c:out value="${qesitmList.sbscrbqesitmSeq}" />" />
        <c:if test="${paramVO.frmGubun eq 'M'}">
        <input type="hidden" id="sbscrbrspns<c:out value="${qesitmStatus.index + 1}" />" name="sbscrbrspns" value="<c:out value="${qesitmList.sbscrbrspns}" />" />
        </c:if>                        
        <c:if test="${qesitmList.qesitmSe eq 'S'}">
            <textarea id="sbjctRspns<c:out value="${qesitmStatus.index + 1}" />" name="sbjctRspns" rows="3" style="resize:none;"><c:out value="${qesitmList.rspnsVal}" /></textarea>                                          
        </c:if>
        <c:if test="${qesitmList.qesitmSe eq 'O'}">
            <c:if test="${!empty iemList}">
            <ul class="wzForm">
                <c:forEach var="iemList" items="${iemList}" varStatus="iemStatus">
                <c:if test="${qesitmList.sbscrbqesitmSeq eq iemList.sbscrbqesitmSeq}">
                   <li class="pr10">
                        <input type="radio" id="sbscrbiemSeq<c:out value="${iemList.sbscrbiemSeq}" />" name="sbscrbiemSeq<c:out value="${qesitmStatus.index + 1}" />" value="<c:out value="${iemList.sbscrbiemSeq}" />" <c:if test="${iemList.sbscrbiemSeq eq qesitmList.sbscrbiemSeq}">checked</c:if> />
                        <label for="sbscrbiemSeq<c:out value="${iemList.sbscrbiemSeq}" />"><c:out value="${iemList.iemSj}" /></label>
                    </li>
                </c:if>
                </c:forEach>
            </ul>
            </c:if>
        </c:if>
        <c:if test="${qesitmStatus.last}"><br /></c:if>
    </td>
</tr>
</c:forEach>
</table>
<style>
    .joinUs_box table.basic {border-top:none;}
    .joinUs_box table.basic:not(:last-of-type) {margin-bottom:0;}
    .joinUs_box table.basic td textarea {height:auto;}
    .joinUs_box table.basic th, .joinUs_box table.basic td {border-width:0 0 1px 0;border-bottom-color: #e5e5e5;}
    @media (max-width:899px){
        .joinUs_box table.basic th {border-bottom:none;} 
        .joinUs_box table.basic td {float:left;}
        #usrTyCode + span {display:inline-block; margin-top:0; margin-right:8px;}
    }
</style>
</c:if>   
