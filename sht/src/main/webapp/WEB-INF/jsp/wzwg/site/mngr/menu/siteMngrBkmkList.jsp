<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 
<script>
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

function fnBkmkMenuDel(mngrBkmkSeq) {
	console.log(mngrBkmkSeq);
	 document.listFrm.mngrBkmkSeq.value =mngrBkmkSeq;
	
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/menu/bkmk/deleteSiteMngrBkmkAjax.do'
		, data:$("#listFrm").serialize() 
		 , success:function (data) {
			 	 if(data.result =='success'){
			 		 alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
			 		 location.href="<c:out value="${wzwg_contextPath}"/>/mngr/menu/bkmk/selectSiteMngrBkmkList.do";
			 	 }
				   }
		 , dataType: 'html'
	});
}
</script>  

	<div class="wz_notice brbox bg-white br-blue-strong" style="overflow: visible;">
	        <ul class="wd100">
	                <li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG159" /></li>
	                <li class="admpg-subp wd100 wzAdmSTit p0 mb0" style="background: transparent;">· <spring:message code="wzwg.cmm.msg.tip.MSG0022" />
	                <div class="menu_help">
		                <img src="/images/wzwg/site/mngr/ico_help_grey.png" alt="">
		                <div class="help_pop"><img src="/images/wzwg/site/mngr/helpimg_bmrkmenu.jpg"></div>
                    </div>
	            </li>
	        </ul>
	</div>

	 <form name="listFrm" id="listFrm" method="post">
		 <input type="hidden" name="mngrBkmkSeq" id="mngrBkmkSeq" />
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
					<c:if test="${!empty resultList}">
					<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
					<td>
	                   <c:if test="${sessionScope.LANG eq 'SC00000016' }">
	                       <c:out value="${result.mngrParentMenuNm}"/>
	                    </c:if>
	                    <c:if test="${sessionScope.LANG ne 'SC00000016' }">
	                       <c:out value="${result.mngrParentMenuNmEng}"/>
	                    </c:if>
	                   </td>
	                   <td>
	                   	<c:if test="${sessionScope.LANG eq 'SC00000016' }">
	                       <c:out value="${result.mngrMenuNm}"/>
	                    </c:if>
	                    <c:if test="${sessionScope.LANG ne 'SC00000016' }">
	                       <c:out value="${result.mngrMenuNmEng}"/>
	                    </c:if>
	                   </td>
	                   <td class="txt-l"><c:out value="${result.menuLinkUrl}"/></td> 
	                   <td><a href="javascript:;" onclick="fnBkmkMenuDel('<c:out value="${result.mngrBkmkSeq}"/>')" class="btn-delete iconOnlyBtn btn-basic" title="<spring:message code="wzwg.cmm.word.delete" />"><spring:message code="wzwg.cmm.word.delete" /></a></td>
					</tr>
					</c:forEach>
					</c:if>
				</tbody>
		</table> 
		
	    <div class="rt-box">
			<a href="javascript:void(0);" onclick="javascript:fnMngrMenuList();" class="wzbtn btn-save bg"><spring:message code="wzwg.cmm.word.regist" text="registration" /></a>
        </div> 
	</form>