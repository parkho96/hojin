<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 
<script>
function fnForm(){
		document.listFrm.action="<c:out value="${wzwg_contextPath}"/>/mngr/cmnt/info/registCmntInfoForm.do";
		document.listFrm.method="post";
		document.listFrm.submit();
}

function fnSetMngrSeq(usrSeq,userId,userNm){
	$("#cmntMngrSeq").val(usrSeq);
	$("#cmntMngrNm").val(userNm+"("+userId+")");
	fnLayerPopupClose();
}

function fn_search(pageIndex){
	if(isNaN(pageIndex)){console.log('잘못된 페이지호출');return;}
	 document.mngrFrm.pageIndex.value =pageIndex;
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/cmnt/info/searchCmntMngrAjax.do' 
		 , data:$("#mngrFrm").serialize() 
		 , success:function (data) {
			 	$(".pop-container").html(data);  
					 // 부모코드 셋팅 
					// fnGetMenuList();
				//	 document.getElementById("menuNm").focus();
				   }
		 , dataType: 'html'
	});
	 
}
</script>  

			<div class="pop-conts" style="">
				<form name="mngrFrm" id="mngrFrm" onsubmit="return false;">
					<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex }"/>"/>
					
				<div class="main-menu-bar">
					<select name="searchCondition"  id="searchCondition">
						<option value="0"><spring:message code="wzwg.cmm.word.all" /></option>
						<option value="1" <c:if test="${paramVO.searchCondition eq '1' }">selected="true"</c:if>><spring:message code="wzwg.cmm.word.nm02" /></option> 
						<option value="2" <c:if test="${paramVO.searchCondition eq '2' }">selected="true"</c:if>><spring:message code="wzwg.cmm.word.id02" /></option>
					</select>
					<input type="text" class="txt" name="searchKeyword" value="<c:out value="${paramVO.searchKeyword }"/>" onkeypress="if(window.event.keyCode == 13) {fn_search('1');}"/>
					<a href="javascript:void(0);"  onclick="fn_search('1')" class="wzbtn-table btn-srch"><spring:message code="wzwg.cmm.word.search01" /></a>
				</div>
				
				<table class="basic-table">
				<colgroup>
					<col width="15%"/>
					<col width="20%"/>
					<col width="*"/>
					<col width="15%"/>
				</colgroup>
				<thead>
				<tr>
					<th>NO</th>
					<th>회원아이디</th>
					<th><spring:message code="wzwg.cmm.word.nm02" /></th>
					<th><spring:message code="wzwg.cmm.word.choise" /></th> 
				</tr>
				</thead>
				
				<tbody>
				
				<c:if test="${!empty usrInfoList}">
				<c:forEach var="result" items="${usrInfoList}" varStatus="status">
				<tr>
	               <td><c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.pageSize + status.count) + 1}"/></td>
					<td><c:out value="${result.userId}"/></td>
					<td><c:out value="${result.userNm}"/></td>
					<td> <a href="javascript:;" onclick="fnSetMngrSeq('<c:out value="${result.usrSeq}"/>','<c:out value="${result.userId}"/>','<c:out value="${result.userNm}"/>')"  class="wzbtn-table btn-basic"><spring:message code="wzwg.cmm.word.choise" /></a></td> 
				</tr>
				</c:forEach>
				</c:if>
							
				</tbody>
				</table>
				
				</form>
				
				<div class="of mg_t20">
					<div class="ctr-box">
						<ul class="num">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
						</ul>
					</div>
				</div>
			</div>
