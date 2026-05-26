<%@page import="egovframework.wzwg.cmm.util.CmmSessionUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%> 
<c:set var="siteNm"><%=CmmSessionUtil.getSessionSiteNm(request) %></c:set>
<!doctype html>
<html lang="ko">
<head>
<title><c:out value="${siteNm }"/></title>
	
   	<link rel="stylesheet" href="/css/wzwg/cmm/common.css" type="text/css" />
    <link rel="stylesheet" href="/css/wzwg/site/mngr/style.css" type="text/css" />
    <link rel="stylesheet" href="/css/wzwg/site/mngr/form.css" type="text/css" />
    <link rel="stylesheet" href="/css/wzwg/cmm/layout.css" type="text/css" />
    <link rel="stylesheet" href="/css/wzwg/cmm/empty_line.css" type="text/css" />
    <link rel="stylesheet" href="/css/wzwg/cmm/font.css" type="text/css" />

 	<!-- <link rel="stylesheet" href="/css/wzwg/cmm/btns.css" type="text/css" /> -->
<script type="text/javascript" src="/js/wzwg/cmm/jquery-latest.min.js"></script>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-121105155-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-121105155-1');
</script>

<script>

function topMenuSubParsing() { 
    $('a').each(function () {
   	 if($(this).attr("href").indexOf("/subList") >-1){
       $(this).attr('href','<c:out value="${wzwg_contextPath}" />/mngr/<c:out value="${param.templateSeq}" />'+$(this).attr("href")+'?templateSeq=<c:out value="${param.templateSeq}" />');
   	 }
    });
}

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
        	  	    	           $(cl).attr("href","<c:out value="${wzwg_contextPath}" />/subList/"+firstMenu[index][key]);   
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
            	  	    	            $(cl).attr("href","<c:out value="${wzwg_contextPath}" />/subList/"+subMenu[indexSub][key]);   
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
                	  	    	            $(cl).attr("href","<c:out value="${wzwg_contextPath}" />/subList/"+subMenu[indexSub][key]);   
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
	
function fnAddLeftDiv(sampleData){  
	if($('#left').length >0){
	// $('#left').load(sampleData.fileCours+'/'+sampleData.fileNm); 
	  //  fnDivJsonDataRead();
	   // leftMenuParsing();
	}
}

function leftMenuParsing() { 
	    var startMenuLv = 1;
	    var stopMenuLv = 2;
	    
		var nowMenuNo = '<c:out value="${menuSeq}"/>"'; 
	    $('#left').each(function (index, parentEle) {
	        $.ajax({
	            type:'POST'
	          , url:'<c:out value="${wzwg_contextPath}" />/module/scrin/scrinSubMenuJson.do' 
	          , data:{menuSeq:nowMenuNo}
	          , success:function (data) { 
	        	  var cntntsNm = jsonFilter(data,'menuLv', '1')[0]["menuNm"];  
	        	  $("#left").find(".cntntsNm").html(cntntsNm);
	        	 var firstMenu = jsonFilter(data,'menuLv', '2'); 
	        	    $("#left").find(".data").each(function (pIndex, pChildEle) {  
	        	    	$(this).children().each(function (index, childEle) {  
	        	        if (firstMenu.length > index) { 
	        	        	 var subMenu = jsonFilter(data,'upperMenuSeq', firstMenu[index].menuSeq);

		        	        	if(firstMenu[index].menuSeq == nowMenuNo){ 
		        	        		$(childEle).addClass("on");
		        	        	}else{
		        	        		$(childEle).removeClass("on");
		        	        	}
	        	        	 $(childEle).find("*").each(function(i,cl){
	        	        		 for(var key in firstMenu[index]){ 
	        	 	        		if(key ==  $(cl).data("attr")){
	        	  	    	            $(cl).html(firstMenu[index][key]); 
	        	 	        		}
	        	 	        		if(key ==  $(cl).data("href")){
	        	  	    	            $(cl).attr("href","<c:out value="${wzwg_contextPath}" />/subList/"+firstMenu[index][key]);   
	        	 	        		}
	        	 	        		
	        	 	        		if(key ==  $(cl).data("src")){
	        	  	    	            $(cl).attr("src",firstMenu[index][key]);   
	        	 	        		}
	        	 	        	}
	        	        	 });
	        	        	 
	        	        	 $(childEle).find(".sub-menu").children().each(function (indexSub, childSubEle) {  
	        	        		 if(subMenu.length > indexSub){
	        	        			 if(indexSub ==0){
	        	        				 $(childEle).find("a").attr("href","<c:out value="${wzwg_contextPath}" />/subList/"+subMenu[indexSub]["menuSeq"]);   
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
	        	    /****
	                // li 
	                var liChk = 0;
	                var preLv = 0;
	                for (var i=0; i<data['cntntsData'].length; i++) {
	                    // 1차메뉴
	                    if (data['cntntsData'][i].menuLv == startMenuLv) {
	                        $('.container ul').eq(0).append('<li id="'+data['cntntsData'][i].menuSeq+'"><a href="#">['+data['cntntsData'][i].menuSeq+']'+data['cntntsData'][i].menuNm+'</a></li>');
	                        liChk = 0;   
	                    } else {
	                        // 서브메뉴
	                        if (data['cntntsData'][i].menuLv == stopMenuLv) {
	                            // 1차만 들어감
	                            if (liChk == 0) {
	                                $('.container ul').find('li').last().addClass('sub-menu');
	                                $('.container ul').find('li').last().append('<ul></ul>');   
	                            }
	                            
	                            // 마지막 UL에 메뉴 추가
	                            $('.container ul').find('ul').last().append('<li id="'+data['cntntsData'][i].menuSeq+'"><a href="#">['+data['cntntsData'][i].menuSeq+']'+data['cntntsData'][i].menuNm+'</a></li>');
	                            liChk = 1;
	                        } 
	                    }
	                }
	                ***/
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
	
	 function fnAddTopDiv(sampleData){  
		 $('#menu').load(sampleData.fileCours+'/'+sampleData.fileNm); 
		  //  fnDivJsonDataRead();
		    //topMenuParsing();
	 }
	 
	 $(document).ready(function(){
		 
			if($("#top > #menu").length >0){
				  fnAddTopDiv($("#menu").data("sample"));			 
			} else {
				topMenuSubParsing();
			}
			
			 fnAddLeftDiv($("#left").data("sample"));
			 var topHeight=0;
			 
			 $("#content > div").each(function(){
					if(topHeight< Number($(this).css("top").replace("px",""))+ Number($(this).css("height").replace("px",""))){
						topHeight = Number($(this).css("top").replace("px",""))+ Number($(this).css("height").replace("px",""));
					}
				});
			 
			 if($("#content").css("height")=='100%'){
				 $("#content").css("height",topHeight);
			 }
			    
	 });
</script>
<decorator:head/>
</head>
<body>
<decorator:body/> 
</body>
</html>