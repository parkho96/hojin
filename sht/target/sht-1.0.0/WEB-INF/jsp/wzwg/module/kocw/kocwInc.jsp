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
			pageUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/kocw/kocwFormAjax.do'
		}else if(paramValue == 'dataManage'){
			pageUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/kocw/selectKocwListAjax.do'
		}else if(paramValue == 'author'){
            document.getElementById('sitecntntsSeq').value = $.urlParam('sitecntntsSeq');
            pageUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/cntnts/cntntsAuth/selectCntntsAuthListAjax.do';
        }
		
		$('#tabTyCode').val(paramValue);
		
		$('#searchCondition').val('');
		$('#searchKeyword').val('');
		
		$.ajax({
	        type:'POST'
	      , url:pageUrl
	      , cache : false
	      , async : false
	      , data:$("#kocwFrm").serialize()
	      , success:function (data) {
              $('#kocw_area').html(data);
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
		
		fnTabChange($('#tabTyCode').val());
	}
	
	/** 컨텐츠 내용 삭제 */
	function fn_deleteMap(paramSeq){
		if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
			return;
		}else{
			document.kocwFrm.mapSeq.value = paramSeq;
			
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/kocw/deleteModuleMapAjax.do'
				, data : $("#kocwFrm").serialize()
				, success : function (result) {
					$(result).find('value').each(function(){
						if($(this).text() == "success"){
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
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
			document.kocwFrm.mapSeq.value = paramSeq;
		}
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/kocw/registModuleMApFormAjax.do'
			, cache : false
			, async : false
			, data:$("#kocwFrm").serialize()
			, success:function (data) {
				$('#kocw_area').html(data);
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
</script>
	
	<form:form modelAttribute="paramVO" path="kocwFrm" id="kocwFrm" name="kocwFrm" method="post" onsubmit="return false;">
		<form:hidden path="searchCondition"/>
		<form:hidden path="searchKeyword"/>
		<form:hidden path="pageIndex"/>
        <input type="hidden" name="sitecntntsSeq" id="sitecntntsSeq" value="<c:out value='${paramVO.sitecntntsSeq}'/>" />
		<input type="hidden" name="tabTyCode" id="tabTyCode" value=""/>
		
		<!-- tab 메뉴 -->
	    <div class="step">
	    	<ul class="tapMenu">
				<li><a href="javascript:void(0);" onclick="fnTabChange('bassInfo');" 	title="기본정보" 	id="bassInfo" 	name="bbsTab"><spring:message code="wzwg.cmm.word.bass" /> <spring:message code="wzwg.cmm.word.info" /></a></li>
				<li><a href="javascript:void(0);" onclick="fnTabChange('dataManage');" 	title="데이터관리" 	id="dataManage" name="bbsTab"><spring:message code="wzwg.cmm.word.data" /> <spring:message code="wzwg.cmm.word.manage" /></a></li>
				<li><a href="javascript:void(0);" onclick="fnTabChange('author');" 		title="권한" 		id="author" 	name="bbsTab"><spring:message code="wzwg.cmm.word.author" /></a></li>
				<!-- 
				<li><a href="javascript:void(0);" onclick="fnTabChange('charger');" 	title="<spring:message code="wzwg.cmm.word.charger" />" 	id="charger" 	name="bbsTab">담당자</a></li>
				-->
			</ul>
		</div>
		
	</form:form>
	<div id="kocw_area" class="w100"></div>
	
	