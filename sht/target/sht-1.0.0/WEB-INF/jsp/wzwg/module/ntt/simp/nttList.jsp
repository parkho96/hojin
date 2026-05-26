<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<% pageContext.setAttribute("LF", "\n"); %>

<script type="text/javascript">
try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.cmm.word.list" />';
	$('#nttCn').attr('title', $('#menuNm').val() + ' <spring:message code="wzwg.module.word.postsinpcmpt" />');
}catch(e){console.log(e.message);}

	$(document).ready(function(){	

		// 삭제
		$('#delete_btn').click(function(){
			if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
				return;
			}else{
				var checkCnt = 0;
				var simpnttChkArr = "";

				$("input[name=simpnttChk]").each(function(){
					if(this.checked){
						simpnttChkArr += $(this).val() + ",";
						checkCnt++;
					}
				});
				
				if(checkCnt < 1){
					alert('<spring:message code="wzwg.cmm.msg.MSG087" />');
					return false;
				}
					
				var frm = document.listFrm;
				
				frm.checkSimpnttSeq.value = simpnttChkArr;
				
				$.ajax({
  					type:'POST'
					, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/simp/deleteNttSimpInfoAjax.do'
					, cache : false
					, async : false
					, data:$("#listFrm").serialize()
					, success:function (result) {
						var value = "";
						
						$(result).find("value").each(function() {  
							value = $(this).text();  
						});

						if(value == 'success'){
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
							fnNttSimpList();
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
						}
						$("#content").css("height",$(document).height());											
   					}
				   , error:function (request, status, error) {
				 	  alert('<spring:message code="fail.common.msg" text="error" />');
				   }
				   , dataType: 'xml'
				});
			}
		});		
	
		// 체크박스 전체선택 / 해제
		$("input[name=simpnttAllChk]").on('click', function(){
			var boolean_chk = $("input[name=simpnttAllChk]").get(0).checked;
			$("input[name=simpnttChk]").each(function(){
				this.checked = boolean_chk;
			});
		});
		
	});		

	/** 수정 폼 */
	function fnModifyFrm(simpnttSeq, idx, val){
		var nttCn = $('#nttCn_'+simpnttSeq).val();
		if(val == 'Y'){
			
			$('#nttCnDiv'+idx+'_'+simpnttSeq).hide();
			$('#modifyNttCnDiv'+idx+'_'+simpnttSeq).show();
			$('#modifyY'+idx+'_'+simpnttSeq).hide();
			$('#modifyN'+idx+'_'+simpnttSeq).show();
			
			var innerTag = "";
			
			if('<c:out value="${editorEstbsSe}"/>' == 'S'){
				innerTag += "<div class='mb5'>";
				innerTag += "<textarea id='modifyInput_"+simpnttSeq+"' rows='15' cols='50' style='width:100%;'>"+nttCn+"</textarea>";
				innerTag += "<input type='hidden' name='nttCnChrctr' id='nttCnChrctr' />";
				innerTag += "&nbsp;<script language=\"javascript\" DEFER>";
				innerTag += "var oEditors = [];";
				innerTag += "nhn.husky.EZCreator.createInIFrame({";
				innerTag += "oAppRef: oEditors,";
				innerTag += "elPlaceHolder: 'modifyInput_"+simpnttSeq+"',";
				innerTag += "sSkinURI: '<c:out value="${wzwg_contextPath}"/>/smartEditor2.8.2.1/smartEditor2Skin.do',";
				innerTag += "fCreator: 'createSEditor2',";
				innerTag += "htParams: {fOnBeforeUnload : function(){},aAdditionalFontList : [['NanumSquareR', 'NanumSquareR']]}";
				innerTag += "});";
				innerTag += "<\/script>";
				innerTag += "</div>";
				innerTag += "<div class='btnbox-c'>";
				innerTag += "<a class='wzbtn btn-save' href='javascript:void(0);' onclick='fnModifySimpInfo("+simpnttSeq+");'><spring:message code='wzwg.cmm.word.stre' />";
				innerTag += "</a>";
				innerTag += "</div>";
				
				$('#modifyNttCnDiv'+idx+'_'+simpnttSeq).text("");
				$('#modifyNttCnDiv'+idx+'_'+simpnttSeq).append(innerTag);
			}
			
			if('<c:out value="${editorEstbsSe}"/>' == 'C'){
				$.ajax({
					type:'POST'
					, dataType: 'html'
					, url:'<c:out value="${wzwg_contextPath}"/>/module/editor/editorForm.do'
					, data:"param_editorNm=nttCn_"+simpnttSeq+"&param_editorTy=custom"
					, success:function (data) {
						innerTag += "<div class='btnbox-c'>";
						innerTag += "<a class='wzbtn btn-save' href='javascript:void(0);' onclick='fnModifySimpInfo("+simpnttSeq+", bEditor_nttCn_"+simpnttSeq+".GetBodyValue());'><spring:message code='wzwg.cmm.word.stre' />";
						innerTag += "</a>";
						innerTag += "</div>";
						
						$('#modifyNttCnDiv'+idx+'_'+simpnttSeq).html(data);
						$('#modifyNttCnDiv'+idx+'_'+simpnttSeq).append(innerTag);
						$('#modifyNttCnDiv'+idx+'_'+simpnttSeq).show();
					}
					, error:function (data) {
						alert('<spring:message code="fail.common.msg" text="error" />');
					}
				});
			}
			
		}else{
			
			$('#modifyNttCnDiv'+idx+'_'+simpnttSeq).text("");
			
			$('#nttCnDiv'+idx+'_'+simpnttSeq).show();
			$('#modifyNttCnDiv'+idx+'_'+simpnttSeq).hide();
			$('#modifyY'+idx+'_'+simpnttSeq).show();
			$('#modifyN'+idx+'_'+simpnttSeq).hide();
		}
		$("#content").css("height",$(document).height());
	}
	
	/** 댓글 수정 */
	function fnModifySimpInfo(simpnttSeq, nttCn){

		var frm = document.getElementById('detailFrm');
		
		frm.simpnttSeq.value = simpnttSeq;
		
		if(nttCn == ''){
			if('<c:out value="${editorEstbsSe}"/>' == 'S'){
			
				oEditors.getById["nttCn"].exec("FOCUS",[]);
				return;				
			}
			
			if('<c:out value="${editorEstbsSe}"/>' == 'C'){
				bEditor_nttCn.SetFocusEditor(); // 크로스에디터 Focus 이동 
				return false; 
			}
			
		}  
		if(nttCn ==undefined){
			oEditors.getById["modifyInput_"+simpnttSeq].exec("UPDATE_CONTENTS_FIELD", []);
			nttCn = document.getElementById("modifyInput_"+simpnttSeq).value;
		}
		frm.nttCn.value = nttCn;
		
		$.ajax({
	        type:'POST'
	        , dataType: 'xml'
			, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/simp/modifyNttSimpInfoAjax.do'
			, data:$("#detailFrm").serialize()
			, success:function (result) {
				var value = "";
				
				$(result).find("value").each(function() {  
					value = $(this).text();  
				});
				
				if(value == 'success'){
					$('#modifyInput_'+simpnttSeq).val('');
					fnNttSimpList();
				}else{
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
				}
				$("#content").css("height",$(document).height());
			}
			, error:function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
	// 삭제
	function fnDeleteSimpInfo(simpnttSeq){
		if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
			return;
		}else{
			$.ajax({
					type:'POST'
				, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/simp/deleteNttSimpInfoAjax.do'
				, cache : false
				, async : false
				, data:"simpnttSeq="+simpnttSeq
				, success:function (result) {
					var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value == 'success'){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
						fnNttSimpList();
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
					}
					$("#content").css("height",$(document).height());
				}
			   , error:function (request, status, error) {
			 	  alert('<spring:message code="fail.common.msg" text="error" />');
			   }
			   , dataType: 'xml'
			});
		}
	}
	
	window.onkeydown = function() {

	    var keyCode = event.keyCode;

	    if(keyCode == 8
	    		&& 'INPUT'.indexOf(event.target.nodeName.toUpperCase()) == -1 
	    		&& 'TEXTAREA'.indexOf(event.target.nodeName.toUpperCase()) == -1) {

	    	return false;
		}
	}		
</script>

	<form name="detailFrm" id="detailFrm" method="post">
		<input type="hidden" name="simpnttSeq" />
		<input type="hidden" name="nttCn" />
	</form>
	
	<c:if test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or sessionScope.CNTNTS_ADMIN_AT}">
		<c:set var="adminAuthAt" value="Y"/>
	</c:if>	

	<c:if test="${adminAuthAt eq 'Y'}">
		<div class="mb10 pl10">
			<label>
			<input type="checkbox" name="simpnttAllChk" id="simpnttAllChk" title="<spring:message code="wzwg.module.word.allchoise" />"/>
			<span><spring:message code="wzwg.module.word.allchoise" /></span>
			</label>
		</div>					
	</c:if>	

	<c:if test="${!empty resultList}">
	
	<c:forEach var="resultList" items="${resultList}" varStatus="status">
	
		<c:set var="detAuthAt" value="" />
		<c:set var="modAuthAt" value="" />
		<c:set var="delAuthAt" value="" />
		
		<c:if test="${loginVO.usrSeq eq resultList.ntcrSeq or nttAuthVO.authorSe eq 'R' or nttAuthVO.authorSe eq 'W' or sessionScope.SADMIN_AT or sessionScope.NADMIN_AT}">
			<c:set var="detAuthAt" value="Y" />
		</c:if>	
		
		<c:if test="${loginVO.usrSeq eq resultList.ntcrSeq or sessionScope.SADMIN_AT or sessionScope.NADMIN_AT}">
			<c:set var="modAuthAt" value="Y" />
			<c:set var="delAuthAt" value="Y" />
		</c:if>			
		
		<input type="hidden" id="nttCn_<c:out value='${resultList.simpnttSeq}'/>" value='<c:out value='${resultList.nttCn}' escapeXml="false" />'/>			
	
		<div class="board001 mb5">
			<div class="list_tit">						
				<h3>
					<c:if test="${adminAuthAt eq 'Y'}">
						<input type="checkbox" name="simpnttChk" id="simpnttChk" value="<c:out value='${resultList.simpnttSeq}'/>" />					
					</c:if>
					
					<div class="conTop i-block vert-m">
						<h4>
							<span>
								<c:out value="${resultList.ntcrNm}"/>(<c:out value="${fn:substring(resultList.ntcrId, 0, 4)}"/>****)
							</span>
						</h4>
					</div>				
				</h3>
				<p class="list_date">
					<span>
						<c:out value="${resultList.frstRegistPnttm}"/>
					</span>
					<span class="com_bar">
						<c:if test="${modAuthAt eq 'Y'}">
							<a href="javascript:void(0);" onclick="fnModifyFrm('<c:out value="${resultList.simpnttSeq}"/>', '<c:out value="${status.index}"/>', 'Y');" id="modifyY<c:out value='${status.index}'/>_<c:out value='${resultList.simpnttSeq}'/>">
								<spring:message code="wzwg.cmm.word.updt" />
							</a>
							<a href="javascript:void(0);" onclick="fnModifyFrm('<c:out value="${resultList.simpnttSeq}"/>', '<c:out value="${status.index}"/>', 'N');" id="modifyN<c:out value='${status.index}'/>_<c:out value='${resultList.simpnttSeq}'/>" style="display:none;">
								<spring:message code="wzwg.module.word.updtcancl" />
							</a>
						</c:if>
						<c:if test="${delAuthAt eq 'Y'}">
							<a href="javascript:void(0);" onclick="fnDeleteSimpInfo('<c:out value="${resultList.simpnttSeq}"/>');"><spring:message code="wzwg.cmm.word.delete" /></a>							
						</c:if>
				</span>
				</p>
			</div><!-- list_tit end -->
			<div class="list_content">	
				<div class="conMiddle">
					<div class="conM_txt">
						<div id="nttCnDiv<c:out value='${status.index}'/>_<c:out value='${resultList.simpnttSeq}'/>">
							<c:choose>
								<c:when test="${detAuthAt eq 'Y'}">
									<c:out value='${resultList.nttCn}' escapeXml="false" />
								</c:when>
								<c:otherwise>
									<spring:message code="wzwg.cmm.msg.MSG086" />
								</c:otherwise>
							</c:choose>		
						</div>				
					</div>
					<div id="modifyNttCnDiv<c:out value='${status.index}'/>_<c:out value='${resultList.simpnttSeq}'/>" style="display:none;"></div>
					
					<c:if test="${detAuthAt eq 'Y'}">
						<c:import url="${wzwg_contextPath}${prefix}/module/ntt/simp/answer/selectNttSimpAnswerIncAjax.do" charEncoding="utf-8">
							<c:param name="param_simpnttSeq" value="${resultList.simpnttSeq}" />
						</c:import>
					</c:if>

				</div>
				<div class="conBottom">
					<c:if test="${detAuthAt eq 'Y'}">
						<c:import url="${wzwg_contextPath}${prefix}/module/ntt/simp/answer/selectNttSimpAnswerFormAjax.do" charEncoding="utf-8">
							<c:param name="param_simpnttSeq" value="${resultList.simpnttSeq}" />
						</c:import>
					</c:if>
				</div><!-- conBottom end -->
			</div>
		</div>
	
	</c:forEach>
		
	</c:if>
	
	<c:if test="${empty resultList}">
		<div class="mt30">
			<ul>
				<li style="text-align:center;"><spring:message code="wzwg.cmm.msg.MSG085" /></li>
			</ul>
		</div>
	</c:if>		
	
	<div class="rt-box">
		<c:if test="${adminAuthAt eq 'Y'}">
			<a href="javascript:void(0);" class="wzbtn btn-del fl" id="delete_btn"><spring:message code="wzwg.module.word.choisedelete" /></a>
		</c:if>	
	</div>
	
	<c:if test="${nowUrl.indexOf('/mngr') == -1 }">
	<div class="mt20">
		<c:import url="${wzwg_contextPath}/usr/cntnts/cntPagadiEstbs/selectCntPagadiEstbsUsrAjax.do" />
	</div>
	</c:if>
		
