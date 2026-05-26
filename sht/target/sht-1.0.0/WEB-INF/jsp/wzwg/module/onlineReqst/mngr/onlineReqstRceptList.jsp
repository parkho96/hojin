<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">

	$(document).ready(function(){
			

	});
	
	function fnPage(pageIndex) {
		if(isNaN(pageIndex)){console.log('잘못된 페이지호출');return;}
		var frm = document.getElementById("listFrm");
		frm.pageIndex.value = pageIndex;	
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineReqst/selectOnlineReqstRceptListAjax.do'
	      , dataType: 'html'
	      , cache : false
	      , data:$("#listFrm").serialize()
	      , success:function (data) {
	    	  $('#onlineReqstRcept_area').html(data);
	      }
	      , error:function (data) {
	          alert('<spring:message code="wzwg.cmm.msg.MSG076" />');
	      }	            
	 	});  
	}			

	function fnCheckDelete(){
		var frm = document.getElementById("listFrm");
		
		var checkList = document.getElementsByName("rceptSeqChk");
		var rceptSeqChkStr = "";
		var checkCnt = 0;

		for(var i=0; i<checkList.length; i++){
			if(checkList[i].checked == true){
				rceptSeqChkStr = rceptSeqChkStr + checkList[i].value + ",";
				checkCnt++;
			}
		}
		
		if(checkCnt < 1){
			alert('<spring:message code="wzwg.cmm.msg.MSG087" />');
			return false;
		}

		if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" text="delete" /></spring:argument></spring:message>')){
			frm.rceptSeqChkStr.value = rceptSeqChkStr; 
			$.ajax({
			    type : "POST"
			    , url : "<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineReqst/deleteOnlineReqstRceptAjax.do"
			    , dataType : "html"
			    , cache : false
			    , data : $("#listFrm").serialize()
			    , success : function(response, status, request) {
			    	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
					fnPage('1');
			    }
			    , error : function(request, status, error) { 
				    alert('<spring:message code="fail.common.msg" text="error" />');
			    }
			});			
		}	

	}

	function fnCheckBoxAll(obj){
		var checkBoolean = (obj.checked)? true: false; 
		var checkList = document.getElementsByName("rceptSeqChk"); 

		for (var i=0; i<checkList.length; i++) { 
			checkList[i].checked = checkBoolean; 
		} 
	}		

	function fnConfmRegist(){
		var frm = document.getElementById("listFrm");
		
		var checkList = document.getElementsByName("rceptSeqChk");
		var confmCodeBeforeList = document.getElementsByName("confmCodeBefore");
		var confmCodekList = document.getElementsByName("confmSttusCode");
		var rceptSeqChkStr = "";
		var checkCnt = 0;

		for(var i=0; i<checkList.length; i++){
			if(confmCodeBeforeList[i].value != confmCodekList[i].value){
				rceptSeqChkStr = rceptSeqChkStr + checkList[i].value + "|" + confmCodekList[i].value + ",";
				checkCnt++;
			}
		}
		
		if(checkCnt == 0) {
			alert('<spring:message code="wzwg.cmm.msg.MSG169" />');
			return false;
		}

		if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>')){
			frm.rceptSeqChkStr.value = rceptSeqChkStr; 
			$.ajax({
			    type : "POST"
			    , url : "<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineReqst/modifyOnlineReqstRceptAjax.do"
			    , dataType : "html"
			    , cache : false
			    , data : $("#listFrm").serialize()
			    , success : function(response, status, request) {
			    	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>');
			    	fnPage(1);
			    }
			    , error : function(request, status, error) { 
				    alert('<spring:message code="fail.common.msg" text="error" />');
			    }
			});			
		}	
	}	
	
	function fnReqstNttList(){
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineReqst/selectOnlineReqstNttListAjax.do'
			, cache : false
			, async : false
			, data : $("#searchFrm").serialize()
			, success : function(data) {
				$('#onlineReqst_area').html(data);
			}
			, error : function(data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});	
	};		
</script>
	
	<h3 class="wzAdmSTit wd100 fl mt50"><spring:message code="wzwg.module.word.applcntlist" /></h3>
	
	<form id="listFrm" name="listFrm" method="post">
		<input type="hidden" id="reqstnttSeq" name="reqstnttSeq" value="<c:out value="${paramVO.reqstnttSeq}" />" /> 
		<input type="hidden" id="rceptSeq" name="rceptSeq" /> 
		<input type="hidden" id="rceptSeqChkStr" name="rceptSeqChkStr" />
		<input type="hidden" id="pageIndex" name="pageIndex" value="<c:out value="${paramVO.pageIndex}" />" />

		<div class="main-menu-bar">

			<select id="searchConfmSttusCode" name="searchConfmSttusCode" class="w10">
				<option value=""><spring:message code="wzwg.cmm.word.all" /></option>
				<c:forEach items="${reqcscList}" var="reqcscList" varStatus="status">
					<c:choose>
						<c:when test="${reqcscList.code eq paramVO.searchConfmSttusCode}">
							<option value="<c:out value="${reqcscList.code}" />" selected><c:out value="${reqcscList.codeNm}" /></option>
						</c:when>
						<c:otherwise>
							<option value="<c:out value="${reqcscList.code}" />"><c:out value="${reqcscList.codeNm}" /></option>
						</c:otherwise>
					</c:choose>
				</c:forEach>								
			</select>
			<select name="searchCondition" id="searchCondition" class="w10" title="<spring:message code="wzwg.module.word.searchse" />"> 
				<option value="" <c:if test="${paramVO.searchCondition eq ''}"> selected</c:if>><spring:message code="wzwg.cmm.word.all" /></option>
				<option value="1" <c:if test="${paramVO.searchCondition eq '1'}"> selected</c:if>><spring:message code="wzwg.cmm.word.id02" /></option>
				<option value="2" <c:if test="${paramVO.searchCondition eq '2'}"> selected</c:if>><spring:message code="wzwg.cmm.word.nm02" /></option>
			</select>
			
			<c:set var="srchwrd">
				<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
			</c:set>
			
			<input type="text" name="searchKeyword" id="searchKeyword" value="<c:out value="${paramVO.searchKeyword}" />" title="<spring:message code="wzwg.cmm.word.srchwrd" />" class="txt w30" placeholder="<c:out value="${srchwrd}" />" onkeydown="if(event.keyCode == 13){fnPage('1');}" />
			<a href="javascript:void(0);" onclick="fnPage('1');" class="wzbtn-table btn-srch"><spring:message code="wzwg.cmm.word.search01" /></a>				
		
			<select id="pageUnit" name="pageUnit" title="<spring:message code="wzwg.module.word.pagesearchcount" />" onchange="fnPage('1');" class="fr w5">
					<option value="10" <c:if test="${paramVO.recordCountPerPage eq 10}">selected="selected"</c:if>>10 <spring:message code="wzwg.cmm.word.count04" /></option>
					<option value="30" <c:if test="${paramVO.recordCountPerPage eq 30}">selected="selected"</c:if>>30 <spring:message code="wzwg.cmm.word.count04" /></option>
					<option value="50" <c:if test="${paramVO.recordCountPerPage eq 50}">selected="selected"</c:if>>50 <spring:message code="wzwg.cmm.word.count04" /></option>
			</select>
			
		</div>
	
	</form>			

	<table class="basic-table">
		  <colgroup>
			<col width="10%" />
			<col width="10%" />
			<col width="15%" />
			<col width="15%" />
			<col width="15%" />
			<col width="15%" />
			<col width="*" />		
	      </colgroup>
		  <thead>
			<tr>
				<th><input type="checkbox" name="rceptSeqAllChk" id="rceptSeqAllChk" onclick="fnCheckBoxAll(this);"/></th>
				<th>No</th>
				<th><spring:message code="wzwg.cmm.word.id02" /></th>
				<th><spring:message code="wzwg.cmm.word.nm02" /></th>
				<th><spring:message code="wzwg.module.word.reqstde" /></th>
				<th><spring:message code="wzwg.module.word.confmprocess" /></th>
				<th><spring:message code="wzwg.module.word.atchfile" /></th>	
			</tr>
	      </thead>
		  <tbody>
			<c:if test="${empty resultList}">
				<tr>
					<td colspan="7"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
				</tr>
			</c:if>		  
			<c:if test="${!empty resultList }">
			<c:forEach items="${resultList}" var="resultList" varStatus="status">
				<tr>
					<td>
						<input type="checkbox" name="rceptSeqChk" id="rceptSeqChk" value="<c:out value="${resultList.rceptSeq}" />" />
					</td>
					<td>
						<c:out value="${totCnt - (searchVO.pageIndex-1) * searchVO.pageSize - status.count + 1}"/>
					</td>
					<td>
						<c:out value="${resultList.userId}"></c:out>									
					</td>
					<td>
						<c:out value="${resultList.userNm}"></c:out>									
					</td>
					<td>
						<c:out value="${resultList.frstRegistPnttm}" />
					</td>
					<td>
						<input type="hidden" name="confmCodeBefore" id="confmCodeBefore" value="<c:out value="${resultList.confmSttusCode}" />"/>
						<select name="confmSttusCode" id="confmSttusCode">
							<c:forEach items="${reqcscList}" var="reqcscList" varStatus="status">
								<c:choose>
									<c:when test="${reqcscList.code eq resultList.confmSttusCode}">
										<option value="<c:out value="${reqcscList.code}" />" selected><c:out value="${reqcscList.codeNm}" /></option>
									</c:when>
									<c:otherwise>
										<option value="<c:out value="${reqcscList.code}" />"><c:out value="${reqcscList.codeNm}" /></option>
									</c:otherwise>
								</c:choose>
							</c:forEach>								
						</select>											
					</td>
					<td> 
						<c:if test="${!empty resultList.atchFileId}">
							<c:import url="${wzwg_contextPath}/module/upload/file/selectFileInc.do" charEncoding="utf-8">
								<c:param name="param_atchFileId" 	value="${resultList.atchFileId}" />
								<c:param name="param_updateFlag" 	value="N" />
								<c:param name="param_atchFileNumber" value="1" />
								<c:param name="param_cntntsSeq" value="${paramVO.rceptSeq}" />
							</c:import>					
						</c:if>	
					</td>
				</tr>					
			</c:forEach>
			</c:if>
		  </tbody>
	</table>
	<div class="ctr-box" id="pageInfo">
		<ul class="num mobile-none">
			<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnPage" />
		</ul>
		
		<ul class="num pc-none">
			<ui:pagination paginationInfo="${mobilePaginationInfo}" type="image" jsFunction="fnPage" />
		</ul>
	</div>
	<div class="rt-box">
		<a href="javascript:void(0);" onclick="fnCheckDelete();" class="wzbtn btn-del fl"><spring:message code="wzwg.module.word.choisedelete" /></a>
		<a href="javascript:void(0);" onclick="fnConfmRegist();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
		<a href="javascript:void(0);" onclick="fnReqstNttList();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.cancl" /></a>		
	</div>	
	
	</form>
	
