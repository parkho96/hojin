<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">

	$(document).ready(function(){
		
		// 글쓰기
		$('#regist_form_btn').click(function(){
			
			$.ajax({
				  type : 'POST'
				, dataType: 'html'
				, url : '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/unity/registNttFormAjax.do'
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
		      , url:'<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/cmmn/modifySubospecPopup.do'
		      , cache : false
		      , async : false
		      , data:$("#listFrm").serialize()
		      , success:function (data) {
		    	  //$("#bbs_layer").show();
		    	  //$("#bbs_layer").html(data);
		    	  var title = '<spring:message code="wzwg.sysMngr.word.ctgry02Updt" />';
		    	  wzAjaxModal('popup_s', title, data);
		      }
		      , error:function (request, status, error) {
		    	  alert('<spring:message code="fail.common.msg" text="error" />');
		      }
		      , dataType: 'html'
		 	});
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
		      , url:'<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/cmmn/mvmnNttPopup.do'
		      , cache : false
		      , async : false
		      , data:$("#listFrm").serialize()
		      , success:function (data) {
		    	  $("#bbs_layer").show();
		    	  $("#bbs_layer").html(data);
		    	  $("#content").css("height",$(document).height());
		    	  $(window).scrollTop(0);
		      }
		      , error:function (request, status, error) {
		    	  alert('<spring:message code="fail.common.msg" text="error" />');
		      }
		      , dataType: 'html'
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
					, url:'<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/unity/deleteNttInfoAjax.do'
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
	function fnView(nttSeq, ntcrId, secretAt, parntsNttSeq, ntcrSeq){
		
		var viewAt = "N";
		
		if(secretAt == 'Y') {
			if('<c:out value="${loginVO.usrSeq}" />' == ntcrSeq || '<c:out value="${sessionScope.SADMIN_AT}" />' == 'true' || '<c:out value="${sessionScope.NADMIN_AT}" />' == 'true'){
				viewAt = "Y";
			} else {
				viewAt = fnNtcrIdCheck(parntsNttSeq);	
			}
		} else {
			viewAt = "Y";
		}

		if(viewAt == "Y"){
			var frm = document.listFrm;
			
			frm.nttSeq.value = nttSeq;
			frm.parntsNttSeq.value = parntsNttSeq;
			frm.secretAt.value = secretAt;
			
			$.ajax({
				  type : 'POST'
				, dataType: 'html'
				, url : '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/unity/selectNttDetailAjax.do'
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
			, url : '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/cmmn/selectNttNtcrIdAjax.do'
			, cache : false
			, async : false
			, data:"nttSeq="+nttSeq
			, success:function (result) {
				$(result).find("value").each(function() {  
					value = $(this).text();  
				});

				if(value != '<c:out value="${loginVO.userId}" />'){
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
	
	function fnPage(pageIndex){
		
		if(isNaN(pageIndex)){
			console.log('잘못된 페이지호출');
			return;
		}
		
		var frm = document.listFrm;
		
		frm.pageIndex.value = pageIndex;
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/unity/selectNttListAjax.do'
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
	
	// 공지 게시물 삭제
	function fnDelNotice(nttSeq){
		var frm = document.listFrm;
		
		frm.nttSeq.value = nttSeq;
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/unity/modifyNttNoticeAjax.do'
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
	
	// 댓글 팝업
	function fnAnswerPop(nttSeq, ntcrId, secretAt, ntcrSeq){
		
		if(secretAt == 'Y' && '<c:out value="${loginVO.usrSeq}" />' != ntcrSeq){
			alert('<spring:message code="wzwg.cmm.msg.MSG004" />');
			return;
		}
		
		var frm = document.listFrm;
		
		frm.nttSeq.value = nttSeq;
		
		$('body').css({overflow:'hidden'});
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/answer/selectNttAnswerFormPopup.do'
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
	
	function fnSelectSubospec(subospecSeq){
		// 말머리 선택(탭)
		$('#subospecSeq').val(subospecSeq);
		
		var frm = document.listFrm;

		frm.pageIndex.value = 1;
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/unity/selectNttListAjax.do'
			, cache : false
			, async : false
			, data:$("#listFrm").serialize()
			, success:function (data) {
				$('#bbs_area').html(data);
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
			
	}
	
</script>

		<c:set var="adminAuthAt" value="N"/>

		<c:if test="${sessionScope.SADMIN_AT}">
			<c:set var="adminAuthAt" value="Y"/>
		</c:if>

		<form:form modelAttribute="paramVO" path="listFrm" id="listFrm" name="listFrm" method="post">
			<form:hidden path="siteSeq" />
			<form:hidden path="bbsSeq" />
			<form:hidden path="nttSeq" />
			<form:hidden path="pageIndex" />
			<form:hidden path="ordrSe" />
			<form:hidden path="searchCnd" />
			<form:hidden path="checkNttSeq" />	
			<form:hidden path="menuSeq" />
			<form:hidden path="sysMngrAt" />
			<form:hidden path="parntsNttSeq" />
			<form:hidden path="secretAt" />		
			
			<span class="fr mobile-none">
				<select id="pageUnit" name="pageUnit" onchange="fnPage(1);">
					<option value="10" <c:if test="${paramVO.pageUnit eq '10'}">selected</c:if>>10 <spring:message code="wzwg.cmm.word.count02" /></option>
					<option value="20" <c:if test="${paramVO.pageUnit eq '20'}">selected</c:if>>20 <spring:message code="wzwg.cmm.word.count02" /></option>
					<option value="50" <c:if test="${paramVO.pageUnit eq '50'}">selected</c:if>>50 <spring:message code="wzwg.cmm.word.count02" /></option>
					<option value="100" <c:if test="${paramVO.pageUnit eq '100'}">selected</c:if>>100 <spring:message code="wzwg.cmm.word.count02" /></option>
				</select>
			</span>
			<div class="main-menu-bar">
				<span class="fl wd100">
				<c:import url="${wzwg_contextPath}${prefix}/opnsu/bbs/cmmn/selectBbsSubospecSelectListAjax.do" charEncoding="utf-8">
					<c:param name="param_bbsSeq" value="${paramVO.bbsSeq}" />
				</c:import>	
				</span>
			</div>
			<table class="basic-table mngrSuprtTBL noticeTBL">
				  <colgroup>
					<c:if test="${adminAuthAt eq 'Y'}">
						<col width="5%" />					
					</c:if>
					<col width="10%" />
					<col width="*%" />
					<col width="10%" />
			      </colgroup>
				  <thead>
					<tr>
						<c:if test="${adminAuthAt eq 'Y'}">
							<th><input type="checkbox" name="nttAllChk" id="nttAllChk"  /></th>				
						</c:if>
						<th><spring:message code="wzwg.cmm.word.no" /></th>
						<th><spring:message code="wzwg.cmm.word.sj" /></th>
						<!-- <th><spring:message code="wzwg.cmm.word.wrter" /></th> -->
						<th>
							<span id="frstRegistPnttm_asc"><spring:message code="wzwg.cmm.word.rgsde02" /></span>								
						</th>
						<!--<th>
							<span id="inqireCnt_asc"><spring:message code="wzwg.cmm.word.inqire" /></span>									
						</th>-->
					</tr>
			      </thead>
				  <tbody>
		
					<!-- 공지 게시물 목록 -->
					<c:if test="${!empty noticeList}">
						<c:forEach var="noticeList" items="${noticeList}" varStatus="status">		

						<c:set var="noticeDetAuthAt" value="Y" />
								
						<tr>
							<c:if test="${adminAuthAt eq 'Y'}">
								<td>
									<a href="javascript:void(0);" onclick="fnDelNotice('<c:out value="${noticeList.nttSeq}" />');">
										<img class="icoCenter" src="/images/wzwg/cmm/btn-del.gif" />
									</a>
								</td>				
							</c:if>

							<td><img class="icoCenter" src="/images/wzwg/module/ntt/icoNotice.png" alt="<spring:message code="wzwg.cmm.word.notice02" />" /></td>
							<td class="txt-l fw600">
								<c:choose>
									<c:when test="${!empty noticeList.nttSj}">
										<c:if test="${fn:length(noticeList.nttSj) > 43}">
											<c:set var="nttSj" value="${fn:substring(noticeList.nttSj, 0, 43)}..." />
										</c:if>
										<c:if test="${fn:length(noticeList.nttSj) < 44}">
											<c:set var="nttSj" value="${noticeList.nttSj}" />
										</c:if>
									</c:when>
									<c:otherwise>
										<c:set var="nttSj"><spring:message code="wzwg.cmm.word.untitle"/></c:set>
									</c:otherwise>
								</c:choose>		
								
								<c:if test="${!empty noticeList.subospecSj}">
									<span class="mngrBrdCategory"><c:out value="${noticeList.subospecSj}" /></span>
								</c:if>					
								
								<c:choose>
									<c:when test="${noticeDetAuthAt eq 'Y'}">
										<a href="javascript:void(0);" class="notice_p" onclick="fnView('<c:out value="${noticeList.nttSeq}" />', '<c:out value="${noticeList.ntcrId}" />', '<c:out value="${noticeList.secretAt}" />', '<c:out value="${noticeList.parntsNttSeq}" />', '<c:out value="${noticeList.ntcrSeq}" />');"><c:out value="${nttSj}" /></a>
									 						
									</c:when>
									<c:otherwise>
										<a href="javascript:void(0);" class="notice_p" onclick="alert('<spring:message code="wzwg.cmm.msg.MSG084" />');"><c:out value="${nttSj}" /></a>
								 							
									</c:otherwise>
								</c:choose>
								
								<c:if test="${noticeList.atchFileCnt ne '0'}">
									<span class="atchFileIcon">
									<i class="fa fa-paperclip" aria-hidden="true"></i>
									<span class="blind"><spring:message code="wzwg.cmm.word.file" /></span>
									</span>
								</c:if>
							</td>
							<!-- <td><spring:message code="wzwg.cmm.word.mngr" /></td> -->
							<td class="smalltd"><c:out value="${noticeList.frstRegistPnttm}" /></td>
							<!-- <td><c:out value="${noticeList.inqireCnt}" /></td> -->
						</tr>
						
						</c:forEach>
					</c:if>	
				
					<c:if test="${!empty resultList}">
	
						<c:forEach var="resultList" items="${resultList}" varStatus="status">		
						
						<c:set var="listDetAuthAt" value="Y" />
								
						<tr>
						
							<c:if test="${adminAuthAt eq 'Y'}">
								<td><input type="checkbox" name="nttChk" id="nttChk" value="<c:out value="${resultList.nttSeq}" />" /></td>				
							</c:if>						

							<td class="smalltd"><c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.recordCountPerPage + status.count) + 1}" /></td>
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
						
								<c:if test="${resultList.lv > 1}">
									<c:set var="pd_reply_class" value="${(10 * resultList.lv) - 10}" />
									<img src="/images/wzwg/module/ntt/icoReply.png" style="margin-left:<c:out value="${pd_reply_class}" />px;" alt="<spring:message code="wzwg.cmm.word.answer02" />" />
								</c:if>
							
								<c:if test="${!empty resultList.subospecSj}">
									<span class="mngrBrdCategory"><c:out value="${resultList.subospecSj}" /></span>
								</c:if>
											
								<c:choose>
									<c:when test="${listDetAuthAt eq 'Y'}">
										<a href="javascript:void(0);" onclick="fnView('<c:out value="${resultList.nttSeq}" />', '<c:out value="${resultList.ntcrId}" />', '<c:out value="${resultList.secretAt}" />', '<c:out value="${resultList.parntsNttSeq}" />', '<c:out value="${resultList.ntcrSeq}" />');"><c:out value="${nttSj}" /></a>							
										<c:if test="${resultList.answerCnt > 0}">	
											<span class="reflyTxt"><i class="fa fa-comment-o" aria-hidden="true"></i><span class="blind"><spring:message code="wzwg.sysMngr.word.postAnswer02Co" /></span><span class="rfno"><c:out value="${resultList.answerCnt}" /></span></span>				
										</c:if>					
									</c:when>
									<c:otherwise>
										<a href="javascript:void(0);" onclick="alert('<spring:message code="wzwg.cmm.msg.MSG084" />');"><c:out value="${nttSj}" /></a>							
										<c:if test="${resultList.answerCnt > 0}">
											<span class="reflyTxt"><i class="fa fa-comment-o" aria-hidden="true"></i><span class="blind"><spring:message code="wzwg.sysMngr.word.postAnswer02Co" /></span><span class="rfno"><c:out value="${resultList.answerCnt}" /></span></span>							
										</c:if>							
									</c:otherwise>
								</c:choose>							
								
								<c:if test="${resultList.nttNew eq 'Y'}">
									<img src="/images/wzwg/module/ntt/new.png" />
								</c:if>
								
								<c:if test="${resultList.atchFileCnt ne '0'}">
									<span class="atchFileIcon">
									<i class="fa fa-paperclip" aria-hidden="true"></i>
									<span class="blind"><spring:message code="wzwg.cmm.word.file" /></span>
									</span>
								</c:if>							
							</td>
							<td class="smalltd"><c:out value="${resultList.frstRegistPnttm}" /></td>
						</tr>
							
						</c:forEach>
					</c:if>		
					
					
					<c:set var="colCnt" value="3" />
					<c:if test="${adminAuthAt eq 'Y'}">
						<c:set var="colCnt" value="4" />
					</c:if>
				
					<c:if test="${empty resultList}">
						<tr>
							<td colspan="<c:out value="${colCnt}" />"><spring:message code="wzwg.cmm.msg.MSG085" /></td>
						</tr>
					</c:if>	
								

				  </tbody>
			</table>
			<div class="ctr-box" id="pageInfo">
				<ul class="num mobile-none">
					<ui:pagination paginationInfo="${paginationInfo}" type="ntt" jsFunction="fnPage" />
				</ul>
				
				<ul class="num pc-none">
					<ui:pagination paginationInfo="${mobilePaginationInfo}" type="ntt" jsFunction="fnPage" />
				</ul>
			</div>
			<div class="ctr-box">
					<c:set var="msg_title_txt01"> 
							 <spring:message code="wzwg.sysMngr.word.sch01Se" /> 
					</c:set>
					<form:select path="searchCondition" id="searchCondition" title="${fn:escapeXml(msg_title_txt01)}"> 
						<form:option value=""><label for="option"><spring:message code="wzwg.cmm.word.all" /></label></form:option>
						<form:option value="1"><label for="option1"><spring:message code="wzwg.cmm.word.sj" />+<spring:message code="wzwg.cmm.word.cn" /></label></form:option>
						<form:option value="2"><label for="option2"><spring:message code="wzwg.cmm.word.sj" /></label></form:option>
						<form:option value="3"><label for="option3"><spring:message code="wzwg.sysMngr.word.wrterNm01" /></label></form:option>
					</form:select>
					
					<c:set var="srchwrd">
						<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
					</c:set>
					<form:input path="searchKeyword" id="searchKeyword" placeholder="${fn:escapeXml(srchwrd)}" cssClass="txt" onkeydown="if(event.keyCode == 13){fnPage(1);}" />
					<a href="javascript:void(0);" class="wzbtn-table btn-srch" onclick="fnPage(1);"><spring:message code="wzwg.cmm.word.search01" /></a>
			</div>
			<div class="rt-box">

				<c:set var="subospecModAuthAt" value="" />
				<c:set var="delAuthAt" value="" />
				<c:set var="regAuthAt" value="" />					
			
				<c:if test="${nttAuthVO.authorSe eq 'W'}">
					<c:set var="regAuthAt" value="Y" />
				</c:if>
				
				<c:if test="${adminAuthAt eq 'Y'}">
					<c:if test="${subospecListCnt > 0}">	
						<c:set var="subospecModAuthAt" value="Y" />
					</c:if>
					<c:set var="delAuthAt" value="Y" />
					<c:set var="regAuthAt" value="Y" />
				</c:if>
				
				<c:if test="${delAuthAt eq 'Y'}">
					<a href="javascript:void(0);" id="delete_btn" class="wzbtn btn-del fl"><spring:message code="wzwg.sysMngr.word.choiseDelete" /></a>
				</c:if>
				<c:if test="${subospecModAuthAt eq 'Y'}">			
					<a href="javascript:void(0);" id="subospec_modify_btn" class="wzbtn btn-basic"><spring:message code="wzwg.sysMngr.word.ctgry02Updt" /></a>
				</c:if>
				<c:if test="${regAuthAt eq 'Y'}">
					<a href="javascript:void(0);" id="regist_form_btn" class="wzbtn btn-save bg"><spring:message code="wzwg.cmm.word.regist" /></a>			
				</c:if>	
									
			</div>			

		</form:form>
