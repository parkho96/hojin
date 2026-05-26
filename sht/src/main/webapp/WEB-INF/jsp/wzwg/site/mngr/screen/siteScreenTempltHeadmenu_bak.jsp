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
    });
    
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
								

						 <c:if test="${paramVO.headMenuType eq 'left'}"><c:set var="verticalHeadClass">modal-headmenu-left</c:set></c:if>
						 <div class="pop-tab modal-headmenu <c:out value="${verticalHeadClass }"/>" id="contents_tab">
								<c:if test="${paramVO.headMenuType eq 'left'}"><c:set var="verticalClass">vertical_mode</c:set></c:if>
								
								
								<input id="mn_head" type="radio" name="tab" checked="checked" />
					            <input id="mn_foot" type="radio" name="tab" />
					            <input id="mn_sub" type="radio" name="tab" />
					            <input id="mn_subWide" type="radio" name="tab" />
					            <section class="buttons <c:out value="${verticalClass }"/>">
					                <label for="mn_head">해더메뉴</label>
					                <label for="mn_foot"><spring:message code="wzwg.cmm.word.footer" /> <spring:message code="wzwg.cmm.word.menu" /></label>
					                <c:if test="${paramVO.headMenuType ne 'left'}">
					                <label for="mn_sub">서브메뉴(basic)</label>
					                <label for="mn_subWide">서브메뉴(wide)</label>
					                </c:if>
					            </section>
								
								
					            <!-- headmenu tab -->
					            <div class="tab_item item_for_1 <c:out value="${verticalClass }"/>">
					            	<h4>* <spring:message code="wzwg.cmm.msg.MSG248" /></h4>
									<ul>
										<c:forEach items="${headList }" var="list" varStatus="c">
										<li>
											<%-- <h4><spring:message code="wzwg.cmm.word.head" /> <spring:message code="wzwg.cmm.word.menu" /> <c:out value="${c.count }"/></h4> --%>
											<h4><c:out value="${list.fileName}"/></h4>
											<!-- 썸네일이미지, 클릭시 확대 -->
											<a href="javascript:void(0);" >
												<div class="img_div">
												<img src="/<c:out value="${list.path}"/>.jpg" id="img_thumb_<c:out value="${list.fileName}"/>" onclick="fnImgPrevewPop('img_thumb_<c:out value="${list.fileName}"/>');" style="border: solid 1px #ddd;">
												</div>
											</a>
											
											<a href="javascript:;" onclick="changeTopMenuCss('/<c:out value="${list.path}"/>.css')" class="wzbtn-table btn-edit"><spring:message code="wzwg.cmm.word.tochange" /></a> <!-- 추가하기 -->
											<a href="javascript:void(0);" onclick="fnImgPrevewPop('img_thumb_<c:out value="${list.fileName}"/>');" class="wzbtn-table btn-basic" title="<spring:message code="wzwg.site.screen.msg.MSG160"/>"><spring:message code="wzwg.cmm.word.preview" /></a> <!-- 돋보기버튼_ 클릭시 팝업 -->
										</li>
										</c:forEach>
									</ul>
					            </div>		
					            
					            
					            <!-- footermenu tab -->
					            <div class="tab_item item_for_1">
					            	<h4>* <spring:message code="wzwg.cmm.msg.MSG248" /></h4>
									<ul>
										<c:forEach items="${footList }" var="list" varStatus="c">
										<li>
											<h4><c:out value="${list.fileName}"/></h4>
											<!-- 썸네일이미지, 클릭시 확대 -->
											<a href="javascript:void(0);" >
												<div class="img_div">
												<img src="/<c:out value="${list.path}"/>.jpg" id="imgf_thumb_<c:out value="${list.fileName}"/>" onclick="fnImgPrevewPop('imgf_thumb_<c:out value="${list.fileName}"/>');" style="border: solid 1px #ddd;">
												</div>
											</a>
											
											<a href="javascript:;" onclick="changeFooterCss('/<c:out value="${list.path}"/>.css')" class="wzbtn-table btn-edit"><spring:message code="wzwg.cmm.word.tochange" /></a> <!-- 추가하기 -->
											<a href="javascript:void(0);" onclick="fnImgPrevewPop('imgf_thumb_<c:out value="${list.fileName}"/>');" class="wzbtn-table btn-basic" title="<spring:message code="wzwg.site.screen.msg.MSG160"/>"><spring:message code="wzwg.cmm.word.preview" /></a> <!-- 돋보기버튼_ 클릭시 팝업 -->
										</li>
										</c:forEach>
										
										
									</ul>
					            </div>
					            
					            
					            <!-- submenu tab -->
					            <div class="tab_item item_for_1 vertical_mode">
					            	<c:choose>
					            		<c:when test="${paramVO.headMenuType eq 'left'}"><h4>* <spring:message code="wzwg.cmm.msg.MSG324" /></h4></c:when>
					            		<c:otherwise>
							            	<h4>* <spring:message code="wzwg.cmm.msg.MSG248" /></h4>
											<ul>
												<c:forEach items="${subList }" var="list" varStatus="c">
												<li>
													<h4><c:out value="${list.fileName}"/></h4>
													<!-- 썸네일이미지, 클릭시 확대 -->
													<a href="javascript:void(0);" >
														<div class="img_div">
														<img src="/<c:out value="${list.path}"/>.jpg" id="imgsb_thumb_<c:out value="${list.fileName}"/>" onclick="fnImgPrevewPop('imgsb_thum_<c:out value="${list.fileName}"/>');" style="border: solid 1px #ddd;">
														</div>
													</a>
													
													<a href="javascript:;" onclick="changeSubCss('/<c:out value="${list.path}"/>.css', 'basic')" class="wzbtn-table btn-edit"><spring:message code="wzwg.cmm.word.tochange" /></a> <!-- 추가하기 -->
													<a href="javascript:void(0);" onclick="fnImgPrevewPop('imgsb_thumb_<c:out value="${list.fileName}"/>');" class="wzbtn-table btn-basic" title="<spring:message code="wzwg.site.screen.msg.MSG160"/>"><spring:message code="wzwg.cmm.word.preview" /></a> <!-- 돋보기버튼_ 클릭시 팝업 -->
												</li>
												</c:forEach>
											</ul>
					            		</c:otherwise>
					            	</c:choose>
					            </div>
					            
					            <!-- submenu-wide tab -->
					            <div class="tab_item item_for_1">
					            	<c:choose>
					            		<c:when test="${paramVO.headMenuType eq 'left'}"><h4>* <spring:message code="wzwg.cmm.msg.MSG324" /></h4></c:when>
					            		<c:otherwise>
							            	<h4>* <spring:message code="wzwg.cmm.msg.MSG248" /></h4>
											<ul>
												<c:forEach items="${subWideList }" var="list" varStatus="c">
												<li>
													<h4><c:out value="${list.fileName}"/></h4>
													<!-- 썸네일이미지, 클릭시 확대 -->
													<a href="javascript:void(0);" >
														<div class="img_div">
														<img src="/<c:out value="${list.path}"/>.jpg" id="imgsb_thumb_<c:out value="${list.fileName}"/>" onclick="fnImgPrevewPop('imgsb_thum_<c:out value="${list.fileName}"/>');" style="border: solid 1px #ddd;">
														</div>
													</a>
													
													<a href="javascript:;" onclick="changeSubCss('/<c:out value="${list.path}"/>.css', 'wide')" class="wzbtn-table btn-edit"><spring:message code="wzwg.cmm.word.tochange" /></a> <!-- 추가하기 -->
													<a href="javascript:void(0);" onclick="fnImgPrevewPop('imgsb_thumb_<c:out value="${list.fileName}"/>');" class="wzbtn-table btn-basic" title="<spring:message code="wzwg.site.screen.msg.MSG160"/>"><spring:message code="wzwg.cmm.word.preview" /></a> <!-- 돋보기버튼_ 클릭시 팝업 -->
												</li>
												</c:forEach>
											</ul>
					            		</c:otherwise>
					            	</c:choose>
					            </div>
								
			
			
			
					
					     </div>
			