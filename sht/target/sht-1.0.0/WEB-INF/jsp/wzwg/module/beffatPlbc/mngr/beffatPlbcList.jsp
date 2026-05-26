<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script>

$(document).ready(function(){
	
	if($('#srchCtgryCd').val() != ''){
		$('#srchBtnCtgry_' + $('#srchCtgryCd').val()).click();
	}else{
		$('#srchBtnCtgry_ALL').click();
	}
	
	if($('#srchPblcSn').val() != ''){
		fnSelectPblbcList($('#srchPblcSn').val());
	}
	
});

function fnSelectPblbcList(subOpen){

	var formData = {}
	if($('#srchCtgryCd').val() != ''){
		formData.srchCtgryCd = $('#srchCtgryCd').val();
	}
	if($('#srchPblcSn').val() != ''){
		formData.srchPblcSn = $('#srchPblcSn').val();
	}
	
	var searchKeyword = $('#searchKeyword').val();
	if(searchKeyword != ''){
		formData.searchCondition = $('#searchCondition').val();
		formData.searchKeyword = $('#searchKeyword').val();
	}
	
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/module/beffatPlbc/selectBeffatPlbcListItemAjax.do'
		 , data : formData
		 , async : true
		 , success:function (data) {
			 $('#beffatPlbcListArea').html(data);
			 
			 if(subOpen == 'true'){
				 fnSubBplbcListToggle($('#srchPblcSn').val());//서브데이터 로딩
			 }
			 
			 //$('#srchPblcSn').val('');//검색용 정보공개 순번은 1회용으로 처리
			 
		 }
		 , dataType: 'html'
	});
}

function fnSelectPblbcListToctgry(ctgryCd){
	//$('#searchKeyword').val(''); // 카테고리 클릭시 검색키워드 리셋
	
	$('#srchCtgryCd').val(ctgryCd);
	$('#srchCtgryList button').removeClass('bg-blue-strong');
	$('#srchBtnCtgry_' + ctgryCd).addClass('bg-blue-strong');
	fnSelectPblbcList();
}

function fnSelectPblbcListToPblcSn(srchPblcSn){
	//$('#searchKeyword').val(''); // 카테고리 클릭시 검색키워드 리셋
	
	$('#srchCtgryCd').val('ALL');
	$('#srchCtgryList button').removeClass('bg-blue-strong');
	$('#srchBtnCtgry_ALL').addClass('bg-blue-strong');
	
	$('#srchPblcSn').val(srchPblcSn);
	fnSelectPblbcList('true');//메인데이터 로딩
	
}


function fnSelectSubBplbcList(pblcSn, pageIndex){
	var formData = {}
	formData.pblcSn = pblcSn;
	if(pageIndex != undefined && pageIndex != ''){
		formData.pageIndex = pageIndex;
	}
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/module/beffatPlbc/selectBeffatPlbcSubListAjax.do'
		 , data:formData
		 , success:function (data) {
			 $('#subtd_' + pblcSn).html(data);
			 $('#subtr_' + pblcSn).show();
		 }
		 , dataType: 'html'
	});
	
}

function fnSubBplbcListToggle(pblcSn){
	if($('#subtr_' + pblcSn).isDisplayNone()){
		fnSelectSubBplbcList(pblcSn);
	}else{
		$('#subtr_' + pblcSn).hide();
	}
}

function fnAddQuickItem(){
    if( $(':checkbox[name="qkMenuYn"]:checked').length < 1 ){
        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
				'<spring:argument><spring:message code="wzwg.module.word.publictinfolist" /></spring:argument>'+
				'<spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument>'+
			  '</spring:message>');
        return;
    }
    
	var qkMenuYnArr = [];
	$('input[name="qkMenuYn"]:checked').each(function(){
		qkMenuYnArr.push($(this).val());
	});
	
	//console.log(qkMenuYnArr);
	
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/module/beffatPlbc/modifyBeffatPlbcQkMenuAjax.do'
		 , data:{'qkMenuYnArrStr' : qkMenuYnArr.join(), 'frmTy' : 'R'} 
		 , success:function (data) {
			 console.log(data);
			 console.log(data.body.updateCnt);
			 console.log(data.head.result == 'success' && qkMenuYnArr.length == data.body.updateCnt);
			 if(data.head.result == 'success' && qkMenuYnArr.length == data.body.updateCnt){
				 fnQkMenuList();
				 alert('<spring:message code="wzwg.cmm.cmmMsg.CMG010"><spring:argument><spring:message code="wzwg.cmm.word.change" /></spring:argument></spring:message>');
			 }else{
				 alert('<spring:message code="fail.common.msg" text="error" />');
			 }
		 }
		 , dataType: 'json'
	});
}

function fnDelQuickItem(pblcSn){
	
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/module/beffatPlbc/modifyBeffatPlbcQkMenuAjax.do'
		 , data:{'qkMenuYnArrStr' : pblcSn, 'frmTy' : 'D'} 
		 , success:function (data) {
			 if(data.head.result == 'success' && data.body.updateCnt == 1){
				 alert('<spring:message code="wzwg.cmm.cmmMsg.CMG010"><spring:argument><spring:message code="wzwg.cmm.word.change" /></spring:argument></spring:message>');
				 fnQkMenuList();
			 }else{
				 alert('<spring:message code="fail.common.msg" text="error" />');
			 }
		 }
		 , dataType: 'json'
	});
}

function fnQkMenuList(){
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/module/beffatPlbc/selectBeffatPlbcQkMenuListAjax.do'
		 , data:{} 
		 , success:function (data) {
			 $('#qkMenuListArea').html(data);
		 }
		 , dataType: 'html'
	});
}


function fnBplbcListModifyOrdr(ordr, pblcSn){
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/module/beffatPlbc/ModifyBeffatPlbcMainOrdrAjax.do'
		 , data:{'ordr':ordr, 'pblcSn' : pblcSn} 
		 , success:function (data) {
			 console.log(data);
			 	if(data.head.result == 'success'){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.change" /></spring:argument></spring:message>');
					fnSelectPblbcList();
				}else if(data.head.msg == '001' && ordr == 'U'){
					alert('<spring:message code="wzwg.cmm.msg.MSG176" />');
				}else if(data.head.msg == '001' && ordr == 'D'){
					alert('<spring:message code="wzwg.cmm.msg.MSG175" />');
				}else{	
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.change" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
				}
		 }
		 , dataType: 'json'
	});
}


function fnSearchPblcList(){
	var searchKeyword = $('#searchKeyword').val();
	if(searchKeyword == ''){
		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
		$('#searchKeyword').focus();
		return; 
	}
	
	fnSelectPblbcList();
}
</script>

<div>
	<h3 class="wzAdmSTit wd100 fl"><spring:message code="wzwg.cmm.word.favorite" /> <spring:message code="wzwg.cmm.word.publictinfo" /></h3>
	<ul id="qkMenuListArea"><c:import url="${wzwg_contextPath}/mngr/module/beffatPlbc/selectBeffatPlbcQkMenuListAjax.do"></c:import></ul>
</div>

<div class="mt30">
	<h3 class="wzAdmSTit wd100 fl"><spring:message code="wzwg.module.word.publictinfocl" /> </h3>
	<ul id="srchCtgryList">
		<c:forEach items="${catrgoryList }" var="list">
		<li class="i-block wd15 mg5">
			<button type="button" class="wzbtn btn-basic wd100" id="srchBtnCtgry_<c:out value='${list.ctgryCd}'/>" onclick="fnSelectPblbcListToctgry('<c:out value="${list.ctgryCd}"/>')">
				<c:if test="${not empty list.storFileId }">
				<img class="hgt50" src="<c:out value='${wzwg_contextPath}'/>/module/upload/file/selectImageView.do?atchFileId=<c:out value='${list.storFileId }'/>&fileSn=0">
				</c:if>
				<c:if test="${empty list.storFileId }">
				<img class="hgt50" src="/images/wzwg/site/noImg/noImageLogo_s.jpg">
				</c:if>
				<div><c:out value="${list.ctgryDcCn }"/></div>
			</button>
		</li>
		</c:forEach>
	</ul>
</div>

<div class="mt30">
	<h3 class="wzAdmSTit wd100 fl"><spring:message code="wzwg.module.word.publictinfolist" /> </h3>
	<div class="wzAdmSrchbox txt-r box-border p20 br5 mb0">
	    <div class="wd100 block fl">
	      	<label class="fs16 vert-m wd15 linehgt40 fw600 mr10" for="siteLclasGroup"><spring:message code="wzwg.cmm.word.search01" /></label>
	      	<select name="searchCondition" id="searchCondition" title="<spring:message code="wzwg.module.word.publictlistse" />">
				<option value="beffatPblcSj" <c:if test="${empty paramVO.searchCondition or paramVO.searchCondition eq 'beffatPblcSj'}">selected="selected"</c:if>><spring:message code="wzwg.module.word.publictlist" /></option>
				<option value="deptVal" <c:if test="${paramVO.searchCondition eq 'deptVal'}">selected="selected"</c:if>><spring:message code="wzwg.module.word.deptpeople" /></option>
			</select>
			<input type="text" name="searchKeyword" id="searchKeyword" value="<c:out value='${paramVO.searchKeyword}'/>" placeholder="<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>" title="<spring:message code="wzwg.cmm.word.srchwrd" /> <spring:message code="wzwg.cmm.word.wa.inpcmpt" />">
        	<button onclick="fnSearchPblcList();" id="search" class="wzbtn-table btn-srch"><spring:message code="wzwg.cmm.word.search01" /></button>
	    </div>
	</div>
	<div id="beffatPlbcListArea"></div>
</div>

<div class="crt-box">
	<!-- <span class="fs15 fl p5">즐겨찾기</span> -->
	<button type="button" class="wzbtn btn-basic fl" onclick="fnAddQuickItem()"><spring:message code="wzwg.module.word.bkmkregist" /></button>
	<!-- <button type="button" class="wzbtn btn-del fl ml5" onclick="fnDelQuickItem()">삭제</button> -->
	
	<button type="button" class="wzbtn btn-save bg fr" onclick="fnBeffatPlbcMainRegFrm()"><spring:message code="wzwg.cmm.word.regist" /></button>
</div>