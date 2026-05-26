<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">

	$(document).ready(function(){
		
		fnNttSimpList();
		
		// 등록
		$('#simp_regist_btn').click(function(){
			
			var frm = document.getElementById("listFrm");
			
			if('<c:out value="${editorEstbsSe}"/>' == 'S'){
				frm.nttCn.value = oEditors.getById["nttCn"].getIR();	 
				
				if(frm.nttCn.value == ''){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
							'<spring:argument><spring:message code="wzwg.cmm.word.cn" text="contents" /></spring:argument>'+
							'<spring:argument><spring:message code="wzwg.cmm.word.input" text="input" /></spring:argument>'+
					      '</spring:message>');
					oEditors.getById["nttCn"].exec("FOCUS",[]);
					return;				
				}
			}
			if('<c:out value="${editorEstbsSe}"/>' == 'C'){
				if(bEditor_nttCn.GetBodyElementsByTagName("img").length == 0 && bEditor_nttCn.GetTextValue().replace("<p>", "").replace("</p>", "") == ""){ // 크로스에디터 안의 컨텐츠 입력 확인 
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
							'<spring:argument><spring:message code="wzwg.cmm.word.cn" text="contents" /></spring:argument>'+
							'<spring:argument><spring:message code="wzwg.cmm.word.input" text="input" /></spring:argument>'+
					      '</spring:message>');
					bEditor_nttCn.SetFocusEditor(); // 크로스에디터 Focus 이동 
					return false; 
				}
				
				frm.nttCn.value = bEditor_nttCn.GetBodyValue("nttCn");
			}

			frm.nttCnChrctr.value = frm.nttCn.value.replace(/[<][^>]*[>]/g, "");
			
			$.ajax({
				  type : 'POST'
				, dataType: 'xml'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/simp/registNttSimpInfoAjax.do'
				, cache : false
				, async : false
				, data:$("#listFrm").serialize()
				, success:function (result) {
					var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value == 'success'){
						if('<c:out value="${editorEstbsSe}"/>' == 'S'){
							oEditors.getById["nttCn"].exec("SET_IR", [""]);
						}
						if('<c:out value="${editorEstbsSe}"/>' == 'C'){
							bEditor_nttCn.SetBodyValue("");
						}
						
						fnNttSimpList();
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
		
	});
	
	// 간단게시물 목록
	function fnNttSimpList(){
		$.ajax({
	        type:'POST'
	        , dataType: 'html'
			, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/simp/selectNttSimpListAjax.do'
			, data:$("#listFrm").serialize()
			, success:function (data) {
				$('#simp_list_div').html(data);
				$("#content").css("height",$(document).height());
			}
			, error:function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});	
	}	
	
</script>

		<c:if test="${nowUrl.indexOf('/mngr') > -1 }">
			<div class="wz_notice brbox bg-white br-blue-strong fl mt10" style="overflow:visible;">
		        <ul class="wd100 pl0">
	                <li class="admpg-subp wd100" style="list-style:none;">· <spring:message code="wzwg.cmm.msg.MSG0075"/></li>
		        </ul>
			</div>
		</c:if>
		
		<c:set var="regAuthAt" value="" />

		<c:if test="${nttAuthVO.authorSe eq 'W'}">
			<c:set var="regAuthAt" value="Y" />
		</c:if>
		
		<c:if test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or sessionScope.CNTNTS_ADMIN_AT}">
			<c:set var="regAuthAt" value="Y" />
		</c:if>
		
		<c:if test="${not empty resultVO.bbsPrface}">
		<div class="mb30">
			<c:out value='${resultVO.bbsPrface}' escapeXml="false" />
		</div>
		</c:if>		
		
		<form:form modelAttribute="paramVO" path="listFrm" id="listFrm" name="listFrm" method="post">
			<form:hidden path="siteSeq" />
			<form:hidden path="bbsSeq" />
			<form:hidden path="simpnttSeq" />
			<form:hidden path="menuSeq" />
			<form:hidden path="mngrAt" />
			<form:hidden path="checkSimpnttSeq" />
			<form:hidden path="sitecntntsSeq" />
			
			<c:if test="${regAuthAt eq 'Y'}">
			
				<div>
					<textarea name="nttCn" id="nttCn" rows="15" cols="50" style="width:100%;display:none;"><c:out value="${paramVO.nttCn}"/></textarea> 
					<input type="hidden" name="nttCnChrctr" id="nttCnChrctr" />
					<c:import url="${wzwg_contextPath}/module/editor/editorForm.do" charEncoding="utf-8">
						<c:param name="param_editorNm" 	value="nttCn" />
						<c:param name="param_editorTy" 	value="custom" />
					</c:import>
				</div>
				<div class="btnbox-c">
					<a href="javascript:void(0);" id="simp_regist_btn" class="wzbtn btn-save mt30"><spring:message code="wzwg.cmm.word.regist" /></a>
				</div>	
			
			</c:if>		

			<div id="simp_list_div"></div>

		</form:form>
		
		<c:if test="${not empty resultVO.bbsCnclsn}">
		<div class="mt30">
			<c:out value='${resultVO.bbsCnclsn}' escapeXml="false" />
		</div>
		</c:if>		
