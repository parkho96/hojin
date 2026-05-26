<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>  

<script type="text/javascript">

	$(document).ready(function(){
		
		//$("#module_div").children('.answer').css('display', 'none');
		
		fnQnaReplyList();
		
		// 답변 등록
		$("#reply_regist_btn").click(function(){
			
			var frm = document.detailFrm;
			
			if('<c:out value="${editorEstbsSe}"/>' == 'S'){
				frm.nttCn.value = oEditors.getById["nttReplyCn"].getIR();	
				
				
				 var nttReplyCn = frm.nttCn.value ;
				 nttReplyCn = nttReplyCn.replace(/<(\/?)p>/gi,"");
				 nttReplyCn = nttReplyCn.replace(/(<br>)|(<br \/>)/gi,"");
				 nttReplyCn = nttReplyCn.replace(/\s/gi,"");
				 nttReplyCn = nttReplyCn.replace(/&nbsp;/gi,"");
				
				 if(nttReplyCn == '' || nttCn.length == 0){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument><spring:message code="wzwg.module.word.answercn" /></spring:argument></spring:message>');
					oEditors.getById["nttReplyCn"].exec("FOCUS",[]);
					return;				
				}
			}

			if('<c:out value="${editorEstbsSe}"/>' == 'C'){
				if(!bEditor_nttReplyCn.IsDirty()){ // 크로스에디터 안의 컨텐츠 입력 확인 
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument><spring:message code="wzwg.module.word.answercn" /></spring:argument></spring:message>');
					bEditor_nttReplyCn.SetFocusEditor(); // 크로스에디터 Focus 이동 
					return false; 
				}
				
				frm.nttCn.value = bEditor_nttReplyCn.GetBodyValue("nttReplyCn");
			}

			frm.nttCnChrctr.value = frm.nttCn.value.replace(/[<][^>]*[>]/g, "");
			
			$.ajax({
				type:'POST'
				, dataType: 'xml'
				, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/qna/registNttReplyAjax.do'
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
		
	 	
		// 내림차순
		$('#ordr_desc').click(function(){
			fnQnaReplyListOrdr('A');
			
			$(this).css('display', 'none');
			$('#ordr_asc').css('display', 'block').focus();
		});
		
		// 오름차순
		$('#ordr_asc').click(function(){
			fnQnaReplyListOrdr('D');
			
			$(this).css('display', 'none');
			$('#ordr_desc').css('display', 'block').focus();
		});
	
	});

	// 답변 목록
	function fnQnaReplyList(){
		$.ajax({
	        type:'POST'
	        , dataType: 'html'
			, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/qna/selectNttReplyListAjax.do'
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
			, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/qna/selectNttReplyListAjax.do'
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
		
		$('#ntt_reply_div').css('display', '');
		$('#ntt_reply_ctrl_btn').children('.ico_off').hide();
		$('#ntt_reply_ctrl_btn').children('.ico_on').show();		
		
	}
	
	function fnQnaReplyListCtrl(el) {		
		if($('#ntt_reply_div').css('display') == 'none'){
			$('#ntt_reply_div').css('display', '');
			$('#ntt_reply_ctrl_btn').children('.ico_off').hide();
			$('#ntt_reply_ctrl_btn').children('.ico_on').show();	
			$(el).attr('title', '<spring:message code="wzwg.module.word.regiedanswerfold" />');
		} else {
			$('#ntt_reply_div').css('display', 'none');
			$('#ntt_reply_ctrl_btn').children('.ico_off').show();
			$('#ntt_reply_ctrl_btn').children('.ico_on').hide();
			$(el).attr('title', '<spring:message code="module.cmm.word.regiedansweropen" />');
		}
	}
	
</script>
	
	<input type="hidden" id="nttSj" name="nttSj" value="<c:out value='${nttVO.nttSj}'/>" />
	<input type="hidden" id="nttCn" name="nttCn" />
	<input type="hidden" id="parntsNttSeq" name="parntsNttSeq" value="<c:out value='${nttVO.nttSeq}'/>" />
	<input type="hidden" id="choiceNttSeq" name="choiceNttSeq" value="<c:out value='${nttVO.choiceNttSeq}'/>" />
	<input type="hidden" id="ntcrId" name="ntcrId" value="<c:out value='${nttVO.ntcrId}'/>" />
	
	<c:set var="nttReplyCnt" value="${nttVO.nttReplyCnt}"/>
	<c:if test="${not empty choiceResult}"><c:set var="nttReplyCnt" value="${nttVO.nttReplyCnt-1}"/></c:if>
	
	<div class="step1">
		<ul class="tapMenu">
			<li>
				<a href="javascript:void(0);" id="ntt_reply_ctrl_btn" onclick="fnQnaReplyListCtrl(this);" title="<spring:message code="wzwg.module.word.regiedanswerfold" />">
					<span class="ico_on">▼</span>
					<span class="ico_off" style="display:none;">▲</span>
					<strong>
						<spring:message code="wzwg.module.word.regiedanswer" />					
					</strong>
					<span id="ntt_reply_cnt_txt" class="red"><c:out value="${nttReplyCnt }"/></span>
				</a>
			</li>
			<li>
				<a href="javascript:void(0);" style="display:none;" id="ordr_desc" title="<spring:message code="wzwg.module.word.answerrgsdedescOrdr"/>">
					<span class="ordr_desc"><spring:message code="wzwg.cmm.word.rgsde" /> ▼</span>
				</a>
				<a href="javascript:void(0);" id="ordr_asc" title="<spring:message code="wzwg.module.word.answerrgsdeascOrdr"/>">
					<span class="ordr_asc"><spring:message code="wzwg.cmm.word.rgsde" /> ▲</span>
				</a>
			</li>
		</ul>
	</div>	
    
    <!-- 답변 목록 -->
	<div id="ntt_reply_div"></div>
     
     <c:if test="${empty choiceResult}">
    <div id="ntt_reply_regist_div"> 
		<c:if test="${loginVO.usrSeq ne nttVO.ntcrSeq}">
			<c:if test="${param.authorSe eq 'W'}">
				<c:set var="repAuthAt" value="Y" />
			</c:if>					
		</c:if>
		
		<c:if test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or sessionScope.CNTNTS_ADMIN_AT}">
			<c:set var="repAuthAt" value="Y" />
		</c:if>		
		
		<div class="board001">
		
			<c:if test="${repAuthAt ne 'Y'}">
				<c:if test="${ nttReplyCnt eq 0 }">
					<c:if test="${empty loginVO}">
						<div><spring:message code="wzwg.cmm.msg.MSG422" /></div>
					</c:if>
					<c:if test="${loginVO.usrSeq eq nttVO.ntcrSeq}">
					<div><spring:message code="wzwg.cmm.msg.MSG093" /></div>
					</c:if>
				</c:if>
			</c:if>
				
			<c:if test="${repAuthAt eq 'Y'}">				
		
				<div>
					<textarea name="nttReplyCn" id="nttReplyCn" rows="10" style="width:98%;display:none;"></textarea>
					<input type="hidden" name="nttCnChrctr" id="nttCnChrctr" />
					
					<c:import url="${wzwg_contextPath}/module/editor/editorForm.do" charEncoding="utf-8">
						<c:param name="param_editorNm" 	value="nttReplyCn" />
						<c:param name="param_editorTy" 	value="custom" />
					</c:import>
				</div>
				<div class="ctr-box">
					<a href="javascript:void(0);" id="reply_regist_btn" class="wzbtn btn-save"><spring:message code="wzwg.module.word.answerregist01" /></a>
				</div>
			
			</c:if>
			
		</div>		
		
	</div>
	</c:if>
	
