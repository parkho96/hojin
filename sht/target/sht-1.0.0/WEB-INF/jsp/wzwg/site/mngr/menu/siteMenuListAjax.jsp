<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script src="/jquery/js/jquery.nestable.js"></script>
<!-- <link rel="stylesheet" href="/css/wzwg/cmm/jquery.nestable.css" type="text/css" /> -->
         <script>
         $(document).ready(function()
        		 {
		        	 var updateMenu = function(e)
		        	    {
		        		 $('#nestable1  li').each(function (index, childEle){
		        			 var menulv = $(childEle).parents("li").data("menulv");
		        			 if(menulv ==  undefined){
		        				 menulv =0;
		        			 }
		        			 menulv = menulv+1;
		        			 var upperMenuSeq = $(childEle).parents("li").data("menuseq") ;
		        			 var menudivision =   $(childEle).parents("li").data("menudivision") ;
		        			 var groupmenu =   $(childEle).data("menudivision") ;
		        			 var sysmoduleSeq =   $(childEle).data("sysmoduleseq") ; 
		        			 if(menudivision == undefined){
		        				 menudivision = 'group';
		        			 }
		        			 
		        			 if(groupmenu == undefined){
		        				 groupmenu = 'group';
		        			 }
		        			 if(upperMenuSeq == undefined){
		        				 upperMenuSeq =0;
		        			 }
		        			 if(menudivision != 'group'){
		        				 alert('<spring:message code="wzwg.cmm.msg.MSG353" />');
		        				 location.reload();
		        				 return;
		        			 } 
		        			 if(sysmoduleSeq =='888888888888' && menulv >1){
		        				 alert('<spring:message code="wzwg.cmm.msg.MSG354" />');
		        				 location.reload();
		        				 return;
		        			 }
		        			 
		        			 if(groupmenu =='group' && menulv >2){
		        				 alert('<spring:message code="wzwg.cmm.msg.MSG425" />');
		        				 location.reload();
		        				 return;
		        				 
		        			 }
		        			 
		        			 
		        			 
		        			 $.ajax({
								   type:'POST'
								 , url:' <c:out value="${wzwg_contextPath}"/>/mngr/menu/modifySiteMenuMngrOrdrAjax.do'
								 , data:{'menuOrdr' :index,'menuSeq':$(childEle).data("menuseq"),'upperMenuSeq':upperMenuSeq,'menuLv':menulv} 
								 , success:function (data) { 
										   }
								 , dataType: 'json'
							});
		        			 
		        			
		        		 });
		        	       
		        	    };

        	 
        		 	$('#nestable1').nestable({
        		 	     maxDepth: 3
        		 	}).on('change', updateMenu);
        		 	

        		 	$('#nestable-menu').on('click', function(e)
        		 		    {
        		 		        var target = $(e.target),
        		 		            action = target.data('action');
        		 		        if (action === 'expand-all') {
        		 		            $('.dd').nestable('expandAll');
        		 		        }
        		 		        if (action === 'collapse-all') {
        		 		            $('.dd').nestable('collapseAll');
        		 		        }
        		 		    });
        		 });
         </script>
          <c:set var="firstDD" value="0"/>
          <c:set var="secondDD" value="0"/>
            <ol class="dd-list">
            <c:forEach items="${resultList['MENU_LIST']}" var="oneDepth" varStatus="status">
            <c:if test="${empty oneDepth.upperMenuSeq or oneDepth.upperMenuSeq eq '0' }"> 
                <li class="dd-item dd3-item" data-id="<c:out value="${oneDepth.menuOrdr}"/>" data-menuSeq="<c:out value="${oneDepth.menuSeq}"/>" data-menuLv="<c:out value="${oneDepth.menuLv}"/>" data-menuDivision="<c:out value="${oneDepth.mngrMenuDivision}"/>" data-sysmoduleSeq="<c:out value="${oneDepth.sysmoduleSeq}"/>">
                    <div class="dd-handle dd3-handle"></div>
                    <div class='dd3-content <c:if test="${oneDepth.mngrMenuDivision eq 'group'}">group</c:if> <c:if test="${oneDepth.menuSttusCode eq 'SC00000034'}">hide</c:if>' >
                    	<p class="menu">
	                    	<c:out value="${oneDepth.menuNm}" escapeXml="false"/>
	                    	<c:if test="${oneDepth.menuSttusCode eq 'SC00000034'}"><img src="/images/wzwg/site/mngr/menu-hide.png"></c:if>
                    	</p>
                    	<p class="btn">
                    		<a href="javascript:void(0);" onmousedown="javascript:fnSelectMenuAjax('<c:out value="${oneDepth.menuSeq}"/>');" class="iconOnlyBtn btn-basic btn-setting" title="<spring:message code="wzwg.cmm.word.updt" />"></a>
	                    	<c:if test="${not empty oneDepth.menuTyCode }">
	                    		<c:choose>
	                    		<c:when test="${oneDepth.menuTyCode eq 'SC00000033' }">
	                    			<a href="javascript:void(0);" onclick="fnCntntsBassForm('<c:out value="${oneDepth.sysmoduleSeq}"/>');" class="iconOnlyBtnSameSize btn-basic" style=""><spring:message code="wzwg.cmm.word.cntnts" /></a>
	                    		</c:when>
	                    		<c:otherwise>
		                    		<a href="<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/<c:out value="${oneDepth.mngrPageUrl}"/>?cntntsSeq=<c:out value="${oneDepth.cntntsSeq}"/>&sitecntntsSeq=<c:out value="${oneDepth.sitecntntsSeq}"/>" class="iconOnlyBtnSameSize btn-basic" style=""><spring:message code="wzwg.cmm.word.cntnts" /></a>
	                    		</c:otherwise>
	                    		</c:choose> 
	                    	</c:if>
	                    	<c:if test="${empty oneDepth.menuTyCode and not empty oneDepth.linkUrl}">
	   	                 		<a href="<c:out value="${oneDepth.linkUrl}"/>" target="_blank" class="iconOnlyBtnSameSize btn-basic" style=""><spring:message code="wzwg.cmm.word.mvmn" /></a>
	                    	</c:if>
                    	</p>
                   	</div>
                     <c:forEach items="${resultList['MENU_LIST']}" var="twoDepth" varStatus="status">
            			<c:if test="${oneDepth.menuSeq eq twoDepth.upperMenuSeq}"> 
				        
            			<c:set var="firstDD" value="${firstDD +1 }"/>
            			<c:if test="${firstDD eq '1'}"><ol class="dd-list"> </c:if>
                        <li class="dd-item dd3-item" data-id="<c:out value="${twoDepth.menuOrdr}"/>" data-menuSeq="<c:out value="${twoDepth.menuSeq}"/>" data-menuLv="<c:out value="${twoDepth.menuLv}"/>" data-menuDivision="<c:out value="${twoDepth.mngrMenuDivision}"/>"  data-sysmoduleSeq="<c:out value="${twoDepth.sysmoduleSeq}"/>">
                        <div class="dd-handle dd3-handle"></div>
                        <div class="dd3-content <c:if test="${twoDepth.mngrMenuDivision eq 'group'}">group</c:if> <c:if test="${twoDepth.menuSttusCode eq 'SC00000034'}">hide</c:if>">
                        	<p class="menu">
	                        	<c:out value="${twoDepth.menuNm}" escapeXml="false" />
	                        	<c:if test="${twoDepth.menuSttusCode eq 'SC00000034'}"><img src="/images/wzwg/site/mngr/menu-hide.png"></c:if>
                        	</p>
                        	<p class="btn"> 
	                        	<a href="javascript:void(0);" onmousedown="javascript:fnSelectMenuAjax('<c:out value="${twoDepth.menuSeq}"/>');"  class="iconOnlyBtn btn-basic btn-setting" title="<spring:message code="wzwg.cmm.word.updt" />"></a>
		                    	<c:if test="${not empty twoDepth.menuTyCode }">
		                    		<c:choose>
		                    		<c:when test="${twoDepth.menuTyCode eq 'SC00000033' }">
		                    			<a href="javascript:void(0);" onclick="fnCntntsBassForm('<c:out value="${twoDepth.sysmoduleSeq}"/>');" class="iconOnlyBtnSameSize btn-basic" style=""><spring:message code="wzwg.cmm.word.cntnts" /></a>
		                    		</c:when>
		                    		<c:otherwise>
			                    		<a href="<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/<c:out value="${twoDepth.mngrPageUrl}"/>?cntntsSeq=<c:out value="${twoDepth.cntntsSeq}"/>&sitecntntsSeq=<c:out value="${twoDepth.sitecntntsSeq}"/>" class="iconOnlyBtnSameSize btn-basic" style=""><spring:message code="wzwg.cmm.word.cntnts" /></a>
		                    		</c:otherwise>
		                    		</c:choose> 
		                    	</c:if>
		                    	<c:if test="${empty twoDepth.menuTyCode and not empty twoDepth.linkUrl}">
		   	                 		<a href="<c:out value="${twoDepth.linkUrl}"/>" target="_blank" class="iconOnlyBtnSameSize btn-basic" style=""><spring:message code="wzwg.cmm.word.mvmn" /></a>
		                    	</c:if>
	                    	</p>
                        </div>
                        <c:forEach items="${resultList['MENU_LIST']}" var="threeDepth" varStatus="status">
	            			<c:if test="${twoDepth.menuSeq eq threeDepth.upperMenuSeq}"> 
	            			<c:set var="secondDD" value="${secondDD +1 }"/>
	            			<c:if test="${secondDD eq '1'}"><ol class="dd-list"> </c:if>
		                        <li class="dd-item dd3-item" data-id="<c:out value="${threeDepth.menuOrdr}"/>"  data-menuSeq="<c:out value="${threeDepth.menuSeq}"/>" data-menuLv="<c:out value="${threeDepth.menuLv}"/>" data-menuDivision="<c:out value="${threeDepth.mngrMenuDivision}"/>"  data-sysmoduleSeq="<c:out value="${threeDepth.sysmoduleSeq}"/>">
		                        <div class="dd-handle dd3-handle"></div>
		                        <div class="dd3-content <c:if test="${threeDepth.mngrMenuDivision eq 'group'}">group</c:if> <c:if test="${threeDepth.menuSttusCode eq 'SC00000034'}">hide</c:if>">
		                        	<p class="menu">
			                        	<c:out value="${threeDepth.menuNm}" escapeXml="false" />
			                        	<%-- <c:if test="${threeDepth.menuSttusCode eq 'SC00000034'}">(<spring:message code="wzwg.cmm.word.unexposure" />)</c:if> --%>
			                        	<c:if test="${threeDepth.menuSttusCode eq 'SC00000034'}"><img src="/images/wzwg/site/mngr/menu-hide.png"></c:if>
		                        	</p>
		                        	<p class="btn">
			                        	<a href="javascript:void(0);" onmousedown="javascript:fnSelectMenuAjax('<c:out value="${threeDepth.menuSeq}"/>');"  class="iconOnlyBtn btn-basic btn-setting" title="<spring:message code="wzwg.cmm.word.updt" />"></a>
				                    	<c:if test="${not empty threeDepth.menuTyCode }">
				                    		<c:choose>
				                    		<c:when test="${threeDepth.menuTyCode eq 'SC00000033' }">
				                    			<a href="javascript:void(0);" onclick="fnCntntsBassForm('<c:out value="${threeDepth.sysmoduleSeq}"/>');" class="iconOnlyBtnSameSize btn-basic" style=""><spring:message code="wzwg.cmm.word.cntnts" /></a>
				                    		</c:when>
				                    		<c:otherwise>
					                    		<a href="<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/<c:out value="${threeDepth.mngrPageUrl}"/>?cntntsSeq=<c:out value="${threeDepth.cntntsSeq}"/>&sitecntntsSeq=<c:out value="${threeDepth.sitecntntsSeq}"/>" class="iconOnlyBtnSameSize btn-basic" style=""><spring:message code="wzwg.cmm.word.cntnts" /></a>
				                    		</c:otherwise>
				                    		</c:choose> 
				                    	</c:if>
				                    	<c:if test="${empty threeDepth.menuTyCode and not empty threeDepth.linkUrl}">
				   	                 		<a href="<c:out value="${threeDepth.linkUrl}"/>" target="_blank" class="iconOnlyBtnSameSize btn-basic" style=""><spring:message code="wzwg.cmm.word.mvmn" /></a>
				                    	</c:if>
			                    	</p>
		                        </div>
		                        </li>
		                     </c:if>
	                     </c:forEach> 
	                    <c:if test="${secondDD ge '1'}"><c:set var="secondDD" value="0"/></ol> </c:if>
                        </li>
                         </c:if>
               			</c:forEach>
                    <c:if test="${firstDD ge '1'}"><c:set var="firstDD" value="0"/></ol> </c:if>
                </li>
                </c:if>
                </c:forEach>
            </ol>
