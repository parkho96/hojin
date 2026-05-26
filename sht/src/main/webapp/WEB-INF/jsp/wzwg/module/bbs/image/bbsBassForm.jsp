<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<jsp:include page="/WEB-INF/jsp/wzwg/webModule/editorTool.jsp"></jsp:include>

<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">

	$(document).ready(function(){
	    
		/* ('<c:out value="${resultVO.listCountAt}"/>' == 'Y') ? $("#listCountUnit").prop('disabled', false) : $("#listCountUnit").prop('disabled', true); */
		('<c:out value="${resultVO.atchFilePosblAt}"/>' == 'Y') ? $("#atchFilePosblCo").prop('disabled', false) : $("#atchFilePosblCo").prop('disabled', true);
		
		fnChangeListCntView($('input[name="listScrinCode"]:checked'));
		
		fnChangeAlbumUnitImg($('#listCountUnit_image'));
		
	    $('#subospec_add_btn').click(function(){
			
	        if($('#addSubospecSj').val() == ''){
	            alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.module.word.ctgrysj" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" text="input" /></spring:argument></spring:message>');
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
	    
	    //fnCssInfo();
	    
	    $("#listCountAtY_event").click(function(){
	    	$("#listCountUnit_event").prop('disabled', false);
	    });
	    
	    $("#listCountAtN_event").click(function(){
	    	$("#listCountUnit_event").prop('disabled', true);
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
    	
        var ajaxUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/image';
        ajaxUrl += (callGubun != 'M')? '/registBbsBassInfoAjax.do':'/modifyBbsBassInfoAjax.do';
        
        $("#bbsPrface").val(oEditors.getById["bbsPrface"].getIR());
       // $("#bbsCnclsn").val(oEditors.getById["bbsCnclsn"].getIR());
        
        if(callGubun != 'M') {
        	$("#cntntsNm").val($("#bbsNm").val());
        }
        
        if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>')){
            return;
        }else{
        	
			if(!Validator.validate(document.regForm)){
				return;
			}
			
			var listType = $('input[name="listScrinCode"]:checked').val();
			console.log('listType : ' + listType);
			if(listType == 'I'){
				$('#listCountAt').val($('input[name="listCountAt_image"]:checked').val());
		        $('#listCountUnit').val($('#listCountUnit_image').val());
		        console.log('listCountUnit : ' + $('#listCountUnit').val())
			}else if(listType == 'E'){
				$('#listCountAt').val($('input[name="listCountAt_event"]:checked').val());
		        $('#listCountUnit').val($('#listCountUnit_event').val());
		        console.log('listCountUnit : ' + $('#listCountUnit').val())
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
    			 	//$("#divLayerPopup").html(data);
    	    	  	//$("#divLayerPopup").show();
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
    
    function fnChangeListCntView(radio){
    	var value = $(radio).val();
    	//console.log(value);
    	if(value == 'I'){
    		var useCntAt = $('input[name="listCountAt_event"]:checked').val();
    		if(useCntAt == 'Y'){
    			$('#listCountAtY_image').prop('checked', true);//사용여부 따라가기
    		}else{
    			$('#listCountAtN_image').prop('checked', true);//사용여부 따라가기
    		}
    		
    		$('.tr_imageListCount').show();
    		$('#tr_eventListCount').hide();
    	}else if(value == 'E'){
    		var useCntAt = $('input[name="listCountAt_image"]:checked').val();
    		if(useCntAt == 'Y'){
    			$('#listCountAtY_event').prop('checked', true); //사용여부 따라가기
    			$("#listCountUnit_event").prop('disabled', false); //사용여부에 따라 셀렉트 박스 선택권 변경
    		}else{
    			$('#listCountAtN_event').prop('checked', true); //사용여부 따라가기
    			$("#listCountUnit_event").prop('disabled', true); //사용여부에 따라 셀렉트 박스 선택권 변경
    		}
    		
    		$('.tr_imageListCount').hide();
    		$('#tr_eventListCount').show();
    	}
    }
    
    function fnChangeAlbumUnitImg(sel){
    	var imgSrc = '/images/wzwg/module/ntt/album_' + $(sel).val() + 'ea.png';
    	$('#img_albumListUnit').attr('src', imgSrc);
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
            <%-- 이미지게시판은 글번호 노출되지 않음 - 페이지 번호로 고정함 --%>
            <input type="hidden" name="listNumCode" value="P" />
            <input type="hidden" id="listCountAt" name="listCountAt" value="" />
            <input type="hidden" id="listCountUnit" name="listCountUnit" value="" />
            
            <table class="basic" summary="<spring:message code="wzwg.cmm.menu.bassinfo" />">
            <colgroup>
                <col width="20%"/>
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
                        <c:set var="cntntsnm">
						    <c:out value="${wzwg.module.word.cntntsnm}" />
						</c:set>
						<form:input path="bbsNm" id="bbsNm" cssClass="w70" dir="required" title="${fn:escapeXml(cntntsnm)}" />
                    </td>
                </tr>
                <c:if test="${resultVO.pageMode eq 'B'}">
                <tr>
                    <th><spring:message code="wzwg.module.word.nttform" /></th>
                    <td colspan="3">
                        <form:select path="formSeq" id="formSeq" cssClass="w40">
                            <form:option value=""><label for="unuse"><spring:message code="wzwg.cmm.word.unuse" text="unuse" /></label></form:option>
                            <c:if test="${!empty formList}">
                                <c:forEach var="formList" items="${formList}" varStatus="status">
								    <option value="${fn:escapeXml(formList.formSeq)}">
								    	<c:out value="${formList.formSj}"/>
								    </option>
								</c:forEach>
                            </c:if>
                        </form:select>
                        <span class="wz_tableguide mt10 clboth"><spring:message code="wzwg.cmm.msg.tip.MSG025" /> <b><a class="grey" href="/mngr/module/bbs/bbsForm/selectModuleBbsFormList.do" target="_blank" title="(<spring:message code="wzwg.cmm.word.wa.newOpWin" />)"><spring:message code="wzwg.cmm.msg.tip.MSG0251" /></a></b></span>
                    </td>
                </tr>
                </c:if>
                
                <tr>
                    <th><spring:message code="wzwg.module.word.listscreenty" /> </th> 
                    <td colspan="3">
                        <ul>
	                        <%-- <li class="bbs-tySel" style="text-align: center;">
	                        	<label style="cursor: pointer;">
	                        		<img src="/images/wzwg/module/ntt/01board.png" style="display: block; margin-bottom: 10px" onclick="$('#listScrinCodeD').click();">
	                        		<input type="radio" id="listScrinCodeD" name="listScrinCode" value="L" dir="required" <c:if test="${resultVO.listScrinCode eq 'L' or resultVO.listScrinCode eq null}">checked="true"</c:if> /><spring:message code="wzwg.cmm.word.bbs" text="bbs" />
	                        	</label>
	                        </li> --%>
	                        <li class="bbs-tySel" style="text-align: center;">
	                        	<label style="cursor: pointer;">
	                        		<img src="/images/wzwg/module/ntt/02album.png" style="display: block; margin-bottom: 10px" onclick="$('#listScrinCodeC').click();">
	                        		<input type="radio" id="listScrinCodeC" name="listScrinCode" value="I" dir="required" onchange="fnChangeListCntView(this)" <c:if test="${resultVO.listScrinCode eq 'I' or resultVO.listScrinCode eq null}">checked="true"</c:if> /><spring:message code="wzwg.cmm.word.album" text="album" />
	                        	</label>
	                        </li>
	                        <li class="bbs-tySel" style="text-align: center;">
	                        	<label style="cursor: pointer;">
	                        		<img src="/images/wzwg/module/ntt/03event.png" style="display: block; margin-bottom: 10px" onclick="$('#listScrinCodeE').click();">
	                        		<input type="radio" id="listScrinCodeE" name="listScrinCode" value="E" dir="required" onchange="fnChangeListCntView(this)" <c:if test="${resultVO.listScrinCode eq 'E'}">checked="true"</c:if> /><spring:message code="wzwg.cmm.word.event" text="event" />
	                        	</label>
	                        </li>
	                       <%--  
	                       <li class="bbs-tySel" style="text-align: center;">
	                        	<label style="cursor: pointer;">
	                        		<img src="/images/wzwg/module/ntt/04webzine.png" style="display: block; margin-bottom: 10px" onclick="$('#listScrinCodeB').click();">
	                        		<input type="radio" id="listScrinCodeB" name="listScrinCode" value="W" dir="required" <c:if test="${resultVO.listScrinCode eq 'W'}">checked="true"</c:if> /><spring:message code="wzwg.cmm.word.webzine" text="webzine" />
	                        	</label>
	                        </li>
	                        <li class="bbs-tySel" style="text-align: center;">
	                        	<label style="cursor: pointer;">
	                        		<img src="/images/wzwg/module/ntt/05blog.png" style="display: block; margin-bottom: 10px" onclick="$('#listScrinCodeA').click();">
	                        		<input type="radio" id="listScrinCodeA" name="listScrinCode" value="B" dir="required" <c:if test="${resultVO.listScrinCode eq 'B'}">checked="true"</c:if> /><spring:message code="wzwg.cmm.word._blog" text="blog" />
	                        	</label>
	                        </li>
	                        --%>
                        </ul>
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
                
                <%-- 
                <tr>
                    <th><spring:message code="wzwg.cmm.word.posts" text="posts" /> <spring:message code="wzwg.cmm.word.no" text="no" /> <spring:message code="wzwg.cmm.word.exposure" text="exposure" />
                    <div class="menu_help">
				        <span class="circle_no">?</span>
				        <div class="help_pop">
				            <spring:message code="wzwg.cmm.msg.MSG405" />
				            <img src="/images/wzwg/site/mngr/helpimg_unityboardno.jpg">
				        </div>
				    </div>
                    </th> 
                    <td colspan="3">
                        <ul>
	                        <li><input type="radio" id="listNumCodeA" name="listNumCode" value="N" dir="required" <c:if test="${resultVO.listNumCode eq 'N' or resultVO.listNumCode eq null}">checked="true"</c:if> /><spring:message code="wzwg.cmm.word.ntt" text="ntt" /> <spring:message code="wzwg.cmm.word.no" text="no" /></li>
	                        <li><input type="radio" id="listNumCodeB" name="listNumCode" value="P" dir="required" <c:if test="${resultVO.listNumCode eq 'P'}">checked="true"</c:if> /><spring:message code="wzwg.cmm.word.page" text="page" /> <spring:message code="wzwg.cmm.word.no" text="no" /></li>
                        </ul>
                    </td>
                </tr>
                --%>
                
                <tr class="tr_imageListCount" style="display:none;"><%-- 앨범형 목록갯수 --%>
                    <th><spring:message code="wzwg.module.word.listcountuseat" />
						<div class="menu_help">
                            <span class="circle_no">?</span>
                            <div class="help_pop">
                            	  <spring:message code="wzwg.cmm.msg.MSG401" />                             	
                            	<img src="/images/wzwg/site/mngr/helpimg_unityboard01.jpg">
                        	</div>
                        </div>                         
                    </th> 
                    <td colspan="3">
                        <ul class="wzForm">
	                        <li>
	                        	<input type="radio" id="listCountAtY_image" name="listCountAt_image" value="Y" dir="required" <c:if test="${resultVO.listCountAt eq 'Y'}">checked="true"</c:if> />
	                        	<label for="listCountAtY_image"><spring:message code="wzwg.cmm.word.use" text="use" /></label>
	                        </li>
	                        <li>
	                        	<input type="radio" id="listCountAtN_image" name="listCountAt_image" value="N" dir="required" <c:if test="${resultVO.listCountAt eq 'N' or resultVO.listCountAt eq null}">checked="true"</c:if> />
	                        	<label for="listCountAtN_image"><spring:message code="wzwg.cmm.word.unuse" text="unuse" /></label>
	                        </li>
                        </ul>
                    </td>
                </tr>
                <tr class="tr_imageListCount" style="display:none;"><%-- 앨범형 배열 선택 --%>
                    <th>
                    	<spring:message code="wzwg.cmm.word.album"/>
                    	<spring:message code="wzwg.cmm.word.list"/>
                    	<spring:message code="wzwg.cmm.word.array"/>
                    	<spring:message code="wzwg.cmm.word.choise"/>
                    </th> 
                    <td colspan="3">
                        <ul class="wzForm">
	                        <li>
	                        	<select id="listCountUnit_image" name="listCountUnit_image" style="width:120px;" onchange="fnChangeAlbumUnitImg(this)">
	                        			<option value="3" <c:if test="${resultVO.listCountUnit eq '3' }">selected="selected"</c:if>>3 <spring:message code="wzwg.module.word.steparray" /></option>
	                        			<option value="4" <c:if test="${resultVO.listCountUnit eq '4' }">selected="selected"</c:if>>4 <spring:message code="wzwg.module.word.steparray" /></option>
	                        	</select>
	                        	
	                        	<span>
	                        		<img id="img_albumListUnit" src="/images/wzwg/module/ntt/album_3ea.png"/>
	                        	</span>
	                        </li>
                        </ul>
                    </td>
                </tr>
                
                <tr id="tr_eventListCount" style="display:none;"><%-- 이벤트형 목록갯수 --%>
                    <th><spring:message code="wzwg.cmm.word.listpostCount" /></th> 
                    <td colspan="3">
                        <ul class="wzForm">
	                        <li>
	                        	<input type="radio" id="listCountAtY_event" name="listCountAt_event" value="Y" dir="required" <c:if test="${resultVO.listCountAt eq 'Y'}">checked="true"</c:if> />
	                        	<label for="listCountAtY_event"><spring:message code="wzwg.cmm.word.choise" /></label>
	                        	( 
	                        		<select id="listCountUnit_event" name="listCountUnit_event" style="width:120px;">
	                        			<c:forEach var="result" begin="1" end="10" step="1">
	                        			<option value="${result}" <c:if test="${resultVO.listCountUnit eq result }">selected="selected"</c:if>><c:out value='${result}'/> <spring:message code="wzwg.module.word.countunit" /></option>
	                        			</c:forEach>
	                        		</select>
	                        		<%-- <form:select path="listCountUnit" id="listCountUnit_event" name="listCountUnit_event" cssStyle="width:120px;">
		                        		<c:forEach var="result" begin="1" end="10" step="1">
		                        			<form:option value="${result}"><label for="unit"><c:out value='${result}'/> <spring:message code="wzwg.cmm.word.count02" /> <spring:message code="wzwg.cmm.word.unit" /></label></form:option>
		                        		</c:forEach>
		                        	</form:select>  --%>
		                        )
	                        </li>
	                        <li>
	                        	<input type="radio" id="listCountAtN_event" name="listCountAt_event" value="N" dir="required" <c:if test="${resultVO.listCountAt eq 'N' or resultVO.listCountAt eq null}">checked="true"</c:if> />
	                        	<label for="listCountAtN_event"><spring:message code="wzwg.cmm.word.unsel" /></label>
	                        </li>
                        </ul>
                        <span class="wz_tableguide mt10 clboth fl"><spring:message code="wzwg.cmm.msg.MSG401" /></span>
                    </td>
                </tr>
                
                <tr>
                	<th><spring:message code="wzwg.module.word.imageatchcount" /></th>
                	<td colspan="3">
                		<ul class="wzForm">
	                        <li>
	                        	<%-- <input type="radio" id="atchFilePosblAtY" name="atchFilePosblAt" value="Y" dir="required" <c:if test="${resultVO.atchFilePosblAt eq 'Y' }">checked="true"</c:if> /><spring:message code="wzwg.cmm.word.use" text="use" /> --%>
	                        	 <%-- <spring:message code="wzwg.cmm.word.unit" /> --%> 	
	                        		<form:select path="atchImgFilePosblCo" id="atchImgFilePosblCo" name="atchImgFilePosblCo" cssStyle="width:120px;">
		                        		<c:forEach var="result" begin="1" end="10" step="1">
		                        			<form:option value="${result}"><label for="unit">${result} <spring:message code="wzwg.cmm.word.count02" /></label></form:option>
		                        		</c:forEach>
		                        	</form:select> 
	                        </li>
	                        <%-- <li><input type="radio" id="atchFilePosblAtN" name="atchFilePosblAt" value="N" dir="required" <c:if test="${resultVO.atchFilePosblAt eq 'N' or resultVO.atchFilePosblAt eq null}">checked="true"</c:if> /><spring:message code="wzwg.cmm.word.unuse" text="unuse" /></li> --%>
                        </ul>
                	</td>
                </tr>
                
                <tr>
                	<th><spring:message code="wzwg.module.word.fileatchskll" /></th>
                	<td colspan="3">
                		<ul class="wzForm">
	                        <li>
	                        	<input type="radio" id="atchFilePosblAtY" name="atchFilePosblAt" value="Y" dir="required" <c:if test="${resultVO.atchFilePosblAt eq 'Y'}">checked="true"</c:if> /><label for="atchFilePosblAtY"><spring:message code="wzwg.cmm.word.use" text="use" /></label>
	                        	( 
	                        		<form:select path="atchFilePosblCo" id="atchFilePosblCo" name="atchFilePosblCo" cssStyle="width:120px;">
		                        		<c:forEach var="result" begin="1" end="10" step="1">
		                        			<form:option value="${result}"><label for="unit">${result} <spring:message code="wzwg.cmm.word.count02" /></label></form:option>
		                        		</c:forEach>
		                        	</form:select> )
	                        </li>
	                        <li><input type="radio" id="atchFilePosblAtN" name="atchFilePosblAt" value="N" dir="required" <c:if test="${resultVO.atchFilePosblAt eq 'N' or resultVO.atchFilePosblAt eq null}">checked="true"</c:if> />
	                        <label for="atchFilePosblAtN"><spring:message code="wzwg.cmm.word.unuse" text="unuse" /></label>
	                        </li>
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
                <%-- <tr>
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
                <%-- <tr>
                    <th><spring:message code="wzwg.cmm.word.prev" /> <spring:message code="wzwg.cmm.word.ntt" /> / <spring:message code="wzwg.cmm.word.next" /> <spring:message code="wzwg.cmm.word.ntt" /> <spring:message code="wzwg.module.word.useat" /></th> 
                    <td colspan="3">
                        <ul>
	                        <li><input type="radio" id="prevNextAtA" name="prevNextAt" value="Y" dir="required" <c:if test="${resultVO.prevNextAt eq 'Y'}">checked="true"</c:if> /><spring:message code="wzwg.cmm.word.use" /></li>
	                        <li><input type="radio" id="prevNextAtB" name="prevNextAt" value="N" dir="required" <c:if test="${resultVO.prevNextAt eq 'N' or resultVO.prevNextAt eq null}">checked="true"</c:if> /><spring:message code="wzwg.cmm.word.unuse" /></li>
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
                        <textarea name="bbsPrface" id="bbsPrface" rows="10" style="width:100%;"><c:out value='${resultVO.bbsPrface}'/></textarea>
			
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
                	<th><spring:message code="wzwg.module.word.ctgryty" /></th>
                	<td>
                		<ul class="wzForm">
                			<li><input type="radio" name="cateTy" value="L" id="cateTyL" <c:if test="${resultVO.cateTy eq 'L' or empty resultVO.cateTy}">checked</c:if>/><label class="mr15" for="cateTyL"><spring:message code="wzwg.cmm.word.list" /></label>
                			<li><input type="radio" name="cateTy" value="T" id="cateTyT" <c:if test="${resultVO.cateTy eq 'T'}">checked</c:if>/><label class="mr15" for="cateTyT"><spring:message code="wzwg.cmm.word.tab" /></label>
                		</ul>
                		<span class="wz_tableguide mt10 clboth">
						    <b><spring:message code="wzwg.cmm.word.list" /></b> : <spring:message code="wzwg.cmm.msg.tip.MSG110" /><br>
						    <b><spring:message code="wzwg.cmm.word.tab" /></b> : <spring:message code="wzwg.cmm.msg.tip.MSG111" />
						</span>
                	</td>
                </tr> 
                <tr>
                    <th><spring:message code="wzwg.cmm.word.ctgry02" text="category" /></th>
                    <td colspan="3">
                        <input type="hidden" id="subospecSj" name="subospecSj" />
                        
                        <input type="text" id="addSubospecSj" name="addSubospecSj" class="w70" />
                        <a href="javascript:void(0);" id="subospec_add_btn" class="wzbtn-table btn-basic"><spring:message code="wzwg.cmm.word.add" text="add" /></a>
                        
                        <div id="subospecList" class="mt10">
                            <c:import url="<c:out value='${wzwg_contextPath}${prefix}'/>/module/bbs/cmmn/selectBbsSubospecListAjax.do" charEncoding="utf-8">
                                <c:param name="param_bbsSeq" value="${resultVO.bbsSeq}" />
                            </c:import>
                        </div>   
                    </td>
                </tr> 
                                 
                <%-- <tr>
                	<th><spring:message code="wzwg.module.word.tychange" /></th>
                	<td>
                		<div id="divInfoArea"></div>
                	</td>
                </tr>       --%>            
                </c:if>
                             
            </tbody>
            </table>
            
        </form:form>
                
        <div class="rt-box"> 
            <a href="javascript:void(0);" id="regist_btn" onclick="fnRegist('M');" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" text="stre" /></a>
            <a href="javascript:void(0);" id="reset_btn" onclick="fnReset_btn();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" text="list" /></a>
        </div>
