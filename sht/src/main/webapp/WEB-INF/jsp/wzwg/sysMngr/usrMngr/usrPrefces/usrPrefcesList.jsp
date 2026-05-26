<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
	
<script type="text/javascript">
    $(document).ready(function(){
        <c:if test="${empty paramVO.grpcode}">
        $('.tab').eq(0).click();
        </c:if>
    });
</script>

<c:choose>
<c:when test="${empty tablList}">
</c:when>
<c:otherwise>
<script>
function fnTabLink(grpcode, cnt) {
    
    $('.tab').each(function(idx){
        $(this).removeClass('active');
        if (cnt == idx) {
            $(this).addClass('active');
        }
    });
    
    $.ajax({
        type:'POST'
      , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/usrPrefces/selectusrPrefcesIemAjax.do'
      , data:"usrPrefeCode="+grpcode
      , success:function (data) {
          $("#divCntnts").html(data);
          
          $('#usrPrefeCode').val(grpcode);
      }
      , error:function (request, status, error) {
          alert('<spring:message code="fail.common.msg" text="error" />');
      }
      , dataType: 'html'
    });
}
</script>    
	<div class="wztab underLine theme-blue">
	    <div class="wztab-list">
	        <c:forEach items="${tablList}" var="result" varStatus="status">
	        <a href="#" onclick="fnTabLink('<c:out value="${result.grpcode}" />', <c:out value="${status.count-1}" />);" class="tab wztab-item <c:if test="${empty paramVO.grpcode && status.count eq 1}">active</c:if>"><c:out value="${result.grpcodeNm}" /></a>
	        </c:forEach>
	    </div>
    </div>
</c:otherwise>
</c:choose>
    
	<!--//게시판 설정 table -->
	<div id="divCntnts"></div>
	 

	 <div class="rt-box">
	 		<a href="javascript:void(0);" onclick="fn_usrTySbscrbModify();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
	 </div>
