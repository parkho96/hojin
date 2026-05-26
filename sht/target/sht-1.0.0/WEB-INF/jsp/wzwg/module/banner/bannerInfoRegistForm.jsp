<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<link href="/css/wzwg/cmm/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/js/wzwg/cmm/common.js" ></script>
<script language="javascript" type="text/javascript" src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>
<script language="javascript" type="text/javascript" src="/jquery/js/jquery.form.min.js"></script>

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
	    });
		
		/** 배너 등록 */
	    function fnRegist(){
			
			/** 이미지파일 확장자 체크 */
			var atchFile = document.getElementById('atchFile');
		    if(typeof atchFile != "undefind" && atchFile != null) {
		    	atchFile = atchFile.value;
		        
		        atchFile = atchFile.slice(atchFile.lastIndexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로 만듭니다.
		        
		        if(atchFile != "jpg" && atchFile != "png" && atchFile != "gif"){ //확장자를 확인합니다.
		            alert('<spring:message code="wzwg.cmm.msg.MSG126" />');
		        	$("#atchFile").focus();
		            return;
		        }
		    }
		    
		    if(!Validator.validate(document.bannerForm)){
				return;
			}
			
		    if($(":input:radio[name=pdSetupAt]:checked").val() == 'Y'){
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
				    		alert("<spring:message code="wzwg.cmm.word.banner" /> <spring:message code="wzwg.cmm.msg.MSG125" />");
				    		$("select[name=startTime]").focue();
				    		return;
				    	}
				    }
					
					if($("input[name=startDt]").val() > $("input[name=endDt]").val()){
						alert('<spring:message code="wzwg.cmm.msg.MSG323" />');
						$('input[name=startDt]').focus();
			    		return;
					}
		    }
		    
	 		var frm = $("#bannerForm");
	 		
			frm.ajaxSubmit({
				type:'POST'
				, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/banner/registModuleBannerInfoAjax.do'
				, async: false
		        , data: frm 
		        , mimeType: 'multipart/form-data'
				, success:function(result){
					$(result).find('value').each(function(){
						if($(this).text() == "success"){
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
							fnList();
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
						}
					});
				}
				, error:function (request, status, error) {
		              alert('<spring:message code="fail.common.msg" text="error" />');
		          }
				, dataType: 'xml'
			});
			
 	    }
	    	    
		/** 배너 리스트로 이동 */
	    function fnList(){
	    	document.bannerForm.action='<c:out value="${wzwg_contextPath}${prefix}"/>/module/banner/selectModuleBannerInfoList.do';
	    	document.bannerForm.submit();
	    }
	    
		
	    /** 기간설정여부 설정 */
		function fnPdSetupAtChange(paramValue){
			if(paramValue != 'Y'){
				$("input[name=startDt]").attr("disabled","disabled");
				$("select[name=startTime]").attr("disabled","disabled");
				$("input[name=endDt]").attr("disabled","disabled");
				$("select[name=endTime]").attr("disabled","disabled");
				$("input[name=startDt]").val("");
				$("input[name=endDt]").val("");
			}else{
				$("input[name=startDt]").removeAttr("disabled");
				$("select[name=startTime]").removeAttr("disabled");
				$("input[name=endDt]").removeAttr("disabled");
				$("select[name=endTime]").removeAttr("disabled");
			}
		}
	    
		/** 기간설정여부 설정 */
		function fnLinkUseAtChange(paramValue){
			if(paramValue != 'Y'){
				$("input[name=linkUrl]").attr("disabled","disabled");
				$("select[name=linkTyCd]").attr("disabled","disabled");
				$("input[name=linkUrl]").val("");
			}else{
				$("input[name=linkUrl]").removeAttr("disabled");
				$("select[name=linkTyCd]").removeAttr("disabled");
			}
		}

	    function fnChangeMlsfcGroup(upperGrpSeq) {
	    	if(upperGrpSeq != ""){
		        $.ajax({
		            type : 'POST'
		          , dataType: 'xml'
		          , contentType : 'application/x-www-form-urlencoded; charset=UTF-8'
		          , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/siteMngr/siteGroup/selectSiteGroupMlsfcAjax.do'
		          , cache : false
		          , async : false
		          , data:{'odr':2, 'upperGrpSeq':upperGrpSeq}
		          , success : function(xml, status, request) {
		              
		              $("#siteMlsfcGroup").find("option").remove().end().append("option value=\"\">::<spring:message code="wzwg.cmm.word.all" />::</option>");
		              $("#siteMlsfcGroup").append("<option value=\"\">::<spring:message code="wzwg.cmm.word.all" />::</option>");
		              $(xml).find("item").each(function(){
		                  var sitegrpSeq = $(this).find('name').text();
		                  var groupNm = $(this).find('value').text();
		                  if(sitegrpSeq == '<c:out value="${resultVO.bannerMclCode}"/>'){
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

	</script>
	
	<form id="bannerForm" name="bannerForm" method="post" enctype="multipart/form-data">
	<table class="basic">
			<colgroup>
				<col width="20%" />
				<col width="80%" />
			</colgroup>
		  <tbody>
		  	<c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
			<tr>
				<th><spring:message code="wzwg.cmm.word.se" /></th>
				<td colspan="3">
					<select id="siteLclasGroup" name="bannerLclCode" onchange="fnChangeMlsfcGroup(this.value);" >
						<option value="">::<spring:message code="wzwg.cmm.word.all" />::</option>
						<c:forEach var="result" items="${siteLclasGroupList}">
							<option value="<c:out value='${result.sitegrpSeq}'/>"><c:out value="${result.groupNm}"/></option>
                        </c:forEach>
					</select>
					
                    <select id="siteMlsfcGroup" name="bannerMclCode">
                        <option value="">::<spring:message code="wzwg.cmm.word.all" />::</option>
                    </select>      
				</td>
			</tr>
			</c:if>
			<tr>
				<th><spring:message code="wzwg.cmm.word.bannerzn" /> <spring:message code="wzwg.cmm.word.thumb" />
					<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
					</span>
				</th>
				<td colspan="3">
					<input type="file" name="atchFile" id="atchFile" dir="required" title="<spring:message code="wzwg.cmm.word.banner" /> <spring:message code="wzwg.cmm.word.image" />"/>
					<input type="text" name="imgReplcText" class="w30" placeholder="<spring:message code="wzwg.cmm.msg.MSG191" />" dir="required,vmaxlen=50" title="<spring:message code="wzwg.cmm.word.thumb" /> <spring:message code="wzwg.cmm.word.replc" /> <spring:message code="wzwg.cmm.word.txt" />"/>
					<span class="wz_tableguide mt10"><spring:message code="wzwg.cmm.msg.MSG112" /></span>
					<p class="admpg-subp w100 fl mt10">
						    <span class="circle_no bg-green-strong">i</span><strong class="grey"><spring:message code="wzwg.cmm.msg.tip.MSG003" /> ?</strong>
						      <spring:message code="wzwg.cmm.msg.tip.MSG004" />
						    <span class="wz_tableguide mt5 pl15"><spring:message code="wzwg.cmm.msg.tip.MSG005" /></span>			
					</p>
				</td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.cmm.word.banner" /> <spring:message code="wzwg.cmm.word.nm01" />
					<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
					</span>
				</th>
				
				<c:set var="msg_txt">
					<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.banner" /> <spring:message code="wzwg.cmm.word.nm01" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
				</c:set>
				
				<td colspan="3"><input class="w70" type="text" name="bannerNm" dir="required,vmaxlen=100" title="<spring:message code="wzwg.cmm.word.banner" /> <spring:message code="wzwg.cmm.word.nm01" />" placeholder="<c:out value='${msg_txt}'/>"/></td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.cmm.word.banner" /> <spring:message code="wzwg.cmm.word.sort" /> <spring:message code="wzwg.cmm.word.ordr" /></th>
				
				<td colspan="3">
					<input class="w20" type="number" name="sortOrdr" value="<c:out value='${resultVO.bannerNm}'/>" dir="required,vmaxlen=100" placeholder="<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.number" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>"/>
					<span class="wz_tableguide mt10">
					<spring:message code="wzwg.cmm.msg.MSG382" />
					<c:choose>
						<c:when test="${sessionScope.SYSMNGR_AT eq 'Y'}">(0 ~ 99)</c:when>
						<c:otherwise>(1 ~ 99)</c:otherwise>
					</c:choose>
					</span><!-- 2019.04.18 -->
				</td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.cmm.word.banner" /> <spring:message code="wzwg.cmm.word.pd" /></th>
				<td colspan="3">
					<ul class="wzForm">
						<li class="wd100"><label><input type="radio" name="pdSetupAt" value="N" onchange="fnPdSetupAtChange(this.value);" dir="required" title="<spring:message code="wzwg.cmm.word.pd" /> <spring:message code="wzwg.cmm.word.estbs" /> <spring:message code="wzwg.cmm.word.at" />" checked="checked"><span class="spanLabel"><spring:message code="wzwg.cmm.word.unlimit" /></span></label></li>
						<li><label><input type="radio" name="pdSetupAt" value="Y" onchange="fnPdSetupAtChange(this.value);" dir="required" title="<spring:message code="wzwg.cmm.word.pd" /> <spring:message code="wzwg.cmm.word.estbs" /> <spring:message code="wzwg.cmm.word.at" />"><span class="spanLabel"><spring:message code="wzwg.cmm.word.pd" /> <spring:message code="wzwg.cmm.word.estbs" /></span></label></li>
					</ul>
					
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
					
					<input type="text" class="datePicker cal" style="width:150px;" readonly="readonly" name="startDt" title="<spring:message code="wzwg.cmm.word.bgnde" />" disabled="disabled"  placeholder="<c:out value='${msg_txt01}'/>"/>
					<select name="startTime" title="<spring:message code="wzwg.cmm.word.begin" /> <spring:message code="wzwg.cmm.word.time" />" disabled="disabled">
						<c:forEach begin="0" end="23" varStatus="status">
							<fmt:formatNumber var="sHour" minIntegerDigits="2" value="${status.index }"/>
							<option value="<c:out value='${sHour}'/>"><c:out value='${sHour}'/> <spring:message code="wzwg.cmm.word.hour" /></option>
						</c:forEach>
					</select>
					~
					<input type="text" class="datePicker cal" style="width:150px;" readonly="readonly" name="endDt" title="<spring:message code="wzwg.cmm.word.endde" />" disabled="disabled" placeholder="<c:out value='${msg_txt02}'/>"/>
					<select name="endTime" title="<spring:message code="wzwg.cmm.word.end" /> <spring:message code="wzwg.cmm.word.time" />" disabled="disabled">
						<c:forEach begin="0" end="23" varStatus="status">
							<fmt:formatNumber var="sHour" minIntegerDigits="2" value="${status.index }"/>
							<option value="<c:out value='${sHour}'/>"><c:out value='${sHour}'/> <spring:message code="wzwg.cmm.word.hour" /></option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.module.word.useat" /></th>
				<td colspan="3">
					<ul class="wzForm">
						<li><label><input type="radio" name="noticeAt" value="Y" dir="required" title="<spring:message code="wzwg.module.word.useat" />" checked="checked"><span class="spanLabel"><spring:message code="wzwg.cmm.word.use" /></span></label></li>
						<li><label><input type="radio" name="noticeAt" value="N" dir="required" title="<spring:message code="wzwg.module.word.useat" />"><span class="spanLabel"><spring:message code="wzwg.cmm.word.unuse" /></span></label></li>
					</ul>
				</td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.cmm.word.banner" /> <spring:message code="wzwg.cmm.word.link" /></th>
				<td colspan="3">
					<ul class="wzForm">
						<li><label><input type="radio" name="linkUseAt" value="Y" onchange="fnLinkUseAtChange(this.value);" dir="required" title="<spring:message code="wzwg.module.word.useat" />"><span class="spanLabel"><spring:message code="wzwg.cmm.word.use" /></span></label></li>
						<li class="wd100"><label><input type="radio" name="linkUseAt" value="N" onchange="fnLinkUseAtChange(this.value);" dir="required" title="<spring:message code="wzwg.module.word.useat" />" checked="checked"><span class="spanLabel"><spring:message code="wzwg.cmm.word.unuse" /></span></label></li>

					</ul>
					<input type="text" class="w50" name="linkUrl" title="<spring:message code="wzwg.cmm.word.link" /> URL"  disabled="disabled" placeholder="<spring:message code="wzwg.cmm.msg.MSG346" />"/>
					<select name="linkTyCd" title="<spring:message code="wzwg.cmm.word.link" /> <spring:message code="wzwg.cmm.word.ty" /> <spring:message code="wzwg.cmm.word.code" />"  disabled="disabled" >
						<option value="1"><spring:message code="wzwg.cmm.word.newwin" /></option>
						<option value="2"><spring:message code="wzwg.cmm.word.nowwin" /></option>
					</select>
				</td>
			</tr>
		</tbody>
	</table>
	
	</form>
	
	<div class="rt-box">
			<a href="javascript:void(0);" onclick="fnRegist();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
			<a href="javascript:void(0);" onclick="fnList();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>
	