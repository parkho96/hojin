<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<% pageContext.setAttribute("cn", "\n"); %>

<c:set var="simpnttSeq" value="${nttSimpAnswerVO.simpnttSeq}" />

<script type="text/javascript">
	
	/** 댓글 수정 폼 */
	function fnModifyAnswerFrm(simpnttSeq, answerSeq, parntsAnswerSeq, idx, val, replySe){
		
		var answerCn = $('#answerCn_'+simpnttSeq+"_"+answerSeq).val();
		if(val == 'Y'){
			
			for(var i = 0; i < '${fn:length(resultList)}'; i++){
				$('#answerCnDiv'+i+'_'+simpnttSeq).show();
				$('#modifyAnswerCnDiv'+i+'_'+simpnttSeq).hide();
				$('#modifyAnswerY'+i+'_'+simpnttSeq).show();
				$('#modifyAnswerN'+i+'_'+simpnttSeq).hide();					
				if($('#replyAnswerDiv'+i+'_'+simpnttSeq).show()){
					$('#replyAnswerDiv'+i+'_'+simpnttSeq).hide();
					$('#replyY'+i+'_'+simpnttSeq).show();
					$('#replyN'+i+'_'+simpnttSeq).hide();
				}
			}			
			
			$('#answerCnDiv'+idx+'_'+simpnttSeq).hide();
			$('#modifyAnswerCnDiv'+idx+'_'+simpnttSeq).show();
			$('#modifyAnswerY'+idx+'_'+simpnttSeq).hide();
			$('#modifyAnswerN'+idx+'_'+simpnttSeq).show();
			
			var innerTag = "";
			innerTag += '<table><colgroup><col width="80%"/><col width="10%"/></colgroup><tbody>';
			innerTag += '<tr><td class="comn_tit" colspan="2"><spring:message code="wzwg.module.word.answerupdt" /></td></tr>';
			innerTag += '<tr><td><textarea title="<spring:message code="wzwg.module.word.answerinpcmpt" />" id="modifyInputAnswer_'+simpnttSeq+'" class="txtBox">'+answerCn+'</textarea></td>';
			innerTag += '<td><input class="txtBtn" type="button" value="<spring:message code="wzwg.cmm.word.updt" />" onclick="fnModifyAnswer('+simpnttSeq+', '+answerSeq+');"></td></tr></tbody></table>';			

			$('#modifyAnswerCnDiv'+idx+'_'+simpnttSeq).text("");
			$('#modifyAnswerCnDiv'+idx+'_'+simpnttSeq).append(innerTag);
		}else{
			
			$('#modifyAnswerCnDiv'+idx+'_'+simpnttSeq).text("");
			
			$('#answerCnDiv'+idx+'_'+simpnttSeq).show();
			$('#modifyAnswerCnDiv'+idx+'_'+simpnttSeq).hide();
			$('#modifyAnswerY'+idx+'_'+simpnttSeq).show();
			$('#modifyAnswerN'+idx+'_'+simpnttSeq).hide();
		}
	}
	
	/** 댓글 수정 */
	function fnModifyAnswer(simpnttSeq, answerSeq){

		if($('#modifyInputAnswer_'+simpnttSeq).val() == ''){
			alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.answer02" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
			return;
		}
		
		$('#answerCn').val($('#modifyInputAnswer_'+simpnttSeq).val()); 
			
		$.ajax({
	        type:'POST'
	        , dataType: 'xml'
			, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/simp/answer/modifyNttSimpAnswerAjax.do'
			, data:"simpnttSeq="+simpnttSeq+"&answerSeq="+answerSeq+"&answerCn="+$('#answerCn').val()
			, success:function (result) {
				var value = "";
				
				$(result).find("value").each(function() {  
					value = $(this).text();  
				});
				
				if(value == 'success'){
					$('#modifyInputAnswer_'+simpnttSeq).val('');
					fnAnswerList(simpnttSeq);
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
	function fnDeleteAnswer(simpnttSeq, answerSeq){
		
		if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
			return;
		}

		$.ajax({
			type:'POST'
			, dataType: 'xml'
			, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/simp/answer/deleteNttSimpAnswerAjax.do'
			, data:"simpnttSeq="+simpnttSeq+"&answerSeq="+answerSeq
			, success:function (result) {
				var value = "";
				
				$(result).find("value").each(function() {  
					value = $(this).text();  
				});
				
				if(value != 'fail'){
					$('#answer_cnt_txt_'+simpnttSeq).text(value);
					fnAnswerList(simpnttSeq);
				}else{
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
				}
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	}); 
	}

	function fnReplyAnswer(simpnttSeq, answerSeq, val, idx, parntsWrterNm){
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/simp/answer/selectNttSimpAnswerReplyFormAjax.do'
	      , cache : false
	      , async : false
	      , data:"simpnttSeq="+simpnttSeq+"&parntsAnswerSeq="+answerSeq+"&parntsWrterNm="+parntsWrterNm
	      , success:function (data) {
	    	  $('#replyAnswerDiv'+idx+'_'+simpnttSeq).html(data);
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
		
		if(val == 'Y'){
			
			for(var i = 0; i < '${fn:length(resultList)}'; i++){
				$('#answerCnDiv'+i+'_'+simpnttSeq).show();
				$('#modifyAnswerCnDiv'+i+'_'+simpnttSeq).hide();
				$('#modifyAnswerY'+i+'_'+simpnttSeq).show();
				$('#modifyAnswerN'+i+'_'+simpnttSeq).hide();					
				if($('#replyAnswerDiv'+i+'_'+simpnttSeq).show()){
					$('#replyAnswerDiv'+i+'_'+simpnttSeq).hide();
					$('#replyY'+i+'_'+simpnttSeq).show();
					$('#replyN'+i+'_'+simpnttSeq).hide();
				}
			}		
			
			$('#replyAnswerDiv'+idx+'_'+simpnttSeq).show();
			$('#replyY'+idx+'_'+simpnttSeq).hide();
			$('#replyN'+idx+'_'+simpnttSeq).show();
		}else{
			$('#replyAnswerDiv'+idx+'_'+simpnttSeq).hide();
			$('#replyY'+idx+'_'+simpnttSeq).show();
			$('#replyN'+idx+'_'+simpnttSeq).hide();
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
		
			<input type="hidden" id="answerCn_<c:out value='${resultList.simpnttSeq}'/>_<c:out value='${resultList.answerSeq}'/>" value="<c:out value='${resultList.answerCn}'/>"/>

			<p class="com_cont">
			
			<c:if test="${resultList.listDepth ne '1'}">
				<img src="/images/wzwg/module/ntt/icoReply.png" alt="<spring:message code="wzwg.cmm.word.answer02" />"/>
			</c:if>				
			
			<c:out value="${resultList.wrterNm}"/>
			<span class="gray"><c:out value="${resultList.frstRegistPnttm}"/></span>
			</p>
			<p class="comm_cont">
				<div id="answerCnDiv<c:out value='${status.index}'/>_<c:out value='${resultList.simpnttSeq}'/>">
					<c:if test="${resultList.listDepth ne '1' and resultList.listDepth ne '2'}">
						<span style="font-weight:bold;color:#A6A6A6;"><c:out value="${resultList.parntsWrterNm}"/></span>
					</c:if>
					<c:out value='${fn:replace(resultList.answerCn, cn, "<br />")}' escapeXml="false" />
				</div>
				<div id="modifyAnswerCnDiv<c:out value='${status.index}'/>_<c:out value='${resultList.simpnttSeq}'/>" style="display:none;"></div>				
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
					<li id="replyY<c:out value='${status.index}'/>_<c:out value='${simpnttSeq}'/>" >
						<a href="javascript:void(0);" onclick="fnReplyAnswer('<c:out value="${resultList.simpnttSeq}"/>', '<c:out value="${resultList.answerSeq}"/>', 'Y', '<c:out value="${status.index}"/>', '<c:out value="${resultList.wrterNm}"/>');">
							<img src="/images/wzwg/module/ntt/icoReply.png" alt="<spring:message code="wzwg.cmm.word.answer03" />" /><span><spring:message code="wzwg.cmm.word.answer03" /></span>
						</a>
					</li>
					<li id="replyN<c:out value='${status.index}'/>_<c:out value='${simpnttSeq}'/>" style="display:none;">
						<a href="javascript:void(0);" onclick="fnReplyAnswer('<c:out value="${resultList.simpnttSeq}"/>', '<c:out value="${resultList.answerSeq}"/>', 'N', '<c:out value="${status.index}"/>', '<c:out value="${resultList.wrterNm}"/>');">
							<img src="/images/wzwg/module/ntt/icoReply.png" alt="<spring:message code="wzwg.cmm.word.answer03" /> <spring:message code="wzwg.cmm.word.cancl" />" /><span style="color:#FF2424;"><spring:message code="wzwg.module.word.answercancl" /></span>
						</a>
					</li>	
				</c:if>
				<c:if test="${modAuthAt eq 'Y'}">
					<li id="modifyAnswerY<c:out value='${status.index}'/>_<c:out value='${simpnttSeq}'/>">
						<a href="javascript:void(0);" onclick="fnModifyAnswerFrm('<c:out value="${resultList.simpnttSeq}"/>', '<c:out value="${resultList.answerSeq}"/>', '<c:out value="${resultList.parntsAnswerSeq}"/>', '<c:out value="${status.index}"/>', 'Y');">
							<span><spring:message code="wzwg.cmm.word.updt" /></span>
						</a>
					</li>
					<li id="modifyAnswerN<c:out value='${status.index}'/>_<c:out value='${simpnttSeq}'/>" style="display:none;">
						<a href="javascript:void(0);" onclick="fnModifyAnswerFrm('<c:out value="${resultList.simpnttSeq}"/>', '<c:out value="${resultList.answerSeq}"/>', '<c:out value="${resultList.parntsAnswerSeq}"/>', '<c:out value="${status.index}"/>', 'N');">
							<span style="color:#FF2424;"><spring:message code="wzwg.module.word.updtcancl" /></span>
						</a>
					</li>
				</c:if>
				<c:if test="${delAuthAt eq 'Y'}">					
					<li>
						<a href="javascript:void(0);" onclick="fnDeleteAnswer('<c:out value="${resultList.simpnttSeq}"/>', '<c:out value="${resultList.answerSeq}"/>');">
							<span><spring:message code="wzwg.cmm.word.delete" /></span>
						</a>
					</li>
				</c:if>											
			</ul>

		</li>
		
		<!-- 댓글에 답글 입력 start -->
		<div id="replyAnswerDiv<c:out value='${status.index}'/>_<c:out value='${resultList.simpnttSeq}'/>"></div>
		<!-- 댓글에 답글 입력 end -->		

	</c:forEach>

	
	
	