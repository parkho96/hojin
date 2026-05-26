<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

	<table class="basic">
		<colgroup>
			<col width="20%" />
			<col width="80%" />
		</colgroup>
		<tbody>
			<tr>
				<th><spring:message code="wzwg.module.word.templatechoise" /></th>
				<td>
					<c:forEach items="${tmplatList }" var="tmplatList" varStatus="status">
						<label class="tmImg">
							<input type="radio" name="tmplatSeq" value="<c:out value="${tmplatList.tmplatSeq }" />" <c:if test="${status.first }">checked="checked"</c:if> <c:if test="${resultVO.tmplatSeq eq tmplatList.tmplatSeq }">checked="checked"</c:if> dir="required" title="<spring:message code="wzwg.module.word.templatechoise" />" />
							<img src="<c:out value="${tmplatList.tmplatImg}" />" alt="<c:out value="${tmplatList.tmplatNm}" />" style="width: 50px; height: 50px;" />
						</label>
					</c:forEach>
				</td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.module.word.popupcn" /></th>
				<td>
					<textarea name="popupCn" id="popupCn" style="height: 210px; width: 100%;" dir="required" title="<spring:message code="wzwg.module.word.popupcn" />"><c:out value="${resultVO.popupCn }"/></textarea>
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