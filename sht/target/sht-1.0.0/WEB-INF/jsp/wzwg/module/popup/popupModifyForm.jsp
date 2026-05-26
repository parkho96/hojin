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
	        
	        fn_popupTyChange("<c:out value="${resultVO.popupTyCode}" />");
	        fnChangeMlsfcGroup("<c:out value="${resultVO.lcalsCode}" />");
	        
	        $('#popupForm input').not('[type="hidden"]').first()
	        
	        fnCheckMainUse($('input[name="exposureAt"]:checked'));
	        
	    });

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
	 			 , data:{'popupTyCode':paramValue, 'popupSeq':'<c:out value="${resultVO.popupSeq}" />'} 
	 			 , success:function (data) {
						 $('#popupTyDiv').html(data);
						 
// 						 if(paramValue == 'SC00000413'){
// 							 $("input[name=width]").attr("disabled","disabled");
// 							 $("input[name=height]").attr("disabled","disabled");
// 							 $("input[name=width]").val("");
// 							 $("input[name=height]").val("");
// 						 }else{
// 							 $("input[name=width]").removeAttr("disabled");
// 							 $("input[name=height]").removeAttr("disabled");
// 						 }
					   }
	 			 , dataType: 'html'
	 		 });
            } else {
                $('.divNotice').attr("disabled","disabled");
            }
	    }

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
		
		/** 팝업 수정 */
	    function fn_modify(){

			/** 팝업 타입별 validate, 에디터 데이터 입력 */
			if($("input[name=popupTyCode]").val() == "SC00000414"){
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
				
				<c:if test="${resultVO.popupTyCode ne 'SC00000415'}">
				/** 이미지파일 확장자 체크 */
				var atchFile = document.getElementById('atchFile');
			    if($('#atchFile')[0].files.length > 0) {
			    	atchFile = atchFile.value;
			        
			        atchFile = atchFile.slice(atchFile.indexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로 만듭니다.
			        
			        if(atchFile != "jpg" && atchFile != "png" && atchFile != "gif"){ //확장자를 확인합니다.
			            alert('<spring:message code="wzwg.cmm.msg.MSG126" />');
			        	$("#btn_atchFile").focus();
			            return;
			        }
			    }
			    </c:if>

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
			
		    if($('#thumbFile')[0].files.length > 0) {
		    	thumbFile = thumbFile.value;
		    	
		        thumbFile = thumbFile.slice(thumbFile.indexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로 만듭니다.

		        if(thumbFile != "jpg" && thumbFile != "png" && thumbFile != "gif"){ //확장자를 확인합니다.
		            alert('<spring:message code="wzwg.cmm.msg.MSG126" />');
		        	$("#btn_thumbFile").focus();
		            return;
		        }
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
	 		
	 		
	 		/* disabled 되어 있는 팝업존 노출 정보를 해제한후 저장한다 */
	 		$('input[name="positionAt"]').prop('disabled', false);
	 		
			frm.ajaxSubmit({
				type:'POST'
				, url:'<c:out value="${wzwg_contextPath}" />/module/popup/modifyModulePopupAjax.do'
				, async: false
		        , data: frm 
		        , mimeType: 'multipart/form-data'
				, success:function(result){
					$(result).find('value').each(function(){
						if($(this).text() == "success"){
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>');
							fn_list();
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
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
		
		/** 팝업 삭제 */
		function fn_delete(){
			if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" text="delete" /></spring:argument></spring:message>')){
				$.ajax({
					type:'POST'
					, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/popup/deleteModulePopupAjax.do'
					, data:$("#popupForm").serialize()
					,success:function (result){
						$(result).find('value').each(function(){
							if($(this).text() == "success"){
								alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
								fn_list();
							}else{
								alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
							}
						})
					}
					, error:function (request, status, error) {
			              alert('<spring:message code="fail.common.msg" text="error" />');
			          }
				});
			}else{
				return;
			}
		}
		
		/** 썸네일 or 이미지 파일 변경 */
		function fn_fileModify(paramValue){
			$("#"+paramValue+"Area").empty();
			$("#"+paramValue+"Area").append('<input type="file" name="'+paramValue+'"dir="required" title="<spring:message code="wzwg.cmm.word.file" />"/>');
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
		<input type="hidden" name="popupSeq" value="<c:out value="${resultVO.popupSeq }" />"/>
		<input type="hidden" name="atchFileId" value="<c:out value="${resultVO.atchFileId }" />"/>
		<input type="hidden" name="thumbFileId" value="<c:out value="${resultVO.thumbFileId }" />"/>
		<input type="hidden" name="popupTyCode" value="<c:out value="${resultVO.popupTyCode }" />"/>
		<input type="hidden" name="searchPopupSttus" value="<c:out value="${paramVO.searchPopupSttus }" />"/>
		<input type="hidden" name="searchNoticeAt" value="<c:out value="${paramVO.searchNoticeAt }" />"/>
		<input type="hidden" name="searchKeyword" id="searchKeyword" value="<c:out value="${paramVO.searchKeyword}" />"/>
		<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex}" />"/>
			
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
		  	<tr><th colspan="2" class="wzAdmSTit"><spring:message code="wzwg.module.word.bassestbs" /></th></tr> <!-- 2019.04.18 신규 추가 tr-->
		  	<c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
            <tr>
                <th><spring:message code="wzwg.cmm.word.se" /></th>
                <td colspan="3">
                    <select id="siteLclasGroup" name="lcalsCode" onchange="fnChangeMlsfcGroup(this.value);" >
                        <option value="">::<spring:message code="wzwg.cmm.word.all" />::</option>
                        <c:forEach var="result" items="${siteLclasGroupList}">
                            <option value="<c:out value="${result.sitegrpSeq}" />" <c:if test="${result.sitegrpSeq eq resultVO.lcalsCode}">selected="selected"</c:if>><c:out value="${result.groupNm}" /></option>
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
								
								<input type="radio" name="popupTyCode" value="<c:out value="${codeList.code }" />" id="<c:out value="${codeList.code }" />" dir="required" title="<spring:message code="wzwg.cmm.word.popup" />" disabled="disabled" <c:if test="${resultVO.popupTyCode eq codeList.code }">checked="checked"</c:if>>
							    <label for="<c:out value="${codeList.code }" />" style="margin-top:10px;" title="<spring:message code="wzwg.cmm.word.popup" />">
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
					
					<input type="text" class="datePicker cal" style="width:150px;" readonly="readonly" name="startDt" value="<c:out value="${resultVO.startDt }" />" dir="required,vdateFt=startDt:endDt" title="<spring:message code="wzwg.cmm.word.bgnde" />" placeholder="<c:out value="${msg_txt01}" />"/>
					<select name="startTime" dir="required,vnum" title="<spring:message code="wzwg.module.word.begintimese" />">
						<c:forEach begin="0" end="23" varStatus="status">
							<fmt:formatNumber var="sHour" minIntegerDigits="2" value="${status.index }"/>
							<option value="<c:out value="${sHour }" />" <c:if test="${sHour eq resultVO.startTime }">selected="selected"</c:if>><c:out value="${sHour }" /> <spring:message code="wzwg.cmm.word.hour" /></option>
						</c:forEach>
					</select>
					~
					<input type="text" class="datePicker cal" style="width:150px;" readonly="readonly" name="endDt" value="<c:out value="${resultVO.endDt }" />" dir="required,vdate" title="<spring:message code="wzwg.cmm.word.endde" />" placeholder="<c:out value="${msg_txt02}" />"/>
					<select name="endTime" dir="required,vnum" title="<spring:message code="wzwg.module.word.endtimese" />">
						<c:forEach begin="0" end="23" varStatus="status">
							<fmt:formatNumber var="sHour" minIntegerDigits="2" value="${status.index }"/>
							<option value="<c:out value="${sHour }" />" <c:if test="${sHour eq resultVO.endTime }">selected="selected"</c:if>><c:out value="${sHour }" /> <spring:message code="wzwg.cmm.word.hour" /></option>
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
					<input type="text" class="w10" name="mainSortOrdr" value="<c:out value="${resultVO.mainSortOrdr }" />" dir="required,vnum,vmaxlen=2" maxlength="2" title="<spring:message code="wzwg.module.word.sortordr" />"/> 
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
							<input type="radio" name="noticeAt" value="Y" dir="required" id="requiredY" title="<spring:message code="wzwg.module.word.useat" />" <c:if test="${resultVO.noticeAt eq 'Y' }">checked="checked"</c:if>>
							<label for="requiredY"><spring:message code="wzwg.cmm.word.use" /></label
						></li>
						<li>
							<input type="radio" name="noticeAt" value="N" dir="required" id="requiredN" title="<spring:message code="wzwg.module.word.useat" />" <c:if test="${resultVO.noticeAt eq 'N' }">checked="checked"</c:if>>
							<label for="requiredN"><spring:message code="wzwg.cmm.word.unuse" /></label>
						</li>
					</ul>
				</td>
			</tr>
			
			<!-- 2017.11.28 신규 추가 Start -->
			<tr>
				<th><spring:message code="wzwg.cmm.msg.lypopupUse" /> </th>
				<td colspan="3">
					<ul class="w100 fl wzForm">
						<li class="wd100">
							<input type="radio" class="divNotice" name="exposureAt" value="Y" id="exposureAtY" dir="required" title="<spring:message code="wzwg.module.word.useat" />" <c:if test="${resultVO.exposureAt eq 'Y' }">checked="checked"</c:if> onclick="fnCheckMainUse(this)">
							<label for="exposureAtY"><spring:message code="wzwg.cmm.word.atmc" /> (<spring:message code="wzwg.cmm.msg.popupTypeselect01" />)</label>
						</li>
						<li class="wd100">
							<input type="radio" class="divNotice" name="exposureAt" value="N" id="exposureAtN" dir="required" title="<spring:message code="wzwg.module.word.useat" />" <c:if test="${resultVO.exposureAt eq 'N' }">checked="checked"</c:if> onclick="fnCheckMainUse(this)">
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
							<input type="radio" class="divNotice" name="positionAt" value="Y" id="positionAtY" dir="required" title="<spring:message code="wzwg.module.word.exposureat" />" <c:if test="${resultVO.positionAt eq 'Y' }">checked="checked"</c:if>>
							<label for="positionAtY"><spring:message code="wzwg.cmm.word.exposure" /></label>
						</li>
						<li class="wd100">
							<input type="radio" class="divNotice" name="positionAt" value="N" id="positionAtN" dir="required" title="<spring:message code="wzwg.module.word.exposureat" />" <c:if test="${resultVO.positionAt eq 'N' }">checked="checked"</c:if>>
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
				<th><spring:message code="wzwg.cmm.word.icon" /><span class="circle_no">1</span></th>
				<td colspan="3">
				
					<div class="wzfile_input">
						<!-- <button type="button" onclick="$('#thumbFile').click();"> -->
						<c:if test="${not empty resultVO.thumbFileId }">
							<img id="thumbFile_preview" class="i-block box-border vert-t mb5" style="width: 106px; border: solid 1px #ddd;" src="<c:url value='/module/upload/file/selectImageView.do'/>?atchFileId=<c:out value="${resultVO.thumbFileId }"/>&fileSn=0">
						</c:if>
						<c:if test="${empty resultVO.thumbFileId }">
							<img id="thumbFile_preview" class="i-block box-border vert-t mb5" style="width: 106px; border: solid 1px #ddd;" src="/images/wzwg/site/mngr/no-img.png">
						</c:if>
						<!-- </button> -->
						<input type="file" name="thumbFile" id="thumbFile" <c:if test="${empty resultVO.thumbFileId }"></c:if> title="<spring:message code="wzwg.module.word.thumbimage" />" style="display:none;" onchange="fnThumbCheck(); wzImgPreview('thumbFile', 'thumbFile_preview');"/>
						<div class="i-block" style="width:auto;">
							<button class="wzbtn btn-grey mb5 black" id="btn_thumbFile" type="button" style="height: 40px;" onclick="$('#thumbFile').click();"><spring:message code="wzwg.module.word.fileupdt" /></button>
							<input type="text" name="thumbReplcText" id="thumbReplcText" class="w100 i-block vert-b" value="<c:out value="${resultVO.thumbReplcText }" />" placeholder="<spring:message code="wzwg.cmm.msg.MSG191" />" title="<spring:message code="wzwg.module.word.thumbreplctxt" />"/>
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
				<th><spring:message code="wzwg.cmm.word.sj" /><span class="circle_no">2</span>
					<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
					</span>
				</th>
				
				<c:set var="msg_txt">
					<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.module.word.popupnm" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
				</c:set>
				
				<td colspan="3"><input class="w70" type="text" name="popupSj" value="<c:out value="${resultVO.popupSj }" />" dir="required,vmaxlen=100" title="<spring:message code="wzwg.module.word.popupnm" />" placeholder="<c:out value="${msg_txt}" />"/></td>
			</tr>
			
			<!-- 2017.11.28 신규 추가 Start -->
			<tr>
				<th><spring:message code="wzwg.cmm.word.cn" /><span class="circle_no">3</span></th>
				<td colspan="3">
					<textarea name="popupSjCn" id="popupSjCn" rows="5" class="w80" style="resize:none;"><c:out value="${resultVO.popupSjCn}" /></textarea>
				</td>
			</tr>
			<!-- 2017.11.28 신규 추가 End -->
			
			<tr>
                <th><spring:message code="wzwg.module.word.bcrncolor" /><span class="circle_no">4</span></th>
                <td colspan="3">
                <c:forEach items="${tmplatList}" var="result" varStatus="status">
                	<label class="popupBgColor <c:out value="${result.tmplatFile}" />" title="<c:out value="${result.tmplatNm}" />">
	                    <input type="radio" id="tmplatSeq" name="tmplatSeq" value="<c:out value="${result.tmplatSeq}" />" title="<c:out value="${result.tmplatNm}" />" <c:if test="${result.tmplatSeq eq resultVO.tmplatSeq}">checked</c:if> />
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
			<a href="javascript:void(0);" onclick="fn_delete();" class="wzbtn btn-del fl"><spring:message code="wzwg.cmm.word.delete" /></a>
			<a href="javascript:void(0);" onclick="fn_modify();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
			<a href="javascript:void(0);" onclick="fn_list();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>
