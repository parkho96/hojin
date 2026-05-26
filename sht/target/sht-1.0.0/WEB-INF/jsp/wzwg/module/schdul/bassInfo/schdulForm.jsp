<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
	$(document).ready(function(){
		fnCssInfo();
		
		//컬러리스트
		var colorList = getBgColorList();
		var listadd  = "";
		
		$(colorList).each( function(idx) {
			
			listadd = listadd + '<label>';
			listadd = listadd + '<input type="radio" id="colorCode'+idx+'" name="ctgryColorCode" value="'+colorList[idx].className+'" title="'+colorList[idx].title+' <spring:message code="wzwg.module.word.colchoise" />"  />';
			listadd = listadd + '<div class="'+colorList[idx].className+'" ></div';
			listadd = listadd + '</label>';
			
			$('#colorList').append(listadd);
            
			listadd = "";
        });
		
		$('#colorCode0').attr('checked', true);
		
		$('#selConnModuleSe').change(function(){
			
			if($(this).val() == ''){
				$("#selSitecntntSeq").find("option").remove().end().append("option value=\"\"><spring:message code="wzwg.cmm.word.choise" /></option>");
				$("#selSitecntntSeq").append("<option value=\"\"><spring:message code="wzwg.cmm.word.choise" /></option>");
			}else{
			
				$('#sysmoduleSeq').val($(this).val());
			
				$.ajax({
					  type : 'POST'
					, dataType: 'xml'
					, contentType : 'application/x-www-form-urlencoded; charset=UTF-8'
					, url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/schdul/bassInfo/selectModuleListAjax.do'
					, cache : false
					, async : false
					, data : $("#regForm").serialize()
					, success : function(xml, status, request) {
						
						$("#selSitecntntSeq").find("option").remove().end().append("option value=\"\"><spring:message code="wzwg.cmm.word.choise" /></option>");
						$("#selSitecntntSeq").append("<option value=\"\"><spring:message code="wzwg.cmm.word.choise" /></option>");
						$(xml).find("item").each(function(){
							var sitecntntsSeq 	= $(this).find('name').text();
							var cntntsNm 		= $(this).find('value').text();
							var cntntsNmArr 	= cntntsNm.split(":");
							$("#selSitecntntSeq").append("<option value=\"" +sitecntntsSeq+ "\">[ " + cntntsNmArr[0] + " ] " + cntntsNmArr[1] + "</option>");
						});
						
					}
					, error:function (data) {
						alert('<spring:message code="fail.common.msg" text="error" />');
					}
			 	});
			}
			
		});
		
		$('#connModule_add_btn').click(function(){
			
			var frm = document.regForm;
			
	        if($('#selSitecntntSeq').val() == ''){
	            alert('<spring:message code="wzwg.cmm.msg.MSG172" />');
	            $('#selSitecntntSeq').focus();
	            return;
	        }
	         
	        var strSitecntntsSeq = $('#selSitecntntSeq').val().split(":");
	        
	        $('#conncntntsSeq').val(strSitecntntsSeq[0]);
	        $('#regForm #cntntsSeq').val(strSitecntntsSeq[1]);
	        
	        var selTarget = document.getElementById('selSitecntntSeq');
	        frm.ctgryNm.value = selTarget.options[selTarget.selectedIndex].text; 
	        
	        $.ajax({
	            type : 'POST'
	            , url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/schdul/bassInfo/registSchdulConnModuleListAjax.do'
	            , dataType : 'xml'
	            , data : $("#regForm").serialize()
	            , success : function (result) {
	              
	                var value = "";
	                
	                $(result).find("value").each(function() {  
	                    value = $(this).text();  
	                });
	                
	                if(value == 'success'){
	                    
	                    $.ajax({
	                        type : 'POST'
	                        , url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/schdul/bassInfo/selectConnModuleListAjax.do'
	                        , dataType : 'html'
	                        , data : $("#regForm").serialize()
	                        , success : function (data) {
	                            $('#connModuleDiv').html(data);
	                            $('#selConnModuleSe').change();
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
	        
	    });
	
		
	});
	

    function fnRegist(callGubun) {
        $('#schdulDc').val($('#schdulNm').val());
        if(!confirm('<spring:message code="wzwg.cmm.msg.MSG135" />')){
            return;
        }else{
        	
        	var state = '<c:out value="${state}" />';
        	
        	var url = "";
        	
        	if(state == "modify") {
        		url = "<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/schdul/modifySchdulAjax.do";
        	} else {
        		url = "<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/schdul/registSchdulAjax.do";
        	}
            
            $.ajax({
                type : 'POST'
                , url : url
                , dataType : 'xml'
                , data : $("#regForm").serialize()
                , success : function (result) {
                  
                    var value = "";
                    
                    $(result).find("value").each(function() {  
                        value = $(this).text();  
                    });
                    
                    if(value == 'success'){
                        if (callGubun != 'M') {
                        	document.frmInfo.cntntsNm.value = document.regForm.schdulNm.value;
                            fnCntntsRegist();   
                        } else {
                            alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.menu.bassinfo"/></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
                            location.reload();
                        }
                    }else{
                        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
                    }
                  
                }
                , error : function (request, status, error) {
                    alert('<spring:message code="fail.common.msg" text="error" />');
                }
            });
        
        }
    }
    
    function fnReset_btn() {
 		document.regForm.action='<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/cntnts/cntntsInfo/selectCntntsInfoList.do';
		document.regForm.submit();
	}
    
    function fnLayerPopupClose() {
	    $("#divLayerPopup").hide();
	    $("#divLayerPopup").empty();
	    $('body').css({overflow:'auto'});
	}
    
	/** 적용된 css */
    function fnCssInfo() {

	    $.ajax({
	        type : 'POST'
	        , url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/schdul/selectSchdulCssInfoDetailAjax.do'
                , dataType : 'html'
                , data : $("#regForm").serialize()
                , success : function (data) {
                    $('#schdulCssDiv').html(data);
                }
                , error : function (request, status, error) {
                    alert('<spring:message code="fail.common.msg" text="error" />');
                }

	    });
    }    
	
    /** css 리스트 */
    function fnCntntsStylePopup(){
    	$.ajax({
    		   type:'POST'
    		 , url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/schdul/selectSchdulCssListAjax.do'
    		 , data : $("#regForm").serialize()
    		 , success:function (data) {
    			 	//$("#divLayerPopup").html(data);
    	    	  	//$("#divLayerPopup").show();
    			 	var title = '<spring:message code="wzwg.module.word.skinestbs" />';
 			 		wzAjaxModal('popup_l', title, data);
    			}
    		 , dataType: 'html'
    	});
    }

    
</script>

		<!-- 레이어팝업 영역 Start -->
		<div id="divLayerPopup" class="pop-box"></div>
		<!-- 레이어팝업 영역 End -->
        
        <form:form modelAttribute="resultVO" path="regForm" id="regForm" name="regForm" method="post">
            
            <c:if test="${!empty param.schdulSeq}"><form:hidden path="schdulSeq" /></c:if>
            <c:if test="${empty param.schdulSeq}"><input type="hidden" value="<c:out value="${newSchdulSeq}" />" name="schdulSeq" /></c:if>
            <input type="hidden" name="state" value="<c:out value="${state}" />" />
            <input type="hidden" name="sitecntntsSeq" value="<c:out value="${paramVO.sitecntntsSeq }" />"/>
            <input type="hidden" name="cssSeq" value="<c:out value="${resultVO.cssSeq}" />"/>
            <input type="hidden" name="sysmoduleSeq" id="sysmoduleSeq" />
            <input type="hidden" name="cntntsSeq" id="cntntsSeq" />
            <input type="hidden" name="conncntntsSeq" id="conncntntsSeq" />
            <input type="hidden" naem="ctgryNm" id="ctgryNm" />

            <!--기본정보 table// -->
                <table class="basic">
                <colgroup>
                    <col width="15%"/>
                    <col width="*"/>
                </colgroup>
                <tbody>
                    <tr>
                        <th><spring:message code="wzwg.module.word.cntntsnm" />
                        	<span class="necessary">
									<span></span>
									<div><spring:message code="wzwg.cmm.word.essntl" /></div>
							</span>
                        </th>
                        <td colspan="3">
                        	<c:set var="cntntsnm"><spring:message code="wzwg.module.word.cntntsnm" /></c:set>
                            <form:input path="schdulNm" id="schdulNm" cssClass="w70" dir="required" title="${fn:escapeXml(cntntsnm)}" />
                        </td>
                    </tr>
                    <tr>
                        <th><spring:message code="wzwg.module.word.listscreen" /></th>
                        <td colspan="3">
                        	<ul class="wzForm">
                        		<li><input type="radio" id="initScrinC" name="initScrin" value="C" onclick="$('#skinDiv').css('display', ''); $('#holiday').css('display', '');" dir="required" title="<spring:message code="wzwg.cmm.word.cldr" />" checked="checked" /><label class="mg_r20" for="initScrinC"><spring:message code="wzwg.cmm.word.cldr" /></label></li>
                            	<li><input type="radio" id="initScrinL" name="initScrin" value="L" onclick="$('#skinDiv').css('display', 'none'); $('#holiday').css('display', 'none');" dir="required" title="<spring:message code="wzwg.cmm.word.list" />" <c:if test="${resultVO.initScrin eq 'L'}">checked="true"</c:if> /><label class="mg_r20" for="initScrinL"><spring:message code="wzwg.cmm.word.list" /></label></li>
                        	</ul>
                        </td>
                    </tr>
                    <tr id="holiday" <c:if test="${resultVO.initScrin eq 'L'}">style="display: none;"</c:if>>
                        <th><spring:message code="wzwg.module.word.hldyAtY" /></th>
                        <td colspan="3">
                        	<ul class="wzForm">
                        		<li><input type="radio" name="hldyAt" id="holiDayY" value="Y" <c:if test="${resultVO.hldyAt eq 'Y'}">checked="checked"</c:if>/><label for="holiDayY"><spring:message code="wzwg.module.word.hldyAtY" /></label></li>
                        		<li><input type="radio" name="hldyAt" id="holiDayN" value="N" <c:if test="${empty resultVO.hldyAt or resultVO.hldyAt eq 'N'}">checked="checked"</c:if>><label for="holiDayN"><spring:message code="wzwg.module.word.hldyAtN" /></label></li>
                        	</ul>
                        </td>
                    </tr>
                    <c:if test="${!empty param.schdulSeq}">
	                    <tr id="skinDiv" <c:if test="${resultVO.initScrin eq 'L'}">style="display: none;"</c:if>>
	                    	<th><spring:message code="wzwg.module.word.skinestbs" /></th>
	                    	<td>
	                    		<div id="schdulCssDiv"></div>
	                    	</td>
	                    </tr>
                 	  <tr>
                        <th><spring:message code="wzwg.module.word.modulecnnc" /></th>
                        <td>
                        	<div class="mdLinkDiv">
                        		<table>
                        		<colgroup>
				                    <col width="10%"/>
				                    <col width="*"/>
				                </colgroup>
				                <tbody>
                        		<tr>
                        			<td class="pb10 fl">
			                        	<select name="selConnModuleSe" id="selConnModuleSe" style="width:120px;">
			                       			<option value=""><spring:message code="wzwg.cmm.word.choise" /></option>
			                       			<option value="10000000210"><spring:message code="wzwg.cmm.cntnts.onlinereqst" /></option>
			                       			<!-- <option value="10000000211"><spring:message code="wzwg.cmm.cntnts.onlinequstnr" /></option> -->
			                         	</select>
			                        </td>
			                        <td class="pb10 fl">
			                        	<select name="selSitecntntSeq" id="selSitecntntSeq" style="width:450px;">
			                        		<option value=""><spring:message code="wzwg.cmm.word.choise" /></option>
			                        	</select>
			                        	<c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
				                        	<a href="javascript:void(0);" id="connModule_add_btn" class="wzbtn-table btn-black"><spring:message code="wzwg.cmm.word.cnnc" /></a>
				                        </c:if>
			                        	<div class="block wd100">
				                        	<span class="admpg-subp grey linehgt150 block mt5">※ <spring:message code="wzwg.cmm.msg.MSG106" /></span>
			                        	</div>
                        			</td>
                        		</tr>
                        		<c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
                        		<tr>
                        			<td colspan="2" class="colorPicker">
                        				<b class="admpg-subp mt20 mb10 block"><spring:message code="wzwg.module.word.cnncedcntntsbcrnclrchoise" /></b>
			                        	<div id="colorList"></div>
                        			</td>
                        		</tr>
                        		</c:if>
                        		</tbody>
                        		</table>
			                </div>
			                <c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
							<div id="connModuleDiv">
								<c:import url="${wzwg_contextPath}${prefix}/module/schdul/bassInfo/selectConnModuleListAjax.do" charEncoding="utf-8">
	                                <c:param name="param_schdulSeq" value="${param.schdulSeq}" />
	                            </c:import>
							</div>
							</c:if>
                        </td>
					</tr>
					</c:if>
					
                </tbody>
                </table>
            <!--//기본정보 table -->
            
        </form:form>
                
         <div class="rt-box">
            <a href="javascript:void(0);" id="regist_btn" onclick="javascript:fnRegist('M');"  class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
            <a href="javascript:void(0);" id="reset_btn" onclick="javascript:fnReset_btn();"  class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
        </div>
