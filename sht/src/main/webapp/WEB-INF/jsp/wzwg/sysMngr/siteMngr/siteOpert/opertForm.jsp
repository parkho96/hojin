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
	       
	        fnChangeMlsfcGroup('<c:out value="${resultVO.siteLclasGroup}" />');
	        fn_grpChange('<c:out value="${resultVO.opertClSe}" />');
	    });
	    
		/** 전체사이트, 그룹지정  */
		function fn_grpChange(paramValue){
			if(paramValue != 'G'){
				$("select[name=siteLclasGroup]").attr("disabled","disabled");
				$("select[name=siteMlsfcGroup]").attr("disabled","disabled");
				$("#siteLclasGroup").val("").attr("selected", true);
				$("#siteMlsfcGroup").val("").attr("selected", true);
			}else{
				$("select[name=siteLclasGroup]").removeAttr("disabled");
				$("select[name=siteMlsfcGroup").removeAttr("disabled");
			}
		}
		

	    /** 등록 */
	    function fn_regist(){
	    	oEditors.getById["opertCn"].exec("UPDATE_CONTENTS_FIELD", []);

	 		if(!Validator.validate(document.opertForm)){
	 			return;
	 		}
	 		
	 		
	 		/** 시작시간 && 종료시간 확인 */
		    if($("input[name=opertBgnde]").val() == $("input[name=opertEndde]").val()){
		    	if($("select[name=beginTime]").val() > $("select[name=endTime]").val()){
		    		alert('<spring:message code="wzwg.cmm.msg.MSG096"/>');
		    		$("select[name=beginTime]").focus();
		    		return;
		    	}
		    }

	 		$.ajax({
	 			type:'POST'
	 			, url:'<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteOpert/registSysOpertNtcAjax.do'
	 			, data:$("#opertForm").serialize()
	 			,success:function (result){
	 				$(result).find('value').each(function(){
	 					if($(this).text() == "success"){
	 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
	 						fn_list();
	 					}else{
	 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.rgsde" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
	 					}
	 				})
	 			}
	 			, error:function (request, status, error) {
	 	              alert('<spring:message code="fail.common.msg" text="error" />');
	 	          }
	 		});
	    }
	    
	    /** 수정 */
	    function fn_modify(){
	    	oEditors.getById["opertCn"].exec("UPDATE_CONTENTS_FIELD", []);

	 		if(!Validator.validate(document.opertForm)){
	 			return;
	 		}
	 		
	 		/** 시작시간 && 종료시간 확인 */
		    if($("input[name=opertBgnde]").val() == $("input[name=opertBgnde]").val()){
		    	if($("select[name=beginTime]").val() > $("select[name=endTime]").val()){
		    		alert('<spring:message code="wzwg.cmm.msg.MSG096"/>');
		    		$("select[name=beginTime]").focus();
		    		return;
		    	}
		    }

	 		$.ajax({
	 			type:'POST'
	 			, url:'<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteOpert/modifySysOpertNtcAjax.do'
	 			, data:$("#opertForm").serialize()
	 			,success:function (result){
	 				$(result).find('value').each(function(){
	 					if($(this).text() == "success"){
	 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>');
	 						fn_list();
	 					}else{
	 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
	 					}
	 				})
	 			}
	 			, error:function (request, status, error) {
	 	              alert('<spring:message code="fail.common.msg" text="error" />');
	 	          }
	 		});
	    }
	    
	    function fn_delete(){
	    	if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
	    		return ;
	    	}else{
		 		$.ajax({
		 			type:'POST'
		 			, url:'<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteOpert/deleteSysOpertNtcAjax.do'
		 			, data:$("#opertForm").serialize()
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
	    		
	    	}
	    }
	    
	    /** 리스트로 이동 */
	    function fn_list(){
	    	document.opertForm.action='<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteOpert/selectSysOpertNtcList.do';
	    	document.opertForm.submit();
	    }
	    
	    function fnChangeMlsfcGroup(upperGrpSeq) {
	    	if(upperGrpSeq != ""){
		        $.ajax({
		            type : 'POST'
		          , dataType: 'xml'
		          , contentType : 'application/x-www-form-urlencoded; charset=UTF-8'
		          , url:'<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteGroup/selectSiteGroupMlsfcAjax.do'
		          , cache : false
		          , async : false
		          , data:{'odr':2, 'upperGrpSeq':upperGrpSeq}
		          , success : function(xml, status, request) {
		              
		              $("#siteMlsfcGroup").find("option").remove().end().append("option value=\"\">::<spring:message code="wzwg.cmm.word.all" />::</option>");
		              $("#siteMlsfcGroup").append("<option value=\"\">::<spring:message code="wzwg.cmm.word.all" />::</option>");
		              $(xml).find("item").each(function(){
		                  var sitegrpSeq = $(this).find('name').text();
		                  var groupNm = $(this).find('value').text();
		                  if(sitegrpSeq == '<c:out value="${resultVO.siteMlsfcGroup}" />'){
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
	
	<form id="opertForm" name="opertForm" method="post">
		<input type="hidden" name="sysopertSeq" value="<c:out value="${resultVO.sysopertSeq }" />"/>
		<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex }" />" />
		
		<table class="basic">
			<colgroup>
				<col width="20%" />
				<col width="80%" />
			</colgroup>
			<tbody>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.srvcStpge" /></th>
					<td>
						<ul class="wzForm">
							<li><label><input type="radio" name="opertClSe" value="A" onchange="fn_grpChange(this.value);" checked="checked" dir="required" title="<spring:message code="wzwg.cmm.word.cl" />"/><span class="spanLabel"><spring:message code="wzwg.sysMngr.word.allSiteApplc" /></span></label></li>
							<li><label><input type="radio" name="opertClSe" value="G" onchange="fn_grpChange(this.value);" <c:if test="${resultVO.opertClSe eq 'G' }">checked="checked"</c:if> dir="required" title="<spring:message code="wzwg.cmm.word.cl" />"/><span class="spanLabel"><spring:message code="wzwg.sysMngr.word.groupAppn" /></span></label></li>
						</ul>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.groupAppn" /></th>
					<td>
						<select id="siteLclasGroup" name="siteLclasGroup" onchange="fnChangeMlsfcGroup(this.value);" >
							<option value="">::<spring:message code="wzwg.cmm.word.all" />::</option>
							<c:forEach var="result" items="${siteLclasGroupList}">
								<option value="<c:out value="${result.sitegrpSeq}" />" <c:if test="${result.sitegrpSeq eq resultVO.siteLclasGroup}">selected="selected"</c:if>><c:out value="${result.groupNm}" /></option>
                            </c:forEach>
                        </select>
						
                        <select id="siteMlsfcGroup" name="siteMlsfcGroup">
                            <option value="">::<spring:message code="wzwg.cmm.word.all" />::</option>
                        </select>      
                        
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.opertNm01" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td>
						<c:set var="msg_txt03">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011">
								<spring:argument><spring:message code="wzwg.sysMngr.word.opertNm01" /></spring:argument>
								<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
							</spring:message>
						</c:set>
						
						<input type="text" name="opertNm" class="w70" value="<c:out value="${resultVO.opertNm }" />" dir="required,vmaxlen=25" title="<spring:message code="wzwg.sysMngr.word.opertNm01" />" placeholder="<c:out value="${msg_txt03}" />"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.opertPd" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td>
				
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
					
						<input type="text" class="datePicker cal" style="width:150px;" readonly="readonly" name="opertBgnde" dir="required,vdateFt=opertBgnde:opertEndde" title="<spring:message code="wzwg.cmm.word.bgnde" />" value="<c:out value="${resultVO.opertBgnde }" />" placeholder="<c:out value="${msg_txt01}" />"/>
						<select name="beginTime"  dir="required,vnum" title="<spring:message code="wzwg.sysMngr.word.beginTime" />">
							<c:forEach begin="0" end="23" varStatus="status">
								<fmt:formatNumber var="sHour" minIntegerDigits="2" value="${status.index }"/>
								<option value="<c:out value="${sHour}" />" <c:if test="${sHour eq resultVO.beginTime }">selected="selected"</c:if>><c:out value="${sHour}" /><spring:message code="wzwg.cmm.word.hour" /></option>
							</c:forEach>
						</select>
						~
						<input type="text" class="datePicker cal" style="width:150px;" readonly="readonly" name="opertEndde" dir="required,vdate" title="<spring:message code="wzwg.cmm.word.endde" />" value="<c:out value="${resultVO.opertEndde }" />" placeholder="<c:out value="${msg_txt02}" />"/>
						<select name="endTime" dir="required,vnum" title="<spring:message code="wzwg.sysMngr.word.endTime" />">
							<c:forEach begin="0" end="23" varStatus="status">
								<fmt:formatNumber var="sHour" minIntegerDigits="2" value="${status.index }"/>
								<option value="<c:out value="${sHour}" />" <c:if test="${sHour eq resultVO.endTime }">selected="selected"</c:if>><c:out value="${sHour}" /><spring:message code="wzwg.cmm.word.hour" /></option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.cmm.word.dc" /></th>
					<td>
						<textarea name="opertCn" id="opertCn" rows="20" class="w80" style="height: 420px;" dir="required" title="<spring:message code="wzwg.sysMngr.word.opertCn" />"><c:out value="${resultVO.opertCn }"/></textarea>
						<script type="text/javascript">
							var oEditors = [];
							nhn.husky.EZCreator.createInIFrame({
							    oAppRef: oEditors,
							    elPlaceHolder: "opertCn",
							    sSkinURI: "<c:out value="${wzwg_contextPath}" />/smartEditor2.8.2.1/smartEditor2Skin.do",
							    fCreator: "createSEditor2",
							    htParams: {
									fOnBeforeUnload : function(){}
									,aAdditionalFontList : [['NanumSquareR', 'NanumSquareR']]		// 추가 글꼴 목록
									}
							});
						</script>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.cmm.word.apply" /> <spring:message code="wzwg.cmm.word.at" /></th>
					<td>
						<ul class="wzForm">
							<li><label><input type="radio" name="opertApplcAt" value="Y" dir="required" title="<spring:message code="wzwg.sysMngr.word.applcAt" />" checked="checked"/><span class="spanLabel"><spring:message code="wzwg.cmm.word.applc" /></span></label></li>
							<li><label><input type="radio" name="opertApplcAt" value="N" dir="required" title="<spring:message code="wzwg.sysMngr.word.applcAt" />" <c:if test="${resultVO.opertApplcAt eq 'N' }">checked="checked"</c:if>/><span class="spanLabel"><spring:message code="wzwg.cmm.word.unapplc" /></span></label></li>
						</ul> 
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	
	<div class="rt-box">
		<c:choose>
			<c:when test="${!empty resultVO }">
				<a href="javascript:void(0);" onclick="fn_delete();" class="wzbtn btn-del fl"><spring:message code="wzwg.cmm.word.delete" /></a>
				<a href="javascript:void(0);" onclick="fn_modify();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
			</c:when>
			<c:otherwise>
				<a href="javascript:void(0);" onclick="fn_regist();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
			</c:otherwise>
		</c:choose>
		
		<a href="javascript:void(0);" onclick="fn_list();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>
	