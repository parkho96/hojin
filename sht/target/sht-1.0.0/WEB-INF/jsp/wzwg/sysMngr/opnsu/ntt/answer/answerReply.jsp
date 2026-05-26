<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
	
	<script type="text/javascript">
	
	$(document).ready(function(){
		
		// 댓글에 답글 등록
		$('#module_div_<c:out value="${nttAnswerVO.nttSeq}" /> #reply_regist_btn').click(function(){
			
			if($('#module_div_<c:out value="${nttAnswerVO.nttSeq}" /> #replyInputAnswer').val() == ''){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.answer02" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
				return;
			}
			
			$('#module_div_<c:out value="${nttAnswerVO.nttSeq}" /> #answerCn').val($('#module_div_<c:out value="${nttAnswerVO.nttSeq}" /> #replyInputAnswer').val()); 
			
			$.ajax({
		        type:'POST'
		        , dataType: 'xml'
				, url:'<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/answer/registNttAnswerAjax.do'
				, data:"nttSeq=<c:out value="${nttAnswerVO.nttSeq}" />&answerCn="+$('#module_div_<c:out value="${nttAnswerVO.nttSeq}" /> #answerCn').val()+"&parntsAnswerSeq="+$('#module_div_<c:out value="${nttAnswerVO.nttSeq}" /> #parntsAnswerSeq').val()
				, success:function (result) {
					var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value != 'fail'){
						$('#module_inc_<c:out value="${nttAnswerVO.nttSeq}" /> #answer_cnt_txt').text(value);
						$('#module_div_<c:out value="${nttAnswerVO.nttSeq}" /> #inputAnswer').val('');
						fnAnswerList('<c:out value="${nttAnswerVO.nttSeq}" />');
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
	
	<input type="hidden" id="parntsAnswerSeq" value="<c:out value="${nttAnswerVO.parntsAnswerSeq}" />" />
	
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
							<textarea id="replyInputAnswer" <c:if test="${!empty nttAnswerVO.parntsWrterNm}">placeholder="<c:out value="${nttAnswerVO.parntsWrterNm} ${msg_txt}" />"</c:if> class="txtBox"></textarea>
						</td>
						<td><input class="txtBtn" type="button" value="<spring:message code="wzwg.cmm.word.regist" />"  id="reply_regist_btn"></td>
					</tr>
				</tbody>
			</table>			
		</div>
	</li>
