<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<link type="text/css" href='/css/wzwg/module/ntt/basic/unityBoard.css' rel="stylesheet">
<link type="text/css" href="/css/wzwg/site/mngr/form.css" rel="stylesheet" />
<link href="/css/wzwg/cmm/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>

<script type="text/javascript">
try{document.title = '<spring:message code="wzwg.cmm.word.mberinfo" />-<spring:message code="wzwg.cmm.word.scraplist" />';}catch(e){console.log(e.message);}
	$(document).ready(function(){
		fnGroupChage('');
	});
	
	function fnGroupChage(scrapgroupSeq){
		
		document.getElementById('searchCondition').value = '';
		document.getElementById('searchKeyword').value = '';
		document.getElementById('pageIndex').value = 1;
		
		$('#scrapgroupSeq').val(scrapgroupSeq);
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}" />/cmm/mber/myPage/selectMyScrapListAjax.do'
	      , cache : false
	      , async : false
	      , data:$("#myFrm").serialize()
	      , success:function (data) {
	    	  $('#list_area').html(data);
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
	
	function fnScrapGroupChage(scrapgroupSeq){
		fnGroupChage(scrapgroupSeq);
		$('#btn-scrapGroupList').focus();
	}
</script>
             
    <form:form modelAttribute="paramVO" id="myFrm" name="myFrm" method="post" onsubmit="return false;">
	    <form:hidden path="siteSeq" />
		<form:hidden path="pageIndex" />
		<form:hidden path="searchCondition" />
		<form:hidden path="searchKeyword" />
		<form:hidden path="scrapgroupSeq" />
    </form:form>
    
    <label for="groupSel"><spring:message code="wzwg.cmm.word.scrapgroup" /> :</label>
	<select id="groupSel" class="w30">
		<option value=""><spring:message code="wzwg.cmm.word.all" /></option>
		<c:forEach var="scrapgroupList" items="${scrapgroupList}">
			<option value="<c:out value="${scrapgroupList.scrapgroupSeq}" />" <c:if test="${paramVO.scrapgroupSeq eq scrapgroupList.scrapgroupSeq}">selected="selected"</c:if>><c:out value="${scrapgroupList.groupNm}" /></option>
		</c:forEach>
	</select>
	<button type="button" class="wzbtn btn-basic" id="btn-scrapGroupList" onclick="fnScrapGroupChage($('#groupSel').val());"><spring:message code="wzwg.cmm.word.change" /></button>
	
    <div id="list_area"></div>
