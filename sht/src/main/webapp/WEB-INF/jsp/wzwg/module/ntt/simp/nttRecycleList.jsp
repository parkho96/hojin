<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<% 
	String getUrl = request.getServerName().toString();
	String getPort = String.valueOf(request.getServerPort());
	if(getPort.equals("80")){getPort="";} else {getPort= ":"+getPort;}	
%>

<script src="/clipboard/dist/clipboard.min.js"></script>

<script type="text/javascript">

$(document).ready(function(){	

	// 복원
	$('#recycle_btn').click(function(){
		if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.recovry" /></spring:argument></spring:message>')){
			return false;
		}else{
			var checkCnt = 0;
			var simpnttChkArr = "";
	
			$("input[name=simpnttChk]").each(function(){
				if(this.checked){
					simpnttChkArr += $(this).val() + ",";
					checkCnt++;
				}
			});
			
			if(checkCnt < 1){
				alert('<spring:message code="wzwg.cmm.msg.MSG087" />');
				return false;
			}
				
			var frm = document.listFrm;
			
			frm.checkSimpnttSeq.value = simpnttChkArr;

			$.ajax({
					type:'POST'
				, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/simp/modifyNttRecycleAjax.do'
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
	$("input[name=simpnttAllChk]").on('click', function(){
		var boolean_chk = $("input[name=simpnttAllChk]").get(0).checked;
		$("input[name=simpnttChk]").each(function(){
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
	
	function fnDeleteSimpNtt() {
		if(!confirm('<spring:message code="wzwg.cmm.msg.MSG060" />')){
			return false;
		}else{
			var checkCnt = 0;
			var simpnttChkArr = "";
	
			$("input[name=simpnttChk]").each(function(){
				if(this.checked){
					simpnttChkArr += $(this).val() + ",";
					checkCnt++;
				}
			});
			
			if(checkCnt < 1){
				alert('<spring:message code="wzwg.cmm.msg.MSG087" />');
				return false;
			}
				
			var frm = document.listFrm;
			
			frm.checkSimpnttSeq.value = simpnttChkArr;

			$.ajax({
					type:'POST'
				, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/simp/deleteSimpNttAjax.do'
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
	
	function fnDeleteSimpNttAll() {
		
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
				, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/simp/deleteSimpNttAllAjax.do'
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

	function fnPage(pageIndex){
		if(isNaN(pageIndex)){console.log('잘못된 페이지호출');return;}
		var frm = document.listFrm;
		
		frm.pageIndex.value = pageIndex;
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/simp/selectNttRecycleListAjax.do'
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

	    	return false;
		}
	}		
</script>

	<div class="wz_notice brbox bg-white br-blue-strong fl mt10" style="overflow:visible;">
	        <ul class="wd100 pl0">
                <li class="admpg-subp wd100" style="list-style:none;">· <spring:message code="wzwg.cmm.msg.MSG0071"/></li>
                <li class="admpg-subp wd100" style="list-style:none;">· <spring:message code="wzwg.cmm.msg.MSG0072"/></li>
	        </ul>
	</div>


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
		<form:hidden path="simpnttSeq" />
		<form:hidden path="pageIndex" />
		<form:hidden path="ordrSe" />
		<form:hidden path="searchCnd" />
		<form:hidden path="checkSimpnttSeq" />	
		
	
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

	<c:if test="${!empty resultList}">
	
	<c:if test="${adminAuthAt eq 'Y'}">
		<div class="mb10 pl10">
			<label>
			<input type="checkbox" name="simpnttAllChk" id="simpnttAllChk" title="<spring:message code="wzwg.module.word.allchoise" />"/>
			<span><spring:message code="wzwg.module.word.allchoise" /></span>
			</label>
		</div>					
	</c:if>
	
	<c:forEach var="resultList" items="${resultList}" varStatus="status">
	
		<c:set var="detAuthAt" value="" />
		<c:set var="modAuthAt" value="" />
		<c:set var="delAuthAt" value="" />
		
		<c:if test="${loginVO.usrSeq eq resultList.ntcrSeq or nttAuthVO.authorSe eq 'R' or nttAuthVO.authorSe eq 'W' or sessionScope.SADMIN_AT or sessionScope.NADMIN_AT}">
			<c:set var="detAuthAt" value="Y" />
		</c:if>	
		
		<c:if test="${loginVO.usrSeq eq resultList.ntcrSeq or sessionScope.SADMIN_AT or sessionScope.NADMIN_AT}">
			<c:set var="modAuthAt" value="Y" />
			<c:set var="delAuthAt" value="Y" />
		</c:if>		
		
		<input type="hidden" id="nttCn_<c:out value='${resultList.simpnttSeq}'/>" value="<c:out value='${resultList.nttCn}'/>"/>	
	
		<div class="board001 mb5 simp_list_del">
			<div class="list_tit">			
				<h3>
					<c:if test="${adminAuthAt eq 'Y'}">
						<input type="checkbox" name="simpnttChk" id="simpnttChk" value="<c:out value='${resultList.simpnttSeq}'/>" title="<spring:message code="wzwg.cmm.word.rowchoise" />"/>				
					</c:if>					
				</h3>
				<p class="list_date">
					<c:out value="${resultList.frstRegistPnttm}"/>
				</p>
			</div><!-- list_tit end -->
			<div class="list_content">			
				<div class="conTop">
					<h4><c:out value="${resultList.ntcrNm}"/>(<c:out value="${fn:substring(resultList.ntcrId, 0, 4)}"/>****)</h4>			
				</div>
				<div class="conMiddle">
					<div class="conM_txt">
						<div id="nttCnDiv<c:out value='${status.index}'/>_<c:out value='${resultList.simpnttSeq}'/>">

							<c:out value='${resultList.nttCn}' escapeXml="false" />
	
						</div>				
					</div>

				</div>
				<div class="conBottom">

				</div><!-- conBottom end -->
			</div>
		</div>
	
	</c:forEach>
		
	</c:if>
	
	<c:if test="${empty resultList}">
		<div class="mt30">
			<ul>
				<li style="text-align:center;"><spring:message code="wzwg.cmm.msg.MSG057" /></li>
			</ul>
		</div>
	</c:if>		
	
	<c:if test="${!empty resultList}">
		<div class="ctr-box">
			<ul class="num">
				<ui:pagination paginationInfo="${paginationInfo}" type="ntt" jsFunction="fnPage" />
			</ul>
		</div>
	</c:if>
	
	<c:if test="${adminAuthAt eq 'Y'}">
	
	<div class="rt-box">
		<a href="javascript:void(0);" class="wzbtn btn-save" id="recycle_btn"><spring:message code="wzwg.module.word.choiserecovry" /></a>
		<a href="javascript:void(0);" class="wzbtn btn-del" onclick="fnDeleteSimpNtt();"><spring:message code="wzwg.module.word.choisedelete" /></a>
		<a href="javascript:void(0);" class="wzbtn btn-red-bg" onclick="fnDeleteSimpNttAll();">※ <spring:message code="wzwg.module.word.alldelete" /></a>												
	</div>	
	
	</c:if>	
		
	</form:form>