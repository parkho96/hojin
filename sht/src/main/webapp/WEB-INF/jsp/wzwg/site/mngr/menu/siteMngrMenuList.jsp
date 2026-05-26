<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 
<script>
$(function() { 
	 $(".close").click(function(){
		location.href="<c:out value="${wzwg_contextPath}"/>/mngr/menu/bkmk/selectSiteMngrBkmkList.do"; 
	 });
});
function fnMngrMenuList() {
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/menu/bkmk/selectSiteMngrMenuListAjax.do'
		 , data:$("#listFrm").serialize() 
		 , success:function (data) { 
			 			wzAjaxModal('popup_s', '<spring:message code="wzwg.site.menu.msg.MSG047" />', data);
				   }
		 , dataType: 'html'
	});
}

function fnBkmkMenuAdd(value) { 
	 document.addFrm.mngrMenuSeq.value =value;
	
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/menu/bkmk/registSiteMngrBkmkAjax.do'
		, data:$("#addFrm").serialize() 
		 , success:function (data) {
			 	 if(data.result =='success'){
			 		 alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
			 		 return;
			 	 }
				   }
		 , dataType: 'html'
	});
}
</script>  

	 <form name="addFrm" id="addFrm" method="post">
		 <input type="hidden" name="mngrMenuSeq" id="mngrMenuSeq" />
		<table class="basic-table">	
				<thead>
					<tr>
						<th><spring:message code="wzwg.cmm.word.upperMenuNm" /></th>
						<th><spring:message code="wzwg.cmm.word.bkmkMenuNm" /></th>
						<th><spring:message code="wzwg.cmm.word.bkmkMenuLink" /></th> 
						<th class="wd10"><spring:message code="wzwg.cmm.word.manage" /></th>
					</tr>
				</thead>
				
				<tbody>
					<c:if test="${!empty mngrMenuList}">
					<c:forEach var="result" items="${mngrMenuList}" varStatus="status">
					<tr>
					 <td>
	                   <c:if test="${sessionScope.LANG eq 'SC00000016' }">
	                       <c:out value="${result.mngrParentMenuNm}"/>
	                    </c:if>
	                    <c:if test="${sessionScope.LANG eq 'SC00000019' }">
	                       <c:out value="${result.mngrParentMenuNmEng}"/>
	                    </c:if>
	                   </td>
	                   <td>
	                   <c:if test="${sessionScope.LANG eq 'SC00000016' }">
	                       <c:out value="${result.mngrMenuNm}"/>
	                    </c:if>
	                    <c:if test="${sessionScope.LANG eq 'SC00000019' }">
	                       <c:out value="${result.mngrMenuNmEng}"/>
	                    </c:if>
	                   </td>
	                   <td class="txt-l"><c:out value="${result.menuLinkUrl}"/></td> 
	                   <td><a href="javascript:;" onclick="fnBkmkMenuAdd('<c:out value="${result.mngrMenuSeq}"/>')" class="btn-plus iconOnlyBtn btn-basic ml0" title="<spring:message code="wzwg.cmm.word.add" />"><spring:message code="wzwg.cmm.word.add" /></a></td>
					</tr>
					</c:forEach>
					</c:if>
				</tbody>
		</table> 
		 
	</form>