<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
function fn_usrTySbscrbModify() {
    
    if (confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>')){
        var frm = document.regForm;

        var qesitmArr = new Array();
        var iemArr = new Array();
        
        for(var i = 1; i <= $('#qestnEstbsDiv select[name=qesitmSe]').length; i++){
             
            // 객체 생성
            var qesitm_data = new Object();
            // 객체 생성
            var iem_data = new Object();
            
            qesitm_data.qesitmSeq       = i;
            qesitm_data.sbscrbqesitmSeq = $('#qestnEstbsDiv input[id=sbscrbqesitmSeq'+i+']').val();
            qesitm_data.qesitmSe        = $('#qestnEstbsDiv select[id=qesitmSe'+i+']').val();
            qesitm_data.qesitmSj        = $('#qestnEstbsDiv input[id=qesitmSj'+i+']').val();
            
            iem_data.qesitmSeq          = qesitm_data.qesitmSeq;
            
            if(qesitm_data.qesitmSe == 'O'){
                iem_data.sbscrbiemSeq1  = $('#iemDiv'+i+' input[id=sbscrbiemSeq1]').val();
                iem_data.sbscrbiemSeq2  = $('#iemDiv'+i+' input[id=sbscrbiemSeq2]').val();
                iem_data.sbscrbiemSeq3  = $('#iemDiv'+i+' input[id=sbscrbiemSeq3]').val();
                iem_data.sbscrbiemSeq4  = $('#iemDiv'+i+' input[id=sbscrbiemSeq4]').val();
                iem_data.sbscrbiemSeq5  = $('#iemDiv'+i+' input[id=sbscrbiemSeq5]').val();
                //iem_data.iem1           = $('#iemDiv'+i+' input[id=iemSj1]').val();
                //iem_data.iem2           = $('#iemDiv'+i+' input[id=iemSj2]').val();
                //iem_data.iem3           = $('#iemDiv'+i+' input[id=iemSj3]').val();
                //iem_data.iem4           = $('#iemDiv'+i+' input[id=iemSj4]').val();
                //iem_data.iem5           = $('#iemDiv'+i+' input[id=iemSj5]').val();
                //iem_data.iem_len        = $('#iemDiv'+i+' input[name=iemSj]').length;
                $('#iemDiv'+i+' input[name="iemSj"]').each(function(idx, el){
                	idx ++;
                	iem_data["iem" + idx] = $(this).val();
                });
                iem_data.iem_len        = $('#iemDiv'+i+' input[name=iemSj]').length;
            }
             
            // 리스트에 생성된 객체 삽입
            qesitmArr.push(qesitm_data);
            iemArr.push(iem_data);
        }
        
        frm.qesitmArr.value = JSON.stringify(qesitmArr);
        frm.iemArr.value    = JSON.stringify(iemArr);
        
        $.ajax({
            type:'POST'
            , url:'<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrTy/modifySiteUsrTySbscrb.do'
            , data:$("#regForm").serialize()
            ,success:function (result){
                $(result).find('value').each(function(){
                    if($(this).text() == "success"){
                        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>');
                        $.ajax({
                            type:'POST'
                            , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/siteSbscrb/selectSbscrbQesitmImport.do'
                            , dataType:'html'
                            , data:$("#regForm").serialize()
                            , success:function (data) {
                                $('#qestnEstbsDiv').html(data).find('qesitmListDiv');
                            }
                            , error:function (request, status, error) {
                                alert('<spring:message code="fail.common.msg" text="error" />');
                            }
                        });
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
}

function fn_usrTyDetail(){
    var frm = document.regForm;
    frm.action='<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrTy/selectUsrTyList.do';
    frm.submit();
}

function fn_usrSbscrbInfo(){
    var frm = document.regForm;
    frm.action='<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrTy/selectUsrTySbscrbFormList.do';
    frm.submit();
}

</script>

    <jsp:include page="/WEB-INF/jsp/wzwg/sysMngr/usrMngr/usrTy/usrTyTab.jsp"></jsp:include>

	<form id="regForm" name="regForm" method="post">
        <input type="hidden" id="qesitmArr" name="qesitmArr" />
        <input type="hidden" id="iemArr" name="iemArr" />
        <input type="hidden" id="usrtySeq" name="usrtySeq" value="<c:out value="${sysMngrUsrTyVO.usrTySeq}" />" />
        
		<table class="basic">
			<colgroup>
				<col width="20%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
				<tr>
					<th><spring:message code="wzwg.cmm.word.id02" /></th>
					<td><spring:message code="wzwg.sysMngr.word.chgImprty" /></td>
				</tr>
                <tr>
                    <th><spring:message code="wzwg.cmm.word.password" /></th>
                    <td><spring:message code="wzwg.sysMngr.word.chgImprty" /></td>
                </tr>
                <tr>
                    <th><spring:message code="wzwg.sysMngr.word.passwdCnfirm" /></th>
                    <td><spring:message code="wzwg.sysMngr.word.chgImprty" /></td>
                </tr>
                <c:choose>
                <c:when test="${empty resultList}">
                <tr>
                    <td><spring:message code="wzwg.cmm.msg.MSG153" /></td>
                </tr>
                </c:when>
                <c:otherwise>
                <c:forEach items="${resultList}" var="result" varStatus="status">
                <input type="hidden" id="mberSbsfrmCodeArr" name="mberSbsfrmCodeArr" value="<c:out value="${result.mberSbsfrmCode}" />" />
                <input type="hidden" id="qesitmEstbsSeArr" name="qesitmEstbsSeArr" value="<c:out value="${status.count}" />" />
                <tr>
                    <th><c:out value="${result.mberSbsfrmCodeNm}" /></td>
                    <td>
                        <c:if test="${result.qesitmEstbsSe eq 'E'}"><spring:message code="wzwg.cmm.word.use" />(<spring:message code="wzwg.cmm.word.requinput" />)</c:if> 
                        <c:if test="${result.qesitmEstbsSe eq 'S'}"><spring:message code="wzwg.cmm.word.use" />(<spring:message code="wzwg.cmm.word.electinput" />)</c:if> 
                        <c:if test="${result.qesitmEstbsSe eq 'N'}"><spring:message code="wzwg.cmm.word.unuse" /></c:if> 
                    </td>
                </tr>
                </c:forEach>
                </c:otherwise>
                </c:choose>
			</tbody>
		</table>

		<h3 class="wzAdmSTit wd100 fl"><spring:message code="wzwg.cmm.cntnts.addQestnSet"/></h3>
		<div id="qestnEstbsDiv" class="">
            <c:import url="${wzwg_contextPath}/mngr/usrMngr/siteSbscrb/selectSbscrbQesitmImport.do" charEncoding="utf-8">
            <c:param name="usrtySeq" value="${sysMngrUsrTyVO.usrTySeq}"></c:param>
            </c:import>
        </div>

	</form>
	
	<div class="rt-box">
		<a href="javascript:void(0);" class="wzbtn btn-save" onclick="fn_usrTySbscrbModify();"><spring:message code="wzwg.cmm.word.stre" /></a>
		<a href="javascript:void(0);" class="wzbtn btn-basic" onclick="fn_usrTyDetail();"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>
