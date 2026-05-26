<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>


<script type="text/javascript">

	var fromDate;
	var toDate;
	
    $(document).ready(function(){
    	$("#ui-datepicker-div").remove();
    	fromDate = $(".fromDatePicker").datepicker({
        	dateFormat: 'yy-mm-dd',
      	     monthNamesShort: ['1<spring:message code="wzwg.cmm.word.mt" />','2<spring:message code="wzwg.cmm.word.mt" />','3<spring:message code="wzwg.cmm.word.mt" />','4<spring:message code="wzwg.cmm.word.mt" />','5<spring:message code="wzwg.cmm.word.mt" />','6<spring:message code="wzwg.cmm.word.mt" />','7<spring:message code="wzwg.cmm.word.mt" />','8<spring:message code="wzwg.cmm.word.mt" />','9<spring:message code="wzwg.cmm.word.mt" />','10<spring:message code="wzwg.cmm.word.mt" />','11<spring:message code="wzwg.cmm.word.mt" />','12<spring:message code="wzwg.cmm.word.mt" />'],
      	     dayNamesMin: ['<spring:message code="wzwg.cmm.word.sun01" />','<spring:message code="wzwg.cmm.word.mon01" />','<spring:message code="wzwg.cmm.word.tue01" />','<spring:message code="wzwg.cmm.word.wed01" />','<spring:message code="wzwg.cmm.word.thu01" />','<spring:message code="wzwg.cmm.word.fri01" />','<spring:message code="wzwg.cmm.word.sat01" />'],
      	     weekHeader: 'Wk',
      	     changeMonth: true, 	//월변경가능
      	     changeYear: true, 	//년변경가능
      	     yearRange:'-10:+10', 	// 연도 셀렉트 박스 범위(현재와 같으면 1988~현재년)
      	     showMonthAfterYear: true, 	//년 뒤에 월 표시
      	     autoSize: false	 //오토리사이즈(body등 상위태그의 설정에 따른다)
      	 	 //접근성 옵션추가
	   	     , showOn : 'button'
	   	     , buttonImage : '/images/wzwg/site/mngr/datepicker.png'
	   	     , buttonText			: '<spring:message code="wzwg.module.word.inqirebegindechoise" />'
	   	     , buttonImageOnly		: false
	   	  	 , closeText:'<spring:message code="wzwg.cmm.word.cancl" />'
		   	 , showButtonPanel: true
		   	 , beforeShow : function(inp, inst){
		   	    	 drawYear = inst.drawYear;
		   	    	 drawMonth = inst.drawMonth;
		   	 }
	   	     , onClose : function(text, inst){
	   	    	setFocusPoint('reset');
	   	    	$(".fromDatePicker").next().focus();//호출 버튼 포커스 복귀
	   	     }
        }).on( "change", function() {
	          toDate.datepicker( "option", "minDate", $(this).val() );
	        }).focus(function(){
	        	setTimeout( datepickerWaAction , 250);
	        });	
        
    	
    	toDate = $(".toDatePicker").datepicker({ 		
	   	     dateFormat: 'yy-mm-dd',
	   	     monthNamesShort: ['1<spring:message code="wzwg.cmm.word.mt" />','2<spring:message code="wzwg.cmm.word.mt" />','3<spring:message code="wzwg.cmm.word.mt" />','4<spring:message code="wzwg.cmm.word.mt" />','5<spring:message code="wzwg.cmm.word.mt" />','6<spring:message code="wzwg.cmm.word.mt" />','7<spring:message code="wzwg.cmm.word.mt" />','8<spring:message code="wzwg.cmm.word.mt" />','9<spring:message code="wzwg.cmm.word.mt" />','10<spring:message code="wzwg.cmm.word.mt" />','11<spring:message code="wzwg.cmm.word.mt" />','12<spring:message code="wzwg.cmm.word.mt" />'],
	   	     dayNamesMin: ['<spring:message code="wzwg.cmm.word.sun01" />','<spring:message code="wzwg.cmm.word.mon01" />','<spring:message code="wzwg.cmm.word.tue01" />','<spring:message code="wzwg.cmm.word.wed01" />','<spring:message code="wzwg.cmm.word.thu01" />','<spring:message code="wzwg.cmm.word.fri01" />','<spring:message code="wzwg.cmm.word.sat01" />'],
	   	     weekHeader: 'Wk',
	   	     changeMonth: true, 	//월변경가능
	   	     changeYear: true, 	//년변경가능
	   	     yearRange:'-10:+10', 	// 연도 셀렉트 박스 범위(현재와 같으면 1988~현재년)
	   	     showMonthAfterYear: true, 	//년 뒤에 월 표시
	   	     autoSize: false	 //오토리사이즈(body등 상위태그의 설정에 따른다)
	   	     //접근성 옵션추가
	   	     , showOn : 'button'
	   	     , buttonImage : '/images/wzwg/site/mngr/datepicker.png'
	   	     , buttonText			: '<spring:message code="wzwg.module.word.inqireenddechoise" />'
	   	     , buttonImageOnly		: false
	   	     , closeText:'<spring:message code="wzwg.cmm.word.cancl" />'
	   	     , showButtonPanel: true
	   	  	 , beforeShow : function(inp, inst){
	   	    	 drawYear = inst.drawYear;
	   	    	 drawMonth = inst.drawMonth;
	   	     }
	   	  	 , onClose : function(text, inst){
	   	  		setFocusPoint('reset');
	   	    	$(".toDatePicker").next().focus();//호출 버튼 포커스 복귀
	   	     }
	   	  	}).on( "change", function() {
	          fromDate.datepicker( "option", "maxDate", $(this).val() );
	        }).focus(function(){
	        	setTimeout( datepickerWaAction , 250);
	        });
	        
	    toDate.datepicker( "option", "minDate", $(fromDate).val() );
	    <c:if test="${schdulBassInfoVO.initScrin ne 'L'}">
		fromDate.datepicker( "option", "maxDate", $(toDate).val() );
		</c:if>
		//button icon alt 변경
		$('.ui-datepicker-trigger img').attr('alt', '<spring:message code="wzwg.module.word.cldricon" />');
		
		//setCalendarText();
		
		//컬러리스트
		var colorList = getBgColorList();
		var listadd  = "";
		
		$(colorList).each( function(idx) {
			
			listadd = listadd + '<label>';
			listadd = listadd + '<input type="radio" id="colorCode'+idx+'" name="ctgryColorCode" value="'+colorList[idx].className+'" title="'+colorList[idx].title+' <spring:message code="wzwg.module.word.colchoise" />"  />';
			listadd = listadd + '<span class="p10 fl '+colorList[idx].className+'" wdith:10px;"></span>';
			listadd = listadd + '</label>';
            
			$('#colorList').append(listadd);
            
			listadd = "";
        });
		
		$('#colorCode0').attr('checked', true);
		
		$('.wzpopup .close').click(function(){
			$("#ui-datepicker-div").remove();
		});
		
    });
 
    function fnRegist() {
    	
        if(!confirm('<spring:message code="wzwg.cmm.msg.MSG135" />')){
            return;
        }else{

	 		if(!Validator.validate(document.regForm)){
	 			return;
	 		}
	 		var startDateTime = document.regForm.bgnde.value +  document.regForm.beginTime.value ;
	 		var endDateTime =  document.regForm.endde.value +  document.regForm.endTime.value ;
	 		if(startDateTime >= endDateTime){
	 			alert('<spring:message code="wzwg.cmm.msg.MSG358" />');
	 			return;
	 		}
	 		
	    	$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/schdul/registSchdulAjax.do'
				, dataType: 'xml'
				, data : $("#regForm").serialize()
				, success : function (result) {
						
		    	  	var value = "";
					
                    $(result).find("value").each(function() {  
                        value = $(this).text();  
                    });
                    
                    if(value == 'success'){
                           alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.word.schdul" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
                           //fnLayerPopupClose();
                           $("#ui-datepicker-div").remove();
                          fnSearch(wzPopCallBtn);
                           wzModalClose();
                    }else{
                        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
                    }
		    	  
				}
				, error : function (request, status, error) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
			});
        
        }
    }
    
</script>

        <form:form modelAttribute="paramVO" path="regForm" id="regForm" name="regForm" method="post">
            <form:hidden path="siteSeq" />
            
            <c:if test="${!empty param.schdulSeq}"><form:hidden path="schdulSeq" /></c:if>
            <c:if test="${empty param.schdulSeq}"><input type="hidden" value="<c:out value='${newSchdulSeq}'/>" name="schdulSeq" /></c:if>
            <c:set var="cnTit" ><spring:message code="wzwg.module.word.cninpcmpt" /></c:set>		    
		    <c:set var="schdulNmTit"><spring:message code="wzwg.module.word.schdulnm" /></c:set>		    
					<table class="basic">
						<caption><spring:message code="wzwg.cmm.cmmMsg.CMG024"><spring:argument><spring:message code="wzwg.module.word.schdulregistsj" />, <spring:message code="wzwg.cmm.word.pd" />, <spring:message code="wzwg.cmm.word.cn" />, <spring:message code="wzwg.cmm.word.ctgry03" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.wa.table"/></spring:argument></spring:message></caption>
						<colgroup>
							<col width="25%;" />
							<col width="*;" />
						</colgroup>
						<tbody>
						<tr>
	                        <th scope="row" ><spring:message code="wzwg.cmm.word.sj" /></th>
	                        <td>
	                            <form:input path="schdulNm" id="schdulNm" cssClass="w70" dir="required" title="${fn:escapeXml(schdulNmTit)}" />
	                        </td>
	                    </tr>
	                    <tr>
	                        <th scope="row" ><spring:message code="wzwg.cmm.word.pd" /></th>
	                        <td class="datep-box">
	                            <input type="text" name="bgnde" class="fromDatePicker cal" style="width:100px" tabindex="-1" dir="required,vdateFt=bgnde:endde" title="<spring:message code="wzwg.cmm.word.bgnde" />" readonly="readonly" value="<c:out value='${paramVO.searchDate}'/>" />
	                            <select id="beginTime" name="beginTime" style="width:65px" title="<spring:message code="wzwg.module.word.begintimese" />">
	                            	<c:forEach begin="0" end="23" varStatus="time">
	                            		<c:set var="hour" value="${time.count - 1}" />
	                            		<c:if test="${hour < 10}"><c:set var="hour" value="0${hour}" /></c:if>
	                            		<option value="${hour}"><c:out value="${hour}"/> <spring:message code="wzwg.cmm.word.hour" /></option>
	                            	</c:forEach>
	                            </select>
	                            <span>~</span>
	                            <input type="text" name="endde" class="toDatePicker cal" style="width:100px" tabindex="-1" dir="required,vdate" title="<spring:message code="wzwg.cmm.word.endde" />" readonly="readonly" value="<c:out value='${paramVO.searchDate}'/>" />
	                            <select name="endTime" id="endTime" style="width:65px" title="<spring:message code="wzwg.module.word.endtimese" />">
	                            	<c:forEach begin="0" end="23" varStatus="time">
	                            		<c:set var="hour" value="${time.count - 1}" />
	                            		<c:if test="${hour < 10}"><c:set var="hour" value="0${hour}" /></c:if>
	                            		<option value="${hour}"><c:out value="${hour}"/> <spring:message code="wzwg.cmm.word.hour" /></option>
	                            	</c:forEach>
	                            </select>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th scope="row" ><spring:message code="wzwg.cmm.word.cn" /></th>
	                        <td>
	                            <form:textarea path="cn" rows="5" cols="50" title="${fn:escapeXml(cnTit)}" />
	                        </td>
	                    </tr>
	                    
	                    <%-- <c:if test="${schdulBassInfoVO.fileUseAt eq 'Y'}">
	                    <tr>
	                        <th scope="row" ><spring:message code="wzwg.module.word.atchfile" /></th>
	                        <td>
								<c:import url="/module/upload/file/selectFileInc.do" charEncoding="utf-8">
									<c:param name="param_updateFlag" 		value="N" />
									<c:param name="param_atchFileNumber" 	value="3" />
									<c:param name="param_cntntsSeq" 		value="${param.schdulSeq}" />
								</c:import>
	                        </td>
	                    </tr>
	                    </c:if> --%>
	                    
	                    <tr>
	                        <th scope="row" ><spring:message code="wzwg.cmm.word.ctgry03" /></th>
	                        <td>
	                        	<div style="width: 325px;" id="colorList"></div>
	                        </td>
	                    </tr>
						</tbody>
					</table>
					
					<div class="rt-box">
							<button type="button" onclick="fnRegist();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.regist" /></button>
						<%-- <a href="javascript:void(0);" onclick="fnLayerPopupClose();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.close" /></a> --%> 
					</div>
		</form:form>
		