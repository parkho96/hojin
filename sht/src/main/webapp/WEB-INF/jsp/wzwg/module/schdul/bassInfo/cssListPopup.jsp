<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>


<script type="text/javascript">

	/** CSS 미리보기 */
	function fnCssPrevew(cssSeq){
		var frm = document.frmPopup;
		frm.cssSeq.value = cssSeq;
		
		var frmResult = window.open("", "popForm", "width=800,height=600,toolbars=no,menubars=no,scrollbars=yes");
		
		frm.target='popForm';
		frm.action='<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/bbs/cmmn/selectCssPrevewPopup.do';
		frm.submit();
	}
	
	function fnCssChange(cssSeq, val) {
		
		var frm = document.frmPopup;
		frm.cssSeq.value = cssSeq;		
		
		if(!confirm('<spring:message code="wzwg.cmm.msg.MSG418" />')){
			return;
		}else{
			
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/schdul/modifySchdulCssAjax.do'
				, dataType: 'xml'
				, data : $("#frmPopup").serialize()
				, success : function (result) {
		    	  
		    	  	var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value == 'success'){
						fnBgcolorChange(val);
						fnCssInfo();
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument>CSS <spring:message code="wzwg.cmm.word.info" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
					}
		    	  
				}
				, error : function (request, status, error) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});
		
		}
		
	}	
	
	function fnBgcolorChange(val) {
		//$("div[id^=css_area_]").css("background-color","#fff");
		//$("#css_area_"+val).css("background-color","#ccc");
		$("div[id^=css_area_]").removeClass('bg-blue');
		$("#css_area_"+val).addClass('bg-blue');
		
		//관리자용 CSS 로드
		var imgSrc = $("#css_area_"+val + " img").attr('src');
		var cssPath = imgSrc.replace('jpg', 'css'); //이미지의 확장자를 바꾸고
		console.log(cssPath);
		if($('#schdulCss').length == 0){
			$('head').append('<link type="text/css" id="schdulCss" href="' + cssPath+ '" rel="stylesheet">'); // CSS가 없으면 붙이고
		}else{
			$('#schdulCss').attr('href', cssPath); //CSS가 있으면 변경
		}
	}

</script>


				<form name="frmPopup" id="frmPopup" method="post"> 
					<input type="hidden"  name="cssSeq" id="cssSeq" value="<c:out value="${paramVO.cssSeq}" />"/> 
					<input type="hidden"  name="schdulSeq" id="schdulSeq" value="<c:out value="${paramVO.schdulSeq}" />"/>
					
					<c:forEach var="resultList" items="${resultList}" varStatus="status">
					
					<div id="css_area_<c:out value="${status.count}" />" class="template <c:if test="${paramVO.cssSeq eq resultList.cssSeq}">bg-blue</c:if>">
		
						<div class="pd20">
							<h4><c:out value="${resultList.cssNm}"/></h4>
							<div class="tem-img pb20">
								<div>
									<a href="javascript:void(0);" onclick="fnCssPrevew('<c:out value="${resultList.cssSeq}"/>');">
										<img src='<c:out value="${resultList.prevewPath}"/>' id="orgImg" style="width:250px;height:155px;"/>
									</a>
								</div>
							</div>
							<div class="tem-list">
								<div class="rt-box">
									 <a href="javascript:void(0);" onclick="fnCssChange('<c:out value="${resultList.cssSeq}"/>',<c:out value="${status.count}" />);" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.apply" /></a> 
								</div>
							</div>
						</div>
		
					</div> 
					
					</c:forEach>
					
				</form>
		