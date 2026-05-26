<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script type="text/javascript">

	$(document).ready(function(){
		// 수정
		$('#cl_modify_btn, #modify_top_btn').click(function(){
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/tabMenu/modifyTabMenuDataFormAjax.do'
				, dataType : 'html'
				, data : $("#clDetailFrm").serialize()
				, success : function (data) {
					$('#tabMenuArea').html(data);
					$("#content").css("height",$(document).height());
			     	$(window).scrollTop(0);
				}
				, error : function (request, status, error) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
			});
		});
		
		// 삭제
		$('#cl_delete_btn, #delete_top_btn').click(function(){
			if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
				return;
			}else{
				$.ajax({
			        type : 'POST'
					, url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/tebMenu/deleteTabMenuDataAjax.do'
					, dataType: 'xml'
					, data : $("#clDetailFrm").serialize()
					, success : function (result) {
						var value = "";
						
						$(result).find("value").each(function() {  
							value = $(this).text();  
						});
						
						if(value == 'success'){
							var frm = document.clDetailFrm;
							frm.tabdataSeq.value = '';
							
							$.ajax({
						        type : 'POST'
								, url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/tabMenu/selectTabMenuDataListAjax.do'
								, dataType : 'html'
								, data : $("#clDetailFrm").serialize()
								, success : function (data) {
									$('#tabMenuArea').html(data);
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
		
		
		// 목록
		$('#list_btn').click(function(){
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/tabMenu/selectTabMenuDataListAjax.do'
				, dataType : 'html'
				, data : $("#clDetailFrm").serialize()
				, success : function (data) {
					$('#tabMenuArea').html(data);
					$("#content").css("height",$(document).height());
			     	$(window).scrollTop(0);
				}
				, error : function (request, status, error) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
			});
		});
		
		
	//window.onkeydown = function() {
    //
	//    var keyCode = event.keyCode;
    //
	//    if(keyCode == 8
	//    		&& 'INPUT'.indexOf(event.target.nodeName.toUpperCase()) == -1 
	//    		&& 'TEXTAREA'.indexOf(event.target.nodeName.toUpperCase()) == -1) {
    //
	//    	$('#list_btn').click();
	//    	return false;
	//	}
	//}	
	
	})//end ready 
	
</script>
		<c:if test="${prefix eq '/mngr'}">
			<div class="wzAdmSTit wd100 fl mt15">
				<h3 class="i-block"><span class="grey">[<c:out value='${resultVO.tabdataSj }'/>]</span> <spring:message code="wzwg.cmm.word.wa.tabContents"/></h3>
			</div>
			<div class="w100 fl pl20 pr20 pb20 box-border">
				<div class="admpg-subp fl txt-l i-block mb20 wm100"><span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.tip.MSG073" />
				<span class="wz_tableguide mt5 pl15"><spring:message code="wzwg.cmm.msg.tip.MSG0732" /></span>
				</div>
				<div class="i-block fr mngrCtrlBox">
					<c:if test="${not empty moduleVO }">
					<a href="<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/<c:out value="${moduleVO.mngrPageUrl}" />?cntntsSeq=<c:out value="${cntntsInfoVO.cntntsSeq}" />&sitecntntsSeq=<c:out value="${resultVO.sitecntntsSeq}" />" target="_blank" class="wzbtn btn-grey-bg"><spring:message code="wzwg.module.word.detailestbs"/></a>
					</c:if>
					<a href="javascript:void(0);" id="cl_delete_btn" class="wzbtn btn-del"><spring:message code="wzwg.module.word.tabdelete" /></a>
					<a href="javascript:void(0);" id="cl_modify_btn" class="wzbtn btn-basic"><spring:message code="wzwg.module.word.tabupdt" /></a>
				</div>
			</div>
		</c:if>
		
		<div class="wd100 pl20 pr20 box-border">
			<h5 class="hide-txt"><c:out value='${resultVO.tabdataSj }'/></h5>
			
			<form:form modelAttribute="paramVO" path="clDetailFrm" id="clDetailFrm" name="clDetailFrm" method="post">
				<form:hidden path="siteSeq" />
				<form:hidden path="tabSeq" />
				<form:hidden path="tabdataSeq" />
				<form:hidden path="menuSeq" />
				<form:hidden path="mngrAt" />
				<form:hidden path="cmntUseAt" />
				<form:hidden path="sitecntntsSeq" />
				
								
								<c:if test="${resultVO.tabClSe eq 'L' and nowUrl.indexOf('/mngr') > -1}">
									<div class="mngrLinkContents">
										<i class="fa fa-external-link" aria-hidden="true"></i>
										<span><c:out value='${resultVO.menuLinkUrl}'/></span>
										<c:if test="${resultVO.menuLinkTarget eq 'N'}"><span class="gray">(<spring:message code="wzwg.module.word.newopwin" />)</span></c:if> 
										<c:if test="${resultVO.menuLinkTarget eq 'G'}"><span class="gray">(<spring:message code="wzwg.module.word.nowopwin" />)</span></c:if> 
									</div>
								</c:if>
								
								<c:if test="${resultVO.tabClSe eq 'M'}">
									<%-- <c:set var="url"><c:out value='${fn:substring(resultVO.tabCn, 3, fn:length(resultVO.tabCn)) }'/></c:set> --%>
									<c:choose>
										<c:when test="${prefix eq '/mngrfff'}">
											<div id="moduleNttClArea">
											관리자메뉴이동
											</div>
										</c:when>
										<c:otherwise>
											<div id="moduleNttClArea"></div>
											<script>
											$(document).ready(function(){
												var detailDataJ = {};
												detailDataJ.sysmoduleSeq = '<c:out value="${resultVO.sysmoduleSeq}" />';
												detailDataJ.moduleTyCode = '<c:out value="${resultVO.moduleTyCode}" />';
												detailDataJ.sitecntntsSeq = '<c:out value="${resultVO.sitecntntsSeq}" />';
												
												var detailCallUrl = '<c:out value="${wzwg_contextPath}" />/subList/' + detailDataJ.sysmoduleSeq + '/tabMenuModuleCallAjax.do'; 
												if('<c:out value="${param.pmode}" />' == 'detail'){
													detailDataJ.pmode = '<c:out value="${param.pmode}" />';
													detailDataJ.nttSeq = '<c:out value="${param.childNttSeq}" />';
												}
												
												console.log(detailDataJ);
												$.ajax({
											        type : 'POST'
													, url : detailCallUrl
													, dataType : 'html'
													, data : detailDataJ
													, success : function (data) {
														$('#moduleNttClArea').html(data);
														//$("#content").css("height",$(document).height());
												     	//$(window).scrollTop(0);
													}
													, error : function (request, status, error) {
														alert('<spring:message code="fail.common.msg" text="error" />');
													}
												});
												
											});
											
											</script>
										</c:otherwise>
									</c:choose>
									
								</c:if>
			</form:form>
		</div>
		
		
