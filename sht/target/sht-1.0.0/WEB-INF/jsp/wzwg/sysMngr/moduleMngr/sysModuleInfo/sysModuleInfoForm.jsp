<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script type="text/javascript" src="/js/wzwg/cmm/common.js" ></script>


<script type="text/javascript">
//등록
function fnSysModuleInfoRegist() {
	
	if(!Validator.validate(document.frmReg)){
		return;
	}
	
    var frm = document.frmReg;
    frm.action="<c:out value="${wzwg_contextPath}"/>/sysMngr/moduleMngr/sysModuleInfo/registSysModuleInfo.do";
    frm.submit();
}

//목록
function fnList() {
    var frm = document.frmReg;
    frm.action="<c:out value="${wzwg_contextPath}"/>/sysMngr/moduleMngr/sysModuleInfo/selectSysModuleInfoList.do";
    frm.submit();
}
</script>

                <form:form modelAttribute="paramVO" name="frmReg" method="post">
					<!--기본정보 table// -->
					<table class="basic">
						<colgroup>
							<col width="13%"/>
							<col width="*"/>
						</colgroup>
						<tbody>
                            <tr>
                                <th><spring:message code="wzwg.sysMngr.word.mdTy03" /></th>
                                <td>
                                	<c:set var="msg_txt01">
										<spring:message code="wzwg.cmm.cmmMsg.CMG011">
											<spring:argument><spring:message code="wzwg.sysMngr.word.mdTy03" /></spring:argument>
											<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
										</spring:message>
									</c:set>
                                    <form:select path="moduleTyCode" id="moduleTyCode" dir="required">	
									    <form:option value="" label="${fn:escapeXml(msg_txt01)}" />
									    <c:forEach var="item" items="${moduleTyCodeList}">
									        <form:option value="${fn:escapeXml(item.code)}" label="${fn:escapeXml(item.codeNm)}" />
									    </c:forEach>
                                    </form:select>
                                </td>
                             </tr>
                             <tr>
                                <th><spring:message code="wzwg.sysMngr.word.mdNm01" /></th>
                                <td>
	                                <c:set var="msg_txt02">
										<spring:message code="wzwg.cmm.cmmMsg.CMG011">
											<spring:argument><spring:message code="wzwg.sysMngr.word.mdNm01" /></spring:argument>
											<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
										</spring:message>
									</c:set>
                                    <form:input cssClass="w70" path="moduleNm" id="moduleNm" dir="required" placeholder="${fn:escapeXml(msg_txt02)}"/>
                                </td>
                             </tr>
                             <tr>
                                <th><spring:message code="wzwg.sysMngr.word.mdDc" /></th>
                                <td>
	                                <c:set var="msg_txt03">
										<spring:message code="wzwg.cmm.cmmMsg.CMG011">
											<spring:argument><spring:message code="wzwg.sysMngr.word.mdDc" /></spring:argument>
											<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
										</spring:message>
									</c:set>
                                    <form:input cssClass="w70" path="moduleDc" id="moduleDc" dir="required" placeholder="${fn:escapeXml(msg_txt03)}"/>
                                </td>
                             </tr>
                             <tr>
                                <th><spring:message code="wzwg.sysMngr.word.pckageCours" /></th>
                                <td>
	                                <c:set var="msg_txt04">
										<spring:message code="wzwg.cmm.cmmMsg.CMG011">
											<spring:argument><spring:message code="wzwg.sysMngr.word.pckageCours" /></spring:argument>
											<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
										</spring:message>
									</c:set>
                                    <form:input cssClass="w70" path="pckagePath" id="pckagePath" dir="required" placeholder="${fn:escapeXml(msg_txt04)}"/>
                                </td>
                             </tr>
                             <tr>
                                <th><spring:message code="wzwg.sysMngr.word.instncNm01" /></th>
                                <td>
	                                <c:set var="msg_txt05">
										<spring:message code="wzwg.cmm.cmmMsg.CMG011">
											<spring:argument><spring:message code="wzwg.sysMngr.word.instncNm01" /></spring:argument>
											<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
										</spring:message>
									</c:set>
                                    <form:input cssClass="w70" path="instcNm" id="instcNm" dir="required" placeholder="${fn:escapeXml(msg_txt05)}"/>
                                </td>
                             </tr>
                             <tr>
                                <th><spring:message code="wzwg.sysMngr.word.mngrPgUrl" /></th>
                                <td>
	                                <c:set var="msg_txt06">
										<spring:message code="wzwg.cmm.cmmMsg.CMG011">
											<spring:argument><spring:message code="wzwg.sysMngr.word.mngrPgUrl" /></spring:argument>
											<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
										</spring:message>
									</c:set>
                                    <form:input cssClass="w70" path="mngrPageUrl" id="mngrPageUrl" dir="required" placeholder="${fn:escapeXml(msg_txt06)}"/>
                                </td>
                             </tr>
                             <tr>
                                <th><spring:message code="wzwg.sysMngr.word.emplyrPgUrl" /></th>
                                <td>
	                                <c:set var="msg_txt07">
										<spring:message code="wzwg.cmm.cmmMsg.CMG011">
											<spring:argument><spring:message code="wzwg.sysMngr.word.emplyrPgUrl" /></spring:argument>
											<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
										</spring:message>
									</c:set>
                                    <form:input cssClass="w70" path="usrPageUrl" id="usrPageUrl" dir="required" onkeydown="fnKeyUpEvent('usrPageUrl', '1')" placeholder="${fn:escapeXml(msg_txt07)}"/>
                                </td>
                            </tr>
						</tbody>
					</table>
					<!--//기본정보 table -->
				</form:form>
				
				<div class="rt-box">
					<a href="javascript:void(0);" onclick="fnSysModuleInfoRegist(); return false;" class="btn-a"><spring:message code="wzwg.cmm.word.stre" /></a>
					<a href="javascript:void(0);" onclick="fnList(); return false;" class="btn-a"><spring:message code="wzwg.cmm.word.list" /></a>
				</div>
