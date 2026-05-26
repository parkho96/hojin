<%@page import="egovframework.wzwg.cmm.util.CmmSessionUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>  
<script type="text/javascript" src="/js/wzwg/cmm/jquery-latest.min.js"></script>
	<title><%=CmmSessionUtil.getSessionSiteNm(request) %></title>
	
   	<link rel="stylesheet" href="/css/wzwg/cmm/layout.css" type="text/css" />
 	<link rel="stylesheet" href="/css/wzwg/cmm/empty_line.css" type="text/css" />
 	<link rel="stylesheet" href="/css/wzwg/cmm/font.css" type="text/css" />

 	<!-- <link rel="stylesheet" href="/css/wzwg/cmm/btns.css" type="text/css" /> -->
<c:import url="/WEB-INF/jsp/site/${sessionScope.SITE_SEQ}/subHead.jsp"></c:import> 
<c:import url="/WEB-INF/jsp/site/${sessionScope.SITE_SEQ}/topMenu.jsp"></c:import>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-121105155-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-121105155-1');
</script>

<script>
$(document).ready(function(){
	 $("#content").css("height",$(document).height());
	 $("#content").css("left", $("#content").css("width")+10+'px');
	if($("#top  .menu").length >0){
		if($(".menu").data("sample") != undefined){
		  fnAddTopDiv($(".menu").data("sample"));
		}else{
			topMenuParsing();
		}
		  
	}
	
	if($("#top  .hdmenu").length >0){ 
		if($(".hdmenu").data("sample") != undefined){
		  fnAddTopDiv($(".hdmenu").data("sample"));
		}else{
			<c:if test="${empty sessionScope.loginVO}">
			topHdMenuParsing('N');
			</c:if>
		   <c:if test="${not empty sessionScope.loginVO}">
			topHdMenuParsing('Y');
			</c:if>
		}
		  
	}
	
	if($("#footer  .ftrmenu").length >0){ 
		if($(".hdmenu").data("sample") != undefined){
		  fnAddTopDiv($(".hdmenu").data("sample"));
		}else{
			<c:if test="${empty sessionScope.loginVO}">
			footerFtrMenuParsing('N');
			</c:if>
		   <c:if test="${not empty sessionScope.loginVO}">
			footerFtrMenuParsing('Y');
			</c:if>
		}
		  
	}
	 
	if($("#footer  .ftrinfo").length >0){ 
		if($(".ftrinfo").data("sample") != undefined){
		  fnAddTopDiv($(".ftrinfo").data("sample"));
		}else{
			footerFtrMenuInfoParsing();
		}
		  
	}
	 fnSetMenu();
});  
 

function topMenuParsing() {

    var startMenuLv = 1;
    var stopMenuLv = 2;
    
    $('.menu').each(function (index, parentEle) {
        $.ajax({
            type:'POST'
          , url:'<c:out value="${wzwg_contextPath}" />/module/scrin/scrinMenuJson.do'
          , contentType : "application/json"
          , success:function (data) {
        	 var firstMenu = jsonFilter(data,'menuLv', '1');
        	 $(".tLogo").find("img").attr("src",data.topLogo);
        	    $(".menu").find(".data").each(function (pIndex, pChildEle) {  
        	    	$(this).children().each(function (index, childEle) {   
        	        if (firstMenu.length > index) { 
        	        	 var subMenu = jsonFilter(data,'upperMenuSeq', firstMenu[index].menuSeq);
        	        	
        	        	 $(childEle).find("*").each(function(i,cl){
        	        		 for(var key in firstMenu[index]){ 
        	 	        		if(key ==  $(cl).data("attr")){
        	  	    	            $(cl).html(firstMenu[index][key]);   
        	 	        		}
        	 	        		if(key ==  $(cl).data("href")){
        	  	    	           $(cl).attr("href","/subList/"+firstMenu[index][key]);   
        	 	        //		     $(cl).attr("href","#");
        	 	        		}
        	 	        		
        	 	        		if(key ==  $(cl).data("src")){
        	  	    	            $(cl).attr("src",firstMenu[index][key]);   
        	 	        		}
        	 	        	}
        	        	 });
        	        	 
        	        	 $(childEle).find(".sub-menu").children().each(function (indexSub, childSubEle) {  
        	        		 if(subMenu.length > indexSub){
        	        			 if(indexSub ==0){
        	        				// $(childEle).find("a").attr("href","/subList/"+subMenu[indexSub]["menuSeq"]);   
        	        				 $(childEle).find("a").attr("href","#");
        	        				 $(childEle).find("a").data("toggle","dropdown");
        	        				 $(childEle).find("a").addClass("dropdown-toggle");
        	        			 }
        	        		 $(childSubEle).find("*").each(function(i,cl){
            	        		 for(var key in subMenu[indexSub]){ 
            	 	        		if(key ==  $(cl).data("attr")){
            	  	    	            $(cl).html(subMenu[indexSub][key]);   
            	 	        		}
            	 	        		if(key ==  $(cl).data("href")){
            	  	    	            $(cl).attr("href","/subList/"+subMenu[indexSub][key]);   
            	 	        			//  $(cl).attr("href","#");
            	 	        		}
            	 	        		
            	 	        		if(key ==  $(cl).data("src")){
            	  	    	            $(cl).attr("src",subMenu[indexSub][key]);   
            	 	        		}
            	 	        	}
            	        	 }); 
        	        		 var childMenu = jsonFilter(data,'upperMenuSeq', subMenu[indexSub].menuSeq);
        	        		 $(childSubEle).find(".child-menu").children().each(function (indexChildSub, childSubLowEle) {   
            	        		 if(childMenu.length > indexChildSub){
            	        			 if(indexChildSub ==0){
            	        				// $(childEle).find("a").attr("href","/subList/"+subMenu[indexSub]["menuSeq"]);   
            	        				 $(childSubEle).find("a").attr("href","#");
            	        				 $(childSubEle).find("a").data("toggle","dropdown");
            	        				 $(childSubEle).find("a").addClass("dropdown-toggle");
            	        			 }
            	        		 $(childSubLowEle).find("*").each(function(i,cl){
                	        		 for(var key in childMenu[indexChildSub]){ 
                	 	        		if(key ==  $(cl).data("attr")){
                	  	    	            $(cl).html(childMenu[indexChildSub][key]);   
                	 	        		}
                	 	        		if(key ==  $(cl).data("href")){
                	  	    	            $(cl).attr("href","/subList/"+subMenu[indexSub][key]);   
                	 	        		//	  $(cl).attr("href","#");
                	 	        		}
                	 	        		
                	 	        		if(key ==  $(cl).data("src")){
                	  	    	            $(cl).attr("src",childMenu[indexChildSub][key]);   
                	 	        		}
                	 	        	}
                	        	 });
            	        		 
            	        		 
            	        		 }else{
            	        			 $(childSubLowEle).remove();
            	        		 }
            	        	 });
        	        		 
        	        		 }else{
        	        			 $(childSubEle).remove();
        	        		 }
        	        	 });
        	        	if(subMenu.length ==0){
        	        		$(childEle).find(".sub-menu").remove();
        	        	}
        	        }else{
        	        	$(childEle).remove();
        	        }
        		   
        	    });
        	    }); 
            }
            , dataType: 'json'
        });
    });
}
function footerFtrMenuParsing(lgnAt) {

 var startMenuLv = 1;
 var stopMenuLv = 2;
 $('.ftrmenu').load("/design/sample/etc/FTRMENU.html",function(){
 $('.ftrmenu').each(function (index, parentEle) {
     $.ajax({
         type:'POST'
       , url:'<c:out value="${wzwg_contextPath}" />/mngr/menu/siteHdftrMenuJsonAjax.do?hdftrCode=SC00000082&lgnAt='+lgnAt
       , contentType : "application/json"
       , success:function (data) { 
     	    $(".ftrmenu").find(".data").each(function (pIndex, pChildEle) {  
     	    	$(this).children().each(function (index, childEle) {  
     	        if (data["hdftrMenuData"].length > index) {  
     	        	 $(childEle).find("*").each(function(i,cl){
    	        		 for(var key in data["hdftrMenuData"][index]){ 
    	 	        		if(key ==  $(cl).data("attr")){
    	  	    	            $(cl).html(data["hdftrMenuData"][index][key]);   
    	 	        		}
    	 	        		if(key ==  $(cl).data("href")){
    	  	    	            $(cl).attr("href",data["hdftrMenuData"][index][key]);   
    	 	        		}
    	 	        		
    	 	        		if(key ==  $(cl).data("src")){
    	  	    	            $(cl).attr("src",data["hdftrMenuData"][index][key]);   
    	 	        		}
    	 	        		if(key ==  $(cl).data("target")){
    	 	        			if(data["hdftrMenuData"][index][key]=='SC00000079'){
    	  	    	            $(cl).attr("target","_blank");
    	 	        			}
    	 	        		}
    	 	        	}
    	        	 });
     	        }else{
     	        	$(childEle).remove();
     	        }
     		   
     	    });
     	    });
         }
         , dataType: 'json'
     });
 });
 });
}

function topHdMenuParsing(lgnAt) {

    var startMenuLv = 1;
    var stopMenuLv = 2;
  
    $('.hdmenu').each(function (index, parentEle) {
        $.ajax({
            type:'POST'
          , url:'<c:out value="${wzwg_contextPath}" />/mngr/menu/siteHdftrMenuJsonAjax.do?hdftrCode=SC00000081&lgnAt='+lgnAt
          , contentType : "application/json"
          , success:function (data) { 
        	    $(".hdmenu").find(".data").each(function (pIndex, pChildEle) {  
        	    	$(this).find("a").each(function (index, childEle) { 
        	        if (data["hdftrMenuData"].length > index) {  
        	        		 for(var key in data["hdftrMenuData"][index]){  
        	 	        		if(key ==  $(childEle).data("attr")){
        	  	    	            $(childEle).html(data["hdftrMenuData"][index][key]); 
        	 	        		}
        	 	        		if(key ==  $(childEle).data("href")){
        	  	    	            $(childEle).attr("href",data["hdftrMenuData"][index][key]);   
        	 	        		}
        	 	        		
        	 	        		if(key ==  $(childEle).data("src")){
        	  	    	            $(childEle).attr("src",data["hdftrMenuData"][index][key]);   
        	 	        		}
        	 	        		
        	 	        		if(key ==  $(childEle).data("target")){
        	 	        			if(data["hdftrMenuData"][index][key]=='SC00000079'){
        	  	    	            $(childEle).attr("target","_blank");
        	 	        			}
        	 	        		}
        	 	        	} 
        	        }else{
        	        	$(childEle).remove();
        	        }
        		   
        	    });
        	    });
        	     
            }
            , dataType: 'json'
        });
    }); 
}

function leftMenuParsing() { 
    var startMenuLv = 1;
    var stopMenuLv = 2;
    
var nowMenuNo = '${menuSeq}'; 
    $('#left').each(function (index, parentEle) {
        $.ajax({
            type:'POST'
          , url:'<c:out value="${wzwg_contextPath}" />/module/scrin/scrinSubMenuJson.do' 
          , data:{menuSeq:nowMenuNo}
          , success:function (data) {  
        	  var cntntsNm = jsonFilter(data,'menuLv', '1')[0]["menuNm"];  
        	  $("#left").find(".menuNm").html(cntntsNm);
        	  
        	  var cntntsDc = jsonFilter(data,'menuLv', '1')[0]["menuDc"];  
        	  $("#left").find(".menuDc").html(cntntsDc);
        	  
        	 var firstMenu = jsonFilter(data,'menuLv', '2'); 
        	    $("#left").find(".data").each(function (pIndex, pChildEle) {  
        	    	$(this).children().each(function (index, childEle) {
        	        if (firstMenu.length > index) {  
        	        	if(firstMenu[index].menuSeq == nowMenuNo){ 
        	        		$(childEle).children("a").addClass("on");
        	        	}else{
        	        		$(childEle).children("a").removeClass("on");
        	        	}
        	        	
        	        	 var subMenu  = jsonFilter(data,'upperMenuSeq', firstMenu[index].menuSeq);
        	        	
        	        	 $(childEle).find("*").each(function(i,cl){ 
        	        		 for(var key in firstMenu[index]){ 
        	 	        		if(key ==  $(cl).data("attr")){
        	  	    	            $(cl).html(firstMenu[index][key]); 
        	 	        		}
        	 	        		if(key ==  $(cl).data("href")){
        	 	        			if(subMenu.length> 0){
        	        	 			}else{
        	        	 				$(cl).attr("href","<c:out value="${wzwg_contextPath}" />/subList/"+firstMenu[index][key]);
        	        	 			}
        	 	        		}
        	 	        		
        	 	        		if(key ==  $(cl).data("src")){
        	  	    	            $(cl).attr("src",firstMenu[index][key]);   
        	 	        		}
        	 	        	}
        	        	 });
        	        	 
        	        	 $(childEle).find(".sub-menu").children().each(function (indexSub, childSubEle) {  
        	        		 if(subMenu.length > indexSub){
        	        			 if(indexSub ==0){
        	        				// $(childEle).find("a").attr("href","/subList/"+subMenu[indexSub]["menuSeq"]);   

        		        	        	if(subMenu[indexSub].menuSeq == nowMenuNo){ 
        		        	        		$(childEle).addClass("on");
        		        	        	}else{
        		        	        		$(childEle).removeClass("on");
        		        	        	}
        	        			 }
        	        		 $(childSubEle).find("*").each(function(i,cl){
            	        		 for(var key in subMenu[indexSub]){ 
            	 	        		if(key ==  $(cl).data("attr")){
            	  	    	            $(cl).html(subMenu[indexSub][key]);   
            	 	        		}
            	 	        		if(key ==  $(cl).data("href")){
            	  	    	            $(cl).attr("href","<c:out value="${wzwg_contextPath}" />/subList/"+subMenu[indexSub][key]);   
            	 	        		}
            	 	        		
            	 	        		if(key ==  $(cl).data("src")){
            	  	    	            $(cl).attr("src",subMenu[indexSub][key]);   
            	 	        		}
            	 	        	}
            	        	 });
        	        		 }else{
        	        			 $(childSubEle).remove();
        	        		 }
        	        	 });
        	        	if(subMenu.length ==0){
        	        		$(childEle).find(".sub-menu").remove();
        	        	}
        	        }else{
        	        	$(childEle).remove();
        	        }
        		   
        	    });
        	    });
        	    
            }
            , dataType: 'json'
        });
    });
}
function jsonFilter(data,key, value){
	 var arrJson = new  Array();
	 var obj = new  Object();
	  for (var i=0; i<data['cntntsData'].length; i++) {
			  if (data['cntntsData'][i][key] == value) {
				  obj =data['cntntsData'][i];
				  arrJson.push(obj);
		  }
	  }
	  return arrJson;
}


function footerFtrMenuInfoParsing() {

	 var startMenuLv = 1;
	 var stopMenuLv = 2;
	 
	 $('.ftrinfo').each(function (index, parentEle) {
	     $.ajax({
	         type:'POST'
	       , url:'<c:out value="${wzwg_contextPath}" />/mngr/siteMngr/siteInfo/siteFtrMenuJsonAjax.do'
	       , contentType : "application/json"
	       , success:function (data) { 
	     	    $(".ftrinfo").find(".data").each(function (pIndex, pChildEle) {  
	     	    	$(this).find("*").each(function (index, childEle) {  
	    	        		 for(var key in data["ftrMenuInfo"]){
	    	        			 
	    	 	        		if(key ==  $(childEle).data("attr")){
	    	  	    	            $(childEle).html(data["ftrMenuInfo"][key]);   
	    	 	        		}  
	    	 	        		if(key ==  $(childEle).data("src")){  
	    	  	    	            $(childEle).attr("src",data["ftrMenuInfo"][key]);   
	    	 	        		} 
	    	 	        	} 
	     	        
	     	    });
	     	    });
	         }
	         , dataType: 'json'
	     });
	 });
	}
 function fnAddTopDiv(sampleData){  
	 $('.menu').load(sampleData.fileCours+'/'+sampleData.fileNm); 
	  //  fnDivJsonDataRead();
	    topMenuParsing();
 }
 
 function fnSetMenu(){  
	$("#menuTitle").html($("#menuNm").val());
	$("#menuLocationPath").html((wz_msg('wzwg.cmm.word.home')+'>'+$("#menuPath").val()).substring(0,(wz_msg('wzwg.cmm.word.home')+'>'+$("#menuPath").val()).length-1));
	$("#menuSubTitle").html($("#menuNm").val());
 } 
</script>
<form name="menuFrm" id="menuFrm" method="post">
<input type="hidden" name="menuSeq" id="menuSeq" value="<c:out value="${menuSeq}" />"/>
<input type="hidden" name="menuNm" id="menuNm" value="<c:out value="${menuNm}" />"/>
<input type="hidden" name="menuPath" id="menuPath" value="<c:out value="${menuPath }" />"/>
</form>
<!-- middle_contents -->

<div class="contents">
			<div class="inner"> 
						 <c:import url="/WEB-INF/jsp/site/<c:out value="${sessionScope.SITE_SEQ}" />/leftMenu.jsp"></c:import>
                     <div class="subCon">
						 <decorator:body />
					 </div>
			</div>
		</div>
	
<c:import url="/WEB-INF/jsp/site/<c:out value="${sessionScope.SITE_SEQ}" />/footerMenu.jsp"></c:import>
 
