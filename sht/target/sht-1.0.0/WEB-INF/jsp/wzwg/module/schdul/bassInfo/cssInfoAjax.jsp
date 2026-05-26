<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>


<script type="text/javascript">
	/** CSS 미리보기 */
	function fnCssPrevewPop(cssSeq){
		var frm = document.regForm;
		frm.cssSeq.value = cssSeq;
		
		var frmResult = window.open("", "popForm", "width=800,height=600,toolbars=no,menubars=no,scrollbars=yes");
		
		frm.target='popForm';
		frm.action='<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/bbs/cmmn/selectCssPrevewPopup.do';
		frm.submit();
	}
	
	/* if($('#schdulDefaultCss').length == 0){
		$('head').append('<link type="text/css" id="schdulDefaultCss" href="/css/wzwg/module/ntt/schdul.css" rel="stylesheet">');
	} */
	</script>
	
	<c:choose>
		<c:when test="${!empty schdulCssVO}">
		
		<script type="text/javascript">
		
		if($('#schdulCss').length == 0){
			$('head').append('<link type="text/css" id="schdulCss" href="<c:out value="${schdulCssVO.cssPath}"/>/<c:out value="${schdulCssVO.cssFileNm}"/>" rel="stylesheet">');
		}
		</script>
			<div class="template">
		
				<div class="pd20">
					<h4><c:out value="${schdulCssVO.cssNm}"/></h4>
					<div class="tem-img pb20">
						<div>
							<a href="javascript:void(0);" onclick="fnCssPrevewPop('<c:out value="${schdulCssVO.cssSeq}"/>');">
								<img src='<c:out value="${schdulCssVO.prevewPath}"/>' id="orgImg" style="width:250px;height:155px;"/>
							</a>
						</div>
					</div>
					<div class="tem-list">
						<div class="lt-box">
							<a href="javascript:void(0);" onclick="fnCntntsStylePopup();" class="wzbtn btn-edit"><spring:message code="wzwg.cmm.word.tochange" /></a> 
						</div>				
					</div>
				</div>
		
			</div> 
			
		</c:when>
		<c:otherwise>
			<div class="pd20">
			<div><spring:message code="wzwg.cmm.msg.MSG299" /></div>
			<div class="lt-box">
				<a href="javascript:void(0);" onclick="fnCntntsStylePopup();" class="wzbtn btn-edit"><spring:message code="wzwg.cmm.word.tochange" /></a> 
			</div>				
		</div>	
		</c:otherwise>
	</c:choose>	