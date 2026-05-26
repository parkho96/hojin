<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script> 
</script> 

	  <table  class="basic-table">
		<colgroup>
			<col width="25%" />
			<col width="10%" />
			<col width="10%" />
	        <col width="*" />
	        <col width="10%" />
	        <col width="8%" />
		</colgroup>
		<thead>
		  <tr class="bg-white">
		  	<th><spring:message code="wzwg.site.menu.msg.MSG020" /></th>
            <th><spring:message code="wzwg.site.menu.msg.MSG014" /></th>
			<th><spring:message code="wzwg.site.menu.msg.MSG015" /></th>
			<th><spring:message code="wzwg.site.menu.msg.MSG016" /></th>
			<th><spring:message code="wzwg.cmm.word.sort" /></th>
			<th><spring:message code="wzwg.cmm.word.manage" /></th>
		  </tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${!empty resultList }">
					<c:forEach items="${resultList}" var="result" varStatus="status">
						<tr>
							<td<c:if test="${not empty result.strngthStyle}"> style="color:<c:out value="${result.strngthStyle}"/>;"</c:if>><c:out value="${result.hdftrmenuNm}"/></td>
                            <td>
                                <c:if test="${result.menuTySe eq 'N'}"><spring:message code="wzwg.cmm.word.gnrl" /></c:if>
                                <c:if test="${result.menuTySe eq 'G'}"><spring:message code="wzwg.cmm.word.group" /></c:if>
                                <c:if test="${result.menuTySe eq 'T'}"><spring:message code="wzwg.site.menu.msg.MSG021" /></c:if>
                            </td>
                            <td><c:out value="${result.hdftrmenuTyNm}"/></td>
							<td>
                                <c:if test="${result.menuTySe eq 'N'}"><c:out value="${result.hdftrmenuLinkUrl}"/></c:if>
                                <c:if test="${result.menuTySe eq 'G'}">
                                <script>fnLinkUrlList('linkGrpSeq<c:out value="${result.hdftrmenuSeq}"/>', '<c:out value="${result.linkGrpSeq}"/>');</script>
                                <select id="linkGrpSeq<c:out value="${result.hdftrmenuSeq}"/>" name="linkGrpSeq<c:out value="${result.hdftrmenuSeq}"/>">
                                    <option value="">::<c:out value="${result.hdftrmenuNm}"/>::</option>
                                </select>
                                </c:if>
                                <c:if test="${result.menuTySe eq 'T'}"><spring:message code="wzwg.site.menu.msg.MSG021" /></c:if>
                            </td>
							<td>
								<button class="btn-basic iconOnlyBtn btn-sortUp" onclick="fn_siteHdMenuModifyOrdr('D','<c:out value="${result.hdftrmenuSeq}"/>', '<c:out value="${result.hdftrmenuOrdr}"/>','<c:out value="${result.lgnAt}"/>','<c:out value="${result.menuTySe}"/>')" title="<spring:message code="wzwg.cmm.word.up"/>"<c:if test="${status.first}"> style="color:#ccc;" disabled</c:if>>▲</button>
					   			<button class="btn-basic iconOnlyBtn btn-sortDown" onclick="fn_siteHdMenuModifyOrdr('U','<c:out value="${result.hdftrmenuSeq}"/>', '<c:out value="${result.hdftrmenuOrdr}"/>','<c:out value="${result.lgnAt}"/>','<c:out value="${result.menuTySe}"/>')" title="<spring:message code="wzwg.cmm.word.down"/>"<c:if test="${status.last}"> style="color:#ccc;" disabled</c:if>>▼</button>
							</td>
							<td>
							<!-- c:if test="${result.defaultAt eq 'N' }" -->
								 <a href="javascript:;" onclick="fnMenuModify('<c:out value="${result.hdftrmenuSeq}"/>')"><span class="iconOnlyBtn btn-basic btn-modify"><spring:message code="wzwg.cmm.word.updt" /></span></a>
							<!-- /c:if -->
							</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="6"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	  </table>
	 </form>
