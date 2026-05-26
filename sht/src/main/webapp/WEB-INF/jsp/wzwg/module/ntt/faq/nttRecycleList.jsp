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
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/faq/selectNttRecycleListAjax.do'
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
					, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/faq/modifyNttRecycleAjax.do'
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
		
		
		$('#boardCaption').html($('#menuNm').val() + ' 목록');
		
		
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
				, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/faq/deleteNttAjax.do'
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
				, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/faq/deleteNttAllAjax.do'
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
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/faq/selectNttDetailAjax.do'
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
		if(isNaN(pageIndex)){console.log('잘못된 페이지호출');return;}
		var frm = document.listFrm;
		
		frm.pageIndex.value = pageIndex;
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/faq/selectNttRecycleListAjax.do'
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
			
			<div class="wz_notice brbox bg-white br-blue-strong fl mt10" style="overflow:visible;">
		        <ul class="wd100 pl0">
	                <li class="admpg-subp wd100" style="list-style:none;">· <spring:message code="wzwg.cmm.msg.MSG0071"/></li>
	                <li class="admpg-subp wd100" style="list-style:none;">· <spring:message code="wzwg.cmm.msg.MSG0072"/></li>
		        </ul>
			</div>
			
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
				<!-- <a href="javascript:void(0);" class="wzbtn-table btn-black" onclick="fnSearchReset();"><spring:message code="wzwg.cmm.word.initl" /></a> -->	
			</div>				
			
			<c:if test="${resultVO.cmntUseAt ne 'Y'}">
			<div class="main-menu-bar i-block">
				<c:import url="${wzwg_contextPath}${prefix}/module/bbs/cmmn/selectBbsSubospecSelectListAjax.do" charEncoding="utf-8">
					<c:param name="param_bbsSeq" value="${paramVO.bbsSeq}" />
				</c:import>	
			</div>	
			</c:if>
			
			<%-- <c:set var="tableCss" value="basic-table02 txt-c"/>
			<c:if test="${paramVO.mngrAt eq 'N'}">
				<c:set var="tableCss" value="basic-table01"/>
			</c:if>		 --%>	
			
			<c:set var="tableCss" value="basic-table mt30 fl"/>
				
			
			<table class="<c:out value='${tableCss}'/>">
			<caption id="boardCaption"><spring:message code="wzwg.module.word.postlist" /></caption>
				  <colgroup>
					<c:if test="${adminAuthAt eq 'Y'}">
						<col width="5%"/>						
					</c:if>
					<c:if test="${mobileAt eq 'N'}">
						<col width="10%"/>
					</c:if>
						<col width="*"/>
						<col width="10%"/>
						<col width="10%"/>
			      </colgroup>
				  <thead>
					<tr>
						<c:if test="${adminAuthAt eq 'Y'}">
							<th scope="col"><input type="checkbox" name="nttAllChk" id="nttAllChk" title="<spring:message code="wzwg.cmm.word.rowallchoise" />"/></th>					
						</c:if>
						<c:if test="${mobileAt eq 'N'}">
							<th scope="col"><span><spring:message code="wzwg.cmm.word.no" /></span></th>
						</c:if>
						<th scope="col"><span><spring:message code="wzwg.cmm.word.sj" /></span></th>
						<th scope="col"><span><spring:message code="wzwg.cmm.word.wrter" /></span></th>
						<th scope="col">
							<span id="frstRegistPnttm_asc"><spring:message code="wzwg.cmm.word.rgsde02" /></span>
						</th>
					</tr>
			      </thead>
				  <tbody>		  
				  
					<c:if test="${!empty resultList}">
			
						<c:forEach var="resultList" items="${resultList}" varStatus="status">		
							
						<tr>
							
							<c:if test="${adminAuthAt eq 'Y'}">
								<td>
									<input type="checkbox" name="nttChk" id="nttChk" value="${fn:escapeXml(resultList.nttSeq)}" title="<spring:message code="wzwg.cmm.word.rowchoise" />"/>
								</td>
							</c:if>						
			
							<c:if test="${mobileAt eq 'N'}">
			
							<td><c:out value='${resultList.nttSeq}'/></td>
							
							</c:if>
							
							<td class="txt-l">								
								<c:choose>
									<c:when test="${!empty resultList.nttSj}">
										<c:if test="${fn:length(resultList.nttSj) > 43}">
											<c:set var="nttSj" value="${fn:substring(resultList.nttSj, 0, 43)}..." />
										</c:if>
										<c:if test="${fn:length(resultList.nttSj) < 44}">
											<c:set var="nttSj" value="${resultList.nttSj}" />
										</c:if>
									</c:when>
									<c:otherwise>
										<c:set var="nttSj"><spring:message code="wzwg.cmm.word.untitle"/></c:set>
									</c:otherwise>
								</c:choose>
						
								<c:if test="${resultList.lv > 1}">
									<c:set var="pd_reply_class" value="${(10 * resultList.lv) - 10}" />
									<img src="/images/wzwg/module/ntt/icoReply.png" style="margin-left:${fn:escapeXml(pd_reply_class)}px;" alt="<spring:message code="wzwg.cmm.word.answer03" />" />
								</c:if>
							
								<c:if test="${!empty resultList.subospecSj}">
									<span>[<c:out value="${resultList.subospecSj}"/>]</span>
								</c:if>
								
								<c:if test="${resultList.secretAt eq 'Y'}">
									<img src="/images/wzwg/module/ntt/ico-secret.png" alt="<spring:message code="wzwg.module.word.secretposts" />" />
								</c:if>
								
								<c:out value="${nttSj}"/>
							
								<span class="colorRed">[<c:out value="${resultList.answerCnt}"/>]</span>
	
								
								<c:if test="${resultList.nttNew eq 'Y'}">
									<img src="/images/wzwg/module/ntt/new.png" alt="<spring:message code="wzwg.module.word.newpostsicon" />"/>
								</c:if>
								
								<c:if test="${resultList.atchFileCnt ne '0'}">
									<img src="/images/wzwg/module/ntt/ico-file.gif" alt="<spring:message code="wzwg.module.word.atchfileicon" />"/>
								</c:if>							
							</td>
							<td><c:out value="${resultList.ntcrNm}"/></td>
							<td><c:out value="${resultList.frstRegistPnttm}"/></td>
						</tr>	
						</c:forEach>
					</c:if>		
					
					<c:set var="colCnt" value="4" />
					<c:if test="${adminAuthAt eq 'Y'}">
						<c:set var="colCnt" value="5" />
					</c:if>
					
					<c:if test="${mobileAt eq 'Y'}">
						<c:set var="colCnt" value="${colCnt - 1}" />
				 	</c:if>
							
					<c:if test="${empty resultList}">
						<tr>
							<td colspan="${fn:escapeXml(colCnt)}"><spring:message code="wzwg.cmm.msg.MSG057" /></td>
						</tr>
					</c:if>	

				  </tbody>
			</table>
			
			<c:if test="${!empty resultList}">
			<div class="ctr-box">
				<ul class="num">
					<ui:pagination paginationInfo="${paginationInfo}" type="ntt" jsFunction="fnPage" />
				</ul>
			</div>
			</c:if>
			
			<div class="ctr-box" id="nttSearch">
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
	
