<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.cmm.word.list" />';}catch(e){console.log(e.message);}

	$(document).ready(function(){
		$('#contentsCaption').html($('#menuNm').val() + ' <spring:message code="wzwg.cmm.word.list" />');
		$('#regist_form_btn').click(function(){

			$.ajax({
				  type : 'POST'
				, dataType : 'html'
				, url : '<c:out value="${wzwg_contextPath}" />/module/onlineReqst/registOnlineReqstNttFormAjax.do'
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
		
	function fnPage(pageIndex, callId) {
		if(isNaN(pageIndex)){console.log('잘못된 페이지호출');return;}
		var frm = document.getElementById("listFrm");
		frm.pageIndex.value = pageIndex;	
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}" />/module/onlineReqst/selectOnlineReqstNttListAjax.do'
	      , dataType: 'html'
	      , cache : false
	      , data:$("#listFrm").serialize()
	      , success:function (data) {
	    	  $('#onlineReqst_area').html(data);
	    	  $('#pageInfo').find('.on>a').focus();
	    	  if(callId != undefined || callId != ''){
	            	$('#' + callId).focus();
	           }
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
			    , url : "<c:out value="${wzwg_contextPath}" />/module/onlineReqst/deleteOnlineReqstNttAjax.do"
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
			    , url : "<c:out value="${wzwg_contextPath}" />/module/onlineReqst/deleteOnlineReqstNttAjax.do"
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
			, url : "<c:out value="${wzwg_contextPath}" />/module/onlineReqst/modifyOnlineReqstNttFormAjax.do"
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
			, url : "<c:out value="${wzwg_contextPath}" />/module/onlineReqst/selectOnlineReqstNttDetailAjax.do"
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

	function fnListCountChange(btn){
		fnPage(1, btn);
	}
	
</script>
		   

		<form id="listFrm" name="listFrm" method="post" onsubmit="return false">
			<input type="hidden" name="pageIndex" value="<c:out value="${paramVO.pageIndex}" />" />
			<input type="hidden" name="checkResult" value="0">
			<input type="hidden" name="reqstSeq" value="<c:out value="${paramVO.reqstSeq}" />" />
			<input type="hidden" name="reqstnttSeq" />
			<input type="hidden" name="reqstnttSeqChkStr" />


			
		<div class="allbox">
			<div class="ctr-box">
				<select id="progrsSttusCode" name="progrsSttusCode" class="fl" title="<spring:message code="wzwg.module.word.sttusse" />">
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
				<select name="searchCondition" id="searchCondition" class="fl" title="<spring:message code="wzwg.module.word.searchse" />"> 
					<option value="" <c:if test="${paramVO.searchCondition eq ''}"> selected</c:if>><spring:message code="wzwg.cmm.word.all" /></option>
					<option value="1" <c:if test="${paramVO.searchCondition eq '1'}"> selected</c:if>><spring:message code="wzwg.module.word.reqstnm" /></option>
				</select>
				<c:set var="srchwrd">
					<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
				</c:set>
				
				<input type="text" name="searchKeyword" id="searchKeyword" value="<c:out value="${paramVO.searchKeyword}" />" class="fl w20" placeholder="<c:out value="${srchwrd}" />" onkeydown="if(event.keyCode == 13){fnPage('1');}" title="<spring:message code="wzwg.cmm.word.search01" /> <spring:message code="wzwg.cmm.word.wa.keyword" /> <spring:message code="wzwg.cmm.word.input" />" />
				<a href="javascript:void(0);" id="btn_search" onclick="fnPage('1', 'btn_search');" class="wzbtn-table btn-srch fl"><spring:message code="wzwg.cmm.word.search01" /></a>
				
				<div class="fr">
					<select id="pageUnit" name="pageUnit" title="<spring:message code="wzwg.module.word.listcountse" />">
							<option value="10" <c:if test="${paramVO.recordCountPerPage eq 10}">selected="selected"</c:if>>10 <spring:message code="wzwg.cmm.word.count04" /></option>
							<option value="30" <c:if test="${paramVO.recordCountPerPage eq 30}">selected="selected"</c:if>>30 <spring:message code="wzwg.cmm.word.count04" /></option>
							<option value="50" <c:if test="${paramVO.recordCountPerPage eq 50}">selected="selected"</c:if>>50 <spring:message code="wzwg.cmm.word.count04" /></option>
					</select>
					<button type="button" class="wzbtn btn-basic" id="btn-listCount" onclick="fnListCountChange('btn-listCount')"><spring:message code="wzwg.cmm.word.change" /></button>
				</div>
			</div>	
		</div>		
				
		</form>

		<div style=""><!-- 내용 start -->
			<table class="basic-table01">
			  <caption id="contentsCaption"><spring:message code="wzwg.module.word.onlinereqstlist" /></caption>
			  <colgroup>
			  <c:if test="${mobileAt eq 'N'}">
				<col width="8%" />
				<col width="10%" />
				<col width="30%" />
				<col width="13%" />
				<col width="13%" />
				<col width="8%" />
				<col width="8%" />
				<col width="10%" />
			</c:if>
			<c:if test="${mobileAt eq 'Y'}">
				<col width="45%" />
				<col width="40%" />
				<col width="15%" />
			</c:if>
		      </colgroup>
			  <thead>
				<tr>
				<c:if test="${mobileAt eq 'N'}">
					<th scope="col">No</th>
				</c:if>
					<th scope="col"><spring:message code="wzwg.module.word.reqstnm" /></th>
					<th scope="col"><spring:message code="wzwg.module.word.reqstpd" /></th>
				<c:if test="${mobileAt eq 'N'}">
					<th scope="col"><spring:message code="wzwg.module.word.reqsttrgter" /></th>
					<th scope="col"><spring:message code="wzwg.module.word.confmmthd" /></th>
					<th scope="col"><spring:message code="wzwg.cmm.word.sttus" /></a></th>
					<th scope="col"><spring:message code="wzwg.cmm.word.psncpa" /></th>
				</c:if>
					<th scope="col"><spring:message code="wzwg.cmm.word.reqst" /></a></th>
				</tr>
		      </thead>
			  <tbody>
			  
				<c:if test="${empty resultList}">
					<c:set var="colCnt" value="8" />
					<c:if test="${mobileAt eq 'N'}">
						<c:set var="colCnt" value="3" />
					</c:if>
					<tr>
						<td colspan="8"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
					</tr>	
				</c:if>
				<c:if test="${!empty resultList }">
				<c:forEach items="${resultList}" var="resultList" varStatus="status">				
							  
				<tr>
					<c:if test="${mobileAt eq 'N'}">
					<td>
						<!-- 
						<c:out value="${resultList.reqstnttSeq}"/>
						 -->
						<c:out value="${totCnt - (paramVO.pageIndex-1) * paramVO.pageSize - status.count + 1}"/>
					</td>
					</c:if>
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
						<c:out value="${resultList.bgnde}" /> <c:out value="${resultList.beginTime}" /><spring:message code="wzwg.cmm.word.hour" />
						~ 
						<c:out value="${resultList.endde }" /> <c:out value="${resultList.endTime}" /><spring:message code="wzwg.cmm.word.hour" />
					</td>
					
					<c:if test="${mobileAt eq 'N'}">
					
					<td><c:out value="${resultList.trgterUsrty}"/></td>
					<td>
						<c:forEach items="${reqcmcList}" var="reqcmcList" varStatus="status">
							<c:if test="${reqcmcList.code eq resultList.confmMthdCode}">
								<c:choose>
									<c:when test="${nowUrl.indexOf('/mngr') > -1 }">
										<c:out value="${reqcmcList.codeNm}"/>
									</c:when>
									<c:otherwise>
										<c:if test="${resultList.confmMthdCode eq 'SC00000109'}"><spring:message code="wzwg.cmm.word.fcfs" /></c:if>
										<c:if test="${resultList.confmMthdCode eq 'SC00000110'}"><spring:message code="wzwg.cmm.word.audit" /></c:if>
									</c:otherwise>		
								</c:choose>
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
						<c:if test="${resultList.psncpa > 0}">
							<c:out value="${resultList.psncpa}"/>
						</c:if>
						<c:if test="${resultList.psncpa == 0}">
							-
						</c:if>					
					</td>
					
					</c:if>
					
					<td>
						<c:if test="${resultList.trgterUsrtyAt eq 'Y'}">
							<c:choose>
								<c:when test="${not empty resultList.confmSttusCode and resultList.confmSttusCode ne 'SC00000117'}">
									<a href="javascript:void(0);" onclick="fnDetail('<c:out value="${resultList.reqstnttSeq}" />');" class="wzbtn-table btn-basic"><spring:message code="wzwg.module.word.reqstcnfirm" /></a>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${resultList.progrsSttusCode eq 'SC00000112'}">
											<a href="javascript:void(0);" onclick="fnDetail('<c:out value="${resultList.reqstnttSeq}" />');" class="wzbtn-table btn-basic"><spring:message code="wzwg.module.word.reqstposbl" /></a>
										</c:when>
										<c:when test="${resultList.progrsSttusCode eq 'SC00000113'}">
											<a href="javascript:void(0);" onclick="fnDetail('<c:out value="${resultList.reqstnttSeq}" />');" class="wzbtn-table btn-basic"><spring:message code="wzwg.module.word.waitreqst" /></a>
										</c:when>
										<c:when test="${resultList.progrsSttusCode eq 'SC00000114'}">
											<a href="javascript:void(0);" onclick="fnDetail('<c:out value="${resultList.reqstnttSeq}" />');" class="wzbtn-table btn-basic"><spring:message code="wzwg.module.word.reqstend" /></a>
										</c:when>
									</c:choose>									
								</c:otherwise>
							</c:choose>	
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
		</div><!-- 내용 end -->
		
		<div class="mt20">
			<c:import url="${wzwg_contextPath}/usr/cntnts/cntPagadiEstbs/selectCntPagadiEstbsUsrAjax.do">
				<c:param name="cntntsSeq" value="${paramVO.reqstSeq}" />
			</c:import>
		</div>
