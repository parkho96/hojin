<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<c:set var="paramSiteSeq" value="${resultVO.siteSeq}" />
<c:if test="${empty paramSiteSeq}">
<c:set var="paramSiteSeq" value="${paramVO.siteSeq}" />
</c:if>
 <% String getIp = request.getRemoteAddr().toString(); %>
<c:set var="nowIp" value="<%= getIp %>" scope="request" />
<script type="text/javascript" src="/js/egovframework/com/cmm/fms/EgovMultiFile.js" ></script>
<script type="text/javascript">
function fnSiteAdiInfoRegist() {
	
	 var ipChk = /^([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]|[*]{2}|[0-9][*]{1,2})$/;
	    var connIp = $.trim($('#connIpEstbs').val());
	    if (connIp != '') {
	        var connIpArr = connIp.split(',');
	        if (connIpArr.length > 0) {
	            for (var i=0; i<connIpArr.length; i++) {
	                var getIp = connIpArr[i];
	                if (getIp.indexOf('.') > -1) {
	                    var getIpArr = getIp.split('.');
	                    for (var j=0; j<getIpArr.length; j++) {
	                        if(!ipChk.test(getIpArr[j])) {
	                            return alert('<spring:message code="wzwg.cmm.msg.MSG434" />');
	                        }
	                    }
	                } else {
	                    return alert('<spring:message code="wzwg.cmm.msg.MSG434" />');
	                }
	            }
	        }
	    }

	    

	if(!Validator.validate(document.frmReg)){
		return;
	}
	
    var tLogoFile = document.getElementById('tLogoFile');
    var fLogoFile = document.getElementById('fLogoFile');
    var sIconFile = document.getElementById('sIconFile');
    
    if(typeof tLogoFile != "undefined" && tLogoFile != null  && tLogoFile.value != '') {
    	tLogoFile = tLogoFile.value;
    	
        tLogoFile = tLogoFile.slice(tLogoFile.indexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로 만듭니다.

        if(tLogoFile != "jpg" && tLogoFile != "png" && tLogoFile != "gif"){ //확장자를 확인합니다.
            alert('<spring:message code="wzwg.cmm.msg.MSG126" />');
            return;
        }
    }

    if(typeof fLogoFile != "undefined" && fLogoFile != null && fLogoFile.value != '') {
    	fLogoFile = fLogoFile.value;
        
        fLogoFile = fLogoFile.slice(fLogoFile.indexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로 만듭니다.
        
        if(fLogoFile != "jpg" && fLogoFile != "png" && fLogoFile != "gif"){ //확장자를 확인합니다.
            alert('<spring:message code="wzwg.cmm.msg.MSG126" />');
            return;
        }
    }
    
    if(typeof sIconFile != "undefined" && sIconFile != null && sIconFile.value != '') {
    	sIconFile = sIconFile.value;
        
    	sIconFile = sIconFile.slice(sIconFile.indexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로 만듭니다.
        
        if(sIconFile != "jpg" && sIconFile != "png" && sIconFile != "gif" && sIconFile != "ico"){ //확장자를 확인합니다.
            alert('<spring:message code="wzwg.cmm.msg.MSG126" />');
            return;
        }
    }
    
    document.frmReg.action="<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/registSiteAdiInfo.do";
	document.frmReg.submit();
}

//file을 변경할수 있는 폼을 생성하고 기존에 있던 파일정보를 숨긴다.
//divNm : 변경할 div명(thumbFileDiv, imgFileDiv)
//fileNm : 변경할 파일ID (thumbFile, imgFile)
function fnCreateFileForm(divNm, fileNm) {
    $("#"+divNm).empty();
    
    var title = "";
    
    if(fileNm == "tLogo") {
        title = "<spring:message code='wzwg.sysMngr.word.upendLogo' />";
    } else if(fileNm == "fLogo") {
        title = "<spring:message code='wzwg.sysMngr.word.lptLogo' />";
    }
    
    var fileFormStr = "<p><input type='file' name='"+fileNm+"File' id='"+fileNm+"File'  dir='required' title='"+title+"' />";
    var pTagTxt = "<p><span><!--<spring:message code="wzwg.cmm.msg.MSG151" />--> <spring:message code="wzwg.cmm.msg.MSG126" /></span></p>";
    
    
        $("#"+divNm).append(fileFormStr + pTagTxt);
}

function fnChangeMlsfcGroup(upperGrpSeq) {
    
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
                  if(sitegrpSeq == '<c:out value="${resultVO.siteMlsfcGroup}" />'){
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
}

$(document).ready(function(){
    var slGrp = '<c:out value="${resultVO.siteLclasGroup}" />';
    
    fnChangeMlsfcGroup(slGrp);
});

function fnBaseMenuSet() {
    
    if (!confirm('<spring:message code="wzwg.cmm.msg.MSG144" />')) {
        return false;
    }
    
    $.ajax({
        type : 'POST'
      , dataType: 'xml'
      , url:'<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/menuEstbs/registerMenuEstbsSiteSetAjax.do'
      , cache : false
      , async : true
      , data:{'siteSeq':'<c:out value="${paramSiteSeq}" />', 'estbsinfoSeq':document.getElementById('estbsinfoSeq').value}
	  , beforeSend:fnLoadingOpen
      , success : function(data) {
          fnLayerPopupClose();

          var result = $(data).find('value').text();
          
          if (result == 1) {
              alert('<spring:message code="wzwg.cmm.cmmMsg.CMG010"><spring:argument><spring:message code="wzwg.cmm.word.compt" /></spring:argument></spring:message>');
          } else {
              alert('<spring:message code="wzwg.cmm.msg.MSG076" />');
          }
      }
      , error:function (data) {
          alert('<spring:message code="fail.common.msg" text="error" />');
      }
      , complete:fnLayerPopupClose
      
      
  });
}


//메뉴설정 초기화
function fnMenuEstbsSet() {
 
 if (!confirm('<spring:message code="wzwg.cmm.msg.MSG145" />')) {
     return false;
 }
 
 $.ajax({
     type : 'POST'
   , dataType: 'xml'
   , url:'<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/menuEstbs/modifySiteMenuEstbsAtAjax.do'
   , cache : false
   , async : true
   , data:{'siteSeq':'<c:out value="${paramSiteSeq}" />'}
   , beforeSend:fnLoadingOpen
   , success : function(data) {
       fnLayerPopupClose();

       var result = $(data).find('value').text();
       
       if (result == 1) {
           alert('<spring:message code="wzwg.cmm.cmmMsg.CMG010"><spring:argument><spring:message code="wzwg.cmm.word.compt" /></spring:argument></spring:message>');
       } else {
           alert('<spring:message code="wzwg.cmm.msg.MSG076" />');
       }
       fnTabLink(1);
   }
   , error:function (data) {
       alert('<spring:message code="fail.common.msg" text="error" />');
   }
   , complete:fnLayerPopupClose
   
   
});
}

function fnLoadingOpen(){
	var popupContent = $('#apply_pop').html();
	$("#divLayerPopup").html(popupContent);
	$("#divLayerPopup").show();
}

function fnLayerPopupClose() {
    $("#divLayerPopup").hide();
    $("#divLayerPopup").empty();
    $('body').css({overflow:'auto'});
}

function ajaxTest(){
	//fnLoadingOpen();
	//setTimeout(function(){alert('dd')}, 1000);
	$.ajax({
        type : 'POST'
      , dataType: 'html'
      , contentType : 'application/x-www-form-urlencoded; charset=UTF-8'
      , url:'<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteGroup/selectSiteGroupMlsfcAjax.do'
      , cache : false
      , async : true
      , data:{'odr':2, 'upperGrpSeq':10000000008}
      , beforeSend : fnLoadingOpen
      , success : function(xml, status, request) {
    	  //setTimeout(function(){alert(status)}, 2000);
         alert(status);
          
      }
      , error:function (data) {
          alert('<spring:message code="fail.common.msg" text="error" />');
      }
      , complete : fnLayerPopupClose
     
  });
}

</script>

            <c:choose>
            <c:when test="${!empty paramVO.siteSeq}">
                <jsp:include page="/WEB-INF/jsp/wzwg/sysMngr/siteMngr/siteInfo/siteInfoTab.jsp"></jsp:include>
            </c:when>
            <c:otherwise>
                <h3><spring:message code="wzwg.sysMngr.word.siteAdiinfo" /></h3>
            </c:otherwise>
            </c:choose>

                <form:form modelAttribute="resultVO" name="frmReg" method="post" enctype="multipart/form-data">
                    <c:choose>
                    <c:when test="${empty resultVO.siteSeq}">
                    <input type="hidden" id="siteSeq" name="siteSeq" value="<c:out value="${paramVO.siteSeq}" />" />
                    </c:when>
                    <c:otherwise>
                    <form:hidden path="siteSeq" name="siteSeq" />
                    </c:otherwise>
                    </c:choose>
					
					<!--기본정보 table// -->
                    
                    <c:if test="${empty resultVO.siteSeq}">
                    </c:if>
                   <c:if test="${paramVO.siteSeq ne '10000000001'}">  
					<table summary="<spring:message code="wzwg.cmm.word.adiinfo" />" class="basic">
						<colgroup>
							<col width="13%"/>
							<col width="*"/>
						</colgroup>
						<tbody>
                            <tr>
                                <th><spring:message code="wzwg.cmm.word.detail" /> <spring:message code="wzwg.cmm.word.cl" /></th>
                                <td>
                                	<label class="fs16 vert-m" for="siteLclasGroup"> <spring:message code="wzwg.sysMngr.word.fristGroupEstbs" /></label>
                                    <select id="siteLclasGroup" name="siteLclasGroup" onchange="fnChangeMlsfcGroup(this.value);">
                                        <option value="">::<spring:message code="wzwg.cmm.word.choise" />::</option>
                                        <c:forEach var="result" items="${siteLclasGroupList}">
                                            <option value="<c:out value="${result.sitegrpSeq}" />" <c:if test="${result.sitegrpSeq eq resultVO.siteLclasGroup}">selected="selected"</c:if>><c:out value="${result.groupNm}" /></option>
                                        </c:forEach>
                                    </select>           
                                    
                                    <label class="fs16 vert-m" for="siteLclasGroup"> <spring:message code="wzwg.sysMngr.word.secondGroup" /></label>    
                                    <select id="siteMlsfcGroup" name="siteMlsfcGroup">
                                        <option value="">::<spring:message code="wzwg.cmm.word.choise" />::</option>
                                    </select>      
                                </td>
                            </tr>
                            <tr>
                                <th><spring:message code="wzwg.sysMngr.word.eryyMenuEstbs" /></th>
                                <td>
                                    <select id="estbsinfoSeq" name="estbsinfoSeq">
                                        <c:forEach var="result" items="${menuEstbsList}">
                                            <option value="<c:out value="${result.estbsinfoSeq}" />"><c:out value="${result.estbsinfoNm}" /></option>
                                        </c:forEach>
                                    </select>
                                    <c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
                                    <c:if test="${resultVO.menuEstbsAt eq 'Y'}">
                                        <a href="javascript:void(0);" onclick="fnMenuEstbsSet();" class="wzbtn-table btn-basic"><spring:message code="wzwg.sysMngr.word.menuEstbsCo02Initl" /></a>
                                    </c:if>
                                    </c:if>
                                    <c:choose>
                                    <c:when test="${!empty resultVO.menuEstbsAt && resultVO.menuEstbsAt eq 'Y' && sessionScope.SYSMNGR_AT ne 'Y'}">
                                    <c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
                                        <p class="admpg-subp w100 fl mt10">
										  <span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.MSG146" />
										</p>
                                    </c:if>
                                    </c:when>
                                    <c:otherwise>
                                    <c:if test="${resultVO.menuEstbsAt ne 'Y'}">
                                    <a href="javascript:void(0);" onclick="fnBaseMenuSet();" class="wzbtn-table btn-basic"><spring:message code="wzwg.cmm.word.execut" /></a>
                                    </c:if>
                                    <c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
										<p class="admpg-subp w100 fl mt10">
										  <span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.MSG147" />
										  <span class="wz_tableguide mt5 pl15"><spring:message code="wzwg.cmm.msg.MSG148" /></span>
										</p>
                                    </c:if>
                                    </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr class="wideth-white">
							     <th colspan="2" class="wzAdmSTit"><spring:message code="wzwg.sysMngr.word.logoImageEstbs"/>
							          <div class="wzmsg-help"> <!-- 2019.05.02 (과장님이 알려주신 구조에서 wzmsg-help 한번 더 감싼거예요)   -->
							              <div class="wzmsg-help-btn wz-collapse" data-for="#helpbox1" tabindex="0">
							                    <img src="/images/wzwg/site/mngr/ico_help_grey.png" alt="<spring:message code="wzwg.sysMngr.word.questionIcon" />">					
							              </div>
							              <div class="wzmsg-help-msg" id="helpbox1"><spring:message code="wzwg.cmm.msg.MSG363" /><br>
													<ul><li class="w100"><span class="circle_no">1</span><spring:message code="wzwg.cmm.msg.MSG364" /></li>
													      <li class="w100"><span class="circle_no">2</span><spring:message code="wzwg.cmm.msg.MSG365" /></li>
													      <li class="w100"><span class="circle_no">3</span><spring:message code="wzwg.cmm.msg.MSG366" /></li>
													      <li class="w100"><span class="circle_no">4</span><spring:message code="wzwg.cmm.msg.MSG367" /></li>
													</ul>
													<img style="border-top:1px solid #dedede;" alt="<spring:message code="wzwg.sysMngr.msg.MSG058" />" src="/images/wzwg/site/mngr/helpimg_logozone.jpg">
							               </div>
							          </div>
							     </th>
							</tr> 
							<tr>
								<td colspan="2">
									<p class="admpg-subp w100 fl mt20">
									    <span class="circle_no bg-green-strong vert-m">i</span><strong class="grey"><spring:message code="wzwg.cmm.msg.tip.MSG003" /> ?</strong><spring:message code="wzwg.cmm.msg.tip.MSG004" />
									    <span class="wz_tableguide mt5 pl20"><spring:message code="wzwg.cmm.msg.tip.MSG005" /></span>			
									</p>
									<span class="wz_tableguide mt10 fl wd100 pl20 black"><spring:message code="wzwg.cmm.msg.MSG149" /></span>
								</td>
							</tr>
                            <tr>
                                <th><spring:message code="wzwg.sysMngr.word.reprsntLogoImage" /><span class="circle_no">1</span></th>
                                <td>
	                                <c:choose>
		                                <c:when test="${!empty resultVO.logoTImagePath}">
			                                <div id="tLogoImg">
			                                    <img src='<c:url value='/module/upload/file/selectImageView.do'/>?atchFileId=<c:out value="${resultVO.logoTImagePath}"/>&fileSn=0' alt="<c:out value="${resultVO.logoTImageReplcText}" />" >
			                                    <a href="javascript:void(0);" class="btn-delete iconOnlyBtn btn-basic vert-t ml0 mr10" onclick="fnCreateFileForm('tLogoImg','tLogo');"><spring:message code="wzwg.cmm.word.delete" /></a>
			                                    <input type="hidden" name="logoTImagePath" value="<c:out value="${resultVO.logoTImagePath}" />"/>
			                                </div>
		                                </c:when>
		                                <c:otherwise>
		                                	<p><input type='file' name='tLogoFile' id='tLogoFile'  dir='required'/></p>
		                                </c:otherwise>
	                                </c:choose>
	                                
	                                <div class="">
										<input type="text" name="logoTImageReplcText" id="logoTImageReplcText" class="w30" dir="required" placeholder="<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.sysMngr.word.replcTxt" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>" title="<spring:message code="wzwg.sysMngr.word.reprsntLogoReplcTxt" />" value="<c:out value="${resultVO.logoTImageReplcText}" />">
									</div>
										
								</div>
                                </td>
                            </tr>
                            <tr>
                                <th>copyright<spring:message code="wzwg.cmm.word.logo" /><span class="circle_no">2</span></th>
                                <td>
                                <div id="fLogoImg">
                                    <c:choose>
                                    <c:when test="${!empty resultVO.logoFImagePath}">
                                        <img src="<c:url value='/module/upload/file/selectImageView.do'/>?atchFileId=<c:out value="${resultVO.logoFImagePath}"/>&fileSn=0" alt="<c:out value="${resultVO.logoFImageReplcText}" />">
                                        <a href="javascript:void(0);" onclick="fnCreateFileForm('fLogoImg','fLogo');" class="btn-delete iconOnlyBtn btn-basic vert-t ml0 mr10"><spring:message code="wzwg.cmm.word.delete" /></a>
                                        <input type="hidden" name="logoFImagePath" value="<c:out value="${resultVO.logoFImagePath }" />" />
                                    </c:when>
                                    <c:otherwise>
                                        <p><input type='file' name='fLogoFile' id='fLogoFile'  dir='required' title='<spring:message code="wzwg.sysMngr.word.lptLogoImage" />' /></p>
                                    </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="">
									<input type="text" name="logoFImageReplcText" id="logoFImageReplcText" class="w30" dir="required" placeholder="<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.sysMngr.word.replcTxt" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>" title="<spring:message code="wzwg.sysMngr.word.copyrightLogoReplcTxt" />" value="<c:out value="${resultVO.logoFImageReplcText}" />">
								</div>
                                </td>
                            </tr>
                            <tr>
                                <th>shortcut icon<span class="circle_no">3</span></th>
                                <td>
                                <div id="sIconImg">
                                    <c:choose>
                                    <c:when test="${!empty resultVO.iconSImagePath}">
                                        <img src="<c:url value='/module/upload/file/selectImageView.do'/>?atchFileId=<c:out value="${resultVO.iconSImagePath}"/>&fileSn=0" alt="">
                                        <a href="javascript:void(0);" onclick="fnCreateFileForm('sIconImg','sIcon');" class="btn-delete iconOnlyBtn btn-basic vert-t ml0 mr10"><spring:message code="wzwg.cmm.word.delete" /></a>
                                        <input type="hidden" name="iconSImagePath" value="<c:out value="${resultVO.iconSImagePath }" />" />
                                    </c:when>
                                    <c:otherwise>
                                        <p><input type='file' name='sIconFile' id='sIconFile'  dir='required' title='shortcut icon' /></p>
                                    </c:otherwise>
                                    </c:choose>
                                </div>
                                <span class="wz_tableguide mt10 fl wd100"><spring:message code="wzwg.cmm.msg.MSG362" /></span>
                                </td>
                            </tr>
                            <tr class="wideth-white"><th colspan="2" class="wzAdmSTit"><spring:message code="wzwg.sysMngr.word.etcEstbs" /></th></tr><tr>
                            <tr>
                                <th><spring:message code="wzwg.sysMngr.word.addBotomWords" /><span class="circle_no">4</span></th>
                                <td>
                                    <c:set var="msg_txt01"><spring:message code="wzwg.cmm.msg.MSG150" /></c:set>
                                    <form:textarea class="w70 hgt80 fs16" path="cpyrhtCn" name="cpyrhtCn" rows="3" dir="required" placeholder="${fn:escapeXml(msg_txt01)}" title='copyright'></form:textarea>
                                </td>
                            </tr>
                            <tr>
                                <th><spring:message code="wzwg.sysMngr.word.sslUseAt" /></th>
                                <td>
                                	<ul class="wzForm">
                                		<li>
                                			<label><form:radiobutton path="sslUseAt" name="sslUseAt" value="Y" /><span class="spanLabel"><spring:message code="wzwg.cmm.word.use" /></span></label>
                                		</li>
                                		<li>
                                			<label><form:radiobutton path="sslUseAt" name="sslUseAt" value="N" /><span class="spanLabel"><spring:message code="wzwg.cmm.word.unuse" /></span></label>
                                		</li>
                                	</ul>
                                    <!-- <span class="wz_tableguide mt10">
                                    	<strong><spring:message code="wzwg.cmm.msg.MSG368" /></strong> <spring:message code="wzwg.cmm.msg.MSG369" /><br>
                                    	<spring:message code="wzwg.cmm.msg.MSG370" /> <a class="grey fw600" title="open the new window" href="/mngr/opnsu/bbs/qna/selectBbsInc.do?bbsSeq=10000000003" target="_blank"><spring:message code="wzwg.cmm.msg.MSG371" /></a>
                                    </span> -->
                                    <p class="admpg-subp w100 fl mt10">
                                        <span class="circle_no bg-green-strong vert-m">i</span><spring:message code="wzwg.cmm.msg.MSG368" />
                                        <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<spring:message code="wzwg.cmm.msg.MSG369" />
                                        <span class="wz_tableguide mt5 pl15">
                                            <spring:message code="wzwg.cmm.msg.MSG370" />
                                            <a class="grey fw600" title="open the new window" href="/mngr/opnsu/bbs/qna/selectBbsInc.do?bbsSeq=10000000003" target="_blank">
                                                [<spring:message code="wzwg.cmm.cntnts.hmpgoper" />&gt;<spring:message code="wzwg.cmm.cntnts.opnsu" />&gt;<spring:message code="wzwg.cmm.cntnts.qna" />]</a>
                                            <spring:message code="wzwg.cmm.msg.MSG371" />
                                        </span>
                                    </p>
                                </td>
                            </tr>
                            
                            <tr>
                                <th><spring:message code="wzwg.cmm.word.naver" /> SEO</th>
                                <td>
                                	<c:set var="msg_txt01">
										<spring:message code="wzwg.cmm.cmmMsg.CMG011">
											<spring:argument><spring:message code="wzwg.cmm.word.naver" /> <spring:message code="wzwg.cmm.word.metakey" /></spring:argument>
											<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
										</spring:message>
									</c:set>
                                    <form:input class="w70" path="naverMetaKey" name="naverMetaKey" title="naver metakey" placeholder="${fn:escapeXml(msg_txt01)}"/>
                                    <span class="wz_tableguide mt10">
                                    	<spring:message code="wzwg.cmm.msg.MSG372" /><br>
                                    	<span class="circle_no bg-green-strong">i</span><a class="green fw600" href="https://webmastertool.naver.com" target="_blank"><spring:message code="wzwg.cmm.msg.MSG373" /></a> (<spring:message code="wzwg.cmm.msg.MSG374" />)
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <th><spring:message code="wzwg.cmm.word.google" /> SEO</th>
                                <td>
                                	<c:set var="msg_txt02">
										<spring:message code="wzwg.cmm.cmmMsg.CMG011">
											<spring:argument><spring:message code="wzwg.cmm.word.google" /> <spring:message code="wzwg.cmm.word.metakey" /></spring:argument>
											<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
										</spring:message>
									</c:set>
                                    <form:input class="w70" path="googleMetaKey" name="googleMetaKey" title="google metakey" placeholder="${fn:escapeXml(msg_txt02)}"/>
                                    <span class="wz_tableguide mt10">
                                    	<spring:message code="wzwg.cmm.msg.MSG375" /><br>
                                    	<span class="circle_no bg-green-strong">i</span><a class="green fw600" href="https://www.google.com/webmasters/tools/home?hl=ko" target="_blank"><spring:message code="wzwg.cmm.msg.MSG376" /></a> (<spring:message code="wzwg.cmm.msg.MSG377" />)
                                    </span>
                                </td>
                            </tr>
                           <tr>
                                <th><spring:message code="wzwg.sysMngr.word.dplctLoginSet" /></th>
                                <td>
	                                <c:set var="msg_txt03">
	                                	<spring:message code="wzwg.sysMngr.word.dplctLoginSet" />
	                                </c:set>	
                                    <ul class="wzForm">
                                    	<li>
                                    		<input type="radio" name="dupLoginAt" id="dupLoginAtY" value="Y" dir="required" title="<c:out value="${msg_txt03}" />" <c:if test="${resultVO.dupLoginAt ne 'N' }">checked="checked"</c:if>/> 
                                    		<label for="dupLoginAtY"><spring:message code="wzwg.cmm.word.use" /></label>
                                    	</li>
                                    	<li>
	                                    	<input type="radio" name="dupLoginAt" id="dupLoginAtN" value="N" dir="required" title="<c:out value="${msg_txt03}" />" <c:if test="${resultVO.dupLoginAt eq 'N' }">checked="checked"</c:if>/> 
	                                    	<label for="dupLoginAtN"><spring:message code="wzwg.cmm.word.unuse" /></label>
                                    	</li>
                                    </ul>
                                    <span class="wz_tableguide mt10 block wd100 fl"><spring:message code="wzwg.cmm.msg.tip.MSG063" /></span>
                                </td>
                            </tr> 
                              <tr>
                                <th><spring:message code="wzwg.cmm.word.cnctIPfigur" /></th>
                                <td>
                                    <form:input path="connIpEstbs"  name="connIpEstbs" cssClass="w100 txtIp" />
                                  	<p class="admpg-subp w100 fl mt10">
                                  		<span class="circle_no bg-green-strong vert-m">i</span><spring:message code="wzwg.cmm.msg.tip.MSG104" />
                                        <span class="wz_tableguide mt5 pl15"><spring:message code="wzwg.cmm.msg.tip.MSG105" /> 127.0.0.1, 127.**, 192.168.**, 192.168.1.**</span>
                                        <div class="bg-lightgrey wd100 p15 box-border i-block mt10">
                                        <spring:message code="wzwg.cmm.cmmMsg.CMG020">
											<spring:argument><spring:message code="wzwg.sysMngr.word.nowConectIp" /></spring:argument>
											<spring:argument><strong>[<c:out value="${nowIp}" />]</strong></spring:argument>
										</spring:message>
                                        </div>
                                    </p>
                                </td>
                            </tr>
                            <tr>
                                <th><spring:message code="wzwg.sysMngr.word.mouseRght04ClickPermSet" /></th>
                                <td>
	                                <c:set var="msg_txt04">
	                                	<spring:message code="wzwg.sysMngr.word.mouseRght04ClickPermSet" />
	                                </c:set>
	                                <ul class="wzForm">
	                                	<li>
	                                		<input type="radio" name="rghtClickAt" id="rghtClickAtY" value="Y" dir="required" title="<c:out value="${msg_txt04}" />" <c:if test="${resultVO.rghtClickAt ne 'N' }">checked="checked"</c:if>/> 
                                    		<label for="rghtClickAtY"><spring:message code="wzwg.cmm.word.use" /></label>
	                                	</li>
	                                	<li>
	                                		<input type="radio" name="rghtClickAt" id="rghtClickAtN" value="N" dir="required" title="<c:out value="${msg_txt04}" />" <c:if test="${resultVO.rghtClickAt eq 'N' }">checked="checked"</c:if>/>
	                                		<label for="rghtClickAtN"><spring:message code="wzwg.cmm.word.unuse" /></label>
	                                	</li>
	                                </ul>
                                </td>
                            </tr> 
						</tbody>
					</table>
					</c:if>
					 <c:if test="${paramVO.siteSeq eq '10000000001'}">  	
					<table summary="<spring:message code="wzwg.cmm.word.adiinfo" />" class="basic">
						<colgroup>
							<col width="13%"/>
							<col width="*"/>
						</colgroup>
						<tbody>
                        <tr>
                                <th><spring:message code="wzwg.cmm.word.cnctIPfigur" /></th>
                                <td>
                                    <form:input path="connIpEstbs"  name="connIpEstbs" cssClass="w100 txtIp" />
                                 	<p class="admpg-subp w100 fl mt10">
                                  		<span class="circle_no bg-green-strong vert-m">i</span><spring:message code="wzwg.cmm.msg.tip.MSG104" />
                                        <span class="wz_tableguide mt5 pl15"><spring:message code="wzwg.cmm.msg.tip.MSG105" /> 127.0.0.1, 127.**, 192.168.**, 192.168.1.*11*</span>
                                        <span class="wz-box br-blue-strong">
                                        <spring:message code="wzwg.cmm.cmmMsg.CMG020">
											<spring:argument><spring:message code="wzwg.sysMngr.word.nowConectIp" /></spring:argument>
											<spring:argument><strong>[<c:out value="${nowIp}" />]</strong></spring:argument>
										</spring:message>
										</span>
                                    </p>
                                </td>
                       </tr>
                       </tbody>
                      </table>
                      </c:if>
					<!--//기본정보 table -->
				</form:form>
				
				<div class="rt-box">
					<!-- <a href="javascript:void(0);" onclick="ajaxTest();" class="btn-a">로딩</a> -->
					<a href="javascript:void(0);" onclick="fnSiteAdiInfoRegist(); return false;" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
				</div>
		
		<!-- 레이어팝업 영역 Start -->
		<div id="divLayerPopup" class="modal fade in"></div>
		<!-- 레이어팝업 영역 End -->
		
		<!-- 작업중 모달내용 -->
		<div id="apply_pop" style="display: none;">
			<div class="apply_pop" style="position: absolute; top: 45%; left: 45%; line-height: 20px;">
				<img src="/images/wzwg/cmm/loading.gif" alt="" />
			</div>
		</div>
		<!-- 작업중 모달내용 end -->