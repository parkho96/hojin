<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script language="javascript" type="text/javascript" src="/jquery/js/jquery.form.min.js"></script>

<script type="text/javascript">
<c:if test="${!empty resultVO.linkGrpSeq}">
$( document ).ready(function() {
    fnDetailList();
});
</c:if>

function fnCheckAll() {
    if ($('.checkall').is(':checked')) {
        $('input[name=linkSeqArr]').prop('checked', true);
    } else {
        $('input[name=linkSeqArr]').prop('checked', false);
    }
}

var doubleSubmitFlag = false;
 
function doubleSubmitCheck(){
    if(doubleSubmitFlag){
        return doubleSubmitFlag;
    }else{
        doubleSubmitFlag = true;
        return false;
    }
}

function fnList() {
    var frm = document.frmReg;

    frm.target = "_self";
    frm.action="<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/menu/linkGrp/selectLinkGrpList.do";
    frm.submit();
}

function fnModify() {

	if(!Validator.validate(document.frmReg)){
		return;
	}
	
    var frm = document.frmReg;
    
    frm.action="<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/menu/linkGrp/modifyLinkGrpInfo.do";
    frm.submit();
}

function fnRegist() {

    if(!Validator.validate(document.frmReg)){
        return;
    }
    
    var frm = document.frmReg;

    frm.action="<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/menu/linkGrp/registLinkGrpInfo.do";
    frm.submit();
}

function fnDelete() {
    if (confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')) {
        var frm = document.frmReg;

        frm.action="<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/menu/linkGrp/deleteLinkGrpInfo.do";
        frm.submit();   
    }
}

function fnDetailList() {
 $.ajax({
     type:'POST'
   , url:'<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/menu/linkGrp/selectLinkGrpMapListAjax.do'
   , data: $("#frmReg").serialize()
   , success:function (data) {
       $('#divList').html(data);
       
 	  $('#divList .linkSortBtns:first button:first').css('color', '#ccc');
	  $('#divList .linkSortBtns:first button:first').attr('disabled', 'disabled');
	  $('#divList .linkSortBtns:last button:last').css('color', '#ccc');
	  $('#divList .linkSortBtns:last button:last').attr('disabled', '#disabled');
	  
   }
   , error:function (data) {
       alert('<spring:message code="fail.common.msg" text="error" />');
   }
   , dataType: 'html'
 });
}

function fnSiteLinkGrpOrdr(ordrGubun,linkSeq,ordr) {
	
	document.frmReg.ordrGubun.value=ordrGubun;
	document.frmReg.linkSeq.value=linkSeq;
	document.frmReg.ordr.value=ordr;
	
	if(doubleSubmitCheck()) return;
	
	$.ajax({
		type:'POST'
		, url:'<c:out value="${wzwg_contextPath}"/>/mngr/menu/linkGrp/modifySiteLinkGrpOrdrAjax.do'
		, data:$("#frmReg").serialize()
		, async : false
		, success:function (data){
			if(data.head.result == 'success'){
					fnDetailList();
			}else{
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
			}
		}
		, error:function (request, status, error) {
              alert('<spring:message code="fail.common.msg" text="error" />');
          }
	});
	
}

function fnDetailDelete() {
    if ($('input:checkbox[id="linkSeqArr"]').is(':checked')) {
        if (confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')) {
            $.ajax({
                type:'POST'
              , url:'<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/menu/linkGrp/deleteLinkGrpAjax.do'
              , data:$("#frmReg").serialize()
              , success:function (data) {
                  $(data).find('value').each(function(){
                      if($(this).text() == "success"){
                          alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
                          fnDetailList();
                      }else{
                          alert('<spring:message code="wzwg.cmm.msg.MSG076" />');
                      }
                  })
              }
              , error:function (data) {
                  alert('<spring:message code="fail.common.msg" text="error" />');
              }
              , dataType: 'xml'
            });
        }
    } else {
        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.data" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument></spring:message>');
    }
}

function fnDetailMngr() {
  $('body').css({overflow:'hidden'});
  $.ajax({
      type:'POST'
    , url:'<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/menu/linkGrp/selectLinkInfoDetailMngrAjax.do'
    , async : true
    , data:$("#frmReg").serialize()
    , success:function (data) {
        //$("#divLayerPopup").html(data);
        //$("#divLayerPopup").show();
        var title = '<spring:message code="wzwg.site.menu.msg.MSG001" />';
        wzAjaxModal('popup_s', title,data);
    }
    , error:function (request, status, error) {
       alert('<spring:message code="fail.common.msg" text="error" />');
    }
    , dataType: 'html'
  });
}

function fnLayerPopupClose() {
    //$("#divLayerPopup").hide();
    //$("#divLayerPopup").empty();
    //$('body').css({overflow:'auto'});
    $('.wzpopup .close').click();
}

</script>
                        
                <div id="divLayerPopup" class="pop-box"></div>

<%--                 <h3><spring:message code="wzwg.site.menu.msg.MSG002" /></h3> --%>

                <form:form modelAttribute="resultVO" id="frmReg" name="frmReg" method="post">
					<form:hidden path="linkGrpSeq" name="linkGrpSeq" value="${fn:escapeXml(resultVO.linkGrpSeq)}" />
                    <input type="hidden" name="linkSeq">
                    <input type="hidden" name="ordr">
                    <input type="hidden" name="ordrGubun">
                    <input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex}"/>"/>
                    
                    <c:choose>
	                    <c:when test="${sessionScope.SYSMNGR_AT eq 'Y'}">
	                    	<input type="hidden" id="siteSeq" name="siteSeq" value="<c:out value="${paramVO.siteSeq}"/>" />
	                    </c:when>
	                    <c:otherwise>
	                    	<form:hidden path="siteSeq" name="siteSeq" />
	                    </c:otherwise>
                    </c:choose>
                    
                    <!--기본정보 table// -->
                    
                    <table summary="<spring:message code="wzwg.site.menu.msg.MSG002" />" class="basic">
                        <colgroup>
                            <col width="13%"/>
                            <col width="*"/>
                        </colgroup>
                        <thead>
							<tr>
								<th colspan="2" class="wzAdmSTit">
									<spring:message code="wzwg.site.menu.msg.MSG003" />
								</th>
							</tr>
						</thead>
                        <tbody>
                            <tr>
                                <th><spring:message code="wzwg.site.menu.msg.MSG004" /></th>
                                <td>
                                    <input type="text" class="w70" name="groupNm" id="groupNm" dir="required" value="<c:out value="${resultVO.groupNm}"/>" title="<spring:message code="wzwg.site.menu.msg.MSG004" />" placeholder="<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.site.menu.msg.MSG004" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>" />
                                </td>
                            </tr>
                            <tr>
                                <th><spring:message code="wzwg.site.menu.msg.MSG005" /></th>
                                <td>
                                    <input type="text" class="w70" name="groupDc" id="groupDc" dir="required" value="<c:out value="${resultVO.groupDc}"/>" title="<spring:message code="wzwg.site.menu.msg.MSG005" />" placeholder="<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.site.menu.msg.MSG005" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>" />
                                </td>
                            </tr>
<!--                             <tr> -->
<%--                                 <th><spring:message code="wzwg.site.menu.msg.MSG006" /></th> --%>
<!--                                 <td> -->
<%--                                     <select id="linkTyCode" name="linkTyCode" dir="required" title="<spring:message code="wzwg.cmm.word.ty" />"> --%>
<%--                                         <option value="">::<spring:message code="wzwg.cmm.word.choise" />::</option> --%>
<%--                                         <c:forEach items="${linkTyCodeList}" var="result"> --%>
<%--                                         <option value="<c:out value="${result.code}"/>" <c:if test="${result.code eq resultVO.linkTyCode}">selected</c:if>><c:out value="${result.codeNm}" /></option> --%>
<%--                                         </c:forEach> --%>
<!--                                     </select> -->
<!--                                 </td> -->
<!--                             </tr> -->
                        </tbody>
                    </table>
                    <!--//기본정보 table -->
                               
                <div class="rt-box mb20">
                <c:choose>
                <c:when test="${!empty resultVO.linkGrpSeq}">
                    <a href="javascript:void(0);" onclick="fnDelete();" class="wzbtn btn-del bg fl"><spring:message code="wzwg.cmm.word.delete" /></a>
                    <a href="javascript:void(0);" onclick="fnModify();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.updt" /></a>
                </c:when>
                <c:otherwise>
                    <a href="javascript:void(0);" onclick="fnRegist();" class="wzbtn btn-save bg"><spring:message code="wzwg.cmm.word.stre" /></a>
                </c:otherwise>
                </c:choose>
                    <a href="javascript:void(0);" onclick="fnList();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
                </div>
                    
                
                <!--//게시판 설정 table -->
                
                <c:if test="${!empty resultVO.linkGrpSeq}">
                <div id="divList"></div>
                            
                <div class="rt-box">
                    <a href="javascript:void(0);" class="wzbtn btn-del bg fl" onclick="fnDetailDelete();"><spring:message code="wzwg.cmm.word.excludeLink" /></a>
                    <a href="javascript:void(0);" class="wzbtn btn-save bg" onclick="fnDetailMngr(); return false;"><spring:message code="wzwg.site.menu.msg.MSG001" /></a>
                </div>
                </c:if>
                
               </form:form>                   