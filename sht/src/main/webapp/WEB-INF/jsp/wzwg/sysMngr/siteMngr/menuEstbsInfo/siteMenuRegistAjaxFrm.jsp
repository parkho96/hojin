<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
	
	
	<script type="text/javascript">
		function  fnRegistMenuMngrAjax(){ 

		    if(!Validator.validate(document.frmMenu)) return;
		    
		    if ($('#menumdTyCode1').val().indexOf('SC00000030') > -1 || $('#menumdTyCode1').val().indexOf('SC00000031') > -1 || $('#menumdTyCode1').val().indexOf('SC00000032') > -1) {
		        if ($('#sitecntntsSeq').val().trim().length < 1) {
		            var meg = '<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument>';
		            meg += '<spring:message code="wzwg.sysMngr.word.cntnts/bbsCnnc" />';
		            meg += '</spring:argument></spring:message>';
		            return alert(meg);
		        }
		    }
            if ($('#menumdTyCode1').val() == 'link') {
                if ($('#menuLinkUrl').val().trim().length < 1) {
                    var meg = '<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument>';
                    meg += '<spring:message code="wzwg.sysMngr.word.linkAdres" />';
                    meg += '</spring:argument></spring:message>';
                    return alert(meg);
                }
            }
		    
			$.ajax({
				  method:'post'
		        , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/menuEstbsInfo/registSiteMenuMngrAjax.do'
		        , type:'html'
		        , data: $("#frmMenu").serialize()
		        , success:function (data) {  
		        	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>');
		        	fnListAjax();
		        	fnLayerPopupClose();
		        	
		        }
		    }); 
		}
		
		function fnMenuModuleTyChange(value){
			var sysmoduleSeq = '';
			var moduleTyCode = '';
			if(value !='' && value !='link' ){
				sysmoduleSeq = value.split(",")[0];
				  moduleTyCode = value.split(",")[1];
			}else{
				sysmoduleSeq = value;
				moduleTyCode ='';
			}
			$("#sysmoduleSeq").val(sysmoduleSeq);
			$("#menuTyCode").val(moduleTyCode); 
			if(sysmoduleSeq =='' || moduleTyCode=='SC00000033'){
				$("#menuDiv").css("display","none");
				$("#linkDiv").css("display","none"); 
			}else if(sysmoduleSeq=='link'){
				$("#menuDiv").css("display","none");
				$("#linkDiv").css("display",""); 
			}else{
				$("#menuDiv").css("display","");
				$("#linkDiv").css("display","none");  
				$.ajax({
					  method:'post'
			        , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/menuEstbsInfo/siteMenuCntntListAjax.do'
			        , type:'html'
			        , data:{"sysmoduleSeq":sysmoduleSeq}
			        , success:function (data) { 
			        	 $("#cntntsNmSpan").html(data); 
			        }
			    }); 
			}
		}
		
		function changeCntntsSeq(select){
			//console.log(select);
			$('#menuNm').val($(select).find(":selected").text());
		}
		
		function fnAllCelar() {
		    
		    //var siteId = document.getElementById("siteId").value;
		    
		    $.ajax({
		           type:'POST'
		         , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/menuEstbsInfo/registSiteMenuMngrFrmAjax.do'
		         , data:{'estbsinfoSeq':'<c:out value="${paramVO.estbsinfoSeq}" />'} 
		         , success:function (data) {
		                //$("#divLayerPopup").html(data);
		                //$("#divLayerPopup").show();
		                     // 부모코드 셋팅 
		                    // fnGetMenuList();
		                     
		                //   document.getElementById("menuNm").focus();
		        	 	$('.wzpopup .pop-container').html(data);
		                   }
		         , dataType: 'html'
		    });
		}
	</script>
	
	
		<form id="frmMenu" name="frmMenu" method="post">
			<input type="hidden" name="sysmoduleSeq" id="sysmoduleSeq" value=""/>
			<input type="hidden" name="menuTyCode" id="menuTyCode" value=""/>
			<input type="hidden" name="estbsinfoSeq" id="estbsinfoSeq" value="<c:out value="${paramVO.estbsinfoSeq}" />"/>

				<table class="basic">
				<colgroup>
					<col style="width: 35%;">
					<col style="width: *;">
				</colgroup>
				<tbody>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.groupUpperMenu" /></th>
					<td>
						<select  name="upperMenuSeq"  >
						<option value=""><spring:message code="wzwg.cmm.word.none" /></option>
						<c:forEach items="${resultList['MENU_LIST']}" var="list" varStatus="status">
							<option value="<c:out value="${list.menuSeq}" />"> <c:out value="${list.menuNm}" /></option>
						</c:forEach>
						</select>
					</td>
				</tr> 
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.pgTy" /></th>
					<td>
						<select name="menumdTyCode1" id="menumdTyCode1" onchange="fnMenuModuleTyChange(this.value);" >
						  <option value=""><spring:message code="wzwg.cmm.word.group" /></option>
						  <option value="link"><spring:message code="wzwg.cmm.word.link" /></option>
						  <c:forEach items="${resultList['CNTNTS_LIST']}" var="list" varStatus="status">
							<option value="<c:out value="${list.sysmoduleSeq}" />,<c:out value="${list.moduleTyCode}" />"> <c:out value="${list.moduleNm}" /></option>
						</c:forEach>
						</select>
					</td>
				</tr>
				<tr id="menuDiv" style="display:none ;">
					<th><spring:message code="wzwg.sysMngr.word.cntnts/bbsCnnc" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td id="dataConn">
						<div id="cntntsNmSpan">
						<select>
							<option><spring:message code="wzwg.cmm.msg.MSG139" /></option>
						</select>
						</div>
					</td>
				</tr>
				
				<tr id="linkDiv" style="display:none ;">
					<th><spring:message code="wzwg.sysMngr.word.linkAdres" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td id="dataConn">
					 <input type="text" id="menuLinkUrl" name="menuLinkUrl" title="<spring:message code="wzwg.sysMngr.word.linkAdres" />" value="" class="w70" />
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.menuNm01" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td><input id="menuNm" name="menuNm" dir="required" title="<spring:message code="wzwg.sysMngr.word.menuNm01" />" class="w70" /></td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.menuDc" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td>
						<input id="menuDc"  name="menuDc" dir="required" title="<spring:message code="wzwg.sysMngr.word.menuDc" />" class="w70" />
					</td>
				</tr>
				<tr>
				   <th><spring:message code="wzwg.cmm.word.sttus" /></th>
				   <td> 
				   	   <ul class="wzForm">
				   			<li><input type="radio" id="menuSttusCode2" name="menuSttusCode" value="SC00000035" checked="checked"/><label for="menuSttusCode2"><spring:message code="wzwg.cmm.word.use" /></label></li>
				   			<li><input type="radio" id="menuSttusCode1" name="menuSttusCode" value="SC00000034"   /><label for="menuSttusCode1"><spring:message code="wzwg.cmm.word.hide" /></label></li>
				   	   </ul>
				   </td>
				</tr>
				</tbody>
				</table>
		
		<div class="rt-box">
			<a href="javascript:void(0);"  onclick="javascript:fnRegistMenuMngrAjax();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a> 
			<a href="javascript:void(0);" onclick="wzModalClose();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a> 
			<a href="javascript:void(0);" onclick="javascript:fnAllCelar();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.initl" /></a>
		</div>
		
		</form>
			
