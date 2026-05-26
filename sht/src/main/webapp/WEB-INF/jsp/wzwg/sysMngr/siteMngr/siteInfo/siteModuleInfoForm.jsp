<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script type="text/javascript" src="/js/egovframework/com/cmm/fms/EgovMultiFile.js" ></script>

<script type="text/javascript">

	$(document).ready(function(){
	    $('.checkall').click(function(){
	        if($('.checkall').prop('checked')){
	            $('input[name=sysmoduleSeqArr]').prop('checked', true);
	        }else{
	            $('input[name=sysmoduleSeqArr]').prop('checked', false);
	        }
	    }); 
	});
	
	function fnSiteModuleRegist() { 
		var frm = document.frmReg;
	    frm.action="<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/registSiteModuleInfo.do";
	    frm.submit();
	}

</script>

		<c:choose>
			<c:when test="${!empty paramVO.siteSeq}">
				<jsp:include page="/WEB-INF/jsp/wzwg/sysMngr/siteMngr/siteInfo/siteInfoTab.jsp"></jsp:include>
			</c:when>
			<c:otherwise>
				<h3 class="table_tit"><spring:message code="wzwg.sysMngr.word.siteDomnInfo" /></h3>
			</c:otherwise>
		</c:choose>	         
	                 
		<!--//게시판 설정 table -->
		<form id="frmReg" name="frmReg" method="post">
			<input type="hidden" id="siteSeq" name="siteSeq" value="<c:out value="${paramVO.siteSeq}" />" />
	          
			<div class="wzForm smdWrap">
				<input type="checkbox" id="checkall" name="checkall" value="" class="checkall">
				<label for="checkall"><spring:message code="wzwg.module.word.allchoise" /></label>
				
				<!-- 컨텐츠 -->
				<h3 class="wzAdmSTit wd100 mt15"><spring:message code="wzwg.cmm.word.cntnts" /></h3>
				<ul class="smdList">
					<c:forEach items="${resultList}" var="resultList" varStatus="status">
					<c:if test="${resultList.moduleTyCode eq 'SC00000032'}">
					<li class="menu">
						<label>
							<input type="checkbox" id="sysmoduleSeqArr" name="sysmoduleSeqArr" class="chkDomnSeq" <c:if test="${resultList.moduleCnt > 0 }">checked="checked" </c:if> value="<c:out value="${resultList.sysmoduleSeq}" />">
							<div class="iconbox cntnts"></div>
							<div class="tit">
							 <c:if test="${sessionScope.LANG eq 'SC00000016' }">
								<c:out value="${resultList.moduleNm}" />
							 </c:if>
							 <c:if test="${sessionScope.LANG ne 'SC00000016' }">
								<c:out value="${resultList.moduleNmEng}" />
							 </c:if>
							</div>
							<div class="selbox"></div>
						</label>
					</li>
					</c:if>
					</c:forEach>
				</ul>
				
				<!-- 컨텐츠 -->
				<h3 class="wzAdmSTit wd100 mt15"><spring:message code="wzwg.cmm.word.bbs" /></h3>
				<ul class="smdList">
					<c:forEach items="${resultList}" var="resultList" varStatus="status">
					<c:if test="${resultList.moduleTyCode eq 'SC00000030'}">
					<li class="menu">
						<label>
							<input type="checkbox" id="sysmoduleSeqArr" name="sysmoduleSeqArr" class="chkDomnSeq" <c:if test="${resultList.moduleCnt > 0 }">checked="checked" </c:if> value="<c:out value="${resultList.sysmoduleSeq}" />">
							<div class="iconbox cntnts"></div>
							<div class="tit">
							 <c:if test="${sessionScope.LANG eq 'SC00000016' }">
								<c:out value="${resultList.moduleNm}" />
							 </c:if>
							 <c:if test="${sessionScope.LANG ne 'SC00000016' }">
								<c:out value="${resultList.moduleNmEng}" />
							 </c:if>
							</div>
							<div class="selbox"></div>
						</label>
					</li>
					</c:if>
					</c:forEach>
				</ul>
				
				<!-- 컨텐츠 -->
				<h3 class="wzAdmSTit wd100 mt15"><spring:message code="wzwg.cmm.word.etc" /></h3>
				<ul class="smdList">
					<c:forEach items="${resultList}" var="resultList" varStatus="status">
					<c:if test="${resultList.moduleTyCode ne 'SC00000030' and resultList.moduleTyCode ne 'SC00000032'}">
					<li class="menu">
						<label>
							<input type="checkbox" id="sysmoduleSeqArr" name="sysmoduleSeqArr" class="chkDomnSeq" <c:if test="${resultList.moduleCnt > 0 }">checked="checked"</c:if> value="<c:out value="${resultList.sysmoduleSeq}" />">
							<div class="iconbox cntnts"></div>
							<div class="tit">
								 <c:if test="${sessionScope.LANG eq 'SC00000016' }">
								<c:out value="${resultList.moduleNm}" />
							 </c:if>
							 <c:if test="${sessionScope.LANG ne 'SC00000016' }">
								<c:out value="${resultList.moduleNmEng}" />
							 </c:if>
							</div>
							<div class="selbox"></div>
						</label>
					</li>
					</c:if>
					</c:forEach>
				</ul>
			
			</div>
	
		</form>
		
		<c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
		<div class="rt-box">
			<button onclick="fnSiteModuleRegist(); return false;" class="wzbtn btn-basic"><spring:message code="wzwg.sysMngr.word.choiseRegist" /></button>
		</div> 
		</c:if>	
           
