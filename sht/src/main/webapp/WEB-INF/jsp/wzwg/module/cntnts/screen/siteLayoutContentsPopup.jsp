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
								

			
						 <div id="addContentPopup" class="pop-tab">
					            <input id="ctnt_banner" type="radio" name="tab" checked="checked"/>
					            <input id="ctnt_rolling" type="radio" name="tab" />
					            <input id="ctnt_quick" type="radio" name="tab" />
					            <input id="ctnt_etc" type="radio" name="tab" />
					            <section class="buttons">
					                <label for="ctnt_banner"><spring:message code="wzwg.cmm.cntnts.banner" /></label>
					                <label for="ctnt_rolling"><spring:message code="wzwg.cmm.cntnts.slidebanner" /></label>
					                <label for="ctnt_quick"><spring:message code="wzwg.cmm.cntnts.quickmenu" /></label>
					                <label for="ctnt_etc"><spring:message code="wzwg.cmm.cntnts.etc" /></label>
					            </section>
					            
								<c:choose>
									<c:when test="${paramVO.width eq '100'}"><c:set var="tabItemClass">item_for_1</c:set></c:when>
									<c:otherwise><c:set var="tabItemClass">item_for_234</c:set></c:otherwise>
								</c:choose>
								
								<!-- 일반게시판 탭 -->
			
			
			
								<!-- 배너 탭 -->
								<div class="tab_item <c:out value='${tabItemClass }'/>">
									<h4>* <spring:message code="wzwg.cmm.msg.MSG248" />(<spring:message code="wzwg.cmm.msg.MSG284" />)</h4>
									<ul>
										<c:forEach items="${contentsList }" var="list">
										<c:if test="${list.category eq 'banner' }">
										<li>
											<h4><c:out value='${list.layoutcntntsNm }'/></h4>
											<p><spring:message code="wzwg.cmm.word.chartstc" />: <c:out value='${list.layoutcntntsDc }'/></p>
											<!-- 썸네일이미지, 클릭시 확대 -->
											<a href="javascript:void(0);" >
												<div class="img_div">
												<c:choose>
													<c:when test="${paramVO.width eq '100' }"><img src="<c:out value='${list.thumbWPath }'/>" id="imb_thumb_<c:out value='${list.layoutcntntsSeq }'/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:when test="${paramVO.height eq 'H' }"><img src="<c:out value='${list.thumbHPath }'/>" id="imb_thumb_<c:out value='${list.layoutcntntsSeq }'/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:when test="${paramVO.height eq 'M' }"><img src="<c:out value='${list.thumbMPath }'/>" id="imb_thumb_<c:out value='${list.layoutcntntsSeq }'/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:when test="${paramVO.height eq 'L' }"><img src="<c:out value='${list.thumbLPath }'/>" id="imb_thumb_<c:out value='${list.layoutcntntsSeq }'/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:otherwise><img src="<c:out value='${list.thumbMPath }'/>" id="imb_thumb_<c:out value='${list.layoutcntntsSeq }'/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:otherwise>
												</c:choose>
												</div>
											</a>
			
											<div class="btnbox-l  wd100">
												<a href="javascript:;" onclick="addLayoutContents('<c:out value="${list.sampleFileCours}${list.sampleFileNm }"/>', '<c:out value="${list.sampleFileCours}${list.sampleCssNm }"/>', 'CSS_<c:out value="${list.layoutcntntsSeq }"/>')" class="wzbtn-table btn-edit"><spring:message code="wzwg.cmm.word.add02" /></a> <!-- 추가하기 -->
												<a href="javascript:void(0);" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');" class="wzbtn-table btn-basic"><spring:message code="wzwg.cmm.word.preview" /></a> <!-- 돋보기버튼_ 클릭시 팝업 -->
											</div>
										</li>
										</c:if>
										</c:forEach>
									</ul>
								</div>
			
			
			
								<!-- 롤링이미지 탭 -->
								<div class="tab_item <c:out value='${tabItemClass }'/>">
									<h4>* <spring:message code="wzwg.cmm.msg.MSG248" />(<spring:message code="wzwg.cmm.msg.MSG284" />)</h4>
									<ul>
										<c:forEach items="${contentsList }" var="list">
										<c:if test="${list.category eq 'rolling' }">
										<li>
											<h4><c:out value="${list.layoutcntntsNm }"/></h4>
											<p><spring:message code="wzwg.cmm.word.chartstc" />: <c:out value="${list.layoutcntntsDc }"/></p>
											<!-- 썸네일이미지, 클릭시 확대 -->
											<a href="javascript:void(0);" >
												<div class="img_div">
												<c:choose>
													<c:when test="${paramVO.width eq '100' }"><img src="<c:out value='${list.thumbWPath }'/>" id="imb_thumb_<c:out value='${list.layoutcntntsSeq }'/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:when test="${paramVO.height eq 'H' }"><img src="<c:out value='${list.thumbHPath }'/>" id="imb_thumb_<c:out value='${list.layoutcntntsSeq }'/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:when test="${paramVO.height eq 'M' }"><img src="<c:out value='${list.thumbMPath }'/>" id="imb_thumb_<c:out value='${list.layoutcntntsSeq }'/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:when test="${paramVO.height eq 'L' }"><img src="<c:out value='${list.thumbLPath }'/>" id="imb_thumb_<c:out value='${list.layoutcntntsSeq }'/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:otherwise><img src="<c:out value='${list.thumbMPath }'/>" id="imb_thumb_<c:out value='${list.layoutcntntsSeq }'/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:otherwise>
												</c:choose>
												</div>
											</a>
			
											<div class="btnbox-l  wd100">
												<a href="javascript:;" onclick="addLayoutContents('<c:out value="${list.sampleFileCours}${list.sampleFileNm }"/>', '<c:out value="${list.sampleFileCours}${list.sampleCssNm }"/>', 'CSS_<c:out value="${list.layoutcntntsSeq }"/>')" class="wzbtn-table btn-edit"><spring:message code="wzwg.cmm.word.add02" /></a> <!-- 추가하기 -->
												<a href="javascript:void(0);" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');" class="wzbtn-table btn-basic" title="<spring:message code="wzwg.module.word.expansnview" />"><spring:message code="wzwg.cmm.word.preview" /></a> <!-- 돋보기버튼_ 클릭시 팝업 -->
											</div>
										</li>
										</c:if>
										</c:forEach>
									</ul>
								</div>
			
			
			
								<!-- 퀵메뉴 탭 -->
								<div class="tab_item <c:out value='${tabItemClass }'/>">
									<h4>* <spring:message code="wzwg.cmm.msg.MSG248" />(<spring:message code="wzwg.cmm.msg.MSG284" />)</h4>
									<ul>
										<c:forEach items="${contentsList }" var="list">
										<c:if test="${list.category eq 'quick' }">
										<li>
											<h4><c:out value="${list.layoutcntntsNm }"/></h4>
											<p><spring:message code="wzwg.cmm.word.chartstc" />: <c:out value="${list.layoutcntntsDc }"/></p>
											<!-- 썸네일이미지, 클릭시 확대 -->
											<a href="javascript:void(0);" >
												<div class="img_div">
												<c:choose>
													<c:when test="${paramVO.width eq '100' }"><img src="<c:out value='${list.thumbWPath }'/>" id="imb_thumb_<c:out value='${list.layoutcntntsSeq }'/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:when test="${paramVO.height eq 'H' }"><img src="<c:out value='${list.thumbHPath }'/>" id="imb_thumb_<c:out value='${list.layoutcntntsSeq }'/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:when test="${paramVO.height eq 'M' }"><img src="<c:out value='${list.thumbMPath }'/>" id="imb_thumb_<c:out value='${list.layoutcntntsSeq }'/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:when test="${paramVO.height eq 'L' }"><img src="<c:out value='${list.thumbLPath }'/>" id="imb_thumb_<c:out value='${list.layoutcntntsSeq }'/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:otherwise><img src="<c:out value='${list.thumbMPath }'/>" id="imb_thumb_<c:out value='${list.layoutcntntsSeq }'/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:otherwise>
												</c:choose>
												</div>
											</a>
			
											<div class="btnbox-l  wd100">
												<a href="javascript:;" onclick="addLayoutContents('<c:out value="${list.sampleFileCours}${list.sampleFileNm }"/>', '<c:out value="${list.sampleFileCours}${list.sampleCssNm }"/>', 'CSS_<c:out value="${list.layoutcntntsSeq }"/>')" class="wzbtn-table btn-edit"><spring:message code="wzwg.cmm.word.add02" /></a> <!-- 추가하기 -->
												<a href="javascript:void(0);" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');" class="wzbtn-table btn-basic" title="<spring:message code="wzwg.module.word.expansnview" />"><spring:message code="wzwg.cmm.word.preview" /></a> <!-- 돋보기버튼_ 클릭시 팝업 -->
											</div>
										</li>
										</c:if>
										</c:forEach>
									</ul>
								</div>
								
								
			
			
			
								<!-- 기타 탭 -->
								<div class="tab_item <c:out value='${tabItemClass }'/>">
									<h4>* <spring:message code="wzwg.cmm.msg.MSG248" />(<spring:message code="wzwg.cmm.msg.MSG284" />)</h4>
									<ul>
										<c:forEach items="${contentsList }" var="list">
										<c:if test="${list.category eq 'etc' }">
										<li>
											<h4><c:out value="${list.layoutcntntsNm }"/></h4>
											<p><spring:message code="wzwg.cmm.word.chartstc" />: <c:out value="${list.layoutcntntsDc }"/></p>
											<!-- 썸네일이미지, 클릭시 확대 -->
											<a href="javascript:void(0);" >
												<div class="img_div">
												<c:choose>
													<c:when test="${paramVO.width eq '100' }"><img src="<c:out value='${list.thumbWPath }'/>" id="imb_thumb_<c:out value='${list.layoutcntntsSeq }'/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:when test="${paramVO.height eq 'H' }"><img src="<c:out value='${list.thumbHPath }'/>" id="imb_thumb_<c:out value='${list.layoutcntntsSeq }'/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:when test="${paramVO.height eq 'M' }"><img src="<c:out value='${list.thumbMPath }'/>" id="imb_thumb_<c:out value='${list.layoutcntntsSeq }'/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:when test="${paramVO.height eq 'L' }"><img src="<c:out value='${list.thumbLPath }'/>" id="imb_thumb_<c:out value='${list.layoutcntntsSeq }'/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:when>
													<c:otherwise><img src="<c:out value='${list.thumbMPath }'/>" id="imb_thumb_<c:out value='${list.layoutcntntsSeq }'/>" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');"></c:otherwise>
												</c:choose>
												</div>
											</a>
			
											<div class="btnbox-l  wd100">
												<a href="javascript:;" onclick="addLayoutContents('<c:out value="${list.sampleFileCours}${list.sampleFileNm }"/>', '<c:out value="${list.sampleFileCours}${list.sampleCssNm }"/>', 'CSS_<c:out value="${list.layoutcntntsSeq }"/>')" class="wzbtn-table btn-edit"><spring:message code="wzwg.cmm.word.add02" /></a> <!-- 추가하기 -->
												<a href="javascript:void(0);" onclick="fnImgPrevewPop('imb_thumb_<c:out value="${list.layoutcntntsSeq }"/>');" class="wzbtn-table btn-basic" title="<spring:message code="wzwg.module.word.expansnview" />"><spring:message code="wzwg.cmm.word.preview" /></a> <!-- 돋보기버튼_ 클릭시 팝업 -->
											</div>
										</li>
										</c:if>
										</c:forEach>
										
										<%-- 테스트 테이블 --%>
										<li>
											<h4>테스트 테이블</h4>
											<p><spring:message code="wzwg.cmm.word.chartstc" />: 개발테스트용</p>
											<!-- 썸네일이미지, 클릭시 확대 -->
											<a href="javascript:void(0);" >
												<div class="img_div">
												<img src="/sample/layout/subContents/table/test01/250_timetable01.jpg" id="imb_thumb_aa" onclick="fnImgPrevewPop('imb_thumb_aa');">
												</div>
											</a>
			
											<div class="btnbox-l  wd100">
												<a href="javascript:;" onclick="addLayoutContents('/sample/layout/subContents/table/test01/tabletest01.html', '/sample/layout/subContents/table/test01/css/tabletest01.css', 'CSS_tabletest01')" class="wzbtn-table btn-edit"><spring:message code="wzwg.cmm.word.add02" /></a> <!-- 추가하기 -->
												<a href="javascript:void(0);" onclick="fnImgPrevewPop('imb_thumb_aa');" class="wzbtn-table btn-basic" title="<spring:message code="wzwg.module.word.expansnview" />"><spring:message code="wzwg.cmm.word.preview" /></a> <!-- 돋보기버튼_ 클릭시 팝업 -->
											</div>
										</li>
										
									</ul>
								</div>
			
			
					
					     </div>
			
			
			