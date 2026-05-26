<%@page import="egovframework.com.cmm.service.Globals"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<!-- 셀렉트 검색 라이브러리 -->
<link href="/js/wzwg/cmm/select2/select2.css" rel="stylesheet" />
<script src="/js/wzwg/cmm/select2/select2.js"></script>
<script src="https://t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		fnTabChange('bassInfo');
		
		$('#mapSelect').select2();
	});
	
	/** 타입 변경(기본정보, 데이터관리, 권한, 담당자) */
	function fnTabChange(paramValue){
		var pageUrl = "";
		
		if(paramValue == 'bassInfo'){
			pageUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/map/selectMapBassInfoDetailAjax.do'
		}else if(paramValue == 'dataManage'){
			pageUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/map/selectMapDetailAjax.do'
		}else if(paramValue == 'author'){
         //   document.getElementById('sitecntntsSeq').value = $.urlParam('sitecntntsSeq');
          //  pageUrl = '<c:out value="${prefix}"/>/cntnts/cntntsAuth/selectCntntsAuthListAjax.do';
        }else if(paramValue == 'cntPagadiEstbs'){
            pageUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/cntnts/cntPagadiEstbs/selectCntPagadiEstbsAjax.do';
        }
		
		$('#tabTyCode').val(paramValue);
		
		$('#searchCondition').val('');
		$('#searchKeyword').val('');
		$('#pageIndex').val(1);
		
		//console.log($("#mapFrm").serialize());
		$('#mapinfoSeq').val($('#mapSelect').val());
		
		$.ajax({
	        type:'POST'
	      , url:pageUrl
	      , cache : false
	      , async : false
	      , data:$("#mapFrm").serialize()
	      , success:function (data) {
	    	  $('#map_area').html(data);
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
	function fnChangeMapSeq(paramSeq){
		document.mapFrm.mapinfoSeq.value = paramSeq;
		document.mapFrm.cntntsSeq.value = paramSeq;
		
		fnTabChange($('#tabTyCode').val());
	}
	
	/** 컨텐츠 내용 삭제 */
	function fn_deleteMap(paramSeq){
		if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
			return;
		}else{
			document.mapFrm.mapSeq.value = paramSeq;
			
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/map/deleteModuleMapAjax.do'
				, data : $("#mapFrm").serialize()
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
	function fn_modifyMapForm(paramSeq){
		if(paramSeq != 'regist'){
			document.mapFrm.mapSeq.value = paramSeq;
		}
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/map/registModuleMApFormAjax.do'
			, cache : false
			, async : false
			, data:$("#mapFrm").serialize()
			, success:function (data) {
				$('#map_area').html(data);
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
	/** 컨텐츠 내용 초기화(데이터관리 리스트로 이동) */
	function fn_init(){
		document.mapFrm.mapSeq.value ='';
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/map/selectMapListAjax.do'
	      , cache : false
	      , async : false
	      , data:$("#mapFrm").serialize()
	      , success:function (data) {
	    	  $('#map_area').html(data);
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
			document.mapFrm.cntntsCnSeq.value = paramSeq;
		}
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/cntnts/registModuleCntntsCnFormAjax.do'
			, cache : false
			, async : false
			, data:$("#mapFrm").serialize()
			, success:function (data) {
				$('#cntnts_area').html(data);
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
</script>
	<c:set var="pageadiAt" value="<%=Globals.CNTNTS_PAGEADI_USEAT %>"/>
	<form:form modelAttribute="paramVO" path="mapFrm" id="mapFrm" name="mapFrm" method="post" onsubmit="return false;">
		<form:hidden path="searchCondition"/>
		<form:hidden path="searchKeyword"/>
		<form:hidden path="pageIndex"/>
		<form:hidden path="mapinfoSeq"/>
        <input type="hidden" name="sitecntntsSeq" id="sitecntntsSeq" value="<c:out value='${paramVO.sitecntntsSeq}'/>" />
		<input type="hidden" name="tabTyCode" id="tabTyCode" value=""/>
		<input type="hidden" name="mapSeq" id="mapSeq"/>
		
		<input type="hidden" name="cntntsCnSeq" id="cntntsCnSeq"/>
		
		<input type="hidden" name="mapTmplatSeq" id="mapTmplatSeq"/>
		
		<!-- 추가설정 cntseq -->
		<form:hidden path="cntntsSeq"/>
		
		<!-- 컨텐츠 목록 -->
		<select id="mapSelect" name="mapSelect" onchange="fnChangeMapSeq(this.value);" class="w20">
			<c:forEach var="moduleMapList" items="${moduleMapList}">
				<option value="<c:out value='${moduleMapList.mapinfoSeq}'/>" <c:if test="${paramVO.cntntsSeq eq moduleMapList.mapinfoSeq }">selected="selected"</c:if>><c:out value="${moduleMapList.mapNm }"/></option>
			</c:forEach>
		</select>
		
		<!-- tab 메뉴 -->
	    <div class="step wztab underLine theme-blue adminIcon">
	    	<ul class="tapMenu wztab-list">
				<li class="wztab-item"><span class="ico-info"></span><a href="javascript:void(0);" onclick="fnTabChange('bassInfo');" 		title="<spring:message code="wzwg.cmm.menu.bassinfo" />" 	id="bassInfo" 		name="bbsTab"><spring:message code="wzwg.cmm.menu.bassinfo" /></a></li>
				<c:if test="${sessionScope.SYSMNGR_AT ne 'Y' and pageadiAt eq 'Y'}">
				<li class="wztab-item"><span class="ico-info"></span><a href="javascript:void(0);" onclick="fnTabChange('cntPagadiEstbs');" title="<spring:message code="wzwg.module.word.addestbs" />" id="cntPagadiEstbs" name="bbsTab"><spring:message code="wzwg.module.word.addestbs" /></a></li>
				</c:if>
				<li class="wztab-item"><span class="ico-data"></span><a href="javascript:void(0);" onclick="fnTabChange('dataManage');" 	title="<spring:message code="wzwg.cmm.menu.datamanage" />" 	id="dataManage" 	name="bbsTab"><spring:message code="wzwg.cmm.menu.datamanage" /></a></li>
			</ul>
		</div>
		
		<div id="map_area" class="w100"></div>
	</form:form>
	
	