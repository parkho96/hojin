<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
$(document).ready(function() {

    <c:if test="${!empty message}">
    alert('<spring:message code="${message}" />');
    </c:if>
    
   $('#crtfc_btn').click(function() {
       fnCrtfc();
   }); 
});

function fnCrtfc() {
    var frm = document.frmCrtfc;
    
    frm.action = '<c:out value="${wzwg_contextPath}" />/cmm/mber/myPage/selectMyPageCrtfc.do';
    frm.submit();
}

function fnKeypress() {
    if(event.keyCode == 13){
        fnCrtfc();
    }
}
</script>

             
    <form:form modelAttribute="paramVO" id="frmCrtfc" name="frmCrtfc" method="post">
    <div class="sbscrb003">
        <div class="sbscrbBtmbox" style="margin-top:0px;">
            <table class="sbscrbTable">
                <colgroup>
                    <col width="25%">
                    <col width="*">
                </colgroup>
                <tr>
                    <th scope="row"><spring:message code="wzwg.cmm.word.password" /></th>
                    <td><input type="password" name="password" id="password" maxlength="20" onkeypress="fnKeypress();" autocomplete="off" /></td>
                </tr>
            </table>
            <div class="sbscrbBtnbox">
                <div class="sbscrbBtnwidth">
                    <a href="#" class="nextBtn" id="crtfc_btn"><spring:message code="wzwg.cmm.word.next" /></a>
                </div>
         </div>
        </div>
    </div><!-- sbscrb003 end -->
    </form:form>
     
                