<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp"%>
<script src="/js/wzwg/cmm/tendina.min.js"></script>
<script src="/jquery/js/jquery.form.min.js"></script>

<script>
	$(document).ready(function(){
		wzImgPrevieBind('icon_file', 'icon_preview');
		
		$('.linkMenuList').tendina('destroy');//중복 호출시 이벤트 충돌 방지용
		$('.linkMenuList').tendina({
			animate: true,
			speed: 300,
			onHover: false,
			hoverDelay: 100,
			activeMenu: $('#deepest'),
			openCallback: function(clickedEl) {
			  console.log('Hey dude!');
			},
			closeCallback: function(clickedEl) {
			  console.log('Bye dude!');
			}
		 }); //내부링크
		 
	});
	
	function selectMenuLink(url, name){
		$('#qmenuNm').val(name);
		$('#qmenuDc').val(name);
		$('#qmenuLinkUrl').val(url);
		//$('#hdftrmenuLinkUrl').focus();
	}
	
	
	function registQuickLinkAjax(){
		//var frm = $("#quickLinkForm")[0];
 		//var formData = new FormData(frm);
 		if($('#qmenuTySe').val() == 'L'){
 			if($('#quickLinkForm input[name="menuSttusCode"]:checked').val() == 'Y'){
 				var viewAtCnt = $('#sideQuickItemList tr[data-viewat="true"]').length;//노출 카운터
 				
 				//console.log(viewAtCnt);
 				if(viewAtCnt >= 6){
 					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG018"><spring:argument><spring:message code="wzwg.module.word.linkexposure"/></spring:argument><spring:argument>6<spring:message code="wzwg.cmm.word.count02"/> <spring:message code="wzwg.cmm.word.until"/></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.regist"/></spring:argument></spring:message>');
 					$('#quickLinkForm input[name="menuSttusCode"]:checked').focus();
 					return;
 				}
 			}
 			
 			if($('#qmenuLinkUrl').val() == ''){
 				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument><spring:message code="wzwg.module.word.linkadres"/></spring:argument></spring:message>');
 				$('#qmenuLinkUrl').focus();
 				return;
 			}
 			
 			if($('#qmenuNm').val() == ''){
 				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument><spring:message code="wzwg.module.word.linksj"/></spring:argument></spring:message>');
 				$('#qmenuNm').focus();
 				return;
 			}
 			
	 		if($('#icon_file').val() == '' && $('#menuImagePath').val() == ''){
	 			alert('<spring:message code="errors.required"><spring:argument><spring:message code="wzwg.cmm.word.icon"/></spring:argument></spring:message>')
	 			$('#btn_addIcon').focus();
	 			return;
	 		}
 		}
 		
 		
 		if($('#icon_file').val() != ''){
 			//이미지를 직접 업로드 한다면 스토어 이미지 패스 삭제
 			$('#menuImagePath').val('');
 		}
		
 		$("#quickLinkForm").ajaxSubmit({
	        type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/sideQuick/registSideQuickLinkAjax.do'
			, mimeType: 'multipart/form-data'
			, cache : false
			, async : false
			, processData: false
			, contentType: false
			
			, dataType : 'json'
			, success : function (data) {
				console.log(data);
				if(data.head.result == 'success'){
//					alert('등록되었습니다.');
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
					fnAppendQuickLinkListAjax();
					wzModalClose();
				}else{
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
	    	  
			}
			, error : function (request, status, error) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
		});
	}
	
	function typeSeChange(){
		var tyse = $('#qmenuTySe').val();
		
		if(tyse == 'L'){
			$('.linkFormData').show();
			$('.linkTyHint').show();
			$('.grpTyHint').hide();
		}else if(tyse == 'D'){
			$('.linkFormData').hide();
			$('.linkTyHint').hide();
			$('.grpTyHint').show();
		}
	}
	
	function openImageStore(){   
		$.ajax({
	        type : 'POST'
			, url : sessionStorage.getItem('siteKey')+'/module/upload/image/imageForm.do?mode=100&id=icon_preview'
			, dataType : 'html'
			, success : function (data) {
				//$("#imgDiv").html(data);
				//$("#imgDiv").show();
				wzAjaxModal('popup_s w50', '<spring:message code="wzwg.cmm.word.imageStore"/>', data);
			}
			, error : function (request, status, error) {
				alert('error');
			}
		}); 
	}
	
	function addImgEditor(imgSrc,id){  
		
		 $('#icon_preview').attr('src', imgSrc); //미리보기 이미지
		 $('#menuImagePath').val(imgSrc); //이미지 스토어 경로저장
		 $('#icon_file').val(''); // 첨부파일 삭제
		 wzToast('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.image" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument></spring:message>');
		 
		
	}
</script>
<form id="quickLinkForm" name="quickLinkForm" method="post" enctype="multipart/form-data">
	<input type="hidden" name="qmenuetSeq" id="qmenuetSeq" value="<c:out value="${paramVO.qmenuetSeq }" />">
	<input type="hidden" name="menuImagePath" id="menuImagePath">

	<table class="basic">
		<colgroup>
			<col style="width: 35%;">
			<col style="width: *;">
		</colgroup>
		<tbody>
			<tr>
				<th><spring:message code="wzwg.cmm.word.ty"/></th>
				<td>
					<select id="qmenuTySe" name="qmenuTySe" onchange="typeSeChange()">
						<option value="L"><spring:message code="wzwg.cmm.word.link"/></option>
						<option value="D"><spring:message code="wzwg.module.word.segroupnm"/></option>
					</select>
				</td>
			</tr>
			
			<tr class="linkFormData">
				<th><spring:message code="wzwg.cmm.cntnts.selectsublink" /></th>
				<td>
					<div id="bannerLinkUrlDiv" title="<spring:message code="wzwg.cmm.cntnts.selectsublink" />" >
						<div class="linkSelect hdftrMenuList">
							<button type="button" class="btn-c linkSelectMenu" onclick="javascript:$('#linkMenuList1').toggle(300);"><spring:message code="wzwg.module.word.menulink" /></button>
							
								<ul class="linkMenuList" id="linkMenuList1" style="display: none;">
										   
									<c:forEach items="${menuList}" var="oneDepth" varStatus="status">
									<c:if test="${empty oneDepth.upperMenuSeq or oneDepth.upperMenuSeq eq '0' }">
										<li>
										 <c:choose>
										 	<c:when test="${oneDepth.menuDivision eq 'group' }">
										 		<a href="javascript:void(0);" data-href="menuLinkSeq" data-attr="menuNm">[<c:out value="${oneDepth.menuNm }" />]</a>
										 	</c:when>
										 	<c:when test="${oneDepth.menuDivision eq 'link'}">
										 		<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${oneDepth.menuLinkUrl}" />','<c:out value="${oneDepth.menuNm }" />' )" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${oneDepth.menuNm }" /></a>
										 	</c:when>
										 	<c:otherwise>
										 		<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${wzwg_contextPath}" />/subList/<c:out value="${oneDepth.menuLinkSeq}" />','<c:out value="${oneDepth.menuNm }" />' )" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${oneDepth.menuNm }" /></a>	
										 	</c:otherwise>
										 </c:choose>
											<ul>
											<c:forEach items="${menuList}" var="twoDepth" varStatus="status">
											<c:if test="${oneDepth.menuSeq eq twoDepth.upperMenuSeq}">
												<li>
													<c:choose>
													 	<c:when test="${twoDepth.menuDivision eq 'group' }">
													 		<a href="javascript:void(0);"  data-href="menuLinkSeq" data-attr="menuNm">[<c:out value="${twoDepth.menuNm }" />]</a>
													 	</c:when>
													 	<c:when test="${twoDepth.menuDivision eq 'link'}">
													 		<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${twoDepth.menuLinkUrl}" />','<c:out value="${twoDepth.menuNm }" />' )"  data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${twoDepth.menuNm }" /></a>
													 	</c:when>
													 	<c:otherwise>
													 		<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${wzwg_contextPath}" />/subList/<c:out value="${twoDepth.menuLinkSeq}" />','<c:out value="${twoDepth.menuNm }" />' )" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${twoDepth.menuNm }" /></a>	
													 	</c:otherwise>
													 </c:choose>
							                        
													<ul>
													<c:forEach items="${menuList}" var="threeDepth" varStatus="status">
													  <c:if test="${twoDepth.menuSeq eq threeDepth.upperMenuSeq}"> 
														<li>
														<c:choose>
														 	<c:when test="${threeDepth.menuDivision eq 'group' }">
														 		<a href="javascript:void(0);"  data-href="menuLinkSeq" data-attr="menuNm">[<c:out value="${threeDepth.menuNm }" />]</a>
														 	</c:when>
														 	<c:when test="${threeDepth.menuDivision eq 'link'}">
														 		<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${threeDepth.menuLinkUrl}" />','<c:out value="${threeDepth.menuNm }" />' )" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${threeDepth.menuNm }" /></a>
														 	</c:when>
														 	<c:otherwise>
														 		<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${wzwg_contextPath}" />/subList/<c:out value="${threeDepth.menuLinkSeq}" />','<c:out value="${threeDepth.menuNm }" />' )" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${threeDepth.menuNm }" /></a>	
														 	</c:otherwise>
														 </c:choose>
				
														</li>
													</c:if>
													</c:forEach>
													</ul>
												</li>
											</c:if>
											</c:forEach>	 
											</ul>  
										</li>   
										</c:if>
										</c:forEach>
										<li>
											<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${wzwg_contextPath}" />/cmm/mber/sbscrb/selectSbscrbCrtfc.do','<spring:message code="wzwg.cmm.word.signup" />' )" ><spring:message code="wzwg.cmm.word.signup" /></a>
										</li>
										<li>
											<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${wzwg_contextPath}" />/loginForm.do','<spring:message code="wzwg.cmm.word.login" />' )" ><spring:message code="wzwg.cmm.word.login" /></a>
										</li>
										<li>
											<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${wzwg_contextPath}" />/actionLogout.do','<spring:message code="wzwg.cmm.word.logout" />' )" ><spring:message code="wzwg.cmm.word.logout" /></a>
										</li>
										<li>
											<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${wzwg_contextPath}" />/searchIdForm.do','<spring:message code="wzwg.cmm.word.findi" />' )" ><spring:message code="wzwg.cmm.word.findi" /></a>
										</li>
										<li>
											<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${wzwg_contextPath}" />/searchPwForm.do','<spring:message code="wzwg.cmm.word.findp" />' )" ><spring:message code="wzwg.cmm.word.findp" /></a>
										</li>
										<li>
											<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${wzwg_contextPath}" />/sitemap.do','<spring:message code="wzwg.cmm.word.sitemap" />' )" ><spring:message code="wzwg.cmm.word.sitemap" /></a>
										</li>
										<li>
											<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${wzwg_contextPath}" />/cmm/mber/myPage/selectMyPageMain.do','<spring:message code="wzwg.cmm.word.youracct" />' )" ><spring:message code="wzwg.cmm.word.youracct" /></a>
										</li>
										<c:forEach items="${stplatList }" var="stplatList" varStatus="status">
										<li>
											<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${wzwg_contextPath}" />/module/stplatLog/selectStplatLogList.do?stplatSeq=<c:out value="${stplatList.stplatSeq }" />','<c:out value="${stplatList.stplatNm }" />' )" ><c:out value="${stplatList.stplatNm }" /></a>
										</li>
										</c:forEach>
									</ul>
						</div>
					</div>
				</td>
			</tr>
			<tr class="linkFormData">
				<th><spring:message code="wzwg.module.word.linkadres"/>
					<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
					</span>
				</th>
				<td>
					<input type="text" class="w100" id="qmenuLinkUrl" name="qmenuLinkUrl">
					<span class="wz_tableguide mt10">
						<span class="circle_no bg-green-strong">i</span> 
							<spring:message code="wzwg.cmm.msg.MSG346" /> 
					</span>
				</td>
			</tr>
			<tr class="linkFormData">
				<th><spring:message code="wzwg.module.word.menuadresty" /></th>
				<td>
					<ul class="wzForm">
						<li><label><input type="radio" name="qmenuTyCode" value="self" checked="checked"><span class="spanLabel"><spring:message code="wzwg.cmm.word.nowwin"/></span></label></li>
						<li><label class="ml5"><input type="radio" name="qmenuTyCode" value="new"><span class="spanLabel"><spring:message code="wzwg.cmm.word.newwin"/></span></label></li>
					</ul>
				</td>
			</tr>
			<tr>
				<th>
					<span class="linkTyHint"><spring:message code="wzwg.module.word.linksj"/>
						<span class="necessary">
								<span></span>
								<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</span>
					<span class="grpTyHint" style="display:none"><spring:message code="wzwg.module.word.segroupnm"/></span>
				</th>
				<td>
					<input type="text" class="w100" id="qmenuNm" name="qmenuNm">
					<span class="wz_tableguide mt10 grpTyHint" style="display:none">
						<span class="circle_no bg-green-strong">i</span> 
							<spring:message code="wzwg.cmm.msg.tip.MSG106" /> 
					</span>
				</td>
			</tr>
			<%-- <tr>
				<th><spring:message code="wzwg.cmm.word.link"/> <spring:message code="wzwg.cmm.word.dc"/></th>
				<td><input type="text" class="w100" id="qmenuDc" name="qmenuDc"></td>
			</tr> --%>
			<tr class="linkFormData">
				<th><spring:message code="wzwg.cmm.word.icon"/>
					<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
					</span>
				</th>
				<td>
					<button type="button" id="btn_addIcon" style="border:1px solid #ddd"><img src="/images/wzwg/site/mngr/no-img.png" id="icon_preview" onclick="$('#icon_file').click();" style="width: 80px;"></button>
					<input type="file" style="display:none;" id="icon_file" name="iconFile">
					<span class="wz_tableguide mt10">
						<span class="circle_no bg-green-strong">i</span> 
							<spring:message code="wzwg.cmm.msg.MSG383"><spring:argument>40</spring:argument></spring:message><br>
    					<!-- <strong class="mt5 fl">아이콘 등록 여부에 따라 선택한 퀵메뉴 스킨과 설정 후 모습이 다양하게 달라질 수 있으며, 각 스킨에 맞추어 리사이징되어 적용됩니다.</strong> -->
					</span>
					<div><button type="button" class="wzbtn btn-grey-bg mt10 fs16 fw600" onclick="openImageStore()"><spring:message code="wzwg.cmm.word.imageStore" /></button></div>
				</td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.cmm.word.exposure" /> <spring:message code="wzwg.cmm.word.at" /></th>
				<td>
					<ul class="wzForm">
						<li><label><input type="radio" name="menuSttusCode" checked="checked" value="Y"><span class="spanLabel"><spring:message code="wzwg.cmm.word.exposure" /></span></label></li>
						<li><label class="ml5"><input type="radio" name="menuSttusCode" value="N"><span class="spanLabel"><spring:message code="wzwg.cmm.word.unexposure" /></span></label></li>
					</ul>
				</td>
			</tr>
		</tbody>
	</table>

	<div class="rt-box">
		<button type="button" onclick="registQuickLinkAjax();" class="wzbtn btn-save bg"><spring:message code="wzwg.cmm.word.stre"/></button> 
			
	</div>

</form>