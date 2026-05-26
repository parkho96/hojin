<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script src="/jquery/js/jquery.nestable.js"></script>
<link rel="stylesheet" href="/css/wzwg/cmm/jquery.nestable.css" type="text/css" />
         <script>
         $(document).ready(function()
        		 {
		        	 var updateMenu = function(e)
		        	    {
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
								 , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/menuEstbsInfo/modifySiteMenuMngrOrdrAjax.do'
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
         
         function  fnDeleteMenuAjax(menuSeq, menuGubun){ 
             if (menuGubun == 'group') {
                 if (!confirm('<spring:message code="wzwg.cmm.msg.MSG141" />')) return false;

                 $.ajax({
                       method:'post'
                     , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/menuEstbsInfo/deleteSiteMenuLowAjax.do'
                     , data: {'menuSeq':menuSeq}
                     , dataType:'xml'
                     , success:function (data) {  
                         var result = $(data).find('value').text();
                         
                         if(result =='success'){
                             alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
                         }else{
                             alert('<spring:message code="wzwg.cmm.msg.MSG076" />');     
                         }
                         fnListAjax();
                     }
                 });
             }  else {
                 if (!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006">'+
								'<spring:argument><spring:message code="wzwg.cmm.word.menu" /></spring:argument>'+
								'<spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument>'+
							  '</spring:message>')) return false;
                 
                 $.ajax({
                     method:'post'
                   , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/menuEstbsInfo/deleteSiteMenuMngrAjax.do'
                   , type:'html'
                   , data: {'menuSeq':menuSeq}
                   , success:function (data) {  
                       if(data.msg =='success'){
                       alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
                       }else{
                       alert('<spring:message code="wzwg.cmm.msg.MSG140" />');     
                       }
                       fnListAjax();
                   }
               });  
             }
         }
         </script>
          <c:set var="firstDD" value="0"/>
          <c:set var="secondDD" value="0"/>
            <ol class="dd-list">
            <c:forEach items="${resultList['MENU_LIST']}" var="oneDepth" varStatus="status">
            <c:if test="${empty oneDepth.upperMenuSeq or oneDepth.upperMenuSeq eq '0' }"> 
                <li class="dd-item dd3-item" data-id="<c:out value="${oneDepth.menuOrdr}" />" data-menuSeq="<c:out value="${oneDepth.menuSeq}" />" data-menuLv="<c:out value="${oneDepth.menuLv}" />" data-menuDivision="<c:out value="${oneDepth.menuDivision}" />">
                    <div class="dd-handle dd3-handle"></div>
                    <div class='dd3-content <c:if test="${oneDepth.menuDivision eq 'group'}">group</c:if>' ><c:out value="${oneDepth.menuNm}" />
                    <a href="javascript:void(0);" onmousedown="javascript:fnDeleteMenuAjax('<c:out value="${oneDepth.menuSeq}" />', '<c:out value="${oneDepth.menuDivision}" />');"  class="iconOnlyBtn btn-basic btn-delete fr" style="margin-left:5px !important;" title="<spring:message code="wzwg.cmm.word.delete" />"><spring:message code="wzwg.cmm.word.delete" /></a>
                    <a href="javascript:void(0);" onmousedown="javascript:fnSelectMenuAjax('<c:out value="${oneDepth.menuSeq}" />');" class="iconOnlyBtn btn-basic btn-setting fr" title="<spring:message code="wzwg.cmm.word.updt" />"><spring:message code="wzwg.cmm.word.updt" /></a> </div>
                     <c:forEach items="${resultList['MENU_LIST']}" var="twoDepth" varStatus="status">
            			<c:if test="${oneDepth.menuSeq eq twoDepth.upperMenuSeq}"> 
				        
            			<c:set var="firstDD" value="${firstDD +1 }"/>
            			<c:if test="${firstDD eq '1'}"><ol class="dd-list"> </c:if>
                        <li class="dd-item dd3-item" data-id="<c:out value="${twoDepth.menuOrdr}" />" data-menuSeq="<c:out value="${twoDepth.menuSeq}" />" data-menuLv="<c:out value="${twoDepth.menuLv}" />" data-menuDivision="<c:out value="${twoDepth.menuDivision}" />">
                        <div class="dd-handle dd3-handle"></div>
                        <div class="dd3-content <c:if test="${twoDepth.menuDivision eq 'group'}">group</c:if>"><c:out value="${twoDepth.menuNm}" />
                        <a href="javascript:void(0);" onmousedown="javascript:fnDeleteMenuAjax('<c:out value="${twoDepth.menuSeq}" />', '<c:out value="${twoDepth.menuDivision}" />');"  class="iconOnlyBtn btn-basic btn-delete fr" style="margin-left:5px !important;" title="<spring:message code="wzwg.cmm.word.delete" />"><spring:message code="wzwg.cmm.word.delete" /></a>
                        <a href="javascript:void(0);" onmousedown="javascript:fnSelectMenuAjax('<c:out value="${twoDepth.menuSeq}" />');"  class="iconOnlyBtn btn-basic btn-setting fr" title="<spring:message code="wzwg.cmm.word.updt" />"><spring:message code="wzwg.cmm.word.updt" /></a></div>
                        <c:forEach items="${resultList['MENU_LIST']}" var="threeDepth" varStatus="status">
	            			<c:if test="${twoDepth.menuSeq eq threeDepth.upperMenuSeq}"> 
	            			<c:set var="secondDD" value="${secondDD +1 }"/>
	            			<c:if test="${secondDD eq '1'}"><ol class="dd-list"> </c:if>
		                        <li class="dd-item dd3-item" data-id="<c:out value="${threeDepth.menuOrdr}" />"  data-menuSeq="<c:out value="${threeDepth.menuSeq}" />" data-menuLv="<c:out value="${threeDepth.menuLv}" />" data-menuDivision="<c:out value="${threeDepth.menuDivision}" />">
		                        <div class="dd-handle dd3-handle"></div>
		                        <div class="dd3-content <c:if test="${threeDepth.menuDivision eq 'group'}">group</c:if>"><c:out value="${threeDepth.menuNm}" />  
		                        <a href="javascript:void(0);" onmousedown="javascript:fnDeleteMenuAjax('<c:out value="${threeDepth.menuSeq}" />', '<c:out value="${threeDepth.menuDivision}" />');"  class="iconOnlyBtn btn-basic btn-delete fr" style="margin-left:5px !important;" title="<spring:message code="wzwg.cmm.word.delete" />"><spring:message code="wzwg.cmm.word.delete" /></a>
		                        <a href="javascript:void(0);" onmousedown="javascript:fnSelectMenuAjax('<c:out value="${threeDepth.menuSeq}" />');"  class="iconOnlyBtn btn-basic btn-setting fr" title="<spring:message code="wzwg.cmm.word.updt" />"><spring:message code="wzwg.cmm.word.updt" /></a></div></li>
		                     </c:if>
	                     </c:forEach> 
	                    <c:if test="${secondDD ge '1'}"><c:set var="secondDD" value="0"/></ol> </c:if>
                        </li>
                         </c:if>
               			</c:forEach>
                    <c:if test=  "${firstDD ge '1'}"><c:set var="firstDD" value="0"/></ol> </c:if>
                </li>
                </c:if>
                </c:forEach>
            </ol>
