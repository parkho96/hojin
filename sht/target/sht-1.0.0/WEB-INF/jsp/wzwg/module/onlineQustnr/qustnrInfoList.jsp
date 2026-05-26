<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
		
	<script type="text/javascript">
		/** 체크박스 전체 선택 && 전체 삭제 */
		$(document).ready(function(){
			$("#chkAll").click(function(){
				if($("#chkAll").prop("checked")){
					$("input[name=qustnrSeqArr]").prop("checked", true);
				}else{
					$("input[name=qustnrSeqArr]").prop("checked", false);
				}
			});
		});

		/** 페이징 && 검색 */
		function fnPage(paramPageIndex){
			if(isNaN(paramPageIndex)){console.log('잘못된 페이지호출');return;}
			document.searchForm.pageIndex.value = paramPageIndex;
			document.searchForm.action='<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineQustnr/selectOnlineQustnrInfoList.do';
			document.searchForm.submit();
		}

		/** 설문 등록 */
		function fnRegistForm(){
			document.searchForm.action='<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineQustnr/registOnlineQustnrInfoForm.do';
			document.searchForm.submit();
		}
		
		/** 설문 수정 */
		function fnModifyForm(paramSeq){
			document.searchForm.qustnrSeq.value = paramSeq;
			document.searchForm.action='<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineQustnr/modifyOnlineQustnrInfoForm.do';
			document.searchForm.submit();
		}
		
		/** 결과보기 팝업 */
		function fnResultPopup(paramSeq){
			document.searchForm.qustnrSeq.value = paramSeq;

	    	$.ajax({
	    		   type:'POST'
	    		 , url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineQustnr/selectOnlineQustnrInfoResultPopup.do'
	    		 , data: $("#searchForm").serialize()
	    		 , success:function (data) {
					wzAjaxModal('popup_l', '<spring:message code="wzwg.module.word.qestnrresultview" />', data);
				 }
				 , error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				 }
	    		 , dataType: 'html'
	    	});
		}
		
		/** 설문 삭제 */
		function fnDelete(paramSeq){
			if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
				return;
			} else {
				document.searchForm.qustnrSeq.value = paramSeq;

		 		$.ajax({
		 			type:'POST'
		 			, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineQustnr/deleteOnlineQustnrInfoAjax.do'
		 			, data:$("#searchForm").serialize()
		 			,success:function (result){
		 				$(result).find('value').each(function(){
		 					if($(this).text() == "success"){
		 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
		 						fnPage('1');
		 					}else{
		 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
		 					}
		 				})
		 			}
		 			, error:function (request, status, error) {
		 	              alert('<spring:message code="fail.common.msg" text="error" />');
		 	          }
		 		});
			}
		}
		
		/** 설문 선택삭제 */
		function fnChkDelete(){
			
			if( $(":checkbox[name='qustnrSeqArr']:checked").length < 1 ){
				alert("<spring:message code="wzwg.cmm.msg.MSG116" />");
				return ;
			}
			
			if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" text="delete" /></spring:argument></spring:message>')){
		 		$.ajax({
		 			type:'POST'
		 			, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineQustnr/deleteOnlineQustnrInfoArrAjax.do'
		 			, data:$("#searchForm").serialize()
		 			,success:function (result){
		 				$(result).find('value').each(function(){
		 					if($(this).text() == "success"){
		 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
		 						fnPage('1');
		 					}else{
		 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
		 					}
		 				})
		 			}
		 			, error:function (request, status, error) {
		 	              alert('<spring:message code="fail.common.msg" text="error" />');
		 	          }
		 		});
			}
		}
		
		
	</script>
	
	<form id="searchForm" name="searchForm" method="post">
		<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex}" />"/>
		<input type="hidden" name="qustnrSeq" id="qustnrSeq" value=""/>
		<div class="main-menu-bar">
			<b class="fs17 linehgt40 i-block"><spring:message code="wzwg.cmm.word.sttus" /></b> :
			<select name="searchCondition" id="searchCondition">
				<option value=""><spring:message code="wzwg.cmm.word.all" /></option>
				<option value="1" <c:if test="${paramVO.searchCondition eq '1' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.wait" /></option>
				<option value="2" <c:if test="${paramVO.searchCondition eq '2' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.ongo" /></option>
				<option value="3" <c:if test="${paramVO.searchCondition eq '3' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.end" /></option>
			</select>
			<b class="fs17 linehgt40 i-block"><spring:message code="wzwg.module.word.othbcat" /></b> :
			<select name="searchOthbcAt" id="searchOthbcAt">
				<option value="" <c:if test="${empty paramVO.searchOthbcAt or paramVO.searchOthbcAt eq '' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.all" /></option>
				<option value="1" <c:if test="${paramVO.searchOthbcAt eq '1' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.othbc" /></option>
				<option value="2" <c:if test="${paramVO.searchOthbcAt eq '2' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.clsdr" /></option>
			</select>
			<input type="text" class="txt" name="searchKeyword" value="<c:out value="${paramVO.searchKeyword }" />"/>
			<a href="javascript:void(0);" class="wzbtn-table btn-srch" onclick="fnPage('1');"><spring:message code="wzwg.cmm.word.search01" /></a>
		</div>
		<table class="basic-table">
			  <colgroup>
			  	<col width="5%" />
				<col width="5%" />
				<col width="*" />
				<col width="20%" />
				<col width="7%" />
				<col width="7%" />
				<col width="20%" />
		      </colgroup>
			  <thead>
				<tr>
					<th><ul class="wzForm"><li><label><input type="checkbox" id="chkAll"/><span class="spanLabel"></span></label></li></ul></th>
					<th>No</th>
					<th><spring:message code="wzwg.module.word.qustnrnm" /></th>
					<th><spring:message code="wzwg.module.word.qustnrpd" /></th>
					<th><spring:message code="wzwg.cmm.word.sttus" /></th>
					<th><spring:message code="wzwg.module.word.othbcat" /></th>
					<th><spring:message code="wzwg.cmm.word.manage" /></th>
				</tr>
		      </thead>
			  <tbody>
			  <c:choose>
			  	<c:when test="${!empty resultList }">
			  		<c:forEach items="${resultList }" var="resultList" varStatus="status">
			  		<tr>
			  			<td>
			  				<ul class="wzForm"><li><label><input type="checkbox" name="qustnrSeqArr" value="<c:out value="${resultList.qustnrSeq }" />"/><span class="spanLabel"></span></label></li></ul>
			  			</td>
			  			<td>
			  				<c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.pageSize + status.count) + 1}"/>
			  			</td>
			  			<td class="txt-l">
			  				<c:out value="${resultList.qustnrNm }"/>
			  			</td>
			  			<td>
			  				<span class="fs14"><c:out value="${resultList.bgnde }"/><spring:message code="wzwg.cmm.word.hour" /> <br>~ <c:out value="${resultList.endde }"/><spring:message code="wzwg.cmm.word.hour" /></span>
			  			</td>
			  			<td>
	                    	<c:if test="${resultList.qustnrSttus eq '대기'}"><span class="circle_badge bg-yellow-strong br3 vert-m"><spring:message code="wzwg.cmm.word.wait" /></span></c:if>
			  				<c:if test="${resultList.qustnrSttus eq '종료'}"><span class="circle_badge bg-grey-strong br3 vert-m"><spring:message code="wzwg.cmm.word.end" /></span></c:if>
			  				<c:if test="${resultList.qustnrSttus eq '진행중'}"><span class="circle_badge bg-blue-strong br3 vert-m"><spring:message code="wzwg.cmm.word.ongo" /></span></c:if>
			  			</td>
			  			<td>
			  				<c:if test="${resultList.othbcAt eq '공개'}"><span class="circle_badge bg-blue-strong br3 vert-m"><spring:message code="wzwg.cmm.word.othbc" /></span></c:if>
			  				<c:if test="${resultList.othbcAt eq '비공개'}"><span class="circle_badge bg-grey-strong br3 vert-m"><spring:message code="wzwg.cmm.word.clsdr" /></span></c:if>
			  			</td>
			  			<td>
			  				<a href="javascript:void(0)" onclick="fnResultPopup('<c:out value="${resultList.qustnrSeq}" />');" class="iconOnlyBtnSameSize btn-basic"><spring:message code="wzwg.cmm.word.resultview" /></a>
			  				<a href="javascript:void(0)" onclick="fnModifyForm('<c:out value="${resultList.qustnrSeq}" />');" class="iconOnlyBtn btn-basic btn-modify" title="<spring:message code="wzwg.cmm.word.updt" />"><spring:message code="wzwg.cmm.word.updt" /></a>
			  				<a href="javascript:void(0)" onclick="fnDelete('<c:out value="${resultList.qustnrSeq}" />');" class="iconOnlyBtn btn-basic btn-delete" title="<spring:message code="wzwg.cmm.word.delete" />"><spring:message code="wzwg.cmm.word.delete" /></a>
			  			</td>
			  		</tr>
			  		</c:forEach>
			  	</c:when>
			  	<c:otherwise>
			  		<tr>
			  			<td colspan="7"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
			  		</tr>
			  	</c:otherwise>
			  	</c:choose>
			  </tbody>
		</table>
		
		<c:if test="${!empty resultList }">
		<div class="ctr-box" id="pageInfo">
			<ul class="num mobile-none">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnPage" />
			</ul>
			
			<ul class="num pc-none">
				<ui:pagination paginationInfo="${mobilePaginationInfo}" type="image" jsFunction="fnPage" />
			</ul>
		</div>
		</c:if>
		 
		<div class="rt-box">
			<a href="javascript:void(0);" class="wzbtn btn-del fl" onclick="fnChkDelete();"><spring:message code="wzwg.module.word.choisedelete" /></a>
			<a href="javascript:void(0);" class="wzbtn btn-save bg" onclick="fnRegistForm();"><spring:message code="wzwg.cmm.word.regist" /></a>
		</div>
	</form> 