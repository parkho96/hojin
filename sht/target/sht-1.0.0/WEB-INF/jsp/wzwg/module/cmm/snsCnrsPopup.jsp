<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<% 
	String getScheme = request.getScheme();
	String getUrl = request.getServerName().toString();
	String getPort = String.valueOf(request.getServerPort());
	if(getPort.equals("80")){getPort="";} else {getPort= ":"+getPort;}
%>

<c:set var="urlLink" />

<c:if test="${empty pNttSeq}">
	<c:set var="urlLink"><%=getScheme %>://<%=getUrl%><%=getPort%><c:out value="${wzwg_contextPath}${prefix}"/>/subList/<c:out value="${pMenuSeq}"/></c:set>
</c:if>
<c:if test="${!empty pNttSeq}">
	<c:set var="urlLink"><%=getScheme %>://<%=getUrl%><%=getPort%><c:out value="${wzwg_contextPath}${prefix}"/>/subList/<c:out value="${pMenuSeq}"/>?pmode=detail&nttSeq=<c:out value="${pNttSeq}"/></c:set>
</c:if>
<c:if test="${!empty pMvpNttSeq }">
	<c:set var="urlLink"><%=getScheme %>://<%=getUrl%><%=getPort%><c:out value="${wzwg_contextPath}${prefix}"/>/subList/<c:out value="${pMenuSeq}"/>?pmode=detail&mvpnttSeq=<c:out value="${pMvpNttSeq}"/></c:set>
</c:if>

<link type="text/css" href="/css/wzwg/module/cmm/layer_popup.css" rel="stylesheet" />

<meta property="og:title" content="${fn:escapeXml(pNttSeq)}"/>
<meta property="og:url" content="${fn:escapeXml(urlLink)}"/>

<script type="text/javascript" src="/clipboard/dist/clipboard.min.js"></script>
<script type="text/javascript" src="/js/wzwg/cmm/common-sns-cnrs.js"></script>
<script type="text/javascript" src="/js/wzwg/cmm/jquery.qrcode.js"></script>
<script type="text/javascript" src="/js/wzwg/cmm/qrcode.js"></script>

<script>
	
	$(document).ready(function(){
		
		var menuNm = $('#menuNm').val();
		
		if(!menuNm) {
			menuNm = $('#tabTit').html();
		}
		
		$('#gr_area').qrcode('<c:out value="${urlLink}"/>'); 
		$('#gr_area').find('canvas').html(menuNm + ' QR <spring:message code="wzwg.module.word.codeinfo" />');
		
		$('#adres_copy_btn').click(function(){
			$('#adres_copy_btn').attr('data-clipboard-text', '${fn:escapeXml(urlLink)}'.replace(/&amp;/g, '&'));
		    var clipboard = new Clipboard('#adres_copy_btn');
		    clipboard.on('success', function(e) {
		        alert('<spring:message code="wzwg.cmm.msg.MSG083" />');
		        clipboard.destroy();
		        $('#adres_copy_btn').focus();
		    });
		    clipboard.on('error', function(e) {
		        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
		        return false;
		        clipboard.destroy();
		    });
		    
		    $('#adres_copy_btn').focus();
		});
		
	});
	
	function fnLayerPopupClose() {
		//$("#bbs_layer").hide();
	    //$("#bbs_layer").empty();
	    //$('body').css({overflow:'auto'});
	    wzModalClose();
	}
	
</script>

	<%-- <c:set var="adminAuthAt" value="N"/>
	
	<c:if test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or sessionScope.CNTNTS_ADMIN_AT}">
		<c:set var="adminAuthAt" value="Y"/>
	</c:if>
	
	<c:set var="popupViewAuthAt" value="N" />
	
	<c:if test="${adminAuthAt eq 'Y'}">
		<c:set var="popupViewAuthAt" value="Y" />
	</c:if>	
	
	<c:if test="${popupViewAuthAt ne 'Y'}">
		<script type="text/javascript">
			$("#close_btn").click();
			alert("<spring:message code="wzwg.cmm.msg.MSG084" />");
		</script>
	</c:if>	 --%>
	
	<div class="pop-container">
		<div class="sharepop">
			<div class="qrcode">
				<div id="gr_area"></div>
			</div>
			
			<div class="share_contents">
				<div class="urlbox">
					<%-- <p class="urlp">URL : ${urlLink}</p> --%>
					<a href="javascript:void(0);" title="<spring:message code="wzwg.module.word.adrescopy" />" class="wzbtn wzbtn-table btn-blue-bg" id="adres_copy_btn" data-clipboard-action="copy" ><spring:message code="wzwg.module.word.adrescopy" /></a>
				</div>
				<ul class="snsListul">
					<li><a href="javascript:void(0);" title="<spring:message code="wzwg.module.word.facebookcnrsnewOpWin" />" onclick="sendSns('facebook', '${fn:escapeXml(urlLink)}', '<c:out value="${pNttSj}"/>');" class="gray"><img src="/images/wzwg/cmm/faceIcon001.png" alt="<spring:message code="wzwg.cmm.word.facebook" /> <spring:message code="wzwg.cmm.word.icon" />"/></a></li>
					<li><a href="javascript:void(0);" title="<spring:message code="wzwg.module.word.twittercnrsnewOpWin" />" onclick="sendSns('twitter', '${fn:escapeXml(urlLink)}', '<c:out value="${pNttSj}"/>');" class="gray"><img src="/images/wzwg/cmm/twitterIcon001.png" alt="<spring:message code="wzwg.cmm.word.twitter" /> <spring:message code="wzwg.cmm.word.icon" />"/></a></li>
					<li><a href="javascript:void(0);" title="<spring:message code="wzwg.module.word.navercnrsnewOpWin" />" onclick="sendSns('naver', '${fn:escapeXml(urlLink)}', '<c:out value="${pNttSj}"/>');" class="gray"><img src="/images/wzwg/cmm/naverIcon001.png" alt="<spring:message code="wzwg.cmm.word.naver" /> <spring:message code="wzwg.cmm.word.icon" />"/></a></li>
					
					<c:if test="${pMobileAt eq 'N'}">
						<li><a href="javascript:void(0);" title="<spring:message code="wzwg.module.word.kakaostorycnrsnewOpWin" />" onclick="sendSns('kakaostory_p', '${fn:escapeXml(urlLink)}', '<c:out value="${pNttSj}"/>');" class="gray"><img src="/images/wzwg/cmm/kakao002.png" alt="<spring:message code="wzwg.cmm.word.kakaostory" /> <spring:message code="wzwg.cmm.word.icon" />"/></a></li>
						<li><a href="javascript:void(0);" title="<spring:message code="wzwg.module.word.naverbandcnrsnewOpWin" />" onclick="sendSns('naverband_p', '${fn:escapeXml(urlLink)}', '<c:out value="${pNttSj}"/>');" class="gray"><img src="/images/wzwg/cmm/bandIcon001.png" alt="<spring:message code="wzwg.cmm.word.naverband" /> <spring:message code="wzwg.cmm.word.icon" />"/></a></li>
					</c:if>
					
					<c:if test="${pMobileAt eq 'Y'}">
						<li><a href="javascript:void(0);" title="<spring:message code="wzwg.module.word.kakaotalkcnrsnewOpWin" />" onclick="sendSns('kakaotalk', '${fn:escapeXml(urlLink)}', '<c:out value="${pNttSj}"/>');" class="gray"><img src="/images/wzwg/cmm/kakao001.png" alt="<spring:message code="wzwg.cmm.word.kakaotalk" /> <spring:message code="wzwg.cmm.word.icon" />"/></a></li>
						<li><a href="javascript:void(0);" title="<spring:message code="wzwg.module.word.kakaostorycnrsnewOpWin" />" onclick="sendSns('kakaostory_m', '${fn:escapeXml(urlLink)}', '<c:out value="${pNttSj}"/>');" class="gray"><img src="/images/wzwg/cmm/kakao002.png" alt="<spring:message code="wzwg.cmm.word.kakaostory" /> <spring:message code="wzwg.cmm.word.icon" />"/></a></li>
						<li><a href="javascript:void(0);" title="<spring:message code="wzwg.module.word.naverbandcnrsnewOpWin" />" onclick="sendSns('naverband_m', '${fn:escapeXml(urlLink)}', '<c:out value="${pNttSj}"/>');" class="gray"><img src="/images/wzwg/cmm/bandIcon001.png" alt="<spring:message code="wzwg.cmm.word.naverband" /> <spring:message code="wzwg.cmm.word.icon" />"/></a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>

