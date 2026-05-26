<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>


<script type="text/javascript">
	$(document).ready(function(e){
		$('#addTemplateList').draggable({ handle: "#addTemplateListMoveHanler" });
		$("#addTemplateListMoveHanler").css('cursor', 'move');
	});
	
	/** 컨텐츠 템플릿 미리보기 */
	function fn_cntntsTmplatPrevew(paramSeq){
		var frm = document.frmPopup;
		frm.tmplatSeq.value = paramSeq;
		
		var frmResult = window.open("", "popForm", "width=800,height=600,toolbars=no,menubars=no,scrollbars=yes");
		
		frm.target='popForm';
		frm.action='<c:out value="${wzwg_contextPath}"/>/sysMngr/cntntsMngr/cntntnsTmplat/selectCntntsTmplatPrevewPopup.do';
		frm.submit();
	}

	function fnTmplatChange(paramSeq, paramFileId){
		if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006">'+
				'<spring:argument><spring:message code="wzwg.cmm.word.template" /></spring:argument>'+
				'<spring:argument><spring:message code="wzwg.cmm.word.applc" /></spring:argument>'+
			  '</spring:message>\n<spring:message code="wzwg.cmm.msg.MSG429" />')){
			return;
		}else {
			
	        $('#tmplatSeq').val(paramSeq);
	        
	       $.ajax({
	              type : 'POST'
	            , dataType: 'html'
	            , url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/cntntsEditor/selectCntntsCnAjax.do'
	            , cache : false
	            , async : false
	            , data: {tmplatSeq:paramSeq}
	            , success:function (data) {
		    		  oEditors.getById["cntntsCn"].exec("SET_IR", [""]);
		    		  oEditors.getById["cntntsCn"].exec("PASTE_HTML", [data.cntntsCnVO.tmplatCn]);
		    		  fnTmplatDivChange(data.cntntsCnVO.tmplatSeq, data.cntntsCnVO.atchFileId, data.cntntsCnVO.tmplatSj);
			    	  wzModalClose();
	
	            }
	            , error:function (data) {
	                alert('<spring:message code="fail.common.msg" text="error" />');
	            }
	        });
		}
		
	}	
	
	/*
	function fnNewTempltReload(){
		$.ajax({
            type : 'POST'
          , dataType: 'json'
          , url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/cntntsEditor/registModuleCntntsCnTemplatInitAjax.do'
          , data:$("#cntntsFrm").serialize()
          , success:function (data) {
        	  console.log(data);
              var result = data.head.result;
              
              if (result == 'success') {
                  alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.applc" /></spring:argument></spring:message>');
                  var cntntsCnSeq = data.body.cntntsCnSeq;
                  fn_modifyCntntsCnForm(cntntsCnSeq);
              } else {
                  alert('<spring:message code="wzwg.cmm.msg.MSG099" />');
              }
          }
          , error:function (data) {
              alert('<spring:message code="fail.common.msg" text="error" />');
          }
      });
	}
	*/
	function fnBgcolorChange(val) {
		//$("div[id^=tmplat_area_]").css("background-color","#fff");
		//$("#tmplat_area_"+val).css("background-color","#ccc");
		$("div[id^=tmplat_area_]").removeClass('bg-blue');
		$("#tmplat_area_"+val).addClass('bg-blue');
	}

</script>


		<form name="frmPopup" id="frmPopup" method="post">
			<input type="hidden" name="tmplatSeq" id="tmplatSeq" value=""/> 
			
			<c:choose>
				<c:when test="${!empty resultList }">
					<c:forEach var="resultList" items="${resultList}" varStatus="status">
			
					<div id="tmplat_area_<c:out value='${status.count}'/>" class="template" >
		
						<div class="pd20<c:if test="${paramVO.tmplatSeq eq resultList.tmplatSeq}"> bg-blue</c:if>">
							<h4><c:out value="${resultList.tmplatSj}"/></h4>
							
							<div class="tem-img pb20" style="">
								<div>
									<a href="javascript:void(0);" onclick="fn_cntntsTmplatPrevew('<c:out value="${resultList.tmplatSeq}"/>');">
										<img src='<c:url value='/module/upload/file/selectImageView.do'/>?atchFileId=<c:out value="${resultList.atchFileId }"/>&fileSn=0' style="width:250px;height:155px;"/>
									</a>
								</div>
							</div>
							<div class="tem-list" style="">
								<div class="rt-box">
									 <a href="javascript:void(0);" onclick="fnTmplatChange('<c:out value="${resultList.tmplatSeq}"/>','<c:out value="${resultList.atchFileId }"/>');" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.apply" /></a> 
								</div>
							</div>
						</div>
		
					</div> 
					
					</c:forEach>
				</c:when>
				<c:otherwise>
					<h3><spring:message code="wzwg.cmm.msg.MSG240" /></h3>
				</c:otherwise>
			</c:choose>
			
		</form>
		
	