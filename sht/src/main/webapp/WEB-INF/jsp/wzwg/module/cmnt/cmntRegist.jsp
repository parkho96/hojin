<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<link rel="stylesheet" href="/css/wzwg/module/cmnt/community.css"> 
<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js"></script>
<script type="text/javascript" src="/js/wzwg/cmm/common_validator.js"></script>
<script type="text/javascript">
	 var isExgist =false;
	
		 
		 function fn_regist(){
			 oEditors.getById["cmntMeaning"].exec("UPDATE_CONTENTS_FIELD", []);
				if(!Validator.validate(document.frmInfo)){
					return;
				}
				if(!isExgist){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG012"><spring:argument><spring:message code="wzwg.cmm.word.cmmntynm" /></spring:argument></spring:message>');
					return;
				}
			$.ajax({
		        type:'POST'
		      , url:'<c:out value="${wzwg_contextPath}"/>/usr/cmnt/info/registCmntInfoAjax.do'
		      , cache : false
		      , async : false 
		      , data:$("#frmInfo").serialize()
		      , success:function (data) {
		    	 if(data.cmntAppvlCode == 'SC00000334') {
		    	 	fn_result();
		    	 }else if(data.cmntAppvlCode == 'SC00000335') {
		    		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.word.cmmnty" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.estbl" /></spring:argument></spring:message>.');
		    		fn_list();
		    	 }
		      }
		      , error:function (data) {
		          alert('<spring:message code="fail.common.msg" text="error" />');
		      }
		      , dataType: 'json'
		 	});
		}
	 
	function fn_list(){
		 
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}"/>/module/cmnt/selectCmntListAjax.do'
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
	
function fn_result(){
		 
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}"/>/module/cmnt/registCmntResultAjax.do'
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
	
	function fnExgistCmntNmAjax(){	  
		 if($("#cmntNm").val()==''){
			 alert('<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument><spring:message code="wzwg.cmm.word.cmmntynm" /></spring:argument></spring:message>');
			 return;
		 }
			$.ajax({
				   type:'POST'
				 , url:'<c:out value="${wzwg_contextPath}"/>/usr/cmnt/info/selectCmntInfoExgistAjax.do'
				 , data:{'cmntNm':$("#cmntNm").val()}
				 , success:function (data) {
					 	if(data.result >0){
					 		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG017"><spring:argument><spring:message code="wzwg.cmm.word.cmmnty" /></spring:argument></spring:message>');
					 		$("#cmntNm").val('');
					 	}else{
					 		alert('<spring:message code="wzwg.cmm.msg.MSG023" text="Community name available" />');
					 		isExgist =true;
					 	}
						 
				 }
				 , dataType: 'json'
			});
		} 
	
</script>
	
		  <form  id="frmInfo" name="frmInfo">
		  <input type="hidden" name="cmntMngrSeq" id="cmntMngrSeq" value="<c:out value='${sessionScope.loginVO.usrSeq }'/>"/>
						<div class="joinUs_box">	
									<table>
										<colgroup>
											<col width="15%">
											<col width="38%">
											<col width="12%">
											<col width="40%">
										</colgroup>
										<tr>
											<th><spring:message code="wzwg.cmm.word.oprtr" text="operator" /></th>
											<td  colspan="3"><c:out value='${sessionScope.loginVO.userNm }'/></td>
										</tr>
										<tr>
											<th><spring:message code="wzwg.cmm.word.cttpc" text="contact place" /></th>
											<td>
												 <input type="text"  name="cmntTelno"  id="cmntTelno"  class="w70" dir="required,vtel" title="<spring:message code="wzwg.cmm.word.cttpc" text="contact place" />"/>
											</td>
											<th><spring:message code="wzwg.cmm.word.email" text="email" /></th>
											<td>
												<input type="text"  name="cmntEmailAdres"  id="cmntEmailAdres"  class="w70" dir="required,vemail" title="<spring:message code="wzwg.cmm.word.email" text="email" />"/>
											</td>
										</tr>
										<tr>
											<th><spring:message code="wzwg.cmm.word.cmmntynm" text="cummnity name" /> </th>
											<td colspan="3"><input type="text"  name="cmntNm"  id="cmntNm" class="w70"  dir="required" title="<spring:message code="wzwg.cmm.word.cmmntynm" text="cummnity name" />" onchange="fnExgistFalse()"/> <a href="javascript:;" onclick="fnExgistCmntNmAjax()"  class="wzbtn-table btn-basic"><span><spring:message code="wzwg.cmm.word.dplct" text="duplication" /> <spring:message code="wzwg.cmm.word.cnfirm" text="confirm" /></span></a></td>
										</tr>
										<tr>
											<th><spring:message code="wzwg.module.word.estblpurps" /></th>
											<td colspan="3">
												<textarea name="cmntMeaning" id="cmntMeaning" rows="30" class="w80" dir="required" title="<spring:message code="wzwg.module.word.estblpurps" />"></textarea>
												<script type="text/javascript">
													var oEditors = [];
													nhn.husky.EZCreator.createInIFrame({
													    oAppRef: oEditors,
													    elPlaceHolder: "cmntMeaning",
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
										<tr>
											<th><spring:message code="wzwg.module.word.othbcat" /></th>
											<td colspan="3">
												<ul class="wzForm">
												<c:forEach items="${cmntOpenCodeList}" var="resultList" varStatus="status">
					                          		<li>
					                          			<label>
						                          			<input type="radio" name="cmntOpenCode" id="cmntOpenCode" value="<c:out value='${resultList.code}'/>" <c:if test="${status.first}">checked="true"</c:if>/> 
						                          			<span class="spanLabel"><c:out value='${resultList.codeNm}'/></span>
					                          			</label>
					                          		</li> 
					                          	</c:forEach>
												</ul>
											</td>
										</tr>
									</table>
									<div class="btnbox-c mt30">
										<a href="javascript:fn_regist();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.estbl" text="establishment" /></a>
										<a href="javascript:fn_list();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.cancl" text="cancel" /></a>
									</div>
								  </div><!-- joinUs_box end -->
 
	</form>
	