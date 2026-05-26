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
		
		$("#close_btn").click(function (){
	    	$('body').css({overflow:'auto'});
	    	$("#qna_reply_layer").html("");
	   		$('#qna_reply_layer').hide();	
		});	
		
		// 답변채택
		$("#choice_btn").click(function (){
			
			if($('#qestnUsrCm').val() == ''){
				alert('<spring:message code="wzwg.cmm.msg.MSG173" />');
				return;
			}
			
			if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006">'+
							'<spring:argument><spring:message code="wzwg.cmm.word.answer01" /></spring:argument>'+
							'<spring:argument><spring:message code="wzwg.cmm.word.choice" /></spring:argument>'+
						  '</spring:message>')){
				return
			}else{
				$.ajax({
			        type:'POST'
					, url:'<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/qna/registNttReplyChoiceAjax.do'
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
								, url : '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/qna/selectNttDetailAjax.do'
								, dataType : 'html'
								, data : "siteSeq="+$('#siteSeq').val()+"&nttSeq="+$('#parntsNttSeq').val()+"&bbsSeq="+$('#bbsSeq').val()
								, success : function (data) {
									$('#bbs_area').html(data);
								}
								, error : function (request, status, error) {
									alert('<spring:message code="fail.common.msg" text="error" />');
								}
							});
							
							$("#close_btn").click();
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
		
</script>
	
	<div class="layer1 w600" style="height:300px;">
	
		<div class="pop-id-sch">
			<button class="close" type="button" onclick="fnLayerPopupClose();"><img src="/images/wzwg/site/mngr/pop-close.png" alt="<spring:message code="wzwg.cmm.word.close" />" /></button>
			<span><spring:message code="wzwg.sysMngr.word.answer01Choice" /></span>
		</div>
		
		<div class="pop-container" style="height:150px;">
			<div class="pop-conts" style="height:130px;overflow-y:auto;">
				<form:form modelAttribute="paramVO" name="choiceFrm" id="choiceFrm" method="post">
					<form:hidden path="siteSeq" />
					<form:hidden path="bbsSeq" />
					<form:hidden path="nttSeq" />
					<form:hidden path="parntsNttSeq" />
					
					<div id="board-detail-006" class="board-detail-006">
						<div class="subject">
							<table>
								<colgroup>
									<col width="30%"/>
									<col width="70%"/>
								</colgroup>
								<tbody>
									<tr>
										<th class="subTit"><spring:message code="wzwg.sysMngr.word.interrGret" /></th>
										<td>
	
											<textarea id="qestnUsrCm" name="qestnUsrCm" rows="5" maxlength="200"></textarea>
	
										</td>
									</tr>
								</tbody>
							</table>	
						</div>
					</div>		
					
				</form:form>
			</div>
		</div>
		
		<div class="ctr-box">
			<a href="javascript:void(0);" id="choice_btn" class="btn-a"><spring:message code="wzwg.cmm.word.stre" /></a>
			<a href="javascript:void(0);" id="cancle_btn" class="btn-a"><spring:message code="wzwg.cmm.word.cancl" /></a>
		</div>
			
	</div>