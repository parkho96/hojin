<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<link rel="stylesheet" href="/css/wzwg/module/cmnt/community.css"> 
<script src="/jquery/js/jquery.nestable.js"></script>
<link rel="stylesheet" href="/css/wzwg/cmm/jquery.nestable.css" type="text/css" />
<script type="text/javascript">
try{document.title = cmntNm+'-<spring:message code="wzwg.module.word.cmmntymanage" />-<spring:message code="mgr.menuMngt" text="menu Manage" />';}catch(e){console.log(e.message);}

	$(document).ready(function(){
		 $('#menucaption1').html('<spring:message code="wzwg.cmm.cmmMsg.CMG024"><spring:argument>'+cmntNm+' <spring:message code="wzwg.cmm.word.wa.of" /> <spring:message code="wzwg.cmm.word.menu" /> <spring:message code="wzwg.cmm.word.nm01" />, <spring:message code="wzwg.cmm.word.bbs" /> <spring:message code="wzwg.cmm.word.ty" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.wa.table" /></spring:argument></spring:message>');
		 $('#menucaption2').html('<spring:message code="wzwg.cmm.cmmMsg.CMG024"><spring:argument>'+cmntNm+' <spring:message code="wzwg.cmm.word.wa.of" /> <spring:message code="wzwg.cmm.word.confm" /> <spring:message code="wzwg.cmm.word.mber" />, <spring:message code="wzwg.cmm.word.uapprd" /> <spring:message code="wzwg.cmm.word.mber" /> <spring:message code="wzwg.cmm.word.menu" /> <spring:message code="wzwg.cmm.word.author" />(<spring:message code="wzwg.cmm.word.redng" />, <spring:message code="wzwg.cmm.word.wrt" />)</spring:argument><spring:argument><spring:message code="wzwg.cmm.word.wa.table" /></spring:argument></spring:message>');
		 var updateMenu = function(e)
 	    {
			 /***
 		 $('#nestable1  li').each(function (index, childEle){
 			// alert($(childEle).data("menuseq")); 
 			 var menulv = $(childEle).parents("li").data("menulv");
 			 if(menulv ==  undefined){
 				 menulv =0;
 			 }
 			 menulv = menulv+1;
 			 var upperMenuSeq = $(childEle).parents("li").data("menuseq") ;
 			 var menudivision =   $(childEle).parents("li").data("menudivision") ;
 			 if(menudivision == undefined){
 				 menudivision = 'group';
 			 }
 			 if(menudivision !='group'){
 				 alert('<spring:message code="wzwg.cmm.msg.MSG058" />');
 				 location.reload();
 				 return;
 			 }
 			 if(upperMenuSeq == undefined){
 				 upperMenuSeq =0;
 			 }
 			 
 			 $.ajax({
					   type:'POST'
					 , url:' /mngr/menu/modifySiteMenuMngrOrdrAjax.do'
					 , data:{'menuOrdr' :index,'menuSeq':$(childEle).data("menuseq"),'upperMenuSeq':upperMenuSeq,'menuLv':menulv} 
					 , success:function (data) { 
							   }
					 , dataType: 'json'
				});
 			 
 			
 		 });
 	       ***/
 	    };


	 /* 	$('.typeModify').nestable({
	 	     maxDepth: 1
	 	}).on('change', updateMenu); */
	 	
	 	
 	    var mnList = $('.cmntMenuList ul li');
	 	var mnFirst = mnList.eq(0);
	 	var mnLast = mnList.eq(mnList.length -1);
	 	var dimDownBtn = mnFirst.find('button').eq(0);
	 	var dimUpBtn = mnLast.find('button').eq(1);
	 	
	 	dimDownBtn.css('color', '#eee');
	 	dimDownBtn.off();
	 	dimDownBtn.attr('onmousedown', '');
	 	dimDownBtn.attr('onclick', '');
	 	dimDownBtn.attr('disabled', 'disabled');
	 	dimUpBtn.css('color', '#eee');
	 	dimUpBtn.off();
	 	dimUpBtn.attr('onmousedown', '');
	 	dimUpBtn.attr('onclick', '');
	 	dimUpBtn.attr('disabled', 'disabled');
	 	
	 	$('#atchFilePosblAtN').click(function() {
			$('#atchFilePosblCo').prop('disabled', true);
		});
	 	
	 	$('#atchFilePosblAtY').click(function() {
			$('#atchFilePosblCo').prop('disabled', false);
		});
	 	
	});
	   
	function fn_formCancel(){
		fn_menu();
	}
	function fn_cmntDetail(menuSeq){ 
		  fn_menu();
		 document.cmntMenuFrm.menuSeq.value=menuSeq;
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}"/>/module/cmnt/mngr/selectCmntMeunDetailAjax.do' 
	      , cache : false
	      , async : false 
	      , data  : $("#cmntMenuFrm").serialize()
	      , success:function (data) { 
	    	 for(var i=0;i<data.authList.length;i++){
	    		 if(data.authList[i].apprvlCode =='SC00000339'){
	    			 if(data.authList[i].authSe =='C'){
	    				 $("#authSeAppC").attr("checked",true);
	    			 }
	    			 if(data.authList[i].authSe =='R'){
	    				 $("#authSeAppR").attr("checked",true);
	    			 }
	    			 if(data.authList[i].authSe =='W'){
	    				 $("#authSeAppW").attr("checked",true);
	    			 }
	    		 }
	    		 
	    		 if(data.authList[i].apprvlCode =='SC00000340'){
	    			 if(data.authList[i].authSe =='C'){
	    				 $("#authSeNappC").attr("checked",true);
	    			 }
	    			 if(data.authList[i].authSe =='R'){
	    				 $("#authSeNappR").attr("checked",true);
	    			 }
	    			 if(data.authList[i].authSe =='W'){
	    				 $("#authSeNappW").attr("checked",true);
	    			 }
	    		 }
	    	 } 
	    	  document.cmntMenuFrm.menuNm.value=data.resultVO.menuNm;
	    	  if(data.resultVO.listScrinCode =='L'){
	    		  document.cmntMenuFrm.listScrinCode[0].checked=true;
	    	  }
			  if(data.resultVO.listScrinCode =='I'){
				  document.cmntMenuFrm.listScrinCode[1].checked=true;
	    	  }
			  
			  if(data.resultVO.listScrinCode =='E'){
				  document.cmntMenuFrm.listScrinCode[2].checked=true;
	    	  }
			  
			  if(data.resultVO.listScrinCode =='B'){
				  document.cmntMenuFrm.listScrinCode[3].checked=true;
	    	  }
			  
			  if(data.resultVO.atchFilePosblAt == 'Y'){
				  $('#atchFilePosblAtY').prop('checked', true);
				  $('#atchFilePosblCo option[value='+data.resultVO.atchFilePosblCo+']').attr('selected', true);
			  }else {
				  $('#atchFilePosblAtN').prop('checked', true);
				  $('#atchFilePosblCo').prop('disabled', true);
			  }
			  
			  document.cmntMenuFrm.bbsSeq.value = data.resultVO.bbsSeq;
			  
			  $('#btnBox-modify').show();
			  $('#btnBox-regist').hide();
			  $('#cmntMenuFrm #menuTit').html('<spring:message code="wzwg.cmm.word.updt" text="update" />');
			  $('.menuRegister').css('display', '');
			  
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'json'
	 	});
	}
	
	
	
	function fn_registMenu(){  
		if(document.cmntMenuFrm.menuNm.value ==''){
			alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.module.word.menunm" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
			return;
		} 
		if(document.cmntMenuFrm.menuSeq.value !=''){
			$.ajax({
		        type:'POST'
		      , url:'<c:out value="${wzwg_contextPath}"/>/module/cmnt/mngr/modifyCmntMenuAjax.do'
		      , data:$("#cmntMenuFrm").serialize()
		      , cache : false
		      , async : false 
		      , success:function (data) {  
		    	  alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>');
		    	  fn_menu();
		      }
		      , error:function (data) {
		          alert('<spring:message code="fail.common.msg" text="error" />');
		      }
		      , dataType: 'html'
		 	});
		}else{
			$.ajax({
		        type:'POST'
		      , url:'<c:out value="${wzwg_contextPath}"/>/module/cmnt/mngr/registCmntMenuAjax.do'
		      , data:$("#cmntMenuFrm").serialize()
		      , cache : false
		      , async : false 
		      , success:function (data) { 
		    	  if(data.menuCnt >= 7){
		    		  alert('<spring:message code="wzwg.cmm.msg.MSG048" text="Up to 7 menus can be registered" />');
		    	  }else{
			    	  alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
			    	  fn_menu();
		    	  }
		      }
		      , error:function (data) {
		          alert('<spring:message code="fail.common.msg" text="error" />');
		      }
		      , dataType: 'html'
		 	});
		}
	}
	
	function fn_cmntModifyOrd(elid, command){
		var selectItem = $('#' + elid);
		var targetItem;
		
		if(command == 'down'){
			targetItem = selectItem.prev();
		}else{
			targetItem = selectItem.next();
		}
		
		
		/***
		$('.cmntMenuList ul li').css('background', '#ddd');
		selectItem.css('background', '#fff');
		targetItem.css('background', '#f00');
		
		if(targetItem.length == 0){
			selectItem.css('background', '#000');
		}
		/****/
		//console.log(selectItem);
		//console.log(targetItem);
		
		var submitForm = {
				cmntSeq : $('#cmntSeq').val()
			,	selectMnSeq : selectItem.attr('data-menuSeq')
			,   targetMnSeq : targetItem.attr('data-menuSeq')
			,   selectMnOrd : selectItem.attr('data-menuLv')
			,   targetMnOrd : targetItem.attr('data-menuLv')
			
		};
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}"/>/module/cmnt/mngr/modifyCmntMeunOrdAjax.do'
	      , data: submitForm
	      , cache : false
	      , async : false 
	      , success:function (data) { 
	    	  //console.log(data);
	    	  if(data.result == 'success'){
	    		  fn_menu();
	    	  }
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
	
	function fn_deleteMenu(){
		
		if(confirm('<spring:message code="wzwg.cmm.msg.MSG334" text="Delete the menu?"/>') == false){
			return;
		}
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}"/>/module/cmnt/mngr/deleteCmntMeunAjax.do'
	      , data:$("#cmntMenuFrm").serialize()
	      , cache : false
	      , async : false 
	      , success:function (data) { 
	    	  if(data.result == 'success'){
	    		  fn_menu();
	    	  }
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
	
	function fnMenuRegistForm() {
		$('#cmntMenuFrm #menuSeq').val('');
		$('#cmntMenuFrm #menuNm').val('');
		$('#cmntMenuFrm #menuTit').html('<spring:message code="wzwg.cmm.word.regist" text="regist" />');
		$('#cmntMenuFrm input[type=radio]:first').prop('checked', true);
		$('#cmntMenuFrm input[type=checkbox]').attr('checked', false);
		$('#atchFilePosblAtY').prop('checked', true);
		$('#atchFilePosblCo').prop('disabled', false);
		$('#atchFilePosblCo option[value=1]').attr('selected', true);
		$('#btnBox-modify').hide();
		$('#btnBox-regist').show();
		$('.menuRegister').css('display', '');
	}
	
</script>
	<form name="cmntMenuFrm" id="cmntMenuFrm">
		<input type="hidden" name="cmntSeq" id="cmntSeq" value="<c:out value='${param.cmntSeq }'/>"/>
		<input type="hidden" name="menuSeq" id="menuSeq"/>
		<input type="hidden" name="bbsSeq" id="bbsSeq"/>
		<h5 class="fs24 pt20 pb20 fn wd100 clboth"><spring:message code="mgr.menuMngt" text="menu Manage" /></h5>
		<div class="menuallBox">
			<div class="menuType mb50">
				<p>
					<spring:message code="wzwg.module.word.menustrct" />
				</p>
				<div class="ctr-box"> 
				<!-- 
					<a href="" class="fr btn-a"><spring:message code="wzwg.cmm.word.menu" /> <spring:message code="wzwg.cmm.word.regist" /></a>
				 -->
				</div>
				<%-- <div class="typeModify">
					 <ol class="dd-list">
					   <c:forEach items="${menuList}" var="resultList">
						 <li class="dd-item" data-id="${resultList.menuOrdr}" data-menuSeq="${resultList.menuSeq}" data-menuLv="${resultList.menuOrdr}"  >
	            						   <div class='dd-handle' ><c:out value="${resultList.menuNm}"/>  <a href="javascript:void(0);" onmousedown="javascript:fn_cmntDetail('<c:out value="${resultList.menuSeq}"/>');" class="wzbtn-table btn-basic" style="float: right; margin-right: 20px; padding-top: 2px; padding-bottom: 2px;"><spring:message code="wzwg.cmm.word.updt" text="update" /></a> </div>					
						</li>
						</c:forEach>
					</ol>
					<span class="">*<spring:message code="wzwg.cmm.msg.MSG048" text="Up to 7 menus can be registered" /></span>
				</div> --%>
				<div class="cmntMenuList">
					<ul>
						<c:forEach items="${menuList}" var="resultList">
						<li data-id="<c:out value='${resultList.menuOrdr}'/>" data-menuSeq="<c:out value='${resultList.menuSeq}'/>" data-menuLv="<c:out value='${resultList.menuOrdr}'/>"  id="mnl_<c:out value='${resultList.menuSeq }'/>">
						 	<c:out value="${resultList.menuNm}"/>
	            							<span class='fr'>  
	            								<button type="button" onclick="javascript:fn_cmntModifyOrd('mnl_<c:out value="${resultList.menuSeq }"/>', 'down');" class="btn-basic iconOnlyBtn btn-sortUp" title="<spring:message code="wzwg.cmm.word.up" />" >▲</button> 
	            								<button type="button" onclick="javascript:fn_cmntModifyOrd('mnl_<c:out value="${resultList.menuSeq }"/>', 'up');" class="btn-basic iconOnlyBtn btn-sortDown" title="<spring:message code="wzwg.cmm.word.down" />" >▼</button> 
	            								<button type="button" onclick="javascript:fn_cmntDetail('<c:out value="${resultList.menuSeq}"/>');" class="iconOnlyBtn btn-basic btn-modify"><spring:message code="wzwg.cmm.word.updt" text="update" /></button> 
	            							</span>					
						</li>
						</c:forEach>
					</ul>
					<span class="">*<spring:message code="wzwg.cmm.msg.MSG048" text="Up to 7 menus can be registered" /></span>
					<div class="rt-box">
					  	<a href="javascript:;" onclick="fnMenuRegistForm()" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.regist" text="regist" /></a>
				  	</div>
				</div>
			</div>
			<div class="menuRegister mb50" style="display:none;">
				<p><spring:message code="wzwg.cmm.word.menu" text="menu" /> <span id="menuTit"></span></p>
				 <div class="joinUs_box">
					<table class="mb10">
						<caption id="menucaption1"><spring:message code="wzwg.cmm.cmmMsg.CMG024"><spring:argument><spring:message code="wzwg.module.word.menunm" />, <spring:message code="wzwg.module.word.bbsty" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.wa.table" /></spring:argument></spring:message></caption>
						<colgroup>
							<col width="25%">
							<col width="75%">
						</colgroup>
						<tr>
							<th scope="row"><spring:message code="mgr.menuNm" text="menu name" /></th>
							<td style="text-align: left;"><input type="text" name="menuNm" id="menuNm" title="<spring:message code="wzwg.module.word.menunminpcmpt" />"></td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="wzwg.module.word.bbsty" /></th>
							<td>
								<ul>
									<%-- <li><input type="radio" name="listScrinCode" id="listScrinCode" value="L"/><span><spring:message code="wzwg.cmm.word.bbs" text="board" /> <spring:message code="wzwg.cmm.word.ty" text="type" /></span></li>
									<li><input type="radio" name="listScrinCode" id="listScrinCode" value="I"/><span><spring:message code="wzwg.cmm.word.album" text="album" /> <spring:message code="wzwg.cmm.word.ty" text="type" /></span></li>
									<li><input type="radio" name="listScrinCode" id="listScrinCode" value="B"/><span><spring:message code="wzwg.cmm.word._blog" text="blog" /> <spring:message code="wzwg.cmm.word.ty" text="type" /></span></li>
									<li><input type="radio" name="listScrinCode" id="listScrinCode" value="E"/><span><spring:message code="wzwg.cmm.word.event" text="event" /> <spring:message code="wzwg.cmm.word.ty" text="type" /></span></li> --%>
									<li class="bbs-tySel" style="text-align: center;">
			                        	<label for="listScrinCodeD" style="cursor: pointer;">
			                        		<img src="/images/wzwg/module/ntt/01board.png" alt="" style="display: block; margin-bottom: 10px" onclick="$('#listScrinCodeD').click();">
			                        		<input type="radio" id="listScrinCodeD" checked="checked" name="listScrinCode" value="L"/><spring:message code="wzwg.cmm.word.bbs" text="bbs" />
			                        	</label>
			                        </li>
			                        <li class="bbs-tySel" style="text-align: center;">
			                        	<label for="listScrinCodeC" style="cursor: pointer;">
			                        		<img src="/images/wzwg/module/ntt/02album.png" alt="" style="display: block; margin-bottom: 10px" onclick="$('#listScrinCodeC').click();">
			                        		<input type="radio" id="listScrinCodeC" name="listScrinCode" value="I" /><spring:message code="wzwg.cmm.word.album" text="album" />
			                        	</label>
			                        </li>
			                        <li class="bbs-tySel" style="text-align: center;">
			                        	<label for="listScrinCodeE" style="cursor: pointer;">
			                        		<img src="/images/wzwg/module/ntt/03event.png" alt="" style="display: block; margin-bottom: 10px" onclick="$('#listScrinCodeE').click();">
			                        		<input type="radio" id="listScrinCodeE" name="listScrinCode" value="E" /><spring:message code="wzwg.cmm.word.event" text="event" />
			                        	</label>
			                        </li>
			                       <%--  <li class="bbs-tySel" style="text-align: center;">
			                        	<label for="listScrinCodeB" style="cursor: pointer;">
			                        		<img src="/images/wzwg/module/ntt/04webzine.png" alt="" style="display: block; margin-bottom: 10px">
			                        		<input type="radio" id="listScrinCodeB" name="listScrinCode" value="W" /><spring:message code="wzwg.cmm.word.webzine" text="webzine" />
			                        	</label>
			                        </li> --%>
			                        <%-- <li class="bbs-tySel" style="text-align: center;">
			                        	<label for="listScrinCodeA" style="cursor: pointer;">
			                        		<img src="/images/wzwg/module/ntt/05blog.png" alt="" style="display: block; margin-bottom: 10px" onclick="$('#listScrinCodeA').click();">
			                        		<input type="radio" id="listScrinCodeA" name="listScrinCode" value="B" /><spring:message code="wzwg.cmm.word._blog" text="blog" />
			                        	</label>
			                        </li> --%>
								</ul>
							</td>
						</tr>
						<tr>
		                	<th scope="row"><spring:message code="wzwg.module.word.atchfileposblcount" /></th>
		                	<td>
		                		<ul class="wzForm">
			                        <li>
			                        	<input type="radio" class="vert-m" id="atchFilePosblAtY" name="atchFilePosblAt"  value="Y" checked/><label for="atchFilePosblAtY" class="linehgt40"><spring:message code="wzwg.cmm.word.use" text="use" /></label>
			                        	( <spring:message code="wzwg.cmm.word.unit" /> 	
			                        		<select id="atchFilePosblCo" name="atchFilePosblCo" style="float: none;" title="<spring:message code="wzwg.module.word.atchfileusecountse" />">
				                        		<c:forEach var="result" begin="1" end="10" step="1">
				                        			<option value="${result}"><label for="unit"><c:out value='${result}'/> <spring:message code="wzwg.cmm.word.count02" /></label></option>
				                        		</c:forEach>
				                        	</select> )
			                        </li>
			                        <li class="wd100 clboth txt-l"><input type="radio" class="vert-m" id="atchFilePosblAtN" name="atchFilePosblAt"  value="N" /><label for="atchFilePosblAtN" class="linehgt40"><spring:message code="wzwg.cmm.word.unuse" text="unuse" /></label></li>
		                        </ul>
		                	</td>
		                </tr>
					</table>
					<p class="mb5"><spring:message code="wzwg.module.word.authorestbs" /></p>
					<table>
						<caption id="menucaption2"><spring:message code="wzwg.cmm.cmmMsg.CMG024"><spring:argument><spring:message code="wzwg.module.word.confmmber" />, <spring:message code="wzwg.module.word.uapprdmbermenuauthor" />(<spring:message code="wzwg.cmm.word.redng" />, <spring:message code="wzwg.cmm.word.wrt" />)</spring:argument><spring:argument><spring:message code="wzwg.cmm.word.wa.table" /></spring:argument></spring:message></caption>
						<colgroup>
							<col width="25%">
							<col width="75%">
						</colgroup>
						<tr>
							<th scope="row"><spring:message code="wzwg.module.word.confmmber" /></th>
							<td>
								<ul class="wzForm">
									<li>
										<input type="hidden" name="authSeAppC" id="authSeAppC" value="Y"/>
										<input type="checkbox" name="authSeAppR" id="authSeAppR" value="Y" />
										<label for="authSeAppR"><spring:message code="wzwg.cmm.word.redng" text="reading" /></label>
									</li>
									<li>
										<input type="checkbox" name="authSeAppW" id="authSeAppW" value="Y" />
										<label for="authSeAppW"><spring:message code="wzwg.cmm.word.wrt" text="write" /></label>
									</li>
								</ul>
							</td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="wzwg.module.word.uapprdmber" /></th>
							<td>
								<ul class="wzForm">
									<li>
										<input type="hidden" name="authSeNappC" id="authSeNappC" value="Y"/>
										<input type="checkbox" name="authSeNappR" id="authSeNappR" value="Y" />
										<label for="authSeNappR"><spring:message code="wzwg.cmm.word.redng" text="reading" /></label>
									</li>
									<li>
										<input type="checkbox" name="authSeNappW" id="authSeNappW" value="Y" />
										<label for="authSeNappW"><spring:message code="wzwg.cmm.word.wrt" text="write" /></label>
									</li>
								</ul>
							</td>
						</tr>
					</table>
				  </div><!-- joinUs_box end -->
				  
				  
				  <div class="rt-box" id="btnBox-modify" style="display: none;">
					  <a href="javascript:;" onclick="fn_deleteMenu()" class="wzbtn btn-del fl"><spring:message code="wzwg.cmm.word.delete" text="delete" /></a>
					  <a href="javascript:;" onclick="fn_registMenu()" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.updt" text="update" /></a>
					  <a href="javascript:;" onclick="fn_formCancel()" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.cancl" text="cancel" /></a>
				  </div>
				  
				  <div class="rt-box" id="btnBox-regist">
					  <a href="javascript:;" onclick="fn_registMenu()" class="wzbtn btn-save"><spring:message code="button.save" text="save" /></a>
				  </div>
				  
				  
				</div><!-- END -->
			</div>
		</form>