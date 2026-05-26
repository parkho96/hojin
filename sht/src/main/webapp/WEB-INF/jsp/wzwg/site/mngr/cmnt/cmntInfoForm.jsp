<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js"></script>
<script type="text/javascript" src="/js/wzwg/cmm/common_validator.js"></script>
<script type="text/javascript">
var isExgist = false;
 function fnRegistCmntInfo(){
		oEditors.getById["cmntMeaning"].exec("UPDATE_CONTENTS_FIELD", []);
		if(!Validator.validate(document.frmInfo)){
			return;
		}
		if(!isExgist){
			alert('<spring:message code="wzwg.cmm.msg.MSG197" />'); 
			return;
		}
	 document.frmInfo.action="<c:out value="${wzwg_contextPath}"/>/mngr/cmnt/info/registCmntInfoMngr.do";
	 document.frmInfo.method="post";
	 document.frmInfo.submit();
 }
 
 function fnList(){
	 document.getElementsByName("cmntOpenCode")[0].checked=false;
	 document.getElementsByName("cmntOpenCode")[1].checked=false;
	 
	 document.frmInfo.action="<c:out value="${wzwg_contextPath}"/>/mngr/cmnt/info/selectCmntInfoList.do";
	 document.frmInfo.submit();
 }
 
 function fnExgistCmntNmAjax(){	  
	 if($("#cmntNm").val()==''){
		 alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
					'<spring:argument><spring:message code="wzwg.cmm.word.cmmntynm" /></spring:argument>'+
					'<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>'+
				  '</spring:message>');
		 return;
	 }
		$.ajax({
			   type:'POST'
			 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/cmnt/info/selectCmntInfoExgistAjax.do'
			 , data:{'cmntNm':$("#cmntNm").val()}
			 , success:function (data) {
				 	if(data.result >0){
				 		alert('<spring:message code="wzwg.cmm.msg.MSG198" />');
				 	}else{
				 		alert('<spring:message code="wzwg.cmm.msg.MSG199" />');
				 		isExgist =true;
				 	}
					 
			 }
			 , dataType: 'json'
		});
	} 
  
 function fnExgistFalse(){
	 isExgist = false;
 }
 
 function fnSearchMngrAjax() {
		$.ajax({
			   type:'POST'
			 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/cmnt/info/searchCmntMngrAjax.do' 
			 , success:function (data) {
				 	//$("#divLayerPopup").html(data);
		    	  	//$("#divLayerPopup").show();
						 // 부모코드 셋팅 
						// fnGetMenuList();
					//	 document.getElementById("menuNm").focus();
					var title = '<spring:message code="wzwg.site.cmnt.msg.MSG008" />';
				 	wzAjaxModal('popup_s', title, data);
					   }
			 , dataType: 'html'
		});
	}
 
 function fnLayerPopupClose() {
     //$("#divLayerPopup").hide();
     //$("#divLayerPopup").empty();
     //$('body').css({overflow:'auto'});
     wzModalClose();
 }
</script>
 
                <form  id="frmInfo" name="frmInfo" method="post">
                    
                    <table class="basic" summary="<spring:message code="wzwg.site.cmm.msg.MSG005"/>">
                    <colgroup>
                        <col width="15%"/>
                        <col width="*"/>
                    </colgroup>
                    <tbody>
                        <tr>
                            <th><spring:message code="wzwg.cmm.word.cmmntynm" />
	                            <span class="necessary">
										<span></span>
										<div><spring:message code="wzwg.cmm.word.essntl" /></div>
								</span>
                            </th>
                            <td>
                            	<c:set var="msg_txt01">
									<spring:message code="wzwg.cmm.cmmMsg.CMG011">
										<spring:argument><spring:message code="wzwg.cmm.word.cmmntynm" /></spring:argument>
										<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
									</spring:message>
								</c:set>
								
                          	 <input type="text"  name="cmntNm"  id="cmntNm" class="w70"  dir="required" title="<spring:message code="wzwg.cmm.word.cmmntynm" />" onchange="fnExgistFalse()"> <a href="javascript:;" onclick="fnExgistCmntNmAjax()"  class="wzbtn-table btn-basic"><spring:message code="wzwg.site.cmnt.msg.MSG009" /></a>
							 <span class="wz_tableguide mt10"><spring:message code="wzwg.cmm.msg.tip.MSG085" /></span>
                            </td>
                        </tr>
                        <tr>
                            <th><spring:message code="wzwg.cmm.word.oprtr" />
                            	<span class="necessary">
										<span></span>
										<div><spring:message code="wzwg.cmm.word.essntl" /></div>
								</span>
                            </th>
                            <td>								
                             <input type="hidden" name="cmntMngrSeq" id="cmntMngrSeq" />
                             <input type="text"  name="cmntMngrNm"  id="cmntMngrNm"  class="w70"  dir="required" title="<spring:message code="wzwg.cmm.word.oprtr" />" readonly="readonly" placeholder="<spring:message code="wzwg.cmm.msg.MSG196" />"/><a href="javascript:;" onclick="fnSearchMngrAjax()"  class="wzbtn-table btn-basic"><spring:message code="wzwg.cmm.word.inqire" /></a>
							 <span class="wz_tableguide mt10"><spring:message code="wzwg.cmm.msg.tip.MSG086" /></span>
                            </td>
                        </tr>
                        
                        <tr>
                            <th><spring:message code="wzwg.cmm.word.cttpc" />
                            	<span class="necessary">
										<span></span>
										<div><spring:message code="wzwg.cmm.word.essntl" /></div>
								</span>
                            </th>
                            <td>
                            	<c:set var="msg_txt02">
									<spring:message code="wzwg.cmm.cmmMsg.CMG011">
										<spring:argument><spring:message code="wzwg.cmm.word.cttpc" /></spring:argument>
										<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
									</spring:message>
								</c:set>
								
                              <input type="text"  name="cmntTelno"  id="cmntTelno"  class="w50 wm100" dir="required,vtel" placeholder="000-0000-0000" title="<spring:message code="wzwg.cmm.word.cttpc"/>"/>
                            </td>
                             
                        </tr>
                        <tr>
                        <th><spring:message code="wzwg.cmm.word.email" />
                        	<span class="necessary">
								<span></span>
								<div><spring:message code="wzwg.cmm.word.essntl" /></div>
							</span>
                        </th>
                            <td>
                            	<c:set var="msg_txt03">
									<spring:message code="wzwg.cmm.cmmMsg.CMG011">
										<spring:argument><spring:message code="wzwg.cmm.word.email" /></spring:argument>
										<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
									</spring:message>
								</c:set>
								
                              <input type="text"  name="cmntEmailAdres"  id="cmntEmailAdres"  class="w50 wm100" dir="required,vemail" title="<spring:message code="wzwg.cmm.word.email"/>"/>
                            </td>
                        </tr>
                        <tr> 
                            <th><spring:message code="wzwg.site.cmnt.msg.MSG005" /></th>
                            <td>
                                <textarea name="cmntMeaning" id="cmntMeaning" rows="30" class="w80" dir="required" title="<spring:message code="wzwg.cmm.word.cn" />" style="width:100%;"></textarea>
						<script type="text/javascript">
							var oEditors = [];
							nhn.husky.EZCreator.createInIFrame({
							    oAppRef: oEditors,
							    elPlaceHolder: "cmntMeaning",
							    sSkinURI: "<c:out value="${wzwg_contextPath}"/>/smartEditor2.8.2.1/smartEditor2Skin.do",
							    fCreator: "createSEditor2",
							    htParams: {
									fOnBeforeUnload : function(){}
									,aAdditionalFontList : [['NanumSquareR', 'NanumSquareR']]		// 추가 글꼴 목록
									}
							});
						</script>
                            </td>
                             <tr>
                            <th><spring:message code="wzwg.site.cmnt.msg.MSG006" /></th>
                            <td>
                            	<ul class="wzForm">
		                             <c:forEach items="${cmntOpenCodeList}" var="resultList" varStatus="status">
		                          		<li><label><input type="radio" name="cmntOpenCode" id="cmntOpenCode" value="<c:out value="${resultList.code}"/>" <c:if test="${status.first}">checked="true"</c:if>/> <span class="spanLabel"><c:out value="${resultList.codeNm}"/></span></label></li> 
		                          	</c:forEach>
	                          	</ul>
								<span class="wz_tableguide mt10 clboth"><spring:message code="wzwg.cmm.msg.tip.MSG088" /></span>
                            </td>
                        </tr>
                    </tbody>
                    </table>
                    
                </form>
     <div class="rt-box">
		<a href="javascript:void(0);" onclick="fnRegistCmntInfo();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
		<a href="javascript:void(0);" onclick="fnList();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>
	
		<!-- 레이어팝업 영역 Start -->
	<div id="divLayerPopup" class="pop-box"></div>
	<!-- 레이어팝업 영역 End -->