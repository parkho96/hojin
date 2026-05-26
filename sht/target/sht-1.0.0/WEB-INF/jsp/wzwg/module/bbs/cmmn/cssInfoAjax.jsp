<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />

<script type="text/javascript">
	function fnCssPrevewPop(cssSeq){
		var frm = document.regForm;
		frm.cssSeq.value = cssSeq;
		
		var frmResult = window.open("", "popForm", "width=800,height=600,toolbars=no,menubars=no,scrollbars=yes");
		
		frm.target='popForm';
		frm.action='<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/cmmn/selectCssPrevewPopup.do';
		frm.submit();
	}
	
	function fnBbsFormImgPrevewPop(img){
		console.log(img);
		var viewImg = new Image();
		$(viewImg).attr('src', img.attr('src'));
		var imgsrc = img.attr('src');
		//var imgsrc = $(img).attr('src');

		
//		var width = $(img)[0].naturalWidth;
//		var height = $(img)[0].naturalHeight;
		var width = $(viewImg)[0].naturalWidth;
		var height = $(viewImg)[0].naturalHeight;
		var frm = document.regForm;
		if(!document.regForm.imgSrc){
			var imgSrc = '<input type="hidden" name="imgSrc"/>';
			$('#regForm').append(imgSrc);
		}
		frm.imgSrc.value = imgsrc;
		
		
		var frmResult = window.open("", "popForm", "width=" + width + ",height=" + height + ",toolbars=no,menubars=no,scrollbars=yes,left=50,top=400");
		
		frm.target='popForm';
		frm.action='/sample/img/imgViewer.jsp';
		frm.submit();
	}
	</script>

	<c:if test="${not empty moduleBbsCssVO}">

	<div class="template">

		<div class="pd20">
			<h4><c:out value='${moduleBbsCssVO.cssNm}'/></h4>
			<div class="tem-img pb20">
				<div>
					<c:choose>
						<c:when test="${param.listScrinCode eq 'L'}">
							<a href="javascript:void(0);" onclick="fnBbsFormImgPrevewPop($(this).find('img'))">
								<c:if test="${moduleBbsCssVO.sysmoduleSeq eq '10000000003'}">
									<img src='<c:out value="${moduleBbsCssVO.prevewPath}"/>' id="orgImg" style="width:250px;"/>
								</c:if>
								<c:if test="${moduleBbsCssVO.sysmoduleSeq eq '10000000218'}">
									<img src='<c:out value="${moduleBbsCssVO.cssPath}"/>/linkBoard_list.jpg' id="orgImg" style="width:250px;"/>
								</c:if>
							</a>
						</c:when>
						<c:when test="${param.listScrinCode eq 'I'}">
							<a href="javascript:void(0);" onclick="fnBbsFormImgPrevewPop($(this).find('img'))">
								<c:if test="${moduleBbsCssVO.sysmoduleSeq eq '10000000003'}">
									<img src='<c:out value="${moduleBbsCssVO.cssPath}"/>/album.jpg' id="orgImg" style="width:250px;"/>
								</c:if>
								<c:if test="${moduleBbsCssVO.sysmoduleSeq eq '10000000218'}">
									<img src='<c:out value="${moduleBbsCssVO.cssPath}"/>/linkBoard_album.jpg' id="orgImg" style="width:250px;"/>
								</c:if>
							</a>
						</c:when>
						<c:when test="${param.listScrinCode eq 'E'}">
							<a href="javascript:void(0);" onclick="fnBbsFormImgPrevewPop($(this).find('img'))">
								<c:if test="${moduleBbsCssVO.sysmoduleSeq eq '10000000003'}">
									<img src='<c:out value="${moduleBbsCssVO.cssPath}"/>/event.jpg' id="orgImg" style="width:250px;"/>
								</c:if>
								<c:if test="${moduleBbsCssVO.sysmoduleSeq eq '10000000218'}">
									<img src='<c:out value="${moduleBbsCssVO.cssPath}"/>/linkBoard_event.jpg' id="orgImg" style="width:250px;"/>
								</c:if>
							</a>
						</c:when>
						<c:when test="${param.listScrinCode eq 'W'}">
							<a href="javascript:void(0);" onclick="fnBbsFormImgPrevewPop($(this).find('img'))">
								<img src='<c:out value="${moduleBbsCssVO.cssPath}"/>/webzine.jpg' id="orgImg" style="width:250px;"/>
							</a>
						</c:when>
						<c:when test="${param.listScrinCode eq 'B'}">
							<a href="javascript:void(0);" onclick="fnBbsFormImgPrevewPop($(this).find('img'))">
								<img src='<c:out value="${moduleBbsCssVO.cssPath}"/>/blog.jpg' id="orgImg" style="width:250px;"/>
							</a>
						</c:when>
						<c:otherwise>
							<a href="javascript:void(0);" onclick="fnCssPrevewPop('<c:out value="${moduleBbsCssVO.cssSeq}"/>');">
								<img src='<c:out value="${moduleBbsCssVO.prevewPath}"/>' id="orgImg" style="width:250px;"/>
							</a>
						</c:otherwise>
					</c:choose>
					
				</div>
			</div>
			<div class="tem-list">
				<div class="lt-box">
					<a href="javascript:void(0);" onclick="fnCntntsStylePopup();" class="wzbtn btn-edit"><spring:message code="wzwg.cmm.word.change" text="change" /></a> 
				</div>				
			</div>
		</div>

	</div> 
	
	</c:if>
	<%-- ${param.listScrinCode} --%>
	<c:if test="${empty moduleBbsCssVO}">
		<div class="pd20">
			<div>
				<spring:message code="wzwg.cmm.msg.MSG299" />
			</div>
			<div class="lt-box">
				<a href="javascript:void(0);" onclick="fnCntntsStylePopup();" class="wzbtn btn-edit"><spring:message code="wzwg.cmm.word.change" text="change" /></a> 
			</div>				
		</div>	
	</c:if>
	
	
	