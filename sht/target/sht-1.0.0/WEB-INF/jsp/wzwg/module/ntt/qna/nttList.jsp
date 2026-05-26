<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
try{document.title = $('#menuPath').val().replace(/>/gi,'-') + ' <spring:message code="wzwg.cmm.word.list" />';}catch(e){console.log(e.message);}

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
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/qna/registNttFormAjax.do'
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
		
		// 말머리 선택
		$('#btn_subospecSeq').click(function(){
			
			var frm = document.listFrm;

			frm.pageIndex.value = 1;
			
			$.ajax({
				  type : 'POST'
				, dataType: 'html'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/qna/selectNttListAjax.do'
				, cache : false
				, async : false
				, data:$("#listFrm").serialize()
				, success:function (data) {
					$('#bbs_area').html(data);
					if($('#tabBtn-' + $('#subospecSeq').val()).length > 0){
		            	$('#tabBtn-' + $('#subospecSeq').val()).focus();
		            }
		            
		            if($('#btn_subospecSeq').length > 0){
			            $('#btn_subospecSeq').focus();
		            }
				}
				, error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});
			
		});		
		
		// 말머리 수정
		$('#subospec_modify_btn').click(function(){
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
			
			$('body').css({overflow:'hidden'});
			
			$.ajax({
		        type:'POST'
		      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cmmn/modifySubospecPopup.do'
		      , cache : false
		      , async : false
		      , data:$("#listFrm").serialize()
		      , success:function (data) {
		    	  //$("#bbs_layer").show();
		    	  //$("#bbs_layer").html(data);
		    	  var title = '<spring:message code="wzwg.module.word.ctgryupdt" />';
		    	  wzAjaxModal('popup_s', title, data);
		      }
		      , error:function (request, status, error) {
		    	  alert('<spring:message code="fail.common.msg" text="error" />');
		      }
		      , dataType: 'html'
		 	});
		});
		
		// FAQ 등록
		$('#list_top_regist_btn').click(function(){
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
			frm.noticeAt.value = "Y";
			
			$.ajax({
				type:'POST'    
				, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/qna/modifyNttNoticeAjax.do'
				, dataType: 'xml'
				, data:$("#listFrm").serialize()
				, success:function (result) {
					var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value == 'success'){
						fnPage(1);
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
					}
				}
				, error:function (request, status, error) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});
			
		});
		
		// 자주묻는질문 등록
		$('#faq_regist_btn').click(function(){
			
			if(!confirm('<spring:message code="wzwg.cmm.msg.MSG025" />')){
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
				frm.faqAt.value = "Y";
				
				$.ajax({
			        type:'POST'
			        , dataType: 'xml'
					, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/qna/modifyNttFaqAjax.do'
					, cache : false
					, async : false
					, data:$("#listFrm").serialize()
					, success:function (result) {
						var value = "";
						
						$(result).find("value").each(function() {  
							value = $(this).text();  
						});
						
						if(value == 'success'){
							fnPage(1);
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
						}
					}
					, error:function (request, status, error) {
						alert('<spring:message code="fail.common.msg" text="error" />');
					}
			 	});
			}
			
		});
		
		// 게시물 이동
		$('#move_btn').click(function(){
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
			
			$('body').css({overflow:'hidden'});
			
			$.ajax({
		        type:'POST'
		      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cmmn/mvmnNttPopup.do'
		      , cache : false
		      , async : false
		      , data:$("#listFrm").serialize()
		      , success:function (data) {
		    	  //$("#bbs_layer").show();
		    	  //$("#bbs_layer").html(data);
		    	  var title = '<spring:message code="wzwg.module.word.nttmvmn" />';
		    	  wzAjaxModal('popup_s', title, data);
		      }
		      , error:function (request, status, error) {
		    	  alert('<spring:message code="fail.common.msg" text="error" />');
		      }
		      , dataType: 'html'
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
					, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/qna/deleteNttInfoAjax.do'
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
	function fnView(nttSeq, ntcrId, secretAt){
		
		if(secretAt == 'Y') {
			if('<c:out value="${loginVO.userId}"/>' != ntcrId && '<c:out value="${sessionScope.SADMIN_AT}"/>' != 'true' && '<c:out value="${sessionScope.NADMIN_AT}"/>' != 'true' && '<c:out value="${sessionScope.CNTNTS_ADMIN_AT}"/>' != 'true'){
				alert('<spring:message code="wzwg.cmm.msg.MSG004" />');
				return;
			}
		}			
		
		var frm = document.listFrm;
		
		frm.nttSeq.value = nttSeq;
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/qna/selectNttDetailAjax.do'
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
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/qna/selectNttListAjax.do'
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
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/qna/selectNttListAjax.do'
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
	
	// FAQ 삭제
	function fnDelNotice(nttSeq){
		var frm = document.listFrm;
		
		$('#checkNttSeq').val("");
		
		frm.nttSeq.value = nttSeq;
		frm.noticeAt.value = "N";
		
		if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006"><spring:argument>FAQ</spring:argument><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
			$.ajax({
				type:'POST'    
				, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/qna/modifyNttNoticeAjax.do'
				, dataType: 'xml'
				, data:$("#listFrm").serialize()
				, success:function (result) {
					var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value == 'success'){
						fnPage(1);
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
					}
				}
				, error:function (request, status, error) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});
		}
	}
	
	// 댓글 팝업
	function fnAnswerPop(nttSeq, ntcrId, secretAt){
		
		if(secretAt == 'Y' && '<c:out value="${loginVO.userId}"/>' != ntcrId){
			alert('<spring:message code="wzwg.cmm.msg.MSG004" />');
			return;
		}
		
		var frm = document.listFrm;
		
		frm.nttSeq.value = nttSeq;
		
		$('body').css({overflow:'hidden'});
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/answer/selectNttAnswerFormPopup.do'
	      , cache : false
	      , async : false
	      , data:$("#listFrm").serialize()
	      , success:function (data) {
	    	  $("#bbs_layer").show();
	    	  $("#bbs_layer").html(data);
	      }
	      , error:function (request, status, error) {
	    	  alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
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

		<c:if test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or sessionScope.CNTNTS_ADMIN_AT}">
			<c:set var="adminAuthAt" value="Y"/>
		</c:if>		
		
		<c:if test="${not empty resultVO.bbsPrface}">
		<div class="mb30">
			<c:out value='${resultVO.bbsPrface}' escapeXml="false" />
		</div>
		</c:if>				
		
		<c:set var="expsrAtNoAt" value="N"/>
		<c:set var="expsrAtWrtrAt" value="N"/>
		<c:set var="expsrAtRgsdAt" value="N"/>
		<c:set var="expsrAtIngrAt" value="N"/>
		<c:set var="expsrCnt" value="0" />
		
		<c:forEach items="${fn:split(resultVO.expsrAt, ',')}" var="expsrArr">
			<c:choose>
					<c:when test="${expsrArr eq 'N'}">
						<c:set var="expsrAtNoAt" value="Y"/>
						<c:set var="expsrCnt" value="${expsrCnt + 1}" />			
					</c:when>
					<c:when test="${expsrArr eq 'W'}">
						<c:set var="expsrAtWrtrAt" value="Y"/>
						<c:set var="expsrCnt" value="${expsrCnt + 1}" />
					</c:when>
					<c:when test="${expsrArr eq 'R'}">
						<c:set var="expsrAtRgsdAt" value="Y"/>
						<c:set var="expsrCnt" value="${expsrCnt + 1}" />
					</c:when>
					<c:when test="${expsrArr eq 'I'}">
						<c:set var="expsrAtIngrAt" value="Y"/>
						<c:set var="expsrCnt" value="${expsrCnt + 1}" />
					</c:when>
					<c:otherwise>
						<c:set var="expsrCnt" value="0" />
					</c:otherwise>
				</c:choose>
    	</c:forEach>
		
		<form:form modelAttribute="paramVO" path="listFrm" id="listFrm" name="listFrm" method="post">
			<form:hidden path="siteSeq" />
			<form:hidden path="bbsSeq" />
			<form:hidden path="nttSeq" />
			<form:hidden path="faqAt" />
			<form:hidden path="noticeAt" />
			<form:hidden path="pageIndex" />
			<form:hidden path="ordrSe" />
			<form:hidden path="searchCnd" />
			<form:hidden path="checkNttSeq" />
			<form:hidden path="menuSeq" />
			<form:hidden path="mngrAt" />
			<form:hidden path="secretAt" />
			<form:hidden path="searchAt" />
			
			<form:hidden path="atchFilePosblAt" value="${fn:escapeXml(resultVO.atchFilePosblAt)}" />
			<form:hidden path="atchFilePosblCo" value="${fn:escapeXml(resultVO.atchFilePosblCo)}" />
			<form:hidden path="sitecntntsSeq" />

			<c:set var="temp_listCntSeTit"><spring:message code="wzwg.module.word.listcountse" /></c:set>
			<c:set var="listCntSeTit"><c:out value="${temp_listCntSeTit}" /></c:set>
			<div>
				<div class="main-menu-bar i-block" style="float:left;">
					<c:import url="/module/bbs/cmmn/selectBbsSubospecSelectListAjax.do" charEncoding="utf-8">
						<c:param name="param_bbsSeq" value="${paramVO.bbsSeq}" />
					</c:import>
				</div>	
				
				<c:if test="${resultVO.listCountAt eq 'Y'}">
					<div class="txt-r">
					<form:select path="listCount" name="listCount" id="listCount" cssStyle="width:80px;margin-bottom:0px;" title="${fn:escapeXml(listCntSeTit)}">
						<c:forEach items="${countList}" var="rowCount">
							<form:option value="${fn:escapeXml(rowCount)}"><label for="list_count"><c:out value="${rowCount}"/><spring:message code="wzwg.cmm.word.count03" /></label></form:option>
						</c:forEach>
					</form:select>
					<button type="button" class="wzbtn btn-basic" id="btn-listCount" onclick="fnListCountChange()"><spring:message code="wzwg.cmm.word.change" /></button>
					</div>
				</c:if>
			</div>	
			
			<jsp:include page="/WEB-INF/jsp/wzwg/module/ntt/qna/nttTab.jsp"></jsp:include>

			<%-- <c:set var="tableCss" value="basic-table02 txt-c"/>
			<c:if test="${paramVO.mngrAt eq 'N'}">
				<c:set var="tableCss" value="basic-table01"/>
			</c:if>		 --%>	
			
			<c:set var="tableCss" value="basic-table01"/>
				
			
			<h5 id="subospecSj_txt" class="hide-txt"><c:out value="${paramVO.subospecSj}"/><c:if test="${empty paramVO.subospecSj}"><spring:message code="wzwg.module.word.allqestnanswer" /></c:if></h5>
			<table class="<c:out value='${tableCss}'/>">
				<caption id="contentsCaption"><spring:message code="wzwg.module.word.postlist" /></caption>
				  <colgroup>
					<c:if test="${adminAuthAt eq 'Y'}">
						<col width="5%"/>						
					</c:if>
					<c:if test="${mobileAt eq 'N'}">
						<c:if test="${expsrAtNoAt eq 'Y' }"><col width="10%"/></c:if>
						<col width="*"/>
						<c:if test="${expsrAtWrtrAt eq 'Y' }"><col width="10%"/></c:if>
						<c:if test="${expsrAtRgsdAt eq 'Y' }"><col width="10%"/></c:if>
						<c:if test="${expsrAtIngrAt eq 'Y' }"><col width="10%"/></c:if>
					</c:if>
					<c:if test="${mobileAt eq 'Y'}">
						<col width="*"/>
						<c:if test="${expsrAtWrtrAt eq 'Y' }"><col width="20%"/></c:if>
						<c:if test="${expsrAtRgsdAt eq 'Y' }"><col width="20%"/></c:if>
					</c:if>
			      </colgroup>
				  <thead>
					<tr>
						<c:if test="${adminAuthAt eq 'Y'}">
							<th scope="col"><input type="checkbox" name="nttAllChk" id="nttAllChk" title="<spring:message code="wzwg.cmm.word.rowallchoise" />"/></th>
						</c:if>	
						<c:if test="${mobileAt eq 'N' and expsrAtNoAt eq 'Y'}">					
							<th scope="col"><spring:message code="wzwg.cmm.word.no" /></th>
						</c:if>
						<th scope="col"><span><spring:message code="wzwg.cmm.word.sj" /></span></th>
						
						<c:if test="${expsrAtWrtrAt eq 'Y' }">
						<th scope="col"><span><spring:message code="wzwg.cmm.word.wrter" /></span></th>
						</c:if>
						 
						<c:if test="${expsrAtRgsdAt eq 'Y' }">
						<th scope="col">
							<span><spring:message code="wzwg.cmm.word.rgsde02" /></span>
						</th>
						</c:if>
						<c:if test="${mobileAt eq 'N' and expsrAtIngrAt eq 'Y'}">
							<th scope="col">
								<span><spring:message code="wzwg.cmm.word.inqire" /></span>
							</th>
						</c:if>				
					</tr>
			      </thead>
				<tbody>
					<c:import url="${wzwg_contextPath}${prefix}/module/ntt/cmmn/selectNttNoticeListAjax.do" charEncoding="utf-8">
						<c:param name="expsrAt" 	value="${resultVO.expsrAt}" />
						<c:param name="adminAuthAt" value="${adminAuthAt}" />
						<c:param name="mobileAt" 	value="${mobileAt}" />
						<c:param name="subospecSeq" value="${subospecSeq}" />
						<c:param name="noticeSe" 	value="F" />
					</c:import>	 
					
					<c:if test="${!empty resultList}">
					<c:forEach var="resultList" items="${resultList}" varStatus="status">
					
					<c:set var="listDetAuthAt" value="" />
					
					<c:if test="${loginVO.usrSeq eq resultList.ntcrSeq or nttAuthVO.authorSe eq 'R' or nttAuthVO.authorSe eq 'W' or adminAuthAt eq 'Y'}">
						<c:set var="listDetAuthAt" value="Y" />
					</c:if>							
					
					<tr>
						<c:if test="${adminAuthAt eq 'Y'}">
							<td>
								<input type="checkbox" name="nttChk" id="nttChk" value="<c:out value="${resultList.nttSeq}"/>" title="<spring:message code="wzwg.cmm.word.rowchoise" />"/>
							</td>
						</c:if>
						
						<c:if test="${mobileAt eq 'N' and expsrAtNoAt eq 'Y'}">
						<td>
							<c:choose>
								<c:when test="${resultVO.listNumCode eq 'P'}">
									<c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.recordCountPerPage + status.count) + 1}"/>
								</c:when>
								<c:otherwise>
									<c:out value="${resultList.nttSeq}"/>
								</c:otherwise>
							</c:choose>
						</td>
						</c:if>
						
						<td class="txt-l">
							<c:choose>
								<c:when test="${!empty resultList.nttSj}">
									<c:if test="${fn:length(resultList.nttSj) > 43}">
										<c:set var="nttSj" value="${fn:substring(resultList.nttSj, 0, 43)}..." />
									</c:if>
									<c:if test="${fn:length(resultList.nttSj) < 44}">
										<c:set var="nttSj" value="${resultList.nttSj}" />
									</c:if>
								</c:when>
								<c:otherwise>
									<c:set var="nttSj"><spring:message code="wzwg.cmm.word.untitle"/></c:set>
								</c:otherwise>
							</c:choose>
							
							<c:if test="${!empty resultList.subospecSj}">
							<span>[<c:out value="${resultList.subospecSj}"/>]</span>
							</c:if>
							
							<c:if test="${resultList.secretAt eq 'Y'}">
								<span class="lock"><i class="fa fa-lock" aria-hidden="true"></i><span><spring:message code="wzwg.module.word.secretposts" /></span></span>
							</c:if>
							
							<c:choose>
								<c:when test="${listDetAuthAt eq 'Y'}">
									<a href="javascript:void(0);" class="samu" onclick="fnView('<c:out value="${resultList.nttSeq}"/>', '<c:out value="${resultList.ntcrId}"/>', '<c:out value="${resultList.secretAt}"/>');"><c:out value="${nttSj}"/></a>							
									<c:if test="${resultList.answerCnt > 0}">
										<span class="reflyTxt"><i class="fa fa-comment-o" aria-hidden="true"></i><span class="blind"><spring:message code="wzwg.module.word.registanswerco" /></span><span class="rfno"><c:out value="${resultList.answerCnt}"/></span></span>
									</c:if>			
								</c:when>
								<c:otherwise>							
									<a href="javascript:void(0);" class="samu" onclick="alert('<spring:message code="wzwg.cmm.msg.MSG084" />');"><c:out value="${nttSj}"/></a>							
									<c:if test="${resultList.answerCnt > 0}">
										<a href="javascript:void(0);" onclick="alert('<spring:message code="wzwg.cmm.msg.MSG084" />');">
											<span class="reflyTxt"><i class="fa fa-comment-o" aria-hidden="true"></i><span class="blind"><spring:message code="wzwg.module.word.registanswerco" /></span><span class="rfno"><c:out value="${resultList.answerCnt}"/></span></span>
										</a>
									</c:if>															
								</c:otherwise>
							</c:choose>	
							
							<c:if test="${resultList.nttReplyCnt > 0}">
								<span class="reflyYN"><spring:message code="wzwg.cmm.word.answer01" /> <c:out value="${resultList.nttReplyCnt}"/></span>
							</c:if>
							
							<!--<c:if test="${resultList.nttChoiceAt eq 'Y'}">
								<img src="/images/wzwg/module/ntt/select.png" alt="<spring:message code="wzwg.cmm.word.choice" />" />
							</c:if>-->
							
							<c:if test="${resultList.nttNew eq 'Y'}">
								<img src="/images/wzwg/module/ntt/new.png" alt="<spring:message code="wzwg.module.word.newpostsicon" />"/>
							</c:if>
							
							<c:if test="${resultVO.atchFilePosblAt eq 'Y' and resultList.atchFileCnt ne '0'}">
								<span class="atchFileIcon">
								<i class="fa fa-paperclip" aria-hidden="true"></i>
								<span class="blind"><spring:message code="wzwg.cmm.word.file" /></span>
								</span>
							</c:if>					
						</td>
						
						<c:if test="${expsrAtWrtrAt eq 'Y' }">
						<td class="smalltd">
							<c:if test="${resultList.annymtyAt eq 'Y'}"><spring:message code="wzwg.cmm.word.annymty" /></c:if>
							<c:if test="${resultList.annymtyAt ne 'Y'}"><c:out value="${resultList.ntcrNm}"/></c:if>							
						</td>
						</c:if>
						
						<c:if test="${expsrAtRgsdAt eq 'Y' }">
						<td class="smalltd"><c:out value="${resultList.frstRegistPnttm}"/></td>
						</c:if>
						
						<c:if test="${mobileAt eq 'N' and expsrAtIngrAt eq 'Y'}">
						<td><c:out value="${resultList.inqireCnt}"/></td>
						</c:if>
						
					</tr>
					
					</c:forEach>
					</c:if>					
					
					<c:set var="colCnt" value="1" />
					<c:if test="${adminAuthAt eq 'Y'}">
						<c:set var="colCnt" value="2" />
					</c:if>
					
					<c:if test="${mobileAt eq 'Y'}">
						<c:set var="colCnt" value="${colCnt - 2}" />
				 	</c:if>
							
					<c:if test="${empty resultList}">
						<tr>
							<c:set var="temp_colSpan" value="${colCnt + expsrCnt}" />
							<td colspan="<c:out value='${temp_colSpan}'/>"><spring:message code="wzwg.cmm.msg.MSG085" /></td>
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
					<c:if test="${expsrAtWrtrAt eq 'Y' }">
					<form:option value="3"><label for="option3"><spring:message code="wzwg.module.word.wrternm" /></label></form:option>
					</c:if>
				</form:select>
				
				<c:set var="srchwrd">
					<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
				</c:set>
				<form:input path="searchKeyword" id="searchKeyword" placeholder="${fn:escapeXml(srchwrd)}" cssClass="txt" onkeydown="if(event.keyCode == 13){fnPage(1);}" title="${fn:escapeXml(searchkeyinp)}"/>
				<!-- <input type="button" id="btn_search" value="<spring:message code='wzwg.cmm.word.search01' />" class="wzbtn-table btn-srch" onclick="fnSearch('btn_search');" title="<spring:message code="wzwg.module.word.searchbutton" />"> -->		 
				<a href="javascript:void(0);" id="btn_search" class="wzbtn-table btn-srch" onclick="fnSearch('btn_search');" title="<spring:message code="wzwg.module.word.searchbutton" />"><spring:message code="wzwg.cmm.word.search01" /></a>
			</div>					
			
			<div class="btnbox-r wd100 mt30">

				<c:set var="subospecModAuthAt" value="" />
				<c:set var="movAuthAt" value="" />
				<c:set var="delAuthAt" value="" />
				<c:set var="regAuthAt" value="" />	
				
				<c:if test="${nttAuthVO.authorSe eq 'W'}">
					<c:set var="regAuthAt" value="Y" />
				</c:if>
			
				<c:if test="${adminAuthAt eq 'Y'}">
					<c:if test="${subospecListCnt > 0}">	
						<c:set var="subospecModAuthAt" value="Y" />
					</c:if>
					<c:set var="listTopRegAuthAt" value="Y" />
					<c:set var="faqRegAuthAt" value="Y" />
					<c:set var="movAuthAt" value="Y" />						
					<c:set var="delAuthAt" value="Y" />
					<c:set var="regAuthAt" value="Y" />
				</c:if>					

				<c:if test="${subospecModAuthAt eq 'Y'}">	
					<c:if test="${resultVO.cmntUseAt ne 'Y'}">		
					<a href="javascript:void(0);" class="wzbtn btn-basic fl" id="subospec_modify_btn"><spring:message code="wzwg.module.word.ctgryupdt" /></a>
					</c:if>
				</c:if>
				<c:if test="${delAuthAt eq 'Y'}">
					<a href="javascript:void(0);" class="wzbtn btn-del fl" id="delete_btn"><spring:message code="wzwg.module.word.choisedelete" /></a>
				</c:if>
			
				<c:if test="${listTopRegAuthAt eq 'Y'}">
					<a href="javascript:void(0);" class="wzbtn btn-basic" id="list_top_regist_btn">FAQ <spring:message code="wzwg.cmm.word.regist" /></a>
				</c:if>
				<c:if test="${faqRegAuthAt eq 'Y'}">
					<a href="javascript:void(0);" class="wzbtn btn-basic" id="faq_regist_btn"><spring:message code="wzwg.module.word.faqregist" /></a>
				</c:if>
				<c:if test="${movAuthAt eq 'Y'}">
					<a href="javascript:void(0);" class="wzbtn btn-basic" id="move_btn"><spring:message code="wzwg.cmm.word.mvmn" /></a>
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
