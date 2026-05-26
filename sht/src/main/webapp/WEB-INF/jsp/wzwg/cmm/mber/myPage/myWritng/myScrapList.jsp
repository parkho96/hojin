<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<% 
	String getUrl = request.getServerName().toString();
	String getPort = String.valueOf(request.getServerPort());
	if(getPort.equals("80")){getPort="";} else {getPort= ":"+getPort;}
%>

<script type="text/javascript">


$(document).ready(function() {
	
	// 삭제
	$('#delete_btn').click(function(){
		if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
			return;
		}else{
			var checkCnt = 0;
			var nttChkArr = "";

			$("input[name=nttChk]").each(function(){
				if(this.checked){
					nttChkArr += $(this).val() + ",";
					checkCnt++;
				}
			});
			
			if(checkCnt < 1){
				alert('<spring:message code="wzwg.cmm.msg.MSG087" />');
				return;
			}
				
			var frm = document.listFrm;
			
			frm.checkNttSeq.value = nttChkArr;
			
			$.ajax({
					type:'POST'
				, url:'<c:out value="${wzwg_contextPath}${prefix}" />/module/ntt/scrap/deleteNttScrapAjax.do'
				, cache : false
				, async : false
				, data:$("#listFrm").serialize()
				, success:function (result) {
					var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value == 'success'){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
						fnPage(1);
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
					}
					}
			   , error:function (request, status, error) {
			 	  alert('<spring:message code="fail.common.msg" text="error" />');
			   }
			   , dataType: 'xml'
			});
		}
	});
	
	// 체크박스 전체선택 / 해제
	$("input[name=nttAllChk]").on('click', function(){
		var boolean_chk = $("input[name=nttAllChk]").get(0).checked;
		$("input[name=nttChk]").each(function(){
			this.checked = boolean_chk;
		});
	});
	
	
});



	function fnSearch(callId){
		var frm = document.listFrm;
		
		frm.searchAt.value = "";
		
		if(frm.searchKeyword.value != ""){
			frm.searchAt.value = "Y";	
		}
		
		frm.pageIndex.value = 1;
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}" />/cmm/mber/myPage/selectMyScrapListAjax.do'
			, cache : false
			, async : false
			, data:$("#listFrm").serialize()
			, success:function (data) {
				$('#list_area').html(data);
				$("#content").css("height",$(document).height());
				//$(window).scrollTop(0);
				if(callId != undefined || callId != ''){
	            	$('#' + callId).focus();
	            }
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
	function fnPage(pageIndex){
		var frm = document.listFrm;
		
		frm.pageIndex.value = pageIndex;
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}" />/cmm/mber/myPage/selectMyScrapListAjax.do'
			, cache : false
			, async : false
			, data:$("#listFrm").serialize()
			, success:function (data) {
				$('#list_area').html(data);
				$("#content").css("height",$(document).height());
				//$(window).scrollTop(0);
				$('#pageInfo').find('.on>a').focus();
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
	function fnDetail(menuSeq, nttSeq){
		
		var getUrl = "http://<%=getUrl%><%=getPort%>/subList/"+menuSeq+"?pmode=detail&nttSeq="+nttSeq;
		
		var frm = document.listFrm;
		frm.action = getUrl;
		frm.target = "_blank";
		frm.submit();
	}
	
</script>
         
	<form:form modelAttribute="paramVO" path="listFrm" id="listFrm" name="listFrm" method="post">
		<form:hidden path="siteSeq" />
		<form:hidden path="bbsSeq" />
		<form:hidden path="nttSeq" />
		<form:hidden path="pageIndex" />
		<form:hidden path="searchCnd" />
		<form:hidden path="searchAt" />
		<form:hidden path="checkNttSeq" />
		
		<div class="sbscrb005">
			
			<table class="basic-table01">
			<caption><spring:message code="wzwg.cmm.word.scrapnttlist" /></caption>
			<colgroup>
				<col width="5%">
				<col width="5%">
				<col width="15%">
				<col width="15%">
				<col width="*">
				<col width="10%">
				<col width="10%">
			</colgroup>
			<thead>
			<tr>
				<th scope="col"><input type="checkbox" name="nttAllChk" id="nttAllChk" title="<spring:message code="wzwg.cmm.word.rowallchoise" />"/></th>					
				<th scope="col">No</th>
				<th scope="col"><spring:message code="wzwg.cmm.word.scrapgroupnm" /></th>
				<th scope="col"><spring:message code="wzwg.cmm.word.bbs" /></th>
				<th scope="col"><spring:message code="wzwg.cmm.word.nttsj" /></th>
				<th scope="col"><spring:message code="wzwg.cmm.word.wrter" /></th>
				<th scope="col"><spring:message code="wzwg.cmm.word.rgsde" /></th>
			</tr>
			</thead>
			<tbody>
				<c:if test="${!empty resultList}">
					<c:forEach var="resultList" items="${resultList}" varStatus="status">
					
					<tr>
						<td><input type="checkbox" name="nttChk" id="nttChk" value="<c:out value="${resultList.scrapSeq}" />" title="<spring:message code="wzwg.cmm.word.rowchoise" />"/></td>				
						<td class="txt-c"><c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.recordCountPerPage + status.count) + 1}" /></td>
						<td class="txt-c"><c:out value="${resultList.groupNm}" /></td>
						<td class="txt-c"><c:out value="${resultList.bbsNm}" /></td>
						<td class="txt-l">
							<c:choose>
								<c:when test="${!empty resultList.nttSj}">
									<c:if test="${fn:length(resultList.nttSj) > 43}">
										<c:set var="nttSj"><c:out value="${fn:substring(resultList.nttSj, 0, 43)}" />...</c:set>
									</c:if>
									<c:if test="${fn:length(resultList.nttSj) < 44}">
										<c:set var="nttSj"><c:out value="${resultList.nttSj}" /></c:set>
									</c:if>
								</c:when>
								<c:otherwise>
									<c:set var="nttSj"><spring:message code="wzwg.cmm.word.untitle"/></c:set>
								</c:otherwise>
							</c:choose>
						
							<a href="javascript:void(0);" onclick="fnDetail('<c:out value="${resultList.menuSeq}" />', '<c:out value="${resultList.nttSeq}" />');" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />" ><c:out value="${nttSj}" /></a>
						</td>
						<td class="txt-c">
						<c:choose>
							<c:when test="${adminAuthAt eq 'Y' }">
									<c:out value="${resultList.ntcrNm}" />
							</c:when>
							<c:otherwise>
								<c:if test="${resultList.annymtyAt eq 'Y'}">
										***
								</c:if>
								<c:if test="${resultList.annymtyAt ne 'Y'}"><c:out value="${resultList.ntcrNm}" /></c:if>							
							</c:otherwise>
						</c:choose>
						</td>
						<td class="txt-c"><c:out value="${resultList.frstRegistPnttm}" /></td>
					</tr>
					
					</c:forEach>
				</c:if>	
				
				<c:if test="${empty resultList}">
					<tr>
						<td colspan="7"><spring:message code="wzwg.cmm.msg.MSG085" /></td>
					</tr>
				</c:if>	
			</tbody>
			</table>
			
			<div class="rt-box">
			<a href="javascript:void(0);" class="wzbtn btn-del " id="delete_btn"><spring:message code="wzwg.cmm.word.choisedelete" /></a>
			</div>
			
			<c:if test="${!empty resultList}">
			<div class="ctr-box" id="pageInfo">
				<ul class="num mobile-none">
					<div class="ctr-box" id="pageInfo">
					    <ul class="num mobile-none">
					        <ui:pagination paginationInfo="${paginationInfo}" type="ntt" jsFunction="fnPage" />
					    </ul>
					</div>
				</ul>
				
				<ul class="num pc-none">
					<ui:pagination paginationInfo="${mobilePaginationInfo}" type="ntt" jsFunction="fnPage" />
				</ul>
			</div>
			</c:if>
			<c:set var="searchTit"><spring:message code="wzwg.cmm.word.searchse" /></c:set>
			<c:set var="searchkeyinp"><spring:message code="wzwg.cmm.word.searchkeywordinput" /></c:set>
			
			<div class="txt-c" id="nttSearch">
				<form:select path="searchCondition" id="searchCondition" title="<c:out value="${searchTit}" />">  
					<form:option value="1"><label for="option1"><spring:message code="wzwg.cmm.word.sj" />+<spring:message code="wzwg.cmm.word.cn" /></label></form:option>
					<form:option value="2"><label for="option2"><spring:message code="wzwg.cmm.word.sj" /></label></form:option>
					<form:option value="3"><label for="option3"><spring:message code="wzwg.cmm.word.wrternm" /></label></form:option>
				</form:select>
				
				<c:set var="srchwrd">
					<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
				</c:set>
				<form:input path="searchKeyword" id="searchKeyword" placeholder="${fn:escapeXml(srchwrd)}" cssClass="txt" onkeydown="if(event.keyCode == 13){fnPage(1);}" title="${fn:escapeXml(searchkeyinp)}"/>
				<a href="javascript:void(0);" id="btn_search" class="wzbtn-table btn-srch" onclick="fnSearch('btn_search');"><spring:message code="wzwg.cmm.word.search01" /></a>		 
			</div>
			
		</div>
	
	</form:form>
    