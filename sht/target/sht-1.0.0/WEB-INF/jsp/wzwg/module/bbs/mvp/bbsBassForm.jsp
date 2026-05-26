<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<jsp:include page="/WEB-INF/jsp/wzwg/webModule/editorTool.jsp"></jsp:include>

<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">

	$(document).ready(function(){

		('<c:out value="${resultVO.listCountAt}"/>' == 'Y') ? $("#listCountUnit").prop('disabled', false) : $("#listCountUnit").prop('disabled', true);
		('<c:out value="${resultVO.atchFilePosblAt}"/>' == 'Y') ? $("#atchFilePosblCo").prop('disabled', false) : $("#atchFilePosblCo").prop('disabled', true);
		
		$('#subospec_add_btn').click(function(){
		
		    if($('#addSubospecSj').val() == ''){
		        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.module.word.ctgrysj" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
		        $('#addSubospecSj').focus();
		        return;
		    }
		    
		    $('#subospecSj').val($('#addSubospecSj').val());
		    
		    $.ajax({
		        type : 'POST'
		        , url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/cmmn/registBbsSubospecAjax.do'
		        , dataType: 'xml'
		        , data : $("#regForm").serialize()
		        , success : function (result) {
		          
		            var value = "";
		            
		            $(result).find("value").each(function() {  
		                value = $(this).text();  
		            });
		            
		            if(value == 'success'){

		            	$.ajax({
		                    type : 'POST'
		                    , url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/cmmn/selectBbsSubospecListAjax.do'
		                    , dataType : 'html'
		                    , data : $("#regForm").serialize()
		                    , success : function (data) {
		                        $('#subospecList').html(data);
		                        $('#addSubospecSj').val("");
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
	    
	    $("#listCountAtY").click(function(){
	    	$("#listCountUnit").prop('disabled', false);
	    });
	    
	    $("#listCountAtN").click(function(){
	    	$("#listCountUnit").prop('disabled', true);
	    });
	    
	    $("#atchFilePosblAtY").click(function(){
	    	$("#atchFilePosblCo").prop('disabled', false);
	    });
	    
	    $("#atchFilePosblAtN").click(function(){
	    	$("#atchFilePosblCo").prop('disabled', true);
	    });
	    
	    <c:if test="${!empty resultVO.expsrAt }">
	    	<c:forEach items="${fn:split(resultVO.expsrAt, ',')}" var="expsrArr">
		    	if('<c:out value="${expsrArr}"/>' == 'W'){
					$("#expsrAtWrtr").prop("checked", true);
				}else if('<c:out value="${expsrArr}"/>' == 'R'){
					$("#expsrAtRgsd").prop("checked", true);
				}else if('<c:out value="${expsrArr}"/>' == 'I'){
					$("#expsrAtIngr").prop("checked", true);
				}else {}
	    	</c:forEach>
		</c:if>
    
	});	

    function fnRegist(callGubun) {
    	$('#bbsDc').val($("#bbsNm").val());
    	
        var ajaxUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/mvp';
        ajaxUrl += (callGubun != 'M')? '/registBbsBassInfoAjax.do':'/modifyBbsBassInfoAjax.do';
        
        $("#bbsPrface").val(oEditors.getById["bbsPrface"].getIR());
        //$("#bbsCnclsn").val(oEditors.getById["bbsCnclsn"].getIR());        
        
        if(callGubun != 'M') {
        	$("#cntntsNm").val($("#bbsNm").val());
        }         
        
        if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>')){
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
                            alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
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
    			 	$("#divLayerPopup").html(data);
    	    	  	$("#divLayerPopup").show();
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
                    
            <!--기본정보 table// -->
			<table class="basic" summary="<spring:message code="wzwg.cmm.word.bass" /><spring:message code="wzwg.cmm.word.info" />">
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
			        <td>
			            <c:set var="cntntsnm"><spring:message code="wzwg.module.word.cntntsnm" /></c:set>
                        <form:input path="bbsNm" id="bbsNm" cssClass="w70" dir="required" title="${fn:escapeXml(cntntsnm)}" />
			        </td>
			    </tr>
			    
			    <!-- 게시물 정보 노출여부 start -->
                <tr>
                    <th><spring:message code="wzwg.module.word.nttinfoexposureat"/></th> 
                    <td colspan="3">
                        <ul class="wzForm">
                        	<!-- 수정일때만 check 값 구분 -->
                        	<c:choose>
								<c:when test="${!empty resultVO.bbsSeq }">
									<%-- <li style=""><input type="checkbox" id="expsrAtNo" name="expsrAt" value="N" dir="required" /><spring:message code="wzwg.cmm.word.no"/></li> --%>
									<li><input type="checkbox" id="expsrAtWrtr" name="expsrAt" value="W" dir="required" /><label for="expsrAtWrtr"><spring:message code="wzwg.cmm.word.wrter"/></label></li>
									<li><input type="checkbox" id="expsrAtRgsd" name="expsrAt" value="R" dir="required" /><label for="expsrAtRgsd"><spring:message code="wzwg.cmm.word.rgsde02"/></label></li>
									<li><input type="checkbox" id="expsrAtIngr" name="expsrAt" value="I" dir="required" /><label for="expsrAtIngr"><spring:message code="wzwg.cmm.word.inqire"/></label></li>
								</c:when>
								<c:otherwise>
									<%-- <li style=""><input type="checkbox" id="expsrAtNo" name="expsrAt" value="N" dir="required" checked/><spring:message code="wzwg.cmm.word.no"/></li> --%>
									<li><input type="checkbox" id="expsrAtWrtr" name="expsrAt" value="W" dir="required" checked/><label for="expsrAtWrtr"><spring:message code="wzwg.cmm.word.wrter"/></label></li>
									<li><input type="checkbox" id="expsrAtRgsd" name="expsrAt" value="R" dir="required" checked/><label for="expsrAtRgsd"><spring:message code="wzwg.cmm.word.rgsde02"/></label></li>
									<li><input type="checkbox" id="expsrAtIngr" name="expsrAt" value="I" dir="required" checked/><label for="expsrAtIngr"><spring:message code="wzwg.cmm.word.inqire"/></label></li>
								</c:otherwise>
							</c:choose>
                        </ul>
                        <span class="wz_tableguide mt10 clboth"><spring:message code="wzwg.cmm.msg.tip.MSG109"/></span>
                    </td>
                </tr>
                <!-- 목록 화면 노출여부 end -->
                
                <tr>
                    <th><spring:message code="wzwg.cmm.word.listpostCount" /></th> 
                    <td colspan="3">
                        <ul class="wzForm">
	                        <li>
	                        	<input type="radio" id="listCountAtY" name="listCountAt" value="Y" dir="required" <c:if test="${resultVO.listCountAt eq 'Y'}">checked="true"</c:if> /><label for="listCountAtY"><spring:message code="wzwg.cmm.word.choise" /></label>
	                        	( <form:select path="listCountUnit" id="listCountUnit" name="listCountUnit" cssStyle="width:120px;">
		                        		<c:forEach var="result" begin="1" end="10" step="1">
		                        			<form:option value="${result}"><label for="unit"><c:out value='${result}'/> <spring:message code="wzwg.module.word.countunit" /></label></form:option>
		                        		</c:forEach>
		                        	</form:select> )
	                        </li>
	                        <li><input type="radio" id="listCountAtN" name="listCountAt" value="N" dir="required" <c:if test="${resultVO.listCountAt eq 'N' or resultVO.listCountAt eq null}">checked="true"</c:if> /><label for="listCountAtN"><spring:message code="wzwg.cmm.word.unsel" /></label></li>
                        </ul>
                        <span class="wz_tableguide mt10 clboth fl"><spring:message code="wzwg.cmm.msg.MSG401" /></span>
                    </td>
                </tr>
                <tr>
                	<th><spring:message code="wzwg.module.word.fileatchskll" /></th>
                	<td colspan="3">
                		<ul class="wzForm">
	                        <li>
	                        	<input type="radio" id="atchFilePosblAtY" name="atchFilePosblAt" value="Y" dir="required" <c:if test="${resultVO.atchFilePosblAt eq 'Y'}">checked="true"</c:if> /><label for="atchFilePosblAtY"><spring:message code="wzwg.cmm.word.use" text="use" /></label>
	                        	( <form:select path="atchFilePosblCo" id="atchFilePosblCo" name="atchFilePosblCo" cssStyle="width:120px;">
		                        		<c:forEach var="result" begin="1" end="10" step="1">
		                        			<form:option value="${result}"><label for="unit"><c:out value="${result}"/> <spring:message code="wzwg.cmm.word.count02" /></label></form:option>
		                        		</c:forEach>
		                        	</form:select> )
	                        </li>
	                        <li><input type="radio" id="atchFilePosblAtN" name="atchFilePosblAt" value="N" dir="required" <c:if test="${resultVO.atchFilePosblAt eq 'N' or resultVO.atchFilePosblAt eq null}">checked="true"</c:if> /><label for="atchFilePosblAtN"><spring:message code="wzwg.cmm.word.unuse" text="unuse" /></label></li>
                        </ul>
                	</td>
                </tr>
                <tr>
                    <th><spring:message code="wzwg.module.word.nttcnrs" /></th> 
                    <td colspan="3">
                        <ul class="wzForm">
	                        <li><input type="radio" id="snsCnrsAtA" name="snsCnrsAt" value="Y" dir="required" <c:if test="${resultVO.snsCnrsAt eq 'Y' or resultVO.snsCnrsAt eq null}">checked="true"</c:if> /><label for="snsCnrsAtA"><spring:message code="wzwg.cmm.word.use" /></label></li>
	                        <li><input type="radio" id="snsCnrsAtB" name="snsCnrsAt" value="N" dir="required" <c:if test="${resultVO.snsCnrsAt eq 'N'}">checked="true"</c:if> /><label for="snsCnrsAtB"><spring:message code="wzwg.cmm.word.unuse" /></label></li>
                        </ul>
                        <span class="wz_tableguide mt10 clboth fl"><spring:message code="wzwg.cmm.msg.MSG403" /></span>
                    </td>
                </tr>
               <%--  <tr>
                    <th><spring:message code="wzwg.cmm.word.ntt" /> <spring:message code="wzwg.cmm.word.scrap" /> <spring:message code="wzwg.module.word.useat" />
						<div class="menu_help">
                            <span class="circle_no">?</span>
                            <div class="help_pop">
                              	<spring:message code="wzwg.cmm.msg.MSG404" /> 
                              <img src="/images/wzwg/site/mngr/helpimg_unityboard04.jpg">
                            </div>
                        </div>                    
                    </th> 
                    <td colspan="3">
                        <ul>
	                        <li><input type="radio" id="scrapAtA" name="scrapAt" value="Y" dir="required" <c:if test="${resultVO.scrapAt eq 'Y'}">checked="true"</c:if> /><spring:message code="wzwg.cmm.word.use" /></li>
	                        <li><input type="radio" id="scrapAtB" name="scrapAt" value="N" dir="required" <c:if test="${resultVO.scrapAt eq 'N' or resultVO.scrapAt eq null}">checked="true"</c:if> /><spring:message code="wzwg.cmm.word.unuse" /></li>
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

			    <c:if test="${not empty resultVO.bbsSeq}">
			    <tr>
                    <th><spring:message code="wzwg.cmm.word.ctgry02" /></th>
                    <td colspan="3">
                        <input type="hidden" id="subospecSj" name="subospecSj" />
                        
                        <input type="text" id="addSubospecSj" name="addSubospecSj" class="w70" />
                        <a href="javascript:void(0);" id="subospec_add_btn" class="wzbtn-table btn-basic"><spring:message code="wzwg.cmm.word.add" /></a>
                        
                        <div id="subospecList" class="mt10">
                            <c:import url="<c:out value='${wzwg_contextPath}${prefix}'/>/module/bbs/cmmn/selectBbsSubospecListAjax.do" charEncoding="utf-8">
                                <c:param name="param_bbsSeq" value="${resultVO.bbsSeq}" />
                            </c:import>
                        </div>   
                    </td>
                </tr> 
                <!-- <tr>
                	<th><spring:message code="wzwg.module.word.tychange" /></th>
                	<td>
                		<div id="divInfoArea"></div>
                	</td>
                </tr>  -->                 
                </c:if>
                
			</tbody>
			</table>
            <!--//기본정보 table -->
            
        </form:form>
                
        <div class="rt-box"> 
            <a href="javascript:void(0);" id="regist_btn" onclick="fnRegist('M');" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
            <a href="javascript:void(0);" id="reset_btn" onclick="fnReset_btn();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
        </div>
