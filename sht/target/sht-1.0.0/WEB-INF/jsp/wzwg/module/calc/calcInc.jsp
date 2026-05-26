<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
	$(document).ready(function(){
		fnTabChange('bassInfo');
	});
	
	/** 타입 변경(기본정보, 데이터관리, 권한, 담당자) */
	function fnTabChange(paramValue){
		var pageUrl = "";
		
		if(paramValue == 'bassInfo'){
			pageUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/calc/selectCalcBassInfoDetailAjax.do'
		}else if(paramValue == 'dataManage'){
			pageUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/calc/selectCalcDetailAjax.do'
		}else if(paramValue == 'author'){
         //   document.getElementById('sitecntntsSeq').value = $.urlParam('sitecntntsSeq');
          //  pageUrl = '<c:out value="${prefix}"/>/cntnts/cntntsAuth/selectCntntsAuthListAjax.do';
        }
		
		$('#tabTyCode').val(paramValue);
		
		$('#searchCondition').val('');
		$('#searchKeyword').val('');
		$('#pageIndex').val(1);
		
		//console.log($("#calcFrm").serialize());
		//$('#calcinfoSeq').val($('#cntntsSeq').val());
		var dataForm = $("#calcFrm").serialize();
		//console.log(dataForm);
		$.ajax({
	        type:'POST'
	      , url:pageUrl
	      , cache : false
	      , async : false
	      , data: dataForm
	      , success:function (data) {
	    	  $('#calc_area').html(data);
	          $(".step > .tapMenu > li > a").removeClass("on");
	          $("#"+paramValue).addClass("on");	          
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
	
	/** 컨텐츠 선택 */
	function fnChangeCalcSeq(paramSeq){
		document.calcFrm.calcinfoSeq.value = paramSeq;
		fnTabChange($('#tabTyCode').val());
	}
	
	/** 컨텐츠 내용 삭제 */
	function fn_deleteCalc(paramSeq){
		if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
			return;
		}else{
			document.calcFrm.calcSeq.value = paramSeq;
			
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/calc/deleteModuleCalcAjax.do'
				, data : $("#calcFrm").serialize()
				, success : function (result) {
					$(result).find('value').each(function(){
						if($(this).text() == "success"){
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
							fn_init();
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
						}
					})
				}
				, error : function (request, status, error) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
			});
		}
	}
	
	/** 컨텐츠 내용 수정 */
	function fn_modifyCalcForm(paramSeq){
		if(paramSeq != 'regist'){
			document.calcFrm.calcSeq.value = paramSeq;
		}
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/calc/registModuleCalcFormAjax.do'
			, cache : false
			, async : false
			, data:$("#calcFrm").serialize()
			, success:function (data) {
				$('#calc_area').html(data);
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
	/** 컨텐츠 내용 초기화(데이터관리 리스트로 이동) */
	function fn_init(){
		document.calcFrm.calcSeq.value ='';
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/calc/selectCalcListAjax.do'
	      , cache : false
	      , async : false
	      , data:$("#calcFrm").serialize()
	      , success:function (data) {
	    	  $('#calc_area').html(data);
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}

	
	
	/** 컨텐츠 내용 수정 */
	function fn_modifyCntntsCnForm(paramSeq){
		if(paramSeq != 'regist'){
			document.calcFrm.cntntsCnSeq.value = paramSeq;
		}
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/cntnts/registModuleCntntsCnFormAjax.do'
			, cache : false
			, async : false
			, data:$("#calcFrm").serialize()
			, success:function (data) {
				$('#cntnts_area').html(data);
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
</script>
	
	<form:form modelAttribute="paramVO" path="calcFrm" id="calcFrm" name="calcFrm" method="post" onsubmit="return false;">
		<form:hidden path="searchCondition"/>
		<form:hidden path="searchKeyword"/>
		<form:hidden path="pageIndex"/>
		<form:hidden path="calcinfoSeq"/>
        <input type="hidden" name="sitecntntsSeq" id="sitecntntsSeq" value="<c:out value='${paramVO.sitecntntsSeq}'/>" />
		<input type="hidden" name="tabTyCode" id="tabTyCode" value=""/>
		<input type="hidden" name="calcSeq" id="calcSeq"/>
		
		<input type="hidden" name="cntntsSeq" id="cntntsSeq" value="<c:out value='${paramVO.cntntsSeq }'/>"/>
		
		<!-- 컨텐츠 목록 -->
		<select id="mapSelect" name="mapSelect" onchange="fnChangeCalcSeq(this.value);" class="w20">
			<c:forEach var="moduleCalcList" items="${moduleCalcList}">
				<option value="<c:out value='${moduleCalcList.calcinfoSeq }'/>" <c:if test="${paramVO.cntntsSeq eq moduleCalcList.calcinfoSeq }">selected="selected"</c:if>><c:out value="${moduleCalcList.calcNm }"/></option>
			</c:forEach>
		</select>
		
		<!-- tab 메뉴 -->
	    <div class="step">
	    	<ul class="tapMenu">
				<li><a href="javascript:void(0);" onclick="fnTabChange('bassInfo');" 	title="<spring:message code="wzwg.cmm.menu.bassinfo" />" 	id="bassInfo" 	name="bbsTab"><spring:message code="wzwg.cmm.menu.bassinfo" /></a></li>
				<li><a href="javascript:void(0);" onclick="fnTabChange('dataManage');" 	title="<spring:message code="wzwg.cmm.menu.datamanage" />" 	id="dataManage" name="bbsTab"><spring:message code="wzwg.cmm.menu.datamanage" /></a></li>
			</ul>
		</div>
		
		<div id="calc_area" class="w100"></div>
	</form:form>
	
	