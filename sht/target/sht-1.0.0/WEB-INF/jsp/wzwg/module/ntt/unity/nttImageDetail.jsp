<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<style>
	#zoom_img{width:580px;height:auto;}
	#zoom_img>div>img{width:100%;height:100%;}
	
	.album_read_viewport { position:relative; width:500px; height:105px; margin:0 auto; padding:0; line-height:1; }
	.album_read_viewport .bx-wrapper,
	.album_read_viewport .bx-viewport { padding:0; }
	.album_read_viewport .bx-prev { position:absolute; top:20px; left:-42px; width:18px; height:35px; text-indent:-9000px; background:url(/images/wzwg/cmm/btn_album_read_prev.gif) no-repeat 0 0;}
	.album_read_viewport .bx-next { position:absolute; top:20px; right:-42px; width:18px; height:35px; text-indent:-9000px; background:url(/images/wzwg/cmm/btn_album_read_next.gif) no-repeat 0 0;}
	.album_read_viewport .bx-prev:hover { background-image:url(/images/wzwg/cmm/btn_album_read_prev_over.gif); }
	.album_read_viewport .bx-next:hover { background-image:url(/images/wzwg/cmm/btn_album_read_next_over.gif); }
	.album_thumbnail_box  li { height:105px; text-align:center; } 
	.album_thumbnail_box .thumbnail { display:block; overflow:hidden; width:108px; height:68px; border:1px solid #E0E0E0; text-align:center; vertical-align:middle; cursor:pointer; margin-bottom:0px; } 
	
	.album_thumbnail_box  li > a { display:inline-block; margin-top:5px; } 
	 
	.album_image_viewport { width:600px; padding:5px; margin:10px auto 20px; border:1px solid #E0E0E0; box-sizing:border-box; }
	.album_image_viewport img { width:100%; height:auto; }
	th.nav { background:#F6F6F6; }
</style>

<script type="text/javascript" src="/js/wzwg/cmm/imagesloaded.pkgd.min.js"></script>
<script type="text/javascript" src="/js/wzwg/cmm/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="/js/wzwg/cmm/album.js"></script>

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
		
		//fnImageView('');
		wzImgPopupInit();
		
		// 답글 
		$('#reply_btn').click(function(){
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/unity/selectNttReplyFormAjax.do'
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
		
		// 수정
		$('#modify_btn').click(function(){
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/unity/modifyNttFormAjax.do'
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
					, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/unity/deleteNttInfoAjax.do'
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
		    	  $("#bbs_layer").show();
		    	  $("#bbs_layer").html(data);
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
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/unity/selectNttListAjax.do'
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
	
	function fnViewPage(nttSeq, ntcrId, secretAt){
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
			frm.parntsNttSeq.value = parntsNttSeq;
			frm.secretAt.value = secretAt;
			
			$.ajax({
				  type : 'POST'
				, dataType: 'html'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/unity/selectNttDetailAjax.do'
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
	
	// 제목에서 게시판 클릭시 목록으로 이동
	function fnBbsList(){
		$('#list_btn').click();	
	}
	
	// 태그 사용 게시물 목록
	function fnNttTagList(tagSeq){
		alert('Preparing !!');
	}

	function fnImageView(viewId){

		$('#zoom_img').show();
		
		if(viewId == ''){
			viewId = 0;
		}
		
		$('#image_'+viewId).show();
		
		for(var i = 0; i < '${fn:length(imageList)}'; i++){
			if(i != viewId){
				$('#image_'+i).hide();
			}
		}
		
		$("#content").css("height",$(document).height());
		$(window).scrollTop(0);
		
	}	

	function fnFileDown(atchFileId, fileSn){
		window.open("<c:url value='/module/upload/file/fileDown.do?atchFileId="+atchFileId+"&fileSn="+fileSn+"'/>");
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
			<form:hidden path="cmntUseAt" />	
			<form:hidden path="searchAt" />
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
					<a href="javascript:void(0);" class="wzbtn-table btn-grey" onclick="fnViewPage('<c:out value="${prevNttInfo[0]}"/>', '<c:out value="${resultVO.ntcrId}"/>', '<c:out value="${resultVO.secretAt}"/>');">▲ <spring:message code="wzwg.module.word.prevposts" /></a>
				</c:if>
				<c:if test="${!empty nextNttInfo}">
					<a href="javascript:void(0);" class="wzbtn-table btn-grey" onclick="fnViewPage('<c:out value="${nextNttInfo[0]}"/>', '<c:out value="${resultVO.ntcrId}"/>', '<c:out value="${resultVO.secretAt}"/>');">▼ <spring:message code="wzwg.module.word.nextposts" /></a>
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
						</div>
						
						<c:if test="${resultVO.atchFileCnt ne '0'}">
	
						<div class="album_read_viewport album_thumbnail_box">
							<ul>
								<c:forEach var="resultList" items="${imageList}" varStatus="status">
								<li>
									<span class="thumbnail">
										<img class="wzpop-item" tabindex="0" data-down="/module/upload/file/fileDown.do?atchFileId=<c:out value='${resultList.atchFileId}'/>&fileSn=<c:out value='${resultList.fileSn}'/>" src="/module/upload/file/selectOrignlImageView.do?atchFileId=<c:out value='${resultList.atchFileId}'/>&fileSn=<c:out value='${resultList.fileSn}'/>" alt="<c:out value='${resultVO.nttSj}'/> <spring:message code="wzwg.cmm.word.image" />" />
									</span>
									<a href="javascript:void(0);" onclick="fnFileDown('<c:out value="${resultList.atchFileId}"/>', '<c:out value="${resultList.fileSn}"/>');" title="<c:out value='${result.nttSj}'/>"><span class="btn btn_default btn_m"><spring:message code="wzwg.cmm.word.dwld" /></span></a>
								</li>
								</c:forEach>
							</ul>
						</div>
						
						</c:if>							
						
						<div class="conMiddle">
							<div class="conM_txt">
								<c:out value='${resultVO.nttCn}' escapeXml="false" />
							</div>
						
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
						<col width="10%"/>
					</colgroup>
						
					<c:if test="${!empty prevNttInfo}">
					<tr>
						<th scope="row" class="bg-white br-btm1 br-top0 br-lft0 br-rgt0 br-lightgrey brsolid">▲ <spring:message code="wzwg.module.word.prevposts" /></th>
						<td><a href="javascript:void(0);" onclick="fnViewPage('<c:out value="${prevNttInfo[0]}"/>', '<c:out value="${resultVO.ntcrId}"/>', '<c:out value="${resultVO.secretAt}"/>');"><c:out value="${prevNttInfo[1]}"/></a></td>
						<td><c:out value="${prevNttInfo[2]}"/></td>
						<td><c:out value="${prevNttInfo[3]}"/></td>
					</tr>
					</c:if>
					
					<c:if test="${!empty nextNttInfo}">
					<tr>
						<th scope="row" class="bg-white br-btm1 br-top0 br-lft0 br-rgt0 br-lightgrey brsolid">▼ <spring:message code="wzwg.module.word.nextposts" /></th>
						<td><a href="javascript:void(0);" onclick="fnViewPage('<c:out value="${nextNttInfo[0]}"/>', '<c:out value="${resultVO.ntcrId}"/>', '<c:out value="${resultVO.secretAt}"/>');"><c:out value="${nextNttInfo[1]}"/></a></td>
						<td><c:out value="${nextNttInfo[2]}"/></td>
						<td><c:out value="${nextNttInfo[3]}"/></td>
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
