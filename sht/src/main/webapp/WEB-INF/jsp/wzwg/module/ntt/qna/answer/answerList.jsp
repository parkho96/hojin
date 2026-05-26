<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<% pageContext.setAttribute("cn", "\n"); %>

<c:set var="nttSeq" value="${nttAnswerVO.nttSeq}" />

<script type="text/javascript">
	
	/** 댓글 수정 폼 */
	function fnModifyQnaAnswerFrm(nttSeq, answerSeq, parntsAnswerSeq, idx, val, replySe){
		var answerCn = $('#answerCn_'+nttSeq+"_"+answerSeq).val();
		if(val == 'Y'){
			
			for(var i = 0; i < '${fn:length(resultList)}'; i++){
				$('#answerCnDiv'+i+'_'+nttSeq).show();
				$('#modifyAnswerCnDiv'+i+'_'+nttSeq).hide();
				$('#modifyY'+i+'_'+nttSeq).show();
				$('#modifyN'+i+'_'+nttSeq).hide();				
				if($('#replyAnswerDiv'+i+'_'+nttSeq).show()){
					$('#replyAnswerDiv'+i+'_'+nttSeq).hide();
					$('#replyY'+i+'_'+nttSeq).show();
					$('#replyN'+i+'_'+nttSeq).hide();
				}
			}			

			$('#answerCnDiv'+idx+'_'+nttSeq).hide();
			$('#modifyAnswerCnDiv'+idx+'_'+nttSeq).show();
			$('#modifyY'+idx+'_'+nttSeq).hide();
			$('#modifyN'+idx+'_'+nttSeq).show();
			
			var innerTag = "";
			innerTag += '<table><colgroup><col width="80%"/><col width="10%"/></colgroup><tbody>';
			innerTag += '<tr><td class="comn_tit" colspan="2"><spring:message code="wzwg.module.word.answerupdt" /></td></tr>'
			innerTag += '<tr><td><textarea title="<spring:message code="wzwg.module.word.answerinpcmpt" />" id="modifyInputAnswer_'+nttSeq+'" class="txtBox">'+answerCn+'</textarea></td>';
			innerTag += '<td><input id="reply_regist_btn" type="button" value="<spring:message code="wzwg.cmm.word.updt" />" onclick="fnModifyQnaAnswer('+nttSeq+', '+answerSeq+');"></td></tr></tbody></table>';			
			
			$('#modifyAnswerCnDiv'+idx+'_'+nttSeq).text("");
			$('#modifyAnswerCnDiv'+idx+'_'+nttSeq).append(innerTag);
		}else{
			
			$('#modifyAnswerCnDiv'+idx+'_'+nttSeq).text("");
			
			$('#answerCnDiv'+idx+'_'+nttSeq).show();
			$('#modifyAnswerCnDiv'+idx+'_'+nttSeq).hide();
			$('#modifyY'+idx+'_'+nttSeq).show();
			$('#modifyN'+idx+'_'+nttSeq).hide();
		}
	}
	
	/** 댓글 수정 */
	function fnModifyQnaAnswer(nttSeq, answerSeq){

		if($('#modifyInputAnswer_'+nttSeq).val() == ''){
			alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.answer02" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
			return;
		}
		
		$('#answerCn').val($('#modifyInputAnswer_'+nttSeq).val()); 
			
		$.ajax({
	        type:'POST'
	        , dataType: 'xml'
			, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/qna/answer/modifyNttQnaAnswerAjax.do'
			, data:"nttSeq="+nttSeq+"&answerSeq="+answerSeq+"&answerCn="+$('#answerCn').val()
			, success:function (result) {
				var value = "";
				
				$(result).find("value").each(function() {  
					value = $(this).text();  
				});
				
				if(value == 'success'){
					$('#modifyInputAnswer_'+nttSeq).val('');
					fnQnaAnswerList(nttSeq);
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
	function fnDeleteQnaAnswer(nttSeq, answerSeq){
		
		if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006"><spring:argument><spring:message code="wzwg.cmm.word.answer02" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
			return;
		}

		$.ajax({
			type:'POST'
			, dataType: 'xml'
			, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/qna/answer/deleteNttQnaAnswerAjax.do'
			, data:"nttSeq="+nttSeq+"&answerSeq="+answerSeq
			, success:function (result) {
				var value = "";
				
				$(result).find("value").each(function() {  
					value = $(this).text();  
				});
				
				if(value != 'fail'){
					$('#answer_cnt_txt'+nttSeq).text(value);
					fnQnaAnswerList(nttSeq);
				}else{
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
				}
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	}); 
	}

	function fnReplyQnaAnswer(nttSeq, answerSeq, val, idx, parntsWrterNm){

		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/qna/answer/selectNttQnaAnswerReplyFormAjax.do'
	      , cache : false
	      , async : false
	      , data:"nttSeq="+nttSeq+"&parntsAnswerSeq="+answerSeq+"&parntsWrterNm="+parntsWrterNm
	      , success:function (data) {
	    	  $('#replyAnswerDiv'+idx+'_'+nttSeq).html(data);
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
		
		if(val == 'Y'){
			
			for(var i = 0; i < '${fn:length(resultList)}'; i++){
				$('#answerCnDiv'+i+'_'+nttSeq).show();
				$('#modifyAnswerCnDiv'+i+'_'+nttSeq).hide();
				$('#modifyY'+i+'_'+nttSeq).show();
				$('#modifyN'+i+'_'+nttSeq).hide();				
				if($('#replyAnswerDiv'+i+'_'+nttSeq).show()){
					$('#replyAnswerDiv'+i+'_'+nttSeq).hide();
					$('#replyY'+i+'_'+nttSeq).show();
					$('#replyN'+i+'_'+nttSeq).hide();
				}
			}	
			
			$('#replyAnswerDiv'+idx+'_'+nttSeq).show();
			$('#replyY'+idx+'_'+nttSeq).hide();
			$('#replyN'+idx+'_'+nttSeq).show();
		}else{
			$('#replyAnswerDiv'+idx+'_'+nttSeq).hide();
			$('#replyY'+idx+'_'+nttSeq).show();
			$('#replyN'+idx+'_'+nttSeq).hide();
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
					<c:forEach begin="1" end="${resultList.listDepth -1}">
						<img src="/images/wzwg/module/ntt/icoReply.png" alt="<spring:message code="wzwg.cmm.word.answer02" />" class="reply01"/>
					</c:forEach>
				</c:if>

				<c:out value="${resultList.wrterNm}"/>
				<span class="gray"><c:out value="${resultList.frstRegistPnttm}"/></span>
				<c:choose>
					<c:when test="${resultList.listDepth ne '1'}">
						<c:set var="wrterNm" value="${resultList.wrterNm}" />
					</c:when>
					<c:otherwise>
						<c:set var="wrterNm" value="" />
					</c:otherwise>
				</c:choose>									
			</p>
			<p class="comm_cont">
				<div id="answerCnDiv<c:out value='${status.index}'/>_<c:out value='${resultList.nttSeq}'/>">
					<c:if test="${resultList.listDepth ne '1' and resultList.listDepth ne '2'}">
						<span style="font-weight:bold;color:#A6A6A6;"><c:out value="${resultList.parntsWrterNm}"/></span>
					</c:if>
					<c:out value='${fn:replace(resultList.answerCn, cn, "<br />")}' escapeXml="false" />
				</div>
				<div id="modifyAnswerCnDiv<c:out value='${status.index}'/>_<c:out value='${resultList.nttSeq}'/>" style="display:none;"></div>				
			</p>
			<ul>
				<c:set var="repAuthAt" value="" />
				<c:set var="modAuthAt" value="" />
				<c:set var="delAuthAt" value="" />					
				
				<c:if test="${loginVO.usrSeq eq resultList.wrterSeq or sessionScope.SADMIN_AT or sessionScope.NADMIN_AT}">
					<c:set var="repAuthAt" value="Y" />
					<c:set var="modAuthAt" value="Y" />
					<c:set var="delAuthAt" value="Y" />
				</c:if>	
				
				<c:if test="${repAuthAt eq 'Y'}">	
					<li id="replyY<c:out value='${status.index}'/>_<c:out value='${nttSeq}'/>">							
						<a href="javascript:void(0);" onclick="fnReplyQnaAnswer('<c:out value="${resultList.nttSeq}"/>', '<c:out value="${resultList.answerSeq}"/>', 'Y', '<c:out value="${status.index}"/>', '<c:out value="${wrterNm}"/>');">
							<img src="/images/wzwg/module/ntt/icoReply.png" alt="<spring:message code="wzwg.cmm.word.answer03" />" /><span><spring:message code="wzwg.cmm.word.answer03" /></span>
						</a>
					</li>
					<li id="replyN<c:out value='${status.index}'/>_<c:out value='${nttSeq}'/>" style="display:none;">
						<a href="javascript:void(0);" onclick="fnReplyQnaAnswer('<c:out value="${resultList.nttSeq}"/>', '<c:out value="${resultList.answerSeq}"/>', 'N', '<c:out value="${status.index}"/>', '<c:out value="${wrterNm}"/>');">
							<img src="/images/wzwg/module/ntt/icoReply.png" alt="<spring:message code="wzwg.module.word.answercancl" />" /><span style="color:#FF2424;"><spring:message code="wzwg.module.word.answercancl" /></span>
						</a>
					</li>
				</c:if>	
				<c:if test="${modAuthAt eq 'Y'}">
					<li id="modifyY<c:out value='${status.index}'/>_<c:out value='${nttSeq}'/>">	
						<a href="javascript:void(0);" onclick="fnModifyQnaAnswerFrm('<c:out value="${resultList.nttSeq}"/>', '<c:out value="${resultList.answerSeq}"/>', '<c:out value="${resultList.parntsAnswerSeq}"/>', '<c:out value="${status.index}"/>', 'Y');">
							<span><spring:message code="wzwg.cmm.word.updt" /></span>
						</a>
					</li>
					<li id="modifyN$<c:out value='{status.index}'/>_<c:out value='${nttSeq}'/>" style="display:none;">
						<a href="javascript:void(0);" onclick="fnModifyQnaAnswerFrm('<c:out value="${resultList.nttSeq}"/>', '<c:out value="${resultList.answerSeq}"/>', '<c:out value="${resultList.parntsAnswerSeq}"/>', '<c:out value="${status.index}"/>', 'N');">
							<span style="color:#FF2424;"><spring:message code="wzwg.module.word.updtcancl" /></span>
						</a>
					</li>
				</c:if>	
				<c:if test="${delAuthAt eq 'Y'}">	
					<li>					
						<a href="javascript:void(0);" onclick="fnDeleteQnaAnswer('<c:out value="${resultList.nttSeq}"/>', '<c:out value="${resultList.answerSeq}"/>');"><span><spring:message code="wzwg.cmm.word.delete" /></span></a>
					</li>
				</c:if>							
			</ul>
		</li>
		
		<!-- 댓글에 답글 입력 start -->
		<div id="replyAnswerDiv<c:out value='${status.index}'/>_<c:out value='${resultList.nttSeq}'/>"></div>
		<!-- 댓글에 답글 입력 end -->
		
	</c:forEach>
	
	
	