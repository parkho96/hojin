<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>


<script type="text/javascript">

	/** CSS 미리보기 */
	function fnCssPrevew(cssSeq){
		var frm = document.frmPopup;
		frm.cssSeq.value = cssSeq;
		
		var frmResult = window.open("", "popForm", "width=800,height=600,toolbars=no,menubars=no,scrollbars=yes");
		
		frm.target='popForm';
		frm.action='<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/cmmn/selectCssPrevewPopup.do';
		frm.submit();
	}
	
	function fnImgPrevewPop(img){
		console.log(img);
		var viewImg = new Image();
		$(viewImg).attr('src', img.attr('src'));
		var imgsrc = img.attr('src');
		//var imgsrc = $(img).attr('src');

		
//		var width = $(img)[0].naturalWidth;
//		var height = $(img)[0].naturalHeight;
		var width = $(viewImg)[0].naturalWidth;
		var height = $(viewImg)[0].naturalHeight;
		var frm = document.frmPopup;
		frm.imgSrc.value = imgsrc;
		
		
		var frmResult = window.open("", "popForm", "width=" + width + ",height=" + height + ",toolbars=no,menubars=no,scrollbars=yes,left=50,top=400");
		
		frm.target='popForm';
		frm.action='/sample/img/imgViewer.jsp';
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
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/cmmn/modifyBbsCssSeqAjax.do'
				, dataType: 'xml'
				, data : $("#frmPopup").serialize()
				, success : function (result) {
		    	  
		    	  	var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value == 'success'){
						fnChangeCssFile();
						fnBgcolorChange(val);
						fnCssInfo();
						wzModalClose();
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.applc" text="apply" /></spring:argument></spring:message>');				
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
	}
	
	function fnChangeCssFile(){
		var frm = document.frmPopup;
		frm.cssSeq.value = cssSeq;
		
		$.ajax({
	        type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/cmmn/selectChangeCssInfoAjax.do'
			, dataType: 'xml'
			, data : $("#frmPopup").serialize()
			, success : function (result) {
	    	  
	    	  	var value = "";
				
				$(result).find("value").each(function() {  
					value = $(this).text();  
				});
				
				if(value != 'fail'){
					$("#css_link").attr("href", value);
				}else{
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
				}
	    	  
			}
			, error : function (request, status, error) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
	
</script>

	
				<form name="frmPopup" id="frmPopup" method="post"> 
					<input type="hidden"  name="cssSeq" id="cssSeq" value="<c:out value='${paramVO.cssSeq}'/>"/> 
					<input type="hidden"  name="bbsSeq" id="bbsSeq" value="<c:out value='${paramVO.bbsSeq}'/>"/>
					<input type="hidden" name="imgSrc"/>
					
					<c:forEach var="bbsCssList" items="${bbsCssList}" varStatus="status">
					
					<div id="css_area_<c:out value='${status.count}'/>" class="template mb10<c:if test="${paramVO.cssSeq eq bbsCssList.cssSeq}"> bg-blue adm_active</c:if>">
						<div>
							<h4<c:if test="${paramVO.cssSeq eq bbsCssList.cssSeq}"> class="bg-blue-strong3 white"</c:if>><c:out value="${bbsCssList.cssNm}"/></h4>
							<div class="tem-img" style="">
								<div>
									<c:choose>
										<c:when test="${paramVO.listScrinCode eq 'L'}">
											<a href="javascript:void(0);" onclick="fnImgPrevewPop($(this).find('img'))">
												<c:if test="${cntntsInfoVO.sysmoduleSeq eq '10000000003'}">
													<img src='<c:out value="${bbsCssList.prevewPath}" />' id="orgImg" style="width:250px;"/>
												</c:if>
												<c:if test="${cntntsInfoVO.sysmoduleSeq eq '10000000218'}">
													<img src='<c:out value="${bbsCssList.cssPath}"/>/linkBoard_list.jpg' id="orgImg" style="width:250px;"/>
												</c:if>
											</a>
										</c:when>
										<c:when test="${paramVO.listScrinCode eq 'I'}">
											<a href="javascript:void(0);" onclick="fnImgPrevewPop($(this).find('img'))">
												<c:if test="${cntntsInfoVO.sysmoduleSeq eq '10000000003'}">
													<img src='<c:out value="${bbsCssList.cssPath}"/>/album.jpg' id="orgImg" style="width:250px;"/>
												</c:if>
												<c:if test="${cntntsInfoVO.sysmoduleSeq eq '10000000218'}">
													<img src='<c:out value="${bbsCssList.cssPath}"/>/linkBoard_album.jpg' id="orgImg" style="width:250px;"/>
												</c:if>
											</a>
										</c:when>
										<c:when test="${paramVO.listScrinCode eq 'E'}">
											<a href="javascript:void(0);" onclick="fnImgPrevewPop($(this).find('img'))">
												<c:if test="${cntntsInfoVO.sysmoduleSeq eq '10000000003'}">
													<img src='<c:out value="${bbsCssList.cssPath}"/>/event.jpg' id="orgImg" style="width:250px;"/>
												</c:if>
												<c:if test="${cntntsInfoVO.sysmoduleSeq eq '10000000218'}">
													<img src='<c:out value="${bbsCssList.cssPath}"/>/linkBoard_event.jpg' id="orgImg" style="width:250px;"/>
												</c:if>
											</a>
										</c:when>
										<c:when test="${paramVO.listScrinCode eq 'W'}">
											<a href="javascript:void(0);" onclick="fnImgPrevewPop($(this).find('img'))">
												<img src='<c:out value="${bbsCssList.cssPath}"/>/webzine.jpg' id="orgImg" style="width:250px;"/>
											</a>
										</c:when>
										<c:when test="${paramVO.listScrinCode eq 'B'}">
											<a href="javascript:void(0);" onclick="fnImgPrevewPop($(this).find('img'))">
												<img src='<c:out value="${bbsCssList.cssPath}"/>/blog.jpg' id="orgImg" style="width:250px;"/>
											</a>
										</c:when>
										<c:otherwise>
											<a href="javascript:void(0);" onclick="fnCssPrevew('<c:out value="${bbsCssList.cssSeq}"/>');">
												<img src='<c:out value="${bbsCssList.prevewPath}"/>' id="orgImg" style="width:250px;"/>
											</a>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<%-- 
							<c:out value="${paramVO.listScrinCode }"/>
							<c:out value="${paramVO.sysmoduleSeq }"/>
								L : unityBoard.jpg
								I : album.jpg
								E : event.jpg
								W : webzine.jpg
								B : blog.jpg
							--%>
							<div class="tem-list mt10 p10" style="">
								<div class="rt-box">
									 <a href="javascript:void(0);" onclick="fnCssChange('<c:out value="${bbsCssList.cssSeq}"/>',<c:out value="${status.count}"/>);" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.applc" text="applc" /></a> 
								</div>
							</div>
						</div>
		
					</div> 
					
					</c:forEach>
					
				</form>
			