<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js"></script>

		<table class="wz_cowrap">
			<colgroup>
				<col width="20%"/>
				<col width="20%"/>
				<col width="*"/>
			</colgroup>
			<c:choose>
				<c:when test="${!empty resultVO }">
					<tr>
						<th><spring:message code="wzwg.module.word.registde" /></th>
						<td>
							<c:out value="${resultVO.frstRegistPnttm }"/>
						</td>
						<td class="rt-box txt-r">
      
                            <%-- <a href="javascript:void(0);" onclick="fn_registCntntsCnInit('<c:out value="${resultVO.cntntsCnSeq}"/>');" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.template" /> <spring:message code="wzwg.cmm.word.applc" /></a> --%>
							<a href="javascript:void(0);" onclick="fn_modifyCntntsCnForm('<c:out value="${resultVO.cntntsCnSeq}"/>');" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.updt" /></a>
							<a href="javascript:void(0);" onclick="fn_deleteCntntsCn('<c:out value="${resultVO.cntntsCnSeq}"/>');" class="wzbtn btn-del"><spring:message code="wzwg.cmm.word.delete" /></a>
						</td>
					</tr>
					<tr class="wideth-white">
					     <th colspan="3" class="wzAdmSTit"><spring:message code="wzwg.module.word.cntntscn" /></th>
					</tr>
					<tr>
						<td	colspan="3">
							<div style="max-width:960px;">
							<c:out value="${resultVO.cntntsCn }" escapeXml="false"/>
							</div>
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="3" class="rt-box">
							<a href="javascript:void(0);" class="mainEditBtn" onclick="fn_modifyCntntsCnForm('regist');"><img src="/images/wzwg/site/mngr/layout/writeBtn.png" alt=""><spring:message code="wzwg.cmm.msg.tip.MSG0690" /></a>
							<div class="admpg-subp w100 fl txt-l block pt20 pb50"><span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.tip.MSG069" /></div>
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
		
		<!-- 게시물 목록 -->
		<h3 class="wzAdmSTit wd100 fl"><spring:message code="wzwg.cmm.word.historycntnts" /></h3>
		<table  class="basic-table">
		<colgroup>
			<col width="80%"/>
			<col width="*"/>
		</colgroup>
		<thead>
			<tr>
				<th><spring:message code="wzwg.module.word.writngdt" /></th>
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
