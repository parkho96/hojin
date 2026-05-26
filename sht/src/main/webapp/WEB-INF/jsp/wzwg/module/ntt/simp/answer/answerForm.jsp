<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>   

<c:set var="simpnttSeq" value="${nttSimpAnswerVO.simpnttSeq}" />

<script type="text/javascript">

	$(document).ready(function(){
		
		fnAnswerList("<c:out value='${simpnttSeq}'/>");
		
		// 댓글 등록
		$(".regist_btn_<c:out value='${simpnttSeq}'/>").click(function(){
			
			var paramVal = $(this).attr('value');
			
			if($('#inputAnswer_'+paramVal).val() == ''){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument><spring:message code="wzwg.cmm.word.cn" /></spring:argument></spring:message>');
				return;
			}
			
			$('#answerCn').val($('#inputAnswer_'+paramVal) .val()); 
				
			$.ajax({
				type:'POST'
				, dataType: 'xml'
				, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/simp/answer/registNttSimpAnswerAjax.do'
				, data:"simpnttSeq="+paramVal+"&answerCn="+$('#answerCn').val()
				, success:function (result) {
		    	  
					var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value != 'fail'){
						$("#answer_cnt_txt_"+paramVal).text(value);
						$('#inputAnswer_'+paramVal).val('');
						fnAnswerList(paramVal);
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
					}
		    	  
				}
				, error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
			});
			
		});
		
		// 댓글
	 	$('#module_inc_<c:out value="${simpnttSeq}"/> #answer_ctrl_btn').click(function(){
	 		
	 		$("#module_inc_<c:out value='${simpnttSeq}'/>").each(function(){
				$('#module_inc_<c:out value="${simpnttSeq}"/> .font_txt').css('color', '#333333');
			});
			
			$('#module_inc_<c:out value="${simpnttSeq}"/> #answer_txt').css('color', '#FF0000');
			
	 		if($("#module_div_<c:out value='${simpnttSeq}'/>").children('.answer').css('display') == 'none'){
				$('#module_div_<c:out value="${simpnttSeq}"/>').each(function(){
					$(this).children().css('display', 'none');
				});	 			
	 			$("#module_div_<c:out value='${simpnttSeq}'/>").children('.answer').css('display', 'block');
	 			$('#module_inc_<c:out value="${simpnttSeq}"/> #answer_ctrl_btn').attr('title','<spring:message code="wzwg.module.word.answerinputwindowfold" />')
			}else{
				$("#module_div_<c:out value='${simpnttSeq}'/>").children('.answer').css('display', 'none');
				$('#module_inc_<c:out value="${simpnttSeq}"/> #answer_ctrl_btn').attr('title','<spring:message code="wzwg.module.word.answerinputwindowopen" />')
			} 
	 		
	 		$("#content").css("height",$(document).height());
		});		
		/*
		$('#answer_ctrl_btn_<c:out value="${simpnttSeq}"/>').click(function(){
			if($('#answer_div_<c:out value="${simpnttSeq}"/>').css('display') == 'none'){
				$('#answer_div_<c:out value="${simpnttSeq}"/>').show();	
			}else{
				$('#answer_div_<c:out value="${simpnttSeq}"/>').hide();				
			}
		});
		*/
		
	 	// 등록순
		$('#module_inc_<c:out value="${simpnttSeq}"/> #answer_ordr_btn').click(function(){
	 		
			if($('#module_inc_<c:out value="${simpnttSeq}"/> #answer_ordr_btn .ordr_desc').css('display') == 'none') {
				fnAnswerListOrdr('A', '<c:out value="${simpnttSeq}"/>');
				$(this).find('.ordr_asc').css('display', 'none');
				$(this).find('.ordr_desc').css('display', 'inline');
				$(this).attr('title', '<spring:message code="wzwg.cmm.word.answerrgsdedescOrdr"/>');
			}else {
				fnAnswerListOrdr('D', '<c:out value="${simpnttSeq}"/>');
				$(this).find('.ordr_desc').css('display', 'none');
				$(this).find('.ordr_asc').css('display', 'inline');
				$(this).attr('title', '<spring:message code="wzwg.cmm.word.answerrgsdeascOrdr"/>');
			}
			
			$("#module_div_<c:out value='${simpnttSeq}'/>").each(function(){
				$(this).children().css('display', 'none');
			});
			
			$("#module_div_<c:out value='${simpnttSeq}'/>").children('.answer').css('display', 'block');
			
		});
	 	
		// 내림차순
/* 		$('#module_inc_<c:out value="${simpnttSeq}"/> #answer_ordr_btn .ordr_desc').click(function(){
			fnAnswerListOrdr('A', '<c:out value="${simpnttSeq}"/>');

			$("#module_div_<c:out value='${simpnttSeq}'/>").each(function(){
				$(this).children().css('display', 'none');
			});
			
			$("#module_div_<c:out value='${simpnttSeq}'/>").children('.answer').css('display', 'block');
			
			$("#content").css("height",$(document).height());
		});
		
		// 오름차순
		$('#module_inc_<c:out value="${simpnttSeq}"/> #answer_ordr_btn .ordr_asc').click(function(){
			fnAnswerListOrdr('D', '<c:out value="${simpnttSeq}"/>');
			
			$("#module_div_<c:out value='${simpnttSeq}'/>").each(function(){
				$(this).children().css('display', 'none');
			});
			
			$("#module_div_<c:out value='${simpnttSeq}'/>").children('.answer').css('display', 'block');
			
			$("#content").css("height",$(document).height());
		});	 */	
	});
	
	// 댓글 목록
	function fnAnswerList(paramVal){
		
		if(paramVal == ''){
			paramVal = '<c:out value="${simpnttSeq}"/>';
		}
		
		$.ajax({
	        type:'POST'
	        , dataType: 'html'
			, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/simp/answer/selectNttSimpAnswerListAjax.do'
			, data:"simpnttSeq="+paramVal
			, success:function (data) {
				$('#answer_list_div_'+paramVal).html(data);
			}
			, error:function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});	
		
	}
	
	// 댓글 목록 정렬
	function fnAnswerListOrdr(ordrSe, simpnttSeq){
		$.ajax({
	        type:'POST'
	        , dataType: 'html'
	        , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/simp/answer/selectNttSimpAnswerListAjax.do'
			, data:"simpnttSeq="+simpnttSeq+"&ordrSe="+ordrSe
			, success:function (data) {
				$('#module_div_'+simpnttSeq+' #answer_list_div_'+simpnttSeq).html(data);
				
				/* if(ordrSe == 'A'){
					$('#module_inc_'+simpnttSeq+' #answer_ordr_btn .ordr_desc').hide();
					$('#module_inc_'+simpnttSeq+' #answer_ordr_btn .ordr_asc').show();
				}
				
				if(ordrSe == 'D'){
					$('#module_inc_'+simpnttSeq+' #answer_ordr_btn .ordr_desc').show();
					$('#module_inc_'+simpnttSeq+' #answer_ordr_btn .ordr_asc').hide();
				} */
				
			}
			, error:function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});	
		
	}	

</script>
	
	<input type="hidden" id="answerCn" />
	
	
	<div id="module_div_<c:out value='${simpnttSeq}'/>">

		<div class="answer cmtbg" style="display:none;">		
	
			<div id="answer_div">

				<!-- 댓글 목록 영역 -->
				<ul id="answer_list_div_<c:out value='${simpnttSeq}'/>"></ul>
				
				<!-- 댓글 입력 영역 -->
				<c:set var="regAuthAt" value="" />
				
				<%-- <c:if test="${nttAuthVO.authorSe eq 'W' or sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or sessionScope.CNTNTS_ADMIN_AT}">
				<c:set var="regAuthAt" value="Y" />
				</c:if> --%>
				<c:if test="${not empty loginVO.userId}">
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
								<textarea title="<spring:message code="wzwg.module.word.answerinpcmpt" />" id="inputAnswer_${fn:escapeXml(simpnttSeq)}" placeholder="<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.answer02" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>" class="txtBox"></textarea>
							</td>
							<td>
								<a href="javascript:void(0);" class="regist_btn_<c:out value='${simpnttSeq}'/>" value="<c:out value='${simpnttSeq}'/>">
									<input class="txtBtn" type="button" value="<spring:message code="wzwg.cmm.word.regist" />">
								</a>
							</td>
						</tr>
					</tbody>
				</table>
				</c:if>
				
			</div>
			
		</div>			

	</div>
