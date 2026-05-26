<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script type="text/javascript">
function fnDetail(stplatlogSeq) {
    var frm = document.frmSrh;
    var windowOpen = window.open("", "popForm", "width=500,height=400,toolbars=no,menubars=no,scrollbars=yes");

    frm.stplatlogSeq.value = stplatlogSeq;
    
    frm.target = "popForm";
    frm.action="<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteStplat/log/selectStplatLogDetailPopup.do";
    frm.submit();
}


function fnPage(pageIndex) {
	
	if(isNaN(pageIndex)){
		console.log('잘못된 페이지호출');
		return;
	}
	
    document.listForm.pageIndex.value = pageIndex;
    document.listForm.action="<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteStplat/log/selectStplatLogList.do";
    document.listForm.submit();
}

$(document).ready(function(){
    $('.checkall').click(function(){
        if($('.checkall').prop('checked')){
            $('input[name=stplatlogSeqArr]').prop('checked', true);
        }else{
            $('input[name=stplatlogSeqArr]').prop('checked', false);
        }
    });
});

function fnSelDelete() {

    if( $(':checkbox[name="stplatlogSeqArr"]:checked').length < 1 ){
        alert('<spring:message code="wzwg.cmm.msg.MSG116" />');
        return;
    }
    
    if (confirm(''<spring:message code="wzwg.cmm.cmmMsg.CMG006">'+
					'<spring:argument><spring:message code="wzwg.cmm.word.stplat" /></spring:argument>'+
					'<spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument>'+
				  '</spring:message>')) {
        var frm = document.listForm;
        
        $.ajax({
            type : 'POST'
          , dataType: 'xml'
          , url:'<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteStplat/log/deleteSiteStplatLog.do'
          , data: $("#listForm").serialize()
          , success : function(result) {
             var value = "";
             
             $(result).find("value").each(function() {  
                 value = $(this).text();  
             });
             
             if(value == 'success'){
                 alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
                 fnPage(1);
             }else{
                 alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
             }
          }
          , error:function (data) {
              alert('<spring:message code="fail.common.msg" text="error" />');
          }
      });
    }
}

</script>

                    <c:if test="${!empty paramVO.siteSeq}">
                        <jsp:include page="/WEB-INF/jsp/wzwg/sysMngr/siteMngr/siteInfo/siteInfoTab.jsp"></jsp:include>
                    </c:if>
                    
                    <form name="frmSrh" id="frmSrh" method="post">
                        <input type="hidden" id="stplatlogSeq" name="stplatlogSeq" value="<c:out value="${paramVO.stplatlogSeq}" />" />
                        <c:choose>
                        <c:when test="${empty resultVO.siteSeq}">
                        <input type="hidden" id="siteSeq" name="siteSeq" value="<c:out value="${paramVO.siteSeq}" />" />
                        </c:when>
                        <c:otherwise>
                        <input type="hidden" id="siteSeq" name="siteSeq" />
                        </c:otherwise>
                        </c:choose>
                    </form>
                    
                    <!--//게시판명 table -->
                    <form name="listForm" id="listForm" method="post">
                        <input type="hidden" name="pageIndex" value="<c:out value="${paramVO.pageIndex}" />" />
                        <c:choose>
                        <c:when test="${empty resultVO.siteSeq}">
                        <input type="hidden" id="siteSeq" name="siteSeq" value="<c:out value="${paramVO.siteSeq}" />" />
                        </c:when>
                        <c:otherwise>
                        <input type="hidden" id="siteSeq" name="siteSeq" />
                        </c:otherwise>
                        </c:choose>
                    
                    <!--//게시판 설정 table -->
                    <table summary="<spring:message code="wzwg.sysMngr.word.stplatMngList" />" class="basic-table">
                        <colgroup>
                            <col width="5%"/>
                            <col width="*"/>
                            <col width="20%"/>
                            <col width="10%"/>
                        </colgroup>
                        <thead>
	                        <tr>
	                            <th><input type="checkbox" id="stplatlogSeqArr" name="stplatlogSeqArr" value="" class="checkall"></th>
	                            <th><spring:message code="wzwg.sysMngr.word.stplatNm01" /></th> 
			                    <th><spring:message code="wzwg.sysMngr.word.applcDe" /></th>
			                    <th><spring:message code="wzwg.sysMngr.word.stplatCn" /></th>
	                        </tr>
                        </thead>
                        <tbody>
                        
                        <c:choose>
                        <c:when test="${!empty resultList}">
                        <c:forEach items="${resultList}" var="list" varStatus="status">
                            <tr>
                                <td>
                                    <input type="checkbox" id="stplatlogSeqArr" name="stplatlogSeqArr" class="chkDomnSeq" value="<c:out value="${list.stplatlogSeq}" />" />
                                </td>
                                <td><c:out value="${list.stplatNm}" /></td>
                                <td><c:out value="${list.beginPnttm}" /> ~ <c:out value="${list.endPnttm}" /></td>
                                <td><a href="javascript:void(0);" class="btn-c" onclick="fnDetail('<c:out value="${list.stplatlogSeq}" />'); return false;"><spring:message code="wzwg.cmm.word.view" /></a></td>
                            </tr>
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
                         
                        </tbody>
                    </table>
                    </form>
                  <c:if test="${!empty resultList}">
                  <div class="ctr-box">
                      <ul class="num">
                            <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnPage" />
                       </ul>
                  </div>
                  </c:if>
                          
                  <!--// button --> 
                  <c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
                  <div class="ctr-box">
                      <a href="javascript:void(0);" onclick="fnSelDelete(); return false;" class="btn-b fl"><spring:message code="wzwg.sysMngr.word.choiseDelete" /></a>
                  </div>
                  </c:if>
