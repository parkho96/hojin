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

/*  수정   */
function fnModifyOrgInfo(){
	
	if(!Validator.validate(document.frmOrg)){
		return;
	}
	
	$('#orgnztDcKr').val(oEditors.getById["orgnztDcKr"].getIR());
	$('#orgnztDcEn').val(oEditors.getById["orgnztDcEn"].getIR());
	
	var formData = $("#frmOrg").serialize();
	
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}" />/mngr/module/orgnztInfo/modifyOrgnztInfoAjax.do'
		 , data:formData
		 , success:function (data) {
			  if(data.head.result == 'success'){
				 alert('<spring:message code="wzwg.cmm.word.stre"/><spring:message code="wzwg.cmm.word.compt"/>');
				 //location.reload();
				 
				 fnGetOrgInfoDataList();
			  	 wzModalClose();	
			  }else{
				  alert('<spring:message code="wzwg.cmm.word.stre"/><spring:message code="wzwg.cmm.word.failr"/>');
			  }
			 //console.log(data);
		 }
		 , dataType: 'html'
	})
}


/*  삭제   */
function fndeleteOrgInfo(){
	var formData = $("#frmOrg").serialize();

	//if(confirm("<spring:message code="wzwg.cmm.module.org.MSG027"/>\n<spring:message code="wzwg.cmm.module.org.MSG028"/>")){
		if(confirm("<spring:message code="wzwg.cmm.module.org.MSG029"/>")){
			$.ajax({
				   type:'POST'
				 , url:'<c:out value="${wzwg_contextPath}" />/mngr/module/orgnztInfo/deleteOrgnztInfoAjax.do'
				 , data:formData
				 , success:function (data) {
					  if(data.head.result == 'success'){
						 alert('<spring:message code="wzwg.cmm.word.delete"/><spring:message code="wzwg.cmm.word.compt"/>');
						 //location.reload();
						 
						 fnGetOrgInfoDataList();
					  	 wzModalClose();	
					  }else if(data.head.result == 'useMem'){
						  alert('<spring:message code="wzwg.cmm.module.org.MSG032"/>');
					  }else if(data.head.result == 'useGrp'){
						  alert('<spring:message code="wzwg.cmm.module.org.MSG033"/>');
					  }else{
						  alert('<spring:message code="wzwg.module.word.deletefailr" />');
					  }
				 }
				 , dataType: 'html'
			})
		}else{
			return;
		}
	//}else{
	//	return;
	//}
}

function selectPointCol(col){
	$('#frmOrg #cssClssNm').val(col);
}

</script>

<form id="frmOrg" name="frmOrg" method="post" >
<input type="hidden" id="orgnztSeq" name="orgnztSeq" value="<c:out value="${orgnztInfoVO.orgnztSeq}" />"/>
<input type="hidden" id="cssClssNm" name="cssClssNm" value="<c:out value="${orgnztInfoVO.cssClssNm}" />"/>
	
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
				<th><spring:message code="wzwg.cmm.word.orgnztchart"/><spring:message code="wzwg.cmm.word.nm01"/>(<spring:message code="wzwg.cmm.word.korean"/>)</th>
				<td><input name="orgnztNmKr" id="orgnztNmKr" class="w70" placeholder="<spring:message code="wzwg.module.word.orgnztchartnm" />(<spring:message code="wzwg.cmm.word.korean" />)" dir="required" title="<spring:message code="wzwg.module.word.orgnztchartnm" />(<spring:message code="wzwg.cmm.word.korean" />)" maxlength="20" value="<c:out value="${orgnztInfoVO.orgnztNmKr}" />"></td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.cmm.word.orgnztchart"/><spring:message code="wzwg.cmm.word.nm01"/>(<spring:message code="wzwg.cmm.word.eng"/>)</th>
				<td><input name="orgnztNmEn" id="orgnztNmEn" class="w70" placeholder="<spring:message code="wzwg.module.word.orgnztchartnm" />(<spring:message code="wzwg.cmm.word.eng" />)"  title="<spring:message code="wzwg.module.word.orgnztchartnm" />(<spring:message code="wzwg.cmm.word.eng" />)" value="<c:out value="${orgnztInfoVO.orgnztNmEn}" />"></td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.cmm.word.job"/><spring:message code="wzwg.cmm.word.intrcn"/>(<spring:message code="wzwg.cmm.word.korean"/>)</th>
				<td>
					<textarea name="orgnztDcKr" id="orgnztDcKr" class="w90" placeholder="<spring:message code="wzwg.module.word.jobintrcn" />(<spring:message code="wzwg.cmm.word.korean" />)" title="<spring:message code="wzwg.module.word.jobintrcn" />(<spring:message code="wzwg.cmm.word.korean" />)"><c:out value="${orgnztInfoVO.orgnztDcKr}" /></textarea>
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
				<th><spring:message code="wzwg.cmm.word.job"/><spring:message code="wzwg.cmm.word.intrcn"/>(<spring:message code="wzwg.cmm.word.eng"/>)</th>
				<td>
					<textarea name="orgnztDcEn" id="orgnztDcEn" class="w90" placeholder="<spring:message code="wzwg.module.word.jobintrcn" />(<spring:message code="wzwg.cmm.word.eng" />)" title="<spring:message code="wzwg.module.word.jobintrcn" />(<spring:message code="wzwg.cmm.word.eng" />)"><c:out value="${orgnztInfoVO.orgnztDcEn}" /></textarea>
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
				<th><spring:message code="wzwg.cmm.word.point"/> <spring:message code="wzwg.cmm.word.color"/></th>
				<td>
					<div class="orgInfoColList">
						<ul>
							<c:forEach items="${fn:split(pointColList, ',') }" var="list">
							<li class="fn i-block mb10 <c:if test="${orgnztInfoVO.cssClssNm eq list}"> chk</c:if>"><button type="button" class="<c:out value="${list }" />"  onclick="selectPointCol('<c:out value="${list }" />')"></button></li>
							</c:forEach>
						</ul>
						<ul>
							<c:forEach items="${fn:split(pointColStrList, ',') }" var="list">
							<li class="fn i-block mb10" <c:if test="${orgnztInfoVO.cssClssNm eq list}"> chk</c:if>><button type="button" class="<c:out value="${list }" />"  onclick="selectPointCol('<c:out value="${list }" />')"></button></li>
							</c:forEach>
						</ul>
					</div>
				</td>
			</tr>
	</tbody>
	</table>

	<div class="rt-box">
		<button type="button" onclick="fnModifyOrgInfo();" class="wzbtn btn-save bg"><spring:message code="wzwg.cmm.word.stre" /></button>
		<c:if test="${orgnztInfoVO.orgnztLv > 1 }">
		<button type="button" onclick="fndeleteOrgInfo();" class="wzbtn btn-red-bg fl"><spring:message code="wzwg.cmm.word.delete" /></button>  
		</c:if>
	</div>
</form>
