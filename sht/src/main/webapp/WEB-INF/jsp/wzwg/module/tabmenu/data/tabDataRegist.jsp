<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<c:set var="adminAuthAt" value="N"/>

<c:if test="${paramVO.cmntUseAt eq 'Y'}">
	<c:if test="${sessionScope.cmntMngrAt == true}">
		<c:set var="adminAuthAt" value="Y"/>
	</c:if>
</c:if>	

<c:if test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or sessionScope.CNTNTS_ADMIN_AT}">
	<c:set var="adminAuthAt" value="Y"/>
</c:if>

<!-- 셀렉트 검색 라이브러리 tabsub-->
<link href="/js/wzwg/cmm/select2/select2.css" rel="stylesheet" />
<script src="/js/wzwg/cmm/select2/select2.js"></script>

<script type="text/javascript">
try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.cmm.word.regist" />';}catch(e){console.log(e.message);}

	$(document).ready(function(){
		$('#contentsCaption').html($('#menuNm').val() + ' <spring:message code="wzwg.module.word.postregist" />');
		
 		if('<c:out value="${tmprnttListCnt}" />' > 0){
 			$('#tmprntt_area').html("<a href='javascript:void(0);' onclick='fnTmprPop(this);' class='save'><spring:message code='wzwg.cmm.word.temsvept' /><span class='red'>(<c:out value="${tmprnttListCnt}" />)</span></a>");
 			$('#tmprntt_area').show();
 		}
		
		// 등록
		$('#regist_btn').click(function(){
			
			if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>')){
				return;
			}else{
				
				var frm = document.getElementById("tabDataRegFrm");
				
				var clSe = $("input:radio[name=tabClSe]:checked").val();
				
				if(clSe == 'L'){
					var target = $('#nttClTarget').val();
					var linkUrl = $('#linkUrl').val();
					
					if(linkUrl == ''){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
								'<spring:argument><spring:message code="wzwg.cmm.word.url" text="contents" /></spring:argument>'+
								'<spring:argument><spring:message code="wzwg.cmm.word.input" text="input" /></spring:argument>'+
							  '</spring:message>');
						return;	
					}
					
					//frm.tabCn.value = '[' + target + ']' + linkUrl;
					$('#tabDataRegFrm #menuLinkUrl').val(linkUrl);
					$('#tabDataRegFrm #menuLinkTarget').val(target);
					$('#tabDataRegFrm #sysmoduleSeq').val('');
					$('#tabDataRegFrm #moduleTyCode').val('');
					$('#tabDataRegFrm #sitecntntsSeq').val('');
				}
				
				if(clSe == 'M'){
					if(frm.tabdataSj.value == ''){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
								'<spring:argument><spring:message code="wzwg.module.word.tabsj" /></spring:argument>'+
								'<spring:argument><spring:message code="wzwg.cmm.word.input" text="input" /></spring:argument>'+
							  '</spring:message>');
						return;				
					}
					
					var sysmoduleSeq = $('#sysmoduleSeq').val();
					var siteModuleCntntsSeq = $('#siteModuleCntntsSeq').val();
					var moduleTyCode = $('#moduleTyCode').val();
					
					if(sysmoduleSeq == ''){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
								'<spring:argument><spring:message code="wzwg.module.word.modulety" /></spring:argument>'+
								'<spring:argument><spring:message code="wzwg.cmm.word.choise" text="choise" /></spring:argument>'+
							  '</spring:message>');
						return;
					}
					
					
					if(sysmoduleSeq =='' || moduleTyCode=='SC00000033'){
						//단일모듈 선택
						$("#moduleDiv").css("display","none");
						$("#linkDiv").css("display","none"); 
						//$("#upperMenuDiv").css("display","");
						//$('#sitecntntsSeq').attr('disabled', true);
						//$('#menuLinkUrl').attr('disabled', true);
						//$('#upperMenuSeq').attr('disabled', false);
					}else{
						//중복모듈 선택
						if(siteModuleCntntsSeq == undefined || siteModuleCntntsSeq == ''){
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
									'<spring:argument><spring:message code="wzwg.module.word.modulecntnts" /> </spring:argument>'+
									'<spring:argument><spring:message code="wzwg.cmm.word.choise" text="choise" /></spring:argument>'+
								  '</spring:message>');
							return;	
						}
						
					}
					
					//var paramValue = {'sysmoduleSeq' : sysmoduleSeq, 'moduleTyCode' : moduleTyCode, 'sitecntntsSeq' : siteModuleCntntsSeq};
					//console.log(paramValue);
					//frm.tabCn.value = JSON.stringify(paramValue);
					$('#tabDataRegFrm #sitecntntsSeq').val(siteModuleCntntsSeq);
					
					$('#tabDataRegFrm #menuLinkUrl').val('');
					$('#tabDataRegFrm #menuLinkTarget').val('');
				}
				
				//alert(frm.tabCn.value);
				//return;
				
				$.ajax({
			        type : 'POST'
					, url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/tabMenu/registTabMenuDataAjax.do'
					, dataType: 'xml'
					, data : $("#tabDataRegFrm").serialize()
					, success : function (result) {
			    	  
			    	  	var value = "";
						
						$(result).find("value").each(function() {  
							value = $(this).text();  
						});
						
						if(value != 'fail'){
							frm.tabdataSeq.value = value;
							
							$.ajax({
						        type : 'POST'
								, url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/tabMenu/selectTabMenuDataListAjax.do'
								, dataType : 'html'
								, data : $("#tabDataRegFrm").serialize()
								, success : function (data) {
									$('#tabMenuArea').html(data);
									$("#content").css("height",$(document).height());
							     	$(window).scrollTop(0);
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
					
			}
			
		});
		
		
		// 취소
		$('#cancle_btn').click(function(){
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/tabMenu/selectTabMenuDataListAjax.do'
				, dataType : 'html'
				, data : $("#tabDataRegFrm").serialize()
				, success : function (data) {
					$('#tabMenuArea').html(data);
					$("#content").css("height",$(document).height());
			     	$(window).scrollTop(0);
				}
				, error : function (request, status, error) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
			});
		});
		
	});
	
	// 상세화면으로 이동
	function fnNttView(tabdataSeq){
		
		var frm = document.getElementById("tabDataRegFrm");
		frm.tabdataSeq.value = tabdataSeq;
		
		$.ajax({
	        type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/tabMenu/selectNttDetailAjax.do'
			, dataType : 'html'
			, data : $("#tabDataRegFrm").serialize()
			, success : function (data) {
				$('#tabMenuArea').html(data);
				$("#content").css("height",$(document).height());
		     	$(window).scrollTop(0);
			}
			, error : function (request, status, error) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
		});
	}
	
	//window.onkeydown = function() {
    //
	//    var keyCode = event.keyCode;
    //
	//    if(keyCode == 8
	//    		&& 'INPUT'.indexOf(event.target.nodeName.toUpperCase()) == -1 
	//    		&& 'TEXTAREA'.indexOf(event.target.nodeName.toUpperCase()) == -1) {
    //
	//    	$('#cancle_btn').click();
	//    	return false;
	//	}
	//}		
	
	function fnChangeWriteType(com){
		if(com == 'C'){
			$('#cntntsWrite').show();
			$('#linkWrite').hide();
			$('#moduleWrite').hide();
			//$('#tmpr_regist_btn').show(); //임시저장버튼 
			//$('#tmprntt_area').show(); // 임시저장한글 팝업
		}else if(com == 'L'){
			$('#cntntsWrite').hide();
			$('#linkWrite').show();
			$('#moduleWrite').hide();
			$('#moduleDiv').hide();
			//$('#tmpr_regist_btn').hide(); //임시저장버튼 
			//$('#tmprntt_area').hide(); // 임시저장한글 팝업
		}else if(com == 'M'){
			$('#cntntsWrite').hide();
			$('#linkWrite').hide();
			$('#moduleWrite').show();
			$('#moduleDiv').show();
			//$('#tmpr_regist_btn').hide(); //임시저장버튼 
			//$('#tmprntt_area').hide(); // 임시저장한글 팝업
		}
	}
	
	//tabsub
	function fnMenuModuleTyChange(value){
		var sysmoduleSeq = '';
		var moduleTyCode = '';
		if(value !='' && value !='link' ){
			sysmoduleSeq = value.split(",")[0];
			  moduleTyCode = value.split(",")[1];
		}else{
			sysmoduleSeq = value;
			moduleTyCode ='';
		}
		
		$('#hint-kotraDept').remove();
		
		$("#sysmoduleSeq").val(sysmoduleSeq);
		$("#moduleTyCode").val(moduleTyCode); 
		if(sysmoduleSeq =='' || moduleTyCode=='SC00000033'){
			$("#moduleDiv").css("display","none");
			$("#linkDiv").css("display","none"); 
			//$("#upperMenuDiv").css("display","");
			//$('#sitecntntsSeq').attr('disabled', true);
			//$('#menuLinkUrl').attr('disabled', true);
			//$('#upperMenuSeq').attr('disabled', false);
			//if(sysmoduleSeq == '10000000260'){
			//	$('#moduleSelector').after('<div class="admpg-subp i-block" id="hint-kotraDept"><span class="circle_no bg-green-strong">i</span>조직도 모듈 추가시 [부서소개탭]이 자동으로 추가됩니다.</div>');
			//}
		}else{
			$("#moduleDiv").css("display","");
			$("#linkDiv").css("display","none");
			//$("#upperMenuDiv").css("display","");
			//$('#sitecntntsSeq').attr('disabled', false);
			//$('#menuLinkUrl').attr('disabled', true);
			//$('#upperMenuSeq').attr('disabled', false);
			$.ajax({
				  method:'post'
		        , url:'<c:out value="${wzwg_contextPath}" />/mngr/module/tabMenu/siteMenuCntntListAjax.do'
		        , type:'html'
		        , data:{"sysmoduleSeq":sysmoduleSeq}
		        , success:function (data) { 
		        	 $(".cntntsNmSpan").html(data); 
		        }
		    }); 
		}
	}
	
	function fnSelectModuleFilter(chkbox){
		if($(chkbox).is(':checked')){
			//$('#sitecntntsSeq').find('option[data-menuat="Y"]').css('display', 'none');
			//<option value="10000002556" data-menuat="Y" class="bg-grey" style="">일반게시판</option>
			$('#siteModuleCntntsSeq').find('option[data-menuat="Y"]').each(function(){
				var value = $(this).attr('value');
				var menuat = $(this).attr('data-menuat');
				var cls = $(this).attr('class');
				var cntnts = $(this).html();
				
				var optNon = '<option_none value="' + value + '" data-menuat="' + menuat + '" class="' + cls + '" style="">' + cntnts + '</option_none>'
				$('#siteModuleCntntsSeq').append(optNon);
				$(this).remove();
			});
			//console.log('option remove');
			$('#siteModuleCntntsSeq').select2('destroy');
			$('#siteModuleCntntsSeq').select2();
		}else{
			//$('#sitecntntsSeq').find('option').css('display', '');
			$('#siteModuleCntntsSeq').find('option_none').each(function(){
				var value = $(this).attr('value');
				var menuat = $(this).attr('data-menuat');
				var cls = $(this).attr('class');
				var cntnts = $(this).html();
				
				var opt = '<option value="' + value + '" data-menuat="' + menuat + '" class="' + cls + '" style="">' + cntnts + '</option>'
				$('#siteModuleCntntsSeq').append(opt);
				$(this).remove();
			});
			//console.log('option append');
			$('#siteModuleCntntsSeq').select2('destroy');
			$('#siteModuleCntntsSeq').select2();
		}
		//console.log(chkbox);
	}
</script>

		<form:form modelAttribute="paramVO" path="tabDataRegFrm" id="tabDataRegFrm" name="tabDataRegFrm" method="post">
			<form:hidden path="siteSeq" />
			<form:hidden path="tabSeq" />
			<form:hidden path="tabdataSeq" />
			<form:hidden path="menuSeq" />
			<form:hidden path="menuLinkUrl" />
			<form:hidden path="menuLinkTarget" />
			<form:hidden path="sysmoduleSeq" />
			<form:hidden path="moduleTyCode" />
			<form:hidden path="sitecntntsSeq" />
			
			<c:set var="clNmTit"><spring:message code="wzwg.module.word.clnminpcmpt" /></c:set>
			<div class="register-box mt0">
				<div class="">
					<table class="basic">
					<caption id="contentsCaption"><spring:message code="wzwg.module.word.postwritng" /></caption>
					<colgroup style="display:table-column-group !important;">
						<col width="20%"/>
						<col width="80%"/>
					</colgroup>
					<thead>
					</thead>
					<tbody>				
						<tr style="border-top:none;">
							<th scope="row" class="subTit">
								<spring:message code="wzwg.module.word.tabsj" />
							</th>
							<td class="mr10" colspan="1">
								<c:set var="txt01"><spring:message code="wzwg.cmm.word.ntt" /></c:set>
								<c:set var="txt02"><spring:message code="wzwg.module.word.clnm" /></c:set>
								<form:input path="tabdataSj" id="tabdataSj" style="width:100%;" maxlength="40" dir="required" title="${fn:escapeXml(clNmTit)}" />
								<span id="tmprntt_area" style="display:none;">
							</td>
							<!-- 
							<td>
							 	</span>
							</td> -->							
						</tr>
						<tr>
							<th scope="row" class="subTit">
								<spring:message code="wzwg.cmm.word.ty03" text="name" />
							</th>
							<td colspan="1" class="mr10">
								<%-- <label><input type="radio" name="nttClSe" value="C" checked="checked" onclick="fnChangeWriteType('C')" title="<spring:message code="wzwg.cmm.word.cl" /> <spring:message code="wzwg.cmm.word.ty03" /> <spring:message code="wzwg.cmm.word.wa.post" /> <spring:message code="wzwg.cmm.word.choise" />"> <spring:message code="wzwg.cmm.word.wa.post"/></label> --%>
								<ul class="wzForm">
									<li>
										<label>
											<input type="radio" name="tabClSe" value="M" checked="checked" onclick="fnChangeWriteType('M')" title="<spring:message code="wzwg.module.word.modulecntnts" />"> 
											<span class="spanLabel"><spring:message code="wzwg.module.word.modulecntnts"/></span>
										</label>
									</li>
									<li>
										<label class="ml10">
											<input type="radio" name="tabClSe" value="L" onclick="fnChangeWriteType('L')" title="<spring:message code="wzwg.cmm.word.link" />"> 
											<span class="spanLabel"><spring:message code="wzwg.cmm.word.link"/></span>
										</label>
									</li>
								</ul>
							</td>
						</tr>
						<tr id="linkWrite" style="display:none;">
							<th scope="row" class="subTit"><spring:message code="wzwg.cmm.word.url"/></th>
							<td colspan="1">
								<input type="text" class="w80" id="linkUrl" title="<spring:message code="wzwg.module.word.urlinpcmpt" />">
								<select id="nttClTarget" class="mt10" title="<spring:message code="wzwg.module.word.urlopense" />">
									<option value="G"><spring:message code="wzwg.cmm.word.nowwin"/></option>
									<option value="N"><spring:message code="wzwg.cmm.word.newwin"/></option>
								</select>
								<p class="admpg-subp w100 fl mt10"><span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.MSG346" /></p>
							</td>
						</tr>
						<%-- tabbus --%>
						<tr id="moduleWrite">
							<th scope="row" class="subTit"><spring:message code="wzwg.module.word.pagety" /></th>
							<td colspan="1">
								<select onchange="fnMenuModuleTyChange(this.value);" id="moduleSelector">
									<option value=""><spring:message code="wzwg.cmm.word.choise" /></option>
									<c:forEach items="${moduleList}" var="list" varStatus="status">
										<option value="<c:out value="${list.sysmoduleSeq}" />,<c:out value="${list.moduleTyCode}" />"><c:out value='${list.moduleNm}'/></option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr id="moduleDiv">
							<th><spring:message code="wzwg.cmm.word.cntnts" />&<spring:message code="wzwg.module.word.bbscnnc" /></th>
							<td id="dataConn" class="cntntsNmSpan">
								<select>
									<option><spring:message code="wzwg.cmm.msg.MSG139" /></option> 
								</select>
							</td>
						</tr>
					</tbody>
				</table>
				</div>
			</div>
			<div class="ctr-box">
				<a href="javascript:void(0);" id="cancle_btn" class="wzbtn btn-del"><spring:message code="wzwg.cmm.word.cancl" text="cancle" /></a>
				<a href="javascript:void(0);" id="regist_btn" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" text="save" /></a>			
			</div>		
					
		</form:form>

