<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">

	$(document).ready(function(){		

		$('#regist_form_btn').click(function(){

			$.ajax({
				  type : 'POST'
				, dataType : 'html'
				, url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineReqst/registOnlineReqstNttFormAjax.do'
				, cache : false
				, async : false
				, data : $("#listFrm").serialize()
				, success : function(data) {
					$('#onlineReqst_area').html(data);
				}
				, error : function(data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});			
		});		
	
	});	
		
	function fnPage(pageIndex) {
		if(isNaN(pageIndex)){console.log('잘못된 페이지호출');return;}
		var frm = document.getElementById("listFrm");
		frm.pageIndex.value = pageIndex;	
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineReqst/selectOnlineReqstNttListAjax.do'
	      , dataType: 'html'
	      , cache : false
	      , data:$("#listFrm").serialize()
	      , success:function (data) {
	    	  $('#onlineReqst_area').html(data);
	      }
	      , error:function (data) {
	          alert('<spring:message code="wzwg.cmm.msg.MSG076" />');
	      }	            
	 	});  
	}		
	
	function fnDelete(reqstnttSeq) {
		var frm = document.getElementById("listFrm");
		if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" text="delete" /></spring:argument></spring:message>')){
			
			frm.reqstnttSeq.value = reqstnttSeq; 
			$.ajax({
			    type : "POST"
			    , url : "<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineReqst/deleteOnlineReqstNttAjax.do"
			    , dataType : "html"
			    , cache : false
			    , data : $("#listFrm").serialize()
			    , success : function(response, status, request) {
			    	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
					fnPage(1);
			    }
			    , error : function(request, status, error) { 
				    alert('<spring:message code="fail.common.msg" text="error" />');
			    }
			});			
		}
	}	
	
	function fnCheckDelete(){
		var frm = document.getElementById("listFrm");
		
		var checkList = document.getElementsByName("reqstnttSeqChk");
		var reqstnttSeqChkStr = "";
		var checkCnt = 0;

		for(var i=0; i<checkList.length; i++){
			if(checkList[i].checked == true){
				reqstnttSeqChkStr = reqstnttSeqChkStr + checkList[i].value + ",";
				checkCnt++;
			}
		}
		
		if(checkCnt < 1){
			alert('<spring:message code="wzwg.cmm.msg.MSG087" />');
			return false;
		}

		if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" text="delete" /></spring:argument></spring:message>')){
			frm.reqstnttSeqChkStr.value = reqstnttSeqChkStr; 
			$.ajax({
			    type : "POST"
			    , url : "<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineReqst/deleteOnlineReqstNttAjax.do"
			    , dataType : "html"
			    , cache : false
			    , data : $("#listFrm").serialize()
			    , success : function(response, status, request) {
			    	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
					fnPage(1);
			    }
			    , error : function(request, status, error) { 
				    alert('<spring:message code="fail.common.msg" text="error" />');
			    }
			});			
		}	

	}
	
	function fnCheckBoxAll(obj){
		var checkBoolean = (obj.checked)? true: false; 
		var checkList = document.getElementsByName("reqstnttSeqChk"); 

		for (var i=0; i<checkList.length; i++) { 
			checkList[i].checked = checkBoolean; 
		} 
	}		
	
	function fnModify(reqstnttSeq){
		var frm = document.getElementById("listFrm");
		frm.reqstnttSeq.value = reqstnttSeq;
		
		$.ajax({
			  type : 'POST'
			, dataType : 'html'
			, url : "<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineReqst/modifyOnlineReqstNttFormAjax.do"
			, cache : false
			, async : false
			, data : $("#listFrm").serialize()
			, success : function(data) {
				$('#onlineReqst_area').html(data);
			}
			, error : function(data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});			
	}	
	
	function fnDetail(reqstnttSeq){
		var frm = document.getElementById("listFrm");
		frm.reqstnttSeq.value = reqstnttSeq;
		
		$.ajax({
			  type : 'POST'
			, dataType : 'html'
			, url : "<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineReqst/selectOnlineReqstNttDetailAjax.do"
			, cache : false
			, async : false
			, data : $("#listFrm").serialize()
			, success : function(data) {
				$('#onlineReqst_area').html(data);
			}
			, error : function(data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});			
	}	

</script>
		   
		<form:form modelAttribute="paramVO" path="listFrm" id="listFrm" name="listFrm" method="post" onsubmit="return false">
			<input type="hidden" name="pageIndex" value="<c:out value="${paramVO.pageIndex}" />" />
			<input type="hidden" name="checkResult" value="0">
			<input type="hidden" name="reqstSeq" value="<c:out value="${paramVO.reqstSeq}" />" />
			<input type="hidden" name="reqstnttSeq" />
			<input type="hidden" name="reqstnttSeqChkStr" />

			<div class="main-menu-bar">

				<select id="progrsSttusCode" name="progrsSttusCode" class="w10">
					<option value=""><spring:message code="wzwg.cmm.word.all" /></option>
					<c:forEach items="${reqpscList}" var="reqpscList" varStatus="status">
						<c:choose>
							<c:when test="${reqpscList.code eq paramVO.progrsSttusCode}">
								<option value="<c:out value="${reqpscList.code}" />" selected><c:out value="${reqpscList.codeNm}" /></option>
							</c:when>
							<c:otherwise>
								<option value="<c:out value="${reqpscList.code}" />"><c:out value="${reqpscList.codeNm}" /></option>
							</c:otherwise>
						</c:choose>
					</c:forEach>								
				</select>
				<select name="searchCondition" id="searchCondition" class="w10" title="<spring:message code="wzwg.module.word.searchse" />"> 
					<option value="" <c:if test="${paramVO.searchCondition eq ''}"> selected</c:if>><spring:message code="wzwg.cmm.word.all" /></option>
					<option value="1" <c:if test="${paramVO.searchCondition eq '1'}"> selected</c:if>><spring:message code="wzwg.module.word.reqstnm" /></option>
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
		
		</form:form>	

		<table class="basic-table">
			  <colgroup>
				<col width="5%" />
				<col width="8%" />
				<col width="20%" />
				<col width="15%" />
				<col width="8%" />
				<col width="9%" />
				<col width="*" />
				<col width="7%" />
				<col width="7%" />	
		      </colgroup>
			  <thead>
				<tr>
					<th scope="col"><input type="checkbox" name="reqstSeqAllChk" id="reqstSeqAllChk" onclick="fnCheckBoxAll(this);"/></th>
					<th scope="col">No</th>
					<th scope="col"><spring:message code="wzwg.module.word.reqstnm" /></th>
					<th scope="col"><spring:message code="wzwg.module.word.reqstpd" /></th>
					<th scope="col"><spring:message code="wzwg.cmm.word.confm" /></th>
					<th scope="col"><spring:message code="wzwg.cmm.word.sttus" /></th>
					<th scope="col"><spring:message code="wzwg.module.word.reqsttrgter" /></th>
					<th scope="col"><spring:message code="wzwg.module.word.reqstpsncpa" /></th>
					<th scope="col"><spring:message code="wzwg.cmm.word.manage" /></th>
				</tr>
		      </thead>
			  <tbody>
			  
				<c:if test="${empty resultList}">
					<tr>
						<td colspan="9"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
					</tr>	
				</c:if>
				<c:if test="${!empty resultList }">
				<c:forEach items="${resultList}" var="resultList" varStatus="status">
					<tr>
						<td>
							<input type="checkbox" name="reqstnttSeqChk" id="reqstnttSeqChk" value="<c:out value="${resultList.reqstnttSeq}" />" />
						</td>
						<td>
							<c:out value="${totCnt - (paramVO.pageIndex-1) * paramVO.pageSize - status.count + 1}"/>
						</td>
						<td>
							<c:choose>
								<c:when test="${fn:length(resultList.reqstnttSj) > 30}">
									<c:set var="reqstnttSj" value="${fn:substring(resultList.reqstnttSj, 0, 30)}..." />
								</c:when>
								<c:otherwise>
									<c:set var="reqstnttSj" value="${resultList.reqstnttSj}" />
								</c:otherwise>																							
							</c:choose>	
							
							<c:out value="${reqstnttSj}"></c:out>	
																				
						</td>
						<td>
							<c:out value="${resultList.bgnde}" /> <c:out value="${resultList.beginTime}" /><spring:message code="wzwg.cmm.word.hour" /><br/>
							~ <br/>
							<c:out value="${resultList.endde }" /> <c:out value="${resultList.endTime}" /><spring:message code="wzwg.cmm.word.hour" />
						</td>
						<td>
							<c:forEach items="${reqcmcList}" var="reqcmcList" varStatus="status">
								<c:if test="${reqcmcList.code eq resultList.confmMthdCode}">
									<c:out value="${reqcmcList.codeNm}"/>
								</c:if>
							</c:forEach>
						</td>
						<td>
							<c:forEach items="${reqpscList}" var="reqpscList" varStatus="status">
								<c:if test="${reqpscList.code eq resultList.progrsSttusCode}">
									<c:out value="${reqpscList.codeNm}"/>
								</c:if>
							</c:forEach>
						</td>
						<td>
							<c:out value="${resultList.trgterUsrty}"/>
						</td>
						<td>
							<c:if test="${resultList.psncpa > 0}">
								<c:out value="${resultList.reqstNmpr }"/> / <c:out value="${resultList.psncpa}"/>
							</c:if>
							<c:if test="${resultList.psncpa == 0}">
								<c:out value="${resultList.reqstNmpr }"/> / -
							</c:if>
						</td>
						<td>
							<a href="javascript:void(0);" onclick="fnModify('<c:out value="${resultList.reqstnttSeq}" />');" class="wzbtn-table btn-basic"><spring:message code="wzwg.cmm.word.updt" /></a>
							<a href="javascript:void(0);" onclick="fnDetail('<c:out value="${resultList.reqstnttSeq}" />');" class="wzbtn-table btn-basic"><spring:message code="wzwg.cmm.word.psncpa" /></a>
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
			<a href="javascript:void(0);" id="regist_form_btn"  class="wzbtn btn-basic"><spring:message code="wzwg.module.word.onlinereqstregist" /></a>			
		</div>	



	
