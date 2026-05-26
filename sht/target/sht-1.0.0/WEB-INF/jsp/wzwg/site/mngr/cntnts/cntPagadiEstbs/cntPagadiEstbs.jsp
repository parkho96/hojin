<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

	<script>
		function fnTabreload(nttSeq){
		 try{
         	fnNttDetail(nttSeq);
         	return;
         }catch(e){console.log(e.message);}
     	try{
         	fnTabChange('cntPagadiEstbs');
         	return;
         }catch(e){console.log(e.message);}
         try{
         	fnTabLink('cntPagadiEstbs');
         	return;
         }catch(e){console.log(e.message);}
		}
		
		/* 담당관 설정 */
		function fnAddOclhg(){
			var newList = $('#oclhg_sample').find('tr').clone();
			$('#oclhg_body').append(newList);
		}
		function chargerSet(){
			$('.chargerSetTBL').show();
			$('.chargerSetBtnWrap').hide();
		}
		
		function fnRegistOclhg(tr){
			//console.log(tr);
			var pagoclhgSeq = $(tr).attr('data-pagoclhgSeq');
			
			var	departNm = $(tr).find('input[name="departNm"]').val();
			var	oclhgNm = $(tr).find('input[name="oclhgNm"]').val();
			var	oclhgCttpl = $(tr).find('input[name="oclhgCttpl"]').val();
			
			if(oclhgNm == ''){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.site.cntnts.msg.MSG024" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
				$(tr).find('input[name="oclhgNm"]').focus();
				return;
			}
			
			if(oclhgCttpl == ''){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.cttpc" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
				$(tr).find('input[name="oclhgCttpl"]').focus();
				return;
			}
			
			var oclhgUrl = '';
			if(pagoclhgSeq == '' || pagoclhgSeq == undefined){
				oclhgUrl = '<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/cntnts/cntPagadiEstbs/registOclghAjax.do';
			}else{
				oclhgUrl = '<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/cntnts/cntPagadiEstbs/modifyOclghAjax.do';
			}
			
			
			$.ajax({
	              type : 'POST'
	            , dataType: 'json'
	            , url : oclhgUrl
	            , data:{
	            		pagadiestbsSeq : $('#pagadiestbsSeq').val()
	            	,	'pagoclhgSeq' : pagoclhgSeq
	            	,	'departNm' : departNm
					,	'oclhgNm' : oclhgNm
					,	'oclhgCttpl' : oclhgCttpl
	            }
	            , success:function (data) {
//	                var result = $(data).find('value').text();
	                var result = data.head.result;
	                
	                if (result == 'success') {
	                	/* if(data.body.pagoclhgSeq != '' && data.body.pagoclhgSeq != undefined){
		                	$(tr).attr('data-pagoclhgSeq', data.body.pagoclhgSeq);
	                	} */
	                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
	                	fnTabreload('<c:out value="${paramVO.nttSeq}"/>');
	                }else{
	                	alert('<spring:message code="fail.common.msg" text="error" />');
	                } 
	            }
	            , error:function (data) {
	                alert('<spring:message code="fail.common.msg" text="error" />');
	            }
	        });
		}
		
		function fnDeleteOclhg(tr){
			var pagoclhgSeq = $(tr).attr('data-pagoclhgSeq');
			
			var	departNm = $(tr).find('input[name="departNm"]').val();
			var	oclhgNm = $(tr).find('input[name="oclhgNm"]').val();
			var	oclhgCttpl = $(tr).find('input[name="oclhgCttpl"]').val();

			if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006"><spring:argument><spring:message code="wzwg.site.cntnts.msg.MSG025" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>?\n [' + oclhgNm + ']')){
				var oclhgUrl = '<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/cntnts/cntPagadiEstbs/deleteOclghAjax.do';
				
				$.ajax({
		              type : 'POST'
		            , dataType: 'json'
		            , url : oclhgUrl
		            , data:{
		            		pagadiestbsSeq : $('#pagadiestbsSeq').val()
		            	,	'pagoclhgSeq' : pagoclhgSeq
		            }
		            , success:function (data) {
	//	                var result = $(data).find('value').text();
		                var result = data.head.result;
		                
		                if (result == 'success') {
		                	//$(tr).remove();
		                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
		                    fnTabreload('<c:out value="${paramVO.nttSeq}"/>');
		                }else{
		                	alert('<spring:message code="fail.common.msg" text="error" />');
		                } 
		            }
		            , error:function (data) {
		                alert('<spring:message code="fail.common.msg" text="error" />');
		            }
		        });
				
			}
			
		}
		
		function fnOclhgOrdrChange(ordrSe, oclhgSeq, oclhgOrdrNum) {
			
			$.ajax({
				type:'POST'
				, url:'<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/cntnts/cntPagadiEstbs/OclhgOrdrChangeAjax.do'
				, cache : false
				, async : false
				, data:{
						'ordrSe' : ordrSe
						, 'pagoclhgSeq' : oclhgSeq
						, 'sortOrdr' : oclhgOrdrNum
						, pagadiestbsSeq : $('#pagadiestbsSeq').val()
						}
	            , success:function (data) {
	                var result = data.head.result;
	                
	                if (result == 'success') {
	                    //alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
	                	fnTabreload('<c:out value="${paramVO.nttSeq}"/>');
	                }else{
	                	alert('<spring:message code="fail.common.msg" text="error" />');
	                } 
	            }
	            , error:function (data) {
	                alert('<spring:message code="fail.common.msg" text="error" />');
	            }
	        });
		}
		
		
		/* 저작권 설정 */
		
		function fnCpyrhtChange(tno, useAt){
			var addGuideTag = '';
			if(tno == 1){
				addGuideTag += '<li style="float: none;"><spring:message code="wzwg.cmm.cntnts.cpyrht.MSG001"/></li>';
				addGuideTag += '<li style="float: none;"><spring:message code="wzwg.cmm.cntnts.cpyrht.MSG002"/></li>';
				addGuideTag += '<li style="float: none;"><spring:message code="wzwg.cmm.cntnts.cpyrht.MSG003"/></li>';
			}else if(tno == 2){
				addGuideTag += '<li style="float: none;"><spring:message code="wzwg.cmm.cntnts.cpyrht.MSG001"/></li>';
				addGuideTag += '<li style="float: none;"><spring:message code="wzwg.cmm.cntnts.cpyrht.MSG004"/></li>';
				addGuideTag += '<li style="float: none;"><spring:message code="wzwg.cmm.cntnts.cpyrht.MSG003"/></li>';
			}else if(tno == 3){
				addGuideTag += '<li style="float: none;"><spring:message code="wzwg.cmm.cntnts.cpyrht.MSG001"/></li>';
				addGuideTag += '<li style="float: none;"><spring:message code="wzwg.cmm.cntnts.cpyrht.MSG002"/></li>';
				addGuideTag += '<li style="float: none;"><spring:message code="wzwg.cmm.cntnts.cpyrht.MSG005"/></li>';
			}else if(tno == 4){
				addGuideTag += '<li style="float: none;"><spring:message code="wzwg.cmm.cntnts.cpyrht.MSG001"/></li>';
				addGuideTag += '<li style="float: none;"><spring:message code="wzwg.cmm.cntnts.cpyrht.MSG004"/></li>';
				addGuideTag += '<li style="float: none;"><spring:message code="wzwg.cmm.cntnts.cpyrht.MSG005"/></li>';
			}
			
			$('#cpyrht-guide').empty();
			$('#cpyrht-guide').append(addGuideTag);
			
			$('#cpyrhtSe').val(tno);
		}
		
		function fnRegistCpyrht(){
			var useAt = $('input[name="cpyrhtUseAt"]:checked').val();
			var cpyrhtSe = $('input[name="cpyrhtSe"]:checked').val();
			var cpyrhtImgPath = '';
			
			if(cpyrhtSe == '' || cpyrhtSe == undefined ){
				alert('<spring:message code="wzwg.cmm.cntnts.cpyrht.MSG006" />');
				return;
			}
			
			// 이미지명은 공공누리 정책에 따라 변경 불가
			if(cpyrhtSe == '1'){
				cpyrhtImgPath = '/images/wzwg/module/cntpagead/cpyrht/img_opentype01.jpg';
			}else if(cpyrhtSe == '2'){
				cpyrhtImgPath = '/images/wzwg/module/cntpagead/cpyrht/img_opentype02.jpg';
			}else if(cpyrhtSe == '3'){
				cpyrhtImgPath = '/images/wzwg/module/cntpagead/cpyrht/img_opentype03.jpg';
			}else if(cpyrhtSe == '4'){
				cpyrhtImgPath = '/images/wzwg/module/cntpagead/cpyrht/img_opentype04.jpg';
			}
			
			$.ajax({
	              type : 'POST'
	            , dataType: 'json'
	            , url : '<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/cntnts/cntPagadiEstbs/registPagecpyrhtAjax.do'
	            , data:{
	            		pagadiestbsSeq : $('#pagadiestbsSeq').val()
	            	,	'useAt' : useAt
	            	,	'cpyrhtSe' : cpyrhtSe
	            	,	'cpyrhtImgPath' : cpyrhtImgPath
					
	            }
	            , success:function (data) {
	                var result = data.head.result;
	                
	                if (result == 'success') {
	                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
	                    fnTabreload('<c:out value="${paramVO.nttSeq}"/>');
	                }else{
	                	alert('<spring:message code="fail.common.msg" text="error" />');
	                } 
	            }
	            , error:function (data) {
	                alert('<spring:message code="fail.common.msg" text="error" />');
	            }
	        });
		}
		
		
		/* 평가하기 설정 */
		function fnEvlEstbs(){
			
			var scoreAt = $('input[name="evlScoreAt"]:checked').val();
			var opinionAt = $('input[name="evlOpinionAt"]:checked').val();
			
			if(scoreAt == '' || scoreAt == undefined ){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.site.cntnts.msg.MSG026" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument></spring:message>');
				return;
			}
			
			if(opinionAt == '' || opinionAt == undefined ){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.site.cntnts.msg.MSG027" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument></spring:message>');
				return;
			}
			
			$.ajax({
	              type : 'POST'
	            , dataType: 'json'
	            , url : '<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/cntnts/cntPagadiEstbs/registEvlEstbsAjax.do'
	            , data:{
	            		pagadiestbsSeq : $('#pagadiestbsSeq').val()
	            	,	'useAt' : scoreAt 
	            	,	'opinionUseAt' : opinionAt
					
	            }
	            , success:function (data) {
	                var result = data.head.result;
	                
	                if (result == 'success') {
	                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
	                    fnTabreload('<c:out value="${paramVO.nttSeq}"/>');
	                }else{
	                	alert('<spring:message code="fail.common.msg" text="error" />');
	                } 
	            }
	            , error:function (data) {
	                alert('<spring:message code="fail.common.msg" text="error" />');
	            }
	        });
			
		}
		
		function fnEvlScoreDetailView() {
			$.ajax({
				   type:'POST'
				 , url:'<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/cntnts/cntPagadiEstbs/evlScoreDetailViewAjax.do'
				 , data:{
					 pagadiestbsSeq : $('#pagadiestbsSeq').val()
				 }
				 , success:function (data) {
						var title = '<spring:message code="wzwg.site.cntnts.msg.MSG028" />';
					 	wzAjaxModal('popup_s', title, data);
						   }
				 , dataType: 'html'
			});
		}
		
		function fnChangeUseAtNO(radio){
			if(radio.value === 'N'){
				$('#evlOpinionAtN').prop('checked', true);
				$('#evlOpinionAtY').prop('disabled', true);
				$('#evlOpinionAtN').prop('disabled', true);
			}
			
			if(radio.value === 'Y'){
				$('#evlOpinionAtY').prop('disabled', false);
				$('#evlOpinionAtN').prop('disabled', false);
			}
		}
		
		/* 미리보기 */
		function fnImgPrevewPop(skinImg){
			
			if($('#frmPopup').length == 0){
				var frmPopup = '<form name="frmPopup" id="frmPopup" method="post" target="popForm" action="/sample/img/imgViewer.jsp"><input type="hidden" name="imgSrc" value=""></form>';
				$('body').append(frmPopup);
			}
			
			var viewImg = new Image();
			$(viewImg).attr('src', $(skinImg).attr('src'));
			var imgsrc = $(skinImg).attr('src');
			
			var width = $(viewImg)[0].naturalWidth;
			var height = $(viewImg)[0].naturalHeight;
			var frm = document.frmPopup;
			frm.imgSrc.value = imgsrc;
			
			
			var frmResult = window.open("", "popForm", "width=" + width + ",height=" + height + ",toolbars=no,menubars=no,scrollbars=yes,left=50,top=400");
			
			frm.target='popForm';
			frm.action='/sample/img/imgViewer.jsp';
			frm.submit();
		}
		
		/* 스킨 설정 */
		function fnRegistSkinEstbs() {
			
			var skinTy = $('input[name="skinTy"]:checked').val();
			
			if(skinTy == '' || skinTy == undefined ){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.skin" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument></spring:message>');
				return;
			}
			
			$.ajax({
	              type : 'POST'
	            , dataType: 'json'
	            , url : '<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/cntnts/cntPagadiEstbs/registSkinEstbsAjax.do'
	            , data:{
	            	'skinTy' : skinTy					
	            }
	            , success:function (data) {
	                var result = data.head.result;
	                
	                if (result == 'success') {
	                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
	                }else{
	                	alert('<spring:message code="fail.common.msg" text="error" />');
	                } 
	            }
	            , error:function (data) {
	                alert('<spring:message code="fail.common.msg" text="error" />');
	            }
	        });
			
		}
		
	</script>
	<input type="hidden" id="pagadiestbsSeq" name="pagadiestbsSeq" value="<c:out value="${pageadiEstbsVO.pagadiestbsSeq }"/>">
	
	<div class="wz_notice brbox bg-white br-blue-strong fl mt10" style="overflow:visible;">
	        <ul class="wd100 pl0">
	                <li class="admpg-subp wd100" style="list-style:none;">· <spring:message code="wzwg.cmm.msg.MSG420" /></li>
	                <li class="admpg-subp wd100" style="list-style:none;">· <spring:message code="wzwg.cmm.msg.MSG421" /></li>
	        </ul>
	</div>
	
	<h3 class="wzAdmSTit wd100 fl">
		<spring:message code="wzwg.site.cntnts.msg.MSG029"/> 
	</h3>
	<c:if test="${empty oclhgList }">
		<div class="lt-box fl wd100 pl15 box-border mt0 chargerSetBtnWrap">
			<span class="admpg-subp"><spring:message code="wzwg.cmm.cmmMsg.CMG014"><spring:argument><spring:message code="wzwg.site.cntnts.msg.MSG031"/></spring:argument></spring:message></span>
			<button type="button" class="wzbtn btn-grey-bg fr" onclick="chargerSet()"><spring:message code="wzwg.site.cntnts.msg.MSG030"/></button>
		</div>
		<style>.chargerSetTBL {display:none;}</style>
	</c:if>
	
	<div class="chargerSetTBL">
		<div class="lt-box fl wd100 pl15 box-border mt0 txt-r">
			<button type="button" class="wzbtn btn-basic" onclick="fnAddOclhg()"><spring:message code="wzwg.site.cntnts.msg.MSG032"/></button>
		</div>
		<table class="basic-table">
			<thead>
				<tr>
					<th class="bg-white"><spring:message code="wzwg.site.cntnts.msg.MSG033"/></th>
					<th class="bg-white"><spring:message code="wzwg.cmm.word.charger"/></th>
					<th class="bg-white"><spring:message code="wzwg.cmm.word.cttpc"/></th>
					<th class="bg-white w10"><spring:message code="wzwg.cmm.word.ordr"/></th>
					<th class="bg-white w10"><spring:message code="wzwg.cmm.word.rm"/></th>
				</tr>
			</thead>
			<tbody id="oclhg_body">
				<c:forEach items="${oclhgList }" var="list" varStatus="status">
				<tr data-pagoclhgSeq="<c:out value="${list.pagoclhgSeq }"/>">
					<td><input type="text" class="w100 txt-c" name="departNm" value="<c:out value="${list.departNm }"/>"></td>
					<td><input type="text" class="w100 txt-c" name="oclhgNm" value="<c:out value="${list.oclhgNm }"/>"></td>
					<td><input type="text" class="w100 txt-c" name="oclhgCttpl" value="<c:out value="${list.oclhgCttpl }"/>"></td>
					<td>
						<button class="btn-basic iconOnlyBtn btn-sortUp"<c:if test="${not status.first}"> onclick="fnOclhgOrdrChange('up','<c:out value="${list.pagoclhgSeq }"/>', '<c:out value="${list.sortOrdr}"/>')"</c:if> title="<spring:message code="wzwg.cmm.word.up"/>"<c:if test="${status.first}"> disabled</c:if>>▲</button>
						<button class="btn-basic iconOnlyBtn btn-sortDown"<c:if test="${not status.last}"> onclick="fnOclhgOrdrChange('down','<c:out value="${list.pagoclhgSeq }"/>', '<c:out value="${list.sortOrdr}"/>')"</c:if> title="<spring:message code="wzwg.cmm.word.down"/>"<c:if test="${status.last}"> disabled</c:if>>▼</button>
					</td>
					<td>
						<button type="button" class="iconOnlyBtnSameSize btn-save white" onclick="fnRegistOclhg($(this).parent().parent())"><spring:message code="wzwg.cmm.word.stre"/></button>
						<button type="button" class="iconOnlyBtn btn-basic btn-delete" onclick="fnDeleteOclhg($(this).parent().parent())"><spring:message code="wzwg.cmm.word.delete"/></button>
					</td>
				</tr>
				</c:forEach>
				<c:if test="${empty oclhgList }"><script>fnAddOclhg()</script></c:if>
			</tbody>
		</table>
	</div>
	
	<table style="display:none">
		<tbody id="oclhg_sample">
			<tr>
				<td><input type="text" class="w100 txt-c" name="departNm" placeholder="<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.deparname" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>"></td>
				<td><input type="text" class="w100 txt-c" name="oclhgNm" placeholder="<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.charger" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>"></td>
				<td><input type="text" class="w100 txt-c" name="oclhgCttpl" placeholder="<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.cttpc" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>"></td>
				<td>
					<button class="btn-basic iconOnlyBtn btn-sortUp" disabled style="color:#ccc;" title="<spring:message code="wzwg.cmm.word.up"/>">▲</button>
					<button class="btn-basic iconOnlyBtn btn-sortDown" disabled style="color:#ccc;" title="<spring:message code="wzwg.cmm.word.down"/>">▼</button>
				</td>
				<td>
					<button type="button" class="iconOnlyBtnSameSize btn-save white" onclick="fnRegistOclhg($(this).parent().parent())"><spring:message code="wzwg.cmm.word.stre"/></button>
				</td>
			</tr>
		</tbody>
	</table>
	
	<h3 class="wzAdmSTit wd100 fl mt50 mb0">
		<spring:message code="wzwg.site.cntnts.msg.MSG034"/>
		
		<c:if test="${not empty evlEstbsSummary }">
		<span class="fr fs14" style="font-weight: normal;">
			<c:set var="temp_label"><spring:message code="wzwg.cmm.word.ratescor"/></c:set>
			<c:set var="temp_avg"><fmt:formatNumber value="${evlEstbsSummary.evlAverage}" pattern="#.##" /></c:set>
			<c:set var="temp_count"><fmt:formatNumber value="${evlEstbsSummary.evlCount}" pattern="#,###" /></c:set>
			<c:set var="temp_unit"><spring:message code="wzwg.cmm.word.count04"/></c:set>

			<c:out value="${temp_label}" /> 
			<c:out value="${temp_avg}" /> / <c:out value="${temp_count}" />
			<c:out value="${temp_unit}" />
			<button type="button" class="wzbtn-table btn-basic ml10" onclick="fnEvlScoreDetailView()"><spring:message code="wzwg.site.cntnts.msg.MSG035" /></button>
		</span>
		</c:if>
	</h3>
	<c:if test="${empty evlEstbsVO }">
		<div class="lt-box fl wd100 pl15 box-border mt20 mb0 pb30" style="border-bottom:1px solid #e5e5e5;">
			<span class="admpg-subp"><spring:message code="wzwg.cmm.cmmMsg.CMG014"><spring:argument><spring:message code="wzwg.site.cntnts.msg.MSG030"/></spring:argument></spring:message></span>
		</div>
	</c:if>
	
	<p class="admpg-subp w100 fl mt10">
	    <span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.tip.MSG162" /><span class="wz_tableguide mt5 pl20"><spring:message code="wzwg.cmm.msg.tip.MSG163" /></span>			
	</p>

	<table class="basic">
		<colgroup>
            <col width="15%">
            <col width="*">
        </colgroup>
		<tbody>
			<tr>
				<th class="bg-white"><spring:message code="wzwg.cmm.word.recvEvl"/></th>
				<td>
					<ul class="wzForm">
						<li><input type="radio" name="evlScoreAt" value="Y" id="evlScoreAtY" <c:if test="${evlEstbsVO.useAt eq 'Y' }"> checked="true"</c:if> onchange="fnChangeUseAtNO(this)"> <label for="evlScoreAtY"><spring:message code="wzwg.cmm.word.exy"/></label>
						<li><input type="radio" name="evlScoreAt" value="N" id="evlScoreAtN" <c:if test="${evlEstbsVO.useAt eq 'N' }"> checked="true"</c:if> onchange="fnChangeUseAtNO(this)"> <label for="evlScoreAtN"><spring:message code="wzwg.cmm.word.exn"/></label>
					</ul>
				</td>
			</tr>
			<tr>
				<th class="bg-white"><spring:message code="wzwg.cmm.word.recvOpin"/></th>
				<td>
					<ul class="wzForm">
						<li><input type="radio" name="evlOpinionAt" value="Y" id="evlOpinionAtY" <c:if test="${evlEstbsVO.opinionUseAt eq 'Y' }"> checked="true"</c:if>> <label for="evlOpinionAtY"><spring:message code="wzwg.cmm.word.exy"/></label></li>
						<li><input type="radio" name="evlOpinionAt" value="N" id="evlOpinionAtN"<c:if test="${evlEstbsVO.opinionUseAt eq 'N' }"> checked="true"</c:if>> <label for="evlOpinionAtN"><spring:message code="wzwg.cmm.word.exn"/></label></li>
					</ul>
				</td>
			</tr>
		</tbody>
	</table>
	<div class="rt-box"><button type="button" class="wzbtn btn-save" onclick="fnEvlEstbs()"><spring:message code="wzwg.cmm.word.stre"/></button></div>
	
	<h3 class="wzAdmSTit wd100 fl mt50 mb0">
		<spring:message code="wzwg.site.cntnts.msg.MSG036"/>
	</h3>
	<c:if test="${empty cpyrhtVO }">
		<div class="lt-box fl wd100 pl15 box-border mt20 mb0 pb30" style="border-bottom:1px solid #e5e5e5;">
				<span class="admpg-subp"><spring:message code="wzwg.cmm.cmmMsg.CMG014"><spring:argument><spring:message code="wzwg.site.cntnts.msg.MSG030"/></spring:argument></spring:message></span>
		</div>
	</c:if>
	
	<input type="hidden" name="cpyrhtSe" id="cpyrhtSe" />
	<table class="basic board_copyright">
		<colgroup>
            <col width="15%">
            <col width="*">
        </colgroup>
		<tr>
            <th><spring:message code="wzwg.site.cntnts.msg.MSG037"/><br>(<spring:message code="wzwg.cmm.word.kogl"/>)</th>
            <td>
                <ul class="kogl wzForm">
	                 <li class="bbs-tySel">
	                 	<input type="radio" name="cpyrhtSe" id="cpyrhtSe1" value="1" dir="required" onclick="fnCpyrhtChange('1')" <c:if test="${cpyrhtVO.cpyrhtSe eq '1' }">checked="true"</c:if>>
	                 	<label for="cpyrhtSe1">
	                 		<img src="/images/wzwg/module/cntpagead/cpyrht/img_opentype01.jpg" class="ml0 block pb10 hgt50" onclick="$('#listScrinCodeD').click();">
	                 		<spring:message code="wzwg.cmm.word.firstTy"/>
	                 	</label>
	                 </li>
	                 <li class="bbs-tySel">
	                 	<input type="radio" name="cpyrhtSe" id="cpyrhtSe2" value="2" dir="required" onclick="fnCpyrhtChange('2')" <c:if test="${cpyrhtVO.cpyrhtSe eq '2' }">checked="true"</c:if>>
	                 	<label for="cpyrhtSe2">
	                 		<img src="/images/wzwg/module/cntpagead/cpyrht/img_opentype02.jpg" class="ml0 block pb10 hgt50" onclick="$('#listScrinCodeC').click();">
	                 		<spring:message code="wzwg.cmm.word.secondTy"/>
	                 	</label>
	                 </li>
	                 <li class="bbs-tySel">
	                 	<input type="radio" name="cpyrhtSe" id="cpyrhtSe3" value="3" dir="required" onclick="fnCpyrhtChange('3')" <c:if test="${cpyrhtVO.cpyrhtSe eq '3' }">checked="true"</c:if>>
	                 	<label for="cpyrhtSe3">
	                 		<img src="/images/wzwg/module/cntpagead/cpyrht/img_opentype03.jpg" class="ml0 block pb10 hgt50" onclick="$('#listScrinCodeE').click();">
	                 		<spring:message code="wzwg.cmm.word.thirdTy"/>
	                 	</label>
	                 </li>
	                 <li class="bbs-tySel">
	                 	<input type="radio" name="cpyrhtSe" id="cpyrhtSe4" value="4" dir="required" onclick="fnCpyrhtChange('4')" <c:if test="${cpyrhtVO.cpyrhtSe eq '4' }">checked="true"</c:if>>
	                 	<label for="cpyrhtSe4">
	                 		<img src="/images/wzwg/module/cntpagead/cpyrht/img_opentype04.jpg" class="ml0 block pb10 hgt50" onclick="$('#listScrinCodeB').click();">
	                 		<spring:message code="wzwg.cmm.word.fourthTy"/>
	                 	</label>
	                 </li>
                 </ul>
                 
                 <div class="pt10">
                 	<ul class="ml20"  id="cpyrht-guide" style="padding-left:0 !important;" >
						<li style="float:none; list-style:none;"><div class="black fs16" style="margin-left:-20px;"><span class="circle_no bg-green-strong">!</span><spring:message code="wzwg.cmm.cntnts.cpyrht.MSG006"/></div></li>
					</ul>
                 </div>
            </td>
        </tr>
        <tr>
            <th><spring:message code="wzwg.site.cntnts.msg.MSG037" /></th> 
            <td colspan="3">
            	<ul class="wzForm">
            		<li><input type="radio" name="cpyrhtUseAt" value="Y" id="cpyrhtUseAtY" dir="required"<c:if test="${cpyrhtVO.useAt eq 'Y' }"> checked="true"</c:if>/><label for="cpyrhtUseAtY"><spring:message code="wzwg.cmm.word.use" /></label></li>
            		<li><input type="radio" name="cpyrhtUseAt" value="N" id="cpyrhtUseAtN" dir="required"<c:if test="${cpyrhtVO.useAt eq 'N' }"> checked="true"</c:if>><label for="cpyrhtUseAtN"><spring:message code="wzwg.cmm.word.unuse" /></label></li>
            	</ul>
            </td>
        </tr>
	</table>
	<div class="rt-box"> 
		<button type="button" class="wzbtn btn-save" onclick="fnRegistCpyrht()"><spring:message code="wzwg.cmm.word.stre" text="stre" /></button>
	</div>
	
	<c:if test="${not empty cpyrhtVO }"><script>fnCpyrhtChange(parseInt('<c:out value="${cpyrhtVO.cpyrhtSe}"/>'), '<c:out value="${cpyrhtVO.useAt}"/>')</script></c:if>
	
	<h3 class="wzAdmSTit wd100 fl mt50 mb0">
		<spring:message code="wzwg.site.cntnts.msg.MSG038"/>
	</h3>
	<div class="lt-box fl wd100 pl15 box-border mb0">
		<div class="admpg-subp txt-l wd100 ">
			<span class="circle_no bg-red-strong">!</span><spring:message code="wzwg.cmm.msg.MSG400" />
		</div>
	</div>
	
	<table class="basic-table tr_bgnone">
		<tbody>
			<tr>
				<td style="background:#fff !important; border-top:none;">
					<ul class="wzForm wd100 fl">
						<li class="wd25 fl wm50 mb15">
							<input type="radio" id="skin01" name="skinTy" value="skin01"<c:if test="${empty skinEstbsVO.skinTy or skinEstbsVO.skinTy eq 'skin01'}"> checked="true"</c:if>> 
							<label for="skin01" class="txt-l"><!--<spring:message code="wzwg.cmm.word.ty"/>01<br>--><img src='/images/wzwg/site/mngr/cntnts/cntPagadiEstbs/skin01.jpg' id="skinImg01" class="w90 mt0" />
							<button type="button" class="iconOnlyBtnSameSize btn-basic mt15" onclick="fnImgPrevewPop('#skinImg01')"><spring:message code="wzwg.cmm.word.detail03"/> <spring:message code="wzwg.cmm.word.view"/></button></label>
						</li>
						<li class="wd25 fl wm50 mb15">
							<input type="radio" id="skin02" name="skinTy" value="skin02"<c:if test="${skinEstbsVO.skinTy eq 'skin02' }"> checked="true"</c:if>>
							<label for="skin02" class="txt-l"><!--<spring:message code="wzwg.cmm.word.ty"/>02<br>--><img src='/images/wzwg/site/mngr/cntnts/cntPagadiEstbs/skin02.jpg' id="skinImg02" class="w90 mt0" />
							<button type="button" class="iconOnlyBtnSameSize btn-basic mt15" onclick="fnImgPrevewPop('#skinImg02')"><spring:message code="wzwg.cmm.word.detail03"/> <spring:message code="wzwg.cmm.word.view"/></button></label>
						</li>
						<li class="wd25 fl wm50">
							<input type="radio" id="skin03" name="skinTy" value="skin03"<c:if test="${skinEstbsVO.skinTy eq 'skin03' }"> checked="true"</c:if>>
							<label for="skin03" class="txt-l"><!--<spring:message code="wzwg.cmm.word.ty"/>03<br>--><img src='/images/wzwg/site/mngr/cntnts/cntPagadiEstbs/skin03.jpg' id="skinImg03" class="w90 mt0" />
							<button type="button" class="iconOnlyBtnSameSize btn-basic mt15" onclick="fnImgPrevewPop('#skinImg03')"><spring:message code="wzwg.cmm.word.detail03"/> <spring:message code="wzwg.cmm.word.view"/></button></label>
						</li>
						<li class="wd25 fl wm50">
							<input type="radio" id="skin04" name="skinTy" value="skin04"<c:if test="${skinEstbsVO.skinTy eq 'skin04' }"> checked="true"</c:if>>
							<label for="skin04" class="txt-l"><!--<spring:message code="wzwg.cmm.word.ty"/>04<br>--><img src='/images/wzwg/site/mngr/cntnts/cntPagadiEstbs/skin04.jpg' id="skinImg04" class="w90 mt0" />
							<button type="button" class="iconOnlyBtnSameSize btn-basic mt15" onclick="fnImgPrevewPop('#skinImg04')"><spring:message code="wzwg.cmm.word.detail03"/> <spring:message code="wzwg.cmm.word.view"/></button></label>
						</li>
					</ul>
				</td>
			</tr>
		</tbody>
	</table>
	
	<div class="lt-box fl wd100 mt0">
		<button type="button" class="wzbtn btn-save fr" onclick="fnRegistSkinEstbs()"><spring:message code="wzwg.cmm.word.stre"/></button>
	</div>
