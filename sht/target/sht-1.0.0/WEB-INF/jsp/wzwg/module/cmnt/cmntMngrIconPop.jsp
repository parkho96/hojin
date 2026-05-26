<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>


<script type="text/javascript">
	$(document).ready(function(){ 
		
	});
	 
	function fn_setCmntIconAjax(el){ 
		
		var cmntIconStre = $(el).children().attr('src');
		console.log(cmntIconStre);
		document.iconFrm.cmntIconStre.value = cmntIconStre;
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}"/>/cmnt/mngr/cmnt/info/modifyCmntIconAjax.do' 
	      , cache : false
	      , async : false 
	      , data  : $("#iconFrm").serialize()
	      , success:function (data) { 
	    	  alert('<spring:message code="wzwg.cmm.msg.MSG080" text="changed" />');
			$("#iconImg").attr("src",cmntIconStre);
			$('.close').click();
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
	
	function fnIconUpload(){
		$('#uploadFrm').ajaxForm({
		    type:'POST'
		    , url:'<c:out value="${wzwg_contextPath}"/>/cmnt/mngr/cmnt/info/uploadCmntIconAjax.do'
		    , beforeSend: function() {
		    	
		    }
		    , uploadProgress: function(event, position, total, percentComplete) {
		    	
		    }
		    , success: function(data) {
		    	$("#iconImg").attr("src",data.cmntIconStre);
		    	alert('<spring:message code="wzwg.cmm.msg.MSG080" text="changed" />');
		    	$('.close').click();
		    	//wzModalClose();
		    }
			, complete: function(xhr) {
				//status.html(xhr.responseText);
			}
		    , dataType: 'json'
		}); 
	 
	 $('#uploadFrm').submit();

	}
	
</script>
	
			<form name="iconFrm" id="iconFrm">		
			<input type="hidden" name="cmntSeq" id="cmntSeq" value="<c:out value='${paramVO.cmntSeq}'/>"/>	
			<input type="hidden" name="cmntIconStre" id="cmntIconStre" value=""/>
			</form>
			
			<div id="icon-contents" class="pop-tab community-icon-pop">  <!-- 이팝업은 구조자체를 좀 많이바꿨어요. 기존에 탭팝업처럼 맞추느라고. -->
			
				<input id="select_icon" type="radio" name="add_layer_tab" checked="checked" title="<spring:message code="wzwg.module.word.iconchangechoise" />">
	            <input id="upload_icon" type="radio" name="add_layer_tab" title="<spring:message code="wzwg.module.word.directatchchoise" />">
	            <section class="buttons">
	                <label for="select_icon" tabIndex="0" onkeypress="if(event.keyCode=='13'){this.click(); this.focus();}"><spring:message code="wzwg.module.word.iconchange" /></label>
	                <label for="upload_icon" tabIndex="0" onkeypress="if(event.keyCode=='13'){this.click(); this.focus();}"><spring:message code="wzwg.module.word.directatch" /></label> <!-- 직접첨부에서 단어 변경 -->
	            </section>

	            <!-- 아이콘선택 탭 -->
	            <div class="tab_item">

					<ul>
						<li><a href="#" onclick="fn_setCmntIconAjax(this)"><img src="/images/wzwg/module/cmnt/heart.png" alt=""></a></li>
						<li><a href="#" onclick="fn_setCmntIconAjax(this)"><img src="/images/wzwg/module/cmnt/email.png" alt=""></a></li>
						<li><a href="#" onclick="fn_setCmntIconAjax(this)"><img src="/images/wzwg/module/cmnt/wine.png" alt=""></a></li>
						<li><a href="#" onclick="fn_setCmntIconAjax(this)"><img src="/images/wzwg/module/cmnt/cake.png" alt=""></a></li>
						<li><a href="#" onclick="fn_setCmntIconAjax(this)"><img src="/images/wzwg/module/cmnt/candy.png" alt=""></a></li>
						<li><a href="#" onclick="fn_setCmntIconAjax(this)"><img src="/images/wzwg/module/cmnt/house.png" alt=""></a></li>
						<li><a href="#" onclick="fn_setCmntIconAjax(this)"><img src="/images/wzwg/module/cmnt/ring.png" alt=""></a></li>
					</ul>

				</div>


	            <!-- 직접 첨부 탭 -->
	            <div class="tab_item">

	            	<form name="uploadFrm" id="uploadFrm" method="post" enctype="multipart/form-data" action="/cmnt/mngr/cmnt/info/uploadCmntIconAjax.do">
					<input type="hidden" name="cmntSeq" id="cmntSeq" value="<c:out value='${paramVO.cmntSeq}'/>">
						<div class="pop-main-reon">
							<label for="file1" tabindex="0" onkeypress="if(event.keyCode=='13'){this.click();}"> <!-- 기본적인 파일첨부 버튼 스타일바꿔주려고 label로 감싸줬어요~ -->
								<input type="file" name="file1" id="file1" title="<spring:message code="wzwg.module.word.directatchfilechoise" />">
								<spring:message code="wzwg.module.word.filechoise" />
							</label>
							<!-- <input type="text" readonly="readonly" id="file_route"> 불러온파일 명 불러오는 부분. -->

						</div>
						<div class="icon-view">
							<img src="<c:out value='${paramVO.cmntIconStre}'/>" alt="" id="file_preview"/>
						</div>
						<button type="button" class="wzbtn-table wzbtn-block btn-save" onclick="fnIconUpload();"><spring:message code="button.save" text="save" /></button>
					</form>

	            </div>

			</div>
			