<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>     

<script type="text/javascript">
try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.module.word.dayschdul" />';}catch(e){console.log(e.message);}

$('#contentsCaption').html($('#menuNm').val() + '<spring:message code="wzwg.module.word.dayschdul" />');

	function fnPreview(schdetaSeq, schdulCntntsSe, connCntntsSeq) {
		
		if('<c:out value="${sessionScope.loginVO}"/>' == ''){
			return;			
		}
		
		var subUrl = "";
		
		if(schdulCntntsSe == "schdul"){	// 일정
			subUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/schdul/selectSchdulNttPreviewAjax.do';
			document.detailForm.schdetaSeq.value = schdetaSeq;
		}
		
		if(schdulCntntsSe == "onreqst"){	// 온라인신청
			subUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/onlineReqst/selectOnlineReqstNttPreviewAjax.do';
			document.detailForm.reqstnttSeq.value = schdetaSeq;
			document.detailForm.reqstSeq.value = connCntntsSeq;
		}
		
		if(schdulCntntsSe == "qustnr"){	// 온라인설문
			//subUrl = '<c:out value="${prefix}"/>/module/ntt/schdul/selectSchdulNttPreviewAjax.do';
			alert('Preparing !!');
			return;
		}
		
		$('body').css({overflow:'hidden'});
		
		$.ajax({
	        type:'POST'
	      , url:subUrl
	      , async : true
	      , data:$("#detailForm").serialize()
	      , success:function (data) {  
	    	  $("#divLayerPopup").html(data);
	    	  $("#divLayerPopup").show();
	      }
	      , error:function (request, status, error) {
	 	     alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
		
	}
	
	
</script>
	
	<form id="detailForm" name="detailForm" method="post">
		<input type="hidden" name="schdetaSeq" id="schdetaSeq" value=""/>
		<input type="hidden" name="siteSeq" value="<c:out value='${paramVO.siteSeq}'/>" />
		<input type="hidden" name="schdulSeq" value="<c:out value='${paramVO.schdulSeq}'/>" />
		<input type="hidden" name="reqstSeq" />
		<input type="hidden" name="reqstnttSeq" />
	</form>
	
	<div class="layer1">
		<div class="pop-id-sch">
			<button class="close" type="button" onclick="fnLayerPopupClose();"><img src="/images/wzwg/site/mngr/pop-close.png" alt="<spring:message code="wzwg.cmm.word.close" />" /></button>
			<span><spring:message code="wzwg.module.word.schdullist" /></span>
		</div>
		<div class="pop-container">
			<div class="pop-conts">
				<form  method="post">
				<table class="basic-table02">
					<caption id="contentsCaption"><spring:message code="wzwg.module.word.dayschdul" /></caption>
					<colgroup>
						<col width="20%;"/>
						<col width="*"/>
					</colgroup>
					<thead>
						<tr>
							<th scope="col" >No</th>
							<th scope="col" ><spring:message code="wzwg.module.word.schdulnm" /></th>
						</tr>
					</thead>
					<tbody>
					<c:choose>
						<c:when test="${!empty schdulList }">
						<c:forEach items="${schdulList }" var="resultList" varStatus="status">
							<tr>
								<td>
									<c:out value="${status.count }"/>
								</td>
								<td class="txt-l">
									<a href="javascript:void(0);" onclick="fnPreview('<c:out value="${resultList.schdetaSeq}"/>', '<c:out value="${resultList.schdulCntntsSe}"/>', '<c:out value="${resultList.connCntntsSeq}"/>');">
										<c:out value="${resultList.schdulNm }"/>
									</a>
								</td>
							</tr>
						</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="2"><spring:message code="wzwg.cmm.msg.MSG217" /></td> 
							</tr>
						</c:otherwise>
					</c:choose>
					</tbody>
				</table>
				</form>
					
				<div class="ctr-box">
					<a href="javascript:void(0);" class="btn-b" onclick="fnLayerPopupClose();"><spring:message code="wzwg.cmm.word.close" /></a>
				</div>
			</div>
		</div>
	</div>
