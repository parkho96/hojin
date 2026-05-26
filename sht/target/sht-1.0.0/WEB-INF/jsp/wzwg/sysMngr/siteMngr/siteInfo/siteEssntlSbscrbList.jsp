<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script type="text/javascript">
function fnRegist() {

    if (confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>')){
        
        $.ajax({
            type:'POST'
            , url: '<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteStplat/info/registEssntlStplatAjax.do'
            , dataType: 'xml'
            , data:$("#frmList").serialize()
            , success:function (result) {
              
                var value = "";
                
                $(result).find("value").each(function() {  
                    value = $(this).text();  
                });
                
                if(value != 'success'){
                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
                } else {
                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>');
                }
              
            }
            , error:function (request, status, error) {
                alert('<spring:message code="fail.common.msg" text="error" />');
            }
        });
    }
    
}
</script>
                <c:choose>
                <c:when test="${!empty paramVO.siteSeq}">
                    <jsp:include page="/WEB-INF/jsp/wzwg/sysMngr/siteMngr/siteInfo/siteInfoTab.jsp"></jsp:include>
                </c:when>
                <c:otherwise>
                    <h3 class="table_tit"><spring:message code="wzwg.sysMngr.word.rqrtrmMng" /></h3>
                </c:otherwise>
                </c:choose>
                
                    <!--//게시판명 table -->
                    <form id="frmList" name="frmList" method="post">
                    <input type="hidden" id="siteSeq" name="siteSeq" value="<c:out value="${paramVO.siteSeq}" />" />
                    
                    <!--//게시판 설정 table -->
                      <table class="basic-table">
                        <colgroup>
                        <col width="5%" />
                        <col width="25%" />
                        <col width="*" />
                        </colgroup>
                        <thead>
                          <tr>
                            <th>No</th>
                            <th><spring:message code="wzwg.sysMngr.word.rqrtrmCode" /></th>
                            <th><spring:message code="wzwg.sysMngr.word.estbsStplat" /></th>
                          </tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty resultList}">
                        <tr>
                            <td colspan="3"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
                        </tr>
                        </c:if>
                        <c:forEach items="${resultList}" var="result" varStatus="status">
                        <tr>
                            <td><c:out value="${fn:length(resultList)-status.count+1}" /></td>
                            <td><c:out value="${result.stplatTyCodeNm}" /></td>
                            <td>
                                <select id="stplatTyCodeArr" name="stplatTyCodeArr">
                                <c:if test="${!empty resultMap[result.stplatTyCode]}">
                                <c:forEach items="${resultMap[result.stplatTyCode]}" var="map">
                                <option value="<c:out value="${result.stplatTyCode}" />:<c:out value="${map.stplatSeq}" />" <c:if test="${result.stplatSeq eq map.stplatSeq}">selected</c:if>><c:out value="${map.stplatNm}" /></option>
                                </c:forEach>
                                </c:if>
                                </select>
                            </td>
                        </tr>
                        </c:forEach>
                        </tbody>
                      </table>
                   </form>
                      
                <!--// button --> 
                <div class="rt-box"> 
					<a href="javascript:void(0);" onclick="fnRegist(); return false;" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
                </div>
