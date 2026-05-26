<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.cmm.word.detail" />';}catch(e){console.log(e.message);}

	$(document).ready(function(){
		$('#contentsCaption').html($('#menuNm').val() + ' <spring:message code="wzwg.module.word.postdetailView" />');
		// 답글 
		$('#reply_btn').click(function(){
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/selectNttReplyFormAjax.do'
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
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/modifyNttFormAjax.do'
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
					, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/deleteNttInfoAjax.do'
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
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/selectNttListAjax.do'
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
	
	function fnFieldDecrypt(btn){
		var data = $(btn).attr('data-tel');
		
		var frm = new FormData();
		frm.append('name','data');
		frm.append('data', data);
		
		$.ajax({
	        type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/selectDecryptFieldAjax.do'
			, cache : false
			, async : false
			, processData: false
			, contentType: false
			, data : frm
			, success : function (data) {
	    	  	if(data.result == 'success'){
	    	  		$(btn).after('<div>' + data.dataList[0] + '</div>');
	    	  		$(btn).remove();
	    	  	}else{
	    	  		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.decd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
	    	  		
	    	  	}
			}
			, error : function (request, status, error) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
		});
	}
	
	function fnFileDown(paramFileId,paramSn){
		window.open("<c:url value='/module/upload/file/fileDown.do?atchFileId="+paramFileId+"&fileSn="+paramSn+"'/>");
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
			<form:hidden path="parntsNttSeq" />	
			<form:hidden path="searchAt" />
			<form:hidden path="listCount" />
			<form:hidden path="password" />
			<form:hidden path="sitecntntsSeq"/>
			
			<div class="board001">
					<div class="list_tit">
						<h5>
						
						<c:if test="${repAuthAt eq 'Y'}">
							<c:forEach items="${fieldList }" var="list">
								<c:if test="${list.useAt eq 'Y' and list.fieldTy eq 'title'}">
									<c:if test="${!empty resultVO.subospecSj}">
										[<c:out value="${resultVO.subospecSj}"/>]
									</c:if>					
									<c:out value="${resultVO.nttSj}"/>
								</c:if>
							</c:forEach>
							
							<%-- 리플보기일 경우는 기존대로 보여준다 --%>
							<c:if test="${not empty resultVO.parntsNttSeq }">
									<c:if test="${!empty resultVO.subospecSj}">
										[<c:out value="${resultVO.subospecSj}"/>]
									</c:if>					
									<c:out value="${resultVO.nttSj}"/>
							</c:if>
						</c:if>
						
						<!-- 			
						<span class="tit_bar">
							<a href="javascript:void(0);" onclick="fnBbsList();"><c:out value='${resultVO.bbsNm}'/></a>
						</span>	
						 -->	
						</h5>
						<p class="list_date">
							<c:if test="${expsrAtRgsdAt eq 'Y'}">
							<strong><spring:message code="wzwg.cmm.word.rgsde02" /></strong>
							<span><c:out value="${resultVO.frstRegistPnttm}"/></span>
							</c:if>
							
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
							<c:if test="${expsrAtWrtrAt eq 'Y'}">
							 <p class="writer">
								<strong><spring:message code="wzwg.cmm.word.wrter" /></strong>
								<span>
									<c:if test="${resultVO.annymtyAt eq 'Y'}"><spring:message code="wzwg.cmm.word.annymty" /></c:if>
									<c:if test="${resultVO.annymtyAt ne 'Y'}"><c:out value="${resultVO.ntcrNm}"/>(<c:out value="${fn:substring(resultVO.ntcrId, 0, 4)}"/>****)</c:if>
								</span> 
							</p>
							</c:if>
							
							<c:if test="${!empty loginVO and fn:indexOf(prefix, 'mngr') eq -1}">
								<a href="javascript:void(0);" id="cnrs_btn"><img src="/images/wzwg/cmm/cnrs_btn.png" alt='<spring:message code="wzwg.cmm.word.cnrs" />'></a>
							</c:if>	
							
<%-- 							<c:if test="${resultVO.atchFileCnt ne '0'}">
								<ul>
									<li>
										<a href="javascript:void(0);" onclick="$('#atchFile_div').toggle();">
										<spring:message code="wzwg.module.word.atchfile" /><span>(<c:out value="${resultVO.atchFileCnt}"/>)</span>
										</a>
									</li>
								</ul>
								<div id="atchFile_div" style="display:none;">
									<c:import url="/module/upload/file/selectFileInc.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" 		value="${resultVO.atchFileId}" />
										<c:param name="param_updateFlag" 		value="N" />
										<c:param name="param_atchFileNumber" 	value="3" />
										<c:param name="param_cntntsSeq" 		value="${resultVO.bbsSeq}" />
									</c:import>
								</div>
							</c:if>	 --%>
						</div>
						<div class="conMiddle">
							<%-- <div class="conM_txt">
								<c:out value='${resultVO.nttCn}' escapeXml="false" />
							</div> --%>
							<c:if test="${empty resultVO.parntsNttSeq }">
								<table class="basic-table01" style="line-height: 25px;">
								<caption id="contentsCaption"><spring:message code="wzwg.module.word.postdetailView" /></caption>
									<colgroup>
										<col width="10%">
										<col width="*">
									</colgroup>
									<tbody>
										<c:forEach items="${fieldList }" var="list">
										<c:if test="${list.useAt eq 'Y' }">
										<c:if test="${list.fieldTy ne 'password'}"><%-- 비밀번호는 생략한다 --%>
										<%-- <c:set var="datakey">${list.fieldId }</c:set> --%>
										<tr>
											<th scope="row" class="subTit"><c:out value="${list.fieldNm }"/></th>
											<td style="min-height: 20px; height: auto; text-align: left;">
											<c:choose>
												<c:when test="${list.fieldTy eq 'image' }">
													<c:if test="${!empty customData[list.fieldId] }">
													<img src="/module/upload/file/selectOrignlImageView.do?atchFileId=<c:out value='${resultVO.atchFileId}'/>&fileSn=${customData[list.fieldId]}" alt="<c:out value='${list.fieldNm }'/>">
													</c:if>
												</c:when>
												<c:when test="${list.fieldTy eq 'file' }">
													<c:if test="${!empty atchFileList }"> 
													<c:forEach items="${atchFileList }" var="atchFileList"> 
														<c:if test="${customData[list.fieldId] eq atchFileList.fileSn }">
															<a href="javascript:void(0);" onclick="fnFileDown('<c:out value="${atchFileList.atchFileId}"/>','<c:out value="${atchFileList.fileSn}"/>');" title="<c:out value='${atchFileList.orignlFileNm }'/> <spring:message code="wzwg.cmm.word.dwld" />">
																<c:out value="${atchFileList.orignlFileNm }"/>
															</a>
														</c:if>
													</c:forEach>
													</c:if>
												</c:when>
												<c:when test="${list.fieldTy eq 'tel'}">
													<%-- <c:if test="${delAuthAt eq 'Y' }"><a href="javascript:void(0);" ></a></c:if>
													<c:if test="${delAuthAt ne 'Y' }"><a href="javascript:void(0);" ></a></c:if> --%>
													<button type="button" class="wzbtn-table btn-basic" onclick="fnFieldDecrypt(this)" data-tel="${customData[list.fieldId]}"><spring:message code="wzwg.module.word.telnocnfirm" /></button>
												</c:when>
												<c:when test="${list.fieldTy eq 'contents'}">
													<c:out value="${customData[list.fieldId]}" escapeXml="false"/>
												</c:when>
												
												<c:otherwise><c:out value='${fn:replace(customData[list.fieldId], cn, "<br />")}'/></c:otherwise>
											</c:choose>
												
											</td>
										</tr>
										</c:if>
										</c:if>
										</c:forEach>
									</tbody>
								</table>
							</c:if> 
							
							<c:if test="${not empty resultVO.parntsNttSeq }"><%-- 부모 시퀀스가 있으면 리플 : 리플은 기존내용없이 바로 출력 --%>
								<div class="conM_txt">
									<c:out value='${resultVO.nttCn}' escapeXml="false" />
									
								</div>
							</c:if>
							
							<c:if test="${resultVO.answerPermAt eq 'Y' or expsrAtIngrAt eq 'Y'}">
							<div id="module_inc_<c:out value='${resultVO.nttSeq}'/>">
								<ul>
									<c:if test="${resultVO.answerPermAt eq 'Y'}">
										<c:import url="${wzwg_contextPath}${prefix}/module/ntt/answer/selectNttAnswerIncAjax.do" charEncoding="utf-8">
											<c:param name="param_nttSeq" value="${resultVO.nttSeq}" />
										</c:import>
									</c:if>
									
									<c:if test="${expsrAtIngrAt eq 'Y'}">
									<li><a style="cursor:text;"><spring:message code="wzwg.cmm.word.rdcnt" /> <c:out value="${resultVO.inqireCnt}"/></a></li>
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
			
			<div class="rt-box">
				<%-- <c:if test="${repAuthAt eq 'Y'}">
					<c:forEach items="${fieldList }" var="list">
						<c:if test="${list.useAt eq 'Y' and list.fieldTy eq 'title'}">
							<a href="javascript:void(0);" id="reply_btn" class="btn-a fl"><spring:message code="wzwg.cmm.word.answer03" /></a>
						</c:if>
					</c:forEach>
				</c:if> --%>
				<c:if test="${delAuthAt eq 'Y'}">
					<a href="javascript:void(0);" id="delete_btn" class="wzbtn btn-del fl"><spring:message code="wzwg.cmm.word.delete" /></a>
				</c:if>
				
				<c:if test="${!empty loginVO}">
					<%-- <a href="javascript:void(0);" id="print_btn" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.prntng" /></a> --%>
				
					<%-- <c:if test="${resultVO.scrapAt eq 'Y'}">
						<a href="javascript:void(0);" id="scrap_btn" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.scrap" /></a>
					</c:if> --%>
				</c:if>
				
				<c:if test="${modAuthAt eq 'Y' or resultVO.ntcrId eq '비회원'}">
					<a href="javascript:void(0);" id="modify_btn" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.updt" /></a>
				</c:if>
				
				<%-- <c:if test="${movAuthAt eq 'Y'}">
					<c:if test="${paramVO.cmntUseAt ne 'Y'}">
					<a href="javascript:void(0);" id="move_btn" class="btn-a"><spring:message code="wzwg.cmm.word.mvmn" /></a>	
					</c:if>					
				</c:if> --%>
				
				
				<a href="javascript:void(0);" id="list_btn" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
			</div>			
			
		</form:form>
				
		<c:if test="${not empty moduleBbsVO.bbsCnclsn}">
		<div class="mt30">
			<c:out value='${moduleBbsVO.bbsCnclsn}' escapeXml="false" />
		</div>
		</c:if>				
				
