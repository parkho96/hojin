<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>


<script type="text/javascript">
try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.cmm.word.list" />';}catch(e){console.log(e.message); }


	$(document).ready(function(){
		
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
			<input type="hidden" name="cmntUseAt" id="cmntUseAt" value="${fn:escapeXml(resultVO.cmntUseAt)}" />
			
			<c:set var="listCntSeTit"><spring:message code="wzwg.module.word.listcountse" /></c:set>
			<div>
				<c:if test="${resultVO.listCountAt eq 'Y'}">
					<div style="float:right;">
					<form:select path="listCount" name="listCount" id="listCount" cssStyle="width:80px;margin-bottom:0px;" title="${fn:escapeXml(listCntSeTit)}">
						<c:forEach items="${countList}" var="countList">
							<c:set var="temp_count" value="${countList}" />
							<form:option value="${fn:escapeXml(temp_count)}"><label for="list_count"><c:out value="${temp_count}"/><spring:message code="wzwg.cmm.word.count03" /></label></form:option>
						</c:forEach>
					</form:select>
					<button type="button" class="wzbtn btn-basic" id="btn-listCount" onclick="fnListCountChange()"><spring:message code="wzwg.cmm.word.change" /></button>
					</div>
				</c:if>
			</div>
			
			
			<c:if test="${!empty resultList}">
			
				<c:if test="${adminAuthAt eq 'Y'}">
					<div class="mb10 pl10">
						<label>
						<input type="checkbox" name="nttAllChk" id="nttAllChk" title="<spring:message code="wzwg.cmm.word.rowallchoise" />"/>
						<span><spring:message code="wzwg.module.word.allchoise" /></span>
						</label>
					</div>					
				</c:if>				

				<!-- album -->
				
				<h6 id="subospecSj_txt" class="hide-txt"><c:out value="${paramVO.subospecSj}"/><c:if test="${empty paramVO.subospecSj}"><spring:message code="wzwg.cmm.word.all" /></c:if></h6>
				
				<ul class="album">
		
					<c:forEach var="resultList" items="${resultList}" varStatus="status">
								
					<c:set var="modAuthAt" value="" />
					<c:set var="delAuthAt" value="" />
					
					<c:if test="${loginVO.usrSeq eq resultList.ntcrSeq or adminAuthAt eq 'Y'}">
						<c:set var="modAuthAt" value="Y" />
						<c:set var="delAuthAt" value="Y" />
					</c:if>				
					
					<li>
						
						<c:if test="${adminAuthAt eq 'Y'}">
							<input type="checkbox" name="nttChk" id="nttChk" value="<c:out value='${resultList.linknttSeq}'/>" title="<spring:message code="wzwg.cmm.word.rowchoise" />"/>				
						</c:if>	
						
						<div class="alBox">
							<a href="javascript:void(0);" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />" onclick="fnView('<c:out value="${resultList.linknttSeq}"/>', '<c:out value="${resultList.linkUrl}"/>');">				
								<span class="imgBox">
									<c:if test="${resultList.atchFileCnt ne '0'}">
										<img src='<c:url value='/module/upload/file/selectImageView.do'/>?atchFileId=<c:out value="${resultList.atchFileId}"/>' alt="<c:out value='${resultList.nttSj}'/>" />
									</c:if>
									<c:if test="${resultList.atchFileCnt eq '0'}">
										<img src="/images/egovframework/com/noimg_img.gif" alt="<c:out value='${resultList.nttSj}'/>" />
									</c:if>
								</span>
							</a>
							
							<p>
								<c:choose>
									<c:when test="${!empty resultList.nttSj}">
										<c:if test="${fn:length(resultList.nttSj) > 20}">
											<c:set var="nttSj" value="${fn:substring(resultList.nttSj, 0, 20)}..." />
										</c:if>
										<c:if test="${fn:length(resultList.nttSj) < 21}">
											<c:set var="nttSj" value="${resultList.nttSj}" />
										</c:if>
									</c:when>
									<c:otherwise>
										<c:set var="nttSj"><spring:message code="wzwg.cmm.word.untitle"/></c:set>
									</c:otherwise>
								</c:choose>	
								
								<a href="javascript:void(0);" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />" onclick="fnView('<c:out value="${resultList.linknttSeq}"/>', '<c:out value="${resultList.linkUrl}"/>');">
									<c:out value="${nttSj}"/>
									<span class="comM_txt"><c:out value="${resultList.linkDc}" escapeXml="false"/></span>
								</a>					
							</p>
							
							<div class="inquiry">
								<ul>
									<li><c:out value="${resultList.frstRegistPnttm}"/></li>
									<li><c:out value="${resultList.ntcrNm}"/></li>
								</ul>
								
								<div class="com_bar wd100 mt10">
									<c:if test="${modAuthAt eq 'Y'}">
										<a href="javascript:void(0);" onclick="fnModifyFormPage('<c:out value="${resultList.linknttSeq}"/>');" class="wzbtn-table btn-basic"><spring:message code="wzwg.cmm.word.updt" /></a>
									</c:if>
									<!--<c:if test="${delAuthAt eq 'Y'}">	
										<a href="javascript:void(0);" onclick="fnNttLinkDelete('<c:out value="${resultList.linknttSeq}"/>');" class="wzbtn-table btn-del"><spring:message code="wzwg.cmm.word.delete" /></a>
									</c:if>-->						
								</div>
							</div>
						</div>
					</li>
				
					</c:forEach>
				
				</ul>
			
			<!-- album end -->
			</c:if>
			
			<c:set var="regAuthAt" value="" />
			
			<c:if test="${nttAuthVO.authorSe eq 'W' or adminAuthAt eq 'Y' or cmntAuthW eq 'Y'}">
				<c:set var="regAuthAt" value="Y" />
			</c:if>		
			
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
					<%-- <form:option value=""><label for="option"><spring:message code="wzwg.cmm.word.all" /></label></form:option> --%>
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
