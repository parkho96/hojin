<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<link rel="stylesheet" href="/css/wzwg/module/cmnt/community.css"> 

<script type="text/javascript">
try{document.title = cmntNm+'-<spring:message code="wzwg.module.word.cmmntymanage" />-<spring:message code="wzwg.module.word.mbermanage" />';}catch(e){console.log(e.message);}

	$(document).ready(function(){ 
		$('#usrMngrCaption').html('<spring:message code="wzwg.cmm.cmmMsg.CMG024"><spring:argument>'+cmntNm+' <spring:message code="wzwg.cmm.word.wa.of" /> <spring:message code="wzwg.cmm.word.no" />, <spring:message code="wzwg.cmm.word.sbscrb" /> <spring:message code="wzwg.cmm.word.reqst" /> <spring:message code="wzwg.cmm.word.mber" /> <spring:message code="wzwg.cmm.word.id02" />, <spring:message code="wzwg.cmm.word.nm02" />, <spring:message code="wzwg.cmm.word.writng" /> <spring:message code="wzwg.cmm.word.ntt" /> <spring:message code="wzwg.cmm.word.co" />, <spring:message code="wzwg.cmm.word.visit" /> <spring:message code="wzwg.cmm.word.co" />, <spring:message code="wzwg.cmm.word.last" /> <spring:message code="wzwg.cmm.word.visit" /> <spring:message code="wzwg.cmm.word.date" />, <spring:message code="wzwg.cmm.word.confm" /> <spring:message code="wzwg.cmm.word.at" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.wa.table" /></spring:argument></spring:message>');
		
		$("#checkall").click(function(){
			if($("#checkall").prop("checked")){
				$("input[name=chkAppvlArr]").prop("checked", true);
			}else{
				$("input[name=chkAppvlArr]").prop("checked", false);
			}
		});
	});
	
	function fnAllApproval(apprvlCode){
		document.cmntUsrFrm.apprvlCode.value = apprvlCode;
		
		$.ajax({
			   type:'POST'
			 , url:'<c:out value="${wzwg_contextPath}"/>/cmnt/mngr/allApprovalCmntUserMngrAjax.do'
			 , data:$("#cmntUsrFrm").serialize() 
			 , success:function (data) {
				 	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.applc" /></spring:argument></spring:message>');
				 	fn_search('1');
			 }
			 , dataType: 'json'
		});
	}
	
	function fn_search(pageIndex, callId){
		if(isNaN(pageIndex)){console.log('잘못된 페이지호출');return;}
		document.cmntUsrFrm.pageIndex.value = pageIndex;
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}"/>/cmnt/mngr/selectCmntUserMngrAjax.do' 
	      , cache : false
	      , async : false 
	      , data : $("#cmntUsrFrm").serialize() 
	      , success:function (data) {
	    	  $('#cntnts_area').html(data);
	    	  $('#pageInfo').find('.on>a').focus();
	    	  if(callId != undefined || callId != ''){
	            	$('#' + callId).focus();
	           }
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	} 
	
	function fnAllDelete(){
		
		$.ajax({
			   type:'POST'
			 , url:'<c:out value="${wzwg_contextPath}"/>/cmnt/mngr/allDeleteCmntUserMngrAjax.do'
			 , data:$("#cmntUsrFrm").serialize() 
			 , success:function (data) {
				 	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.applc" /></spring:argument></spring:message>');
				 	fn_search('1');
			 }
			 , dataType: 'json'
		});
	}
	
	function fnModifyAllApproval(){
		
		$.ajax({
			   type:'POST'
			 , url:'<c:out value="${wzwg_contextPath}"/>/cmnt/mngr/modifyApprovalCmntUserMngrAjax.do'
			 , data:$("#cmntUsrFrm").serialize() 
			 , success:function (data) {
				 	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.applc" /></spring:argument></spring:message>');
				 	fn_search('1');
			 }
			 , dataType: 'json'
		});
	}
	
	function fnapprvlCodeChange() {
		fn_search('1');
		$('#btn-fnapprvl').focus();
	}
</script>
<form name="cmntUsrFrm" id="cmntUsrFrm">
		<input type="hidden" name="cmntSeq" id="cmntSeq" value="<c:out value='${paramVO.cmntSeq}'/>" />
		<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value='${paramVO.pageIndex}'/>" />
		<input type="hidden" name="apprvlCode" id="apprvlCode" value="" />
		<h5 class="fs24 pt20 pb20 fn wd100 clboth"><spring:message code="wzwg.module.word.mbermanage" /></h5>
		<c:if test="${!empty usrInfoList}">
		<div class="ctr-box txt-r">
			<select id="apprvlCodeSearch" name="apprvlCodeSearch" title="<spring:message code="wzwg.module.word.confmse" />">
			<option value=""><spring:message code="wzwg.module.word.confmat" /></option>
                <c:forEach items="${approvalCodeList}" var="resultList" varStatus="status">
            		 <option value="<c:out value='${resultList.code}'/>" <c:if test="${paramVO.apprvlCode eq resultList.code}">selected="true"</c:if>><c:out value="${resultList.codeNm}"/></option>
            	</c:forEach>
           	</select>
           	<button type="button" class="wzbtn btn-basic" id="btn-fnapprvl" onclick="fnapprvlCodeChange()"><spring:message code="wzwg.cmm.word.inqire" /></button>
		</div><!-- ctr-box end -->
		</c:if>
						 <div class="joinUs_box mt5">	
						 <table class="basic-table01">
						 <caption id="usrMngrCaption"><spring:message code="wzwg.cmm.cmmMsg.CMG024"><spring:argument><spring:message code="wzwg.cmm.word.no" />, <spring:message code="wzwg.cmm.word.sbscrb" /> <spring:message code="wzwg.cmm.word.reqst" /> <spring:message code="wzwg.cmm.word.mber" /> <spring:message code="wzwg.cmm.word.id02" />, <spring:message code="wzwg.cmm.word.nm02" />, <spring:message code="wzwg.cmm.word.writng" /> <spring:message code="wzwg.cmm.word.ntt" /> <spring:message code="wzwg.cmm.word.co" />, <spring:message code="wzwg.cmm.word.visit" /> <spring:message code="wzwg.cmm.word.co" />, <spring:message code="wzwg.cmm.word.last" /> <spring:message code="wzwg.cmm.word.visit" /> <spring:message code="wzwg.cmm.word.date" />, <spring:message code="wzwg.cmm.word.confm" /> <spring:message code="wzwg.cmm.word.at" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.wa.table" /></spring:argument></spring:message></caption>
							  <colgroup>
								<col width="5%" />
								<col width="5%" />
								<col width="10%" />
								<col width="10%" />
								<col width="10%" />
								<col width="10%" />
								<col width="10%" />
								<col width="7%" />
						      </colgroup>
							  <thead>
								<tr>
									<th scope="col"><input type="checkbox" id="checkall" name="checkall" title="<spring:message code="wzwg.cmm.word.rowallchoise" />" /></th>
									<th scope="col">No</th>
									<th scope="col"><spring:message code="wzwg.cmm.word.id02" text="id" /></th>
									<th scope="col"><spring:message code="wzwg.cmm.word.nm02" text="name" /></th>
									<th scope="col"><spring:message code="wzwg.module.word.writngnttco" /> </th>
									<th scope="col"><spring:message code="wzwg.module.word.visitco" /></th>
									<th scope="col"><spring:message code="wzwg.module.word.lastvisitdate" /></th>
									<th scope="col"><spring:message code="wzwg.module.word.confmat" /></th>
								</tr>
						      </thead>
							  <tbody>
							  <c:if test="${empty usrInfoList}">
									<tr>
										<td colspan="8"><spring:message code="wzwg.cmm.msg.MSG246" /></td>
									</tr>
							  </c:if>
							  <c:if test="${!empty usrInfoList}">
								<c:forEach var="result" items="${usrInfoList}" varStatus="status">
								<tr>
									<td>
									<input type="hidden" name="usrSeqArr" id="usrSeqArr" value="<c:out value='${result.usrSeq}'/>"/>
									<input type="checkbox" name="chkAppvlArr" id="chkAppvlArr" value="<c:out value='${result.usrSeq}'/>" title="<spring:message code="wzwg.cmm.word.rowchoise" />"/></td>
									<td><c:out value='${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.pageSize + status.count) + 1}'/></td>
									<td><c:out value='${result.userId}'/></td>
									<td><c:out value='${result.userNm}'/></td>
									<td><c:out value='${result.bbsCnt}'/></td>
									<td><c:out value='${result.connCnt}'/></td>
									<td><c:out value='${result.lastConnPnttm}'/></td>
									<td>
									<select id="apprvlCodeArr" name="apprvlCodeArr" title="<spring:message code="wzwg.module.word.confmse" />">
		                             <c:forEach items="${approvalCodeList}" var="resultList" varStatus="status">
		                          		 <option value="<c:out value='${resultList.code}'/>" <c:if test="${result.apprvlCode eq resultList.code}">selected="true"</c:if>><c:out value='${resultList.codeNm}'/></option>
		                          	</c:forEach>
		                          	</select>
									</td>
								</tr>
								</c:forEach>
							</c:if> 
							  </tbody>
							</table>
							  <div class="of mg_t20">
								<div class="ctr-box">
								<c:if test="${!empty usrInfoList}">
									<ul id="pageInfo" class="num">
										<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
									</ul>
								</c:if>
								</div>
							</div> 
									<c:if test="${!empty usrInfoList}">
									<div class="rt-box fr">
										<a href="javascript:fnAllApproval('SC00000339');" class="wzbtn btn-black fl" style="margin-right:5px;"><spring:message code="wzwg.module.word.choisemberconfm" /></a>
										<a href="javascript:fnAllApproval('SC00000340');" class="wzbtn btn-black fl" style="margin-right:5px;"><spring:message code="wzwg.module.word.choisemberuapprd" /></a>
										<a href="javascript:fnAllDelete();" class="wzbtn btn-del fl" style="margin-right:5px;"><spring:message code="wzwg.module.word.choisembersecsn" /></a>
										<a href="javascript:fnModifyAllApproval();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.applc" text="apply" /></a>
									</div>
								  </div><!-- joinUs_box end -->
								  		<div class="ctr-box">
										<select name="searchCondition"  id="searchCondition" title="<spring:message code="wzwg.module.word.searchse" />">
											<%-- <option value=""><spring:message code="wzwg.cmm.word.all" text="all" /></option> --%>
											<option value="1" <c:if test="${paramVO.searchCondition eq '1' }">selected="true"</c:if>><spring:message code="wzwg.cmm.word.nm02" text="name" /></option>
											<option value="2" <c:if test="${paramVO.searchCondition eq '2' }">selected="true"</c:if>><spring:message code="wzwg.cmm.word.id02" text="id" /></option>
										</select>
										<input type="text" class="txt" name="searchKeyword" value="<c:out value='${paramVO.searchKeyword }'/>" title="<spring:message code="wzwg.module.word.searchkeywordinpcmpt" />" />
										<a href="javascript:void(0);" id="btn_search"  onclick="fn_search('1', 'btn_search')" class="wzbtn-table btn-srch"><spring:message code="wzwg.cmm.word.search01" text="search" /></a>
								</div>
								</c:if>
</form>