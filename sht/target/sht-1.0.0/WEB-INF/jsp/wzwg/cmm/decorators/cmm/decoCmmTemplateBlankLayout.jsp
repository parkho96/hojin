<%@page import="egovframework.wzwg.cmm.util.CmmSessionUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<c:set var="siteNm"><%=CmmSessionUtil.getSessionSiteNm(request) %></c:set>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1"> 
	<title><c:out value="${siteNm }"/></title>
	
   	<link rel="stylesheet" href="/css/wzwg/cmm/layout.css" type="text/css" />
 	<link rel="stylesheet" href="/css/wzwg/cmm/empty_line.css" type="text/css" />
 	<link rel="stylesheet" href="/css/wzwg/cmm/font.css" type="text/css" />

 	<!-- <link rel="stylesheet" href="/css/wzwg/cmm/btns.css" type="text/css" /> -->
    <script src="/js/wzwg/cmm/jquery-latest.min.js"></script>
    <script src="/design/module/sample/js/swiper.jquery.min.js"></script> 
    <script src="/js/wzwg/cmm/jquery-ui.js"></script>
    
    <!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-121105155-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-121105155-1');
</script>
    
	<script> 
 var timer =new Array();
 function topMenuSubParsing() { 
     $('a').each(function () {
    	 if($(this).attr("href").indexOf("/subList") >-1){
        $(this).attr('href','<c:out value="${wzwg_contextPath}" />/mngr/<c:out value="${param.templateSeq}" />'+$(this).attr("href")+'?templateSeq=<c:out value="${param.templateSeq}" />');
    	 }
     });
 }
 
 
	function changeImgSlider(chgImgDiv ,imgNumber){  
		   var options = {};
		var imgCnt =1;
		var imgDivId=chgImgDiv; 
		$("#"+chgImgDiv+"   img").css( 'display',"none" );
		imgCnt =  $("#"+chgImgDiv+"  img").size(); 
		options = {direction :"right"};  
 	    $("#"+chgImgDiv+"   img:eq("+(Number(imgNumber)-1)+")").show( 'fade', options, 1000 );  
 	  
		$("#"+chgImgDiv).children("li").each(function(){     
			 $(this).remove();	
		 });  
		for(var i=1;i<=imgCnt;i++){
			if(i == imgNumber){
				$("#"+chgImgDiv).append("<li class='active' onclick='changeImgSliderLink(\""+imgDivId+"\",\""+i+"\")'/>");
			}else{
			   $("#"+chgImgDiv).append("<li onclick='changeImgSliderLink(\""+imgDivId+"\",\""+i+"\")'/>");
			}
	 	}  
		 if($("#"+chgImgDiv).data("auto")=='start'){
			 timer[chgImgDiv]=	setTimeout(function(){changeImgSliderAuto(chgImgDiv ,imgNumber);},2000);
		 }
	} 
	
	function fnDivJsonTabDataRead(callback){
	    $('.tabmenu').children("li").each(function (index, parentEle) {
	        var cntseq = $(this).data('cntseq');
	        
	        $.ajax({
	            type:'POST'
	          , url:'<c:out value="${wzwg_contextPath}" />/module/scrin/scrinCntntsJson.do'
	          , data:{menuSeq:cntseq}
	          , success:function (data) {
	              fnDivJsonDataPrint(data, parentEle,callback);
	              
	          }
	          , dataType: 'json'
	      });
	    }); 
	    
	    $('.tab').children("div").children("div").each(function (index, parentEle) {
	        var cntseq = $(this).data('cntseq');
	        
	        $.ajax({
	            type:'POST'
	          , url:'<c:out value="${wzwg_contextPath}" />/module/scrin/scrinCntntsJson.do'
	          , data:{menuSeq:cntseq}
	          , success:function (data) {
	              fnDivJsonDataPrint(data, parentEle,callback);
	              
	          }
	          , dataType: 'json'
	      });
	    }); 
	    
}

	
	$(document).ready(function(){
		if($("#top  .menu").length >0){ 
			topMenuSubParsing();
		}
		if($(".removeStyleZone").size() >0){
		  $(".removeStyleZone").attr("style","");
		}
	 
		if($(".tab").size() >0){
			$('.tab').children("div").css('display','none');
			$('.tab').children("div").eq(0).css('display','block');
			$('.tabmenu').children("li").children("a").removeClass("on");
			$('.tabmenu').children("li").children("a").eq(0).addClass("on");
			$('.tabmenu').children("li").children("a").each(function(index,child){
					$(child).click(function(){ 
					$('.tab').children("div").css('display','none'); 
					$('.tabmenu').children("li").children("a").removeClass("on");
					$('.tab').children("div").eq(index).css('display','block');
					$('.tabmenu').children("li").children("a").eq(index).addClass("on");
				});
			});
		   fnDivJsonTabDataRead();
		} 
		
		if($(".mainSlider").size() >0){
			
		    var swiper = new Swiper('.mainSlider', {
		    	loop: true, 
				autoplay: 2500,
		        autoplayDisableOnInteraction: true, 
		        pagination: '.swiper-pagination', 
		        nextButton: '.swiper-button-next',
		        prevButton: '.swiper-button-prev', 
		    	paginationClickable: true
		    });
		
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
		
		if($("#loginBox").length >0){
			$("#loginBox").remove();
			<c:if test="${empty sessionScope.loginVO}">
			$('.login_before').css('display','');$('.login_after').css('display','none');
			</c:if>
		   <c:if test="${not empty sessionScope.loginVO}">
		   $('.login_before').css('display','none');$('.login_after').css('display','');
			</c:if>
		}
	 $(".slider").each(function(){
		 changeImgSliderAuto($(this).attr("id") ,0); 
	 });
	 fnDivJsonDataRead();
	 $("#content >  div").each(function(){ 
		 if($(this).data("tab") != undefined && $(this).data("tab")=='Y'){ 
			 $(this).tabs({active: 0}); 
		 }
	 });
	 

	});
	
	function changeImgSliderLink(chgImgDiv ,imgNumber){   
		 clearTimeout(timer[chgImgDiv]);
	    changeImgSlider(chgImgDiv ,imgNumber);
	}
		
	function changeImgSliderAuto(chgImgDiv ,imgNumber){  
		var imgCnt =1;
		imgCnt =  $("#"+chgImgDiv+"  img").size(); 
		 $("#"+chgImgDiv).data("auto","start");
		if(imgCnt ==imgNumber){
			timer[chgImgDiv] = setTimeout(function(){changeImgSlider(chgImgDiv ,1);},2000); 
		}else if(imgNumber ==0){
			timer[chgImgDiv] = setTimeout(function(){changeImgSlider(chgImgDiv ,1);},2000); 
		}else{
			timer[chgImgDiv] = setTimeout(function(){changeImgSlider(chgImgDiv ,Number(imgNumber)+1);},2000); 
		}
	} 
	
	function fnDivJsonDataRead(callback){
	    $('.cntContextSGC0000027').each(function (index, parentEle) {
	        var cntseq = $(this).data('cntseq');
	        $.ajax({
	            type:'POST'
	          , url:'<c:out value="${wzwg_contextPath}" />/module/scrin/scrinCntntsJson.do'
	          , data:{menuSeq:cntseq}
	          , success:function (data) {
	              fnDivJsonDataPrint(data, parentEle,callback);
	              
	          }
	          , dataType: 'json'
	      });
	    }); 
	    
 }
	 

	 function fnDivJsonDataPrint(data, ele,callback) {
		 $(ele).find("#data").children().css("display","");
		 
		// sampleData = $(ele).data("sample"); 
		// $(ele).load(sampleData.fileCours+'/'+sampleData.fileNm,function(){
			    // 컨텐츠 정보 - 컨텐츠 제목 
			    $(ele).find('.menuNm').html(data.cntntsInfo.menuNm);
			    if($(ele).find('.menuDc').size() > 0){
			    	 $(ele).find('.menuDc').html(data.cntntsInfo.menuDc);
			    }
			    if($(ele).find('.menuSeq').size() > 0){
			    	$(ele).find('.menuSeq').attr("href","/subList/"+data.cntntsInfo.menuSeq);  
			    }
			    
			    if(data['cntntsData'].length ==0){ 
			    	$(ele).find('#noData').css("display","");
		        }else{
		        	$(ele).find('#noData').css("display","none");
		        	$(ele).find('#data').css("display","");
		        } 
			 
			    // 컨텐츠 정보 - 목록 제목
			    $(ele).find("#data").children().each(function (index, childEle) {  
			    	 
			        if (data['cntntsData'].length > index) { 
			        	 $(childEle).find("*").each(function(i,cl){
			        		 for(var key in data['cntntsData'][index]){ 
			 	        		if(key ==  $(cl).data("attr")){
			  	    	            $(cl).html(data['cntntsData'][index][key]);   
			 	        		}
			 	        		if(key ==  $(cl).data("href")){
			  	    	            $(cl).attr("href",data['cntntsData'][index][key]);   
			 	        		}
			 	        		
			 	        		if(key ==  $(cl).data("src")){
			  	    	            $(cl).attr("src",data['cntntsData'][index][key]);   
			 	        		}
			 	        	}
			        	 });
			        	
			        }else{
			        	$(childEle).remove();
			        }
				   
			    });
			    if(typeof callback =='function'){
				    callback();
				    }
			 
//		 });
		 
		}
 
	 function topMenuParsing() {
		    var startMenuLv = 1;
		    var stopMenuLv = 2;
		    var nStart = new Date().getTime();      //시작시간 체크(단위 ms)
			var nEnd;
		    var nDiff;
		    $('.menu').each(function (index, parentEle) {
		        $.ajax({
		            type:'POST'
		          , url:'<c:out value="${wzwg_contextPath}" />/module/scrin/scrinMenuJson.do'
		          , contentType : "application/json"
		          , success:function (data) {
		        	  alert(1);
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
		        	 	        			alert(firstMenu[index]["menuDivision"] );
		        	 	        			if(firstMenu[index]["menuDivision"] =='link'){
		        	 	        				$(cl).attr("href","<c:out value="${wzwg_contextPath}" />/subList/"+firstMenu[index]["menuLinkUrl"]);
		        	 	        				$(cl).attr("target","_blank");
		        	 	        			}else{
		        	  	    	           		$(cl).attr("href","<c:out value="${wzwg_contextPath}" />/subList/"+firstMenu[index][key]);
		        	 	        			}
		        	 	        //		     $(cl).attr("href","#");
		        	 	        		}
		        	 	        		
		        	 	        		if(key ==  $(cl).data("src")){
		        	  	    	            $(cl).attr("src",firstMenu[index][key]);   
		        	 	        		}
		        	 	        	}
		        	        	 });
		        	        	 
		        	        	 $(childEle).find(".sub-menu").children().each(function (indexSub, childSubEle) {  
		        	        		 if(subMenu.length > indexSub){
		        	        			 nEnd =  new Date().getTime();      //종료시간 체크(단위 ms)


		        	       		      nDiff = nEnd - nStart;      //두 시간차 계산(단위 ms)
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
		            	 	        			if(subMenu[indexSub]["menuDivision"] =='link'){
			        	 	        				$(cl).attr("href","<c:out value="${wzwg_contextPath}" />/subList/"+subMenu[indexSub]["menuLinkUrl"]);
			        	 	        				$(cl).attr("target","_blank");
			        	 	        			}else{
			        	 	        				 $(cl).attr("href","<c:out value="${wzwg_contextPath}" />/subList/"+subMenu[indexSub][key]); 
			        	 	        			}
		            	  	    	             
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
		                	 	        			if(childMenu[indexChildSub]["menuDivision"] =='link'){
				        	 	        				$(cl).attr("href","<c:out value="${wzwg_contextPath}" />/subList/"+childMenu[indexChildSub]["menuLinkUrl"]);
				        	 	        				$(cl).attr("target","_blank");
				        	 	        			}else{
				        	 	        				 $(cl).attr("src",childMenu[indexChildSub][key]);   
				        	 	        			}
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
  $('.ftrmenu').each(function (index, parentEle) {
      $.ajax({
          type:'POST'
        , url:'<c:out value="${wzwg_contextPath}" />/menu/siteHdftrMenuJsonAjax.do?hdftrCode=SC00000082&lgnAt='+lgnAt
        , contentType : "application/json"
        , success:function (data) {  
        	if($(".footerLogo").size() >0){
        	$(".footerLogo").find("img").attr("src",data.footerLogo);
        	}
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
 }

 function topHdMenuParsing(lgnAt) {

     var startMenuLv = 1;
     var stopMenuLv = 2;
   
     $('.hdmenu').each(function (index, parentEle) {
         $.ajax({
             type:'POST'
           , url:'<c:out value="${wzwg_contextPath}" />/usr/menu/siteHdftrMenuJsonAjax.do?hdftrCode=SC00000081&lgnAt='+lgnAt
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
         	    if($('.hdmenu').find("li").size() >0){
         	   $('.hdmenu').find("li").each(function(){
	      		 if($(this).children("a").size() ==0){
	      				 $(this).remove();
	      			 }
	      		 });
         	    }
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
		       , url:'<c:out value="${wzwg_contextPath}" />/usr/siteMngr/siteInfo/siteFtrMenuJsonAjax.do'
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
		    //topMenuParsing();
	 }
	</script>
  <decorator:head />
  </head>
<body>
<decorator:body /> 
</body>
</html>
