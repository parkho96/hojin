<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

	<script type="text/javascript">
		/** 체크박스 전체 선택 && 전체 삭제 */
		$(document).ready(function(){
			$("#checkall").click(function(){
				if($("#checkall").prop("checked")){
					$("input[name=chk]").prop("checked", true);
				}else{
					$("input[name=chk]").prop("checked", false);
				}
			});
		});
		
		function fnPage(paramPageIndex){
			
			if(isNaN(paramPageIndex)){
				console.log('잘못된 페이지호출');
				return;
			}
			
			document.usrInfoForm.pageIndex.value = paramPageIndex;
			document.usrInfoForm.action='<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/siteInfo/selectMngrInfoList.do';
			document.usrInfoForm.submit();
			
		}
		
		function fn_usrInfoDetail(siteSeq, usrSeq){
            document.usrInfoForm.siteSeq.value = siteSeq;
			document.usrInfoForm.usrSeq.value = usrSeq;
			document.usrInfoForm.action='<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/modifyMngrInfoForm.do';
			document.usrInfoForm.submit();
		}
		
		 function fn_mngrInfoRegist(){
			    document.usrInfoForm.action = "<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectMngrInfoNewSbscrbForm.do";
			    document.usrInfoForm.submit();
		 }
		
		 function fn_usrInfoDelete(){

			    if( $(':checkbox[name="chk"]:checked').length < 1 ){
	                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
							'<spring:argument><spring:message code="wzwg.cmm.word.emplyr" /></spring:argument>'+
							'<spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument>'+
						  '</spring:message>');
			        return;
			    }
			    
				if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
					
					$.ajax({
						type:'POST'
						, url:'<c:out value="${wzwg_contextPath}${prefix}" />/usrMngr/usrInfo/deleteUsrInfo.do'
						, data:$("#usrInfoForm").serialize()
						,success:function (result){
							$(result).find('value').each(function(){
								if($(this).text() == "success"){
									alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
									fnTabLink(7);
								}else{
									alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
								}
							})
						}
						, error:function (request, status, error) {
				              alert('<spring:message code="fail.common.msg" text="error" />');
				          }
					});
				}else{
					return ;
				}
		}

		
	</script>
	  <c:choose>
            <c:when test="${!empty paramVO.siteSeq}">
                <jsp:include page="/WEB-INF/jsp/wzwg/sysMngr/siteMngr/siteInfo/siteInfoTab.jsp"></jsp:include>
            </c:when>
            <c:otherwise>
                <h3><spring:message code="wzwg.sysMngr.word.siteAdiinfo" /></h3>
            </c:otherwise>
            </c:choose>
    <form:form modelAttribute="paramVO" id="usrInfoForm" name="usrInfoForm" method="post">
		<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex}" />" />
        <input type="hidden" name="usrSeq" id="usrSeq" value=""/>
        <input type="hidden" name="siteSeq" id="siteSeq" value="<c:out value="${paramVO.siteSeq}" />"/>
		<div class="main-menu-bar">
			<c:set var="msg_txt01">
				<spring:message code="wzwg.cmm.cmmMsg.CMG011">
					<spring:argument><spring:message code="wzwg.sysMngr.word.mberNm01" /></spring:argument>
					<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
				</spring:message>
			</c:set>
		</div>
		<div class="rt-box">
			<span class="member"><spring:message code="wzwg.cmm.word.total" /> <c:out value="${usrInfoCnt}" /> <spring:message code="wzwg.cmm.word.people" /></span>
		</div>
	
		<table class="basic-table">
			<colgroup>
                   <col width="5%"/>
                   <col width="5%"/>
                   <col width="*"/> 
                   <col width="20%"/>
                   <col width="15%"/>
                   <col width="12%"/>
                   <col width="10%"/>
			</colgroup>
	 		<thead>
				<tr>
					<th><ul class="wzForm"><li><label><input type="checkbox" name="checkall" id="checkall"/><span class="spanLabel"></span></label></li></ul></th>
					<th>No</th>
					<th><spring:message code="wzwg.sysMngr.word.siteNm01" /></th>
					<th><spring:message code="wzwg.cmm.word.id02" /></th>
                    <th><spring:message code="wzwg.cmm.word.nm02" /></th>
					<th><spring:message code="wzwg.sysMngr.word.sbscrbDe" /></th>
					<th><spring:message code="wzwg.cmm.word.manage" /></th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty usrInfoList}">
				<tr>
					<td colspan="7"><spring:message code="wzwg.cmm.msg.MSG246" /></td>
				</tr>
				</c:if>
				<c:forEach items="${usrInfoList }" var="usrInfoList" varStatus="status">
					<tr> 
						<td><ul class="wzForm"><li><label><input type="checkbox" name="chk" value="<c:out value="${usrInfoList.usrSeq}" />:<c:out value="${usrInfoList.siteSeq}" />" /><span class="spanLabel"></span></label></li></ul></td>
						<td><c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.pageSize + status.count) + 1 }"/></td>
                        <td><c:out value="${usrInfoList.siteFullNm }"/></td>
                        <td><c:out value="${usrInfoList.userId }"/></td>
                        <td><c:out value="${usrInfoList.userNm }"/></td>
                        <td><c:out value="${usrInfoList.sbscrbPnttm }"/></td>
                        <td><a href="javascript:void(0);" onclick="fn_usrInfoDetail(<c:out value="${usrInfoList.siteSeq}" />,<c:out value="${usrInfoList.usrSeq}" />)" class="iconOnlyBtn btn-basic btn-modify" title="<spring:message code="wzwg.cmm.word.updt" />"><spring:message code="wzwg.cmm.word.updt" /></a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<c:if test="${!empty usrInfoList}">
			<div class="ctr-box" id="pageInfo">
				<ul class="num mobile-none">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnPage" />
				</ul>
				
				<ul class="num pc-none">
					<ui:pagination paginationInfo="${mobilePaginationInfo}" type="image" jsFunction="fnPage" />
				</ul>
			</div>
		</c:if>

    </form:form>
	<div class="rt-box">
		<c:if test="${sessionScope.SYSMNGR_AT eq 'Y' }">
			<a href="javascript:void(0);" onclick="fn_usrInfoDelete();" class="wzbtn btn-del fl"><spring:message code="wzwg.sysMngr.word.choiseDelete" /></a>
			<a href="javascript:void(0);" onclick="fn_mngrInfoRegist();"id="sbscrb_btn" class="wzbtn btn-basic"> <spring:message code="wzwg.cmm.word.regist" /></a>
		</c:if>
	</div>
