<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 

 
 <script>
    $(document).ready(function(e){
        $(".layer_1step>a>input:radio").on('change', function(){
			$(".layer_1step>ul").slideUp();

			//console.log($(this));console.log(this);
			//console.log($(this).is(':checked'));
			var submenu = $(this).parent().next("ul");
			
			if($(this).is(':checked')){
				submenu.slideDown();
			}else{
				submenu.slideUp();
			}
		
        });
        //console.log('<c:out value="${param.callType}"/>');
        //console.log('layout width : <c:out value="${param.width}"/>');
    });
    
    function fnPreviewLayout(id, cod){
    	
    	$('#layout_preview').html($('#' + id).html());
    	
    	if(cod){
	    	var height = $('input[name="height' + cod + '"]:checked').val();
	    	fnPreviewLayoutEditVertical(height);
    	}
    }
    
    function fnPreviewLayoutEditVertical(hmode){
    	$('#layout_preview .div_wrap').children().each(function(){
    		  $(this).removeClass('layout_height_M');  
    		  $(this).removeClass('layout_height_L');  
    		  $(this).removeClass('layout_height_H');  
    		  
    		  $(this).addClass('layout_height_' + hmode);  
    		  $(this).attr('data-h', hmode);  
    	})
    }
    
    function fnAddTemplateToLayout(){
    	var layout = $('#layout_preview').clone(); 
    	
    	//var clickAction = $('#sample_contents_action').html();
		//console.log(clickAction);
		//console.log($(layout).find('.div_wrap'));
		
		/* $(layout).find('.div_wrap').children().each(function(){
			$(this).html(clickAction);  
		}) */
		
    	
    	//$("#cntntsEdit").append(layout.html());
    	$(".addContentZone").append(layout.html());
		$('#layout_preview').html('');
		
		var emptyLine = $('#sample_empty_30').html(); 
//    	$("#cntntsEdit").append(emptyLine);
    	$(".addContentZone").append(emptyLine);
    	
    	editInit();
    	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.word.layout" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.add" /></spring:argument></spring:message>');
    	wzModalClose();
    	
    }
    
    function fnAddTemplateToEmpty(id){
    	//fnAddTemplateToLayout(false);
    	
    	var layout = $('#' + id).html(); 
    	$(".addContentZone").append(layout);
    	editInit();
    	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.word.layout" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.add" /></spring:argument></spring:message>');
    	//fnLayerPopupClose();
    	wzModalClose();
    }
    
 	function fnPreviewVarLayout(id){
    	
    	$('#varLayout_preview').html($('#' + id).html());
    	
    }
 	
 	
 	function fnAddTemplateToVarLayout(){
    	var layout = $('#varLayout_preview').clone(); 
    	
    	//var clickAction = $('#sample_contents_action').html();
		//console.log(clickAction);
		//console.log($(layout).find('.div_wrap'));
		
		/* $(layout).find('.div_wrap').children().each(function(){
			$(this).html(clickAction);  
		}) */
		
    	
    	//$("#cntntsEdit").append(layout.html());
    	$(".addContentZone").append(layout.html());
		$('#varLayout_preview').html('');
		
		var emptyLine = $('#sample_empty_30').html(); 
//    	$("#cntntsEdit").append(emptyLine);
    	$(".addContentZone").append(emptyLine);
    	
    	editInit();
    	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.word.layout" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.add" /></spring:argument></spring:message>');
    	wzModalClose();
    	
    }
</script>
								
			<c:if test="${empty param.callType}"><c:set var="variableLayoutView" value="true"></c:set></c:if>
			<c:if test="${param.callType eq 'tabContainer'}"><c:set var="variableLayoutView" value="true"></c:set></c:if>
			<c:if test="${param.callType eq 'varLayout'}">
				<c:if test="${param.width eq '66' }">
					<c:set var="layoutView_4" value="false"></c:set>
				</c:if>
				<c:if test="${param.width eq '33' or param.width eq '50' or param.width eq '25'}">
					<c:set var="layoutView_3" value="false"></c:set>
					<c:set var="layoutView_4" value="false"></c:set>
				</c:if>
				
				<c:if test="${param.width eq '33' or param.width eq '25'}">
					<c:set var="layoutView_2" value="false"></c:set>
				</c:if>
				
				<c:if test="${param.width eq '50'}">
					<c:set var="layoutView_2_3_7" value="false"></c:set>
				</c:if>
			</c:if>


						<div id="add_layer" class="pop-tab">
				            <c:if test="${variableLayoutView eq 'true'}">
				            <input id="add_layer_variableLayout" type="radio" name="add_layer_tab" checked="checked"/>
				            </c:if>
				            <input id="add_layer_first" type="radio" name="add_layer_tab"  />
				            <input id="add_layer_second" type="radio" name="add_layer_tab" />
				            <section class="buttons">
				                <c:if test="${variableLayoutView eq 'true'}">
				                <label for="add_layer_variableLayout">복합 <spring:message code="wzwg.cmm.word.layout" /></label>
				                </c:if>
				                <label for="add_layer_first">고정 <spring:message code="wzwg.cmm.word.layout" /></label>
				                <label for="add_layer_second"><spring:message code="wzwg.cmm.word.layout" /> <spring:message code="wzwg.cmm.word.intrvl" /> <spring:message code="wzwg.cmm.word.and" /> <spring:message code="wzwg.cmm.word.se" /></label>
				            </section>
							
							
							
							
							
							
							<c:if test="${variableLayoutView eq 'true'}">
							<!-- 복합 레이아웃 탭 -->
				            <div class="tab_item layout_select01">
				            	<p style="margin-top: 15px; width: 100%; text-align: left; color:#999;">※ <spring:message code="wzwg.cmm.msg.MSG249" /></p>
				            	<div class="layer_preview">
				            		<h4><spring:message code="wzwg.cmm.word.preview" />:<span> (<spring:message code="wzwg.cmm.msg.MSG250" />)</span></h4>
										
										<div id="varLayout_preview" style="padding-top: 20px; padding-bottom: 20px; float: left; width: 100%;"></div>
		
				            	</div>
				            	
				            	
				            	<ul>
							        <li class="layer_1step">
							        	<a title="클릭하여 옵션을 선택하세요">
							            	<input id="varLayout01" type="radio" name="layout_select" onclick="fnPreviewVarLayout('sample_var_layout_01')"/>
							            	<label for="varLayout01">1<spring:message code="wzwg.cmm.word.step" /></label>
							            	<table class="table_preview" onclick="$('#varLayout01').click();"><tr><td>&nbsp;</td></tr></table>
							            </a>
							            <%-- <ul class="hide" style="display:none !important;">
							                <li>&#10004; <spring:message code="wzwg.cmm.msg.MSG311" /></li>
							                <li>&bull; <spring:message code="wzwg.cmm.msg.MSG312" />: 
							                	<input id="varLayout02_1_paddingO" type="radio" name="paddingVar2_1" checked="checked" onclick="fnPreviewVarLayout('sample_var_layout_02_padding')"/><label for="varLayout02_1_paddingO"><spring:message code="wzwg.cmm.word.be" /></label>
							                	<input id="varLayout02_1_paddingX" type="radio" name="paddingVar2_1" onclick="fnPreviewVarLayout('sample_var_layout_02')"><label for="varLayout02_1_paddingX"><spring:message code="wzwg.cmm.word.none" /></label>
							                </li>
							            </ul> --%>
										
									</li>
									<li class="layer_1step" style="visibility: hidden;">
									
									
							        <li class="layer_1step">
							        	<a title="클릭하여 옵션을 선택하세요">
							            	<input id="varLayout02" type="radio" name="layout_select" onclick="fnPreviewVarLayout('sample_var_layout_02_padding')"/>
							            	<label for="varLayout02">2<spring:message code="wzwg.cmm.word.step" /> (1:1)</label>
							            	<table class="table_preview" onclick="$('#varLayout02').click();"><tr><td>&nbsp;</td><td>&nbsp;</td></tr></table>
							            </a>
							            <ul class="hide">
							                <li>&#10004; <spring:message code="wzwg.cmm.msg.MSG311" /></li>
							                <li>&bull; <spring:message code="wzwg.cmm.msg.MSG312" />: 
							                	<input id="varLayout02_1_paddingO" type="radio" name="paddingVar2_1" checked="checked" onclick="fnPreviewVarLayout('sample_var_layout_02_padding')"/><label for="varLayout02_1_paddingO"><spring:message code="wzwg.cmm.word.be" /></label>
							                	<input id="varLayout02_1_paddingX" type="radio" name="paddingVar2_1" onclick="fnPreviewVarLayout('sample_var_layout_02')"><label for="varLayout02_1_paddingX"><spring:message code="wzwg.cmm.word.none" /></label>
							                </li>
							            </ul>
										
									</li>
							        <li class="layer_1step">
							        	<a title="클릭하여 옵션을 선택하세요">
							            	<input id="varLayout02_37" type="radio" name="layout_select" onclick="fnPreviewVarLayout('sample_var_layout_02_37_padding')"/>
							            	<label for="varLayout02_37">2<spring:message code="wzwg.cmm.word.step" /> (1:2)</label>
							            	<table class="table_preview" onclick="$('#varLayout02_37').click();"><td class="prev_td30">&nbsp;</td><td>&nbsp;</td></tr></table>
							            </a>
							            <ul class="hide">
							                <li>&#10004; <spring:message code="wzwg.cmm.msg.MSG311" /></li>
							                <li>&bull; <spring:message code="wzwg.cmm.msg.MSG312" />: 
							                	<input id="varLayout02_37_paddingO" type="radio" name="paddingVar2_37" checked="checked" onclick="fnPreviewVarLayout('sample_var_layout_02_37_padding')"/><label for="varLayout02_37_paddingO"><spring:message code="wzwg.cmm.word.be" /></label>
							                	<input id="varLayout02_37_paddingX" type="radio" name="paddingVar2_37" onclick="fnPreviewVarLayout('sample_var_layout_02_37')"><label for="varLayout02_37_paddingX"><spring:message code="wzwg.cmm.word.none" /></label>
							                </li>
							            </ul>
										
									</li>
									
									
									
									<li class="layer_1step">
							            <a title="클릭하여 옵션을 선택하세요">
							            	<input id="varLayout03_1" type="radio" name="layout_select" onclick="fnPreviewVarLayout('sample_var_layout_03_padding', '3_1')">
							            	<label for="varLayout03_1">3<spring:message code="wzwg.cmm.word.step" /> (1:1:1)</label>
							            	<table class="table_preview table_preview37" onclick="$('#varLayout03_1').click();"><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></table>
							            </a>
							            <ul class="hide">
							                <li>&#10004; <spring:message code="wzwg.cmm.msg.MSG311" /></li>
							                <li>&bull; <spring:message code="wzwg.cmm.msg.MSG312" />: 
							                	<input id="varLayout03_1_paddingO" type="radio" name="paddingVar3_1" checked="checked" onclick="fnPreviewVarLayout('sample_var_layout_03_padding', '3_1')"><label for="varLayout03_1_paddingO"><spring:message code="wzwg.cmm.word.be" /></label>
							                	<input id="varLayout03_1_paddingX" type="radio" name="paddingVar3_1" onclick="fnPreviewVarLayout('sample_var_layout_03', '3_1')"><label for="varLayout03_1_paddingX"><spring:message code="wzwg.cmm.word.none" /></label>
							                </li>
							                <%-- <li>&bull; <spring:message code="wzwg.cmm.msg.MSG313" />: 
							                	<input id="varLayout03_1_high" type="radio" name="height3_1" onclick="fnPreviewLayoutEditVertical('H')" value="H"><label for="layout03_1_high" title="350px"><spring:message code="wzwg.cmm.word.high" /></label>
							                	<input id="varLayout03_1_middle" type="radio" name="height3_1" checked="checked" onclick="fnPreviewLayoutEditVertical('M')" value="M"><label for="layout03_1_middle" title="250px"><spring:message code="wzwg.cmm.word.middle" /></label>
							                	<input id="varLayout03_1_low" type="radio" name="height3_1" onclick="fnPreviewLayoutEditVertical('L')" value="L"><label for="layout03_1_low" title="150px"><spring:message code="wzwg.cmm.word.low" /></label>
							                </li> --%>
							            </ul>
							        </li>
							        <li class="layer_1step">
							            <a title="클릭하여 옵션을 선택하세요">
							            	<input id="varLayout03_2" type="radio" name="layout_select" onclick="fnPreviewVarLayout('sample_var_layout_03_211_padding', '3_2')">
							            	<label for="varLayout03_2">3<spring:message code="wzwg.cmm.word.step" /> (2:1:1)</label>
							            	<table class="table_preview" onclick="$('#varLayout03_2').click();"><tr><td class="prev_td50">&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></table>
							            </a>
							            <ul class="hide">
							                <li>&#10004; <spring:message code="wzwg.cmm.msg.MSG311" /></li>
							                <li>&bull; <spring:message code="wzwg.cmm.msg.MSG312" />: 
							                	<input id="varLayout03_2_paddingO" type="radio" name="padding3_2" checked="checked" onclick="fnPreviewVarLayout('sample_var_layout_03_211_padding', '3_2')"><label for="varLayout03_2_paddingO"><spring:message code="wzwg.cmm.word.be" /></label>
							                	<input id="varLayout03_2_paddingX" type="radio" name="padding3_2" onclick="fnPreviewVarLayout('sample_var_layout_03_211', '3_2')"><label for="varLayout03_2_paddingX"><spring:message code="wzwg.cmm.word.none" /></label>
							                </li>
							                <%-- <li>&bull; <spring:message code="wzwg.cmm.msg.MSG313" />: 
							                	<input id="layout03_2_high" type="radio" name="height3_2" onclick="fnPreviewLayoutEditVertical('H')" value="H"><label for="layout03_2_high" title="350px"><spring:message code="wzwg.cmm.word.high" /></label>
							                	<input id="layout03_2_middle" type="radio" name="height3_2" checked="checked" onclick="fnPreviewLayoutEditVertical('M')" value="M"><label for="layout03_2_middle" title="250px"><spring:message code="wzwg.cmm.word.middle" /></label>
							                	<input id="layout03_2_low" type="radio" name="height3_2" onclick="fnPreviewLayoutEditVertical('L')" value="L"><label for="layout03_2_low" title="150px"><spring:message code="wzwg.cmm.word.low" /></label>
							                </li> --%>
							            </ul>
							        </li>
							        
							        
							        
							        <li class="layer_1step">
							            <a title="클릭하여 옵션을 선택하세요">
											<input id="varLayout04" type="radio" name="layout_select" onclick="fnPreviewVarLayout('sample_var_layout_04_padding', '4')">
								            <label for="varLayout04">4<spring:message code="wzwg.cmm.word.step" /></label>
											<table class="table_preview" onclick="$('#varLayout04').click();"><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></table>
										</a>
							            <ul class="hide">
							                <li>&#10004; <spring:message code="wzwg.cmm.msg.MSG311" /></li>
							                <li>&bull; <spring:message code="wzwg.cmm.msg.MSG312" />: 
							                	<input id="varLayout04_paddingO" type="radio" name="padding4" checked="checked" onclick="fnPreviewVarLayout('sample_var_layout_04_padding', '4')"><label for="varLayout04_paddingO"><spring:message code="wzwg.cmm.word.be" /></label>
							                	<input id="varLayout04_paddingX" type="radio" name="padding4" onclick="fnPreviewVarLayout('sample_var_layout_04', '4')"><label for="varLayout04_paddingX"><spring:message code="wzwg.cmm.word.none" /></label>
							                </li>
							                <%-- <li>&bull; <spring:message code="wzwg.cmm.msg.MSG313" />: 
							                	<input id="layout04_high" type="radio" name="height4" onclick="fnPreviewLayoutEditVertical('H')" value="H"><label for="layout04_high" title="350px"><spring:message code="wzwg.cmm.word.high" /></label>
							                	<input id="layout04_middle" type="radio" name="height4" checked="checked" onclick="fnPreviewLayoutEditVertical('M')" value="M"><label for="layout04_middle" title="250px"><spring:message code="wzwg.cmm.word.middle" /></label>
							                	<input id="layout04_low" type="radio" name="height4" onclick="fnPreviewLayoutEditVertical('L')" value="L"><label for="layout04_low" title="150px"><spring:message code="wzwg.cmm.word.low" /></label>
							                </li> --%>
							            </ul>
							        </li>
							        
							        
								</ul>
								
								
								
								
								
								<div class="btnbox-c mb20">
									<a href="javascript:void(0);" class="wzbtn btn-edit" onclick="fnAddTemplateToVarLayout()"><spring:message code="wzwg.cmm.word.add02" /></a>
								</div>
								
							</div>
							</c:if>
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
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
							        	<ul class="hide">
							                <li>&#10004; <spring:message code="wzwg.cmm.msg.MSG311" /></li>
							                <li>&bull; <spring:message code="wzwg.cmm.word.layout" /> <spring:message code="wzwg.cmm.word.extend" />: 
							                	<input id="layout01_1_nomal" type="radio" name="layout_1" checked="checked" onclick="fnPreviewLayout('sample_layout_01')"/><label for="layout01_1_nomal"><spring:message code="wzwg.cmm.word.bass" /></label>
							                	<input id="layout02_1_wide" type="radio" name="layout_1" onclick="fnPreviewLayout('sample_layout_01_full')"><label for="layout02_1_wide"><spring:message code="wzwg.cmm.word.extend" /></label>
							                </li>
							                
							            </ul>
										
									</li>
							        <li class="layer_1step" style="visibility: hidden;">
							        	
										
									</li>
							   
							   <c:if test="${layoutView_2 ne 'false' }">
							        <li class="layer_1step">
							            <a title="클릭하여 옵션을 선택하세요">
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
							        
							    	<c:if test="${layoutView_2_3_7 ne 'false' }">
							        <li class="layer_1step">
							            <a title="클릭하여 옵션을 선택하세요">
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
							        </c:if>
							    </c:if>
		
								<c:if test="${layoutView_3 ne 'false' }">
							        <li class="layer_1step">
							            <a title="클릭하여 옵션을 선택하세요">
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
							            <a title="클릭하여 옵션을 선택하세요">
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
								</c:if>
		
								<c:if test="${layoutView_4 ne 'false' }">
							        <li class="layer_1step">
							            <a title="클릭하여 옵션을 선택하세요">
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
								</c:if>
							    </ul>
		
								<div class="btnbox-c mb20">
									<a href="javascript:void(0);" class="wzbtn btn-edit" onclick="fnAddTemplateToLayout()"><spring:message code="wzwg.cmm.word.add02" /></a>
								</div>
								
				            </div>		
							
		
		
		
		
		
		
							
		
		
		
		
		
		
		
		
		
		
		
							<!-- 레이아웃 간격 및 구분 탭 -->
				            <div class="tab_item layout_select02">
								<ul class="empty_select">
									<h4><spring:message code="wzwg.cmm.word.blnkspce" /></h4>
									<li><span>- 10px</span> <div class="empty_prev empty_prev10"></div>
												<a href="javascript:void(0);" class="wzbtn btn-edit" onclick="fnAddTemplateToEmpty('sample_empty_10')"><spring:message code="wzwg.cmm.word.add02" /></a>
									</li>
									<li><span>- 20px</span> <div class="empty_prev empty_prev20"></div>
												<a href="javascript:void(0);" class="wzbtn btn-edit" onclick="fnAddTemplateToEmpty('sample_empty_20')"><spring:message code="wzwg.cmm.word.add02" /></a>
									</li>
									<li><span>- 30px (<spring:message code="wzwg.cmm.word.bass" />)</span> <div class="empty_prev empty_prev30"></div>
												<a href="javascript:void(0);" class="wzbtn btn-edit" onclick="fnAddTemplateToEmpty('sample_empty_30')"><spring:message code="wzwg.cmm.word.add02" /></a>
									</li>
									<li><span>- 50px</span> <div class="empty_prev empty_prev50"></div>
												<a href="javascript:void(0);" class="wzbtn btn-edit" onclick="fnAddTemplateToEmpty('sample_empty_50')"><spring:message code="wzwg.cmm.word.add02" /></a>
									</li>
									<li><span>- 80px (반응형)</span><div class="empty_prev empty_prev80"></div>
												<a href="javascript:void(0);" class="wzbtn btn-edit" onclick="fnAddTemplateToEmpty('sample_empty_80')"><spring:message code="wzwg.cmm.word.add02" /></a>
									</li>
									<li><span>- 100px (반응형)</span><div class="empty_prev empty_prev100"></div>
												<a href="javascript:void(0);" class="wzbtn btn-edit" onclick="fnAddTemplateToEmpty('sample_empty_100')"><spring:message code="wzwg.cmm.word.add02" /></a>
									</li>
								</ul>
		
								<ul class="line_select">
									<h4><spring:message code="wzwg.cmm.word.se" /> <spring:message code="wzwg.cmm.word.line03" /></h4>
									<li><div class="line_prev01"></div> <a href="javascript:void(0);" class="wzbtn btn-edit" onclick="fnAddTemplateToEmpty('smaple_line_prev01')"><spring:message code="wzwg.cmm.word.add02" /></a></li>
									<li><div class="line_prev02"></div> <a href="javascript:void(0);" class="wzbtn btn-edit" onclick="fnAddTemplateToEmpty('smaple_line_prev02')"><spring:message code="wzwg.cmm.word.add02" /></a></li>
									<li><div class="line_prev03"></div> <a href="javascript:void(0);" class="wzbtn btn-edit" onclick="fnAddTemplateToEmpty('smaple_line_prev03')"><spring:message code="wzwg.cmm.word.add02" /></a></li>
									<li><div class="line_prev04"></div> <a href="javascript:void(0);" class="wzbtn btn-edit" onclick="fnAddTemplateToEmpty('smaple_line_prev04')"><spring:message code="wzwg.cmm.word.add02" /></a></li>
									<li><div class="line_prev05"></div> <a href="javascript:void(0);" class="wzbtn btn-edit" onclick="fnAddTemplateToEmpty('smaple_line_prev05')"><spring:message code="wzwg.cmm.word.add02" /></a></li>
									<li><div class="line_prev06"></div> <a href="javascript:void(0);" class="wzbtn btn-edit" onclick="fnAddTemplateToEmpty('smaple_line_prev06')"><spring:message code="wzwg.cmm.word.add02" /></a></li>
									<li><div class="line_prev07"></div> <a href="javascript:void(0);" class="wzbtn btn-edit" onclick="fnAddTemplateToEmpty('smaple_line_prev07')"><spring:message code="wzwg.cmm.word.add02" /></a></li>
									<li><div class="line_prev08"></div> <a href="javascript:void(0);" class="wzbtn btn-edit" onclick="fnAddTemplateToEmpty('smaple_line_prev08')"><spring:message code="wzwg.cmm.word.add02" /></a></li>
									<li><div class="line_prev09"></div> <a href="javascript:void(0);" class="wzbtn btn-edit" onclick="fnAddTemplateToEmpty('smaple_line_prev09')"><spring:message code="wzwg.cmm.word.add02" /></a></li>
									<li><div class="line_prev10"></div> <a href="javascript:void(0);" class="wzbtn btn-edit" onclick="fnAddTemplateToEmpty('smaple_line_prev10')"><spring:message code="wzwg.cmm.word.add02" /></a></li>
									<li><div class="line_prev11"></div> <a href="javascript:void(0);" class="wzbtn btn-edit" onclick="fnAddTemplateToEmpty('smaple_line_prev11')"><spring:message code="wzwg.cmm.word.add02" /></a></li>			
								</ul>
		
		
		
				            </div>		
				     </div>


								
 
 
 
 
 
 
 
 
 
 <div style="display: none;"> <!-- 실제 레이아웃 샘플 코드 -->
 	<!-- 컨텐츠 추가 컨트롤러 -->
 	<div id="sample_contents_action">
		
		<div class="add_div" onclick="addContentsPopup(this);">
			<h3><spring:message code="wzwg.cmm.msg.MSG138" /><img src="/images/wzwg/site/mngr/add_cursor.png"></h3>
		</div>
 	</div>
 
	<!-- 1단 -->
 	<div id="sample_layout_01">
					<div class="layout_wrap wzwgContextMenu layout_wrap_border" >
						<div class="div_wrap layout_block1">
							<div class="layout_01 layout_contents_border"  data-w="100" data-h="M"></div>
						</div>
					</div>
 	</div>
 	
	<!-- 1단 full -->
 	<div id="sample_layout_01_full">
					<div class="layout_wrap wzwgContextMenu layout_wrap_border">
						<div class="div_wrap layout_block1" style="max-width: 100%;">
							<div class="layout_01 layout_contents_border"  data-w="100" data-h="M"></div>
						</div>
					</div>
 	</div>
 	
 	<!-- 2단 (50:50) 간격X -->
 	<div id="sample_layout_02">
 			
					<div class="layout_wrap wzwgContextMenu layout_wrap_border" >
						<div class="div_wrap layout_block2">
							<div class="layout_02 layout_height_M layout_contents_border"  data-w="50" data-h="M"></div>
							<div class="layout_02 layout_height_M layout_contents_border"  data-w="50" data-h="M"></div>
						</div>
					</div>
 	</div>
 	
 	<!-- 2단 (50:50) 간격O -->
 	<div id="sample_layout_02_padding">
					<div class="layout_wrap wzwgContextMenu layout_wrap_border" >
						<div class="div_wrap layout_block2 layout_padding">
							<div class="layout_02 layout_height_M layout_contents_border"  data-w="50" data-h="M"></div>
							<div class="layout_02 layout_height_M layout_contents_border"  data-w="50" data-h="M"></div>
						</div>
					</div>
 	</div>
 	
	<!-- 2단 (30:70) 간격X -->
 	<div id="sample_layout_02_37">
					<div class="layout_wrap wzwgContextMenu layout_wrap_border" >
						<div class="div_wrap layout_block2">
							<div class="layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
							<div class="layout_06 layout_height_M layout_contents_border" data-w="66" data-h="M"></div>
						</div>
					</div>
 	</div>
 	
	<!-- 2단 (30:70) 간격O -->
 	<div id="sample_layout_02_37_padding">
					<div class="layout_wrap wzwgContextMenu layout_wrap_border" >
						<div class="div_wrap layout_block2 layout_padding">
							<div class="layout_02_36 layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
							<div class="layout_02_36 layout_06 layout_height_M layout_contents_border" data-w="66" data-h="M"></div>
						</div>
					</div>
 	</div>

	<!-- 3단 (1:1:1) 간격X -->
 	<div id="sample_layout_03">
					<div class="layout_wrap wzwgContextMenu layout_wrap_border" >
						<div class="div_wrap layout_block3">
							<div class="layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
							<div class="layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
							<div class="layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
						</div>
					</div>
 	</div>
 	
 	<!-- 3단 (1:1:1) 간격O -->
 	<div id="sample_layout_03_padding">
					<div class="layout_wrap wzwgContextMenu layout_wrap_border" >
						<div class="div_wrap layout_block3 layout_padding">
							<div class="layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
							<div class="layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
							<div class="layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M"></div>
						</div>
					</div>
 	</div>
 	
 	<!-- 3단 (2:1:1) 간격X -->
 	<div id="sample_layout_03_211">
					<div class="layout_wrap wzwgContextMenu layout_wrap_border" >
						
						<div class="div_wrap layout_block3 layout_block3_2">
							<div class="layout_02 layout_height_M layout_contents_border"  data-w="50" data-h="M"></div>
							<div class="layout_04 layout_04ml layout_height_M layout_contents_border"  data-w="25" data-h="M"></div>
							<div class="layout_04 layout_04mr layout_height_M layout_contents_border"  data-w="25" data-h="M"></div>
						</div>
					</div>
 	</div>
 	
 	<!-- 3단 (2:1:1) 간격O -->
 	<div id="sample_layout_03_211_padding">
					<div class="layout_wrap wzwgContextMenu layout_wrap_border" >
						
						<div class="div_wrap layout_block3 layout_block3_2 layout_padding">
							<div class="layout_02 layout_height_M layout_contents_border" data-w="50" data-h="M"></div>
							<div class="layout_04 layout_04ml layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
							<div class="layout_04 layout_04mr layout_height_M layout_contents_border" data-w="25" data-h="M"></div>
						</div>
					</div>
 	</div>
 	
 	<!-- 4단 (1:1:1:1) 간격X -->
 	<div id="sample_layout_04">
					<div class="layout_wrap wzwgContextMenu layout_wrap_border" >
						
						<div class="div_wrap layout_block4">
							<div class="layout_04 layout_height_M layout_contents_border"  data-w="25" data-h="M"></div>
							<div class="layout_04 layout_height_M layout_contents_border"  data-w="25" data-h="M"></div>
							<div class="layout_04 layout_height_M layout_contents_border"  data-w="25" data-h="M"></div>
							<div class="layout_04 layout_height_M layout_contents_border"  data-w="25" data-h="M"></div>
						</div>
					</div>
 	</div>
 	
 	<!-- 4단 (1:1:1:1) 간격O -->
 	<div id="sample_layout_04_padding">
					<div class="layout_wrap wzwgContextMenu layout_wrap_border" >
						
						<div class="div_wrap layout_block4 layout_padding">
							<div class="layout_04 layout_height_M layout_contents_border"  data-w="25" data-h="M"></div>
							<div class="layout_04 layout_height_M layout_contents_border"  data-w="25" data-h="M"></div>
							<div class="layout_04 layout_height_M layout_contents_border"  data-w="25" data-h="M"></div>
							<div class="layout_04 layout_height_M layout_contents_border"  data-w="25" data-h="M"></div>
						</div>
					</div>
 	</div>
 	
 	
 	
 	
 	
 	
 	
 	
 	
 	
 	
 	
 	<!-- 복합 1단  -->
 	<div id="sample_var_layout_01">
 			
					<div class="layout_wrap wzwgContextMenu layout_wrap_border" >
						<div class="div_wrap layout_block1" style="max-width:100%;">
							<div class="layout_01 layout_height_A layout_contents_border varLayout" data-w="100" data-h="M"></div>
						</div>
					</div>
 	</div>
 	<!-- 복합 2단 (50:50) 간격X -->
 	<div id="sample_var_layout_02">
 			
					<div class="layout_wrap wzwgContextMenu layout_wrap_border" >
						<div class="div_wrap layout_block2" style="max-width:100%;">
							<div class="layout_02 layout_height_A layout_contents_border varLayout"  data-w="50" data-h="M"></div>
							<div class="layout_02 layout_height_A layout_contents_border varLayout"  data-w="50" data-h="M"></div>
						</div>
					</div>
 	</div>
 	<!-- 복합 2단 (50:50) 간격O -->
 	<div id="sample_var_layout_02_padding">
					<div class="layout_wrap wzwgContextMenu layout_wrap_border" >
						<div class="div_wrap layout_block2 layout_padding" style="max-width:100%; padding-left:10px; padding-right: 10px;">
							<div class="layout_02 layout_height_A layout_contents_border varLayout"  data-w="50" data-h="M"></div>
							<div class="layout_02 layout_height_A layout_contents_border varLayout"  data-w="50" data-h="M"></div>
						</div>
					</div>
 	</div>
 	
	<!-- 복합 2단 (30:70) 간격X -->
 	<div id="sample_var_layout_02_37">
					<div class="layout_wrap wzwgContextMenu layout_wrap_border" >
						<div class="div_wrap layout_block2" style="max-width:100%;">
							<div class="layout_03 layout_height_A layout_contents_border varLayout" data-w="33" data-h="M"></div>
							<div class="layout_06 layout_height_A layout_contents_border varLayout" data-w="66" data-h="M"></div>
						</div>
					</div>
 	</div>
 	
	<!-- 복합 2단 (30:70) 간격O -->
 	<div id="sample_var_layout_02_37_padding">
					<div class="layout_wrap wzwgContextMenu layout_wrap_border" >
						<div class="div_wrap layout_block2 layout_padding" style="max-width:100%; padding-left:10px; padding-right: 10px;">
							<div class="layout_02_36 layout_03 layout_height_A layout_contents_border varLayout" data-w="33" data-h="M"></div>
							<div class="layout_02_36 layout_06 layout_height_A layout_contents_border varLayout" data-w="66" data-h="M"></div>
						</div>
					</div>
 	</div>

	<!-- 복합 3단 (1:1:1) 간격X -->
 	<div id="sample_var_layout_03">
					<div class="layout_wrap wzwgContextMenu layout_wrap_border" >
						<div class="div_wrap layout_block3">
							<div class="layout_03 layout_height_A layout_contents_border varLayout" data-w="33" data-h="M"></div>
							<div class="layout_03 layout_height_A layout_contents_border varLayout" data-w="33" data-h="M"></div>
							<div class="layout_03 layout_height_A layout_contents_border varLayout" data-w="33" data-h="M"></div>
						</div>
					</div>
 	</div>
 	
 	<!-- 복합 3단 (1:1:1) 간격O -->
 	<div id="sample_var_layout_03_padding">
					<div class="layout_wrap wzwgContextMenu layout_wrap_border" >
						<div class="div_wrap layout_block3 layout_padding">
							<div class="layout_03 layout_height_A layout_contents_border varLayout" data-w="33" data-h="M"></div>
							<div class="layout_03 layout_height_A layout_contents_border varLayout" data-w="33" data-h="M"></div>
							<div class="layout_03 layout_height_A layout_contents_border varLayout" data-w="33" data-h="M"></div>
						</div>
					</div>
 	</div>
 	
 	<!-- 복합 3단 (2:1:1) 간격X -->
 	<div id="sample_var_layout_03_211">
					<div class="layout_wrap wzwgContextMenu layout_wrap_border" >
						
						<div class="div_wrap layout_block3 layout_block3_2">
							<div class="layout_02 layout_height_A layout_contents_border varLayout"  data-w="50" data-h="M"></div>
							<div class="layout_04 layout_04ml layout_height_A layout_contents_border varLayout"  data-w="25" data-h="M"></div>
							<div class="layout_04 layout_04mr layout_height_A layout_contents_border varLayout"  data-w="25" data-h="M"></div>
						</div>
					</div>
 	</div>
 	
 	<!-- 복합 3단 (2:1:1) 간격O -->
 	<div id="sample_var_layout_03_211_padding">
					<div class="layout_wrap wzwgContextMenu layout_wrap_border" >
						
						<div class="div_wrap layout_block3 layout_block3_2 layout_padding">
							<div class="layout_02 layout_height_A layout_contents_border varLayout" data-w="50" data-h="M"></div>
							<div class="layout_04 layout_04ml layout_height_A layout_contents_border varLayout" data-w="25" data-h="M"></div>
							<div class="layout_04 layout_04mr layout_height_A layout_contents_border varLayout" data-w="25" data-h="M"></div>
						</div>
					</div>
 	</div>
 	
 	<!-- 복합 4단 (1:1:1:1) 간격X -->
 	<div id="sample_var_layout_04">
					<div class="layout_wrap wzwgContextMenu layout_wrap_border" >
						
						<div class="div_wrap layout_block4">
							<div class="layout_04 layout_height_A layout_contents_border varLayout"  data-w="25" data-h="M"></div>
							<div class="layout_04 layout_height_A layout_contents_border varLayout"  data-w="25" data-h="M"></div>
							<div class="layout_04 layout_height_A layout_contents_border varLayout"  data-w="25" data-h="M"></div>
							<div class="layout_04 layout_height_A layout_contents_border varLayout"  data-w="25" data-h="M"></div>
						</div>
					</div>
 	</div>
 	
 	<!-- 복합 4단 (1:1:1:1) 간격O -->
 	<div id="sample_var_layout_04_padding">
					<div class="layout_wrap wzwgContextMenu layout_wrap_border" >
						
						<div class="div_wrap layout_block4 layout_padding">
							<div class="layout_04 layout_height_A layout_contents_border varLayout"  data-w="25" data-h="M"></div>
							<div class="layout_04 layout_height_A layout_contents_border varLayout"  data-w="25" data-h="M"></div>
							<div class="layout_04 layout_height_A layout_contents_border varLayout"  data-w="25" data-h="M"></div>
							<div class="layout_04 layout_height_A layout_contents_border varLayout"  data-w="25" data-h="M"></div>
						</div>
					</div>
 	</div>
 	
 	
 	
 	
 	
 	
 	
 	
 	
 	
 	
 	<!-- 여백 샘플 -->
 	<div id="sample_empty_10">
 					<div class="empty empty_10 wzwgContextMenu layout_line_border" ></div>
 	</div>
 	<div id="sample_empty_20">
 					<div class="empty empty_20 wzwgContextMenu layout_line_border" ></div>
 	</div>
 	<div id="sample_empty_30">
 					<div class="empty empty_30 wzwgContextMenu layout_line_border" ></div>
 	</div>
 	<div id="sample_empty_50">
 					<div class="empty empty_50 wzwgContextMenu layout_line_border" ></div>
 	</div>
 	<div id="sample_empty_80">
 					<div class="empty empty_80 wzwgContextMenu layout_line_border" ></div>
 	</div>
 	<div id="sample_empty_100">
 					<div class="empty empty_100 wzwgContextMenu layout_line_border" ></div>
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