<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script type="text/javascript">
function fnRegistFrom() {
    document.frmSrh.action="<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/sysSiteStplat/info/selectSysStplatInfoForm.do";
    document.frmSrh.submit();
}

function fnDetail(stplatSeq) {
    document.frmSrh.stplatSeq.value = stplatSeq;
    
    document.frmSrh.action="<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/sysSiteStplat/info/selectSysStplatInfoDetail.do";
    document.frmSrh.submit();
}

function fnPage(pageIndex) {
    if(isNaN(pageIndex)){console.log('잘못된 페이지호출');return;}
    document.listForm.pageIndex.value = pageIndex;
    document.listForm.action="<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/sysSiteStplat/info/selectSysStplatInfoList.do";
    document.listForm.submit();
}

function fnDelete(stplatSeq){
	if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
		return;
	} else {
		
		$("#stplatSeq").val(stplatSeq);
		
		$.ajax({
			type:'POST'
			, url:'<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/sysSiteStplat/info/deleteSysStplatInfoAjax.do'
			, data:$("#frmSrh").serialize()
			,success:function (result){
				$(result).find('value').each(function(){
					if($(this).text() == "success"){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
						fnPage(1);
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
					}
				})
			}
			, error:function (request, status, error) {
		             alert('<spring:message code="fail.common.msg" text="error" />');
			}
		});

	}

}

function fnDefaultChange(paramSeq, paramValue){
	document.frmSrh.stplatSeq.value = paramSeq;
	document.frmSrh.defaultAt.value = paramValue;
	
	$.ajax({
		type:'POST'
		, url:'<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/sysSiteStplat/info/modifySysStplatInfoDefaultAjax.do'
		, data:$("#frmSrh").serialize()
		,success:function (result){
			$(result).find('value').each(function(){
				if($(this).text() == "success"){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>');
					location.href='<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/sysSiteStplat/info/selectSysStplatInfoList.do';
				}else{
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
				}
			})
		}
		, error:function (request, status, error) {
	             alert('<spring:message code="fail.common.msg" text="error" />');
		}
	});
}

function fnApply(paramSeq){
	if(!confirm('<spring:message code="wzwg.cmm.msg.MSG344"/>')){
		return ;
	}else{
		document.frmSrh.stplatSeq.value = paramSeq;
		
		$.ajax({
			type:'POST'
			, url:'<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/sysSiteStplat/info/registSysStplatInfoAllSiteApplyAjax.do'
			, data:$("#frmSrh").serialize()
	     	, beforeSend: fnLoadingOpen
			,success:function (result){
				$(result).find('value').each(function(){
					if($(this).text() == "success"){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.applc" /></spring:argument></spring:message>');
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.applc" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
					}
				})
			}
		  	, complete: fnLayerPopupClose
			, error:function (request, status, error) {
		             alert('<spring:message code="fail.common.msg" text="error" />');
			}
		});
	}
}

function fnLoadingOpen(){
	var popupContent = $('#apply_pop').html();
	$("#divLayerPopup").html(popupContent);
	$("#divLayerPopup").show();
}

function fnLayerPopupClose() {
    $("#divLayerPopup").hide();
    $("#divLayerPopup").empty();
    $('body').css({overflow:'auto'});
}


</script>

		<!-- 작업중 모달내용 -->
		<div id="apply_pop" style="display: none;">
			<div class="apply_pop" style="position: absolute; top: 45%; left: 45%; line-height: 20px;">
				<img src="/images/wzwg/cmm/loading.gif" alt="" />
			</div>
		</div>
		<!-- 작업중 모달내용 end -->

		<!-- 레이어팝업 영역 Start -->
		<div id="divLayerPopup" class="modal fade in"></div>
		<!-- 레이어팝업 영역 End -->
		                    
                    <form name="frmSrh" id="frmSrh" method="post">
                        <input type="hidden" id="stplatSeq" name="stplatSeq" value="<c:out value="${paramVO.stplatSeq}" />" />
                        <input type="hidden" id="defaultAt" name="defaultAt" value="" />
                    </form>
                    
                    <div class="wz_notice brbox bg-white br-blue-strong" style="overflow: visible;">	
						<ul class="wd100">
							<li class="admpg-subp wd100 mb0">· <spring:message code="wzwg.cmm.msg.tip.MSG138" /></li>
						</ul>
					</div>
                    
                    <!--//게시판명 table -->
                        <form name="listForm" id="listForm" method="post">
                            <input type="hidden" name="pageIndex" value="<c:out value="${paramVO.pageIndex}" />" />
                            <input type="hidden" id="siteSeq" name="siteSeq" value="<c:out value="${paramVO.siteSeq}" />" />
                        </form>
                    
                    <!--//게시판 설정 table -->
                    <table summary="약관관리 목록" class="basic-table">
                        <colgroup>
                            <col width="5%"/>
                            <col width="7%"/>
                            <col width="*"/>
                            <col width="12%"/>
                            <col width="10%"/>
                            <col width="12%"/>
                            <col width="10%"/>
                            <col width="20%"/>
                        </colgroup>
                        <thead>
	                        <tr>
	                            <th>No</th>
	                            <th><spring:message code="wzwg.cmm.word.ty" /></th>
	                            <th><spring:message code="wzwg.sysMngr.word.stplatAndPolicyNm01" /></th>
	                            <th><spring:message code="wzwg.sysMngr.word.registDe" /></th>
	                            <th><spring:message code="wzwg.sysMngr.word.essntlAt"/></th>
	                            <th><spring:message code="wzwg.cmm.word.lastupdtde" /></th>
    		                    <th><spring:message code="wzwg.sysMngr.word.bassEstbsAt" /></th>
	                            <th><spring:message code="wzwg.cmm.word.manage" /></th>
	                        </tr>
                        </thead>
                        <tbody>
                        
                        <c:if test="${!empty resultList}">
                        <c:forEach items="${resultList}" var="list" varStatus="status">
	                        <tr>
	                            <td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + status.count) + 1}" /></td>
	                            <td><c:out value="${list.stplatTyCodeNm}" /></td>
	                            <td class="txt_l"><c:out value="${list.stplatNm}" /></td>
	                            <td><span class="fs14"><c:out value="${list.frstRegistPnttm}" /></span></td>
	                            <td>
	                            	<c:if test="${list.stplatTyCode eq 'SC00000453' and list.essntlAt eq 'Y' }"><spring:message code="wzwg.cmm.word.essntl"/></c:if>
	                            	<c:if test="${list.stplatTyCode eq 'SC00000453' and list.essntlAt eq 'N' }"><spring:message code="wzwg.cmm.word.choise"/></c:if>
	                            </td>
	                            <td><span class="fs14"><c:out value="${list.lastUpdtPnttm}" /></span></td>
	                            <td>
	                            	<c:if test="${list.defaultAt ne 'Y'}">
	                            		<a href="javascript:void(0);" onclick="fnDefaultChange('<c:out value="${list.stplatSeq}" />','Y');" class="iconOnlyBtnSameSize btn-basic"><spring:message code="wzwg.sysMngr.word.bassEstbs" /></a>
	                            	</c:if>
	                            	<c:if test="${list.defaultAt eq 'Y'}">
	                            		<a href="javascript:void(0);" onclick="fnDefaultChange('<c:out value="${list.stplatSeq}" />','N');" class="btn-del iconOnlyBtnSameSize"><spring:message code="wzwg.sysMngr.word.bassEstbsRelis" /></a>
	                            	</c:if>
	                            </td>
		                        <td>
		                       	 <a class="iconOnlyBtnSameSize btn-basic" onclick="fnApply('<c:out value="${list.stplatSeq}" />'); return false;" href="javascript:void(0);"><spring:message code="wzwg.sysMngr.word.allSiteApplc" /></a>
		                       	 <a href="javascript:void(0)" onclick="fnDetail('<c:out value="${list.stplatSeq}" />'); return false;" class="iconOnlyBtn btn-basic btn-setting" title="<spring:message code="wzwg.cmm.word.estbs" />"><spring:message code="wzwg.cmm.word.estbs" /></a>
		                       	 <a href="javascript:void(0)" onclick="fnDelete('<c:out value="${list.stplatSeq}" />'); return false;" class="iconOnlyBtn btn-basic btn-delete" title="<spring:message code="wzwg.cmm.word.delete" />"><spring:message code="wzwg.cmm.word.delete" /></a> 
		                        </td>
	                        </tr>
                        </c:forEach>
                        </c:if>
                         
                        </tbody>
                   </table>
                  <c:if test="${!empty resultList}">
                  	<div class="ctr-box" id="pageInfo">
						<ul class="num mobile-none">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnPage" />
						</ul>
						
						<ul class="num pc-none">
							<ui:pagination paginationInfo="${mobilePaginationInfo}" type="image" jsFunction="fnPage" />
						</ul>
					</div>
                  </c:if>
                          
                  <!--// button --> 
                  <div class="rt-box">
   	              	<a href="javascript:void(0);" onclick="fnRegistFrom(); return false;" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.regist" /></a>
                  </div>
                  
