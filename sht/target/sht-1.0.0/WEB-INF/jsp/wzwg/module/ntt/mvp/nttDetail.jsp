<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<% 
	String getUrl = request.getServerName().toString();
	String getPort = String.valueOf(request.getServerPort());
	if(getPort.equals("80")){getPort="";} else {getPort= ":"+getPort;}
%>

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
	.album_thumbnail_box .thumbnail { display:block; overflow:hidden; width:108px; height:68px; border:1px solid #E0E0E0; text-align:center; vertical-align:middle; cursor:pointer; } 
	
	.album_thumbnail_box  li > a { display:inline-block; margin-top:5px; } 
	 
	.album_image_viewport { width:600px; padding:5px; margin:10px auto 20px; border:1px solid #E0E0E0; box-sizing:border-box; }
	.album_image_viewport img { width:100%; height:auto; }
	th.nav { background:#F6F6F6; }
</style>

<script type="text/javascript" src="/js/wzwg/cmm/imagesloaded.pkgd.min.js"></script>
<script type="text/javascript" src="/js/wzwg/cmm/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="/js/wzwg/cmm/album.js"></script>

<script type="text/javascript">
try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.cmm.word.detail" />';}catch(e){console.log(e.message);}

	$(document).ready(function(){
		
		// 수정
		$('#modify_btn').click(function(){
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/mvp/modifyNttMvpFormAjax.do'
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
					, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/mvp/deleteNttMvpInfoAjax.do'
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
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/mvp/selectNttMvpListAjax.do'
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
		      , data:'param_menuSeq=<c:out value="${paramVO.menuSeq}"/>&param_mvpnttSeq=<c:out value="${resultVO.mvpnttSeq}"/>&param_nttSj=<c:out value="${repNttSj}"/>&param_mobileAt=<c:out value="${mobileAt}"/>'
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
	
	function fnViewPage(mvpnttSeq){

		var frm = document.detailFrm;
		
		frm.mvpnttSeq.value = mvpnttSeq;
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/mvp/selectNttMvpDetailAjax.do'
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
	}
	
	// 제목에서 게시판 클릭시 목록으로 이동
	function fnBbsList(){
		$('#list_btn').click();	
	}
	
	function fnImageView(viewId){

		$('#zoom_img').show();
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
		
		<c:set var="expsrAtNoAt" value="N"/>
		<c:set var="expsrAtWrtrAt" value="N"/>
		<c:set var="expsrAtRgsdAt" value="N"/>
		<c:set var="expsrAtIngrAt" value="N"/>
		
		<c:forEach items="${fn:split(moduleBbsVO.expsrAt, ',')}" var="expsrArr">
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
			<form:hidden path="mvpnttSeq" />
			<form:hidden path="pageIndex" />
			<form:hidden path="searchCondition" />
			<form:hidden path="searchKeyword" />
			<form:hidden path="menuSeq" />
			<form:hidden path="mngrAt" />	
			<form:hidden path="searchAt" />
			<form:hidden path="listCount" />
			
			<form:hidden path="atchFilePosblAt" value="${fn:escapeXml(resultVO.atchFilePosblAt)}" />
			<form:hidden path="atchFilePosblCo" value="${fn:escapeXml(resultVO.atchFilePosblCo)}" />
			
			<c:if test="${!empty resultVO.nextNttInfo}">
				<c:set var="nextNttInfo" value="${fn:split(resultVO.nextNttInfo, ',') }" />				
			</c:if>
			
			<c:if test="${!empty resultVO.prevNttInfo}">
				<c:set var="prevNttInfo" value="${fn:split(resultVO.prevNttInfo, ',') }" />	
			</c:if>
			
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
								<dd><c:out value="${resultVO.ntcrNm}"/></dd>
								</c:if>
								<c:if test="${expsrAtRgsdAt eq 'Y'}">
								<dt class="dateTit"><spring:message code="wzwg.cmm.word.rgsde02" /></dt>
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
						<div class="conMiddle">	
							<div class="conM_ytb">
								<iframe width="100%" height="350" src="https://www.youtube.com/embed/<c:out value="${resultVO.mvpKey}"/>" frameborder="0" allowfullscreen></iframe>
							</div>

							<c:if test="${not empty mvpCapLen and mvpCapLen > 0}">
							<div class="conM_ytxt">
								<span class="videosub"><spring:message code="wzwg.module.word.vidocap" /></span>
								<div id="targetBox" class="subBox" tabindex = "0">
									<input type="hidden" id="rawContent" value="${resultVO.mvpCap}">
								</div>
								<script>
									$(document).ready(function() {
										var rawData = $('#rawContent').val();
										// 텍스트로 읽어서 HTML로 넣어주면 엔티티가 자동해석
										$('#targetBox').html($('<div/>').html(rawData).text());
										console.log('jQuery decoded success');
									});
								</script>
							</div>
							</c:if>
							<div class="conM_txt">
								<c:out value='${resultVO.nttCn}' escapeXml="false" />
							</div>
							
							<c:if test="${expsrAtIngrAt eq 'Y'}">
							<div id="module_inc_<c:out value='${resultVO.mvpnttSeq}'/>">
								<ul>
									<li><a style="cursor:text;"><span><spring:message code="wzwg.cmm.word.rdcnt" /> <c:out value="${resultVO.inqireCnt}"/></span></a></li>
								</ul>	
							</div>
							</c:if>
														
						</div>
						<div class="conBottom">
							
							<c:if test="${moduleBbsVO.atchFilePosblAt eq 'Y' and resultVO.atchFileCnt ne '0'}">
								<c:if test="${fileEstbsSe eq 'C'}">
									<c:import url="${wzwg_contextPath}/module/upload/crossuploader/downloadForm.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" 		value="${resultVO.atchFileId}" />
									</c:import>
								</c:if>
							</c:if>

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
						<c:if test="${expsrAtRgsdAt eq 'Y'}"><col width="10%"/></c:if>
					</colgroup>
						
					<c:if test="${!empty prevNttInfo}">
					<tr>
						<th scope="row" class="PageMoveBtn prevPageBtn bg-white br-btm1 br-top0 br-lft0 br-rgt0 br-lightgrey brsolid"><spring:message code="wzwg.module.word.prevposts" /></th>
						<td class="txt-l"><a href="javascript:void(0);" onclick="fnViewPage('<c:out value="${prevNttInfo[0]}"/>');"><c:out value="${prevNttInfo[1]}"/></a></td>
						<c:if test="${expsrAtWrtrAt eq 'Y'}"><td><c:out value="${prevNttInfo[2]}"/></td></c:if>
						<c:if test="${expsrAtRgsdAt eq 'Y'}"><td><c:out value="${prevNttInfo[3]}"/></td></c:if>
					</tr>
					</c:if>
					
					<c:if test="${!empty nextNttInfo}">
					<tr>
						<th scope="row" class="PageMoveBtn nextPageBtn bg-white br-btm1 br-top0 br-lft0 br-rgt0 br-lightgrey brsolid"><spring:message code="wzwg.module.word.nextposts" /></th>
						<td class="txt-l"><a href="javascript:void(0);" onclick="fnViewPage('<c:out value="${nextNttInfo[0]}"/>')"><c:out value="${nextNttInfo[1]}"/></a></td>
						<c:if test="${expsrAtWrtrAt eq 'Y'}"><td><c:out value="${nextNttInfo[2]}"/></td></c:if>
						<c:if test="${expsrAtRgsdAt eq 'Y'}"><td><c:out value="${nextNttInfo[3]}"/></td></c:if>
					</tr>
					</c:if>
					
				</table>
			</div>
			
			<div class="rt-box">
				<c:if test="${delAuthAt eq 'Y'}">
					<a href="javascript:void(0);" id="delete_btn" class="wzbtn btn-del fl"><spring:message code="wzwg.cmm.word.delete" /></a>
				</c:if>
				
				<%-- <c:if test="${!empty loginVO}">
					<a href="javascript:void(0);" id="print_btn"><img src="/images/wzwg/cmm/ico-print.png" title='<spring:message code="wzwg.cmm.word.prntng" />' alt='<spring:message code="wzwg.cmm.word.prntng" />'></a>
					<a href="javascript:void(0);" id="print_btn" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.prntng" /></a>
				</c:if> --%>
				
				<%-- <c:if test="${resultVO.scrapAt eq 'Y'}">
					<a href="javascript:void(0);" id="scrap_btn" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.scrap" /></a>
				</c:if> --%>
				
				<c:if test="${modAuthAt eq 'Y'}">
					<a href="javascript:void(0);" id="modify_btn" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.updt" /></a>
				</c:if>
				
				<%-- <c:if test="${movAuthAt eq 'Y'}">
					<a href="javascript:void(0);" id="move_btn" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.mvmn" /></a>						
				</c:if> --%>
				
				
				
				<a href="javascript:void(0);" id="list_btn" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
			</div>	
			
		</form:form>
		
		<c:if test="${not empty moduleBbsVO.bbsCnclsn}">
		<div class="mt30">
			<c:out value='${moduleBbsVO.bbsCnclsn}' escapeXml="false" />
		</div>
		</c:if>
		
	