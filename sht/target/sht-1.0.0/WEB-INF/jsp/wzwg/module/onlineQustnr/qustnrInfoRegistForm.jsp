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
	        
	    });
	    
	    /** 설문 등록 */
	    function fnRegist(){
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
	 			, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineQustnr/registOnlineQustnrInfoAjax.do'
	 			, data:$("#qustnrForm").serialize()
	 			,success:function (result){
	 				$(result).find('value').each(function(){
	 					if($(this).text() == "success"){
	 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
                            //fnCntntsRegist(); 
	 						fnList();
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
	    
	    /** 설문 리스트로 이동 */
	    function fnList(){
	    	document.qustnrForm.action='<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineQustnr/selectOnlineQustnrInfoList.do';
	    	document.qustnrForm.submit();
	    }

	</script>
	
	<form id="qustnrForm" name="qustnrForm" method="post">
		<table class="basic">
			<colgroup>
				<col width="20%" />
				<col width="80%" />
			</colgroup>
			<tbody>
				<tr>
					<th><spring:message code="wzwg.module.word.qustnrnm" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td>
						<c:set var="msg_txt">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.module.word.qustnrnm" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
						</c:set>
						
						<input type="text" name="qustnrNm" id="qustnrNm" class="w70" dir="required,vmaxlen=100" title="<spring:message code="wzwg.module.word.qustnrnm" />" placeholder="<c:out value="${msg_txt}" />"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.module.word.qustnrtrgter" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td>
						<ul class="wzForm">
							<c:choose>
								<c:when test="${!empty usrtyList }">
									<c:forEach items="${usrtyList }" var="usrtyList" varStatus="status">
										<li><label class="mr10">
											<input type="checkbox" name="usrtySeqArr" value="<c:out value="${usrtyList.usrTySeq }" />" dir="required" title="<spring:message code="wzwg.module.word.qustnrtrgter" />"/>
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
					<th><spring:message code="wzwg.module.word.qustnrpd" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
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
					
						<input type="text" class="datePicker cal" style="width:150px;" readonly="readonly" name="bgnde" dir="required,vdateFt=bgnde:endde" placeholder="<c:out value="${msg_txt01}" />" title="<spring:message code="wzwg.cmm.word.bgnde" />" />
						<select name="beginTime"  dir="required,vnum">
							<c:forEach begin="0" end="23" varStatus="status">
								<fmt:formatNumber var="sHour" minIntegerDigits="2" value="${status.index }"/>
								<option value="<c:out value="${sHour}" />"><c:out value="${sHour}" /> <spring:message code="wzwg.cmm.word.hour" /></option>
							</c:forEach>
						</select>
						~
						<input type="text" class="datePicker cal" style="width:150px;" readonly="readonly" name="endde" dir="required,vdate"  placeholder="<c:out value="${msg_txt02}" />" title="<spring:message code="wzwg.cmm.word.endde" />" />
						<select name="endTime" dir="required,vnum">
							<c:forEach begin="0" end="23" varStatus="status">
								<fmt:formatNumber var="sHour" minIntegerDigits="2" value="${status.index }"/>
								<option value="<c:out value="${sHour}" />"><c:out value="${sHour}" /> <spring:message code="wzwg.cmm.word.hour" /></option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.module.word.othbcat" /></th>
					<td>
						<ul class="wzForm">
							<li><label><input type="radio" name="othbcAt" value="Y" dir="required" title="<spring:message code="wzwg.module.word.othbcat" />"/><span class="spanLabel"><spring:message code="wzwg.cmm.word.othbc" /></span></label></li>
							<li><label><input type="radio" name="othbcAt" value="N" dir="required" title="<spring:message code="wzwg.module.word.othbcat" />" checked="checked"/><span class="spanLabel"><spring:message code="wzwg.cmm.word.clsdr" /></span></label></li>
						</ul> 
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.module.word.qustnrdc" /></th>
					<td>
						<textarea name="rm" id="rm" rows="20" class="w80" style="height: 420px; width:100%;" dir="required" title="<spring:message code="wzwg.module.word.qustnrdc" />"></textarea>
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
		<a href="javascript:void(0);" onclick="fnRegist();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
		<a href="javascript:void(0);" onclick="fnList();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>
	