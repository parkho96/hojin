<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js"></script>
<script type="text/javascript">
var isExgist = false;
 function fnModifyCmntInfo(){
	 document.frmInfo.action="<c:out value="${wzwg_contextPath}"/>/mngr/cmnt/info/modifyCmntInfoMngr.do";
	 document.frmInfo.method="post";
	 document.frmInfo.submit();
 }
 function fnCmntInfoList(){
	 document.frmInfo.action="<c:out value="${wzwg_contextPath}"/>/mngr/cmnt/info/selectCmntInfoList.do";
	 document.frmInfo.method="post";
	 document.frmInfo.submit();
 }
 
 function fnDeleteCmntInfo(){
	 document.frmInfo.action="<c:out value="${wzwg_contextPath}"/>/mngr/cmnt/info/deleteCmntInfoMngr.do";
	 document.frmInfo.method="post";
	 document.frmInfo.submit();
 }
  
 
 function fnLayerPopupClose() {
     $("#divLayerPopup").hide();
     $("#divLayerPopup").empty();
     $('body').css({overflow:'auto'});
 }
</script>
 
                <form id="frmInfo" name="frmInfo">
                    <input type="hidden" name="cmntSeq" id="cmntSeq" value="<c:out value="${resultVO.cmntSeq}"/>"/>
                    
                    <input type="hidden" name="cmntApprovalCodeSearch" id="cmntApprovalCodeSearch" value="<c:out value="${paramVO.cmntApprovalCodeSearch}"/>"/>
                    <input type="hidden" name="searchCondition" id="searchCondition" value="<c:out value="${paramVO.searchCondition}"/>" />
                    <input type="hidden" name="searchKeyword" id="searchKeyword" value="<c:out value="${paramVO.searchKeyword}"/>" />
                    <input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex}"/>" />
                    
                    <table class="basic" summary="<spring:message code="wzwg.site.cmm.msg.MSG005"/>">
                    <colgroup>
                        <col width="15%"/>
                        <col width="*"/>
                    </colgroup>
                    <tbody>
                        <tr>
                            <th><spring:message code="wzwg.cmm.word.cmmntynm" /></th>
                            <td colspan="3">
                          	 <c:out value="${resultVO.cmntNm}"/>
                            </td>
                        </tr>
                        <tr>
                            <th><spring:message code="wzwg.cmm.word.oprtr" /></th>
                            <td colspan="3">
                            <c:out value="${resultVO.cmntMngrNm}"/>(<c:out value="${resultVO.cmntMngrId}"/>)
                            </td>
                        </tr>
                        
                        <tr>
                            <th><spring:message code="wzwg.cmm.word.cttpc" /></th>
                            <td>
                              <c:out value="${resultVO.cmntTelno}"/>
                            </td>
                             <th><spring:message code="wzwg.cmm.word.email" /></th>
                            <td>
                               <c:out value="${resultVO.cmntEmailAdres}"/>
                            </td>
                        </tr>
                        <tr>
                            <th><spring:message code="wzwg.site.cmnt.msg.MSG005" /></th>
                            <td  colspan="3">
                             <c:out value="${resultVO.cmntMeaning}" escapeXml="false"/>
                            </td>
                        </tr>
                        <tr>
                            <th><spring:message code="wzwg.site.cmnt.msg.MSG006" /></th>
                            <td colspan="3">
                            	<ul class="wzForm">
		                             <c:forEach items="${cmntOpenCodeList}" var="resultList" varStatus="status">
		                          		<li><label><input type="radio" name="cmntOpenCode" id="cmntOpenCode" value="<c:out value="${resultList.code}"/>" <c:if test="${resultVO.cmntOpenCode eq resultList.code}">checked="true"</c:if>/> <span class="spanLabel"><c:out value="${resultList.codeNm}"/></span></label></li> 
		                          	</c:forEach>
                          		</ul>
                            </td>
                        </tr>
                        <tr>
                            <th><spring:message code="wzwg.site.cmnt.msg.MSG007" /></th>
                            <td colspan="3">
                            <select id="cmntApprovalCode" name="cmntApprovalCode">
                             <c:forEach items="${cmntApprovalCodeList}" var="resultList" varStatus="status">
                          		 <option value="<c:out value="${resultList.code}"/>" <c:if test="${resultVO.cmntApprovalCode eq resultList.code}">selected="true"</c:if>><c:out value="${resultList.codeNm}"/></option>
                          	</c:forEach>
                          	</select>
                            </td>
                        </tr>
                    </tbody>
                    </table>
                    
                </form>
      
     <div class="rt-box">
     
		<a href="javascript:void(0);" onclick="fnDeleteCmntInfo();" class="wzbtn btn-del fl"><spring:message code="wzwg.cmm.word.delete" /></a>
		<a href="javascript:void(0);" onclick="fnModifyCmntInfo();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
		<a href="javascript:void(0);" onclick="fnCmntInfoList();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>
	
		<!-- 레이어팝업 영역 Start -->
	<div id="divLayerPopup" class="modal fade in"></div>
	<!-- 레이어팝업 영역 End -->