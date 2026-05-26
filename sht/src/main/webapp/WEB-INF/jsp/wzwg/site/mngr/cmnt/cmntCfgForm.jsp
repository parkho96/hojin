<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js"></script>
<script type="text/javascript">
 function fn_modifyCmntCfg(){
		oEditors.getById["cmntInfo"].exec("UPDATE_CONTENTS_FIELD", []);
	 document.frmInfo.action="<c:out value="${wzwg_contextPath}"/>/mngr/cmnt/config/modifyCmntCfgForm.do";
	 document.frmInfo.method="post";
	 document.frmInfo.submit();
 }
</script>
 
                <form  id="frmInfo" name="frmInfo">
                    
                    <table class="basic">
                    <colgroup>
                        <col width="15%"/>
                        <col width="*"/>
                    </colgroup>
                    <tbody>
                        <tr>
                            <th><spring:message code="wzwg.site.cmnt.msg.MSG001" /></th>
                            <td>
                            	<ul class="wzForm">
	                                <c:forEach items="${estblCodeList}" var="resultList" varStatus="status">
	                                    <li><label><input type="radio" name="cmntEstblCode" id="cmntEstblCode" value="<c:out value="${resultList.code}"/>" <c:if test="${resultVO.cmntEstblCode eq resultList.code }">checked="true"</c:if>/> <span class="spanLabel"><c:out value="${resultList.codeNm}"/></span></label></li> 
	                                </c:forEach>
                                </ul>
                                <span class="wz_tableguide mt10 clboth">
                                    <spring:message code="wzwg.cmm.msg.tip.MSG079" /><br>
                                    <spring:message code="wzwg.cmm.msg.tip.MSG080" />
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <th><spring:message code="wzwg.site.cmnt.msg.MSG002" /></th>
                            <td>
                            	<ul class="wzForm">
		                             <c:forEach items="${usrgroupList}" var="resultList" varStatus="status">
		                          		<li><label><input type="checkbox" name="usrgroupSeqArry" id="usrgroupSeqArry" value="<c:out value="${resultList.usrGroupSeq}"/>"
		                          		<c:forEach items="${groupList}" var="groupList" varStatus="groupStat"><c:if test="${resultList.usrGroupSeq eq groupList.usrgroupSeq }">checked="true"</c:if> </c:forEach>
		                          		/> <span class="spanLabel"><c:out value="${resultList.usrGroupNm}"/> </span></label></li>
		                          	</c:forEach> 
                          		</ul>
                            	<span class="wz_tableguide mt10 clboth"><spring:message code="wzwg.cmm.msg.tip.MSG081" /></span>
                            </td>
                        </tr>
                        
                        <tr>
                            <th><spring:message code="wzwg.site.cmnt.msg.MSG003" /></th>
                            <td>
                            	<ul class="wzForm">
		                             <c:forEach items="${appvlCodeList}" var="resultList" varStatus="status">
		                          		<li><label><input type="radio" name="cmntAppvlCode" id="cmntAppvlCode" value="<c:out value="${resultList.code}"/>" <c:if test="${resultVO.cmntAppvlCode eq resultList.code }">checked="true"</c:if>/> <span class="spanLabel"><c:out value="${resultList.codeNm}"/></span></label></li> 
		                          	</c:forEach>  
                          		</ul>
	                            <span class="wz_tableguide mt10 clboth">
	                                <spring:message code="wzwg.cmm.msg.tip.MSG082" /><br>
	                                <spring:message code="wzwg.cmm.msg.tip.MSG083" />
	                            </span> 
                            </td>
                        </tr>
                        <tr>
                            <th><spring:message code="wzwg.site.cmnt.msg.MSG004" /></th>
                            <td>
                                <span class="wz_tableguide mt10 mb20"><spring:message code="wzwg.cmm.msg.tip.MSG084" /></span>
                                <textarea name="cmntInfo" id="cmntInfo" rows="30" class="w80" dir="required" title="<spring:message code="wzwg.cmm.word.cn"/>" style="width:100%;"><c:out value="${resultVO.cmntInfo}"/></textarea>
						<script type="text/javascript">
							var oEditors = [];
							nhn.husky.EZCreator.createInIFrame({
							    oAppRef: oEditors,
							    elPlaceHolder: "cmntInfo",
							    sSkinURI: "<c:out value="${wzwg_contextPath}"/>/smartEditor2.8.2.1/smartEditor2Skin.do",
							    fCreator: "createSEditor2",
							    htParams: {
									fOnBeforeUnload : function(){}
									,aAdditionalFontList : [['NanumSquareR', 'NanumSquareR']]		// 추가 글꼴 목록
									}
							});
						</script>
                            </td>
                        </tr>
                    </tbody>
                    </table>
                    
                </form>
     <div class="rt-box">
		<a href="javascript:void(0);" onclick="fn_modifyCmntCfg();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
	</div>