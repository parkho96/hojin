<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
	fnInit('SC00000453');
});

function fnInit(paramValue){
	if(paramValue != 'SC00000454'){
		$("input:radio[name='essntlAt']").removeAttr("disabled");
		$("input:radio[name='expsrAt']").removeAttr("disabled");
	}else{
		$("input:radio[name='essntlAt']").prop("disabled", true);
		$("input:radio[name='expsrAt']").prop("disabled", true);
	}
}

function fnRegist() {

	if(!Validator.validate(document.regForm)){
		return;
	}
	
	$.ajax({
		type:'POST'
		, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/siteMngr/siteStplat/info/registStplatInfoAjax.do'
		, data:$("#regForm").serialize()
		,success:function (result){
			$(result).find('value').each(function(){
				if($(this).text() == "success"){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
					fnList();
				}else{
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
				}
			})
		}
		, error:function (request, status, error) {
	             alert('<spring:message code="fail.common.msg" text="error" />');
		}
	});
}

function fnList() {
	$('select[name=stplatTyCode').val('');
    document.regForm.action="<c:out value="${wzwg_contextPath}${prefix}"/>/siteMngr/siteStplat/info/selectStplatInfoList.do";
    document.regForm.submit();
}
</script>

                <c:choose>
                <c:when test="${!empty paramVO.siteSeq}">
                    <jsp:include page="/WEB-INF/jsp/wzwg/sysMngr/siteMngr/siteInfo/siteInfoTab.jsp"></jsp:include>
                </c:when>
                <c:otherwise>
                    <h3>사이트상태정보</h3>
                </c:otherwise>
                </c:choose>

                <form id="regForm" name="regForm" method="post">
                    <c:choose>
                    <c:when test="${empty resultVO.siteSeq}">
                    <input type="hidden" id="siteSeq" name="siteSeq" value="<c:out value="${paramVO.siteSeq}"/>" />
                    </c:when>
                    <c:otherwise>
                    <input type="hidden" path="siteSeq" name="siteSeq" />
                    </c:otherwise>
                    </c:choose>
                
                    
                    <!--기본정보 table// -->
                    
                    <table summary="약관정보" class="basic">
                        <colgroup>
                            <col width="13%"/>
                            <col width="*"/>
                        </colgroup>
                        <tbody>
                            <tr>
                                <th><spring:message code="wzwg.cmm.word.ty" /></th>
                                <td>
                                	<select name="stplatTyCode" dir="required" title="<spring:message code="wzwg.cmm.word.cl" />" onchange="fnInit(this.value);">
                                		<c:forEach items="${stplatInfoTyCodeList}" var="codeList">
                                			<option value="<c:out value="${codeList.code}"/>"><c:out value="${codeList.codeNm }"/></option>
                                		</c:forEach>
                                	</select>
                                	
                                	<span class="wz_tableguide mt10">
									    <strong><spring:message code="wzwg.cmm.word.stplat" /></strong> : <spring:message code="wzwg.cmm.msg.MSG388" /><br>
									    <strong><spring:message code="wzwg.cmm.word.Policy" /></strong> : <spring:message code="wzwg.cmm.msg.MSG389" />
									</span>
                                </td>
                            </tr>
                            <tr>
                                <th><spring:message code="wzwg.sysMngr.word.stplatAndPolicyNm01" />
	                                <span class="necessary">
											<span></span>
											<div><spring:message code="wzwg.cmm.word.essntl" /></div>
									</span>
                                </th>
                                <td>
	                                <c:set var="msg_txt01">
										<spring:message code="wzwg.cmm.cmmMsg.CMG011">
											<spring:argument><spring:message code="wzwg.cmm.word.stplatNm" /></spring:argument>
											<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
										</spring:message>
									</c:set>
									<input type="text" class="w70" name="stplatNm" id="stplatNm" dir="required" title="<spring:message code="wzwg.sysMngr.word.stplatNm01" />" placeholder="<c:out value="${msg_txt01}"/>"/>
                                </td>
                            </tr>
                            <tr>
                                <th><spring:message code="wzwg.cmm.word.dc" />
                                	<span class="necessary">
											<span></span>
											<div><spring:message code="wzwg.cmm.word.essntl" /></div>
									</span>
                                </th>
                                <td>
	                                <c:set var="msg_txt02">
										<spring:message code="wzwg.cmm.cmmMsg.CMG011">
											<spring:argument><spring:message code="wzwg.sysMngr.word.stplatDc" /></spring:argument>
											<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
										</spring:message>
									</c:set>
									<input type="text" class="w70" id="stplatDc" name="stplatDc" dir="required" title="<spring:message code="wzwg.sysMngr.word.stplatDc" />" placeholder="<c:out value="${msg_txt02}"/>"/>
                                </td>
                            </tr>
                            <tr>
                            	<th><spring:message code="wzwg.sysMngr.word.essntlAt"/></th>
                            	<td> 
                            		<ul class="wzForm">
	                            		<li><label><input type="radio" id="essntlY" name="essntlAt" dir="required" value="Y" checked="checked"/><span class="spanLabel"><spring:message code="wzwg.cmm.word.essntl"/></span></label></li>
	                            		<li><label><input type="radio" id="essntlN" name="essntlAt" dir="required" value="N"/><span class="spanLabel"><spring:message code="wzwg.cmm.word.choise"/></span></label></li>
                            		</ul>
                            		<span class="wz_tableguide mt10 clboth"><spring:message code="wzwg.cmm.msg.MSG333" /></span>
                            	</td>
                            </tr>
                        </tbody>
                    </table>
                    <!--//기본정보 table -->
                </form>
                <div class="rt-box">
                    <button onclick="fnRegist();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></button>
                    <button onclick="fnList();" class="wzbtn btn-del"><spring:message code="wzwg.cmm.word.cancl" /></button>
                </div>
