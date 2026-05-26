<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script type="text/javascript">
function fnMngrRegist() {
    var layUrl = "";
    
    <c:choose>
    <c:when test="${empty resultVO.linkSeq}">
    layUrl="<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/menu/linkGrp/registLinkInfoAjax.do";
    </c:when>
    <c:otherwise>
    layUrl="<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/menu/linkGrp/modifyLinkInfoAjax.do";
    </c:otherwise>
    </c:choose>
    
    if($('#linkNm').val() == ''){
    	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument><spring:message code="wzwg.site.menu.msg.MSG010" /></spring:argument></spring:message>');
		$('#linkNm').focus();
		return;
    }
    if($('#linkUrl').val() == ''){
    	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument><spring:message code="wzwg.cmm.word.url" /></spring:argument></spring:message>');
		$('#linkUrl').focus();
		return;
    }
    
    $.ajax({
        type:'POST'
      , url:layUrl
      , data:$("#frmLayReg").serialize()
      , success:function (data) {
          $(data).find('value').each(function(){
              if($(this).text() == "success"){
                  alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
                  fnDetailList();
                  fnMngrSearch(1);
              }else{
                  alert('<spring:message code="wzwg.cmm.msg.MSG076" />');
              }
          })
      }
      , error:function (data) {
          alert('<spring:message code="fail.common.msg" text="error" />');
      }
      , dataType: 'json'
    });
}

function fnMngrDelete() {

    if (confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')) {
        
        $.ajax({
            type:'POST'
          , url:'<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/menu/linkGrp/deleteLinkInfoAjax.do'
          , data:$("#frmLayReg").serialize()
          , success:function (data) {
              $(data).find('value').each(function(){
                  if($(this).text() == "success"){
                      alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
                      fnDetailList();
                      fnMngrSearch(1);
                  }else{
                      alert('<spring:message code="wzwg.cmm.msg.MSG076" />');
                  }
              })
          }
          , error:function (data) {
              alert('<spring:message code="fail.common.msg" text="error" />');
          }
          , dataType: 'json'
        });
    }
}
</script>
                                    
                <form:form modelAttribute="resultVO" id="frmLayReg" name="frmLayReg" method="post">
                    <form:hidden path="linkSeq" id="linkSeq" />
                    <c:choose>
                    <c:when test="${empty resultVO.siteSeq}">
                    <input type="hidden" id="siteSeq" name="siteSeq" value="<c:out value="${paramVO.siteSeq}"/>" />
                    </c:when>
                    <c:otherwise>
                    <form:hidden path="siteSeq" name="siteSeq" />
                    </c:otherwise>
                    </c:choose>
                    
                    <!--기본정보 table// -->
                    
                    <table summary="<spring:message code="wzwg.site.menu.msg.MSG011" />" class="basic">
                        <colgroup>
                            <col width="30%"/>
                            <col width="*"/>
                        </colgroup>
                        <tbody>
                           <tr>
                                <th><spring:message code="wzwg.site.menu.msg.MSG010" /></th>
                                <td class="txt-l">
                                    <input name="linkNm" id="linkNm" value="<c:out value="${resultVO.linkNm}"/>" title="<spring:message code="wzwg.site.menu.msg.MSG010" />" class="w80" placeholder="<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.site.menu.msg.MSG010" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>" />
                                </td>
                           </tr>
                           <tr>
                                <th><spring:message code="wzwg.site.menu.msg.MSG012" /></th>
                                <td class="txt-l">
                                    <textarea name="linkDc" id="linkDc" title="<spring:message code="wzwg.site.menu.msg.MSG012" />" rows="5" class="w80" placeholder="<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.site.menu.msg.MSG012" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>"><c:out value="${resultVO.linkDc}" /></textarea>
                                </td>
                           </tr>
                           <tr>
                                <th><spring:message code="wzwg.cmm.word.url" /></th>
                                <td class="txt-l">
                                    <input type="text" name="linkUrl" id="linkUrl" value="<c:out value="${resultVO.linkUrl}"/>" title="<spring:message code="wzwg.cmm.word.url" />" class="w80" placeholder="<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.url" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>"/>
                                </td>
                           </tr>
                        </tbody>
                    </table>
                    <!--//기본정보 table -->
                </form:form>
                
	                <div class="ctr-box">
	                <c:choose>
	                <c:when test="${!empty resultVO.linkSeq}">
	                    <a href="javascript:void(0);" onclick="fnMngrRegist();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.updt" /></a>
	                    <a href="javascript:void(0);" onclick="fnMngrDelete();" class="wzbtn btn-del"><spring:message code="wzwg.cmm.word.delete" /></a>
	                </c:when>
	                <c:otherwise>
	                    <a href="javascript:void(0);" onclick="fnMngrRegist();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
	                </c:otherwise>
	                </c:choose>
	                    <a href="javascript:void(0);" onclick="fnMngrSearch(1);" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
	                </div>
                