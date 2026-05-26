<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script language="javascript" type="text/javascript" src="/jquery/js/jquery.form.min.js"></script>

<script>
	$(document).ready(function(){
		fnTabLink('dataManage');
	});

	function fnTabLink(tab, init){
		
		var formData = {}
		
		if(init){
			$('#srchCtgryCd').val('');
			$('#srchPblcSn').val('');
		}
		
		formData.searchCondition = $("#searchCondition").val();
		formData.searchKeyword = $("#searchKeyword").val();
		
        var dataUrl = '';
		if(tab == 'dataManage' || tab ==''){
			dataUrl ="<c:out value='${wzwg_contextPath}'/>/mngr/module/beffatPlbc/selectBeffatPlbcListAjax.do";
		}else if(tab == 'category'){
			dataUrl ="<c:out value='${wzwg_contextPath}'/>/mngr/module/beffatPlbc/selectBeffatPlbcCategoryListAjax.do";
		}
		
		$.ajax({
			type : 'POST'
			, url : dataUrl
			, data : formData
			, success : function (data) {
				$("#beffatPlbcArea").html(data); 
				//$("#beffatPlbcFrmArea").hide(); 
				//$("#beffatPlbcArea").show(); 
				
				$(".step > .tapMenu > li > a").removeClass("on");
		        $("#"+tab).addClass("on");
			}
			, error : function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
	function fnBeffatPlbcMainRegFrm(){
		var formData = {}

		$.ajax({
			type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}"/>/mngr/module/beffatPlbc/selectBeffatPlbcMainRegFrmAjax.do'
			, data : formData
			, success : function (data) {
				$("#beffatPlbcArea").html(data); 
				//$("#beffatPlbcFrmArea").html(data);
				//$('#beffatPlbcFrmArea').show();
			}
			, error : function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
	function fnBplbcListModifyMainData(pblcSn){
		var formData = {}
		formData.pblcSn = pblcSn;
		formData.frmTy = 'modify';
		formData.searchCondition = $("#searchCondition").val();
		formData.searchKeyword = $("#searchKeyword").val();

		$.ajax({
			type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}"/>/mngr/module/beffatPlbc/selectBeffatPlbcMainRegFrmAjax.do'
			, data : formData
			, success : function (data) {
				$("#beffatPlbcArea").html(data); 
				//$("#beffatPlbcFrmArea").html(data);
				//$('#beffatPlbcFrmArea').show();
			}
			, error : function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
	
	function fnBeffatPlbcSubRegFrm(pblcSn){
		var formData = {}
		formData.pblcSn = pblcSn;
		
		$.ajax({
			type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}"/>/mngr/module/beffatPlbc/selectBeffatPlbcSubRegFrmAjax.do'
			, data : formData
			, success : function (data) {
				$("#beffatPlbcArea").html(data); 
				//$("#beffatPlbcFrmArea").html(data);
				//$('#beffatPlbcFrmArea').show();
			}
			, error : function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
	function fnBeffatPlbcSubModifyFrm(pblcSn, listSn){
		var formData = {}
		formData.pblcSn = pblcSn;
		formData.listSn = listSn;
		formData.frmTy = 'modify';
		
		$.ajax({
			type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}"/>/mngr/module/beffatPlbc/selectBeffatPlbcSubRegFrmAjax.do'
			, data : formData
			, success : function (data) {
				$("#beffatPlbcArea").html(data)
				//$("#beffatPlbcFrmArea").html(data);
				//$('#beffatPlbcFrmArea').show();
			}
			, error : function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
	function fnBeffatPlbcSubRegFrmCancel(){
		$("#beffatPlbcFrmArea").hide(); 
		$("#beffatPlbcArea").show(); 
	}
	
	
</script>
<input type="hidden" name="srchCtgryCd" id="srchCtgryCd" value="">
<input type="hidden" name="srchPblcSn" id="srchPblcSn" value="">

<!-- 관리자 탭 -->
	<div class="step wztab underLine theme-blue">
	   	<ul class="tapMenu"> 
			<li class="wztab-item"><a href="javascript:void(0);" onclick="fnTabLink('dataManage', true);" 	title="<spring:message code="wzwg.cmm.menu.datamanage" />" 		id="dataManage"  ><spring:message code="wzwg.cmm.menu.datamanage" /></a></li>
			<li class="wztab-item"><a href="javascript:void(0);" onclick="fnTabLink('category');" 	title="<spring:message code="wzwg.cmm.word.ctgry02"/>" 	id="category"  ><spring:message code="wzwg.module.word.ctgrymanage" /></a></li>
		</ul>
	</div>
	
	<div id="beffatPlbcArea"></div>
	<!-- <div id="beffatPlbcFrmArea" style="display:none;"></div> -->