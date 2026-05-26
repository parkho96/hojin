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
		        			 var menulv = $(childEle).parents("li").data("menulv");
		        			 if(menulv ==  undefined){
		        				 menulv =0;
		        			 }
		        			 menulv = menulv+1;
		        			 var upperMenuSeq = $(childEle).parents("li").data("mngrmenuseq") ;
		        			 var menudivision =   $(childEle).parents("li").data("menudivision") ;
		        			 var groupmenu =   $(childEle).data("menudivision") ; 
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
		        			 
		        			 if(groupmenu =='group' && menulv >2){
		        				 alert('<spring:message code="wzwg.cmm.msg.MSG425" />');
		        				 location.reload();
		        				 return;
		        				 
		        			 }
		        			 
		        			 console.log($(childEle).data("mngrmenuseq"));
		        			 
		        			 $.ajax({
								   type:'POST'
								 , url:' <c:out value="${wzwg_contextPath}"/>/sysMngr/siteMngr/menu/modifySiteMngrMenuMngrOrdrAjax.do'
								 , data:{'menuOrdr' :index,'mngrMenuSeq':$(childEle).data("mngrmenuseq"),'upperMenuSeq':upperMenuSeq,'menuLv':menulv} 
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
                <li class="dd-item dd3-item" data-id="<c:out value="${oneDepth.menuOrdr}"/>" data-mngrMenuSeq="<c:out value="${oneDepth.mngrMenuSeq}"/>" data-menuLv="1" data-menuDivision="<c:out value="${oneDepth.mngrMenuDivision}"/>">
                    <div class="dd-handle dd3-handle"></div>
                    <div class='dd3-content <c:if test="${oneDepth.mngrMenuDivision eq 'group'}">group</c:if> ' >
                    	<p class="menu">
	                    	<c:if test="${sessionScope.LANG eq 'SC00000016' }">
								<c:out value="${oneDepth.mngrMenuNm}"/> 
							  </c:if>
							  <c:if test="${sessionScope.LANG ne 'SC00000016' }">
								<c:out value="${oneDepth.mngrMenuNmEng}"/> 
							  </c:if>
                    	</p>
                    	<p class="btn">
                    		<a href="javascript:void(0);" onmousedown="javascript:fnSelectMenuAjax('<c:out value="${oneDepth.mngrMenuSeq}"/>');" class="iconOnlyBtn btn-basic btn-setting fr" style="margin-left:5px !important;" title="<spring:message code="wzwg.cmm.word.updt" />"></a>
                    	</p>
                   	</div>
                     <c:forEach items="${resultList['MENU_LIST']}" var="twoDepth" varStatus="status">
            			<c:if test="${oneDepth.mngrMenuSeq eq twoDepth.upperMenuSeq}"> 
				        
            			<c:set var="firstDD" value="${firstDD +1 }"/>
            			<c:if test="${firstDD eq '1'}"><ol class="dd-list"> </c:if>
                        <li class="dd-item dd3-item" data-id="<c:out value="${twoDepth.menuOrdr}"/>" data-mngrMenuSeq="<c:out value="${twoDepth.mngrMenuSeq}"/>" data-menuLv="2" data-menuDivision="<c:out value="${twoDepth.mngrMenuDivision}"/>" >
                        <div class="dd-handle dd3-handle"></div>
                        <div class="dd3-content <c:if test="${twoDepth.mngrMenuDivision eq 'group'}">group</c:if>">
                        	<p class="menu">
	                        <c:if test="${sessionScope.LANG eq 'SC00000016' }">
								<c:out value="${twoDepth.mngrMenuNm}"/> 
							  </c:if>
							  <c:if test="${sessionScope.LANG ne 'SC00000016' }">
								<c:out value="${twoDepth.mngrMenuNmEng}"/> 
							  </c:if> 
                        	</p>
                        	<p class="btn"> 
	                        	<a href="javascript:void(0);" onmousedown="javascript:fnSelectMenuAjax('<c:out value="${twoDepth.mngrMenuSeq}"/>');"  class="iconOnlyBtn btn-basic btn-setting fr" style="margin-left:5px !important;" title="<spring:message code="wzwg.cmm.word.updt" />"></a>
	                    	</p>
                        </div>
                        <c:forEach items="${resultList['MENU_LIST']}" var="threeDepth" varStatus="status">
	            			<c:if test="${twoDepth.mngrMenuSeq eq threeDepth.upperMenuSeq}"> 
	            			<c:set var="secondDD" value="${secondDD +1 }"/>
	            			<c:if test="${secondDD eq '1'}"><ol class="dd-list"> </c:if>
		                        <li class="dd-item dd3-item" data-id="<c:out value="${threeDepth.menuOrdr}"/>"  data-mngrMenuSeq="<c:out value="${threeDepth.mngrMenuSeq}"/>" data-menuLv="3" data-menuDivision="<c:out value="${threeDepth.mngrMenuDivision}"/>"  >
		                        <div class="dd-handle dd3-handle"></div>
		                        <div class="dd3-content">
		                        	<p class="menu">
			                        <c:if test="${sessionScope.LANG eq 'SC00000016' }">
										<c:out value="${threeDepth.mngrMenuNm}"/>
									  </c:if>
									  <c:if test="${sessionScope.LANG ne 'SC00000016' }">
										<c:out value="${threeDepth.mngrMenuNmEng}"/>
									  </c:if> 
			                        	<%-- <c:if test="${threeDepth.menuSttusCode eq 'SC00000034'}">(<spring:message code="wzwg.cmm.word.unexposure" />)</c:if> --%>
		                        	</p>
		                        	<p class="btn">
			                        	<a href="javascript:void(0);" onmousedown="javascript:fnSelectMenuAjax('<c:out value="${threeDepth.mngrMenuSeq}"/>');"  class="iconOnlyBtn btn-basic btn-setting fr" style="margin-left:5px !important;" title="<spring:message code="wzwg.cmm.word.updt" />"></a>
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
