<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<link href="/css/wzwg/cmm/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>

<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js"></script>

	<script type="text/javascript">
	    $(document).ready(function(){
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
	        
	        fnQesitmInit();
	        
	    });
	    
	    /** 설문 수정 */
	    function fnModify(){
	    	oEditors.getById["rm"].exec("UPDATE_CONTENTS_FIELD", []);

	 		if(!Validator.validate(document.qustnrForm)){
	 			return;
	 		}
	 		
	 		if($("input[name=usrtySeqArr]").length != 0 && $("input[name=usrtySeqArr]").is(":checked") == false){
	 			alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
	 					'<spring:argument><spring:message code="wzwg.module.word.qustnrtrgter" /></spring:argument>'+
	 					'<spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument>'+
	 				  '</spring:message>');
	 			$("input[name=usrtySeqArr]").focus();
	 			return;
	 		}
	 		
	 		/** 시작시간 && 종료시간 확인 */
		    if($("input[name=bgnde]").val() == $("input[name=endde]").val()){
		    	if($("select[name=beginTime]").val() > $("select[name=endTime]").val()){
		    		alert("<spring:message code="wzwg.cmm.word.qustnr" /> <spring:message code="wzwg.cmm.msg.MSG125" />");
		    		$("select[name=beginTime]").focus();
		    		return;
		    	}
		    }

	 		$.ajax({
	 			type:'POST'
	 			, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineQustnr/modifyOnlineQustnrInfoAjax.do'
	 			, data:$("#qustnrForm").serialize()
	 			,success:function (result){
	 				$(result).find('value').each(function(){
	 					if($(this).text() == "success"){
	 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>');
	 						fnList();
	 					}else{
	 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
	 					}
	 				})
	 			}
	 			, error:function (request, status, error) {
	 	              alert('<spring:message code="fail.common.msg" text="error" />');
	 	          }
	 		});
	    	
	    }
	    
	    /** 설문 리스트로 이동 */
	    function fnList(){
	    	document.qustnrForm.action='<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineQustnr/selectOnlineQustnrInfoList.do';
	    	document.qustnrForm.submit();
	    }
	    
	    /** 문항 리스트 조회 */
	    function fnQesitmInit(){
	    	$.ajax({
				  type:'POST'
				, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineQustnr/selectOnlineQustnrQesitmListAjax.do'
				, data: $("#qustnrForm").serialize()
				, success:function (data) {
					$('#qesitmListDiv').html(data);
				}
				, error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
				, dataType: 'html'
			});
		}
	    
	    /** 문항 등록/수정 폼 */
	    function fnQesitmPopup(paramCode, paramCodeNm, paramSeq){
	    	
	    	$("#qesitmForm #qesitmTyCode").val(paramCode);
	    	$("#qesitmForm #qesitmSeq").val(paramSeq);
	    	
	    	$.ajax({
	    		   type:'POST'
	    		 , url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineQustnr/selectOnlineQustnrQesitmFormPopup.do'
	    		 , data: $("#qesitmForm").serialize()
	    		 , success:function (data) {
					wzAjaxModal('popup_s', paramCodeNm + ' <spring:message code="wzwg.module.word.qesitmregist" />', data);
				 }
				 , error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				 }
	    		 , dataType: 'html'
	    	});
		}
	    
	    /** 문항 삭제 */
	    function fnQesitmDelete(paramSeq){
	    	$("#qesitmForm #qesitmSeq").val(paramSeq);
	 		$.ajax({
	 			type:'POST'
	 			, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineQustnr/deleteOnlineQustnrQesitmAjax.do'
	 			, data:$("#qesitmForm").serialize()
	 			,success:function (result){
	 				$(result).find('value').each(function(){
	 					if($(this).text() == "success"){
	 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
	 						fnQesitmInit();
	 					}else{
	 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
	 					}
	 				})
	 			}
	 			, error:function (request, status, error) {
	 	              alert('<spring:message code="fail.common.msg" text="error" />');
	 	          }
	 		});
	    }

		/** 문항 선택삭제 */
		function fnChkQesitmDelete(){
			
			if( $(":checkbox[name='qesitmSeqArr']:checked").length < 1 ){
				alert("<spring:message code="wzwg.cmm.msg.MSG116" />");
				return ;
			}
			
			if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" text="delete" /></spring:argument></spring:message>')){
		 		$.ajax({
		 			type:'POST'
		 			, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineQustnr/deleteOnlineQustnrQesitmArrAjax.do'
		 			, data:$("#qesitmForm").serialize()
		 			,success:function (result){
		 				$(result).find('value').each(function(){
		 					if($(this).text() == "success"){
		 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
		 						fnQesitmInit();
		 					}else{
		 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
		 					}
		 				})
		 			}
		 			, error:function (request, status, error) {
		 	              alert('<spring:message code="fail.common.msg" text="error" />');
		 	          }
		 		});
			}
		}
		
	    /** 문항 순서 변경 */
	    function fnOrdrChange(paramSeq, paramOrdr, paramChangeSeq, paramChangeOrdr){
	    	var frm = document.qesitmForm;
	    	frm.qesitmSeq.value = paramSeq;
	    	frm.ordr.value = paramOrdr;
	    	frm.changeQesitmSeq.value = paramChangeSeq;
	    	frm.changeOrdr.value = paramChangeOrdr;
	    	
	    	$.ajax({
	 			type:'POST'
	 			, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineQustnr/modifyOnlineQustnrQesitmOrdrAjax.do'
	 			, data:$("#qesitmForm").serialize()
	 			,success:function (result){
	 				$(result).find('value').each(function(){
	 					if($(this).text() == "success"){
	 						fnQesitmInit();
	 					}else{
	 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
	 					}
	 				})
	 			}
	 			, error:function (request, status, error) {
	 	              alert('<spring:message code="fail.common.msg" text="error" />');
	 	          }
	 		});
	    }
	    
	    /** 내 문항에 저장 */
		function fnChoiseQesitmStre(){
			var totCnt = $(":checkbox[name='qesitmSeqArr']:checked").length;
			if( totCnt < 1 ){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
	 					'<spring:argument><spring:message code="wzwg.module.word.registdata" /></spring:argument>'+
	 					'<spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument>'+
	 				  '</spring:message>');
				return ;
			}
			
	 		$.ajax({
	 			type:'POST'
	 			, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineQustnr/registOnlineQustnrItmCstdyAjax.do'
	 			, data:$("#qesitmForm").serialize()
	 			,success:function (result){
	 				$(result).find('value').each(function(){
	 					if($(this).text() == totCnt){
	 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
	 					}else if($(this).text() == 0){
	 						alert('<spring:message code="wzwg.cmm.msg.MSG127" />');
	 					}else{
	 						alert('<spring:message code="wzwg.cmm.msg.MSG128">'+
				 					'<spring:argument>'+totCnt+'</spring:argument>'+
				 					'<spring:argument>'+(totCnt-$(this).text())+'</spring:argument>'+
				 					'<spring:argument>'+$(this).text()+'</spring:argument>'+
				 				  '</spring:message>');
	 					}
	 					fnQesitmInit();
	 				});
	 			}
	 			, error:function (request, status, error) {
	 	              alert('<spring:message code="fail.common.msg" text="error" />');
	 	          }
	 		});
	    }
	    
	    /** 설문지 미리보기 */
		function fnQustnrPrevew(){
	    	$.ajax({
	    		   type:'POST'
	    		 , url:'<c:out value="${wzwg_contextPath}" />/module/onlineQustnr/selectOnlineQustnrRespondFormPopup.do'
	    		 , data: $("#qustnrForm").serialize()
	    		 , success:function (data) {
					wzAjaxModal('popup_l', '<spring:message code="wzwg.module.word.qestnrpreview" />', data);
				 }
				 , error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				 }
	    		 , dataType: 'html'
	    	});
	    	
	    }
	    
	    /** 내 문항 목록조회 */
		function fnItmCstdyList(paramPageIndex, paramCode, paramKeyword){
	    	document.qustnrForm.pageIndex.value = paramPageIndex;
	    	document.qustnrForm.searchQesitmTyCode.value = paramCode;
	    	document.qustnrForm.searchKeyword.value = paramKeyword;
	    	$.ajax({
	    		   type:'POST'
	    		 , url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineQustnr/selectOnlineQustnrItmCstdyListAjax.do'
	    		 , data: $("#qustnrForm").serialize()
	    		 , success:function (data) {
					wzAjaxModal('popup_s', '<spring:message code="wzwg.module.word.myqesitmlist" />', data);
				 }
				 , error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				 }
	    		 , dataType: 'html'
	    	});
		}

	</script>
	
	<form id="qustnrForm" name="qustnrForm" method="post">
		<input type="hidden" name="qustnrSeq" value="<c:out value="${resultVO.qustnrSeq }" />"/>
		<input type="hidden" id="qesitmSeq" name="qesitmSeq" value=""/>
		
		<c:set var="pageIndex" value="${paramVO.pageIndex}" />
		<c:set var="condition" value="${paramVO.searchCondition}" />
		<c:set var="othbcAt" value="${paramVO.searchOthbcAt}" />
		<c:set var="keyword" value="${paramVO.searchKeyword}" />
		
		<input type="hidden" id="pageIndex" name="pageIndex" value="<c:out value='${pageIndex}' />"/>			
		<input type="hidden" id="searchQesitmTyCode" name="searchQesitmTyCode" value=""/>
		<input type="hidden" id="searchCondition" name="searchCondition" value="<c:out value='${condition}' />"/>
		<input type="hidden" id="searchOthbcAt" name="searchOthbcAt" value="<c:out value='${othbcAt}' />"/>
		<input type="hidden" id="searchKeyword" name="searchKeyword" value="<c:out value='${keyword}' />"/>
		
		<table class="basic">
			<colgroup>
				<col width="20%" />
				<col width="80%" />
			</colgroup>
			<tbody>
				<tr>
					<th><spring:message code="wzwg.module.word.qustnrnm" /></th>
					<td>
						<c:set var="msg_txt">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.module.word.qustnrnm" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
						</c:set>
						
						<input type="text" name="qustnrNm" id="qustnrNm" class="w70" dir="required,vmaxlen=100" title="<spring:message code="wzwg.module.word.qustnrnm" />" placeholder="<c:out value="${msg_txt}" />" value="<c:out value="${resultVO.qustnrNm }" />"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.module.word.qustnrtrgter" /></th>
					<td>
						<ul class="wzForm">
							<c:choose>
								<c:when test="${!empty usrtyList }">
									<c:forEach items="${usrtyList }" var="usrtyList" varStatus="status">
										<li><label class="mr10">
											<input type="checkbox" name="usrtySeqArr" value="<c:out value="${usrtyList.usrtySeq }" />" dir="required" title="<spring:message code="wzwg.module.word.qustnrtrgter" />" <c:if test="${usrtyList.usrtyApplcChk ne 0 }">checked="checked"</c:if>/>
											<span class="spanLabel"><c:out value="${usrtyList.tyNm }"/></span>
										</label></li>
									</c:forEach>
									<span class="wz_tableguide wd100 fl mt10"><spring:message code="wzwg.cmm.msg.tip.MSG074" /></span>
								</c:when>
								<c:otherwise>
									<spring:message code="wzwg.cmm.msg.MSG104" />
								</c:otherwise>
							</c:choose>
						</ul>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.module.word.qustnrpd" /></th>
					<td>
						
						<c:set var="msg_txt01">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011">
								<spring:argument><spring:message code="wzwg.cmm.word.bgnde" /></spring:argument>
								<spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument>
							</spring:message>
						</c:set>
						
						<c:set var="msg_txt02">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011">
								<spring:argument><spring:message code="wzwg.cmm.word.endde" /></spring:argument>
								<spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument>
							</spring:message>
						</c:set>
					
						<input type="text" class="datePicker cal" style="width:150px;" readonly="readonly" name="bgnde" dir="required,vdateFt=bgnde:endde" value="<c:out value="${resultVO.bgnde }" />" placeholder="<c:out value="${msg_txt01}" />" title="<spring:message code="wzwg.cmm.word.bgnde" />" />
						<select name="beginTime"  dir="required,vnum">
							<c:forEach begin="0" end="23" varStatus="status">
								<fmt:formatNumber var="sHour" minIntegerDigits="2" value="${status.index }"/>
								<option value="<c:out value="${sHour}" />" <c:if test="${sHour eq resultVO.beginTime }">selected="selected"</c:if>><c:out value="${sHour}" /> <spring:message code="wzwg.cmm.word.hour" /></option>
							</c:forEach>
						</select>
						~
						<input type="text" class="datePicker cal" style="width:150px;" readonly="readonly" name="endde" dir="required,vdate" value="<c:out value="${resultVO.endde }" />" placeholder="<c:out value="${msg_txt02}" />" title="<spring:message code="wzwg.cmm.word.endde" />" />
						<select name="endTime" dir="required,vnum">
							<c:forEach begin="0" end="23" varStatus="status">
								<fmt:formatNumber var="sHour" minIntegerDigits="2" value="${status.index }"/>
								<option value="<c:out value="${sHour}" />" <c:if test="${sHour eq resultVO.endTime }">selected="selected"</c:if>><c:out value="${sHour}" /> <spring:message code="wzwg.cmm.word.hour" /></option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.module.word.othbcat" /></th>
					<td>
						<ul class="wzForm">
							<li><label><input type="radio" name="othbcAt" value="Y" dir="required" title="<spring:message code="wzwg.module.word.othbcat" />" <c:if test="${resultVO.othbcAt eq 'Y' }">checked="checked"</c:if>/><span class="spanLabel"><spring:message code="wzwg.cmm.word.othbc" /></span></label></li>
							<li><label><input type="radio" name="othbcAt" value="N" dir="required" title="<spring:message code="wzwg.module.word.othbcat" />" <c:if test="${resultVO.othbcAt ne 'Y' }">checked="checked"</c:if>/><span class="spanLabel"><spring:message code="wzwg.cmm.word.clsdr" /></span></label></li>
						</ul> 
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.module.word.qustnrdc" /></th>
					<td>
						<textarea name="rm" id="rm" rows="20" class="w80" style="height: 420px; width:100%;" dir="required" title="<spring:message code="wzwg.module.word.qustnrdc" />"><c:out value="${resultVO.rm }"/></textarea>
						<script type="text/javascript">
							var oEditors = [];
							nhn.husky.EZCreator.createInIFrame({
							    oAppRef: oEditors,
							    elPlaceHolder: "rm",
							    sSkinURI: "<c:out value="${wzwg_contextPath}" />/smartEditor2.8.2.1/smartEditor2Skin.do",
							    fCreator: "createSEditor2",
							    htParams: {
									fOnBeforeUnload : function(){}
									,aAdditionalFontList : [['NanumSquareR', 'NanumSquareR']]		// 추가 글꼴 목록
									}
							});
						</script>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	
	<div class="rt-box">
		<a href="javascript:void(0);" onclick="fnModify();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
		<a href="javascript:void(0);" onclick="fnList();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>
	
	<h3 class="wzAdmSTit wd100 fl"><spring:message code="wzwg.module.word.qustnrqesitm" /></h3>
	
	<table class="basic">
	    <colgroup>
	        <col width="20%">
	        <col width="80%">
	    </colgroup>
	    <tbody>
	        <tr>
	            <th><spring:message code="wzwg.module.word.qustnradd" /></th>
	            <td>
	            	<div class="lt-box mb0">
		                <c:forEach items="${codeList }" var="codeList" varStatus="status">
							<a href="javascript:void(0);" class="wzbtn btn-basic" onclick="fnQesitmPopup('<c:out value="${codeList.code}" />','<c:out value="${codeList.codeNm}" />', '');"><c:out value="${codeList.codeNm }" /></a>
						</c:forEach>
						<span class="wz_tableguide wd100 fl mt10 linehgt150"><spring:message code="wzwg.cmm.msg.tip.MSG075" /></span>
					</div>
	            </td>
	        </tr>
			<tr>
	            <th><spring:message code="wzwg.module.word.qustnrqesitm" /></th>
	            <td>
	               	<form id="qesitmForm" name="qesitmForm" method="post">
						<input type="hidden" name="qustnrSeq" value="<c:out value="${resultVO.qustnrSeq }" />"/>
						<input type="hidden" name="qesitmTyCode" id="qesitmTyCode" value=""/>
						<input type="hidden" name="qesitmSeq" id="qesitmSeq" value=""/>
						<input type="hidden" name="ordr" id="ordr" value=""/>
						<input type="hidden" name="changeQesitmSeq" id="changeQesitmSeq" value=""/>
						<input type="hidden" name="changeOrdr" id="changeOrdr" value=""/>
						
						<div id="qesitmListDiv"> </div>
					</form>
					<div class="lt-box">
						<a href="javascript:void(0);" onclick="fnChkQesitmDelete();" class="wzbtn btn-del"><spring:message code="wzwg.module.word.choisedelete" /></a>
						<a href="javascript:void(0);" onclick="fnChoiseQesitmStre();" class="wzbtn btn-basic fr ml5"><spring:message code="wzwg.module.word.choiseqesitmstre" /></a>
						<a href="javascript:void(0);" onclick="fnItmCstdyList(1,'','');" class="wzbtn btn-basic fr"><spring:message code="wzwg.module.word.streqesitmimport" /></a>
						<a href="javascript:void(0);" onclick="fnQustnrPrevew();" class="wzbtn btn-basic"><spring:message code="wzwg.module.word.qestnrpreview" /></a>
					</div>
	            </td>
	        </tr>
	    </tbody>
	</table>
	
	
	
	

	

	