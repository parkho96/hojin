<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.cmm.word.list" />';}catch(e){console.log(e.message);}

	<c:if test="${!empty authorMessage}">
		alert('<c:out value="${authorMessage}"/>');
		history.go(-1);
	</c:if>

	$(document).ready(function(){
		$('#contentsCaption').html($('#menuNm').val() + ' <spring:message code="wzwg.module.word.postlist" />');
		
		// 글쓰기
		$('#regist_form_btn').click(function(){
			
			$.ajax({
				  type : 'POST'
				, dataType: 'html'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/link/registNttLinkFormAjax.do'
				, cache : false
				, async : false
				, data:$("#listFrm").serialize()
				, success:function (data) {
					$('#bbs_area').html(data);
					$("#content").css("height",$(document).height());
					$(window).scrollTop(0);
				}
				, error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});
			
		});
		
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
					, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/link/deleteNttLinkInfoAjax.do'
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
		
		//$("#listCount").change(function(){
		//	fnPage(1);
		//});
		
	});
	
	function fnListCountChange(){
		fnPage(1);
		$('#btn-listCount').focus();
	}
	
	// 상세정보
	function fnView(linknttSeq, linkUrl){
		window.open(linkUrl, "");
	}	
	
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
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/link/selectNttLinkListAjax.do'
			, cache : false
			, async : false
			, data:$("#listFrm").serialize()
			, success:function (data) {
				$('#bbs_area').html(data);
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
		if(isNaN(pageIndex)){console.log('잘못된 페이지호출');return;}
		var frm = document.listFrm;
		
		frm.pageIndex.value = pageIndex;
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/link/selectNttLinkListAjax.do'
			, cache : false
			, async : false
			, data:$("#listFrm").serialize()
			, success:function (data) {
				$('#bbs_area').html(data);
				$("#content").css("height",$(document).height());
				//$(window).scrollTop(0);
				$('#pageInfo').find('.on>a').focus();
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
	// 수정 화면
	function fnModifyFormPage(linknttSeq){
		var frm = document.listFrm;
		
		frm.linknttSeq.value = linknttSeq;
		
		$.ajax({
	        type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/link/modifyNttLinkFormAjax.do'
			, dataType : 'html'
			, data : $("#listFrm").serialize()
			, success : function (data) {
				$('#bbs_area').html(data);
				$("#content").css("height",$(document).height());
				$(window).scrollTop(0);
			}
			, error : function (request, status, error) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
		});
	}
	
	// 삭제
	function fnNttLinkDelete(linknttSeq){
		var frm = document.listFrm;
		
		frm.linknttSeq.value = linknttSeq;
		
		$.ajax({
				type:'POST'
			, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/link/deleteNttLinkInfoAjax.do'
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
	
	window.onkeydown = function() {

	    var keyCode = event.keyCode;

	    if(keyCode == 8
	    		&& 'INPUT'.indexOf(event.target.nodeName.toUpperCase()) == -1 
	    		&& 'TEXTAREA'.indexOf(event.target.nodeName.toUpperCase()) == -1) {

	    	fnPage(1);
	    	return false;
		}
	}		
	
</script>

		<c:if test="${nowUrl.indexOf('/mngr') > -1 }">
			<div class="wz_notice brbox bg-white br-blue-strong fl mt10" style="overflow:visible;">
		        <ul class="wd100 pl0">
	                <li class="admpg-subp wd100" style="list-style:none;">· <spring:message code="wzwg.cmm.msg.MSG0075"/></li>
		        </ul>
			</div>
		</c:if>
		
		<c:set var="adminAuthAt" value="N"/>
		
		<c:if test="${resultVO.cmntUseAt eq 'Y'}">
			<c:if test="${sessionScope.cmntMngrAt == true}">
				<c:set var="adminAuthAt" value="Y"/>
			</c:if>
		</c:if>		

		<c:if test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or sessionScope.CNTNTS_ADMIN_AT}">
			<c:set var="adminAuthAt" value="Y"/>
		</c:if>
		
		<c:if test="${not empty resultVO.bbsPrface}">
		<div class="mb30">
			<c:out value='${resultVO.bbsPrface}' escapeXml="false" />
		</div>
		</c:if>		
		
		<form:form modelAttribute="paramVO" path="listFrm" id="listFrm" name="listFrm" method="post">
			<form:hidden path="siteSeq" />
			<form:hidden path="bbsSeq" />
			<form:hidden path="linknttSeq" />
			<form:hidden path="pageIndex" />
			<form:hidden path="searchCnd" />
			<form:hidden path="checkNttSeq" />
			<form:hidden path="menuSeq" />
			<form:hidden path="mngrAt" />
			<form:hidden path="searchAt" />
			<form:hidden path="sitecntntsSeq" />
			
			<input type="hidden" name="cmntUseAt" id="cmntUseAt" value="aaaaaaaaaa<c:out value="${resultVO.cmntUseAt}"/>" />
			
			<c:set var="temp_listCntSeTit"><spring:message code="wzwg.module.word.listcountse" /></c:set>
			<c:set var="listCntSeTit"><c:out value="${temp_listCntSeTit}" /></c:set>
			<div>
				<c:if test="${resultVO.cmntUseAt ne 'Y'}">
				<div class="main-menu-bar i-block">
					<c:import url="${wzwg_contextPath}${prefix}/module/bbs/cmmn/selectBbsSubospecSelectListAjax.do" charEncoding="utf-8">
						<c:param name="param_bbsSeq" value="${paramVO.bbsSeq}" />
					</c:import>
				</div>
				</c:if>
				
				<c:if test="${resultVO.listCountAt eq 'Y'}">
					<div style="float:right;">
					<form:select path="listCount" name="listCount" id="listCount" cssStyle="width:80px;margin-bottom:0px;" title="${fn:escapeXml(listCntSeTit)}">
						<c:forEach items="${countList}" var="countList">
							<c:set var="temp_count" value="${countList}" />	
							<form:option value="${fn:escapeXml(temp_count)}"><label for="list_count"><c:out value="${fn:escapeXml(temp_count)}"/><spring:message code="wzwg.cmm.word.count03" /></label></form:option>
						</c:forEach>
					</form:select>
					<button type="button" class="wzbtn btn-basic" id="btn-listCount" onclick="fnListCountChange()"><spring:message code="wzwg.cmm.word.change" /></button>
					</div>
				</c:if>
			</div>
			
			<h6 id="subospecSj_txt" class="hide-txt"><c:out value="${paramVO.subospecSj}"/><c:if test="${empty paramVO.subospecSj}"><spring:message code="wzwg.cmm.word.all" /></c:if></h6>
			
			<table class="link_list">
				<caption id="contentsCaption"><spring:message code="wzwg.module.word.postlist" /></caption>
				  <colgroup>
					<c:if test="${adminAuthAt eq 'Y'}">
						<col width="5%"/>						
					</c:if>
					<c:if test="${mobileAt eq 'N'}">
						<!-- <col width="10%"/> -->
						<col width="*"/>
						<col width="10%"/>
					</c:if> 
			      </colgroup>
			      <thead>
			      	<tr>
				      	<c:if test="${adminAuthAt eq 'Y'}">
							<th>
								<label>
								<input type="checkbox" name="nttAllChk" id="nttAllChk" title="<spring:message code="wzwg.cmm.word.rowallchoise" />"/>
								</label>
							</th>					
						</c:if>
						
						<th><spring:message code="wzwg.cmm.word.sj" /></th>
						<th><spring:message code="wzwg.cmm.word.wrter" /></th>
			      	</tr>
			      </thead>
				  <tbody>
				  	
				  	
					
				  	<c:if test="${!empty resultList}">
			
						<c:forEach var="resultList" items="${resultList}" varStatus="status">		
						
						<c:set var="modAuthAt" value="" />
						<c:set var="delAuthAt" value="" />
						
						<c:if test="${loginVO.usrSeq eq resultList.ntcrSeq or adminAuthAt eq 'Y'}">
							<c:set var="modAuthAt" value="Y" />
							<c:set var="delAuthAt" value="Y" />
						</c:if>				

						<tr>
							
							<c:if test="${adminAuthAt eq 'Y'}">
								<td><input type="checkbox" name="nttChk" id="nttChk" value="<c:out value='${resultList.linknttSeq}'/>" title="<spring:message code="wzwg.cmm.word.rowchoise" />"/></td>				
							</c:if>						
			
							<td class="txt-l">								
								<c:choose>
									<c:when test="${!empty resultList.nttSj}">
										<c:if test="${fn:length(resultList.nttSj) > 60}">
											<c:set var="nttSj" value="${fn:substring(resultList.nttSj, 0, 60)}..." />
										</c:if>
										<c:if test="${fn:length(resultList.nttSj) < 61}">
											<c:set var="nttSj" value="${resultList.nttSj}" />
										</c:if>
									</c:when>
									<c:otherwise>
										<c:set var="nttSj"><spring:message code="wzwg.cmm.word.untitle"/></c:set>
									</c:otherwise>
								</c:choose>
								
								<a href="javascript:void(0);" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />" onclick="fnView('<c:out value="${resultList.linknttSeq}"/>', '<c:out value="${resultList.linkUrl}"/>');">
									<p>
										<c:out value="${nttSj}"/>
										<c:if test="${resultList.nttNew eq 'Y'}">
											<img src="/images/wzwg/module/ntt/new.png" alt="<spring:message code="wzwg.module.word.newpostsicon" />"/>
										</c:if>
									</p>
								</a>
								
								<div class="comM_txt"><c:out value="${resultList.linkDc}"/></div>
								
								<div class="btnbox">
									<c:if test="${modAuthAt eq 'Y'}">
										<a href="javascript:void(0);" onclick="fnModifyFormPage('<c:out value="${resultList.linknttSeq}"/>');" class="wzbtn-table btn-basic"><spring:message code="wzwg.cmm.word.updt" /></a>
									</c:if>
								</div>
								
							</td>
							<td><c:out value="${resultList.frstRegistPnttm}"/></td>
						</tr>	
						</c:forEach>
					</c:if>		
					
					<c:set var="colCnt" value="6" />
					<c:if test="${adminAuthAt eq 'Y'}">
						<c:set var="colCnt" value="7" />
					</c:if>
					
					<c:if test="${mobileAt eq 'Y'}">
						<c:set var="colCnt" value="${colCnt - 2}" />
				 	</c:if>
							
					<c:if test="${empty resultList}">
						<tr>
							<td colspan="<c:out value='${colCnt}'/>"><spring:message code="wzwg.cmm.msg.MSG085" /></td>
						</tr>
					</c:if>
				  
				  </tbody>
			</table>

			<c:if test="${!empty resultList}">
			<div class="ctr-box" id="pageInfo">
				<ul class="num mobile-none">
					<ui:pagination paginationInfo="${paginationInfo}" type="ntt" jsFunction="fnPage" />
				</ul>
				
				<ul class="num pc-none">
					<ui:pagination paginationInfo="${mobilePaginationInfo}" type="ntt" jsFunction="fnPage" />
				</ul>
			</div>
			</c:if>
			
			<div class="ctr-box" id="nttSearch">
				<c:set var="searchTit"><spring:message code="wzwg.module.word.searchse" /></c:set>
				<c:set var="searchkeyinp"><spring:message code="wzwg.module.word.searchkeywordinput" /></c:set>
				<form:select path="searchCondition" id="searchCondition" title="${fn:escapeXml(searchTit)}"> 
					<form:option value="1"><label for="option1"><spring:message code="wzwg.cmm.word.sj" />+<spring:message code="wzwg.cmm.word.cn" /></label></form:option>
					<form:option value="2"><label for="option2"><spring:message code="wzwg.cmm.word.sj" /></label></form:option>
					<form:option value="3"><label for="option3"><spring:message code="wzwg.module.word.wrternm" /></label></form:option>
				</form:select>
				
				<c:set var="srchwrd">
					<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
				</c:set>
				<form:input path="searchKeyword" id="searchKeyword" placeholder="${fn:escapeXml(srchwrd)}" cssClass="txt" onkeydown="if(event.keyCode == 13){fnPage(1);}" title="${fn:escapeXml(searchkeyinp)}"/>	
				<a href="javascript:void(0);" id="btn_search" class="wzbtn-table btn-srch" onclick="fnSearch('btn_search');" title="<spring:message code="wzwg.module.word.searchbutton" />"><spring:message code="wzwg.cmm.word.search01" /></a>			 
			</div>				
			
			<div class="rt-box">
			
				<c:set var="delAuthAt" value="" />
				<c:set var="regAuthAt" value="" />					
			
				<c:if test="${nttAuthVO.authorSe eq 'W' or cmntAuthW eq 'Y'}">
					<c:set var="regAuthAt" value="Y" />
				</c:if>
				
				<c:if test="${adminAuthAt eq 'Y'}">
					<c:set var="delAuthAt" value="Y" />
					<c:set var="regAuthAt" value="Y" />
				</c:if> 
				
				<c:if test="${adminAuthAt eq 'Y'}">
					<a href="javascript:void(0);" class="wzbtn btn-del fl" id="delete_btn"><spring:message code="wzwg.module.word.choisedelete" /></a>
				</c:if>	
				<c:if test="${regAuthAt eq 'Y'}">				
					<a href="javascript:void(0);" class="wzbtn btn-basic" id="regist_form_btn"><spring:message code="wzwg.module.word.postswrt" /></a>
				</c:if>
			</div>				
			
			<c:if test="${nowUrl.indexOf('/mngr') == -1 }">
			<div class="mt20">
				<c:import url="${wzwg_contextPath}/usr/cntnts/cntPagadiEstbs/selectCntPagadiEstbsUsrAjax.do">
					<c:param name="cntntsSeq" value="${resultVO.bbsSeq }" />
					<c:param name="nttSeqAt" value="N" />
				</c:import>
			</div>
			</c:if>
			
		</form:form>
		
		<c:if test="${not empty resultVO.bbsCnclsn}">
		<div class="mt30">
			<c:out value='${resultVO.bbsCnclsn}' escapeXml="false" />
		</div>
		</c:if>		
