<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
	$(document).ready(function(){
		$("#chkAll").click(function(){
			if($("#chkAll").prop("checked")){
				$("input[name=sysopertSeqArr]").prop("checked", true);
			}else{
				$("input[name=sysopertSeqArr]").prop("checked", false);
			}
		});
	});
	
	/** 등록 / 수정 폼 */
	function fn_opertForm(paramSeq){
		document.searchForm.sysopertSeq.value = paramSeq;
		document.searchForm.action='<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteOpert/selectSysOpertNtcForm.do';
		document.searchForm.submit();
	}

	/** 페이징 && 검색 */
	function fn_search(paramPageIndex){
		
		if(isNaN(paramPageIndex)){
			console.log('잘못된 페이지호출');
			return;
		}
		
		document.searchForm.pageIndex.value = paramPageIndex;
		document.searchForm.action='<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteOpert/selectSysOpertNtcList.do';
		document.searchForm.submit();
	}

	/** 선택삭제 */
	function fn_deleteArr(){
		if( $(":checkbox[name='sysopertSeqArr']:checked").length < 1 ){
			alert("<spring:message code="wzwg.cmm.msg.MSG116" />");
			return ;
		}
		
		if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" text="delete" /></spring:argument></spring:message>')){
	 		$.ajax({
	 			type:'POST'
	 			, url:'<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/siteOpert/deleteSysOpertNtcArrAjax.do'
	 			, data:$("#searchForm").serialize()
	 			,success:function (result){
	 				$(result).find('value').each(function(){
	 					if($(this).text() == "success"){
	 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
	 						fn_search('1');
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
		<input type="hidden" name="sysopertSeq" id="sysopertSeq" value="" />
		<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex }" />" />
		
		<div class="wz_notice brbox bg-white br-blue-strong" style="overflow: visible;">	
			<ul class="wd100">
				<li class="admpg-subp wd100 fw600">· <spring:message code="wzwg.cmm.msg.tip.MSG134" /> </li>
				<li class="admpg-subp wd100 mb0">· <spring:message code="wzwg.cmm.msg.tip.MSG135" /></li>
			</ul>
		</div>
		
		<div>
			<table class="basic-table">
				<colgroup>
					<col width="5%" />
				  	<col width="5%" />
					<col width="20%" />
					<col width="*" />
					<col width="15%" />
					<col width="7%" />
					<col width="10%" />
					<col width="10%" />
			    </colgroup>
				<thead>
					<tr>
						<th><ul class="wzForm"><li><label><input type="checkbox" id="chkAll" /><span class="spanLabel"></span></label></ul></th>
						<th>No</th>
						<th><spring:message code="wzwg.cmm.word.lclas" /> <span class="i-block mr5" style="width:8px; height:8px; transform:rotate(45deg); border:1px solid #333; border-width:1px 1px 0 0;"></span> <spring:message code="wzwg.cmm.word.mlsfc" /></th>
						<th><spring:message code="wzwg.sysMngr.word.opertNm01" /></th>
						<th><spring:message code="wzwg.sysMngr.word.opertPd" /></th>
						<th><spring:message code="wzwg.sysMngr.word.applcAt" /></th>
						<th><spring:message code="wzwg.sysMngr.word.registDe01" /></th>
						<th><spring:message code="wzwg.cmm.word.manage" /></th>
					</tr> 
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${!empty resultList }">
							<c:forEach items="${resultList }" var="resultList" varStatus="status">
							<tr>
								<td>
									<ul class="wzForm"><li><label><input type="checkbox" name="sysopertSeqArr" value="<c:out value="${resultList.sysopertSeq }" />"/><span class="spanLabel"></span></label></ul>
								</td>
				  				<td>
				  					<c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.pageSize + status.count) + 1}"/>
				  				</td>
				  				<td>
				  					<c:out value="${resultList.siteLclasGroupNm }"/> <span class="i-block mr5" style="width:8px; height:8px; transform:rotate(45deg); border:1px solid #333; border-width:1px 1px 0 0;"></span> <c:out value="${resultList.siteMlsfcGroupNm }"/>
				  				</td>
				  				<td class="txt-l"><c:out value="${resultList.opertNm }"/></td>
				  				<td>
				  					<c:out value="${resultList.opertBgnde }시"/><br>~ <c:out value="${resultList.opertEndde }시"/>
				  				</td>
				  				<td>
				  				<c:if test="${resultList.opertApplcAt eq '적용'}">
				  					<spring:message code="wzwg.cmm.word.applc" />
				  				</c:if>
				  				<c:if test="${resultList.opertApplcAt eq '미적용'}">
				  					<spring:message code="wzwg.cmm.word.unapplc" />
				  				</c:if>
				  				</td>
				  				<td>
				  					<c:out value="${resultList.frstRegistPnttm }"/>
				  				</td>
				  				<td><a href="javascript:void(0);" onclick="fn_opertForm('<c:out value="${resultList.sysopertSeq}"/>')" class="iconOnlyBtn btn-basic btn-setting" title="<spring:message code="wzwg.cmm.word.estbs" />"><spring:message code="wzwg.cmm.word.estbs" /></a></td>
							</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="8"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
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
		</div>
	</form>
	
	<div class="rt-box">
		<a href="javascript:void(0);" class="wzbtn btn-del fl" onclick="fn_deleteArr();"><spring:message code="wzwg.sysMngr.word.choiseDelete" /></a>
		<a href="javascript:void(0);" class="wzbtn btn-basic" onclick="fn_opertForm('');"><spring:message code="wzwg.cmm.word.regist" /></a>
	</div>