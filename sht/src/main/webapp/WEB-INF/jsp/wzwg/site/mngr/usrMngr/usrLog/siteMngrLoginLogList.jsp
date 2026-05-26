<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
	<link href="/css/wzwg/cmm/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/js/wzwg/cmm/common.js" ></script>
<script language="javascript" type="text/javascript" src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>
<script language="javascript" type="text/javascript" src="/jquery/js/jquery.form.min.js"></script>
	
	<script type="text/javascript">
	$(document).ready(function(){
        $(".datePicker").datepicker({ 		
   	     dateFormat: 'yy-mm-dd',
   	     monthNamesShort: ['1<spring:message code="wzwg.cmm.word.mt" />','2<spring:message code="wzwg.cmm.word.mt" />','3<spring:message code="wzwg.cmm.word.mt" />','4<spring:message code="wzwg.cmm.word.mt" />','5<spring:message code="wzwg.cmm.word.mt" />','6<spring:message code="wzwg.cmm.word.mt" />','7<spring:message code="wzwg.cmm.word.mt" />','8<spring:message code="wzwg.cmm.word.mt" />','9<spring:message code="wzwg.cmm.word.mt" />','10<spring:message code="wzwg.cmm.word.mt" />','11<spring:message code="wzwg.cmm.word.mt" />','12<spring:message code="wzwg.cmm.word.mt" />'],
   	     dayNamesMin: ['<spring:message code="wzwg.cmm.word.sun01" />','<spring:message code="wzwg.cmm.word.mon01" />','<spring:message code="wzwg.cmm.word.tue01" />','<spring:message code="wzwg.cmm.word.wed01" />','<spring:message code="wzwg.cmm.word.thu01" />','<spring:message code="wzwg.cmm.word.fri01" />','<spring:message code="wzwg.cmm.word.sat01" />'],
   	     weekHeader: 'Wk',
   	     changeMonth: true, 	//월변경가능
   	     changeYear: true, 	//년변경가능
   	     yearRange:'-10:+10', 	// 연도 셀렉트 박스 범위(현재와 같으면 1988~현재년)
   	     showMonthAfterYear: true, 	//년 뒤에 월 표시
   	     buttonImageOnly: false, //이미지표시  
   	     buttonText: '<spring:message code="wzwg.cmm.msg.MSG088" />', 
   	     autoSize: false	 //오토리사이즈(body등 상위태그의 설정에 따른다)
   	  	});
         
    });

		 
		 function fnSearch(){
			 fnPage(1); 
		 }
		 
		 function fnPage(paramPageIndex){
			 
			 if(isNaN(paramPageIndex)){
				console.log('잘못된 페이지호출');
				return;
			}
			 
			document.siteMngrLogForm.pageIndex.value = paramPageIndex;
			document.siteMngrLogForm.action='<c:out value="${wzwg_contextPath}" />/sysMngr/usrLog/selectSiteMngrLoginLogList.do';
			document.siteMngrLogForm.submit();
		 }
		 
		 function fnReset() {
			 $('#siteId').val('');
			 $('#loginMthd').val('');
			 $('input[name=searchBgnDe]').val('');
			 $('input[name=searchEndDe]').val('');
			 $('#searchCnd').val('');
			 $('#searchWrd').val('');
			 fnSearch();
		 }
	</script>
	
	<form id="siteMngrLogForm" name="siteMngrLogForm" method="post"> 
  	    <input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex }" />"/>
  	    
  	    <div class="wz_notice brbox bg-white br-blue-strong">	
		    <ul class="wd100">
			    <li class="admpg-subp wd100 mb0">· <spring:message code="wzwg.cmm.msg.tip.MSG153" /></li>
		    </ul>
		</div>
  	    
		<div class="main-menu-bar">
			<select name="siteId" id="siteId" onchange="fnSearch();">
				<option value="" <c:if test="${empty paramVO.siteId }">selected="selected"</c:if>><spring:message code="wzwg.site.usrmngr.msg.MSG010" /></option>
				<option value="10000000001" <c:if test="${paramVO.siteId eq '10000000001' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.sysmngr" /></option>
				<c:forEach items="${siteInfoList }" var="siteInfoList" varStatus="status">
					<option value="<c:out value="${siteInfoList.siteSeq }" />" <c:if test="${paramVO.siteId eq siteInfoList.siteSeq}">selected="selected"</c:if>>
						<c:out value="${siteInfoList.siteFullNm }"/>
					</option>
				</c:forEach>
			 </select>
			 <select name="loginMthd" id="loginMthd" onchange="fnSearch();">
				<option value="" <c:if test="${empty paramVO.loginMthd }">selected="selected"</c:if>><spring:message code="wzwg.site.usrmngr.msg.MSG011" /></option>
				<option value="I" <c:if test="${paramVO.loginMthd eq 'I' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.login" /></option>
				<option value="O" <c:if test="${paramVO.loginMthd eq 'O' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.logout" /></option>
			 </select>
			
			<c:set var="srchwrd">
				<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
			</c:set>
			<input type="text" class="datePicker txt"  readonly="readonly" name="searchBgnDe" value="<c:out value="${paramVO.searchBgnDe}" />"  title="<spring:message code="wzwg.cmm.word.bgnde"/>" placeholder="<spring:message code="wzwg.cmm.word.bgnde"/>" />
			~<input type="text" class="datePicker txt"   readonly="readonly" name="searchEndDe" value="<c:out value="${paramVO.searchEndDe}" />"   title="<spring:message code="wzwg.cmm.word.endde"/>" placeholder="<spring:message code="wzwg.cmm.word.endde"/>" />
			<br/>
			<div class="mt10">
				<select name="searchCnd" id="searchCnd" >
					<option value="" <c:if test="${empty paramVO.searchCnd }">selected="selected"</c:if>><spring:message code="wzwg.site.usrmngr.msg.MSG012" /></option>
					<option value="1" <c:if test="${paramVO.searchCnd eq '1'}">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.id02" /></option>
					<option value="2" <c:if test="${paramVO.searchCnd eq '2'}">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.conect" /> IP</option>
				 </select>
				<input type="text" name="searchWrd" id="searchWrd" placeholder="<c:out value="${srchwrd}" />" class="txt" onkeypress="if(window.event.keyCode == 13) {fnSearch();}" value="<c:out value="${paramVO.searchWrd}" />"/>
		 		<a href="javascript:void(0);" class="wzbtn-table btn-srch" onclick="fnSearch();"><spring:message code="wzwg.cmm.word.search01" /></a>
		 		<a href="javascript:void(0);" class="wzbtn-table btn-basic" onclick="fnReset();"><spring:message code="wzwg.cmm.word.initl" /></a>
	 		</div>
		</div>
		<span class="fr mb15"><spring:message code="wzwg.cmm.word.total" /> <c:out value="${totCnt}" /><spring:message code="wzwg.cmm.word.count04" /></span>
		<table class="basic-table">
			<colgroup>
				<col width="5%" />
		        <col width="15%" />
		        <col width="10%" />
		        <col width="8%" />
				<col width="8%" />
				<col width="10%" />
				<col width="10%" />
			</colgroup>
			<thead>
			  <tr>
			  	<th>NO</th>
			  	<th><spring:message code="wzwg.site.usrmngr.msg.MSG013" /></th>
			  	<th><spring:message code="wzwg.cmm.word.id02" /></th>
			  	<th><spring:message code="wzwg.site.usrmngr.msg.MSG014" /></th>
			  	<th><spring:message code="wzwg.cmm.word.result" /></th>
			  	<th><spring:message code="wzwg.cmm.word.conect" /> IP</th>
			  	<th><spring:message code="wzwg.site.usrmngr.msg.MSG015" /></th> 
			  </tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${!empty mngrLoginlogList }">
						<c:forEach items="${mngrLoginlogList }" var="list" varStatus="status">
						  <tr>
					  		<td><c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.recordCountPerPage + status.count) + 1}" /></td>
			  				<td><c:out value="${list.siteNm}" /></td>
						  	<td><c:out value="${list.userId}" /></td>
						  	<td>
						  		<c:if test="${list.loginMthd eq 'I'}"><spring:message code="wzwg.cmm.word.login" /></c:if>
						  		<c:if test="${list.loginMthd eq 'O'}"><spring:message code="wzwg.cmm.word.logout" /></c:if>
						  	</td>
						  	<td>
						  		<c:if test="${list.errOccrrAt eq 'N'}"><spring:message code="wzwg.cmm.word.succes" /></c:if>
						  		<c:if test="${list.errOccrrAt eq 'Y'}"><spring:message code="wzwg.cmm.word.failr" /></c:if>
						  	</td>
						  	<td><c:out value="${list.loginIp}" /></td>
						  	<td><c:out value="${list.creatDt}" /></td> 
						  </tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="7"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</form>
	 
	 <c:if test="${!empty mngrLoginlogList}">
	 	<div class="ctr-box" id="pageInfo">
			<ul class="num mobile-none">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnPage" />
			</ul>
			
			<ul class="num pc-none">
				<ui:pagination paginationInfo="${mobilePaginationInfo}" type="image" jsFunction="fnPage" />
			</ul>
		</div>
	 </c:if>
 
