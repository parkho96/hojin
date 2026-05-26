<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script src="/clipboard/dist/clipboard.min.js"></script>

<script type="text/javascript">
if($(location).attr('href').indexOf('/cmnt') > -1) {
	if(cmntNm && cmntMenuNm) {
		try{document.title = cmntNm+'-'+cmntMenuNm+'-<spring:message code="wzwg.cmm.word.detail" />';}catch(e){console.log(e.message);}	
	}else {
		try{document.title = '<spring:message code="wzwg.cmm.word.detail" />';}catch(e){console.log(e.message);}
	}
}else {
	try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.cmm.word.detail" />';}catch(e){console.log(e.message);}
}


	$(document).ready(function(){
	    
		// 답글 
		$('#reply_btn').click(function(){
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/image/selectNttReplyFormAjax.do'
				, dataType : 'html'
				, data : $("#detailFrm").serialize()
				, success : function (data) {
					$('#bbs_area').html(data);
					$("#content").css("height",$(document).height());
			     	$(window).scrollTop(0);
				}
				, error : function (request, status, error) {
					alert("code : " + request.status + "\r\nmessage : " + request.reponseText);
				}
			});
		});
		
		// 수정
		$('#modify_btn').click(function(){
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/image/modifyNttFormAjax.do'
				, dataType : 'html'
				, data : $("#detailFrm").serialize()
				, success : function (data) {
					$('#bbs_area').html(data);
					$("#content").css("height",$(document).height());
			     	$(window).scrollTop(0);
				}
				, error : function (request, status, error) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
			});
		});
		
		// 수정(상단 버튼)
		$('#modify_top_btn').click(function(){
			$('#modify_btn').click();
		});
		
		// 삭제
		$('#delete_btn').click(function(){
			if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
				return;
			}else{
				$.ajax({
			        type : 'POST'
					, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/image/deleteNttInfoAjax.do'
					, dataType: 'xml'
					, data : $("#detailFrm").serialize()
					, success : function (result) {
						var value = "";
						
						$(result).find("value").each(function() {  
							value = $(this).text();  
						});
						
						if(value == 'success'){
							$('#list_btn').click();
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
						}
					}
					, error : function (request, status, error) {
						alert('<spring:message code="fail.common.msg" text="error" />');
					}
				});
			}
		});
		
		// 삭제(상단 버튼)
		$('#delete_top_btn').click(function(){
			$('#delete_btn').click();
		});
		
		// 이동
		$('#move_btn').click(function(){
			
 			$('body').css({overflow:'hidden'});
			
			$.ajax({
		        type:'POST'
		      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cmmn/mvmnNttPopup.do'
		      , cache : false
		      , async : false
		      , data:$("#detailFrm").serialize()
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
		
		// 목록
		$('#list_btn').click(function(){
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/image/selectNttListAjax.do'
				, dataType : 'html'
				, data : $("#detailFrm").serialize()
				, success : function (data) {
					$('#bbs_area').html(data);
					$("#content").css("height",$(document).height());
			     	$(window).scrollTop(0);
				}
				, error : function (request, status, error) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
			});
		});
		
		// 스크랩 버튼
		$('#scrap_btn').click(function(){
			/* 
				레이어팝업으로 스크랩 그룹 지정 팝업 띄우고
				selectbox 로 등록된 그룹 보여주고 옆에 그룹추가 버튼 
				그룹추가 버튼 클릭하면 그룹 등록 팝업으로 변경
				그룹 선택 후 스크랩 저장 버튼 누르면 스크랩 되었다고 마이페이지에서 확인할 수 있다는 메시지 보여주고 팝업 close
				
				마이페이지에서 '나의 스크랩' 이런 메뉴 만들어서
				선택하면 스크랩한 게시물 목록을 게시판명/게시물제목/스크랩날짜 로 보여주고
				클릭하면 해당 게시판 게시물 상세보기로 이동
			*/
			$.ajax({
		       type:'POST'
		        , dataType: 'xml'
				, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/scrap/selectNttScrapDplctChkAjax.do'
				, cache : false
				, data: $("#detailFrm").serialize()
				, success:function (result) {
					var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value == 'success'){
						$.ajax({
					        type:'POST'
					      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/scrap/registNttScrapPopup.do'
					      , cache : false
					      , async : false
					      , data:$("#detailFrm").serialize()
					      , success:function (data) {
					    	  var title = '<spring:message code="wzwg.module.word.scrapregist" />';
					    	  wzAjaxModal('popup_s', title, data, false);
					      }
					      , error:function (request, status, error) {
					    	  alert('<spring:message code="fail.common.msg" text="error" />');
					      }
					      , dataType: 'html'
					 	});
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG017"><spring:argument><spring:message code="wzwg.module.word.nttscrap" /></spring:argument></spring:message>');
						return;
					}
					
				}
				, error:function (data) {
				    alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});
			
		});
		<c:set var="repNttSj">${fn:replace(resultVO.nttSj, "'", "\\'")} </c:set>
		// 게시물 공유 버튼
		$('#cnrs_btn').click(function(){
			$.ajax({
		        type:'POST'
		      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/cmm/snsCnrs/selectSnsCnrsPopup.do'
		      , cache : false
		      , async : false
		      , data:'param_menuSeq=<c:out value="${paramVO.menuSeq}"/>&param_nttSeq=<c:out value="${resultVO.nttSeq}"/>&param_nttSj=<c:out value="${repNttSj}"/>&param_mobileAt=<c:out value="${mobileAt}"/>'
		      , success:function (data) {
		    	  var title = '<spring:message code="wzwg.cmm.word.cnrs" />';
		    	  wzAjaxModal('popup_la', title, data, true, $('#cnrs_btn'));
		      }
		      , error:function (request, status, error) {
		    	  alert('<spring:message code="fail.common.msg" text="error" />');
		      }
		      , dataType: 'html'
		 	});
		});
		
		// 인쇄 버튼
		$('#print_btn').click(function(){
			var printWindow = window.open("", "_blank");
			var printContents = $('.conM_txt').html();
			
			printWindow.document.write('<head>');
			printWindow.document.write($('head').html());
			printWindow.document.write('</head>');
			
			printWindow.document.write('<div>');
			printWindow.document.write(printContents);
			printWindow.document.write('</div>');
			
			printWindow.print();
			printWindow.document.close();
		});
		
	});
	
	function fnViewPage(nttSeq, ntcrId, secretAt, parntsNttSeq, parntsNtcrSeq, ntcrSeq){
		var viewAt = "N";
		
		if(secretAt == 'Y') {
			if('<c:out value="${loginVO.usrSeq}"/>'){
				if('<c:out value="${loginVO.usrSeq}"/>' == ntcrSeq || '<c:out value="${sessionScope.SADMIN_AT}"/>' == 'true' || '<c:out value="${sessionScope.NADMIN_AT}"/>' == 'true'){
					viewAt = "Y";
				} else if('<c:out value="${loginVO.usrSeq}"/>' == parntsNtcrSeq){
					viewAt = "Y";
				} else {
					viewAt = fnNtcrIdCheck(parntsNttSeq);	
				}
			}
		} else {
			viewAt = "Y";
		}

		if(viewAt == "Y"){
			var frm = document.detailFrm;
			
			frm.nttSeq.value = nttSeq;
			frm.parntsNttSeq.value = parntsNttSeq;
			frm.secretAt.value = secretAt;
			
			$.ajax({
				  type : 'POST'
				, dataType: 'html'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/image/selectNttDetailAjax.do'
				, cache : false
				, async : false
				, data:$("#detailFrm").serialize()
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
	
	// 제목에서 게시판 클릭시 목록으로 이동
	function fnBbsList(){
		$('#list_btn').click();	
	}
	
	// 태그 사용 게시물 목록
	function fnNttTagList(tagSeq){
		alert('Preparing !!');
	}
		
	window.onkeydown = function() {

	    var keyCode = event.keyCode;

	    if(keyCode == 8
	    		&& 'INPUT'.indexOf(event.target.nodeName.toUpperCase()) == -1 
	    		&& 'TEXTAREA'.indexOf(event.target.nodeName.toUpperCase()) == -1) {

	    	$('#list_btn').click();
	    	return false;
		}
	}	
	
</script>

		<c:set var="adminAuthAt" value="N"/>
		
		<c:if test="${paramVO.cmntUseAt eq 'Y'}">
			<c:if test="${sessionScope.cmntMngrAt == true}">
				<c:set var="adminAuthAt" value="Y"/>
			</c:if>
		</c:if>		

		<c:if test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or sessionScope.CNTNTS_ADMIN_AT}">
			<c:set var="adminAuthAt" value="Y"/>
		</c:if>

		<c:set var="repAuthAt" value="" />
		<c:set var="modAuthAt" value="" />
		<c:set var="movAuthAt" value="" />
		<c:set var="delAuthAt" value="" />

		<c:if test="${nttAuthVO.authorSe eq 'W'}">
			<c:set var="repAuthAt" value="Y" />
		</c:if>
	
		<c:if test="${loginVO.usrSeq eq resultVO.ntcrSeq or adminAuthAt eq 'Y'}">
			<c:set var="repAuthAt" value="Y" />
			<c:set var="modAuthAt" value="Y" />
			<c:set var="delAuthAt" value="Y" />
		</c:if>	
		
		<c:if test="${adminAuthAt eq 'Y'}">
			<c:set var="movAuthAt" value="Y" />
		</c:if>
		
		<c:if test="${not empty moduleBbsVO.bbsPrface}">
		<div class="mb30">
			<c:out value='${moduleBbsVO.bbsPrface}' escapeXml="false" />
		</div>
		</c:if>		
		
		<form:form modelAttribute="paramVO" path="detailFrm" id="detailFrm" name="detailFrm" method="post">
			<form:hidden path="siteSeq" />
			<form:hidden path="bbsSeq" />
			<form:hidden path="nttSeq" />
			<form:hidden path="pageIndex" />
			<form:hidden path="searchCondition" />
			<form:hidden path="searchKeyword" />
			<form:hidden path="menuSeq" />
			<form:hidden path="mngrAt" />
			<form:hidden path="searchAt" />
			<form:hidden path="cmntUseAt" />
			<form:hidden path="listCount" />
			<form:hidden path="sitecntntsSeq" />
			<form:hidden path="parntsNttSeq" />
			<form:hidden path="secretAt" />
			<form:hidden path="atchFilePosblAt" value="${fn:escapeXml(moduleBbsVO.atchFilePosblAt)}" />
			<form:hidden path="atchFilePosblCo" value="${fn:escapeXml(moduleBbsVO.atchFilePosblCo)}" />
			
			<c:if test="${!empty resultVO.nextNttInfo}">
				<c:set var="nextNttInfo" value="${fn:split(resultVO.nextNttInfo, ',') }" />				
			</c:if>
			
			<c:if test="${!empty resultVO.prevNttInfo}">
				<c:set var="prevNttInfo" value="${fn:split(resultVO.prevNttInfo, ',') }" />	
			</c:if>
			
			<div class="mb10">
				<c:if test="${!empty prevNttInfo}">
					<a href="javascript:void(0);" class="wzbtn-table btn-grey" onclick="fnViewPage('<c:out value="${prevNttInfo[0]}"/>', '<c:out value="${prevNttInfo[3]}"/>', '<c:out value="${prevNttInfo[5]}"/>', '<c:out value="${resultVO.parntsNttSeq}"/>', '<c:out value="${resultVO.parntsNtcrSeq}"/>', '<c:out value="${prevNttInfo[7]}"/>');">▲ <spring:message code="wzwg.module.word.prevposts" /></a>
				</c:if>
				<c:if test="${!empty nextNttInfo}">
					<a href="javascript:void(0);" class="wzbtn-table btn-grey" onclick="fnViewPage('<c:out value="${nextNttInfo[0]}"/>', '<c:out value="${nextNttInfo[3]}"/>', '<c:out value="${nextNttInfo[5]}"/>', '<c:out value="${resultVO.parntsNttSeq}"/>', '<c:out value="${resultVO.parntsNtcrSeq}"/>', '<c:out value="${nextNttInfo[7]}"/>');">▼ <spring:message code="wzwg.module.word.nextposts" /></a>
				</c:if>
			</div>
			
			<div class="board001">
					<div class="list_tit">
						<h5>
						<c:if test="${!empty resultVO.subospecSj}">
							[<c:out value="${resultVO.subospecSj}"/>]
						</c:if>					
						<c:out value="${resultVO.nttSj}"/>
						<!-- 			
						<span class="tit_bar">
							<a href="javascript:void(0);" onclick="fnBbsList();"><c:out value="${resultVO.bbsNm}"/></a>
						</span>	
						 -->	
						</h5>
						<p class="list_date">
							<strong><spring:message code="wzwg.cmm.word.rgsde02" /></strong>
							<span><c:out value="${resultVO.frstRegistPnttm}"/></span>
							<span class="com_bar">
							<c:if test="${modAuthAt eq 'Y'}">
								<a href="javascript:void(0);" id="modify_top_btn" class="gray"><spring:message code="wzwg.cmm.word.updt" /></a>
							</c:if>
							<c:if test="${delAuthAt eq 'Y'}">
								<a href="javascript:void(0);" id="delete_top_btn" class="gray"><spring:message code="wzwg.cmm.word.delete" /></a>
							</c:if>					
							</span>												
						</p>
					</div><!-- list_tit end -->
					<div class="list_content">
						<div class="conTop">
							<p class="writer">
								<strong><spring:message code="wzwg.cmm.word.wrter" /></strong>
								<span>
									<c:if test="${resultVO.annymtyAt eq 'Y'}"><spring:message code="wzwg.cmm.word.annymty" /></c:if>
									<c:if test="${resultVO.annymtyAt ne 'Y'}"><c:out value="${resultVO.ntcrNm}"/>(<c:out value="${fn:substring(resultVO.ntcrId, 0, 4)}"/>****)</c:if>
								</span>
							</p>
							
							<c:if test="${!empty loginVO and fn:indexOf(prefix, 'mngr') eq -1}">
								<a href="javascript:void(0);" id="cnrs_btn"><img src="/images/wzwg/cmm/cnrs_btn.png" alt='<spring:message code="wzwg.cmm.word.cnrs" />'></a>
							</c:if>
							
							<c:if test="${fileEstbsSe eq 'B'}">
								<c:if test="${moduleBbsVO.atchFilePosblAt eq 'Y' and resultVO.atchFileCnt ne '0'}">
								<ul>
									<li>
										<a href="javascript:void(0);">
										<spring:message code="wzwg.module.word.atchfile" /><span>(<c:out value="${resultVO.atchFileCnt}"/>)</span>
										</a>
									</li>
								</ul>
								<div id="atchFile_div" style="display:none;">
									<c:import url="${wzwg_contextPath}/module/upload/file/selectFileInc.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" 		value="${resultVO.atchFileId}" />
										<c:param name="param_updateFlag" 		value="N" />
										<c:param name="param_atchFileNumber" 	value="${moduleBbsVO.atchFilePosblCo}" />
										<c:param name="param_cntntsSeq" 		value="${resultVO.bbsSeq}" />
									</c:import>
								</div>
								</c:if>
							</c:if>	
						</div>
						
						<div class="conMiddle">
							<div class="conM_txt">
								<c:out value='${resultVO.nttCn}' escapeXml="false" />
							</div>
							
							<%-- <c:if test="${!empty tagList}">
							<div class="conMiddle">
								<div class="mg_t20">
									<span class="btn btn_default btn_m mg_r10"><spring:message code="wzwg.cmm.word.tag" /></span>
									<!-- 태그 목록 start -->
									<c:forEach var="tagList" items="${tagList}" varStatus="status">
										<span class="mg_r5" style="background-color:#D5D5D5;"><a href="javascript:void(0);" onclick="fnNttTagList('${tagList.tagSeq}');">#${tagList.tagNm}</a></span>
									</c:forEach>
									<!-- 태그 목록 end -->
								</div>
							</div>
							</c:if>	 --%>					
							
							<div id="module_inc_<c:out value='${resultVO.nttSeq}'/>">
								<ul>
								<!-- 댓글, 등록순, 조회수, 좋아요 -->
									<c:if test="${resultVO.answerPermAt eq 'Y'}">
										<c:import url="${wzwg_contextPath}${prefix}/module/ntt/answer/selectNttAnswerIncAjax.do" charEncoding="utf-8">
											<c:param name="param_nttSeq" value="${resultVO.nttSeq}" />
										</c:import>
									</c:if>
									
									<li><a style="cursor:text;"><span><spring:message code="wzwg.cmm.word.rdcnt" /> <c:out value="${resultVO.inqireCnt}"/></span></a></li>
								</ul>	
							</div>
							
						</div>
						
						<div class="conBottom">
							
							<c:if test="${fileEstbsSe eq 'C'}">
								<c:if test="${moduleBbsVO.atchFilePosblAt eq 'Y' and resultVO.atchFileCnt ne '0'}">
									<c:import url="${wzwg_contextPath}/module/upload/crossuploader/downloadForm.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" 		value="${resultVO.atchFileId}" />
									</c:import>
								</c:if>
							</c:if>
							
							<div id="module_div_<c:out value='${resultVO.nttSeq}'/>">
								
								<div class="answer cmtbg" style="display:none;">
									<c:if test="${resultVO.answerPermAt eq 'Y'}">
										<c:import url="${wzwg_contextPath}${prefix}/module/ntt/answer/selectNttAnswerFormAjax.do" charEncoding="utf-8">
											<c:param name="param_nttSeq" value="${resultVO.nttSeq}" />
											<c:param name="param_bbsSeq" value="${paramVO.bbsSeq}" />
										</c:import>
									</c:if>
								</div>
								
							</div>					

						</div>
					</div><!-- list_content end -->
			</div>
			
			<div class="rt-box">

				<c:if test="${delAuthAt eq 'Y'}">
					<a href="javascript:void(0);" id="delete_btn" class="wzbtn btn-del fl"><spring:message code="wzwg.cmm.word.delete" /></a>
				</c:if>
				
				<c:if test="${!empty loginVO}">
					<%-- <a href="javascript:void(0);" id="print_btn"><img src="/images/wzwg/cmm/ico-print.png" title='<spring:message code="wzwg.cmm.word.prntng" />' alt='<spring:message code="wzwg.cmm.word.prntng" />'></a> --%>
					<%-- <a href="javascript:void(0);" id="print_btn" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.prntng" /></a> --%>
					
					<%-- <c:if test="${resultVO.scrapAt eq 'Y'}">
						<a href="javascript:void(0);" id="scrap_btn" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.scrap" /></a>
					</c:if> --%>
				</c:if>
				
				<c:if test="${repAuthAt eq 'Y'}">
					<a href="javascript:void(0);" id="reply_btn" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.answer03" /></a>
				</c:if>
				
				<c:if test="${movAuthAt eq 'Y'}">
					<c:if test="${paramVO.cmntUseAt ne 'Y'}">
					<a href="javascript:void(0);" id="move_btn" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.mvmn" /></a>	
					</c:if>					
				</c:if>
				
				<c:if test="${modAuthAt eq 'Y'}">
					<a href="javascript:void(0);" id="modify_btn" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.updt" /></a>
				</c:if>
				
				<a href="javascript:void(0);" id="list_btn" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
				
			</div>		
			
			<div class="mt30">
				<table class="basic-table01">
					<caption><spring:message code="wzwg.module.word.prevposts" /> <spring:message code="wzwg.module.word.nextposts" /></caption>
					<colgroup>
						<col width="10%"/>
						<col width="*"/>
						<col width="15%"/>
						<col width="15%"/>
					</colgroup>
						
					<c:if test="${!empty prevNttInfo}">
					<tr>
						<th scope="row" class="bg-white br-btm1 br-top0 br-lft0 br-rgt0 br-lightgrey brsolid">▲ <spring:message code="wzwg.module.word.prevposts" /></th>
						<td>
							<c:if test="${prevNttInfo[5] eq 'Y'}">
								<img src="/images/wzwg/module/ntt/ico-secret.png" alt="<spring:message code="wzwg.module.word.secretposts" />" />
							</c:if>
							<a href="javascript:void(0);" onclick="fnViewPage('<c:out value="${prevNttInfo[0]}"/>', '<c:out value="${prevNttInfo[3]}"/>', '<c:out value="${prevNttInfo[5]}"/>', '<c:out value="${resultVO.parntsNttSeq}"/>', '<c:out value="${resultVO.parntsNtcrSeq}"/>', '<c:out value="${prevNttInfo[7]}"/>');"><c:out value="${prevNttInfo[1]}"/></a>
						</td>
						<td>
							<c:if test="${prevNttInfo[6] eq 'Y'}"><spring:message code="wzwg.cmm.word.annymty" /></c:if>
							<c:if test="${prevNttInfo[6] ne 'Y'}"><c:out value="${prevNttInfo[2]}"/></c:if>
						</td>
						<td><c:out value="${prevNttInfo[4]}"/></td>
					</tr>
					</c:if>
					<c:if test="${!empty nextNttInfo}">
					<tr>
						<th scope="row" class="bg-white br-btm1 br-top0 br-lft0 br-rgt0 br-lightgrey brsolid">▼ <spring:message code="wzwg.module.word.nextposts" /></th>
						<td>
							<c:if test="${nextNttInfo[5] eq 'Y'}">
								<img src="/images/wzwg/module/ntt/ico-secret.png" alt="<spring:message code="wzwg.module.word.secretposts" />" />
							</c:if>
							<a href="javascript:void(0);" onclick="fnViewPage('<c:out value="${nextNttInfo[0]}"/>', '<c:out value="${nextNttInfo[3]}"/>', '<c:out value="${nextNttInfo[5]}"/>', '<c:out value="${resultVO.parntsNttSeq}"/>', '<c:out value="${resultVO.parntsNtcrSeq}"/>', '<c:out value="${prevNttInfo[7]}"/>');"><c:out value="${nextNttInfo[1]}"/></a></td>
						<td>
							<c:if test="${nextNttInfo[6] eq 'Y'}"><spring:message code="wzwg.cmm.word.annymty" /></c:if>
							<c:if test="${nextNttInfo[6] ne 'Y'}"><c:out value="${nextNttInfo[2]}"/></c:if>
						</td>
						<td><c:out value="${nextNttInfo[4]}"/></td>
					</tr>
					</c:if>
				</table>
			</div>
			
		</form:form>
				
		<c:if test="${not empty moduleBbsVO.bbsCnclsn}">
		<div class="mt30">
			<c:out value='${moduleBbsVO.bbsCnclsn}' escapeXml="false" />
		</div>
		</c:if>				
				
