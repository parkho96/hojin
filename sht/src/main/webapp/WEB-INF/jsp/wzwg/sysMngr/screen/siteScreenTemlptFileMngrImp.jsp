<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 
<%
/***
 * 템플릿 리소스 파일들을 디자이너가 직접 관리해주게끔 만들기 위한 모듈
 * @since 2018.09.06
 * @auth 조원권
*/


	String webRoot = request.getServletContext().getRealPath("/");

	String templatePath = request.getParameter("templatePath");
	//System.out.println(webRoot + templatePath);
	String cssPath = "css";
	String imgPath = "img";




%>

<div id="templtFileMngr" style="">
<div class="pop-box">
 	<div class="layer3 main-design-edit-popup" id="modal-layout">	
		 <div class="popupzone_layer">
		 	<div class="pop-id-sch" id="modal-fileMngr-move-handler">
				<span><spring:message code="wzwg.sysMngr.word.layoutAdd02" /></span>
				<button class="close" type="button" onclick="fnLayerPopupClose();"><img src="/images/wzwg/site/mngr/pop-close.png" alt="<spring:message code="wzwg.cmm.word.close" />"></button>
			</div>
			<div class="pop-container">
				<div class="pop-conts">
		
					 <div id="add_layer">
				            <input id="add_layer_first" type="radio" name="add_layer_tab" checked="checked" />
				            <input id="add_layer_second" type="radio" name="add_layer_tab" />
				            <section class="buttons">
				                <label for="add_layer_first"><spring:message code="wzwg.cmm.word.layout" /></label>
				                <label for="add_layer_second"><spring:message code="wzwg.sysMngr.word.layoutIntrvlAndSe" /></label>
				            </section>
							
							<!-- 레이아웃 탭 -->
				            <div class="tab_item layout_select01">
				            	<p style="margin-top: 15px; width: 100%; text-align: left; color:#999;">※ <spring:message code="wzwg.cmm.msg.MSG249" /></p>
				            	<div class="layer_preview">
				            		<h4><spring:message code="wzwg.cmm.word.preview" />:<span> (<spring:message code="wzwg.cmm.msg.MSG250" />)</span></h4>
										
										<div id="layout_preview" style="padding-top: 20px; padding-bottom: 20px; float: left; width: 100%;"></div>
		
				            	</div>
		
		
		
							    <ul>
							        <li class="layer_1step">
							        	<a>
							        		<input id="layout01" type="radio" name="layout_select" onclick="fnPreviewLayout('sample_layout_01')">
							        		<label for="layout01">1<spring:message code="wzwg.cmm.word.step" /></label> <table class="table_preview" onclick="$('#layout01').click();"><tr><td>&nbsp;</td></tr></table>
							        	</a>
										
									</li>
							        <li class="layer_1step" style="visibility: hidden;">
							        	
										
									</li>
							 
							        <li class="layer_1step">
							            <a title="<spring:message code="wzwg.cmm.msg.screen.MSG087" />">
							            	<input id="layout02_1" type="radio" name="layout_select" onclick="fnPreviewLayout('sample_layout_02_padding', '2_1')"/>
							            	<label for="layout02_1">2<spring:message code="wzwg.cmm.word.step" /> (1:1)</label>
							            	<table class="table_preview" onclick="$('#layout02_1').click();"><tr><td>&nbsp;</td><td>&nbsp;</td></tr></table>
							            </a>
							            <ul class="hide">
							                <li>&#10004; <spring:message code="wzwg.cmm.msg.MSG311" /></li>
							                <li>&bull; <spring:message code="wzwg.cmm.msg.MSG312" />: 
							                	<input id="layout02_1_paddingO" type="radio" name="padding2_1" checked="checked" onclick="fnPreviewLayout('sample_layout_02_padding', '2_1')"/><label for="layout02_1_paddingO"><spring:message code="wzwg.cmm.word.be" /></label>
							                	<input id="layout02_1_paddingX" type="radio" name="padding2_1" onclick="fnPreviewLayout('sample_layout_02', '2_1')"><label for="layout02_1_paddingX"><spring:message code="wzwg.cmm.word.none" /></label>
							                </li>
							                <li>&bull; <spring:message code="wzwg.cmm.msg.MSG313" />: 
							                	<input id="layout02_1_high" type="radio" name="height2_1" onclick="fnPreviewLayoutEditVertical('H')" value="H"><label for="layout02_1_high" title="350px"><spring:message code="wzwg.cmm.word.high" /></label>
							                	<input id="layout02_1_middle" type="radio" name="height2_1" checked="checked" onclick="fnPreviewLayoutEditVertical('M')" value="M"><label for="layout02_1_middle" title="250px"><spring:message code="wzwg.cmm.word.middle" /></label>
							                	<input id="layout02_1_low" type="radio" name="height2_1" onclick="fnPreviewLayoutEditVertical('L')" value="L"><label for="layout02_1_low" title="150px"><spring:message code="wzwg.cmm.word.low" /></label>
							                </li>
							            </ul>
							        </li>
							        <li class="layer_1step">
							            <a title="<spring:message code="wzwg.cmm.msg.screen.MSG087" />">
							            	<input id="layout02_2" type="radio" name="layout_select" onclick="fnPreviewLayout('sample_layout_02_37_padding', '2_2')">
							            	<label for="layout02_2">2<spring:message code="wzwg.cmm.word.step" /> (1:2)</label>
							            	<table class="table_preview" onclick="$('#layout02_2').click();"><tr><td class="prev_td30">&nbsp;</td><td>&nbsp;</td></tr></table>
							            </a>
							            <ul class="hide">
							                <li>&#10004; <spring:message code="wzwg.cmm.msg.MSG311" /></li>
							                <li>&bull; <spring:message code="wzwg.cmm.msg.MSG312" />: 
							                	<input id="layout02_2_paddingO" type="radio" name="padding2_2" checked="checked" onclick="fnPreviewLayout('sample_layout_02_37_padding', '2_2')"><label for="layout02_2_paddingO"><spring:message code="wzwg.cmm.word.be" /></label>
							                	<input id="layout02_2_paddingX" type="radio" name="padding2_2" onclick="fnPreviewLayout('sample_layout_02_37', '2_2')"><label for="layout02_2_paddingX"><spring:message code="wzwg.cmm.word.none" /></label>
							                </li>
							                <li>&bull; <spring:message code="wzwg.cmm.msg.MSG313" />: 
							                	<input id="layout02_2_high" type="radio" name="height2_2" onclick="fnPreviewLayoutEditVertical('H')" value="H"><label for="layout02_2_high" title="350px"><spring:message code="wzwg.cmm.word.high" /></label>
							                	<input id="layout02_2_middle" type="radio" name="height2_2" checked="checked" onclick="fnPreviewLayoutEditVertical('M')" value="M"><label for="layout02_2_middle" title="250px"><spring:message code="wzwg.cmm.word.middle" /></label>
							                	<input id="layout02_2_low" type="radio" name="height2_2" onclick="fnPreviewLayoutEditVertical('L')" value="L"><label for="layout02_2_low" title="150px"><spring:message code="wzwg.cmm.word.low" /></label>
							                </li>
							            </ul>
							        </li>
		
							        <li class="layer_1step">
							            <a title="<spring:message code="wzwg.cmm.msg.screen.MSG087" />">
							            	<input id="layout03_1" type="radio" name="layout_select" onclick="fnPreviewLayout('sample_layout_03_padding', '3_1')">
							            	<label for="layout03_1">3<spring:message code="wzwg.cmm.word.step" /> (1:1:1)</label>
							            	<table class="table_preview table_preview37" onclick="$('#layout03_1').click();"><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></table>
							            </a>
							            <ul class="hide">
							                <li>&#10004; <spring:message code="wzwg.cmm.msg.MSG311" /></li>
							                <li>&bull; <spring:message code="wzwg.cmm.msg.MSG312" />: 
							                	<input id="layout03_1_paddingO" type="radio" name="padding3_1" checked="checked" onclick="fnPreviewLayout('sample_layout_03_padding', '3_1')"><label for="layout03_1_paddingO"><spring:message code="wzwg.cmm.word.be" /></label>
							                	<input id="layout03_1_paddingX" type="radio" name="padding3_1" onclick="fnPreviewLayout('sample_layout_03', '3_1')"><label for="layout03_1_paddingX"><spring:message code="wzwg.cmm.word.none" /></label>
							                </li>
							                <li>&bull; <spring:message code="wzwg.cmm.msg.MSG313" />: 
							                	<input id="layout03_1_high" type="radio" name="height3_1" onclick="fnPreviewLayoutEditVertical('H')" value="H"><label for="layout03_1_high" title="350px"><spring:message code="wzwg.cmm.word.high" /></label>
							                	<input id="layout03_1_middle" type="radio" name="height3_1" checked="checked" onclick="fnPreviewLayoutEditVertical('M')" value="M"><label for="layout03_1_middle" title="250px"><spring:message code="wzwg.cmm.word.middle" /></label>
							                	<input id="layout03_1_low" type="radio" name="height3_1" onclick="fnPreviewLayoutEditVertical('L')" value="L"><label for="layout03_1_low" title="150px"><spring:message code="wzwg.cmm.word.low" /></label>
							                </li>
							            </ul>
							        </li>
							        <li class="layer_1step">
							            <a title="<spring:message code="wzwg.cmm.msg.screen.MSG087" />">
							            	<input id="layout03_2" type="radio" name="layout_select" onclick="fnPreviewLayout('sample_layout_03_211_padding', '3_2')">
							            	<label for="layout03_2">3<spring:message code="wzwg.cmm.word.step" /> (2:1:1)</label>
							            	<table class="table_preview" onclick="$('#layout03_2').click();"><tr><td class="prev_td50">&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></table>
							            </a>
							            <ul class="hide">
							                <li>&#10004; <spring:message code="wzwg.cmm.msg.MSG311" /></li>
							                <li>&bull; <spring:message code="wzwg.cmm.msg.MSG312" />: 
							                	<input id="layout03_2_paddingO" type="radio" name="padding3_2" checked="checked" onclick="fnPreviewLayout('sample_layout_03_211_padding', '3_2')"><label for="layout03_2_paddingO"><spring:message code="wzwg.cmm.word.be" /></label>
							                	<input id="layout03_2_paddingX" type="radio" name="padding3_2" onclick="fnPreviewLayout('sample_layout_03_211', '3_2')"><label for="layout03_2_paddingX"><spring:message code="wzwg.cmm.word.none" /></label>
							                </li>
							                <li>&bull; <spring:message code="wzwg.cmm.msg.MSG313" />: 
							                	<input id="layout03_2_high" type="radio" name="height3_2" onclick="fnPreviewLayoutEditVertical('H')" value="H"><label for="layout03_2_high" title="350px"><spring:message code="wzwg.cmm.word.high" /></label>
							                	<input id="layout03_2_middle" type="radio" name="height3_2" checked="checked" onclick="fnPreviewLayoutEditVertical('M')" value="M"><label for="layout03_2_middle" title="250px"><spring:message code="wzwg.cmm.word.middle" /></label>
							                	<input id="layout03_2_low" type="radio" name="height3_2" onclick="fnPreviewLayoutEditVertical('L')" value="L"><label for="layout03_2_low" title="150px"><spring:message code="wzwg.cmm.word.low" /></label>
							                </li>
							            </ul>
							        </li>
		
							        <li class="layer_1step">
							            <a title="<spring:message code="wzwg.cmm.msg.screen.MSG087" />">
											<input id="layout04" type="radio" name="layout_select" onclick="fnPreviewLayout('sample_layout_04_padding', '4')">
								            <label for="layout04">4<spring:message code="wzwg.cmm.word.step" /></label>
											<table class="table_preview" onclick="$('#layout04').click();"><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></table>
										</a>
							            <ul class="hide">
							                <li>&#10004; <spring:message code="wzwg.cmm.msg.MSG311" /></li>
							                <li>&bull; <spring:message code="wzwg.cmm.msg.MSG312" />: 
							                	<input id="layout04_paddingO" type="radio" name="padding4" checked="checked" onclick="fnPreviewLayout('sample_layout_04_padding', '4')"><label for="layout04_paddingO"><spring:message code="wzwg.cmm.word.be" /></label>
							                	<input id="layout04_paddingX" type="radio" name="padding4" onclick="fnPreviewLayout('sample_layout_04', '4')"><label for="layout04_paddingX"><spring:message code="wzwg.cmm.word.none" /></label>
							                </li>
							                <li>&bull; <spring:message code="wzwg.cmm.msg.MSG313" />: 
							                	<input id="layout04_high" type="radio" name="height4" onclick="fnPreviewLayoutEditVertical('H')" value="H"><label for="layout04_high" title="350px"><spring:message code="wzwg.cmm.word.high" /></label>
							                	<input id="layout04_middle" type="radio" name="height4" checked="checked" onclick="fnPreviewLayoutEditVertical('M')" value="M"><label for="layout04_middle" title="250px"><spring:message code="wzwg.cmm.word.middle" /></label>
							                	<input id="layout04_low" type="radio" name="height4" onclick="fnPreviewLayoutEditVertical('L')" value="L"><label for="layout04_low" title="150px"><spring:message code="wzwg.cmm.word.low" /></label>
							                </li>
							            </ul>
							        </li>
							    </ul>
								
		
								<a href="javascript:void(0);" class="btn-a" onclick="fnAddTemplateToLayout()"><spring:message code="wzwg.cmm.word.add02" /></a>
								
				            </div>		
							
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
							<!-- 레이아웃 간격 및 구분 탭 -->
				            <div class="tab_item layout_select02">
								<ul class="empty_select">
									<h4><spring:message code="wzwg.cmm.word.blnkspce" /></h4>
									<li><span>- 10px</span> <div class="empty_prev empty_prev10"></div>
												<a href="javascript:void(0);" class="add_btn" onclick="fnAddTemplateToEmpty('sample_empty_10')"><spring:message code="wzwg.cmm.word.add02" /></a>
									</li>
									<li><span>- 20px</span> <div class="empty_prev empty_prev20"></div>
												<a href="javascript:void(0);" class="add_btn" onclick="fnAddTemplateToEmpty('sample_empty_20')"><spring:message code="wzwg.cmm.word.add02" /></a>
									</li>
									<li><span>- 30px (<spring:message code="wzwg.cmm.word.bass" />)</span> <div class="empty_prev empty_prev30"></div>
												<a href="javascript:void(0);" class="add_btn" onclick="fnAddTemplateToEmpty('sample_empty_30')"><spring:message code="wzwg.cmm.word.add02" /></a>
									</li>
									<li><span>- 50px</span> <div class="empty_prev empty_prev50"></div>
												<a href="javascript:void(0);" class="add_btn" onclick="fnAddTemplateToEmpty('sample_empty_50')"><spring:message code="wzwg.cmm.word.add02" /></a>
									</li>
								</ul>
								<ul class="line_select">
									<h4><spring:message code="wzwg.cmm.word.se" /> <spring:message code="wzwg.cmm.word.line03" /></h4>
									<li><div class="line_prev01"></div> <a href="javascript:void(0);" class="add_btn" onclick="fnAddTemplateToEmpty('smaple_line_prev01')"><spring:message code="wzwg.cmm.word.add02" /></a></li>
									<li><div class="line_prev02"></div> <a href="javascript:void(0);" class="add_btn" onclick="fnAddTemplateToEmpty('smaple_line_prev02')"><spring:message code="wzwg.cmm.word.add02" /></a></li>
									<li><div class="line_prev03"></div> <a href="javascript:void(0);" class="add_btn" onclick="fnAddTemplateToEmpty('smaple_line_prev03')"><spring:message code="wzwg.cmm.word.add02" /></a></li>
									<li><div class="line_prev04"></div> <a href="javascript:void(0);" class="add_btn" onclick="fnAddTemplateToEmpty('smaple_line_prev04')"><spring:message code="wzwg.cmm.word.add02" /></a></li>
								</ul>
		
		
		
		
		
				            </div>		
				     </div>
		
		
		
				</div>
			</div>
		
		 </div>
	</div>
 </div>