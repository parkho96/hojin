<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript" src="/js/wzwg/cmm/imagesloaded.pkgd.min.js"></script>
<!-- <script type="text/javascript" src="/js/wzwg/cmm/jquery.bxslider.min.js"></script> -->
<script type="text/javascript" src="/js/wzwg/cmm/album.js"></script>
<link rel="stylesheet" href="/js/wzwg/cmm/slick/slick.css" type="text/css" />
<script src="/js/wzwg/cmm/slick/slick.js"></script> 
<c:if test="${fn:indexOf(prefix, 'mngr') > -1}">
<script src="/js/wzwg/site/siteWizbuilder.js"></script>
</c:if>

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
		//playSlideSlick($('.wzwg-slide-info'));
		wzwgSwiperAll();
		
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
					alert('<spring:message code="fail.common.msg" text="error" />');
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
	
	function fnViewPage(nttSeq, ntcrSeq, secretAt, parntsNtcrSeq){
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
		
		<c:set var="ran"><%= java.lang.Math.round(java.lang.Math.random() * 1234567) %></c:set>
		
		<c:if test="${not empty moduleBbsVO.bbsPrface}">
		<div class="mb30">
			<!--<c:out value='${moduleBbsVO.bbsPrface}' escapeXml="false" />-->
		</div> 
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
			<form:hidden path="atchImgFilePosblCo" value="${fn:escapeXml(moduleBbsVO.atchImgFilePosblCo)}" />
			
			<c:if test="${!empty resultVO.nextNttInfo}">
				<c:set var="nextNttInfo" value="${fn:split(resultVO.nextNttInfo, ',') }" />				
			</c:if>
			
			<c:if test="${!empty resultVO.prevNttInfo}">
				<c:set var="prevNttInfo" value="${fn:split(resultVO.prevNttInfo, ',') }" />	
			</c:if>
			
			<!-- <div class="mb10">
				<c:if test="${!empty prevNttInfo}">
					<a href="javascript:void(0);" class="wzbtn-table btn-grey" onclick="fnViewPage('<c:out value="${prevNttInfo[0]}"/>', '<c:out value="${resultVO.ntcrId}"/>', '<c:out value="${resultVO.secretAt}"/>');">▲ <spring:message code="wzwg.module.word.prevposts" /></a>
				</c:if>
				<c:if test="${!empty nextNttInfo}">
					<a href="javascript:void(0);" class="wzbtn-table btn-grey" onclick="fnViewPage('<c:out value="${nextNttInfo[0]}"/>', '<c:out value="${resultVO.ntcrId}"/>', '<c:out value="${resultVO.secretAt}"/>');">▼ <spring:message code="wzwg.module.word.nextposts" /></a>
				</c:if>
			</div> -->
			
			<div class="board001">
					<div class="list_tit">
						<h5 class="brdDetailTit">
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
								<dt class="dateTit"><spring:message code="wzwg.cmm.word.rgsde02" /></dt>
								<dd><c:out value="${resultVO.frstRegistPnttm}"/></dd>
								</c:if>
							</dl>
							
							<c:if test="${!empty loginVO and fn:indexOf(prefix, 'mngr') eq -1}">
								<a href="javascript:void(0);" id="cnrs_btn"><img src="/images/wzwg/cmm/cnrs_btn.png" alt='<spring:message code="wzwg.cmm.word.cnrs" />'></a>
							</c:if>
							
							<c:if test="${fileEstbsSe eq 'B'}">
								<c:if test="${moduleBbsVO.atchFilePosblAt eq 'Y' and resultVO.atchFileCnt ne '0'}">
									<div class="atchFileWrap">
										<span class="fileTit"><spring:message code="wzwg.module.word.atchfile" /></span>
										<div class="fileList">
											<c:import url="${wzwg_contextPath}/module/upload/file/selectFileInc.do" charEncoding="utf-8">
												<c:param name="param_atchFileId" 		value="${resultVO.atchFileId}" />
												<c:param name="param_updateFlag" 		value="N" />
												<c:param name="param_atchFileNumber" 	value="${moduleBbsVO.atchFilePosblCo}" />
												<c:param name="param_cntntsSeq" 		value="${resultVO.bbsSeq}" />
											</c:import>
										</div>
									</div>
								</c:if>
							</c:if>
						</div>
						
					
					</div><!-- list_tit end -->
					<div class="list_content">
						<div class="conTop">
							
							<c:if test="${not empty imageList }">
							<div class="imgbrd_slide">
									<div class="wzwg-slide-info" data-slidesPerView="8" data-slidesPerView-mobile="2" data-loop="false" data-autoplay="none" >
										<div class="wzwg-slide-data">
											<c:forEach items="${imageList }" var="imgList">
											<span class="imgbox">
												<img class="wzpop-item" src="<c:url value='/module/upload/file/selectOrignlImageView.do'/>?atchFileId=<c:out value='${imgList.atchFileId}'/>&fileSn=<c:out value='${imgList.fileSn}'/>&ran=<c:out value='${ran}'/>" alt="<c:out value='${imgList.fileDc }'/>" data-down="/module/upload/file/fileDown.do?atchFileId=<c:out value='${imgList.atchFileId}'/>&fileSn=<c:out value='${imgList.fileSn}'/>&ran=<c:out value='${ran}'/>" data-filename="<c:out value='${imgList.orignlFileNm }'/>">
											</span>
											</c:forEach>
										</div>
									</div>
								</div>
							</c:if>
							
							<c:if test="${fileEstbsSe eq 'C'}">
								<c:if test="${moduleBbsVO.atchFilePosblAt eq 'Y' and resultVO.atchFileCnt ne '0'}">
									<c:import url="${wzwg_contextPath}/module/upload/crossuploader/downloadForm.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" 		value="${resultVO.atchFileId}" />
									</c:import>
								</c:if>
							</c:if>
						</div>
						
						<div class="conMiddle">
							<div class="conM_txt">
								<c:out value='${resultVO.nttCn}' escapeXml="false" />
							</div>
							
							<c:if test="${resultVO.answerPermAt eq 'Y' or expsrAtIngrAt eq 'Y'}">
							<div id="module_inc_<c:out value='${resultVO.nttSeq}'/>">
								<ul>
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

			<div class="mt30">
				<table class="basic-table01 brdotherPostTBL">
					<caption><spring:message code="wzwg.module.word.prevposts" /> <spring:message code="wzwg.module.word.nextposts" /></caption>
					<colgroup>
						<col width="20%"/>
						<col width="*"/>
						<c:if test="${expsrAtWrtrAt eq 'Y'}"><col width="15%"/></c:if>
					</colgroup>
						
					<c:if test="${!empty prevNttInfo}">
					<tr>
						<th scope="row" class="PageMoveBtn prevPageBtn bg-white br-btm1 br-top0 br-lft0 br-rgt0 br-lightgrey brsolid"><spring:message code="wzwg.module.word.prevposts" /></th>
						<td class="txt-l"><a href="javascript:void(0);" onclick="fnViewPage('<c:out value="${prevNttInfo[0]}"/>', '<c:out value="${resultVO.ntcrSeq}"/>', '<c:out value="${prevNttInfo[5]}"/>', '<c:out value="${prevNttInfo[7]}"/>');"><c:out value="${prevNttInfo[1]}"/></a></td>
						<c:if test="${expsrAtWrtrAt eq 'Y'}"><td>
						<c:if test="${prevNttInfo[6] eq 'Y'}"><spring:message code="wzwg.cmm.word.annymty" /></c:if>
							<c:if test="${prevNttInfo[6] ne 'Y'}"><c:out value="${prevNttInfo[2]}"/></c:if>
						</td></c:if>
						<!--<td>${prevNttInfo[3]}</td>-->
					</tr>
					</c:if>
					
					<c:if test="${!empty nextNttInfo}">
					<tr>
						<th scope="row" class="PageMoveBtn nextPageBtn bg-white br-btm1 br-top0 br-lft0 br-rgt0 br-lightgrey brsolid"><spring:message code="wzwg.module.word.nextposts" /></th>
						<td class="txt-l"><a href="javascript:void(0);" onclick="fnViewPage('<c:out value="${nextNttInfo[0]}"/>', '<c:out value="${resultVO.ntcrSeq}"/>', '<c:out value="${nextNttInfo[5]}"/>', '<c:out value="${nextNttInfo[7]}"/>');"><c:out value="${nextNttInfo[1]}"/></a></td>
						<c:if test="${expsrAtWrtrAt eq 'Y'}"><td>
						<c:if test="${nextNttInfo[6] eq 'Y'}"><spring:message code="wzwg.cmm.word.annymty" /></c:if>
							<c:if test="${nextNttInfo[6] ne 'Y'}"><c:out value="${nextNttInfo[2]}"/></c:if>
						</td></c:if>
						<!--<td>${nextNttInfo[3]}</td>-->
					</tr>
					</c:if>
				</table>
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
	
		</form:form>
				
		<c:if test="${not empty moduleBbsVO.bbsCnclsn}">
		<div class="mt30">
			<c:out value='${moduleBbsVO.bbsCnclsn}' escapeXml="false" />
		</div>
		</c:if>				
