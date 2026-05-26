<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<jsp:include page="/WEB-INF/jsp/wzwg/webModule/editorTool.jsp"></jsp:include>

<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js"></script>
<script language="javascript" type="text/javascript" src="/jquery/js/jquery.form.min.js"></script>
<script src="/js/wzwg/cmm/html2canvas.js" type="text/javascript"></script>



<script type="text/javascript">
	$(document).ready(function(e){
	    
	    $('#modal-layout').draggable({ handle: "#modal-layout-move-handler" });
		$("#modal-layout-move-handler").css('cursor', 'move');
		
		$('input[name=tmplatSj]').focus();
	});
	/** 컨텐츠 템플릿 등록 */
	function fn_CntntsTmplatRegist(){
		
		/** 이미지파일 확장자 체크 */
		var atchFile = document.getElementById('atchFile');
	    if(typeof atchFile != "undefind" && atchFile != null) {
	    	atchFile = atchFile.value;
	        
	        atchFile = atchFile.slice(atchFile.lastIndexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로 만듭니다.
	        
	        if(atchFile != "jpg" && atchFile != "png" && atchFile != "gif"){ //확장자를 확인합니다.
	            alert('<spring:message code="wzwg.cmm.msg.MSG126" />');
	        	$("#atchFile").focus();
	            return;
	        }
	    }
	    
	    oEditors.getById["tmplatCn"].exec("UPDATE_CONTENTS_FIELD", []);

		if(!Validator.validate(document.cntntsTmplatForm)){
			return;
		}

 		var frm = $("#cntntsTmplatForm");

		frm.ajaxSubmit({
			type:'POST'
			, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/cntntsMngr/cntntnsTmplat/registCntntsTmplatAjax.do'
			, async: false
			, success:function(result){
				$(result).find('value').each(function(){
					if($(this).text() == "success"){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
						fn_CntntsTmplatList();
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
					}
				});
			}
			, error:function (request, status, error) {
	              alert('<spring:message code="fail.common.msg" text="error" />');
	          }
			, dataType: 'xml'
		});
	}

	/** 컨텐츠 템플릿 목록으로 이동 */
	function fn_CntntsTmplatList(){
		var frm = document.cntntsTmplatForm;
		frm.action='<c:out value="${wzwg_contextPath}${prefix}"/>/cntntsMngr/cntntnsTmplat/selectCntntsTmplatList.do';
		frm.submit();
	}
	
	function fnPreviewOpen(){
		var previewContent = oEditors.getById["tmplatCn"].getIR();
		
		$('#previewDiv').html(previewContent);
		//$("#divLayerPopup").html(popupContent);
		//$("#divLayerPopup").show();
		
		var title = '<spring:message code="wzwg.sysMngr.word.cntntsTmplatPreview" />';
		wzHtmlModal('popup_l', title, 'previewDiv');
	}
	
	function fnLayerPopupClose() {
	    $("#divLayerPopup").hide();
	    //$("#divLayerPopup").empty();
	    $('#previewDiv').empty();
	    $('body').css({overflow:'auto'});
	}
	
	function fnScreenshotDownload() {
		var browser = navigator.userAgent.toLowerCase();
		if ( (-1 != browser.indexOf('chrome')) == false ){
			alert('<spring:message code="wzwg.cmm.msg.MSG180" />');
			return;
		}
		
		//$(document).scrollTop(0);
		$('.pop-container').scrollTop(0);
		html2canvas($("#previewDiv"), {
			//allowTaint: true,
			//taintTest: false,
			useCORS: true,
			proxy: '/etc/proxy_image',
			onrendered: function(canvas) {
				var image = canvas.toDataURL();
				//meta.cmn.submitHiddenForm("/etc/bypass_image", { image : image });
				var a = document.createElement('a');
				a.style = "display: none";
				a.href = image;
				a.download = "screenShot.png";
				document.body.appendChild(a);
				a.click();
				setTimeout(function() { // 다운로드가 안되는 경우 방지
				    document.body.removeChild(a);
				}, 100);
				
			}
		});
	}   
</script>

	<form id="cntntsTmplatForm" name="cntntsTmplatForm" method="post" enctype="multipart/form-data">
		<table class="basic">
			<colgroup>
				<col width="20%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
				<tr>
					<th><spring:message code="wzwg.cmm.word.ctgry02" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td>
						<select name="tmplatClSeq" id="tmplatClSeq" dir="required" title="<spring:message code="wzwg.cmm.word.ty" />">
							<c:forEach items="${codeList }" var="codeList">
								<option value="<c:out value="${codeList.code }"/>"><c:out value="${codeList.codeNm }"/></option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.tmplatSj" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td>
						<c:set var="msg_txt01">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011">
								<spring:argument><spring:message code="wzwg.sysMngr.word.tmplatSj" /></spring:argument>
								<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
							</spring:message>
						</c:set>
						<input type="text" name="tmplatSj" class="w70" dir="required" title="<spring:message code="wzwg.cmm.word.sj" />" placeholder="<c:out value="${msg_txt01}"/>"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.cmm.word.thumb" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td>
						<input type="file" name="atchFile" id="atchFile" title="<spring:message code="wzwg.cmm.word.thumb" />" dir="required"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.tmplatCn" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td>
						<textarea name="tmplatCn" id="tmplatCn" rows="30" style="width:100%;" dir="required" title="<spring:message code="wzwg.cmm.word.cn" />"></textarea>
						<script type="text/javascript">
							var oEditors = [];
							nhn.husky.EZCreator.createInIFrame({
							    oAppRef: oEditors,
							    elPlaceHolder: "tmplatCn",
							    sSkinURI: "<c:out value="${wzwg_contextPath}"/>/smartEditor2.8.2.1/smartEditor2Skin.do",
							    fCreator: "createSEditor2",
							    htParams: {
									fOnBeforeUnload : function(){}
									,aAdditionalFontList : [['NanumSquareR', 'NanumSquareR']]		// 추가 글꼴 목록
									}
							});
							WzwgEditorTool.instance("tmplatCn");
						</script>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	
	
    
	<div class="rt-box">
		<a href="javascript:void(0);" class="wzbtn btn-basic" onclick="fnPreviewOpen();"><spring:message code="wzwg.cmm.word.preview" /></a>
		<a href="javascript:void(0);" class="wzbtn btn-save" onclick="fn_CntntsTmplatRegist();"><spring:message code="wzwg.cmm.word.stre" /></a>
		<a href="javascript:void(0);" class="wzbtn btn-basic" onclick="fn_CntntsTmplatList();"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>
	
	<!-- 레이어팝업 영역 Start -->
		<div id="divLayerPopup" class="modal fade in" style="display: none;">
			<div style="margin-top: 150px">
				<div class="pop-box" style="display: block;">
				 	<div class="layer3 main-design-edit-popup" id="modal-layout">	
						 <div class="popupzone_layer">
						 	<div class="pop-id-sch" id="modal-layout-move-handler">
								<span><spring:message code="wzwg.sysMngr.word.cntntsTmplatPreview" /></span>
								<button class="close" type="button" onclick="fnLayerPopupClose();"><img src="/images/wzwg/site/mngr/pop-close.png" alt="<spring:message code="wzwg.cmm.word.close" />"></button>
							</div>
							<div class="pop-container">
								<div id="previewDiv" class="cntntsTmplt_prvwPOP" style="width:100%; box-sizing:border-box;"></div>
								<div class="rt-box" style="width: 100%; max-width: 960px; margin: 10px auto;">
									<button type="button" class="btn-a" onclick="fnScreenshotDownload();"><spring:message code="wzwg.cmm.word.scrst" /></button>
									<button type="button" class="btn-a" onclick="fnLayerPopupClose();"><spring:message code="wzwg.cmm.word.close" /></button>
								</div>
							</div>
						</div>
					</div>
				</div>
				
							
			</div>
		</div>
		<!-- 레이어팝업 영역 End -->
