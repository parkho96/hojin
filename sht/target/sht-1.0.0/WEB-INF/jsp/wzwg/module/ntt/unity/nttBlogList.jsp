<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<% 
	String getUrl = request.getServerName().toString();
	String getPort = String.valueOf(request.getServerPort());
	if(getPort.equals("80")){getPort="";} else {getPort= ":"+getPort;}
%>

<script src="/clipboard/dist/clipboard.min.js"></script>

<script type="text/javascript">
try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.cmm.word.list" />';}catch(e){console.log(e.message);}

	<c:if test="${!empty authorMessage}">
		alert('<c:out value="${authorMessage}"/>');
		history.go(-1);
	</c:if>

	function fnSubospecSeq(subospecSeq) {
	    $('#subospecSeq').val(subospecSeq);
	    fnCallSubospecList();
	}

	function fnCallSubospecList() {
	    
	    var frm = document.listFrm;

	    frm.pageIndex.value = 1;
	    
	    $.ajax({
	          type : 'POST'
	        , dataType: 'html'
	        , url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/unity/selectNttListAjax.do'
	        , cache : false
	        , async : false
	        , data:$("#listFrm").serialize()
	        , success:function (data) {
	            $('#bbs_area').html(data);
	            
	            if($('#tabBtn-' + $('#subospecSeq').val()).length > 0){
	            	$('#tabBtn-' + $('#subospecSeq').val()).focus();
	            }
	            
	            if($('#btn_subospecSeq').length > 0){
		            $('#btn_subospecSeq').focus();
	            }
	        }
	        , error:function (data) {
	            alert('<spring:message code="fail.common.msg" text="error" />');
	        }
	    });
	}
	
	$(document).ready(function(){
		$('#contentsCaption').html($('#menuNm').val() + ' <spring:message code="wzwg.module.word.postlist" />');
		
		// 글쓰기
		$('#regist_form_btn').click(function(){
			
			$.ajax({
				  type : 'POST'
				, dataType: 'html'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/unity/registNttFormAjax.do'
				, cache : false
				, async : false
				, data:$("#listFrm").serialize()
				, success:function (data) {
					$('#bbs_area').html(data);
					$("#content").css("height",$(document).height());
					$(window).scrollTop(0);
					
				}
				, error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});
			
		});
		
		// 말머리 선택
		$('#btn_subospecSeq').click(function(){
			fnCallSubospecList();
		});
		
		// 말머리 수정
		$('#subospec_modify_btn').click(function(){
			var checkCnt = 0;
			var nttChkArr = "";

			$("input[name=nttChk]").each(function(){
				if(this.checked){
					nttChkArr += $(this).val() + ",";
					checkCnt++;
				}
			});
			
			if(checkCnt < 1){
				alert('<spring:message code="wzwg.cmm.msg.MSG087" />');
				return;
			}
			
			var frm = document.listFrm;
			
			frm.checkNttSeq.value = nttChkArr;
			
			$('body').css({overflow:'hidden'});
			
			$.ajax({
		        type:'POST'
		      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cmmn/modifySubospecPopup.do'
		      , cache : false
		      , async : false
		      , data:$("#listFrm").serialize()
		      , success:function (data) {
		    	  //$("#bbs_layer").show();
		    	  //$("#bbs_layer").html(data);
		    	  var title = '<spring:message code="wzwg.module.word.ctgryupdt" />';
		    	  wzAjaxModal('popup_s', title, data);
		      }
		      , error:function (request, status, error) {
		    	  alert('<spring:message code="fail.common.msg" text="error" />');
		      }
		      , dataType: 'html'
		 	});
		});
		
		// 삭제
		$('#delete_btn').click(function(){
			if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
				return;
			}else{
				var checkCnt = 0;
				var nttChkArr = "";

				$("input[name=nttChk]").each(function(){
					if(this.checked){
						nttChkArr += $(this).val() + ",";
						checkCnt++;
					}
				});
				
				if(checkCnt < 1){
					alert('<spring:message code="wzwg.cmm.msg.MSG087" />');
					return;
				}
					
				var frm = document.listFrm;
				
				frm.checkNttSeq.value = nttChkArr;
				
				$.ajax({
  					type:'POST'
					, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/unity/deleteNttInfoAjax.do'
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
							fnPage(1);
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
						}
   					}
				   , error:function (request, status, error) {
				 	  alert('<spring:message code="fail.common.msg" text="error" />');
				   }
				   , dataType: 'xml'
				});
			}
		});
		
		// 체크박스 전체선택 / 해제
		$("input[name=nttAllChk]").on('click', function(){
			var boolean_chk = $("input[name=nttAllChk]").get(0).checked;
			$("input[name=nttChk]").each(function(){
				this.checked = boolean_chk;
			});
		});		
		
		//$("#listCount").change(function(){
		//	fnPage(1);
		//});
		
	});
	
	function fnListCountChange(){
		fnPage(1);
		$('#btn-listCount').focus();
	}
	
	// 삭제
	function fnNttDelete(nttSeq){
		var frm = document.listFrm;
		
		frm.nttSeq.value = nttSeq;
		
		$.ajax({
				type:'POST'
			, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/unity/deleteNttInfoAjax.do'
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
					fnPage(1);
				}else{
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
				}
				}
		   , error:function (request, status, error) {
		 	  alert('<spring:message code="fail.common.msg" text="error" />');
		   }
		   , dataType: 'xml'
		});
	}
	
	// 수정 화면
	function fnModifyFormPage(nttSeq){
		var frm = document.listFrm;
		
		frm.nttSeq.value = nttSeq;
		
		$.ajax({
	        type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/unity/modifyNttFormAjax.do'
			, dataType : 'html'
			, data : $("#listFrm").serialize()
			, success : function (data) {
				$('#bbs_area').html(data);
				$("#content").css("height",$(document).height());
				$(window).scrollTop(0);
			}
			, error : function (request, status, error) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
		});
	}
	
	// 상세정보
	function fnView(nttSeq, ntcrId, secretAt, parntsNttSeq){
		
		var viewAt = "N";
		
		if(secretAt == 'Y') {
			if('<c:out value="${loginVO.userId}"/>' == ntcrId || '<c:out value="${sessionScope.SADMIN_AT}"/>' == 'true' || '<c:out value="${sessionScope.NADMIN_AT}"/>' == 'true'){
				viewAt = "Y";
			} else {
				viewAt = fnNtcrIdCheck(parntsNttSeq);	
			}
		} else {
			viewAt = "Y";
		}

		if(viewAt == "Y"){
			var frm = document.listFrm;
			
			frm.nttSeq.value = nttSeq;
			frm.parntsNttSeq.value = parntsNttSeq;
			frm.secretAt.value = secretAt;
			
			$.ajax({
				  type : 'POST'
				, dataType: 'html'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/unity/selectNttDetailAjax.do'
				, cache : false
				, async : false
				, data:$("#listFrm").serialize()
				, success:function (data) {
					$('#bbs_area').html(data);
			     	$("#content").css("height",$(document).height());
			     	$(window).scrollTop(0);
				}
				, error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});				
		} else {
			alert('<spring:message code="wzwg.cmm.msg.MSG004" />');
			return;			
		}		
	}	
	
	function fnNtcrIdCheck(nttSeq) {
		var viewAt = "N";
		
		$.ajax({
			  type : 'POST'
			, dataType: 'xml'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cmmn/selectNttNtcrIdAjax.do'
			, cache : false
			, async : false
			, data:"nttSeq="+nttSeq
			, success:function (result) {
				$(result).find("value").each(function() {  
					value = $(this).text();  
				});

				if(value != '<c:out value="${loginVO.userId}"/>'){
					viewAt = "N";
				} else {
					viewAt = "Y";
				}
			}
			, error : function (request, status, error) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});			
		return viewAt;
	}
	
	function fnSearch(callId){
		var frm = document.listFrm;
		
		frm.searchAt.value = "";
		
		if(frm.searchKeyword.value != ""){
			frm.searchAt.value = "Y";	
		}
		
		frm.pageIndex.value = 1;
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/unity/selectNttListAjax.do'
			, cache : false
			, async : false
			, data:$("#listFrm").serialize()
			, success:function (data) {
				$('#bbs_area').html(data);
				$("#content").css("height",$(document).height());
				//$(window).scrollTop(0);
				if(callId != undefined || callId != ''){
	            	$('#' + callId).focus();
	            }
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
	function fnPage(pageIndex){
		if(isNaN(pageIndex)){console.log('잘못된 페이지호출');return;}
		var frm = document.listFrm;
		
		frm.pageIndex.value = pageIndex;
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/unity/selectNttListAjax.do'
			, cache : false
			, async : false
			, data:$("#listFrm").serialize()
			, success:function (data) {
				$('#bbs_area').html(data);
				$("#content").css("height",$(document).height());
				//$(window).scrollTop(0);
				$('#pageInfo').find('.on>a').focus();
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
	// 공지 게시물 삭제
	function fnDelNotice(nttSeq){
		var frm = document.listFrm;
		
		frm.nttSeq.value = nttSeq;
		
		if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006"><spring:argument><spring:message code="wzwg.cmm.word.notice02" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
			$.ajax({
		        type:'POST'
		      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/unity/modifyNttNoticeAjax.do'
		      , cache : false
		      , async : false
		      , data:$("#listFrm").serialize()
		      , success:function (result) {
		    	  var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value == 'success'){
						fnPage(1);
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
					}
		      }
		      , error:function (request, status, error) {
		    	  alert('<spring:message code="fail.common.msg" text="error" />');
		      }
		      , dataType: 'xml'
		 	});
		}
	}
	
	// 댓글 팝업
	function fnAnswerPop(nttSeq, ntcrId, secretAt){
		
		if(secretAt == 'Y') {
			if('<c:out value="${loginVO.userId}"/>' != ntcrId && '<c:out value="${sessionScope.SADMIN_AT}"/>' != 'true' && '<c:out value="${sessionScope.NADMIN_AT}"/>' != 'true'){
				alert('<spring:message code="wzwg.cmm.msg.MSG004" />');
				return;
			}
		}		
		
		var frm = document.listFrm;
		
		frm.nttSeq.value = nttSeq;
		
		$('body').css({overflow:'hidden'});
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/answer/selectNttAnswerFormPopup.do'
	      , cache : false
	      , async : false
	      , data:$("#listFrm").serialize()
	      , success:function (data) {
	    	  $("#bbs_layer").show();
	    	  $("#bbs_layer").html(data);
	      }
	      , error:function (request, status, error) {
	    	  alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
	
	// 첨부파일 오픈
	function fnAtchFileOpen(nttSeq, atchFileId){
		
		if($("#atchFile_div_"+nttSeq).css('display') != 'none'){
			 $("#atchFile_div_"+nttSeq).hide();
		}else{
			
			$.ajax({
				type:'POST' 
				, url:'<c:out value="${wzwg_contextPath}"/>/module/upload/file/selectFileInc.do'
				, data:'param_atchFileId='+atchFileId+'&param_updateFlag=N'
				, success:function (data) {
					$("#atchFile_div_"+nttSeq).html(data);
					$("#atchFile_div_"+nttSeq).show();
				}
				, error:function (request, status, error) {
				 alert('<spring:message code="fail.common.msg" text="error" />');
				}
				, dataType: 'html'
			});
			
		}

	}
	
	function fnAdresCopy(nttSeq) {
		
		<c:set var="temp_menuSeq" value="${paramVO.menuSeq}" />
		var menuSeq = "<c:out value='${temp_menuSeq}'/>";
		
		$('#adres_copy_btn').attr('data-clipboard-text', 'http://<%=getUrl%><%=getPort%>/subList/' + menuSeq + '?pmode=detail&nttSeq=' + nttSeq);    
		var clipboard = new Clipboard('#adres_copy_btn');
	    clipboard.on('success', function(e) {
	        alert('<spring:message code="wzwg.cmm.msg.MSG083" />');
	        clipboard.destroy();
	    });
	    clipboard.on('error', function(e) {
	        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
	        return false;
	        clipboard.destroy();
	    });
	};		
	
	window.onkeydown = function() {

	    var keyCode = event.keyCode;

	    if(keyCode == 8
	    		&& 'INPUT'.indexOf(event.target.nodeName.toUpperCase()) == -1 
	    		&& 'TEXTAREA'.indexOf(event.target.nodeName.toUpperCase()) == -1) {

	    	fnPage(1);
	    	return false;
		}
	}	
	
	// 스크랩 버튼
	function fnNttScrapPop(nttSeq){
		
		$('#nttSeq').val(nttSeq);
		
		$.ajax({
	       type:'POST'
	        , dataType: 'xml'
			, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/scrap/selectNttScrapDplctChkAjax.do'
			, cache : false
			, data: $("#listFrm").serialize()
			, success:function (result) {
				var value = "";
				
				$(result).find("value").each(function() {  
					value = $(this).text();  
				});
				
				if(value == 'success'){
					$.ajax({
				        type:'POST'
				      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/scrap/registNttScrapPopup.do'
				      , cache : false
				      , async : false
				      , data:$("#listFrm").serialize()
				      , success:function (data) {
				    	  var title = '<spring:message code="wzwg.module.word.scrapregist" />';
				    	  wzAjaxModal('popup_s', title, data);
				      }
				      , error:function (request, status, error) {
				    	  alert('<spring:message code="fail.common.msg" text="error" />');
				      }
				      , dataType: 'html'
				 	});
				}else{
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG017"><spring:argument><spring:message code="wzwg.module.word.nttscrap" /></spring:argument></spring:message>');
					return;
				}
				
			}
			, error:function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
		
	}
	
	function fnNttMvmnPopup(nttSeq){
		
		$('#nttSeq').val(nttSeq);
		
		$('body').css({overflow:'hidden'});
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cmmn/mvmnNttPopup.do'
	      , cache : false
	      , async : false
	      , data:$("#listFrm").serialize()
	      , success:function (data) {
	    	  //$("#bbs_layer").show();
	    	  //$("#bbs_layer").html(data);
	    	  var title = '<spring:message code="wzwg.module.word.nttmvmn" />';
	    	  wzAjaxModal('popup_s', title, data);

	      }
	      , error:function (request, status, error) {
	    	  alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
	
</script>

		<c:set var="adminAuthAt" value="N"/>
		
		<c:if test="${resultVO.cmntUseAt eq 'Y'}">
			<c:if test="${sessionScope.cmntMngrAt == true}">
				<c:set var="adminAuthAt" value="Y"/>
			</c:if>
		</c:if>		

		<c:if test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or sessionScope.CNTNTS_ADMIN_AT}">
			<c:set var="adminAuthAt" value="Y"/>
		</c:if>
		
		<c:if test="${not empty resultVO.bbsPrface}">
		<div class="mb30">
			<c:out value='${resultVO.bbsPrface}' escapeXml="false" />
		</div>
		</c:if>		

		<form:form modelAttribute="paramVO" path="listFrm" id="listFrm" name="listFrm" method="post">
			<form:hidden path="siteSeq" />
			<form:hidden path="bbsSeq" />
			<form:hidden path="nttSeq" />
			<form:hidden path="pageIndex" />
			<form:hidden path="searchCnd" />	
			<form:hidden path="menuSeq" />
			<form:hidden path="mngrAt" />	
			<form:hidden path="parntsNttSeq" />	
			<form:hidden path="secretAt" />		
			<form:hidden path="searchAt" />
			<form:hidden path="checkNttSeq" />
			<form:hidden path="sitecntntsSeq" />
			<input type="hidden" name="cmntUseAt" id="cmntUseAt" value="<c:out value='${resultVO.cmntUseAt}'/>" />
			<form:hidden path="listScrinCode" />
						
			<form:hidden path="atchFilePosblAt" value="${fn:escapeXml(resultVO.atchFilePosblAt)}" />
			<form:hidden path="atchFilePosblCo" value="${fn:escapeXml(resultVO.atchFilePosblCo)}" />
			<c:set var="listCntSeTit"><spring:message code="wzwg.module.word.listcountse" /></c:set>			
			
			<div>
				<c:if test="${resultVO.cmntUseAt ne 'Y'}">
				<div class="main-menu-bar i-block">
					<c:import url="${wzwg_contextPath}${prefix}/module/bbs/cmmn/selectBbsSubospecSelectListAjax.do" charEncoding="utf-8">
						<c:param name="param_bbsSeq" value="${paramVO.bbsSeq}" />
						<c:param name="cateTy" value="${resultVO.cateTy}" />
					</c:import>
				</div>
				</c:if>
				
				<c:if test="${resultVO.listCountAt eq 'Y'}">
					<div style="float:right;">
					<form:select path="listCount" name="listCount" id="listCount" cssStyle="width:80px;margin-bottom:0px;" title="${fn:escapeXml(listCntSeTit)}">
						<c:forEach items="${countList}" var="countList">
							<form:option value="${fn:escapeXml(countList)}"><label for="list_count"><c:out value='${countList}'/><spring:message code="wzwg.cmm.word.count03" /></label></form:option>
						</c:forEach>
					</form:select>
					<button type="button" class="wzbtn btn-basic" id="btn-listCount" onclick="fnListCountChange()"><spring:message code="wzwg.cmm.word.change" /></button>
					</div>
				</c:if>
			</div>

			<h6 id="subospecSj_txt" class="hide-txt"><c:out value='${paramVO.subospecSj}'/><c:if test="${empty paramVO.subospecSj}"><spring:message code="wzwg.cmm.word.all" /></c:if></h6>
			
			<c:if test="${not empty noticeList}">
			
			<table class="basic-table01">
				<caption id="contentsCaption"><spring:message code="wzwg.module.word.postlist" /></caption>
				 <colgroup>
					<c:if test="${adminAuthAt eq 'Y'}">
						<col width="5%"/>						
					</c:if>
					<c:if test="${mobileAt eq 'N'}">
						<col width="10%"/>
						<col width="*"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="10%"/>
					</c:if>
					<c:if test="${mobileAt eq 'Y'}">
						<col width="*"/>
						<col width="20%"/>
						<col width="20%"/>
					</c:if>
			     </colgroup>
				 <thead>
					<tr>
						<c:if test="${adminAuthAt eq 'Y'}">
							<th scope="col"></th>					
						</c:if>
						<c:if test="${mobileAt eq 'N'}">
							<th scope="col"><spring:message code="wzwg.cmm.word.no" /></th>		
						</c:if>	
						<th scope="col"><spring:message code="wzwg.cmm.word.sj" /></th>
						<th scope="col"><spring:message code="wzwg.cmm.word.wrter" /></th>
						<th scope="col"><spring:message code="wzwg.cmm.word.rgsde02" /></th>
						<c:if test="${mobileAt eq 'N'}">
							<th scope="col"><spring:message code="wzwg.cmm.word.inqire" /></th>
						</c:if>							
					</tr>						
				</thead>
				<tbody>
					<!-- 공지 게시물 목록 -->
					<c:if test="${!empty noticeList && (paramVO.subospecSeq eq null or paramVO.subospecSeq eq '')}"> 
					<c:forEach var="noticeList" items="${noticeList}" varStatus="status">
					
					<c:set var="noticeDetAuthAt" value="" />
					
					<c:if test="${loginVO.usrSeq eq noticeList.ntcrSeq or nttAuthVO.authorSe eq 'R' or nttAuthVO.authorSe eq 'W' or adminAuthAt eq 'Y' or cmntAuthR eq 'Y' or cmntAuthW eq 'Y'}">
						<c:set var="noticeDetAuthAt" value="Y" />
					</c:if>						
					
					<tr>
						<c:if test="${adminAuthAt eq 'Y'}">
							<td>								
								<a title="<spring:message code="wzwg.module.word.noticepostsdelete" />" href="javascript:void(0);" onclick="fnDelNotice('${fn:escapeXml(noticeList.nttSeq)}');">
									<img src="/images/wzwg/cmm/btn-del.gif" alt="<spring:message code="wzwg.module.word.deleteicon" />" />
								</a>
							</td>
						</c:if>
						
						<c:if test="${mobileAt eq 'N'}">
						
					    <td><img src="/images/wzwg/cmm/ico-list-notice.gif" alt="<spring:message code="wzwg.module.word.noticeicon" />" /></td>
					    
					    </c:if>
					    
						<td class="txt-l">
							
							<c:choose>
								<c:when test="${!empty noticeList.nttSj}">
									<c:if test="${fn:length(noticeList.nttSj) > 43}">
										<c:set var="nttSj" value="${fn:substring(noticeList.nttSj, 0, 43)}..." />
									</c:if>
									<c:if test="${fn:length(noticeList.nttSj) < 44}">
										<c:set var="nttSj" value="${noticeList.nttSj}" />
									</c:if>
								</c:when>
								<c:otherwise>
									<c:set var="nttSj"><spring:message code="wzwg.cmm.word.untitle"/></c:set>
								</c:otherwise>
							</c:choose>
							
							<c:if test="${!empty noticeList.subospecSj}">
								<span class="red fw900">
									[<c:out value="${noticeList.subospecSj}"/>]
								</span>
							</c:if>
							
							<c:if test="${noticeList.secretAt eq 'Y'}">
								<img src="/images/wzwg/module/ntt/ico-secret.png" alt="<spring:message code="wzwg.module.word.secretposts" />" />
							</c:if>
							
							<c:choose>
								<c:when test="${noticeDetAuthAt eq 'Y'}">
									<a href="javascript:void(0);" class="notice_p" onclick="fnView('<c:out value="${noticeList.nttSeq}"/>', '<c:out value="${noticeList.ntcrId}"/>', '<c:out value="${noticeList.secretAt}"/>', '<c:out value="${noticeList.parntsNttSeq}"/>');"><c:out value="${nttSj}"/></a>							
									<c:if test="${noticeList.answerCnt > 0}">
										<span class="colorRed">[<c:out value="${noticeList.answerCnt}"/>]</span>
									</c:if>
								</c:when>
								<c:otherwise>
									<a href="javascript:void(0);" class="notice_p" onclick="alert('<spring:message code="wzwg.cmm.msg.MSG084" />');"><c:out value="${nttSj}"/></a>							
									<c:if test="${noticeList.answerCnt > 0}">
										<a href="javascript:void(0);" onclick="alert('<spring:message code="wzwg.cmm.msg.MSG084" />');">
											<span class="colorRed">[<c:out value="${noticeList.answerCnt}"/>]</span>
										</a>
									</c:if>
								</c:otherwise>
							</c:choose>							

							<c:if test="${noticeList.atchFileCnt ne '0'}">
								<img src="/images/wzwg/module/ntt/ico-file.gif" alt="<spring:message code="wzwg.module.word.atchfileicon" />"/>
							</c:if>
							
						</td>
						<td><spring:message code="wzwg.cmm.word.mngr" /></td>
						<td><c:out value="${noticeList.frstRegistPnttm}"/></td>
						
						<c:if test="${mobileAt eq 'N'}">
						
						<td><c:out value="${noticeList.inqireCnt}"/></td>
						</c:if>
					</tr>
					</c:forEach>					
					</c:if>

					<c:set var="colCnt" value="6" />
					<c:if test="${adminAuthAt eq 'Y'}">
						<c:set var="colCnt" value="7" />
					</c:if>
					
					<c:if test="${mobileAt eq 'Y'}">
						<c:set var="colCnt" value="${colCnt - 2}" />
					</c:if>
							
					<c:if test="${empty resultList}">
						<tr>
							<c:set var="temp_colCnt" value="${colCnt}" />
							<td colspan="<c:out value='${temp_colCnt}'/>"><spring:message code="wzwg.cmm.msg.MSG085" /></td>
						</tr>
					</c:if>	
					
				</tbody>
			</table>
			
			</c:if>
			
			<c:if test="${!empty resultList}">
			
				<c:if test="${adminAuthAt eq 'Y'}">
					<div class="mb10 pl10">
						<label>
						<input type="checkbox" name="nttAllChk" id="nttAllChk" title="<spring:message code="wzwg.cmm.word.rowallchoise" />"/>
						<span><spring:message code="wzwg.module.word.allchoise" /></span>
						</label>
					</div>					
				</c:if>		
			
				<c:forEach var="resultList" items="${resultList}" varStatus="status">
				
				<c:set var="listDetAuthAt" value="" />
				<c:set var="modAuthAt" value="" />
				<c:set var="delAuthAt" value="" />
				
				<c:if test="${resultList.secretAt eq 'Y'}">
					<c:if test="${!empty loginVO.userId and loginVO.userId eq resultList.parntsNtcrId}">
						<c:set var="listDetAuthAt" value="Y" />
					</c:if>	
				</c:if>
				<c:if test="${resultList.secretAt ne 'Y'}">
					<c:if test="${nttAuthVO.authorSe eq 'R' or nttAuthVO.authorSe eq 'W' or cmntAuthR eq 'Y' or cmntAuthW eq 'Y'}">
						<c:set var="listDetAuthAt" value="Y" />
					</c:if>						
				</c:if>
				
				<c:if test="${loginVO.usrSeq eq resultList.ntcrSeq or adminAuthAt eq 'Y'}">
					<c:set var="listDetAuthAt" value="Y" />
					<c:set var="modAuthAt" value="Y" />
					<c:set var="delAuthAt" value="Y" />
				</c:if>				

				<div class="board001 mt5">
					<div class="list_tit">				
						<h3>	
							<c:if test="${adminAuthAt eq 'Y'}">
								<input type="checkbox" name="nttChk" id="nttChk" value="<c:out value='${resultList.nttSeq}'/>" title="<spring:message code="wzwg.cmm.word.rowchoise" />"/>				
							</c:if>									
							<span>
								<c:if test="${resultList.lv > 1}">
									<c:forEach step="1" begin="1" end="${resultList.lv - 1}">
										<img src="/images/wzwg/module/ntt/icoReply.png"/>
									</c:forEach>
								</c:if>
							<c:if test="${!empty resultList.subospecSj}">
								<span>[<c:out value="${resultList.subospecSj}"/>]</span>
							</c:if>
							<c:if test="${resultList.secretAt eq 'Y'}">
								<img src="/images/wzwg/module/ntt/ico-secret.png" alt="<spring:message code="wzwg.module.word.secretposts" />" title="<spring:message code="wzwg.module.word.secretposts" />" />
							</c:if>											
								<c:out value="${resultList.nttSj}"/>
							</span>				
							<span class="sub_title"><c:out value="${resultVO.bbsNm}"/></span>								
						</h3>
						<p class="list_date">
							<strong><spring:message code="wzwg.cmm.word.rgsde02" /></strong>
							<span><c:out value="${resultList.frstRegistPnttm}"/></span>
							<span class="com_bar">
							<c:if test="${modAuthAt eq 'Y'}">
								<a href="javascript:void(0);" onclick="fnModifyFormPage('<c:out value="${resultList.nttSeq}"/>');" class="gray"><spring:message code="wzwg.cmm.word.updt" /></a>
							</c:if>
							<c:if test="${delAuthAt eq 'Y'}">	
								<a href="javascript:void(0);" onclick="fnNttDelete('<c:out value="${resultList.nttSeq}"/>');" class="gray"><spring:message code="wzwg.cmm.word.delete" /></a>
							</c:if>						
							</span>
						</p>
					</div><!-- list_tit end -->
					<div class="list_content">
						<div class="conTop">
							 <p class="writer">
								<strong><spring:message code="wzwg.cmm.word.wrter" /></strong>
								<span>
									<c:if test="${resultList.annymtyAt eq 'Y'}"><spring:message code="wzwg.cmm.word.annymty" /></c:if>
									<c:if test="${resultList.annymtyAt ne 'Y'}"><c:out value="${resultList.ntcrNm}"/>(<c:out value="${fn:substring(resultList.ntcrId, 0, 4)}"/>****)</c:if>
								</span>								
							</p>
							<p>
								<c:if test="${paramVO.mngrAt ne 'Y'}">
									<c:if test="${listDetAuthAt eq 'Y'}">
										<%-- http://<%=getUrl%><%=getPort%>/subList/${paramVO.menuSeq}?pmode=detail&nttSeq=${resultList.nttSeq} --%>
										<a href="javascript:void(0);" onclick="fnAdresCopy(<c:out value='${resultList.nttSeq}'/>);" id="adres_copy_btn"><spring:message code="wzwg.module.word.adrescopy" /></a>							
									</c:if>
								</c:if>							
							</p>

							<c:if test="${listDetAuthAt eq 'Y'}">
								
								<c:if test="${resultList.atchFileCnt ne '0'}">
									<ul>
										<li>
											<a href="javascript:void(0);" onclick="fnAtchFileOpen('<c:out value="${resultList.nttSeq}"/>', '<c:out value="${resultList.atchFileId}"/>');return false;">
											<spring:message code="wzwg.module.word.atchfile" /><span>(<c:out value="${resultList.atchFileCnt}"/>)</span>
											</a>
										</li>									
									</ul>
									
									<p id="atchFile_div_<c:out value='${resultList.nttSeq}'/>" style="display:none;">
										<%-- <c:import url="/module/upload/file/selectFileInc.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" 		value="${resultList.atchFileId}" />
											<c:param name="param_updateFlag" 		value="N" />
											<c:param name="param_atchFileNumber" 	value="${moduleBbsVO.atchFilePosblCo}" />
											<c:param name="param_cntntsSeq" 		value="${resultList.bbsSeq}" />
										</c:import> --%>
									</p>
								</c:if>
							
							</c:if>							
						</div><!-- conTop end -->
						<div class="conMiddle">
							<div class="conM_txt">
								<c:choose>
									<c:when test="${listDetAuthAt eq 'Y'}">
										<c:out value='${resultList.nttCn}' escapeXml="false" />
									</c:when>
									<c:otherwise>
										<spring:message code="wzwg.cmm.msg.MSG086" />
									</c:otherwise>
								</c:choose>							
							</div>
							 
						 	<div id="module_inc_<c:out value='${resultList.nttSeq}'/>">
								<ul>
								<!-- 댓글, 등록순, 조회수, 좋아요 -->
									<c:if test="${resultList.answerPermAt eq 'Y'}">
										<c:import url="${wzwg_contextPath}${prefix}/module/ntt/answer/selectNttAnswerIncAjax.do" charEncoding="utf-8">
											<c:param name="param_nttSeq" value="${resultList.nttSeq}" />
										</c:import>
									</c:if>		
															
									<li><a style="cursor:text;"><spring:message code="wzwg.cmm.word.rdcnt" /> <c:out value="${resultList.inqireCnt}"/></a></li>
								</ul>
							</div>
	
						</div>
						<div class="conBottom">
							<div id="module_div_<c:out value='${resultList.nttSeq}'/>">
								
								<div class="answer cmtbg" style="display:none;">
									<c:if test="${resultList.answerPermAt eq 'Y'}">
										<c:import url="${wzwg_contextPath}${prefix}/module/ntt/answer/selectNttAnswerFormAjax.do" charEncoding="utf-8">
											<c:param name="param_nttSeq" value="${resultList.nttSeq}" />
										</c:import>
									</c:if>
								</div>
								
							</div>
						</div><!-- conBottom end -->
						
						<div class="rt-box">

							<c:if test="${delAuthAt eq 'Y'}">
								<a href="javascript:void(0);" onclick="fnNttDelete('<c:out value="${resultList.nttSeq}"/>');" class="wzbtn btn-del fl"><spring:message code="wzwg.cmm.word.delete" /></a>
							</c:if>
							
							<c:if test="${!empty loginVO and resultVO.scrapAt eq 'Y'}">
								<a href="javascript:void(0);" onclick="fnNttScrapPop('<c:out value="${resultList.nttSeq}"/>');" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.scrap" /></a>
							</c:if>
							
							<c:if test="${movAuthAt eq 'Y'}">
								<c:if test="${paramVO.cmntUseAt ne 'Y'}">
								<a href="javascript:void(0);" onclick="fnModifyFormPage('<c:out value="${resultList.nttSeq}"/>');" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.mvmn" /></a>	
								</c:if>					
							</c:if>
							
							<c:if test="${modAuthAt eq 'Y'}">
								<a href="javascript:void(0);" onclick="fnModifyFormPage('<c:out value="${resultList.nttSeq}"/>');" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.updt" /></a>
							</c:if>
							
						</div>	
						
					</div><!-- list_content end -->
				</div>
			</c:forEach>
			</c:if>		
			
			<c:set var="regAuthAt" value="" />
			
			<c:if test="${nttAuthVO.authorSe eq 'W' or adminAuthAt eq 'Y' or cmntAuthW eq 'Y'}">
				<c:set var="regAuthAt" value="Y" />
			</c:if>	

			<c:if test="${!empty resultList}">
			<div class="ctr-box" id="pageInfo">
				<ul class="num mobile-none">
					<ui:pagination paginationInfo="${paginationInfo}" type="ntt" jsFunction="fnPage" />
				</ul>
				
				<ul class="num pc-none">
					<ui:pagination paginationInfo="${mobilePaginationInfo}" type="ntt" jsFunction="fnPage" />
				</ul>
			</div>
			</c:if>		
			
			<div class="ctr-box" id="nttSearch">
				<c:set var="searchTit"><spring:message code="wzwg.module.word.searchse" /></c:set>				
				<c:set var="searchkeyinp"><spring:message code="wzwg.module.word.searchkeywordinput" /></c:set>				
				<form:select path="searchCondition" id="searchCondition" title="${fn:escapeXml(searchTit)}"> 
					<%-- <form:option value=""><label for="option"><spring:message code="wzwg.cmm.word.all" /></label></form:option> --%>
					<form:option value="1"><label for="option1"><spring:message code="wzwg.cmm.word.sj" />+<spring:message code="wzwg.cmm.word.cn" /></label></form:option>
					<form:option value="2"><label for="option2"><spring:message code="wzwg.cmm.word.sj" /></label></form:option>
					<form:option value="3"><label for="option3"><spring:message code="wzwg.module.word.wrternm" /></label></form:option>
				</form:select>
				
				<c:set var="srchwrd">
					<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
				</c:set>				
				<form:input path="searchKeyword" id="searchKeyword" placeholder="${fn:escapeXml(srchwrd)}" cssClass="txt" onkeydown="if(event.keyCode == 13){fnPage(1);}" title="${fn:escapeXml(searchkeyinp)}"/>
				<a href="javascript:void(0);" id="btn_search" class="wzbtn-table btn-srch" onclick="fnSearch('btn_search');" title="<spring:message code="wzwg.module.word.searchbutton" />"><spring:message code="wzwg.cmm.word.search01" /></a>		 
			</div>	

			<div class="rt-box">
				<c:if test="${adminAuthAt eq 'Y'}">
					<c:if test="${subospecListCnt > 0}">
						<c:if test="${resultVO.cmntUseAt ne 'Y'}">		
						<a href="javascript:void(0);" class="wzbtn btn-basic fl" id="subospec_modify_btn"><spring:message code="wzwg.module.word.ctgryupdt" /></a>
						</c:if>
					</c:if>	
					<a href="javascript:void(0);" class="wzbtn btn-del fl" id="delete_btn"><spring:message code="wzwg.module.word.choisedelete" /></a>
				</c:if>	
				<c:if test="${regAuthAt eq 'Y'}">				
					<a href="javascript:void(0);" class="wzbtn btn-basic" id="regist_form_btn"><spring:message code="wzwg.module.word.postswrt" /></a>
				</c:if>
			</div>	

			<c:if test="${nowUrl.indexOf('/mngr') == -1 }">
			<div class="mt20">
				<c:import url="${wzwg_contextPath}/usr/cntnts/cntPagadiEstbs/selectCntPagadiEstbsUsrAjax.do">
					<c:param name="cntntsSeq" value="${resultVO.bbsSeq }" />
					<c:param name="nttSeqAt" value="N" />
				</c:import>
			</div>
			</c:if>

		</form:form>
		
		<c:if test="${not empty resultVO.bbsCnclsn}">
		<div class="mt30">
			<c:out value='${resultVO.bbsCnclsn}' escapeXml="false" />
		</div>
		</c:if>		
