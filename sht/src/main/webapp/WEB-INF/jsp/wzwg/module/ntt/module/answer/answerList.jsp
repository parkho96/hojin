<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<% pageContext.setAttribute("cn", "\n"); %>

<script type="text/javascript">
	
	/** 댓글 수정 폼 */
	function fnModifyAnswerFrm(nttSeq, answerSeq, parntsAnswerSeq, idx, val, replySe){
		var answerCn = $('#answerCn_'+nttSeq+"_"+answerSeq).val();
		if(val == 'Y'){
			
			for(var i = 0; i < '${fn:length(resultList)}'; i++){
				$('#module_div_'+nttSeq+' #answerCnDiv'+i).show();
				$('#module_div_'+nttSeq+' #modifyAnswerCnDiv'+i).hide();					
				$('#module_div_'+nttSeq+' #modifyY'+i).show();
				$('#module_div_'+nttSeq+' #modifyN'+i).hide();				
				if($('#module_div_'+nttSeq+' #replyAnswerDiv'+i).css('display') != 'none'){
					$('#module_div_'+nttSeq+' #replyAnswerDiv'+i).hide();
					$('#module_div_'+nttSeq+' #replyY'+i).show();
					$('#module_div_'+nttSeq+' #replyN'+i).hide();
				}
			}		

			$('#module_div_'+nttSeq+' #answerCnDiv'+idx).hide();
			$('#module_div_'+nttSeq+' #modifyAnswerCnDiv'+idx).show();
			$('#module_div_'+nttSeq+' #modifyY'+idx).hide();
			$('#module_div_'+nttSeq+' #modifyN'+idx).show();
			
			var innerTag = "";
			innerTag += '<li><div class="mg_b10 reply_write_form">';
			innerTag += '<table><colgroup><col width="80%"/><col width="10%"/></colgroup><tbody><tr><td class="comn_tit" colspan="2"><spring:message code="wzwg.module.word.answerupdt" /></td></tr>';
			innerTag += '<tr><td><textarea id="modifyInputAnswer" class="txtBox" title="<spring:message code="wzwg.module.word.answerinpcmpt" />">'+answerCn+'</textarea></td>';
			innerTag += '<td><input id="reply_regist_btn" type="button" value="<spring:message code="wzwg.cmm.word.updt" />" onclick="fnModifyAnswer('+nttSeq+', '+answerSeq+');"></td></tr></tbody></table>';
			innerTag += '</li></div>';

			$('#module_div_'+nttSeq+' #modifyAnswerCnDiv'+idx).text("");
			$('#module_div_'+nttSeq+' #modifyAnswerCnDiv'+idx).append(innerTag);

		}else{
			
			$('#module_div_'+nttSeq+' #modifyAnswerCnDiv'+idx).text("");
			
			$('#module_div_'+nttSeq+' #answerCnDiv'+idx).show();
			$('#module_div_'+nttSeq+' #modifyAnswerCnDiv'+idx).hide();
			$('#module_div_'+nttSeq+' #modifyY'+idx).show();
			$('#module_div_'+nttSeq+' #modifyN'+idx).hide();
		}
	}

	/** 댓글 수정 */
	function fnModifyAnswer(nttSeq, answerSeq){
		
		if($('#module_div_'+nttSeq+' #modifyInputAnswer').val() == ''){
			alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.answer02" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
			return;
		}
		
		$('#module_div_'+nttSeq+' #answerCn').val($('#module_div_'+nttSeq+' #modifyInputAnswer').val()); 
			
		$.ajax({
	        type:'POST'
	        , dataType: 'xml'
			, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/answer/modifyNttAnswerAjax.do'
			, data:"nttSeq="+nttSeq+"&answerSeq="+answerSeq+"&answerCn="+$('#module_div_'+nttSeq+' #answerCn').val()
			, success:function (result) {
				var value = "";
				
				$(result).find("value").each(function() {  
					value = $(this).text();  
				});
				
				if(value == 'success'){
					$('#module_div_'+nttSeq+' #modifyInputAnswer').val('');
					fnAnswerList(nttSeq);
				}else{
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
				}
			}
			, error:function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
	/** 댓글 삭제 */
	function fnDeleteAnswer(nttSeq, answerSeq){
		
		if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
			return;
		}
		
		$.ajax({
			type:'POST'
			, dataType: 'xml'
			, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/answer/deleteNttAnswerAjax.do'
			, data:"nttSeq="+nttSeq+"&answerSeq="+answerSeq
			, success:function (result) {
				var value = "";
				
				$(result).find("value").each(function() {  
					value = $(this).text();  
				});
				
				if(value != 'fail'){
					$('#module_inc_'+nttSeq+' #answer_cnt_txt').text(value);
					fnAnswerList(nttSeq);
				}else{
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
				}
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	}); 
	}

	function fnReplyAnswer(answerSeq, val, idx, parntsWrterNm, nttSeq){

		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/answer/selectNttAnswerReplyFormAjax.do'
	      , cache : false
	      , async : false
	      , data:"nttSeq="+nttSeq+"&parntsAnswerSeq="+answerSeq+"&parntsWrterNm="+parntsWrterNm
	      , success:function (data) {
	    	  $('#module_div_'+nttSeq+' #replyAnswerDiv'+idx).html(data);
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
		
		if(val == 'Y'){
		
			for(var i = 0; i < '${fn:length(resultList)}'; i++){
				$('#module_div_'+nttSeq+' #answerCnDiv'+i).show();
				$('#module_div_'+nttSeq+' #modifyAnswerCnDiv'+i).hide();					
				$('#module_div_'+nttSeq+' #modifyY'+i).show();
				$('#module_div_'+nttSeq+' #modifyN'+i).hide();				
				if($('#module_div_'+nttSeq+' #replyAnswerDiv'+i).css('display') != 'none'){
					$('#module_div_'+nttSeq+' #replyAnswerDiv'+i).hide();
					$('#module_div_'+nttSeq+' #replyY'+i).show();
					$('#module_div_'+nttSeq+' #replyN'+i).hide();
				}
			}	
			
			$('#module_div_'+nttSeq+' #replyAnswerDiv'+idx).show();
			$('#module_div_'+nttSeq+' #replyY'+idx).hide();
			$('#module_div_'+nttSeq+' #replyN'+idx).show();
		}else{
			$('#module_div_'+nttSeq+' #replyAnswerDiv'+idx).hide();
			$('#module_div_'+nttSeq+' #replyY'+idx).show();
			$('#module_div_'+nttSeq+' #replyN'+idx).hide();
		}
	}

</script>

	<c:forEach var="resultList" items="${resultList}" varStatus="status">
	
		<c:choose>
			<c:when test="${resultList.listDepth ne '1'}">
				<li style="margin-left:${resultList.listDepth * 10}px;">
			</c:when>
			<c:otherwise><li></c:otherwise>
		</c:choose>
		
				<input type="hidden" id="answerCn_<c:out value='${resultList.nttSeq}'/>_<c:out value='${resultList.answerSeq}'/>" value="<c:out value='${resultList.answerCn}'/>"/>
		
				<p class="com_cont">
				
					<c:if test="${resultList.listDepth ne '1'}">
						<img src="/images/wzwg/module/ntt/icoReply.png" alt="<spring:message code="wzwg.cmm.word.answer02" />"/>
					</c:if>				
				
					<c:out value="${resultList.wrterNm}"/>
					<span class="gray"><c:out value="${resultList.frstRegistPnttm}"/></span>
				</p>
				<p class="comm_cont">
					<div id="answerCnDiv<c:out value='${status.index}'/>">
						<c:if test="${resultList.listDepth ne '1' and resultList.listDepth ne '2'}">
							<span><c:out value="${resultList.parntsWrterNm}"/></span>
						</c:if>
						<c:out value='${fn:replace(resultList.answerCn, cn, "<br />")}' escapeXml="false" />
					</div>
				</p>
				<ul>
					<c:set var="repAuthAt" value="" />
					<c:set var="modAuthAt" value="" />
					<c:set var="delAuthAt" value="" />				
	
					<c:if test="${loginVO.usrSeq eq resultList.wrterSeq or sessionScope.SADMIN_AT or sessionScope.NADMIN_AT}">
						<c:set var="modAuthAt" value="Y" />
						<c:set var="delAuthAt" value="Y" />
					</c:if>	
					<c:if test="${not empty loginVO.userId}">
						<c:set var="repAuthAt" value="Y" />
					</c:if>
					<c:if test="${repAuthAt eq 'Y'}">
						<li id="replyY<c:out value='${status.index}'/>" >
							<a href="javascript:void(0);" onclick="fnReplyAnswer('<c:out value="${resultList.answerSeq}"/>', 'Y', '<c:out value="${status.index}"/>', '<c:out value="${resultList.wrterNm}"/>', '<c:out value="${resultList.nttSeq}"/>');">
								<img src="/images/wzwg/module/ntt/icoReply.png" alt="<spring:message code="wzwg.cmm.word.answer03" />" /><span><spring:message code="wzwg.cmm.word.answer03" /></span>
							</a>
						</li>
						<li id="replyNM<c:out value='${status.index}'/>" style="display:none;">
							<a href="javascript:void(0);" onclick="fnReplyAnswer('<c:out value="${resultList.answerSeq}"/>', 'N', '<c:out value="${status.index}"/>', '<c:out value="${resultList.wrterNm}"/>', '<c:out value="${resultList.nttSeq}"/>');">
								<img src="/images/wzwg/module/ntt/icoReply.png" alt="<spring:message code="wzwg.module.word.answercancl" />" /><span style="color:#FF2424;"><spring:message code="wzwg.module.word.answercancl" /></span>
							</a>
						</li>		
					</c:if>	
					
					<c:if test="${modAuthAt eq 'Y'}">
						<li id="modifyY<c:out value='${status.index}'/>">
							<a href="javascript:void(0);" onclick="fnModifyAnswerFrm('<c:out value="${resultList.nttSeq}"/>', '<c:out value="${resultList.answerSeq}"/>', '<c:out value="${resultList.parntsAnswerSeq}"/>', '<c:out value="${status.index}"/>', 'Y');">
								<span><spring:message code="wzwg.cmm.word.updt" /></span>
							</a>
						</li>
						<li id="modifyN<c:out value='${status.index}'/>" style="display:none;">
							<a href="javascript:void(0);" onclick="fnModifyAnswerFrm('<c:out value="${resultList.nttSeq}"/>', '<c:out value="${resultList.answerSeq}"/>', '<c:out value="${resultList.parntsAnswerSeq}"/>', '<c:out value="${status.index}"/>', 'N');">
								<span style="color:#FF2424;"><spring:message code="wzwg.module.word.updtcancl" /></span>
							</a>
						</li>
					</c:if>
					
					<c:if test="${delAuthAt eq 'Y'}">
						<li>
							<a href="javascript:void(0);" onclick="fnDeleteAnswer('<c:out value="${resultList.nttSeq}"/>', '<c:out value="${resultList.answerSeq}"/>');">
								<span><spring:message code="wzwg.cmm.word.delete" /></span>
							</a>
						</li>
					</c:if>	
				</ul>				
		</li>	
		
		<div id="modifyAnswerCnDiv<c:out value='${status.index}'/>" style="display:none;"></div> 
		
		<!-- 댓글에 답글 입력 start -->
		<div id="replyAnswerDiv<c:out value='${status.index}'/>"></div>
		<!-- 댓글에 답글 입력 end -->
		
	</c:forEach>
	