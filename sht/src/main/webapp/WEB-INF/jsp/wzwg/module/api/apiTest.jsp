<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">

$(document).ready(function() {
    var sitecntntsSeq = '<c:out value="${paramVO.searchCntntsSeq}"/>';
    
    if (sitecntntsSeq == '') {
        fnSearch();
    }
});

function fnSearch() {
    var frm = document.frmCol;
    
    frm.action = "<c:out value='${wzwg_contextPath}'/>/mngr/module/api/selectApiTest.do";
    frm.submit();
}

function fnSitecntntslList(codeVal) {
    $.ajax({
        type:'POST'
      , url:'<c:out value="${wzwg_contextPath}"/>/mngr/module/api/selectSitecntntsSeqList.do'
      , data:$("#frmCol").serialize()
      , success:function (data) {
          
          $('#searchCntntsSeq').empty();
          
          $(data).find('response').find('item').each(function (idx) {
              
              var classId = $(this).find('name').text();
              var classNm = $(this).find('value').text();
              $('#searchCntntsSeq').append('<option value="'+classId+'">'+classNm+'</option>');
          });
        }
      , dataType: 'xml'
  });
}

/** 게시판 리스트 팝업 */
function fnApiCall(apiCallSe, apiRetType, ajaxUrl){
    
    var frm = document.frmList;
    
    frm.apiCallSe.value  = apiCallSe;
    frm.apiRetType.value = apiRetType;
    
    var windowOpen = window.open("", "popForm", "width=500,height=400,toolbars=no,menubars=no,scrollbars=yes");
    
    frm.target = "popForm";
    frm.action=ajaxUrl;
    frm.submit();
}
</script>

            <form:form modelAttribute="paramVO" id="frmCol" name="frmCol" method="post">    
            <div class="search mg_t10">
<%--                 <c:set var="temp_moduleList"><c:out value="${moduleList}" /></c:set>
                <c:set var="temp_cntntsList"><c:out value="${cntntsList}" /></c:set>
                <form:select path="searchModuleSeq" items="${temp_moduleList}" itemLabel="moduleNm" itemValue="sysmoduleSeq" onchange="javascript:fnSitecntntslList(this.value);" cssClass="form-control w20"></form:select>
                <form:select path="searchCntntsSeq" items="${temp_cntntsList}" itemLabel="cntntsNm" itemValue="sitecntntsSeq" onchange="javascript:fnSearch();" cssClass="form-control w20"></form:select> --%>
				<select id="searchModuleSeq" name="searchModuleSeq" onchange="fnSitecntntslList(this.value);" class="form-control w20">
				    <c:forEach var="item" items="${moduleList}">
				        <option value="<c:out value='${item.sysmoduleSeq}'/>" ${paramVO.searchModuleSeq == item.sysmoduleSeq ? 'selected' : ''}>
				            <c:out value="${item.moduleNm}" />
				        </option>
				    </c:forEach>
				</select>
				
				<select id="searchCntntsSeq" name="searchCntntsSeq" onchange="fnSearch();" class="form-control w20">
				    <c:forEach var="item" items="${cntntsList}">
				        <option value="<c:out value='${item.sitecntntsSeq}'/>" ${paramVO.searchCntntsSeq == item.sitecntntsSeq ? 'selected' : ''}>
				            <c:out value="${item.cntntsNm}" />
				        </option>
				    </c:forEach>
				</select>
             </div>
             </form:form>
            
            <form:form modelAttribute="paramVO" id="frmList" name="frmList" method="post">  
            <input type="hidden" id="apiCallSe" name="apiCallSe" />
            <input type="hidden" id="apiRetType" name="apiRetType" />
              
            <div class="tableWrap row mg_t20">
            <table>
            <caption>게시판 양식 상세</caption>
            <colgroup>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="*"/>
            </colgroup>
            <tbody>
                <c:if test="${!empty resultList}">
                <c:forEach var="result" items="${resultList}" varStatus="status">
                <tr>
                    <th scope="row" rowspan="10">API</th>
                    <th class="ta_l" colspan="3">호출URL</th>
                    <td class="ta_l">
                        <c:out value="/${result.pckagePath}/api/callCntntsList.do" />
                    </td>
                </tr>
                <tr>
                    <th class="ta_l" rowspan="6">PARAM</th>
                    <th class="ta_l" rowspan="4">기본</th>
                    <th class="ta_l">인증키</th>
                    <td class="ta_l">
                        <select id="apiCrtfcKey" name="apiCrtfcKey" class="form-control w30">
                        <c:forEach var="crtfcKey" items="${crtfcKeyList}">
                            <option value="<c:out value='${crtfckey.apiCrtfcKey}'/>"><c:out value="${crtfcKey.apiNm}" /></option>
                        </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th class="ta_l">모듈</th>
                    <td class="ta_l">
                        <input type="hidden" id="sysmoduleSeq" name="sysmoduleSeq" value="<c:out value='${result.sysmoduleSeq}'/>" />
                        <c:out value="${result.sysmoduleSeq}" />
                    </td>
                </tr>
                <tr>
                    <th class="ta_l">컨텐츠</th>
                    <td class="ta_l">
                        <input type="hidden" id="sitecntntsSeq" name="sitecntntsSeq" value="<c:out value='${result.sitecntntsSeq}'/>" />
                        <c:out value="${result.sitecntntsSeq}" />
                    </td>
                </tr>
                <tr>
                    <th class="ta_l">세부컨텐츠</th>
                    <td class="ta_l">
                        <input type="hidden" id="cntntsSeq" name="cntntsSeq" value="<c:out value='${result.cntntsSeq}'/>" />
                        <c:out value="${result.cntntsSeq}" />
                    </td>
                </tr>
                <tr>
                    <th class="ta_l" rowspan="2">사용자설정</th>
                    <th class="ta_l">현재페이지</th>
                    <td class="ta_l">
                        <input type="text" id="pageIndex" name="pageIndex" value="1" class="form-control w10" />
                    </td>
                </tr>
                <tr>
                    <th class="ta_l">페이지사이즈</th>
                    <td class="ta_l">
                        <input type="text" id="pageSize" name="pageSize" value="10" class="form-control w10" />
                    </td>
                </tr>
                <tr>
                    <th class="ta_l" rowspan="3">기능</th>
                    <th class="ta_l" rowspan="3"><spring:message code="wzwg.cmm.word.list" /></th>
                    <th class="ta_l">JSON</th>
                    <td class="ta_l">
                        <a href="javascript:void(0);" onclick="javascript:fnApiCall('L', 'J', '<c:out value="${wzwg_contextPath}"/>/<c:out value="${result.pckagePath}"/>/api/callCntntsList.do');" class="btn btn_default btn_xs">JSON 호출</a>
                    </td>
                </tr>
                <tr>
                    <th class="ta_l">기본디자인</th>
                    <td class="ta_l">
                        <a href="javascript:void(0);" onclick="javascript:fnApiCall('L', 'P', '<c:out value="${wzwg_contextPath}"/>/<c:out value="${result.pckagePath}"/>/api/callCntntsList.do');" class="btn btn_default btn_xs"><spring:message code="wzwg.cmm.word.preview" /> 호출</a>
                    </td>
                </tr>
                <tr>
                    <th class="ta_l">소스</th>
                    <td class="ta_l">
                        <textarea style="width:100%;" rows="10" cols=""></textarea>
                    </td>
                </tr>
                </c:forEach>
                </c:if>
            </tbody>
            </table>
            </div>
            </form:form>
