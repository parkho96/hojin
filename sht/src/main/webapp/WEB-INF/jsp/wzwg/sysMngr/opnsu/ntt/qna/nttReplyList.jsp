<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<% pageContext.setAttribute("cn", "\n"); %>

<script>
	
	var modify_oEditors = [];

	$(document).ready(function(){
		
		// 채택된 답변 접기 
		
		// 원문보기 열기
		$('.orginl_open').click(function(){ 
			$('.orginl_open').hide();
			$('.orginl_close').show();
			$("#content").css("height",$(document).height());
		});
		
		// 원문보기 닫기
		$('.orginl_close').click(function(){ 
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
			, url:'<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/qna/selectNttReplyChoicePopup.do'
			, data:"nttSeq="+nttSeq+"&parntsNttSeq=<c:out value="${parntsNttSeq}" />"
			, success:function (data) {
				$('#qna_reply_layer').html(data);
				$("#qna_reply_layer").show();
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
				if('<c:out value="${resultList.nttSeq}" />' != nttSeq){
				 
					$('#modify_replay_div_<c:out value="${resultList.nttSeq}" />').hide();
				}
			</c:forEach>
			
			$('#'+nttSeq).hide();
			$('#modify_replay_div_'+nttSeq).show();
			$('#modify_replay_div_'+nttSeq).find('iframe').css('height','400px'); 
			
			if('<c:out value="${editorEstbsSe}" />' == 'S'){
				/*
				var editorObj = (new Function ("return "+"bEditor_modifyNttReplyCn_"+nttSeq)());
				
				editorObj.getById["modifyNttReplyCn_"+nttSeq].exec("CHANGE_EDITING_MODE", ["WYSIWYG"]);
				editorObj.getById["modifyNttReplyCn_"+nttSeq].exec("RESET_TOOLBAR");
				*/
			
				oEditors.getById["modifyNttReplyCn_"+nttSeq].exec("CHANGE_EDITING_MODE", ["WYSIWYG"]);
				oEditors.getById["modifyNttReplyCn_"+nttSeq].exec("RESET_TOOLBAR");
			 
			}
			
		}else{
			$('#'+nttSeq).show();	
			$('#ntt_reply_regist_div').show();
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
			alert('<spring:message code="wzwg.cmm.cmmMsg.CMG020">'+
							'<spring:argument><spring:message code="wzwg.sysMngr.word.answr01Cn" /></spring:argument>'+
							'<spring:argument><spring:message code="wzwg.sysMngr.word.requinutIem" /></spring:argument>'+
						  '</spring:message>');
			return;
		}
		 
		$.ajax({
			type:'POST'
			, dataType: 'xml'
			, url:'<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/qna/modifyNttReplyAjax.do'
			, data:$("#replyFrm").serialize()
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
				, url:'<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/qna/deleteNttReplyAjax.do'
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
			<c:if test="${nttChoiceAt eq 'N'}">
				<c:set var="answeChoAuthAt" value="Y" />		
			</c:if>
		</c:if>
		
		<c:if test="${sessionScope.SADMIN_AT}">
			<c:set var="replyModAuthAt" value="Y" />	
			<c:set var="replyDelAuthAt" value="Y" />
			<c:if test="${nttChoiceAt eq 'N'}">
				<c:set var="answeChoAuthAt" value="Y" />		
			</c:if>			
		</c:if>		
		
		<div  class="answer">
		
		<ul>
			<li>
				<p class="com_cont"><img class="user" src="/images/wzwg/site/mngr/a.png" alt="<spring:message code="wzwg.sysMngr.word.emplyrIcon" />" />
					<a class="va10"><c:out value="${resultList.ntcrNm}" />(<c:out value="${fn:substring(resultList.ntcrId, 0, 4)}" />****)</a>
					<span class="gray va10"><c:out value="${resultList.frstRegistPnttm}" />
						<c:if test="${nttVO.choiceNttSeq eq resultList.nttSeq}">
							<span style="color:#FF0000;"><spring:message code="wzwg.cmm.msg.MSG008" /></span>
							<!-- <a href="javascript:void(0);">
								<span class="orginl_open">원문보기 ▼</span>
								<span class="orginl_close" style="display:none;">원문보기 ▲</span>
							</a> -->
						</c:if>						
					</span>
				</p>
				<div class="comm_cont" id="<c:out value="${resultList.nttSeq}" />">
						<c:out value='${resultList.nttCn}' escapeXml="false" />
				</div>
				<ul>
					<c:if test="${replyModAuthAt eq 'Y'}">
						<li><a href="javascript:void(0);" onclick="fnReplyModifyForm('<c:out value="${resultList.nttSeq}" />', 'Y');"><spring:message code="wzwg.cmm.word.updt" /></a></li>
					</c:if>
					<c:if test="${replyDelAuthAt eq 'Y'}">
						<li><a href="javascript:void(0);" onclick="fnReplyDelete('<c:out value="${resultList.nttSeq}" />');"><spring:message code="wzwg.cmm.word.delete" /></a></li>
					</c:if>				
				</ul>
				<!-- 
	        	<c:if test="${answeChoAuthAt eq 'Y'}">
					<div class="ctr-box">
						<a href="javascript:void(0);" onclick="fnAnsweChoice('<c:out value="${resultList.nttSeq}"/>');" class="btn-a"><spring:message code="wzwg.cmm.word.answer01" /> <spring:message code="wzwg.cmm.word.choice" /></a>
					</div>			        
		        </c:if>	
		         -->
				<c:if test="${replyModAuthAt eq 'Y'}">
					
					<div id="modify_replay_div_<c:out value="${resultList.nttSeq}" />" style="display:none;margin-top:10px;">

							<textarea name="modifyNttReplyCn_<c:out value="${resultList.nttSeq}" />" id="modifyNttReplyCn_<c:out value="${resultList.nttSeq}" />" rows="10" style="width:98%;display:none;"><c:out value="${resultList.nttCn}" escapeXml="false"/></textarea>
							
							<c:import url="${wzwg_contextPath}/module/editor/editorForm.do" charEncoding="utf-8">
								<c:param name="param_editorNm" 	value="modifyNttReplyCn_${resultList.nttSeq}" />
								<c:param name="param_editorTy" 	value="custom" />
							</c:import>
							
							<div class="rt-box">
								<c:if test="${editorEstbsSe eq 'C'}">
								<a href="javascript:void(0);" onclick="fnReplyModify('<c:out value="${resultList.nttSeq}" />', bEditor_modifyNttReplyCn_<c:out value="${resultList.nttSeq}" />.GetBodyValue());" class="wzbtn btn-save"><spring:message code="wzwg.sysMngr.word.answr01Updt" /></a>
								</c:if>
								<c:if test="${editorEstbsSe eq 'S'}">
								<a href="javascript:void(0);" onclick="fnReplyModify('<c:out value="${resultList.nttSeq}" />', oEditors.getById['modifyNttReplyCn_<c:out value="${resultList.nttSeq}" />'].getIR())" class="wzbtn btn-save"><spring:message code="wzwg.sysMngr.word.answr01Updt" /></a>
								</c:if>
								<a href="javascript:void(0);" onclick="fnReplyModifyForm('<c:out value="${resultList.nttSeq}" />', 'N');" class="wzbtn btn-del"><spring:message code="wzwg.cmm.word.cancl" /></a>
							</div>
						
						</div>

					</div>	
					
				</c:if>			        				
				
			</li>
			
		</ul>
		
		</div>

		</c:forEach>
		
	</c:if>
	