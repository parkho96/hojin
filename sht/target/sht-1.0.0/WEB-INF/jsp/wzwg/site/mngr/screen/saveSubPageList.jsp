<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 

<script>
	$(document).ready(function(){
		$('input[name="subMenuSeq"]').on('change', function(){
			var inpType = $(this).attr('data-type');
			
			//console.log($(this).attr('data-type'));
			
			if(inpType == 'group'){
				//console.log($(this).parent().next());
				var mngrp = $(this).parent().next();
				var thisChk = $(this).is(":checked");
				mngrp.find('input[name="subMenuSeq"]').prop("checked", thisChk);
			}
		})
	});
	
	function fnSubpageSaveSend(){
		var subMenuSeqs = new Array();
		
		$('input[name="subMenuSeq"]').each(function(){
			if($(this).is(":checked")){
				subMenuSeqs.push($(this).val());
			}
		});

		var finalMenuSeqs = [];
		// 중복제거
		$.each(subMenuSeqs,function(i,value){
		    if(finalMenuSeqs.indexOf(value) == -1 ) finalMenuSeqs.push(value);
		});

		var usrSubChek = $('input[name="chkUsrSubEdit"]').is(":checked");
		if(finalMenuSeqs.length == 0 && usrSubChek == false){
			alert('<spring:message code="wzwg.site.screen.msg.MSG191"/>');
			return;
		}
		//console.log(finalMenuSeqs.join());
		$('#subMenuSeqs').val(finalMenuSeqs.join());

		if(usrSubChek){
			$('#usrSubEdit').val("Y");
		}else{
			$('#usrSubEdit').val("N");
		}
		getSave(); //부모 페이지 스크립트 호출
	}
</script>

	<div class="mngrSaveSubPageList">
		   <c:choose>
					<c:when test="${subPrefix eq '/subMngr' or subPrefix eq '/subsite' }">
							<c:set var="menuLength">0</c:set>
							 <ul class="dep01">
							   <c:forEach items="${menuList}" var="oneDepth" varStatus="status">
							   <c:if test="${empty oneDepth.upperMenuSeq or oneDepth.upperMenuSeq eq '0' }">
								<li class="topMenuItem <c:if test="${oneDepth.menuDivision eq 'group' }">mnGroup</c:if>" data-test="<c:out value="${oneDepth.menuDivision }"/>" tabindex="1">
									<c:choose>
										<c:when test="${oneDepth.menuDivision eq 'anchor'}">
											<a href="<c:out value="${wzwg_contextPath}"/>/subsite/<c:out value="${subsiteKey}"/>#.anc_<c:out value="${oneDepth.menuSeq}"/>" data-type="anchor" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}"/>"><c:out value="${oneDepth.menuNm }"/></a>
										</c:when>
										<c:when test="${oneDepth.menuDivision eq 'link'}">
											<a href="<c:out value="${oneDepth.menuLinkUrl}"/>" <c:if test="${fn:indexOf(oneDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin"/>"</c:if> data-type="link" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}"/>"><c:out value="${oneDepth.menuNm }"/></a>
										</c:when>
										<c:otherwise>
											<a href="<c:out value="${wzwg_contextPath}"/>/subsite/<c:out value="${subsiteKey}"/>/subList/<c:out value="${oneDepth.menuLinkSeq}"/>" data-type="subPage" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}"/>"><c:out value="${oneDepth.menuNm }"/></a>
										</c:otherwise>
									</c:choose>
									
									<ul>
									<c:forEach items="${menuList}" var="twoDepth" varStatus="status">
									<c:if test="${oneDepth.menuSeq eq twoDepth.upperMenuSeq}">
										<li class="<c:if test="${twoDepth.menuDivision eq 'group' }">mnGroup</c:if>" tabindex="1">
											<c:choose>
												<c:when test="${twoDepth.menuDivision eq 'anchor'}">
													<a href="<c:out value="${wzwg_contextPath}"/>/subsite/<c:out value="${subsiteKey}"/>#.anc_<c:out value="${twoDepth.menuSeq}"/>" data-type="anchor" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}"/>"><c:out value="${twoDepth.menuNm }"/></a>
												</c:when>
												<c:when test="${twoDepth.menuDivision eq 'link'}">
													<a href="<c:out value="${twoDepth.menuLinkUrl}"/>" <c:if test="${fn:indexOf(twoDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin"/>"</c:if> data-type="link" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}"/>"><c:out value="${twoDepth.menuNm }"/></a>
												</c:when>
												<c:otherwise>
													<a href="<c:out value="${wzwg_contextPath}"/>/subsite/<c:out value="${subsiteKey}"/>/subList/<c:out value="${twoDepth.menuLinkSeq}"/>" data-type="subPage" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}"/>"><c:out value="${twoDepth.menuNm }"/></a>
												</c:otherwise>
											</c:choose>
											<ul>
											<c:forEach items="${menuList}" var="threeDepth" varStatus="status">
											  <c:if test="${twoDepth.menuSeq eq threeDepth.upperMenuSeq}"> 
												<li class="<c:if test="${threeDepth.menuDivision eq 'group' }">mnGroup</c:if>" tabindex="1">
												<c:choose>
													<c:when test="${threeDepth.menuDivision eq 'anchor'}">
														<a href="<c:out value="${wzwg_contextPath}"/>/subsite/<c:out value="${subsiteKey}"/>#.anc_<c:out value="${threeDepth.menuSeq}"/>" data-type="anchor" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}"/>"><c:out value="${threeDepth.menuNm }"/></a>
													</c:when>
													<c:when test="${threeDepth.menuDivision eq 'link'}">
														<a href="<c:out value="${threeDepth.menuLinkUrl}"/>" <c:if test="${fn:indexOf(threeDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin"/>"</c:if> data-type="link" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}"/>"><c:out value="${threeDepth.menuNm }"/></a>
													</c:when>
													<c:otherwise>
														<a href="<c:out value="${wzwg_contextPath}"/>/subsite/<c:out value="${subsiteKey}"/>/subList/<c:out value="${threeDepth.menuLinkSeq}"/>" data-type="subPage" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}"/>"><c:out value="${threeDepth.menuNm }"/></a>
													</c:otherwise>
												</c:choose>
												</li>
											</c:if>
											</c:forEach>
											</ul>
										</li>
									</c:if>
									</c:forEach>	 
									</ul>  
								</li>   
								<c:set var="menuLength"><c:out value="${menuLength + 1}"/></c:set>
								</c:if>
								</c:forEach>
							 </ul>
					</c:when>
					
					
					<c:otherwise>
							<c:set var="menuLength">0</c:set>
							 <ul cclass="dep01">
							   <c:forEach items="${menuList}" var="oneDepth" varStatus="status">
							   <c:if test="${empty oneDepth.upperMenuSeq or oneDepth.upperMenuSeq eq '0' }">
								<li class="topMenuItem <c:if test="${oneDepth.menuDivision eq 'group' }">mnGroup</c:if>">
									<c:choose>
										<c:when test="${oneDepth.sysmoduleSeq eq '888888888888' }">
										<label><c:out value="${oneDepth.menuNm }"/></label>
										<%-- <a href="<c:out value="${oneDepth.menuLinkUrl}"/>" data-type="anchor" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}"/>"><c:out value="${oneDepth.menuNm }"/></a> --%>
										</c:when>
										<c:when test="${oneDepth.mngrMenuDivision eq 'link' }">
										<label><c:out value="${oneDepth.menuNm }"/></label>
										<%-- <a href="<c:out value="${oneDepth.menuLinkUrl}"/>" <c:if test="${fn:indexOf(oneDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin"/>"</c:if> data-type="link" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}"/>"><c:out value="${oneDepth.menuNm }"/></a> --%>
										</c:when>
										<c:otherwise>
										<label><input type="checkbox" name="subMenuSeq" data-type="<c:out value="${oneDepth.mngrMenuDivision }"/>" value="<c:out value="${oneDepth.menuLinkSeq}"/>" <c:if test="${paramVO.menuSeq eq oneDepth.menuLinkSeq }"> checked</c:if>><c:out value="${oneDepth.menuNm }"/></label>
										<%-- <a href="/subList/<c:out value="${oneDepth.menuLinkSeq}"/>" data-type="subPage" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}"/>"><c:out value="${oneDepth.menuNm }"/></a> --%>
										</c:otherwise>
									</c:choose>
								 	
									<ul class="ml20">
										<%-- <span class="oneDepth_menuNm" style="display: none;"><c:out value="${oneDepth.menuNm }"/></span> --%>
									<c:forEach items="${menuList}" var="twoDepth" varStatus="status">
									<c:if test="${oneDepth.menuSeq eq twoDepth.upperMenuSeq}">
										<li <c:if test="${twoDepth.menuDivision eq 'group' }">class="mnGroup"</c:if>>
										
											<c:choose>
												<c:when test="${twoDepth.sysmoduleSeq eq '888888888888' }">
												<label><c:out value="${twoDepth.menuNm }"/></label>
												<%-- <a href="<c:out value="${twoDepth.menuLinkUrl}"/>" data-type="anchor" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}"/>"><c:out value="${twoDepth.menuNm }"/></a> --%>
												</c:when>
												<c:when test="${twoDepth.mngrMenuDivision eq 'link' }">
												<label><c:out value="${twoDepth.menuNm }"/></label>
												<%-- <a href="<c:out value="${twoDepth.menuLinkUrl}"/>" <c:if test="${fn:indexOf(twoDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin"/>"</c:if> data-type="link" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}"/>"><c:out value="${twoDepth.menuNm }"/></a> --%>
												</c:when>
												<c:otherwise>
												<label><input type="checkbox" name="subMenuSeq" data-type="<c:out value="${twoDepth.mngrMenuDivision }"/>" value="<c:out value="${twoDepth.menuLinkSeq}"/>" <c:if test="${paramVO.menuSeq eq twoDepth.menuLinkSeq }"> checked</c:if>><c:out value="${twoDepth.menuNm }"/></label>
												<%-- <a href="/subList/<c:out value="${twoDepth.menuLinkSeq}"/>" data-type="subPage" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}"/>"><c:out value="${twoDepth.menuNm }"/></a> --%>
												</c:otherwise>
											</c:choose>
											
											<ul class="ml20">
											<c:forEach items="${menuList}" var="threeDepth" varStatus="status">
											  <c:if test="${twoDepth.menuSeq eq threeDepth.upperMenuSeq}"> 
												<li <c:if test="${threeDepth.menuDivision eq 'group' }">class="mnGroup"</c:if>>
												<c:choose>
													<c:when test="${threeDepth.sysmoduleSeq eq '888888888888' }">
													<label><c:out value="${twoDepth.menuNm }"/></label>
													<%-- <a href="<c:out value="${threeDepth.menuLinkUrl}"/>" data-type="anchor" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}"/>"><c:out value="${threeDepth.menuNm }"/></a> --%>
													</c:when>
													<c:when test="${threeDepth.mngrMenuDivision eq 'link' }">
													<label><c:out value="${twoDepth.menuNm }"/></label>
													<%-- <a href="<c:out value="${threeDepth.menuLinkUrl}"/>" <c:if test="${fn:indexOf(threeDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin"/>"</c:if> data-type="link" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}"/>"><c:out value="${threeDepth.menuNm }"/></a> --%>
													</c:when>
													<c:otherwise>
													<label><input type="checkbox" name="subMenuSeq" data-type="<c:out value="${threeDepth.mngrMenuDivision }"/>" value="<c:out value="${threeDepth.menuLinkSeq}"/>" <c:if test="${paramVO.menuSeq eq threeDepth.menuLinkSeq }"> checked</c:if>><c:out value="${threeDepth.menuNm }"/></label>
													<%-- <a href="/subList/<c:out value="${threeDepth.menuLinkSeq}"/>" data-type="subPage" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}"/>"><c:out value="${threeDepth.menuNm }"/></a> --%>
													</c:otherwise>
												</c:choose>
												
												
												</li>
											</c:if>
											</c:forEach>
											</ul>
										</li>
									</c:if>
									</c:forEach>	 
									</ul>  
								</li>   
								<c:set var="menuLength"><c:out value="${menuLength + 1}"/></c:set>
								</c:if>
								</c:forEach>
							 </ul>
							 
							<ul>
								<li class="blindMenuItem"><label><input type="checkbox" name="chkUsrSubEdit" value="Y"><spring:message code="wzwg.site.screen.msg.MSG002" /> (<spring:message code="wzwg.cmm.word.signup" />, <spring:message code="wzwg.cmm.word.login" />, <spring:message code="wzwg.cmm.msg.screen.MSG082" />)</label></li>
							</ul>
					</c:otherwise>
				</c:choose>
				
				<div class="mt50">
				<button type="button" class="wzbtn-block wzbtn btn-save" onclick="fnSubpageSaveSend()"><spring:message code="wzwg.cmm.word.stre" /></button>
				</div>
	</div>