<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript" src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>

<link href="/css/wzwg/cmm/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">

	$(document).ready(function(){
		
		$('#delete_btn').click(function(){

			var frm = document.getElementById("dataFrm");

			if(document.getElementById('bgnde').value.length != 10){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.bgnde" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
				$('input[name=bgnde]').focus();
				return false;				
			}
			
			if(document.getElementById('endde').value.length != 10){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.endde" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
				$('input[name=endde]').focus();
				return false;				
			}		
				
			if(!Validator.validate(frm)){
				return;
			}
			
			if($("input[name=bgnde]").val() == $("input[name=endde]").val()){
		    	if($("select[name=beginTime]").val() > $("select[name=endTime]").val()){
		    		alert("<spring:message code="wzwg.cmm.msg.MSG125" />");
		    		$("select[name=beginTime]").focus();
		    		return;
		    	}
		    }
			
			if(!confirm('<spring:message code="wzwg.cmm.msg.MSG026" />')){
				return false;
			}else{	
				
				var msg = "";

				msg = msg + "<spring:message code="wzwg.cmm.msg.MSG267" />\n";
				msg = msg + document.getElementById('bgnde').value + " " +  document.getElementById('beginTime').value + "<spring:message code="wzwg.cmm.word.hour" /> ~ "; 
				msg = msg + document.getElementById('endde').value + " " +  document.getElementById('endTime').value + "<spring:message code="wzwg.cmm.word.hour" /> "; 
				msg = msg + "<spring:message code="wzwg.cmm.msg.MSG268" />\n";
				msg = msg + "<spring:message code="wzwg.cmm.msg.MSG269" />\n";
				msg = msg + "<spring:message code="wzwg.cmm.msg.MSG270" />\n";
				
				if(!confirm(msg)){
					return false;
				}else{
				
					var formData = new FormData(frm);
					
					
					var checkUrl = "";
					
					<c:if test="${sessionScope.SYSMNGR_AT eq 'Y' }">
						checkUrl = '<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/bbsDataMngr/selectSysOpertNtcAtAjax.do';
					</c:if>
					
					<c:if test="${sessionScope.SYSMNGR_AT ne 'Y' }">
						checkUrl = '<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/bbsDataMngr/selectSiteOpertNtcAtAjax.do';
					</c:if>					
					
					$.ajax({
						  type : 'POST'
						, url : checkUrl
						, cache : false
						, async : false
						, processData : false
						, contentType : false
						, data : formData
						, success : function(result) {
				    	  	var value = "";
							
							$(result).find("value").each(function() {  
								value = $(this).text();  
							});

							if(value != 'success'){
								alert('<spring:message code="wzwg.cmm.msg.MSG261" />');
							}else{
								$.ajax({
									  type : 'POST'
									, url : '<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/bbsDataMngr/deleteBbsData.do'
									, cache : false
									, async : false
									, processData : false
									, contentType : false
									, data : formData
									, success : function(result) {
							    	  	var value = "";
										
										$(result).find("value").each(function() {  
											value = $(this).text();  
										});
										
										if(value != 'fail'){
											alert('<spring:message code="wzwg.cmm.msg.MSG262" />');
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
						, error : function (request, status, error) {
							alert('<spring:message code="fail.common.msg" text="error" />');
						}
				 	});						
				
				}
				
			}
		});			
		
	
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
		
		<c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
        fnChangeMlsfcGroup('<c:out value="${resultVO.siteLclasGroup}" />');
        fn_grpChange('<c:out value="${resultVO.opertClSe}" />');
        </c:if>

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
    
    function fnGoSiteSttus() {
    	
    	frm = document.dataFrm;
    	
		var url = "";
		
		<c:if test="${sessionScope.SYSMNGR_AT eq 'Y' }">
			url = "<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteOpert/selectSysOpertNtcList.do";
		</c:if> 
		<c:if test="${sessionScope.SYSMNGR_AT ne 'Y' }">
			url = "<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectSiteSttusForm.do";
			frm.siteSeq.value = "<c:out value="${siteInfoDetail.siteSeq}" />";
		</c:if>    	

    	frm.action = url;
    	frm.submit();
    }
</script>

	<div class="wz_notice">
		<h4 class="admpg-tit2">※ <spring:message code="wzwg.cmm.msg.MSG157" /></h4>
		<ul class="wd100 mt20">
			<li class="admpg-subp wd100">1. <spring:message code="wzwg.cmm.msg.MSG263" /></li>
			<li class="admpg-subp wd100">2. <spring:message code="wzwg.cmm.msg.MSG264" /> <a href="javascript:void(0);" onclick="fnGoSiteSttus();">[<spring:message code="wzwg.cmm.msg.MSG265" />]</a></li>
			<li class="admpg-subp wd100">3. <spring:message code="wzwg.cmm.msg.MSG266" /></li>
		</ul>
	</div>

	<form:form modelAttribute="paramVO" path="dataFrm" id="dataFrm" name="dataFrm" method="post">
	<input type="hidden" name="siteSeq" id="siteSeq" />
	<input type="hidden" name="bbsSeq" id="bbsSeq" />
	
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

	<table class="basic mt10">
			<colgroup>
				<col width="20%" />
				<col width="80%" />
			</colgroup>
		  <tbody>
		  	<c:if test="${sessionScope.SYSMNGR_AT eq 'Y' }">
			<tr>
				<th><spring:message code="wzwg.sysMngr.word.dataArngTrget" /></th>
				<td>
					<ul class="wzForm">
						<li><label><input type="radio" name="opertClSe" value="A" onchange="fn_grpChange(this.value);" checked="checked" dir="required" title="<spring:message code="wzwg.cmm.word.cl" />"/><span class="spanLabel"><spring:message code="wzwg.sysMngr.word.allSite" /></span></label></li>
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
			
			</c:if>		
			<tr>
				<th><spring:message code="wzwg.sysMngr.word.dataDeletePd" /></th>
				<td>
					<input type="text" id="bgnde" name="bgnde" class="datePicker cal" style="width:150px;" readonly="readonly" dir="required,vdateFt=bgnde:endde" title="<spring:message code="wzwg.cmm.word.bgnde" />" value="" placeholder="<c:out value="${msg_txt01}" />"/> 
					<select id="beginTime" name="beginTime" style="width:50px;">
						<c:forEach begin="0" end="23" var="stime" varStatus="status">
							<c:if test="${stime < 10}">
								<c:set var="stime" value="0${stime}" />
							</c:if>
							<option value="<c:out value="${stime}" />"><c:out value="${stime}" /></option>
						</c:forEach>
					</select><spring:message code="wzwg.cmm.word.hour" />
					~ 
					<input type="text" id="endde" name="endde" class="datePicker cal" style="width:150px;" readonly="readonly" dir="required,vdate" title="<spring:message code="wzwg.cmm.word.endde" />" value="" placeholder="<c:out value="${msg_txt02}" />"/>
					<select id="endTime" name="endTime" style="width:50px;">
						<c:forEach begin="0" end="23" var="etime" varStatus="status">
							<c:if test="${etime < 10}">
								<c:set var="etime" value="0${etime}" />
							</c:if>
							<option value="<c:out value="${etime}" />"><c:out value="${etime}" /></option>									
						</c:forEach>
					</select><spring:message code="wzwg.cmm.word.hour" />
				</td>
			</tr>			
		  </tbody>
	</table>
	
	</form:form>	
	
	<div class="rt-box"> 
		<a href="javascript:void(0);" id="delete_btn" class="wzbtn btn-del"><spring:message code="wzwg.cmm.msg.MSG271" /></a>			
	</div>		