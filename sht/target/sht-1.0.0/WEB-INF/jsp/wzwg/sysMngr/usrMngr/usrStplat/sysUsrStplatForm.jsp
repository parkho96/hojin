<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
    function fn_usrTyModify(){
        
        if(!Validator.validate(document.usrTyModifyForm)){
            return;
        }
        
        $.ajax({
            type:'POST'
            <c:choose>
            <c:when test="${empty resultVO.usrstplatSeq}">
            , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/usrStplat/registSysUsrStplat.do'
            </c:when>
            <c:otherwise>
            , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/usrStplat/modifySysUsrStplat.do'
            </c:otherwise>
            </c:choose>
            , data:$("#usrTyModifyForm").serialize()
            ,success:function (result){
                $(result).find('value').each(function(){
                    if($(this).text() == "success"){
                        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>');
                        <c:if test="${empty resultVO.usrstplatSeq}">
                        fn_usrTyList();
                        </c:if>
                        <c:if test="${!empty resultVO.usrstplatSeq}">
                        fn_usrTyDetail();
                        </c:if>
                    }else{
                        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
                    }
                })
            }
            , error:function (request, status, error) {
                  alert('<spring:message code="fail.common.msg" text="error" />');
              }
        });
    }
    
    function fn_usrTyDetail(){
        var frm = document.usrTyModifyForm;
        frm.action='<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/usrStplat/selectSysUsrStplatForm.do';
        frm.submit();
    }
    
    function fn_usrTyList(){
        var frm = document.usrTyModifyForm;
        frm.action='<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/usrStplat/selectSysUsrStplatList.do';
        frm.submit();
    }

    function fnCheckAll() {
        if ($('.checkall').is(':checked')) {
            $('input[name=usrstphistSeqArr]').prop('checked', true);
        } else {
            $('input[name=usrstphistSeqArr]').prop('checked', false);
        }
    }
    function fn_delete(){

        if ($('input:checkbox[id="usrstphistSeqArr"]').is(':checked')) {
            if (confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006">'+
							'<spring:argument><spring:message code="wzwg.cmm.word.data" /></spring:argument>'+
							'<spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument>'+
						'</spring:message>')) {
                $.ajax({
                    type:'POST'
                    , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/usrStplat/deleteSysUsrStplatHist.do'
                    , data:$("#stplatHistForm").serialize()
                    ,success:function (result){
                        $(result).find('value').each(function(){
                            if($(this).text() == "success"){
                                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>');
                                fn_usrTyDetail();
                            }else{
                                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
                            }
                        })
                    }
                    , error:function (request, status, error) {
                          alert('<spring:message code="fail.common.msg" text="error" />');
                      }
                });
            }
        } else {
            alert('<spring:message code="wzwg.cmm.msg.MSG116" />');
        }
    }
    
</script>
 
    <form id="usrTyModifyForm" name="usrTyModifyForm" method="post">
        <input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex}" />" />
        <input type="hidden" name="searchCondition" id="searchCondition" value="<c:out value="${paramVO.searchCondition}" />"/>
        <input type="hidden" name="searchKeyword" id="searchKeyword" value="<c:out value="${paramVO.searchKeyword}" />"/>
        <input type="hidden" name="usrstplatSeq" id="usrstplatSeq" value="<c:out value="${resultVO.usrstplatSeq}" />"/>
        <table summary="약관설정" class="basic">
            <colgroup>
                <col width="30%"/>
                <col width="*"/>
            </colgroup>
            <tbody>
                <tr>
                    <th><spring:message code="wzwg.sysMngr.word.stplatNm01" /> </th>
                    <td>
                        <input type="text" name="stplatSj" class="w70" value="<c:out value="${resultVO.stplatSj}" />" dir="required" title="<spring:message code="wzwg.sysMngr.word.mberTy" />"/>
                    </td>
                </tr>
                <tr>
                    <th><spring:message code="wzwg.sysMngr.word.stplatDc" /></th>
                    <td>
                        <input type="text" name="stplatCn" class="w70" value="<c:out value="${resultVO.stplatCn}" />" dir="required" title="<spring:message code="wzwg.sysMngr.word.mberTyDc" />"/>
                    </td>
                </tr>
                <tr>
                    <th><spring:message code="wzwg.sysMngr.word.essntlAt" /></th>
                    <td>
                    	<ul>
                    		<li><label><input type="radio" name="stplatEstbsSe" value="E" <c:if test="${resultVO.stplatEstbsSe eq 'E' || empty resultVO.stplatEstbsSe}">checked</c:if> title="<spring:message code="wzwg.sysMngr.word.essntlAtEssntl" />"/> <spring:message code="wzwg.cmm.word.essntl" /></label></li>
                    		<li><label><input type="radio" name="stplatEstbsSe" value="S" <c:if test="${resultVO.stplatEstbsSe eq 'S'}">checked</c:if> title="<spring:message code="wzwg.sysMngr.word.essntlAtSelect" />"/> <spring:message code="wzwg.cmm.word.choise" /></label></li>
                    		<li><label><input type="radio" name="stplatEstbsSe" value="N" <c:if test="${resultVO.stplatEstbsSe eq 'N'}">checked</c:if> title="<spring:message code="wzwg.sysMngr.word.essntlAtUnuse" />"/> <spring:message code="wzwg.cmm.word.unuse" /></label></li>
                    	</ul>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>
    
    <div class="rt-box">
        <a href="javascript:void(0);" onclick="fn_usrTyModify();" class="btn-a"><spring:message code="wzwg.cmm.word.stre" /></a>
        <a href="javascript:void(0);" onclick="fn_usrTyList();" class="btn-a"><spring:message code="wzwg.cmm.word.list" /></a>
    </div>
    
    <h2 class="mg_t20"> </h2>
    <c:if test="${!empty resultVO.usrstplatSeq}">
    <form id="stplatHistForm" name="stplatHistForm" method="post">
    <input type="hidden" name="usrstplatSeq" id="usrstplatSeq" value="<c:out value="${resultVO.usrstplatSeq}" />"/>
    <!--//게시판 설정 table -->
    <table class="basic-table">
        <colgroup>
            <col width="10%" />
            <col width="10%" />
            <col width="*" />
            <col width="20%" />
        </colgroup>
        <thead>
        <tr>
            <th><input type="checkbox" id="chkAll" name="chkAll" value="" onclick="fnCheckAll()" /></th>
            <th>No</th>
            <th><spring:message code="wzwg.sysMngr.word.estbsStplat" /></th>
            <th><spring:message code="wzwg.sysMngr.word.estbsDe" /></th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${empty resultHistList}">
        <tr>
            <td colspan="4"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
        </tr>
        </c:if>
        <c:forEach items="${resultHistList}" var="result" varStatus="status">
        <tr>
            <td><input type="checkbox" id="usrstphistSeqArr" name="usrstphistSeqArr" value="<c:out value="${result.usrstphistSeq}" />" /></td>
            <td><c:out value="${fn:length(resultHistList)-status.count+1}" /></td>
            <td><c:out value="${result.stplatSj}" /></td>
            <td><c:out value="${result.stplatEstbsPnttm}" /></td>
        </tr>
        </c:forEach>
        </tbody>
    </table>
    
    <div class="ctr-box fl">
        <a href="javascript:void(0);" onclick="fn_delete();" class="btn-b"><spring:message code="wzwg.sysMngr.word.choiseDelete" /></a>
    </div>
    </form>
    </c:if>
