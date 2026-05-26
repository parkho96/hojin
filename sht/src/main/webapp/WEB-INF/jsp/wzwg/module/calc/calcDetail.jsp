<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<style type="text/css">
.calcDash {border: dashed 2px #3899ec; min-height: 14px; min-width: 50px; }
</style>
<script type="text/javascript">
	$(document).ready(function(){
		fn_calcView();
		changeCss();
		$('input[name="calcCss"]:radio[value="<c:out value="${result.calcCss}"/>"]').prop('checked',true);
	});
	
	var status = '0<c:out value="${result.calcType }"/>'; // 0이면 등록 1이면 수정
	
	function calcRegist(){
		
		var ajaxUrl = '';
		if(status == '0'){
			ajaxUrl = '<c:out value="${wzwg_contextPath}"/>/module/calc/registModuleCalcAjax.do';
		}else{
			ajaxUrl = '<c:out value="${wzwg_contextPath}"/>/module/calc/modifyModuleCalcAjax.do';
		}
		
		removeContentTxt();
		calcTextClean();
		
		$('#calcCn').val($('#calcContents').html());
		
		var formData = $("#calcBassForm").serialize();
		
		//console.log(formData);
		
			$.ajax({
		        type:'POST'
		      , url: ajaxUrl
		      , data : formData 
		      , cache : false
		      , async : true
		      , success:function (data) {
		    	  status = '1';
		    	  alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
		    	  writeContentTxt();
		      }
		      , error:function (data) {
		          alert('<spring:message code="fail.common.msg" text="error" />');
		      }
		      , dataType: 'json'
		 	}); 
		
		
	}
	
	function fn_calcCntsDelete(){
		$.ajax({
	        type:'POST'
	      , url: '<c:out value="${wzwg_contextPath}"/>/module/calc/modifyModuleCalcCnDeleteAjax.do'
	      , data : $("#calcBassForm").serialize()
	      , cache : false
	      , async : true
	      , success:function (data) {
	    	  fn_calcView();
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	}); 
	}
	
	function fn_calcView(){
		$.ajax({
	        type:'POST'
	      , url: '<c:out value="${wzwg_contextPath}"/>/module/calc/selectCalcViewAjax.do'
	      , data : $("#calcBassForm").serialize()
	      , cache : false
	      , async : true
	      , success:function (data) {
	    	 $('#clacViewArea').show();
	    	 $('#calcView').html(data);
	    	 writeContentTxt();
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	}); 
	}
	
	function writeContentTxt(){
//		 $('.edt_text').css('border', 'dashed 1px #3899ec');
		 $('.edt_text').addClass('calcDash');
		 $('.edt_text').attr('contenteditable', 'true');
	}
	 
	function removeContentTxt(obj){
		$('.edt_text').removeAttr('contenteditable');
		$('.edt_text').removeClass('calcDash');
//		$('.edt_text').css('border', '');
	}
	
	function calcTextClean(){
		$('.edtClean').each(function(idx,el){
			$(this).html('');
		});
	}
	
	function changeCss(){
		$('input:radio[name="calcCss"]').on('click',function(e){
			//console.log(e);
			//console.log($(this).val());
			var cssPath = $(this).val();
			var cssObj = $('#calcCssPath');
			cssObj.attr('href', cssPath);
			/* if(cssObj.size() == 0){
				
			}else{
				cssObj.attr('src', cssPath);
			} */
		});
	}
  
</script>

	<form id="calcBassForm" name="calcBassForm" method="post" onsubmit="return false">
        <input type="hidden" name="sitecntntsSeq" id="sitecntntsSeq" value="<c:out value='${resultVO.sitecntntsSeq}'/>"/>
		<input type="hidden" name="calcinfoSeq" id="calcinfoSeq" value="<c:out value='${resultVO.calcinfoSeq }'/>"/>
		<textarea id="calcCn" name="calcCn" style="display:none"><c:out value='${resultVO.calcCn }'/></textarea>
		<link type="text/css" href="<c:out value='${result.calcCss }'/>" id="calcCssPath" rel="stylesheet" />
		<table class="basic">
			<colgroup>
				<col width="15%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
				<tr>
					<th>계산기 선택</th>
					<td>
						<select name="calcType" id="calcType" class="w70" onchange="fn_calcView()">
							<option value="usrCalc01" <c:if test="${'usrCalc01' eq result.calcType }">selected="selected"</c:if>>예금계산기 이율입력형</option>
							<option value="usrCalc02" <c:if test="${'usrCalc02' eq result.calcType }">selected="selected"</c:if>>예금계산기 이율고정형</option>
							<option value="usrCalc03" <c:if test="${'usrCalc03' eq result.calcType }">selected="selected"</c:if>>예금계산기03 탭형식</option>
							<option value="usrCalc04" <c:if test="${'usrCalc04' eq result.calcType }">selected="selected"</c:if>>대출계산기</option>
						</select>
						<a href="javascript:void(0);" onclick="javascript:fn_calcCntsDelete();" class="btn-c"><spring:message code="wzwg.cmm.word.initl" /></a>
						
						<%-- <input type="text" name="calcType" id="calcType" class="w70" value="${result.calcType }" dir="required" title="주소"/>
						<a href="javascript:void(0);" onclick="javascript:fn_calcView();" class="btn-c"><spring:message code="wzwg.cmm.word.preview" /></a> --%>
					</td>
				</tr>
				<tr>
					<th>스타일 선택</th>
					<td>
						<label><input type="radio" name="calcCss" value=""/>기본</label>
						<label style="margin-left: 10px;"><input type="radio" name="calcCss" value="/css/wzwg/module/calc/cal_skin_blue.css"/>BLUE</label>
						<label style="margin-left: 10px;"><input type="radio" name="calcCss" value="/css/wzwg/module/calc/cal_skin_blueline.css"/>BLUE(line)</label>
						<label style="margin-left: 10px;"><input type="radio" name="calcCss" value="/css/wzwg/module/calc/cal_skin_greenbg.css"/>GREEN</label>
						<label style="margin-left: 10px;"><input type="radio" name="calcCss" value="/css/wzwg/module/calc/cal_skin_greenline.css"/>GREEN(line)</label>
						<label style="margin-left: 10px;"><input type="radio" name="calcCss" value="/css/wzwg/module/calc/cal_skin_greybg.css"/>GRAY</label>
						<label style="margin-left: 10px;"><input type="radio" name="calcCss" value="/css/wzwg/module/calc/cal_skin_greyline.css"/>GRAY(line)</label>
						<label style="margin-left: 10px;"><input type="radio" name="calcCss" value="/css/wzwg/module/calc/cal_skin_orangebg.css"/>ORANGE</label>
						<label style="margin-left: 10px;"><input type="radio" name="calcCss" value="/css/wzwg/module/calc/cal_skin_orangeline.css"/>ORANGE(line)</label>
					</td>
				</tr>
				<tr id="clacViewArea" style="display:none;">
					<th><spring:message code="wzwg.cmm.word.preview" /></th>
					<td id="calcView"></td>
				</tr>
				
		</table>
	</form>

	<div class="rt-box">
		<a id="tmplatAddBtn" style="display:none;" href="javascript:void(0);" class="btn-a" onclick="fn_selectTmplatCn();">템플릿 초기화</a>
        <a href="javascript:void(0);" id="regist_btn" onclick="javascript:calcRegist();" class="btn-a"><spring:message code="wzwg.cmm.word.stre" /></a>
		<a href="javascript:void(0);" id="reset_btn" onclick="javascript:fnCancel();" class="btn-b"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>

	<script>
	$(document).ready(function(){ 
		//dataInit();
	});
	</script>