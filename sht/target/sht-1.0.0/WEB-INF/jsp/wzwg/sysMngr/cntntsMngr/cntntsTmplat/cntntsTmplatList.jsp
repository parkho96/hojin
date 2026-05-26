<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

	<script type="text/javascript">
		/** 컨텐츠 템플릿 등록 폼 */
		function fn_cntntsTmplatRegistForm(){
			document.cntntsTmplatForm.action='<c:out value="${wzwg_contextPath}${prefix}" />/cntntsMngr/cntntnsTmplat/registCntntsTmplatForm.do';
			document.cntntsTmplatForm.submit();
		}
		
		/** 컨텐츠 템플릿 상세조회 */
		function fn_cntntsTmplatDetail(paramSeq){
			document.cntntsTmplatForm.tmplatSeq.value = paramSeq;
			document.cntntsTmplatForm.action='<c:out value="${wzwg_contextPath}${prefix}" />/cntntsMngr/cntntnsTmplat/selectCntntsTmplatDetail.do';
			document.cntntsTmplatForm.submit();
		}
		
		/** 컨텐츠 템플릿 미리보기 */
		function fn_cntntsTmplatPrevew(paramSeq){
			var frm = document.cntntsTmplatPopup;
			frm.tmplatSeq.value = paramSeq;
			
			var frmResult = window.open("", "popForm", "width=1100,height=700,toolbars=no,menubars=no,scrollbars=yes");
			
			frm.target='popForm';
			frm.action='<c:out value="${wzwg_contextPath}${prefix}" />/cntntsMngr/cntntnsTmplat/selectCntntsTmplatPrevewPopup.do';
			frm.submit();
		}
		
		/** 페이징 */
		function fnPage(paramPageIndex){
			
			if(isNaN(paramPageIndex)){
				console.log('잘못된 페이지호출');
				return;
			}
			
			document.cntntsTmplatForm.pageIndex.value = paramPageIndex;
			document.cntntsTmplatForm.action='<c:out value="${wzwg_contextPath}${prefix}" />/cntntsMngr/cntntnsTmplat/selectCntntsTmplatList.do';
			document.cntntsTmplatForm.submit();
		}
		
		/** 검색 */
		function fnSearch(){
			document.cntntsTmplatForm.pageIndex.value = 1;
			document.cntntsTmplatForm.action='<c:out value="${wzwg_contextPath}${prefix}" />/cntntsMngr/cntntnsTmplat/selectCntntsTmplatList.do';
			document.cntntsTmplatForm.submit();
		}
		$(document).ready(function(){
			$('input[name=searchKeyword]').focus();
		});
	</script>

	<form id="cntntsTmplatPopup" name="cntntsTmplatPopup" method="post">
		<input type="hidden" id="tmplatSeq" name="tmplatSeq" value=""/> 
	</form>
	
	<div class="wz_notice brbox bg-white br-blue-strong">	
	    <ul class="wd100">
		    <li class="admpg-subp wd100 mb0">· <spring:message code="wzwg.cmm.msg.tip.MSG139" /></li>
	    </ul>
	</div>

	<form id="cntntsTmplatForm" name="cntntsTmplatForm" method="post">
		<input type="hidden" name="tmplatSeq" id="tmplatSeq" value=""/>
		<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex}" />" />
		<input type="hidden" name="pageUnit" value="10" />
		<div class="main-menu-bar">
			<select name="searchCondition" id="searchCondition">
				<option value=""><spring:message code="wzwg.cmm.word.sj" /></option>
				<c:forEach items="${codeList}" var="codeList">
					<option value="<c:out value="${codeList.code}" />" <c:if test="${codeList.code eq paramVO.searchCondition }">selected="selected"</c:if>><c:out value="${codeList.codeNm}" /></option>
				</c:forEach>
			</select>
			
			<c:set var="srchwrd">
				<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
			</c:set>
			
			<input type="text" name="searchKeyword" id="searchKeyword" placeholder="<c:out value="${srchwrd}" />" class="txt" onkeypress="if(window.event.keyCode == 13) {fnSearch();}" <c:if test="${!empty paramVO.searchKeyword}">value="<c:out value="${paramVO.searchKeyword }" />"</c:if> />
	 		<span onclick="fnSearch(1);"><a class="wzbtn-table btn-srch" href="javascript:void(0);"><spring:message code="wzwg.cmm.word.search01" /></a></span>
		</div>
	
		<!-- 
	  	<table class="basic-table">
			<colgroup>
				 <col width="10%" />
				 <col width="15%" />
		   	     <col width="*" />
		   	     <col width="15%" />
		   	     <col width="10%" />
			</colgroup>
			<thead>
			  	<tr>
			  		<th>No</th>
					<th><spring:message code="wzwg.cmm.word.cl" /></th>
					<th><spring:message code="wzwg.cmm.word.sj" /></th>
					<th><spring:message code="wzwg.cmm.word.rm" /></th>
					<th><spring:message code="wzwg.cmm.word.manage" /></th>
	  			</tr>	
			</thead>
			<tbody>
			<c:choose>
				<c:when test="${!empty cntntsTmplatList }">
					<c:forEach items="${cntntsTmplatList }" var="cntntsTmplatList" varStatus="status">
						<tr>
							<td>
								<c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.pageSize + status.count) + 1 }"/>
							</td>
							<td>
								<c:out value="${cntntsTmplatList.tmplatClSeqNm }"/>
							</td>
							<td class="txt-l"><c:out value="${cntntsTmplatList.tmplatSj }"/></td>
							<td>
								<a href="javascript:void(0);" onclick="fn_cntntsTmplatPrevew('<c:out value="${cntntsTmplatList.tmplatSeq}"/>');" class="btn-c">
									<img src='<c:url value='/module/upload/file/selectImageView.do'/>?atchFileId=<c:out value="${cntntsTmplatList.atchFileId }"/>&fileSn=0' style="width: 50px; height: 50px;"/>
								</a>
							</td>
							<td><a href="javascript:void(0);" onclick="fn_cntntsTmplatDetail('<c:out value="${cntntsTmplatList.tmplatSeq}" />')" class="iconOnlyBtn btn-basic btn-modify" title="<spring:message code="wzwg.cmm.word.updt" />"><spring:message code="wzwg.cmm.word.updt" /></a></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<td colspan="5"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
				</c:otherwise>
			</c:choose>
			</tbody>
		</table>
		 -->
		
		<ul class="subTemplate_sysList">
			<c:choose>
				<c:when test="${!empty cntntsTmplatList }">
					<c:forEach items="${cntntsTmplatList }" var="cntntsTmplatList" varStatus="status">
						<li>
							<div class="nmBox">
								<span class="category_subT"><c:out value="${cntntsTmplatList.tmplatClSeqNm }"/></span>
								<div class="subtemNm"><c:out value="${cntntsTmplatList.tmplatSj }"/></div>
							</div>
							
							<div class="temBox thumImg">
								<div class="wd100 fl">
									<img src="<c:url value='/module/upload/file/selectImageView.do'/>?atchFileId=<c:out value="${cntntsTmplatList.atchFileId }"/>&fileSn=0">
								</div>
								<div class="hoverLayer">
									<div class="i-block wd100 linehgt150 vert-m txt-l">
			   							<a href="javascript:void(0);" onclick="fn_cntntsTmplatPrevew('<c:out value="${cntntsTmplatList.tmplatSeq}"/>');" class="circleRTxt"><span class="hoverbtn_circle closeUp"></span>자세히 보기</a>
			   							<a href="javascript:void(0);" onclick="fn_cntntsTmplatDetail('<c:out value="${cntntsTmplatList.tmplatSeq}" />')" class="circleRTxt"><span class="hoverbtn_circle modify"></span>수정하기</a>
			  						</div>
			  					</div>
							</div>
						</li>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<li class="noLi"><spring:message code="wzwg.cmm.msg.MSG097" /></li>
				</c:otherwise>
			</c:choose>
		</ul>
	 </form>
	 
	 <c:if test="${!empty cntntsTmplatList}">
		 <div class="ctr-box" id="pageInfo">
			<ul class="num mobile-none">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnPage" />
			</ul>
			
			<ul class="num pc-none">
				<ui:pagination paginationInfo="${mobilePaginationInfo}" type="image" jsFunction="fnPage" />
			</ul>
		</div>
	 </c:if>

	 <div class="fr">
	 	<div class="rt-box">
	 		<a href="javascript:void(0);" onclick="fn_cntntsTmplatRegistForm();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.regist" /></a>
	 	</div>
	 </div>
