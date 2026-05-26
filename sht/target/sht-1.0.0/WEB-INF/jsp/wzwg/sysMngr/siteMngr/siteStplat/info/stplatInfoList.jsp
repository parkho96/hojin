<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script type="text/javascript">
function fnRegistFrom() {
    document.frmSrh.action="<c:out value="${wzwg_contextPath}${prefix}"/>/siteMngr/siteStplat/info/selectStplatInfoForm.do";
    document.frmSrh.submit();
}

function fnDetail(stplatSeq) {
    document.frmSrh.stplatSeq.value = stplatSeq;
    
    document.frmSrh.action="<c:out value="${wzwg_contextPath}${prefix}"/>/siteMngr/siteStplat/info/selectStplatInfoDetail.do";
    document.frmSrh.submit();
}

function fnPage(pageIndex) {
	
	if(isNaN(pageIndex)){
		console.log('잘못된 페이지호출');
		return;
	}
	
    document.listForm.pageIndex.value = pageIndex;
    document.listForm.action="<c:out value="${wzwg_contextPath}${prefix}"/>/siteMngr/siteStplat/info/selectStplatInfoList.do";
    document.listForm.submit();
}

function fnDelete(stplatSeq){
	if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
		return;
	} else {
		
		// 여기에 체크하는 로직 들어가야 함
		
		$("#stplatSeq").val(stplatSeq);
		
		$.ajax({
			type:'POST'
			, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/siteMngr/siteStplat/info/deleteStplatInfoAjax.do'
			, data:$("#frmSrh").serialize()
			,success:function (result){
				$(result).find('value').each(function(){
					if($(this).text() == "success"){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
						fnPage(1);
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
					}
				})
			}
			, error:function (request, status, error) {
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
                        <input type="hidden" id="stplatSeq" name="stplatSeq" value="<c:out value="${paramVO.stplatSeq}"/>" />
                        <c:choose>
                        <c:when test="${empty resultVO.siteSeq}">
                        <input type="hidden" id="siteSeq" name="siteSeq" value="<c:out value="${paramVO.siteSeq}"/>" />
                        </c:when>
                        <c:otherwise>
                        <input type="hidden" id="siteSeq" name="siteSeq" />
                        </c:otherwise>
                        </c:choose>
                    </form>
                    
                    <!--//게시판명 table -->
                        <form name="listForm" id="listForm" method="post">
                            <input type="hidden" name="pageIndex" value="<c:out value="${paramVO.pageIndex}"/>" />
                            <c:choose>
                            <c:when test="${empty resultVO.siteSeq}">
                            <input type="hidden" id="siteSeq" name="siteSeq" value="<c:out value="${paramVO.siteSeq}"/>" />
                            </c:when>
                            <c:otherwise>
                            <input type="hidden" id="siteSeq" name="siteSeq" />
                            </c:otherwise>
                            </c:choose>
                        </form>
                    
                    <!--//게시판 설정 table -->
                    <table summary="약관관리 목록" class="basic-table">
                        <colgroup>
                            <col width="5%"/>
                            <col width="10%"/>
                            <col width="*"/>
                            <col width="12%"/>
                            <col width="10%"/>
                            <col width="15%"/>
                            <col width="10%"/>
                        </colgroup>
                        <thead>
	                        <tr>
	                            <th>No</th>
	                            <th><spring:message code="wzwg.cmm.word.ty" /></th>
	                            <th><spring:message code="wzwg.sysMngr.word.stplatAndPolicyNm01" /></th>
	                            <th><spring:message code="wzwg.sysMngr.word.registDe" /></th>
	                            <th><spring:message code="wzwg.sysMngr.word.essntlAt"/></th>
	                            <th><spring:message code="wzwg.cmm.word.lastupdtde" /></th>
	                            <th><spring:message code="wzwg.cmm.word.manage" /></th>
	                        </tr>
                        </thead>
                        <tbody>
                        
                        <c:if test="${!empty resultList}">
                        <c:forEach items="${resultList}" var="list" varStatus="status">
	                        <tr>
	                            <td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + status.count) + 1}"/></td>
	                            <td><c:out value="${list.stplatTyCodeNm}" /></td>
	                            <td class="txt-l"><c:out value="${list.stplatNm}" /></td>
	                            <td><c:out value="${list.frstRegistPnttm}" /></td>
	                            <td>
	                            	<c:if test="${list.stplatTyCode eq 'SC00000453' and list.essntlAt eq 'Y' }"><spring:message code="wzwg.cmm.word.essntl"/></c:if>
	                            	<c:if test="${list.stplatTyCode eq 'SC00000453' and list.essntlAt eq 'N' }"><spring:message code="wzwg.cmm.word.choise"/></c:if>
	                            </td>
	                            <td><c:out value="${list.lastUpdtPnttm}" /></td>
	                            <td>
	                            	<a href="javascript:void(0);" onclick="fnDetail('<c:out value="${list.stplatSeq}" />'); return false;" class="iconOnlyBtn btn-basic btn-modify" title="<spring:message code="wzwg.cmm.word.updt" />"><spring:message code="wzwg.cmm.word.updt" /></a>
	                            	<a href="javascript:void(0)" onclick="fnDelete('<c:out value="${list.stplatSeq}" />'); return false;" class="iconOnlyBtn btn-basic btn-delete" title="<spring:message code="wzwg.cmm.word.delete" />"><spring:message code="wzwg.cmm.word.delete" /></a>
	                            	</td>
	                        </tr>
                        </c:forEach>
                        </c:if>
                         
                        </tbody>
                   </table>
                  <c:if test="${!empty resultList}">
	                  <c:if test="${sessionScope.SYSMNGR_AT ne 'Y' }">
		                  <div class="admpg-subp w100 fl txt-l mb15">
								<span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.MSG390" />
						  </div>
					  </c:if>
                  	<div class="ctr-box" id="pageInfo">
						<ul class="num mobile-none">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnPage" />
						</ul>
						
						<ul class="num pc-none">
							<ui:pagination paginationInfo="${mobilePaginationInfo}" type="image" jsFunction="fnPage" />
						</ul>
				  	</div>
                  </c:if>
                          
                  <!--// button --> 
                  <div class="rt-box">
   	              	<a href="javascript:void(0);" onclick="fnRegistFrom(); return false;" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.regist" /></a>
                  </div>
