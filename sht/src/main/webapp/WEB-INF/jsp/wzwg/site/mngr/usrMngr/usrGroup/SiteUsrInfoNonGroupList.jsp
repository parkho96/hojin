<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
	
	<script type="text/javascript">
	$(document).ready(function(){
		$("#checkallnon").click(function(){
			if($("#checkallnon").prop("checked")){
				$("input[name=chknon]").prop("checked", true);
			}else{
				$("input[name=chknon]").prop("checked", false);
			}
		});
	});
	
	/** 사이트사용자그룹 추가 */
	function fn_siteUsrInfoGroupRegist(){ 
		if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.add" text="add" /></spring:argument></spring:message>')){
			$.ajax({
				type:'POST'
				, url:'<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrGroup/registSiteUsrInfoGroup.do'
				, data:$("#siteUsrInfoGroupForm").serialize()
				,success:function (result){
					$(result).find('value').each(function(){
						if($(this).text() == "success"){
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.add" /></spring:argument></spring:message>');
							wzModalClose();
							fn_usrGrouplist();
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.add" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
						}
					})
				}
				, error:function (request, status, error) {
		              alert('<spring:message code="fail.common.msg" text="error" />');
		          }
			});
		}else{
			return;
		}
	}
	
	
		 function fn_siteUsrGroupRegistForm(){
			 var frm = document.siteUsrGroupForm;
			 frm.action='<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrGroup/registSiteUsrGroupForm.do';
			 frm.submit();
		 }
		 
		 function fn_siteUsrGroupDetail(paramSeq){
			 var frm = document.siteUsrGroupForm;
			 
			 frm.usrGroupSeq.value = paramSeq;
			 frm.action='<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrGroup/selectSiteUsrGroupDetail.do';
			 frm.submit(); 
		 }
		 
		 function fn_search(){
			var frm = document.siteUsrGroupForm;
			frm.action='<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrGroup/selectSiteUsrGroupList.do';
			frm.submit();
		 }
		 
		 function fnPage(paramPageIndex){
			 
			 if(isNaN(paramPageIndex)){
				console.log('잘못된 페이지호출');
				return;
			}
			 
			document.siteUsrInfoGroupForm.pageIndex.value = paramPageIndex; 
			$.ajax({
				type:'POST'
				, url:'<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrGroup/SiteUsrInfoNonGroupListAjax.do'
				, data:$("#siteUsrInfoGroupForm").serialize()
				,success:function (result){ 
					$('.wzpopup .pop-container').html(result);  
				}
				, error:function (request, status, error) {
		              alert('<spring:message code="fail.common.msg" text="error" />');
		          }
			});
		 }
	</script>
	<form id="siteUsrInfoGroupForm" name="siteUsrInfoGroupForm" method="post">
  	    <input type="hidden" name="usrGroupSeq" id="usrGroupSeq" value="<c:out value="${paramVO.usrGroupSeq }" />"/>  
  	    <input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex }" />"/>
 
		<table class="basic-table">
			<colgroup>
                    
                   <col width="5%"/>
                   <col width="15%"/> 
                   <col width="10%"/>
                   <col width="*"/>
                   <col width="10%"/>
                   <col width="15%"/> 
			</colgroup>
	 		<thead>
				<tr>
					<th><ul class="wzForm"><li><label><input type="checkbox" name="checkallnon" id="checkallnon"/><span class="spanLabel"></span></label></li></ul></th>
					<th>No</th>
					<th><spring:message code="wzwg.cmm.word.id02" /></th>
                    <th><spring:message code="wzwg.cmm.word.nm02" /></th>
                    <th><spring:message code="wzwg.cmm.word.sttus" /></th>
					<th><spring:message code="wzwg.site.usrmngr.msg.MSG009" /></th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty usrInfoList}">
				<tr>
					<td colspan="6"><spring:message code="wzwg.cmm.msg.MSG246" /></td>
				</tr>
				</c:if>
				<c:forEach items="${usrInfoList }" var="usrInfoList" varStatus="status">
					<tr>
						<td>
							<ul class="wzForm"><li><label><input type="checkbox" name="chknon" value="<c:out value="${usrInfoList.usrSeq}:${usrInfoList.siteSeq}" />" /><span class="spanLabel"></span></label></li></ul>
						</td>
						<td style="cursor:pointer;">
							<c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.pageSize + status.count) + 1 }"/>
						</td>
                          <td style="cursor:pointer;">
                              <c:out value="${usrInfoList.userId }"/>
                          </td>
                          <td style="cursor:pointer;">
                              <c:out value="${usrInfoList.userNm }"/>
                          </td>
                            <c:if test="${sessionScope.SYSMNGR_AT ne 'Y' }">
                          <td style="cursor:pointer;">
                              <c:out value="${usrInfoList.usrSttusCodeNm }"/>
                          </td>
                          </c:if>
                          <td style="cursor:pointer;">
							<c:out value="${usrInfoList.sbscrbPnttm }"/>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		 </form>
	<c:if test="${!empty usrInfoList}">
	 	<div class="ctr-box">
			<ul class="num">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnPage" />
			</ul>
		</div>
	</c:if>
	<div class="rt-box">
		<a href="javascript:void(0);" class="wzbtn btn-save" onclick="fn_siteUsrInfoGroupRegist();"><spring:message code="wzwg.cmm.word.add" /></a>
	</div>
	  
