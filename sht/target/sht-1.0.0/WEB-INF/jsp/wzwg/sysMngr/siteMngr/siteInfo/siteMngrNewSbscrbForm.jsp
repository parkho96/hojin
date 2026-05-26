<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript" src="/js/wzwg/cmm/common.js" ></script>
<script type="text/javascript" src="/js/wzwg/cmm/jquery-checktree.js" ></script>
<link rel="stylesheet" href="/css/wzwg/cmm/jquery-checktree.css" type="text/css" />

	<script type="text/javascript">
	
		$(document).ready(function(){
			
			/** ID 중복체크 */
			$("#dplct_btn").click(function(){
				
				if($("#inputUserId").val() == ''){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
							'<spring:argument><spring:message code="wzwg.cmm.word.id01" /></spring:argument>'+
							'<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>'+
						  '</spring:message>');
					$("#inputUserId").focus();
					return;
				}else{
					var regex = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
					
					if(regex.test($("#inputUserId").val())){
						alert('<spring:message code="wzwg.cmm.msg.MSG121" />');
						$("#inputUserId").val("");
						$("#inputUserId").focus();
						return;
					}					
				}
				
				$("#userId").val($("#inputUserId").val());
				
				$.ajax({
			        type:'POST'
					, url: '<c:out value="${wzwg_contextPath}" />/cmm/mber/sbscrb/selectSbscrbUserIdDplctCeckAjax.do'
					, dataType: 'xml'
					, data:$("#regForm").serialize()
					, success:function (result) {
			    	  
			    	  	var value = "";
						
						$(result).find("value").each(function() {  
							value = $(this).text();  
						});
						
						if(value == 'dplctN'){
							alert('<spring:message code="wzwg.cmm.msg.MSG119" />');
							$("#dplctYn").val("N");
							$("#userId").val("");
							$("#dplct_div").hide();
							$("#inputUserId").val("");
							$("#inputUserId").focus();
						}else{
							if(!confirm('<spring:message code="wzwg.cmm.msg.MSG027" />')) {
								$("#dplctYn").val("N");
								$("#userId").val("");
								$("#dplct_div").hide();
								$("#inputUserId").val("");
								$("#inputUserId").focus();
							}else{
								$("#dplctYn").val("Y");
								$("#userId").val($("#inputUserId").val());
								$("#userIdTmp").val($("#inputUserId").val());
								$("#dplct_div").show();
								//$("#inputUserId").css('background', '#dddddd');
							}
						}
			    	  
					}
					, error:function (request, status, error) {
						alert('<spring:message code="fail.common.msg" text="error" />');
					}
			 	});
			});
			
			/** 저장하기 */
			$("#sbscrb_btn").click(function(){
				
				if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006"><spring:argument><spring:message code="wzwg.cmm.word.sitemngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>')){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.cancl" text="cancle" /></spring:argument></spring:message>');
					return;
				}else{
					
						
						if($("#dplctYn").val() != 'Y'){
							alert('<spring:message code="wzwg.cmm.msg.MSG117" />');
							return;
						}
						
						if($("#userIdTmp").val() != $("#inputUserId").val()){
							alert('<spring:message code="wzwg.cmm.msg.MSG117" />');
							return;
						}
						
						if($("#password").val().length < 8){
							alert('<spring:message code="wzwg.cmm.msg.MSG118" />');
							return;
						}
						
						if(!fnPasswordMxtr($("#password").val())){
							alert('<spring:message code="wzwg.cmm.msg.MSG051" />');
							return;
						}
						
						$("#emailAdres").val($("#emailId").val()+"@"+$("#emailDomn").val());
	 					
					
					$.ajax({
				        type:'POST'
						, url: '<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/registMngrSbscrbInfo.do'
						, dataType: 'xml'
						, data:$("#regForm").serialize()
						, success:function (result) {
				    	  
				    	  	var value = "";
							
							$(result).find("value").each(function() {  
								value = $(this).text();  
							});
							
							if(value == 'success'){
								alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.sbscrb" /></spring:argument></spring:message>');
								//$("#cancle_btn").click();
								
								fnTabLink(7);
								
							}else{
								alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
							}
				    	  
						}
						, error:function (request, status, error) {
							alert('<spring:message code="fail.common.msg" text="error" />');
						}
				 	});
				}
					
			});
			
			/* 이메일 도메인 변경 */
			$("#selDomn").change(function(){
				
				if($("#selDomn").val() == "directInput"){
					$("#emailDomn").prop("disabled", false);
					$("#emailDomn").val("");
					$("#emailDomn").focus();
				}else{
					$("#emailDomn").prop("disabled", true);
					$("#emailDomn").val($("#selDomn").val());				
				}
				
			});
		});
		
		function fnList(){
		document.regForm.action='<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/siteInfo/selectMngrInfoList.do';
		document.regForm.submit();
		}
		 
	
	</script>
				
				  <c:choose>
            <c:when test="${!empty paramVO.siteSeq}">
                <jsp:include page="/WEB-INF/jsp/wzwg/sysMngr/siteMngr/siteInfo/siteInfoTab.jsp"></jsp:include>
            </c:when>
            <c:otherwise>
                <h3><spring:message code="wzwg.sysMngr.word.siteAdiinfo" /></h3>
            </c:otherwise>
            </c:choose>
				 
                  
                <form:form modelAttribute="paramVO" path="regForm" id="regForm" name="regForm" method="post">
					<form:hidden path="siteSeq" />
					<form:hidden path="sbscrbqesitmSeq" />
					<form:hidden path="sbscrbiemSeq" />
					<form:hidden path="sbjctRspns" />
					<form:hidden path="crtfctSeCode" />
					<form:hidden path="stplatArr" />
					<form:hidden path="userId" id="userId" name="userId" />
					<form:hidden path="unitySbscrbYn" />
					<input type="hidden" name="siteStplatArr" />
					<input type="hidden" name="rspnsArr" />
					<input type="hidden" id="dplctYn" />
					<input type="hidden" id="userIdTmp" />
                    
					<table summary="가입정보" class="basic">
						<colgroup>
							<col width="15%"/>
						</colgroup>
						<tbody>
							<tr>
								<th><spring:message code="wzwg.cmm.word.id02" /></th>
								<td>
									<c:set var="msg_txt01">
										<spring:message code="wzwg.cmm.cmmMsg.CMG011">
											<spring:argument><spring:message code="wzwg.cmm.word.id01" /></spring:argument>
											<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
										</spring:message>
									</c:set>
									<input type="text" id="inputUserId" name="inputUserId" class="w30" maxlength="20" style="ime-mode:inactive;" onkeyup="fnKeyUpEvent('inputUserId', '6');" placeholder="${fn:escapeXml(msg_txt01)}"/>
									<a href="javascript:void(0);" id="dplct_btn" class="wzbtn-table btn-basic"><spring:message code="wzwg.sysMngr.word.dplctCnfirm" /></a>
									<span id="dplct_div" style="display:none;">ID <spring:message code="wzwg.sysMngr.word.idDplctCnfirmCopt" /></span>
								</td>
							</tr>
							<tr>
								<th><spring:message code="wzwg.cmm.word.password" /></th>
								<td>
									<c:set var="msg_txt02">
										<spring:message code="wzwg.cmm.cmmMsg.CMG011">
											<spring:argument><spring:message code="wzwg.cmm.word.password" /></spring:argument>
											<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
										</spring:message>
									</c:set>
									<form:password path="password" cssClass="w30" maxlength="20" placeholder="${fn:escapeXml(msg_txt02)}"/>
									<span><spring:message code="wzwg.cmm.msg.MSG051" /></span>
								</td>
							</tr>
							<tr>
								<th><spring:message code="wzwg.cmm.word.nm02" /></th>
								<td>
									<c:set var="msg_txt03">
										<spring:message code="wzwg.cmm.cmmMsg.CMG011">
											<spring:argument><spring:message code="wzwg.cmm.word.nm02" /></spring:argument>
											<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
										</spring:message>
									</c:set>
									<form:input path="userNm" cssClass="w30" maxlength="25" onkeyup="fnKeyUpEvent('userNm', '5');" placeholder="${fn:escapeXml(msg_txt03)}"/>
								</td>
							</tr>
							<tr>
								<th>E-mail</th>
								<td>
									<c:set var="msg_txt04">
										<spring:message code="wzwg.cmm.cmmMsg.CMG011">
											<spring:argument><spring:message code="wzwg.cmm.word.email" /></spring:argument>
											<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
										</spring:message>
									</c:set>
									<form:hidden path="emailAdres" />
									<input type="text" class="w30" id="emailId" maxlength="100" onkeyup="fnKeyUpEvent('emailId', '6');" placeholder="${fn:escapeXml(msg_txt04)}" />@<input type="text" id="emailDomn" maxlength="50" class="w30" onkeyup="fnKeyUpEvent('emailDomn', '6');" disabled />
									<select id="selDomn">
										<option value=""><spring:message code="wzwg.cmm.word.choise" /></option>
										<option value="naver.com">naver.com</option>
										<option value="gmail.com">gmail.com</option>
										<option value="daum.net">daum.net</option>
										<option value="nate.com">nate.com</option>
										<option value="directInput"><spring:message code="wzwg.cmm.word.drtinp" /></option>
									</select>
								</td>
							</tr>
							   <c:if test="${paramVO.siteSeq ne '10000000001'}"> 
                            <tr>
                                <th><spring:message code="wzwg.sysMngr.word.mngrAuthor" /></th>
                                <td colspan="3">
                                    <ul id="tree" > 
                                      <c:forEach items="${mngrMenuList['MENU_LIST']}" var="oneDepth" varStatus="status">
                                       <c:if test="${empty oneDepth.upperMenuSeq or oneDepth.upperMenuSeq eq '0' }"> 
										<li>
										<label>
										<input type="checkbox" name="mngrMenuSeqArry" value="<c:out value="${oneDepth.mngrMenuSeq}" />" checked="checked"/>
										<c:out value="${oneDepth.mngrMenuNm}" /></label>
									
											<ul>
												    <c:forEach items="${mngrMenuList['MENU_LIST']}" var="twoDepth" varStatus="status">
            								<c:if test="${oneDepth.mngrMenuSeq eq twoDepth.upperMenuSeq}"> 
												<li>
												<label>
												<input type="checkbox" name="mngrMenuSeqArry" value="<c:out value="${twoDepth.mngrMenuSeq}" />"   checked="checked"/>
												<c:out value="${twoDepth.mngrMenuNm}" /></label>
												<ul>
												  <c:forEach items="${mngrMenuList['MENU_LIST']}" var="threeDepth" varStatus="status">
	            									<c:if test="${twoDepth.mngrMenuSeq eq threeDepth.upperMenuSeq}"> 
													<li>
													<label>
													<input type="checkbox" name="mngrMenuSeqArry" value="<c:out value="${threeDepth.mngrMenuSeq}" />"   checked="checked"/>
													<c:out value="${threeDepth.mngrMenuNm}" /></label>
													</li>
													 </c:if>
													 </c:forEach>
												</ul>
												</li>
											</c:if>
											</c:forEach>
											</ul>
										</li> 
										</c:if>
									  </c:forEach>
									</ul>
                                </td>
                            </tr>
                            </c:if>
						</tbody>
					</table>
					
				</form:form>
					<script>
		$('#tree').checktree();
		$("#tree li").css("float","none");
		$("#tree li").css("line-height","22px");
		$("#tree ul").css("padding","revert");
		</script>
				<div class="rt-box">
					<a href="javascript:void(0);" id="sbscrb_btn" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
					<a href="javascript:fnList();" id="sbscrb_list" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
				</div>
