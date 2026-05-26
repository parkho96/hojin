<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

	<script type="text/javascript">
		function fnPage(paramPageIndex){
			
			if(isNaN(paramPageIndex)){
				console.log('잘못된 페이지호출');
				return;
			}
			
			document.usrInfoForm.pageIndex.value = paramPageIndex;
			document.usrInfoForm.action='<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectMngrSbscrbInfoForm.do';
			document.usrInfoForm.submit();
			
		}
		
		function fnSearch(){
			document.usrInfoForm.pageIndex.value = 1;
			document.usrInfoForm.action='<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectMngrSbscrbInfoForm.do';
			document.usrInfoForm.submit();
		}
		
		function fnTabLink(num) {
			var tabUrl = ["<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectMngrNewSbscrbForm.do"
			              , "<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectMngrSbscrbInfoForm.do"];
			
			var frm = document.frmTab;
			frm.action = tabUrl[num];
			frm.submit();
		}
		
		function fn_usrSiteSbscrb(usrSeq) {
			
			document.regForm.usrSeq.value = usrSeq;
			
			$.ajax({
		        type:'POST'
				, url: '<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/registMngrSiteSbscrbInfo.do'
				, dataType: 'xml'
				, data:$("#regForm").serialize()
				, success:function (result) {
					
					alert(result);
		    	  
		    	  	var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value == 'success'){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.sbscrb" /></spring:argument></spring:message>');
						//$("#cancle_btn").click();
						
						var frm = document.regForm;
						frm.action = "<c:out value="${wzwg_contextPath}${prefix}" />/usrMngr/usrInfo/selectUsrInfoList.do";
						frm.submit();
						
					}else{
						alert('<spring:message code="wzwg.cmm.msg.MSG273" />');
					}
		    	  
				}
				, error:function (request, status, error) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});
		}
		
	</script>
	
		<div class="cocntainer_tabs">
	        <a href="#" onclick="fnTabLink(0);" class="tab <c:if test="${fn:indexOf(nowUrl, 'New') > -1}">active</c:if>"><spring:message code="wzwg.sysMngr.word.newSignup" /></a>
	        <a href="#" onclick="fnTabLink(1);" class="tab <c:if test="${fn:indexOf(nowUrl, 'New') eq -1}">active</c:if>"><spring:message code="wzwg.sysMngr.word.legacyMberregist" /></a>
	    </div>
	    
	    <form id="regForm" name="regForm" method="post">
	        <input type="hidden" id="siteSeq" name="siteSeq" value="<c:out value="${paramVO.siteSeq}" />" />
	        <input type="hidden" id="usrSeq" name="usrSeq" value="" />
	    </form>
	    
	    <form id="frmTab" name="frmTab" method="post">
	        <input type="hidden" id="siteSeq" name="siteSeq" value="<c:out value="${paramVO.siteSeq}" />" />
	    </form>
	
	<form name="usrInfoForm" id="usrInfoForm" method="post">
		<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex}" />" />
		<input type="hidden" name="usrSeq" id="usrSeq" value=""/>
		<div class="main-menu-bar mt10">
			<spring:message code="wzwg.sysMngr.word.choiseSite" /> : <c:out value="${siteInfoVO.siteFullNm}" />
		</div>
		
		<div class="rt-box">
			<span class="member"><spring:message code="wzwg.cmm.word.total" /> <c:out value="${usrInfoCnt}" /> <spring:message code="wzwg.cmm.word.count04" /></span>
		</div>

		<table class="basic-table">
			<colgroup>
				<col width="5%"/>
				<col width="15%"/>
				<col width="*"/>
				<col width="10%"/>
				<col width="15%"/>
				<col width="250"/>
			</colgroup>
	 		<thead>
				<tr>
					<th>No</th>
					<th><spring:message code="wzwg.sysMngr.word.mberTy" /></th>
					<th><spring:message code="wzwg.cmm.word.id02" /></th>
					<th><spring:message code="wzwg.cmm.word.nm02" /></th>
					<th><spring:message code="wzwg.sysMngr.word.sbscrbDe" /></th>
					<th><spring:message code="wzwg.cmm.word.manage" /></th>
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
							<c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.pageSize + status.count) + 1 }"/>
						</td>
						<td>
							<c:out value="${usrInfoList.usrSttusCode }"/>
						</td>
						<td>
							<c:out value="${usrInfoList.userId }"/>
						</td>
						<td>
							<c:out value="${usrInfoList.userNm }"/>
						</td>
						<td>
							<c:out value="${usrInfoList.sbscrbPnttm }"/>
						</td>
						<td>
							<a href="javascript:void(0);" onclick="fn_usrSiteSbscrb('<c:out value="${usrInfoList.usrSeq}" />');" class="btn-c"> <spring:message code="wzwg.sysMngr.word.sitemngrEstbs" /></a>
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
	
	<div class="lt-box">
		<a href="javascript:void(0);" onclick="fn_checkUsrInfoDelete();" class="btn-b"><spring:message code="wzwg.sysMngr.word.choiseDelete" /></a>
	</div>
