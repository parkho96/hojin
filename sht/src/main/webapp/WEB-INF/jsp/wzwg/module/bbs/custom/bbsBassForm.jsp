<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<jsp:include page="/WEB-INF/jsp/wzwg/webModule/editorTool.jsp"></jsp:include>

<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript" src="/js/wzwg/cmm/jquery-ui.js"></script>
<style type="text/css">
.ui-sortable-helper {border:1px dashed #3899ec !important;}
</style>

<script type="text/javascript">

var oEditors = [];
	$(document).ready(function(){
	    
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
	    
	    
	  fnFieldSort();
	  noLoginChange();
	    
	    $("#listCountAtY").click(function(){
	    	$("#listCountUnit").prop('disabled', false);
	    });
	    
	    $("#listCountAtN").click(function(){
	    	$("#listCountUnit").prop('disabled', true);
	    });

	    <c:if test="${!empty resultVO.expsrAt }">
    	<c:forEach items="${fn:split(resultVO.expsrAt, ',')}" var="expsrArr">
    		if('<c:out value="${expsrArr}"/>' == 'N'){
    			$("#expsrAtNo").prop("checked", true);
    		}else if('<c:out value="${expsrArr}"/>' == 'W'){
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
    	
    	var fileChk = true;
    	if($("#nolognAt").is(":checked") == true){
    		$('#fieldArea select[name="fieldTy"]').each(function(idx,el){
    			if($(this).val() == 'image' || $(this).val() == 'file'){
    				if($("#fieldArea select[name=useAt]").eq(idx).val() != 'N'){ fileChk = false;	}
    			}
    		});
    		if(fileChk == false){
    			alert('<spring:message code="wzwg.cmm.msg.MSG337"/>');
    			return ;
    		}
    	}
    	
		var fieldArr = [];
		
		$('#fieldArea input[name="fieldNm"]').each(function(idx,el){
			fieldArr.push($(this).val());
		});
		
		if(arrayDuplicateCheck(fieldArr) == false){
			alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004">'+
					'<spring:argument><spring:message code="wzwg.module.word.iemnm" /></spring:argument>'+
					'<spring:argument><spring:message code="wzwg.cmm.word.dplct" text="duplication" /></spring:argument>'+
				  '</spring:message>');
			return;
		}

		var typeArr = [];
		$('#fieldArea select[name="fieldTy"]').each(function(idx,el){
			typeArr.push($(this).val());
		});
		
		if(fnTitleFieldCheck(typeArr, 'title') == false){
			alert('<spring:message code="wzwg.cmm.cmmMsg.CMG018">'+
					'<spring:argument><spring:message code="wzwg.module.word.sjty" /></spring:argument>'+
					'<spring:argument><spring:message code="wzwg.cmm.word.one" text="one" /></spring:argument>'+
					'<spring:argument><spring:message code="wzwg.cmm.word.use" text="use" /></spring:argument>'+
				  '</spring:message>');
			return;
		}
		
		if(fnTitleFieldCheck(typeArr, 'password') == false){
			alert('<spring:message code="wzwg.cmm.cmmMsg.CMG018">'+
					'<spring:argument><spring:message code="wzwg.cmm.word.password" text="password" /></spring:argument>'+
					'<spring:argument><spring:message code="wzwg.cmm.word.one" text="one" /></spring:argument>'+
					'<spring:argument><spring:message code="wzwg.cmm.word.use" text="use" /></spring:argument>'+
				  '</spring:message>');
			return;
		}
		
        var ajaxUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/custom';
        ajaxUrl += (callGubun != 'M')? '/registBbsBassInfoAjax.do':'/modifyBbsBassInfoAjax.do';
        
        $("#bbsPrface").val(oEditors.getById["bbsPrface"].getIR());
        //$("#bbsCnclsn").val(oEditors.getById["bbsCnclsn"].getIR());
        
        var tmp = oEditors.getById["agreementCn"].getIR();
        tmp = tmp.replace(/[<][^>]*[>]/g, "");
        tmp = $.trim(tmp.replace(/&nbsp;/g, ''));
        //console.log(tmp);
		if(tmp == ''){
	        $("#agreementCn").val('');
		}else{
	        $("#agreementCn").val(oEditors.getById["agreementCn"].getIR());
		}
			
        
        if(callGubun != 'M') {
        	$("#cntntsNm").val($("#bbsNm").val());
        }
        
        if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>')){
            return;
        }else{

			if(!Validator.validate(document.regForm)){
				return;
			}
			 
			var fieldCnt = $('#fieldArea input[name="fieldNm"]').length;
			$('#fieldCnt').val(fieldCnt);
			$("#fieldArea select").removeAttr("disabled"); 
			
			var formData = $("#regForm").serialize();

            $.ajax({
                type : 'POST'
                , url : ajaxUrl
                , dataType: 'xml'
                , data : formData
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
    
    function fnAddField(){
    	var addField = $('#fieldSample').clone().wrapAll("<div/>").html();
    	$('#fieldArea').append(addField);
    	
    	fnFieldSort();
    }
    
    function fnFieldSelect(_sel){
    	var val = $(_sel).val();
    	var p = $(_sel).parent();
    	var selectSpan = p.find('.fldSelVal');
    	
    	if(val == 'select'){
    		selectSpan.css('display' , 'inline-block');
    	}else{
    		selectSpan.css('display' , 'none');
    		selectSpan.find('input[type=text]').val('');
    	}
    	
    	var listat = p.find('select[name=listAt]');
    	if(val == 'contents' || val=='file'){
    		listat.val('N');
    		listat.css('background-color', '#eee');
    		listat.find('option').not(":selected").attr("disabled", "disabled");
    	}else{
    		listat.css('background-color', '#fff');
    		listat.find('option').not(":selected").removeAttr("disabled");
    	}
    	
    	if(val == 'password' ){
    		var fieldNm = p.find('input[name="fieldNm"]');

    		if(fieldNm.val() == ''){
    			fieldNm.val('<spring:message code="wzwg.cmm.word.password" text="password" />');
    		}
    		
    		listat.val('N');
    		listat.css('background-color', '#eee');
    		listat.find('option').not(":selected").attr("disabled", "disabled");
    	}
    	
    	if(val == 'title' ){
    		var fieldNm = p.find('input[name="fieldNm"]');

    		if(fieldNm.val() == ''){
    			fieldNm.val('<spring:message code="wzwg.cmm.word.sj" />');
    		}
    	}
    }
    
    function arrayDuplicateCheck(arr){
    	if(!arr){
	    	//arr = ["11", "11", "33", "44"];
	    	return false;
    	}
    	
    	for (var i = 1; i < arr.length; i++){
    	    /*
    	        i = 1 부터 시작하는 이유
    	        아래의 for문 종료 시점이 j < i 이기 때문에 0 미만은 없으니까!!
    	    */
    	    var useTitle = false;
    	    for (var j = 0; j < i; j++) {
    	        /*
    	            종료시점이 j < i 인 이유
    	            비교값에 자신과 같은 요소를 비교하면 모든값이 중복이 되어버리기 때문에
    	            자신의 값 전까지만 비교하도록 조건을 설정했다!!
    	        */
    	        var arrI = arr[i]; //비교하고 싶은 항목이 있는곳 찾아가기
    	        var arrJ = arr[j]; //비교하고 싶은 항목이 있는곳 찾아가기

    	        if(arrI == arrJ) { //비교항목 텍스트 비교
    	        	return false
    	        } else {
    	        }
    	 		
    	    }
    	}
    	
    	return true
    }
    
    function fnTitleFieldCheck(arr , src){
    	var useTitle = false;
    	for(var i = 0 ; i < arr.length; i++ ){

    		if(useTitle && arr[i] == src){
    			return false;
    		}
    		
    		if(arr[i] == src){
    			useTitle = true;
    		}
    	}//end for
   		return true;
    }
    
    function fnFieldRemove(btn){
    	var fieldDiv = $(btn).parent().parent();
    	if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" text="delete" /></spring:argument></spring:message>')){
	    	fieldDiv.remove();
    	}
    }
    
    function fnFieldSort(){
    	  $('#fieldArea').sortable({
  	    	handle : '.handle', 
  	    	revert:true
  	    });
    }
    
    function noLoginChange(){
    	$('#nolognAt').change(function(){
    		if($(this).is(':checked')){
    			alert('<spring:message code="wzwg.cmm.msg.MSG337"/>');
    			$('#fieldArea').children().each(function(){
    				if($(this).find('select[name="fieldTy"]').val() == 'password'){
    					$(this).remove();
    				}
    			})
    			var addField = $('#fieldPassword').clone().wrapAll("<div/>").html();
    	    	$('#fieldArea').append(addField);
    	    	
    	    	fnFieldSort();
    	    	
    		}else{
    			$('#fieldArea').children().each(function(){
    				if($(this).find('select[name="fieldTy"]').val() == 'password'){
    					$(this).remove();
    				}
    			})
    		}
    	})
    }
</script>
							<div id="fieldSample" style="display:none;">
								<div style="margin-bottom: 10px; vertical-align: middle; position: relative; background: #fff;">
									<input type="hidden" name="fieldId" value="">
                					<input type="hidden" name="fieldSeq" value="">
                					<div class="handle" style="display: inline-block; cursor: n-resize;font-size: 20px; vertical-align: middle; padding: 3px; border: solid 1px #e9e9e9; border-radius: 3px; background: #bbb; color: #fff;"><span>≡</span></div>
	                				<label><spring:message code="wzwg.module.word.iemnm" /> : </label><input name="fieldNm" type="text" style="padding: 4px 5px; font-size: 12px;"/>
    	            				<label style="margin-left: 10px;"><spring:message code="wzwg.cmm.word.ty" text="type" /> : </label>
    	            				<select onchange="fnFieldSelect(this)" name="fieldTy">
    	            					<option value="text"><spring:message code="wzwg.cmm.word.txt" text="text" /></option>
    	            					<option value="title"><spring:message code="wzwg.cmm.word.sj" text="title" /></option>
    	            					<option value="name"><spring:message code="wzwg.cmm.word.nm02" text="name" /></option>
    	            					<option value="tel"><spring:message code="wzwg.cmm.word.telno" text="Telephone Number" /></option>
    	            					<option value="email"><spring:message code="wzwg.cmm.word.email" text="email" /></option>
    	            					<option value="number"><spring:message code="wzwg.cmm.word.number" text="number" /></option>
    	            					<option value="select"><spring:message code="wzwg.module.word.choisety" /></option>
    	            					<option value="contents"><spring:message code="wzwg.module.word.editrcntnts" /></option>
    	            					<option value="image"><spring:message code="wzwg.cmm.word.image" text="image" /></option>
    	            					<option value="file"><spring:message code="wzwg.cmm.word.file" text="file" /></option>
    	            				</select>
    	            				<label style="margin-left: 10px;"><spring:message code="wzwg.module.word.listexposure" /> : </label>
    	            					<select name="listAt">
	    	            					<option value="Y"><spring:message code="wzwg.cmm.word.exposure" text="exposure" /></option>
	    	            					<option value="N"><spring:message code="wzwg.cmm.word.unexposure" text="unexposure" /></option>
	    	            				</select>
    	            				<span class="fldSelVal" style="display:none;"><label><spring:message code="wzwg.module.word.choisetyview" /> : </label><input name="fieldSel" type="text" style="padding: 4px 5px; font-size: 12px;" placeholder="<spring:message code="wzwg.cmm.msg.MSG155" />"></span>
    	            				<span style="float: right; margin-right: 30px;">
    	            				<label><spring:message code="wzwg.module.word.iemuse"/> : </label>
    	            					<select name="useAt">
	    	            					<option value="Y"><spring:message code="wzwg.cmm.word.use" text="use" /></option>
	    	            					<option value="N"><spring:message code="wzwg.cmm.word.unuse" text="unused" /></option>
	    	            				</select>
    	            				</span>
    	            				
    	            				<span style="position: absolute; right:0px;">
    	            					<input class="btn-b" type="button" value="-" style="padding:5px 8px; border-radius:6px; cursor: pointer;" onclick="fnFieldRemove(this)">
    	            				</span>
								</div>
                			</div>
                			
							<div id="fieldPassword" style="display:none;">
								<div style="margin-bottom: 10px; vertical-align: middle; position: relative; background: #fff;">
									<input type="hidden" name="fieldId" value="">
                					<input type="hidden" name="fieldSeq" value="">
                					<div class="handle" style="display: inline-block; cursor: n-resize;font-size: 20px; vertical-align: middle; padding: 3px; border: solid 1px #e9e9e9; border-radius: 3px; background: #bbb; color: #fff;"><span>≡</span></div>
	                				<label><spring:message code="wzwg.module.word.iemnm" /> : </label><input name="fieldNm" type="text" style="padding: 4px 5px; font-size: 12px;" value="<spring:message code="wzwg.cmm.word.password" text="password" />"/>
    	            				<label style="margin-left: 10px;"><spring:message code="wzwg.cmm.word.ty" text="type" /> : </label>
    	            					<select name="fieldTy" disabled="disabled" style="background: #eee;">
	    	            					<option value="password"><spring:message code="wzwg.cmm.word.password" text="password" /></option>
	    	            					<option value="contents"><spring:message code="wzwg.module.word.editrcntnts" /></option>
	    	            				</select>
    	            				<label style="margin-left: 10px;"><spring:message code="wzwg.module.word.listexposure" /> : </label>
    	            					<select name="listAt" disabled="disabled" style="background: #eee;">
	    	            					<option value="N"><spring:message code="wzwg.cmm.word.unexposure" text="unexposure" /></option>
	    	            				</select>
    	            				<span style="float: right; margin-right: 30px;">
    	            				<label><spring:message code="wzwg.module.word.iemuse" /> : </label>
    	            					<select name="useAt" disabled="disabled" style="background: #eee;">
	    	            					<option value="Y"><spring:message code="wzwg.cmm.word.use" text="use" /></option>
	    	            					<option value="N"><spring:message code="wzwg.cmm.word.unuse" text="unused" /></option>
	    	            				</select>
    	            				</span>
    	            				
    	            				<span style="position: absolute; right:0px;">
    	            					
    	            				</span>
								</div>
                			</div>
<!--     	            				<a href="javascript:void(0);" onclick="fnAddField();" class="btn-b" style="padding: 3px 15px; margin-left: 10px; float:right;"><spring:message code="wzwg.cmm.word.delete" /></a> -->
        
        <form:form modelAttribute="resultVO" path="regForm" id="regForm" name="regForm" method="post">
            <form:hidden path="sitecntntsSeq" />
            <form:hidden path="siteSeq" />
            <form:hidden path="bbsSeq" />
            <input type="hidden" name="listScrinCode" id="listScrinCode" value="L"/>
            <input type="hidden" name="fieldCnt" id="fieldCnt" />
            
                    
            <!--기본정보 table// -->
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
                      	<c:set var="cntntsnm">
						    <c:out value='${wzwg.module.word.cntntsnm}' />
						</c:set>
						<form:input path="bbsNm" id="bbsNm" cssClass="w70" dir="required" title="${fn:escapeXml(cntntsnm)}" />
                    </td>
                </tr>
                <tr>
                	<th><spring:message code="wzwg.module.word.iemestbs" /></th>
                	<td colspan="3">
                		<div id="fieldArea">
                			<c:forEach items="${fieldList }" var="list">
                				<div style="margin-bottom: 10px; vertical-align: middle; position: relative; background: #fff;">
	                				<input type="hidden" name="fieldId" value="<c:out value='${list.fieldId }'/>">
	                				<input type="hidden" name="fieldSeq" value="<c:out value='${list.fieldSeq }'/>">
	                				<div class="handle" style="display: inline-block; cursor: n-resize;font-size: 20px; vertical-align: middle; padding: 3px; border: solid 1px #e9e9e9; border-radius: 3px; background: #bbb; color: #fff;"><span>≡</span></div>
	                				<label><spring:message code="wzwg.module.word.iemnm"/> : </label><input name="fieldNm" type="text" style="padding: 4px 5px; font-size: 12px;" value="<c:out value='${list.fieldNm }'/>"/>
    	            				<label style="margin-left: 10px;"><spring:message code="wzwg.cmm.word.ty" text="type" /> : </label>
    	            				<select onchange="fnFieldSelect(this)" name="fieldTy" <c:if test="${list.fieldTy eq 'password'}">disabled="disabled" style="background: #eee;"</c:if>>
    	            					<option value="title"	  <c:if test="${list.fieldTy eq 'title'}">selected="selected"</c:if>	><spring:message code="wzwg.cmm.word.sj" text="title" /></option>
    	            					<option value="text"	  <c:if test="${list.fieldTy eq 'text'}">selected="selected"</c:if>		><spring:message code="wzwg.cmm.word.txt" text="text" /></option>
    	            					<option value="name"	  <c:if test="${list.fieldTy eq 'name'}">selected="selected"</c:if>		><spring:message code="wzwg.cmm.word.nm02" text="name" /></option>
    	            					<option value="tel"		  <c:if test="${list.fieldTy eq 'tel'}">selected="selected"</c:if>		><spring:message code="wzwg.cmm.word.telno" text="Telephone Number" /></option>
    	            					<option value="email"	  <c:if test="${list.fieldTy eq 'email'}">selected="selected"</c:if>	><spring:message code="wzwg.cmm.word.email" text="email" /></option>
    	            					<option value="number"	  <c:if test="${list.fieldTy eq 'number'}">selected="selected"</c:if>	><spring:message code="wzwg.cmm.word.number" text="number" /></option>
    	            					<option value="select"	  <c:if test="${list.fieldTy eq 'select'}">selected="selected"</c:if>	><spring:message code="wzwg.module.word.choisety" /></option>
    	            					<option value="contents"  <c:if test="${list.fieldTy eq 'contents'}">selected="selected"</c:if>	><spring:message code="wzwg.module.word.editrcntnts"/></option>
    	            					<option value="image"	  <c:if test="${list.fieldTy eq 'image'}">selected="selected"</c:if>	><spring:message code="wzwg.cmm.word.image" text="image" /></option>
    	            					<option value="file"	  <c:if test="${list.fieldTy eq 'file'}">selected="selected"</c:if>		><spring:message code="wzwg.cmm.word.file" text="file" /></option>
    	            					
    	            					<c:if test="${list.fieldTy eq 'password'}">
    	            						<option value="password"  selected="selected"><spring:message code="wzwg.cmm.word.password" text="password" /></option>
    	            					</c:if>
    	            				</select>
    	            				<label style="margin-left: 10px;"><spring:message code="wzwg.module.word.listexposure" /> : </label>
    	            					<select name="listAt" <c:if test="${list.fieldTy eq 'password'}">disabled="disabled" style="background: #eee;"</c:if>>
	    	            					<option value="Y" 	<c:if test="${list.listAt eq 'Y'}">selected="selected"</c:if>  ><spring:message code="wzwg.cmm.word.exposure" text="exposure" /></option>
	    	            					<option value="N"	<c:if test="${list.listAt eq 'N'}">selected="selected"</c:if>  ><spring:message code="wzwg.cmm.word.unexposure" text="unexposure" /></option>
	    	            				</select>
	    	            			<c:if test="${not empty list.fieldSel }">
	    	            				<span class="fldSelVal" ><label><spring:message code="wzwg.module.word.choisetyview" /> : </label><input name="fieldSel" type="text" style="padding: 4px 5px; font-size: 12px;" placeholder="<spring:message code="wzwg.cmm.msg.MSG155" />" value="<c:out value='${list.fieldSel }'/>"></span>
	    	            			</c:if>
	    	            			<c:if test="${empty list.fieldSel }">
	    	            				<span class="fldSelVal" style="display:none;"><label><spring:message code="wzwg.module.word.choisetyview" /> : </label><input name="fieldSel" type="text" style="padding: 4px 5px; font-size: 12px;" placeholder="<spring:message code="wzwg.cmm.msg.MSG155" />"></span>
	    	            			</c:if>

    	            				<span style="float: right; margin-right: 30px;">
    	            				<label><spring:message code="wzwg.module.word.iemuse" /> : </label>
    	            					<select name="useAt" <c:if test="${list.fieldTy eq 'password'}">disabled="disabled" style="background: #eee;"</c:if>>
	    	            					<option value="Y"	<c:if test="${list.useAt eq 'Y'}">selected="selected"</c:if>  ><spring:message code="wzwg.cmm.word.use" text="use" /></option>
	    	            					<option value="N"	<c:if test="${list.useAt eq 'N'}">selected="selected"</c:if>  ><spring:message code="wzwg.cmm.word.unuse" text="unused" /></option>
	    	            				</select>
    	            				</span>

								</div>
                			</c:forEach>
                		</div>
                		
                		<div style="margin-top: 5px; padding-top: 10px; border-top: 1px solid #e9e9e9;">
	                		<div><a href="javascript:void(0);" onclick="fnAddField();" class="wzbtn-table btn-black-bg"><spring:message code="wzwg.module.word.iemadd" /></a></div>
	                		<p class="admpg-subp w100 fl mt10">
				              <span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.MSG154" />
				             <span class="wz_tableguide mt5 pl15"><spring:message code="wzwg.cmm.msg.tip.MSG048"/></span></p>
                		</div>
                	</td>
                </tr>
                <tr>
                    <th><spring:message code="wzwg.module.word.emplyrscreenty" /></th> 
                    <td colspan="3">
                        <ul class="wzForm">
	                        <li><input type="radio" id="usrScrinTyL" name="usrScrinTy" value="L" dir="required" <c:if test="${funcVO.usrScrinTy eq 'L' or funcVO.usrScrinTy eq null}">checked="true"</c:if> /><label for="usrScrinTyL"><spring:message code="wzwg.cmm.word.list" /></label></li>
	                        <li><input type="radio" id="usrScrinTyW" name="usrScrinTy" value="W" dir="required" <c:if test="${funcVO.usrScrinTy eq 'W'}">checked="true"</c:if> /><label for="usrScrinTyW"><spring:message code="wzwg.cmm.word.regist" /></label></li>
                        </ul>
                        <span class="wz_tableguide wd100 fl">
    						<strong><spring:message code="wzwg.cmm.word.list"/></strong> : <spring:message code="wzwg.cmm.msg.tip.MSG051"/><br>
    						<strong><spring:message code="wzwg.cmm.word.regist"/></strong> : <spring:message code="wzwg.cmm.msg.tip.MSG052"/>
						</span>
                    </td>
                </tr>
                <tr>
                    <th><spring:message code="wzwg.module.word.skllestbs"/>(<spring:message code="wzwg.cmm.word.optn" text="option" />)</th> 
                    <td colspan="3">
                        <ul class="wzForm">
	                        <li style="width:100%;">
	                        	<input type="checkbox" id="nolognAt" name="nolognAt" value="Y" dir="required" <c:if test="${funcVO.nolognAt eq 'Y'}">checked="checked"</c:if>/><label for="nolognAt"><spring:message code="wzwg.cmm.msg.MSG239" /></label>
	                        	<p class="admpg-subp w100 fl">
                					<span class="circle_no bg-green-strong ml0">i</span>
                						<spring:message code="wzwg.cmm.msg.tip.MSG049"/>
                   					<span class="wz_tableguide mt5 pl15"><spring:message code="wzwg.cmm.msg.tip.MSG050"/></span>
      							</p>
	                        </li>
                        </ul>
                    </td>
                </tr>
                
                <tr>
                    <th><spring:message code="wzwg.module.word.postsno"/></th> 
                    <td colspan="3">
                        <ul class="wzForm">
	                        <li><input type="radio" id="listNumCodeA" name="listNumCode" value="N" dir="required" <c:if test="${resultVO.listNumCode eq 'N'}">checked="true"</c:if> /><label for="listNumCodeA"><spring:message code="wzwg.module.word.nttno" /></label></li>
	                        <li><input type="radio" id="listNumCodeB" name="listNumCode" value="P" dir="required" <c:if test="${resultVO.listNumCode eq 'P' or resultVO.listNumCode eq null}">checked="true"</c:if> /><label for="listNumCodeB"><spring:message code="wzwg.module.word.pageno" /></label></li>
                        </ul>
                        <span class="wz_tableguide mt10 clboth">
                            <b><spring:message code="wzwg.module.word.nttno" /></b> : <spring:message code="wzwg.cmm.msg.tip.MSG107"/><br>
                            <b><spring:message code="wzwg.module.word.pageno" /></b> : <spring:message code="wzwg.cmm.msg.tip.MSG108"/>
                        </span>
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
									<li><input type="checkbox" id="expsrAtNo" name="expsrAt" value="N" dir="required" /><label for="expsrAtNo"   ><spring:message code="wzwg.cmm.word.no"/></label></li>
									<li><input type="checkbox" id="expsrAtWrtr" name="expsrAt" value="W" dir="required" /><label for="expsrAtWrtr" ><spring:message code="wzwg.cmm.word.wrter"/></label></li>
									<li><input type="checkbox" id="expsrAtRgsd" name="expsrAt" value="R" dir="required" /><label for="expsrAtRgsd" ><spring:message code="wzwg.cmm.word.rgsde02"/></label></li>
									<li><input type="checkbox" id="expsrAtIngr" name="expsrAt" value="I" dir="required" /><label for="expsrAtIngr" ><spring:message code="wzwg.cmm.word.inqire"/></label></li>
								</c:when>
								<c:otherwise>
									<li><input type="checkbox" id="expsrAtNo"   name="expsrAt" value="N" dir="required" checked/><label for="expsrAtNo"  ><spring:message code="wzwg.cmm.word.no"/></label></li>
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

                
               <%--  <tr>
                    <th><spring:message code="wzwg.cmm.word.bbs" text="bbs" /> <spring:message code="wzwg.cmm.word.form" text="form" /></th>
                    <td colspan="3">
                        <form:select path="formSeq" id="formSeq" cssClass="w40">
                            <form:option value=""><label for="unuse"><spring:message code="wzwg.cmm.word.unuse" text="unuse" /></label></form:option>
                            <c:if test="${!empty formList}">
                                <c:forEach var="formList" items="${formList}" varStatus="status">
                                    <form:option value="${formList.formSeq}" label="${formList.formSj}" />
                                </c:forEach>
                            </c:if>
                        </form:select>
                    </td>
                </tr> --%>
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
                              <img src="/images/wzwg/site/mngr/helpimg_unityboard03.jpg">
                            </div>
                        </div>                     
                    </th> 
                    <td colspan="3">
                        <ul>
	                        <li><input type="radio" id="scrapAtA" name="scrapAt" value="Y" dir="required" <c:if test="${resultVO.scrapAt eq 'Y'}">checked="true"</c:if> /><spring:message code="wzwg.cmm.word.use" /></li>
	                        <li><input type="radio" id="scrapAtB" name="scrapAt" value="N" dir="required" <c:if test="${resultVO.scrapAt eq 'N' or resultVO.scrapAt eq null}">checked="true"</c:if> /><spring:message code="wzwg.cmm.word.unuse" /></li>
                        </ul>
                        <span class="wz_tableguide wd100 fl">
    						<spring:message code="wzwg.cmm.msg.tip.MSG053"/>
						</span>
                    </td>
                </tr> --%>
                
                 <tr>
                    <th><spring:message code="wzwg.module.word.chargeremail" /></th>
                    <td colspan="3">
                        <form:input path="reciveEmail" id="reciveEmail" cssClass="w70"  title="reciveEmail" />
                    </td>
                </tr>
                <tr>
                    <th><spring:message code="wzwg.module.word.stplatregist" />(<spring:message code="wzwg.cmm.word.optn" text="option" />)</th>
                    <td colspan="3">
                    	<div style="margin-bottom: 10px;">※ <spring:message code="wzwg.cmm.msg.MSG156" /></div>
                        <textarea name="agreementCn" id="agreementCn" rows="10" style="width:100%;"><c:out value='${funcVO.agreementCn}'/></textarea>
			
						<script type="text/javascript">
							nhn.husky.EZCreator.createInIFrame({
								oAppRef: oEditors,
								elPlaceHolder: "agreementCn",
								sSkinURI: "<c:out value='${wzwg_contextPath}'/>/smartEditor2.8.2.1/smartEditor2Skin.do",
								fCreator: "createSEditor2",
								htParams: {fOnBeforeUnload : function(){},aAdditionalFontList : [['NanumSquareR', 'NanumSquareR']]}
							}); 
						</script>                        
                    </td>
                </tr>
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
                    <th><spring:message code="wzwg.cmm.word.ctgry02" text="category" /></th>
                    <td colspan="3">
                        <input type="hidden" id="subospecSj" name="subospecSj" />
                        
                        <input type="text" id="addSubospecSj" name="addSubospecSj" class="w70" />
                        <a href="javascript:void(0);" id="subospec_add_btn" class="wzbtn-table btn-basic"><spring:message code="wzwg.cmm.word.add" text="add" /></a>
                        
                        <div id="subospecList" class="mt10">
                            <c:import url="${wzwg_contextPath}${prefix}/module/bbs/cmmn/selectBbsSubospecListAjax.do" charEncoding="utf-8">
                                <c:param name="param_bbsSeq" value="${resultVO.bbsSeq}" />
                            </c:import>
                        </div>   
                    </td>
                </tr> 
                </c:if>  
                             
            </tbody>
            </table>
            <!--//기본정보 table -->
            
        </form:form>
                
        <div class="rt-box"> 
            <a href="javascript:void(0);" id="regist_btn" onclick="fnRegist('M');" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" text="stre" /></a>
            <a href="javascript:void(0);" id="reset_btn" onclick="fnReset_btn();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" text="list" /></a>
        </div>
