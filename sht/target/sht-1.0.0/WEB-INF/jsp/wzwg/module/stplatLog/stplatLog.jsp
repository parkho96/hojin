<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script type="text/javascript">
function fnDetail(stplatsimpSeq) {
    var frm = document.frmSrh;

    frm.stplatsimpSeq.value = stplatsimpSeq;
    
    $.ajax({
        type:'POST'
      , url:'<c:out value="${wzwg_contextPath}" />/module/stplatLog/selectStplatLogDetailAjax.do'
      , async : true
      , data:$("#frmSrh").serialize()
      , success:function (data) {
          $('#divDetail').html(data);
      }
      , dataType: 'html'
     });
}


function fnList() {
    var frm = document.frmSrh;
    frm.action="<c:out value="${wzwg_contextPath}" />/module/stplatLog/selectStplatLogList.do";
    frm.submit();
}

</script>

         <form name="frmSrh" id="frmSrh" method="post">
         <input type="hidden" id="stplatsimpSeq" name="stplatsimpSeq" />
         <input type="hidden" id="confmStplat" name="confmStplat" value="<c:out value="${paramVO.confmStplat}" />" />
         </form>
         
         <div class="sbscrb003">
             <div class="sbscrbBtmbox" style="margin-top:0px; float:none;">
                 <p class="sbscrbNaming"><spring:message code="wzwg.cmm.word.tmacnd" /></p>
                 <table class="sbscrbTable">
                     <colgroup>
                         <col width="25%">
                         <col width="*">
                     </colgroup>
                     <tbody>
                     
                     <c:choose>
                     <c:when test="${!empty resultList}">
                     <c:forEach items="${resultList}" var="list" varStatus="status">
                     <c:if test="${status.first}">
                     <tr>
                         <th><spring:message code="wzwg.cmm.word.stplatNm" /></th>
                         <td><c:out value="${list.stplatNm}" /></td>
                     </tr>
                     <tr>
                         <th><spring:message code="wzwg.module.word.stplatdc" /></th>
                         <td><c:out value="${list.stplatDc}" /></td>
                     </tr>
                     </c:if>
                     </c:forEach>
                     </c:when>
                     <c:otherwise>
                     <tr>
                         <td colspan="2">
                             <spring:message code="wzwg.cmm.cmmMsg.CMG014">
                                 <spring:argument><spring:message code="wzwg.cmm.word.dtartv" /></spring:argument>
                             </spring:message>
                         </td>
                     </tr>
                     </c:otherwise>
                     </c:choose>
                 </tbody></table>
                 <p class="sbscrbNaming" style="margin-top:20px;float:none;"><spring:message code="wzwg.module.word.detailstplat" /></p>
                 <div id="divDetail">
                 <table class="sbscrbTable">
                     <colgroup>
                         <col width="15%">
                         <col width="*">
                         <col width="15%">
                         <col width="35%">
                     </colgroup>
                     <tbody>
                     
                     <c:choose>
                     <c:when test="${!empty resultList}">
                     <c:forEach items="${resultList}" var="list" varStatus="status">
                     <c:if test="${status.first}">
                     <tr>
                         <th><spring:message code="wzwg.cmm.word.opertnDe" /></th>
                         <td><c:out value="${list.opertnDe}" /></td>
                         <th><spring:message code="wzwg.cmm.word.endde" /></th>
                         <td><c:out value="${list.endDe}" /></td>
                     </tr>
                     <tr>
                         <th><spring:message code="wzwg.module.word.detailstplatNm" /></th>
                         <td colspan="3"><c:out value="${list.stplatSj}" /></td>
                     </tr>
                     <tr>
                         <th><spring:message code="wzwg.module.word.stplatcn" /></th>
                         <td colspan="3"><c:out value="${list.stplatCn}" /></td>
                     </tr>
                     </c:if>
                     </c:forEach>
                     </c:when>
                     <c:otherwise>
                     <tr>
                         <td colspan="4">
                             <spring:message code="wzwg.cmm.cmmMsg.CMG014">
                                 <spring:argument><spring:message code="wzwg.cmm.word.dtartv" /></spring:argument>
                             </spring:message>
                         </td>
                     </tr>
                     </c:otherwise>
                     </c:choose>
                 </tbody></table>
                 </div>
             </div>
         </div>
         
         <div class="sbscrb005">
         <p class="sbscrbNaming"><spring:message code="wzwg.module.word.detailstplathist" /></p>
         <table class="sbscrbTable">
            <colgroup>
                <col width="20%">
                <col width="*%">
                <col width="20%">
                <col width="20%">
            </colgroup>
            <thead>
                <tr>
                    <th>No</th>
                    <th><spring:message code="wzwg.module.word.detailstplatNm" /></th>
                    <th><spring:message code="wzwg.cmm.word.opertnDe" /></th>
                    <th><spring:message code="wzwg.cmm.word.endde" /></th>
                </tr>
            </thead>
            <tbody>
            
            <c:choose>
            <c:when test="${!empty resultList}">
            <c:forEach items="${resultList}" var="list" varStatus="status">
                <tr style="cursor: pointer;" onclick="fnDetail('<c:out value="${list.stplatsimpSeq}" />'); return false;">
                    <td style="text-align:center;"><c:out value="${fn:length(resultList) - status.count + 1}" /></td>
                    <td><c:out value="${list.stplatSj}" /></td>
                    <td style="text-align:center;"><c:out value="${list.opertnDe}" /></td>
                    <td style="text-align:center;"><c:out value="${list.endDe}" /></td>
                </tr>
            </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="5">
                        <spring:message code="wzwg.cmm.cmmMsg.CMG014">
                            <spring:argument><spring:message code="wzwg.cmm.word.dtartv" /></spring:argument>
                        </spring:message>
                    </td>
                </tr>
            </c:otherwise>
            </c:choose>
             
            </tbody>
        </table>
        
        <div class="sbscrbBtnbox">
            <div class="sbscrbBtnwidth" style="max-width:100%;">
                <a href="#" class="cancelBtn" onclick="fnList(); return false;" style="float:right; padding:6px 0px; width:20%;"><spring:message code="wzwg.cmm.word.list" /></a>
            </div>
        </div>
        
        </div>
        
            
                          
