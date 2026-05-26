<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<link type="text/css" href="/css/wzwg/module/cmm/layer_popup.css" rel="stylesheet" />

<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		fnTmprnttList();
		
		/* $("#cancle_btn").click(function (){
	    	$('body').css({overflow:'auto'});
	    	$("#bbs_layer").html("");
	   		$('#bbs_layer').hide();	
		});	
		
		$("#close_btn").click(function (){
	    	$('body').css({overflow:'auto'});
	    	$("#bbs_layer").html("");
	   		$('#bbs_layer').hide();	
		});	 */
			
	});
	
	// 임시 저장글 목록
	function fnTmprnttList(){
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cmmn/selectTmprnttListAjax.do'
			, data:$('#tmprFrm').serialize()
			, success:function (data) {
				$('#tmprnttListDiv').html(data);
				wzModalFocus();
			}
			, error:function (request, status, error) {
		    	  alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
	// 임시 저장글 불러오기
	function fnNttRegistForm(tmprnttSeq){
		if(!confirm('<spring:message code="wzwg.cmm.msg.MSG001" />')){
			return;
		}else{
			$.ajax({
				  type : 'POST'
				, dataType: 'json'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cmmn/selectTmprnttDetailAjax.do'
				, data:"searchTmprnttSeq="+tmprnttSeq
				, success:function (data) {

					document.getElementById('tmprnttSeq').value = tmprnttSeq;
					
					$('#nttSj').val(data.rmprnttInfo.nttSj);
					oEditors.getById["nttCn"].exec("SET_IR", [data.rmprnttInfo.nttCn]);
					
					if(data.rmprnttInfo.noticeAt == 'Y'){
						$("input[name=noticeAt]").prop("checked", true);
					}
					
					if(data.rmprnttInfo.secretAt == 'Y'){
						$("input[name=secretAt]").prop("checked", true);
					}
					
					if(data.rmprnttInfo.annymtyAt == 'Y'){
						$("input[name=annymtyAt]").prop("checked", true);
					}
					
					if(data.rmprnttInfo.answerPermAt == 'Y'){
						$("input[name=answerPermAt]").prop("checked", true);
					}
					 
					//$("#close_btn").click();
					//wzModalClose();
					$(".close").click();
				}
				, error:function (request, status, error) {
			    	  alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});
		}
	}
	
	// 임시 저장글 삭제
	function fnTmprnttDelete(tmprnttSeq){
		if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" text="delete" /></spring:argument></spring:message>')){
			$.ajax({
				  type : 'POST'
				, dataType: 'xml'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cmmn/deleteTmprnttInfoAjax.do'
				, data:"tmprnttSeq="+tmprnttSeq
				, success:function (result) {
					
					var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value != 'fail'){
						$('#tmprntt_area').html("<a href='javascript:void(0);' onclick='fnTmprPop(this);' class='save'><spring:message code='wzwg.cmm.word.temsvept' /><span class='red'>("+value+")</span></a>");
						wzPopCallBtn = $('#tmprntt_area').find('a');
						fnTmprnttList();
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
					}
					
					wzModalFocus('last');
					
				}
				, error:function (request, status, error) {
			    	  alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});
		}
	}
	
	
</script>
		
				<form:form modelAttribute="paramVO" name="tmprFrm" id="tmprFrm" method="post">
					<form:hidden path="siteSeq" />
					<form:hidden path="bbsSeq" />
					<form:hidden path="nttSeq" />
		
					<div id="tmprnttListDiv"></div>
	
				</form:form>
		
	