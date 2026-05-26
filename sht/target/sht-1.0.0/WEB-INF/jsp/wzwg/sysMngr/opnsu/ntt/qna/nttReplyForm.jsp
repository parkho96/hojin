<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>  

<script type="text/javascript">

	$(document).ready(function(){
		
		$("#module_div").children('.answer').css('display', 'none');
		
		fnQnaReplyList();
		
		// 답변 등록
		$("#reply_regist_btn").click(function(){
			
			var frm = document.detailFrm;
			
			if('<c:out value="${editorEstbsSe}" />' == 'S'){
				frm.nttCn.value = oEditors.getById["nttReplyCn"].getIR();	
				
				if(frm.nttCn.value == ''){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument><spring:message code="wzwg.sysMngr.word.answr01Cn" /></spring:argument></spring:message>');
					oEditors.getById["nttReplyCn"].exec("FOCUS",[]);
					return;				
				}
			}

			if('<c:out value="${editorEstbsSe}" />' == 'C'){
				if(bEditor_nttReplyCn.GetBodyElementsByTagName("img").length == 0 && bEditor_nttReplyCn.GetTextValue().replace("<p>", "").replace("</p>", "") == ""){	// 크로스에디터 안의 컨텐츠 입력 확인
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument><spring:message code="wzwg.sysMngr.word.answr01Cn" /></spring:argument></spring:message>');
					bEditor_nttReplyCn.SetFocusEditor(); // 크로스에디터 Focus 이동 
					return false; 
				}
				
				frm.nttCn.value = bEditor_nttReplyCn.GetBodyValue("nttReplyCn");
			}

			$.ajax({
				type:'POST'
				, dataType: 'xml'
				, url:'<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/qna/registNttReplyAjax.do'
				, data:$("#detailFrm").serialize()
				, success:function (result) {
		    	  
					var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value != 'fail'){
						$("#ntt_reply_cnt_txt").text(value);
						$("#ntt_reply_detail_txt").text(value);
						
						if('<c:out value="${editorEstbsSe}"/>' == 'S'){
							oEditors.getById["nttReplyCn"].exec("SET_IR", ['']);		
						}
						if('<c:out value="${editorEstbsSe}"/>' == 'C'){
							bEditor_nttReplyCn.SetBodyValue("");
						}
						
						fnQnaReplyList();
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
					}
		    	  
				}
				, error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
			});
			
		});
		
		$('#ntt_reply_ordr_btn').click(function(){
			/*
	 		if($("#module_div").children('.answer').css('display') == 'none'){
	 			$("#module_div").children('.answer').css('display', 'block');
			}
			*/
		});
	 	
		// 내림차순
		$('#ntt_reply_ordr_btn').children('.ordr_desc').click(function(){
			fnQnaReplyListOrdr('A');
			/*
			$("#module_div").each(function(){
				$(this).children().css('display', 'none');
			});
			
			$("#module_div").children('.answer').css('display', 'block');
			*/
		});
		
		// 오름차순
		$('#ntt_reply_ordr_btn').children('.ordr_asc').click(function(){
			fnQnaReplyListOrdr('D');
			/*
			$("#module_div").each(function(){
				$(this).children().css('display', 'none');
			});
			
			$("#module_div").children('.answer').css('display', 'block');
			*/
		});
	
	});

	// 답변 목록
	function fnQnaReplyList(){
		$.ajax({
	        type:'POST'
	        , dataType: 'html'
			, url:'<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/qna/selectNttReplyListAjax.do'
			, data:$("#detailFrm").serialize()
			, success:function (data) {
				$('#ntt_reply_div').html(data);
				$("#content").css("height",$(document).height());
			}
			, error:function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});	
	}
	
	// 답변 목록 정렬
	function fnQnaReplyListOrdr(ordrSe){
		
		var frm = document.detailFrm;
		
		frm.ordrSe.value = ordrSe;
		
		$.ajax({
	        type:'POST'
	        , dataType: 'html'
			, url:'<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/qna/selectNttReplyListAjax.do'
			, data:$("#detailFrm").serialize()
			, success:function (data) {
				$('#ntt_reply_div').html(data);
				
				if(ordrSe == 'A'){
					$('#ntt_reply_ordr_btn').children('.ordr_desc').hide();
					$('#ntt_reply_ordr_btn').children('.ordr_asc').show();
				}
				
				if(ordrSe == 'D'){
					$('#ntt_reply_ordr_btn').children('.ordr_desc').show();
					$('#ntt_reply_ordr_btn').children('.ordr_asc').hide();
				}
				$("#content").css("height",$(document).height());
			}
			, error:function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});	
		
	}
	
</script>
	
	<input type="hidden" id="nttSj" name="nttSj" value="<c:out value="${nttVO.nttSj}" />" />
	<input type="hidden" id="nttCn" name="nttCn" />
	<input type="hidden" id="parntsNttSeq" name="parntsNttSeq" value="<c:out value="${nttVO.nttSeq}" />" />
	<input type="hidden" id="choiceNttSeq" name="choiceNttSeq" value="<c:out value="${nttVO.choiceNttSeq}" />" />
	<input type="hidden" id="ntcrId" name="ntcrId" value="<c:out value="${nttVO.ntcrId}" />" />
	 
    
    <!-- 답변 목록 -->
	<div id="ntt_reply_div"></div>
     
    <div id="ntt_reply_regist_div">

		<c:if test="${sessionScope.SADMIN_AT}">
			<c:set var="repAuthAt" value="Y" />
		</c:if>		
		
		<c:if test="${repAuthAt eq 'Y'}">

		<table>
			<colgroup>
				<col width="100%"/>
			</colgroup>
			<thead>
				<tr>
					<td><spring:message code="wzwg.sysMngr.word.answr01Regist" /></td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>

						<c:if test="${repAuthAt eq 'Y'}">					
							<div class="txtBox">
								<textarea name="nttReplyCn" id="nttReplyCn" rows="10" style="width:98%;display:none;"></textarea>
								
								<c:import url="${wzwg_contextPath}/module/editor/editorForm.do" charEncoding="utf-8">
									<c:param name="param_editorNm" 	value="nttReplyCn" />
									<c:param name="param_editorTy" 	value="custom" />
								</c:import>
							</div>
						</c:if>
					</td>
				</tr>
				<tr>
					<td>
						<div class="ctr-box"><a href="javascript:void(0);" class="wzbtn btn-save" id="reply_regist_btn"><spring:message code="wzwg.sysMngr.word.answr01Regist" /></a></div>					
					</td>
				</tr>
			</tbody>
		</table>
		
		</c:if>
		
	</div>
	
