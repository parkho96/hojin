<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<link rel="stylesheet" href="/css/wzwg/module/cmnt/community.css"> 
<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js"></script>
<script type="text/javascript" src="/js/wzwg/cmm/common_validator.js"></script>
<script src="/js/wzwg/cmm/jquery.form.min.js"></script> 

<script type="text/javascript">
try{document.title = cmntNm+'-<spring:message code="wzwg.module.word.cmmntymanage" />-<spring:message code="wzwg.module.word.bassestbs" />';}catch(e){console.log(e.message);}

	$(document).ready(function(){ 
		
		/* $('#file1').on('change',function(){
			//console.log(this.value);
			$('#file_route').val(this.value);
		}); */
		
		wzImgPrevieBind('file1', 'file_preview');
		//$(".pop1").click(function(){
		//	$(".pop-box1").toggle();	
		//});
		//$(".hid").click(function(){
		//	$(".pop-box1").hide();
		//});
        //
		//$(".reon").click(function(){
		//	$(".pop-box2").toggle();
		//	$(".pop-box1").hide();
		//});
		//$(".hid").click(function(){
		//	$(".pop-box2").hide();
		//});
        //
		//$(".rcon").click(function(){
		//	$(".pop-box1").toggle();
		//	$(".pop-box2").hide();
		//});
	});
	 
	function fn_searchMngr(btn){
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}"/>/cmnt/mngr/searchCmntMngrAjax.do' 
	      , cache : false
	      , async : false 
	      , data:{"cmntSeq":<c:out value='${result.cmntSeq}'/>}
	      , success:function (data) {
	    	  //$('.pop-box').html(data);
	    	  var title = '<spring:message code="wzwg.module.word.oprtrchange" />';
	    	  wzAjaxModal('popup_s', title, data, true, btn);
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
	
	
	function fn_search(pageIndex){
		document.cmntFrm.pageIndex.value = pageIndex;
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}"/>/module/cmnt/selectCmntListAjax.do'
	   	  , data:$("#cmntFrm").serialize()
	      , cache : false
	      , async : false 
	      , success:function (data) {
	    	  $('#cntnts_area').html(data);
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	}); 
	}

	function fn_modify(){ 
		oEditors.getById["cmntIntro"].exec("UPDATE_CONTENTS_FIELD", []);
		if(!Validator.validate(document.mngrFrm)){
			return;
		}
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}"/>/cmnt/mngr/cmnt/info/modifyCmntAjax.do' 
	      , cache : false
	      , async : false 
	      , data  : $("#mngrFrm").serialize()
	      , success:function (data) { 
	    	  alert('<spring:message code="wzwg.cmm.msg.MSG080" text="changed" />');
	    	  location.href='<c:out value="${wzwg_contextPath}"/>/module/cmnt/mngr/<c:out value="${result.cmntSeq}"/>';
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'json'
	 	});
	}	
	
	function fnIconPopup(btn){
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}"/>/cmnt/mngr/cmntIconPopAjax.do' 
	      , cache : false
	      , async : false 
	      , data:{"cmntSeq":<c:out value='${result.cmntSeq}'/>, "cmntIconStre":'<c:out value="${result.cmntIconStre}"/>'}
	      , success:function (data) {
	    	  //$('.pop-box').html(data);
	    	  var title = '<spring:message code="wzwg.module.word.iconchange" />';
	    	  wzAjaxModal('popup_s', title, data, true, btn);
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
		
	}

</script>
	
		 <h5 class="fs24 pt20 pb20 fn wd100 clboth"><spring:message code="wzwg.module.word.bassestbs" /></h5>
		 <div class="joinUs_box mt5">	
		 <form name="mngrFrm" id="mngrFrm">
		 <input type="hidden" name="cmntSeq" id="cmntSeq" value="<c:out value='${result.cmntSeq}'/>"/>
			<table>
				<caption><spring:message code="wzwg.cmm.cmmMsg.CMG024"><spring:argument><c:out value='${result.cmntNm}'/> <spring:message code="wzwg.cmm.word.wa.of" /> <spring:message code="wzwg.cmm.word.confm" /> <spring:message code="wzwg.cmm.word.de01" />, <spring:message code="wzwg.cmm.word.oprtr" />, <spring:message code="wzwg.cmm.word.icon" />, <spring:message code="wzwg.cmm.word.sbscrb" /> <spring:message code="wzwg.cmm.word.author" />, <spring:message code="wzwg.cmm.word.sbscrb" /> <spring:message code="wzwg.cmm.word.mthd" />, <spring:message code="wzwg.cmm.word.cmmnty" /> <spring:message code="wzwg.cmm.word.intrcn" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.wa.table" /></spring:argument></spring:message></caption>
				<!-- <colgroup>
					<col width="10%">
					<col width="38%">
					<col width="12%">
					<col width="40%">
				</colgroup> -->
				<tr>
					<th scope="row"><spring:message code="wzwg.cmm.word.cmmntynm" text="cmmnty name" /></th>
					<td colspan="3"><b><c:out value='${result.cmntNm}'/></b>
					<span class="grey ml10">(<spring:message code="recomendSiteManageVO.confmDe" text="confirm date" /> : <c:out value='${result.cmntApprovalPnttm}'/>)</span></td>
				</tr>
				<!-- <tr>
					<th scope="row"><spring:message code="recomendSiteManageVO.confmDe" text="confirm date" /></th>
					<td colspan="3"><c:out value='${result.cmntApprovalPnttm}'/></td>
				</tr> -->
				<tr>
					<th scope="row"><spring:message code="wzwg.cmm.word.oprtr" text="operator" /></th>
					<td colspan="3"><span id="mngrSpan"><c:out value='${result.cmntMngrNm}'/>(<c:out value='${result.cmntMngrId}'/>)</span> <a href="javascript:void(0);" onclick="fn_searchMngr(this)" class="wzbtn-table btn-basic ml5"><spring:message code="wzwg.module.word.oprtrchange" /></a></td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.cmm.word.cttpc" text="contact place" /></th>
					<td>
						 <input type="text"  name="cmntTelno"  id="cmntTelno"  class="w70" dir="required,vtel" title="<spring:message code="wzwg.cmm.word.cttpc" text="contact place" />" value="<c:out value='${result.cmntTelno}'/>"/>
					</td>
					<th><spring:message code="wzwg.cmm.word.email" text="email" /></th>
					<td>
						<input type="text"  name="cmntEmailAdres"  id="cmntEmailAdres"  class="w70" dir="required,vemail" title="<spring:message code="wzwg.cmm.word.email" text="email" />" value="<c:out value='${result.cmntEmailAdres}'/>"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><spring:message code="wzwg.cmm.word.icon" text="icon" /></th>
					<td colspan="3">
						<img src="<c:out value='${result.cmntIconStre}'/>" alt="" id="iconImg"/><a href="javascript:void(0);" onclick="fnIconPopup(this)" class="wzbtn-table btn-basic ml5"><spring:message code="wzwg.module.word.iconchange" /></a>
					</td>
				</tr>
				<tr>
					<th scope="row"><spring:message code="wzwg.cmm.word.cmmntySimpIntro" text="Community SimpleIntroduction" /></th>
					<td colspan="3">
						<input type="text"  name="cmntSimpIntro"  id="cmntSimpIntro"  class="w100" dir="vmaxlen=250" maxlength="250" title="<spring:message code="wzwg.module.word.cmmntysimpleintrcn"/>" value="<c:out value='${result.cmntSimpIntro}'/>"/>
						<span class="wz_tableguide mt10"><spring:message code="wzwg.cmm.msg.tip.MSG087" /></span>
					</td>
				</tr>
				<tr>
					<th scope="row"><spring:message code="wzwg.module.word.sbscrbauthor" /></th>
					<td colspan="3">
						<ul class="wzForm">
							<c:forEach items="${usrgroupList}" var="resultList" varStatus="status">
	                        	<li>
	                        		<label>
		                        		<input title="<c:out value='${resultList.usrGroupNm}'/> <spring:message code="wzwg.cmm.word.choise" />" type="checkbox" name="usrgroupSeqArry" id="usrgroupSeqArry" value="<c:out value='${resultList.usrGroupSeq}'/>"<c:forEach items="${groupList}" var="groupList" varStatus="groupStat"><c:if test="${resultList.usrGroupSeq eq groupList.usrgroupSeq }">checked="true"</c:if></c:forEach> />
		                   				<span class="spanLabel"><c:out value='${resultList.usrGroupNm}'/></span>
	                   				</label>
	                   			</li> 
	                         </c:forEach> 
						</ul>
					</td>
				</tr>
				<tr>
					<th scope="row"><spring:message code="wzwg.module.word.sbscrbmthd" /></th>
					<td colspan="3">
						<ul class="wzForm">
							<c:forEach items="${appvlCodeList}" var="resultList" varStatus="status">
	                        	<li>
	                        		<label>
		                        		<input title="<c:out value='${resultList.codeNm}'/> <spring:message code="wzwg.cmm.word.choise" />" type="radio" name="cmntAppvlCode" id="cmntAppvlCode" value="<c:out value='${resultList.code}'/>" <c:if test="${resultList.code eq result.cmntAppvlCode}">checked="true"</c:if>/>
		                        		<span class="spanLabel"><c:out value='${resultList.codeNm}'/></span>
	                        		</label>
	                        	</li> 
	                        </c:forEach>
						</ul>
					</td>
				</tr>
				
				<tr class="cmntinfo_contents">
					<th scope="row" colspan="4"><spring:message code="cop.cmmntyIntrcn" text="Community Introduction" /></th>
				</tr>
				<tr>
					<td colspan="4">
						<span class="wz_tableguide mb10"><spring:message code="wzwg.cmm.msg.tip.MSG0871" /></span>
						<textarea name="cmntIntro" id="cmntIntro" rows="30" style="width:100%;" dir="required" title="<spring:message code="wzwg.module.word.cninpcmpt" />"><c:out value='${result.cmntIntro}' escapeXml="false"/></textarea>
						<script type="text/javascript">
							var oEditors = [];
							nhn.husky.EZCreator.createInIFrame({
							    oAppRef: oEditors,
							    elPlaceHolder: "cmntIntro",
							    sSkinURI: "<c:out value='${wzwg_contextPath}'/>/smartEditor2.8.2.1/smartEditor2Skin.do",
							    fCreator: "createSEditor2"
							    ,htParams: {
									fOnBeforeUnload : function(){}
									,aAdditionalFontList : [['NanumSquareR', 'NanumSquareR']]		// 추가 글꼴 목록
								}
							});
						</script>
					</td>
				</tr>
			</table>
			</form>
		  </div><!-- joinUs_box end -->
		  
		  
			<div class="btnbox-c mb50">
				<a href="javascript:fn_modify();" class="wzbtn btn-save"><spring:message code="button.save" text="save" /></a>
			</div>
			
</div>
<%-- 
<div class="pop-box1" style="display:none;">
			<div class="layer1" >	
			<form name="iconFrm" id="iconFrm">		
			<input type="hidden" name="cmntSeq" id="cmntSeq" value="<c:out value='${result.cmntSeq}'/>"/>	
			<input type="hidden" name="cmntIconStre" id="cmntIconStre" value=""/>
				<div class="pop-id-sch">
					<span><spring:message code="wzwg.cmm.word.icon" text="icon" /> <spring:message code="wzwg.cmm.word.change" text="change" /></span>
					<button class="close hid" type="button"><img src="/images/wzwg/module/cmnt/pop-close.png" alt="<spring:message code="wzwg.cmm.word.close" />" /></button>
				</div>
				<div class="pop-container">
							<div class="pop-conts">
								<!--content //-->
									<div class="main-menu-bar">
										<ul class="pop-tab">
											<li><a href="#" class="pop-on"><spring:message code="wzwg.cmm.word.icon" text="icon" /> <spring:message code="wzwg.cmm.word.choise" text="choise" /></a></li>
											<li><a href="#" class="reon"><spring:message code="wzwg.cmm.word.direct" text="direct" /> <spring:message code="wzwg.cmm.word.atch" text="attach" /></a></li>
										</ul>
									</div>
									<div class="pop-main-con">
										<ul>
											<li style="width:50px;height:50px"><a href="#"><img src="/images/wzwg/module/cmnt/cake.png" alt="" onclick="fn_setCmntIconAjax(this.src)" /></a></li>
											<li><a href="#"><img src="/images/wzwg/module/cmnt/wine.png" alt=""  onclick="fn_setCmntIconAjax(this.src)"/></a></li>
											<li><a href="#"><img src="/images/wzwg/module/cmnt/email.png" alt="" onclick="fn_setCmntIconAjax(this.src)"/></a></li>
											<li><a href="#"><img src="/images/wzwg/module/cmnt/heart.png" alt="" onclick="fn_setCmntIconAjax(this.src)"/></a></li>
											<li><a href="#"><img src="/images/wzwg/module/cmnt/ring.png" alt="" onclick="fn_setCmntIconAjax(this.src)"/></a></li>
										</ul>
									</div>
									<div class="ctr-box">
										<a href="javascript:void(0);" class="hid wzbtn btn-basic"><spring:message code="wzwg.cmm.word.close" text="close" /></a>
									</div><!--close btn //-->
							</div> <!-- pop-conts end -->
				</div> <!-- pop-container end -->
				</form>
			</div> <!-- layer1 end -->
		</div> <!-- 레이어팝업 end -->
 --%>
	<%-- 	<div class="pop-box2" style="display:none;">
			<div class="layer1" >				
				<div class="pop-id-sch">
					<span><spring:message code="wzwg.cmm.word.icon" text="icon" /> <spring:message code="wzwg.cmm.word.change" text="change" /></span>
					<a href="#"  class="hid close" type="button"><img src="/images/wzwg/module/cmnt/pop-close.png" alt="<spring:message code="wzwg.cmm.word.close" />" /></a>
				</div>
				<div class="pop-container">
							<div class="pop-conts">
								<!--content //-->
									<div class="main-menu-bar">
										<ul class="pop-tab">
											<li><a href="#" class="pop-on"><spring:message code="wzwg.cmm.word.icon" text="icon" /> <spring:message code="wzwg.cmm.word.choise" text="choise" /></a></li>
											<li><a href="#" class="reon"><spring:message code="wzwg.cmm.word.direct" text="direct" /> <spring:message code="wzwg.cmm.word.atch" text="attach" /></a></li>
										</ul>
									</div>
									<form name="uploadFrm" id="uploadFrm" method="post" enctype="multipart/form-data">
									<input type="hidden" name="cmntSeq" id="cmntSeq" value="<c:out value='${result.cmntSeq}'/>"/>
									<div class="pop-main-reon">
										<input type="file" name="file1" id="file1" /><a href="javascript:fnIconUpload();" class="wzbtn-table btn-basic"><spring:message code="button.save" text="save" /></a>
									</div>
									</form>
									<div class="ctr-box">
										<a href="javascript:void(0);" class="hid wzbtn btn-basic"><spring:message code="wzwg.cmm.word.close" text="close" /></a>
									</div><!--close btn //-->
							</div> <!-- pop-conts end -->
				</div> <!-- pop-container end -->
			</div> <!-- layer1 end -->
		</div> <!-- 레이어팝업 end -->
 --%>
