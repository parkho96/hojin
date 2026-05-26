<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 
<script>

$(document).ready(function(){
	$("#checkall").click(function(){
		if($("#checkall").prop("checked")){
			$("input[name=chkAppvlArr]").prop("checked", true);
		}else{
			$("input[name=chkAppvlArr]").prop("checked", false);
		}
	});
	
});

/**
 * 중복서브밋 방지
 * 
 * @returns {Boolean}
 */
var doubleSubmitFlag = false;
 
function doubleSubmitCheck(){
    if(doubleSubmitFlag){
        return doubleSubmitFlag;
    }else{
        doubleSubmitFlag = true;
        return false;
    }
}

function fnForm(){
		document.listFrm.action="<c:out value="${wzwg_contextPath}"/>/mngr/cmnt/info/registCmntInfoForm.do";
		document.listFrm.method="post";
		document.listFrm.submit();
}
function fnCmntInfo(cmntSeq){
	document.listFrm.cmntSeq.value =cmntSeq;
	document.listFrm.action="<c:out value="${wzwg_contextPath}"/>/mngr/cmnt/info/selectCmntInfo.do";
	document.listFrm.method="post";
	document.listFrm.submit();
}

function fn_search(pageIndex){
	if(isNaN(pageIndex)){console.log('잘못된 페이지호출');return;}
	 document.listFrm.pageIndex.value =pageIndex;
	 document.listFrm.action="<c:out value="${wzwg_contextPath}"/>/mngr/cmnt/info/selectCmntInfoList.do";
	 document.listFrm.submit();
}

function fnAllApproval(cmntApprovalCode){
	document.listFrm.cmntApprovalCode.value = cmntApprovalCode;
	
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/cmnt/info/allApprovalCmntMngrAjax.do'
		 , data:$("#listFrm").serialize() 
		 , success:function (data) {
			 	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.applc" text="apply" /></spring:argument></spring:message>');	
			 	fn_search('1');
		 }
		 , dataType: 'json'
	});
}



function fnSiteCmntOrdr(ordrGubun,cmntSeq,ordr) {
	
	document.listFrm.ordrGubun.value=ordrGubun;
	document.listFrm.cmntSeq.value=cmntSeq;
	document.listFrm.cmntOrdr.value=ordr;
	
	if(doubleSubmitCheck()) return;
	
	$.ajax({
		type:'POST'
		, url:'<c:out value="${wzwg_contextPath}"/>/mngr/cmnt/info/modifySiteCmntOrdrAjax.do'
		, data:$("#listFrm").serialize()
		, async : false
		, success:function (data){
			if(data.head.result == 'success'){
				var pageIdx = $('#pageIndex').val();
				if(pageIdx){
					fn_search(pageIdx);
				}else {
					fn_search(1);
				}
			}else{
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
			}
		}
		, error:function (request, status, error) {
              alert('<spring:message code="fail.common.msg" text="error" />');
          }
	});
	
}

</script> 
	 <div class="wz_notice brbox bg-white br-blue-strong">
		<ul class="wd100">
			<li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG089" /></li>
			<li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG090" /></li>
		</ul>
	 </div>

	 <form name="listFrm" id="listFrm" method="post">
		<input type="hidden" name="cmntSeq" id="cmntSeq" />
		<input type="hidden" name="cmntApprovalCode" id="cmntApprovalCode" />
		<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex }"/>"/>
		<input type="hidden" name="ordrGubun" />
		<input type="hidden" name="cmntOrdr" />
		
		<div class="main-menu-bar">
			<select name="cmntApprovalCodeSearch" id="cmntApprovalCodeSearch" onchange="fn_search('1')">
				<option value=""><spring:message code="wzwg.site.cmnt.msg.MSG007"/></option>
				<c:forEach items="${cmntApprovalCodeList}" var="result" varStatus="status" >
				<option value="<c:out value="${result.code}"/>" <c:if test="${paramVO.cmntApprovalCodeSearch eq result.code }">selected</c:if>><c:out value="${result.codeNm}"/></option>
				 </c:forEach>
			</select> 
		</div> 
		<table class="basic-table">	
				<thead>
					<tr>
						<th><ul class="wzForm"><li><label><input type="checkbox" id="checkall" name="checkall" class="checkall" value=" " /><span class="spanLabel"></span></label></li></ul></th>
						<!-- <th><spring:message code="wzwg.cmm.word.no" text="number" /></th> -->
						<th><spring:message code="wzwg.site.cmnt.msg.MSG010" /></th>
						<!-- <th><spring:message code="wzwg.cmm.word.author" text="authority" /></th> -->
						<th><spring:message code="wzwg.cmm.word.oprtr" text="id" /></th>
						<!-- <th><spring:message code="wzwg.cmm.word.id02" text="id" /></th>
						<th><spring:message code="wzwg.cmm.word.nm02" text="name" /></th> -->
						<!-- <th><spring:message code="wzwg.cmm.word.cttpc" text="contact place" /></th>
						<th><spring:message code="wzwg.cmm.word.email" text="email" /></th> -->
						<th class="wd10"><spring:message code="wzwg.site.cmnt.msg.MSG011" /></th>
						<th class="wd5"><spring:message code="wzwg.cmm.word.confm" text="consent" /></th>
						<th class="wd10"><spring:message code="wzwg.cmm.word.sort" /></th>
						<th class="wd10"><spring:message code="wzwg.cmm.word.manage" /></th>
					</tr>
				</thead>
				
				<tbody>
					<c:if test="${!empty resultList}">
					<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
	                   <td><ul class="wzForm"><li><label><input type="checkbox" id="chkAppvlArr" name="chkAppvlArr" value="<c:out value="${result.cmntSeq}"/>" /><span class="spanLabel"></span></label></li></ul></td>
	                   <!-- <td><c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.pageSize + status.count) + 1}"/></td> -->
	                   <td class="txt-l"><c:out value="${result.cmntNm}"/></td>
	                   <!-- <td><c:out value="${result.cmntMngrTy}"/></td> -->
	                   <td><c:out value="${result.cmntMngrNm}"/> <span class="grey">(<c:out value="${result.cmntMngrId}"/>)</span></td>
	                   <!-- <td><c:out value="${result.cmntTelno}"/></td>
	                   <td><c:out value="${result.cmntEmailAdres}"/></td> -->
	                   <td><c:out value="${result.frstRegistPnttm}"/></td>
	                   <td><c:out value="${result.cmntApprovalNm}"/></td>
	                   <td class="cmntSortBtns">
		                   <button class="btn-basic iconOnlyBtn btn-sortUp" onclick="fnSiteCmntOrdr('U','<c:out value="${result.cmntSeq}"/>', '<c:out value="${result.cmntOrdr}"/>')" title="<spring:message code="wzwg.cmm.word.up"/>"<c:if test="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.pageSize + status.count) + 1 eq resultCnt}"> style="color:#ccc;" disabled</c:if>>▲</button>
						   <button class="btn-basic iconOnlyBtn btn-sortDown" onclick="fnSiteCmntOrdr('D','<c:out value="${result.cmntSeq}"/>', '<c:out value="${result.cmntOrdr}"/>')" title="<spring:message code="wzwg.cmm.word.down"/>"<c:if test="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.pageSize + status.count) + 1 eq 1}"> style="color:#ccc;" disabled</c:if>>▼</button>
	                   </td>
	                   <td><a href="javascript:;" onclick="fnCmntInfo('<c:out value="${result.cmntSeq}"/>')" class="iconOnlyBtn btn-basic btn-modify" title="<spring:message code="wzwg.cmm.word.updt" />"><spring:message code="wzwg.cmm.word.updt" /></a></td>
					</tr>
					</c:forEach>
					</c:if>
				</tbody>
		</table>
				
				
				
	  <div class="of mg_t20">
	  	<div class="ctr-box" id="pageInfo">
			<ul class="num mobile-none">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
			</ul>
			
			<ul class="num pc-none">
				<ui:pagination paginationInfo="${mobilePaginationInfo}" type="image" jsFunction="fn_search" />
			</ul>
		</div>
	  </div>
		
	    <div class="rt-box">
			<a href="javascript:void(0);" onclick="javascript:fnAllApproval('SC00000339');" class="wzbtn btn-basic fl" style="margin-right:5px;"><spring:message code="wzwg.site.cmnt.msg.MSG012" text="choise" /></a>
			<a href="javascript:void(0);" onclick="javascript:fnAllApproval('SC00000340');" class="wzbtn btn-del fl"><spring:message code="wzwg.site.cmnt.msg.MSG013" text="choise" /></a>
			<a href="javascript:void(0);" onclick="javascript:fnForm();" class="wzbtn btn-save bg"><spring:message code="wzwg.cmm.word.regist" text="registration" /></a>
        </div>
		<div class="ctr-box">
				<select name="searchCondition"  id="searchCondition">
					<option value="1" <c:if test="${paramVO.searchCondition eq '1' }">selected="true"</c:if>><spring:message code="wzwg.site.cmnt.msg.MSG010" text="comunity" /></option> 
					<option value="2" <c:if test="${paramVO.searchCondition eq '2' }">selected="true"</c:if>><spring:message code="wzwg.cmm.word.nm02" text="name" /></option>
					<option value="3" <c:if test="${paramVO.searchCondition eq '3' }">selected="true"</c:if>><spring:message code="wzwg.cmm.word.id02" text="id" /></option>
				</select>
				<input type="text" class="txt" name="searchKeyword" value="<c:out value="${paramVO.searchKeyword }"/>"/>
				<a href="javascript:void(0);"  onclick="fn_search('1')" class="wzbtn-table btn-srch"><spring:message code="wzwg.cmm.word.search01" text="search" /></a>
		</div>
	</form>