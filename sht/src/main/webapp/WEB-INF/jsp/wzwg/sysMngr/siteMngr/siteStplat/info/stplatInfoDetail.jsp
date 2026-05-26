<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<jsp:include page="/WEB-INF/jsp/wzwg/webModule/editorTool.jsp"></jsp:include>

<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js"></script>

<script type="text/javascript" src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>

<link href="/css/wzwg/cmm/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
$( document ).ready(function() {
    fnDetailList();
    fnDateSet();
	fnInit('<c:out value="${resultVO.stplatTyCode}"/>');
});

function fnDateSet(){
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

function fnInit(paramValue){
	if(paramValue != 'SC00000454'){
		$("input:radio[name='essntlAt']").removeAttr("disabled");
		$("input:radio[name='expsrAt']").removeAttr("disabled");
	}else{
		$("input:radio[name='essntlAt']").prop("disabled", true);
		$("input:radio[name='expsrAt']").prop("disabled", true);
	}
}

function fnList() {
    var frm = document.regForm;
    $('select[name=stplatTyCode').val('');
    frm.target = "_self";
    frm.action="<c:out value="${wzwg_contextPath}${prefix}"/>/siteMngr/siteStplat/info/selectStplatInfoList.do";
    frm.submit();
}

function fnModify() {

    if(!Validator.validate(document.regForm)){
        return;
    }

	$.ajax({
		type:'POST'
		, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/siteMngr/siteStplat/info/modifyStplatInfoAjax.do'
		, data:$("#regForm").serialize()
		,success:function (result){
			$(result).find('value').each(function(){
				if($(this).text() == "success"){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>');
				}else{
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
				}
			})
		}
		, error:function (request, status, error) {
	             alert('<spring:message code="fail.common.msg" text="error" />');
		}
	});
}

function fnCheckAll() {
    if ($('.checkall').is(':checked')) {
        $('input[name=stplatsimpSeqArr]').prop('checked', true);
    } else {
        $('input[name=stplatsimpSeqArr]').prop('checked', false);
    }
}

// 매핑 목록 조회
function fnDetailList() {
 $.ajax({
     type:'POST'
   , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/siteMngr/siteStplat/simp/selectSiteStplatSimpListAjax.do'
   , data: $("#regForm").serialize()
   , success:function (data) {
       $('#divList').html(data);
   }
   , error:function (data) {
       alert('<spring:message code="fail.common.msg" text="error" />');
   }
   , dataType: 'html'
 });
}

// 매핑 정보 삭제
function fnDetailDelete() {
    if ($('input:checkbox[id="stplatsimpSeqArr"]').is(':checked')) {
        if (confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')) {
            $.ajax({
                type:'POST'
              , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/siteMngr/siteStplat/simp/deleteSiteStplatSimp.do'
              , data:$("#frmList").serialize()
              , success:function (data) {
                  $(data).find('value').each(function(){
                      if($(this).text() == "success"){
                          alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
                          fnDetailList();
                      }else{
                          alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
                      }
                  })
              }
              , error:function (data) {
                  alert('<spring:message code="fail.common.msg" text="error" />');
              }
              , dataType: 'json'
            });
        }
    } else {
        alert('<spring:message code="wzwg.cmm.msg.MSG116" />');
    }
}

function fnRegistStplatsimp() {

    var frm = document.frmInfoSimp;

    var stplatsimpSeq = frm.stplatsimpSeq.value;
    
    var actionNm = '';
    var actionUrl = '';
    
    if (stplatsimpSeq != '') {
        actionNm = '<spring:message code="wzwg.cmm.word.updt" />';
        actionUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/siteMngr/siteStplat/simp/modifySiteStplatSimp.do';
    } else {
        actionNm = '<spring:message code="wzwg.cmm.word.stre" />';
        actionUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/siteMngr/siteStplat/simp/registSiteStplatSimp.do';
    }
    
    oEditors.getById["stplatCn"].exec("UPDATE_CONTENTS_FIELD", []);
    
    if(!Validator.validate(frm)){
        return;
    }
    
    var lastOpertDe = $("#lastRegistOpertnDe").val();
    
    if(lastOpertDe != '' && stplatsimpSeq == ''){
    	if(lastOpertDe.replace(/\-/g,'') >= frm.opertnDe.value){
    		return alert('<spring:message code="wzwg.cmm.msg.MSG335" />');
    	}
    }
    
    if (confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006">'+
					'<spring:argument><spring:message code="wzwg.sysMngr.word.detail02Stplat" /></spring:argument>'+
					'<spring:argument>'+actionNm+'</spring:argument>'+
				  '</spring:message>')) {
         
        $.ajax({
            type:'POST'
          , url:actionUrl
          , async : true
          , data:$("#frmInfoSimp").serialize()
          , success:function (data) {
              $(data).find('value').each(function(){
                  if($(this).text() == "success"){
                      if (stplatsimpSeq != '') {
                          alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>');
                      } else {
                          alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
                      }
                      fnDetailList();
                      fnStplatsimpClear();
                  }else{
                      alert('<spring:message code="fail.common.msg" text="error" />');
                  }
              })
          }
          , dataType: 'xml'
         }); 
    }
}

function fnStplatsimpClear() {
    var frm = document.frmInfoSimp;
    
    frm.stplatSeq.value = '<c:out value="${resultVO.stplatSeq}"/>';
    frm.stplatsimpSeq.value = '';
    frm.opertnDe.value = '';
    frm.stplatSj.value = '';
    frm.stplatCn.value = '';
    oEditors.getById["stplatCn"].exec("SET_IR", [""]);
}

function fnStplatsimpDetail(stplatsimpSeq) {

    var frm = document.frmInfoSimp;
    
    frm.stplatsimpSeq.value = stplatsimpSeq;
    
    $.ajax({
        type:'POST'
      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/siteMngr/siteStplat/simp/selectSiteStplatSimpAjax.do'
      , async : true
      , data:$("#frmInfoSimp").serialize()
      , success:function (data) {
          $('#divInfoSimp').html(data);
      }
      , dataType: 'html'
     });
}
</script>
                        
                <c:choose>
                <c:when test="${!empty paramVO.siteSeq}">
                    <jsp:include page="/WEB-INF/jsp/wzwg/sysMngr/siteMngr/siteInfo/siteInfoTab.jsp"></jsp:include>
                </c:when>
                <c:otherwise>
                    <h3><spring:message code="wzwg.sysMngr.word.siteStplatInfo" /></h3>
                </c:otherwise>
                </c:choose>

                <form:form modelAttribute="resultVO" id="regForm" name="regForm" method="post">
                    <%-- <form:hidden path="stplatSeq" name="stplatSeq" value="${resultVO.stplatSeq}" /> --%>
					<form:hidden path="stplatSeq" value="${fn:escapeXml(resultVO.stplatSeq)}" />
                
                    <c:choose>
                    <c:when test="${sessionScope.SYSMNGR_AT eq 'Y'}">
                    <input type="hidden" id="siteSeq" name="siteSeq" value="<c:out value="${paramVO.siteSeq}"/>" />
                    </c:when>
                    <c:otherwise>
                    <form:hidden path="siteSeq" name="siteSeq" />
                    </c:otherwise>
                    </c:choose>
                    
                    <!--기본정보 table// -->
                    
                    <table summary="<spring:message code="wzwg.sysMngr.word.stplatInfo" />" class="basic">
                        <colgroup>
                            <col width="15%"/>
                            <col width="*"/>
                        </colgroup>
                        <tbody>
                            <tr>
                                <th><spring:message code="wzwg.cmm.word.ty" /></th>
                                <td>
                                  	<c:set var="msg_title_txt01"> 
										<spring:message code="wzwg.cmm.word.cl" /> 
									</c:set>
									
                                    <%-- <form:select path="stplatTyCode" name="stplatTyCode" dir="required" title="${msg_title_txt01}" onchange="fnInit(this.value);">
                                        <form:options items="${stplatInfoTyCodeList}" itemLabel="codeNm" itemValue="code" />
                                    </form:select> --%>
                                    <form:select path="stplatTyCode" dir="required" title="${fn:escapeXml(msg_title_txt01)}" onchange="fnInit(this.value);">
								        <c:forEach items="${stplatInfoTyCodeList}" var="item">
								            <option value="<c:out value='${item.code}' />" 
								                <c:if test="${item.code eq resultVO.stplatTyCode}">selected="selected"</c:if>>
								                <c:out value="${item.codeNm}" />
								            </option>
								        </c:forEach>
								    </form:select>
                                    
                                    <span class="wz_tableguide mt10">
									    <strong><spring:message code="wzwg.cmm.word.stplat" /></strong> : <spring:message code="wzwg.cmm.msg.MSG388" /><br>
									    <strong><spring:message code="wzwg.cmm.word.Policy" /></strong> : <spring:message code="wzwg.cmm.msg.MSG389" />
									</span>
                                </td>
                            </tr>
                            <tr>
                                <th><spring:message code="wzwg.sysMngr.word.stplatAndPolicyNm01" /></th>
                                <td>
                                    <input type="text" class="w70" name="stplatNm" id="stplatNm" dir="required" value="<c:out value="${resultVO.stplatNm}"/>" title="<spring:message code="wzwg.cmm.word.stplatNm" />" placeholder="<spring:message code="wzwg.cmm.word.stplatNm" />" />
                                </td>
                            </tr>
                            <tr>
                                <th><spring:message code="wzwg.cmm.word.dc" /></th>
                                <td>
                                    <input type="text" class="w70" name="stplatDc" id="stplatDc" dir="required" value="<c:out value="${resultVO.stplatDc}"/>" title="<spring:message code="wzwg.sysMngr.word.stplatDc" />" placeholder="<spring:message code="wzwg.sysMngr.word.stplatDc" />" />
                                </td>
                            </tr>
                            <tr>
                            	<th><spring:message code="wzwg.cmm.word.essntl"/> <spring:message code="wzwg.cmm.word.at"/></th>
                            	<td> 
                            		<ul class="wzForm">
                            			<li><label><input type="radio" id="essntlY" name="essntlAt" dir="required" value="Y" checked="checked"/><span class="spanLabel"><spring:message code="wzwg.cmm.word.essntl"/></span></label></li>
                            			<li><label><input type="radio" id="essntlN" name="essntlAt" dir="required" value="N" <c:if test="${resultVO.essntlAt eq 'N' }">checked="checked"</c:if>/><span class="spanLabel"><spring:message code="wzwg.cmm.word.choise"/></span></label></li>
                            		</ul>
                            		<span class="wz_tableguide mt10 clboth"><spring:message code="wzwg.cmm.msg.MSG333" /></span>
                            	</td>
                            </tr>
                        </tbody>
                    </table>
                    <!--//기본정보 table -->
                </form:form>
                
                <div class="rt-box"> 
                    <a href="javascript:void(0);" onclick="fnModify();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.updt" /></a>
                    <a href="javascript:void(0);" onclick="fnList();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
                </div>
                
				<!-- 상세약관 start -->
                <!-- <h3 class="mt30 mb10"><spring:message code="wzwg.cmm.word.detail02" /> <spring:message code="wzwg.cmm.word.stplat" /> <spring:message code="wzwg.cmm.word.info" /></h3> -->
                <table class="basic mb0" style="border-bottom:none;">
                    <tbody><tr class="wideth-white"><th colspan="2" class="wzAdmSTit"><spring:message code="wzwg.sysMngr.word.detail02StplatInfo" /></th></tr></tbody>
                </table>
                    
                <form:form modelAttribute="resultVO" id="frmInfoSimp" name="frmInfoSimp" method="post">
                <%-- <form:hidden path="stplatSeq" name="stplatSeq" value="${resultVO.stplatSeq}" /> --%>
                <form:hidden path="stplatSeq" value="${fn:escapeXml(resultVO.stplatSeq)}" />
                <c:choose>
                <c:when test="${sessionScope.SYSMNGR_AT eq 'Y'}">
                <input type="hidden" id="siteSeq" name="siteSeq" value="<c:out value="${paramVO.siteSeq}"/>" />
                </c:when>
                <c:otherwise>
                <form:hidden path="siteSeq" name="siteSeq" />
                </c:otherwise>
                </c:choose>
                <div id="divInfoSimp">
                <form:hidden path="stplatsimpSeq" name="stplatsimpSeq" />
                <table summary="<spring:message code="wzwg.sysMngr.word.stplatInfo" />" class="basic">
                    <colgroup>
                        <col width="15%">
                        <col width="*">
                    </colgroup>
                    <tbody>
                        <tr>
                            <th><spring:message code="wzwg.cmm.word.opertnDe" />
                            	<span class="necessary">
										<span></span>
										<div><spring:message code="wzwg.cmm.word.essntl" /></div>
								</span>
                            </th>
                            <td>
                                <input type="text" id="opertnDe" name="opertnDe" dir="required" class="datePicker cal w10" readonly="readonly" title="<spring:message code="wzwg.cmm.word.opertnDe" />" value="" /> 
                            </td>
                        </tr>
                        <tr>
                            <th><spring:message code="wzwg.cmm.word.sj" />
                            	<span class="necessary">
										<span></span>
										<div><spring:message code="wzwg.cmm.word.essntl" /></div>
								</span>
                            </th>
                            <td>
                                <input type="text" class="w70" name="stplatSj" id="stplatSj" dir="required" title="<spring:message code="wzwg.cmm.word.sj" />" placeholder="<spring:message code="wzwg.cmm.word.sj" />" />
                            </td>
                        </tr>
                        <tr>
                            <th><spring:message code="wzwg.cmm.word.cn" /></th>
                            <td>
                                <textarea name="stplatCn" id="stplatCn" rows="30" class="w90" dir="required" title="<spring:message code="wzwg.cmm.word.cn" />" style="width:100%;">
                                </textarea>
                                
                                <script type="text/javascript">
                                    var oEditors = [];
                                    nhn.husky.EZCreator.createInIFrame({
                                        oAppRef: oEditors,
                                        elPlaceHolder: "stplatCn",
                                        sSkinURI: "<c:out value="${wzwg_contextPath}"/>/smartEditor2.8.2.1/smartEditor2Skin.do",
                                        fCreator: "createSEditor2",
                                       	htParams: {fOnBeforeUnload : function(){},aAdditionalFontList : [['NanumSquareR', 'NanumSquareR']]}
                                    });
                                    
                                    WzwgEditorTool.instance("stplatCn");
                                </script>
                            </td>
                        </tr>
                    </tbody>
                </table>
                </div>
                </form:form>
                
                <div class="rt-box">
                    <a href="javascript:void(0);" class="wzbtn btn-del fl" onclick="fnStplatsimpClear()"><spring:message code="wzwg.cmm.word.initl" /></a>
                    <a href="javascript:void(0);" class="wzbtn btn-save" onclick="fnRegistStplatsimp()"><spring:message code="wzwg.cmm.word.stre" /></a>
                </div>
                <!-- 상세약관 End -->             
                
                <!-- <h3 class="mt30 mb10"><spring:message code="wzwg.cmm.word.detail02" /> <spring:message code="wzwg.cmm.word.stplat" /> <spring:message code="wzwg.cmm.word.hist" /></h3> -->
                <table class="basic mb0" style="border:none;">
                    <tbody><tr class="wideth-white"><th colspan="2" class="wzAdmSTit"><spring:message code="wzwg.sysMngr.word.detail02StplatHist" /></th></tr></tbody>
                </table>
                    
                <form id="frmList" name="frmList" method="post">
                <input type="hidden" id="stplatSeq" name="stplatSeq" value="<c:out value="${resultVO.stplatSeq}"/>" />
                <div id="divList"></div>
                </form>
                
                <div class="admpg-subp w100 fl txt-l mb25">
						<span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.tip.MSG064" />
				</div>
                
                <div class="lt-box">
                    <a href="javascript:void(0);" class="wzbtn btn-del" onclick="fnDetailDelete();"><spring:message code="wzwg.sysMngr.word.choiseDelete" /></a>
                </div>                