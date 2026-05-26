<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 셀렉트 검색 라이브러리 -->
<link href="/js/wzwg/cmm/select2/select2.css" rel="stylesheet" />
<script src="/js/wzwg/cmm/select2/select2.js"></script>

	<script type="text/javascript">
		/** 체크박스 전체 선택 && 전체 삭제 */
		$(document).ready(function(){
			$("#checkall").click(function(){
				if($("#checkall").prop("checked")){
					$("input[name=chk]").prop("checked", true);
				}else{
					$("input[name=chk]").prop("checked", false);
				}
			});
			
			<c:if test="${sessionScope.SYSMNGR_AT eq 'Y' }">
			$('#siteSeq').select2();
			</c:if>
		});
		
		function fnPage(paramPageIndex){
			
			if(isNaN(paramPageIndex)){
				console.log('잘못된 페이지호출');
				return;
			}
			
			document.usrInfoForm.pageIndex.value = paramPageIndex;
			document.usrInfoForm.action='<c:out value="${wzwg_contextPath}${prefix}" />/usrMngr/usrInfo/selectUsrInfoList.do';
			document.usrInfoForm.submit();
			
		}
		
		function fnSearch(){
			document.usrInfoForm.pageIndex.value = 1;
			document.usrInfoForm.action='<c:out value="${wzwg_contextPath}${prefix}" />/usrMngr/usrInfo/selectUsrInfoList.do';
			document.usrInfoForm.submit();
		}
		
		function fn_usrInfoDetail(siteSeq, usrSeq){
            document.usrInfoForm.siteSeq.value = siteSeq;
			document.usrInfoForm.usrSeq.value = usrSeq;
			document.usrInfoForm.action='<c:out value="${wzwg_contextPath}${prefix}" />/usrMngr/usrInfo/modifyUsrInfoForm.do';
			document.usrInfoForm.submit();
		}
		
		function fn_usrInfoDelete(){

		    if( $(':checkbox[name="chk"]:checked').length < 1 ){
                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
						'<spring:argument><spring:message code="wzwg.cmm.word.emplyr" /></spring:argument>'+
						'<spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument>'+
					  '</spring:message>');
		        return;
		    }
		    
			if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
				
				$.ajax({
					type:'POST'
					, url:'<c:out value="${wzwg_contextPath}${prefix}" />/usrMngr/usrInfo/deleteUsrInfo.do'
					, data:$("#usrInfoForm").serialize()
					,success:function (result){
						$(result).find('value').each(function(){
							if($(this).text() == "success"){
								alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
								fnSearch();
							}else{
								alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
							}
						})
					}
					, error:function (request, status, error) {
			              alert('<spring:message code="fail.common.msg" text="error" />');
			          }
				});
			}else{
				return ;
			}
		}
		
		function fn_checkUsrInfoConfm() {

            if( $(':checkbox[name="chk"]:checked').length < 1 ){
                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
						'<spring:argument><spring:message code="wzwg.cmm.word.emplyr" /></spring:argument>'+
						'<spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument>'+
					  '</spring:message>');
                return;
            }
            
            if(confirm('<spring:message code="wzwg.cmm.msg.MSG306" />')){
                
                $.ajax({
                    type:'POST'
                    , url:'<c:out value="${wzwg_contextPath}${prefix}" />/usrMngr/usrInfo/modifyUsrSttus.do'
                    , data:$("#usrInfoForm").serialize()
                    ,success:function (result){
                        $(result).find('value').each(function(){
                            if($(this).text() == "success"){
                                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.confm" /></spring:argument></spring:message>');
                                fnSearch();
                            }else{
                                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.confm" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
                            }
                        })
                    }
                    , error:function (request, status, error) {
                          alert('<spring:message code="fail.common.msg" text="error" />');
                      }
                });
            }else{
                return ;
            }
		}
		
	</script>
	
	<div class="wz_notice brbox bg-white br-blue-strong">	
	    <ul class="wd100">
		    <li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG026" /></li>
		    <c:if test="${sessionScope.SYSMNGR_AT ne 'Y' }"><li class="admpg-subp wd100 mb0">· <spring:message code="wzwg.cmm.msg.tip.MSG027" /></li></c:if>
	    </ul>
	</div>
	
    <form:form modelAttribute="paramVO" id="usrInfoForm" name="usrInfoForm" method="post">
		<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex}" />" />
        <input type="hidden" name="usrSeq" id="usrSeq" value=""/>
        <c:if test="${sessionScope.SYSMNGR_AT ne 'Y' }">
        	<input type="hidden" name="siteSeq" id="siteSeq" value=""/>
        </c:if>
		<div class="wzAdmSrchbox txt-l wd90 wm100">
			<c:set var="temp_msg_txt01">
				<spring:message code="wzwg.cmm.cmmMsg.CMG011">
					<spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument>
					<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
				</spring:message>
			</c:set>
			<c:set var="msg_txt01"><c:out value="${temp_msg_txt01}" /></c:set>
			<c:set var="tempTit"><spring:message code="wzwg.sysMngr.word.sch01Se" /></c:set>
			<c:set var="searchTit"><c:out value="${tempTit}"/></c:set>
			<c:choose>
				<c:when test="${sessionScope.SYSMNGR_AT eq 'Y' }">
					<select name="siteSeq" id="siteSeq" onchange="fnSearch();">
						<option value="" <c:if test="${empty paramVO.siteSeq }">selected="selected"</c:if> ><spring:message code="wzwg.cmm.word.all" /></option>
						<c:forEach items="${siteInfoList }" var="siteInfoList" varStatus="status">
							<option value="<c:out value="${siteInfoList.siteSeq }" />" <c:if test="${paramVO.siteSeq eq siteInfoList.siteSeq}">selected="selected"</c:if>>
								<c:out value="${siteInfoList.siteFullNm }"/>
							</option>
						</c:forEach>
					</select>
                    <%-- <select name="usrSttusCode" id="usrSttusCode" onchange="fnSearch();">
                        <option value="" <c:if test="${empty paramVO.usrSttusCode }">selected="selected"</c:if> ><spring:message code="wzwg.cmm.word.all" /></option>
                        <c:forEach items="${usrSttusList }" var="usrSttusList" varStatus="status">
                            <option value="${usrSttusList.code }" <c:if test="${paramVO.usrSttusCode eq usrSttusList.code}">selected="selected"</c:if>>
                                <c:out value="${usrSttusList.codeNm }"/>
                            </option>
                        </c:forEach>
                    </select> --%>
                   <!--  <input type="hidden" name="searchCondition" value="1"/> -->
    			    <form:select path="searchCondition" id="searchCondition" title="${fn:escapeXml(searchTit)}">
					<form:option value="0"><label for="option1"><spring:message code="wzwg.cmm.word.all" /></label></form:option>
					<form:option value="1"><label for="option2"><spring:message code="wzwg.cmm.word.nm02" /></label></form:option>
					<form:option value="2"><label for="option3"><spring:message code="wzwg.cmm.word.id02" /></label></form:option>
			        </form:select>
    			    <form:input path="searchKeyword" cssClass="txt" onkeydown="if(event.keyCode == 13){fnSearch(1);}" placeholder="${fn:escapeXml(msg_txt01)}" />
			        <a href="javascript:void(0);" onclick="fnSearch(1);" class="wzbtn-table btn-srch"><spring:message code="wzwg.cmm.word.search01" /></a>
    			</c:when>
				<c:otherwise>
					<div class="pb10 i-block wm100">
	                    <select name="usrTyCode" id="usrTyCode" onchange="fnSearch();">
	                        <option value="" <c:if test="${empty paramVO.usrTyCode }">selected="selected"</c:if>><spring:message code="wzwg.sysMngr.word.mberTyAll" /></option>
	                        <c:forEach items="${usrTyCdList }" var="usrTyCdList" varStatus="status">
	                            <option value="<c:out value="${usrTyCdList.code }" />" <c:if test="${paramVO.usrTyCode eq usrTyCdList.code}">selected="selected"</c:if>>
	                                <c:out value="${usrTyCdList.codeNm }"/>
	                            </option>
	                        </c:forEach>
	                    </select>
	                    <select name="usrGroupSeq" id="usrGroupCode" onchange="fnSearch();">
	                        <option value="" <c:if test="${empty paramVO.usrGroupSeq }">selected="selected"</c:if> ><spring:message code="wzwg.sysMngr.word.mberGroupAll" /></option>
	                        <c:forEach items="${usrGroupCode }" var="usrGroupCode" varStatus="status">
	                            <option value="<c:out value="${usrGroupCode.usrGroupSeq }" />" <c:if test="${paramVO.usrGroupSeq eq usrGroupCode.usrGroupSeq}">selected="selected"</c:if>>
	                                <c:out value="${usrGroupCode.usrGroupNm }"/>
	                            </option>
	                        </c:forEach>
	                    </select>
	                    <select name="usrSttusCode" id="usrSttusCode" onchange="fnSearch();">
	                        <option value="" <c:if test="${empty paramVO.usrSttusCode }">selected="selected"</c:if> ><spring:message code="wzwg.sysMngr.word.mberSttusAll" /></option>
	                        <c:forEach items="${usrSttusList }" var="usrSttusList" varStatus="status">
	                            <option value="<c:out value="${usrSttusList.code }" />" <c:if test="${paramVO.usrSttusCode eq usrSttusList.code}">selected="selected"</c:if>>
	                                <c:out value="${usrSttusList.codeNm }"/>
	                            </option>
	                        </c:forEach>
	                    </select>
	                </div>
                   <!--  <input type="hidden" name="searchCondition" value="1"/> -->
                    <form:select path="searchCondition" id="searchCondition" title="${fn:escapeXml(searchTit)}">  
					<form:option value="0"><label for="option1"><spring:message code="wzwg.cmm.word.all" /></label></form:option>
					<form:option value="1"><label for="option2"><spring:message code="wzwg.cmm.word.nm02" /></label></form:option>
					<form:option value="2"><label for="option3"><spring:message code="wzwg.cmm.word.id02" /></label></form:option>
    			   	</form:select>
    			    <form:input path="searchKeyword" cssClass="txt" onkeydown="if(event.keyCode == 13){fnSearch(1);}" placeholder="${fn:escapeXml(msg_txt01)}" />
			        <a href="javascript:void(0);" onclick="fnSearch(1);" class="wzbtn-table btn-srch"><spring:message code="wzwg.cmm.word.search01" /></a>
				</c:otherwise>
			</c:choose>
			
		</div>
		<div class="fr txt-r wd10 wm100 pb10 pt20">
			<span class="member"><spring:message code="wzwg.cmm.word.total" /> <c:out value="${usrInfoCnt}"/> <spring:message code="wzwg.cmm.word.count04" /></span>
		</div>
	
		<table class="basic-table">
			<colgroup>
                   <c:choose>
	                   <c:when test="${sessionScope.SYSMNGR_AT eq 'Y' }">
		                   <col width="10%"/>
		                   <col width="*"/> 
		                   <col width="20%"/>
		                   <col width="15%"/>
		                   <col width="10%"/>
		                   <c:set var="colCnt" value="5"/>
	                   </c:when>
	                   <c:otherwise>
		                   <col width="5%"/>
		                   <col width="5%"/>
		                   <col width="15%"/>
		                   <col width="10%"/>
		                   <col width="*"/>
		                   <col width="8%"/>
		                   <col width="10%"/>
		                   <col width="10%"/>
		                   <c:set var="colCnt" value="8"/>
	                   </c:otherwise>
                   </c:choose>
			</colgroup>
	 		<thead>
				<tr>
					<c:if test="${sessionScope.SYSMNGR_AT ne 'Y' }"><th><ul class="wzForm"><li><label><input type="checkbox" name="checkall" id="checkall"/><span class="spanLabel"></span></label></li></ul></th></c:if>
					<th>No</th>
                    <c:if test="${sessionScope.SYSMNGR_AT eq 'Y' }"><th><spring:message code="wzwg.sysMngr.word.siteNm01" /></th></c:if>
                    <c:if test="${sessionScope.SYSMNGR_AT ne 'Y' }">
                    	<th><spring:message code="wzwg.sysMngr.word.mberTy" />(<spring:message code="wzwg.cmm.word.detail02" />)
                    	<div class="menu_help">
								<span class="circle_no">?</span>
								<div class="help_pop">
									<spring:message code="wzwg.cmm.msg.tip.MSG0391" />
								</div>
							</div>
                    	</th>
						<th><spring:message code="wzwg.sysMngr.word.mberGroup" /></th>
					</c:if>
					<th><spring:message code="wzwg.cmm.word.nm02" /> (<spring:message code="wzwg.cmm.word.id02" />)</th>
                    <c:if test="${sessionScope.SYSMNGR_AT ne 'Y' }"><th><spring:message code="wzwg.cmm.word.sttus" /></th></c:if>
					<th><spring:message code="wzwg.cmm.word.sbscrb" /> <spring:message code="wzwg.cmm.word.de" /></th>
					<th><spring:message code="wzwg.cmm.word.manage" /></th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty usrInfoList}">
					<tr>
						<td colspan="<c:out value="${colCnt}" />"><spring:message code="wzwg.cmm.msg.MSG246" /></td>
					</tr>
				</c:if>
				<c:forEach items="${usrInfoList }" var="usrInfoList" varStatus="status">
					<tr>
						<c:if test="${sessionScope.SYSMNGR_AT ne 'Y' }"><td><ul class="wzForm"><li><label><input type="checkbox" name="chk" value="<c:out value="${usrInfoList.usrSeq}" />:<c:out value="${usrInfoList.siteSeq}" />" /><span class="spanLabel"></span></label></li></ul></td></c:if>
						<td><c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.pageSize + status.count) + 1 }"/></td>
                        <c:if test="${sessionScope.SYSMNGR_AT eq 'Y' }">
                           	<td><c:out value="${usrInfoList.siteFullNm }"/></td>
                        </c:if>
                        <c:if test="${sessionScope.SYSMNGR_AT ne 'Y' }">
                        	<td><c:if test="${empty usrInfoList.usrTyCodeNm }"><spring:message code="wzwg.sysMngr.word.siteMngr" /></c:if><c:out value="${usrInfoList.usrTyCodeNm }"/>(<c:out value="${usrInfoList.usrDetailTyNm }"/>)</td>
                        	<td><c:out value="${usrInfoList.usrGroupNm }"/></td>
						</c:if>
                        <td><c:out value="${usrInfoList.userNm }"/> <span class="grey fs15"> (<c:out value="${usrInfoList.userId }"/>)</span></td>
                        <c:if test="${sessionScope.SYSMNGR_AT ne 'Y' }">
                        	<td><c:out value="${usrInfoList.usrSttusCodeNm }"/></td>
                        </c:if>
                        <td><c:out value="${usrInfoList.sbscrbPnttm }"/></td>
                        <td><a href="javascript:void(0);" onclick="fn_usrInfoDetail(<c:out value="${usrInfoList.siteSeq}" />,<c:out value="${usrInfoList.usrSeq}" />)" class="iconOnlyBtn btn-basic btn-setting" title="<spring:message code="wzwg.cmm.word.estbs" />"><spring:message code="wzwg.cmm.word.estbs" /></a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<c:if test="${!empty usrInfoList}">
			<div class="ctr-box" id="pageInfo">
				<ul class="num mobile-none">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnPage" />
				</ul>
				
				<ul class="num pc-none">
					<ui:pagination paginationInfo="${mobilePaginationInfo}" type="image" jsFunction="fnPage" />
				</ul>
			</div>
		</c:if>

    </form:form>
	<div class="rt-box">
		<c:if test="${sessionScope.SYSMNGR_AT ne 'Y' }">
			<a href="javascript:void(0);" onclick="fn_usrInfoDelete();" class="wzbtn btn-del fl"><spring:message code="wzwg.sysMngr.word.choiseDelete" /></a>
			<a href="javascript:void(0);" onclick="fn_checkUsrInfoConfm();" class="wzbtn btn-save"><spring:message code="wzwg.sysMngr.word.choiseConfm" /></a>
		</c:if>
	</div>
