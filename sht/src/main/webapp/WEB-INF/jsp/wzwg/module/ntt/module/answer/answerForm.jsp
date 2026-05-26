<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>  

<script type="text/javascript">

	$(document).ready(function(){
		
		fnAnswerList('<c:out value="${nttAnswerVO.nttSeq}"/>');
		
		// 댓글 등록
		$("#module_div_<c:out value='${nttAnswerVO.nttSeq}'/> #regist_btn").click(function(){
			
			if($('#module_div_<c:out value="${nttAnswerVO.nttSeq}"/> #inputAnswer').val() == ''){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument><spring:message code="wzwg.cmm.word.cn" /></spring:argument></spring:message>');
				return;
			}
			
			$('#module_div_<c:out value="${nttAnswerVO.nttSeq}"/> #answerCn').val($('#module_div_<c:out value="${nttAnswerVO.nttSeq}"/> #inputAnswer').val()); 
				
			$.ajax({
				type:'POST'
				, dataType: 'xml'
				, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/answer/registNttAnswerAjax.do'
				, data:"nttSeq=<c:out value='${nttAnswerVO.nttSeq}'/>&answerCn="+$('#module_div_<c:out value="${nttAnswerVO.nttSeq}"/> #answerCn').val()
				, success:function (result) {
		    	  
					var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value != 'fail'){
						$("#module_inc_<c:out value='${nttAnswerVO.nttSeq}'/> #answer_cnt_txt").html(value);
						$('#module_div_<c:out value="${nttAnswerVO.nttSeq}"/> #inputAnswer').val('');
						fnAnswerList('<c:out value="${nttAnswerVO.nttSeq}"/>');
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
	 	$('#module_inc_<c:out value="${nttAnswerVO.nttSeq}"/> #answer_ctrl_btn').click(function(){
	 		
	 		if($('#answerCnt').val() == 0 && '<c:out value="${loginVO}"/>' =='' ){
	 			return;
	 		}
	 		
	 		$("#module_inc_<c:out value='${nttAnswerVO.nttSeq}'/>").each(function(){
				$('#module_inc_<c:out value="${nttAnswerVO.nttSeq}"/> .font_txt').css('color', '#333333');
			});
			
			$('#module_inc_<c:out value="${nttAnswerVO.nttSeq}"/> #answer_txt').css('color', '#FF0000');
			
	 		if($("#module_div_<c:out value='${nttAnswerVO.nttSeq}'/>").children('.answer').css('display') == 'none'){
				$('#module_div_<c:out value="${nttAnswerVO.nttSeq}"/>').each(function(){
					$(this).children().css('display', 'none');
				});	 			
	 			$("#module_div_<c:out value='${nttAnswerVO.nttSeq}'/>").children('.answer').css('display', 'block');
	 			$('#module_inc_<c:out value="${nttAnswerVO.nttSeq}"/> #answer_ctrl_btn').attr('title','<spring:message code="wzwg.module.word.answerinputwindowfold" />')
			}else{
				$("#module_div_<c:out value='${nttAnswerVO.nttSeq}'/>").children('.answer').css('display', 'none');
	 			$('#module_inc_<c:out value="${nttAnswerVO.nttSeq}"/> #answer_ctrl_btn').attr('title','<spring:message code="wzwg.module.word.answerinputwindowopen" />')
			} 
	 		
	 		$("#content").css("height",$(document).height());
		});
	 	
		// 내림차순
		$('#module_inc_<c:out value="${nttAnswerVO.nttSeq}"/> #answer_ordr_btn').click(function(){
			
			if($('#module_inc_<c:out value="${nttAnswerVO.nttSeq}"/> #answer_ordr_btn .ordr_desc').css('display') == 'none') {
				fnAnswerListOrdr('A', '<c:out value="${nttAnswerVO.nttSeq}"/>');
				$(this).find('.ordr_asc').css('display', 'none');
				$(this).find('.ordr_desc').css('display', 'inline');
				$(this).attr('title', '<spring:message code="wzwg.module.word.answerrgsdedescOrdr"/>');
			}else {
				fnAnswerListOrdr('D', '<c:out value="${nttAnswerVO.nttSeq}"/>');
				$(this).find('.ordr_desc').css('display', 'none');
				$(this).find('.ordr_asc').css('display', 'inline');
				$(this).attr('title', '<spring:message code="wzwg.module.word.answerrgsdeascOrdr"/>');
			}
			
			$("#module_div_<c:out value='${nttAnswerVO.nttSeq}'/>").each(function(){
				$(this).children().css('display', 'none');
			});
			
			$("#module_div_<c:out value='${nttAnswerVO.nttSeq}'/>").children('.answer').css('display', 'block');
			
		});
		
		/* // 오름차순
		$('#module_inc_<c:out value="${nttAnswerVO.nttSeq}"/> #ordr_asc').click(function(){
			fnAnswerListOrdr('D', '<c:out value="${nttAnswerVO.nttSeq}"/>');
			
			$(this).css('display', 'none');
			$('#ordr_desc').css('display', 'block').attr('title','<spring:message code="wzwg.cmm.word.answer02"/> <spring:message code="wzwg.cmm.word.rgsde"/> <spring:message code="wzwg.cmm.word.wa.descOrdr"/>').focus();
			
			$("#module_div_<c:out value='${nttAnswerVO.nttSeq}'/>").each(function(){
				$(this).children().css('display', 'none');
			});
			
			$("#module_div_<c:out value='${nttAnswerVO.nttSeq}'/>").children('.answer').css('display', 'block');
			
			//$("#content").css("height",$(document).height());
		}); */
	
	});
	
	// 댓글 목록
	function fnAnswerList(nttSeq){
		$.ajax({
	        type:'POST'
	        , dataType: 'html'
			, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/answer/selectNttAnswerListAjax.do'
			, data:"nttSeq="+nttSeq
			, success:function (data) {
				$('#module_div_'+nttSeq+' #answer_list_div').html(data);
			}
			, error:function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});	
	}
	
	// 댓글 목록 정렬
	function fnAnswerListOrdr(ordrSe, nttSeq){
		$.ajax({
	        type:'POST'
	        , dataType: 'html'
			, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/answer/selectNttAnswerListAjax.do'
			, data:"nttSeq="+nttSeq+"&ordrSe="+ordrSe
			, success:function (data) {
				$('#module_div_'+nttSeq+' #answer_list_div').html(data);
				
/* 				if(ordrSe == 'A'){
					$('#module_inc_'+nttSeq+' #answer_ordr_btn .ordr_desc').hide();
					$('#module_inc_'+nttSeq+' #answer_ordr_btn .ordr_asc').show();
					$('#module_inc_'+nttSeq+' #answer_ordr_btn').attr('title', '<spring:message code="wzwg.cmm.word.answer02"/> <spring:message code="wzwg.cmm.word.rgsde"/> <spring:message code="wzwg.cmm.word.wa.ascOrdr"/>');
				}
				
				if(ordrSe == 'D'){
					$('#module_inc_'+nttSeq+' #answer_ordr_btn .ordr_desc').show();
					$('#module_inc_'+nttSeq+' #answer_ordr_btn .ordr_asc').hide();
					$('#module_inc_'+nttSeq+' #answer_ordr_btn').attr('title', '<spring:message code="wzwg.cmm.word.answer02"/> <spring:message code="wzwg.cmm.word.rgsde"/> <spring:message code="wzwg.cmm.word.wa.descOrdr"/>');
				} */
				
			}
			, error:function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});	
		
	}
	
</script>
	
	<input type="hidden" id="answerCn" name="answerCn" />
	<input type="hidden" id="wrterNm" name="wrterNm" />
	
	<div id="answer_div">
	
		<!-- 댓글 목록 영역 -->
		<ul id="answer_list_div"></ul>
		
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
							<textarea title="<spring:message code="wzwg.module.word.answerinpcmpt" />" id="inputAnswer" placeholder="<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.answer02" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>" class="txtBox"></textarea>
						</td>
						<td><input class="txtBtn" type="button" value="<spring:message code="wzwg.cmm.word.regist" />"  id="regist_btn"></td>
					</tr>
				</tbody>
			</table>			
			</c:if>

		<!-- //write_re1 -->
		
	</div>
	
