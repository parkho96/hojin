<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<style>

	.list_btns{width:100%;overflow:hidden;padding:5px 0;}
    .list_btns ul li{float:left;margin:0 5px 6px 0px;list-style:none;}
    .list_btns ul li.last{margin-right:0;}
    .list_btns ul li table{width:100%;}
</style>

	<div class="list_btns">
		<ul> 
			<c:if test="${!empty imageList}">
			<c:forEach var="resultList" items="${imageList}" varStatus="status">
			<li <c:if test="${status.count % 5 eq 0}">class="last"</c:if>>
				<table>
				<tr><td></td></tr>
				<tr>
					<td style="padding-left:3px;">
						<div class="ta_c">
						<c:choose>
							<c:when test="${param.mode eq 100}">
							<a href="javascript:void(0);" onclick="addImgEditor('<c:out value="${wzwg_contextPath}" />/module/upload/image/selectImageDetail.do?usrimgId=<c:out value="${resultList.usrimgId}" />','<c:out value="${param.id}" />')">
								<img src="<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/image/selectImageDetail.do?usrimgId=<c:out value="${resultList.usrimgId}" />" id="img_<c:out value="${resultList.usrimgId}" />" width="100" height="85" alt="<c:out value="${resultList.orignlImageNm}" />" onload="fnImgSizeView(this);"/>
							</a>
							</c:when>
							<c:otherwise>
							<a href="javascript:void(0);" onclick="selectImgLoad('<c:out value="${wzwg_contextPath}" />/module/upload/image/selectImageDetail.do?usrimgId=<c:out value="${resultList.usrimgId}" />',selectDiv, '<c:out value="${param.mode}" />', '<c:out value="${param.id}" />')">
								<img src="<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/image/selectImageDetail.do?usrimgId=<c:out value="${resultList.usrimgId}" />" id="img_<c:out value="${resultList.usrimgId}" />" width="100" height="85" alt="<c:out value="${resultList.orignlImageNm}" />" onload="fnImgSizeView(this);"/>
							</a>
							</c:otherwise>
						</c:choose>
						</div>
						<div class="btnbox-c">
							<div class="i-size-data">
							  
							</div>
							<div class="btn-set">
								
	                            <c:if test="${sessionScope.SYSMNGR_AT eq 'Y' or resultList.siteSeq eq sessionScope.SITE_SEQ}">
								<a href="javascript:void(0);" onclick="fnDeleteImage('<c:out value="${resultList.usrimgId}" />', '<c:out value="${resultList.imageStreCours}" />', '<c:out value="${resultList.streImageNm}" />');" class="wzbtn-table btn-del"><spring:message code="wzwg.cmm.word.delete" /></a>
	                            </c:if>
							</div>
						</div>
					</td>
				</tr>
				<tr><td></td></tr>
				</table>
			</li>
			</c:forEach>
			</c:if>
		</ul>
	</div>
	
</div>

