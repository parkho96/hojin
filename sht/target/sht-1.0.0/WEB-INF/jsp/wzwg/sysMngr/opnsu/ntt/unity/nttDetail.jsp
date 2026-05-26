<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<% 
	pageContext.setAttribute("cn", "\n"); 
%>

<script src="/clipboard/dist/clipboard.min.js"></script>

<script type="text/javascript">

	$(document).ready(function(){

		// 답글 
		$('#reply_btn').click(function(){
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/unity/selectNttReplyFormAjax.do'
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
		
		// 수정
		$('#modify_btn').click(function(){
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/unity/modifyNttFormAjax.do'
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
					, url : '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/unity/deleteNttInfoAjax.do'
					, dataType : 'xml'
					, data : $("#detailFrm").serialize()
					, success : function (result) {
						var value = "";
						
						$(result).find("value").each(function() {  
							value = $(this).text();  
						});
						
						if(value == 'success'){
							$('#list_btn').click();
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
		      , url:'<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/cmmn/mvmnNttPopup.do'
		      , cache : false
		      , async : false
		      , data:$("#detailFrm").serialize()
		      , success:function (data) {
		    	  $("#bbs_layer").show();
		    	  $("#bbs_layer").html(data);
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
				, url : '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/unity/selectNttListAjax.do'
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
		
	});
	
	// 제목에서 게시판 클릭시 목록으로 이동
	function fnBbsList(){
		$('#list_btn').click();	
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

		<c:if test="${sessionScope.SADMIN_AT}">
			<c:set var="adminAuthAt" value="Y"/>
		</c:if>

		<c:set var="repAuthAt" value="" />
		<c:set var="modAuthAt" value="" />
		<c:set var="delAuthAt" value="" />

		<c:if test="${nttAuthVO.authorSe eq 'W'}">
			<c:set var="repAuthAt" value="Y" />
		</c:if>
	
		<c:if test="${loginVO.usrSeq eq resultVO.ntcrSeq or adminAuthAt eq 'Y'}">
			<c:set var="repAuthAt" value="Y" />
			<c:set var="modAuthAt" value="Y" />
			<c:set var="delAuthAt" value="Y" />
		</c:if>	
		
		<form:form modelAttribute="paramVO" path="detailFrm" id="detailFrm" name="detailFrm" method="post">
			<form:hidden path="siteSeq" />
			<form:hidden path="bbsSeq" />
			<form:hidden path="nttSeq" />
			<form:hidden path="pageIndex" />
			<form:hidden path="searchCondition" />
			<form:hidden path="searchKeyword" />
			<form:hidden path="menuSeq" />
			<form:hidden path="sysMngrAt" />
	
			<div class="board001 bbsmngr">
				<div class="list_tit">
					<h3>
						<c:if test="${!empty resultVO.subospecSj}">
							<span>[ <c:out value="${resultVO.subospecSj}" /> ]</span>
						</c:if>					
						<c:out value="${resultVO.nttSj}" />
												
					</h3>
					<p class="list_date">
						<c:out value="${resultVO.lastUpdtPnttm}" />
						<!-- 
						<c:if test="${modAuthAt eq 'Y'}">
							<a href="javascript:void(0);" id="modify_top_btn" class="btn-c"><spring:message code="wzwg.cmm.word.updt" /></a>
						</c:if>
						<c:if test="${delAuthAt eq 'Y'}">
							<a href="javascript:void(0);" id="delete_top_btn" class="btn-c"><spring:message code="wzwg.cmm.word.delete" /></a>
						</c:if>	
						 -->				
					</p>
				</div><!-- list_tit end -->
				<div class="list_content">
					<div class="conTop">
						<h4>
							<c:if test="${resultVO.annymtyAt eq 'Y'}"><spring:message code="wzwg.cmm.word.clsdr" /></c:if>
							<c:if test="${resultVO.annymtyAt ne 'Y'}"><c:out value="${resultVO.ntcrNm}" />(<c:out value="${fn:substring(resultVO.ntcrId, 0, 4)}" />****)</c:if>						
						</h4>

						<c:if test="${resultVO.atchFileCnt ne '0'}">
						<div class="fileBox">
							<ul>
								<li>
									<a href="javascript:void(0);" onclick="$('#atchFile_div').toggle();" >
									<spring:message code="wzwg.sysMngr.word.atchFile" /><span>(<c:out value="${resultVO.atchFileCnt}" />)</span>
									</a>
								</li>								
							</ul>
							<div id="atchFile_div" style="display:none;">
							<c:import url="${wzwg_contextPath}/opnsu/file/selectFileInc.do" charEncoding="utf-8">
								<c:param name="param_atchFileId" 	value="${resultVO.atchFileId}" />
								<c:param name="param_updateFlag" 	value="N" />
							</c:import>
							</div>											
						</div>
						</c:if>					 
					</div>
					<div class="conMiddle">
						<div class="conM_txt">
							<c:out value='${fn:replace(resultVO.nttCn, cn, "<br />")}' escapeXml="false" />
						</div>
						<ul id="module_inc_<c:out value="${resultVO.nttSeq}" />">
							<%-- <li><a href="javascript:void(0);"><spring:message code="wzwg.cmm.word.prntng" /></a></li>
							<li><a href="javascript:void(0);"><spring:message code="wzwg.cmm.word.answer02" /><span>1</span></a></li>
							<li><a href="javascript:void(0);"><spring:message code="wzwg.cmm.word.rgsde" /> <span>▲</span></a></li> --%>
							<c:if test="${resultVO.answerPermAt eq 'Y'}">
								<c:import url="${wzwg_contextPath}${prefix}/opnsu/ntt/answer/selectNttAnswerIncAjax.do" charEncoding="utf-8">
									<c:param name="param_nttSeq" value="${resultVO.nttSeq}" />
								</c:import>
							</c:if>							 
							<li><a style="cursor:text;"><spring:message code="wzwg.cmm.word.rdcnt" /> <span><c:out value="${resultVO.inqireCnt}" /></span></a></li> 
							<%-- <li><a href="javascript:void(0);"><spring:message code="wzwg.cmm.word.like" /><span>▲</span></a></li>
							<li><a href="javascript:void(0);" class="lu"><img src="./img/ico-heart.png" alt="<spring:message code="wzwg.cmm.word.like" />" /><b>0</b></a></li> --%>
						</ul>
					</div>
					<div class="conBottom" id="module_div_<c:out value="${resultVO.nttSeq}" />">
					
						<div id="answer" style="display:none;">

							<c:if test="${resultVO.answerPermAt eq 'Y'}">
								<c:import url="${wzwg_contextPath}${prefix}/opnsu/ntt/answer/selectNttAnswerFormAjax.do" charEncoding="utf-8">
									<c:param name="param_nttSeq" value="${resultVO.nttSeq}" />
									<c:param name="param_bbsSeq" value="${paramVO.bbsSeq}" />
								</c:import>
							</c:if>

						</div>
					</div>
				</div><!-- list_content end -->
			</div>
			<div class="rt-box">
			
				<c:if test="${delAuthAt eq 'Y'}">
					<a href="javascript:voidf(0);" id="delete_btn" class="wzbtn btn-del fl"><spring:message code="wzwg.cmm.word.delete" /></a>
				</c:if>	
				<!-- 		
				<c:if test="${repAuthAt eq 'Y'}">
					<a href="javascript:voidf(0);" id="reply_btn" class="btn-a"><spring:message code="wzwg.cmm.word.answer03" /></a>
				</c:if>
				 -->
				<c:if test="${modAuthAt eq 'Y'}">
					<a href="javascript:voidf(0);" id="modify_btn" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.updt" /></a>
				</c:if>
				<a href="javascript:voidf(0);" id="list_btn" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>

			</div>
				
		</form:form>
				
