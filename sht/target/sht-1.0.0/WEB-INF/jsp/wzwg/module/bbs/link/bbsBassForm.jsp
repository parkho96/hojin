<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<jsp:include page="/WEB-INF/jsp/wzwg/webModule/editorTool.jsp"></jsp:include>

<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">

	$(document).ready(function(){
	    fnCssInfo();
	});

    function fnRegist(callGubun) {
    	$('#bbsDc').val($("#bbsNm").val());
    	
        var ajaxUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/link';
        ajaxUrl += (callGubun != 'M')? '/registBbsBassInfoAjax.do':'/modifyBbsBassInfoAjax.do';
        
        $("#bbsPrface").val(oEditors.getById["bbsPrface"].getIR());
        
        if(callGubun != 'M') {
        	$("#cntntsNm").val($("#bbsNm").val());
        }
        
        if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>')){
            return;
        }else{
        	
			if(!Validator.validate(document.regForm)){
				return;
			}
			 
            $.ajax({
                type : 'POST'
                , url : ajaxUrl
                , dataType: 'xml'
                , data : $("#regForm").serialize()
                , success : function (result) {
                  
                    var value = "";
                    
                    $(result).find("value").each(function() {  
                        value = $(this).text();  
                    });
                    
                    if(value == 'success'){
                        if (callGubun != 'M') {
                            fnCntntsRegist();   
                        } else {
                            alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>');
                            fnBbsChage($('#bbsSel').val());
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
        document.regForm.action='<c:out value="${wzwg_contextPath}${prefix}"/>/cntnts/cntntsInfo/selectCntntsInfoList.do';
        document.regForm.submit();
    }
    
    function fnCntntsStylePopup(){
    	$.ajax({
			type:'POST'
			, url:'<c:out value="${wzwg_contextPath}"/>/mngr/module/bbs/cmmn/selectCssListPopup.do'
			, data : $("#regForm").serialize()
			, success:function (data) {
				var title = '<spring:message code="wzwg.module.word.skinestbs" />';
			 	wzAjaxModal('popup_l', title, data);
			}
			, dataType: 'html'
    	});
    }
    
    function fnLayerPopupClose() {
        $("#divLayerPopup").hide();
        $("#divLayerPopup").empty();
        $('body').css({overflow:'auto'});
    }   
    
    function fnCssInfo() {

	    $.ajax({
	        type : 'POST'
	        , url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/cmmn/selectCssInfoAjax.do'
            , dataType : 'html'
            , data : $("#regForm").serialize()
            , success : function (data) {
                $('#divInfoArea').html(data);
            }
            , error : function (request, status, error) {
                alert('<spring:message code="fail.common.msg" text="error" />');
            }

	    });
    }    
</script>

		<!-- 레이어팝업 영역 Start -->
		<div id="divLayerPopup" class="pop-box"></div>
		<!-- 레이어팝업 영역 End -->
        
        <form:form modelAttribute="resultVO" path="regForm" id="regForm" name="regForm" method="post">
            <form:hidden path="sitecntntsSeq" />
            <form:hidden path="siteSeq" />
            <form:hidden path="bbsSeq" />
            <form:hidden path="cssSeq" />
            <form:hidden path="pageMode" />
                    
            <table class="basic" summary="<spring:message code="wzwg.cmm.menu.bassinfo" />">
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
                        <form:input path="bbsNm" id="bbsNm" cssClass="w70" dir="required" title="${fn:escapeXml(cntntsnm)}" />
                    </td>
                </tr>
                <tr>
                    <th><spring:message code="wzwg.module.word.listscreenty" /> </th> 
                    <td colspan="3">
                        <ul class="wzForm">
                        	<li class="bbs-tySel" style="text-align: center;">
	                        	<label style="cursor: pointer;">
	                        		<img src="/images/wzwg/module/ntt/03event.png" style="display: block; margin-bottom: 10px" onclick="$('#listScrinCodeE').click();">
	                        		<input type="radio" id="listScrinCodeE" name="listScrinCode" value="E" dir="required" <c:if test="${resultVO.listScrinCode eq 'E'}">checked="true"</c:if> /><span class="spanLabel"><spring:message code="wzwg.cmm.word.event" text="event" /></span>
	                        	</label>
	                        </li>
	                        <li class="bbs-tySel" style="text-align: center;">
	                        	<label style="cursor: pointer;">
	                        		<img src="/images/wzwg/module/ntt/01board.png" style="display: block; margin-bottom: 10px" onclick="$('#listScrinCodeD').click();">
	                        		<input type="radio" id="listScrinCodeL" name="listScrinCode" value="L" dir="required" <c:if test="${resultVO.listScrinCode eq 'L' or resultVO.listScrinCode eq null}">checked="true"</c:if> /><span class="spanLabel"><spring:message code="wzwg.cmm.word.list" text="list" /></span>
	                        	</label>
	                        </li>
	                        <li class="bbs-tySel" style="text-align: center;">
	                        	<label style="cursor: pointer;">
	                        		<img src="/images/wzwg/module/ntt/02album.png" style="display: block; margin-bottom: 10px" onclick="$('#listScrinCodeC').click();">
	                        		<input type="radio" id="listScrinCodeI" name="listScrinCode" value="I" dir="required" <c:if test="${resultVO.listScrinCode eq 'I'}">checked="true"</c:if> /><span class="spanLabel"><spring:message code="wzwg.cmm.word.image" text="image" /></span>
	                        	</label>
	                        </li>
                        </ul>
						<div class="wz_tableguide mt10 block clboth">
					      <p><b><spring:message code="wzwg.module.word.eventty" /> </b>: <spring:message code="wzwg.cmm.msg.tip.MSG154" /></p>
					      <p><b><spring:message code="wzwg.module.word.listty" /> </b>: <spring:message code="wzwg.cmm.msg.tip.MSG155" /></p>
					      <p><b><spring:message code="wzwg.module.word.imagety" /> </b>: <spring:message code="wzwg.cmm.msg.tip.MSG156" /></p>
					    </div>
                    </td>
                </tr>
                
				<c:if test="${not empty resultVO.bbsSeq}">
                <tr>
                	<th><spring:message code="wzwg.module.word.tychange" /></th>
                	<td>
                		<div id="divInfoArea"></div>
                	</td>
                </tr>  
                </c:if>
                
                <%-- <tr id="listNumDiv">
                    <th><spring:message code="wzwg.cmm.word.posts" text="posts" /> <spring:message code="wzwg.cmm.word.no" text="no" /> <spring:message code="wzwg.cmm.word.exposure" text="exposure" /></th> 
                    <td colspan="3">
                        <ul>
	                        <li><input type="radio" id="listNumCodeA" name="listNumCode" value="N" dir="required" <c:if test="${resultVO.listNumCode eq 'N' or resultVO.listNumCode eq null}">checked="true"</c:if> /><spring:message code="wzwg.cmm.word.ntt" text="ntt" /> <spring:message code="wzwg.cmm.word.no" text="no" /></li>
	                        <li><input type="radio" id="listNumCodeB" name="listNumCode" value="P" dir="required" <c:if test="${resultVO.listNumCode eq 'P'}">checked="true"</c:if> /><spring:message code="wzwg.cmm.word.page" text="page" /> <spring:message code="wzwg.cmm.word.no" text="no" /></li>
                        </ul>
                    </td>
                </tr> --%>
                <%-- <tr>
                    <th><spring:message code="wzwg.cmm.word.list" text="list" /> <spring:message code="wzwg.cmm.word.count" text="count" /> <spring:message code="wzwg.cmm.word.use" text="use" /> <spring:message code="wzwg.cmm.word.at" text="at" /></th> 
                    <td colspan="3">
                        <ul>
	                        <li>
	                        	<input type="radio" id="listCountAtY" name="listCountAt" value="Y" dir="required" <c:if test="${resultVO.listCountAt eq 'Y'}">checked="true"</c:if> /><spring:message code="wzwg.cmm.word.use" text="use" />
	                        	( <spring:message code="wzwg.cmm.word.unit" /> 	
	                        		<form:select path="listCountUnit" id="listCountUnit" name="listCountUnit" cssStyle="width:120px;">
		                        		<c:forEach var="result" begin="1" end="10" step="1">
		                        			<form:option value="${result}"><label for="unit"><c:out value='${result}'/> <spring:message code="wzwg.cmm.word.count02" /> <spring:message code="wzwg.cmm.word.unit" /></label></form:option>
		                        		</c:forEach>
		                        	</form:select> )
	                        </li>
	                        <li><input type="radio" id="listCountAtN" name="listCountAt" value="N" dir="required" <c:if test="${resultVO.listCountAt eq 'N' or resultVO.listCountAt eq null}">checked="true"</c:if> /><spring:message code="wzwg.cmm.word.unuse" text="unuse" /></li>
                        </ul>
                    </td>
                </tr> --%>
                <tr>
                    <th class="headwrite_board"><spring:message code="wzwg.module.word.prefaceestbs" />
                    	<div class="menu_help">
							<img src="/images/wzwg/site/mngr/ico_help_grey.png">
							<div class="help_pop">
								<img src="/images/wzwg/site/mngr/helpimg_headwrite.jpg">
					
							</div>
						</div>
                    </th>
                    <td colspan="3">
                        <textarea name="bbsPrface" id="bbsPrface" rows="10" style="width:100%;"><c:out value="${resultVO.bbsPrface}"/></textarea>
			
						<script type="text/javascript">
							var oEditors = [];
							nhn.husky.EZCreator.createInIFrame({
								oAppRef: oEditors,
								elPlaceHolder: "bbsPrface",
								sSkinURI: "<c:out value='${wzwg_contextPath}'/>/smartEditor2.8.2.1/smartEditor2Skin.do",
								fCreator: "createSEditor2",
								htParams: {fOnBeforeUnload : function(){},aAdditionalFontList : [['NanumSquareR', 'NanumSquareR']]}
							});
							WzwgEditorTool.instance("bbsPrface");
						</script>                        
                    </td>
                </tr>
            </tbody>
            </table>
            
        </form:form>
                
        <div class="rt-box"> 
            <a href="javascript:void(0);" id="regist_btn" onclick="fnRegist('M');" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" text="stre" /></a>
            <a href="javascript:void(0);" id="reset_btn" onclick="fnReset_btn();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" text="list" /></a>
        </div>
