<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<%-- 위디자인 컬러 세팅 --%>
<c:set var="pointColList">red,pink,orange,yellow,green,blue,brown,purple,white,grey,black</c:set>

	<script src="/js/wzwg/cmm/tendina.min.js"></script>
	<script language="javascript" type="text/javascript" src="/jquery/js/jquery.form.min.js"></script>
	
	<script type="text/javascript">
		
		$(function() {
			<c:if test="${not empty siteHdftrMenuVO.strngthStyle}">
			$('.menuPointColList').find('button').removeClass('active');
			$('.menuPointColList').find('button').each(function (idx, el) {
				if($('#strngthStyle').val() == $(el).css('color')){
					$(el).addClass('active');
				}
			});
			</c:if>
		});
	
		/** 사이트사용자그룹 등록 */
		function fn_siteHdftrMenuModify(){
		
			if($('#hdftrmenuNm').val() == '') {
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.site.menu.msg.MSG026" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
				$("#hdftrmenuNm").focus();
				return;
			}
			
			if($("input[name='menuTySe']:checked").val() == "I"){
				/** 이미지파일 확장자 체크 */
				
				if($('#iconFile').length > 0) {
					var imgVal = $('#iconFile').val();
				    if(imgVal) {
				        
				    	var imgNm = imgVal.slice(imgVal.indexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로 만듭니다.
				        
				        if(imgNm != "jpg" && imgNm != "png" && imgNm != "gif"){ //확장자를 확인합니다.
				            alert('<spring:message code="wzwg.cmm.msg.MSG126" />');
				        	$("#iconFile").focus();
				            return;
				        }
				    	
				    }else {
				    	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.site.menu.msg.MSG038" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument></spring:message>');
						return;
				    }
				}
			    
				if($('input[name=iconReplcText]').val() == ''){
		        	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.site.menu.msg.MSG039" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
		        	$('input[name=iconReplcText]').focus();
		        	return;
		        }
				
				$('#lgnAt').val('Y');
				
			}else {
				$('#iconFile').val('');
			    $('input[name=iconReplcText]').val('');
			}
			
			if($("input[name='menuTySe']:checked").val() != "N"){
				$('#strngthStyle').val('');
			}
			
			var dplctChk = false;
			var hdftrmenuSeq = $("#hdftrmenuSeq").val();
			
			if($("input[name='menuTySe']:checked").val() == "T"){
				
				var chk = '<c:out value="${siteHdftrMenuVO.lgnAt}"/>';
				nChk = chk;
				yChk = chk;
				
				$.ajax({
					type:'POST'
					, url:'<c:out value="${wzwg_contextPath}"/>/mngr/menu/selectSiteHdftrMenuTrnslatChkAjax.do'
					, data:{hdftrmenuSeq:hdftrmenuSeq,nChk:nChk,yChk:yChk}
					, async : false
					,success:function (result){
						$(result).find('value').each(function(){
							if($(this).text() == "success"){
								dplctChk = true;
							}else{
								alert('<spring:message code="wzwg.cmm.cmmMsg.CMG018"><spring:argument><spring:message code="wzwg.site.menu.msg.MSG021" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.one" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
							}
						})
					}
					, error:function (request, status, error) {
			              alert('<spring:message code="fail.common.msg" text="error" />');
			          }
				});
			}else{
				dplctChk = true;
			}
			
			var frm = $("#siteHdfrmMenuForm");
			
			if(dplctChk == true){
			frm.ajaxSubmit({
				type:'POST'
				, url:'<c:out value="${wzwg_contextPath}"/>/mngr/menu/selectSiteHdftrMenuModifyAjax.do'
				, async : false
				, data : frm
				, mimeType : 'multipart/form-data'
				, success:function (result){
					$(result).find('value').each(function(){
						if($(this).text() == "success"){
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>');
							fn_list();
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
						}
					})
				}
				, error:function (request, status, error) {
		              alert('<spring:message code="fail.common.msg" text="error" />');
		          }
		        , dataType: 'xml'
				});
			}
		}
		
		
		function fn_siteHdftrMenuDelete(){
			$.ajax({
				type:'POST'
				, url:'<c:out value="${wzwg_contextPath}"/>/mngr/menu/deleteSiteHdftrMenuAjax.do'
				, data:$("#siteHdfrmMenuForm").serialize()
				,success:function (result){
					$(result).find('value').each(function(){
						if($(this).text() == "success"){
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
							fn_list();
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
						}
					})
				}
				, error:function (request, status, error) {
		              alert('<spring:message code="fail.common.msg" text="error" />');
		          }
			});
		}
		
		/** 사이트사용자그룹 리스트로 이동*/
		function fn_list(){
			<c:if test="${siteHdftrMenuVO.hdftrCode eq 'SC00000081'}">
			document.siteHdfrmMenuForm.action='<c:out value="${wzwg_contextPath}"/>/mngr/menu/selectSiteHdMenuMngrList.do';
			</c:if>
			<c:if test="${siteHdftrMenuVO.hdftrCode eq 'SC00000082'}">
			document.siteHdfrmMenuForm.action='<c:out value="${wzwg_contextPath}"/>/mngr/menu/selectSiteFtrMenuMngrList.do';
			</c:if>
			document.siteHdfrmMenuForm.submit();
		}
        
        function fnChkRdo(val) {
            $('.trDisplayChk').hide();
            $('.ty_'+val).show();
        }
        
        $(document).ready(function() {
            fnChkRdo('<c:out value="${siteHdftrMenuVO.menuTySe}"/>');
            
            $('.linkMenuList').tendina({
				animate: true,
				speed: 300,
				onHover: false,
				hoverDelay: 100,
				activeMenu: $('#deepest'),
				openCallback: function(clickedEl) {
				  console.log('Hey dude!');
				},
				closeCallback: function(clickedEl) {
				  console.log('Bye dude!');
				}
			 }); //lnb메뉴
        });
        
        function selectMenuLink(url, name){
			$('#hdftrmenuNm').val(name);
			$('#hdftrmenuDc').val(name);
			$('#hdftrmenuLinkUrl').val(url);
			//$('#hdftrmenuLinkUrl').focus();
		}
        
        function fnFileModify(){
			$("#fileArea").empty();
			$("#fileArea").append('<input type="file" name="iconFile" id="iconFile" title="<spring:message code="wzwg.cmm.word.icon" />"/>');
		}
        
        function selectPointCol(el, col){
			$('.menuPointColList').find('button').removeClass('active');
			$(el).addClass('active');
			
			if(col) {
				$('#strngthStyle').val($(el).css('color'));
			}else {
				$('#strngthStyle').val('');
			}
		}
	</script>

		<form id="siteHdfrmMenuForm" name="siteHdfrmMenuForm" method="post" enctype="multipart/form-data">
		<input type="hidden"  name="hdftrmenuSeq" id="hdftrmenuSeq" value="<c:out value="${siteHdftrMenuVO.hdftrmenuSeq}"/>" />
		<input type="hidden"  name="lgnAt" id="lgnAt" value="<c:out value="${siteHdftrMenuVO.lgnAt}"/>" />
		<input type="hidden"  name="hdftrmenuOrdr" id="hdftrmenuOrdr" value="<c:out value="${siteHdftrMenuVO.hdftrmenuOrdr}"/>" />
		<input type="hidden"  name="hdftrCode" id="hdftrCode" value="<c:out value="${siteHdftrMenuVO.hdftrCode}"/>" />
		<input type="hidden"  name="strngthStyle" id="strngthStyle" value="<c:out value="${siteHdftrMenuVO.strngthStyle}"/>" />
		
		<table class="basic" summary="<spring:message code="wzwg.site.menu.msg.MSG049"/>">
			<colgroup>
				<col width="20%"/>
				<col width="*"/>
			</colgroup>
			<thead>
				<tr>
					<th colspan="2" class="wzAdmSTit">
						<c:if test="${siteHdftrMenuVO.hdftrCode eq 'SC00000081'}"><spring:message code="wzwg.cmm.cntnts.mnuModify" ><spring:argument><spring:message code="wzwg.cmm.word.upend" /></spring:argument></spring:message></c:if>
						<c:if test="${siteHdftrMenuVO.hdftrCode eq 'SC00000082'}"><spring:message code="wzwg.cmm.cntnts.mnuModify" ><spring:argument><spring:message code="wzwg.cmm.word.lpt" /></spring:argument></spring:message></c:if>
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th scope="row"><spring:message code="wzwg.site.menu.msg.MSG026" /></th>
					<td class="ta_l">
						<c:set var="msg_txt">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.site.menu.msg.MSG026" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
						</c:set>
						
						<input type="text" name="hdftrmenuNm"  id="hdftrmenuNm"   class="w70" dir="required" title="<spring:message code="wzwg.site.menu.msg.MSG026" />" value="<c:out value="${siteHdftrMenuVO.hdftrmenuNm}"/>" placeholder="<c:out value="${msg_txt}"/>"/>
					</td>
				</tr>
                <tr>
                    <th scope="row"><spring:message code="wzwg.cmm.word.menu" /> <spring:message code="wzwg.cmm.word.ty03" /></th>
                    <td class="ta_l">
                    	<ul class="wzForm">
                    	<c:if test="${siteHdftrMenuVO.menuTySe ne 'I'}">
                    		<li><label><input type="radio" name="menuTySe" id="menuTySe" value="N" onclick="fnChkRdo(this.value);" <c:if test="${siteHdftrMenuVO.menuTySe eq 'N'}">checked</c:if> /><span class="spanLabel"><spring:message code="wzwg.cmm.word.gnrl" /></span></label></li>
                        	<li><label><input type="radio" name="menuTySe" id="menuTySe" value="G" onclick="fnChkRdo(this.value);" <c:if test="${siteHdftrMenuVO.menuTySe eq 'G'}">checked</c:if> /><span class="spanLabel"><spring:message code="wzwg.cmm.word.group" /></span></label></li>
                        </c:if>
                        <c:if test="${siteHdftrMenuVO.hdftrCode eq 'SC00000082' and siteHdftrMenuVO.menuTySe eq 'I'}">
                        	<li><label><input type="radio" name="menuTySe" id="menuTySe" value="I" onclick="fnChkRdo(this.value);" <c:if test="${siteHdftrMenuVO.menuTySe eq 'I'}">checked</c:if> /><span class="spanLabel"><spring:message code="wzwg.site.menu.msg.MSG019" /></span></label></li>
                        </c:if>
                         <c:if test="${siteHdftrMenuVO.hdftrCode eq 'SC00000081'}">
                        	<li><label><input type="radio" name="menuTySe" id="menuTySe" value="T" onclick="fnChkRdo(this.value);" <c:if test="${siteHdftrMenuVO.menuTySe eq 'T'}">checked</c:if> /><span class="spanLabel"><spring:message code="wzwg.site.menu.msg.MSG021" /></span></label></li>
                        </c:if>
                        </ul>
                        
                        <span class="wz_tableguide mt10 block clboth"><spring:message code="wzwg.cmm.msg.tip.MSG002" /><br>
                        <strong><spring:message code="wzwg.site.menu.msg.MSG019" /></strong> : <spring:message code="wzwg.cmm.msg.tip.MSG0023" />
                        </span>
                    </td>
                </tr>
                <tr  class="trDisplayChk ty_N">
					<th scope="row"><spring:message code="wzwg.site.menu.msg.MSG040"/></th>
					<td class="ta_l">
						<div class="menuPointColList">
							<ul>
								<li class="fn i-block mb10"><button type="button" class="active"  onclick="selectPointCol(this)"><spring:message code="wzwg.cmm.word.unsel"/></button></li>
								<c:forEach items="${fn:split(pointColList, ',') }" var="list">
								<li class="fn i-block mb10"><button type="button" class="<c:out value="${list}"/>"  onclick="selectPointCol(this,'<c:out value="${list}"/>')"><spring:message code="wzwg.site.menu.msg.MSG026"/></button></li>
								</c:forEach>
							</ul>
						</div>
					</td>
				</tr>
                <c:if test="${siteHdftrMenuVO.hdftrCode eq 'SC00000082'}">
                <tr class="trDisplayChk ty_I" style="display:none;">
					<th scope="row"><spring:message code="wzwg.site.menu.msg.MSG038" /></th>
					<td class="ta_l">
						<c:if test="${empty siteHdftrMenuVO.iconFileId}">
							<input type="file" name="iconFile" id="iconFile" title="<spring:message code="wzwg.site.menu.msg.MSG038" />"/>
						</c:if>
						<c:if test="${not empty siteHdftrMenuVO.iconFileId}">
						<span id="fileArea">
							<img src='<c:url value='/module/upload/file/selectImageView.do'/>?atchFileId=<c:out value="${siteHdftrMenuVO.iconFileId }"/>&fileSn=0' style="height: 50px;" alt="<c:out value="${siteHdftrMenuVO.iconReplcText}"/>" />
							<a href="javascript:void(0);" onclick="fnFileModify();" class="btn-delete iconOnlyBtn btn-basic vert-m ml10"><spring:message code="wzwg.site.menu.msg.MSG041" /></a>
						</span>
						</c:if>
						
						<c:set var="iconReplcText">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.site.menu.msg.MSG039" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
						</c:set>
						<input type="text" name="iconReplcText" class="w30" value="<c:out value="${siteHdftrMenuVO.iconReplcText}"/>" placeholder="<c:out value="${iconReplcText }"/>" title="<spring:message code="wzwg.site.menu.msg.MSG039" />"/>
						
						<p class="admpg-subp w100 fl mt10">
						    <span class="circle_no bg-green-strong vert-m">i</span><strong class="grey"><spring:message code="wzwg.cmm.msg.tip.MSG003" /> ?</strong> <spring:message code="wzwg.cmm.msg.tip.MSG004" />
						    <span class="wz_tableguide mt5 pl20"><spring:message code="wzwg.cmm.msg.tip.MSG005" /></span>			
						</p>
					</p>
					</td>
				</tr>
				</c:if>
				<tr class="trDisplayChk ty_N ty_G ty_I">
					<th scope="row"><spring:message code="wzwg.site.menu.msg.MSG015" /></th>
					<td class="ta_l">
						<select name="hdftrmenuTyCode" id="hdftrmenuTyCode"  title="<spring:message code="wzwg.cmm.word.ty"/>">
							<c:forEach items="${hdftrMenuTyCodeList }" var="list">
								<option value="<c:out value="${list.code }"/>" <c:if test="${list.code eq  siteHdftrMenuVO.hdftrmenuTyCode}">selected="true"</c:if>>
									<c:out value="${list.codeNm }"/>
								</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr class="trDisplayChk ty_N">
					<th scope="row"><spring:message code="wzwg.cmm.cntnts.selectsublink" /></th>
					<td class="ta_l">
						<span class="wz_tableguide mt10 mb10 block"><spring:message code="wzwg.cmm.msg.tip.MSG066" /></span>
						<div id="bannerLinkUrlDiv">
						<div class="linkSelect hdftrMenuList">
							<button type="button" class="btn-c linkSelectMenu" onclick="javascript:$('#linkMenuList1').toggle(300);"><spring:message code="wzwg.site.menu.msg.MSG042" /></button>
							
								<ul class="linkMenuList" id="linkMenuList1" style="display: none;">
										   
									<c:forEach items="${menuList}" var="oneDepth" varStatus="status">
									<c:if test="${empty oneDepth.upperMenuSeq or oneDepth.upperMenuSeq eq '0' }">
										<li>
										 <c:choose>
										 	<c:when test="${oneDepth.menuDivision eq 'group' }">
										 		<a href="javascript:void(0);" data-href="menuLinkSeq" data-attr="menuNm">[<c:out value="${oneDepth.menuNm }"/>]</a>
										 	</c:when>
										 	<c:when test="${oneDepth.menuDivision eq 'link'}">
										 		<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${oneDepth.menuLinkUrl}"/>','<c:out value="${oneDepth.menuNm }"/>' )" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${oneDepth.menuNm }"/></a>
										 	</c:when>
										 	<c:otherwise>
										 		<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${wzwg_contextPath}"/>/subList/<c:out value="${oneDepth.menuLinkSeq}"/>','<c:out value="${oneDepth.menuNm }"/>' )" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${oneDepth.menuNm }"/></a>	
										 	</c:otherwise>
										 </c:choose>
											<ul>
											<c:forEach items="${menuList}" var="twoDepth" varStatus="status">
											<c:if test="${oneDepth.menuSeq eq twoDepth.upperMenuSeq}">
												<li>
													<c:choose>
													 	<c:when test="${twoDepth.menuDivision eq 'group' }">
													 		<a href="javascript:void(0);"  data-href="menuLinkSeq" data-attr="menuNm">[<c:out value="${twoDepth.menuNm }"/>]</a>
													 	</c:when>
													 	<c:when test="${twoDepth.menuDivision eq 'link'}">
													 		<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${twoDepth.menuLinkUrl}"/>','<c:out value="${twoDepth.menuNm }"/>' )"  data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${twoDepth.menuNm }"/></a>
													 	</c:when>
													 	<c:otherwise>
													 		<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${wzwg_contextPath}"/>/subList/<c:out value="${twoDepth.menuLinkSeq}"/>','<c:out value="${twoDepth.menuNm }"/>' )" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${twoDepth.menuNm }"/></a>	
													 	</c:otherwise>
													 </c:choose>
							                        
													<ul>
													<c:forEach items="${menuList}" var="threeDepth" varStatus="status">
													  <c:if test="${twoDepth.menuSeq eq threeDepth.upperMenuSeq}"> 
														<li>
														<c:choose>
														 	<c:when test="${threeDepth.menuDivision eq 'group' }">
														 		<a href="javascript:void(0);"  data-href="menuLinkSeq" data-attr="menuNm">[<c:out value="${threeDepth.menuNm }"/>]</a>
														 	</c:when>
														 	<c:when test="${threeDepth.menuDivision eq 'link'}">
														 		<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${threeDepth.menuLinkUrl}"/>','<c:out value="${threeDepth.menuNm }"/>' )" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${threeDepth.menuNm }"/></a>
														 	</c:when>
														 	<c:otherwise>
														 		<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${wzwg_contextPath}"/>/subList/<c:out value="${threeDepth.menuLinkSeq}"/>','<c:out value="${threeDepth.menuNm }"/>' )" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${threeDepth.menuNm }"/></a>	
														 	</c:otherwise>
														 </c:choose>
				
														</li>
													</c:if>
													</c:forEach>
													</ul>
												</li>
											</c:if>
											</c:forEach>	 
											</ul>  
										</li>   
										</c:if>
										</c:forEach>
										<li>
											<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${wzwg_contextPath}"/>/cmm/mber/sbscrb/selectSbscrbUsrTy.do','<spring:message code="wzwg.cmm.word.signup" />' )" ><spring:message code="wzwg.cmm.word.signup" /></a>
										</li>
										<li>
											<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${wzwg_contextPath}"/>/loginForm.do','<spring:message code="wzwg.cmm.word.login" />' )" ><spring:message code="wzwg.cmm.word.login" /></a>
										</li>
										<li>
											<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${wzwg_contextPath}"/>/adLoginForm.do','<spring:message code="wzwg.cmm.word.mngr" />' )" ><spring:message code="wzwg.cmm.word.mngr" /></a>
										</li>
										<li>
											<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${wzwg_contextPath}"/>/actionLogout.do','<spring:message code="wzwg.cmm.word.logout" />' )" ><spring:message code="wzwg.cmm.word.logout" /></a>
										</li>
										<li>
											<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${wzwg_contextPath}"/>/searchIdForm.do','<spring:message code="wzwg.cmm.word.findi" />' )" ><spring:message code="wzwg.cmm.word.findi" /></a>
										</li>
										<li>
											<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${wzwg_contextPath}"/>/searchPwForm.do','<spring:message code="wzwg.cmm.word.findp" />' )" ><spring:message code="wzwg.cmm.word.findp" /></a>
										</li>
										<li>
											<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${wzwg_contextPath}"/>/sitemap.do','<spring:message code="wzwg.cmm.word.sitemap" />' )" ><spring:message code="wzwg.cmm.word.sitemap" /></a>
										</li>
										<li>
											<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${wzwg_contextPath}"/>/cmm/mber/myPage/selectMyPageMain.do','<spring:message code="wzwg.cmm.word.youracct" />' )" ><spring:message code="wzwg.cmm.word.youracct" /></a>
										</li>
<%-- 										<li>
											<a href="javascript:void(0);" onclick="selectMenuLink('/module/stplatLog/selectStplatPrivate.do','<spring:message code="wzwg.cmm.word.pivply" />' )" ><spring:message code="wzwg.cmm.word.pivply" /></a>
										</li> --%>
										<c:forEach items="${stplatList }" var="stplatList" varStatus="status">
										<li>
											<a href="javascript:void(0);" onclick="selectMenuLink('<c:out value="${wzwg_contextPath}"/>/module/stplatLog/selectStplatLogList.do?stplatSeq=<c:out value="${stplatList.stplatSeq }"/>','<c:out value="${stplatList.stplatNm }"/>' )" ><c:out value="${stplatList.stplatNm }"/></a>
										</li>
										</c:forEach>
									</ul> 
						</div>
						</div>
					</td>
				</tr>
				<tr class="trDisplayChk ty_N ty_I">
					<th scope="row"><spring:message code="wzwg.site.menu.msg.MSG016" /></th>
					<td class="ta_l">
						
						<c:set var="msg_txt01">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.site.menu.msg.MSG016" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
						</c:set>
						
						<input type="text" name="hdftrmenuLinkUrl"  id="hdftrmenuLinkUrl"  class="w70" title="<spring:message code="wzwg.site.menu.msg.MSG016"/>"  value="<c:out value="${siteHdftrMenuVO.hdftrmenuLinkUrl}"/>" placeholder="<c:out value="${msg_txt01}"/>"/>
						<span class="wz_tableguide mt10 block"><spring:message code="wzwg.cmm.msg.tip.MSG067" /></span>
					</td>
				</tr>
				<tr class="trDisplayChk ty_N ty_I">
					<th scope="row"><spring:message code="wzwg.site.menu.msg.MSG027" /></th>
					<td class="ta_l">
						
						<c:set var="msg_txt02">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.site.menu.msg.MSG027" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
						</c:set>
						
						<input type="text" name="hdftrmenuDc" id="hdftrmenuDc" class="w70" title="<spring:message code="wzwg.cmm.word.dc"/>"  value="<c:out value="${siteHdftrMenuVO.hdftrmenuDc}"/>" placeholder="<c:out value="${msg_txt02}"/>"/>
					</td>
				</tr>
                <tr class="trDisplayChk ty_G" style="display:none;">
                    <th scope="row"><spring:message code="wzwg.cmm.cntnts.linkgroup" /></th>
                    <td class="ta_l">
                        <select name="linkGrpSeq" id="linkGrpSeq"  title="<spring:message code="wzwg.cmm.word.ty"/>">
                            <c:forEach items="${linkGrpList}" var="result">
                                <option value="<c:out value="${result.linkGrpSeq}"/>" <c:if test="${result.linkGrpSeq eq siteHdftrMenuVO.linkGrpSeq}">selected</c:if>>
                                    <c:out value="${result.groupNm}"/>
                                </option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
			</tbody>
		</table>
		</form>
	<div class="rt-box"> 
		<a href="javascript:void(0);" onclick="fn_siteHdftrMenuDelete();" class="wzbtn btn-del fl"><spring:message code="wzwg.cmm.word.delete" /></a>
		<a href="javascript:void(0);"  class="wzbtn btn-save" onclick="fn_siteHdftrMenuModify();"><spring:message code="wzwg.cmm.word.updt" /></a>
		<a href="javascript:void(0);"   class="wzbtn btn-basic" onclick="fn_list();"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>
