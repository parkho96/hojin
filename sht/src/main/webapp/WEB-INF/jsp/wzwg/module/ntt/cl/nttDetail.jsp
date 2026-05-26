<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script type="text/javascript" src="/widesign/widesign.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
	    
		// 수정
		$('#modify_btn').click(function(){
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cl/modifyNttFormAjax.do'
				, dataType : 'html'
				, data : $("#detailFrm").serialize()
				, success : function (data) {
					$('#bbs_area').html(data);
					$("#content").css("height",$(document).height());
			     	$(window).scrollTop(0);
				}
				, error : function (request, status, error) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
			});
		});
		
		// 수정(상단 버튼)
		$('#modify_top_btn').click(function(){
			$('#modify_btn').click();
		});
		
		// 삭제
		$('#delete_btn').click(function(){
			if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
				return;
			}else{
				$.ajax({
			        type : 'POST'
					, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cl/deleteNttInfoAjax.do'
					, dataType: 'xml'
					, data : $("#detailFrm").serialize()
					, success : function (result) {
						var value = "";
						
						$(result).find("value").each(function() {  
							value = $(this).text();  
						});
						
						if(value == 'success'){
							var frm = document.detailFrm;
							frm.nttSeq.value = '';
							
							$.ajax({
						        type : 'POST'
								, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cl/selectNttListAjax.do'
								, dataType : 'html'
								, data : $("#detailFrm").serialize()
								, success : function (data) {
									$('#bbs_area').html(data);
									$("#content").css("height",$(document).height());
							     	$(window).scrollTop(0);
								}
								, error : function (request, status, error) {
									alert('<spring:message code="fail.common.msg" text="error" />');
								}
							});
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
						}
					}
					, error : function (request, status, error) {
						alert('<spring:message code="fail.common.msg" text="error" />');
					}
				});
			}
		});
		
		// 삭제(상단 버튼)
		$('#delete_top_btn').click(function(){
			$('#delete_btn').click();
		});
		
		// 이동
		$('#move_btn').click(function(){
			
			$('body').css({overflow:'hidden'});
			
			$.ajax({
		        type:'POST'
		      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cmmn/mvmnNttPopup.do'
		      , cache : false
		      , async : false
		      , data:$("#detailFrm").serialize()
		      , success:function (data) {
		    	  //$("#bbs_layer").show();
		    	  //$("#bbs_layer").html(data);
		    	  var title = '<spring:message code="wzwg.module.word.nttmvmn" />';
		    	  wzAjaxModal('popup_s', title, data);
		      }
		      , error:function (request, status, error) {
		    	  alert('<spring:message code="fail.common.msg" text="error" />');
		      }
		      , dataType: 'html'
		 	});
		});
		
		// 목록
		$('#list_btn').click(function(){
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cl/selectNttListAjax.do'
				, dataType : 'html'
				, data : $("#detailFrm").serialize()
				, success : function (data) {
					$('#bbs_area').html(data);
					$("#content").css("height",$(document).height());
			     	$(window).scrollTop(0);
				}
				, error : function (request, status, error) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
			});
		});
		
		// 스크랩 버튼
		$('#scrap_btn').click(function(){
			$.ajax({
		       type:'POST'
		        , dataType: 'xml'
				, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/scrap/selectNttScrapDplctChkAjax.do'
				, cache : false
				, data: $("#detailFrm").serialize()
				, success:function (result) {
					var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value == 'success'){
						$.ajax({
					        type:'POST'
					      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/scrap/registNttScrapPopup.do'
					      , cache : false
					      , async : false
					      , data:$("#detailFrm").serialize()
					      , success:function (data) {
					    	  var title = '<spring:message code="wzwg.module.word.scrapregist" />';
					    	  wzAjaxModal('popup_s', title, data);
					      }
					      , error:function (request, status, error) {
					    	  alert('<spring:message code="fail.common.msg" text="error" />');
					      }
					      , dataType: 'html'
					 	});
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG017"><spring:argument><spring:message code="wzwg.module.word.nttscrap" /></spring:argument></spring:message>');
						return;
					}
					
				}
				, error:function (data) {
				    alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});
			
		});
		<c:set var="repNttSj">${fn:replace(resultVO.nttSj, "'", "\\'")} </c:set>
		// 게시물 공유 버튼
		$('#cnrs_btn').click(function(){
			$.ajax({
		        type:'POST'
		      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/cmm/snsCnrs/selectSnsCnrsPopup.do'
		      , cache : false
		      , async : false
		      , data:'param_menuSeq=<c:out value="${paramVO.menuSeq}"/>&param_nttSeq=<c:out value="${resultVO.nttSeq}"/>&param_nttSj=<c:out value="${repNttSj}"/>&param_mobileAt=<c:out value="${mobileAt}"/>'
		      , success:function (data) {
		    	  var title = '<spring:message code="wzwg.cmm.word.cnrs" />';
		    	  wzAjaxModal('popup_la', title, data, true, $('#cnrs_btn'));
		      }
		      , error:function (request, status, error) {
		    	  alert('<spring:message code="fail.common.msg" text="error" />');
		      }
		      , dataType: 'html'
		 	});
		});
		
		// 인쇄 버튼
		$('#print_btn').click(function(){
			var printWindow = window.open("", "_blank");
			var printContents = $('.conM_txt').html();
			
			printWindow.document.write('<head>');
			printWindow.document.write($('head').html());
			printWindow.document.write('</head>');
			
			printWindow.document.write('<div>');
			printWindow.document.write(printContents);
			printWindow.document.write('</div>');
			
			printWindow.print();
			printWindow.document.close();
		});
		
	});
	
	// 분류명에서 게시판 클릭시 목록으로 이동
	function fnBbsList(){
		var frm = document.detailFrm;
		frm.nttSeq.value = '';
		
		$.ajax({
	        type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cl/selectNttListAjax.do'
			, dataType : 'html'
			, data : $("#detailFrm").serialize()
			, success : function (data) {
				$('#bbs_area').html(data);
				$("#content").css("height",$(document).height());
		     	$(window).scrollTop(0);
			}
			, error : function (request, status, error) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
		});
	}
	
	// 태그 사용 게시물 목록
	function fnNttTagList(tagSeq){
		alert('Preparing !!');
	}
		
	window.onkeydown = function() {

	    var keyCode = event.keyCode;

	    if(keyCode == 8
	    		&& 'INPUT'.indexOf(event.target.nodeName.toUpperCase()) == -1 
	    		&& 'TEXTAREA'.indexOf(event.target.nodeName.toUpperCase()) == -1) {

	    	$('#list_btn').click();
	    	return false;
		}
	}	
	
</script>

		<c:set var="adminAuthAt" value="N"/>
		
		<c:if test="${paramVO.cmntUseAt eq 'Y'}">
			<c:if test="${sessionScope.cmntMngrAt == true}">
				<c:set var="adminAuthAt" value="Y"/>
			</c:if>
		</c:if>		

		<c:if test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or sessionScope.CNTNTS_ADMIN_AT}">
			<c:set var="adminAuthAt" value="Y"/>
		</c:if>

		<c:set var="repAuthAt" value="" />
		<c:set var="modAuthAt" value="" />
		<c:set var="movAuthAt" value="" />
		<c:set var="delAuthAt" value="" />

		<c:if test="${nttAuthVO.authorSe eq 'W'}">
			<c:set var="repAuthAt" value="Y" />
		</c:if>
	
		<c:if test="${loginVO.usrSeq eq resultVO.ntcrSeq or adminAuthAt eq 'Y'}">
			<c:set var="repAuthAt" value="Y" />
			<c:set var="modAuthAt" value="Y" />
			<c:set var="delAuthAt" value="Y" />
		</c:if>	
		
		<c:if test="${adminAuthAt eq 'Y'}">
			<c:set var="movAuthAt" value="Y" />
		</c:if>
		
		<form:form modelAttribute="paramVO" path="detailFrm" id="detailFrm" name="detailFrm" method="post">
			<form:hidden path="siteSeq" />
			<form:hidden path="bbsSeq" />
			<form:hidden path="nttSeq" />
			<form:hidden path="menuSeq" />
			<form:hidden path="mngrAt" />
			<form:hidden path="cmntUseAt" />
			<form:hidden path="sitecntntsSeq" />
			
			<div class="board001">
				<%-- <div class="list_tit">
					<h3>
					${resultVO.nttSj}
					</h3>
					
					<p class="list_date">
					${resultVO.lastUpdtPnttm}
					<span class="com_bar">
					<c:if test="${modAuthAt eq 'Y'}">
						<a href="javascript:void(0);" id="modify_top_btn" class="gray"><spring:message code="wzwg.cmm.word.updt" /></a>
					</c:if>
					<c:if test="${delAuthAt eq 'Y'}">
						<a href="javascript:void(0);" id="delete_top_btn" class="gray"><spring:message code="wzwg.cmm.word.delete" /></a>
					</c:if>								
					
					</span>	
					
					</p>
				</div> --%>
				<!-- list_tit end -->
				
				<div class="list_content">
					<div class="conMiddle">
						<%-- <p>
							<c:if test="${!empty loginVO and fn:indexOf(prefix, 'mngr') eq -1}">
								<c:if test="${paramVO.mngrAt ne 'Y' and resultVO.snsCnrsAt eq 'Y'}">
									<a href="javascript:void(0);" id="cnrs_btn"><img src="/images/wzwg/cmm/cnrs_btn.png" alt='<spring:message code="wzwg.cmm.word.cnrs" />'></a>
								</c:if>		
							</c:if>
						</p> --%>
						<div class="conM_txt">
							<c:if test="${resultVO.nttClSe eq 'C'}">
								<c:out value='${resultVO.nttCn}' escapeXml="false" />
							</c:if>
							<c:if test="${resultVO.nttClSe eq 'L' and nowUrl.indexOf('/mngr') > -1}">
								<c:set var="url">${fn:substring(resultVO.nttCn, 3, fn:length(resultVO.nttCn)) }</c:set>
								<c:out value='${url}'/> <i class="fa fa-external-link" aria-hidden="true"></i>
							</c:if>
						</div> 
					</div>
					
					<div class="conMiddle">
						<div class="conM_txt">
						</div>
					</div>
					
					<%-- <c:if test="${!empty tagList}">
					<div class="conMiddle">
						<div class="mg_t20">
							<span class="btn btn_default btn_m mg_r10"><spring:message code="wzwg.cmm.word.tag" /></span>
							<!-- 태그 목록 start -->
							<c:forEach var="tagList" items="${tagList}" varStatus="status">
								<span class="mg_r5" style="background-color:#D5D5D5;"><a href="javascript:void(0);" onclick="fnNttTagList('${tagList.tagSeq}');">#${tagList.tagNm}</a></span>
							</c:forEach>
							<!-- 태그 목록 end -->
						</div>
					</div>
					</c:if> --%>	
					
				</div><!-- list_content end -->
			</div>
			
			<div class="rt-box mb10">
				
				<c:if test="${delAuthAt eq 'Y'}">
					<a href="javascript:void(0);" id="delete_btn" class="wzbtn-table btn-del fl"><spring:message code="wzwg.cmm.word.delete" /></a>
				</c:if>
				
				<c:if test="${!empty loginVO}">
					<%-- <a href="javascript:void(0);" id="print_btn" class="wzbtn-table btn-basic"><spring:message code="wzwg.cmm.word.prntng" /></a> --%>
				
					<%-- <c:if test="${resultVO.scrapAt eq 'Y'}">
						<a href="javascript:void(0);" id="scrap_btn" class="wzbtn-table btn-basic"><spring:message code="wzwg.cmm.word.scrap" /></a>
					</c:if> --%>
				</c:if>
				
				<c:if test="${modAuthAt eq 'Y'}">
					<a href="javascript:void(0);" id="modify_btn" class="wzbtn-table btn-basic"><spring:message code="wzwg.cmm.word.updt" /></a>
				</c:if>
				
				<c:if test="${movAuthAt eq 'Y'}">
					<c:if test="${paramVO.cmntUseAt ne 'Y'}">
					<a href="javascript:void(0);" id="move_btn" class="wzbtn-table btn-basic"><spring:message code="wzwg.cmm.word.mvmn" /></a>	
					</c:if>							
				</c:if>
			</div>
			<c:if test="${nowUrl.indexOf('/mngr') > -1 }">
				<c:if test="${!empty paramVO.sitecntntsSeq and !empty paramVO.nttSeq and resultVO.nttClSe ne 'L'}">
				<div class="mt30">
					<h3 class="wzAdmSTit wd100 fl wz-collapse" data-for=".tapCntntsSet"><spring:message code="wzwg.module.word.pageaddset" /></h3>
					<div class="tapCntntsSet dp-none">
						<c:import url="${wzwg_contextPath}${prefix}/cntnts/cntPagadiEstbs/selectCntPagadiEstbsAjax.do">
							<c:param name="cntntsSeq" value="${paramVO.bbsSeq }" />
						</c:import>
					</div>
				</div>
				</c:if>
			</c:if>
			
			<c:if test="${nowUrl.indexOf('/mngr') == -1 }">
			<div class="mt20">
				<c:import url="${wzwg_contextPath}/usr/cntnts/cntPagadiEstbs/selectCntPagadiEstbsUsrAjax.do">
					<c:param name="cntntsSeq" value="${resultVO.bbsSeq }" />
					<c:param name="frstRegistPnttm" value="${resultVO.frstRegistPnttm }" />
				</c:import>
			</div>
			</c:if>
			
		</form:form>
