<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<c:set var="adminAuthAt" value="N"/>

		<c:if test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or sessionScope.CNTNTS_ADMIN_AT}">
			<c:set var="adminAuthAt" value="Y"/>
		</c:if>		
		
<script>
	
	$(document).ready(function(){
		
		// 채택된 답변 접기
		$('#reply_<c:out value="${nttVO.choiceNttSeq}"/>').remove();
		
		// 원문보기 열기
		$('.orginl_open').click(function(){
			$('#<c:out value="${nttVO.choiceNttSeq}"/>').show();
			$('.orginl_open').hide();
			$('.orginl_close').show();
			$("#content").css("height",$(document).height());
		});
		
		// 원문보기 닫기
		$('.orginl_close').click(function(){
			$('#<c:out value="${nttVO.choiceNttSeq}"/>').hide();
			$('#modify_replay_div_<c:out value="${nttVO.choiceNttSeq}"/>').hide();
			$('.orginl_open').show();
			$('.orginl_close').hide();
			$("#content").css("height",$(document).height());
		});
		
	});

	// 답변채택 팝업
	function fnAnsweChoice(nttSeq){
		
		$('body').css({overflow:'hidden'});
		
		$.ajax({
			type:'POST'
			, dataType: 'html'
			, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/qna/selectNttReplyChoicePopup.do'
			, data:"nttSeq="+nttSeq+"&parntsNttSeq=<c:out value='${parntsNttSeq}'/>"
			, success:function (data) {
				//$('#qna_reply_layer').html(data);
				//$("#qna_reply_layer").show();
				var title = '<spring:message code="wzwg.module.word.answerchoice" />';
				wzAjaxModal('popup_s', title, data);
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
		});
	}
	
	// 답변수정 폼
	function fnReplyModifyForm(nttSeq, val){
		if(val == 'Y'){
			$('#ntt_reply_regist_div').hide();
			
			<c:forEach var="resultList" items="${resultList}">
				if('<c:out value="${resultList.nttSeq}"/>' != nttSeq){
					if('<c:out value="${nttVO.choiceNttSeq}"/>' != '<c:out value="${resultList.nttSeq}"/>'){
						$('#<c:out value="${resultList.nttSeq}"/>').show();	
					}else{
						$('.orginl_close').click();
					}
					$('#modify_replay_div_<c:out value="${resultList.nttSeq}"/>').hide();
				}
			</c:forEach>
			
			$('#'+nttSeq).hide();
			$('#modify_replay_div_'+nttSeq).show();
			
				$('#modify_replay_div_'+nttSeq).find('iframe').css('height','400px'); 
			
				<c:if test="${editorEstbsSe eq 'S'}">
				/*
				var editorObj = (new Function ("return "+"oEditors_"+nttSeq)());
				
				editorObj.getById["modifyNttReplyCn_"+nttSeq].exec("CHANGE_EDITING_MODE", ["WYSIWYG"]);
				editorObj.getById["modifyNttReplyCn_"+nttSeq].exec("RESET_TOOLBAR");
				*/
				
				
				 
				oEditors.getById["modifyNttReplyCn_"+nttSeq].exec("CHANGE_EDITING_MODE", ["WYSIWYG"]);
				oEditors.getById["modifyNttReplyCn_"+nttSeq].exec("RESET_TOOLBAR");
				
					
				</c:if>
			<c:if test="${adminAuthAt eq 'Y' }">
			</c:if>
			
			<c:if test="${adminAuthAt ne 'Y' }">
				//$('#modifyNttReplyCn_' + nttSeq).show();
			</c:if>
			
		}else{
			$('#ntt_reply_regist_div').show();
			
			if('<c:out value="${nttVO.choiceNttSeq}"/>' == nttSeq){
				$('.orginl_close').click();
			}else{
				$('#'+nttSeq).show();				
			}
			
			$('#modify_replay_div_'+nttSeq).hide();
		}
		$("#content").css("height",$(document).height());
	}
	
	// 답변수정
	function fnReplyModify(nttSeq, replyNttCn){
		
		var frm = document.replyFrm;
		
		frm.nttSeq.value = nttSeq;
		if(oEditors.getById["modifyNttReplyCn_"+nttSeq] != undefined){
			frm.nttCn.value = oEditors.getById["modifyNttReplyCn_"+nttSeq].getIR();
		}else{
			frm.nttCn.value = replyNttCn;
		}
		frm.nttCnChrctr.value = frm.nttCn.value.replace(/[<][^>]*[>]/g, "");
		
		if(replyNttCn == ''){
			alert('<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument><spring:message code="wzwg.module.word.answercn" /></spring:argument></spring:message>');
			return;
		}
		 
		$.ajax({
			type:'POST'
			, dataType: 'xml'
			, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/qna/modifyNttReplyAjax.do'
			, data:$("#replyFrm").serialize()
			//, data:"nttSeq="+nttSeq+"&nttCn="+replyNttCn+"&nttCnChrctr="+replyNttCnChrctr
			, success:function (result) {
	    	  
				var value = "";
				
				$(result).find("value").each(function() {  
					value = $(this).text();  
				});
				
				if(value == 'success'){
					fnQnaReplyList();
					$('#ntt_reply_regist_div').show();
				}else{
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
				}
	    	  
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
		});
		$("#content").css("height",$(document).height());
		
	}
			
	// 답변삭제
	function fnReplyDelete(nttSeq){
		
		if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
			return;
		}else{
			$.ajax({
				type:'POST'
				, dataType: 'xml'
				, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/qna/deleteNttReplyAjax.do'
				, data:"nttSeq="+nttSeq+"&parntsNttSeq="+$('#parntsNttSeq').val()
				, success:function (result) {
		    	  
					var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value != 'fail'){
						$("#ntt_reply_cnt_txt").text(value);
						$("#ntt_reply_detail_txt").text(value);
						fnQnaReplyList();
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
					}
		    	  
				}
				, error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
			});
		}
		
		$("#content").css("height",$(document).height());
	}
	
	// 답변신고
	function fnReplySttemnt(nttSeq){
		if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006"><spring:argument><spring:message code="wzwg.module.word.answerposts" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.sttemnt" /></spring:argument></spring:message>')){
			return;
		}else{
			$.ajax({
				type:'POST'
				, dataType: 'xml'
				, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/sttemnt/registNttSttemntAjax.do'
				, data:"nttSeq="+nttSeq
				, success:function (result) {
		    	  
					var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value == 'success'){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.word.answer01" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.sttemnt" /></spring:argument></spring:message>');
						fnQnaReplyList();
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
					}
		    	  
				}
				, error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
			});
		}
		$("#content").css("height",$(document).height());
	}
	

</script>

	<!-- 레이어팝업 영역 Start -->
	<div id="qna_reply_layer" class="pop-box"></div>
	<!-- 레이어팝업 영역 End -->
	
	<c:if test="${!empty resultList}">
		<c:forEach var="resultList" items="${resultList}" varStatus="status">
		
		<c:set var="replyModAuthAt" value="" />	
		<c:set var="replyDelAuthAt" value="" />
		<c:set var="answeChoAuthAt" value="" />		
		
		<c:if test="${loginVO.usrSeq eq resultList.ntcrSeq}">
			<c:set var="replyModAuthAt" value="Y" />	
			<c:set var="replyDelAuthAt" value="Y" />
		</c:if>
		
		<c:if test="${loginVO.usrSeq eq resultList.parntsNtcrSeq}">
			<c:if test="${nttChoiceAt eq 'N'}">
				<c:set var="answeChoAuthAt" value="Y" />		
			</c:if>
		</c:if>
		
		<c:if test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or sessionScope.CNTNTS_ADMIN_AT}">
			<c:set var="replyModAuthAt" value="Y" />	
			<c:set var="replyDelAuthAt" value="Y" />
			<c:if test="${nttChoiceAt eq 'N'}">
				<c:set var="answeChoAuthAt" value="Y" />		
			</c:if>			
		</c:if>			
		
		<div class="board001 mb5" id="reply_<c:out value='${resultList.nttSeq}'/>">
			<div class="list_tit">
				<h3></h3>
				<p class="list_date">		
					 <span>
					 <c:choose>
								<c:when test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT }">
								<c:out value="${resultList.ntcrNm}"/>(<c:out value="${resultList.ntcrId}"/>)
								</c:when>
								<c:otherwise>
								<c:out value="${resultList.ntcrNm}"/>
								</c:otherwise>
							</c:choose>
					 </span> 
					<span><c:out value="${resultList.frstRegistPnttm}"/></span>
					<span class="com_bar">
						<c:if test="${replyModAuthAt eq 'Y'}">
							<a href="javascript:void(0);" onclick="fnReplyModifyForm('<c:out value="${resultList.nttSeq}"/>', 'Y');" class="gray"><spring:message code="wzwg.cmm.word.updt" /></a>
						</c:if>
						<c:if test="${replyDelAuthAt eq 'Y'}">
							<a href="javascript:void(0);" onclick="fnReplyDelete('<c:out value="${resultList.nttSeq}"/>');"><spring:message code="wzwg.cmm.word.delete" /></a>
						</c:if>	
					</span>				
				</p>
			</div><!-- list_tit end -->
			<div class="list_content">
				 <div class="conTop">
					<%-- <h4>${resultList.ntcrNm}(${fn:substring(resultList.ntcrId, 0, 4)}****)</h4> --%>
					<c:if test="${nttVO.choiceNttSeq eq resultList.nttSeq}">	
					<p>
						<span style="color:#FF0000;"><spring:message code="wzwg.cmm.msg.MSG008" /></span>
						<a href="javascript:void(0);" class="orginl_open"><spring:message code="wzwg.module.word.orgtxtview" /> ▼</a>
						<a href="javascript:void(0);"  class="orginl_close" style="display:none;"><spring:message code="wzwg.module.word.orgtxtview" /> ▲</a>						
					</p>
					</c:if>
				</div><!-- conTop end --> 
				<div class="conMiddle">
					<div class="conM_txt" id="<c:out value='${resultList.nttSeq}'/>">
						<c:out value='${resultList.nttCn}' escapeXml="false" />
					</div>
					<ul>
						<li>
							<a href="javascript:void(0);" id="answer_ctrl_btn_<c:out value='${resultList.nttSeq}'/>" class="red fw900">
								<spring:message code="wzwg.cmm.word.answer02" /> <span id="answer_cnt_txt_<c:out value='${resultList.nttSeq}'/>" ><c:out value="${resultList.answerCnt}"/></span>
							</a>
						</li>
						
						<li>
							<a href="javascript:void(0);" id="qna_answer_ordr_btn_<c:out value='${resultList.nttSeq}'/>">
								<span class="ordr_desc_<c:out value='${resultList.nttSeq}'/>" style="display:none;"><spring:message code="wzwg.cmm.word.rgsde" /> ▼</span>
								<span class="ordr_asc_<c:out value='${resultList.nttSeq}'/>"><spring:message code="wzwg.cmm.word.rgsde" /> ▲</span>
							</a>
						</li>						
					</ul>
				</div>
			</div>

			<c:if test="${replyModAuthAt eq 'Y'}">
			
			<div id="modify_replay_div_<c:out value='${resultList.nttSeq}'/>" style="display:none;margin-top:10px;">
				<div class="ta_c mg_b10">
					<textarea name="modifyNttReplyCn_<c:out value="${resultList.nttSeq}"/>" id="modifyNttReplyCn_<c:out value="${resultList.nttSeq}"/>" rows="10" class="p5" style="width:98%;display:none;" title="<spring:message code="wzwg.cmm.word.answer01" /> <spring:message code="wzwg.cmm.word.cn" /> <spring:message code="wzwg.cmm.word.updt" />"><c:out value="${resultList.nttCn}"/></textarea>
					
					<c:import url="${wzwg_contextPath}/module/editor/editorForm.do" charEncoding="utf-8">
						<c:param name="param_editorNm" 	value="modifyNttReplyCn_${resultList.nttSeq}" />
						<c:param name="param_editorTy" 	value="custom" />
					</c:import>
					<c:if test="${adminAuthAt eq 'Y' }">
					</c:if>
					
				</div>
				
				<div>
					<div class="ctr-box">
						<c:if test="${adminAuthAt eq 'Y' }">
							<c:if test="${editorEstbsSe eq 'C'}">
							<a href="javascript:void(0);" onclick="fnReplyModify('<c:out value="${resultList.nttSeq}"/>', bEditor_modifyNttReplyCn_<c:out value='${resultList.nttSeq}'/>.GetBodyValue());" class="wzbtn-table btn-save"><spring:message code="wzwg.cmm.word.answer01" /> <spring:message code="wzwg.cmm.word.updt" /></a>
							</c:if>
							<c:if test="${editorEstbsSe eq 'S'}">
							<a href="javascript:void(0);" onclick="fnReplyModify('<c:out value="${resultList.nttSeq}"/>', oEditors.getById['modifyNttReplyCn_<c:out value="${resultList.nttSeq}"/>'].getIR())" class="wzbtn-table btn-save"><spring:message code="wzwg.cmm.word.answer01" /> <spring:message code="wzwg.cmm.word.updt" /></a>
							</c:if>
						</c:if>
						
						<c:if test="${adminAuthAt ne 'Y' }">
						<a href="javascript:void(0);" onclick="fnReplyModify('<c:out value="${resultList.nttSeq}"/>', $('#modifyNttReplyCn_<c:out value="${resultList.nttSeq}"/>').val())" class="wzbtn-table btn-save"><spring:message code="wzwg.cmm.word.answer01" /> <spring:message code="wzwg.cmm.word.updt" /></a>
						</c:if>
						
						<a href="javascript:void(0);" onclick="fnReplyModifyForm('<c:out value="${resultList.nttSeq}"/>', 'N');" class="wzbtn-table btn-basic"><spring:message code="wzwg.cmm.word.cancl" /></a>
					</div>
				</div>		
				
			</div>	
			
			</c:if>				
			
	        <div class="mg_t5" style="clear:both; overflow:hidden;">
		        <c:import url="${wzwg_contextPath}${prefix}/module/ntt/qna/answer/selectNttQnaAnswerFormAjax.do" charEncoding="utf-8">
					<c:param name="param_nttSeq" 		value="${resultList.nttSeq}" />
					<c:param name="param_parntsNttSeq" 	value="${resultList.parntsNttSeq}" />
				</c:import>
			</div>			

			<c:if test="${answeChoAuthAt eq 'Y'}">
				<div class="ctr-box">
					<a href="javascript:void(0);" onclick="fnAnsweChoice('<c:out value="${resultList.nttSeq}"/>');" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.answer01" /> <spring:message code="wzwg.cmm.word.choice" /></a>
				</div>	
			</c:if>		
			
		</div>
		
		</c:forEach>
		
	</c:if>
	