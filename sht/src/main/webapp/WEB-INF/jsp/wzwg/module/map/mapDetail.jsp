<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<jsp:include page="/WEB-INF/jsp/wzwg/webModule/editorTool.jsp"></jsp:include>
<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">
	function toDataUrl(url, callback) {
	    var xhr = new XMLHttpRequest();
	    xhr.onload = function() {
	        var reader = new FileReader();
	        reader.onloadend = function() {
	            callback(reader.result);
	        }
	        reader.readAsDataURL(xhr.response);
	    };
	    xhr.open('GET', url);
	    xhr.responseType = 'blob';
	    xhr.send();
	}
	
	function getMapImage(){
		var addr = $('#mapAddr').val();
		if(! addr){
			alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
						'<spring:argument><spring:message code="wzwg.cmm.word.adres" /></spring:argument>'+
						'<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>'+
					  '</spring:message>');
			return;
		}
		
		//addr = '%EB%A7%8C%EB%85%84%EB%8F%';
		
		//var gApiUrl = 'http://maps.googleapis.com/maps/api/geocode/xml?address=' + addr + '&language=ko&sensor=false';
		
		$.ajax({
	        type:'POST'
	      , url: '<c:out value="${wzwg_contextPath}"/>/module/map/getGeoCodeAjax.do'
	      , data : {mapAddr : addr, width: 1024, height:400, mapinfoSeq: $('#mapinfoSeq').val()}
	      , cache : false
	      , async : false
	      , success:function (data) {
	    	  //console.log(data);
	    	  if(data.head.result != 'success'){
	    		  alert('<spring:message code="wzwg.cmm.msg.MSG167" />');
	    		  return;
	    	  }
	    	  if(!data.body.x && !data.body.y){
	    		  alert('<spring:message code="wzwg.cmm.msg.MSG167" />');
	    		  return;
	    	  }
	    	  if($('#viewMap').find('img').length == 0){
	    		  $('#viewMap').empty();
	    	  }
	    	  //console.log(data.x);
	    	  //console.log(data.y);
	    	  
	    	$('#viewMap').append(data.html.imgList);
	    	  
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'json'
	      , complete : function(){
	    	  
	    	  $('#tmpScript').remove();
	      }
	 	}); 
	}
	
	function addCntnsImg(addBtn, width){
		var imgDiv = $(addBtn).parent().find('img');
		//console.log(imgDiv);
		var style = 'style="width: ' + width + '%;"';
		var item = '';
			//item += '<a href="http://map.naver.com/index.nhn?query=' + imgDiv.attr('data-addr') + '&tab=1" target="_blank">';
			//item += '<a href="http://map.naver.com/v5/search/' + imgDiv.attr('data-addr') + '" target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />">';
			item += '<a href="http://map.kakao.com/link/search/' + imgDiv.attr('data-addr') + '" target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />">';
			item += '	<img src="' + imgDiv.attr('src') + '" ' + style + ' alt="" >';
			item += '</a><br>';
			
			console.log(item);
		
		oEditors.getById["mapCn"].exec("PASTE_HTML", [item]);
	}
	
	function deleteMapImg(addBtn){
		
		if(confirm('지도 이미지를 삭제 합니까?\n\n본문에서는 삭제되지 않습니다.')){
			
			var mapDiv = $(addBtn).parent();
			var img = $(mapDiv).find('img');
			//console.log(img);
			//console.log($(img).attr('data-mapImgSeq'));
			
			$.ajax({
		        type:'POST'
		      , url: '<c:out value="${wzwg_contextPath}"/>/module/map/modifyMapImgAjax.do'
		      , data : {mapinfoSeq: $('#mapinfoSeq').val(), mapImgSeq: $(img).attr('data-mapImgSeq'), useAt: 'N'}
		      , cache : false
		      , async : true
		      , success:function (data) {
		    	  if(data.head.result == 'success'){
					$(mapDiv).fadeOut(150, function(){
						$(this).remove();
					});
		    	  }else{
		    		  alert('<spring:message code="fail.common.msg" text="error" />');
		    	  }
		    	  
		      }
		      , error:function (data) {
		          alert('<spring:message code="fail.common.msg" text="error" />');
		      }
		      , dataType: 'json'
		 	}); 
			
			
		}else{
			return;
		}
		
	}
	
	function defImgChange(mapImg){
		var mapDiv = $('#'+mapImg);
		var img = $(mapDiv).find('img');
		//console.log(mapDiv);
		//console.log($(img).attr('data-mapImgSeq'));
		
		$.ajax({
	        type:'POST'
	      , url: '<c:out value="${wzwg_contextPath}"/>/module/map/modifyMapImgAjax.do'
	      , data : {mapinfoSeq: $('#mapinfoSeq').val(), mapImgSeq: $(img).attr('data-mapImgSeq'), defaultYn: 'Y'}
	      , cache : false
	      , async : true
	      , success:function (data) {
	    	  if(data.head.result == 'success'){
				alert('<spring:message code="success.common.update"/>');
	    	  }else{
	    		  alert('<spring:message code="fail.common.msg" text="error" />');
	    	  }
	    	  
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'json'
	 	}); 
	}
	
	var status = '0<c:out value="${result.mapSeq }"/>'; // 0이면 등록 1이면 수정
	
	function mapRegist(){
		/*
		var addr = $('#mapAddr').val();
		if(! addr){
			alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
						'<spring:argument><spring:message code="wzwg.cmm.word.adres" /></spring:argument>'+
						'<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>'+
					  '</spring:message>');
			return;
		}
		
		if($('#viewMap').html() == '<spring:message code="wzwg.cmm.word.map" /> <spring:message code="wzwg.cmm.word.relm" />'){
			alert('<spring:message code="wzwg.cmm.cmmMsg.CMG021">'+
					'<spring:argument><spring:message code="wzwg.cmm.word.image" /> <spring:message code="wzwg.cmm.word.creat" /></spring:argument>'+
				  '</spring:message>');
			return;
		}
		*/
		$('#mapCn').val(oEditors.getById["mapCn"].getIR());
		
		var ajaxUrl = '';
		if(status == '0'){
			ajaxUrl = '<c:out value="${wzwg_contextPath}"/>/module/map/registModuleMapAjax.do';
		}else{
			ajaxUrl = '<c:out value="${wzwg_contextPath}"/>/module/map/modifyModuleMapAjax.do';
		}
		
			$.ajax({
		        type:'POST'
		      , url: ajaxUrl
		      , data : $("#mapBassForm").serialize()
		      , cache : false
		      , async : true
		      , success:function (data) {
		    	  status = '1';
		    	  alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
		      }
		      , error:function (data) {
		          alert('<spring:message code="fail.common.msg" text="error" />');
		      }
		      , dataType: 'xml'
		 	}); 
		
		
	}
	
	function mapCapture(){
		html2canvas(document.querySelector("#viewMap"), {
		    onrendered: function(canvas) {
		    	$('#mapImg').attr('src',canvas.toDataURL());
		    }
		});
		/* 
		 html2canvas(document.querySelector("#viewMap"), {canvas: canvas}).then(function(canvas) {
	  			//$('#mapImg').val(canvas.toDataURL());
	  			$('#mapImg').attr('src',canvas.toDataURL());
	              //console.log('Drew on the existing canvas');
	          }); */
	}
	
	
	function dataInit(){
		var tmplatSeq = document.mapFrm.mapTmplatSeq.value;
		var mapContentsLen = '<c:out value="${fn:length(result.mapCn)}"/>';
		
		//console.log(mapContentsLen == '0');
		//console.log(tmplatSeq + '/' + mapContentsLen);
		//console.log(!tmplatSeq);
		//console.log(mapContentsLen == '0');
		
		if(mapContentsLen == '0'){
			fn_selectTmplatCn();
		}else{
			$('#mapContents').show();
		}
		
		if(tmplatSeq){
			$('#tmplatAddBtn').show();
		}
	}
	
	function fn_selectTmplatCn(){
		$.ajax({
	        type:'POST'
	      , url: '<c:out value="${wzwg_contextPath}"/>/module/map/selectTmplatCnAjax.do'
	      , data : {tmplatSeq: $('#mapTmplatSeq').val()}
	      , cache : false
	      , async : true
	      , success:function (data) {
	    	  //console.log(data);
	    	  if(data.result == 'success'){
	    		  oEditors.getById["mapCn"].exec("SET_IR", [""]);
	    		  oEditors.getById["mapCn"].exec("PASTE_HTML", [data.tmplatCn]);
	    		  //$('#tmplatAddBtn').hide();
	    		  //$('#mapContents').show();
	    	  }else{
	    		  alert('<spring:message code="wzwg.cmm.msg.MSG168" />');
	    	  }
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'json'
	 	}); 
	}
	
	function selectMapImgList(){
		$.ajax({
	        type:'POST'
	      , url: '<c:out value="${wzwg_contextPath}"/>/module/map/selectMapImgListAjax.do'
	      , data : {mapinfoSeq: $('#mapinfoSeq').val()}
	      , cache : false
	      , async : false
	      , success:function (data) {
	    	  //console.log(data);
	    	  //console.log(data.head);
	    	  if(data.head.result == 'success'){
	    		  
	    		if($('#viewMap').find('img').length == 0){
		    		  $('#viewMap').empty();
		    	}
	    		
		    	$('#viewMap').append(data.html.imgList);
		    	
		    	
	    	  }
	    	  
	    
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'json'
	      , complete : function(){
	    	  $('#tmpScript').remove();
	    	  
	      }
	 	}); 
	}
</script>

	<form id="mapBassForm" name="mapBassForm" method="post">
        <input type="hidden" name="sitecntntsSeq" id="sitecntntsSeq" value="<c:out value='${resultVO.sitecntntsSeq}'/>"/>
		<input type="hidden" name="mapinfoSeq" id="mapinfoSeq" value="<c:out value='${resultVO.mapinfoSeq }'/>"/>
		<textarea name="mapImg" id="mapImg" style="display: none;"><c:out value='${result.mapImg }'/></textarea>
			
		<table class="basic">
			<colgroup>
				<col width="15%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
				<tr>
					<th>
						<spring:message code="wzwg.module.word.addinfo" />
					</th>
					<td>
						<div id="mapContents" >
						<textarea name="mapCn" id="mapCn" rows="40" style="width:100%;"><c:out value="${result.mapCn}"/></textarea>
								<script type="text/javascript">
									var oEditors = [];
									nhn.husky.EZCreator.createInIFrame({
										oAppRef: oEditors,
										elPlaceHolder: "mapCn",
										sSkinURI: "<c:out value='${wzwg_contextPath}'/>/smartEditor2.8.2.1/smartEditor2Skin.do",
										fCreator: "createSEditor2",
										htParams: {
											fOnBeforeUnload : function(){}
											,aAdditionalFontList : [['NanumSquareR', 'NanumSquareR']]		// 추가 글꼴 목록
											}
										,fOnAppLoad : function(){
											dataInit();
										}
									});
									
									WzwgEditorTool.instance("mapCn");
								</script>
						</div>
						
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.cmm.word.adres" /></th>
					<td>
						<input type="text" name="mapAddr" id="mapAddr" class="w70" value="<c:out value='${result.mapAddr }'/>" readonly="true" dir="required" />
						<a href="javascript:void(0);" onclick="execKakaoPostcode();" class="wzbtn-table btn-basic"><spring:message code="wzwg.webModule.word.adresSearch" /></a>
						<a href="javascript:void(0);" id="regist_btn" onclick="javascript:getMapImage();" class="wzbtn-table btn-basic"><spring:message code="wzwg.module.word.imagecreat" /></a>
						
						<script>
							function execKakaoPostcode() {
	                            new kakao.Postcode({
	                                oncomplete: function(data) {
	                                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	                    
	                                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                                    var fullAddr = ''; // 최종 주소 변수
	                                    var extraAddr = ''; // 조합형 주소 변수

	                                    // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                                        fullAddr = data.roadAddress;
	                    
	                                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                                        fullAddr = data.jibunAddress;
	                                    }
	                    
	                                    // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	                                    if(data.userSelectedType === 'R'){
	                                        //법정동명이 있을 경우 추가한다.
	                                        if(data.bname !== ''){
	                                            extraAddr += data.bname;
	                                        }
	                                        // 건물명이 있을 경우 추가한다.
	                                        if(data.buildingName !== ''){
	                                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                                        }
	                                        // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                                        fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                                    }

	                                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                                    document.getElementById('mapAddr').value = fullAddr;
	                    
	                                    // 커서를 상세주소 필드로 이동한다.
	                                    document.getElementById('mapAddr').focus();
	                                }
	                            }).open();
	                        }
						</script>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.cmm.word.map" /></th>
					<c:choose>
						<c:when test="${not empty result.mapImg }">
							<td id="viewMap">
						  	<a href="http://map.naver.com/index.nhn?query=<c:out value='${result.mapAddr}'/>&tab=1&level=2" target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />">
	    	  					<img id="tmapImg" src="<c:out value='${result.mapImg}'/>"  alt="" />
	    	  				</a>
	    	  				</td>
						</c:when>
						
						<c:otherwise>
							<td >
								<p class="admpg-subp w100 fl mt10 mb20">
								    <span class="circle_no bg-green-strong vert-m">i</span><strong class="grey"><spring:message code="wzwg.cmm.msg.MSG319" /> <!-- <spring:message code="wzwg.cmm.msg.MSG320" /> --></strong>
								    <span class="wz_tableguide mt5 pl20"><spring:message code="wzwg.cmm.msg.MSG321" /><br><spring:message code="wzwg.cmm.msg.MSG343" /></span>			
								</p>
								<div id="viewMap"></div>
							</td>
						</c:otherwise>
					</c:choose>
					
				</tr>
				
		</table>
	</form>

	<div class="rt-box">
		<a id="tmplatAddBtn" style="display:none;" href="javascript:void(0);" class="wzbtn btn-blue-bg" onclick="fn_selectTmplatCn();"><spring:message code="wzwg.module.word.templateinitl" /></a>
        <a href="javascript:void(0);" id="regist_btn" onclick="javascript:mapRegist();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
	</div>

	<script>
	$(document).ready(function(){ 
		//dataInit();
		selectMapImgList();
	});
	</script>