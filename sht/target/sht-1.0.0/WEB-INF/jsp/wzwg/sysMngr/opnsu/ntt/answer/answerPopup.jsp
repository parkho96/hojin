<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>  

<link type="text/css" href="/css/wzwg/module/cmm/layer_popup.css" rel="stylesheet" /> 

<script type="text/javascript">

	$(document).ready(function(){
		
		$("#cancle_btn").click(function (){
	    	$('body').css({overflow:'auto'});
	    	$("#bbs_layer").html("");
	   		$('#bbs_layer').hide();	
		});	
		
		$("#close_btn").click(function (){
	    	$('body').css({overflow:'auto'});
	    	$("#bbs_layer").html("");
	   		$('#bbs_layer').hide();	
		});	
		
		fnAnswerList();
		
		// 댓글 등록
		$("#regist_btn").click(function(){
			
			if($('#inputAnswer').val() == ''){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument><spring:message code="wzwg.cmm.word.cn" /></spring:argument></spring:message>');
				return;
			}
			
			$('#answerCn').val($('#inputAnswer').val()); 

			$.ajax({
				type:'POST'
				, dataType: 'xml'
				, url:'<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/answer/registNttAnswerAjax.do'
				, data:$('#popFrm').serialize()
				, success:function (result) {
		    	  
					var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value != 'fail'){
						$("#answer_cnt_txt").text(value);
						$('#inputAnswer').val('');
						fnAnswerList();
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
					}
		    	  
				}
				, error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
			});
			
		});
		
		// 게시판 상세보기 화면 이동
		$('#ntt_detail_btn').click(function(){
			$("#close_btn").click();
			fnView('<c:out value="${resultVO.nttSeq}" />', '<c:out value="${resultVO.ntcrId}" />', '<c:out value="${resultVO.secretAt}" />');
		});
		
		// 내림차순
		$('.ordr_desc').click(function(){
			fnAnswerListOrdr('A');			
		});
		
		// 오름차순
		$('.ordr_asc').click(function(){
			fnAnswerListOrdr('D');			
		});
		
	});
	 
	// 댓글 목록
	function fnAnswerList(){
		$.ajax({
	        type:'POST'
	        , dataType: 'html'
			, url:'<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/answer/selectNttAnswerListAjax.do'
			, data:$('#popFrm').serialize()
			, success:function (data) {
				$('#answer_list_div').html(data);
			}
			, error:function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});	
	}
	
	// 댓글 목록 정렬
	function fnAnswerListOrdr(ordrSe){
		
		document.getElementById('ordrSe').value = ordrSe;
		
		$.ajax({
	        type:'POST'
	        , dataType: 'html'
			, url:'<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/answer/selectNttAnswerListAjax.do'
			, data:$('#popFrm').serialize()
			, success:function (data) {
				$('#answer_list_div').html(data);
				
				if(ordrSe == 'A'){
					$('.ordr_desc').hide();
					$('.ordr_asc').show();
				}
				
				if(ordrSe == 'D'){
					$('.ordr_desc').show();
					$('.ordr_asc').hide();
				}
				
			}
			, error:function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});	
	}
	
</script>

<c:set var="adminAuthAt" value="N"/>

<c:if test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or sessionScope.CNTNTS_ADMIN_AT}">
	<c:set var="adminAuthAt" value="Y"/>
</c:if>

<c:set var="popupViewAuthAt" value="N" />

<c:if test="${loginVO.usrSeq eq resultVO.ntcrSeq or nttAuthVO.authorSe eq 'R' or nttAuthVO.authorSe eq 'W' or adminAuthAt eq 'Y'}">
	<c:set var="popupViewAuthAt" value="Y" />
</c:if>	

<c:if test="${popupViewAuthAt ne 'Y'}">
	<script type="text/javascript">		
		$("#close_btn").click();
		alert("<spring:message code="wzwg.cmm.msg.MSG084" />");
	</script>
</c:if>	

<div class="layer1 w800" style="height:600px;">
	
		<div class="pop-id-sch">
			<button class="close" type="button" onclick="fnLayerPopupClose();"><img src="/images/wzwg/site/mngr/pop-close.png" alt="<spring:message code="wzwg.cmm.word.close" />" /></button>
			<span><c:out value="${resultVO.nttSj}" /></span>
		</div>
		
		<div class="pop-container" style="height:480px;">
			<div class="pop-conts" style="height:440px;overflow-y:auto;">
				<form:form modelAttribute="nttAnswerVO" path="popFrm" name="popFrm" id="popFrm" method="post">
				<form:hidden path="siteSeq" />
				<form:hidden path="nttSeq" />
				<form:hidden path="ordrSe" />		
			
				<!-- board-detail-005 -->
				<div id="board-detail-005" class="board-detail-005">
					<div class="list_tit">
						<h3>
							<c:if test="${!empty resultVO.subospecSj}">
							<span class="mg_r5" style="color:#A6A6A6;">[ <c:out value="${resultVO.subospecSj}" /> ]</span>
							</c:if>
							<a href="javascript:void(0);"><span class="mg_r10" id="ntt_detail_btn"><c:out value="${resultVO.nttSj}" /></span></a>		
							<span class="tit_bar"><c:out value="${resultVO.bbsNm}" /></span>
						</h3>
						<p class="list_date">
							<c:out value="${resultVO.lastUpdtPnttm}" />
						</p>
					</div>
					<div class="list_content">
					
						<!-- conBottom -->
						<div class="conBottom">	
								
							<div id="module_id_<c:out value="${resultVO.nttSeq}" />" class="mg_t20" style="clear:both; overflow:hidden;">
							
								<div id="module_inc">
									<ul class="cBleft">
										<li>
											<a href="javascript:void(0);" id="answer_ctrl_btn">
												<font id="answer_txt" class="font_txt" style="font-weight:bold;color:#FF2424;"><spring:message code="wzwg.cmm.word.answer02" /> <span id="answer_cnt_txt" style="font-weight:bold;color:#FF2424;"><c:out value="${nttAnswerVO.answerCnt}" /></span></font>
											</a>
										</li>
										<li>
											<a href="javascript:void(0);" id="answer_ordr_btn">
												<span class="ordr_desc" style="display:none;"><spring:message code="wzwg.cmm.word.rgsde" /> ▼</span>
												<span class="ordr_asc"><spring:message code="wzwg.cmm.word.rgsde" /> ▲</span>
											</a>
										</li>
									</ul>
								</div>								
								
								
								<!-- module_div -->
								<div id="module_div">
								
									<input type="hidden" id="answerCn" name="answerCn" />
									<input type="hidden" id="wrterNm" name="wrterNm" />									
									
									<div class="answer">
									
										<div id="answer_div">
										
											<!-- 댓글 목록 영역 -->
											<ul id="answer_list_div" style="overflow-y:scroll;height:350px;padding-right:10px;"></ul>
											
											<!-- 댓글 입력 영역 -->
									
												<table>
													<colgroup>
														<col width="80%"/>
														<col width="10%"/>
													</colgroup>
													<thead>
														<tr>
															<td colspan="2"><spring:message code="wzwg.sysMngr.word.answr02Wrt" /></td>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td>
																<c:set var="msg_txt01">
																	<spring:message code="wzwg.cmm.cmmMsg.CMG011">
																		<spring:argument><spring:message code="wzwg.cmm.word.answer02" /></spring:argument>
																		<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
																	</spring:message>
																</c:set>
																
																<textarea id="inputAnswer" placeholder="<c:out value="${msg_txt01}" />" class="txtBox"></textarea>
															</td>
															<td><input class="txtBtn" type="button" value="<spring:message code="wzwg.cmm.word.regist" />"  id="regist_btn"></td>
														</tr>
													</tbody>
												</table>			

										</div>
								
									</div>

								</div>	
								<!-- //module_div -->				
								
							</div>	
							<!-- //module_id -->
													
						</div>						
						<!-- //conBottom -->
					
					</div>
					
				</div>	
				<!-- //board-detail-005 -->

			</form:form>
			</div>
		</div>
		
		<div class="ctr-box">
			<a href="javascript:void(0);" class="btn-a fc" onclick="fnLayerPopupClose()"><spring:message code="wzwg.cmm.word.close" /></a>
		</div>
			
	</div>