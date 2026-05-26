<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 

 <link rel="stylesheet" href="/css/wzwg/cmm/layout.css" type="text/css" />
 <link rel="stylesheet" href="/css/wzwg/cmm/empty_line.css" type="text/css" />
 <link rel="stylesheet" href="/css/wzwg/site/mngr/popupzone.css" type="text/css" />
 
 <script>
 	var headIndex;
    $(document).ready(function(e){
    	//$('#modal-headmenu').draggable({ handle: "#modal-headmenu-move-handler" });
    	//$("#modal-headmenu-move-handler").css('cursor', 'move');
    	headIndex = $('.head-group').css('z-index');
    	$('.head-group').css('z-index', '100');
    	
    	fnSelectMenuAddBg();
    });
    
    function fnSelectMenuAddBg(){
		var headCssLink = $('#headmenu').attr('href');
    	
    	$('.headMenuList').each(function(){
    		$(this).children().each(function(){
    			var fileNm = $(this).attr('data-filenm');
    			if(headCssLink.indexOf(fileNm) > -1){
    				$(this).find('.thumImg').addClass('bg-blue adm_active');
    				$(this).find('strong').addClass('bg-blue-strong3 white adm_active');
    			}
    		});
    	});
    	
    	var footCssLink = $('#footmenu').attr('href');
    	
    	$('.footMenuList').each(function(){
    		$(this).children().each(function(){
    			var fileNm = $(this).attr('data-filenm');
    			if(footCssLink.indexOf(fileNm) > -1){
    				$(this).find('.thumImg').addClass('bg-blue adm_active');
    				$(this).find('strong').addClass('bg-blue-strong3 white adm_active');
    			}
    		});
    	});
    	
    	var subCssLink = $('#submenu').attr('href');
    	
    	$('.subMenuList').each(function(){
    		$(this).children().each(function(){
    			var fileNm = $(this).attr('data-filenm');
    			if(subCssLink.indexOf(fileNm) > -1){
    				$(this).find('.thumImg').addClass('bg-blue adm_active');
    				$(this).find('strong').addClass('bg-blue-strong3 white adm_active');
    			}
    		});
    	});
    }
    
    function fnImgPrevewPop(id){
		var imgsrc = $('#' + id).attr('src');

		
		var width = $('#' + id)[0].naturalWidth;
		var height = $('#' + id)[0].naturalHeight;
		var frm = document.frmImgPreview;
		frm.imgSrc.value = imgsrc;
		
    	
		var frmResult = window.open("", "popForm", "width=" + width + ",height=" + height + ",toolbars=no,menubars=no,scrollbars=yes,left=50,top=400");
		
		frm.target='popForm';
		frm.action='/sample/img/imgViewer.jsp';
		frm.submit();
    }
    
    function fnHeadDown(){
    	$('.head-group').css('z-index', headIndex);
    }
</script>
<form id="frmImgPreview" name="frmImgPreview" style="display: none;" method="post">
	<input type="hidden" name="imgSrc"/>
</form>								
								

				<div class="pop-tab menuDsnPOPUP mngEditPOPUP">
							
					<input id="mn_head" type="radio" name="tab" <c:if test="${paramVO.headMenuType ne 'left'}">checked="checked"</c:if> >
		            <input id="mn_headLeft" type="radio" name="tab" <c:if test="${paramVO.headMenuType eq 'left'}">checked="checked"</c:if>>
		            <input id="mn_foot" type="radio" name="tab">
		            <input id="mn_sub" type="radio" name="tab">
		            <section class="buttons ">
		                <label for="mn_head" style="<c:if test="${paramVO.headMenuType eq 'left'}">display:none;</c:if>"><span></span><spring:message code="wzwg.site.screen.msg.MSG122" /></label>
		                <label for="mn_headLeft" style="<c:if test="${paramVO.headMenuType ne 'left'}">display:none;</c:if>"><span></span><spring:message code="wzwg.site.screen.msg.MSG122" /></label>
		                <label for="mn_foot"><span></span><spring:message code="wzwg.site.screen.msg.MSG123" /></label>
		                <c:if test="${paramVO.headMenuType ne 'left'}"><label for="mn_sub"><span></span><spring:message code="wzwg.site.screen.msg.MSG124" /></label></c:if>
		            </section>
					
					
		            <!-- headmenu tab -->
		            <div class="tab_item">
		            	<p class="tab_tit"><spring:message code="wzwg.site.screen.msg.MSG122" /></p>

		            	<div class="pop-tab tab_2Dpth">
		            		<input id="head_basic" type="radio" name="head" checked="checked">
		            		<input id="head_wide" type="radio" name="head">
		            		<section class="buttons ">
				                <label for="head_basic"><spring:message code="wzwg.cmm.word.bassTy" />
				                	<div class="menu_help">
										<span class="circle_no bg-blue-strong2 vert-m">?</span>
										<div class="help_pop">
											<spring:message code="wzwg.cmm.msg.screen.MSG060" />
										</div>
									</div>
				                </label>
				                <c:if test="${not empty headListWide}">
				                <label for="head_wide"><spring:message code="wzwg.cmm.word.wideTy" />
				                	<div class="menu_help">
										<span class="circle_no bg-blue-strong2 vert-m">?</span>
										<div class="help_pop">
											<spring:message code="wzwg.cmm.msg.screen.MSG061" />
										</div>
									</div>
				                </label>
				                </c:if>
				                
				                <div class="wd100 notice fl mt0 brsolid br-top1 br-rgt0 br-lft0 br-btm0 br-lightgrey box-border pt10 pl10">
						            <div><span class="circle_no bg-green-strong vert-m">!</span><b class="fs14 linehgt150"><spring:message code="wzwg.cmm.word.prect" /></b></div>
						            <div><p class="pt5 word_kp linehgt130 grey pl5 box-border wd100">
						            		<spring:message code="wzwg.cmm.msg.screen.MSG062" />
						            	 </p></div>
						        </div>
				            </section>

				            <div class="tab_item">
				            	<p class="tab_tit"><spring:message code="wzwg.cmm.word.bassTy" /></p>
				            	<ul class="headMenuList">
				            		<c:forEach items="${headListBasic }" var="list" varStatus="c">
									<li class="wd50 wm100" data-filenm="<c:out value="${list.fileName}"/>">
										<strong class="wd100 fl fs16 fw400 hgt40 linehgt40 pl10 box-border"><c:out value="${list.fileName}"/></strong>
										<div class="thumImg wd100 fl hgt250">
											<div class="wd100 fl">
												<img src="/<c:out value="${list.path}"/>.jpg" id="img_thumb_<c:out value="${list.fileName}"/>">
											</div>
											<div class="hoverLayer">
												<div class="i-block wd100 linehgt150 vert-m txt-l">
						   							<a href="javascript:void(0);" onclick="fnImgPrevewPop('img_thumb_<c:out value="${list.fileName}"/>');" class="circleRTxt">
						   								<span class="hoverbtn_circle closeUp"></span><spring:message code="wzwg.cmm.word.preview" /></a>
						   							<a href="javascript:void(0);" onclick="changeTopMenuCss('/<c:out value="${list.path}"/>.css')" class="circleRTxt">
						   								<span class="hoverbtn_circle new"></span><spring:message code="wzwg.cmm.word.tochange" /></a>
						  						</div>
						  					</div>
										</div>
									</li>
									</c:forEach>
								</ul>
				            </div>
				            
				            <c:if test="${not empty headListWide}">
				            <div class="tab_item">
				            	<p class="tab_tit"><spring:message code="wzwg.cmm.word.wideTy" /></p>
				            	<ul class="headMenuList">
				            		<c:forEach items="${headListWide }" var="list" varStatus="c">
									<li class="wd50 wm100" data-filenm="<c:out value="${list.fileName}"/>">
										<strong class="wd100 fl fs16 fw400 hgt40 linehgt40 pl10 box-border"><c:out value="${list.fileName}"/></strong>
										<div class="thumImg wd100 fl hgt250">
											<div class="wd100 fl">
												<img src="/<c:out value="${list.path}"/>.jpg" id="img_thumb_<c:out value="${list.fileName}"/>">
											</div>
											<div class="hoverLayer">
												<div class="i-block wd100 linehgt150 vert-m txt-l">
						   							<a href="javascript:void(0);" onclick="fnImgPrevewPop('img_thumb_<c:out value="${list.fileName}"/>');" class="circleRTxt">
						   								<span class="hoverbtn_circle closeUp"></span><spring:message code="wzwg.cmm.word.preview" /></a>
						   							<a href="javascript:void(0);" onclick="changeTopMenuCss('/<c:out value="${list.path}"/>.css')" class="circleRTxt">
						   								<span class="hoverbtn_circle new"></span><spring:message code="wzwg.cmm.word.tochange" /></a>
						  						</div>
						  					</div>
										</div>
									</li>
									</c:forEach>
								</ul>
				            </div>
				            </c:if>
				            
		            	</div>
		            </div>		
		            

		            <!-- headmenu(LEFT) tab -->
		            <div class="tab_item">
		            	<p class="tab_tit"><spring:message code="wzwg.site.screen.msg.MSG122" /></p>
		            	<ul class="headMenuList">
		            		<c:forEach items="${headList }" var="list" varStatus="c">
							<li class="wd25 wm50" data-filenm="<c:out value="${list.fileName}"/>">
								<strong class="wd100 fl fs16 fw400 hgt40 linehgt40 pl10 box-border"><c:out value="${list.fileName}"/></strong>
								<div class="thumImg wd100 fl hgt400">
									<div class="wd100 fl">
										<img src="/<c:out value="${list.path}"/>.jpg" id="img_thumb_<c:out value="${list.fileName}"/>">
									</div>
									<div class="hoverLayer">
										<div class="i-block wd100 linehgt150 vert-m txt-l">
				   							<a href="javascript:void(0);" onclick="fnImgPrevewPop('img_thumb_<c:out value="${list.fileName}"/>');" class="circleRTxt">
				   								<span class="hoverbtn_circle closeUp"></span><spring:message code="wzwg.cmm.word.preview" /></a>
				   							<a href="javascript:void(0);" onclick="changeTopMenuCss('/<c:out value="${list.path}"/>.css')" class="circleRTxt">
				   								<span class="hoverbtn_circle new"></span><spring:message code="wzwg.cmm.word.tochange" /></a>
				  						</div>
				  					</div>
								</div>
							</li>
							</c:forEach>
						</ul>
		            </div>


		            
		            <!-- footermenu tab -->
		            <div class="tab_item">
		            	<p class="tab_tit"><spring:message code="wzwg.site.screen.msg.MSG123" /></p>
	            		<ul class="footMenuList">
	            			<c:forEach items="${footList }" var="list" varStatus="c">
							<li class="wd50 wm100" data-filenm="<c:out value="${list.fileName}"/>">
								<strong class="wd100 fl fs16 fw400 hgt40 linehgt40 pl10 box-border"><c:out value="${list.fileName}"/></strong>
								<div class="thumImg wd100 fl hgt250">
									<div class="wd100 fl">
										<img src="/<c:out value="${list.path}"/>.jpg" id="imgf_thumb_<c:out value="${list.fileName}"/>">
									</div>
									<div class="hoverLayer">
										<div class="i-block wd100 linehgt150 vert-m txt-l">
				   							<a href="javascript:void(0);" onclick="fnImgPrevewPop('imgf_thumb_<c:out value="${list.fileName}"/>');" class="circleRTxt">
				   								<span class="hoverbtn_circle closeUp"></span><spring:message code="wzwg.cmm.word.preview" /></a>
				   							<a href="javascript:void(0);" onclick="changeFooterCss('/<c:out value="${list.path}"/>.css')" class="circleRTxt">
				   								<span class="hoverbtn_circle new"></span><spring:message code="wzwg.cmm.word.tochange" /></a>
				  						</div>
				  					</div>
								</div>
							</li>
							</c:forEach>
						</ul>
		            </div>
		            
		            
		            <!-- submenu tab -->
		            <div class="tab_item">
		            	<p class="tab_tit"><spring:message code="wzwg.site.screen.msg.MSG124" /></p>

		            	<div class="pop-tab tab_2Dpth">
		            		<input id="sub_left" type="radio" name="submenu" checked="checked">
		            		<input id="sub_wide" type="radio" name="submenu">
		            		<section class="buttons ">
				                <label for="sub_left"><spring:message code="wzwg.site.screen.msg.MSG125" />
				                	<div class="menu_help">
										<span class="circle_no bg-blue-strong2 vert-m">?</span>
										<div class="help_pop">
											<spring:message code="wzwg.cmm.msg.screen.MSG063" />
										</div>
									</div>
				                </label>
				                <label for="sub_wide"><spring:message code="wzwg.site.screen.msg.MSG126" />
				                	<div class="menu_help">
										<span class="circle_no bg-blue-strong2 vert-m">?</span>
										<div class="help_pop">
											<spring:message code="wzwg.cmm.msg.screen.MSG064" />
										</div>
									</div>
				                </label>
				            </section>

				            <div class="tab_item">
				            	<p class="tab_tit"><spring:message code="wzwg.site.screen.msg.MSG125" /></p>
				            	<ul class="subMenuList">
				            		<c:forEach items="${subList }" var="list" varStatus="c">
									<li class="wd25 wm50" data-filenm="<c:out value="${list.fileName}"/>">
										<strong class="wd100 fl fs16 fw400 hgt40 linehgt40 pl10 box-border"><c:out value="${list.fileName}"/></strong>
										<div class="thumImg wd100 fl hgt400">
											<div class="wd100 fl">
												<img src="/<c:out value="${list.path}"/>.jpg" id="imgsb_thumb_<c:out value="${list.fileName}"/>">
											</div>
											<div class="hoverLayer">
												<div class="i-block wd100 linehgt150 vert-m txt-l">
						   							<a href="javascript:void(0);" onclick="fnImgPrevewPop('imgsb_thumb_<c:out value="${list.fileName}"/>');" class="circleRTxt">
						   								<span class="hoverbtn_circle closeUp"></span><spring:message code="wzwg.cmm.word.preview" /></a>
						   							<a href="javascript:void(0);" onclick="changeSubCss('/<c:out value="${list.path}"/>.css', 'basic')" class="circleRTxt">
						   								<span class="hoverbtn_circle new"></span><spring:message code="wzwg.cmm.word.tochange" /></a>
						  						</div>
						  					</div>
										</div>
									</li>
									</c:forEach>
								</ul>
				            </div>

				            <div class="tab_item">
				            	<p class="tab_tit"><spring:message code="wzwg.site.screen.msg.MSG126" /></p>
				            	<ul class="subMenuList">
				            		<c:forEach items="${subWideList }" var="list" varStatus="c">
									<li class="wd50 wm100" data-filenm="<c:out value="${list.fileName}"/>">
										<strong class="wd100 fl fs16 fw400 hgt40 linehgt40 pl10 box-border"><c:out value="${list.fileName}"/></strong>
										<div class="thumImg wd100 fl hgt250">
											<div class="wd100 fl">
												<img src="/<c:out value="${list.path}"/>.jpg" id="imgsb_thumb_<c:out value="${list.fileName}"/>" onclick="fnImgPrevewPop('imgsb_thumb_<c:out value="${list.fileName}"/>');" style="border: solid 1px #ddd;">
											</div>
											<div class="hoverLayer">
												<div class="i-block wd100 linehgt150 vert-m txt-l">
						   							<a href="javascript:void(0);" onclick="fnImgPrevewPop('imgsb_thumb_<c:out value="${list.fileName}"/>');" class="circleRTxt">
						   								<span class="hoverbtn_circle closeUp"></span><spring:message code="wzwg.cmm.word.preview" /></a>
						   							<a href="javascript:void(0);" onclick="changeSubCss('/<c:out value="${list.path}"/>.css', 'wide')" class="circleRTxt">
						   								<span class="hoverbtn_circle new"></span><spring:message code="wzwg.cmm.word.tochange" /></a>
						  						</div>
						  					</div>
										</div>
									</li>
									</c:forEach>
								</ul>
				            </div>
		            	</div>

		            </div>
		            <!-- end submenu tab -->
		            
		            
		            
		            
			</div><!-- end pop-tab menuDsnPOPUP -->