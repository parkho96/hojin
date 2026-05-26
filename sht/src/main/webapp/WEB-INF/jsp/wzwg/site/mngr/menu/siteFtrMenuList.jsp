<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script> 
$(function() { 
	fnMenuFtrLgnNList();
	fnMenuFtrLgnYList();
	fnMenuFtrImgLinkList();
});
function fnMenuFtrLgnNList() { 
    $.ajax({
        type:'POST'
      , url:'<c:out value="${wzwg_contextPath}"/>/mngr/menu/selectSiteFtrLgnNMenuMngrListAjax.do' 
      , success:function (data) {
          $('#lgnNDiv').html(data);  
        }
      , dataType: 'html'
  });
}

function fnMenuFtrLgnYList() {
    $.ajax({
        type:'POST'
      , url:'<c:out value="${wzwg_contextPath}"/>/mngr/menu/selectSiteFtrLgnYMenuMngrListAjax.do' 
      , success:function (data) {
          $('#lgnYDiv').html(data);  
        }
      , dataType: 'html'
  });
}

function fnMenuFtrImgLinkList() { 
	document.frm.menuTySe.value='I';
	
    $.ajax({
        type:'POST'
      , data:$("#frm").serialize()
      , url:'<c:out value="${wzwg_contextPath}"/>/mngr/menu/selectSiteFtrLgnYMenuMngrListAjax.do' 
      , success:function (data) {
          $('#ftrImgLinkDiv').html(data);  
        }
      , dataType: 'html'
  });
}

function fnMenuFtrLgnYRegist() { 
    document.frm.lgnAt.value="Y";
    document.frm.action="<c:out value="${wzwg_contextPath}"/>/mngr/menu/selectSiteMenuRegistFrmMngr.do";
    document.frm.submit();
}

function fnMenuFtrLgnNRegist() { 
    document.frm.lgnAt.value="N";
    document.frm.action="<c:out value="${wzwg_contextPath}"/>/mngr/menu/selectSiteMenuRegistFrmMngr.do";
    document.frm.submit();
}

function fnMenuModify(hdftrmenuSeq) { 
    document.frm.hdftrmenuSeq.value=hdftrmenuSeq;
    document.frm.action="<c:out value="${wzwg_contextPath}"/>/mngr/menu/selectSiteMenuModifyFrmMngr.do";
    document.frm.submit();
}


function fn_siteFtrMenuModifyOrdr(ordrGubun,hdftrmenuSeq,hdftrmenuOrdr,lgnAt,menuTySe){
	document.frm.ordrGubun.value=ordrGubun;
	document.frm.hdftrmenuSeq.value=hdftrmenuSeq;
	document.frm.hdftrmenuOrdr.value=hdftrmenuOrdr;
	document.frm.lgnAt.value=lgnAt; 
	document.frm.menuTySe.value=menuTySe;
	
	$.ajax({
		type:'POST'
		, url:'<c:out value="${wzwg_contextPath}"/>/mngr/menu/modifySiteHdftrMenuOrdrAjax.do'
		, data:$("#frm").serialize()
		,success:function (result){
			$(result).find('value').each(function(){
				if($(this).text() == "success"){
					if(menuTySe == 'I') {
						fnMenuFtrImgLinkList();
					}else {
						if(lgnAt == 'Y'){
							fnMenuFtrLgnYList();
						}else{
							fnMenuFtrLgnNList();
						}
					}
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

function fnLinkUrlList(selId, linkGrpSeq){
    $.ajax({
          type : 'POST'
        , dataType: 'xml'
        , contentType : 'application/x-www-form-urlencoded; charset=UTF-8'
        , url : '<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/menu/linkGrp/selectLinkUrlListAjax.do'
        , cache : false
        , async : false
        , data : {'linkGrpSeq':linkGrpSeq}
        , success : function(xml, status, request) {
            
            $(xml).find("item").each(function(){
                var linkUrl = $(this).find('name').text();
                var linkNm = $(this).find('value').text();
                $("#"+selId).append("<option value=\"" +linkUrl+ "\">" + linkNm + "</option>");
            });
        }
        , error:function (data) {
            alert('<spring:message code="fail.common.msg" text="error" />');
        }
    });
}
</script> 
<form name="frm" id="frm" method="post">
<input type="hidden"  name="lgnAt" id="lgnAt" />
<input type="hidden"  name="hdftrmenuSeq" id="hdftrmenuSeq" />
<input type="hidden"  name="hdftrCode" id="hdftrCode" value="SC00000082" />
<input type="hidden"  name="ordrGubun" id="ordrGubun" />
<input type="hidden"  name="hdftrmenuOrdr" id="hdftrmenuOrdr" />
<input type="hidden"  name="menuTySe" id="menuTySe" />

</form>

<div class="wz_notice brbox bg-white br-blue-strong" style="overflow: visible;">
        <ul class="wd100">
                <li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG0021" /></li>
                <!-- <li class="admpg-subp wd100 grey">· 예시) 로그인전 : 로그인, 회원가입  / 로그인후 : 로그아웃, 마이페이지 등</li> -->
                <li class="admpg-subp wd100 wzAdmSTit p0 mb0" style="background: transparent;">· <spring:message code="wzwg.cmm.msg.tip.MSG0022" />
	                        <div class="menu_help">
		                <img src="/images/wzwg/site/mngr/ico_help_grey.png" alt="">
		                <div class="help_pop">
		                       <img src="/images/wzwg/site/mngr/helpimg_footermenu.jpg" class="mxwd100" alt="">
	                                </div>
	                        </div>
	            </li>
        </ul>
</div>

<h3 class="wzAdmSTit wd100 fl">
	<spring:message code="wzwg.site.menu.msg.MSG017" />
</h3>

  <div id="lgnNDiv"  style="margin-top:30px; margin-bottom: 20px;"></div>

	 <%-- <div style="margin-top:10px;">
	 	<div class="rt-box">
	 		 <a href="javascript:void(0);" class="btn-a" onclick="fnMenuFtrLgnNRegist();"><spring:message code="wzwg.cmm.word.regist" /></a>
	 	</div>
	 </div> --%>
	  
<h3 class="wzAdmSTit wd100 fl" >
	<spring:message code="wzwg.site.menu.msg.MSG018" />
</h3>

  <div id="lgnYDiv" style="margin-top:20px; margin-bottom: 30px;"></div>
  
  
<h3 class="wzAdmSTit wd100 fl mb10 mt50" >
	<spring:message code="wzwg.site.menu.msg.MSG019" />
</h3>
<p class="admpg-subp w100 fl mt10 mb20 pl20">
    <span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.tip.MSG0023" />
</p>
  <div id="ftrImgLinkDiv" style="margin-top:20px; margin-bottom: 30px;"></div>
  
	 	<div style="margin-top:10px;">
	 	<div class="fr">
		 	<div class="rt-box">
		 		<a class="wzbtn btn-save bg" href="javascript:void(0);" onclick="fnMenuFtrLgnYRegist();"><spring:message code="wzwg.cmm.word.regist" /></a>
		 	</div>
	 	</div>
	 </div>
