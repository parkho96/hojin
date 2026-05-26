<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 

 <link rel="stylesheet" href="/css/wzwg/cmm/layout.css" type="text/css" />
 <link rel="stylesheet" href="/css/wzwg/cmm/empty_line.css" type="text/css" />
 <link rel="stylesheet" href="/css/wzwg/site/mngr/popupzone.css" type="text/css" />
 
 <script>
    $(document).ready(function(e){
    	//$('#addContentPopup').draggable({ handle: "#addContentPopupMoveHanler" });
    	//$("#addContentPopupMoveHanler").css('cursor', 'move');
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
</script>
<form id="frmImgPreview" name="frmImgPreview" style="display: none;" method="post">
	<input type="hidden" name="imgSrc"/>
</form>								
								

			
						 <div class="pop-tab mngEditPOPUP coAddPOPUP">
					            <input id="wg_board" type="radio" name="tab" checked="checked" />
					            <input id="wg_gallery" type="radio" name="tab" />
					            <input id="wg_video" type="radio" name="tab" />
					            <input id="wg_bnr" type="radio" name="tab" />
					            <input id="wg_slide" type="radio" name="tab" />
					            <input id="wg_quick" type="radio" name="tab" />
					            <c:if test="${(subPrefix eq '/subMngr' or subPrefix eq '/subsite') eq false }">
					            <input id="wg_clndr" type="radio" name="tab" />
					            <input id="wg_map" type="radio" name="tab" />
					            </c:if>
					            <!-- <input id="ctnt_shop" type="radio" name="tab" /> -->
					            <input id="wg_etc" type="radio" name="tab" />
					            <section class="buttons wd100" style="height:auto;">
					                <label for="wg_board"><span></span><spring:message code="wzwg.cmm.cntnts.bassbbs" /></label>
					                <label for="wg_gallery"><span></span><spring:message code="wzwg.cmm.cntnts.imagebbs" /></label>
					                <label for="wg_video"><span></span><spring:message code="wzwg.cmm.cntnts.mvpbbs" /></label>
					                <label for="wg_bnr"><span></span><spring:message code="wzwg.cmm.cntnts.banner" /></label>
					                <label for="wg_slide"><span></span><spring:message code="wzwg.cmm.cntnts.slidebanner" /></label>
					                <label for="wg_quick"><span></span><spring:message code="wzwg.cmm.cntnts.quickmenu" /></label>
					                <c:if test="${(subPrefix eq '/subMngr' or subPrefix eq '/subsite') eq false }">
					                <label for="wg_clndr"><span></span><spring:message code="wzwg.cmm.cntnts.schdul" /></label>
					                <label for="wg_map"><span></span><spring:message code="wzwg.cmm.word.map" /></label>
					                </c:if>
					                <%-- <label for="ctnt_shop"><spring:message code="wzwg.cmm.cntnts.shopmall" /></label> --%>
					                <label for="wg_etc"><span></span><spring:message code="wzwg.cmm.cntnts.etc" /></label>
					            </section>
					            
								<c:choose>
									<c:when test="${paramVO.width eq '100'}"><c:set var="tabItemClass">item_for_1</c:set></c:when>
									<c:otherwise><c:set var="tabItemClass">item_for_234</c:set></c:otherwise>
								</c:choose>
								
								<!-- 일반게시판 탭 -->
					            <div class="tab_item wd100 p0">
					            	<%-- <h4>* <spring:message code="wzwg.cmm.msg.MSG248" />(<spring:message code="wzwg.cmm.msg.MSG284" />)</h4> --%>
					            	<p class="prv_notice wd100 pt20 pb20 txt-c">
					            		<span class="circle_no bg-blue-strong2 vert-m">i</span>
					            		<spring:message code="wzwg.cmm.msg.MSG284" />
					            	</p>
									<ul>
										<c:forEach items="${contentsList }" var="list">
										<c:if test="${list.category eq 'board' }">
										<li class="wd33 wm50">
											<strong class="wd100 fl fs16 fw400 pl10 box-border"><c:out value="${list.layoutcntntsNm }"/>
												<p><c:out value="${list.layoutcntntsDc }"/></p>
											</strong>
											<%-- <h4><c:out value="${list.layoutcntntsDc }"/></h4> --%>
											<div class="thumImg wd100 fl">
												<div class="wd100 fl">
													<!-- <img src="http://test1.wiz-wig.co.kr/sample/layout/contents/board/board006_1/350_board006_1.jpg" onclick="fnImgPrevewPop('img_thumb_headmenu32_wide');"> -->
													<c:choose>
														<c:when test="${paramVO.width eq '100' }"><img src="<c:out value="${list.thumbWPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>"></c:when>
														<c:when test="${paramVO.height eq 'H' }"><img src="<c:out value="${list.thumbHPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" ></c:when>
														<c:when test="${paramVO.height eq 'M' }"><img src="<c:out value="${list.thumbMPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" ></c:when>
														<c:when test="${paramVO.height eq 'L' }"><img src="<c:out value="${list.thumbLPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" ></c:when>
														<c:otherwise><img src="<c:out value="${list.thumbMPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:otherwise>
													</c:choose>
												</div>
												<div class="hoverLayer">
													<div class="wd100">
							   							<a href="javascript:void(0);" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');" class="circleRTxt">
							   								<span class="hoverbtn_circle closeUp"></span><spring:message code="wzwg.cmm.word.preview" /></a>
							   							<a href="javascript:void(0);" onclick="addLayoutContents('<c:out value="${list.sampleFileCours}${list.sampleFileNm }"/>', '<c:out value="${list.sampleFileCours}${list.sampleCssNm }"/>', 'CSS_<c:out value="${list.layoutcntntsSeq }"/>','<c:out value="${list.layoutcntntsNm }"/>')" class="circleRTxt">
							   								<span class="hoverbtn_circle add"></span><spring:message code="wzwg.cmm.word.add02" /></a>
							  						</div>
							  					</div>
											</div>
											<%-- <p><spring:message code="wzwg.cmm.word.chartstc" />: <c:out value="${list.layoutcntntsDc }"/></p> --%>
											<!-- 썸네일이미지, 클릭시 확대 -->
											<%-- <a href="javascript:void(0);" >
												<div class="img_div">
												<c:choose>
													<c:when test="${paramVO.width eq '100' }"><img src="<c:out value="${list.thumbWPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:when test="${paramVO.height eq 'H' }"><img src="<c:out value="${list.thumbHPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:when test="${paramVO.height eq 'M' }"><img src="<c:out value="${list.thumbMPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:when test="${paramVO.height eq 'L' }"><img src="<c:out value="${list.thumbLPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:otherwise><img src="<c:out value="${list.thumbMPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:otherwise>
												</c:choose>
												</div>
											</a>
			
											<div class="btnbox-l  wd100">
												<a href="javascript:;" onclick="addLayoutContents('<c:out value="${list.sampleFileCours}${list.sampleFileNm }"/>', '<c:out value="${list.sampleFileCours}${list.sampleCssNm }"/>', 'CSS_<c:out value="${list.layoutcntntsSeq }"/>')" class="wzbtn-table btn-edit"><spring:message code="wzwg.cmm.word.add02" /></a> <!-- 추가하기 -->
												<a href="javascript:void(0);" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');" class="wzbtn-table btn-basic" title="확대보기"><spring:message code="wzwg.cmm.word.preview" /></a> <!-- 돋보기버튼_ 클릭시 팝업 -->
											</div> --%>
										</li>
										</c:if>
										</c:forEach>
									</ul>
					            </div>		
								
			
					            <!-- 이미지게시판 탭 -->
								<div class="tab_item wd100 p0">
									<p class="prv_notice wd100 pt20 pb20 txt-c">
					            		<span class="circle_no bg-blue-strong2 vert-m">i</span>
					            		<spring:message code="wzwg.cmm.msg.MSG284" />
					            	</p>
									
									<ul>
										<c:forEach items="${contentsList }" var="list">
										<c:if test="${list.category eq 'img_board' }">
										<li class="wd33 wm50">
											<strong class="wd100 fl fs16 fw400 pl10 box-border"><c:out value="${list.layoutcntntsNm }"/>
												<p><c:out value="${list.layoutcntntsDc }"/></p>
											</strong>
											<div class="thumImg wd100 fl">
												<div class="wd100 fl">
													<c:choose>
														<c:when test="${paramVO.width eq '100' }"><img src="<c:out value="${list.thumbWPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>"></c:when>
														<c:when test="${paramVO.height eq 'H' }"><img src="<c:out value="${list.thumbHPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" ></c:when>
														<c:when test="${paramVO.height eq 'M' }"><img src="<c:out value="${list.thumbMPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" ></c:when>
														<c:when test="${paramVO.height eq 'L' }"><img src="<c:out value="${list.thumbLPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" ></c:when>
														<c:otherwise><img src="<c:out value="${list.thumbMPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:otherwise>
													</c:choose>
												</div>
												<div class="hoverLayer">
													<div class="wd100">
							   							<a href="javascript:void(0);" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');" class="circleRTxt">
							   								<span class="hoverbtn_circle closeUp"></span><spring:message code="wzwg.cmm.word.preview" /></a>
							   							<a href="javascript:void(0);" onclick="addLayoutContents('<c:out value="${list.sampleFileCours}${list.sampleFileNm }"/>', '<c:out value="${list.sampleFileCours}${list.sampleCssNm }"/>', 'CSS_<c:out value="${list.layoutcntntsSeq }"/>','<c:out value="${list.layoutcntntsNm }"/>')" class="circleRTxt">
							   								<span class="hoverbtn_circle add"></span><spring:message code="wzwg.cmm.word.add02" /></a>
							  						</div>
							  					</div>
											</div>
										</li>
										</c:if>
										</c:forEach>
									</ul>
								</div>
								
								
					            <!-- 동영상게시판 탭 -->
								<div class="tab_item wd100 p0">
									<p class="prv_notice wd100 pt20 pb20 txt-c">
					            		<span class="circle_no bg-blue-strong2 vert-m">i</span>
					            		<spring:message code="wzwg.cmm.msg.MSG284" />
					            	</p>
									
									<ul>
										<c:forEach items="${contentsList }" var="list">
										<c:if test="${list.category eq 'mvp_board' }">
										<li class="wd33 wm50">
											<strong class="wd100 fl fs16 fw400 pl10 box-border"><c:out value="${list.layoutcntntsNm }"/>
												<p><c:out value="${list.layoutcntntsDc }"/></p>
											</strong>
											<div class="thumImg wd100 fl">
												<div class="wd100 fl">
													<c:choose>
														<c:when test="${paramVO.width eq '100' }"><img src="<c:out value="${list.thumbWPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>"></c:when>
														<c:when test="${paramVO.height eq 'H' }"><img src="<c:out value="${list.thumbHPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" ></c:when>
														<c:when test="${paramVO.height eq 'M' }"><img src="<c:out value="${list.thumbMPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" ></c:when>
														<c:when test="${paramVO.height eq 'L' }"><img src="<c:out value="${list.thumbLPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" ></c:when>
														<c:otherwise><img src="<c:out value="${list.thumbMPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:otherwise>
													</c:choose>
												</div>
												<div class="hoverLayer">
													<div class="wd100">
							   							<a href="javascript:void(0);" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');" class="circleRTxt">
							   								<span class="hoverbtn_circle closeUp"></span><spring:message code="wzwg.cmm.word.preview" /></a>
							   							<a href="javascript:void(0);" onclick="addLayoutContents('<c:out value="${list.sampleFileCours}${list.sampleFileNm }"/>', '<c:out value="${list.sampleFileCours}${list.sampleCssNm }"/>', 'CSS_<c:out value="${list.layoutcntntsSeq }"/>','<c:out value="${list.layoutcntntsNm }"/>')" class="circleRTxt">
							   								<span class="hoverbtn_circle add"></span><spring:message code="wzwg.cmm.word.add02" /></a>
							  						</div>
							  					</div>
											</div>
										</li>
										</c:if>
										</c:forEach>
									</ul>
								</div>
			
			
			
								<!-- 배너 탭 -->
								<div class="tab_item wd100 p0">
									<p class="prv_notice wd100 pt20 pb20 txt-c">
					            		<span class="circle_no bg-blue-strong2 vert-m">i</span>
					            		<spring:message code="wzwg.cmm.msg.MSG284" />
					            	</p>
									<ul>
										<c:forEach items="${contentsList }" var="list">
										<c:if test="${list.category eq 'banner' }">
										<li class="wd33 wm50">
											<strong class="wd100 fl fs16 fw400 pl10 box-border"><c:out value="${list.layoutcntntsNm }"/>
												<p><c:out value="${list.layoutcntntsDc }"/></p>
											</strong>
											<div class="thumImg wd100 fl">
												<div class="wd100 fl">
													<c:choose>
														<c:when test="${paramVO.width eq '100' }"><img src="<c:out value="${list.thumbWPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>"></c:when>
														<c:when test="${paramVO.height eq 'H' }"><img src="<c:out value="${list.thumbHPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" ></c:when>
														<c:when test="${paramVO.height eq 'M' }"><img src="<c:out value="${list.thumbMPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" ></c:when>
														<c:when test="${paramVO.height eq 'L' }"><img src="<c:out value="${list.thumbLPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" ></c:when>
														<c:otherwise><img src="<c:out value="${list.thumbMPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:otherwise>
													</c:choose>
												</div>
												<div class="hoverLayer">
													<div class="wd100">
							   							<a href="javascript:void(0);" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');" class="circleRTxt">
							   								<span class="hoverbtn_circle closeUp"></span><spring:message code="wzwg.cmm.word.preview" /></a>
							   							<a href="javascript:void(0);" onclick="addLayoutContents('<c:out value="${list.sampleFileCours}${list.sampleFileNm }"/>', '<c:out value="${list.sampleFileCours}${list.sampleCssNm }"/>', 'CSS_<c:out value="${list.layoutcntntsSeq }"/>','<c:out value="${list.layoutcntntsNm }"/>')" class="circleRTxt">
							   								<span class="hoverbtn_circle add"></span><spring:message code="wzwg.cmm.word.add02" /></a>
							  						</div>
							  					</div>
											</div>
										</li>
										</c:if>
										</c:forEach>
									</ul>
								</div>
			
			
			
								<!-- 롤링이미지 탭 -->
								<div class="tab_item wd100 p0">
									<p class="prv_notice wd100 pt20 pb20 txt-c">
					            		<span class="circle_no bg-blue-strong2 vert-m">i</span>
					            		<spring:message code="wzwg.cmm.msg.MSG284" />
					            	</p>
									<ul>
										<c:forEach items="${contentsList }" var="list">
										<c:if test="${list.category eq 'slide' }">
										<li class="wd33 wm50">
											<strong class="wd100 fl fs16 fw400 pl10 box-border"><c:out value="${list.layoutcntntsNm }"/>
												<p><c:out value="${list.layoutcntntsDc }"/></p>
											</strong>
											<div class="thumImg wd100 fl">
												<div class="wd100 fl">
													<c:choose>
														<c:when test="${paramVO.width eq '100' }"><img src="<c:out value="${list.thumbWPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>"></c:when>
														<c:when test="${paramVO.height eq 'H' }"><img src="<c:out value="${list.thumbHPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" ></c:when>
														<c:when test="${paramVO.height eq 'M' }"><img src="<c:out value="${list.thumbMPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" ></c:when>
														<c:when test="${paramVO.height eq 'L' }"><img src="<c:out value="${list.thumbLPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" ></c:when>
														<c:otherwise><img src="<c:out value="${list.thumbMPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:otherwise>
													</c:choose>
												</div>
												<div class="hoverLayer">
													<div class="wd100">
							   							<a href="javascript:void(0);" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');" class="circleRTxt">
							   								<span class="hoverbtn_circle closeUp"></span><spring:message code="wzwg.cmm.word.preview" /></a>
							   							<a href="javascript:void(0);" onclick="addLayoutContents('<c:out value="${list.sampleFileCours}${list.sampleFileNm }"/>', '<c:out value="${list.sampleFileCours}${list.sampleCssNm }"/>', 'CSS_<c:out value="${list.layoutcntntsSeq }"/>','<c:out value="${list.layoutcntntsNm }"/>')" class="circleRTxt">
							   								<span class="hoverbtn_circle add"></span><spring:message code="wzwg.cmm.word.add02" /></a>
							  						</div>
							  					</div>
											</div>
										</li>
										</c:if>
										</c:forEach>
									</ul>
								</div>
			
			
			
								<!-- 퀵메뉴 탭 -->
								<div class="tab_item wd100 p0">
									<p class="prv_notice wd100 pt20 pb20 txt-c">
					            		<span class="circle_no bg-blue-strong2 vert-m">i</span>
					            		<spring:message code="wzwg.cmm.msg.MSG284" />
					            	</p>
									<ul>
										<c:forEach items="${contentsList }" var="list">
										<c:if test="${list.category eq 'quick' }">
										<li class="wd33 wm50">
											<strong class="wd100 fl fs16 fw400 pl10 box-border"><c:out value="${list.layoutcntntsNm }"/>
												<p><c:out value="${list.layoutcntntsDc }"/></p>
											</strong>
											<div class="thumImg wd100 fl">
												<div class="wd100 fl">
													<c:choose>
														<c:when test="${paramVO.width eq '100' }"><img src="<c:out value="${list.thumbWPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>"></c:when>
														<c:when test="${paramVO.height eq 'H' }"><img src="<c:out value="${list.thumbHPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" ></c:when>
														<c:when test="${paramVO.height eq 'M' }"><img src="<c:out value="${list.thumbMPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" ></c:when>
														<c:when test="${paramVO.height eq 'L' }"><img src="<c:out value="${list.thumbLPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" ></c:when>
														<c:otherwise><img src="<c:out value="${list.thumbMPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:otherwise>
													</c:choose>
												</div>
												<div class="hoverLayer">
													<div class="wd100">
							   							<a href="javascript:void(0);" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');" class="circleRTxt">
							   								<span class="hoverbtn_circle closeUp"></span><spring:message code="wzwg.cmm.word.preview" /></a>
							   							<a href="javascript:void(0);" onclick="addLayoutContents('<c:out value="${list.sampleFileCours}${list.sampleFileNm }"/>', '<c:out value="${list.sampleFileCours}${list.sampleCssNm }"/>', 'CSS_<c:out value="${list.layoutcntntsSeq }"/>','<c:out value="${list.layoutcntntsNm }"/>')" class="circleRTxt">
							   								<span class="hoverbtn_circle add"></span><spring:message code="wzwg.cmm.word.add02" /></a>
							  						</div>
							  					</div>
											</div>
										</li>
										</c:if>
										</c:forEach>
									</ul>
								</div>
								
								
								<c:if test="${(subPrefix eq '/subMngr' or subPrefix eq '/subsite') eq false }">
								<!-- 일정 탭 -->
								<div class="tab_item wd100 p0">
									<p class="prv_notice wd100 pt20 pb20 txt-c">
					            		<span class="circle_no bg-blue-strong2 vert-m">i</span>
					            		<spring:message code="wzwg.cmm.msg.MSG284" />
					            	</p>
									<ul>
										<c:forEach items="${contentsList }" var="list">
										<c:if test="${list.category eq 'schedule' }">
										<li class="wd33 wm50">
											<strong class="wd100 fl fs16 fw400 pl10 box-border"><c:out value="${list.layoutcntntsNm }"/>
												<p><c:out value="${list.layoutcntntsDc }"/></p>
											</strong>
											<div class="thumImg wd100 fl">
												<div class="wd100 fl">
													<c:choose>
														<c:when test="${paramVO.width eq '100' }"><img src="<c:out value="${list.thumbWPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>"></c:when>
														<c:when test="${paramVO.height eq 'H' }"><img src="<c:out value="${list.thumbHPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" ></c:when>
														<c:when test="${paramVO.height eq 'M' }"><img src="<c:out value="${list.thumbMPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" ></c:when>
														<c:when test="${paramVO.height eq 'L' }"><img src="<c:out value="${list.thumbLPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" ></c:when>
														<c:otherwise><img src="<c:out value="${list.thumbMPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:otherwise>
													</c:choose>
												</div>
												<div class="hoverLayer">
													<div class="wd100">
							   							<a href="javascript:void(0);" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');" class="circleRTxt">
							   								<span class="hoverbtn_circle closeUp"></span><spring:message code="wzwg.cmm.word.preview" /></a>
							   							<a href="javascript:void(0);" onclick="addLayoutContents('<c:out value="${list.sampleFileCours}${list.sampleFileNm }"/>', '<c:out value="${list.sampleFileCours}${list.sampleCssNm }"/>', 'CSS_<c:out value="${list.layoutcntntsSeq }"/>','<c:out value="${list.layoutcntntsNm }"/>')" class="circleRTxt">
							   								<span class="hoverbtn_circle add"></span><spring:message code="wzwg.cmm.word.add02" /></a>
							  						</div>
							  					</div>
											</div>
										</li>
										</c:if>
										</c:forEach>
									</ul>
								</div>
								</c:if>
								
								
								
								<c:if test="${(subPrefix eq '/subMngr' or subPrefix eq '/subsite') eq false }">
								<!-- 지도 탭 -->
								<div class="tab_item wd100 p0">
									<p class="prv_notice wd100 pt20 pb20 txt-c">
					            		<span class="circle_no bg-blue-strong2 vert-m">i</span>
					            		<spring:message code="wzwg.cmm.msg.MSG284" />
					            	</p>
									<ul>
										<c:forEach items="${contentsList }" var="list">
										<c:if test="${list.category eq 'map' }">
										<li class="wd33 wm50">
											<strong class="wd100 fl fs16 fw400 pl10 box-border"><c:out value="${list.layoutcntntsNm }"/>
												<p><c:out value="${list.layoutcntntsDc }"/></p>
											</strong>
											<div class="thumImg wd100 fl">
												<div class="wd100 fl">
													<c:choose>
														<c:when test="${paramVO.width eq '100' }"><img src="<c:out value="${list.thumbWPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>"></c:when>
														<c:when test="${paramVO.height eq 'H' }"><img src="<c:out value="${list.thumbHPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" ></c:when>
														<c:when test="${paramVO.height eq 'M' }"><img src="<c:out value="${list.thumbMPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" ></c:when>
														<c:when test="${paramVO.height eq 'L' }"><img src="<c:out value="${list.thumbLPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" ></c:when>
														<c:otherwise><img src="<c:out value="${list.thumbMPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:otherwise>
													</c:choose>
												</div>
												<div class="hoverLayer">
													<div class="wd100">
							   							<a href="javascript:void(0);" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');" class="circleRTxt">
							   								<span class="hoverbtn_circle closeUp"></span><spring:message code="wzwg.cmm.word.preview" /></a>
							   							<a href="javascript:void(0);" onclick="addLayoutContents('<c:out value="${list.sampleFileCours}${list.sampleFileNm }"/>', '<c:out value="${list.sampleFileCours}${list.sampleCssNm }"/>', 'CSS_<c:out value="${list.layoutcntntsSeq }"/>','<c:out value="${list.layoutcntntsNm }"/>')" class="circleRTxt">
							   								<span class="hoverbtn_circle add"></span><spring:message code="wzwg.cmm.word.add02" /></a>
							  						</div>
							  					</div>
											</div>
										</li>
										</c:if>
										</c:forEach>
									</ul>
								</div>
								</c:if>
			
			
			
								<!-- 표 탭 -->
								<%-- <div class="tab_item <c:out value="${tabItemClass }"/>">
									<h4>* <spring:message code="wzwg.cmm.msg.MSG248" />(<spring:message code="wzwg.cmm.msg.MSG284" />)</h4>
									<ul>
										<c:forEach items="${contentsList }" var="list">
										<c:if test="${list.category eq 'table' }">
										<li>
											<h4><c:out value="${list.layoutcntntsNm }"/></h4>
											<p><spring:message code="wzwg.cmm.word.chartstc" />: <c:out value="${list.layoutcntntsDc }"/></p>
											<!-- 썸네일이미지, 클릭시 확대 -->
											<a href="javascript:void(0);" >
												<div class="img_div">
												<c:choose>
													<c:when test="${paramVO.width eq '100' }"><img src="<c:out value="${list.thumbWPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:when test="${paramVO.height eq 'H' }"><img src="<c:out value="${list.thumbHPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:when test="${paramVO.height eq 'M' }"><img src="<c:out value="${list.thumbMPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:when test="${paramVO.height eq 'L' }"><img src="<c:out value="${list.thumbLPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:otherwise><img src="<c:out value="${list.thumbMPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:otherwise>
												</c:choose>
												</div>
											</a>
			
											<a href="javascript:;" onclick="addLayoutContents('<c:out value="${list.sampleFileCours}${list.sampleFileNm }"/>', '<c:out value="${list.sampleFileCours}${list.sampleCssNm }"/>', 'CSS_<c:out value="${list.layoutcntntsSeq }"/>')" class="btn-a"><spring:message code="wzwg.cmm.word.add02" /></a> <!-- 추가하기 -->
											<a href="javascript:void(0);" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');" class="big_btn" title="확대보기"><spring:message code="wzwg.cmm.word.preview" /></a> <!-- 돋보기버튼_ 클릭시 팝업 -->
										</li>
										</c:if>
										</c:forEach>
									</ul>
								</div>
								 --%>
								<!-- 쇼핑몰 탭 -->
								<%-- <div class="tab_item <c:out value="${tabItemClass }"/>">
									<h4>* <spring:message code="wzwg.cmm.msg.MSG248" />(<spring:message code="wzwg.cmm.msg.MSG284" />)</h4>
									<ul>
										<c:forEach items="${contentsList }" var="list">
										<c:if test="${list.category eq 'shop' }">
										<li>
											<h4><c:out value="${list.layoutcntntsNm }"/></h4>
											<p><spring:message code="wzwg.cmm.word.chartstc" />: <c:out value="${list.layoutcntntsDc }"/></p>
											<!-- 썸네일이미지, 클릭시 확대 -->
											<a href="javascript:void(0);" >
												<div class="img_div">
												<c:choose>
													<c:when test="${paramVO.width eq '100' }"><img src="<c:out value="${list.thumbWPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:when test="${paramVO.height eq 'H' }"><img src="<c:out value="${list.thumbHPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:when test="${paramVO.height eq 'M' }"><img src="<c:out value="${list.thumbMPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:when test="${paramVO.height eq 'L' }"><img src="<c:out value="${list.thumbLPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:otherwise><img src="<c:out value="${list.thumbMPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:otherwise>
												</c:choose>
												</div>
											</a>
			
											<a href="javascript:;" onclick="addLayoutContents('<c:out value="${list.sampleFileCours}${list.sampleFileNm }"/>', '<c:out value="${list.sampleFileCours}${list.sampleCssNm }"/>', 'CSS_<c:out value="${list.layoutcntntsSeq }"/>')" class="btn-a"><spring:message code="wzwg.cmm.word.add02" /></a> <!-- 추가하기 -->
											<a href="javascript:void(0);" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');" class="big_btn" title="확대보기"><spring:message code="wzwg.cmm.word.preview" /></a> <!-- 돋보기버튼_ 클릭시 팝업 -->
										</li>
										</c:if>
										</c:forEach>
									</ul>
								</div> --%>
			
			
			
								<!-- 기타 탭 -->
								<div class="tab_item wd100 p0">
									<p class="prv_notice wd100 pt20 pb20 txt-c">
					            		<span class="circle_no bg-blue-strong2 vert-m">i</span>
					            		<spring:message code="wzwg.cmm.msg.MSG284" />
					            	</p>
									<ul>
										<c:forEach items="${contentsList }" var="list">
										<c:if test="${list.category eq 'etc' }">
										<li class="wd33 wm50">
											<strong class="wd100 fl fs16 fw400 pl10 box-border"><c:out value="${list.layoutcntntsNm }"/>
												<p><c:out value="${list.layoutcntntsDc }"/></p>
											</strong>
											<div class="thumImg wd100 fl">
												<div class="wd100 fl">
													<c:choose>
														<c:when test="${paramVO.width eq '100' }"><img src="<c:out value="${list.thumbWPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>"></c:when>
														<c:when test="${paramVO.height eq 'H' }"><img src="<c:out value="${list.thumbHPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" ></c:when>
														<c:when test="${paramVO.height eq 'M' }"><img src="<c:out value="${list.thumbMPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" ></c:when>
														<c:when test="${paramVO.height eq 'L' }"><img src="<c:out value="${list.thumbLPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" ></c:when>
														<c:otherwise><img src="<c:out value="${list.thumbMPath }"/>" id="imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:otherwise>
													</c:choose>
												</div>
												<div class="hoverLayer">
													<div class="wd100">
							   							<a href="javascript:void(0);" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');" class="circleRTxt">
							   								<span class="hoverbtn_circle closeUp"></span><spring:message code="wzwg.cmm.word.preview" /></a>
							   							<a href="javascript:void(0);" onclick="addLayoutContents('<c:out value="${list.sampleFileCours}${list.sampleFileNm }"/>', '<c:out value="${list.sampleFileCours}${list.sampleCssNm }"/>', 'CSS_<c:out value="${list.layoutcntntsSeq }"/>','<c:out value="${list.layoutcntntsNm }"/>')" class="circleRTxt">
							   								<span class="hoverbtn_circle add"></span><spring:message code="wzwg.cmm.word.add02" /></a>
							  						</div>
							  					</div>
											</div>
										</li>
										</c:if>
										</c:forEach>
									</ul>
								</div>
			
			
					
					     </div>
			
			
			