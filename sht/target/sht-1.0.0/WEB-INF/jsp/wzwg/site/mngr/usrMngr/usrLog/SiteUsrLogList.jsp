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
			 
			document.siteUsrLogForm.pageIndex.value = paramPageIndex;
			document.siteUsrLogForm.action='<c:out value="${wzwg_contextPath}" />/sysMngr/usrLog/selectSiteUsrLogList.do';
			document.siteUsrLogForm.submit();
		 }
	</script>
	
	<form id="siteUsrLogForm" name="siteUsrLogForm" method="post"> 
  	    <input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex }" />"/>
  	    
  	    <div class="wz_notice brbox bg-white br-blue-strong">	
		    <ul class="wd100">
			    <li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG151" /></li>
			    <li class="admpg-subp wd100 mb0">· <spring:message code="wzwg.cmm.msg.tip.MSG152" /></li>
		    </ul>
		</div>
		
		<div class="main-menu-bar">
			<select name="siteSeq" id="siteSeq" onchange="fnSearch();">
				<option value="" <c:if test="${empty paramVO.siteSeq }">selected="selected"</c:if>><spring:message code="wzwg.site.usrmngr.msg.MSG016" /></option>
				<option value="10000000001" <c:if test="${paramVO.siteSeq eq '10000000001' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.sysmngr" /></option>
				<c:forEach items="${siteInfoList }" var="siteInfoList" varStatus="status">
					<option value="<c:out value="${siteInfoList.siteSeq }" />" <c:if test="${paramVO.siteSeq eq siteInfoList.siteSeq}">selected="selected"</c:if>>
						<c:out value="${siteInfoList.siteFullNm }"/>
					</option>
				</c:forEach>
			 </select>
			 <select name="usrChngCode" id="usrChngCode" onchange="fnSearch();">
				<option value="" <c:if test="${empty paramVO.usrChngCode }">selected="selected"</c:if>><spring:message code="wzwg.site.usrmngr.msg.MSG017" /></option>
				<c:forEach items="${codeList }" var="list" varStatus="status">
					<option value="<c:out value="${list.code }" />" <c:if test="${paramVO.usrChngCode eq list.code}">selected="selected"</c:if>>
						<c:out value="${list.codeNm }"/>
					</option>
				</c:forEach>
			 </select>
			
			<c:set var="srchwrd">
				<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
			</c:set>
			<input type="text" class="datePicker txt"  readonly="readonly" name="searchKeywordFrom" value="<c:out value="${paramVO.searchKeywordFrom}" />"  title="<spring:message code="wzwg.cmm.word.bgnde"/>" placeholder="<spring:message code="wzwg.cmm.word.bgnde"/>" />
			~<input type="text" class="datePicker txt"   readonly="readonly" name="searchKeywordTo" value="<c:out value="${paramVO.searchKeywordTo}" />"   title="<spring:message code="wzwg.cmm.word.endde"/>" placeholder="<spring:message code="wzwg.cmm.word.endde"/>" />
			<br/>
			<div class="mt10">
				<select name="searchCondition" id="searchCondition" >
					<option value="" <c:if test="${empty paramVO.searchCondition }">selected="selected"</c:if> ><spring:message code="wzwg.cmm.word.all" /></option>
					 <option value="1" <c:if test="${paramVO.searchCondition eq '1'}">selected="selected"</c:if>><spring:message code="wzwg.site.usrmngr.msg.MSG020"/></option>
					 <option value="2" <c:if test="${paramVO.searchCondition eq '2'}">selected="selected"</c:if>><spring:message code="wzwg.site.usrmngr.msg.MSG019"/></option>
					 <option value="3" <c:if test="${paramVO.searchCondition eq '3'}">selected="selected"</c:if>><spring:message code="wzwg.site.usrmngr.msg.MSG023"/></option>
				 </select>
				<input type="text" name="searchKeyword" id="searchKeyword" placeholder="<c:out value="${srchwrd}" />" class="txt" onkeypress="if(window.event.keyCode == 13) {fnSearch();}" value="<c:out value="${paramVO.searchKeyword}" />"/>
		 		<a href="javascript:void(0);" class="wzbtn-table btn-srch" onclick="fnSearch();"><spring:message code="wzwg.cmm.word.search01" /></a>
	 		</div>
		</div>
		<span class="fr mb15"><spring:message code="wzwg.cmm.word.total"/> <c:out value="${totCnt }" /> <spring:message code="wzwg.cmm.word.count04"/></span>
		<table class="basic-table">
			<colgroup>
				<col width="10%" />
				<col width="8%" />
		        <col width="8%" />
		        <col width="8%" />
		        <col width="*" />
				<col width="10%" />
				<col width="10%" />
				<col width="6%" />
			</colgroup>
			<thead>
			  <tr>
			  	<th><spring:message code="wzwg.site.usrmngr.msg.MSG018" /></th>
			  	<th><spring:message code="wzwg.site.usrmngr.msg.MSG019" /></th>
			  	<th><spring:message code="wzwg.site.usrmngr.msg.MSG020" /></th>
			  	<th><spring:message code="wzwg.site.usrmngr.msg.MSG021" /></th>
			  	<th style="word-break:break-all"><spring:message code="wzwg.cmm.word.execut" /><br />URL</th>
			  	<th style="word-break:break-all"><spring:message code="wzwg.cmm.word.execut" /><br />PARAMETER</th>
			  	<th><spring:message code="wzwg.cmm.word.conect" /><br />IP</th> 
			  	<th><spring:message code="wzwg.site.usrmngr.msg.MSG015" /></th>
			  </tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${!empty siteUsrLogList }">
						<c:forEach items="${siteUsrLogList }" var="list" varStatus="status">
						  <tr>
				  				<td><c:out value="${list.siteNm}" /></td>
							  	<td><c:out value="${list.userId}" /></td>
							  	<td><c:out value="${list.trgtUserId}" /></td>
							  	<td><c:out value="${list.chngNm}" /></td>
							  	<td style="word-break:break-all"><c:out value="${list.usrlogUrl}" /></td>
							  	<td style="word-break:break-all"><c:out value="${list.usrlogParam}" /></td>
							  	<td><c:out value="${list.conectIp}" /></td> 
							  	<td><c:out value="${list.frstRegistPnttm}" /></td>
						  </tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="9"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</form>
	 
	 <c:if test="${!empty siteUsrLogList}">
	 	<div class="ctr-box" id="pageInfo">
			<ul class="num mobile-none">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnPage" />
			</ul>
			
			<ul class="num pc-none">
				<ui:pagination paginationInfo="${mobilePaginationInfo}" type="image" jsFunction="fnPage" />
			</ul>
		</div>
	 </c:if>
 
