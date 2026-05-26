<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 
<script>  
$(document).ready(function()
		{
			$("#allCnt").html('<b>' + $("#totalCnt").val()+'</b><spring:message code="wzwg.cmm.word.count02" />');
			fn_search('1');
			
			$('#layout_all').click('on', function() {
				$('input[name=layoutSeCode]').val('');
				$('input[name=code]').val('');
				$('input[name=ctgryCode]').prop('checked', false);
				$('input[name=layoutCode]').prop('checked', false);
				$(this).addClass('on');
				fn_search(1);
			});
			
			$('input[name=ctgryCode]').click('on', function() {
				$('input[name=code]').val($(this).val());
				$('#layout_all').removeClass('on');
				fn_search(1);
			});
			
			$('input[name=layoutCode]').click('on', function() {
				$('input[name=layoutSeCode]').val($(this).val());
				$('#layout_all').removeClass('on');
				fn_search(1);
			});
		});
function fn_search(pageno){
	
	if(isNaN(pageno)){
		console.log('잘못된 페이지호출');
		return;
	}
	
	document.frmList.pageIndex.value=pageno;
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/screen/selectSiteScreenTempltListAjax.do'
		 , data:$("#frmList").serialize()
		 , success:function (data) {
			 	$("#templtListArea").html(data); 
			}
		 , dataType: 'html'
	});
}

function fn_detail(templateSeq, templateNm){
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/screen/selectSiteScreenTempltInfoAjax.do'
		 , data:{'templateSeq':templateSeq} 
		 , success:function (data) {
			 	//$("#divLayerPopup").html(data);
	    	  	//$("#divLayerPopup").show();
					 // 부모코드 셋팅 
					// fnGetMenuList();
					 
				//	 document.getElementById("menuNm").focus();
	    	  	wzAjaxModal('popup_l', templateNm, data); 
				   }
		 , dataType: 'html'
	});
}

function fnLayerPopupClose() {
    $("#divLayerPopup").hide();
    $("#divLayerPopup").empty();
    $('body').css({overflow:'auto'});
}

function fn_imgChange(imgUrl){
	$("#orgImg").attr("src",imgUrl);
}

function fn_imgChangePopup(imgUrl){
	$("#orgImgPopup").attr("src",imgUrl);
}

function fn_pannelToggle(){
	if($('#pannelTemplate').css('display') != 'none'){
		$('#pannelTemplate').slideUp( function(){
			$('#pannelTemplateSelect').slideDown();
			$('#pannelTemplateSelectTitle').addClass("on");
			$('#pannelTemplateTitle').removeClass("on");
		})
	}else{
		$('#pannelTemplateSelect').slideUp(function(){
			$('#pannelTemplate').slideDown();
			$('#pannelTemplateTitle').addClass("on");
			$('#pannelTemplateSelectTitle').removeClass("on");
		})
	}
}

function fn_mainTemplateMngr(templateSeq){
	document.frm.templateSeq.value=templateSeq;
	document.frm.action  ="<c:out value="${wzwg_contextPath}"/>/mngr/screen/selectSiteScreenTempIndexMngr.do";
	document.frm.method="post";
	document.frm.target="_blank";
	document.frm.submit();
}

function fn_siteTempTempltCallMain(templateSeq){
	if(confirm('<spring:message code="wzwg.cmm.msg.MSG279" />')){
	document.frm.templateSeq.value=templateSeq;
	document.frm.action  ="<c:out value="${wzwg_contextPath}"/>/mngr/screen/selectSiteScreenTempIndexMngr.do";
	document.frm.method="post";
	document.frm.target="_blank";
	document.frm.submit();
	}
}

function fnLoadTemplatInitCallMain(templateSeq){ 
	if(confirm('<spring:message code="wzwg.cmm.msg.MSG280" />')){
	document.frm.templateSeq.value=templateSeq;
	document.frm.action="<c:out value="${wzwg_contextPath}"/>/mngr/screen/selectSiteScreenTemplateInitMngr.do";
	document.frm.method="post";
	document.frm.target="_blank";
	document.frm.submit();
	}
}

function fnChangeTab(tabCls){
	//console.log(tabCls);
	$('.tapMenu li a').removeClass('on');
	
	$('#' + tabCls).addClass('on');
	
	$('.tab-pannel').hide();
	
	$('.' + tabCls).show();
	
}

</script>








	
		<div class="step wztab underLine theme-blue">
	    	<ul class="tapMenu wztab-list">
				<li class="wztab-item active">
					<a href="javascript:void(0);" title="<spring:message code="wzwg.cmm.msg.MSG407"/>" id="designAdm_now" name="bbsTab" class="on" onclick="fnChangeTab('designAdm_now')"><spring:message code="wzwg.cmm.msg.MSG407"/></a>
				</li>
				<li class="wztab-item">
					<a href="javascript:void(0);" title="<spring:message code="wzwg.cmm.msg.MSG408"/>" id="designAdm_tem" name="bbsTab" onclick="fnChangeTab('designAdm_tem')"><spring:message code="wzwg.cmm.msg.MSG408"/></a>
				</li>
	
			</ul>
		</div>
	
		<div class="designAdm_now tab-pannel">
			<form name="frm" id="frm" method="post"> 
				<input type="hidden"  name="templateSeq" id="templateSeq" />

			<c:if test="${ empty templtVO }">
			<table class="basic-table">
				<thead>
					<tr>
						<th><spring:message code="wzwg.cmm.msg.MSG099" /></th>
					</tr>
				</thead>
			</table>
			</c:if>
	
	 		<c:if test="${not empty templtVO }">
	 			<a href="javascript:void(0);" onclick="fn_mainTemplateMngr('<c:out value="${templtVO.templateSeq}"/>')" class="mainEditBtn">
	 				<img src="/images/wzwg/site/mngr/layout/dshbrdMIcon06.png" alt=""><spring:message code="wzwg.cmm.msg.MSG098" />
	 			</a>
	 			<p class="admpg-subp w100 fl mt20 mb80">
				    <span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.MSG0981" />
				    <span class="wz_tableguide mt5 pl15"><spring:message code="wzwg.cmm.msg.MSG0982" /></span>
				</p>
	 			
	 			<h3 class="wzAdmSTit wd100 fl"><spring:message code="wzwg.cmm.msg.MSG452" /></h3>
	 			<div class="wd100 box-border p15">
					<div class="thumImg wd30 fl box-border">
						<img src="/<c:out value="${templtVO.templateStreCours }"/>screenshot/thumb_<c:out value="${templtVO.thumbUrl}"/>" id="orgImgPopup">
					</div>
					<div class="nowtemInfoTbl wd70 wm100 fl box-border">
						<table class="basic-table">
							<colgroup>
								<col width="25%">
								<col width="75%">
							</colgroup>
							<tbody>
								<tr>
									<th class="txt-r"><spring:message code="wzwg.site.screen.msg.MSG131" /></th>
									<td class="txt-l"><c:out value="${templtVO.templateNm}"/></td>
								</tr>
								<!-- <tr>
									<th class="txt-r"><spring:message code="wzwg.cmm.word.rgsde" /></th>
									<td class="txt-l"><c:out value="${templtVO.frstRegistPnttm}"/></td>
								</tr> -->
								<tr>
									<th class="txt-r vert-t"><spring:message code="wzwg.site.screen.msg.MSG132" /></th>
									<td>
										<ul class="wd100">
											<li class="wd30 fl">
												<p class="linehgt150 mb10"><spring:message code="wzwg.site.screen.msg.MSG133" /></p>
												<div class="thumImg">
													<img src="/<c:out value="${templtVO.templateStreCours }"/>screenshot/thumb_<c:out value="${templtVO.thumbUrl}"/>"/>
													<div class="hoverLayer blck">
						    							<a class="hoverbtn_circle closeUp" href="javascript:void(0);" onclick="fn_imgChangePopup('/<c:out value="${templtVO.templateStreCours }"/>screenshot/thumb_<c:out value="${templtVO.thumbUrl}"/>')" title="<spring:message code="wzwg.site.screen.msg.MSG135" />"><spring:message code="wzwg.site.screen.msg.MSG135" /></a>
						    						</div>
						    					</div>
											</li>
											<li class="wd30 fl">
												<p class="linehgt150 mb10"><spring:message code="wzwg.site.screen.msg.MSG134" /></p>
												<div class="thumImg">
													<img src="/<c:out value="${templtVO.templateStreCours }"/>screenshot/thumb_<c:out value="${templtVO.thumbUrlSub1}"/>" />
													<div class="hoverLayer blck">
						    							<a class="hoverbtn_circle closeUp" href="javascript:void(0);" onclick="fn_imgChangePopup('/<c:out value="${templtVO.templateStreCours }"/>screenshot/thumb_<c:out value="${templtVO.thumbUrlSub1}"/>')" title="<spring:message code="wzwg.site.screen.msg.MSG135" />"><spring:message code="wzwg.site.screen.msg.MSG135" /></a>
						    						</div>
												</div>
											</li>
											<li class="wd30 fl mr0">
												<p class="linehgt150 mb10"><spring:message code="wzwg.site.screen.msg.MSG136" /></p>
												<div class="thumImg">
													<img src="/<c:out value="${templtVO.templateStreCours }"/>screenshot/thumb_<c:out value="${templtVO.thumbUrlSubMobile}"/>"/>
													<div class="hoverLayer blck">
						    							<a class="hoverbtn_circle closeUp" href="javascript:void(0);" onclick="fn_imgChangePopup('/<c:out value="${templtVO.templateStreCours }"/>screenshot/thumb_<c:out value="${templtVO.thumbUrlSubMobile}"/>')" title="<spring:message code="wzwg.site.screen.msg.MSG135" />"><spring:message code="wzwg.site.screen.msg.MSG135" /></a>
						    						</div>
												</div>
											</li>
										</ul>
									</td>
								</tr>
							</tbody>
						</table>	
					</div>
				</div>
			</c:if>
				
				
			</form>
		</div>
		
		
		
		
		
		
		<div class="designAdm_tem tab-pannel" style="display:none;">
			<form name="frmList" id="frmList" method="post">
			<input type="hidden"  name="layoutSeCode" />
			<input type="hidden"  name="code"/>
			<input type="hidden"  name="templateSeq" id="templateSeq" />
			<input type="hidden"  name="pageIndex" id="pageIndex" value="1" />
			<c:set var="layoutTotalCnt" value="0"/>
						
				<%-- <h3 class="wzAdmSTit wd100 fl"><span>01</span><spring:message code="wzwg.site.screen.msg.MSG137" /></h3>

				<ul class="temTypeSel wzForm wd100 fl txt-c">
					<li class="i-block txt-l">
						<input type="radio" name="layoutSeCode" id="layout_all" value="" onclick="fn_search(1)" checked="checked">
						<label for="layout_all">
							<div class="txtbox">
    							<p class="title"><spring:message code="wzwg.cmm.word.all" /></p>
    							<p class="no" id="allCnt"></p>
	    					</div>
<!-- 							<img src="/images/wzwg/site/mngr/layout/2020_layout_all.png" alt=""> -->
						</label>
					</li>
					<c:forEach items="${layoutList}" var="layout" varStatus="status">
					<c:set var="layoutTotalCnt" value="${layoutTotalCnt + layout.cnt}"/>
					<li class="i-block txt-l">
						<input type="radio" name="layoutSeCode" id="<c:out value="${layout.codeAbrvNm}"/>_<c:out value="${layout.code}"/>" value="<c:out value="${layout.code}"/>" onclick="fn_search(1)">
						<label for="<c:out value="${layout.codeAbrvNm}"/>_<c:out value="${layout.code}"/>">
							<div class="txtbox">
	    						<c:if test="${layout.codeAbrvNm eq 'layout1' }"><p class="title"><spring:message code="wzwg.site.screen.msg.MSG138" /></p><p class="no"><b><c:out value="${layout.cnt}"/></b><spring:message code="wzwg.cmm.word.count02" /></p></c:if>
	    						<c:if test="${layout.codeAbrvNm eq 'layout2' }"><p class="title"><spring:message code="wzwg.site.screen.msg.MSG139" /></p><p class="no"><b><c:out value="${layout.cnt}"/></b><spring:message code="wzwg.cmm.word.count02" /></p></c:if>
	    						<c:if test="${layout.codeAbrvNm eq 'layout3' }"><p class="title"><spring:message code="wzwg.site.screen.msg.MSG140" /></p><p class="no"><b><c:out value="${layout.cnt}"/></b><spring:message code="wzwg.cmm.word.count02" /></p></c:if>
	    						<c:if test="${layout.codeAbrvNm eq 'layout6' }"><p class="title"><spring:message code="wzwg.site.screen.msg.MSG141" /></p><p class="no"><b><c:out value="${layout.cnt}"/></b><spring:message code="wzwg.cmm.word.count02" /></p></c:if>
	    						
	    						<c:if test="${status.count == 1 }">A : <spring:message code="wzwg.cmm.word.gnrl" /> <c:out value="${layout.cnt}"/><spring:message code="wzwg.cmm.word.count02" /></c:if>
								<c:if test="${status.count == 2 }">B : <spring:message code="wzwg.site.screen.msg.MSG142" /> <c:out value="${layout.cnt}"/><spring:message code="wzwg.cmm.word.count02" /></c:if>
								<c:if test="${status.count == 3 }">C : <spring:message code="wzwg.cmm.word.wide" /> <c:out value="${layout.cnt}"/><spring:message code="wzwg.cmm.word.count02" /></c:if>
								<c:if test="${status.count == 4 }">D : <spring:message code="wzwg.cmm.word.cmpnd" /> <c:out value="${layout.cnt}"/><spring:message code="wzwg.cmm.word.count02" /></c:if></label>
	    					</div>
							<img src="/images/wzwg/site/mngr/layout/2020_<c:out value="${layout.codeAbrvNm}"/>.png" alt="">
						</label>
					</li>
					</c:forEach>
				</ul>
				<input type="hidden" id="totalCnt" value="<c:out value="${layoutTotalCnt}"/>">
				
				<h3 class="wzAdmSTit wd100 fl"><span>02</span> <spring:message code="wzwg.site.screen.msg.MSG143" /></h3> --%>

				<div class="admDesignSet">
				  <p class="admpg-subp w100 fl mt10 mb40">
				    <span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.MSG446" />
				    <span class="wz_tableguide mt5 pl20"><spring:message code="wzwg.cmm.msg.MSG447" /></span>
				  </p>
				  <div class="ctgryBox mb50">
				    <div class="mainTemCtgryWrap">
				      <ul>
				      	<li>
				      		<button id="layout_all" type="button" class="ctgryBtn ctgryBtnAll<c:if test="${empty paramVO.code and empty paramVO.layoutSeCode}"> on</c:if>"><spring:message code="wzwg.cmm.word.all" /></button>
				      	</li>
				      	<c:forEach items="${templateCtgryCode}" var="codeList">
				        <li>
						  <input type="radio" name="ctgryCode" id="<c:out value='${codeList.codeAbrvNm}'/>_<c:out value='${codeList.code}'/>" value="<c:out value='${codeList.code}'/>">
				          <label for="<c:out value="${codeList.codeAbrvNm}_${codeList.code}" />" class="ctgryBtn">#<c:out value="${codeList.codeNm}"/>
					          <c:if test="${fn:indexOf(codeList.codeAbrvNm, 'layout') > -1}">
					          	<div class="menu_help">
					              <span class="circle_no bg-grey blue fw600">?</span>
					              <div class="help_pop">
					              	<img src="/images/wzwg/site/mngr/layout/2020_<c:out value="${codeList.codeAbrvNm}" />.png" alt="" class="fl">
					                <c:if test="${codeList.codeAbrvNm eq 'layout1' }"><span><spring:message code="wzwg.cmm.msg.MSG448" /></span></c:if>
				    				<c:if test="${codeList.codeAbrvNm eq 'layout2' }"><span><spring:message code="wzwg.cmm.msg.MSG449" /></span></c:if>
				    				<c:if test="${codeList.codeAbrvNm eq 'layout3' }"><span><spring:message code="wzwg.cmm.msg.MSG450" /></span></c:if>
				    				<c:if test="${codeList.codeAbrvNm eq 'layout6' }"><span><spring:message code="wzwg.cmm.msg.MSG451" /></span></c:if>
					              </div>
					            </div>
					          </c:if>
				          </label>
				        </li>
				        </c:forEach>
				      </ul>
				  
				      <ul style="display: none;">
				      	<c:forEach items="${layoutList}" var="layout" varStatus="status">
				        <li>
				          <input type="radio" name="layoutCode" id="<c:out value="${layout.codeAbrvNm}_${layout.code}" />" value="<c:out value="${layout.code}" />">
				          <label for="<c:out value="${layout.codeAbrvNm}_${layout.code}" />" class="ctgryBtn">
				          	<c:if test="${layout.codeAbrvNm eq 'layout1' }">#<spring:message code="wzwg.site.screen.msg.MSG138" /></c:if>
		    				<c:if test="${layout.codeAbrvNm eq 'layout2' }">#<spring:message code="wzwg.site.screen.msg.MSG139" /></c:if>
		    				<c:if test="${layout.codeAbrvNm eq 'layout3' }">#<spring:message code="wzwg.site.screen.msg.MSG140" /></c:if>
		    				<c:if test="${layout.codeAbrvNm eq 'layout6' }">#<spring:message code="wzwg.site.screen.msg.MSG141" /></c:if>
				            <div class="menu_help">
				              <span class="circle_no bg-grey blue fw600">?</span>
				              <div class="help_pop">
				              	<img src="/images/wzwg/site/mngr/layout/2020_<c:out value="${layout.codeAbrvNm}" />.png" alt="" class="fl">
				                <c:if test="${layout.codeAbrvNm eq 'layout1' }"><span><spring:message code="wzwg.cmm.msg.MSG448" /></span></c:if>
			    				<c:if test="${layout.codeAbrvNm eq 'layout2' }"><span><spring:message code="wzwg.cmm.msg.MSG449" /></span></c:if>
			    				<c:if test="${layout.codeAbrvNm eq 'layout3' }"><span><spring:message code="wzwg.cmm.msg.MSG450" /></span></c:if>
			    				<c:if test="${layout.codeAbrvNm eq 'layout6' }"><span><spring:message code="wzwg.cmm.msg.MSG451" /></span></c:if>
				              </div>
				            </div>
				          </label>
				        </li>
				        </c:forEach>
				      </ul>
				    </div>
				  </div>
				</div>

				<div id="templtListArea">
				
				

				</div>

			</form>
		</div>



































<%-- 
<div class="designMngr">
	
	<div id="pannelTemplateTitle" class="template_act2 on">
		<h2><a href="javascript:void(0)" onclick="fn_pannelToggle()"><spring:message code="wzwg.cmm.msg.MSG105" /></a></h2>
	</div>
	<div id="pannelTemplate">
		<form name="frm" id="frm" method="post"> 
		<input type="hidden"  name="templateSeq" id="templateSeq" /> 
							<div class="template">
							<div class="pd20">
							<c:if test="${not empty templtVO }">
								<div class="tem-img">
										<div><img src="/<c:out value="${templtVO.templateStreCours }"/>screenshot/thumb_<c:out value="${templtVO.thumbUrl}"/>" id="orgImgPopup" width="400px" height="100%"/></div>
									</div>
									<div class="tem-list">
										<table class="tem-table01">
											<colgroup>
												<col width="25%">
												<col width="75%">
											</colgroup>
												<tr>
													<th><spring:message code="wzwg.site.screen.msg.MSG131" /></th>
													<td><c:out value="${templtVO.templateNm}"/></td>
												</tr>
												<tr>
													<th><spring:message code="wzwg.cmm.word.rgsde" /></th>
													<td><c:out value="${templtVO.frstRegistPnttm}"/></td>
												</tr>
												<tr>
													<th><p><spring:message code="wzwg.site.screen.msg.MSG144" /></p></th>
													<td>
														
														<ul>
															<li>
																<p><spring:message code="wzwg.site.screen.msg.MSG133" /></p>
																<img src="/<c:out value="${templtVO.templateStreCours }"/>screenshot/thumb_<c:out value="${templtVO.thumbUrl}"/>" onclick="fn_imgChangePopup('/<c:out value="${templtVO.templateStreCours }"/>screenshot/thumb_<c:out value="${templtVO.thumbUrl}"/>')" style="cursor:pointer;"/>
															</li>
															<li>
																<p><spring:message code="wzwg.site.screen.msg.MSG134" /></p>
																<img src="/<c:out value="${templtVO.templateStreCours }"/>screenshot/thumb_<c:out value="${templtVO.thumbUrlSub1}"/>"  onclick="fn_imgChangePopup('/<c:out value="${templtVO.templateStreCours }"/>screenshot/thumb_<c:out value="${templtVO.thumbUrlSub1}"/>')" style="cursor:pointer;"/>
															</li>
															<li style="max-height: 260px; overflow: hidden;">
																<p><spring:message code="wzwg.site.screen.msg.MSG136" /></p>
																<img src="/<c:out value="${templtVO.templateStreCours }"/>screenshot/thumb_<c:out value="${templtVO.thumbUrlSubMobile}"/>"  onclick="fn_imgChangePopup('/<c:out value="${templtVO.templateStreCours }"/>screenshot/thumb_<c:out value="${templtVO.thumbUrlSubMobile}"/>')" style="cursor:pointer; height: unset;"/>
															</li>
														</ul>
													</td>
												</tr>
										</table>
										
										
										
									</div>
										<div class="lt-box template_act">
												<a href="javascript:void(0);" onclick="fn_mainTemplateMngr('<c:out value="${templtVO.templateSeq}"/>')" class="wzbtn wzbtn-block btn-save"><spring:message code="wzwg.site.screen.msg.MSG145" /></a>
												<div><spring:message code="wzwg.cmm.msg.MSG098" /></div>
										</div>
										
									</c:if>
									<c:if test="${ empty templtVO }">
								<h4><spring:message code="wzwg.cmm.msg.MSG099" /></h4>
								 	<script>
								 	fn_pannelToggle();
								 	</script>
									</c:if>
								</div>
							</div>
						
							 
		</form>
	</div>
	
	<div id="pannelTemplateSelectTitle" class="lt-box template_act2">
			<a href="javascript:;"  class="btn-a" onclick="fn_pannelToggle()"><spring:message code="wzwg.site.screen.msg.MSG146" /></a>
			<div><spring:message code="wzwg.cmm.msg.MSG100" /></div>
	</div>
	
	<div id="pannelTemplateSelect" <c:if test="${not empty templtVO }">style="display: none;"</c:if>>
		<form name="frmList" id="frmList" method="post">
		<input type="hidden"  name="templateSeq" id="templateSeq" />
		<input type="hidden"  name="pageIndex" id="pageIndex" value="0" />
			
			<div class="ctr-box tem-list01">
				
				<h4><span>01</span> <spring:message code="wzwg.site.screen.msg.MSG137" /></h4>
				<ul>
				<c:forEach items="${layoutList}" var="layout" varStatus="status">
					<li>
						<img src="/images/wzwg/site/mngr/layout/<c:out value="${layout.codeAbrvNm}"/>.jpg" alt="" />
						<span><label><input type="radio" name="layoutSeCode" id="layoutSeCode" value="<c:out value="${layout.code}"/>" onclick="fn_search(1)" <c:if test="${status.count == 1 }">checked="checked"</c:if>>
							<c:if test="${status.count == 1 }">A : <spring:message code="wzwg.cmm.word.gnrl" /> <c:out value="${layout.cnt}"/><spring:message code="wzwg.cmm.word.count02" /></c:if>
							<c:if test="${status.count == 2 }">B : <spring:message code="wzwg.site.screen.msg.MSG142" /> <c:out value="${layout.cnt}"/><spring:message code="wzwg.cmm.word.count02" /></c:if>
							<c:if test="${status.count == 3 }">C : <spring:message code="wzwg.cmm.word.wide" /> <c:out value="${layout.cnt}"/><spring:message code="wzwg.cmm.word.count02" /></c:if>
							<c:if test="${status.count == 4 }">D : <spring:message code="wzwg.cmm.word.cmpnd" /> <c:out value="${layout.cnt}"/><spring:message code="wzwg.cmm.word.count02" /></c:if></label>
						</span>
					</li> 
				</c:forEach>
				</ul>
			</div>
		<div id="templtListDiv">
		
		</div>
		</form>
		<!-- 레이어팝업 영역 Start -->
		<!-- <div id="divLayerPopup" class="pop-box"></div> -->
		<!-- 레이어팝업 영역 End -->
	</div>
</div> --%>