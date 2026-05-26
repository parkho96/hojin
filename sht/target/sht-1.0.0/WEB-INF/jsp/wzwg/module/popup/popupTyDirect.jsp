<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

	<table class="basic">
		<colgroup>
			<col width="20%" />
			<col width="80%" />
		</colgroup>
		<tbody>
			<tr><th colspan="2" class="wzAdmSTit"><spring:message code="wzwg.module.word.lypopupZoneestbs" /></th></tr><tr> <!-- 2019.04.18 신규 추가 tr-->
			<tr>
				<th><spring:message code="wzwg.module.word.popupcn" /></th>
				<td>
					<textarea name="popupCn" id="popupCn" rows="20" style="width: 100%; height: 420px;" dir="required" title="<spring:message code="wzwg.module.word.popupcn" />"><c:out value="${resultVO.popupCn }"/></textarea>
					<script type="text/javascript">
						var oEditors = [];
						nhn.husky.EZCreator.createInIFrame({
						    oAppRef: oEditors,
						    elPlaceHolder: "popupCn",
						    sSkinURI: "<c:out value="${wzwg_contextPath}" />/smartEditor2.8.2.1/smartEditor2Skin.do",
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