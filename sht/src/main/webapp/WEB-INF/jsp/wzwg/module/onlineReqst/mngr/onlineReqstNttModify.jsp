<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<link href="/css/wzwg/cmm/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />

<style type="text/css">
	.fileplus li{width:100%; float:left; margin-bottom:3px;}
	/* .fileplus li a{float:left; margin-left:3px; line-height:13px;} */
	.fileplus li span{float:left; margin-right:5px;}	
	input.uploadTit{width:70%; float:left;}
	.attatch_file_box { position:relative; padding:0 !important;}
	.attatch_file_box .attatchfile { position:absolute; top:0; left:0; width:80%; font-size:45px; opacity:0; filter:alpha(opacity=0); cursor:pointer; vertical-align:middle; height:20px;}
</style>

<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>" ></script>
<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript" src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>


<script type="text/javascript">

	$(document).ready(function(){
		
		$('#modify_btn').click(function(){
			
			
			if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>')){
				return;
			}else{			
			
				var frm = document.getElementById("modFrm");
				
				if(document.getElementById('reqstnttSj').value == ''){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
							'<spring:argument><spring:message code="wzwg.module.word.reqstnm" /></spring:argument>'+
							'<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>'+
						  '</spring:message>');
					return false;				
				}
				
				if(document.getElementById('bgnde').value.length != 10){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.bgnde" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
					return false;				
				}
				
				if(document.getElementById('endde').value.length != 10){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.endde" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
					return false;				
				}
				
				if(document.getElementById('psncpa').value == ''){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
							'<spring:argument><spring:message code="wzwg.cmm.word.psncpa" /></spring:argument>'+
							'<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>'+
						  '</spring:message>');
					return false;				
				}	
				
				var chechAt = "N";
				
				$("input[name=confmMthdCode]").each(function(){									
					if(this.checked){
						chechAt = "Y";
					}
				});
				
				if(chechAt == "N"){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
							'<spring:argument><spring:message code="wzwg.module.word.confmmthd" /></spring:argument>'+
							'<spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument>'+
						  '</spring:message>');
					return false;
				}
				
				var checkCnt = 0;
				var usrtyChkArr = "";

				$("input[name=usrty]").each(function(){
					if(this.checked){
						usrtyChkArr += $(this).val() + ",";
						checkCnt++;
					}
				});
				
				if(checkCnt < 1){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
							'<spring:argument><spring:message code="wzwg.module.word.reqsttrgter" /></spring:argument>'+
							'<spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument>'+
						  '</spring:message>');
					return false;
				}	
				
				frm.trgterUsrty.value = usrtyChkArr;

	
				frm.reqstnttCn.value = oEditors.getById["reqstnttCn"].getIR();
				
				if(frm.reqstnttCn.value == ''){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.cn" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
					return false;				
				}	
				
				var formData = new FormData(frm);
				
				$.ajax({
					  type : 'POST'
					, url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineReqst/modifyOnlineReqstNttAjax.do'
					, mimeType : 'multipart/form-data'
					, cache : false
					, async : false
					, processData : false
					, contentType : false
					, data : formData
					, success : function(result) {
			    	  	var value = "";
						
						$(result).find("value").each(function() {  
							value = $(this).text();  
						});
						
						if(value != 'fail'){
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>');
							$('#cancle_btn').click();
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
		
		$('#cancle_btn').click(function(){
			$.ajax({
				  type : 'POST'
				, dataType: 'html'
				, url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineReqst/selectOnlineReqstNttListAjax.do'
				, cache : false
				, async : false
				, data : $("#searchFrm").serialize()
				, success : function(data) {
					$('#onlineReqst_area').html(data);
				}
				, error : function(data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});	
		});		
		
		$("#ui-datepicker-div").remove();
		$(".datePicker").datepicker({ 		
		     dateFormat: 'yy-mm-dd',
		     monthNamesShort: ['1<spring:message code="wzwg.cmm.word.mt" />','2<spring:message code="wzwg.cmm.word.mt" />','3<spring:message code="wzwg.cmm.word.mt" />','4<spring:message code="wzwg.cmm.word.mt" />','5<spring:message code="wzwg.cmm.word.mt" />','6<spring:message code="wzwg.cmm.word.mt" />','7<spring:message code="wzwg.cmm.word.mt" />','8<spring:message code="wzwg.cmm.word.mt" />','9<spring:message code="wzwg.cmm.word.mt" />','10<spring:message code="wzwg.cmm.word.mt" />','11<spring:message code="wzwg.cmm.word.mt" />','12<spring:message code="wzwg.cmm.word.mt" />'],
		     dayNamesMin: ['<spring:message code="wzwg.cmm.word.sun01" />','<spring:message code="wzwg.cmm.word.mon01" />','<spring:message code="wzwg.cmm.word.tue01" />','<spring:message code="wzwg.cmm.word.wed01" />','<spring:message code="wzwg.cmm.word.thu01" />','<spring:message code="wzwg.cmm.word.fri01" />','<spring:message code="wzwg.cmm.word.sat01" />'],
		     weekHeader: 'Wk',
		     changeMonth: true, 	//월변경가능
		     changeYear: true, 	//년변경가능
		     yearRange:'-10:+10', 	// 연도 셀렉트 박스 범위(현재와 같으면 1988~현재년)
		     showMonthAfterYear: true, 	//년 뒤에 월 표시
		     buttonImageOnly: false, //이미지표시  
		     buttonText: '<spring:message code="wzwg.cmm.msg.MSG088" />', 
		     autoSize: false	 //오토리사이즈(body등 상위태그의 설정에 따른다)
		  });
	});

	nowPageTop = screen.availWidth;
	nowPageLeft = screen.availHeight;
	popupPageTop = 600;
	popupPageLeft = 600;
	resultTop = (nowPageTop - popupPageTop) / 2;
	resultLeft = (nowPageLeft - popupPageLeft) / 2;
	popOption = 'width=' + popupPageTop + ', height=' + popupPageLeft
			+ ', resizable=no, scrollbars=no, status=no, top=' + resultLeft
			+ ', left=' + resultTop + ';';


</script>


	<form id="searchFrm" name="searchFrm" method="post">
		<input type="hidden" name="pageIndex" value="<c:out value="${paramVO.pageIndex}" />"/>
		<input type="hidden" name="pageUnit" value="<c:out value="${paramVO.pageUnit}" />"/>
		<input type="hidden" name="progrsSttusCode" value="<c:out value="${paramVO.progrsSttusCode}" />"/>
		<input type="hidden" name="searchCondition" value="<c:out value="${paramVO.searchCondition}" />"/>
		<input type="hidden" name="searchKeyword" value="<c:out value="${paramVO.searchKeyword}" />"/>
		<input type="hidden" name="reqstSeq" value="<c:out value="${paramVO.reqstSeq}" />" />
	</form>
	
	<form:form modelAttribute="paramVO" path="modFrm" id="modFrm" name="modFrm" method="post" enctype="multipart/form-data" >	
	<form:hidden path="reqstSeq"/>
	<form:hidden path="reqstnttSeq"/>

	<table class="basic">
			<colgroup>
				<col width="20%" />
				<col width="80%" />
			</colgroup>
		  <tbody>
			<tr>
				<th><spring:message code="wzwg.module.word.reqstnm" /><span class="red">*</span></th>
				<td><input type="text" id="reqstnttSj" name="reqstnttSj" value="<c:out value="${onlineReqstNttVO.reqstnttSj}" />" class="w80"/></td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.module.word.reqstpd" /><span class="red">*</span></th>
				<td>
					<input type="text" id="bgnde" name="bgnde" class="datePicker cal" style="width:150px;" readonly="readonly" title="<spring:message code="wzwg.cmm.word.bgnde" />" value="<c:out value="${onlineReqstNttVO.bgnde}" />" /> 
					<select id="beginTime" name="beginTime" class="w5">
						<c:forEach begin="0" end="23" var="stime" varStatus="status">
							<c:if test="${stime < 10}">
								<c:set var="stime" value="0${stime}" />
							</c:if>
							<option value="<c:out value="${stime}" />"><c:out value="${stime}" /></option>
						</c:forEach>
					</select><spring:message code="wzwg.cmm.word.hour" />
					~ 
					<input type="text" id="endde" name="endde" class="datePicker cal" style="width:150px;" readonly="readonly" title="<spring:message code="wzwg.cmm.word.endde" />" value="<c:out value="${onlineReqstNttVO.endde}" />" />
					<select id="endTime" name="endTime" class="w5">
						<c:forEach begin="0" end="23" var="etime" varStatus="status">
							<c:if test="${etime < 10}">
								<c:set var="etime" value="0${etime}" />
							</c:if>
							<option value="<c:out value="${etime}" />"><c:out value="${etime}" /></option>									
						</c:forEach>
					</select><spring:message code="wzwg.cmm.word.hour" />
				</td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.cmm.word.psncpa" /><span class="red">*</span></th>
				<td>
					<input type="text" id="psncpa" name="psncpa" class="w10" value="<c:out value="${onlineReqstNttVO.psncpa}" />"/><spring:message code="wzwg.cmm.word.person" />
					<span class="wz_tableguide wd100 fl mt10"><spring:message code="wzwg.cmm.msg.MSG170" /></span>
				</td>
			</tr>						
			<tr>
				<th><spring:message code="wzwg.module.word.confmmthd" /><span class="red">*</span></th>
				<td>
					<ul>
					<c:forEach items="${reqcmcList}" var="reqcmcList" varStatus="status">
						<c:choose>
						<c:when test="${reqcmcList.code eq onlineReqstNttVO.confmMthdCode}">
							<li><label><input type="radio" id="confmMthdCode" name="confmMthdCode" value="<c:out value="${reqcmcList.code}" />" checked/><c:out value="${reqcmcList.codeNm}" /></label></li>
						</c:when>	
						<c:otherwise>
							<li><label><input type="radio" id="confmMthdCode" name="confmMthdCode" value="<c:out value="${reqcmcList.code}" />"/><c:out value="${reqcmcList.codeNm}" /></label></li>
						</c:otherwise>								
						</c:choose>
					</c:forEach>	
					</ul>									
				</td>
			</tr>	
			<c:set var="progrsSttusAreaCss" value="none"/>
			<c:if test="${onlineReqstNttVO.confmMthdCode eq 'SC00000110'}">
				<c:if test="${onlineReqstNttVO.progrsSttusCode eq 'SC00000113' or onlineReqstNttVO.progrsSttusCode eq 'SC00000114'}">
					<c:set var="progrsSttusAreaCss" value=""/>
				</c:if>
			</c:if> 
			<tr id="progrsSttusArea" style="display:<c:out value="${progrsSttusAreaCss}" />;">
				<th><spring:message code="wzwg.module.word.sttuschange" /></th>
				<td>
					<ul>
					<c:forEach items="${reqpscList}" var="reqpscList" varStatus="status">
						<c:if test="${reqpscList.code eq 'SC00000113' || reqpscList.code eq 'SC00000114'}">
							<c:choose>
							<c:when test="${reqpscList.code eq onlineReqstNttVO.progrsSttusCode}">
								<li><label><input type="radio" id="progrsSttusCode" name="progrsSttusCode" value="<c:out value="${reqpscList.code}" />" checked/><c:out value="${reqpscList.codeNm}" /></label></li>
							</c:when>	
							<c:otherwise>
								<li><label><input type="radio" id="progrsSttusCode" name="progrsSttusCode" value="<c:out value="${reqpscList.code}" />"/><c:out value="${reqpscList.codeNm}" /></label></li>
							</c:otherwise>								
							</c:choose>
						</c:if>
					</c:forEach>
					</ul>							
				</td> 
			</tr>					
			<tr>
				<th><spring:message code="wzwg.module.word.reqsttrgter" /><span class="red">*</span></th>
				<td>
					<input type="hidden" id="trgterUsrty" name="trgterUsrty" />
					<ul>
					<c:forEach items="${usrtyList }" var="usrtyList" varStatus="status">
						<c:set var="usrtyCheckAt" value="N"/>
						<c:forEach items="${trgterUsrtyList}" var="trgterUsrty" varStatus="status">
							<c:if test="${trgterUsrty.usrtySeq eq usrtyList.usrTySeq}">
								<c:set var="usrtyCheckAt" value="Y"/>
							</c:if>
						</c:forEach>
						<c:choose>
							<c:when test="${usrtyCheckAt eq 'Y'}">
								<li><label><input type="checkbox" id="usrty" name="usrty" value="<c:out value="${usrtyList.usrTySeq}" />" checked="checked"/><c:out value="${usrtyList.tyNm}" /></label></li>							
							</c:when>
							<c:otherwise>
								<li><label><input type="checkbox" id="usrty" name="usrty" value="<c:out value="${usrtyList.usrTySeq}" />"/><c:out value="${usrtyList.tyNm}" /></label></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<span class="wz_tableguide wd100 fl mt10"><spring:message code="wzwg.cmm.msg.tip.MSG074" /></span>
					</ul>									
				</td>
			</tr>						
			<tr>
				<th><spring:message code="wzwg.module.word.reqstcn" /></th>
				<td>
		
					<textarea id="reqstnttCn" name="reqstnttCn" rows="20" style="width:100%;"><c:out value="${onlineReqstNttVO.reqstnttCn}" /></textarea>
					
					<script type="text/javascript">
						var oEditors = [];
						nhn.husky.EZCreator.createInIFrame({
							oAppRef: oEditors,
							elPlaceHolder: "reqstnttCn",
							sSkinURI: "<c:out value="${wzwg_contextPath}" />/smartEditor2.8.2.1/smartEditor2Skin.do",
							fCreator: "createSEditor2",
							htParams: {fOnBeforeUnload : function(){} ,aAdditionalFontList : [['NanumSquareR', 'NanumSquareR']]}
						});
					</script>			        						
				</td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.module.word.reqstform" /></th>
				<td>
					<c:import url="${wzwg_contextPath}/module/upload/file/selectFileInc.do" charEncoding="utf-8">
						<c:param name="param_atchFileId" 	value="${onlineReqstNttVO.atchFileId}" />
						<c:param name="param_updateFlag" 	value="Y" />
						<c:param name="param_atchFileNumber" value="1" />
						<c:param name="param_cntntsSeq" value="${paramVO.reqstSeq}" />
					</c:import>							
				</td>
			</tr>			
	
		  </tbody>
	</table>
	<div class="rt-box">
		<a href="javascript:void(0);" id="modify_btn" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.updt" /></a>
		<a href="javascript:void(0);" id="cancle_btn" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.cancl" /></a>		
	</div>		
	
	
	</form:form>



