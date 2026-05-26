<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script>
$(document).ready(function(){
	if($('#frmTy').val() == 'modify'){
		$('#pblcMthCd_<c:out value="${plbcSubVO.pblcMthCd}"/>').click();
		$('#expsrYn_<c:out value="${plbcSubVO.expsrYn}"/>').prop('checked', true);
	}else{
		$('#expsrYn_Y').prop('checked', true);
	}
});

function fnOpenPblcArea(ty){
	$('#pblcMth_file').hide();
	$('#pblcMth_link').hide();
	$('#pblcMth_' + ty).show();
}

function getByteLength(strData) {
    var intByteLength = 0;
    var chrData         = null;
    for(var i=0; i<strData.length; i++) {
        chrData = escape(strData.charAt(i));
        if(chrData.length == 1) {
            intByteLength ++;
        } else if (chrData.indexOf("%u") != -1) {
            intByteLength += 2;
        } else if (chrData.indexOf("%") != -1) {
            intByteLength += chrData.length/3;
        }
    }
    return intByteLength;
}

function fnBeffatPlbcSubRegist(command){
	
	if($('#beffatPblcSubSj').val() == ''){
		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.module.word.publictlistsubsj" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
		$('#beffatPblcSubSj').focus();
		return;
	}
	
	if(getByteLength($('#beffatPblcSubSj').val()) > 60 ){
		alert('<spring:message code="wzwg.cmm.msg.MSG442" />');
		$('#beffatPblcSubSj').focus();
		return;
	}
	
	var frm = $("#beffatPlbcSubRegFrm");
	var formData = frm.serialize();
	
	var callUrl = '';
	if(command == 'R'){
		callUrl = '<c:out value="${wzwg_contextPath}"/>/mngr/module/beffatPlbc/registBeffatPlbcSubDataAjax.do'
	}else if(command == 'M'){
		callUrl = '<c:out value="${wzwg_contextPath}"/>/mngr/module/beffatPlbc/modifyBeffatPlbcSubDataAjax.do'
	}
	
	frm.ajaxSubmit({
		type:'POST'
		, url:callUrl
		, async: false
        , data: formData 
        , mimeType: 'multipart/form-data'
		, success:function(data){
			//console.log(data);
			if(data.head.result == 'success'){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
				fnTabLink('dataManage');
				//fnSelectSubBplbcList('<c:out value="${paramVO.pblcSn }"/>');
				//fnBeffatPlbcSubRegFrmCancel();
			}else{
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
			}
			
		}
		, error:function (request, status, error) {
              alert('<spring:message code="fail.common.msg" text="error" />');
        }
		, dataType: 'json'
	   
	});
}

function fnBeffatPlbcSubDelete(){
	if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006"><spring:argument><spring:message code="wzwg.module.word.nextpublictinfodetaildata" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>\n[<c:out value="${plbcSubVO.beffatPblcSubSj }"/>]')){
		
		var frm = $("#beffatPlbcSubRegFrm");
		var formData = frm.serialize();
		
		$.ajax({
			type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}"/>/mngr/module/beffatPlbc/deleteBeffatPlbcSubDataAjax.do'
			, data : formData
			, success : function (data) {
				if(data.head.result == 'success'){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
					fnTabLink('dataManage');
				}else{
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
				}
			}
			, error : function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
}



<%-- 부서검색 모듈 --%>
function fnSearchDeptFrm(){
	
	$.ajax({
        type:'POST'
      , url:'<c:out value="${wzwg_contextPath}"/>/mngr/cmm/deptCode/selectDeptCodeSearchFrmAjax.do'
      , cache : false
      , async : false
      , data:{acceptNm:null, acceptClose: ''}
      , success:function (data) {
    	  var popup = wzAjaxModal('popup_s', '<spring:message code="wzwg.module.word.chrgdeptchoise" />', data);
    	  var container = popup.find('.pop-container');
    	  container.addClass('search-dept-code');
      }
      , error:function (data) {
          alert('<spring:message code="fail.common.msg" text="error" />');
      }
      , dataType: 'html'
    });
	
	
}

function fnRecivDeptCd(arrDeptcd){
	//console.log(arrDeptcd);
	
	var arrDeptParam = [];
	for(var i = 0 ; i < arrDeptcd.length; i++){
		arrDeptParam.push(arrDeptcd[i].deptName);
	}
	//console.log(arrDeptParam);
	//console.log(arrDeptParam.join());
	
	$('#deptVal').val(arrDeptParam.join());
}
</script>


<form name="beffatPlbcSubRegFrm" id="beffatPlbcSubRegFrm" method="post" enctype="multipart/form-data">
	<input type="hidden" name="frmTy" id="frmTy" value="<c:out value='${paramVO.frmTy }'/>" >
	
	<input type="hidden" name="deptVal" id="deptVal" value="<c:out value='${plbcMainVO.deptVal }'/>">
	<input type="hidden" name="pblcSn" id="pblcSn" value="<c:out value='${plbcMainVO.pblcSn }'/>">
	<input type="hidden" name="listSn" id="listSn" value="<c:out value='${plbcSubVO.listSn }'/>">
	<input type="hidden" name="storFileId" id="storFileId" value="<c:out value='${plbcSubVO.storFileId }'/>">
	
	<div>
		<table class="basic">
			<colgroup>
				<col width="20%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
				<tr>
					<th colspan="2" class="wzAdmSTit">
						<c:choose>
							<c:when test="${paramVO.frmTy eq 'modify' }">
								[<c:out value="${plbcMainVO.beffatPblcSj }"/> : <c:out value="${plbcSubVO.beffatPblcSubSj }"/> ] <spring:message code="wzwg.module.word.detaildataupdt" />
							</c:when>
							<c:otherwise>
								[<c:out value="${plbcMainVO.beffatPblcSj }"/>] <spring:message code="wzwg.module.word.detaildatainput"/>
							</c:otherwise>
						</c:choose>
						
					</th>
				</tr>
				<tr>
					<th><spring:message code="wzwg.module.word.publictlistsubsj" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td class="txt-l"><input type="text" name="beffatPblcSubSj" id="beffatPblcSubSj" class="w80" value="<c:out value='${plbcSubVO.beffatPblcSubSj }'/>"></td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.module.word.exposureat" /></th>
					<td class="txt-l">
						<ul class="wzForm">
							<li class="fl mr20"><input type="radio" name="expsrYn" id="expsrYn_Y" value="Y"><label for="expsrYn_Y"><spring:message code="wzwg.cmm.word.exposure" /></label></li>
							<li class="fl"><input type="radio" name="expsrYn" id="expsrYn_N" value="N" class="ml10"><label for="expsrYn_N"><spring:message code="wzwg.cmm.word.unexposure" /></label></li>
						</ul>
					</td>
				</tr>
				
				
				<tr>
					<th><spring:message code="wzwg.module.word.publictmth" /></th>
					<td class="txt-l">
						<div class="mb20 fl wd100">
							<ul class="wzForm">
								<li class="fl mr20"><input type="radio" name="pblcMthCd" id="pblcMthCd_file" onclick="fnOpenPblcArea('file')" value="file"><label for="pblcMthCd_file"><spring:message code="wzwg.module.word.atchfilety" /></label></li>
								<li class="fl"><input type="radio" name="pblcMthCd" id="pblcMthCd_link" onclick="fnOpenPblcArea('link')" value="link" class="ml10"><label for="pblcMthCd_link"><spring:message code="wzwg.module.word.linkty" /></label></li>
							</ul>
						</div>
						<div id="pblcMth_file" style="display: none;">
							<!-- <div><button type="button" class="wzbtn-table btn-basic" onclick="fnAddAttchFile()">파일추가</button> ※최대3개까지 추가됩니다.</div>
							<div id="attchFileArea">
								
							</div> -->
							<div>
								<c:choose>
									<c:when test="${paramVO.frmTy eq 'modify' }">
										<c:import url="${wzwg_contextPath}/module/upload/file/selectFileInc.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" 		value="${plbcSubVO.storFileId}" />
											<c:param name="param_updateFlag" 		value="Y" />
											<c:param name="param_atchFileNumber" 	value="3" />
										</c:import>
									</c:when>
									<c:otherwise>
										<c:import url="${wzwg_contextPath}/module/upload/file/selectFileInc.do" charEncoding="utf-8">
											<c:param name="param_updateFlag" 		value="N" />
											<c:param name="param_atchFileNumber" 	value="3" />
										</c:import>
									</c:otherwise>
								</c:choose>
							
							</div>
						</div>
						<div id="pblcMth_link" style="display: none;">
							<input type="text" name="linkUrl" class="w70" placeholder="<spring:message code="wzwg.cmm.msg.MSG443" />" value="<c:out value='${plbcSubVO.linkUrl }'/>">
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</form>

	<div class="rt-box">
			<c:choose>
				<c:when test="${paramVO.frmTy eq 'modify' }">
				<button type="button" onclick="fnBeffatPlbcSubDelete()" class="wzbtn btn-del fl"><spring:message code="wzwg.cmm.word.delete" /></button>
				<button type="button" onclick="fnBeffatPlbcSubRegist('M')" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></button>
				</c:when>
				
				<c:otherwise>
				<button type="button" onclick="fnBeffatPlbcSubRegist('R')" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></button>
				</c:otherwise>
			</c:choose>
			
			<button type="button" onclick="fnTabLink('dataManage');" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></button>
	</div>