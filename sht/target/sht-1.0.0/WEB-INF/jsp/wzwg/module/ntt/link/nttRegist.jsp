<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<c:set var="adminAuthAt" value="N"/>

<c:if test="${paramVO.cmntUseAt eq 'Y'}">
	<c:if test="${sessionScope.cmntMngrAt == true}">
		<c:set var="adminAuthAt" value="Y"/>
	</c:if>
</c:if>	

<c:if test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or sessionScope.CNTNTS_ADMIN_AT}">
	<c:set var="adminAuthAt" value="Y"/>
</c:if>

<script type="text/javascript">
try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.cmm.word.regist" />';}catch(e){console.log(e.message);}

	$(document).ready(function(){
		$('#contentsCaption').html($('#menuNm').val() + ' <spring:message code="wzwg.module.word.postwritng" />');
		
		// 등록
		$('#regist_btn').click(function(){
			
			if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>')){
				return;
			}else{
								
				var frm = document.getElementById("regFrm");
				
				frm.nttCnChrctr.value = frm.linkDc.value;

				if(frm.nttSj.value == ''){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.sj" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
					return;				
				}
				
				if(frm.linkUrl.value == ''){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.module.word.nttlink" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
					return;				
				}
				
				/* if(frm.file_1.value == ''){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.thumb" /> <spring:message code="wzwg.cmm.word.image" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
					return;				
				} */
				
				var formData = new FormData(frm);

				$.ajax({
			        type : 'POST'
					, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/link/registNttLinkInfoAjax.do'
					, mimeType: 'multipart/form-data'
					, cache : false
					, async : false
					, processData: false
					, contentType: false
					, data : formData
					, success : function (result) {
			    	  
			    	  	var value = "";
						
						$(result).find("value").each(function() {  
							value = $(this).text();  
						});
						
						if(value != 'fail'){
							
							if('<c:out value="${paramVO.listScrinCode}"/>' == 'B'){
								$.ajax({
							        type : 'POST'
									, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/link/selectNttLinkListAjax.do'
									, dataType : 'html'
									, data : $("#regFrm").serialize()
									, success : function (data) {
										$('#bbs_area').html(data);
										$("#content").css("height",$(document).height());
								     	$(window).scrollTop(0);
									}
									, error : function (request, status, error) {
										alert('<spring:message code="fail.common.msg" text="error" />');
									}
								});
							}else{
								fnNttLinkList();
							}

						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
						}

					}
					, error : function (request, status, error) {
						alert('<spring:message code="fail.common.msg" text="error" />');
					}
				});

			}
			
		});
		
		// 취소
		$('#cancle_btn').click(function(){
			fnNttLinkList();
		});
		
	});
	
	// 목록으로 이동
	function fnNttLinkList(){
		
		var frm = document.getElementById("regFrm");
		
		$.ajax({
	        type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/link/selectNttLinkListAjax.do'
			, dataType : 'html'
			, data : $("#regFrm").serialize()
			, success : function (data) {
				$('#bbs_area').html(data);
				$("#content").css("height",$(document).height());
		     	$(window).scrollTop(0);
			}
			, error : function (request, status, error) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
		});
	}
	
	window.onkeydown = function() {

	    var keyCode = event.keyCode;

	    if(keyCode == 8
	    		&& 'INPUT'.indexOf(event.target.nodeName.toUpperCase()) == -1 
	    		&& 'TEXTAREA'.indexOf(event.target.nodeName.toUpperCase()) == -1) {

	    	$('#cancle_btn').click();
	    	return false;
		}
	}		
	
</script>

		<form:form modelAttribute="paramVO" path="regFrm" id="regFrm" name="regFrm" method="post" enctype="multipart/form-data">
			<form:hidden path="siteSeq" />
			<form:hidden path="bbsSeq" />
			<input type="hidden" id="linknttSeq" name="linknttSeq" />
			<form:hidden path="menuSeq" />
			<form:hidden path="mngrAt" />
			<input type="hidden" id="cntntsSeq" name="cntntsSeq" />
			<form:hidden path="cmntUseAt" />
			
			<c:set var="nttSjTit"><spring:message code="wzwg.module.word.nttsjinpcmpt" /></c:set>
			<c:set var="nttlinkTit"><spring:message code="wzwg.module.word.nttlinkinpcmpt" /></c:set>
			<c:set var="placeTit"><spring:message code="wzwg.cmm.msg.MSG346" /></c:set>
			
			<div class="register-box">
				<div class="subject">
					<table>
					<caption id="contentsCaption"><spring:message code="wzwg.module.word.postwritng" /></caption>
					<colgroup>
						<col width="10%"/>
						<col width="*"/>
					</colgroup>
					<thead>
					</thead>
					<tbody>				
						<tr>
							<th scope="row" class="subTit">
								<spring:message code="wzwg.cmm.word.sj" />
							</th>
							<td style="padding-right:5px;">
								<form:input path="nttSj" id="nttSj" style="width:100%;" dir="required" title="${fn:escapeXml(nttSjTit)}" />
							</td>
						</tr>
						<tr>
							<th scope="row" class="subTit">
								<spring:message code="wzwg.module.word.nttlink" />
							</th>
							<td style="padding-right:5px;">
								<form:input path="linkUrl" id="linkUrl" style="width:100%;" dir="required" title="${fn:escapeXml(nttlinkTit)}" value="http://" placeholder="${fn:escapeXml(placeTit)}"/>
							</td>
						</tr>
						<tr>
							<th scope="row" class="subTit">
								<spring:message code="wzwg.module.word.thumbimage" />
							</th>
							<td>
								<c:import url="${wzwg_contextPath}/module/upload/file/selectFileInc.do" charEncoding="utf-8">
									<c:param name="param_updateFlag" 		value="N" />
									<c:param name="param_atchFileNumber" 	value="1" />
									<c:param name="param_cntntsSeq" 		value="${paramVO.bbsSeq}" />
									<c:param name="param_bbsSe" 			value="link" />
								</c:import>
							</td>
						</tr>
						<tr>
							<th scope="row" class="subTit">
								<spring:message code="wzwg.cmm.word.cn" />
							</th>
							<td>
								<textarea title="<spring:message code="wzwg.module.word.linkdcinpcmpt" />" name="linkDc" id="linkDc" rows="10" style="width:100%;"><c:out value="${paramVO.linkDc}"/></textarea>
								<input type="hidden" name="nttCnChrctr" id="nttCnChrctr" />
							</td>
						</tr>
						<tr>
							<td colspan="2" class="txt-c" style="letter-spacing:-1px;"><spring:message code="wzwg.cmm.msg.MSG006" /></td>
						</tr>
					</tbody>
				</table>
				</div>
			</div>
			<div class="ctr-box">
				<a href="javascript:void(0);" id="cancle_btn" class="wzbtn btn-del"><spring:message code="wzwg.cmm.word.cancl" /></a>
				<a href="javascript:void(0);" id="regist_btn" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
			</div>		
					
		</form:form> 

