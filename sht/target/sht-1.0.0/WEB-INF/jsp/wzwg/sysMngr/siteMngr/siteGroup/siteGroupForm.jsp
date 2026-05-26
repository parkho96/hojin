<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
$(document).ready(function(){
    <c:if test="${empty resultVO.useAt}">
    $('input[name=useAt]').eq(1).attr('checked',true);
    </c:if>
});

function fnRegist() {

	if(!Validator.validate(document.regForm)){
		return;
	}
	
 	<c:choose>
	<c:when test="${empty resultVO.sitegrpSeq}">
    document.regForm.action="<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/siteGroup/registSiteGroup.do";
	</c:when>
	<c:otherwise>
    document.regForm.action="<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/siteGroup/modifySiteGroup.do";
	</c:otherwise>
	</c:choose>
	document.regForm.submit();
}

function fnList() {
	document.regForm.action="<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/siteGroup/selectSiteGroupList.do";
	document.regForm.submit();
}

function fnRegistFrom() {
    document.frmSrh.action="<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/siteGroup/selectSiteGroupForm.do";
    document.frmSrh.submit();
}

function fnDetail(sitegrpSeq) {
    document.frmSrh.sitegrpSeq.value = sitegrpSeq;
    
    document.frmSrh.action="<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/siteGroup/selectSiteGroupForm.do";
    document.frmSrh.submit();
}
</script>

                <form:form modelAttribute="resultVO" name="regForm" method="post">
					<form:hidden path="sitegrpSeq" name="sitegrpSeq" />
                    <form:hidden path="upperGrpSeq" name="upperGrpSeq" />
                    <form:hidden path="odr" name="odr" />
                    <input type="hidden" name="pageIndex" value="<c:out value="${paramVO.pageIndex}" />" /> 
					
					<!--기본정보 table// -->
                    <c:if test="${resultVO.odr eq '1' }"><h3 class="wzAdmSTit  wd100 fl"><spring:message code="wzwg.sysMngr.word.fristGroupEstbs" /></h3></c:if>
                    <c:if test="${resultVO.odr eq '2' }"><h3 class="wzAdmSTit  wd100 fl"><spring:message code="wzwg.sysMngr.word.secondGroupEstbs" /></h3></c:if>
					<table class="basic">
						<colgroup>
							<col width="13%"/>
							<col width="37%"/>
							<col width="13%"/>
							<col width="*"/>
						</colgroup>
						<tbody>
							<tr>
								<th><spring:message code="wzwg.sysMngr.word.groupNm01" />
									<span class="necessary">
											<span></span>
											<div><spring:message code="wzwg.cmm.word.essntl" /></div>
									</span>
								</th>
								<td colspan="3">
									<c:set var="msg_txt01">
										<spring:message code="wzwg.cmm.cmmMsg.CMG011">
											<spring:argument><spring:message code="wzwg.sysMngr.word.groupNm01" /></spring:argument>
											<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
										</spring:message>
									</c:set>
									
                                    <form:input cssClass="w70" path="groupNm" id="groupNm" dir="required" placeholder="${fn:escapeXml(msg_txt01)}"/>
								</td>
							</tr>
							<tr>
								<th><spring:message code="wzwg.sysMngr.word.groupDc" />
									<span class="necessary">
											<span></span>
											<div><spring:message code="wzwg.cmm.word.essntl" /></div>
									</span>
								</th>
								<td colspan="3">
								
									<c:set var="msg_txt02">
										<spring:message code="wzwg.cmm.cmmMsg.CMG011">
											<spring:argument><spring:message code="wzwg.sysMngr.word.groupDc" /></spring:argument>
											<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
										</spring:message>
									</c:set>
									
                                    <form:input cssClass="w70" path="groupDc" id="groupDc" dir="required" placeholder="${fn:escapeXml(msg_txt02)}"/>
								</td>
							</tr>
                            <tr>
								<th><spring:message code="wzwg.sysMngr.word.useAt" /></th>
								<td>
									<ul class="wzForm">
                                    	<li><label><input type="radio" id="useAt" name="useAt" value="Y" <c:if test="${resultVO.useAt eq 'Y'}">checked</c:if> /> <span class="spanLabel"><spring:message code="wzwg.cmm.word.use" /></span></label></li>
                                    	<li><label><input type="radio" id="useAt" name="useAt" value="N" <c:if test="${resultVO.useAt eq 'N'}">checked</c:if> /> <span class="spanLabel"><spring:message code="wzwg.cmm.word.unuse" /></span></label></li>
                                    </ul>
								</td>
							</tr>
						</tbody>
					</table>
					<!--//기본정보 table -->
				</form:form>
				
				<div class="rt-box">
                    <c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
					<a href="javascript:void(0);" onclick="fnRegist();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
                    </c:if>
                    <c:choose>
                    <c:when test="${resultVO.odr eq '1' || empty resultVO.sitegrpSeq}">
                    <a href="javascript:void(0);" onclick="fnList();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
                    </c:when>
                    <c:otherwise>
                    <a href="javascript:void(0);" onclick="fnDetail('<c:out value="${resultVO.upperGrpSeq}" />');" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
                    </c:otherwise>
                    </c:choose>
				</div>
                
                <form name="frmSrh" id="frmSrh" method="post">
                    <input type="hidden" name="sitegrpSeq" value="" />
                    <input type="hidden" name="odr" value="" />
                    <input type="hidden" name="upperGrpSeq" value="<c:out value="${resultVO.sitegrpSeq}" />" />
                </form>

                <c:if test="${resultVO.odr eq '1'}">
                    
                    <h3 class="wzAdmSTit  wd100 fl"><spring:message code="wzwg.sysMngr.word.secondGroupList" /></h3>
                    <!--//게시판 설정 table -->
                    <table class="basic-table" style="margin-top:20px;">
                        <colgroup> 
                        <col width="5%" />
                        <col width="*" />
                        <col width="10%" />
                        <col width="15%" />
                        <col width="15%" />
                        </colgroup>
                        <thead>
                          <tr class="bg-white">
                            <th><spring:message code="wzwg.cmm.word.sn" /></th>
                            <th><spring:message code="wzwg.sysMngr.word.secondGroupNm01" /></th>
                            <th><spring:message code="wzwg.sysMngr.word.siteCo" /></th>
                            <th><spring:message code="wzwg.sysMngr.word.useAt" /></th>
                            <th><spring:message code="wzwg.sysMngr.word.registDe" /></th>
                          </tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty resultList}">
                        <tr>
                            <td colspan="6"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
                        </tr>
                        </c:if>
                        <c:forEach items="${resultList}" var="list" varStatus="status">
                        <tr style="cursor:pointer;" onclick="javascript:fnDetail('<c:out value="${list.sitegrpSeq}" />');">
                            <td><c:out value="${fn:length(resultList)-list.rn+1}" /></td>
                            <td><c:out value="${list.groupNm}" /></td>
                            <td><c:out value="${list.cnt}" /></td>
                            <td><c:if test="${list.useAt eq 'Y'}"><spring:message code="wzwg.cmm.word.use" /></c:if><c:if test="${list.useAt eq 'N'}"><spring:message code="wzwg.cmm.word.unuse" /></c:if></td>
                            <td><c:out value="${list.frstRegistPnttm}" /></td>
                        </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                      
                <!--// button --> 
                <div class="rt-box">
                    <a href="javascript:void(0);" onclick="fnRegistFrom(); return false;" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.regist" /></a>
                </div>
                </c:if>