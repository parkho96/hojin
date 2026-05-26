<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
function fnRegist() {

	if(!Validator.validate(document.regForm)){
		return;
	}
	
 	<c:choose>
	<c:when test="${empty resultVO.estbsinfoSeq}">
    document.regForm.action="<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/menuEstbs/registMenuEstbs.do";
	</c:when>
	<c:otherwise>
    document.regForm.action="<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/menuEstbs/modifyMenuEstbs.do";
	</c:otherwise>
	</c:choose>
	document.regForm.submit();
}

function fnList() {
	document.regForm.action="<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/menuEstbs/selectMenuEstbsList.do";
	document.regForm.submit();
}
$(document).ready(function(){
	$('#estbsinfoNm').focus();
});
</script>

                <form:form modelAttribute="resultVO" name="regForm" method="post">
                    <form:hidden path="estbsinfoSeq"/>
                    <input type="hidden" name="pageIndex" value="<c:out value="${paramVO.pageIndex}" />" />
					
					<!--기본정보 table// -->
                    
					<table class="basic">
						<colestbsinfo>
<!-- 							<col width="13%"/> -->
<!-- 							<col width="37%"/> -->
							<col width="13%"/>
							<col width="*"/>
						</colestbsinfo>
						<tbody>
<!--                             <tr> -->
<!--                                 <th>공동유대구분</th> -->
<!--                                 <td colspan="3"> -->
<!--                                     <select id="siteLclasGroup" name="siteLclasGroup"> -->
<!--                                         <option value="">::<spring:message code="wzwg.cmm.word.choise" />::</option> -->
<%--                                         <c:forEach var="result" items="${siteLclasGroupList}"> --%>
<%--                                             <option value="${result.cuCode}" <c:if test="${result.cuCode eq resultVO.siteLclasGroup}">selected="selected"</c:if>>${result.groupNm}</option> --%>
<%--                                         </c:forEach> --%>
<!--                                     </select>  -->
<!--                                 </td> -->
<!--                             </tr> -->
<!--                             <tr> -->
<!--                                 <th>지역본부코드</th> -->
<!--                                 <td>               -->
<!--                                     <select id="siteMlsfcGroup" name="siteMlsfcGroup"> -->
<!--                                         <option value="">::<spring:message code="wzwg.cmm.word.choise" />::</option> -->
<%--                                         <c:forEach var="result" items="${siteMlsfcGroupList}"> --%>
<%--                                             <option value="${result.cuCode}" <c:if test="${result.cuCode eq resultVO.siteMlsfcGroup}">selected="selected"</c:if>>${result.groupNm}</option> --%>
<%--                                         </c:forEach> --%>
<!--                                     </select>     -->
<!--                                 </td> -->
<!--                             </tr> -->
							<tr>
								<th><spring:message code="wzwg.sysMngr.word.menuEstbsNm01" />
									<span class="necessary">
										<span></span>
										<div><spring:message code="wzwg.cmm.word.essntl" /></div>
									</span>
								</th>
								<td colspan="3">
                                    <c:set var="msg_txt01">
										<spring:message code="wzwg.sysMngr.word.menuEstbsNm01" />
									</c:set>
                                    <form:input cssClass="w70" path="estbsinfoNm" id="estbsinfoNm" dir="required" placeholder="${fn:escapeXml(msg_txt01)}"/>
								</td>
							</tr>
							<tr>
								<th><spring:message code="wzwg.sysMngr.word.meunEstbsDc" />
									<span class="necessary">
										<span></span>
										<div><spring:message code="wzwg.cmm.word.essntl" /></div>
									</span>
								</th>
								<td colspan="3">
									<c:set var="msg_txt02">
										<spring:message code="wzwg.sysMngr.word.meunEstbsDc" />
									</c:set>
                                    <form:input cssClass="w70" path="estbsinfoDc" id="estbsinfoDc" dir="required" placeholder="${fn:escapeXml(msg_txt02)}"/>
								</td>
							</tr>
<!--                             <tr>
								<th><spring:message code="wzwg.cmm.word.estbs" /> <spring:message code="wzwg.cmm.word.at" /></th>
								<td>
                                    <input type="radio" id="estbsAt" name="estbsAt" value="Y" <c:if test="${resultVO.estbsAt eq 'Y'}">checked</c:if> /> <spring:message code="wzwg.cmm.word.estbs" />
                                    <input type="radio" id="estbsAt" name="estbsAt" value="N" <c:if test="${empty resultVO.estbsAt || resultVO.estbsAt eq 'N'}">checked</c:if> /> <spring:message code="wzwg.cmm.word.unestbs" />
								</td>
							</tr> -->
						</tbody>
					</table>
					<!--//기본정보 table -->
				</form:form>
				
				<div class="rt-box">
                    <c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
					<a href="javascript:void(0);" onclick="javascript:fnRegist(); return false;" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
                    </c:if>
                    <a href="javascript:void(0);" onclick="fnList();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
				</div>



<c:if test="${!empty resultVO.estbsinfoSeq}">
<script>
$(document).ready(function()
{
    
    fnListAjax();
});

//메뉴 정보를 조회
function fnRegistMenuAjax() {
    
    var siteId = document.getElementById("siteId").value;
    
    $.ajax({
           type:'POST'
         , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/menuEstbsInfo/registSiteMenuMngrFrmAjax.do'
         , data:{'estbsinfoSeq':'<c:out value="${resultVO.estbsinfoSeq}" />'} 
         , success:function (data) {
                //$("#divLayerPopup").html(data);
                //$("#divLayerPopup").show();
                     // 부모코드 셋팅 
                    // fnGetMenuList();
                     
                //   document.getElementById("menuNm").focus();
        	 	wzAjaxModal('popup_s', '<spring:message code="wzwg.sysMngr.word.menuRegist" />', data);
                   }
         , dataType: 'html'
    });
}

function fnSelectMenuAjax(menuSeq) {
    var siteId = document.getElementById("siteId").value;
    
    $.ajax({
           type:'POST'
         , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/menuEstbsInfo/modifySiteMenuMngrFrmAjax.do'
         , data:{'menuSeq':menuSeq,'estbsinfoSeq':'<c:out value="${resultVO.estbsinfoSeq}" />'} 
         , success:function (data) {
                //$("#divLayerPopup").html(data);
                //$("#divLayerPopup").show();
                     // 부모코드 셋팅 
                    // fnGetMenuList();
                //   document.getElementById("menuNm").focus();
        	 	wzAjaxModal('popup_s', '<spring:message code="wzwg.sysMngr.word.menuUpdt" />', data);
                   }
         , dataType: 'html'
    });
}

function fnListAjax(){
    $.ajax({
           type:'POST'
         , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/menuEstbsInfo/selectSiteMenuMngrListAjax.do'
         , data:{'estbsinfoSeq':'<c:out value="${resultVO.estbsinfoSeq}" />'} 
         , success:function (data) {
                $("#nestable1").html(data);
                     // 부모코드 셋팅 
                    // fnGetMenuList();
                     
                //   document.getElementById("menuNm").focus();
                   }
         , dataType: 'html'
    });
} 

function fnLayerPopupClose() {
       //$("#divLayerPopup").hide();
       //$("#divLayerPopup").empty();
       //$('body').css({overflow:'auto'});
       wzModalClose();
   }

</script>

<div class="mngrMenu">
    <h3 class="table_tit txt-l i-block wd-auto" style="min-width:auto;"><spring:message code="wzwg.sysMngr.word.menuStrct" /></h3>
    <form name="menuForm" id="menuForm" method="post">
        <input type="hidden" name="siteId" id="siteId" value="<c:out value="${siteId}" />" />
        <menu id="nestable-menu">
            <a data-action="expand-all" href="javascript:void(0);" class="wzbtn btn-basic btn-bottom"><spring:message code="wzwg.sysMngr.word.allOpen03" /></a>
            <a data-action="collapse-all" href="javascript:void(0);" class="wzbtn btn-basic btn-top"><spring:message code="wzwg.sysMngr.word.allClose" /></a>
            <!-- <a  href="javascript:void(0);" class="btn btn_default btn_xs" onclick="fnInsertMenuAllAjax();">정렬 저장</a> -->
            <a  href="javascript:void(0);" class="wzbtn btn-basic btn-plus txt-l" onclick="fnRegistMenuAjax();"><img src="/images/wzwg/site/mngr/layout/menuadminLink.png" alt="" class="vert-m mr5"> <spring:message code="wzwg.cmm.word.cnctmenu" /></a>
        </menu>
        
        <div class="dd" id="nestable1"></div>
    </form>
</div>


	<div class="wz_notice brbox bg-white clnone fl">
		 <h4 class="admpg-tit2"><spring:message code="wzwg.sysMngr.word.menuRegistRule" /></h4>
		 <ul class="wd100 mt20">
			<li class="admpg-subp wd100">1. <spring:message code="wzwg.cmm.msg.MSG129" /></li>
			<li class="admpg-subp wd100">2. <spring:message code="wzwg.cmm.msg.MSG130" /></li>
			<li class="admpg-subp wd100 mt20"><strong class="mr10">- <spring:message code="wzwg.sysMngr.word.linkMenu" /></strong><spring:message code="wzwg.cmm.msg.MSG346" /></li>
		</ul>
	</div>

<!-- 레이어팝업 영역 Start -->
<div id="divLayerPopup" class="pop-box"></div>
<!-- 레이어팝업 영역 End -->
</c:if>