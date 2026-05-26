<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>


<script type="text/javascript">

	$(document).ready(function(){

		// 말머리 선택
		$('#btn_subospecSeq').click(function(){
			
			var frm = document.listFrm;

			frm.pageIndex.value = 1;
			
			$.ajax({
				  type : 'POST'
				, dataType: 'html'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/unity/selectNttRecycleListAjax.do'
				, cache : false
				, async : false
				, data:$("#listFrm").serialize()
				, success:function (data) {
					$('#bbs_area').html(data);
					if($('#tabBtn-' + $('#subospecSeq').val()).length > 0){
		            	$('#tabBtn-' + $('#subospecSeq').val()).focus();
		            }
		            
		            if($('#btn_subospecSeq').length > 0){
			            $('#btn_subospecSeq').focus();
		            }
				}
				, error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});
			
		});

		// 복원
		$('#recycle_btn').click(function(){
			if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.recovry" /></spring:argument></spring:message>')){
				return;
			}else{
				var checkCnt = 0;
				var nttChkArr = "";

				$("input[name=nttChk]").each(function(){
					if(this.checked){
						nttChkArr += $(this).val() + ",";
						checkCnt++;
					}
				});
				
				if(checkCnt < 1){
					alert('<spring:message code="wzwg.cmm.msg.MSG087" />');
					return;
				}
					
				var frm = document.listFrm;
				
				frm.checkNttSeq.value = nttChkArr;
				
				$.ajax({
  					type:'POST'
					, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/unity/modifyNttRecycleAjax.do'
					, cache : false
					, async : false
					, data:$("#listFrm").serialize()
					, success:function (result) {
						var value = "";
						
						$(result).find("value").each(function() {  
							value = $(this).text();  
						});
						
						if(value == 'success'){
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.recovry" /></spring:argument></spring:message>');
							fnPage(1);
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
						}
   					}
				   , error:function (request, status, error) {
				 	  alert('<spring:message code="fail.common.msg" text="error" />');
				   }
				   , dataType: 'xml'
				});
			}
		});
		
		// 체크박스 전체선택 / 해제
		$("input[name=nttAllChk]").on('click', function(){
			var boolean_chk = $("input[name=nttAllChk]").get(0).checked;
			$("input[name=nttChk]").each(function(){
				this.checked = boolean_chk;
			});
		});
		
		$(".datePicker").datepicker({ 		
		    dateFormat: 'yy-mm-dd',
		    monthNamesShort: ['1<spring:message code="wzwg.cmm.word.mt" />','2<spring:message code="wzwg.cmm.word.mt" />','3<spring:message code="wzwg.cmm.word.mt" />','4<spring:message code="wzwg.cmm.word.mt" />','5<spring:message code="wzwg.cmm.word.mt" />','6<spring:message code="wzwg.cmm.word.mt" />','7<spring:message code="wzwg.cmm.word.mt" />','8<spring:message code="wzwg.cmm.word.mt" />','9<spring:message code="wzwg.cmm.word.mt" />','10<spring:message code="wzwg.cmm.word.mt" />','11<spring:message code="wzwg.cmm.word.mt" />','12<spring:message code="wzwg.cmm.word.mt" />'],
		    dayNamesMin: ['<spring:message code="wzwg.cmm.word.sun01" />','<spring:message code="wzwg.cmm.word.mon01" />','<spring:message code="wzwg.cmm.word.tue01" />','<spring:message code="wzwg.cmm.word.wed01" />','<spring:message code="wzwg.cmm.word.thu01" />','<spring:message code="wzwg.cmm.word.fri01" />','<spring:message code="wzwg.cmm.word.sat01" />'],
		    weekHeader: 'Wk',
		    changeMonth: true, 	//월변경가능
		    changeYear: true, 	//년변경가능
		    yearRange:'-10:+10', 	// 연도 셀렉트 박스 범위(현재와 같으면 1988~현재년)
		    showMonthAfterYear: true, 	//년 뒤에 월 표시
		    buttonImageOnly: false, //이미지표시  
		    buttonText: '<spring:message code="wzwg.cmm.msg.MSG088" />', 
		    autoSize: false	 //오토리사이즈(body등 상위태그의 설정에 따른다)
		 });			
		
	});
	
	function fnDeleteNtt() {
		if(!confirm('<spring:message code="wzwg.cmm.msg.MSG060" />')){
			return false;
		}else{
			var checkCnt = 0;
			var nttChkArr = "";

			$("input[name=nttChk]").each(function(){
				if(this.checked){
					nttChkArr += $(this).val() + ",";
					checkCnt++;
				}
			});
			
			if(checkCnt < 1){
				alert('<spring:message code="wzwg.cmm.msg.MSG087" />');
				return;
			}
				
			var frm = document.listFrm;
			
			frm.checkNttSeq.value = nttChkArr;

			$.ajax({
					type:'POST'
				, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/unity/deleteNttAjax.do'
				, cache : false
				, async : false
				, data:$("#listFrm").serialize()
				, success:function (result) {
					var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value == 'success'){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
						fnPage(1);
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
					}
					}
			   , error:function (request, status, error) {
			 	  alert('<spring:message code="fail.common.msg" text="error" />');
			   }
			   , dataType: 'xml'
			});
		}		
	}
	
	function fnDeleteNttAll() {
		
		if(document.getElementById('bgnde').value.length != 10){
			alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.bgnde" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
			return false;				
		}
		
		if(document.getElementById('endde').value.length != 10){
			alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.endde" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
			return false;				
		}		
		
		var msg = document.getElementById('bgnde').value + " " 
		+ document.getElementById('beginTime').value + "<spring:message code="wzwg.cmm.word.hour" />"
		+ " ~ "
		+ document.getElementById('endde').value + " " 
		+ document.getElementById('endTime').value + "<spring:message code="wzwg.cmm.word.hour" />";

		if(!confirm(msg + '\n' + '<spring:message code="wzwg.cmm.msg.MSG015" />')){
			return false;
		}else{

			var frm = document.listFrm;

			$.ajax({
					type:'POST'
				, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/unity/deleteNttAllAjax.do'
				, cache : false
				, async : false
				, data:$("#listFrm").serialize()
				, success:function (result) {
					var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value == 'success'){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
						fnPage(1);
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
					}
					}
			   , error:function (request, status, error) {
			 	  alert('<spring:message code="fail.common.msg" text="error" />');
			   }
			   , dataType: 'xml'
			});
		}		
	}		
	
	// 상세정보
	function fnView(nttSeq, ntcrId, secretAt, parntsNttSeq){
		
		var viewAt = "N";
		
		if(secretAt == 'Y') {
			if('<c:out value="${loginVO.userId}"/>' == ntcrId || '<c:out value="${sessionScope.SADMIN_AT}"/>' == 'true' || '<c:out value="${sessionScope.NADMIN_AT}"/>' == 'true'){
				viewAt = "Y";
			} else {
				viewAt = fnNtcrIdCheck(parntsNttSeq);	
			}
		} else {
			viewAt = "Y";
		}

		if(viewAt == "Y"){
			var frm = document.listFrm;
			
			frm.nttSeq.value = nttSeq;
			frm.parntsNttSeq.value = parntsNttSeq;
			frm.secretAt.value = secretAt;
			
			$.ajax({
				  type : 'POST'
				, dataType: 'html'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/unity/selectNttDetailAjax.do'
				, cache : false
				, async : false
				, data:$("#listFrm").serialize()
				, success:function (data) {
					$('#bbs_area').html(data);
			     	$("#content").css("height",$(document).height());
			     	$(window).scrollTop(0);
				}
				, error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});				
		} else {
			alert('<spring:message code="wzwg.cmm.msg.MSG004" />');
			return;			
		}		
	}	

	function fnPage(pageIndex){
		var frm = document.listFrm;
		
		frm.pageIndex.value = pageIndex;
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/unity/selectNttRecycleListAjax.do'
			, cache : false
			, async : false
			, data:$("#listFrm").serialize()
			, success:function (data) {
				$('#bbs_area').html(data);
				$("#content").css("height",$(document).height());
				$(window).scrollTop(0);
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
	function fnSearchReset() {
		var frm = document.listFrm;
		
		frm.bgnde.value = "";
		frm.endde.value = "";
		
		$("select[name=beginTime] option[value=00]").attr("selected",true);
		$("select[name=endTime] option[value=00]").attr("selected",true);

		fnPage(1);
	}		

	window.onkeydown = function() {

	    var keyCode = event.keyCode;

	    if(keyCode == 8
	    		&& 'INPUT'.indexOf(event.target.nodeName.toUpperCase()) == -1 
	    		&& 'TEXTAREA'.indexOf(event.target.nodeName.toUpperCase()) == -1) {

	    	fnPage(1);
	    	return false;
		}
	}		
	
</script>

		<c:set var="adminAuthAt" value="N"/>
		
		<c:if test="${resultVO.cmntUseAt eq 'Y'}">
			<c:if test="${sessionScope.cmntMngrAt == true}">
				<c:set var="adminAuthAt" value="Y"/>
			</c:if>
		</c:if>		

		<c:if test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or sessionScope.CNTNTS_ADMIN_AT}">
			<c:set var="adminAuthAt" value="Y"/>
		</c:if>
		
		<form:form modelAttribute="paramVO" path="listFrm" id="listFrm" name="listFrm" method="post">
			<form:hidden path="siteSeq" />
			<form:hidden path="bbsSeq" />
			<form:hidden path="nttSeq" />
			<form:hidden path="pageIndex" />
			<form:hidden path="ordrSe" />
			<form:hidden path="searchCnd" />
			<form:hidden path="checkNttSeq" />
			<form:hidden path="menuSeq" />
			<form:hidden path="mngrAt" />
			<form:hidden path="parntsNttSeq" />
			<form:hidden path="secretAt" />	
			<input type="hidden" name="cmntUseAt" id="cmntUseAt" value="<c:out value='${resultVO.cmntUseAt}'/>" />
			
			<div class="wzAdmMainSrchbox txt-c" id="nttSearch">
				<p class="mb20"><spring:message code="wzwg.cmm.msg.MSG386"/>
              		<span class="red"><spring:message code="wzwg.cmm.msg.MSG007" /></span>
    			</p>
    			
				<input type="text" id="bgnde" name="bgnde" class="datePicker cal txt" style="width:120px;" readonly="readonly" title="<spring:message code="wzwg.cmm.word.bgnde" />" value="<c:out value='${paramVO.bgnde}'/>" placeholder="<spring:message code="wzwg.cmm.word.bgnde"/>"/> 
				<select id="beginTime" name="beginTime" class="w5">
					<c:forEach begin="0" end="23" var="stime" varStatus="status">
						<c:if test="${stime < 10}">
							<c:set var="stime" value="0${stime}" />
						</c:if>
						<option value="${stime}" <c:if test='${paramVO.beginTime eq stime}'>selected</c:if>><c:out value="${stime}"/></option>
					</c:forEach>
				</select><spring:message code="wzwg.cmm.word.hour" />
				~ 
				<input type="text" id="endde" name="endde" class="datePicker cal txt" style="width:120px;" readonly="readonly" title="<spring:message code="wzwg.cmm.word.endde" />" value="<c:out value='${paramVO.endde}'/>" placeholder="<spring:message code="wzwg.cmm.word.endde"/>"/>
				<select id="endTime" name="endTime" class="w5">
					<c:forEach begin="0" end="23" var="etime" varStatus="status">
						<c:if test="${etime < 10}">
							<c:set var="etime" value="0${etime}" />
						</c:if>
						<option value="${etime}" <c:if test='${paramVO.endTime eq etime}'>selected</c:if>><c:out value="${etime}"/></option>									
					</c:forEach>
				</select><spring:message code="wzwg.cmm.word.hour" />
				&nbsp;
				<a href="javascript:void(0);" class="wzbtn-table btn-srch" onclick="fnPage(1);"><spring:message code="wzwg.cmm.word.search" /></a>&nbsp;	
				<a href="javascript:void(0);" class="wzbtn-table btn-black" onclick="fnSearchReset();"><spring:message code="wzwg.cmm.word.initl" /></a>	
			</div>				
			
			<c:if test="${resultVO.cmntUseAt ne 'Y'}">
			<div class="main-menu-bar i-block">
				<c:import url="${wzwg_contextPath}${prefix}/module/bbs/cmmn/selectBbsSubospecSelectListAjax.do" charEncoding="utf-8">
					<c:param name="param_bbsSeq" value="${paramVO.bbsSeq}" />
				</c:import>
			</div>
			</c:if>
			
			<c:if test="${!empty resultList}">
			
				<c:if test="${adminAuthAt eq 'Y'}">
					<div class="mb10 pl10">
						<label>
						<input type="checkbox" name="nttAllChk" id="nttAllChk" title="<spring:message code="wzwg.cmm.word.rowallchoise" />"/>
						<span><spring:message code="wzwg.module.word.allchoise" /></span>
						</label>
					</div>					
				</c:if>				

				<!-- album -->
				
				<c:if test="${mobileAt eq 'Y'}">
					<ul class="album">
				</c:if>				
		
				<c:forEach var="resultList" items="${resultList}" varStatus="status">
							
				<c:if test="${mobileAt eq 'N'}">
				<c:if test="${status.count % 4 == 1}">
					<ul class="album">
				</c:if>
				</c:if>
				
				<c:set var="listDetAuthAt" value="" />
				<c:set var="modAuthAt" value="" />
				<c:set var="delAuthAt" value="" />
				
				<c:if test="${resultList.secretAt eq 'Y'}">
					<c:if test="${loginVO.userId eq resultList.parntsNtcrId}">
						<c:set var="listDetAuthAt" value="Y" />
					</c:if>	
				</c:if>
				<c:if test="${resultList.secretAt ne 'Y'}">
					<c:if test="${nttAuthVO.authorSe eq 'R' or nttAuthVO.authorSe eq 'W' or cmntAuthR eq 'Y' or cmntAuthW eq 'Y'}">
						<c:set var="listDetAuthAt" value="Y" />
					</c:if>						
				</c:if>
				
				<c:if test="${loginVO.usrSeq eq resultList.ntcrSeq or adminAuthAt eq 'Y'}">
					<c:set var="listDetAuthAt" value="Y" />
					<c:set var="modAuthAt" value="Y" />
					<c:set var="delAuthAt" value="Y" />
				</c:if>					
				
				<c:if test="${mobileAt eq 'N'}">
				<li>
				</c:if>
				
				<c:if test="${mobileAt eq 'Y'}">
				<li style="width:100%;">
				</c:if>
				
				
					<div class="alBox">
	
							<span class="imgBox">
								<c:if test="${paramVO.listScrinCode eq 'I'}">
									<c:if test="${resultList.atchFileCnt ne '0'}">
										<img src='<c:url value='/module/upload/file/selectImageView.do'/>?atchFileId=${fn:escapeXml(resultList.atchFileId)}' alt="${fn:escapeXml(resultList.nttSj)}" />
									</c:if>
									<c:if test="${resultList.atchFileCnt eq '0'}">
										<img src="/images/egovframework/com/noimg_img.gif" alt="${fn:escapeXml(resultList.nttSj)}" />
									</c:if>
								</c:if>
							</span>

						<p>
							<c:choose>
								<c:when test="${!empty resultList.nttSj}">
									<c:if test="${fn:length(resultList.nttSj) > 20}">
										<c:set var="nttSj" value="${fn:substring(resultList.nttSj, 0, 20)}..." />
									</c:if>
									<c:if test="${fn:length(resultList.nttSj) < 21}">
										<c:set var="nttSj" value="${resultList.nttSj}" />
									</c:if>
								</c:when>
								<c:otherwise>
									<c:set var="nttSj"><spring:message code="wzwg.cmm.word.untitle"/></c:set>
								</c:otherwise>
							</c:choose>	
							<c:if test="${adminAuthAt eq 'Y'}">
								<input type="checkbox" name="nttChk" id="nttChk" value="${fn:escapeXml(resultList.nttSeq)}" title="<spring:message code="wzwg.cmm.word.rowchoise" />"/>				
							</c:if>						
							<c:if test="${resultList.lv > 1}">
								<c:set var="pd_reply_class" value="${(10 * resultList.lv) - 10}" />
								<img src="/images/wzwg/module/ntt/icoReply.png" style="margin-left:${fn:escapeXml(pd_reply_class)}px;" alt="<spring:message code="wzwg.cmm.word.answer03" />" />
							</c:if>
							
							<c:if test="${resultList.secretAt eq 'Y'}">
								<img src="/images/wzwg/module/ntt/ico-secret.png" alt="<spring:message code="wzwg.module.word.secretposts" />" />
							</c:if>
							
							<c:out value="${nttSj}"/>
							
							<span class="colorRed">[<c:out value="${resultList.answerCnt}"/>]</span>		
											
						</p>
						<div class="inquiry">
							<ul>
								<li><spring:message code="wzwg.cmm.word.inqire" /> <c:out value="${resultList.inqireCnt}"/></li>
								<li><c:out value="${resultList.frstRegistPnttm}"/></li>
							</ul>
							<span>
								<c:if test="${resultList.annymtyAt eq 'Y'}"><spring:message code="wzwg.cmm.word.annymty" /></c:if>
								<c:if test="${resultList.annymtyAt ne 'Y'}"><c:out value="${resultList.ntcrNm}"/></c:if>	
							</span>
						</div>
					</div>
				</li>
				
				<c:if test="${mobileAt eq 'N'}">
				<c:if test="${status.count % 4 == 0 or status.last}">
					</ul>
				</c:if>
				</c:if>
				
				</c:forEach>
				
				<c:if test="${mobileAt eq 'Y'}">
					</ul>
				</c:if>

			
			<!-- album end -->
			</c:if>
			
			<c:set var="regAuthAt" value="" />
			
			<c:if test="${nttAuthVO.authorSe eq 'W' or adminAuthAt eq 'Y' or cmntAuthW eq 'Y'}">
				<c:set var="regAuthAt" value="Y" />
			</c:if>				
			
			<c:if test="${empty resultList}">
				<div style="text-align:center;">
					<spring:message code="wzwg.cmm.msg.MSG057" />
				</div>
			</c:if>				
			
			<c:if test="${!empty resultList}">
			<div class="ctr-box">
				<ul class="num">
					<ui:pagination paginationInfo="${paginationInfo}" type="ntt" jsFunction="fnPage" />
				</ul>
			</div>
			</c:if>
			
			<div class="ctr-box">
				<c:set var="searchTit"><spring:message code="wzwg.module.word.searchse" /></c:set>
				<c:set var="searchkeyinp"><spring:message code="wzwg.module.word.searchkeywordinput" /></c:set>
				<form:select path="searchCondition" id="searchCondition" title="${fn:escapeXml(searchTit)}"> 
					<form:option value="1"><label for="option1"><spring:message code="wzwg.cmm.word.sj" />+<spring:message code="wzwg.cmm.word.cn" /></label></form:option>
					<form:option value="2"><label for="option2"><spring:message code="wzwg.cmm.word.sj" /></label></form:option>
					<form:option value="3"><label for="option3"><spring:message code="wzwg.module.word.wrternm" /></label></form:option>
				</form:select>
				<c:set var="srchwrd">
					<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
				</c:set>
				<form:input path="searchKeyword" id="searchKeyword" placeholder="${fn:escapeXml(srchwrd)}" cssClass="txt" onkeydown="if(event.keyCode == 13){fnPage(1);}" title="${fn:escapeXml(searchkeyinp)}"/>	
				<a href="javascript:void(0);" class="wzbtn-table btn-srch" onclick="fnPage(1);" title="<spring:message code="wzwg.module.word.searchbutton" />"><spring:message code="wzwg.cmm.word.search01" /></a>			 
			</div>				
			
			<c:if test="${adminAuthAt eq 'Y'}">
			
			<div class="rt-box">
				<a href="javascript:void(0);" class="wzbtn btn-save" id="recycle_btn"><spring:message code="wzwg.module.word.choiserecovry" /></a>
				<a href="javascript:void(0);" class="wzbtn btn-del" onclick="fnDeleteNtt();"><spring:message code="wzwg.module.word.choisedelete" /></a>
				<a href="javascript:void(0);" class="wzbtn btn-red-bg" onclick="fnDeleteNttAll();">※ <spring:message code="wzwg.module.word.alldelete" /></a>												
			</div>	
			
			</c:if>				
		
		</form:form>
		