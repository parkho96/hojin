<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
		
	<script type="text/javascript">
		/** 팝업 등록폼 */
		function fn_registForm(){
			document.searchForm.action='<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/popup/registModulePopupForm.do';
			document.searchForm.submit();
		}
	
		/** 팝업 수정폼*/
		function fn_modifyForm(paramSeq){
			document.searchForm.popupSeq.value = paramSeq;
			document.searchForm.action='<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/popup/modifyModulePopupForm.do';
			document.searchForm.submit();
		}
		
		/** 팝업 미리보기 */
		function fn_popupDetail(paramSeq, paramTyCode, paramWidth, paramHeight, paramXPosition, paramYPosition){
			
			var frm = document.popForm;

			frm.popupSeq.value = paramSeq;
			frm.popupTyCode.value = paramTyCode;
			
			var frmResult = window.open('', 'popup', 'left='+paramXPosition+', top='+paramYPosition+', resize=yes, width='+paramWidth+', height='+paramHeight+', scrollbars=yes');
			
			frm.target = "popup";
			frm.action = "<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/popup/selectModulePrevewPopup.do";
			frm.submit();
		}
		
		/** 팝업 검색(페이징에서도 같이 사용) */
		function fn_search(paramPageIndex){
			if(isNaN(paramPageIndex)){console.log('잘못된 페이지호출');return;}
			document.searchForm.pageIndex.value = paramPageIndex;
			document.searchForm.action='<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/popup/selectModulePopupList.do';
			document.searchForm.submit();
		}
		$(document).ready(function(){
			$('input[name=searchKeyword]').focus();
		});
	</script>
	
	<form id="popForm" name="popForm" method="post">
		<input type="hidden" name="popupSeq" id="popupSeq" value=""/>
		<input type="hidden" name="popupTyCode" id="popupTyCode" value=""/>
	</form>

	<form id="searchForm" name="searchForm" method="post">
		<input type="hidden" name="popupSeq" id="popupSeq" value=""/>
		<input type="hidden" name="popupTyCode" id="popupTyCode" value=""/>
		<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex}" />"/>
		<div class="wzAdmSrchbox txt-l">
			<label class="fs16 vert-m" for="searchPopupSttus"><spring:message code="wzwg.cmm.word.sttus" /> : </label>
			
			<select name="searchPopupSttus" id="searchPopupSttus" onchange="fn_search('1');">
				<option value=""><spring:message code="wzwg.cmm.word.all" /></option>
				<option value="0" <c:if test="${paramVO.searchPopupSttus eq '0' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.wait" /></option>
				<option value="1" <c:if test="${paramVO.searchPopupSttus eq '1' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.ongo" /></option>
				<option value="2" <c:if test="${paramVO.searchPopupSttus eq '2' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.end" /></option>
			</select>
			<label class="fs16 vert-m" for="searchNoticeAt"><spring:message code="wzwg.module.word.useat" /> :</label>
			<select name="searchNoticeAt" id="searchNoticeAt" name="searchNoticeAt" onchange="fn_search('1');">
				<option value=""><spring:message code="wzwg.cmm.word.all" /></option>
				<option value="1" <c:if test="${paramVO.searchNoticeAt eq '1' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.use" /></option>
				<option value="2" <c:if test="${paramVO.searchNoticeAt eq '2' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.unuse" /></option>
			</select>
		</div>
		<table class="basic-table">
			  <colgroup>
				<col width="5%" />
				<c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
                <col width="10%" />
				</c:if>
				<c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
				<col width="10%"/>
				</c:if>
				<col width="15%" />
				<col width="*" />
				<col width="15%" />
				<col width="8%" />
				<col width="8%" />
				<col width="10%" />
				<col width="5%" />
		      </colgroup>
			  <thead>
				<tr>
					<th>No.</th>
					<c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
                    <th><spring:message code="wzwg.cmm.word.se" /></th>
					</c:if>
					<c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
					<th><spring:message code="wzwg.module.word.sitese" /></th>
					</c:if>
					<th><spring:message code="wzwg.module.word.popupty" /></th>
					<th><spring:message code="wzwg.module.word.popupnm" /></th>
					<th><spring:message code="wzwg.module.word.popuppd" /></th>
					<th><spring:message code="wzwg.cmm.word.sttus" /></th>
					<th><spring:message code="wzwg.module.word.useat" /></th>
					<th><spring:message code="wzwg.cmm.word.rgsde" /></th>
					<th><spring:message code="wzwg.cmm.word.manage" /></th>
				</tr>
		      </thead>
			  <tbody>
			  <c:choose>
			  	<c:when test="${!empty resultList }">
			  		<c:forEach items="${resultList }" var="resultList" varStatus="status">
			  		<tr>
			  			<td>
			  				<c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.pageSize + status.count) + 1}"/>
			  			</td>
			  			<c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
			  			<td>
			  				<c:choose>
				  				<c:when test="${resultList.lcalsCodeNm eq '전체'}"><spring:message code="wzwg.cmm.word.all" /></c:when>
				  				<c:otherwise><c:out value="${resultList.lcalsCodeNm }"/></c:otherwise>
			  				</c:choose>
			  				
                            <c:if test="${!empty resultList.mlsfcCodeNm}">
                            	<c:choose>
					  				<c:when test="${resultList.mlsfcCodeNm eq '전체'}"><spring:message code="wzwg.cmm.word.all" /></c:when>
					  				<c:otherwise><c:out value="${resultList.mlsfcCodeNm }"/></c:otherwise>
				  				</c:choose>
                            </c:if>
			  			</td>
			  			</c:if>
			  			<c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
			  			<td>
			  				<c:if test="${resultList.siteSeq eq '10000000001' }"><spring:message code="wzwg.cmm.word.system" /></c:if>
			  				<c:if test="${resultList.siteSeq ne '10000000001' }"><spring:message code="wzwg.cmm.word.site" /></c:if>
			  			</td>
			  			</c:if>
			  			<td>
			  				<c:out value="${resultList.popupTyCodeNm }"/>
			  			</td>
			  			<td class="txt-l">
			  				<c:out value="${resultList.popupSj }"/>
			  			</td>
			  			<td>
			  				<c:out value="${resultList.startDt }"/><br/> ~ <c:out value="${resultList.endDt }"/>
			  			</td>
			  			<td>
			  				<c:if test="${resultList.popupSttus eq '대기'}"><span class="circle_badge bg-yellow-strong br3 vert-m"><spring:message code="wzwg.cmm.word.wait" /></span></c:if>
			  				<c:if test="${resultList.popupSttus eq '종료'}"><span class="circle_badge bg-grey-strong br3 vert-m"><spring:message code="wzwg.cmm.word.end" /></span></c:if>
			  				<c:if test="${resultList.popupSttus eq '진행중'}"><span class="circle_badge bg-blue-strong br3 vert-m"><spring:message code="wzwg.cmm.word.ongo" /></span></c:if>
			  			</td>
			  			<td>
			  				<c:if test="${resultList.noticeAt eq '사용'}"><span class="circle_badge bg-blue-strong br3 vert-m"><spring:message code="wzwg.cmm.word.use" /></span></</c:if>
			  				<c:if test="${resultList.noticeAt eq '사용안함'}"><span class="circle_badge bg-grey-strong br3 vert-m"><spring:message code="wzwg.cmm.word.unuse" /></span></c:if>
			  			</td>
			  			<td>
			  				<c:out value="${resultList.frstRegistPnttm }"/>
			  			</td>
			  			<td>
                    		<c:choose>
                    		<c:when test="${sessionScope.SITE_SEQ ne '10000000001' and resultList.siteSeq eq '10000000001' }">
                    			<div class="menu_help">
									<span class="circle_no vert-m">?</span>
									<div class="help_pop txt-l" style="right:0; left:auto;">
										<spring:message code="wzwg.cmm.msg.MSG432" />
									</div>
								</div>
                    		</c:when>
                    		<c:otherwise>
                    			<a href="javascript:void(0);" onclick="fn_modifyForm('<c:out value="${resultList.popupSeq}" />')" class="iconOnlyBtn btn-basic btn-modify" title="<spring:message code="wzwg.cmm.word.updt" />"><spring:message code="wzwg.cmm.word.updt" /></a>
                    		</c:otherwise>
                    		</c:choose>
			  			</td>
			  		</tr>
			  		</c:forEach>
			  	</c:when>
			  	<c:otherwise>
			  		<tr>
			  			<td colspan="9"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
			  		</tr>
			  	</c:otherwise>
			  	</c:choose>
			  </tbody>
		</table>
		
		<c:if test="${!empty resultList }">
		<div class="ctr-box" id="pageInfo">
			<ul class="num mobile-none">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
			</ul>
			
			<ul class="num pc-none">
				<ui:pagination paginationInfo="${mobilePaginationInfo}" type="image" jsFunction="fn_search" />
			</ul>
		</div>
		</c:if>
		
		<div class="wzAdmSrchbox txt-c">
			<select name="searchCondition" id="searchCondition">
				<option value="0"><spring:message code="wzwg.cmm.word.all" /></option>
				<option value="1" <c:if test="${paramVO.searchCondition eq '1' }">selected="selected"</c:if>><spring:message code="wzwg.module.word.popupnm" /></option>
				<option value="2" <c:if test="${paramVO.searchCondition eq '2' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.cn" /></option>
			</select>
			
			<c:set var="msg_txt01">
				<spring:message code="wzwg.cmm.cmmMsg.CMG011">
					<spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument>
					<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
				</spring:message>
			</c:set>
			
			<input type="text" class="txt" name="searchKeyword" placeholder="<c:out value="${msg_txt01}" />" value="<c:out value="${paramVO.searchKeyword }" />"/>
			<a href="javascript:void(0);" class="wzbtn-table btn-srch" onclick="fn_search('1');"><spring:message code="wzwg.cmm.word.search01" /></a>
		</div>
		<div class="rt-box">
			<a href="javascript:void(0);" class="wzbtn btn-save" onclick="fn_registForm();"><spring:message code="wzwg.cmm.word.regist" /></a>
		</div>
	</form>