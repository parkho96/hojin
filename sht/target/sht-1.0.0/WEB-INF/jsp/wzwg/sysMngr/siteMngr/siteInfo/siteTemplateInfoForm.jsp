<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script type="text/javascript" src="/js/egovframework/com/cmm/fms/EgovMultiFile.js" ></script>

<script type="text/javascript">

	$(document).ready(function(){
	    $('.checkall').click(function(){
	        if($('.checkall').prop('checked')){
	            $('input[name=templateSeqArr]').prop('checked', true);
	        }else{
	            $('input[name=templateSeqArr]').prop('checked', false);
	        }
	    });

	    $('#layout_all').click('on', function() {
			$('input[name=layoutSeCode]').val('');
			$('input[name=code]').val('');
			fn_search();
		});
	    
	    $('input[name=templateSeqArr]').each(function() {
	    	if(this.checked == true) {
	    		$("#templateChkArr_"+$(this).val()).val("Y");
	    	}else{
	    		$("#templateChkArr_"+$(this).val()).val("N");
	    	}
	    });

	});
	
	function fnRegist() { 
		var frm = document.regFrm;
		
		if("<c:out value="${paramVO.code}" />" != ""){
			var seqArr = "";
			var chkArr = "";
			
			$('input[name=templateSeqArr]').each(function() {
				if(this.checked == true) {
					seqArr += $(this).val() + ",";
					chkArr += "Y" + ",";
		    	}else{
		    		seqArr += $(this).val() + ",";
					chkArr += "N" + ",";
		    	}
		    });
			
			frm.chkTemplateSeqArr.value = seqArr;
			frm.chkTemplateChkArr.value = chkArr;
		}
				
	    frm.action="<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/registSiteTemplateInfo.do";
	    frm.submit();
	}

	function fn_search(){
		var frm = document.regFrm;
	    frm.action="<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectSiteTemplateInfoForm.do";
	    frm.submit();
	}
	
	function fn_templatChk(idx, templatSeq){
		if(idx.checked == true){
			$("#templateChkArr_"+templatSeq).val("Y");
		}else{
			$("#templateChkArr_"+templatSeq).val("N");	
		}
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
		<form id="regFrm" name="regFrm" method="post">
			<input type="hidden" id="siteSeq" name="siteSeq" value="<c:out value="${paramVO.siteSeq}" />" />
			<input type="hidden" id="chkTemplateSeqArr" name="chkTemplateSeqArr" />
			<input type="hidden" id="chkTemplateChkArr" name="chkTemplateChkArr" />
			
			<div class="admDesignSet">
				<div class="ctgryBox mb50">
					<div class="mainTemCtgryWrap">
						<ul>
							<li>
								<button id="layout_all" type="button" class="ctgryBtn ctgryBtnAll<c:if test="${empty paramVO.code and empty paramVO.layoutSeCode}"> on</c:if>"><spring:message code="wzwg.cmm.word.all" /></button>
							</li>
							<c:forEach items="${templateCtgryCode}" var="codeList">
							<li>
								<%-- <input type="radio" name="code" id="<c:out value="${codeList.codeAbrvNm}_${codeList.code}" />" value="${codeList.code}" onclick="fn_search();" <c:if test="${codeList.code eq paramVO.code }">checked="checked"</c:if>> --%>

								<input type="radio" name="code" id="<c:out value="${codeList.codeAbrvNm}_${codeList.code}" />" value="<c:out value="${codeList.code}" />" onclick="fn_search();"<c:if test="${codeList.code eq paramVO.code}">checked="checked"</c:if> />
								
								<label for="<c:out value="${codeList.codeAbrvNm}_${codeList.code}" />" class="ctgryBtn">#<c:out value="${codeList.codeNm}"/>
									<c:if test="${fn:indexOf(codeList.codeAbrvNm, 'layout') > -1}">
									<div class="menu_help">
										<span class="circle_no bg-grey blue fw600">?</span>
										<div class="help_pop">
											<img src="/images/wzwg/site/mngr/layout/2020_<c:out value="${codeList.codeAbrvNm}" />.png" alt="" class="fl">
											<c:if test="${codeList.codeAbrvNm eq 'layout1' }"><span><spring:message code="wzwg.cmm.msg.tip.MSG144" /></span></c:if>
											<c:if test="${codeList.codeAbrvNm eq 'layout2' }"><span><spring:message code="wzwg.cmm.msg.tip.MSG145" /></span></c:if>
											<c:if test="${codeList.codeAbrvNm eq 'layout3' }"><span><spring:message code="wzwg.cmm.msg.tip.MSG146" /></span></c:if>
											<c:if test="${codeList.codeAbrvNm eq 'layout6' }"><span><spring:message code="wzwg.cmm.msg.tip.MSG147" /></span></c:if>
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
								<input type="radio" name="layoutSeCode" id="<c:out value="${layout.codeAbrvNm}_${layout.code}" />" value="<c:out value="${layout.code}" />" onclick="fn_search();" <c:if test="${layout.code eq paramVO.layoutSeCode }">checked="checked"</c:if>>
								<label for="<c:out value="${layout.codeAbrvNm}_${layout.code}" />" class="ctgryBtn">
									<c:if test="${layout.codeAbrvNm eq 'layout1' }">#<spring:message code="wzwg.sysMngr.word.gnrlTy02" /></c:if>
									<c:if test="${layout.codeAbrvNm eq 'layout2' }">#<spring:message code="wzwg.sysMngr.word.left01MenuTy02" /></c:if>
									<c:if test="${layout.codeAbrvNm eq 'layout3' }">#<spring:message code="wzwg.sysMngr.word.wideTy02" /></c:if>
									<c:if test="${layout.codeAbrvNm eq 'layout6' }">#<spring:message code="wzwg.sysMngr.word.cmpndTy02" /></c:if>
									<div class="menu_help">
										<span class="circle_no bg-grey blue fw600">?</span>
										<div class="help_pop">
											<img src="/images/wzwg/site/mngr/layout/2020_<c:out value="${layout.codeAbrvNm}" />.png" alt="" class="fl">
											<c:if test="${layout.codeAbrvNm eq 'layout1' }"><span><spring:message code="wzwg.cmm.msg.tip.MSG144" /></span></c:if>
											<c:if test="${layout.codeAbrvNm eq 'layout2' }"><span><spring:message code="wzwg.cmm.msg.tip.MSG145" /></span></c:if>
											<c:if test="${layout.codeAbrvNm eq 'layout3' }"><span><spring:message code="wzwg.cmm.msg.tip.MSG146" /></span></c:if>
											<c:if test="${layout.codeAbrvNm eq 'layout6' }"><span><spring:message code="wzwg.cmm.msg.tip.MSG147" /></span></c:if>
										</div>
									</div>
								</label>
							</li>
							</c:forEach>
						</ul>
				      
					</div>
				</div>
			</div>
			<!-- /템플릿 종류 -->
			
			<div class="wzForm smdWrap">
				<input type="checkbox" id="checkall" name="checkall" value="" class="checkall">
				<label for="checkall"><spring:message code="wzwg.sysMngr.word.allSelect" /></label>
			
				<!-- 템플릿 목록 -->
				<c:if test="${not empty templtList }">
					<ul class="tmpltList">
					<c:forEach items="${templtList}" var="templtList" varStatus="status"> 
					<li class="item fs14">
						<label>
							<input type="checkbox" name="templateSeqArr" id="templateSeqArr_<c:out value="${templtList.templateSeq}" />" <c:if test="${templtList.templateCnt > 0 }">checked="checked"</c:if> value="<c:out value="${templtList.templateSeq}" />" onclick="fn_templatChk(this, '<c:out value="${templtList.templateSeq}" />');"> <span><c:out value="${templtList.templateNm}" /></span>
							<input type="hidden" name="templateChkArr" id="templateChkArr_<c:out value="${templtList.templateSeq}" />" />
							 
							<div class="thumb">
								<img src="/<c:out value="${templtList.templateStreCours }" />screenshot/thumb_<c:out value="${templtList.thumbUrl}" />">
							</div>
							
							<div class="btnZoom"></div>
							
							<div class="zoomImg">
								<img src="/<c:out value="${templtList.templateStreCours }" />screenshot/thumb_<c:out value="${templtList.thumbUrl}" />">
							</div>
						</label>
					</li>
					</c:forEach>
					</ul>
				</c:if>
				
				<c:if test="${empty templtList }">
					<p class="txt-c"><spring:message code="wzwg.cmm.msg.MSG097" /></p>
				</c:if>
				<!-- /템플릿 목록 -->
			
			</div>
						
		</form>
		
		<c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
		<div class="rt-box">
			<button onclick="fnRegist(); return false;" class="wzbtn btn-basic"><spring:message code="wzwg.sysMngr.word.choiseRegist" /></button>
		</div> 
		</c:if>	
           
