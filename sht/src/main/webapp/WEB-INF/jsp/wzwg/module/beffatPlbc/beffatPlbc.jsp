<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<link type="text/css" href="/css/wzwg/module/beffatPlbc/beffatPlbc.css" rel="stylesheet" /> <!-- 사전정보 공표 css-->
<script src="/js/wzwg/cmm/cross-browser-grayscale/grayscale.js"></script>
<script type="text/javascript" src="/clipboard/dist/clipboard.min.js"></script>
 


<script>
$(document).ready(function(){
	//fnSelectPblbcList();
	
	//fnQkMenuList();
	var queryMap = fnGetQueryMap();//파라미터맵 세팅
	console.log(queryMap);
	if(queryMap.pblcSn == null || queryMap.pblcSn == '' || queryMap.pblcSn == undefined){
		$('#srchBtnCtgry_ALL').click();
		//console.log('기본호출');
	}else{
		fnSelectPblbcListToQkMenu(queryMap.pblcSn);
		//console.log('파라미터 반응');
	}
	
	
	if(getIEVersion() >= 10){
		$('#srchCtgryList li').each(function(){
			if($(this).hasClass('on') == false){
				grayscale($(this).find('img'));
			}
		});
		$('#srchCtgryList li').on({
					'mouseover' : function(e){
						//console.log('li mouseover');
						
						grayscale.reset($(this).find('img'));
						//내것만 복구
						
					}
					,'mouseleave' : function(e){
						//console.log('li mouseleave');
						if($(this).hasClass('on') == false){
							grayscale($(this).find('img'));
						}
					}
		});
	}else{
		//$('#srchCtgryList img').each(function(){
		//});
	}
	
	
});

function getIEVersion(){
	var rv = -1;
	if (navigator.appName == 'Microsoft Internet Explorer'){
		var ua = navigator.userAgent;
		var re  = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
		if (re.exec(ua) != null)
		rv = parseFloat( RegExp.$1 );
	}
	else if (navigator.appName == 'Netscape'){
		var ua = navigator.userAgent;
		var re  = new RegExp("Trident/.*rv:([0-9]{1,}[\.0-9]{0,})");
		if (re.exec(ua) != null)
		rv = parseFloat( RegExp.$1 );
	}
	return rv;
};

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
		 , url:'<c:out value="${wzwg_contextPath}"/>/module/beffatPlbc/selectBeffatPlbcUsrListItemAjax.do'
		 , data : formData
		 , async : true
		 , success:function (data) {
			 $('#beffatPlbcListArea').html(data);
			 
			 $('#beffatPlbcListArea').find('.admBtn').each(function(){
				//관리자 주소복사 기능 데이터 입력
				$(this).attr('data-clipboard-text', location.origin + location.pathname + '?pblcSn=' + $(this).attr('data-pblcSn'));
			 });
			 
			 if(subOpen == 'true'){
				 fnSubBplbcListToggle($('#srchPblcSn').val());//서브데이터 로딩
			 }
			 
			 $('#srchPblcSn').val('');//검색용 정보공개 순번은 1회용으로 처리

			 if(searchKeyword != ''){
				 if($('#searchCondition').val() == 'beffatPblcSj'){
					 $('#mainListTit').html('<spring:message code="wzwg.module.word.listsearch" /> : ' + searchKeyword);
				 }
				 if($('#searchCondition').val() == 'deptVal'){
					 $('#mainListTit').html('<spring:message code="wzwg.module.word.chrgdeptsearch" /> : ' + searchKeyword);
				 }
			 }
			 
		 }
		 , dataType: 'html'
	});
}

function fnSelectPblbcListToctgry(ctgryCd, ctgryDcCn){
	$('#searchKeyword').val(''); // 카테고리 클릭시 검색키워드 리셋
	
	$('#srchCtgryList li').each(function(){
		if($(this).hasClass('on')){
			if(getIEVersion() >= 10){
				grayscale($(this).find('img'));
			}
		}
		
		//$(this).removeClass('on');
	})

	$('#srchCtgryCd').val(ctgryCd);
	$('#srchCtgryList li').removeClass('on');
	$('#srchLICtgry_' + ctgryCd).addClass('on');
	
	$('#qkMenuListArea li').removeClass('on'); // 퀵메뉴 선택 리셋
	//$('#srchCtgryList li').removeClass('select');
	//$('#srchLICtgry_' + ctgryCd).addClass('on');
	
	fnSelectPblbcList();
	$('#mainListTit').html(ctgryDcCn + ' <spring:message code="wzwg.module.word.priorinfolist" />');
}

function fnSelectPblbcListToQkMenu(srchPblcSn, _btn){
	$('#searchKeyword').val(''); // 카테고리 클릭시 검색키워드 리셋
	
	$('#srchCtgryCd').val('ALL');
	$('#srchCtgryList li').removeClass('on');
	$('#srchLICtgry_ALL').addClass('on');
	
	$('#srchPblcSn').val(srchPblcSn);
	fnSelectPblbcList('true');//메인데이터 로딩
	
	$('#qkMenuListArea li').removeClass('on');
	$('#qkMenu_' + srchPblcSn).addClass('on');
	$('#mainListTit').html('<spring:message code="wzwg.module.word.alllistpriorinfolist" />');
}

function fnSubBplbcListToggle(pblcSn){
	if($('#subtr_' + pblcSn).isDisplayNone()){
		fnSelectSubBplbcList(pblcSn);
	}else{
		$('#subtr_' + pblcSn).hide();
	}
}

function fnSelectSubBplbcList(pblcSn, pageIndex){
	var formData = {}
	formData.pblcSn = pblcSn;
	if(pageIndex != undefined && pageIndex != ''){
		formData.pageIndex = pageIndex;
	}
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}"/>/module/beffatPlbc/selectBeffatPlbcUsrSubListAjax.do'
		 , data : formData
		 , success:function (data) {
			 $('#subtd_' + pblcSn).html(data);
			 $('#subtr_' + pblcSn).show();
			 //history.pushState(null,null, location.pathname + '?pblcSn=' + pblcSn);
			 //location.replace(location.pathname + '?pblcSn=' + pblcSn);
		 }
		 , dataType: 'html'
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

//주소복사
function fnOnClipboard(btnId){
	var clipboard = new Clipboard('#' + btnId);
    clipboard.on('success', function(e) {
        alert('<spring:message code="wzwg.cmm.msg.MSG083" />');
        clipboard.destroy();
        $('#adres_copy_btn').focus();
    });
    clipboard.on('error', function(e) {
        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
        return false;
        clipboard.destroy();
    });
}

</script>

<input type="hidden" name="srchCtgryCd" id="srchCtgryCd" value="">
<input type="hidden" name="srchPblcSn" id="srchPblcSn" value="">

<div class="beffatPlbc">
	<div>
		<h5 class="btit fs18"><spring:message code="wzwg.module.word.favoritepriorinfo" /></h5>
		<ul id="qkMenuListArea">
			<c:forEach items="${beffatPlbcQkMenuList }" var="list">
				<li id="qkMenu_<c:out value='${list.pblcSn }'/>">
					<button type="button" class="" onclick="fnSelectPblbcListToQkMenu('<c:out value="${list.pblcSn}"/>', this)"><c:out value="${list.beffatPblcSj }"/></button>
				</li>
			</c:forEach>
		</ul>
	</div>
	
		<h5 class="btit fs18"><spring:message code="wzwg.cmm.word.priorinfo" /></h5>
		<ul id="srchCtgryList" class="container">
			<c:forEach items="${catrgoryList }" var="list">
			<li class="" id="srchLICtgry_<c:out value='${list.ctgryCd}'/>">
				<button type="button" id="srchBtnCtgry_<c:out value='${list.ctgryCd}'/>" onclick="fnSelectPblbcListToctgry('<c:out value="${list.ctgryCd}"/>', '<c:out value="${list.ctgryDcCn }"/>')">
					<div class="imgbox">
						<c:if test="${not empty list.storFileId }">
						<img src="<c:out value='${wzwg_contextPath}'/>/module/upload/file/selectImageView.do?atchFileId=<c:out value='${list.storFileId}'/>&fileSn=0" class="img" alt="">
						</c:if>
						<c:if test="${empty list.storFileId }">
						<img src="/images/wzwg/site/noImg/noImageLogo_s.jpg" class="img" alt="">
						</c:if>
					</div>
					<div class="tit"><c:out value="${list.ctgryDcCn }"/></div>
				</button>
			</li>
			</c:forEach>
		</ul>
	
	<div class="srchFrm_wrap">
		<h6 class="btit fs18 fl" id="mainListTit"><spring:message code="wzwg.module.word.priorinfolist" /></h6>
		<div class="srchFrm basicSrchbox">
			<select name="searchCondition" id="searchCondition" title="<spring:message code="wzwg.module.word.listse" />">
				<option value="beffatPblcSj"><spring:message code="wzwg.module.word.listnm" /></option>
				<option value="deptVal"><spring:message code="wzwg.module.word.deptpeople" /></option>
			</select>
			<input type="text" name="searchKeyword" id="searchKeyword" placeholder="<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>" title="<spring:message code="wzwg.cmm.word.srchwrd" /> <spring:message code="wzwg.cmm.word.wa.inpcmpt" />">
			<button type="button" class="wzbtn btn-srch" onclick="fnSearchPblcList()"><spring:message code="wzwg.cmm.word.search01" /></button>
		</div>
	</div>
	
	<div id="beffatPlbcListArea"></div>
</div>