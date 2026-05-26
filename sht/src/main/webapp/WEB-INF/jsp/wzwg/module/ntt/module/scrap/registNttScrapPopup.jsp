<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<link type="text/css" href="/css/wzwg/module/cmm/layer_popup.css" rel="stylesheet" />

<script type="text/javascript">
	
	$(document).ready(function(){
		
		
		$("#scrapgroupSeq").on("change", function () {
			if( $(this).val() != null && $(this).val() != ''){
				$('#scrapgroup_del_btn').show();
			}else{
				$('#scrapgroup_del_btn').hide();
			}
		});

		$("#scrap_regist_btn").click(function (){
			
			if($('#scrapgroupSeq').val() == ""){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.group" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument></spring:message>');
				return;
			}
			
			if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006"><spring:argument><spring:message code="wzwg.cmm.word.ntt" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.scrap" /></spring:argument></spring:message>')){
				return
			}else{
				$.ajax({
			        type:'POST'
					, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/scrap/registNttScrapAjax.do'
					, cache : false
					, data:$("#registFrm").serialize()
					, success:function (result) {
						var value = "";
						
						$(result).find("value").each(function() {  
							value = $(this).text();  
						});
						
						if(value == 'success'){
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.word.ntt" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.scrap" /></spring:argument></spring:message>');
							
							$('body').css({overflow:'auto'});
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
						}
			    	  
						$(".close").click();
						var nttSeq = $('#detailFrm #nttSeq').val();
						fnViewPage(nttSeq);
						
					}
					, error:function (data) {
					    alert('<spring:message code="fail.common.msg" text="error" />');
					}
					, dataType: 'xml'
			 	});
			}
			
		});
		
		$("#scrapgroup_add_btn").click(function (){
			$('#scrapgroupDiv').show();
			$('#scrapgroup_add_btn').hide();
			$('#scrapgroup_add_cancle_btn').show();
			$('#scrapgroupSeq').prop('disabled', true);
		});
		
		$("#scrapgroup_add_cancle_btn").click(function (){
			$('#scrapgroupDiv').hide();
			$('#groupNm').val("");
			$('#scrapgroup_add_btn').show();
			$('#scrapgroup_add_cancle_btn').hide();
			$('#scrapgroupSeq').prop('disabled', false);
		});
		
		$("#scrapgroup_dplct_btn").click(function (){
			
			if($('#groupNm').val() == ""){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.module.word.groupnm" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
				$('#groupNm').focus();
				return;
			}
			
			$.ajax({
		        type:'POST'
		        , dataType:'xml'
				, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/scrap/selectNttScrapgroupDplctChkAjax.do'
				, cache : false
				, data:$("#registFrm").serialize()
				, success:function (result) {
					var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value == 'success'){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.cnfirm" /></spring:argument></spring:message>');
						
						$('#scrapgroupNmDplctAt').val("Y");
						$('#scrapgroupNmDplctNm').val($('#groupNm').val());
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG017"><spring:argument><spring:message code="wzwg.module.word.groupnm" /></spring:argument></spring:message>');
						$('#groupNm').focus();
					}
					
				}
				, error:function (data) {
				    alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});
			
		});
	
		$("#scrapgroup_regist_btn").click(function (){
			if($('#groupNm').val() == ""){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.module.word.groupnm" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
				return;
			}
			
			if($('#scrapgroupNmDplctAt').val() != "Y" || $('#groupNm').val() != $('#scrapgroupNmDplctNm').val()){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG021"><spring:argument><spring:message code="wzwg.module.word.groupnmdplctceck" /></spring:argument></spring:message>');
				return;
			}
			
			if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006"><spring:argument><spring:message code="wzwg.module.word.scrapgroup" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>')){
				return
			}else{
				$.ajax({
			        type:'POST'
					, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/scrap/registNttScrapgroupAjax.do'
					, cache : false
					, data:$("#registFrm").serialize()
					, success:function (result) {
						var value = "";
						
						$(result).find("value").each(function() {  
							value = $(this).text();  
						});
						
						if(value == 'success'){
							$('#scrapgroupNmDplctAt').val("N");
							$('#scrapgroupNmDplctNm').val('');
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.module.word.scrapgroup" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
							
							$('body').css({overflow:'auto'});
							
							$.ajax({
								  type : 'POST'
								, dataType: 'xml'
								, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/scrap/selectNttScrapgroupListAjax.do'
								, data : $("#registFrm").serialize()
								, success : function(xml, status, request) {
									
									$("#scrapgroupSeq").find("option").remove();
									$("#scrapgroupSeq").append("<option value=\"\"><spring:message code="wzwg.cmm.word.choise" /></option>");
									$(xml).find("item").each(function(){
										var scrapgroupSeq 	= $(this).find('name').text();
										var groupNm 		= $(this).find('value').text();
										
										$("#scrapgroupSeq").append("<option value="+scrapgroupSeq+">"+groupNm+"</option>")
									});
									
									$("#scrapgroup_add_cancle_btn").click();
								}
								, error:function (data) {
									alert('<spring:message code="fail.common.msg" text="error" />');
								}
						 	});
							
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
						}
					}
					, error:function (data) {
					    alert('<spring:message code="fail.common.msg" text="error" />');
					}
					, dataType: 'xml'
			 	});
			}
		});
		
		
		
		// 삭제
		$("#scrapgroup_del_btn").click(function (){
			
			if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
				return;
			}else{
			
			$.ajax({
		        type:'POST'
		        , dataType:'xml'
				, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/scrap/deleteNttScrapgroupAjax.do'
				, cache : false
				, data:$("#registFrm").serialize()
				, success:function (result) {
					var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value == 'success'){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.module.word.scrapgroup" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
						
						$('body').css({overflow:'auto'});
						
						$.ajax({
							  type : 'POST'
							, dataType: 'xml'
							, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/scrap/selectNttScrapgroupListAjax.do'
							, data : $("#registFrm").serialize()
							, success : function(xml, status, request) {
								
								$('#scrapgroup_del_btn').hide();
								$("#scrapgroupSeq").find("option").remove();
								$("#scrapgroupSeq").append("<option value=\"\"><spring:message code="wzwg.cmm.word.choise" /></option>");
								$(xml).find("item").each(function(){
									var scrapgroupSeq 	= $(this).find('name').text();
									var groupNm 		= $(this).find('value').text();
									
									$("#scrapgroupSeq").append("<option value="+scrapgroupSeq+">"+groupNm+"</option>")
								});
								
								$("#scrapgroup_add_cancle_btn").click();
							}
							, error:function (data) {
								alert('<spring:message code="fail.common.msg" text="error" />');
							}
					 	});
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
					}
					
				}
				, error:function (data) {
				    alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});
			
			}
			
		});
		
		
		
	});

	function fnLayerPopupClose() {
       $("#bbs_layer").hide();
       $("#bbs_layer").empty();
       $('body').css({overflow:'auto'});
	}	
	
</script>

	<c:set var="adminAuthAt" value="N"/>
	
	<c:if test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or sessionScope.CNTNTS_ADMIN_AT}">
		<c:set var="adminAuthAt" value="Y"/>
	</c:if>
	
	<c:set var="popupViewAuthAt" value="N" />
	
	<c:if test="${adminAuthAt eq 'Y'}">
		<c:set var="popupViewAuthAt" value="Y" />
	</c:if>	
		
			<div class="pop-conts" style="overflow-y:auto;">
				<form:form modelAttribute="paramVO" name="registFrm" id="registFrm" method="post">
					<form:hidden path="siteSeq" />
					<form:hidden path="bbsSeq" />
					<form:hidden path="nttSeq" />
					<form:hidden path="usrSeq" />
					<input type="hidden" id="scrapgroupNmDplctAt" value="N" />
					<input type="hidden" id="scrapgroupNmDplctNm" />
					
					<table class="basic">
						<colgroup>
							<col width="20%" />
							<col width="80%" />
						</colgroup>
						  <tbody>					
							<tr>
								<th scope="row"><spring:message code="wzwg.module.word.nttscrap" /></th>
								<td>
									<form:select path="scrapgroupSeq" cssClass="w60">
										<form:option value=""><label for="option1"><spring:message code="wzwg.cmm.word.choise"/></label></form:option>
										<c:forEach var="resultList" items="${scrapgroupList}">
										<form:option value="${fn:escapeXml(resultList.scrapgroupSeq)}" label="${fn:escapeXml(resultList.groupNm)}" />
										</c:forEach>
									</form:select>
									
									<a href="javascript:void(0);" class="wzbtn-table btn-basic" id="scrapgroup_add_btn"><spring:message code="wzwg.module.word.groupadd" /></a>
									<a href="javascript:void(0);" class="wzbtn-table btn-basic" id="scrapgroup_add_cancle_btn" style="display:none;"><spring:message code="wzwg.module.word.groupaddcancl" /></a>
									<a href="javascript:void(0);" class="wzbtn-table btn-del" id="scrapgroup_del_btn" style="display:none;"><spring:message code="wzwg.module.word.groupdelete" /></a>
								</td>
							</tr>
							<tr id="scrapgroupDiv" style="display:none;">
								<th scope="row"><spring:message code="wzwg.module.word.groupnm" /></th>
								<td>
									<form:input path="groupNm" cssClass="w60" />
									<a href="javascript:void(0);" class="wzbtn-table btn-basic" id="scrapgroup_dplct_btn"><spring:message code="wzwg.module.word.dplctceck" /></a>
									<a href="javascript:void(0);" class="wzbtn-table btn-basic" id="scrapgroup_regist_btn"><spring:message code="wzwg.cmm.word.regist" /></a>
								</td>
							</tr>
						  </tbody>
					</table>
		
				</form:form>
			</div>
		
		<div class="ctr-box">
			<a href="javascript:void(0);" class="wzbtn btn-save" id="scrap_regist_btn"><spring:message code="wzwg.module.word.scrapregist" /></a>
		</div>
			
	       