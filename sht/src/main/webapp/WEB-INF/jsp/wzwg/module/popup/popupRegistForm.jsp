<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<link href="/css/wzwg/cmm/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/js/wzwg/cmm/common.js" ></script>
<script language="javascript" type="text/javascript" src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>
<script language="javascript" type="text/javascript" src="/jquery/js/jquery.form.min.js"></script>


<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js"></script>

	<script type="text/javascript">
	    $(document).ready(function(){
	        $(".datePicker").datepicker({ 		
	   	     dateFormat: 'yy-mm-dd',
	   	     monthNamesShort: ['1<spring:message code="wzwg.cmm.word.mt" />','2<spring:message code="wzwg.cmm.word.mt" />','3<spring:message code="wzwg.cmm.word.mt" />','4<spring:message code="wzwg.cmm.word.mt" />','5<spring:message code="wzwg.cmm.word.mt" />','6<spring:message code="wzwg.cmm.word.mt" />','7<spring:message code="wzwg.cmm.word.mt" />','8<spring:message code="wzwg.cmm.word.mt" />','9<spring:message code="wzwg.cmm.word.mt" />','10<spring:message code="wzwg.cmm.word.mt" />','11<spring:message code="wzwg.cmm.word.mt" />','12<spring:message code="wzwg.cmm.word.mt" />'],
	   	     dayNamesMin: ['<spring:message code="wzwg.cmm.word.sun01" />','<spring:message code="wzwg.cmm.word.mon01" />','<spring:message code="wzwg.cmm.word.tue01" />','<spring:message code="wzwg.cmm.word.wed01" />','<spring:message code="wzwg.cmm.word.thu01" />','<spring:message code="wzwg.cmm.word.fri01" />','<spring:message code="wzwg.cmm.word.sat01" />'],
	   	     weekHeader: 'Wk',
	   	     changeMonth: true, 	//월변경가능
	   	     changeYear: true, 	//년변경가능
	   	     yearRange:'-10:+10', 	// 연도 셀렉트 박스 범위(현재와 같으면 1988~현재년)
	   	     showMonthAfterYear: true, 	//년 뒤에 월 표시
	   	     buttonImageOnly: false, //이미지표시  
	   	     buttonText: '<spring:message code="wzwg.cmm.msg.MSG088" />', 
	   	     autoSize: false	 //오토리사이즈(body등 상위태그의 설정에 따른다)
	   	  	});
	        
	        fn_popupTyChange("SC00000413");
	        $('#popupForm input').not('[type="hidden"]').first()
	        
	        /* 팝업존 노출 설정값은 기본설정 불가 */
	        $('input[name="positionAt"]').prop('disabled', true);
	        
	    });

		/** 팝업 위치 자동지정, 직접지정 설정 */
// 		function fn_positionAtChange(paramValue){
// 			if(paramValue != 'Y'){
// 				$("input[name=xPosition]").attr("disabled","disabled");
// 				$("input[name=yPosition]").attr("disabled","disabled");
// 				$("input[name=xPosition]").val("");
// 				$("input[name=yPosition]").val("");
// 			}else{
// 				$("input[name=xPosition]").removeAttr("disabled");
// 				$("input[name=yPosition]").removeAttr("disabled");
// 			}
// 		}
		
		/** 이미지링크 연결여부 설정 (이미지타입에서만 사용) */
		function fn_imgLinkUseAtChange(paramValue){
			if(paramValue != 'Y'){
				$("input[name=linkUrl]").attr("disabled","disabled");
				$("select[name=linkTargetSe]").attr("disabled","disabled");
				$("input[name=linkUrl]").val("");
				$("select[name=linkTargetSe]").val("");
			}else{
				$("input[name=linkUrl]").removeAttr("disabled");
				$("input[name=linkUrl]").val("");
				$("select[name=linkTargetSe]").removeAttr("disabled");
			}
		}

        function fnChangeMlsfcGroup(upperGrpSeq) {
            if(upperGrpSeq != ""){
                
                $.ajax({
                    type : 'POST'
                  , dataType: 'xml'
                  , contentType : 'application/x-www-form-urlencoded; charset=UTF-8'
                  , url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/siteMngr/siteGroup/selectSiteGroupMlsfcAjax.do'
                  , cache : false
                  , async : false
                  , data:{'odr':2, 'upperGrpSeq':upperGrpSeq}
                  , success : function(xml, status, request) {
                      
                      $("#siteMlsfcGroup").find("option").remove().end().append("option value=\"\">::<spring:message code="wzwg.cmm.word.all" />::</option>");
                      $("#siteMlsfcGroup").append("<option value=\"\">::<spring:message code="wzwg.cmm.word.all" />::</option>");
                      $(xml).find("item").each(function(){
                          var sitegrpSeq = $(this).find('name').text();
                          var groupNm = $(this).find('value').text();
                          if(sitegrpSeq == '<c:out value="${resultVO.mlsfcCode}" />'){
                              $("#siteMlsfcGroup").append("<option value=\"" +sitegrpSeq+ "\" selected >" + groupNm + "</option>");                      
                          }else{
                              $("#siteMlsfcGroup").append("<option value=\"" +sitegrpSeq+ "\">" + groupNm + "</option>");
                          }
                      });
                      
                  }
                  , error:function (data) {
                      alert('<spring:message code="fail.common.msg" text="error" />');
                  }
              });

            }else{
                $("#siteMlsfcGroup").empty();
                $("#siteMlsfcGroup").append('<option value="">::<spring:message code="wzwg.cmm.word.all" />::</option>');
            }
        }
		
		/** 팝업 등록 */
	    function fn_regist(){

			/** 팝업 타입별 validate, 에디터 데이터 입력 */
			if($(":input:radio[name=popupTyCode]:checked").val() == "SC00000414"){
				oEditors.getById["popupCn"].exec("UPDATE_CONTENTS_FIELD", []);
				
			}else{ 
				
				if($(":input:radio[name=imgLinkuseAt]:checked").val() == 'Y'){
					if($("input[name=linkUrl]").val() == ""){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG020">'+
								'<spring:argument><spring:message code="wzwg.cmm.word.link" /></spring:argument>'+
								'<spring:argument><spring:message code="wzwg.module.word.requinputiem" /></spring:argument>'+
							  '</spring:message>');
						$("input[name=linkUrl]").focus();
						return ;
					}
					if($("input[name=linkTargetSe]").val() == ""){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG020">'+
								'<spring:argument><spring:message code="wzwg.module.word.newwinnowwinat" /></spring:argument>'+
								'<spring:argument><spring:message code="wzwg.module.word.requinputiem" /></spring:argument>'+
							  '</spring:message>');
						$("input[name=linkTargetSe]").focus();
						return ;
					}
				}

				/** 이미지파일 확장자 체크 */
				var atchFile = document.getElementById('atchFile');
			    if(typeof atchFile != "undefind" && atchFile != null) {
			    	atchFile = atchFile.value;
			        
			        atchFile = atchFile.slice(atchFile.lastIndexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로 만듭니다.
			        
			        if(atchFile != "jpg" && atchFile != "png" && atchFile != "gif"){ //확장자를 확인합니다.
			            alert('<spring:message code="wzwg.cmm.msg.MSG126" />');
			        	$("#btn_atchFile").focus();
			            return;
			        }
			    }

			}

			/** 파일확장자 체크 */
			var thumbFile = document.getElementById('thumbFile');
			/* 기본아이콘 필수값에서 제거 되도록 변경 20200513 */
			if($('#thumbFile').val() != ''){
				//console.log('대체 텍스트 체크');
				$('#thumbReplcText').attr('dir', 'required,vmaxlen=50');
			}else{
				//console.log('대체 텍스트 체크 해제');
				$('#thumbReplcText').attr('dir', '');
			}
			if($('#thumbFile').val() != ''){
			    if(typeof thumbFile != "undefind" && thumbFile != null) {
			    	thumbFile = thumbFile.value;
			    	
			        thumbFile = thumbFile.slice(thumbFile.lastIndexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로 만듭니다.
	
			        if(thumbFile != "jpg" && thumbFile != "png" && thumbFile != "gif"){ //확장자를 확인합니다.
			            alert('<spring:message code="wzwg.cmm.msg.MSG126" />');
			        	$("#btn_thumbFile").focus();
			            return;
			        }
			    }
			    /*
			    if($('#thumbReplcText').val() == ''){
			    	alert('<spring:message code="errors.required" ><spring:message code="wzwg.cmm.word.thumb" /> <spring:message code="wzwg.cmm.word.replc" /> <spring:message code="wzwg.cmm.word.txt" /></spring:message>');
		        	$("#thumbReplcText").focus();
		            return;
			    }
				*/
			}
			
			
			if($("input[name=startDt]").val() == ''){
    			alert('<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument><spring:message code="wzwg.cmm.word.bgnde" /></spring:argument></spring:message>');
				$('input[name=startDt]').focus();
				return;
			}
			
			if($("input[name=endDt]").val() == ''){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument><spring:message code="wzwg.cmm.word.endde" /></spring:argument></spring:message>');
				$('input[name=endDt]').focus();
				return;
			}
		    
		    if($("input[name=startDt]").val() == $("input[name=endDt]").val()){
		    	if($("select[name=startTime]").val() > $("select[name=endTime]").val()){
		    		alert("<spring:message code="wzwg.cmm.word.popup" /> <spring:message code="wzwg.cmm.msg.MSG125" />");
		    		$("select[name=startTime]").focus();
		    		return;
		    	}
		    }

			if(!Validator.validate(document.popupForm)){
				return;
			}
			 
	 		var frm = $("#popupForm");
	 		
			frm.ajaxSubmit({
				type:'POST'
				, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/popup/registModulePopupAjax.do'
				, async: false
		        , data: frm 
		        , mimeType: 'multipart/form-data'
				, success:function(result){
					$(result).find('value').each(function(){
						if($(this).text() == "success"){
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
							fn_list();
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
						}
					});
				}
				, error:function (request, status, error) {
		              alert('<spring:message code="fail.common.msg" text="error" />');
		          }
				, dataType: 'xml'
			    , beforeSend:fnLoadingOpen
			    , complete:fnLayerPopupClose
			});
			
 	    }
	    	    
		/** 팝업 리스트로 이동 */
	    function fn_list(){
	    	document.popupForm.action='<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/popup/selectModulePopupList.do';
	    	document.popupForm.submit();
	    }
	    
		/** 팝업 타입 변경 (이미지, 템플릿, 직접입력같은 타입 변경) */
	    function fn_popupTyChange(paramValue){
	    	$('#popupTyDiv').empty();
	    	
	    	if (paramValue != 'SC00000415') {
                $('.divNotice').removeAttr("disabled");

//                 var positionAt = $('input[name=positionAt]').val();
//                 if (positionAt == 'N') {
//                     $("input[name=xPosition]").attr("disabled","disabled");
//                     $("input[name=yPosition]").attr("disabled","disabled");
//                 }
                
                
                $.ajax({
                      type:'POST'
                    , url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/popup/selectPopupTyChangeAjax.do'
                    , data:{'popupTyCode':paramValue} 
                    , success:function (data) {
                            $('#popupTyDiv').html(data);
                            
//                             if(paramValue == 'SC00000413'){
//                                 $("input[name=width]").attr("disabled","disabled");
//                                 $("input[name=height]").attr("disabled","disabled");
//                                 $("input[name=width]").val("");
//                                 $("input[name=height]").val("");
//                             }else{
//                                 $("input[name=width]").removeAttr("disabled");
//                                 $("input[name=height]").removeAttr("disabled");
//                             }
                          }
                    , dataType: 'html'
                });
	    	} else {
	    	    $('.divNotice').attr("disabled","disabled");
	    	}

	    }
		
        function fnLoadingOpen(){
            var popupContent = $('#apply_pop').html();
            $("#divLayerPopup").html(popupContent);
            $("#divLayerPopup").show();
        }

        function fnLayerPopupClose() {
            $("#divLayerPopup").hide();
            $("#divLayerPopup").empty();
            $('body').css({overflow:'auto'});
        }
		
        function fnThumbCheck(){
        	//console.log('fnThumbCheck');
        	if($('#thumbFile').val() == ''){
        		$('#thumbFile_preview').attr('src', '/images/wzwg/site/mngr/no-img.png');
        	}
        }
        
        function fnAtchFileCheck(){
        	//console.log('fnThumbCheck');
        	if($('#thumbFile').val() == ''){
        		$('#atchFile_preview').attr('src', '/images/wzwg/site/mngr/no-img.png');
        	}
        }
        
        function fnCheckMainUse(check){
        	console.log($(check).val());
        	if($(check).val() == 'N'){
        		$('input[name="positionAt"]').filter('[value="Y"]').prop('checked', true)
        		$('input[name="positionAt"]').prop('disabled', true);
        	}else{
        		$('input[name="positionAt"]').prop('disabled', false);
        	}
        }
	</script>
	
	<form id="popupForm" name="popupForm" method="post" enctype="multipart/form-data">
	
	<div class="wz_notice brbox bg-white br-blue-strong" style="overflow: visible;">	
			<ul class="wd100">
				<li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.popupTopGuide01" /></li>
				<li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.popupTopGuide02" /></li>
				<li class="admpg-subp wd100 wzAdmSTit p0 mb0" style="background: transparent;">· <spring:message code="wzwg.module.word.exposurelcguidance" />
				<div class="menu_help">
					<img src="/images/wzwg/site/mngr/ico_help_grey.png" alt="">
					<div class="help_pop" style="width:50vw; max-width:900px;">
					     <img src="/images/wzwg/site/mngr/helpimg_popupzone.jpg" class="mxwd100" alt="<spring:message code="wzwg.module.word.exposurelcguidance" />">
				    </div>
				</div>
				</li>	
			</ul>
	</div>
		
		
	<table class="basic">
			<colgroup>
				<col width="20%" />
				<col width="80%" />
			</colgroup>
		  <tbody>
		  	<tr>
		  		<th colspan="2" class="wzAdmSTit"><spring:message code="wzwg.module.word.bassestbs" /></th>
		  	</tr> <!-- 2019.04.18 신규 추가 tr-->
		  	<c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
            <tr>
                <th><spring:message code="wzwg.cmm.word.se" /></th>
                <td colspan="3">
                    <select id="siteLclasGroup" name="lcalsCode" onchange="fnChangeMlsfcGroup(this.value);" >
                        <option value="">::<spring:message code="wzwg.cmm.word.all" />::</option>
                        <c:forEach var="result" items="${siteLclasGroupList}">
                            <option value="<c:out value="${result.sitegrpSeq}" />"><c:out value="${result.groupNm}" /></option>
                        </c:forEach>
                    </select>
                    
                    <select id="siteMlsfcGroup" name="mlsfcCode">
                        <option value="">::<spring:message code="wzwg.cmm.word.all" />::</option>
                    </select>      
                </td>
            </tr>
			</c:if>
			
			<tr>
				<th><spring:message code="wzwg.module.word.popupty" /></th>
				<td colspan="3">
					<ul class="wzForm popupRadio">
						<c:forEach items="${codeList }" var="codeList" varStatus="status">
							<li class="bbs-tySel popup_<c:out value="${codeList.code }" />">
								<div class="guideTxt">
									<div class="type01">
										<b>① <spring:message code="wzwg.cmm.msg.lypopupType" /></b><span><spring:message code="wzwg.cmm.msg.lypopupTypeInfo" /></span>
									</div>
									<div class="type02">
										<b>② <spring:message code="wzwg.cmm.msg.toppopupType" /></b><span><spring:message code="wzwg.cmm.msg.toppopupTypeInfo" /></span>
									</div>
								</div>
								
							    <input type="radio" name="popupTyCode" value="<c:out value="${codeList.code }" />" id="<c:out value="${codeList.code }" />" onchange="fn_popupTyChange(this.value);" dir="required" title="<spring:message code="wzwg.cmm.word.popup" />" <c:if test="${status.first}">checked="checked"</c:if>>
							    <label for="<c:out value="${codeList.code }" />" title="<spring:message code="wzwg.cmm.word.popup" />">
							     	<img src="/images/wzwg/module/popup/<c:out value="${codeList.code }" />.png"><br>
							     	<c:out value="${codeList.codeNm }" /><br>
							     	<span class="wz_tableguide">
							     		<c:if test="${codeList.code eq 'SC00000413' }"><spring:message code="wzwg.cmm.msg.MSG444" /></c:if>
							     		<c:if test="${codeList.code eq 'SC00000414' }"><spring:message code="wzwg.cmm.msg.MSG445" /></c:if>
							     		<%-- <c:out value="${codeList.codeDc}" /> --%>
							     	</span>
							    </label>
							    
							</li>
						</c:forEach>
					</ul>
					<!-- 2019.04.18 신규 추가 start
					<p class="admpg-subp w100 fl mt20">
					<span class="circle_no bg-green-strong">i</span>
					    <spring:message code="wzwg.cmm.msg.MSG348" />
					    
					<span class="wz_tableguide mt5 pl15">- <spring:message code="wzwg.cmm.msg.MSG349" /> </span>
					</p>
					2019.04.18 신규 추가 end-->
				</td>
			</tr>
			
			
			<tr>
				<th><spring:message code="wzwg.module.word.popuppd" />
					<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
					</span>
				</th>
				<td colspan="3">
				
					<c:set var="msg_txt01">
						<spring:message code="wzwg.cmm.cmmMsg.CMG011">
							<spring:argument><spring:message code="wzwg.cmm.word.bgnde" /></spring:argument>
							<spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument>
						</spring:message>
					</c:set>
					
					<c:set var="msg_txt02">
						<spring:message code="wzwg.cmm.cmmMsg.CMG011">
							<spring:argument><spring:message code="wzwg.cmm.word.endde" /></spring:argument>
							<spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument>
						</spring:message>
					</c:set>
					
					<input type="text" class="datePicker cal" style="width:150px;" readonly="readonly" name="startDt" dir="required,vdateFt=startDt:endDt" title="<spring:message code="wzwg.cmm.word.bgnde" />" placeholder="<c:out value="${msg_txt01}" />"/>
					<select name="startTime"  dir="required,vnum" title="<spring:message code="wzwg.module.word.begintimese" />">
						<c:forEach begin="0" end="23" varStatus="status">
							<fmt:formatNumber var="sHour" minIntegerDigits="2" value="${status.index }"/>
							<option value="<c:out value="${sHour}" />"><c:out value="${sHour}" /> <spring:message code="wzwg.cmm.word.hour" /></option>
						</c:forEach>
					</select>
					~
					<input type="text" class="datePicker cal" style="width:150px;" readonly="readonly" name="endDt" dir="required,vdate" title="<spring:message code="wzwg.cmm.word.endde" />" placeholder="<c:out value="${msg_txt02}" />"/>
					<select name="endTime" dir="required,vnum" title="<spring:message code="wzwg.module.word.endtimese" />">
						<c:forEach begin="0" end="23" varStatus="status">
							<fmt:formatNumber var="sHour" minIntegerDigits="2" value="${status.index }"/>
							<option value="<c:out value="${sHour}" />"><c:out value="${sHour}" /> <spring:message code="wzwg.cmm.word.hour" /></option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.module.word.popupsortordr" />
					<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
					</span>
				</th>
				<td colspan="3">
					<input type="text" class="w10" name="mainSortOrdr" dir="required,vnum,vmaxlen=2" maxlength="2" title="<spring:message code="wzwg.module.word.sortordr" />"/> 
					<span class="wz_tableguide mt5">
					<spring:message code="wzwg.cmm.msg.MSG113" />
					<c:choose>
						<c:when test="${sessionScope.SYSMNGR_AT eq 'Y'}">(0 ~ 99)</c:when>
						<c:otherwise>(1 ~ 99)</c:otherwise>
					</c:choose>
					</span><!-- 2019.04.18 -->
				</td>
			</tr>
            
			<tr>
				<th><spring:message code="wzwg.module.word.useat" /></th>
				<td colspan="3">
					<ul class="wzForm">
						<li>
							<input type="radio" name="noticeAt" value="Y" dir="required" title="<spring:message code="wzwg.module.word.useat" />" id="noticeAtY" checked="checked">
							<label for="noticeAtY"><spring:message code="wzwg.cmm.word.use" /></label>
						</li>
						<li>
							<input type="radio" name="noticeAt" value="N" dir="required" title="<spring:message code="wzwg.module.word.useat" />" id="noticeAtN">
							<label for="noticeAtN"><spring:message code="wzwg.cmm.word.unuse" /></label>
						</li>
					</ul>
				</td>
			</tr>
			
			<!-- 2017.11.28 신규 추가 Start -->
			<tr class="divNotice">
				<th><spring:message code="wzwg.cmm.msg.lypopupUse" /> </th>
				<td colspan="3">
					<ul class="w100 fl wzForm">
						<li class="wd100">
							<input type="radio" class="divNotice" name="exposureAt" value="Y" id="exposureAtY" dir="required" title="<spring:message code="wzwg.module.word.useat" />" onclick="fnCheckMainUse(this)">
							<label for="exposureAtY"><spring:message code="wzwg.cmm.word.atmc" /> (<spring:message code="wzwg.cmm.msg.popupTypeselect01" />)</label>
						</li>
						<li class="wd100">
							<input type="radio" class="divNotice" name="exposureAt" value="N" id="exposureAtN" dir="required" title="<spring:message code="wzwg.module.word.useat" />" onclick="fnCheckMainUse(this)" checked>
							<label for="exposureAtN"><spring:message code="wzwg.cmm.word.manual" /> (<spring:message code="wzwg.cmm.msg.popupTypeselect02" />)</label>
						</li>
					</ul>
					<!-- <span class="wz_tableguide fl mt5"><spring:message code="wzwg.cmm.msg.MSG347" /> </span> -->
				</td>
			</tr>
			<!-- 2017.11.28 신규 추가 End -->
			
			<!-- 2020.05.13 신규 추가 Start -->
			<tr class="divNotice">
				<th><spring:message code="wzwg.cmm.msg.toppopupUse" /> </th>
				<td colspan="3">
					<ul class="w100 fl wzForm">
						<li class="wd100">
							<input type="radio" class="divNotice" name="positionAt" value="Y" id="positionAtY" dir="required" title="<spring:message code="wzwg.module.word.exposureat" />" checked disabled="disabled">
							<label for="positionAtY"><spring:message code="wzwg.cmm.word.exposure" /></label>
						</li>
						<li class="wd100">
							<input type="radio" class="divNotice" name="positionAt" value="N" id="positionAtN" dir="required" title="<spring:message code="wzwg.module.word.exposureat" />" disabled="disabled">
							<label for="positionAtN"><spring:message code="wzwg.cmm.word.unexposure" /> (<spring:message code="wzwg.cmm.msg.popupTypeselect03" />)</label>
						</li>
					</ul>
					<!-- <span class="wz_tableguide fl mt5"><spring:message code="wzwg.cmm.msg.MSG387" /> </span> -->
				</td>
			</tr>
			<!-- 2020.05.13 신규 추가 End -->
			
			
			
			
			
			
			
			
			
			
			<!-- 2019.04.18 변경 이하 가상 두번째 테이블 -->
			<!-- <tr><th colspan="2" style="background: #f7f7f7; padding:10px;"> </th></tr> -->         <!-- 2019.04.18 신규 추가 tr-->
  			<tr>
  				<th colspan="2" class="wzAdmSTit">
  					<spring:message code="wzwg.module.word.upendpopupznestbs" />
				 <div class="wzmsg-help">
		              <div class="wzmsg-help-btn wz-collapse" data-for="#helpbox1" tabindex="0">
		                    <img src="/images/wzwg/site/mngr/ico_help_grey.png" alt="<spring:message code="wzwg.cmm.word.icon" />" title="<spring:message code="wzwg.cmm.msg.lypopupTypesetTitle" />">					
		              </div>
		              <div class="wzmsg-help-msg" id="helpbox1"><spring:message code="wzwg.cmm.msg.MSG350" /><br>
								<ul>
									<li class="w50"><span class="circle_no">1</span><spring:message code="wzwg.cmm.msg.MSG351" /></li>
								    <li class="w50"><span class="circle_no">2</span><spring:message code="wzwg.cmm.msg.MSG352" /></li>
								    <li class="w50"><span class="circle_no">3</span><spring:message code="wzwg.cmm.word.cn" /></li>
								    <li class="w50"><span class="circle_no">4</span><spring:message code="wzwg.module.word.bcrncolor" /></li>
								</ul>
								<img src="/images/wzwg/site/mngr/helpimg_popupzone.jpg" alt="<spring:message code="wzwg.module.word.exposurelcguidance" />" style="border-top:1px solid #dedede;">
		               </div>
		          </div>
  				</th>
  			</tr>                  <!-- 2019.04.18 신규 추가 tr-->
			<tr>
				<th><spring:message code="wzwg.cmm.word.icon" /><span class="circle_no" title="<spring:message code="wzwg.cmm.msg.lypopupTypesetTitle00" />">1</span></th>
				<td colspan="3">
					<div class="wzfile_input">
						<img id="thumbFile_preview" class="i-block box-border vert-t mb5" style="width: 106px; border: solid 1px #ddd;" src="/images/wzwg/site/mngr/no-img.png">
						<input type="file" name="thumbFile" id="thumbFile" title="<spring:message code="wzwg.module.word.thumbimage" />" style="display:none;" onchange="fnThumbCheck();wzImgPreview('thumbFile', 'thumbFile_preview');"/>
						<div class="i-block" style="width: auto;">
							<button type="button" id="btn_thumbFile" class="wzbtn btn-grey mb5 black" style="height: 40px;" onclick="$('#thumbFile').click();"><spring:message code="wzwg.module.word.fileupdt" /></button>
							<input type="text" name="thumbReplcText" id="thumbReplcText" class="w100 i-block vert-b" placeholder="<spring:message code="wzwg.cmm.msg.MSG191" />" title="<spring:message code="wzwg.module.word.thumbreplctxt" />"/>
						</div>
					</div>
					<!-- <span class="wz_tableguide mg5"><spring:message code="wzwg.cmm.msg.MSG112" /></span> -->
					<div>
						<p class="admpg-subp w100 fl mt10">
						    <span class="circle_no bg-green-strong">i</span><strong class="grey"><spring:message code="wzwg.cmm.msg.tip.MSG003" /> ?</strong>
						      <spring:message code="wzwg.cmm.msg.tip.MSG004" />
						    <span class="wz_tableguide mt5 pl15"><spring:message code="wzwg.cmm.msg.tip.MSG005" /></span>			
						</p>
					</div>
				</td>
			</tr>
			
			<tr>
				<th><spring:message code="wzwg.cmm.word.sj" /><span class="circle_no" title="<spring:message code="wzwg.cmm.msg.lypopupTypesetTitle00" />">2</span>
					<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
					</span>
				</th>
				
				<c:set var="msg_txt">
					<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.module.word.popupnm" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
				</c:set>
				<td colspan="3"><input class="w70" type="text" name="popupSj" dir="required,vmaxlen=100" placeholder="<c:out value="${msg_txt}" />" title="<spring:message code="wzwg.module.word.popupnm" />"/></td>
			</tr>
			
			<!-- 2017.11.28 신규 추가 Start -->
			<tr>
				<th><spring:message code="wzwg.cmm.word.cn" /><span class="circle_no" title="<spring:message code="wzwg.cmm.msg.lypopupTypesetTitle00" />">3</span></th>
				<td colspan="3">
					<textarea name="popupSjCn" id="popupSjCn" rows="5" class="w80" style="resize:none;"></textarea>
				</td>
			</tr>
			<!-- 2017.11.28 신규 추가 End -->
			
			<tr>
                <th><spring:message code="wzwg.module.word.bcrncolor" /><span class="circle_no" title="<spring:message code="wzwg.cmm.msg.lypopupTypesetTitle00" />">4</span></th>
                <td colspan="3">
                <c:forEach items="${tmplatList}" var="result" varStatus="status">
                	<label class="popupBgColor <c:out value="${result.tmplatFile}" />" title="<c:out value="${result.tmplatNm}" />">
	                    <input type="radio" id="tmplatSeq" name="tmplatSeq" value="<c:out value="${result.tmplatSeq}" />" title="<c:out value="${result.tmplatNm}" />" <c:if test="${status.first}">checked</c:if> />
	                   <span><c:out value="${result.tmplatNm}" /></span>
                    </label>
                </c:forEach>
                </td>
            </tr>
		</tbody>
	</table>
	
	<div id="popupTyDiv"></div>
	
	</form>
	
	<div class="rt-box">
			<a href="javascript:void(0);" onclick="fn_regist();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
			<a href="javascript:void(0);" onclick="fn_list();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>
	