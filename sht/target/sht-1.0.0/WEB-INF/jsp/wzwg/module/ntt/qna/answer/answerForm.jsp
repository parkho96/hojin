<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>   

<c:set var="nttSeq" value="${nttAnswerVO.nttSeq}" />

<script script="text/javascript">

	$(document).ready(function(){
	
		fnQnaAnswerList('');
	
		// 댓글 등록
		$(".regist_btn_<c:out value='${nttSeq}'/>").click(function(){
			
			var paramVal = $(this).attr('value');
			
			if($('#inputAnswer_'+paramVal).val() == ''){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument><spring:message code="wzwg.cmm.word.cn" /></spring:argument></spring:message>');
				return;
			}
			
			$('#answerCn').val($('#inputAnswer_'+paramVal).val()); 
				
			$.ajax({
				type:'POST'
				, dataType: 'xml'
				, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/qna/answer/registNttQnaAnswerAjax.do'
				, data:"nttSeq="+paramVal+"&answerCn="+$('#answerCn').val()
				, success:function (result) {
		    	  
					var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value != 'fail'){
						$("#answer_cnt_txt_"+paramVal).text(value);
						$('#inputAnswer_'+paramVal).val('');
						fnQnaAnswerList(paramVal);
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
					}
					$("#content").css("height",$(document).height());
				}
				, error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
			});
			
		});
		
		$('#answer_ctrl_btn_<c:out value="${nttSeq}"/>').click(function(){
			if($('#answer_div_<c:out value="${nttSeq}"/>').css('display') == 'none'){
				$('#answer_div_<c:out value="${nttSeq}"/>').show();	
			}else{
				$('#answer_div_<c:out value="${nttSeq}"/>').hide();				
			}
			$("#content").css("height",$(document).height());
		});
		
		$('#qna_answer_ordr_btn_<c:out value="${nttSeq}"/>').click(function(){
			if($('#answer_div_<c:out value="${nttSeq}"/>').css('display') == 'none'){
				$('#answer_div_<c:out value="${nttSeq}"/>').show();	
				$("#content").css("height",$(document).height());
			}
		});
			
		// 내림차순
		$('.ordr_desc_<c:out value="${nttSeq}"/>').click(function(){
			fnQnaAnswerListOrdr('<c:out value="${nttSeq}"/>', 'A');
		});
		
		// 오름차순
		$('.ordr_asc_<c:out value="${nttSeq}"/>').click(function(){
			fnQnaAnswerListOrdr('<c:out value="${nttSeq}"/>', 'D');
		});
	});
	
	// 댓글 목록
	function fnQnaAnswerList(paramVal){
		
		if(paramVal == ''){
			paramVal = '<c:out value="${nttSeq}"/>';
		}
		
		$.ajax({
	        type:'POST'
	        , dataType: 'html'
			, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/qna/answer/selectNttQnaAnswerListAjax.do'
			, data:"nttSeq="+paramVal
			, success:function (data) {
				$('#answer_list_div_'+paramVal).html(data);
				$("#content").css("height",$(document).height());
			}
			, error:function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});	
		
	}

	// 댓글 목록 정렬
	function fnQnaAnswerListOrdr(paramVal, ordrSe){
		
		$.ajax({
	        type:'POST'
	        , dataType: 'html'
			, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/qna/answer/selectNttQnaAnswerListAjax.do'
			, data:"nttSeq="+paramVal+"&ordrSe="+ordrSe
			, success:function (data) {
				$('#answer_list_div_'+paramVal).html(data);
				
				if(ordrSe == 'A'){
					$('.ordr_desc_'+paramVal).hide();
					$('.ordr_asc_'+paramVal).show();
				}
				
				if(ordrSe == 'D'){
					$('.ordr_desc_'+paramVal).show();
					$('.ordr_asc_'+paramVal).hide();
				}
				
			}
			, error:function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});	
		
	}

</script>


	<input type="hidden" id="answerCn" />
	
	
	<div id="answer_div_<c:out value='${nttSeq}'/>" style="display:none;" class="conBottom">
				
		<div id="module_div">
		
			<div class="answer cmtbg">		
		
				<!-- 댓글 목록 영역 -->
				<ul id="answer_list_div_<c:out value='${nttSeq}'/>"></ul>
				
				<!-- 댓글 입력 영역 -->
				<c:set var="regAuthAt" value="" />
				
				<c:if test="${nttAuthVO.authorSe eq 'W' or sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or sessionScope.CNTNTS_ADMIN_AT}">
					<c:set var="regAuthAt" value="Y" />
				</c:if>
				
				<c:if test="${regAuthAt eq 'Y'}">
					<table>
						<colgroup>
							<col width="80%"/>
							<col width="10%"/>
						</colgroup>
						<tbody>
							<tr>
								<td class="comn_tit" colspan="2"><spring:message code="wzwg.module.word.answerwrt" /></td>
							</tr>
							<tr>
								<td>
									<textarea title="<spring:message code="wzwg.module.word.answerinpcmpt" />" id="inputAnswer_<c:out value="${nttSeq}"/>" placeholder="<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.answer02" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>" class="txtBox"></textarea>
								</td>
								<td>
									<a href="javascript:void(0);" class="regist_btn_<c:out value='${nttSeq}'/>" value="<c:out value='${nttSeq}'/>">
									<input class="txtBtn" type="button" value="<spring:message code="wzwg.cmm.word.regist" />">
									</a>
								</td>
							</tr>
						</tbody>
					</table>			
				</c:if>
				<!-- //write_re1 -->
			</div>
			
		</div>
		
	</div>
