<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>


<script>

$(document).ready(function(){
	fnUpDownBtnDesabled();
});

function fnUpDownBtnDesabled(){
	$('#categoryTable .ftrordBtns:first button:first').css('color', '#ccc');
	$('#categoryTable .ftrordBtns:first button:first').attr('disabled', 'disabled');
	$('#categoryTable .ftrordBtns:last button:last').css('color', '#ccc');
	$('#categoryTable .ftrordBtns:last button:last').attr('disabled', 'disabled');
}

function fnCategoryRegForm(ctgryCd){
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/module/beffatPlbc/selectBeffatPlbcCategoryRegFrmAjax.do'
		 , data:{'ctgryCd':ctgryCd} 
		 , success:function (data) {
			 			wzAjaxModal('popup_s', '<spring:message code="wzwg.module.word.publictinfoctgryestbs" />', data);
				   }
		 , dataType: 'html'
	});
}

function fnThumbCheck(){
	//console.log('fnThumbCheck');
	if($('#thumbFile').val() == ''){
		$('#thumbFile_preview').attr('src', '/images/wzwg/site/mngr/no-img.png');
	}
}


function fnCategoryRegForm(ctgryCd){
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/module/beffatPlbc/selectBeffatPlbcCategoryRegFrmAjax.do'
		 , data:{'ctgryCd':ctgryCd} 
		 , success:function (data) {
			 			wzAjaxModal('popup_s', '<spring:message code="wzwg.module.word.publictinfoctgryestbs" />', data);
				   }
		 , dataType: 'html'
	});
}

function fnCategoryRegist(command){
	
	if($('#ctgryDcCn').val() == ''){
		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.module.word.clnm" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
		$('#ctgryDcCn').focus();
		return;
	}
	
	
	if($('#thumbFile').val() != ''){
	    if(typeof thumbFile != "undefined" && thumbFile != null) {
	    	thumbFile = thumbFile.value;
	    	
	        thumbFile = thumbFile.slice(thumbFile.lastIndexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로 만듭니다.

	        if(thumbFile != "jpg" && thumbFile != "png" && thumbFile != "gif"){ //확장자를 확인합니다.
	            alert('<spring:message code="wzwg.cmm.msg.MSG126" />');
	        	$("#btn_thumbFile").focus();
	            return;
	        }
	    }
	}else{
		//등록일때만
		if(command == 'R'){
			alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.module.word.iconfile" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.atch" /></spring:argument></spring:message>');
			$("#btn_thumbFile").focus();
	        return;
		}
	}
	
	var frm = $("#categoryRegForm");
	
	var callUrl = '';
	if(command == 'R'){
		callUrl = '<c:out value="${wzwg_contextPath}"/>/mngr/module/beffatPlbc/registBeffatPlbcCategoryAjax.do'
	}else if(command == 'M'){
		callUrl = '<c:out value="${wzwg_contextPath}"/>/mngr/module/beffatPlbc/modifyBeffatPlbcCategoryAjax.do'
	}
	
	frm.ajaxSubmit({
		type:'POST'
		, url:callUrl
		, async: false
        , data: frm 
        , mimeType: 'multipart/form-data'
		, success:function(data){
			//console.log(data);
			if(data.head.result == 'success'){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
				wzModalClose();
				fnTabLink('category');
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


function fn_categoryModifyOrdr(ordr, ctgryCd){
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/module/beffatPlbc/ModifyBeffatPlbcCategoryOrdrAjax.do'
		 , data:{'ordr':ordr, 'ctgryCd' : ctgryCd} 
		 , success:function (data) {
			 //console.log(data);
			 	if(data.head.result == 'success'){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.change" /></spring:argument></spring:message>');
					fnTabLink('category');
				}else if(data.head.msg == '001' && ordr == 'U'){
					alert('<spring:message code="wzwg.cmm.msg.MSG176" />');
				}else if(data.head.msg == '001' && ordr == 'D'){
					alert('<spring:message code="wzwg.cmm.msg.MSG175" />');
				}else{	
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.change" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
				}
		 }
		 , dataType: 'json'
	});
}

function fnCategoryDelete(ctgryCd){
	var ctgryNm = $('td[data-ctgrycd="' + ctgryCd + '"]').html();
	if(confirm('<spring:message code="wzwg.cmm.msg.MSG440" />\n[' + ctgryNm + '] <spring:message code="wzwg.cmm.cmmMsg.CMG006"><spring:argument><spring:message code="wzwg.cmm.word.ctgry02" /> <spring:message code="wzwg.cmm.word.iem" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
		$.ajax({
			   type:'POST'
			 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/module/beffatPlbc/deleteBeffatPlbcCategoryAjax.do'
			 , data:{'ctgryCd' : ctgryCd} 
			 , success:function (data) {
				 //console.log(data);
				 	if(data.head.result == 'success'){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
						fnTabLink('category');
					}else{	
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.change" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
					}
			 }
			 , dataType: 'json'
		});
	}
}
</script>

<div class="rt-box">
<button type="button" class="wzbtn btn-save" onclick="fnCategoryRegForm()"><spring:message code="wzwg.cmm.word.regist" /></button>
</div>

<table class="basic-table" id="categoryTable">
	<colgroup>
		<col width="10%"/>
		<col width="*"/>
		<col width="*"/>
		<col width="15%"/>
		<col width="10%"/>
	</colgroup>
	<thead>
		<tr>
			<th>No</th>
			<th><spring:message code="wzwg.module.word.clnm" /></th>
			<th><spring:message code="wzwg.cmm.word.icon" /></th>
			<th><spring:message code="wzwg.cmm.word.ordr" /></th>
			<th><spring:message code="wzwg.cmm.word.rm" /></th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${catrgoryList }" var="list" varStatus="status">
		<tr>
			<td><c:out value="${status.count }"></c:out></td>
			<td data-ctgrycd="<c:out value='${list.ctgryCd }'/>"><c:out value="${list.ctgryDcCn }"></c:out></td>
			<td>
				<c:if test="${not empty list.storFileId }">
				<img src="<c:out value='${wzwg_contextPath}'/>/module/upload/file/selectImageView.do?atchFileId=<c:out value='${list.storFileId }'/>&fileSn=0" style="height: 85px;">
				</c:if>
				<c:if test="${empty list.storFileId }">
				<img src="/images/wzwg/site/noImg/noImageLogo_s.jpg" style="height: 85px;">
				</c:if>
			</td>
			<td class="ftrordBtns">
				<button class="btn-basic iconOnlyBtn btn-sortUp" onclick="fn_categoryModifyOrdr('D','<c:out value="${list.ctgryCd}"/>')" title="<spring:message code="wzwg.cmm.word.up"/>">▲</button>
				<button class="btn-basic iconOnlyBtn btn-sortDown" onclick="fn_categoryModifyOrdr('U','<c:out value="${list.ctgryCd}"/>')" title="<spring:message code="wzwg.cmm.word.down"/>">▼</button>
			</td>
			<td class="txt-c">
				<button type="button" class="iconOnlyBtn btn-basic btn-modify" onclick="fnCategoryRegForm('<c:out value="${list.ctgryCd}"/>')"><spring:message code="wzwg.cmm.word.updt" /></button>
				<c:if test="${list.ctgryCd ne 'ALL' }">
				<button type="button" class="iconOnlyBtn btn-basic btn-delete" onclick="fnCategoryDelete('<c:out value="${list.ctgryCd}"/>')">삭제</button>
				</c:if>
			</td>
		</tr>		
		</c:forEach>
	</tbody>
</table>