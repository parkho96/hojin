<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
$( document ).ready(function() {
    fnList();
});

// 목록 조회
function fnList() {
    $.ajax({
        type:'POST'
      , url:'<c:out value="${wzwg_contextPath}"/>/mngr/cntnts/cntntsCharger/selectCntntsChargerListAjax.do'
      , data: $("#frmSrh").serialize()
      , success:function (data) {
          $('#divList').html(data);
      }
      , error:function (data) {
          alert('<spring:message code="fail.common.msg" text="error" />');
      }
      , dataType: 'html'
    });
}

// 등록/삭제 callBack
function fnSearchClear() {
    $('#ulUsrList').find('li').remove();
    $("#searchUsr").hide();
    
    fnList();
}

// 담당자 조회
function fnSearch() {
    var frm = document.frmSrh;
    
    var keyword = frm.searchKeyword.value;
    
    if (keyword.trim().length != 0) {
        $.ajax({
            type : 'POST'
            , url : '<c:out value="${wzwg_contextPath}"/>/module/usr/selectUsrListJson.do'
            , dataType : 'xml'
            , data : $("#frmSrh").serialize()
            , success : function (result) {
                $('#ulUsrList').find('li').remove();
                if (result['usrList'].length > 0) {
                    var tdUsrId = $('.tdUsrId').text();
                    
                    // 같은 아이디 제외
                    for (var i=0; i<result['usrList'].length; i++) {
                        if (tdUsrId.indexOf(result['usrList'][i].userId) < 0) {
                            $('#ulUsrList').append('<li class="pb5 pt5"><label><input type="checkbox" id="usrSeqArr" name="usrSeqArr" value="'+result['usrList'][i].usrSeq+'" class="form-control" /> <span class="spanLabel">'+result['usrList'][i].userNm+'('+result['usrList'][i].userId+')</span></label></li>');
                        }
                    }
                } else {
                    $('#ulUsrList').append('<li><spring:message code="wzwg.cmm.msg.MSG097" /></li>');
                }
                $("#searchUsr").show();
            }
            , error : function (request, status, error) {
                alert('<spring:message code="fail.common.msg" text="error" />');
            }
        });
    } else {
        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
    }
}    

// 담당자 등록
function fnRegist() {
    if ($('input:checkbox[id="usrSeqArr"]').is(':checked')) {
        $.ajax({
            type:'POST'
          , url:'<c:out value="${wzwg_contextPath}"/>/mngr/cntnts/cntntsCharger/registCntntsCharger.do'
          , data:$("#frmSrh").serialize()
          , success:function (data) {
              alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>');
              
              fnSearchClear();
          }
          , error:function (data) {
              alert('<spring:message code="fail.common.msg" text="error" />');
          }
          , dataType: 'html'
        });
    } else {
        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.data" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument></spring:message>');
    }
}

// 담당자 삭제
function fnDelete(cntntschrgSeq) {
    var frm = document.frmInfo;
    
    frm.cntntschrgSeq.value = cntntschrgSeq;
    
    if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" text="delete" /></spring:argument></spring:message>')){
        $.ajax({
            type:'POST'
          , url:'<c:out value="${wzwg_contextPath}"/>/mngr/cntnts/cntntsCharger/deleteCntntsCharger.do'
          , data:$("#frmInfo").serialize()
          , success:function (data) {
              alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" text="delete" /></spring:argument></spring:message>');

              fnSearchClear();
          }
          , error:function (data) {
              alert('<spring:message code="fail.common.msg" text="error" />');
          }
          , dataType: 'html'
        });
    }
}
</script>
			<div class="wz_notice brbox bg-white br-blue-strong fl mt10" style="overflow:visible;">
		        <ul class="wd100 pl0">
		                <li class="admpg-subp wd100" style="list-style:none;">· <spring:message code="wzwg.cmm.msg.tip.MSG0541" /></li>
		        </ul>
			</div>
			
	<form:form modelAttribute="paramVO" id="frmInfo" name="frmInfo" method="post">
		<form:hidden path="sitecntntsSeq"/>
		<input type="hidden" id="cntntschrgSeq" name="cntntschrgSeq" />
		
			<div id="divList"></div>
	</form:form>
         
	<form:form modelAttribute="paramVO" id="frmSrh" name="frmSrh" method="post">
		<form:hidden path="sitecntntsSeq"/>
		<h3 class="wzAdmSTit wd100 fl mt50">
			<spring:message code="wzwg.cmm.msg.tip.MSG0542" />
		</h3>
		<div class="wd100 pl20 pr20 box-border">
			<div class="admpg-subp txt-l mb15 i-block">
				<span class="circle_no bg-green-strong">!</span><spring:message code="wzwg.cmm.msg.tip.MSG0543" />
			</div>
			<div class="ctr-box mt0" id="nttSearch">
				<c:set var="wMsg"><spring:message code="wzwg.cmm.word.searchse"/></c:set>
				<form:select path="searchCondition" name="stplatTyCode" title="${fn:escapeXml(wMsg)}">  
					<form:option value="N"><label for="option1"><spring:message code="wzwg.cmm.word.nm02" /></label></form:option>
					<form:option value="I"><label for="option2"><spring:message code="wzwg.cmm.word.id02" /></label></form:option>
				</form:select>
				
				<c:set var="srchwrd">
					<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
				</c:set>
				<form:input path="searchKeyword" id="searchKeyword" placeholder="${fn:escapeXml(srchwrd)}" cssClass="txt" onkeydown="if(event.keyCode == 13){fnSearch(); return false;}" />
				<a href="javascript:void(0);" class="wzbtn-table btn-srch" onclick="fnSearch();"><spring:message code="wzwg.cmm.word.search01" /></a>
				
				<div id="searchUsr" style="background-color:ffffff; display:none;">
					<ul id="ulUsrList" class="wzForm txt-l p20 box-border bg-lightgrey mt20 mb20" style="padding-left:20px !important;"></ul>
		                 
					<div class="wd100">
						<a href="javascript:void(0);" onclick="javascript:fnRegist();"><span class="wzbtn btn-save fr"><spring:message code="wzwg.site.cntnts.msg.MSG043" /></span></a>
					</div>
				</div>
	
			</div>
		</div>
	
	</form:form>