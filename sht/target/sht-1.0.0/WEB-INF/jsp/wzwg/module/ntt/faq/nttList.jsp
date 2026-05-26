<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.cmm.word.list" />';}catch(e){console.log(e.message);}

	<c:if test="${!empty authorMessage}">
		alert('<c:out value="${authorMessage}"/>');
		history.go(-1);
	</c:if>

	function fnSubospecSeq(subospecSeq) {
	    $('#subospecSeq').val(subospecSeq);
	    fnCallSubospecList();
	}

	function fnCallSubospecList() {
	    
	    var frm = document.listFrm;

	    frm.pageIndex.value = 1;
	    
	    $.ajax({
	          type : 'POST'
	        , dataType: 'html'
	        , url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/faq/selectNttListAjax.do'
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
	}
	
	$(document).ready(function(){
		$('#contentsCaption').html($('#menuNm').val() + ' <spring:message code="wzwg.module.word.postlist" />');
		
		// 말머리 선택
		$('#btn_subospecSeq').click(function(){
		    fnCallSubospecList();
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
		
		// 글쓰기
		$('#regist_form_btn').click(function(){
			
			$.ajax({
				  type : 'POST'
				, dataType: 'html'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/faq/registNttFormAjax.do'
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
			if(!confirm('<spring:message code="wzwg.cmm.msg.MSG059" />')){
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
					, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/faq/deleteNttInfoAjax.do'
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
	
	// 상세정보
	function fnView(nttSeq, ntcrId, secretAt, parntsNttSeq, num, el, ntcrSeq){
		
		var viewAt = "N";
		
		if(secretAt == 'Y') {
			if('<c:out value="${loginVO.usrSeq}"/>' == ntcrSeq || '<c:out value="${sessionScope.SADMIN_AT}"/>' == 'true' || '<c:out value="${sessionScope.NADMIN_AT}"/>' == 'true'){
				viewAt = "Y";
			} else {
				viewAt = fnNtcrIdCheck(parntsNttSeq);	
			}
		} else {
			viewAt = "Y";
		}

		if(viewAt == "Y"){

			for(var i = 1; i <= '${fn:length(resultList)}'; i++){

				if(num == i) {

					if($('#faq_reply_'+i).css('display') == 'none') {
						$('#faq_reply_'+i).show();
						$(el).attr('title', '<spring:message code="wzwg.module.word.answerfold" />');
					} else {
						$('#faq_reply_'+i).hide();
						$(el).attr('title', '<spring:message code="wzwg.module.word.answeropen" />');
					}
				} /* else {
					$('#faq_reply_'+i).hide();
				} */
			};

		} else {
			alert('<spring:message code="wzwg.cmm.msg.MSG004" />');
			return;			
		}		
	}
	
	function fnNtcrIdCheck(nttSeq) {
		var viewAt = "N";
		
		$.ajax({
			  type : 'POST'
			, dataType: 'xml'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cmmn/selectNttNtcrIdAjax.do'
			, cache : false
			, async : false
			, data:"nttSeq="+nttSeq
			, success:function (result) {
				$(result).find("value").each(function() {  
					value = $(this).text();  
				});

				if(value != '<c:out value="${loginVO.userId}"/>'){
					viewAt = "N";
				} else {
					viewAt = "Y";
				}
			}
			, error : function (request, status, error) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});			
		return viewAt;
	}
	
	function fnPage(pageIndex, callId){
		var frm = document.listFrm;
		
		frm.pageIndex.value = pageIndex;
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/faq/selectNttListAjax.do'
			, cache : false
			, async : false
			, data:$("#listFrm").serialize()
			, success:function (data) {
				$('#bbs_area').html(data);
				$("#content").css("height",$(document).height());
				//$(window).scrollTop(0);
				$('#pageInfo').find('.on>a').focus();
				if(callId != undefined || callId != ''){
	            	$('#' + callId).focus();
	            }
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
	// 수정
	function fnModify(nttSeq) {

		var frm = document.listFrm;
		
		frm.nttSeq.value = nttSeq;

		$.ajax({
	        type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/faq/modifyNttFormAjax.do'
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

		<%-- <c:if test="${not empty resultVO.bbsPrface}">
		<div class="mb30">
			<c:out value='${resultVO.bbsPrface}' escapeXml="false" />
		</div>
		</c:if>	 --%>
		<div class="mb30">
		<c:choose>
			<c:when test="${empty resultVO.bbsPrface or resultVO.bbsPrface eq '<p><br></p>'}">
				<jsp:include page="${wzwg_contextPath}/module/bbs/cmmn/selectCmmBbsPrfaceAjax.do"/>
			</c:when>
			<c:otherwise>
				<c:out value='${resultVO.bbsPrface}' escapeXml="false" />
			</c:otherwise>
		</c:choose>
		</div>
		
		<form:form modelAttribute="paramVO" path="listFrm" id="listFrm" name="listFrm" method="post">
			<form:hidden path="siteSeq" />
			<form:hidden path="bbsSeq" />
			<form:hidden path="nttSeq" />
			<form:hidden path="pageIndex" />
			<form:hidden path="ordrSe" />
			<form:hidden path="searchCnd" />
			<form:hidden path="checkNttSeq" />	
			<form:hidden path="menuSeq" />
			<form:hidden path="mngrAt" />
			<form:hidden path="parntsNttSeq" />
			<form:hidden path="secretAt" />		
			<form:hidden path="searchAt" />
			<form:hidden path="sitecntntsSeq" />
			<input type="hidden" name="cmntUseAt" id="cmntUseAt" value="${resultVO.cmntUseAt}" />
			<form:hidden path="atchFilePosblAt" value="${resultVO.atchFilePosblAt}" />
			<form:hidden path="atchFilePosblCo" value="${resultVO.atchFilePosblCo}" />	
			
			<div class="search-box">
				<c:set var="searchkeyinp"><spring:message code="wzwg.module.word.searchkeywordinput" /></c:set>
				<p><spring:message code="wzwg.cmm.msg.MSG314" /></p>
				<div>
					<form:input path="searchKeyword" id="searchKeyword" cssClass="w30" onkeydown="if(event.keyCode == 13){fnPage(1);}" title="${searchkeyinp}"/>
					<a href="javascript:void(0);" id="btn_search" class="wzbtn-table btn-srch" onclick="fnPage(1, 'btn_search');" ><spring:message code="wzwg.cmm.word.inqire" /></a>
				</div>
			</div>
			<div class="selectBbsSubospec">
				<c:if test="${resultVO.cmntUseAt ne 'Y'}">
				<div class="main-menu-bar i-block" style="float:left;">
					<c:import url="${wzwg_contextPath}${prefix}/module/bbs/cmmn/selectBbsSubospecSelectListAjax.do" charEncoding="utf-8">
						<c:param name="param_bbsSeq" 		value="${paramVO.bbsSeq}" />
						<c:param name="cateTy" 				value="${resultVO.cateTy}" />
					</c:import>	
				</div>	
				</c:if>
			</div>
			<h6 id="subospecSj_txt" class="hide-txt"><c:out value="${paramVO.subospecSj}"/><c:if test="${empty paramVO.subospecSj}"><spring:message code="wzwg.cmm.word.all" /></c:if></h6>
			<%-- <h4 id="subospecSj_txt">${paramVO.subospecSj}<c:if test="${empty paramVO.subospecSj}"><spring:message code="wzwg.cmm.word.all" /></c:if></h4> --%>
		
			<table class="basic-table board_faq">
				  <colgroup>
					  <c:if test="${adminAuthAt eq 'Y'}">
						<col width="5%" />
						<col width="*%" />
						<col width="10%" />
				 	  </c:if>
				 	  <c:if test="${adminAuthAt ne 'Y'}">
						<col width="100%" />
				 	  </c:if>
			      </colgroup>
			      
			      <c:if test="${nowUrl.indexOf('/mngr') > -1}">
				  <thead>
					<tr>
					  <c:if test="${adminAuthAt eq 'Y'}">
						<th scope="col"><input type="checkbox" name="nttAllChk" id="nttAllChk"  title="<spring:message code="wzwg.cmm.word.rowallchoise" />"/></th>
						<th scope="col"><spring:message code="wzwg.cmm.word.sj" /></th>
						<th scope="col"><spring:message code="wzwg.cmm.word.manage" /></th>
				 	  </c:if>
				 	  <c:if test="${adminAuthAt ne 'Y'}">
						<th scope="col"><spring:message code="wzwg.cmm.word.sj" /></th>
				 	  </c:if>					
					</tr>
			      </thead>
			      </c:if>
			      
				  <tbody>
				
					<c:if test="${!empty resultList}">
	
						<c:forEach var="resultList" items="${resultList}" varStatus="status">		
						
						<tr>
						
							<c:if test="${adminAuthAt eq 'Y'}">
								<td><input type="checkbox" name="nttChk" id="nttChk" value="<c:out value='${resultList.nttSeq}'/>" title="<spring:message code="wzwg.cmm.word.rowchoise" />"/></td>				
							</c:if>						
							<td   class="txt-l">		
							
								<div>
									<ul>
										<li>	
							
											<c:choose>
												<c:when test="${!empty resultList.nttSj}">
													<c:set var="nttSj" value="${resultList.nttSj}" />
												</c:when>
												<c:otherwise>
													<c:set var="nttSj"><spring:message code="wzwg.cmm.word.untitle"/></c:set>
												</c:otherwise>
											</c:choose>
			
											<c:if test="${!empty resultList.subospecSj}">
												<span><strong>[ <c:out value="${resultList.subospecSj}"/> ]</strong></span>
											</c:if>
														
											<a href="javascript:void(0);" onclick="fnView('<c:out value="${resultList.nttSeq}"/>', '<c:out value="${resultList.ntcrId}"/>', '<c:out value="${resultList.secretAt}"/>', '<c:out value="${resultList.parntsNttSeq}"/>', '<c:out value="${status.count}"/>', this, '<c:out value="${resultList.ntcrSeq}"/>');" title="<spring:message code="wzwg.cmm.word.answer01" /> <spring:message code="wzwg.cmm.word.open03" />">
												<b class="blind"><spring:message code="wzwg.cmm.word.qestn" /></b>
												<c:out value="${nttSj}"/>
											</a>
											
										</li>
										
										<li id="faq_reply_<c:out value='${status.count}'/>" style="display:none;">
											<div>
												<b class="blind"><spring:message code="wzwg.cmm.word.answer01" /></b>
												<c:out value='${fn:replace(resultList.nttCn, cn, "<br />")}' escapeXml="false" />
											</div>
											<c:if test="${resultList.atchFileCnt ne '0'}">
											<div class="fileBox">
												<ul>
													<li>
														<spring:message code="wzwg.module.word.atchfile" /><span>(<c:out value="${resultList.atchFileCnt}"/>)</span>
													</li>								
												</ul>
												<div id="atchFile_div" style="display:none;">
												<c:import url="${wzwg_contextPath}/module/upload/file/selectFileInc.do" charEncoding="utf-8">
													<c:param name="param_atchFileId" 	value="${resultList.atchFileId}" />
													<c:param name="param_updateFlag" 	value="N" />
													<c:param name="param_atchFileNumber" 	value="${resultVO.atchFilePosblCo}" />
													<c:param name="param_cntntsSeq" 		value="${resultVO.bbsSeq}" />
												</c:import>
												</div>										
											</div>
											</c:if>											
										</li>
										
									</ul>
								</div>						
													
							</td>
							<c:if test="${adminAuthAt eq 'Y'}">
								<td><a href="javascript:void(0);" class="wzbtn-table btn-basic" onclick="fnModify('<c:out value="${resultList.nttSeq}"/>');"><spring:message code="wzwg.cmm.word.updt" /></a></td>
							</c:if>
						</tr>
							
						</c:forEach>
					</c:if>		
					
					
					<c:set var="colCnt" value="1" />
					<c:if test="${adminAuthAt eq 'Y'}">
						<c:set var="colCnt" value="3" />
					</c:if>
				
					<c:if test="${empty resultList}">
						<tr>
							<td style="padding:15px 0;" colspan="<c:out value='${colCnt}'/>"><spring:message code="wzwg.cmm.msg.MSG085" /></td>
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
			
			<div class="rt-box">

				<c:set var="delAuthAt" value="" />
				<c:set var="regAuthAt" value="" />					
			
				<c:if test="${nttAuthVO.authorSe eq 'W' or cmntAuthW eq 'Y'}">
					<c:set var="regAuthAt" value="Y" />
				</c:if>
				
				<c:if test="${adminAuthAt eq 'Y'}">
					<c:if test="${subospecListCnt > 0}">	
						<c:set var="subospecModAuthAt" value="Y" />
					</c:if>
					<c:set var="delAuthAt" value="Y" />
					<c:set var="regAuthAt" value="Y" />
				</c:if> 
				<c:if test="${subospecModAuthAt eq 'Y'}">	
					<a href="javascript:void(0);" class="wzbtn btn-basic fl" id="subospec_modify_btn"><spring:message code="wzwg.module.word.ctgryupdt" /></a>
				</c:if>	
				<c:if test="${delAuthAt eq 'Y'}">
					<a href="javascript:void(0);" id="delete_btn" class="wzbtn btn-del fl"><spring:message code="wzwg.module.word.choisedelete" /></a>
				</c:if>
				<c:if test="${regAuthAt eq 'Y'}">
					<a href="javascript:void(0);" id="regist_form_btn" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.regist" /></a>			
				</c:if>	
									
			</div>			

			<c:if test="${nowUrl.indexOf('/mngr') == -1 }">
			<div class="mt20">
				<c:import url="${wzwg_contextPath}/usr/cntnts/cntPagadiEstbs/selectCntPagadiEstbsUsrAjax.do">
					<c:param name="cntntsSeq" value="${paramVO.bbsSeq }" />
					<c:param name="nttSeqAt" value="N" />
				</c:import>
			</div>
			</c:if>
			
		</form:form>	