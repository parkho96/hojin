<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.cmm.word.detail" />';}catch(e){console.log(e.message);}

	$(document).ready(function(){
		
		$("#module_div").children('.answer').css('display', 'none');
		
		// 수정
		$('#modify_btn').click(function(){
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/qna/modifyNttFormAjax.do'
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
			
			if($('#ntt_reply_detail_txt').text() != '' && $('#ntt_reply_detail_txt').text() != '0'){
				alert('<spring:message code="wzwg.cmm.msg.MSG039" />');
				return;
			}
			
			if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
				return;
			}else{
				$.ajax({
			        type : 'POST'
					, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/qna/deleteNttInfoAjax.do'
					, dataType: 'xml'
					, data : $("#detailFrm").serialize()
					, success : function (result) {
						var value = "";
						
						$(result).find("value").each(function() {  
							value = $(this).text();  
						});
						
						if(value == 'success'){
							$('#list_btn').click();
							
						}else if(value == 'authFail'){
							alert('<spring:message code="wzwg.cmm.msg.MSG084"></spring:message>');
							if($('#menuSeq').length == 1){
								location.replace('/subList/' + $('#menuSeq').val());
							}else{
								location.replace('/<c:out value="${wzwg_contextPath}${prefix}"/>');
							}
							
						}else if(value == 'fail'){
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
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/qna/selectNttListAjax.do'
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
					    	  wzAjaxModal('popup_s', title, data);
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
		    	  wzAjaxModal('popup_la', title, data, true);
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
	
	function fnViewPage(nttSeq, ntcrId, secretAt, parntsNttSeq, parntsNtcrId){
		var viewAt = "N";
		
		if(secretAt == 'Y') {
			if('<c:out value="${loginVO.userId}"/>'){
				if('<c:out value="${loginVO.userId}"/>' == ntcrId || '<c:out value="${sessionScope.SADMIN_AT}"/>' == 'true' || '<c:out value="${sessionScope.NADMIN_AT}"/>' == 'true'){
					viewAt = "Y";
				} else if('<c:out value="${loginVO.userId}"/>' == parntsNtcrId){
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
			frm.secretAt.value = secretAt;
			
			$.ajax({
				  type : 'POST'
				, dataType: 'html'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/qna/selectNttDetailAjax.do'
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

	<c:if test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or sessionScope.CNTNTS_ADMIN_AT}">
		<c:set var="adminAuthAt" value="Y"/>
	</c:if>
	
	<c:set var="modAuthAt" value="" />
	<c:set var="movAuthAt" value="" />
	<c:set var="delAuthAt" value="" />

	<c:if test="${loginVO.usrSeq eq resultVO.ntcrSeq or adminAuthAt eq 'Y'}">
		<c:set var="modAuthAt" value="Y" />
		<c:set var="delAuthAt" value="Y" />
	</c:if>	
	
	<c:if test="${adminAuthAt eq 'Y'}">
		<c:set var="movAuthAt" value="Y" />
	</c:if>		
	
	<c:set var="expsrAtNoAt" value="N"/>
	<c:set var="expsrAtWrtrAt" value="N"/>
	<c:set var="expsrAtRgsdAt" value="N"/>
	<c:set var="expsrAtIngrAt" value="N"/>
	
	<c:forEach items="${fn:split(resultVO.expsrAt, ',')}" var="expsrArr">
		<c:choose>
			<c:when test="${expsrArr eq 'N'}"><c:set var="expsrAtNoAt" value="Y"/></c:when>
			<c:when test="${expsrArr eq 'W'}"><c:set var="expsrAtWrtrAt" value="Y"/></c:when>
			<c:when test="${expsrArr eq 'R'}"><c:set var="expsrAtRgsdAt" value="Y"/></c:when>
			<c:when test="${expsrArr eq 'I'}"><c:set var="expsrAtIngrAt" value="Y"/></c:when>
			<c:otherwise></c:otherwise>
		</c:choose>
   	</c:forEach>
   	

		<c:if test="${not empty moduleBbsVO.bbsPrface}">
		<div class="mb30">
			<c:out value='${moduleBbsVO.bbsPrface}' escapeXml="false" />
		</div>
		</c:if>
	
	
		<c:if test="${!empty resultVO.nextNttInfo}">
			<c:set var="nextNttInfo" value="${fn:split(resultVO.nextNttInfo, ',') }" />				
		</c:if>
		
		<c:if test="${!empty resultVO.prevNttInfo}">
			<c:set var="prevNttInfo" value="${fn:split(resultVO.prevNttInfo, ',') }" />	
		</c:if>
		<!-- 
		<c:if test="${!empty prevNttInfo}">
			<a href="javascript:void(0);" class="wzbtn-table btn-grey" onclick="fnViewPage('<c:out value="${prevNttInfo[0]}"/>', '<c:out value="${resultVO.ntcrId}"/>', '<c:out value="${resultVO.secretAt}"/>', '<c:out value="${resultVO.parntsNttSeq}"/>');">▲ <spring:message code="wzwg.module.word.prevposts" /></a>
		</c:if>
		<c:if test="${!empty nextNttInfo}">
			<a href="javascript:void(0);" class="wzbtn-table btn-grey" onclick="fnViewPage('<c:out value="${nextNttInfo[0]}"/>', '<c:out value="${resultVO.ntcrId}"/>', '<c:out value="${resultVO.secretAt}"/>', '<c:out value="${resultVO.parntsNttSeq}"/>');">▼ <spring:message code="wzwg.module.word.nextposts" /></a>
		</c:if> -->
		
		<div class="board001 mb5 mt10">
			<div class="list_tit">
				<span class="blind"><spring:message code="wzwg.cmm.word.qestn" /></span>
				<h5 class="brdDetailTit">
					<c:if test="${!empty resultVO.subospecSj}">
						[<c:out value="${resultVO.subospecSj}"/>]
					</c:if>					
					<c:out value="${resultVO.nttSj}"/>
					<c:if test="${!empty resultVO.nttReplyCnt and resultVO.nttReplyCnt > 0}">
					<span class="mg_r10" style="font-size:12px;color:#f00;"><spring:message code="wzwg.cmm.word.answer01" /> <span id="ntt_reply_detail_txt"><c:out value="${resultVO.nttReplyCnt}"/></span></span>
					</c:if>
					<span class="sub_title"><c:out value="${resultVO.bbsNm}"/></span>
				</h5>
				<div class="BrtDetailPostInfo">
					<dl>
						<c:if test="${expsrAtWrtrAt eq 'Y'}">
						<dt class="writerTit"><spring:message code="wzwg.cmm.word.wrter" /></dt>
						<dd>
							<c:if test="${resultVO.annymtyAt eq 'Y'}"><spring:message code="wzwg.cmm.word.annymty" /></c:if>
							<c:if test="${resultVO.annymtyAt ne 'Y'}"><c:out value="${resultVO.ntcrNm}"/>(<c:out value="${fn:substring(resultVO.ntcrId, 0, 4)}"/>****)</c:if>
						</dd>
						</c:if>
						
						<c:if test="${expsrAtRgsdAt eq 'Y'}">
						<dt><spring:message code="wzwg.cmm.word.rgsde02" /></dt>
						<dd><c:out value="${resultVO.frstRegistPnttm}"/></dd>
						</c:if>
					</dl>
					
					<c:if test="${!empty loginVO and fn:indexOf(prefix, 'mngr') eq -1}">
						<a href="javascript:void(0);" id="cnrs_btn"><img src="/images/wzwg/cmm/cnrs_btn.png" alt='<spring:message code="wzwg.cmm.word.cnrs" />'></a>
					</c:if>	
					
					<c:if test="${moduleBbsVO.atchFilePosblAt eq 'Y' and resultVO.atchFileCnt ne '0'}">
						<c:if test="${fileEstbsSe eq 'B'}">
						<div class="atchFileWrap">
							<span class="fileTit"><spring:message code="wzwg.module.word.atchfile" /></span>
							<div class="fileList" id="atchFile_div">
								<c:import url="${wzwg_contextPath}/module/upload/file/selectFileInc.do" charEncoding="utf-8">
									<c:param name="param_atchFileId" 		value="${resultVO.atchFileId}" />
									<c:param name="param_updateFlag" 		value="N" />
									<c:param name="param_atchFileNumber" 	value="${moduleBbsVO.atchFilePosblCo}" />
									<c:param name="param_cntntsSeq" 		value="${resultVO.bbsSeq}" />
									<c:param name="param_sitecntntsSeq" 	value="${paramVO.sitecntntsSeq}" />
									<c:param name="param_usemode" 			value="bbs" />
								</c:import>
							</div>
						</div>
						</c:if>
						
						<c:if test="${fileEstbsSe eq 'C'}">
							<c:import url="${wzwg_contextPath}/module/upload/crossuploader/downloadForm.do" charEncoding="utf-8">
								<c:param name="param_atchFileId" 		value="${resultVO.atchFileId}" />
							</c:import>
						</c:if>
					</c:if>	
				</div>

			</div><!-- list_tit end -->
			<div class="list_content">
				<div class="conMiddle">
					<div class="conM_txt">
						<c:out value='${resultVO.nttCn}' escapeXml="false" />
					</div>
					<%-- 
					<c:if test="${!empty tagList}">
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
					
					
					<c:if test="${resultVO.answerPermAt eq 'Y' or expsrAtIngrAt eq 'Y'}">
					<div id="module_inc_${resultVO.nttSeq}">
						<ul>
						<!-- 댓글, 등록순, 조회수, 좋아요 -->
							<c:if test="${resultVO.answerPermAt eq 'Y'}">
								<c:import url="${wzwg_contextPath}${prefix}/module/ntt/answer/selectNttAnswerIncAjax.do" charEncoding="utf-8">
									<c:param name="param_nttSeq" value="${resultVO.nttSeq}" />
								</c:import>
							</c:if>
							
							<c:if test="${expsrAtIngrAt eq 'Y'}">
							<li><a style="cursor:text;"><span><spring:message code="wzwg.cmm.word.rdcnt" /> <c:out value="${resultVO.inqireCnt}"/></span></a></li>
							</c:if>
						</ul>	
					</div>
					</c:if>
					
				</div><!-- conMiddle end -->
				<div class="conBottom">
				
					<div id="module_div_${resultVO.nttSeq}">
						
						<div class="answer cmtbg" style="display:none;">
							<c:if test="${resultVO.answerPermAt eq 'Y'}">
								<c:import url="${wzwg_contextPath}${prefix}/module/ntt/answer/selectNttAnswerFormAjax.do" charEncoding="utf-8">
									<c:param name="param_nttSeq" value="${resultVO.nttSeq}" />
									<c:param name="param_bbsSeq" value="${paramVO.bbsSeq}" />
								</c:import>
							</c:if>
						</div>
						
					</div>
						
				</div><!-- conBottom end -->				
			</div>
		</div><!-- board001 end -->	

		<!-- 채택 Start -->
		<c:set var="choiceNttSeq" value="" />
		
		<c:if test="${!empty choiceResult}">
		
			<c:set var="choiceNttSeq" value="${choiceResult.nttSeq}" />

			<div class="board001 mb5">
				<div class="list_tit">
					<span class="blind"><spring:message code="wzwg.cmm.word.answer01" /></span>
					<h5><spring:message code="wzwg.module.word.adoptedanswer" /></h5>
					<p class="list_date">
						<strong><spring:message code="wzwg.cmm.word.rgsde02" /></strong>
						<span><c:out value="${choiceResult.frstRegistPnttm}"/></span>
					</p>
				</div><!-- list_tit end -->
				<div class="list_content">
					<div class="conTop">
						 <p class="writer">
							<strong><spring:message code="wzwg.cmm.word.wrter" /></strong>
							<span>
								<c:out value="${choiceResult.ntcrNm}"/>(<c:out value="${fn:substring(choiceResult.ntcrId, 0, 4)}"/>****)
							</span>
						</p>
						<p></p>
					</div>
					<div class="conMiddle">
						<div class="conM_txt">
							<p><span><spring:message code="wzwg.module.word.interrgret" /></span><span> : <c:out value='${fn:replace(choiceResult.qestnUsrCm, cn, "<br />")}' escapeXml="false" /></span></p>
							<c:out value='${choiceResult.nttCn}' escapeXml="false" />
						</div>
					</div>
				</div><!-- list_content end -->
			</div><!-- board001 end -->			
		
		</c:if>
		<!-- 채택 End -->	
	<form id="replyFrm" name="replyFrm" method="post">
		<input type="hidden" id="nttSeq" name="nttSeq" />
		<input type="hidden" id="nttCn" name="nttCn" />
		<input type="hidden" id="nttCnChrctr" name="nttCnChrctr" />
	</form>
	<form:form modelAttribute="paramVO" path="detailFrm" id="detailFrm" name="detailFrm" method="post" onclick="return false;">
		<form:hidden path="siteSeq" />
		<form:hidden path="bbsSeq" />
		<form:hidden path="nttSeq" />
		<form:hidden path="faqAt" />
		<form:hidden path="pageIndex" />
		<form:hidden path="ordrSe" />
		<form:hidden path="searchCondition" />
		<form:hidden path="searchKeyword" />
		<form:hidden path="menuSeq" />
		<form:hidden path="mngrAt" />	
		<form:hidden path="searchAt" />
		<form:hidden path="listCount" /> 
		<form:hidden path="sitecntntsSeq" />
		<form:hidden path="secretAt" />
		<form:hidden path="atchFilePosblAt" value="${moduleBbsVO.atchFilePosblAt}" />
		<form:hidden path="atchFilePosblCo" value="${moduleBbsVO.atchFilePosblCo}" />
				
		<!-- 답글 Start -->
		<div class="mg_t20" style="clear:both; overflow:hidden;">
			<c:import url="${wzwg_contextPath}${prefix}/module/ntt/qna/selectNttReplyFormAjax.do" charEncoding="utf-8">
				<c:param name="param_nttSeq" 		value="${resultVO.nttSeq}" />
				<c:param name="param_nttSj" 		value="${resultVO.nttSj}" />
				<c:param name="param_choiceNttSeq"	value="${choiceNttSeq}" />
				<c:param name="param_bbsSeq"		value="${paramVO.bbsSeq}" />
				<c:param name="param_ntcrId" 		value="${resultVO.ntcrId}" />
				<c:param name="authorSe" 			value="${nttAuthVO.authorSe}" />
			</c:import>
		</div>
		<!-- 답글 End -->	
		
	</form:form>					
	
		<div class="btnbox-c txt-r mt30">
		
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
		
			<c:if test="${modAuthAt eq 'Y'}">
					<a href="javascript:void(0);" id="modify_btn" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.updt" /></a>
			</c:if>
			<c:if test="${movAuthAt eq 'Y'}">
					<a href="javascript:void(0);" id="move_btn" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.mvmn" /></a>						
			</c:if>
			
			<a href="javascript:void(0);" id="list_btn" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>				

		</div><!-- rt-box end -->

		<c:if test="${not empty moduleBbsVO.bbsCnclsn}">
		<div class="mt30">
			<c:out value='${moduleBbsVO.bbsCnclsn}' escapeXml="false" />
		</div>
		</c:if>	
	
		<div class="mt30">
			<table class="basic-table01 brdotherPostTBL ">
				<caption><spring:message code="wzwg.module.word.prevposts" /> <spring:message code="wzwg.module.word.nextposts" /></caption>
				<colgroup>
					<col width="20%"/>
					<col width="*"/>
					<c:if test="${expsrAtWrtrAt eq 'Y'}">
					<col width="15%"/>
					</c:if>
				</colgroup>
				
				<c:if test="${!empty prevNttInfo}">
					<tr>
						<th scope="row" class="PageMoveBtn prevPageBtn bg-white br-btm1 br-top0 br-lft0 br-rgt0 br-lightgrey brsolid"><spring:message code="wzwg.module.word.prevposts" /></th>
						<td class="txt-l">
							<c:if test="${prevNttInfo[5] eq 'Y'}">
								<span class="lock"><i class="fa fa-lock" aria-hidden="true"></i><span><spring:message code="wzwg.module.word.secretposts" /></span></span>
							</c:if>
							<a href="javascript:void(0);" onclick="fnViewPage('<c:out value="${prevNttInfo[0]}"/>', '<c:out value="${prevNttInfo[3]}"/>', '<c:out value="${prevNttInfo[5]}"/>', '<c:out value="${resultVO.parntsNttSeq}"/>', '<c:out value="${resultVO.parntsNtcrId}"/>');"><c:out value="${prevNttInfo[1]}"/></a>
						</td>
						<c:if test="${expsrAtWrtrAt eq 'Y'}">
						<td>
							<c:if test="${prevNttInfo[6] eq 'Y'}"><spring:message code="wzwg.cmm.word.annymty" /></c:if>
							<c:if test="${prevNttInfo[6] ne 'Y'}"><c:out value="${prevNttInfo[2]}"/></c:if>
						</td>
						</c:if>
					</tr>
					</c:if>
					<c:if test="${!empty nextNttInfo}">
					<tr>
						<th scope="row" class="PageMoveBtn nextPageBtn bg-white br-btm1 br-top0 br-lft0 br-rgt0 br-lightgrey brsolid"><spring:message code="wzwg.module.word.nextposts" /></th>
						<td class="txt-l">
							<c:if test="${nextNttInfo[5] eq 'Y'}">
								<span class="lock"><i class="fa fa-lock" aria-hidden="true"></i><span><spring:message code="wzwg.module.word.secretposts" /></span></span>
							</c:if>
							<a href="javascript:void(0);" onclick="fnViewPage('<c:out value="${nextNttInfo[0]}"/>', '<c:out value="${nextNttInfo[3]}"/>', '<c:out value="${nextNttInfo[5]}"/>', '<c:out value="${resultVO.parntsNttSeq}"/>', '<c:out value="${resultVO.parntsNtcrId}"/>');"><c:out value="${nextNttInfo[1]}"/></a>
						</td>
						<c:if test="${expsrAtWrtrAt eq 'Y'}">
						<td>
							<c:if test="${nextNttInfo[6] eq 'Y'}"><spring:message code="wzwg.cmm.word.annymty" /></c:if>
							<c:if test="${nextNttInfo[6] ne 'Y'}"><c:out value="${nextNttInfo[2]}"/></c:if>
						</td>
						</c:if>
					</tr>
					</c:if>
			</table>
		</div>
