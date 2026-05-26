<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<%-- 위디자인 배경 컬러 세팅 --%>
<c:set var="pointColList">bg-red,bg-pink,bg-orange,bg-yellow,bg-green,bg-blue,bg-brown,bg-violet,bg-purple,bg-white</c:set>
<c:set var="pointColStrList">bg-red-strong,bg-pink-strong,bg-orange-strong,bg-yellow-strong,bg-green-strong,bg-blue-strong,bg-brown-strong,bg-violet-strong,bg-purple-strong</c:set>


<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">
$(document).ready(function(){
	$('.orgInfoColList li').click(function(){
		$('.orgInfoColList li').removeClass('chk');
		$(this).addClass('chk');
	})	
})

var oEditors = [];

function fnRegistOrgInfo(){
	
	if(!Validator.validate(document.frmOrg)){
		return;
	}
	
	$('#orgnztDcKr').val(oEditors.getById["orgnztDcKr"].getIR());
	$('#orgnztDcEn').val(oEditors.getById["orgnztDcEn"].getIR());
	
	var orgInfoSeq = document.frmOrg.parntsOrgnztSeq.value;
	
	
	/** 
		# normal : 일반
		# other : 감사 (별도 2차 그룹)
		# ctrd : 시도지부 (동일 2차 그룹 아래 하위 2차그룹)
	
		1차 : 하위 가능 그룹 타입 (normal, other)
		2차 : 하위 가능 그룹 타입 (normal, ctrd)
	*/
	var orgTySeVal = $('#orgTySeGroupSel option:selected').val();
	
	if(orgTySeVal != undefined){
		document.frmOrg.orgnztTySe.value = orgTySeVal;
	}else{
		document.frmOrg.orgnztTySe.value = "normal";
	}
		
	
	
	var formData = $("#frmOrg").serialize();
	
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}" />/mngr/module/orgnztInfo/registOrgnztInfoAjax.do'
		 , data:formData
		 , success:function (data) {
			  if(data.head.result == 'success'){
				 alert('<spring:message code="wzwg.module.word.strecompt"/>');
				 //location.reload();
				 
				 fnGetOrgInfoDataList(orgInfoSeq);
			  	 wzModalClose();	
			  }else{
				  alert('<spring:message code="wzwg.module.word.strefailr"/>')
			  }
			 //console.log(data);
		 }
		 , dataType: 'html'
	});
	
}

function selectPointCol(col){
	$('#frmOrg #cssClssNm').val(col);
}
</script>

<form id="frmOrg" name="frmOrg" method="post" >
	<input type="hidden" id="orgnztLv" name="orgnztLv" value="<c:out value="${paramVO.orgnztLv}" />"/>
	<input type="hidden" id="parntsOrgnztSeq" name="parntsOrgnztSeq" value="<c:out value="${paramVO.orgnztSeq}" />"/>
	<input type="hidden" id="orgnztTySe" name="orgnztTySe" value=""/>
	<input type="hidden" id="cssClssNm" name="cssClssNm" value="bg-white"/>
	
	<select name="orgTySeGroupSel" id="orgTySeGroupSel" style="display: none;">
		<option value="n"><spring:message code="wzwg.cmm.word.gnrl"/></option><!-- 일반 -->
	</select>
	
	<table class="basic">
	<colgroup>
		<col style="width: 35%;">
		<col style="width: *;">
	</colgroup>
	<tbody>
	
			<tr>
				<th><spring:message code="wzwg.module.word.orgnztchartnm"/>(<spring:message code="wzwg.cmm.word.korean"/>)
					<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
					</span>
				</th>
				<td><input name="orgnztNmKr" id="orgnztNmKr" class="w70" placeholder="<spring:message code="wzwg.module.word.orgnztchartnm" />(<spring:message code="wzwg.cmm.word.korean" />)" dir="required" title="<spring:message code="wzwg.module.word.orgnztchartnm" />(<spring:message code="wzwg.cmm.word.korean" />)" maxlength="20"></td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.module.word.orgnztchartnm"/>(<spring:message code="wzwg.cmm.word.eng"/>)
					<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
					</span>
				</th>
				<td><input name="orgnztNmEn" id="orgnztNmEn" class="w70" placeholder="<spring:message code="wzwg.module.word.orgnztchartnm" />(<spring:message code="wzwg.cmm.word.eng" />)" dir="required" title="<spring:message code="wzwg.module.word.orgnztchartnm" />(<spring:message code="wzwg.cmm.word.eng" />)"></td>
			</tr>
			<tr>
			<th><spring:message code="wzwg.module.word.jobintrcn"/>(<spring:message code="wzwg.cmm.word.korean"/>)</th>
				<td>
					<textarea name="orgnztDcKr" id="orgnztDcKr" class="w90" placeholder="<spring:message code="wzwg.module.word.jobintrcn" />(<spring:message code="wzwg.cmm.word.korean" />)"  title="<spring:message code="wzwg.module.word.jobintrcn" />(<spring:message code="wzwg.cmm.word.korean" />)"></textarea>
					<script type="text/javascript">
							
							nhn.husky.EZCreator.createInIFrame({
								oAppRef: oEditors,
								elPlaceHolder: "orgnztDcKr",
								sSkinURI: "<c:out value="${wzwg_contextPath}" />/smartEditor2.8.2.1/smartEditor2Skin.do",
								fCreator: "createSEditor2",
								htParams: {fOnBeforeUnload : function(){},aAdditionalFontList : [['NanumSquareR', 'NanumSquareR']]}
							});
					</script>
				</td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.module.word.jobintrcn"/>(<spring:message code="wzwg.cmm.word.eng"/>)</th>
				<td>
					<textarea name="orgnztDcEn" id="orgnztDcEn" class="w90" placeholder="<spring:message code="wzwg.module.word.jobintrcn" />(<spring:message code="wzwg.cmm.word.eng" />)"  title="<spring:message code="wzwg.module.word.jobintrcn" />(<spring:message code="wzwg.cmm.word.eng" />)"></textarea>
					<script type="text/javascript">
							
							nhn.husky.EZCreator.createInIFrame({
								oAppRef: oEditors,
								elPlaceHolder: "orgnztDcEn",
								sSkinURI: "<c:out value="${wzwg_contextPath}" />/smartEditor2.8.2.1/smartEditor2Skin.do",
								fCreator: "createSEditor2",
								htParams: {fOnBeforeUnload : function(){},aAdditionalFontList : [['NanumSquareR', 'NanumSquareR']]}
							});
					</script>	
				</td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.module.word.pointcolor"/></th>
				<td>
					<div class="orgInfoColList">
						<ul>
							<c:forEach items="${fn:split(pointColList, ',') }" var="list">
							<li class="fn i-block mb10"><button type="button" class="<c:out value="${list }" />"  onclick="selectPointCol('<c:out value="${list }" />')"></button></li>
							</c:forEach>
						</ul>
						<ul>
							<c:forEach items="${fn:split(pointColStrList, ',') }" var="list">
							<li class="fn i-block mb10"><button type="button" class="<c:out value="${list }" />"  onclick="selectPointCol('<c:out value="${list }" />')"></button></li>
							</c:forEach>
						</ul>
					</div>
				</td>
			</tr>
	</tbody>
	</table>

	<div class="rt-box">
		<button type="button" onmousedown="fnRegistOrgInfo();" class="wzbtn btn-save bg"><spring:message code="wzwg.cmm.word.stre" /></button> 
	</div>

</form>
