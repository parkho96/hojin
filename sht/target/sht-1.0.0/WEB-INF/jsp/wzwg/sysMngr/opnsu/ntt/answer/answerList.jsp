<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<% pageContext.setAttribute("cn", "\n"); %>

<script type="text/javascript">
	
	/** 댓글 수정 폼 */
	function fnModifyAnswerFrm(nttSeq, answerSeq, parntsAnswerSeq, idx, val, replySe){
		var answerCn = $('#answerCn_'+nttSeq+"_"+answerSeq).val();
		if(val == 'Y'){
			
			for(var i = 0; i < '<c:out value="${fn:length(resultList)}" />'; i++){
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
			innerTag += '<table><colgroup><col width="80%"/><col width="10%"/></colgroup><thead><tr><td colspan="2"><spring:message code="wzwg.sysMngr.word.answr02Updt" /></td></tr></thead><tbody>';
			innerTag += '<tr><td><textarea id="modifyInputAnswer" class="txtBox">'+answerCn+'</textarea></td>';
			innerTag += '<td><input class="txtBtn" type="button" value="<spring:message code="wzwg.cmm.word.updt" />" onclick="fnModifyAnswer('+nttSeq+', '+answerSeq+');"></td></tr></tbody></table>';

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
			, url:'<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/answer/modifyNttAnswerAjax.do'
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
			, url:'<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/answer/deleteNttAnswerAjax.do'
			, data:"nttSeq="+nttSeq+"&answerSeq="+answerSeq
			, success:function (result) {
				var value = "";
				
				$(result).find("value").each(function() {  
					value = $(this).text();  
				});
				
				if(value != 'fail'){
					$('#module_id_'+nttSeq+' > #module_inc #answer_cnt_txt').text(value);
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
	      , url:'<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/answer/selectNttAnswerReplyFormAjax.do'
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
		
			for(var i = 0; i < '<c:out value="${fn:length(resultList)}" />'; i++){
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
	
		<li>
		
				<input type="hidden" id="answerCn_<c:out value="${resultList.nttSeq}_${resultList.answerSeq}" />" value="<c:out value="${resultList.answerCn}" />"/>
		
				<p class="com_cont">
		
				<c:if test="${resultList.listDepth ne '1'}">
					<img src="/images/wzwg/module/ntt/icoReply.png" alt="<spring:message code="wzwg.cmm.word.answer02" />"/>					
				</c:if>

				<a style="cursor:text;"><c:out value="${resultList.wrterNm}" /></a>
				<span class="gray"><c:out value="${resultList.frstRegistPnttm}" /></span>
				
				</p>
				
				<c:choose>
					<c:when test="${resultList.listDepth ne '1'}">
						<c:set var="wrterNm" value="${resultList.wrterNm}" />
					</c:when>
					<c:otherwise>
						<c:set var="wrterNm" value="" />
					</c:otherwise>
				</c:choose>	
				
				<p class="comm_cont">
					<div id="answerCnDiv<c:out value="${status.index}" />">
						<c:if test="${resultList.listDepth ne '1' and resultList.listDepth ne '2'}">
							<span><c:out value="${resultList.parntsWrterNm}" /></span>
						</c:if>
						<c:out value='${fn:replace(resultList.answerCn, cn, "<br />")}' escapeXml="false" />
					</div>
					<div id="modifyAnswerCnDiv<c:out value="${status.index}" />" style="display:none;"></div>				
				</p>
				
				<c:set var="repAuthAt" value="" />
				<c:set var="modAuthAt" value="" />
				<c:set var="delAuthAt" value="" />				
				
				<c:choose>
					<c:when test="${sessionScope.SYSMNGR_AT eq 'Y'}">
						<c:if test="${loginVO.usrSeq eq resultList.wrterSeq or sessionScope.SADMIN_AT or sessionScope.NADMIN_AT}">
							<c:set var="repAuthAt" value="Y" />
							<c:set var="modAuthAt" value="Y" />
							<c:set var="delAuthAt" value="Y" />
						</c:if>	
					</c:when>
					<c:otherwise>
						<c:if test="${loginVO.usrSeq eq resultList.wrterSeq or sessionScope.SADMIN_AT}">
							<c:set var="repAuthAt" value="Y" />
							<c:set var="modAuthAt" value="Y" />
							<c:set var="delAuthAt" value="Y" />
						</c:if>	
					</c:otherwise>
				</c:choose>
				
				<ul>
			 
				<c:if test="${modAuthAt eq 'Y'}">
					<li id="modifyY<c:out value="${status.index}" />">
					<a href="javascript:void(0);" onclick="fnModifyAnswerFrm('<c:out value="${resultList.nttSeq}" />', '<c:out value="${resultList.answerSeq}" />', '<c:out value="${resultList.parntsAnswerSeq}" />', '<c:out value="${status.index}" />', 'Y');">
						<spring:message code="wzwg.cmm.word.updt" />
					</a>
					</li>
					<li id="modifyN<c:out value="${status.index}" />" style="display:none;">
					<a href="javascript:void(0);" onclick="fnModifyAnswerFrm('<c:out value="${resultList.nttSeq}" />', '<c:out value="${resultList.answerSeq}" />', '<c:out value="${resultList.parntsAnswerSeq}" />', '<c:out value="${status.index}" />', 'N');">
						<spring:message code="wzwg.sysMngr.word.updtCancl" />
					</a>
					</li>
				</c:if>
				
				<c:if test="${delAuthAt eq 'Y'}">
					<li>
					<a href="javascript:void(0);" onclick="fnDeleteAnswer('<c:out value="${resultList.nttSeq}" />', '<c:out value="${resultList.answerSeq}" />');"><spring:message code="wzwg.cmm.word.delete" /></a>
					</li>
				</c:if>					
				
				</ul>
				
		</li>	
		 
		
		<!-- 댓글에 답글 입력 start -->
		<div id="replyAnswerDiv<c:out value="${status.index}" />"></div>
		<!-- 댓글에 답글 입력 end -->
		
	</c:forEach>
	