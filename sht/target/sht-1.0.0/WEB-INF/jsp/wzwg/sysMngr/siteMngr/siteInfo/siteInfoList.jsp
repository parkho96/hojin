<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script type="text/javascript" src="/js/wzwg/cmm/common.js" ></script>
<script language="javascript" type="text/javascript" src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>
<script language="javascript" type="text/javascript" src="/jquery/js/jquery.form.min.js"></script>
<c:set var="msg_txt01">
	<spring:message code="wzwg.cmm.cmmMsg.CMG011">
		<spring:argument><spring:message code="wzwg.sysMngr.word.siteNm01" /></spring:argument>
		<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
	</spring:message>
</c:set>  
<c:set var="msg_txt02">
	<spring:message code="wzwg.cmm.cmmMsg.CMG011">
		<spring:argument><spring:message code="wzwg.sysMngr.word.reprsntSiteUrl" /></spring:argument>
		<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
	</spring:message>
</c:set>  
<script type="text/javascript">
function fnRegistFrom() {
	document.listForm.action="<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectSiteInfoForm.do";
	document.listForm.submit();
}

function fnDetail(siteSeq) {
    document.listForm.siteSeq.value = siteSeq;
    
    document.listForm.action="<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectSiteInfoForm.do";
    document.listForm.submit();
}

function fnPage(pageIndex) {
	
	if(isNaN(pageIndex)){
		console.log('잘못된 페이지호출');
		return;
	}
	
	document.listForm.pageIndex.value = pageIndex;
	document.listForm.action="<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectSiteInfoList.do";
	document.listForm.submit();
}

/** 사용자관리 - 가입정보 설정 페이지 이동 */
function fnSbscrbForm(siteSeq){
	document.listForm.siteSeq.value = siteSeq;
    document.listForm.action = "<c:out value="${wzwg_contextPath}${prefix}" />/usrMngr/siteSbscrb/selectSbscrbInfoForm.do";
    document.listForm.submit();
}

/* 관리자 등록 페이지로 이동 */
function fnMngrSbscrbForm(siteSeq){
	document.listForm.siteSeq.value = siteSeq;
    document.listForm.action = "<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectMngrInfoNewSbscrbForm.do";
    document.listForm.submit();
}

function fnMoveSite(url,gubun) {
	if(gubun == 'mngr'){
		document.frmSrh.action="<c:out value="${wzwg_contextPath}" />/mngr/cmm/actionSSOMngrLogin.do";
	}
	
	document.frmSrh.target="_blank";
	document.frmSrh.submit();
}

function fnChangeMlsfcGroup(upperGrpSeq) {
    if(upperGrpSeq !=''){
    $.ajax({
        type : 'POST'
      , dataType: 'xml'
      , contentType : 'application/x-www-form-urlencoded; charset=UTF-8'
      , url:'<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteGroup/selectSiteGroupMlsfcAjax.do'
      , cache : false
      , async : false
      , data:{'odr':2, 'upperGrpSeq':upperGrpSeq}
      , success : function(xml, status, request) {
          
          $("#siteMlsfcGroup").find("option").remove().end().append("option value=\"\">::<spring:message code="wzwg.cmm.word.choise" />::</option>");
          $("#siteMlsfcGroup").append("<option value=\"\">::<spring:message code="wzwg.cmm.word.choise" />::</option>");
          $(xml).find("item").each(function(){
              var sitegrpSeq = $(this).find('name').text();
              var groupNm = $(this).find('value').text();
              if(sitegrpSeq == '<c:out value="${paramVO.siteMlsfcGroup}" />'){
                  $("#siteMlsfcGroup").append("<option value=\"" +sitegrpSeq+ "\" selected >" + groupNm + "</option>");                      
              }else{
                  $("#siteMlsfcGroup").append("<option value=\"" +sitegrpSeq+ "\">" + groupNm + "</option>");
              }
          });
          
      }
      , error:function (data) {
          alert('<spring:message code="fail.common.msg" text="error" />');
      }
  });
    }else{
    	$("#siteMlsfcGroup").find("option").remove().end().append("option value=\"\">::<spring:message code="wzwg.cmm.word.choise" />::</option>");
        $("#siteMlsfcGroup").append("<option value=\"\">::<spring:message code="wzwg.cmm.word.choise" />::</option>");
    }
}

$(document).ready(function(){
var slGrp = '<c:out value="${paramVO.siteLclasGroup}" />';
if(slGrp != '')
fnChangeMlsfcGroup(slGrp);
});


function fnMngrSiteConn(cnt) {
    var siteUrl = $.trim($('input[name=siteUrl]').eq(cnt-1).attr('value'));
    
    if (siteUrl.length == 0) {
        alert('<spring:message code="wzwg.cmm.msg.MSG272" />');
    } else {
        window.open("http://"+siteUrl+"/cmm/mber/login/mngrLoginForm.do", "_blank");
    }
    
}

function checkFileType(filePath) {
    var fileFormat = filePath.split('.');
    if (fileFormat.indexOf('xls') > -1) {
        return true;
    } else {
        return false;
    }

}

function fnExcelUpload() {
    if (confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.upload" /></spring:argument></spring:message>')) {

        var frm = $("#frmExcel");
        var formData = frm.serialize();
        
        frm.ajaxSubmit({
            type:'POST'
            , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/siteInfo/registSiteInfoExcelAjax.do'
            , async: false
            , data: formData 
            , mimeType: 'multipart/form-data'
            , success:function(result){
                $('.rt-box').append(result);
            }
            , error:function (request, status, error) {
                  alert('<spring:message code="fail.common.msg" text="error" />');
              }
            , dataType: 'html'
        });
    }
}
function changeSearchPlace(value){
	if(value == 2){
		$("#msg_txt").attr('placeholder','<c:out value="${msg_txt02}" />');
	}else{
		$("#msg_txt").attr('placeholder','<c:out value="${msg_txt01}" />');
	}
}


</script>
                    <form name="frmSrh" id="frmSrh" method="post">
                        <input type="hidden" name="siteSeq" />
                    </form>
                    
                    <div class="wz_notice brbox bg-white br-blue-strong mb50" style="overflow: visible;">	
						<ul class="wd100">
							<li class="admpg-subp wd100 mb0">· <spring:message code="wzwg.cmm.msg.tip.MSG115" /></li>
						</ul>
					</div>
					
					<!--//게시판명 table -->
					<form name="listForm" id="listForm" method="post">
						<input type="hidden" name="siteSeq" value="" />
						<input type="hidden" name="pageIndex" value="<c:out value="${paramVO.pageIndex}" />" />
						
						<div class="wzAdmSrchbox txt-l">
							<label class="fs16 vert-m" for="siteLclasGroup"> <spring:message code="wzwg.sysMngr.word.firstGroup" /></label>
							<select id="siteLclasGroup" name="siteLclasGroup" onchange="fnChangeMlsfcGroup(this.value);">
								<option value="">::<spring:message code="wzwg.cmm.word.choise" />::</option>
								<c:forEach var="result" items="${siteLclasGroupList}">
									<option value="<c:out value="${result.sitegrpSeq}" />" <c:if test="${result.sitegrpSeq eq paramVO.siteLclasGroup}">selected="selected"</c:if>><c:out value="${result.groupNm}" /></option>
								</c:forEach>
							</select>
							
							<label class="fs16 vert-m" for="siteLclasGroup"> <spring:message code="wzwg.sysMngr.word.secondGroup" /></label>               
							<select id="siteMlsfcGroup" name="siteMlsfcGroup">
								<option value="">::<spring:message code="wzwg.cmm.word.choise" />::</option>
							</select>    
							
							
							<select id="searchCondition" name="searchCondition" onchange="changeSearchPlace(this.value);">
								<option value="1" <c:if test="${paramVO.searchCondition eq '1'}">selected="selected"</c:if>><spring:message code="wzwg.sysMngr.word.siteNm01" /></option>
								<option value="2" <c:if test="${paramVO.searchCondition eq '2'}">selected="selected"</c:if>><spring:message code="wzwg.sysMngr.word.reprsntSiteUrl" /></option>
							</select>  
							
							
							<input type="text" class="txt w20" id="msg_txt" name="searchKeyword" value="<c:out value="${paramVO.searchKeyword }" />" placeholder="<c:out value="${msg_txt01}" />"/>
							<a href="javascript:void(0);" class="wzbtn-table btn-srch" onclick="fnPage('1');"><spring:message code="wzwg.cmm.word.search01" /></a>
							<input type="checkbox" id="ablEnncAt" name="ablEnncAt" <c:if test="${paramVO.ablEnncAt eq 'Y'}">checked</c:if> value="Y" /> <spring:message code="wzwg.sysMngr.word.siteClsIncls"/>
						</div>
					</form>
					
					<!--//게시판 설정 table -->
					<table class="basic-table">
						<thead>
						  <tr>
							<th><spring:message code="wzwg.cmm.word.sn" /></th>
							<th><spring:message code="wzwg.sysMngr.word.siteNm01" />(URL)</th>
							<th><spring:message code="wzwg.cmm.word.lclas" /></th>
							<th><spring:message code="wzwg.cmm.word.mlsfc" /></th>
							<th><spring:message code="wzwg.cmm.word.telno" /> (FAX)</th>
							<th><spring:message code="wzwg.sysMngr.word.creatDe01" /></th>
							<th><spring:message code="wzwg.sysMngr.word.srvcAt" /></th>
							<th><spring:message code="wzwg.sysMngr.word.clsAt" /></th>
							<th><spring:message code="wzwg.cmm.word.manage" /></th>
						  </tr>
						</thead>
						<tbody>
						<c:if test="${empty resultList}">
						<tr>
							<td colspan="9"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
						</tr>
						</c:if>
						<c:forEach items="${resultList}" var="list" varStatus="status">
						<tr>
							<td><c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.recordCountPerPage + status.count) + 1}" /></td>
							<td class="txt-l">
                                <input type="hidden" id="siteUrl" name="siteUrl" value="<c:out value="${list.siteUrl}" />" />
                                <p><c:out value="${list.siteFullNm}" /></p>
                                <span class="siteNcr">(<a href="http://<c:out value="${list.siteUrl}"/>" target="_blank"><c:out value="${list.siteUrl}" /></a>)</span>
                            </td>
                            <td><c:out value="${list.siteLclasGroupNm}" /></td>
                            <td><c:out value="${list.siteMlsfcGroupNm}" /></td>
							<td>
                                <c:out value="${list.telno1}" />-<c:out value="${list.telno2}" />-<c:out value="${list.telno3}" /><br/>
                                (<c:out value="${list.faxnum1}" />-<c:out value="${list.faxnum2}" />-<c:out value="${list.faxnum3}" />)
                            </td>
							<td><c:out value="${list.creatDe}" /></td>
							<td>
								<c:if test="${list.srvcAt eq 'Y'}"><span class="circle_badge bg-blue-strong br3 vert-m"><spring:message code="wzwg.sysMngr.word.operSrvc01" /></span></c:if>
								<c:if test="${list.srvcAt eq 'N'}"><span class="circle_badge bg-grey-strong br3 vert-m"><spring:message code="wzwg.sysMngr.word.operStpge" /></span></c:if>
							</td>
							<td>
								<c:if test="${list.ablEnncAt eq 'Y'}"><span class="circle_badge bg-grey-strong br3 vert-m"><spring:message code="wzwg.sysMngr.word.siteCls" /></span></c:if>
								<c:if test="${list.ablEnncAt eq 'N'}"><span class="circle_badge bg-blue-strong br3 vert-m"><spring:message code="wzwg.sysMngr.word.siteOpen02" /></span></c:if>
							</td>
							<td>
								<!-- 
								<a href="javascript:void(0);" onclick="fnMoveSite('','hmpg');" class="btn btn_default btn_xs"><spring:message code="wzwg.cmm.word.hmpg" /></a>
								<a href="javascript:void(0);" onclick="fnMoveSite('','mngr');"  class="btn btn_default btn_xs"><spring:message code="wzwg.cmm.word.mngr" /></a>
								 -->
                                <a href="javascript:void(0);" class="iconOnlyBtn btn-basic btn-setting" onclick="fnDetail('<c:out value="${list.siteSeq}" />'); return false;"><spring:message code="wzwg.sysMngr.word.detailInfo" /></a>
<%--                                 <a href="javascript:void(0);" class="btn-c" onclick="fnSbscrbForm('<c:out value="${list.siteSeq}" />'); return false;"><spring:message code="wzwg.cmm.word.sbscrb" /> <spring:message code="wzwg.cmm.word.info" /></a> --%>
                                <a href="javascript:void(0);" class="iconOnlyBtnSameSize btn-basic" onclick="fnMngrSbscrbForm('<c:out value="${list.siteSeq}" />'); return false;"><spring:message code="wzwg.sysMngr.word.mngrRegist" /></a>
                                <a href="javascript:void(0);" class="iconOnlyBtnSameSize btn-basic" onclick="fnMngrSiteConn('<c:out value="${status.count}" />'); return false;"><spring:message code="wzwg.sysMngr.word.mngrOpen01" /></a>
							</td>
						</tr>
						</c:forEach>
						</tbody>
					</table>
				  <c:if test="${!empty resultList}">
				  	<div class="ctr-box" id="pageInfo">
						<ul class="num mobile-none">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnPage" />
						</ul>
						
						<ul class="num pc-none">
							<ui:pagination paginationInfo="${mobilePaginationInfo}" type="image" jsFunction="fnPage" />
						</ul>
					</div>
				  </c:if>
					  
				<!--// button --> 
				<div class="rt-box">
<!--                      <form id="frmExcel" name="frmExcel" method="post" enctype="multipart/form-data">   -->
<!--                           <input type="file" id="excelFile" name="excelFile" />   -->
<!--                       </form>   -->
<!--                       <a href="/sample/excelUpload/siteInfo_upload.xlsx">엑셀샘플파일</a>   -->
<!--                       <a href="javascript:void(0);" onclick="fnExcelUpload(); return false;" class="btn-a">사이트 업로드</a>   -->
					<a href="javascript:void(0);" onclick="fnRegistFrom(); return false;" class="wzbtn btn-basic"><spring:message code="wzwg.sysMngr.word.siteEstbl" /></a>
				</div>
    
                
