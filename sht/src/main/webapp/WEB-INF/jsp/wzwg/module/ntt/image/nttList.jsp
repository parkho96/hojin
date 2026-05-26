<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript" src="/js/wzwg/cmm/common.js"></script>

<script type="text/javascript">
if($(location).attr('href').indexOf('/cmnt') > -1) {
	if(cmntNm && cmntMenuNm) {
		try{document.title = cmntNm+'-<spring:message code="wzwg.module.word.cmmntymain" />';}catch(e){console.log(e.message);}	
	}else {
		try{document.title = '<spring:message code="wzwg.module.word.cmmntymain" />';}catch(e){console.log(e.message);}
	}
}else {
	try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.cmm.word.list" />';}catch(e){console.log(e.message);}
}

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
        , url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/image/selectNttListAjax.do'
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

function fnCallRegistForm() {
    
    $.ajax({
          type : 'POST'
        , dataType: 'html'
        , url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/image/registNttFormAjax.do'
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

	$(document).ready(function(){
	  	$('#contentsCaption').html($('#menuNm').val() + ' <spring:message code="wzwg.module.word.postlist" />');
	    
		// 글쓰기
		$('#regist_form_btn').click(function(){
		    fnCallRegistForm();
		});
		
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
		    	  //$("#content").css("height",$(document).height());
		    	  //$(window).scrollTop(0);
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
					, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/image/deleteNttInfoAjax.do'
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
	function fnView(nttSeq, ntcrId, secretAt, parntsNttSeq, parntsNtcrId){
		
		var viewAt = "N";
		
		if(secretAt == 'Y') {
			if('<c:out value="${loginVO.userId}"/>' == ntcrId || '<c:out value="${sessionScope.SADMIN_AT}"/>' == 'true' || '<c:out value="${sessionScope.NADMIN_AT}"/>' == 'true' ||'<c:out value="${sessionScope.CNTNTS_ADMIN_AT}"/>' == 'true' ){
				viewAt = "Y";
			} else if('<c:out value="${loginVO.userId}"/>' == parntsNtcrId){
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
			frm.parntsNtcrId.value = parntsNtcrId;
			
			$.ajax({
				  type : 'POST'
				, dataType: 'html'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/image/selectNttDetailAjax.do'
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
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/image/selectNttListAjax.do'
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
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/image/selectNttListAjax.do'
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
	
	// 공지 게시물 삭제
	function fnDelNotice(nttSeq){
		var frm = document.listFrm;
		
		frm.nttSeq.value = nttSeq;
		
		if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006"><spring:argument><spring:message code="wzwg.cmm.word.notice02" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
			$.ajax({
		        type:'POST'
		      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/image/modifyNttNoticeAjax.do'
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
			<input type="hidden" name="parntsNtcrId" id="parntsNtcrId" value="" />
			<input type="hidden" name="cmntUseAt" id="cmntUseAt" value="${fn:escapeXml(resultVO.cmntUseAt)}" />
			<form:hidden path="atchFilePosblAt" value="${fn:escapeXml(resultVO.atchFilePosblAt)}" />
			<form:hidden path="atchFilePosblCo" value="${fn:escapeXml(resultVO.atchFilePosblCo)}" />
			
			<c:set var="temp_listCntSeTit"><spring:message code="wzwg.module.word.listcountse" /></c:set>
			<c:set var="listCntSeTit" value="${temp_listCntSeTit}" />
			<div class="selectBbsSubospec">
				<c:if test="${resultVO.cmntUseAt ne 'Y'}">
				<div class="main-menu-bar i-block" style="float:left;">
					<c:import url="${wzwg_contextPath}${prefix}/module/bbs/cmmn/selectBbsSubospecSelectListAjax.do" charEncoding="utf-8">
						<c:param name="param_bbsSeq" value="${paramVO.bbsSeq}" />
						<c:param name="cateTy" value="${resultVO.cateTy}" />
					</c:import>	
				</div>	
				</c:if>
				
				<c:if test="${resultVO.listCountAt eq 'Y'}">
					<div style="float:right;">
						<form:select path="listCount" name="listCount" id="listCount" cssStyle="width:80px;margin-bottom:0px;" title="${fn:escapeXml(listCntSeTit)}">
						    <c:forEach items="${countList}" var="countList">
						        <form:option value="${fn:escapeXml(countList)}">
						            ${fn:escapeXml(countList)}<spring:message code="wzwg.cmm.word.count03" />
						        </form:option>
						    </c:forEach>
						</form:select>
						<button type="button" class="wzbtn btn-basic" id="btn-listCount" onclick="fnListCountChange()"><spring:message code="wzwg.cmm.word.change" /></button>
					</div>
				</c:if>
			</div>
			
			<%-- <c:set var="tableCss" value="basic-table02 txt-c"/>
			<c:if test="${paramVO.mngrAt eq 'N'}">
				<c:set var="tableCss" value="basic-table01"/>
			</c:if>		 --%>	
			
			<c:set var="tableCss" value="basic-table01"/>
				
			
			<h6 id="subospecSj_txt" class="hide-txt"><c:out value="${paramVO.subospecSj}"/><c:if test="${empty paramVO.subospecSj}"><spring:message code="wzwg.cmm.word.all" /></c:if></h6>
			
			<table class="<c:out value='${tableCss}'/>">
				<caption id="contentsCaption"><spring:message code="wzwg.module.word.postlist" /></caption>
				  <colgroup>
					<c:if test="${adminAuthAt eq 'Y'}">
						<col width="5%"/>						
					</c:if>
					<c:if test="${mobileAt eq 'N'}">
						<col width="10%"/>
						<col width="*"/>
						<col width="10%"/> 
						<col width="10%"/>
						<col width="10%"/>
					</c:if>
					<c:if test="${mobileAt eq 'Y'}">
						<col width="*"/>
						<col width="20%"/>
						<col width="20%"/>
					</c:if>
			      </colgroup>
				  <thead>
					<tr>
						<c:if test="${adminAuthAt eq 'Y'}">
							<th scope="col"><input type="checkbox" name="nttAllChk" id="nttAllChk" title="<spring:message code="wzwg.cmm.word.rowallchoise" />"/></th>					
						</c:if>
						<c:if test="${mobileAt eq 'N'}">
							<th scope="col"><span><spring:message code="wzwg.cmm.word.no" /></span></th>
						</c:if>
						<th scope="col"><span><spring:message code="wzwg.cmm.word.sj" /></span></th>
						<th scope="col"><span><spring:message code="wzwg.cmm.word.wrter" /></span></th> 
						<th scope="col"><span><spring:message code="wzwg.cmm.word.rgsde02" /></span></th>
						<c:if test="${mobileAt eq 'N'}">
							<th scope="col"><span><spring:message code="wzwg.cmm.word.inqire" /></span></th>
						</c:if>
					</tr>
			      </thead>
				  <tbody>
	
					<c:import url="${wzwg_contextPath}${prefix}/module/ntt/cmmn/selectNttNoticeListAjax.do" charEncoding="utf-8">
						<c:param name="expsrAt" 	value="" />
						<c:param name="adminAuthAt" value="${adminAuthAt}" />
						<c:param name="mobileAt" 	value="${mobileAt}" />
						<c:param name="subospecSeq" value="${subospecSeq}" />
						<c:param name="noticeSe" 	value="N" />
					</c:import>	  		  
				   
					<c:if test="${!empty resultList}">
			
						<c:forEach var="resultList" items="${resultList}" varStatus="status">		
						
						<c:set var="listDetAuthAt" value="" />
						<c:set var="modAuthAt" value="" />
						<c:set var="delAuthAt" value="" />
						
						<c:if test="${resultList.secretAt eq 'Y'}">
							<c:if test="${!empty loginVO.userId and loginVO.userId eq resultList.parntsNtcrId}">
								<c:set var="listDetAuthAt" value="Y" />
							</c:if>	
						</c:if>
						<c:if test="${resultList.secretAt ne 'Y'}">
							<c:if test="${nttAuthVO.authorSe eq 'R' or nttAuthVO.authorSe eq 'W' or cmntAuthR eq 'Y' or cmntAuthW eq 'Y'}">
								<c:set var="listDetAuthAt" value="Y" />
							</c:if>						
						</c:if>
						
						<c:if test="${loginVO.usrSeq eq resultList.ntcrSeq or adminAuthAt eq 'Y'}">
							<c:set var="listDetAuthAt" value="Y" />
							<c:set var="modAuthAt" value="Y" />
							<c:set var="delAuthAt" value="Y" />
						</c:if>				

						<tr>
							
							<c:if test="${adminAuthAt eq 'Y'}">
								<c:set var="temp_nttSeq" value="${resultList.nttSeq}" />
								<c:set var="temp_rowTitle"><spring:message code="wzwg.cmm.word.rowchoise" /></c:set>
								<td><input type="checkbox" name="nttChk" id="nttChk" value="<c:out value='${temp_nttSeq}'/>" title="<c:out value='${temp_rowTitle}'/>"/></td>				
							</c:if>						
			
							<c:if test="${mobileAt eq 'N'}">
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
						
								<c:if test="${resultList.lv > 1}">
									<c:set var="temp_pd_reply_class" value="${(10 * resultList.lv) - 10}" />
									<img src="/images/wzwg/module/ntt/icoReply.png" style="margin-left:<c:out value='${temp_pd_reply_class}'/>px;" alt="<spring:message code="wzwg.cmm.word.answer03" />" />
								</c:if>
							
								<c:if test="${!empty resultList.subospecSj}">
									<span>[<c:out value="${resultList.subospecSj}"/>]</span>
								</c:if>
								
								<c:if test="${resultList.secretAt eq 'Y'}">
									<span class="lock"><i class="fa fa-lock" aria-hidden="true"></i><span><spring:message code="wzwg.module.word.secretposts" /></span></span>
								</c:if>
							
								<c:choose>
									<c:when test="${listDetAuthAt eq 'Y'}">
										<a href="javascript:void(0);" onclick="fnView('<c:out value="${resultList.nttSeq}"/>', '<c:out value="${resultList.ntcrId}"/>', '<c:out value="${resultList.secretAt}"/>', '<c:out value="${resultList.parntsNttSeq}"/>','<c:out value="${resultList.parntsNtcrId}"/>');"><c:out value="${nttSj}"/></a>							
										<c:if test="${resultList.answerCnt > 0}">
											<span class="colorRed">[<c:out value="${resultList.answerCnt}"/>]</span>
										</c:if>					
									</c:when>
									<c:otherwise>
										<a href="javascript:void(0);" onclick="alert('<spring:message code="wzwg.cmm.msg.MSG084" />');"><c:out value="${nttSj}"/></a>							
										<c:if test="${resultList.answerCnt > 0}">
											<a href="javascript:void(0);" onclick="alert('<spring:message code="wzwg.cmm.msg.MSG084" />');">
												<span class="colorRed">[<c:out value="${resultList.answerCnt}"/>]</span>
											</a>								
										</c:if>							
									</c:otherwise>
								</c:choose>	
								
								<c:if test="${resultList.nttNew eq 'Y'}">
									<img src="/images/wzwg/module/ntt/new.png" alt="<spring:message code="wzwg.module.word.newpostsicon" />"/>
								</c:if>
								
								<c:if test="${resultVO.atchFilePosblAt eq 'Y' and resultList.atchFileCnt ne '0'}">
									<img src="/images/wzwg/module/ntt/ico-file.gif" alt="<spring:message code="wzwg.module.word.atchfileicon" />"/>
								</c:if>							
							</td>
							<td>
								<c:if test="${resultList.annymtyAt eq 'Y'}"><spring:message code="wzwg.cmm.word.annymty" /></c:if>
								<c:if test="${resultList.annymtyAt ne 'Y'}"><c:out value="${resultList.ntcrNm}"/></c:if>							
							</td>
							<td><c:out value="${resultList.frstRegistPnttm}"/></td>
							
							<c:if test="${mobileAt eq 'N'}">
							<td class="txt-c"><c:out value="${resultList.inqireCnt}"/></td>
							</c:if>
							
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
							<td colspan="${fn:escapeXml(colCnt)}"><spring:message code="wzwg.cmm.msg.MSG085" /></td>
						</tr>
					</c:if>	

				  </tbody>
			</table>
			
			<c:if test="${!empty resultList}">
			<div class="ctr-box">
				<ul id="pageInfo" class="num">
					<ui:pagination paginationInfo="${paginationInfo}" type="ntt" jsFunction="fnPage" />
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
				    <spring:message code="wzwg.cmm.cmmMsg.CMG011">
				        <spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument>
				        <spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
				    </spring:message>
				</c:set>
				<form:input path="searchKeyword" id="searchKeyword" placeholder="${fn:escapeXml(srchwrd)}" cssClass="txt" onkeydown="if(event.keyCode == 13){fnPage(1);}" title="${fn:escapeXml(searchkeyinp)}"/>
				<a href="javascript:void(0);" id="btn_search" class="wzbtn-table btn-srch" onclick="fnSearch('btn_search');" title="<spring:message code="wzwg.module.word.searchbutton" />"><spring:message code="wzwg.cmm.word.search01" /></a>		 
			</div>
			
			<div class="rt-box">

				<c:set var="subospecModAuthAt" value="" />
				<c:set var="movAuthAt" value="" />
				<c:set var="delAuthAt" value="" />
				<c:set var="regAuthAt" value="" />					
			
				<c:if test="${nttAuthVO.authorSe eq 'W' or cmntAuthW eq 'Y'}">
					<c:set var="regAuthAt" value="Y" />
				</c:if>
				
				<c:if test="${adminAuthAt eq 'Y'}">
					<c:if test="${subospecListCnt > 0}">	
						<c:set var="subospecModAuthAt" value="Y" />
					</c:if>
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
					<a href="javascript:void(0);" class="wzbtn btn-del " id="delete_btn"><spring:message code="wzwg.module.word.choisedelete" /></a>
				</c:if>							
				<c:if test="${movAuthAt eq 'Y'}">
					<c:if test="${resultVO.cmntUseAt ne 'Y'}">
					<a href="javascript:void(0);" class="wzbtn btn-basic" id="move_btn"><spring:message code="wzwg.cmm.word.mvmn" /></a>
					</c:if>
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
		
		