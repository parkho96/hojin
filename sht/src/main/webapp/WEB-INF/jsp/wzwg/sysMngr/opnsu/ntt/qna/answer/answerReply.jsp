<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<c:set var="nttSeq" value="${nttAnswerVO.nttSeq}" />

<script>
	
	$(document).ready(function(){
		
		// 댓글에 답글 등록
		$('.reply_regist_btn_<c:out value="${nttSeq}" />').click(function(){
			
			var paramVal = $(this).attr('value');
			
			if($('#replyInputAnswer_'+paramVal).val() == ''){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.answer02" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
				return;
			}
			
			$('#answerCn').val($('#replyInputAnswer_'+paramVal).val()); 
			
			$.ajax({
		        type:'POST'
		        , dataType: 'xml'
				, url:'<c:out value="${wzwg_contextPath}${prefix}" />/module/ntt/qna/answer/registNttQnaAnswerAjax.do'
				, data:"nttSeq="+paramVal+"&answerCn="+$('#answerCn').val()+"&parntsAnswerSeq="+$('#parntsAnswerSeq_'+paramVal).val()
				, success:function (result) {
					var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value != 'fail'){
						$('#answer_cnt_txt_'+paramVal).text(value);
						$('#inputAnswer_'+paramVal).val('');
						fnQnaAnswerList(paramVal);
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
					}
				}
				, error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
			});
			
		});
		
	});
		
</script>
	
	<input type="hidden" id="parntsAnswerSeq_<c:out value="${nttSeq}" />" value="<c:out value="${nttAnswerVO.parntsAnswerSeq}" />" />
	
	<li>
		<div class="mg_b10 reply_write_form">
			<table>
				<colgroup>
					<col width="80%"/>
					<col width="10%"/>
				</colgroup>
				<thead>
					<tr>
						<td colspan="2"><spring:message code="wzwg.sysMngr.word.answr02Input" /></td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<c:set var="msg_txt"><spring:message code="wzwg.cmm.msg.MSG302" /></c:set>
							<textarea id="replyInputAnswer_<c:out value="${nttSeq}" />" <c:if test="${!empty nttAnswerVO.parntsWrterNm}">placeholder="<c:out value="${nttAnswerVO.parntsWrterNm} ${msg_txt}" />"</c:if> class="txtBox"></textarea>
						</td>
						<td>
							<a href="javascript:void(0);" class="reply_regist_btn_<c:out value="${nttSeq}" />" value="<c:out value="${nttSeq}" />">
							<input class="txtBtn" type="button" value="<spring:message code="wzwg.cmm.word.regist" />">
							</a>
						</td>
					</tr>
				</tbody>
			</table>			
		</div>
	</li>	
	
