<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

	<link rel="stylesheet" href="/css/wzwg/cmm/layout.css" type="text/css" />

	<link rel="stylesheet" href="/css/wzwg/cmm/font.css" type="text/css" />

	
    <link rel="stylesheet" href="/smartEditorCustom/css/editorTool.css" type="text/css" />
	<link rel="stylesheet" href="/smartEditorCustom/css/subcon_common.css" type="text/css" />
	<link rel="stylesheet" href="/smartEditorCustom/css/subcon_tamplate.css" type="text/css" />
	<link rel="stylesheet" href="/smartEditorCustom/css/font-awesome.css" type="text/css" />
	<link rel="stylesheet" href="/smartEditorCustom/css/font-awesome.min.css" type="text/css" />


<script type="text/javascript">
<c:choose>
<c:when test="${ stplatTyCode eq 'SC00000453'}">
try{document.title = '<spring:message code="wzwg.module.word.stplathist" />';}catch(e){console.log(e.message);}
</c:when>
<c:otherwise>
try{document.title = '<spring:message code="wzwg.module.word.policyhist" />';}catch(e){console.log(e.message);}
</c:otherwise>
</c:choose>

$(document).ready(function(){
	<c:if test="${!empty resultList}">
	fnInit('<c:out value="${paramStplatSeq}" />','<c:out value="${paramStplatNum}" />');
	</c:if>
});

function fnInit(paramSeq,paramNum){
	
	document.frmSrh.stplatSeq.value = paramSeq;
	
	$.ajax({
        type:'POST'
      , url:'<c:out value="${wzwg_contextPath}" />/module/stplatLog/selectStplatLogListAjax.do'
      , cache : false
      , async : false
      , data:$("#frmSrh").serialize()
      , success:function (data) {
    	  $('#stplatSimpDiv').html(data);
    	  $('.clauseAllbox').children('li').removeClass();
    	  $('#liNum'+paramNum).addClass("active");
      }
      , error:function (data) {
          alert('<spring:message code="fail.common.msg" text="error" />');
      }
      , dataType: 'html'
 	});

}

function fnTdStplatCnCtrl(count, el) {
    if ($('.stplatCn'+count).css('display') == 'none') {
        //$('.tdLogCn').hide();
        $('.stplatCn'+count).show();
        $(el).attr('title', $(el).html()+' <spring:message code="wzwg.module.word.cnclose" />');
    } else {
        $('.tdLogCn').hide();
        $(el).attr('title', $(el).html()+' <spring:message code="wzwg.module.word.cnopen" />')
    }
}
</script>

    <form name="frmSrh" id="frmSrh" method="post">
    <input type="hidden" id="stplatSeq" name="stplatSeq" />
    <input type="hidden" id="stplatTyCode" name="stplatTyCode" value="<c:out value="${paramVO.stplatTyCode }" />" />
    <input type="hidden" name="pageIndex" value="<c:out value="${paramVO.pageIndex}" />" />
         
    <div class="clause001">
    <c:choose>
    	<c:when test="${ stplatTyCode eq 'SC00000453'}">
        <p class="clauseNaming"><spring:message code="wzwg.module.word.stplathist" /></p>
    	</c:when>
    	<c:otherwise>
        <p class="clauseNaming"><spring:message code="wzwg.module.word.policyhist" /></p>
    	</c:otherwise>
    </c:choose>
        <div class="clauseWrap"> 
            <ul class="clauseAllbox">
            	<c:if test="${!empty resultList}">
            	<c:forEach items="${resultList }" var="stplatList" varStatus="status">
            		<li id="liNum<c:out value="${status.count }" />">
            		<div class="clausBox">
            			<h2 class="clauseList" onclick="fnInit('<c:out value="${stplatList.stplatSeq }" />','<c:out value="${status.count}" />');">
            				<a href="javascript:void(0);" class="tit_name" ><c:out value="${stplatList.stplatNm }" /></a>
            			</h2>
            		</div>
            		</li>
            	</c:forEach>
            	</c:if>
            </ul>
        </div>

    </div><!-- clause001 end -->
    </form>
   	<div id="stplatSimpDiv"></div>
         
                          
