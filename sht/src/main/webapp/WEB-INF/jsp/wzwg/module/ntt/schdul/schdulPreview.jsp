<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>     
<script>

function fnModify() {
	
	//fnLayerPopupClose();
	
	$.ajax({
        type:'POST'
      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/schdul/modifySchdulFormAjax.do'
      , async : true
      , data:$("#detailForm").serialize()
      , success:function (data) {  
    	  //$("#divLayerPopup").html(data);
    	  //$("#divLayerPopup").show();
    	  wzModalClose();
    	  var title = '<spring:message code="wzwg.module.word.schdulupdt" />';
    	  wzAjaxModal('popup_s', title, data);
      }
      , error:function (request, status, error) {
 	     alert('<spring:message code="fail.common.msg" text="error" />');
      }
      , dataType: 'html'
 	});
}

function fnDelete() {
	
    if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006">'+
					'<spring:argument><spring:message code="wzwg.cmm.word.schdul" /></spring:argument>'+
					'<spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument>'+
				  '</spring:message>')){
        return;
    }else{
    	
    	$.ajax({
            type:'POST'
          , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/schdul/deleteSchdulAjax.do'
          , async : true
          , data:$("#previewForm").serialize()
          , success:function (result) {
        	  var value = "";
				
              $(result).find("value").each(function() {  
                  value = $(this).text();  
              });
              
              if(value == 'success'){
                  alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.word.schdul" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
                  /* $("#divLayerPopup").hide();
			      $("#divLayerPopup").empty();
			      $('body').css({overflow:'auto'}); */
			      //삭제시 포커스 유지를 위해 선택된 이벤트의 부모 날짜에 포커스 넣기
			      setParentDayId();
                  fnSearch();
			      $(".close").click();
               }else{
                  alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
               }
          }
          , error:function (request, status, error) {
     	     alert('<spring:message code="fail.common.msg" text="error" />');
          }
          , dataType: 'xml'
     	});
		
    }
}

function setParentDayId(){
	var openBtnId = $('#openBtnId').val();// pageCallCtrlSchdul.jsp 에 있는 hidden 객체
	var td = $('#' + openBtnId).parent().parent();
	console.log(td);
	var tr = td.parent();
	console.log(tr);
	var selectTd = $('.week .week_date.week_' + tr.attr('data-week')).find('td').eq(td.attr('data-day'));
	console.log(selectTd);
	$('#openBtnId').val(selectTd.find('a').attr('id'));
	console.log($('#openBtnId'));
}
</script>
	
		<form:form modelAttribute="detailVO" name="previewForm" id="previewForm" method="post" onsubmit="return false;">
			<form:hidden path="siteSeq" />
			<form:hidden path="schdetaSeq" />
		    	<div class="pop-conts">
					<table class="basic">
					<caption><spring:message code="wzwg.cmm.cmmMsg.CMG024"><spring:argument><spring:message code="wzwg.module.word.schdulsj" />, <spring:message code="wzwg.cmm.word.pd" />, <spring:message code="wzwg.cmm.word.cn" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.wa.table" /></spring:argument></spring:message></caption>
					<colgroup>
						<col width="25%;">
						<col width="*;">
					</colgroup>
					<tbody>
					<tr>
						<th scope="row" ><spring:message code="wzwg.cmm.word.sj" /></th>
						<td><c:out value="${detailVO.schdulNm}" /></td>
					</tr>
					<tr>
						<th scope="row" ><spring:message code="wzwg.cmm.word.pd" /></th>
						<td><c:out value="${detailVO.bgnde}"/> <c:out value="${detailVO.beginTime}"/><spring:message code="wzwg.cmm.word.hour" /> ~ <c:out value="${detailVO.endde}"/> <c:out value="${detailVO.endTime}"/><spring:message code="wzwg.cmm.word.hour" /></td>
					</tr>
					<tr>
						<th scope="row" ><spring:message code="wzwg.cmm.word.cn" /></th>
						<td><c:out value="${detailVO.cn}" escapeXml="false" /></td>
					</tr>
					</tbody>
					</table>
				
			        <!--//기본정보 table -->
				
					<div class="rt-box">
						<c:if test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or nttAuthVO.authorSe eq 'W'}">
						 	<button type="button" onclick="fnDelete();" class="wzbtn btn-del fl"><spring:message code="wzwg.cmm.word.delete" /></button>
						 	<button type="button" onclick="fnModify();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.updt" /></button>
						</c:if> 
						 <%-- <a href="javascript:void(0);" onclick="fnLayerPopupClose();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.close" /></a> --%> 
					</div>
				</div>
			
		</form:form>
       