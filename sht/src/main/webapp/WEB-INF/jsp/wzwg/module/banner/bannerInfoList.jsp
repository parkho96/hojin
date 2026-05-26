<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
//등록화면 이동
function fnRegistForm() {
    var frm = document.frmSrh;
    
    frm.action = "<c:out value='${wzwg_contextPath}${prefix}'/>/module/banner/registModuleBannerInfoForm.do";
    frm.submit(); 
}

function fnSearch(pageIndex) {
    if(isNaN(pageIndex)){console.log('잘못된 페이지호출');return;}
    var frm = document.frmSrh;
    frm.pageIndex.value = pageIndex;
    frm.action = "<c:out value='${wzwg_contextPath}${prefix}'/>/module/banner/selectModuleBannerInfoList.do";
    frm.submit();
}

//수정화면 이동
function fnDetail(bannerSeq) {
    var frm = document.frmSrh;
    frm.bannerSeq.value = bannerSeq;
    frm.action = "<c:out value='${wzwg_contextPath}${prefix}'/>/module/banner/modifyModuleBannerInfoForm.do";
    frm.submit();
}

</script>

    <form id="frmSrh" name="frmSrh" method="post">
    	<input type="hidden" name="bannerSeq" id="bannerSeq" />
        <input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value='${paramVO.pageIndex}'/>" />
        <input type="hidden" name="pageUnit" value="10" />
        <div class="wz_notice brbox bg-white br-blue-strong" style="overflow: visible;">	
			<ul class="wd100">
				<li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG022" /></li>
				<li class="admpg-subp wd100 wzAdmSTit p0 mb0" style="background: transparent;">· <spring:message code="wzwg.module.word.exposurelcguidance" />
				<div class="menu_help">
					<img src="/images/wzwg/site/mngr/ico_help_grey.png" alt="">
					<div class="help_pop">
					     <img src="/images/wzwg/site/mngr/bnrNotice.jpg" class="mxwd100"  alt="<spring:message code="wzwg.cmm.word.banrguid" />">
				                </div>
				</div>
				</li>	
			</ul>
		</div>
        <div class="main-menu-bar">
        	<label class="fs16 vert-m" for="searchPopupSttus"><spring:message code="wzwg.cmm.word.sttus" /> : </label>
			<select name="searchPopupSttus" id="searchPopupSttus" onchange="fnSearch('1');">
				<option value=""><spring:message code="wzwg.cmm.word.all" /></option>
				<option value="0" <c:if test="${paramVO.searchPopupSttus eq '0' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.wait" /></option>
				<option value="1" <c:if test="${paramVO.searchPopupSttus eq '1' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.ongo" /></option>
				<option value="2" <c:if test="${paramVO.searchPopupSttus eq '2' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.end" /></option>
			</select>
			<label class="fs16 vert-m" for="searchNoticeAt"><spring:message code="wzwg.module.word.useat" /> : </label>
			<select name="searchNoticeAt" id="searchNoticeAt" name="searchNoticeAt" onchange="fn_search('1');">
				<option value=""><spring:message code="wzwg.cmm.word.all" /></option>
				<option value="1" <c:if test="${paramVO.searchNoticeAt eq '1' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.use" /></option>
				<option value="2" <c:if test="${paramVO.searchNoticeAt eq '2' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.unuse" /></option>
			</select>
			<label class="fs16 vert-m" for="searchCondition"><spring:message code="wzwg.cmm.word.search01" /> : </label>
			<select name="searchCondition" id="searchCondition">
				<option value=""><spring:message code="wzwg.cmm.word.all" /></option>
				<option value="1" <c:if test="${paramVO.searchCondition eq '1' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.sj" /></option>
				<option value="2" <c:if test="${paramVO.searchCondition eq '2' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.cn" /></option>
			</select>
			
			<c:set var="msg_txt01">
				<spring:message code="wzwg.cmm.cmmMsg.CMG011">
					<spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument>
					<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
				</spring:message>
			</c:set>
			
			<input type="text" class="txt" name="searchKeyword" placeholder="<c:out value='${msg_txt01}'/>" value="<c:out value='${paramVO.searchKeyword }'/>"/>
			<a href="javascript:void(0);" class="wzbtn-table btn-srch" onclick="fnSearch('1');"><spring:message code="wzwg.cmm.word.search01" /></a>
		</div>
    </form>
    
    <form id="frmList" name="frmList" method="post">
        <input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value='${paramVO.pageIndex}'/>" />
        <input type="hidden" name="bannerSeq" id="bannerSeq" value="<c:out value='${resultVO.bannerSeq}'/>"/>
        <!--//게시판 설정 table -->
        
          <table class="basic-table">
            <colgroup>
                    <col width="5%"/>
					<c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
                    <col width="12%"/>
                    </c:if>
                    <c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
                    <col width="10%"/>
                    </c:if>
                    <col width="10%"/>
                    <col width="*"/>
                    <col width="8%"/>
                    <col width="10%"/>
                    <col width="8%"/>
                    <col width="10%"/>
                    <col width="8%"/>
                    <col width="8%"/>
            </colgroup>
            <thead>
                <tr>
                    <th>No</th>
                    <c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
                    <th><spring:message code="wzwg.module.word.sitese" /></th>
                    </c:if>
                    <c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
					<th><spring:message code="wzwg.module.word.sitese" /></th>
					</c:if>
                    <th><spring:message code="wzwg.module.word.thumbimage" /></th>
                    <th><spring:message code="wzwg.module.word.bannernm" /></th>
                    <th><spring:message code="wzwg.module.word.sortordr" /></th>
                    <th><spring:message code="wzwg.cmm.word.pd" /></th>
                    <th><spring:message code="wzwg.cmm.word.sttus" /></th>
                    <th><spring:message code="wzwg.module.word.useat" /></th>
                    <th><spring:message code="wzwg.cmm.word.rgsde" /></th>
                    <th><spring:message code="wzwg.cmm.word.manage" /></th>
                </tr>   
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${!empty resultList }">
                <c:forEach items="${resultList}" var="result" varStatus="status">
                <tr>
                    <td><c:out value='${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count) + 1}'/></td>
                    <c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
                    <td>
						<c:out value="${result.bannerLclCodeNm }"/> > <c:out value="${result.bannerMclCodeNm }"/>
					</td>
                    </c:if>
                    <c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
                    <td>
                    	<c:if test="${result.siteSeq eq '10000000001' }"><spring:message code="wzwg.cmm.word.system" /></c:if>
			  			<c:if test="${result.siteSeq ne '10000000001' }"><spring:message code="wzwg.cmm.word.site" /></c:if>
                    </td>
                    </c:if>
                    <td><img style="max-width:130px; max-height:70px;" src='<c:url value='/module/upload/file/selectImageView.do'/>?atchFileId=<c:out value="${result.atchFileId }"/>&fileSn=0' style="height: 50px;" alt='<c:out value="${result.imgReplcText}" />' /></td>
                    <td class="txt-l">
                    		<c:choose>
                    		<c:when test="${sessionScope.SITE_SEQ ne '10000000001' and result.siteSeq eq '10000000001' }">
                    			<span class="pl15"><c:out value="${result.bannerNm}" /></span>
                    		</c:when>
                    		<c:otherwise>
                    			<span class="pl15"><c:out value="${result.bannerNm}" /></span>
                    		</c:otherwise>
                    		</c:choose>
                    </td>
                    <td>
                    	<c:out value='${result.sortOrdr }'/>
                    	<c:if test="${empty result.sortOrdr }"><spring:message code="wzwg.cmm.word.noOrd" /></c:if>
                    </td>
                    <td>
                    	<c:choose>
                    		<c:when test="${result.pdSetupAt eq 'Y'}"><span class="fs14"><c:out value="${result.startDt}" /> ~ <br /><c:out value="${result.endDt}" /></span></c:when>
                    		<c:otherwise><spring:message code="wzwg.cmm.word.unlimit" /></c:otherwise>
                    	</c:choose>
                    </td>
                    <td>
                    	<c:if test="${result.sttus eq '0'}"><span class="circle_badge bg-yellow-strong br3 vert-m"><spring:message code="wzwg.cmm.word.wait" /></span></c:if>
		  				<c:if test="${result.sttus eq '1'}"><span class="circle_badge bg-blue-strong br3 vert-m"><spring:message code="wzwg.cmm.word.ongo" /></span></c:if>
		  				<c:if test="${result.sttus eq '2'}"><span class="circle_badge bg-grey-strong br3 vert-m"><spring:message code="wzwg.cmm.word.end" /></span></c:if>
                    </td>
                    <td>
                        <c:if test="${result.noticeAt eq 'Y' }"><span class="circle_badge bg-blue-strong br3 vert-m"><spring:message code="wzwg.cmm.word.use" /></span></c:if>
                        <c:if test="${result.noticeAt ne 'Y' }"><span class="circle_badge bg-grey-strong br3 vert-m"><spring:message code="wzwg.cmm.word.unuse" /></span></c:if>
                    </td>
                    <td><span class="fs14"><c:out value="${result.frstRegistPnttm}" /></span></td>
                    <td>
                   		<c:choose>
                   		<c:when test="${sessionScope.SITE_SEQ ne '10000000001' and result.siteSeq eq '10000000001' }">
                   			<div class="menu_help">
								<span class="circle_no vert-m">?</span>
								<div class="help_pop txt-l" style="right:0; left:auto;">
									<spring:message code="wzwg.cmm.msg.MSG428" />
								</div>
							</div>
                   		</c:when>
                   		<c:otherwise>
                   			<a href="javascript:void(0);" onclick="fnDetail('<c:out value="${result.bannerSeq}"/>');" class="iconOnlyBtn btn-basic btn-modify" title="<spring:message code="wzwg.cmm.word.updt" />"><spring:message code="wzwg.cmm.word.updt" /></a>
                   		</c:otherwise>
                   		</c:choose>
                    </td>
                </tr>
                </c:forEach>
                </c:when>
                <c:otherwise>
                    <td colspan="8"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
     </form>
     
	<c:if test="${!empty resultList }">
	<div class="ctr-box" id="pageInfo">
		<ul class="num mobile-none">
			<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnSearch" />
		</ul>
		
		<ul class="num pc-none">
			<ui:pagination paginationInfo="${mobilePaginationInfo}" type="image" jsFunction="fnSearch" />
		</ul>
	</div>
	</c:if>

	<div class="rt-box">
		<a href="javascript:void(0);" class="wzbtn btn-save" onclick="fnRegistForm();"><spring:message code="wzwg.cmm.word.regist" /></a>
	</div>
