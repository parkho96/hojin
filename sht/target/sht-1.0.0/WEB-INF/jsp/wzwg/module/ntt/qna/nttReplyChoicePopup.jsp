<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<link type="text/css" href="/css/wzwg/module/cmm/layer_popup.css" rel="stylesheet" />

<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("#cancle_btn").click(function (){
	    	$('body').css({overflow:'auto'});
	    	$("#qna_reply_layer").html("");
	   		$('#qna_reply_layer').hide();	
		});	
		
		// 답변채택
		$("#choice_btn").click(function (){
			
			if($('#qestnUsrCm').val() == ''){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.module.word.interrgretcn" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
				$('#qestnUsrCm').focus();
				return;
			}
			
			if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006"><spring:argument><spring:message code="wzwg.cmm.word.answer01" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.choice" /></spring:argument></spring:message>')){
				return;
			}else{
				$.ajax({
			        type:'POST'
					, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/qna/registNttReplyChoiceAjax.do'
					, cache : false
					, data:$("#choiceFrm").serialize()
					, success:function (result) {
						var value = "";
						
						$(result).find("value").each(function() {  
							value = $(this).text();  
						});
						
						if(value == 'success'){
							
							$.ajax({
						        type : 'POST'
								, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/qna/selectNttDetailAjax.do'
								, dataType : 'html'
								, data : "siteSeq="+$('#siteSeq').val()+"&nttSeq="+$('#parntsNttSeq').val()+"&bbsSeq="+$('#bbsSeq').val()
								, success : function (data) {
									$('#bbs_area').html(data);
								}
								, error : function (request, status, error) {
									alert('<spring:message code="fail.common.msg" text="error" />');
								}
							});
							
							$("#cancle_btn").click();
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
						}
			    	  
						//$("#close_btn").click();
					}
					, error:function (data) {
					    alert('<spring:message code="fail.common.msg" text="error" />');
					}
					, dataType: 'xml'
			 	});
			}
			
		});
	});
		
	function fnLayerPopupClose(){
		$("#cancle_btn").click();	
	}
	
</script>

				<form:form modelAttribute="paramVO" name="choiceFrm" id="choiceFrm" method="post">
					<form:hidden path="siteSeq" />
					<form:hidden path="bbsSeq" />
					<form:hidden path="nttSeq" />
					<form:hidden path="parntsNttSeq" />
					
					<div id="board-detail-006" class="board-detail-006">
						<div class="subject">
							<table style="width:100%;">
								<colgroup>
									<col width="15%"/>
									<col width="*"/>
								</colgroup>
								<tbody>
									<tr>
										<th scope="row" class="subTit"><spring:message code="wzwg.module.word.interrgret" /></th>
										<td>
											<textarea id="qestnUsrCm" name="qestnUsrCm" rows="10" style="width:100%;" maxlength="200"></textarea>
										</td>
									</tr>
								</tbody>
							</table>	
						</div>
					</div>		
						
				</form:form>
		
		<div class="rt-box txt-c">
			<a href="javascript:void(0);" id="choice_btn" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
			<a href="javascript:void(0);" id="cancle_btn" class="wzbtn btn-basic pop-close"><spring:message code="wzwg.cmm.word.cancl" /></a>
		</div>
			
