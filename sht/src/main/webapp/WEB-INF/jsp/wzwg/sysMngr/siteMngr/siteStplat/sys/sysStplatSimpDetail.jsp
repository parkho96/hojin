<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<jsp:include page="/WEB-INF/jsp/wzwg/webModule/editorTool.jsp"></jsp:include>

<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js"></script>

<script type="text/javascript" src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>

<link href="/css/wzwg/cmm/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />
<script>
$(document).ready(function() {
    fnDateSet();
});
function fnDateSet() {

    $(".datePicker").datepicker({       
        dateFormat: 'yymmdd',
        monthNamesShort: ['1<spring:message code="wzwg.cmm.word.mt" />','2<spring:message code="wzwg.cmm.word.mt" />','3<spring:message code="wzwg.cmm.word.mt" />','4<spring:message code="wzwg.cmm.word.mt" />','5<spring:message code="wzwg.cmm.word.mt" />','6<spring:message code="wzwg.cmm.word.mt" />','7<spring:message code="wzwg.cmm.word.mt" />','8<spring:message code="wzwg.cmm.word.mt" />','9<spring:message code="wzwg.cmm.word.mt" />','10<spring:message code="wzwg.cmm.word.mt" />','11<spring:message code="wzwg.cmm.word.mt" />','12<spring:message code="wzwg.cmm.word.mt" />'],
		    dayNamesMin: ['<spring:message code="wzwg.cmm.word.sun01" />','<spring:message code="wzwg.cmm.word.mon01" />','<spring:message code="wzwg.cmm.word.tue01" />','<spring:message code="wzwg.cmm.word.wed01" />','<spring:message code="wzwg.cmm.word.thu01" />','<spring:message code="wzwg.cmm.word.fri01" />','<spring:message code="wzwg.cmm.word.sat01" />'],
        weekHeader: 'Wk',
        changeMonth: true,  //월변경가능
        changeYear: true,   //년변경가능
        yearRange:'-10:+10',    // 연도 셀렉트 박스 범위(현재와 같으면 1988~현재년)
        showMonthAfterYear: true,   //년 뒤에 월 표시
        buttonImageOnly: false, //이미지표시  
        buttonText: '<spring:message code="wzwg.cmm.msg.MSG088" />', 
        autoSize: false  //오토리사이즈(body등 상위태그의 설정에 따른다) 
     });
}
function fnRegistStplatsimp() {

    var frm = document.frm;

    var stplatsimpSeq = frm.stplatsimpSeq.value;
    
    var actionNm = '';
    var actionUrl = '';
    
    
    actionNm = '<spring:message code="wzwg.cmm.word.updt" />';
    actionUrl = '<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/sysSiteStplat/sys/modifySysSiteStplatSimp.do';
    
    oEditors.getById["stplatCn"].exec("UPDATE_CONTENTS_FIELD", []);
    
    if(!Validator.validate(frm)){
        return;
    }
    
    if (frm.opertnDe.value > frm.endDe.value) {
        return alert('<spring:message code="wzwg.cmm.msg.MSG274" />');
    }
    
    if (confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006">'+
					'<spring:argument><spring:message code="wzwg.sysMngr.word.siguupStplat" /></spring:argument>'+
					'<spring:argument>'+actionNm+'</spring:argument>'+
				  '</spring:message>')) {
        
        $.ajax({
            type:'POST'
          , url:actionUrl
          , async : true
          , data:$("#frm").serialize()
          , success:function (data) {
              $(data).find('value').each(function(){
                  if($(this).text() == "success"){ 
                          alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
                       location.href='<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/sysSiteStplat/sys/selectSysSiteStplatSimpList.do';
                       
                  }else{
                      alert('<spring:message code="fail.common.msg" text="error" />');
                  }
              })
          }
          , dataType: 'xml'
         });
    }
}

function fnStplatsimpDelete() {

    var frm = document.frm;

    var stplatsimpSeq = frm.stplatsimpSeq.value;
    
    var actionNm = '';
    var actionUrl = '';
    
    
    actionNm = '<spring:message code="wzwg.cmm.word.delete" />';
    actionUrl = '<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/sysSiteStplat/sys/deleteSysSiteStplatSimp.do';
    
    oEditors.getById["stplatCn"].exec("UPDATE_CONTENTS_FIELD", []);
    
    if(!Validator.validate(frm)){
        return;
    }
    
    if (frm.opertnDe.value > frm.endDe.value) {
        return alert('<spring:message code="wzwg.cmm.msg.MSG274" />');
    }
    
    if (confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006">'+
					'<spring:argument><spring:message code="wzwg.sysMngr.word.siguupStplat" /></spring:argument>'+
					'<spring:argument>'+actionNm+'</spring:argument>'+
				  '</spring:message>')) {
        
        $.ajax({
            type:'POST'
          , url:actionUrl
          , async : true
          , data:$("#frm").serialize()
          , success:function (data) {
              $(data).find('value').each(function(){
                  if($(this).text() == "success"){ 
                          alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
                       location.href='<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/sysSiteStplat/sys/selectSysSiteStplatSimpList.do';
                       
                  }else{
                      alert('<spring:message code="fail.common.msg" text="error" />');
                  }
              })
          }
          , dataType: 'xml'
         });
    }
}

function fnList(){
	document.frm.action='<c:out value="${wzwg_contextPath}${prefix}" />/sysSiteStplat/sys/selectSysSiteStplatSimpList.do';
	document.frm.submit();
}

</script>
<form name="frm" id="frm" method="post">
                <input type="hidden" id="stplatsimpSeq" name="stplatsimpSeq" value="<c:out value="${infoSimpVO.stplatsimpSeq}" />" />
                <input type="hidden" id="stplatSeq" name="stplatSeq" value="<c:out value="${infoSimpVO.stplatSeq}" />" />
                <!--기본정보 table// -->
                <table summary="<spring:message code="wzwg.sysMngr.word.stplatInfo" />" class="basic">
                    <colgroup>
                        <col width="15%">
                        <col width="35%">
                        <col width="15%">
                        <col width="*">
                    </colgroup>
                    <tbody>
                        <tr>
                            <th><spring:message code="wzwg.cmm.word.opertnDe" /></th>
                            <td>
                                <input type="text" id="opertnDe" name="opertnDe" dir="required" class="datePicker cal w10" readonly="readonly" title="<spring:message code="wzwg.cmm.word.opertnDe" />" value="<c:out value="${infoSimpVO.opertnDe}" />" /> 
                            </td>
                            <th><spring:message code="wzwg.cmm.word.endde" /></th>
                            <td>
                                <input type="text" id="endDe" name="endDe" class="datePicker cal w10" readonly="readonly" title="<spring:message code="wzwg.cmm.word.endde" />" value="<c:out value="${infoSimpVO.endDe}" />" />
                            </td>
                        </tr>
                        <tr>
                            <th><spring:message code="wzwg.cmm.word.sj" /></th>
                            <td colspan="3">
                                <input type="text" class="w70" name="stplatSj" id="stplatSj" dir="required" title="<spring:message code="wzwg.cmm.word.sj" />" value="<c:out value="${infoSimpVO.stplatSj}" />" placeholder="<spring:message code="wzwg.cmm.word.sj" />" />
                            </td>
                        </tr>
                        <tr>
                            <th><spring:message code="wzwg.cmm.word.cn" /></th>
                            <td colspan="3">
                                <textarea name=stplatCn id="stplatCn" rows="30" class="w90" dir="required" title="<spring:message code="wzwg.cmm.word.cn" />" style="width:100%;">
                                <c:out value="${infoSimpVO.stplatCn}" />
                                </textarea>
                                
                                <script type="text/javascript">
                                    var oEditors = [];
                                    nhn.husky.EZCreator.createInIFrame({
                                        oAppRef: oEditors,
                                        elPlaceHolder: "stplatCn",
                                        sSkinURI: "<c:out value="${wzwg_contextPath}" />/smartEditor2.8.2.1/smartEditor2Skin.do",
                                        fCreator: "createSEditor2",
                                        htParams: {fOnBeforeUnload : function(){}}
                                    });
                                    
                                    WzwgEditorTool.instance("stplatCn");
                                </script>
                            </td>
                        </tr>
                    </tbody>
                </table>
 </form>               
           <div class="rt-box">
                    <a href="javascript:void(0);" class="wzbtn btn-del fl" onclick="fnStplatsimpDelete()"><spring:message code="wzwg.cmm.word.delete" /></a>
                    <a href="javascript:void(0);" class="wzbtn btn-save" onclick="fnRegistStplatsimp()"><spring:message code="wzwg.cmm.word.updt" /></a>
                    <a href="javascript:void(0);" class="wzbtn btn-basic" onclick="fnList();"><spring:message code="wzwg.cmm.word.list" /></a>
                </div>