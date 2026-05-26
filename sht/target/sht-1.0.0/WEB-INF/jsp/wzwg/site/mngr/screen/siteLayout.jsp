<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 

 <link rel="stylesheet" href="/css/wzwg/cmm/layout.css" type="text/css" />
 <link rel="stylesheet" href="/css/wzwg/cmm/empty_line.css" type="text/css" />
 <link rel="stylesheet" href="/css/wzwg/site/mngr/popupzone.css" type="text/css" />
 

				<script>
				    function fnPreviewLayout(id, cod){
				    	
				    	$('#layout_preview').html($('#' + id).html());
				    	
				    	if(cod){
					    	var height = $('input[name="height' + cod + '"]:checked').val();
					    	fnPreviewLayoutEditVertical(height);
				    	}else {
				    		
				    	}
				    	
				    	if(id.indexOf('padding') > -1){
				    		$('#layou0'+cod+'_bdr_between').parent().css('display', 'none');
				    		if($('#layou0'+cod+'_bdr_between').is(':checked')){
				    			$('#layou0'+cod+'_bdr_none').prop('checked', true);
				    		}
				    	}else {
				    		$('#layou0'+cod+'_bdr_between').parent().css('display', '');
				    	}
				    	
				    }
				    
				    function fnPreviewLayoutEditVertical(hmode){
				    	$('#layout_preview .div_wrap').children().each(function(){
				    		  $(this).removeClass('layout_height_M');  
				    		  $(this).removeClass('layout_height_L');  
				    		  $(this).removeClass('layout_height_H');
				    		  $(this).removeClass('layout_height_A'); 
				    		  
				    		  $(this).addClass('layout_height_' + hmode);  
				    		  $(this).attr('data-h', hmode);  
				    	})
				    }
				    

				    function fnAddTemplateToLayout(){
				    	var layout = $('#layout_preview').clone(); 
				    	layout.find('.layout_wrap').attr('id', 'thisNewLayout');
				    	
				    	//var clickAction = $('#sample_contents_action').html();
						//console.log(clickAction);
						//console.log($(layout).find('.div_wrap'));
						
						/* $(layout).find('.div_wrap').children().each(function(){
							$(this).html(clickAction);  
						}) */
						
						if(!selectLayer){
					    	$(".addContentZone").append(layout.html());
							$('#layout_preview').html('');
							
							var emptyLine = $('#sample_empty_30').html(); 
					    	$(".addContentZone").append(emptyLine);
						}else{
							$(selectLayer).after(layout.html());
							selectLayer = null;
						}
				    	
						selectDiv = $('#thisNewLayout');
				    	var efCom = '';
				    	if(selectDiv.hasClass('FXarea_Fade')){
				    		efCom = 'FXarea_Fade';
				    	}
				    	if(selectDiv.hasClass('FXarea_slideUp')){
				    		efCom = 'FXarea_slideUp';
				    	}
				    	if(selectDiv.hasClass('FXarea_slideNfade')){
				    		efCom = 'FXarea_slideNfade';
				    	}
				    	//console.log(efCom);
				    	layoutEffecClear();
				    	addLayoutEffect(efCom);
				    	selectDiv.removeAttr('id');
				    	
				    	
				    	editInit();
				    	alert(wz_msg('<spring:message code="wzwg.site.screen.msg.MSG192"/>'));
				    	wzModalClose();
				    	
				    }
				    
				    function fnAddTemplateToEmpty(id){
				    	//fnAddTemplateToLayout(false);
				    	
				    	var layout = $('#' + id).html(); 
				    	
				    	if(!selectLayer){
					    	$(".addContentZone").append(layout);
							$('#layout_preview').html('');
							
						}else{
							$(selectLayer).after(layout);
							selectLayer = null;
						}
				    	
				    	editInit();
				    	alert(wz_msg('<spring:message code="wzwg.site.screen.msg.MSG192"/>'));
				    	//fnLayerPopupClose();
				    	wzModalClose();
				    }
				    
				    function fnAddEffect(ef){
				    	var layout = $('#layout_preview .layout_wrap');
				    	layout.removeClass('FXarea_Fade');
				    	layout.removeClass('FXarea_slideUp');
				    	layout.removeClass('FXarea_slideNfade');
				    	
				    	if(ef != undefined && ef != ''){
				    		layout.addClass(ef);
				    		
				    		if(ef == 'FXarea_Fade'){
				    			setTimeout(function(ef){
				    				layout.addClass('animate-fade');
				    			}, 1000);
				    		}
				    		
				    		if(ef == 'FXarea_slideUp'){
				    			setTimeout(function(ef){
				    				layout.addClass('animate-slideUp');
				    			}, 1000);
				    		}
				    		
				    		if(ef == 'FXarea_slideNfade'){
				    			setTimeout(function(ef){
				    				layout.addClass('animate-slideNfade');
				    			}, 1000);
				    		}
				    	}
				    }
				    
				    function fnAddBoard(el){
				    	var layout = $('#layout_preview .div_wrap');
				    	layout.removeClass('border-radius');
				    	layout.removeClass('borderbox');
				    	layout.removeClass('between_border');
				    	
			    		var noneEl = $(el).parents('ul.wzForm02').find('input[type=checkbox]').eq(0);
				    	if($(el).val() != undefined && $(el).val() != ''){
				    		$(noneEl).prop('checked', false);
				    		$(el).parents('ul.wzForm02').find('input[type=checkbox]:checked').each(function(idx, ele) {
				    			layout.addClass($(ele).val());
				    		});
				    	}else {
				    		$(el).parents('ul.wzForm02').find('input[type=checkbox]').prop('checked', false);
				    		$(noneEl).prop('checked', true);
				    	}
				    }
				    
				    
				    function fnPreviewRefresh(com){
				    	//console.log('fnPreviewRefresh command : ' + com );
				    	if(com == '1'){
					    	$('input[name="layout_1"]:checked').click();
					    	$('input[name="layout1_ef"]:checked').click();
					    	$('input[name="layout1_bdr"]:checked').each(function(idx, ele) {
					    		$('#layout_preview .div_wrap').addClass($(ele).val());
				    		});
				    	}else{
				    		$('input[name="height' + com + '"]:checked').click();
					    	$('input[name="padding' + com + '"]:checked').click();
					    	$('input[name="layout' + com + '_ef"]:checked').click();
					    	$('input[name="layout'+com+'_bdr"]:checked').each(function(idx, ele) {
					    		$('#layout_preview .div_wrap').addClass($(ele).val());
				    		});
				    	}
				    }
				</script>



				<div class="pop-tab mngEditPOPUP layoutPOPUP">

					<input id="add_lyot" type="radio" name="tab" checked="checked">
		            <input id="add_empty" type="radio" name="tab">
		            <input id="add_line" type="radio" name="tab">
		            <section class="buttons ">
		                <label for="add_lyot"><span></span><spring:message code="wzwg.cmm.word.layout" /></label>
		                <label for="add_empty"><span></span><spring:message code="wzwg.cmm.word.intrvl" /></label>
		                <label for="add_line"><span></span><spring:message code="wzwg.cmm.word.scrin.dividLine" /></label>
		            </section>
					
					
		            <!-- Layout tab -->
		            <div class="tab_item p0">
		            	<p class="tab_tit"><spring:message code="wzwg.cmm.word.layout" /></p>

		            	<div class="prvBox lyotprv">
		            		<p class="prv_notice"><span class="circle_no bg-blue-strong2 vert-m">i</span>
		            			<spring:message code="wzwg.cmm.msg.MSG250" />
		            		</p>
			            	<div id="layout_preview">
			            		
								<div class="layout_wrap wzwgContextMenu layout_wrap_border">
									<div class="div_wrap layout_block1">
										<div class="layout_01 layout_contents_border" data-w="100" data-h="M">
										</div>
									</div>
								</div>

			            	</div>
						</div>

		            	<ul class="lyotSelect">
		            		<li class="layer_1step">
		            			<input id="layout01" type="radio" name="layout_select" onclick="fnPreviewRefresh('1')" checked="checked">
					        	<label for="layout01">1<spring:message code="wzwg.cmm.word.step" /></label>
						        <div class="OptionBox">
						        	<p class="optiontit"><spring:message code="wzwg.site.screen.msg.MSG004" /></p>
						        	<ul class="wzForm02">
						        		<li class="wd40">
				        					<input id="layout01_1_nomal" type="radio" name="layout_1" checked="checked" onclick="fnPreviewLayout('sample_layout_01')">
				        					<label for="layout01_1_nomal"><spring:message code="wzwg.cmm.word.bass" /> (<spring:message code="wzwg.site.screen.msg.MSG005" />)</label>
				        				</li>
				        				<li class="wd40">
				        					<input id="layout02_1_wide" type="radio" name="layout_1" onclick="fnPreviewLayout('sample_layout_01_full')">
				        					<label for="layout02_1_wide"><spring:message code="wzwg.cmm.word.extend" /> (<spring:message code="wzwg.site.screen.msg.MSG006" /> 100%)</label>
				        				</li>
						        	</ul>
						        	
						        	<p class="optiontit"><spring:message code="wzwg.site.screen.msg.MSG007" /></p>
				        			<ul class="wzForm02">
										<li class="wd25 wm50">
				        					<input id="layou01_ef_none" type="radio" name="layout1_ef" checked="checked" onclick="fnAddEffect('')">
				        					<label for="layou01_ef_none"><spring:message code="wzwg.cmm.word.none" /></label>
			                	
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou01_ef_fade" type="radio" name="layout1_ef" onclick="fnAddEffect('FXarea_Fade')">
				        					<label for="layou01_ef_fade"><spring:message code="wzwg.cmm.word.wa.fade" /><br>(<spring:message code="wzwg.cmm.word.scrin.gradualAppea" />)</label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou01_ef_slide" type="radio" name="layout1_ef" onclick="fnAddEffect('FXarea_slideUp')">
				        					<label for="layou01_ef_slide"><spring:message code="wzwg.cmm.word.wa.slide" /><br>(<spring:message code="wzwg.cmm.word.scrin.gradualUp" />)</label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou01_ef_slideNfade" type="radio" name="layout1_ef" onclick="fnAddEffect('FXarea_slideNfade')">
				        					<label for="layou01_ef_slideNfade"><spring:message code="wzwg.cmm.word.wa.fade" />+<spring:message code="wzwg.cmm.word.wa.slide" /></label>
				        				</li>
				        			</ul>

									<p class="optiontit"><spring:message code="wzwg.site.screen.msg.MSG008" /></p>
				        			<ul class="wzForm02">
										<li class="wd25 wm50">
				        					<input id="layou01_bdr_none" type="checkbox" name="layout1_bdr" checked="checked" onclick="fnAddBoard(this)" value="">
				        					<label for="layou01_bdr_none"><spring:message code="wzwg.cmm.word.none" /></label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou01_bdr_radius" type="checkbox" name="layout1_bdr" onclick="fnAddBoard(this)" value="border-radius">
				        					<label for="layou01_bdr_radius"><spring:message code="wzwg.cmm.word.scrin.roundBorr" /></label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou01_bdr_box" type="checkbox" name="layout1_bdr" onclick="fnAddBoard(this)" value="borderbox">
				        					<label for="layou01_bdr_box"><spring:message code="wzwg.cmm.word.scrin.lineBorr" /></label>
				        				</li>
				        			</ul>
				        			
						        	<div class="btnbox-r">
										<a href="javascript:void(0);" class="wzbtn bg-blue-strong2 white br0" onclick="fnAddTemplateToLayout()"><spring:message code="wzwg.cmm.word.add02" /></a>
									</div>
						        </div>
					        </li>

					        <li class="layer_1step">
					        	<input id="layout02_1" type="radio" name="layout_select" onclick="fnPreviewRefresh('2_1')">
					            <label for="layout02_1">2<spring:message code="wzwg.cmm.word.step" />(1:1)</label>
						        <div class="OptionBox">
						        	<p class="optiontit"><spring:message code="wzwg.site.screen.msg.MSG009" /></p>
						        	<ul class="wzForm02">
						        		<li>
				        					<input id="layout02_1_high" type="radio" name="height2_1" onclick="fnPreviewLayoutEditVertical('H')" value="H">
				        					<label for="layout02_1_high" title="350px"><spring:message code="wzwg.cmm.word.high" /> (350px)</label>
				        				</li>
				        				<li>
				        					<input id="layout02_1_middle" type="radio" name="height2_1" checked="checked" onclick="fnPreviewLayoutEditVertical('M')" value="M">
				        					<label for="layout02_1_middle" title="250px"><spring:message code="wzwg.cmm.word.middle" /> (250px)</label>
				        				</li>
				        				<li>
				        					<input id="layout02_1_low" type="radio" name="height2_1" onclick="fnPreviewLayoutEditVertical('L')" value="L">
				        					<label for="layout02_1_low" title="150px"><spring:message code="wzwg.cmm.word.low" /> (150px)</label>
				        				</li>
				        				<li style="display: none;">
				        					<input id="layout02_1_auto" type="radio" name="height2_1" onclick="fnPreviewLayoutEditVertical('A')" value="A">
				        					<label for="layout02_1_auto" title="auto"><spring:message code="wzwg.cmm.word.noRestr" /></label>
				        				</li>
				        			</ul>

						        	<p class="optiontit"><spring:message code="wzwg.cmm.word.scrin.leftRightCntnts" /></p>
				        			<ul class="wzForm02">
										<li class="wd25 wm50">
				        					<input id="layout02_1_paddingO" type="radio" name="padding2_1" checked="checked" onclick="fnPreviewLayout('sample_layout_02_padding', '2_1')">
				        					<label for="layout02_1_paddingO">1%</label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layout02_1_paddingO_2" type="radio" name="padding2_1" onclick="fnPreviewLayout('sample_layout_02_padding_2', '2_1')">
				        					<label for="layout02_1_paddingO_2">2%</label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layout02_1_paddingO_3" type="radio" name="padding2_1" onclick="fnPreviewLayout('sample_layout_02_padding_3', '2_1')">
				        					<label for="layout02_1_paddingO_3">3%</label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layout02_1_paddingO_4" type="radio" name="padding2_1" onclick="fnPreviewLayout('sample_layout_02_padding_4', '2_1')">
				        					<label for="layout02_1_paddingO_4">4%</label>
				        				</li>
				        				<li class="wd100 clboth mt10">
				        					<input id="layout02_1_paddingX" type="radio" name="padding2_1" onclick="fnPreviewLayout('sample_layout_02', '2_1')">
				        					<label for="layout02_1_paddingX"><spring:message code="wzwg.cmm.word.none" /></label>
				        				</li>
				        			</ul>
				        			
				        			<p class="optiontit"><spring:message code="wzwg.site.screen.msg.MSG007" /></p>
				        			<ul class="wzForm02">
										<li class="wd25 wm50">
				        					<input id="layou02_1_ef_none" type="radio" name="layout2_1_ef" checked="checked" onclick="fnAddEffect('')">
				        					<label for="layou02_1_ef_none"><spring:message code="wzwg.cmm.word.none" /></label>
			                	
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou02_1_ef_fade" type="radio" name="layout2_1_ef" onclick="fnAddEffect('FXarea_Fade')">
				        					<label for="layou02_1_ef_fade"><spring:message code="wzwg.cmm.word.wa.fade" /><br>(<spring:message code="wzwg.cmm.word.scrin.gradualAppea" />)</label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou02_1_ef_slide" type="radio" name="layout2_1_ef" onclick="fnAddEffect('FXarea_slideUp')">
				        					<label for="layou02_1_ef_slide"><spring:message code="wzwg.cmm.word.wa.slide" /><br>(<spring:message code="wzwg.cmm.word.scrin.gradualUp" />)</label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou02_1_ef_slideNfade" type="radio" name="layout2_1_ef" onclick="fnAddEffect('FXarea_slideNfade')">
				        					<label for="layou02_1_ef_slideNfade"><spring:message code="wzwg.cmm.word.wa.fade" />+<spring:message code="wzwg.cmm.word.wa.slide" /></label>
				        				</li>
				        			</ul>
				        			
				        			<p class="optiontit"><spring:message code="wzwg.site.screen.msg.MSG008" /></p>
				        			<ul class="wzForm02">
										<li class="wd25 wm50">
				        					<input id="layou02_1_bdr_none" type="checkbox" name="layout2_1_bdr" checked="checked" onclick="fnAddBoard(this)" value="">
				        					<label for="layou02_1_bdr_none"><spring:message code="wzwg.cmm.word.none" /></label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou02_1_bdr_radius" type="checkbox" name="layout2_1_bdr" onclick="fnAddBoard(this)" value="border-radius">
				        					<label for="layou02_1_bdr_radius"><spring:message code="wzwg.cmm.word.scrin.roundBorr" /></label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou02_1_bdr_box" type="checkbox" name="layout2_1_bdr" onclick="fnAddBoard(this)" value="borderbox">
				        					<label for="layou02_1_bdr_box"><spring:message code="wzwg.cmm.word.scrin.lineBorr" /></label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou02_1_bdr_between" type="checkbox" name="layout2_1_bdr" onclick="fnAddBoard(this)" value="between_border">
				        					<label for="layou02_1_bdr_between"><spring:message code="wzwg.cmm.word.scrin.withLineBorr" /></label>
				        				</li>
				        			</ul>
				        			
				        			<div class="btnbox-r">
										<a href="javascript:void(0);" class="wzbtn bg-blue-strong2 white br0" onclick="fnAddTemplateToLayout()"><spring:message code="wzwg.cmm.word.add02" /></a>
									</div>
						        </div>
					        </li>

					        <li class="layer_1step">
					        	<input id="layout02_2" type="radio" name="layout_select" onclick="fnPreviewRefresh('2_2')">
					            <label for="layout02_2">2<spring:message code="wzwg.cmm.word.step" />(1:2)</label>
					            <div class="OptionBox">
						        	<p class="optiontit"><spring:message code="wzwg.site.screen.msg.MSG009" /></p>
						        	<ul class="wzForm02">
						        		<li>
				        					<input id="layout02_2_high" type="radio" name="height2_2" onclick="fnPreviewLayoutEditVertical('H')" value="H">
				        					<label for="layout02_2_high" title="350px"><spring:message code="wzwg.cmm.word.high" /> (350px)</label>
				        				</li>
				        				<li>
				        					<input id="layout02_2_middle" type="radio" name="height2_2" checked="checked" onclick="fnPreviewLayoutEditVertical('M')" value="M">
				        					<label for="layout02_2_middle" title="250px"><spring:message code="wzwg.cmm.word.middle" /> (250px)</label>
				        				</li>
				        				<li>
				        					<input id="layout02_2_low" type="radio" name="height2_2" onclick="fnPreviewLayoutEditVertical('L')" value="L">
				        					<label for="layout02_2_low" title="150px"><spring:message code="wzwg.cmm.word.low" /> (150px)</label>
				        				</li>
				        				<li style="display: none;">
				        					<input id="layout02_2_auto" type="radio" name="height2_2" onclick="fnPreviewLayoutEditVertical('A')" value="A">
				        					<label for="layout02_2_auto" title="auto"><spring:message code="wzwg.cmm.word.noRestr" /></label>
				        				</li>
				        			</ul>

						        	<p class="optiontit"><spring:message code="wzwg.cmm.word.scrin.leftRightCntnts" /></p>
				        			<ul class="wzForm02">
										<li class="wd25 wm50">
											<input id="layout02_2_paddingO" type="radio" name="padding2_2" checked="checked" onclick="fnPreviewLayout('sample_layout_02_37_padding', '2_2')">
											<label for="layout02_2_paddingO">1%</label>
				        				</li>
				        				<li class="wd25 wm50">
											<input id="layout02_2_paddingO_2" type="radio" name="padding2_2" onclick="fnPreviewLayout('sample_layout_02_37_padding_2', '2_2')">
											<label for="layout02_2_paddingO_2">2%</label>
				        				</li>
				        				<li class="wd25 wm50">
											<input id="layout02_2_paddingO_3" type="radio" name="padding2_2" onclick="fnPreviewLayout('sample_layout_02_37_padding_3', '2_2')">
											<label for="layout02_2_paddingO_3">3%</label>
				        				</li>
				        				<li class="wd25 wm50">
											<input id="layout02_2_paddingO_4" type="radio" name="padding2_2" onclick="fnPreviewLayout('sample_layout_02_37_padding_4', '2_2')">
											<label for="layout02_2_paddingO_4">4%</label>
				        				</li>
				        				<li class="wd100 clboth mt10">
				        					<input id="layout02_2_paddingX" type="radio" name="padding2_2" onclick="fnPreviewLayout('sample_layout_02_37', '2_2')">
				        					<label for="layout02_2_paddingX"><spring:message code="wzwg.cmm.word.none" /></label>
				        				</li>
				        			</ul>
				        			
				        			<p class="optiontit"><spring:message code="wzwg.site.screen.msg.MSG007" /></p>
				        			<ul class="wzForm02">
										<li class="wd25 wm50">
				        					<input id="layou02_2_ef_none" type="radio" name="layout2_2_ef" checked="checked" onclick="fnAddEffect('')">
				        					<label for="layou02_2_ef_none"><spring:message code="wzwg.cmm.word.none" /></label>
			                	
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou02_2_ef_fade" type="radio" name="layout2_2_ef" onclick="fnAddEffect('FXarea_Fade')">
				        					<label for="layou02_2_ef_fade"><spring:message code="wzwg.cmm.word.wa.fade" /><br>(<spring:message code="wzwg.cmm.word.scrin.gradualAppea" />)</label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou02_2_ef_slide" type="radio" name="layout2_2_ef" onclick="fnAddEffect('FXarea_slideUp')">
				        					<label for="layou02_2_ef_slide"><spring:message code="wzwg.cmm.word.wa.slide" /><br>(<spring:message code="wzwg.cmm.word.scrin.gradualUp" />)</label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou02_2_ef_slideNfade" type="radio" name="layout2_2_ef" onclick="fnAddEffect('FXarea_slideNfade')">
				        					<label for="layou02_2_ef_slideNfade"><spring:message code="wzwg.cmm.word.wa.fade" />+<spring:message code="wzwg.cmm.word.wa.slide" /></label>
				        				</li>
				        			</ul>
				        			
				        			<p class="optiontit"><spring:message code="wzwg.site.screen.msg.MSG008" /></p>
				        			<ul class="wzForm02">
										<li class="wd25 wm50">
				        					<input id="layou02_2_bdr_none" type="checkbox" name="layout2_2_bdr" checked="checked" onclick="fnAddBoard(this)" value="">
				        					<label for="layou02_2_bdr_none"><spring:message code="wzwg.cmm.word.none" /></label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou02_2_bdr_radius" type="checkbox" name="layout2_2_bdr" onclick="fnAddBoard(this)" value="border-radius">
				        					<label for="layou02_2_bdr_radius"><spring:message code="wzwg.cmm.word.scrin.roundBorr" /></label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou02_2_bdr_box" type="checkbox" name="layout2_2_bdr" onclick="fnAddBoard(this)" value="borderbox">
				        					<label for="layou02_2_bdr_box"><spring:message code="wzwg.cmm.word.scrin.lineBorr" /></label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou02_2_bdr_between" type="checkbox" name="layout2_2_bdr" onclick="fnAddBoard(this)" value="between_border">
				        					<label for="layou02_2_bdr_between"><spring:message code="wzwg.cmm.word.scrin.withLineBorr" /></label>
				        				</li>
				        			</ul>
				        			
				        			<div class="btnbox-r">
										<a href="javascript:void(0);" class="wzbtn bg-blue-strong2 white br0" onclick="fnAddTemplateToLayout()"><spring:message code="wzwg.cmm.word.add02" /></a>
									</div>
						        </div>
					        </li>

					        <li class="layer_1step">
						        <input id="layout03_1" type="radio" name="layout_select" onclick="fnPreviewRefresh('3_1')">
						        <label for="layout03_1">3<spring:message code="wzwg.cmm.word.step" /> (1:1:1)</label>
						        <div class="OptionBox">
						        	<p class="optiontit"><spring:message code="wzwg.site.screen.msg.MSG009" /></p>
						        	<ul class="wzForm02">
						        		<li>
				        					<input id="layout03_1_high" type="radio" name="height3_1" onclick="fnPreviewLayoutEditVertical('H')" value="H">
				        					<label for="layout03_1_high" title="350px"><spring:message code="wzwg.cmm.word.high" /> (350px)</label>
				        				</li>
				        				<li>
				        					<input id="layout03_1_middle" type="radio" name="height3_1" checked="checked" onclick="fnPreviewLayoutEditVertical('M')" value="M">
				        					<label for="layout03_1_middle" title="250px"><spring:message code="wzwg.cmm.word.middle" /> (250px)</label>
				        				</li>
				        				<li>
				        					<input id="layout03_1_low" type="radio" name="height3_1" onclick="fnPreviewLayoutEditVertical('L')" value="L">
				        					<label for="layout03_1_low" title="150px"><spring:message code="wzwg.cmm.word.low" /> (150px)</label>
				        				</li>
				        				<li style="display: none;">
				        					<input id="layout03_1_auto" type="radio" name="height3_1" onclick="fnPreviewLayoutEditVertical('A')" value="A">
				        					<label for="layout03_1_auto" title="auto"><spring:message code="wzwg.cmm.word.noRestr" /></label>
				        				</li>
				        			</ul>

						        	<p class="optiontit"><spring:message code="wzwg.cmm.word.scrin.leftRightCntnts" /></p>
				        			<ul class="wzForm02">
										<li class="wd25 wm50">
											<input id="layout03_1_paddingO" type="radio" name="padding3_1" checked="checked" onclick="fnPreviewLayout('sample_layout_03_padding', '3_1')">
											<label for="layout03_1_paddingO">1%</label>
				        				</li>
				        				<li class="wd25 wm50">
											<input id="layout03_1_paddingO_2" type="radio" name="padding3_1" onclick="fnPreviewLayout('sample_layout_03_padding_2', '3_1')">
											<label for="layout03_1_paddingO_2">2%</label>
				        				</li>
				        				<li class="wd25 wm50">
											<input id="layout03_1_paddingO_3" type="radio" name="padding3_1" onclick="fnPreviewLayout('sample_layout_03_padding_3', '3_1')">
											<label for="layout03_1_paddingO_3">3%</label>
				        				</li>
				        				<li class="wd25 wm50">
											<input id="layout03_1_paddingO_4" type="radio" name="padding3_1" onclick="fnPreviewLayout('sample_layout_03_padding_4', '3_1')">
											<label for="layout03_1_paddingO_4">4%</label>
				        				</li>
				        				<li class="wd100 clboth mt10">
				        					<input id="layout03_1_paddingX" type="radio" name="padding3_1" onclick="fnPreviewLayout('sample_layout_03', '3_1')">
				        					<label for="layout03_1_paddingX"><spring:message code="wzwg.cmm.word.none" /></label>
				        				</li>
				        			</ul>
				        			
				        			<p class="optiontit"><spring:message code="wzwg.site.screen.msg.MSG007" /></p>
				        			<ul class="wzForm02">
										<li class="wd25 wm50">
				        					<input id="layou03_1_ef_none" type="radio" name="layout3_1_ef" checked="checked" onclick="fnAddEffect('')">
				        					<label for="layou03_1_ef_none"><spring:message code="wzwg.cmm.word.none" /></label>
			                	
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou03_1_ef_fade" type="radio" name="layout3_1_ef" onclick="fnAddEffect('FXarea_Fade')">
				        					<label for="layou03_1_ef_fade"><spring:message code="wzwg.cmm.word.wa.fade" /><br>(<spring:message code="wzwg.cmm.word.scrin.gradualAppea" />)</label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou03_1_ef_slide" type="radio" name="layout3_1_ef" onclick="fnAddEffect('FXarea_slideUp')">
				        					<label for="layou03_1_ef_slide"><spring:message code="wzwg.cmm.word.wa.slide" /><br>(<spring:message code="wzwg.cmm.word.scrin.gradualUp" />)</label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou03_1_ef_slideNfade" type="radio" name="layout3_1_ef" onclick="fnAddEffect('FXarea_slideNfade')">
				        					<label for="layou03_1_ef_slideNfade"><spring:message code="wzwg.cmm.word.wa.fade" />+<spring:message code="wzwg.cmm.word.wa.slide" /></label>
				        				</li>
				        			</ul>
				        			
				        			<p class="optiontit"><spring:message code="wzwg.site.screen.msg.MSG008" /></p>
				        			<ul class="wzForm02">
										<li class="wd25 wm50">
				        					<input id="layou03_1_bdr_none" type="checkbox" name="layout3_1_bdr" checked="checked" onclick="fnAddBoard(this)" value="">
				        					<label for="layou03_1_bdr_none"><spring:message code="wzwg.cmm.word.none" /></label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou03_1_bdr_radius" type="checkbox" name="layout3_1_bdr" onclick="fnAddBoard(this)" value="border-radius">
				        					<label for="layou03_1_bdr_radius"><spring:message code="wzwg.cmm.word.scrin.roundBorr" /></label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou03_1_bdr_box" type="checkbox" name="layout3_1_bdr" onclick="fnAddBoard(this)" value="borderbox">
				        					<label for="layou03_1_bdr_box"><spring:message code="wzwg.cmm.word.scrin.lineBorr" /></label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou03_1_bdr_between" type="checkbox" name="layout3_1_bdr" onclick="fnAddBoard(this)" value="between_border">
				        					<label for="layou03_1_bdr_between"><spring:message code="wzwg.cmm.word.scrin.withLineBorr" /></label>
				        				</li>
				        			</ul>
				        			
				        			<div class="btnbox-r">
										<a href="javascript:void(0);" class="wzbtn bg-blue-strong2 white br0" onclick="fnAddTemplateToLayout()"><spring:message code="wzwg.cmm.word.add02" /></a>
									</div>
						        </div>
					        </li>

					        <li class="layer_1step">
						       	<input id="layout03_2" type="radio" name="layout_select" onclick="fnPreviewRefresh('3_2')">
						        <label for="layout03_2">3<spring:message code="wzwg.cmm.word.step" /> (2:1:1)</label>

						        <div class="OptionBox">
						        	<p class="optiontit"><spring:message code="wzwg.site.screen.msg.MSG009" /></p>
						        	<ul class="wzForm02">
						        		<li>
				        					<input id="layout03_2_high" type="radio" name="height3_2" onclick="fnPreviewLayoutEditVertical('H')" value="H">
				        					<label for="layout03_2_high" title="350px"><spring:message code="wzwg.cmm.word.high" /> (350px)</label>
				        				</li>
				        				<li>
				        					<input id="layout03_2_middle" type="radio" name="height3_2" checked="checked" onclick="fnPreviewLayoutEditVertical('M')" value="M">
				        					<label for="layout03_2_middle" title="250px"><spring:message code="wzwg.cmm.word.middle" /> (250px)</label>
				        				</li>
				        				<li>
				        					<input id="layout03_2_low" type="radio" name="height3_2" onclick="fnPreviewLayoutEditVertical('L')" value="L">
				        					<label for="layout03_2_low" title="150px"><spring:message code="wzwg.cmm.word.low" /> (150px)</label>
				        				</li>
				        				<li style="display: none;">
				        					<input id="layout03_2_auto" type="radio" name="height3_2" onclick="fnPreviewLayoutEditVertical('A')" value="A">
				        					<label for="layout03_2_auto" title="auto"><spring:message code="wzwg.cmm.word.noRestr" /></label>
				        				</li>
				        			</ul>

						        	<p class="optiontit"><spring:message code="wzwg.cmm.word.scrin.leftRightCntnts" /></p>
				        			<ul class="wzForm02">
										<li class="wd25 wm50">
											<input id="layout03_2_paddingO" type="radio" name="padding3_2" checked="checked" onclick="fnPreviewLayout('sample_layout_03_211_padding', '3_2')">
											<label for="layout03_2_paddingO">1%</label>
				        				</li>
				        				<li class="wd25 wm50">
											<input id="layout03_2_paddingO_2" type="radio" name="padding3_2" onclick="fnPreviewLayout('sample_layout_03_211_padding_2', '3_2')">
											<label for="layout03_2_paddingO_2">2%</label>
				        				</li>
				        				<li class="wd25 wm50">
											<input id="layout03_2_paddingO_3" type="radio" name="padding3_2" onclick="fnPreviewLayout('sample_layout_03_211_padding_3', '3_2')">
											<label for="layout03_2_paddingO_3">3%</label>
				        				</li>
				        				<li class="wd25 wm50">
											<input id="layout03_2_paddingO_4" type="radio" name="padding3_2" onclick="fnPreviewLayout('sample_layout_03_211_padding_4', '3_2')">
											<label for="layout03_2_paddingO_4">4%</label>
				        				</li>
				        				<li class="wd100 clboth mt10">
				        					<input id="layout03_2_paddingX" type="radio" name="padding3_2" onclick="fnPreviewLayout('sample_layout_03_211', '3_2')">
				        					<label for="layout03_2_paddingX"><spring:message code="wzwg.cmm.word.none" /></label>
				        				</li>
				        			</ul>
				        			
				        			<p class="optiontit"><spring:message code="wzwg.site.screen.msg.MSG007" /></p>
				        			<ul class="wzForm02">
										<li class="wd25 wm50">
				        					<input id="layou03_2_ef_none" type="radio" name="layout3_2_ef" checked="checked" onclick="fnAddEffect('')">
				        					<label for="layou03_2_ef_none"><spring:message code="wzwg.cmm.word.none" /></label>
			                	
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou03_2_ef_fade" type="radio" name="layout3_2_ef" onclick="fnAddEffect('FXarea_Fade')">
				        					<label for="layou03_2_ef_fade"><spring:message code="wzwg.cmm.word.wa.fade" /><br>(<spring:message code="wzwg.cmm.word.scrin.gradualAppea" />)</label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou03_2_ef_slide" type="radio" name="layout3_2_ef" onclick="fnAddEffect('FXarea_slideUp')">
				        					<label for="layou03_2_ef_slide"><spring:message code="wzwg.cmm.word.wa.slide" /><br>(<spring:message code="wzwg.cmm.word.scrin.gradualUp" />)</label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou03_2_ef_slideNfade" type="radio" name="layout3_2_ef" onclick="fnAddEffect('FXarea_slideNfade')">
				        					<label for="layou03_2_ef_slideNfade"><spring:message code="wzwg.cmm.word.wa.fade" />+<spring:message code="wzwg.cmm.word.wa.slide" /></label>
				        				</li>
				        			</ul>
				        			
				        			<p class="optiontit"><spring:message code="wzwg.site.screen.msg.MSG008" /></p>
				        			<ul class="wzForm02">
										<li class="wd25 wm50">
				        					<input id="layou03_2_bdr_none" type="checkbox" name="layout3_2_bdr" checked="checked" onclick="fnAddBoard(this)" value="">
				        					<label for="layou03_2_bdr_none"><spring:message code="wzwg.cmm.word.none" /></label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou03_2_bdr_radius" type="checkbox" name="layout3_2_bdr" onclick="fnAddBoard(this)" value="border-radius">
				        					<label for="layou03_2_bdr_radius"><spring:message code="wzwg.cmm.word.scrin.roundBorr" /></label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou03_2_bdr_box" type="checkbox" name="layout3_2_bdr" onclick="fnAddBoard(this)" value="borderbox">
				        					<label for="layou03_2_bdr_box"><spring:message code="wzwg.cmm.word.scrin.lineBorr" /></label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou03_2_bdr_between" type="checkbox" name="layout3_2_bdr" onclick="fnAddBoard(this)" value="between_border">
				        					<label for="layou03_2_bdr_between"><spring:message code="wzwg.cmm.word.scrin.withLineBorr" /></label>
				        				</li>
				        			</ul>
				        			
				        			<div class="btnbox-r">
										<a href="javascript:void(0);" class="wzbtn bg-blue-strong2 white br0" onclick="fnAddTemplateToLayout()"><spring:message code="wzwg.cmm.word.add02" /></a>
									</div>
						        </div>
					        </li>


					        <li class="layer_1step">
					        	<input id="layout04" type="radio" name="layout_select" onclick="fnPreviewRefresh('4')">
						        <label for="layout04">4<spring:message code="wzwg.cmm.word.step" /></label>

						        <div class="OptionBox">
						        	<p class="optiontit"><spring:message code="wzwg.site.screen.msg.MSG009" /></p>
						        	<ul class="wzForm02">
						        		<li>
				        					<input id="layout04_high" type="radio" name="height4" onclick="fnPreviewLayoutEditVertical('H')" value="H">
				        					<label for="layout04_high" title="350px"><spring:message code="wzwg.cmm.word.high" /> (350px)</label>
				        				</li>
				        				<li>
				        					<input id="layout04_middle" type="radio" name="height4" checked="checked" onclick="fnPreviewLayoutEditVertical('M')" value="M">
				        					<label for="layout04_middle" title="250px"><spring:message code="wzwg.cmm.word.middle" /> (250px)</label>
				        				</li>
				        				<li>
				        					<input id="layout04_low" type="radio" name="height4" onclick="fnPreviewLayoutEditVertical('L')" value="L">
				        					<label for="layout04_low" title="150px"><spring:message code="wzwg.cmm.word.low" /> (150px)</label>
				        				</li>
				        				<li style="display: none;">
				        					<input id="layout04_auto" type="radio" name="height4" onclick="fnPreviewLayoutEditVertical('A')" value="A">
				        					<label for="layout04_auto" title="auto"><spring:message code="wzwg.cmm.word.noRestr" /></label>
				        				</li>
				        			</ul>

						        	<p class="optiontit"><spring:message code="wzwg.cmm.word.scrin.leftRightCntnts" /></p>
				        			<ul class="wzForm02">
										<li class="wd25 wm50">
											<input id="layout04_paddingO" type="radio" name="padding4" checked="checked" onclick="fnPreviewLayout('sample_layout_04_padding', '4')">
											<label for="layout04_paddingO">1%</label>
				        				</li>
				        				<li class="wd25 wm50">
											<input id="layout04_paddingO_2" type="radio" name="padding4" onclick="fnPreviewLayout('sample_layout_04_padding_2', '4')">
											<label for="layout04_paddingO_2">2%</label>
				        				</li>
				        				<li class="wd25 wm50">
											<input id="layout04_paddingO_3" type="radio" name="padding4" onclick="fnPreviewLayout('sample_layout_04_padding_3', '4')">
											<label for="layout04_paddingO_3">3%</label>
				        				</li>
				        				<li class="wd25 wm50">
											<input id="layout04_paddingO_4" type="radio" name="padding4" onclick="fnPreviewLayout('sample_layout_04_padding_4', '4')">
											<label for="layout04_paddingO_4">4%</label>
				        				</li>
				        				<li class="wd100 clboth mt10">
				        					<input id="layout04_paddingX" type="radio" name="padding4" onclick="fnPreviewLayout('sample_layout_04', '4')">
				        					<label for="layout04_paddingX"><spring:message code="wzwg.cmm.word.none" /></label>
				        				</li>
				        			</ul>
				        			
				        			<p class="optiontit"><spring:message code="wzwg.site.screen.msg.MSG007" /></p>
				        			<ul class="wzForm02">
										<li class="wd25 wm50">
				        					<input id="layou04_ef_none" type="radio" name="layout4_ef" checked="checked" onclick="fnAddEffect('')">
				        					<label for="layou04_ef_none"><spring:message code="wzwg.cmm.word.none" /></label>
			                	
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou04_ef_fade" type="radio" name="layout4_ef" onclick="fnAddEffect('FXarea_Fade')">
				        					<label for="layou04_ef_fade"><spring:message code="wzwg.cmm.word.wa.fade" /><br>(<spring:message code="wzwg.cmm.word.scrin.gradualAppea" />)</label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou04_ef_slide" type="radio" name="layout4_ef" onclick="fnAddEffect('FXarea_slideUp')">
				        					<label for="layou04_ef_slide"><spring:message code="wzwg.cmm.word.wa.slide" /><br>(<spring:message code="wzwg.cmm.word.scrin.gradualUp" />)</label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou04_ef_slideNfade" type="radio" name="layout4_ef" onclick="fnAddEffect('FXarea_slideNfade')">
				        					<label for="layou04_ef_slideNfade"><spring:message code="wzwg.cmm.word.wa.fade" />+<spring:message code="wzwg.cmm.word.wa.slide" /></label>
				        				</li>
				        			</ul>
				        			
				        			<p class="optiontit"><spring:message code="wzwg.site.screen.msg.MSG008" /></p>
				        			<ul class="wzForm02">
										<li class="wd25 wm50">
				        					<input id="layou04_bdr_none" type="checkbox" name="layout4_bdr" checked="checked" onclick="fnAddBoard(this)" value="">
				        					<label for="layou03_1_bdr_none"><spring:message code="wzwg.cmm.word.none" /></label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou04_bdr_radius" type="checkbox" name="layout4_bdr" onclick="fnAddBoard(this)" value="border-radius">
				        					<label for="layou04_bdr_radius"><spring:message code="wzwg.cmm.word.scrin.roundBorr" /></label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou04_bdr_box" type="checkbox" name="layout4_bdr" onclick="fnAddBoard(this)" value="borderbox">
				        					<label for="layou04_bdr_box"><spring:message code="wzwg.cmm.word.scrin.lineBorr" /></label>
				        				</li>
				        				<li class="wd25 wm50">
				        					<input id="layou04_bdr_between" type="checkbox" name="layout4_bdr" onclick="fnAddBoard(this)" value="between_border">
				        					<label for="layou04_bdr_between"><spring:message code="wzwg.cmm.word.scrin.withLineBorr" /></label>
				        				</li>
				        			</ul>
				        			
				        			<div class="btnbox-r">
										<a href="javascript:void(0);" class="wzbtn bg-blue-strong2 white br0" onclick="fnAddTemplateToLayout()"><spring:message code="wzwg.cmm.word.add02" /></a>
									</div>
						        </div>
					        </li>
		            	</ul>

		            	

		            </div>		
		            












		            <!-- empty tab -->
		            <div class="tab_item">
		            	<p class="tab_tit"><spring:message code="wzwg.cmm.word.intrvl" /></p>

		            	<div class="pop-tab tab_2Dpth">
		            		<input id="empty10" type="radio" name="empty">
		            		<input id="empty20" type="radio" name="empty">
		            		<input id="empty30" type="radio" name="empty" checked="checked">
		            		<input id="empty50" type="radio" name="empty">
		            		<input id="empty80" type="radio" name="empty">
		            		<input id="empty100" type="radio" name="empty">
		            		<section class="buttons ">
				                <label for="empty10">10px</label>
				                <label for="empty20">20px</label>
				                <label for="empty30">30px</label>
				                <label for="empty50">50px (<spring:message code="wzwg.cmm.word.scrin.reactType" />)
				                	<div class="menu_help">
										<span class="circle_no bg-blue-strong2 vert-m">?</span>
										<div class="help_pop">
											<spring:message code="wzwg.cmm.msg.screen.MSG057" />
										</div>
									</div>
				                </label>
				                <label for="empty80">80px (<spring:message code="wzwg.cmm.word.scrin.reactType" />)
				                	<div class="menu_help">
										<span class="circle_no bg-blue-strong2 vert-m">?</span>
										<div class="help_pop">
											<spring:message code="wzwg.cmm.msg.screen.MSG058" />
										</div>
									</div>
				                </label>
				                <label for="empty100">100px (<spring:message code="wzwg.cmm.word.scrin.reactType" />)
				                	<div class="menu_help">
										<span class="circle_no bg-blue-strong2 vert-m">?</span>
										<div class="help_pop">
											<spring:message code="wzwg.cmm.msg.screen.MSG059" />
										</div>
									</div>
				                </label>
				            </section>



				            <div class="tab_item">
				            	<p class="tab_tit">10px</p>

				            	<div class="prvBox">
				            		<p class="prv_notice"><span class="circle_no bg-blue-strong2 vert-m">i</span>
				            			<spring:message code="wzwg.cmm.msg.screen.MSG055" />
				            		</p>
					            	<div id="empty_preview">
					            		<div class="conBox wd100 txt-c"><spring:message code="wzwg.cmm.word.cntnts" /></div>
					            		<div class="emptyBox wd100 txt-c">
									 		<div class="empty empty_10 layout_line_border">
									 			<spring:message code="wzwg.cmm.msg.screen.MSG056" /> 10px
									 		</div>
									 	</div>
									 	<div class="conBox wd100 txt-c"><spring:message code="wzwg.cmm.word.cntnts" /></div>
					            	</div>
								</div>

								<div class="btnbox-r">
									<a href="javascript:void(0);" class="wzbtn bg-blue-strong2 white br0" onclick="fnAddTemplateToEmpty('sample_empty_10')"><spring:message code="wzwg.cmm.word.add02" /></a>
								</div>
				            </div>


				            <div class="tab_item">
				            	<p class="tab_tit">20px</p>

				            	<div class="prvBox">
				            		<p class="prv_notice"><span class="circle_no bg-blue-strong2 vert-m">i</span>
				            			<spring:message code="wzwg.cmm.msg.screen.MSG055" />
				            		</p>
					            	<div id="empty_preview">
					            		<div class="conBox wd100 txt-c"><spring:message code="wzwg.cmm.word.cntnts" /></div>
					            		<div class="emptyBox wd100 txt-c">
									 		<div class="empty empty_20 layout_line_border">
									 			<spring:message code="wzwg.cmm.msg.screen.MSG056" /> 20px
									 		</div>
									 	</div>
									 	<div class="conBox wd100 txt-c"><spring:message code="wzwg.cmm.word.cntnts" /></div>
					            	</div>
								</div>

								<div class="btnbox-r">
									<a href="javascript:void(0);" class="wzbtn bg-blue-strong2 white br0" onclick="fnAddTemplateToEmpty('sample_empty_20')"><spring:message code="wzwg.cmm.word.add02" /></a>
								</div>
				            </div>


				            <div class="tab_item">
				            	<p class="tab_tit">30px</p>

				            	<div class="prvBox">
				            		<p class="prv_notice"><span class="circle_no bg-blue-strong2 vert-m">i</span>
				            			<spring:message code="wzwg.cmm.msg.screen.MSG055" />
				            		</p>
					            	<div id="empty_preview">
					            		<div class="conBox wd100 txt-c"><spring:message code="wzwg.cmm.word.cntnts" /></div>
					            		<div class="emptyBox wd100 txt-c">
									 		<div class="empty empty_30 layout_line_border">
									 			<spring:message code="wzwg.cmm.msg.screen.MSG056" /> 30px
									 		</div>
									 	</div>
									 	<div class="conBox wd100 txt-c"><spring:message code="wzwg.cmm.word.cntnts" /></div>
					            	</div>
								</div>

								<div class="btnbox-r">
									<a href="javascript:void(0);" class="wzbtn bg-blue-strong2 white br0" onclick="fnAddTemplateToEmpty('sample_empty_30')"><spring:message code="wzwg.cmm.word.add02" /></a>
								</div>
				            </div>


				            <div class="tab_item">
				            	<p class="tab_tit">50px</p>

				            	<div class="prvBox">
				            		<p class="prv_notice"><span class="circle_no bg-blue-strong2 vert-m">i</span>
				            			<spring:message code="wzwg.cmm.msg.screen.MSG055" />
				            		</p>
					            	<div id="empty_preview">
					            		<div class="conBox wd100 txt-c"><spring:message code="wzwg.cmm.word.cntnts" /></div>
					            		<div class="emptyBox wd100 txt-c">
									 		<div class="empty empty_50 layout_line_border">
									 			<spring:message code="wzwg.cmm.msg.screen.MSG056" /> 50px (<spring:message code="wzwg.cmm.word.scrin.reactType" />)
									 		</div>
									 	</div>
									 	<div class="conBox wd100 txt-c"><spring:message code="wzwg.cmm.word.cntnts" /></div>
					            	</div>
								</div>

								<div class="btnbox-r">
									<a href="javascript:void(0);" class="wzbtn bg-blue-strong2 white br0" onclick="fnAddTemplateToEmpty('sample_empty_50')"><spring:message code="wzwg.cmm.word.add02" /></a>
								</div>
				            </div>


				            <div class="tab_item">
				            	<p class="tab_tit">80px (<spring:message code="wzwg.cmm.word.scrin.reactType" />)</p>

				            	<div class="prvBox">
				            		<p class="prv_notice"><span class="circle_no bg-blue-strong2 vert-m">i</span>
				            			<spring:message code="wzwg.cmm.msg.screen.MSG055" />
				            		</p>
					            	<div id="empty_preview">
					            		<div class="conBox wd100 txt-c"><spring:message code="wzwg.cmm.word.cntnts" /></div>
					            		<div class="emptyBox wd100 txt-c">
									 		<div class="empty empty_80 layout_line_border">
									 			<spring:message code="wzwg.cmm.msg.screen.MSG056" /> 80px (<spring:message code="wzwg.cmm.word.scrin.reactType" />)
									 		</div>
									 	</div>
									 	<div class="conBox wd100 txt-c"><spring:message code="wzwg.cmm.word.cntnts" /></div>
					            	</div>
								</div>

								<div class="btnbox-r">
									<a href="javascript:void(0);" class="wzbtn bg-blue-strong2 white br0" onclick="fnAddTemplateToEmpty('sample_empty_80')"><spring:message code="wzwg.cmm.word.add02" /></a>
								</div>
				            </div>


				            <div class="tab_item">
				            	<p class="tab_tit">100px (<spring:message code="wzwg.cmm.word.scrin.reactType" />)</p>

				            	<div class="prvBox">
				            		<p class="prv_notice"><span class="circle_no bg-blue-strong2 vert-m">i</span>
				            			<spring:message code="wzwg.cmm.msg.screen.MSG055" />
				            		</p>
					            	<div id="empty_preview">
					            		<div class="conBox wd100 txt-c"><spring:message code="wzwg.cmm.word.cntnts" /></div>
					            		<div class="emptyBox wd100 txt-c">
									 		<div class="empty empty_100 layout_line_border">
									 			<spring:message code="wzwg.cmm.msg.screen.MSG056" /> 100px (<spring:message code="wzwg.cmm.word.scrin.reactType" />)
									 		</div>
									 	</div>
									 	<div class="conBox wd100 txt-c"><spring:message code="wzwg.cmm.word.cntnts" /></div>
					            	</div>
								</div>

								<div class="btnbox-r">
									<a href="javascript:void(0);" class="wzbtn bg-blue-strong2 white br0" onclick="fnAddTemplateToEmpty('sample_empty_100')"><spring:message code="wzwg.cmm.word.add02" /></a>
								</div>
				            </div>

		            	</div> <!-- tab_2Dpth END -->
		            </div>	




		            







		            <!-- Line tab -->
		            <div class="tab_item">
		            	<p class="tab_tit"><spring:message code="wzwg.cmm.word.scrin.dividLine" /></p>

		            	<ul id="line_prev">
		            		<li><div class="line_prev01"></div> <a href="javascript:void(0);" class="wzbtn bg-blue-strong2 white br0" onclick="fnAddTemplateToEmpty('smaple_line_prev01')"><spring:message code="wzwg.cmm.word.add02" /></a></li>
							<li><div class="line_prev02"></div> <a href="javascript:void(0);" class="wzbtn bg-blue-strong2 white br0" onclick="fnAddTemplateToEmpty('smaple_line_prev02')"><spring:message code="wzwg.cmm.word.add02" /></a></li>
							<li><div class="line_prev03"></div> <a href="javascript:void(0);" class="wzbtn bg-blue-strong2 white br0" onclick="fnAddTemplateToEmpty('smaple_line_prev03')"><spring:message code="wzwg.cmm.word.add02" /></a></li>
							<li><div class="line_prev04"></div> <a href="javascript:void(0);" class="wzbtn bg-blue-strong2 white br0" onclick="fnAddTemplateToEmpty('smaple_line_prev04')"><spring:message code="wzwg.cmm.word.add02" /></a></li>
							<li><div class="line_prev05"></div> <a href="javascript:void(0);" class="wzbtn bg-blue-strong2 white br0" onclick="fnAddTemplateToEmpty('smaple_line_prev05')"><spring:message code="wzwg.cmm.word.add02" /></a></li>
							<li><div class="line_prev06"></div> <a href="javascript:void(0);" class="wzbtn bg-blue-strong2 white br0" onclick="fnAddTemplateToEmpty('smaple_line_prev06')"><spring:message code="wzwg.cmm.word.add02" /></a></li>
							<li><div class="line_prev07"></div> <a href="javascript:void(0);" class="wzbtn bg-blue-strong2 white br0" onclick="fnAddTemplateToEmpty('smaple_line_prev07')"><spring:message code="wzwg.cmm.word.add02" /></a></li>
							<li><div class="line_prev08"></div> <a href="javascript:void(0);" class="wzbtn bg-blue-strong2 white br0" onclick="fnAddTemplateToEmpty('smaple_line_prev08')"><spring:message code="wzwg.cmm.word.add02" /></a></li>
							<li><div class="line_prev09"></div> <a href="javascript:void(0);" class="wzbtn bg-blue-strong2 white br0" onclick="fnAddTemplateToEmpty('smaple_line_prev09')"><spring:message code="wzwg.cmm.word.add02" /></a></li>
							<li><div class="line_prev10"></div> <a href="javascript:void(0);" class="wzbtn bg-blue-strong2 white br0" onclick="fnAddTemplateToEmpty('smaple_line_prev10')"><spring:message code="wzwg.cmm.word.add02" /></a></li>
							<li><div class="line_prev11"></div> <a href="javascript:void(0);" class="wzbtn bg-blue-strong2 white br0" onclick="fnAddTemplateToEmpty('smaple_line_prev11')"><spring:message code="wzwg.cmm.word.add02" /></a></li>
						</ul>
		            </div>
		            
		            




				</div>






















				<!-- 실제 <spring:message code="wzwg.cmm.word.layout" /> 샘플 코드 -->

				<div style="display:none;"> 
				 	<!-- 컨텐츠 추가 컨트롤러 -->
				 	<div id="sample_contents_action">
						<div class="add_div" onclick="addContentsPopup(this);">
							<h3><spring:message code="wzwg.cmm.msg.screen.MSG031" /><img src="/images/wzwg/site/mngr/add_cursor.png"></h3>
						</div>
				 	</div>
				 
					<!-- 1단 -->
				 	<div id="sample_layout_01">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block1">
								<div class="layout_01 layout_contents_border" data-w="100" data-h="M">
								</div>
							</div>
						</div>
				 	</div>
				 	
					<!-- 1단 full -->
				 	<div id="sample_layout_01_full">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block1 mxwd100">
								<div class="layout_01 layout_contents_border" data-w="100" data-h="M">
								</div>
							</div>
						</div>
				 	</div>

				 	<!-- 2단 (50:50) 간격X -->
				 	<div id="sample_layout_02">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block2">
								<div class="layout_02 layout_height_M layout_contents_border" data-w="50" data-h="M"></div>
								<div class="layout_02 layout_height_M layout_contents_border" data-w="50" data-h="M"></div>
							</div>
						</div>
				 	</div>
				 	
				 	<!-- 2단 (50:50) 간격O 1% -->
				 	<div id="sample_layout_02_padding">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block2 layout_padding">
								<div class="layout_02 layout_height_M layout_contents_border" data-w="50" data-h="M"></div>
								<div class="layout_02 layout_height_M layout_contents_border" data-w="50" data-h="M"></div>
							</div>
						</div>
				 	</div>
				 	
				 	<!-- 2단 (50:50) 간격O 2% -->
				 	<div id="sample_layout_02_padding_2">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block2 layout_padding btw2">
								<div class="layout_02 layout_height_M layout_contents_border" data-w="50" data-h="M"></div>
								<div class="layout_02 layout_height_M layout_contents_border" data-w="50" data-h="M"></div>
							</div>
						</div>
				 	</div>
				 	
				 	<!-- 2단 (50:50) 간격O 3% -->
				 	<div id="sample_layout_02_padding_3">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block2 layout_padding btw3">
								<div class="layout_02 layout_height_M layout_contents_border" data-w="50" data-h="M"></div>
								<div class="layout_02 layout_height_M layout_contents_border" data-w="50" data-h="M"></div>
							</div>
						</div>
				 	</div>
				 	
				 	<!-- 2단 (50:50) 간격O 4% -->
				 	<div id="sample_layout_02_padding_4">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block2 layout_padding btw4">
								<div class="layout_02 layout_height_M layout_contents_border" data-w="50" data-h="M"></div>
								<div class="layout_02 layout_height_M layout_contents_border" data-w="50" data-h="M"></div>
							</div>
						</div>
				 	</div>
				 	
					<!-- 2단 (30:70) 간격X -->
				 	<div id="sample_layout_02_37">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block2">
								<div class="layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
								<div class="layout_06 layout_height_M layout_contents_border" data-w="66" data-h="M"></div>
							</div>
						</div>
				 	</div>
				 	
					<!-- 2단 (30:70) 간격O 1% -->
				 	<div id="sample_layout_02_37_padding">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block2 layout_padding">
								<div class="layout_02_36 layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
								<div class="layout_02_36 layout_06 layout_height_M layout_contents_border" data-w="66" data-h="M"></div>
							</div>
						</div>
				 	</div>
				 	
				 	<!-- 2단 (30:70) 간격O 2% -->
				 	<div id="sample_layout_02_37_padding_2">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block2 layout_padding btw2">
								<div class="layout_02_36 layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
								<div class="layout_02_36 layout_06 layout_height_M layout_contents_border" data-w="66" data-h="M"></div>
							</div>
						</div>
				 	</div>
				 	
				 	<!-- 2단 (30:70) 간격O 3% -->
				 	<div id="sample_layout_02_37_padding_3">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block2 layout_padding btw3">
								<div class="layout_02_36 layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
								<div class="layout_02_36 layout_06 layout_height_M layout_contents_border" data-w="66" data-h="M"></div>
							</div>
						</div>
				 	</div>
				 	
				 	<!-- 2단 (30:70) 간격O 4% -->
				 	<div id="sample_layout_02_37_padding_4">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block2 layout_padding  btw4">
								<div class="layout_02_36 layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
								<div class="layout_02_36 layout_06 layout_height_M layout_contents_border" data-w="66" data-h="M"></div>
							</div>
						</div>
				 	</div>
				 	
					<!-- 3단 (1:1:1) 간격X -->
				 	<div id="sample_layout_03">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block3">
								<div class="layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
								<div class="layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
								<div class="layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
							</div>
						</div>
				 	</div>
				 	
				 	<!-- 3단 (1:1:1) 간격O 1% -->
				 	<div id="sample_layout_03_padding">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block3 layout_padding">
								<div class="layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
								<div class="layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
								<div class="layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
							</div>
						</div>
				 	</div>
				 	
				 	<!-- 3단 (1:1:1) 간격O 2% -->
				 	<div id="sample_layout_03_padding_2">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block3 layout_padding btw2">
								<div class="layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
								<div class="layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
								<div class="layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
							</div>
						</div>
				 	</div>
				 	
				 	<!-- 3단 (1:1:1) 간격O 3% -->
				 	<div id="sample_layout_03_padding_3">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block3 layout_padding btw3">
								<div class="layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
								<div class="layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
								<div class="layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
							</div>
						</div>
				 	</div>
				 	
				 	<!-- 3단 (1:1:1) 간격O 4% -->
				 	<div id="sample_layout_03_padding_4">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block3 layout_padding btw4">
								<div class="layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
								<div class="layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
								<div class="layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
							</div>
						</div>
				 	</div>
				 	
				 	<!-- 3단 (2:1:1) 간격X -->
				 	<div id="sample_layout_03_211">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block3 layout_block3_2">
								<div class="layout_02 layout_height_M layout_contents_border" data-w="50" data-h="M"></div>
								<div class="layout_04 layout_04ml layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
								<div class="layout_04 layout_04mr layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
							</div>
						</div>
				 	</div>
				 	
				 	<!-- 3단 (2:1:1) 간격O 1% -->
				 	<div id="sample_layout_03_211_padding">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block3 layout_block3_2 layout_padding">
								<div class="layout_02 layout_height_M layout_contents_border" data-w="50" data-h="M"></div>
								<div class="layout_04 layout_04ml layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
								<div class="layout_04 layout_04mr layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
							</div>
						</div>
				 	</div>
				 	
				 	<!-- 3단 (2:1:1) 간격O 2% -->
				 	<div id="sample_layout_03_211_padding_2">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block3 layout_block3_2 layout_padding btw2">
								<div class="layout_02 layout_height_M layout_contents_border" data-w="50" data-h="M"></div>
								<div class="layout_04 layout_04ml layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
								<div class="layout_04 layout_04mr layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
							</div>
						</div>
				 	</div>
				 	
				 	<!-- 3단 (2:1:1) 간격O 3% -->
				 	<div id="sample_layout_03_211_padding_3">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block3 layout_block3_2 layout_padding btw3">
								<div class="layout_02 layout_height_M layout_contents_border" data-w="50" data-h="M"></div>
								<div class="layout_04 layout_04ml layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
								<div class="layout_04 layout_04mr layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
							</div>
						</div>
				 	</div>
				 	
				 	<!-- 3단 (2:1:1) 간격O 4% -->
				 	<div id="sample_layout_03_211_padding_4">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block3 layout_block3_2 layout_padding btw4">
								<div class="layout_02 layout_height_M layout_contents_border" data-w="50" data-h="M"></div>
								<div class="layout_04 layout_04ml layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
								<div class="layout_04 layout_04mr layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
							</div>
						</div>
				 	</div>
				 	
				 	<!-- 4단 (1:1:1:1) 간격X -->
				 	<div id="sample_layout_04">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block4">
								<div class="layout_04 layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
								<div class="layout_04 layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
								<div class="layout_04 layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
								<div class="layout_04 layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
							</div>
						</div>
				 	</div>
				 	
				 	<!-- 4단 (1:1:1:1) 간격O 1% -->
				 	<div id="sample_layout_04_padding">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block4 layout_padding">
								<div class="layout_04 layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
								<div class="layout_04 layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
								<div class="layout_04 layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
								<div class="layout_04 layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
							</div>
						</div>
				 	</div>
				 	
				 	<!-- 4단 (1:1:1:1) 간격O 2% -->
				 	<div id="sample_layout_04_padding_2">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block4 layout_padding btw2">
								<div class="layout_04 layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
								<div class="layout_04 layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
								<div class="layout_04 layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
								<div class="layout_04 layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
							</div>
						</div>
				 	</div>
				 	
				 	<!-- 4단 (1:1:1:1) 간격O 3% -->
				 	<div id="sample_layout_04_padding_3">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block4 layout_padding btw3">
								<div class="layout_04 layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
								<div class="layout_04 layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
								<div class="layout_04 layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
								<div class="layout_04 layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
							</div>
						</div>
				 	</div>
				 	
				 	<!-- 4단 (1:1:1:1) 간격O 4% -->
				 	<div id="sample_layout_04_padding_4">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block4 layout_padding btw4">
								<div class="layout_04 layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
								<div class="layout_04 layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
								<div class="layout_04 layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
								<div class="layout_04 layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
							</div>
						</div>
				 	</div>
				 	

				 	<!-- 여백 샘플 -->
				 	<div id="sample_empty_10">
				 		<div class="empty empty_10 wzwgContextMenu layout_line_border"></div>
				 	</div>
				 	<div id="sample_empty_20">
				 		<div class="empty empty_20 wzwgContextMenu layout_line_border"></div>
				 	</div>
				 	<div id="sample_empty_30">
				 		<div class="empty empty_30 wzwgContextMenu layout_line_border"></div>
				 	</div>
				 	<div id="sample_empty_50">
				 		<div class="empty empty_50 wzwgContextMenu layout_line_border"></div>
				 	</div>
				 	<div id="sample_empty_80">
				 		<div class="empty empty_80 wzwgContextMenu layout_line_border"></div>
				 	</div>
				 	<div id="sample_empty_100">
				 		<div class="empty empty_100 wzwgContextMenu layout_line_border"></div>
				 	</div>


					<!-- 여백라인 샘플 -->
				 	<div id="smaple_line_style001">
				 					<div class="between_line layout_line_border" >
										<div class="div_wrap">
											<div class="line_style001"></div>
										</div>
									</div>
				 	</div>
				 	<div id="smaple_line_prev01">
				 					<div class="between_line layout_line_border" >
										<div class="div_wrap">
											<div class="line_prev01"></div>
										</div>
									</div>
				 	</div>
				 	<div id="smaple_line_prev02">
				 					<div class="between_line layout_line_border" >
										<div class="div_wrap">
											<div class="line_prev02"></div>
										</div>
									</div>
				 	</div>
				 	<div id="smaple_line_prev03">
				 					<div class="between_line layout_line_border">
										<div class="div_wrap">
											<div class="line_prev03"></div>
										</div>
									</div>
				 	</div>
				 	<div id="smaple_line_prev04">
				 					<div class="between_line layout_line_border" >
										<div class="div_wrap">
											<div class="line_prev04"></div>
										</div>
									</div>
				 	</div>
				 	<div id="smaple_line_prev05">
				 					<div class="between_line layout_line_border" >
										<div class="div_wrap">
											<div class="line_prev05"></div>
										</div>
									</div>
				 	</div>
				 	<div id="smaple_line_prev06">
				 					<div class="between_line layout_line_border" >
										<div class="div_wrap">
											<div class="line_prev06"></div>
										</div>
									</div>
				 	</div>
				 	<div id="smaple_line_prev07">
				 					<div class="between_line layout_line_border" >
										<div class="div_wrap">
											<div class="line_prev07"></div>
										</div>
									</div>
				 	</div>
				 	<div id="smaple_line_prev08">
				 					<div class="between_line layout_line_border" >
										<div class="div_wrap">
											<div class="line_prev08"></div>
										</div>
									</div>
				 	</div>
				 	<div id="smaple_line_prev09">
				 					<div class="between_line layout_line_border" >
										<div class="div_wrap">
											<div class="line_prev09"></div>
										</div>
									</div>
				 	</div>
				 	<div id="smaple_line_prev10">
				 					<div class="between_line layout_line_border" >
										<div class="div_wrap">
											<div class="line_prev10"></div>
										</div>
									</div>
				 	</div>
				 	<div id="smaple_line_prev11">
				 					<div class="between_line layout_line_border" >
										<div class="div_wrap">
											<div class="line_prev11"></div>
										</div>
									</div>
				 	</div>

				</div>







