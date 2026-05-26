<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript" src="/js/wzwg/cmm/common_validator.js"></script>

<script type="text/javascript">
	$(document).ready(function (){
		<c:forEach items="${resultList }" var="resultList">
			iemInit('<c:out value="${resultList.qesitmSeq }" />');
		</c:forEach>
	});

	function iemInit(paramSeq){
		document.iemFrm.qesitmSeq.value = paramSeq;
    	$.ajax({
			  type:'POST'
			, url:'<c:out value="${wzwg_contextPath}" />/module/onlineQustnr/selectOnlineQustnrRespondFormIemListAjax.do'
			, data:{'qesitmSeq':paramSeq}
			, success:function (data) {
				$('#iemDiv'+paramSeq).html(data);
				wzModalFocus();
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
			, dataType: 'html'
		});
	}
	
	function fnRegist(){
		if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.regist" text="regist" /></spring:argument></spring:message>')){
		}else{
			var responseLength = "<c:out value="${fn:length(resultList)}" />";
			
			var frm = document.getElementById("iemFrm");
			if(!Validator.validate(frm)){
				return;
			}
	
			for(var i=0; i<responseLength; i++){
				var qesitmSeq = document.getElementsByName("chkQesitmSeq")[i].value;
				var qesitmTyCode = document.getElementsByName("chkQesitmTyCode")[i].value; 
				
	 			if(qesitmTyCode != 'SC00000326'){
	 				if($("input[name=chkVal"+qesitmSeq+"]").is(":checked") == false){
	 					alert('<spring:message code="wzwg.cmm.msg.MSG024" />');
	 					$("#respondFrm").empty();
	 					$("#respondFrm").append('<input type="hidden" name="qustnrSeq" id="qustnrSeq" value="<c:out value="${resultVO.qustnrSeq }" />"/>');
	 					$("input[name=chkVal"+qesitmSeq+"]").focus();
	 					return;
	 				}
	 			}
	 			
	 			if(qesitmTyCode != 'SC00000326'){
	  				$("input[name=chkVal"+qesitmSeq+"]:checked").each(function(){
	  					var iemSeq = $(this).val();
	  					fnDataSet(qesitmSeq, iemSeq, "");
	  				});
	 			}else{
	 				var iemSeq = document.getElementsByName("chkIemSeq"+qesitmSeq)[0].value;
	 				var dscrpAnswer = document.getElementsByName("chkVal"+qesitmSeq)[0].value;
	 				fnDataSet(qesitmSeq, iemSeq, dscrpAnswer);
	 			}
			}
			
	 		$.ajax({
	 			type:'POST'
	 			, url:'<c:out value="${wzwg_contextPath}" />/module/onlineQustnr/registOnlineQustnrRespondAjax.do'
	 			, data:$("#respondFrm").serialize()
	 			,success:function (result){
	 				$(result).find('value').each(function(){
	 					if($(this).text() == "success"){
	 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
	 						//fnInit();
	 						fnPage(1);
	 						wzModalClose();
	 					}else{
	 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
	 					}
	 				})
	 			}
	 			, error:function (request, status, error) {
	 	              alert('<spring:message code="fail.common.msg" text="error" />');
	 	          }
	 		});
		}
	}
	
	
	function fnDataSet(paramQesitmSeq, paramIemSeq, paramIemValue){
		var str = paramQesitmSeq + "$$!$" + paramIemSeq + "$$!$" + paramIemValue; 
		$("#respondFrm").append('<input type="hidden" name="responseValue" value="'+str+'"/>');
	}
	


</script>

	<form id="respondFrm" name="respondFrm" method="post">
		<input type="hidden" name="qustnrSeq" id="qustnrSeq" value="<c:out value="${resultVO.qustnrSeq }" />"/>
	</form>

	<form id="iemFrm" name="iemFrm" method="post">
		<input type="hidden" name="qesitmSeq" id="qesitmSeq" value=""/>
		<table class="wztable_line">
			<caption> <spring:message code="wzwg.cmm.cmmMsg.CMG024"><spring:argument><c:out value="${resultVO.qustnrNm }"></c:out> <spring:message code="wzwg.cmm.word.wa.of" /> <spring:message code="wzwg.module.word.qustnrpd" />, <spring:message code="wzwg.module.word.qustnrcn" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.wa.table" /></spring:argument></spring:message></caption>
			<colgroup>
				<col width="20%" />
				<col width="80%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col" colspan="2"><c:out value="${resultVO.qustnrNm }"></c:out></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th scope="row"><spring:message code="wzwg.module.word.qustnrpd" /></th>
					<td><c:out value="${resultVO.bgnde } ~ ${resultVO.endde }"/></td>
				</tr>
				<tr>
					<th scope="row"><spring:message code="wzwg.module.word.qustnrcn" /></th>
					<td><c:out value="${resultVO.rm }" escapeXml="false"/></td>
				</tr>
			</tbody>
		</table>
		
		<div class="survey">
			<ul>
			<c:forEach items="${resultList }" var="resultList" varStatus="status">
				<li>
					<input type="hidden" name="chkQesitmSeq" value="<c:out value="${resultList.qesitmSeq }" />"/>
					<input type="hidden" name="chkQesitmTyCode" value="<c:out value="${resultList.qesitmTyCode }" />"/>
					<p><c:out value="${status.count }. ${resultList.qesitmNm }"/></p>
					<div id="iemDiv<c:out value="${resultList.qesitmSeq}" />"/>
				</li>
			</c:forEach>
			</ul>
		</div>
		
		<c:if test="${sessionScope.SADMIN_AT ne 'true' and sessionScope.NADMIN_AT ne 'true' and sessionScope.loginVO.usrSeq ne ''}">
			<div class="ctr-box">
				<a href="javascript:void(0);" onclick="fnRegist();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
			</div>
		</c:if>
	</form>
	
	<br/>
	
