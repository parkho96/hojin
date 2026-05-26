<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>


<script type="text/javascript">

$(document).ready(function(){
    $(".checkall").click(function(){
        if($(".checkall").prop("checked")){
            $("input[name=chkDelArr]").prop("checked", true);
        }else{
            $("input[name=chkDelArr]").prop("checked", false);
        }
    });
});

function fnSearch(pageIndex) {
    var frm = document.frmSrh;
    
    frm.pageIndex.value = pageIndex;
    
    frm.action = "<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/cntnts/cntntsInfo/selectCntntsInfoList.do";
    frm.submit();
}

function fnForm() {
    var frm = document.frmSrh;
    
    frm.sysmoduleSeq.value = frm.searchModuleSeq.value; 
    
    frm.action = "<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/cntnts/cntntsInfo/selectCntntsInfoForm.do";
    frm.submit();
}

function fnCheckDelete() {
    
    if( $(":checkbox[name='chkDelArr']:checked").length < 1 ){
        alert("<spring:message code="wzwg.cmm.msg.MSG116" />");
        return;
    }
    
    if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" text="delete" /></spring:argument></spring:message>')){
        
        $.ajax({
            type:'POST'
            , url:'<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/cntnts/cntntsInfo/deleteCntntsInfoArr.do'
            , data:$("#frmList").serialize()
            , success:function (result){
                $(result).find('value').each(function(){
                    if($(this).text() == "success"){
                        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
                        fnSearch(1);
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

function fnDelete(sitecntntsSeq) {

    var frm = document.frmList;
    frm.sitecntntsSeq.value = sitecntntsSeq;

    $("input[name=chkDelArr]").prop("checked", false);
    
    if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" text="delete" /></spring:argument></spring:message>')){
        
        $.ajax({
            type:'POST'
            , url:'<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/cntnts/cntntsInfo/deleteCntntsInfo.do'
            , data:$("#frmList").serialize()
            , success:function (result){
                $(result).find('value').each(function(){
                    if($(this).text() == "success"){
                        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
                        fnSearch(1);
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

function fnListOrdr(gubun, ordr) {
    $('#moduleNmOrdr').val('');
    $('#cntntsNmOrdr').val('');
    $('#frstRegistPnttmOrdr').val('');
    $('#'+gubun).val(ordr);
    
    fnSearch(1);
}
</script>
			
			<div class="wz_notice brbox bg-white br-blue-strong">
			  <ul class="wd100">
			  	<c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
					<li class="admpg-subp wd100 red fw600 pb10">· <spring:message code="wzwg.cmm.msg.tip.MSG0354" /></li>
					<li class="admpg-subp wd100 fw600">· <spring:message code="wzwg.cmm.msg.tip.MSG0355" /></li>
	        	</c:if>
	        	<c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
			    	<li class="admpg-subp wd100 fw600">· <spring:message code="wzwg.cmm.msg.tip.MSG0353" /></li>
			    </c:if>
			    <li class="admpg-subp wd100 mb0">· <spring:message code="wzwg.cmm.msg.tip.MSG035" /></li>
			  </ul>
			</div>
						
            <form:form modelAttribute="paramVO" id="frmSrh" name="frmSrh">
            <form:hidden path="pageIndex" />
            <form:hidden path="sysmoduleSeq" />
            <form:hidden path="moduleNmOrdr" />
            <form:hidden path="cntntsNmOrdr" />
            <form:hidden path="frstRegistPnttmOrdr" />
            
            <div class="main-menu-bar">
                <form:select path="searchModuleSeq" onchange="javascript:fnSearch(1);">
                    <form:option value=""><spring:message code="wzwg.cmm.word.all" /></form:option>
                    <form:options items="${moduleAllList}" itemLabel="moduleNm" itemValue="sysmoduleSeq" />
                </form:select>
                <form:hidden path="searchCondition" name="searchCondition" value="1" />
                <%-- 
                <form:select path="searchCondition" title="<spring:message code="wzwg.cmm.word.searchse"/>"> 
                    <option value="1"><spring:message code="wzwg.site.cntnts.msg.MSG021" /></option>
                </form:select>
                 --%>
                <c:set var="srchwrd">
					<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
				</c:set>
				
                <form:input path="searchKeyword" cssClass="txt" onkeydown="if(event.keyCode == 13){fnSearch(1);}" placeholder="${srchwrd}" />
                <a href="javascript:void(0);" class="wzbtn-table btn-srch" onclick="fnSearch(1);"><spring:message code="wzwg.cmm.word.search01" /></a>
            </div>
            </form:form>

            <c:set var="moduleNmOrdr" />
            <c:choose>
            <c:when test="${empty paramVO.moduleNmOrdr}">
                <c:set var="moduleNmOrdr" value="A" />
            </c:when>
            <c:otherwise>
                <c:if test="${paramVO.moduleNmOrdr eq 'A'}">
                    <c:set var="moduleNmOrdr" value="D" />
                </c:if>
                <c:if test="${paramVO.moduleNmOrdr eq 'D'}">
                    <c:set var="moduleNmOrdr" value="A" />
                </c:if>
            </c:otherwise>
            </c:choose>

            <c:set var="cntntsNmOrdr" />
            <c:choose>
            <c:when test="${empty paramVO.cntntsNmOrdr}">
                <c:set var="cntntsNmOrdr" value="A" />
            </c:when>
            <c:otherwise>
                <c:if test="${paramVO.cntntsNmOrdr eq 'A'}">
                    <c:set var="cntntsNmOrdr" value="D" />
                </c:if>
                <c:if test="${paramVO.cntntsNmOrdr eq 'D'}">
                    <c:set var="cntntsNmOrdr" value="A" />
                </c:if>
            </c:otherwise>
            </c:choose>

            <c:set var="frstRegistPnttmOrdr" />
            <c:choose>
            <c:when test="${empty paramVO.frstRegistPnttmOrdr}">
                <c:set var="frstRegistPnttmOrdr" value="A" />
            </c:when>
            <c:otherwise>
                <c:if test="${paramVO.frstRegistPnttmOrdr eq 'A'}">
                    <c:set var="frstRegistPnttmOrdr" value="D" />
                </c:if>
                <c:if test="${paramVO.frstRegistPnttmOrdr eq 'D'}">
                    <c:set var="frstRegistPnttmOrdr" value="A" />
                </c:if>
            </c:otherwise>
            </c:choose>

            <form id="frmList" name="frmList">            
            	<input type="hidden" id="sitecntntsSeq" name="sitecntntsSeq" />
			
				<table class="basic-table">
				<colgroup>
					<col width="3%"/>
					<col width="10%"/>
					<col width="25%"/>
					<col width="*"/>
					<col width="10%"/>
					<col width="10%"/>
				</colgroup>
				<thead>
				<tr>
					<th><ul class="wzForm"><li><label><input type="checkbox" id="chkDelArr" name="chkDelArr" class="checkall" value="" /><span class="spanLabel"><span class="dp-none"><spring:message code="wzwg.site.cmm.msg.MSG006"/></span></span></label></li></ul></th>
					<th><spring:message code="wzwg.site.cntnts.msg.MSG020" /> <a href="#" onclick="fnListOrdr('moduleNmOrdr', '<c:out value="${moduleNmOrdr}"/>');"><c:if test="${moduleNmOrdr eq 'D'}">▲</c:if><c:if test="${moduleNmOrdr eq 'A'}">▼</c:if></a></th>
					<th><spring:message code="wzwg.site.cntnts.msg.MSG021" /><a href="#" onclick="fnListOrdr('cntntsNmOrdr', '<c:out value="${cntntsNmOrdr}"/>');"><c:if test="${cntntsNmOrdr eq 'D'}">▲</c:if><c:if test="${cntntsNmOrdr eq 'A'}">▼</c:if></a></th>
					<th><spring:message code="wzwg.site.cntnts.msg.MSG022" />
							<div class="menu_help">
								<span class="circle_no vert-m">?</span>
								<div class="help_pop txt-l" style="width:350px;">
									<span class="circle_badge bg-grey-strong br3">MENU</span> : <spring:message code="wzwg.cmm.msg.tip.MSG0351" /><br>
									<div style="display:inline-block; text-indent:-45px; padding-left:45px;">
										<span class="circle_badge bg-blue-strong br3" style="text-indent:0;">TAB</span>: <spring:message code="wzwg.cmm.msg.tip.MSG0352" />
									</div>
								</div>
							</div>
					</th>
					<th><spring:message code="wzwg.site.cntnts.msg.MSG023" /><a href="#" onclick="fnListOrdr('frstRegistPnttmOrdr', '<c:out value="${frstRegistPnttmOrdr}"/>');"><c:if test="${frstRegistPnttmOrdr eq 'D'}">▲</c:if><c:if test="${frstRegistPnttmOrdr eq 'A'}">▼</c:if></a></th>
					<th><spring:message code="wzwg.cmm.word.rm" /></th>
				</tr>
				</thead>
				
				<tbody>
				
				<c:if test="${!empty resultList}">
				<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
                   <td>
                   <ul class="wzForm">
                   	<li>
                   		<label><input type="checkbox" id="chkDelArr" name="chkDelArr" value="<c:out value="${result.sitecntntsSeq}"/>" <c:if test="${!empty menuPathCheck[result.sitecntntsSeq]}">disabled="disabled"</c:if> /><span class="spanLabel"></span></label>
                   	</li>
                   </ul>
                   
                   </td>
                   <td><c:out value="${result.moduleNm}"/></td>
                   <td><c:out value="${result.cntntsNm}"/></td>
                   <%-- <td><c:out value="${fn:replace(fn:replace(menuPathList[result.sitecntntsSeq], ",", "<br />"), "|", " > ")}"/></td> --%>
                   <td class="txt-l grey">
                   		<c:set var="menuItemCnt" value="1"></c:set>
                   		<c:forEach items="${menuPathList }" var="pathList">
                   			<c:if test="${pathList.sitecntntsSeq eq result.sitecntntsSeq }">
	                   			<c:if test="${menuItemCnt gt 1 }"><br></c:if>
	                   			<c:if test="${pathList.menuDc eq 'menu' }"><span class="circle_badge bg-grey-strong br3 vert-m">MENU</span></c:if>
	                   			<c:if test="${pathList.menuDc eq 'tab' }"><span class="circle_badge bg-blue-strong br3 vert-m">TAB</span></c:if>
	                   			<c:out value="${fn:replace(pathList.menuNmPath, '|', ' > ')}"></c:out>
	                   			<c:set var="menuItemCnt" value="${menuItemCnt + 1 }"></c:set>
                   			</c:if>
                   		</c:forEach>
                   </td>
                   <td><span class="grey fs15"><c:out value="${result.frstRegistPnttm}"/></span></td>
                   <td>
                       <a href="<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/<c:out value="${result.mngrPageUrl}"/>?cntntsSeq=<c:out value="${result.cntntsSeq}"/>&sitecntntsSeq=<c:out value="${result.sitecntntsSeq}"/>" class="btn-setting iconOnlyBtn btn-basic" title="<spring:message code="wzwg.cmm.word.estbs" />"><spring:message code="wzwg.cmm.word.estbs" /></a>
                       <c:choose>
                       <c:when test="${!empty menuPathCheck[result.sitecntntsSeq]}">
                       <a href="javascript:void(0);" onclick="javascript:alert('<spring:message code="wzwg.cmm.msg.MSG174" />');" class="btn-delete iconOnlyBtn btn-basic" title="<spring:message code="wzwg.cmm.word.delete" />"><spring:message code="wzwg.cmm.word.delete" /></a>
                       </c:when>
                       <c:otherwise>
                       <a href="javascript:void(0);" onclick="javascript:fnDelete('<c:out value="${result.sitecntntsSeq}"/>');" class="btn-delete iconOnlyBtn btn-basic" title="<spring:message code="wzwg.cmm.word.delete" />"><spring:message code="wzwg.cmm.word.delete" /></a>
                       </c:otherwise>
                       </c:choose>
                   </td>
				</tr>
				</c:forEach>
				</c:if>
				
				</tbody>
				</table>
				
            </form>
			
			<c:if test="${!empty resultList}">
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
				<a href="javascript:void(0);" onclick="javascript:fnForm();" class="wzbtn btn-save bg"><spring:message code="wzwg.cmm.word.regist" /></a>
				<a href="javascript:void(0);" onclick="javascript:fnCheckDelete();" class="wzbtn btn-del fl"><spring:message code="wzwg.site.cntnts.msg.MSG002" /></a>
            </div>
