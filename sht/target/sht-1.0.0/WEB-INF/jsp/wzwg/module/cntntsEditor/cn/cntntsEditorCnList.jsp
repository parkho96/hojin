<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js"></script>

		<table class="basic">
			<colgroup>
				<col width="20%"/>
				<col width="20%"/>
				<col width="*"/>
			</colgroup>
			<c:choose>
				<c:when test="${!empty resultVO }">
					<tr>
						<th><spring:message code="wzwg.cmm.word.regist" /> <spring:message code="wzwg.cmm.word.de01" /></th>
						<td>
							<c:out value="${resultVO.frstRegistPnttm }"/>
						</td>
						<td class="rt-box txt-r">
      
                            <%-- <a href="javascript:void(0);" onclick="fn_registCntntsCnInit('${resultVO.cntntsCnSeq}');" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.template" /> <spring:message code="wzwg.cmm.word.applc" /></a> --%>
							<a href="javascript:void(0);" onclick="fn_modifyCntntsCnForm('<c:out value="${resultVO.cntntsCnSeq}"/>');" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.updt" /></a>
							<a href="javascript:void(0);" onclick="fn_deleteCntntsCn('<c:out value="${resultVO.cntntsCnSeq}"/>');" class="wzbtn btn-del"><spring:message code="wzwg.cmm.word.delete" /></a>
						</td>
					</tr>
					<tr>
						<th><spring:message code="wzwg.cmm.word.cntnts" /> <spring:message code="wzwg.cmm.word.cn" /></th>
						<td	colspan="2">
							<div style="max-width:960px;">
							<c:out value="${resultVO.cntntsCn }" escapeXml="false"/>
							</div>
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="3" class="rt-box">
							<a href="javascript:void(0);" class="wzbtn btn-basic" onclick="fn_modifyCntntsCnForm('regist');"><spring:message code="wzwg.cmm.word.regist" /></a>
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
		
		<!-- 게시물 목록 -->
		<table  class="basic-table">
		<colgroup>
			<col width="80%"/>
			<col width="*"/>
		</colgroup>
		<thead>
			<tr>
				<th><spring:message code="wzwg.cmm.word.writng" /> <spring:message code="wzwg.cmm.word.dt" /></th>
				<th><spring:message code="wzwg.cmm.word.rm" /></th>
			</tr>			
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${!empty cntntsCnList }">
					<c:forEach items="${cntntsCnList }" var="cntntsCnList" varStatus="status">
						<tr>
							<td><c:out value="${cntntsCnList.frstRegistPnttm }"/></td>
							<td class="rt-box">
								<a href="javascript:void(0);" onclick="fn_modifyCntntsCnForm('<c:out value="${cntntsCnList.cntntsCnSeq}"/>');" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.recovry" /></a>
								<a href="javascript:void(0);" onclick="fn_deleteCntntsCn('<c:out value="${cntntsCnList.cntntsCnSeq}"/>');" class="wzbtn btn-del"><spring:message code="wzwg.cmm.word.delete" /></a>
							</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<td colspan="2"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
				</c:otherwise>
			</c:choose>
		</tbody>
		</table>
