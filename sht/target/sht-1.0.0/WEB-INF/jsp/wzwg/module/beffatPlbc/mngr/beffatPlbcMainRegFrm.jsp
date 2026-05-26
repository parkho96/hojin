<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script>
$(document).ready(function(){
	if($('#frmTy').val() == 'modify'){
		$('#ctgryCd').val('<c:out value="${beffatPlbcVO.ctgryCd}"/>');
		$('#expsrYn_<c:out value="${beffatPlbcVO.expsrYn}"/>').prop('checked', true);
	}else{
		$('#expsrYn_Y').prop('checked', true);
	}
});

function fnOpenPblcArea(ty){
	$('#pblcMth_file').hide();
	$('#pblcMth_link').hide();
	$('#pblcMth_' + ty).show();
}


function fnChangeCycleVal(sel){
	if($(sel).val() != ''){
		$('#beffatPblcCycleVal').val($(sel).val());
	}
}

function fnChangeEraVal(sel){
	if($(sel).val() != ''){
		$('#beffatPblcEraVal').val($(sel).val());
	}
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
	
function fnBeffatPlbcMainRegist(command){
	
	if($('#ctgryCd').val() == ''){
		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.cl" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument></spring:message>');
		$('#ctgryCd').focus();
		return;
	}
	
	if($('#beffatPblcSj').val() == ''){
		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.module.word.publictlist" /> <spring:message code="wzwg.cmm.word.sj" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
		$('#beffatPblcSj').focus();
		return;
	}
	
	if(getByteLength($('#beffatPblcSj').val()) > 60 ){
		alert('<spring:message code="wzwg.cmm.msg.MSG441" />');
		$('#beffatPblcSj').focus();
		return;
	}
	
	if($('#deptVal').val() == ''){
		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.module.word.chrgdept" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
		$('#deptVal').focus();
		return;
	}
	
	if($('#beffatPblcCycleVal').val() == ''){
		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.module.word.publictcycle" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
		$('#beffatPblcCycleVal').focus();
		return;
	}
	
	if($('#beffatPblcEraVal').val() == ''){
		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.module.word.publictperiod" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
		$('#beffatPblcEraVal').focus();
		return;
	}
	
	
	
	var frm = $("#beffatPlbcRegFrm");
	var formData = frm.serialize();
	
	var callUrl = '';
	if(command == 'R'){
		callUrl = '<c:out value="${wzwg_contextPath}"/>/mngr/module/beffatPlbc/registBeffatPlbcMainDataAjax.do'
	}else if(command == 'M'){
		callUrl = '<c:out value="${wzwg_contextPath}"/>/mngr/module/beffatPlbc/modifyBeffatPlbcMainDataAjax.do'
	}
	
	frm.ajaxSubmit({
		type:'POST'
		, url:callUrl
		, async: false
        , data: formData 
        
		, success:function(data){
			//console.log(data);
			if(data.head.result == 'success'){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
				fnTabLink('dataManage');
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


function fnBeffatPlbcMainDelete(){
	if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006"><spring:argument><spring:message code="wzwg.module.word.nextpublictinfodata" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>\n[<c:out value="${beffatPlbcVO.beffatPblcSj }"/>]')){
		$.ajax({
			   type:'POST'
			 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/module/beffatPlbc/deleteBeffatPlbcMainDataAjax.do'
			 , data:{'pblcSn' : $('#pblcSn').val()} 
			 , success:function (data) {
				if(data.head.result == 'success'){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
					fnTabLink('dataManage');
				}else{
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
				}
			 }
			 , dataType: 'json'
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


<form name="beffatPlbcRegFrm" id="beffatPlbcRegFrm" method="post" >
	<input type="hidden" name="frmTy" id="frmTy" value="<c:out value='${paramVO.frmTy}'/>"/>
	<input type="hidden" name="pblcSn" id="pblcSn" value="<c:out value='${beffatPlbcVO.pblcSn}'/>"/>
	
	<input type="hidden" name="searchCondition" id="searchCondition" value="<c:out value='${paramVO.searchCondition}'/>"/>
	<input type="hidden" name="searchKeyword" id="searchKeyword" value="<c:out value='${paramVO.searchKeyword}'/>"/>
	
	<div>
		<table class="basic">
			<colgroup>
				<col width="20%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
				<tr><th colspan="2" class="wzAdmSTit">
						<c:choose>
							<c:when test="${paramVO.frmTy eq 'modify' }">
								[<c:out value="${beffatPlbcVO.beffatPblcSj }"/>] <spring:message code="wzwg.module.word.publictinfodataupdt" />
							</c:when>
							<c:otherwise>
								<spring:message code="wzwg.module.word.publictinfodatainput" />
							</c:otherwise>
						</c:choose>
					</th>
				</tr>
				<tr>
					<th><spring:message code="wzwg.cmm.word.cl" />
						<span class="necessary">
								<span></span>
								<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td class="txt-l">
						<select name="ctgryCd" id="ctgryCd">
							<option value=""><spring:message code="wzwg.cmm.word.choise" /></option>
							<c:forEach items="${catrgoryList }" var="list">
							<c:if test="${list.ctgryCd ne 'ALL' }">
							<option value="<c:out value='${list.ctgryCd }'/>"><c:out value="${list.ctgryDcCn }"/></option>
							</c:if>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.module.word.publictlistsj" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td class="txt-l"><input type="text" name="beffatPblcSj" id="beffatPblcSj" class="w80" value="<c:out value='${beffatPlbcVO.beffatPblcSj }'/>"></td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.module.word.chrgdept" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td class="txt-l"><input type="text" name="deptVal" id="deptVal" class="w30" value="<c:out value='${beffatPlbcVO.deptVal }'/>"><!-- <button type="button" class="wzbtn btn-srch" onclick="fnSearchDeptFrm()"><spring:message code="wzwg.cmm.word.search01" /></button> --></td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.module.word.publictcycle" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td class="txt-l">
						<select onchange="fnChangeCycleVal(this)">
							<option value=""><spring:message code="wzwg.module.word.choiseandupdt" /></option>
							<option value="<spring:message code="wzwg.cmm.word.evemth" />"><spring:message code="wzwg.cmm.word.evemth" /></option>
							<option value="<spring:message code="wzwg.cmm.word.eveyr" />"><spring:message code="wzwg.cmm.word.eveyr" /></option>
							<option value="<spring:message code="wzwg.cmm.word.anytm" />"><spring:message code="wzwg.cmm.word.anytm" /></option>
							<option value="<spring:message code="wzwg.cmm.word.ht" />"><spring:message code="wzwg.cmm.word.ht" /></option>
						</select>
						<input type="text" name="beffatPblcCycleVal" id="beffatPblcCycleVal" class="w40" value="<c:out value='${beffatPlbcVO.beffatPblcCycleVal}'/>">
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.module.word.publictperiod" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td class="txt-l">
						<select onchange="fnChangeEraVal(this)">
							<option value=""><spring:message code="wzwg.module.word.choiseandupdt" /></option>
							<option value="1<spring:message code="wzwg.cmm.word.mon01" />">1<spring:message code="wzwg.cmm.word.mon01" /></option>
							<option value="4<spring:message code="wzwg.cmm.word.mon01" />">4<spring:message code="wzwg.cmm.word.mon01" /></option>
							<option value="8<spring:message code="wzwg.cmm.word.mon01" />">8<spring:message code="wzwg.cmm.word.mon01" /></option>
							<option value="1,4,7,10<spring:message code="wzwg.cmm.word.mon01" />">1,4,7,10<spring:message code="wzwg.cmm.word.mon01" /></option>
							<option value="4,8<spring:message code="wzwg.cmm.word.mon01" />">4,8<spring:message code="wzwg.cmm.word.mon01" /></option>
							<option value="31<spring:message code="wzwg.cmm.word.de" />">31<spring:message code="wzwg.cmm.word.de" /></option>
							<option value="<spring:message code="wzwg.cmm.word.dtaoccrrnctm" />"><spring:message code="wzwg.cmm.word.dtaoccrrnctm" /></option>
							<option value="<spring:message code="wzwg.cmm.word.acnttm" />"><spring:message code="wzwg.cmm.word.acnttm" /></option>
						</select>
						<input type="text" name="beffatPblcEraVal" id="beffatPblcEraVal" class="w40" value="<c:out value='${beffatPlbcVO.beffatPblcEraVal}'/>">
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.module.word.exposureat" /></th>
					<td class="txt-l">
						<ul class="wzForm">
							<li class="i-block mr20"><input type="radio" name="expsrYn" id="expsrYn_Y" value="Y" ><label for="expsrYn_Y"><label><spring:message code="wzwg.cmm.word.exposure" /></label></li>
							<li class="i-block"><input type="radio" name="expsrYn" id="expsrYn_N" value="N" class="ml10"><label for="expsrYn_N"><spring:message code="wzwg.cmm.word.unexposure" /></label></li>
						</ul>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</form>

	<div class="rt-box">
			<c:choose>
				<c:when test="${paramVO.frmTy eq 'modify' }">
				<button type="button" onclick="fnBeffatPlbcMainDelete()" class="wzbtn btn-del fl"><spring:message code="wzwg.cmm.word.delete" /></button>
				<button type="button" onclick="fnBeffatPlbcMainRegist('M')" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></button>
				</c:when>
				
				<c:otherwise>
				<button type="button" onclick="fnBeffatPlbcMainRegist('R')" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></button>
				</c:otherwise>
			</c:choose>
			<button type="button" onclick="fnTabLink('dataManage');" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></button>
	</div>