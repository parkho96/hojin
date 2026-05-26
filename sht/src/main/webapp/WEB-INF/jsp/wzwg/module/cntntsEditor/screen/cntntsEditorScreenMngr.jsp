<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><spring:message code="wzwg.cmm.word.sitemngr"/> - 서브메인홈 <spring:message code="wzwg.cmm.word.edit"/></title>
<link rel="stylesheet" href="/css/wzwg/cmm/jquery-ui.css">
<script src="/js/wzwg/cmm/jquery-latest.min.js"></script>
<script src="/js/wzwg/cmm/jquery-ui.js"></script>
<script src="/js/wzwg/cmm/tendina.min.js"></script>

<!-- 위즈위그 메시지 로드 -->
  	<script type="text/javascript" language="JavaScript"  src="/js/wzwg/cmm/jquery.i18n.properties-min-1.0.9.js"></script>
  	<script type="text/javascript" language="JavaScript"  src="/js/wzwg/site/wzwgMessage.js"></script>
	<script>
	jQuery(document).ready(function() {
		onloadWzwgMsg("${fn:escapeXml(sessionScope.langCode)}");
	});
	</script>
	
	
<link rel="stylesheet" href="/smartEditorCustom/css/font-awesome.css" type="text/css" />
<link href="/css/wzwg/cmm/jquery.contextMenu.css" rel="stylesheet"
	type="text/css" />
<script src="/js/wzwg/cmm/jquery.contextMenu.js" type="text/javascript"></script>
<script src="/js/wzwg/cmm/jquery.ui.position.min.js"
	type="text/javascript"></script>
<script src="/js/wzwg/site/editFunc.js" type="text/javascript"></script>

<link rel="stylesheet" type="text/css" media="screen" href="/css/wzwg/cmm/0028_farbtastic.css" />
<script type="text/javascript" charset="utf-8" src="/js/wzwg/cmm/0028_farbtastic.js"></script>

<!-- <script src="/design/module/sample/js/swiper.jquery.min.js"></script> -->
<link rel="stylesheet" href="/js/wzwg/cmm/slick/slick.css" type="text/css" />
<script src="/js/wzwg/cmm/slick/slick.js"></script> 

<link rel="stylesheet" href="/css/wzwg/site/mngr/screenMngr.css" type="text/css">

<!-- <script src="/js/wzwg/site/schedule.js"></script>
<script src="/js/wzwg/site/timetable.js"></script>
 -->

<link rel="stylesheet" href="/css/wzwg/site/mngr/form.css" type="text/css">

<!-- 위디자인 -->
<link rel="stylesheet" href="/widesign/widesigncore.css" type="text/css" />
<script type="text/javascript" src="/widesign/widesign.js"></script>

<!-- codeMirror 리소스 -->
  	<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/lib/codemirror.css">
  	<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/material.css">
	<script src="/js/wzwg/cmm/codemirror/lib/codemirror.js"></script>
	<script src="/js/wzwg/cmm/codemirror/mode/xml/xml.js"></script>
	<script src="/js/wzwg/cmm/codemirror/mode/javascript/javascript.js"></script>
	<script src="/js/wzwg/cmm/codemirror/mode/css/css.js"></script>
	<script src="/js/wzwg/cmm/codemirror/mode/vbscript/vbscript.js"></script>
	<script src="/js/wzwg/cmm/codemirror/mode/htmlmixed/htmlmixed.js"></script>
	<script src="/js/wzwg/cmm/codemirror/lib/formatting.js"></script>

	<!-- wizonEditor 용 리소스 -->
	<link rel="stylesheet" href="/wizonEditor/css/template_part.css" type="text/css" />
	<link rel="stylesheet" href="/wizonEditor/css/wizonCntnts.css" type="text/css" />
	<link rel="stylesheet" href="/wizonEditor/css/wizonEditorBase.css" type="text/css" />
	<link rel="stylesheet" href="/css/wzwg/cmm/empty_line.css" type="text/css">
	<script src="/jquery/js/jquery.form.min.js"></script>
  	<script src="/wizonEditor/js/wizonEditorBase.js"></script>
  	<script src="/wizonEditor/js/wizonEditorAction.js"></script>
  	<script src="/wizonEditor/js/wzwgTableEditor.js"></script>
  	<script src="/wizonEditor/js/wfSel.js"></script>
  	<script src="/wizonEditor/js/codeMirrorApp.js"></script>
  	


<c:import url="/WEB-INF/jsp/wzwg/webModule/wzwgContextMenu.jsp"></c:import>

<script type="text/javascript"> 
 var editMode ='Y';
 var divNumber = 0; 
 var minZindex =0;
 var maxZindex =0;
 var par ;
 var editor;
 var txtEditMode='N';
 var selectDiv;
 var codeVal,cntseq;
 var divNumber2='';
 var tab='';
 var sThis='';
 var deleteYn='Y';
 var swiper ="";
 var slider ="";
 var bannerMdMode="";
 var fontPickerColor="";
 var bgPickerColor ="";
 var codeSe="";
 var selectLayer;
 var txtChangeMode;
 
	var oEditors = [];
//중분류 선택시 중분류에 맞는 샘플 목록을 출력함
 function fnMenuMlcListSelect(codeVal2,cntseq2) { 
     $.ajax({
         type:'POST'
       , url:'${fn:escapeXml(wzwg_contextPath)}/module/scrin/module/selectSampleList.do?mode=1'
       , data:{menuMclCode:codeVal2}
       , success:function (data) {
	
           $('#divSampleList').html(data);
           $( "#divSampleList" ).dialog("open");
          // fnCntntsModuleSelect(codeVal);
           codeVal =codeVal2;
           cntseq = cntseq2; 
         }
       , dataType: 'html'
   });
 }
 
 function fnTopMenuMlcListSelect(code,mode) { 
     $.ajax({
         type:'POST'
       , url:'${fn:escapeXml(wzwg_contextPath)}/module/scrin/module/selectSampleList.do?mode='+mode
       , data:{menuMclCode:code}
       , success:function (data) {
	
           $('#divSampleList').html(data);
           $( "#divSampleList" ).dialog("open"); 
         }
       , dataType: 'html'
   });
 }
 
 function fnSamplePrint(smmenuSeq) {
	
	    var sampleData = $('#'+smmenuSeq).data('sample');
	 //   selectDiv.data("sample",sampleData);
	 //   selectDiv.attr("data-sample",JSON.stringify(sampleData));
	    $( "#divSampleList" ).dialog("close"); 
	    alert(sampleData.fileNm);
        fnAddCntDiv(sampleData);
	}
 function fnSamplePrintTop(smmenuSeq) {
	    var sampleData = $('#'+smmenuSeq).data('sample');
	    $(".menu").data("sample",sampleData);
	    $(".menu").attr("data-sample",JSON.stringify(sampleData));
	    $( "#divSampleList" ).dialog("close");
     //fnAddCntDiv(sampleData);
     fnAddTopDiv($(".menu").data("sample"));
	}

 var firstNttMenuSeq = '${fn:escapeXml(firstNttMenuSeq.menuSeq)}';
 function fnDivJsonDataRead(callback){
	    $('.cntContextSGC0000027').each(function (index, parentEle) {
	        var cntseq = $(this).data('cntseq');
	        if(cntseq == ''){
	        	cntseq = firstNttMenuSeq;
	        	 $(this).data('cntseq',cntseq);
	        }
	         
	        $.ajax({
	            type:'POST'
	          , url:'${fn:escapeXml(wzwg_contextPath)}/module/scrin/scrinCntntsJson.do'
	          , data:{menuSeq:cntseq}
	          , success:function (data) {
	        	  //console.log(data);
	        	  if(data.cntntsInfo != null){
	              	fnDivJsonDataPrint(data, parentEle,callback);
	        	  }
	              
	          }
	          , dataType: 'json'
	      });
	    }); 
	    
	    $('.cntContext10000000204').each(function (index, parentEle) { 
	        var cntseq = $(this).data('cntseq');
	        if(cntseq == ''){
	        	cntseq = firstNttMenuSeq;
	        	 $(this).data('cntseq',cntseq);
	        } 
	        
	        $.ajax({
	            type:'POST'
	          , url:'${fn:escapeXml(wzwg_contextPath)}/module/scrin/scrinCntntsJson.do'
	          , data:{menuSeq:cntseq}
	          , success:function (data) {
	        	  fnDivMovJsonDataPrint(data, parentEle,callback);
	              
	          }
	          , dataType: 'json'
	      });
	    });
	    
	    $('.cntContext10000000104').each(function (index, parentEle){
	    	var menuseq = $(this).data('cntseq');
	    	
	    	if(menuseq != ''){
		    	getCalendar($(this), menuseq);
	    	}
	    });
	    
 }
 function fnDivJsonTabDataRead(callback){
	    $('.tabmenu').children("li").each(function (index, parentEle) {
	        var cntseq = $(this).data('cntseq');
	        
	        $.ajax({
	            type:'POST'
	          , url:'${fn:escapeXml(wzwg_contextPath)}/module/scrin/scrinCntntsJson.do'
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
	          , url:'${fn:escapeXml(wzwg_contextPath)}/module/scrin/scrinCntntsJson.do'
	          , data:{menuSeq:cntseq}
	          , success:function (data) {
	              fnDivJsonDataPrint(data, parentEle,callback);
	              
	          }
	          , dataType: 'json'
	      });
	    }); 
	    
}

 
 
 function fnDivJsonDataPrint(data, ele,callback) {
	 
	 sampleData = $(ele).data("sample"); 
	// $(ele).load(sampleData.fileCours+'/'+sampleData.fileNm,function(){
		    // 컨텐츠 정보 - 컨텐츠 제목 
		    $(ele).find('.menuNm').html(data.cntntsInfo.menuNm);
		    $(ele).find('.subMenuNm').html(data.cntntsInfo.menuNm);
		    
		    if($(ele).find('.menuDc').size() > 0){
		    	 $(ele).find('.menuDc').html(data.cntntsInfo.menuDc);
		    }
		    if($(ele).find('.menuSeq').size() > 0){
		    	$(ele).find('.menuSeq').attr("href",siteKey + "/subList/"+data.cntntsInfo.menuSeq);  
		    }
		    
		    if(data['cntntsData'] != undefined  && data['cntntsData'].length ==0){ 
   		    	$(ele).find('.wzwg-slide-data').addClass('no_slideData');
		    	$(ele).find('#noData').css("display","");
	        }else{
    	       	$(ele).find('.wzwg-slide-data').removeClass('no_slideData');
	        	$(ele).find('#noData').css("display","none");
	        	$(ele).find('#data').css("display","");
	        } 
		    
		    var slickObj = $(ele).find('.wzwg-slide-data');
		    if(slickObj.length == 1){
			    try{
					 //console.log(slickObj.slick('getSlick').unslicked);
					 if(slickObj.slick('getSlick').unslicked == false){
						 //if 구문에서 에러가 발생하면 한번도 생성되지 않은상태
						 //false 이면 이미 slick이 실행되어 있기 때문에 destory 후 진행
						 slickObj.slick('unslick');
					 }
				 }catch(e){}
		    	
		    }
		    
		    var toDayDate = new Date();
		    var toDayyear = toDayDate.getFullYear();
		    var toDaymonth = ('0' + (toDayDate.getMonth() + 1)).slice(-2);
		    var toDayday = ('0' + toDayDate.getDate()).slice(-2);
		    var toDayStr = toDayyear+"."+toDaymonth+"."+toDayday;
		    
		    // 컨텐츠 정보 - 목록 제목
		    $(ele).find("#data").children().each(function (index, childEle) {  
		        if (data['cntntsData'] != undefined  && data['cntntsData'].length > index) {
		        	 $(childEle).css("display","");
		        	 $(childEle).find("*").each(function(i,cl){
		        		 for(var key in data['cntntsData'][index]){  
		 	        		if(key ==  $(cl).data("attr")){  
		  	    	            $(cl).html(data['cntntsData'][index][key]); 
		 	        		}

		 	        		if($(cl).attr("data-newNttImg")){
		 	        			if(toDayStr == data['cntntsData'][index]['frstRegistPnttm']){
		 	        				$(cl).css('display','inline');
		 	        			}else {
		 	        				$(cl).css('display','none');
		 	        			}
		 	        		}
		 	        		
		 	        		if(key ==  $(cl).data("href")){
		 	        			$(cl).removeAttr("target"); 
		 	        			var moduleCode = data.cntntsInfo.sysmoduleSeq;
		 	        			//console.log('moduleCode : ' + moduleCode);
		 	        			if(moduleCode == '10000000218'){
		 	        				//링크 게시판일 경우
			  	    	            $(cl).attr("target", "_blank");   
		 	        			}
		 	        			
		 	        			$(cl).attr("href",siteKey + data['cntntsData'][index][key]);   
		 	        			
		 	        		}
		 	        		
		 	        		if(key ==  $(cl).data("src")){
		 	        			var dataSrc = data['cntntsData'][index][key];
		 	        			var imgHide = $(cl).data('hide');
		 	        			
		 	        			if(dataSrc == undefined || dataSrc == 'undefined' || dataSrc == null){ dataSrc = '/images/wzwg/site/mngr/no-img.png';}
		 	        			if(imgHide == undefined || imgHide == 'undefined' || imgHide == null){ imgHide = '';}
		 	        			

		 	        			if(dataSrc == '' && imgHide != ''){
		 	        				$(childEle).find('.' + imgHide).hide();
		 	        			}else{
		 	        				if(imgHide != ''){
			 	        				$(childEle).find('.' + imgHide).show();
		 	        				}
			  	    	            $(cl).attr("src", dataSrc);
			  	    	            
			  	    	            var imageDc = data['cntntsData'][index]['fileDc'];
			  	    	            if(imageDc != undefined){
			  	    	            	$(cl).attr("alt", imageDc);
			  	    	            }
		 	        			}
		 	        		}
		 	        		
		 	        		
		 	        		/* 게시판 요일 관련 추가 2018.12.07 조원권 */
		 	        		if(key ==  $(cl).data("day")){
		  	    	            $(cl).html(data['cntntsData'][index][key]);   
		 	        		}
		 	        		
		 	        		if('registDayEn' ==  $(cl).data("day")){
		 	        			var dno = data['cntntsData'][index]['registDayNo'];
		 	        			switch(dno){
		 	        			case '1' : $(cl).html('SUN'); break;
		 	        			case '2' : $(cl).html('MON'); break;
		 	        			case '3' : $(cl).html('TUE'); break;
		 	        			case '4' : $(cl).html('WED'); break;
		 	        			case '5' : $(cl).html('THU'); break;
		 	        			case '6' : $(cl).html('FRI'); break;
		 	        			case '7' : $(cl).html('SAT'); break;
		 	        			}
		  	    	               
		 	        		}
		 	        		
		 	        		
		 	        	}
		        	 });
		        	
		        }else{
		        	//alert(1);
		        	$(childEle).css("display","none");
		        }
			   
		    });
		    
		 
		    /* if(slickObj.length == 1){
		    	playSlideSlick($(ele).find('.wzwg-slide-info'));
		    } */
		    
		    if($(ele).find('.wzwg-slide-data').length > 0){
		    	$(ele).find('.wzwg-slide-data').children().each(function(){
		    			//console.log($(swiperEle).html());
		    			if($(this).css("display") =='none'){
		    				$(this).remove();
		    			}
		    	});
		    	
		    	if($(ele).find('.wzwg-slide-data').children().length == 0){
		    		$(ele).find('.wzwg-slide-data').append( $(ele).find('.no_data').html());
		    	}else {
		    		var fslideView = parseFloat($(ele).find('.wzwg-slide-info').attr('data-slidesperview'));
		        	var fslideCnt = parseFloat($(ele).find('.wzwg-slide-data').children().length);
		        	if(fslideView){
		        		if(fslideView>fslideCnt){
		        			$(ele).find('.wzwg-slide-data').addClass('over_slideData');
		        		}else {
		        			$(ele).find('.wzwg-slide-data').removeClass('over_slideData');
		        		}
		        	}
		    	}

		    	playSlideSlick($(ele).find('.wzwg-slide-info'));
		    }else {
		    	//console.log(data['cntntsData']);
				// console.log(data['cntntsData'].length);
				if(data && data['cntntsData'] != undefined  && data['cntntsData'].length == 0){
					$(ele).find('.no_data').css('display', 'inline');
				}else{
					$(ele).find('.no_data').css('display', 'none');
				}
		    }
		    
		    if(typeof callback =='function'){
			    callback();
			}
		    
	}// end fnDivJsonDataPrint
 
 function fnDivMovJsonDataRead(callback){
	    $('.cntContext10000000204').each(function (index, parentEle) {
	        var cntseq = $(this).data('cntseq');
	      //  if(cntseq == ''){
	      //  	cntseq = firstNttMenuSeq;
	      //  	 $(this).data('cntseq',cntseq);
	      //    }
	        
	        $.ajax({
	            type:'POST'
	          , url:'${fn:escapeXml(wzwg_contextPath)}/module/scrin/scrinCntntsJson.do'
	          , data:{menuSeq:cntseq}
	          , success:function (data) {
	              fnDivMovJsonDataPrint(data, parentEle,callback);
	              
	          }
	          , dataType: 'json'
	      });
	    }); 
	    
}
 
function fnDivMovJsonDataPrint(data, ele,callback) {
	 
	 sampleData = $(ele).data("sample"); 
	// $(ele).load(sampleData.fileCours+'/'+sampleData.fileNm,function(){
		    // 컨텐츠 정보 - 컨텐츠 제목 
		      if($(ele).find('.menuNm').size() > 0){
		    $(ele).find('.menuNm').html(data.cntntsInfo.menuNm);
		      }
		    if($(ele).find('.menuDc').size() > 0){
		    	 $(ele).find('.menuDc').html(data.cntntsInfo.menuDc);
		    }
		    if($(ele).find('.menuSeq').size() > 0){
		    	$(ele).find('.menuSeq').attr("href",siteKey + "/subList/"+data.cntntsInfo.menuSeq);  
		    }
		    
		    if(data['cntntsData'] != undefined  && data['cntntsData'].length ==0){ 
		    	$(ele).find('#noData').css("display","");
	        }else{
	        	$(ele).find('#noData').css("display","none");
	        	$(ele).find('#data').css("display","");
	        }
		 
		    // 컨텐츠 정보 - 목록 제목
		    $(ele).find("#data").children().each(function (index, childEle) {  
		    	 
		        if (data['cntntsData'] != undefined  &&  data['cntntsData'].length > index) {
		        	 $(childEle).find("*").each(function(i,cl){
		        		 
		        		 for(var key in data['cntntsData'][index]){

		 	        		if(key ==  $(cl).data("attr")){  
		  	    	            $(cl).html(data['cntntsData'][index][key]); 
		 	        		}
		 	        		
		 	        		if(key ==  $(cl).data("href")){
		  	    	            $(cl).attr("href",siteKey + data['cntntsData'][index][key]);   
		 	        		}
		 	        		
		 	        		if(key ==  $(cl).data("src")){
		  	    	            $(cl).attr("src",data['cntntsData'][index][key]);   
		 	        		}
		 	        		
		 	        		if(key ==  $(cl).data("mvponclick")){
		  	    	            $(cl).attr("onclick","playMvp(\""+data['cntntsData'][index][key]+"\")");   
		 	        		}
		 	        		
		 	        		if($(cl).data("mvponclick") == "mvpId"){
		  	    	            $(cl).attr("onclick","playMvp(\""+data['cntntsData'][index]['mvpKey']+"\")");
		 	        		}
		 	        
	 	        			if(key ==  $(cl).data("mvpplay")){
		  	    	            $(cl).attr("src", "https://www.youtube-nocookie.com/embed/" + data['cntntsData'][index][key] + "?showinfo=0&rel=0&controls=1");
		 	        		}
	 	        			
	 	        			if($(cl).data("mvpplay") ==  "mvpId") {
		 	        			$(cl).attr("src", "https://www.youtube-nocookie.com/embed/" + data['cntntsData'][index]['mvpKey'] + "?showinfo=0&rel=0&controls=1");
		 	        		}
		 	        		
		 	        	}
		        	 });
		        	
		        }
			   
		    });
		    
		    if(data && data['cntntsData'] != undefined  && data['cntntsData'].length == 0){
				$(ele).find('.no_data').css('display', '');
			}else{
				$(ele).find('.no_data').css('display', 'none');
			}
		    
		    
		    if(typeof callback =='function'){
			    callback();
			    }
		 
	// });
	 
	}
 
 
 function fnAddTopDiv(sampleData){  
	 $('.menu').load(sampleData.fileCours+'/'+sampleData.fileNm); 
	  //  fnDivJsonDataRead();
	    topMenuParsing();
 }
 
 function fnAddCntDiv(sampleData){    
	 if(divNumber2 ==''){ 
		 if(tab ==''){
			 $("#content").append( "<div id='cntDiv"+divNumber+"'  data-draggable='Y' data-resizable='all' data-divnumber='"+divNumber+"' class='cntContext"+codeVal+"' data-cntseq='"+cntseq+"' style='width:350px;height:200px;position:absolute;top:50%;left:50%'/>\n\r");
			 
			 $("#content").children("div").each(function(){
			   $(this).resizable();
			   $(this).resizable( "option", "disabled", true );
			});  
			    $('#cntDiv'+divNumber).load(sampleData.fileCours+'/'+sampleData.fileNm,function(){ 
			    	 if(codeVal =='SGC0000030'){
						   $('#cntDiv'+divNumber).find("div").each(function(){  
							   if($(this).attr("class")=='login_after'){
								   $(this).css("display","none");
							   }
							});  
					   }
			    });  
			    fnDivJsonDataRead();
				editInit();
		 }else{
			 $('#'+tab).append( "<div id='cntDiv"+divNumber+"'  data-draggable='Y' data-resizable='all' data-divnumber='"+divNumber+"' style='width:100%;height:100%;' class='cntContext"+codeVal+"' data-cntseq='"+cntseq+"'/>\n\r");
			
		    $('#cntDiv'+divNumber).load(sampleData.fileCours+'/'+sampleData.fileNm,function(){    	
				

		    	 fnDivJsonDataRead(function(){  
			    	 setTimeout(function(){
			    		 if($('#'+tab).children("ul").length ==0){ 
			    		 $('#'+tab).prepend("<ul/>");
			    		
			    		 $('#'+tab).children(".cntContextSGC0000027").each(function(){
							 var parDivId = $(this).attr("id");
							$(this).children("ul:first").each(function(){ 
								$('#'+tab).children("ul:first").append("<li><a href='#"+parDivId+"'><h3>"+$(this).text()+"</h3></a></il>\n\r");
								$(this).remove();
							});
						 }); 
			    		 $('#'+tab).tabs();
			    		 tab='';
			    		 }else{
			    			 $('#'+tab).children("ul:first").append("<li><a href='#"+$('#cntDiv'+divNumber).attr('id')+"'><h3>"+$('#cntDiv'+divNumber).children("ul:first").text()+"</h3></a></il>\n\r");

				    		 $('#cntDiv'+divNumber).children("ul:first").remove();
				    		 $('#'+tab).tabs("refresh"); 
				    		 tab='';
			    		 }
			    	 },100);
 
		    	 }) ; 
					
		    });
		   
		 }
	 }else{
		 $('#'+divNumber2).load(sampleData.fileCours+'/'+sampleData.fileNm,function(){
			 $('#'+divNumber2).data("sample", JSON.stringify(sampleData));
			 $('#'+divNumber2).attr("data-sample",JSON.stringify(sampleData));
			  fnDivJsonDataRead();
			  if(tab !=''){ 
					 $('#cntDiv'+divNumber2).children("ul:first").remove();
					 tab='';
				 }
			 divNumber2='';
		 });  
			editInit();
	 }

	  
 }
 
 function txtContextMenu(){
   $.contextMenu({
            selector: '.txtContext', 
            callback: function(key, opt) {
				if(key =='delete')
				{
					$(this).remove();
				}
					if(key =='copy')
				{ 
					$("#content").append( "<div id='txtDiv"+divNumber+"'   data-draggable='Y' data-resizable='all' data-divnumber='"+divNumber+"' class='txtContext' style='width:"+$(this).css('width')+";height:"+$(this).css('height')+"'>"+$(this).html()+"</div>\n\r");
					 $("#content").children("div").each(function(){
					   $(this).resizable();
					   $(this).resizable( "option", "disabled", true );
					}); 
					
					 txtContextMenu();
					editInit();
				}
				if(key == "txtEdit"){     
				  opt.items.txtEditEnd.disabled=false;	
				  opt.items.copy.disabled=true;	
				  opt.items.txtEdit.disabled=true;	
				  editor = new MediumEditor('#'+$(this).attr("id"), {
					delay: 1000,
					targetBlank: true,
					toolbar: {
						buttons: ['bold', 'italic', 'underline','anchor', 'h1', 'h2', 'h3','strikethrough','justifyLeft','justifyCenter','justifyRight','indent','outdent'],
						diffLeft: 25,
						diffTop: 10,
					}  
				
  			}); 

				//  $(this).draggable( "option", "disabled", true ); 
				  txtEditMode ='Y';
				}

				if(key == "txtEditEnd"){     
				  opt.items.txtEditEnd.disabled=true;	
				  opt.items.txtEdit.disabled=false;	
				  opt.items.copy.disabled=false;	
				  editor.destroy();
				 // $(this).draggable( "option", "disabled", false ); 
				  txtEditMode ='Y';
				}
				
				if(key =='background')
				{
					 $( "#pickerDiv" ).dialog("open");
					jQuery.farbtastic('#picker').linkTo('#'+$(this).attr("id"));
				}
					 
				 if(key =='maxZindex'){
						//addImg();
						selectDiv=$(this); 
						maxZindex = maxZindex +1;
						$(this).css("z-index",maxZindex);
				}
				 
				 if(key =='minZindex'){
						//addImg();
						selectDiv=$(this); 
						if(minZindex > 0){
						minZindex = minZindex -1;
						}
						$(this).css("z-index",minZindex);
				}
				 if(key == 'border-color'){
					 $( "#pickerBorderDiv" ).dialog("open");
					 sThis=$(this); 
						var picker=$('#pickerBorder').farbtastic(function(color){   
							sThis.css('border-color',color); 
							sThis.css('border-style',"solid"); 
							sThis.css('border-width',"1px"); 						
							});
						 picker=null;
					 
				 }
				 
				 if(key =='minZindex'){
						//addImg();
						selectDiv=$(this); 
						if(minZindex > 0){
						minZindex = minZindex -1;
						}
						$(this).css("z-index",minZindex);
				}
				 if(key =='size'){
					 selectDiv=$(this); 
					 $("#sTop").val($(this).css("top"));
					 $("#sLeft").val($(this).css("left"));
					 $("#sWidth").val($(this).css("width"));
					 $("#sHeight").val($(this).css("height"));
					 deleteYn='N';
					 $( "#sizeDiv" ).dialog("open");
				 }
            },
            items: {
                "txtEdit": {name: "<spring:message code="wzwg.cmm.word.txt" /> <spring:message code="wzwg.cmm.word.updt" />", icon: "edit"},
                "copy": {name: "<spring:message code="wzwg.cmm.word.relm" /> <spring:message code="wzwg.cmm.word.copy" />", icon: "copy"},
                "size": {name: "<spring:message code="wzwg.cmm.word.size" /> <spring:message code="wzwg.cmm.word.and" /> <spring:message code="wzwg.cmm.word.lc" />", icon: "edit"}, 
                /**
                "zindex":{
	           		 name:"배열", icon : "edit",
	           		 items:{
	       				 "maxZindex": {name: "<spring:message code="wzwg.cmm.msg.MSG307" />", icon: "edit"},
	       				 "minZindex": {name: "<spring:message code="wzwg.cmm.msg.MSG308" />", icon: "edit"}
	       			}
       		   },
       		   **/
				"txtEditEnd": {name: "<spring:message code="wzwg.cmm.word.txt" /> <spring:message code="wzwg.cmm.word.updt" /> <spring:message code="wzwg.cmm.word.compt" />", icon: "edit",disabled:true},
				"delete": {name: "<spring:message code="wzwg.cmm.word.relm" /> <spring:message code="wzwg.cmm.word.delete" />", icon: "trash"},
				"background": {name: "<spring:message code="wzwg.cmm.word.bcrn" /> <spring:message code="wzwg.cmm.word.color" />", icon: "edit"},
		         "border-color": {name: "<spring:message code="wzwg.cmm.word.borr" /> <spring:message code="wzwg.cmm.word.color" />", icon: "edit"},
                "sep1": "---------",
                "quit": {name: "<spring:message code="wzwg.cmm.word.close" />", icon: function(){
                    return 'context-menu-icon context-menu-icon-close';
                }}
            }
            ,zIndex: 10
        });
 }
 function uploadImg(mode){
		$.ajax({
	        type : 'POST'
			, url : '${fn:escapeXml(wzwg_contextPath)}/module/upload/image/imageForm.do?mode='+mode
			, dataType : 'html'
			, success : function (data) {
				//$("#imgDiv").html(data);
				//$("#imgDiv").show();
				wzAjaxModal('popup_s wd50', '<spring:message code="wzwg.cmm.word.image" />', data);
			}
			, error : function (request, status, error) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
		}); 
 }
 
 function addContentsLayout(){
		$.ajax({
			   type:'POST'
			 , url:'${fn:escapeXml(wzwg_contextPath)}/mngr/screen/selectSiteLayoutTempltAjax.do'
			 , data:$("#frmLayout").serialize()
			 , success:function (data) {
				 	$("#divLayerPopup").html(data);
		    	  	$("#divLayerPopup").show();
		    	  	$(".pop-box").toggle();
						 // 부모코드 셋팅 
						// fnGetMenuList();
						 
					//	 document.getElementById("menuNm").focus();
					   }
			 , dataType: 'html'
		});
	}
 
 function addLayout(){
		$.ajax({
			   type:'POST'
			 , url:'${fn:escapeXml(wzwg_contextPath)}/mngr/screen/selectSiteLayoutAjax.do'
			 , data:$("#frmLayout").serialize()
			 , success:function (data) {
				 
				 wzAjaxModal('popup_l', '<spring:message code="wzwg.cmm.word.layout" /> <spring:message code="wzwg.cmm.word.add02" />', data);
				 	//$("#divLayerPopup").html(data);
		    	  	//$("#divLayerPopup").show();
		    	  	//$(".pop-box").toggle();
						 // 부모코드 셋팅 
						// fnGetMenuList();
						 
					//	 document.getElementById("menuNm").focus();
					   }
			 , dataType: 'html'
		});
	}

/* moo0506 레이아웃 컨텐츠 팝업창 열기*/
function addContentsPopup(contentsZone){
	 
	 //console.log(contentsZone);
	 $('.addLayoutContentsZone').removeClass('addLayoutContentsZone');
	 
	 $(contentsZone).parent().addClass('addLayoutContentsZone');
	 
	 //console.log($(contentsZone).parent().attr('data-w'));
	 
	 var form = new FormData();
	 form.append('width', $(contentsZone).parent().attr('data-w'));
	 form.append('height', $(contentsZone).parent().attr('data-h'));
	 
	 //console.log(frm);
	 
	 $.ajax({
		   type:'POST'
		 , url:'${fn:escapeXml(wzwg_contextPath)}/mngr/screen/selectLayoutContentsPopupAjax.do'
		 , cache : false
		 , async : false
		 , processData: false
		 , contentType: false
		 , data : form
		 , success:function (data) {
			 wzAjaxModal('popup_l', '<spring:message code="wzwg.cmm.word.cntnts" /> <spring:message code="wzwg.cmm.word.add02" />', data);
			 	//$("#divLayerPopup").html(data);
	    	  	//$("#divLayerPopup").show();
	    	  	//$(".pop-box").toggle();
					 // 부모코드 셋팅 
					// fnGetMenuList();
					 
				//	 document.getElementById("menuNm").focus();
				   }
		 , dataType: 'html'
	});
}

/* moo0506 레이아웃 영역에 컨텐츠 추가 컨텐츠 에디터 용으로 변경 2022.08.09 */
function addLayoutContents(_html, _css, _cssId, _cssNm){
	 //$('#tmpReciveContents').html('');
	 var workPannel = $('#' + wizonEditors.wizonId).find(wizonEditorApp.workPannel);
	 var workSelected = $('#' + wizonEditors.wizonId).find('.work_selected');
	 var cssZone = $('#cssZone');
	 if(cssZone.length == 0){
		 workPannel.prepend('<div id="cssZone" style="display:none;"></div>');
	 }
		
	 if($('#' + _cssId).length == 0){
		 $('#cssZone').append('<link rel="stylesheet" href="' + _css + '" type="text/css" id="' + _cssId + '"/>' );
	 }
	 
	 //$('.addLayoutContentsZone').find('.add_div').remove();
	 
	 var contents = $('<div/>');
	 contents.load(_html + '?ran=' + Math.random(), function(){
		 //console.log($(this).html());
		 var htmlContents = $(this).html();
		 
		 workSelected.append(htmlContents);
		 
		 workSelected.children().each(function(){
			 if($(this).is('script') == false){
				 var cssId = _cssId.replace('CSS_', '');
				 
				 $(this).addClass('wzwgWidget').attr('data-id', cssId).attr('data-nm', _cssNm);
				 return;//$.each()만 빠져나감
			 }
		 });

		 //wzwgSwiper();
		 var findSwiper = workSelected.find('.wzwg-swiper');
		 //console.log(findSwiper.length);
		 
		 if(findSwiper.length == 1){
			swiperPlay(findSwiper);
		 }
		 
		 var findSwiperBanner = workSelected.find('.wzwg-banner-swiper');
		 //console.log(findSwiper.length);
		 
		 if(findSwiperBanner.length == 1){
			 swiperBannerPlay(findSwiperBanner);
		 }
		 
		 var findSlide = workSelected.find('.wzwg-slide-info');
		 //console.log(findSwiper.length);
		 
		 if(findSlide.length == 1){
			 playSlideSlick(findSlide);
		 }
		 
		 var findBannerSlide = workSelected.find('.wzwg-banner-slide-info');
		 //console.log(findSwiper.length);
		 
		 if(findBannerSlide.length == 1){
			 playBannerSlideSlick(findBannerSlide);
		 }
		 
		 //editInit();
		 
		 alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.word.cntnts" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.add" /></spring:argument></spring:message>');
		 wzModalClose();
	 	 //wzwgCMSelectorInit();
	 	 
		 /* if($(".wzwg-swiper").size() >0){
	 	 	wzwgSwiperCall();
	 	 } */ 
	 });
	 
	
}
 
 function addContentsTxt(){
		$.ajax({
			   type:'POST'
			 , url:'${fn:escapeXml(wzwg_contextPath)}/mngr/screen/siteTxtContentsInfoAjax.do'
			 , data:$("#frmLayout").serialize()
			 , success:function (data) {
				 	$("#divLayerPopup").html(data);
		    	  	$("#divLayerPopup").show();
		    	  	$(".pop-box").toggle();
						 // 부모코드 셋팅 
						// fnGetMenuList();
						 
					//	 document.getElementById("menuNm").focus();
					   }
			 , dataType: 'html'
		});
	}
 /*
 function addQuickBanner(){
		 if($(".quickBannerZone").size() ==0){
			 alert('<spring:message code="wzwg.cmm.msg.MSG178" />');
			 return;
		 }
		
	 $.ajax({
		   type:'POST'
		 , url:'${fn:escapeXml(wzwg_contextPath)}/mngr/screen/selectSiteQuickBannerAjax.do'
		 , data:$("#frmLayout").serialize()
		 , success:function (data) {
			 	$("#divLayerPopup").html(data);
	    	  	$("#divLayerPopup").show();
	    	  	$(".pop-box1").toggle();
					 // 부모코드 셋팅 
					// fnGetMenuList();
					 
				//	 document.getElementById("menuNm").focus();
				   }
		 , dataType: 'html'
	});
	}
 */
 /* moo0506 퀵배너 추가시 퀵배너 html에서 샘플 코드를 복사해서 퀵배너 영역에 바로 추가 */
 function addQuickBanner(qContents){

		var maxitem = $(qContents).attr('data-maxitem');
		var itemLength = $(qContents).find('.quickBannerZone').children().length;
		//console.log(maxitem + '/' + itemLength);
		
		//퀵메뉴131 에서 높이가 중간일때와 높음일때 maxitem 개수를 다르게하기위해 추가 dahee 201125
		var maxUseAt = $(qContents).attr('data-maxUseAt');
		var hMaxItem = $(qContents).attr('data-hMaxItem'); // 높음
		var mMaxItem = $(qContents).attr('data-mMaxItem'); // 중간
		var lMaxItem = $(qContents).attr('data-lMaxItem'); // 낮음
		var wMaxItem = $(qContents).attr('data-wMaxItem');
		var parentH = $(qContents).parent().attr('data-h');
		var parentW = $(qContents).parent().attr('data-w');
		
		//퀵메뉴133 때문에 수정 (여러개의 퀵존이 존재)
		if(!parentH) {
			parentH = $(qContents).parents().closest('.layout_contents_border').attr('data-h');
			parentW = $(qContents).parents().closest('.layout_contents_border').attr('data-w');
		}
		
		if(maxUseAt != '' && maxUseAt == 'Y') {
			if(parentH == 'H') {
				maxitem = hMaxItem;
			}else if(parentH == 'M') {
				if(wMaxItem && parentW == '100') {
					maxitem = wMaxItem;
				}else {
					maxitem = mMaxItem;					
				}
			}else if(parentH == 'L') {
				maxitem = lMaxItem;
			}
		}
		
		maxitem = parseInt(maxitem);
		itemLength = parseInt(itemLength);
		
		if(maxitem <= itemLength){
			alert('<spring:message code="wzwg.cmm.msg.MSG177"><spring:argument>'+maxitem+'</spring:argument></spring:message>');
			return;
		}
		 
		var quickItem = $(qContents).find('.quick_sample').html();
		$(qContents).find('.quickBannerZone').append(quickItem);
		
		$(qContents).find('.quickBannerZone').each(function(){
			$(this).children().attr('data-type' ,'quick');
		});
	}
 
 /* 퀵메뉴 추가 */
 function addQuickMenu(qContents){

		var maxitem = $(qContents).attr('data-maxitem');
		var itemLength = $(qContents).find('.quickBannerZone').children().length;

		//퀵메뉴131 에서 높이가 중간일때와 높음일때 maxitem 개수를 다르게하기위해 추가 dahee 201125
		var maxUseAt = $(qContents).attr('data-maxUseAt');
		var hMaxItem = $(qContents).attr('data-hMaxItem'); // 높음
		var mMaxItem = $(qContents).attr('data-mMaxItem'); // 중간
		var lMaxItem = $(qContents).attr('data-lMaxItem'); // 낮음
		var wMaxItem = $(qContents).attr('data-wMaxItem');
		var parentH = $(qContents).parent().attr('data-h');
		var parentW = $(qContents).parent().attr('data-w');
		
		//퀵메뉴133 때문에 수정 (여러개의 퀵존이 존재)
		if(!parentH) {
			parentH = $(qContents).parents().closest('.layout_contents_border').attr('data-h');
			parentW = $(qContents).parents().closest('.layout_contents_border').attr('data-w');
		}
		
		if(maxUseAt != '' && maxUseAt == 'Y') {
			if(parentH == 'H') {
				maxitem = hMaxItem;
			}else if(parentH == 'M') {
				if(wMaxItem && parentW == '100') {
					maxitem = wMaxItem;
				}else {
					maxitem = mMaxItem;					
				}
			}else if(parentH == 'L') {
				maxitem = lMaxItem;
			}
		}
		
		maxitem = parseInt(maxitem);
		itemLength = parseInt(itemLength);
		
		if(maxitem <= itemLength){
			alert('<spring:message code="wzwg.cmm.msg.MSG177"><spring:argument>'+maxitem+'</spring:argument></spring:message>');
			return;
		}
		 
		var quickItem = $(qContents).find('.quick_sample').html();
		$(qContents).find('.quickBannerZone').append(quickItem);
		
		$(qContents).find('.quickBannerZone').each(function(){
			$(this).children().attr('data-type' ,'quick');
		});
	}
 
 function fnConvertHTML(){
	 contentsSortableDestroy();
	 var html = $("#content").html();
	$(".contents").css('display','none');
	$("#content").append('<textarea  style="width:100%;height:668px;" id="contentArea"></textarea>');
	$("#contentArea").val(html); 
	$("#convertDesign").css("display","");
	$("#convertHtml").css("display","none");
 }
 
 function fnConvertDesign(){ 
		$("#content").html($("#contentArea").val()); 
		$("#convertDesign").css("display","none");
		$("#convertHtml").css("display","");
		 contentsSortable();
	 }
 
 /* moo0506 메뉴스타일 변경 팝업 */
  function fnChangeMenuPopup(){
	 	var templateHeadType = $('#headmenu').attr('data-type');

	 	if(templateHeadType){
		 	$('#headMenuType').val(templateHeadType);
	 	}
	 	
	 	var templateHeadType = $('#footmenu').attr('data-type');

	 	if(templateHeadType){
		 	$('#footMenuType').val(templateHeadType);
	 	}
	 	
	 	var templateSubType = $('#submenu').attr('data-type');

	 	if(templateSubType){
		 	$('#subMenuType').val(templateSubType);
	 	}
	 	
		$.ajax({
			   type:'POST'
			 , url:'${fn:escapeXml(wzwg_contextPath)}/mngr/screen/selectSiteScreenTempltHeadmenuAjax.do'
			 , data:$("#frmLayout").serialize()
			 , success:function (data) {
				 var title = '<spring:message code="wzwg.cmm.word.menu" /> <spring:message code="wzwg.cmm.word.design" /> <spring:message code="wzwg.cmm.word.change" />'
				 wzAjaxModal('popup_l', title, data);
				 	//$("#divLayerPopup").html(data);
		    	  	//$("#divLayerPopup").show();
		    	  	//$(".pop-box").toggle();
						 // 부모코드 셋팅 
						// fnGetMenuList();
						 
					//	 document.getElementById("menuNm").focus();
					   }
			 , dataType: 'html'
		});
	}
 function fnLayerPopupClose() {
	    $("#divLayerPopup").hide();
	    $("#divLayerPopup").empty();
	    $('body').css({overflow:'auto'});
	}
 
 
 function wzwgSwiperCall(){ 
	swiper = new Swiper('.wzwg-swiper', {
		init : false,
		loop: false,   
		pagination: '.swiper-pagination',
		nextButton: '.swiper-button-next',
		prevButton: '.swiper-button-prev', 
		paginationClickable: true
 	}); 
 }
 
 $(document).ready(function(){
	 
	 	$("#convertDesign").css("display","none");
		$(".hide").click(function(){
			$(".pop-box").hide();
		});
	
		
	});
 $(function() {
	 if($("#top  .menu").length >0){ 
	 topMenuSubParsing();
	 }
	 fnDivJsonTabDataRead();
	 fnDivJsonDataRead();
	 txtContextMenu();
	 $(".axebox").click(function(){ 
		 if( $(this).parents(".removeAxeboxZone").size() >0){
			 $(this).parents(".removeAxeboxZone").remove();
		 }else{
			 //$(this).next("div").remove();
			 //$(this).remove();
		 }
	 });
	 
	 $(".axeboxboot").click(function(){
		 $(this).next("div").remove();
		 $(this).remove();
	 });
	 
	
	 $(".axebox").html("X");
	 $(".axeboxboot").html("X");
			$("#content > div").each(function(){	  
				var zindex=0;
			 if(divNumber <$(this).data("divnumber")){
				 divNumber = $(this).data("divnumber");
			 } 
			 if($(this).css("z-index") !='auto'){
				 zindex=$(this).css("z-index") ;
			 }
			 if(zindex < minZindex){
				 minZindex =zindex;
			 }
			 if(zindex > maxZindex){
				 maxZindex = zindex;
			 }
			 
			 if($(this).data("tab") =='Y'){
				 $(this).tabs();
				 $(this).tabs("load", 0 );
				 $(this).tabs( "enable", 0 );				 
				 $(this).tabs("refresh");
			 }
			
			});  
			divNumber =divNumber+1; 
			 
			
			if($(".tab").size() >0){
				$('.tab').children("div").eq(0).css('display','block');
				$('.tabmenu').children("li").children("a").each(function(index,child){
						$(child).click(function(){ 
							$('.tab').children("div").css('display','none');
							$('.tabmenu').children("li").removeClass("currentBtn");
							$('.tab').children("div").removeClass("currentDiv");
							$('.tabmenu').children("li").children("a").removeClass("on");
							$('.tabmenu').children("li").eq(index).addClass("currentBtn");
							$('.tab').children("div").eq(index).css('display','block');
							$('.tab').children("div").eq(index).addClass("currentDiv");
							$('.tabmenu').children("li").children("a").eq(index).addClass("on");
					});
				});
				} 
			
			if($("#top  .hdmenu").length >0){ 
				if($(".hdmenu").data("sample") != undefined){
				  fnAddTopDiv($(".hdmenu").data("sample"));
				}else{
					topHdMenuParsing('N');
				}
				  
			}
			
			if($("#footer  .ftrmenu").length >0){ 
				if($(".ftrmenu").data("sample") != undefined){
				  fnAddTopDiv($(".ftrmenu").data("sample"));
				}else{
					footerFtrMenuParsing('N');
				}
				  
			}
			if($("#footer  .ftrinfo").length >0){ 
				if($(".ftrinfo").data("sample") != undefined){
				  fnAddTopDiv($(".ftrinfo").data("sample"));
				}else{
					footerFtrMenuInfoParsing();
				}
				  
			}

			
			 
			 $.contextMenu({
			     selector: '.cntContextSGC0000056', 
			     callback: function(key, opt) {
						if(key =='maxZindex'){
								//addImg();
								selectDiv=$(this); 
								maxZindex = maxZindex +1;
								$(this).css("z-index",maxZindex);
						}else if(key =='minZindex'){
								//addImg();
								selectDiv=$(this); 
								if(minZindex > 0){
								minZindex = minZindex -1;
								}
								$(this).css("z-index",minZindex);
						}else{  
							$(this).data("cntseq",key);
							$(this).attr("data-cntseq",key); 
							sThis = $(this); 
							 fnDivMovJsonDataRead();
						}
						
						if(key =='addBgColor')
						{
							$( "#pickerBgDiv" ).dialog("open");
							 selectDiv=$(this); 
						//	addSilder($(this))
						}	
			     },
			     items: {
			     	//"skinReplace": {name: "스킨변경", icon: "edit"}, 
			     	"dataReplace": {
			     					name: "<spring:message code="wzwg.cmm.cntnts.mvpbbs" /> <spring:message code="wzwg.cmm.word.change" />", icon: "link",
			     					items:{
			     						<c:if test="${fn:length(moduleSGC0000027)>0}"> 
                								<c:forEach  items="${moduleSGC0000056}" var="subList" varStatus="statusSub">
                								"${fn:escapeXml(subList.menuSeq)}":{name:"${fn:escapeXml(subList.menuNm)}",icon:"edit"}<c:if test="${!statusSub.last}">,</c:if>
                								</c:forEach>
			     			       		</c:if>
			     					}
			     					},
			     				/**	 
						"zindex":{
			        		 name:"배열", icon : "edit",
			        		 items:{
			    				 "maxZindex": {name: "<spring:message code="wzwg.cmm.msg.MSG307" />", icon: "edit"},
			    				 "minZindex": {name: "<spring:message code="wzwg.cmm.msg.MSG308" />", icon: "edit"}
			    			}
			 		   }, 
			 		   **/
			 		 "addBgColor": {name: "<spring:message code="wzwg.cmm.word.bcrnclr" /> <spring:message code="wzwg.cmm.word.change" />", icon: "edit"},
			         "sep1": "---------",
			         "quit": {name: "<spring:message code="wzwg.cmm.word.close" />", icon: function(){
			             return 'context-menu-icon context-menu-icon-close';
			         }}
			     }
			     ,zIndex: 10
			 });
	
		$('#linkMenuList2').tendina({
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
		 }); //링크연결 리스트
	 
	 document.onkeydown = backSpaceKey;
	 editInit(); //화면구성에 필요한 객체 추가 
	 wzwgSwiperAll(); //공용 스와이퍼 스크립트 자동
	 writeContentTxt(); // 직접입력 객체 활성화
	 editDialog(); // 다이얼로그 준비
	 //subPageCMBuilder(); // 컨텍스트 메뉴 준비(서브페이지전용)
	
	 swiperBannerAll(); // 배너 스와이퍼 스크립트

	 fnGridBtnText();
 
 
	/* 조원권 */
	setTimeout(addMenuGroupClass, 0); 
	fnHederScroll();
	//addMenuGroupClass(); 
	
	/* 레이아웃 스크롤 이펙트 추가 */
	wzRestartScollEffect();
	$(window).scroll(function () {
		if($(window).scrollTop() == 0){
			// 관리자 화면에서는 스크롤 최상단 일때 이펙트 초기화(확인용)
			wzRestartScollEffect();
		}
	});
	/* 제목 클릭 제거 */
	
	
	$('.head-group a, .footer a').off();
	$('.head-group a, .footer a').click(function(e){
	   e.preventDefault(); 
	   var href = $(this).attr('href');
	   if(href){
		   if(href.indexOf('javascript') > -1 || href == '' || href == '#' ){
			   href = '연결된 링크가 없습니다.';
		   }else{
			   var alertMsg = '편집화면에서는 컨텐츠 페이지로 이동할 수 없습니다. \r\r이동경로 : ' + href;
			   var title = $(this).attr('title');
			   if(title && title.length > 0){
				   alertMsg += '\r\n링크명 : ' + title;
			   }
			   alert(alertMsg);
		   }
		   
	   }
	 });
	
 });/*end function()*/

 
 var scrolPos = 0;
 var footerTop;// = $('#footer').offset().top;
 function fnHederScroll(){
	 
	 footerTop = $('#footer').height();
 	$(document).scroll(function(){
 			var headerPoint =  ($('.adm_popupzone').isDisplayNone() == true ? 0 : $('.adm_popupzone').outerHeight()); //팝업높이
 		//console.log($(this).scrollTop());
 		//console.log($('body').scrollTop());
 			var movScrolpx = $(this).scrollTop();
 			
 			if(movScrolpx < headerPoint || movScrolpx == 0){
 				$('.head-group').removeClass('fixedhead');
 				$('.head-group').css('top', '');
 			/*
 			}else if($(document).height() - $(window).height() == movScrolpx){
 				//스크롤이 마지막까지 내려오면 헤더를 열어준다
 			*/
 			}else if(movScrolpx > scrolPos){
 				//console.log('스크롤 내려감');
 				$('.head-group').addClass('fixedhead');
 				var headFixed = $('.fixedhead').css('position');
 				if(headFixed == 'fixed'){
 					$('.head-group').css('top', $('#dgnCtlPannel').outerHeight(true) + 'px');
 				}
 			}else{
 				//console.log('스크롤 올라감');
 			}
 			
 			/* 왼쪽메뉴 유형 fixed 일때 푸터 겹치지 않도록 조절 2019-04-26 조원권*/
			
			if( $('#headmenu').attr('data-type') == 'left' && $('.head-group').css('position') == 'fixed' ){
				var headBottom = $('.head-group').offset().top + $('.head-group').height();
				
				var scrollY =$(document).height() - $(document).scrollTop() - $(window).height();
				
				//if(headBottom > footerTop){
				//console.log(scrollY +'/'+ footerTop);
				if(scrollY < footerTop){
					var headTopPos = $('#footer').outerHeight() + $('.head-group').outerHeight() - $(window).height();
					
					headTopPos = scrollY - headTopPos;
					$('.head-group').css('top', headTopPos + 'px');
					//console.log('넘침');
				}else{
					$('.head-group').css('top', '');
					//console.log('안넘침');
					//console.log(headBottom + '/' + footerTop);
				}
				
			}else{
				//console.log('안넘침');
			}
 			
 			scrolPos = movScrolpx; 
 	  });
 }
 
 
function addMenuGroupClass(){
	$('.lnb').find('ul').each(function(){
		$(this).parent().addClass('mnGroup');
	});
	
	$('#m_nav').find('ul').each(function(){
		$(this).parent().addClass('mnGroup');
	});
}
 /* moo0506 쇼핑몰 데이터 매핑 */
 function moduleShopDataMapping(shopEl){
	 var shopinfoSeq = $(shopEl).attr('data-shopinfo-seq');
	 var menuSeq =	$(shopEl).attr('data-menu-seq');
	 var formData = {
			 
			 pageUnit : $(shopEl).attr('data-row-count')
		,	shopinfoSeq : $(shopEl).attr('data-shopinfo-seq')
	 }
	 $.ajax({
         type:'POST'
       , url:'${fn:escapeXml(wzwg_contextPath)}/module/shop/selectShopProducListJsonAjax.do'
       , data:formData
       , success:function (data) {
           //console.log(data);
           $(shopEl).find('[data-link]').attr('href' , siteKey + '/subList/'+ menuSeq);
           var itemList = data.productList;
           
           $(shopEl).find('#data').children().each(function(idx, el){
        	   //console.log(itemList[idx]);
        	   //console.log(el); 
        	   var item = itemList[idx];
        	   if(item){
        		   $(this).find('[data-thumb]').attr('src','${fn:escapeXml(wzwg_contextPath)}/module/upload/file/selectImageView.do?atchFileId='+item.productImg1);
        		   $(this).find('[data-nm]').html(item.productNm);
        		   $(this).find('[data-price]').html(setComma(item.productPrice));
        		   $(this).find('[data-price-won]').html(setComma(item.productPrice) + '<spring:message code="wzwg.cmm.word.won" />');
        		   $(this).find('[data-dc]').html(item.productDc);
        		   $(this).find('[data-detail-link]').attr('href', siteKey + '/subList/'+ menuSeq + '?pmode=detail&seq=' + item.productSeq);
        			
        		   //console.log(item.productBadge);
        		    
        		   if(item.productBadge){
        			   var badgename = $(shopEl).attr('data-badge-name-' + item.productBadge);
	        		   $(this).find('[data-badge]').html('<span class="' + item.productBadge + '">' + badgename + '</span>');
        			   $(this).find('[data-badge]').css('display', '');
        		   }else{
        			   $(this).find('[data-badge]').css('display', 'none');
        		   }
        		   $(this).css('display', '');
        	   }else{
        		   $(this).css('display', 'none');
        	   }
           });
           
       }
       , dataType: 'json'
   });
 }
 /* moo0506 숫자 세자릿수 콤마찍기 */
 function setComma (number) {
	    // 정규표현식 : (+- 존재하거나 존재 안함, 숫자가 1개 이상), (숫자가 3개씩 반복)
	    var reg = /(^[+-]?\d+)(\d{3})/;

	    // 스트링변환
	    number += '';
	    while (reg.test(number)) {
	        // replace 정규표현식으로 3자리씩 콤마 처리
	        number = number.replace(reg,'$1'+','+'$2');
	    }

	    return number;
	}
 
 /* moo0506 단순 텍스트 변경 활성화 */
 function writeContentTxt(){
	 removeContentTxt();
 	 $('.edtFormTxt').css('border', 'dashed 1px #3899ec');
 	 $('.edtFormTxt').css('cursor', 'auto');
 	 $('.edtFormTxt').attr('contenteditable', 'true');
 }

 /* moo0506 단순 텍스트 변경 비활성화*/
 function removeContentTxt(){
 	$('.edtFormTxt').removeAttr('contenteditable');
 	$('.edtFormTxt').css('border', '');
 	$('.edtFormTxt').css('cursor', '');
 }

 /* moo0506 단순 텍스트 변경 활성/비활성 토글 */
 function txtEdit(idName){  
 	if($('#'+idName.id).parent().attr("contenteditable") =="true"){
 	$('#'+idName.id).parent().attr("contenteditable","false");
 	}else{ 
 	$('#'+idName.id).parent().attr("contenteditable","true");
 	}
 }
 
 /* moo0506 그리드토글 noneborder CSS 파일 삽입/제거 */
 function fnGridToggle(){
	 if($('#styleGridNone').length == 0){
		 var gridCss = '<link id="styleGridNone" href="/css/wzwg/site/mngr/screenMngrNoneBorder.css" rel="stylesheet"	type="text/css" />'
		 $('head').append(gridCss);
	 }else{
		 $('#styleGridNone').remove();
	 }
	 
	 fnGridBtnText();
 }
 
 function fnGridBtnText(){
	if($('#styleGridNone').length == 0){
		$('#GridToggleBtn').html('<spring:message code="wzwg.cmm.word.guidance" /><spring:message code="wzwg.cmm.word.line03" /> <spring:message code="wzwg.cmm.word.hide" />');
	}else{
		$('#GridToggleBtn').html('<spring:message code="wzwg.cmm.word.guidance" /><spring:message code="wzwg.cmm.word.line03" /> <spring:message code="wzwg.cmm.word.ex" />');
	}
 }
 
function getSource(){ 
$("#content").children("div").each(function(){ 
	  $(this).removeClass("selected");   
	  $(this).resizable( "option", "disabled", true );
	  $(this).draggable( "option", "disabled", true );
	  $(this).css("position","relative");
	  editMode ='N';
}); 
}

function setEdit(){ 
 $("#content").children("div").each(function(){
	   $(this).resizable();
	   $(this).resizable( "option", "disabled", true );
	     $(this).draggable( "option", "disabled", false );
	     editMode ='Y';
	}); 

}

function topMenuSubParsing() { 
    $('#top a').each(function () {
	   	 if($(this).attr("href").indexOf("/subList") >-1){
	       var hrefStr = $(this).attr("href").replace('${fn:escapeXml(wzwg_contextPath)}','');
	       $(this).attr('href','${fn:escapeXml(wzwg_contextPath)}/mngr/screen'+hrefStr+'?templateSeq=${fn:escapeXml(siteTemplateScreenVO.templateSeq)}');
	       $(this).attr('target', '_blank');
	   	 }else if($(this).attr("data-type") == 'anchor'){
	   		 //앵커 링크
	   		 var id = $(this).attr('data-mnseq');
	   		 //$(this).removeAttr('target');
	   	   	 $(this).attr("onclick", "$('html, body').animate({scrollTop: $('.anc_" + id + "').offset().top});") ;
	   	   	 //$(this).attr("href", "#.anc_" + id) ;
	   	   	 $(this).attr("href", "javascript:void(0)") ;
	   	 }else{
	   		$(this).attr("href", "javascript:void(0);") ;
	   	 	$(this).attr("target", "") .attr('title', '');
	   	 	$(this).click(function(e){
	   	 		alert('편집화면에서는 링크이동이 불가능합니다.');
	   	 	});
	   	 }
    });
    if($('#top .logo a').attr("href") == '/'){
    	$('#top .logo a').attr("href", "javascript:void(0);");
    }
}


function getSave(){ 
	if(confirm('<spring:message code="wzwg.cmm.msg.MSG256" />')){
		fnConvertDesign();
		saveDataReady();
		
		document.frmSave.action="${fn:escapeXml(wzwg_contextPath)}/mngr/screen/siteScreenTempSave.do";
		document.frmSave.target= "_self";
		document.frmSave.submit();
	}
}

function saveDataReady(){
	console.log("saveDataReady");
	
	/* 레이아웃 이펙트 제거 */
	wzStopScrollEffec();
	$('#layout_wrap').each(function(){
		$(this).removeClass('animate-fade');
		$(this).removeClass('animate-slideUp');
		$(this).removeClass('animate-slideNfade');
	});
	
	$('#cntntsCn').val($('#cntntsCnEditor').wizonEditor('getHtml'));
	﻿
}

function goTemplatePriview(){
	document.frmSave.action="${fn:escapeXml(wzwg_contextPath)}/mngr/${fn:escapeXml(siteTemplateScreenVO.templateSeq)}/template/index.do";
	document.frmSave.target="_blank";
	document.frmSave.submit();
	
}


function footerFtrMenuParsing(lgnAt) {

	  var startMenuLv = 1;
	  var stopMenuLv = 2;
	  $('.ftrmenu').each(function (index, parentEle) {
	      $.ajax({
	          type:'POST'
	        , url:'${fn:escapeXml(wzwg_contextPath)}/menu/siteHdftrMenuJsonAjax.do?hdftrCode=SC00000082&lgnAt='+lgnAt
	        , contentType : "application/json"
	        , success:function (data) {  
	        	if($(".footerLogo").size() >0){
	            	$(".footerLogo").find("img").attr("src",data.footerLogo);
	            	}
	          	    $(".ftrmenu").find(".data").each(function (pIndex, pChildEle) {  
	          	    	$(this).children().each(function (index, childEle) {  
	          	        if (data["hdftrMenuData"].length > index) {  
	          	        	 $(childEle).find("*").each(function(i,cl){
	                             if(data["hdftrMenuData"][index]['menuTySe'] == 'G'){
	                            	 $(this).parent().addClass('link-group');
	                            	 var linkList = '<select id="'+data['hdftrMenuData'][index]['hdftrmenuSeq']+'" title="' + data['hdftrMenuData'][index]['hdftrmenuNm'] +' '+ wz_msg('wzwg.cmm.word.se')+'" ></select>';
	                                 $(childEle).html(linkList);
	                                 $('#'+data['hdftrMenuData'][index]['hdftrmenuSeq']).find('option').remove();
	                                 $('#'+data['hdftrMenuData'][index]['hdftrmenuSeq']).html('<option>::'+data['hdftrMenuData'][index]['hdftrmenuNm']+'::</option>');
	                                 fnLinkUrlList(data['hdftrMenuData'][index]['hdftrmenuSeq'],data['hdftrMenuData'][index]['linkGrpSeq']);
	                             } else {
	             	        		 for(var key in data["hdftrMenuData"][index]){
	                                    if(key ==  $(cl).data("attr")){
	                                        $(cl).html(data["hdftrMenuData"][index][key]);
	                                    }
	                                    if(key ==  $(cl).data("href")){
	                                        $(cl).attr("href",siteKey + data["hdftrMenuData"][index][key]);   
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
	                             }
	         	        	 });
	          	        }else{
	          	        	$(childEle).remove();
	          	        }
	          		   
	          	    });
	          	    });
	          	    
		          	//푸터메뉴 파싱이후 푸터 CSS상황에 따라 셀렉트박스 조절함
						if($('#footmenu').attr('href').indexOf('select') > -1){
							//console.log('왜 안되는것인가');
							//셀렉트 그룹이 밖으로 빠지는 푸터 메뉴이기 때문에 html 소스를 재조립함
							var addSelFoot = '';
								addSelFoot += '<div class="selGroup" id="footSelGrp">';
						    	addSelFoot += '	<ul class="data">';
						    	addSelFoot += '	</ul">';
						    	addSelFoot += '</div>';
						    // 신규 셀렉트 박스가 들어갈영역 만듬
						    
						    $('.ftrmenu').before(addSelFoot);
						    // 신규 셀렉트 박스 영역 추가
						    
						    $('.ftrmenu').find('.link-group').each(function(){
						    	$('#footSelGrp ul').append($(this));
						    });
						    // 영역에 셀렉트 박스 옮김
						}
	          	
	          	
	          	
	              }
	          , dataType: 'json'
	      });
	  });
	 }


function topHdMenuParsing(lgnAt) {

    var startMenuLv = 1;
    var stopMenuLv = 2;
  
    var multiMenuIndex = 0;
    $('.hdmenu').each(function (index, parentEle) {
        $.ajax({
            type:'POST'
          , url:'${fn:escapeXml(wzwg_contextPath)}/mngr/menu/siteHdftrMenuJsonAjax.do?hdftrCode=SC00000081&lgnAt='+lgnAt
          , contentType : "application/json"
          , success:function (data) { 
       	    $(".hdmenu").find(".data").each(function (pIndex, pChildEle) {  
     	    	$(this).find("a").each(function (index, childEle) { 
     	    		
     	    	multiMenuIndex++;
     	    		
     	        if (data["hdftrMenuData"].length > index) {  
                    if(data["hdftrMenuData"][index]['menuTySe'] == 'G'){
                    	$(this).parent().addClass('link-group');
                    	var linkList = '<select id="'+data['hdftrMenuData'][index]['hdftrmenuSeq']+ multiMenuIndex +'" title="' + data['hdftrMenuData'][index]['hdftrmenuNm'] +' '+ wz_msg('wzwg.cmm.word.se')+'" ></select>';
                        $(childEle).html(linkList);
                        $('#'+data['hdftrMenuData'][index]['hdftrmenuSeq']+ multiMenuIndex).find('option').remove();
                        $('#'+data['hdftrMenuData'][index]['hdftrmenuSeq']+ multiMenuIndex).html('<option>::'+data['hdftrMenuData'][index]['hdftrmenuNm']+'::</option>');
                        fnLinkUrlList(data['hdftrMenuData'][index]['hdftrmenuSeq'] + multiMenuIndex,data['hdftrMenuData'][index]['linkGrpSeq']);
                    } else {
     	        		 for(var key in data["hdftrMenuData"][index]){  
     	 	        		if(key ==  $(childEle).data("attr")){
     	  	    	            $(childEle).html(data["hdftrMenuData"][index][key]); 
     	 	        		}
     	 	        		if(key ==  $(childEle).data("href")){
     	  	    	            $(childEle).attr("href",siteKey + data["hdftrMenuData"][index][key]);   
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
                    }
                    $('.hdmenu .gnb').show();
     	        }else{
     	        	$(childEle).remove();
     	        }
     		   
     	    });
     	    });
       		
       	    /* moo0506 2018.01.30 상단메뉴 불필요 메뉴 삭제 추가 (기존버그 수정 스크립트) */
	      	  $(".hdmenu").find(".data").children().each(function (pIndex, pChildEle) {
	      		  if($(this).html() == ''){
	      			  $(this).remove();
	      		  }
	      	  });
         }
            , dataType: 'json'
        });
    }); 
}

function fnLinkUrlList(selId, linkGrpSeq){
    $.ajax({
          type : 'POST'
        , dataType: 'xml'
        , contentType : 'application/x-www-form-urlencoded; charset=UTF-8'
        , url : '${fn:escapeXml(wzwg_contextPath)}${fn:escapeXml(prefix)}/menu/linkGrp/selectLinkUrlListAjax.do'
        , cache : false
        , async : false
        , data : {'linkGrpSeq':linkGrpSeq}
        , success : function(xml, status, request) {
            
            $(xml).find("item").each(function(){
                var linkUrl = $(this).find('name').text();
                var linkNm = $(this).find('value').text();
                $("#"+selId).append("<option value=\"" +linkUrl+ "\">" + linkNm + "</option>");
            });
            
            /*
            $('#'+selId).change(function() {
           	 var newLink = $(this).val();
           	 if(newLink.indexOf('/') == 0){
           		 
           	 }else if(newLink.indexOf('http') == -1){
           		 newLink = 'http://' + newLink;
           	 }
                var win = window.open(newLink, '_blank');
                win.focus();
            });
            */
            $('#' + selId).after('<button id="btn_' + selId + '" class="wzbtn-table btn-basic" style="margin-left:3px !important; opacity: 0.8; padding-top: 1px; padding-bottom: 1px;" onclick="alert(\'편집화면에서는 링크이동이 불가능합니다.\')">GO</button>');
            
        }
        , error:function (data) {
            alert('<spring:message code="fail.common.msg" text="error" />');
        }
    });
}

function changeTopMenu(topMenuNum){
	var dummy = parseInt(Math.random()*1000); // 템플릿마다 파일명이 같아서 캐시가 남는 문제 해결을 위한 핵
	var topMenuStr = "headmenu0"+topMenuNum+".css" +"?dummy=" + dummy ;
	 var tempDir = $("#headmenu").attr("href").substring(0,$("#headmenu").attr("href").lastIndexOf("/")+1);
	 $("#headmenu").attr("href",siteKey + tempDir+topMenuStr);
	 $("#headmenu").attr("data-menu-seq",topMenuNum);
	 /* try{$('#menuCssSeq').val(topMenuNum);}catch(e){} */
}

/* moo0506 메인메뉴 CSS 변경 */
function changeTopMenuCss(cssPath){
	var dummy = parseInt(Math.random()*1000); // 템플릿마다 파일명이 같아서 캐시가 남는 문제 해결을 위한 핵
	var topMenuStr = cssPath+"?dummy=" + dummy ;
	$("#headmenu").attr("href",topMenuStr);
	 /* try{$('#menuCssSeq').val(topMenuNum);}catch(e){} */
	alert('<spring:message code="wzwg.cmm.msg.MSG080" />');
	wzModalClose();
}

/* moo0506 푸터 CSS 변경 */
function changeFooterCss(cssPath){
	var dummy = parseInt(Math.random()*1000); // 템플릿마다 파일명이 같아서 캐시가 남는 문제 해결을 위한 핵
	var topMenuStr = cssPath+"?dummy=" + dummy ;
	$("#footmenu").attr("href",topMenuStr);
	 /* try{$('#menuCssSeq').val(topMenuNum);}catch(e){} */
	 
	if(cssPath.indexOf('select') > -1){
		//셀렉트 그룹이 밖으로 빠지는 푸터 메뉴이기 때문에 html 소스를 재조립함
		var addSelFoot = '';
			addSelFoot += '<div class="selGroup" id="footSelGrp">';
	    	addSelFoot += '	<ul class="data">';
	    	addSelFoot += '	</ul">';
	    	addSelFoot += '</div>';
	    // 신규 셀렉트 박스가 들어갈영역 만듬
	    
	    $('.ftrmenu').before(addSelFoot);
	    // 신규 셀렉트 박스 영역 추가
	    
	    $('.ftrmenu').find('.link-group').each(function(){
	    	$('#footSelGrp ul').append($(this));
	    });
	    // 영역에 셀렉트 박스 옮김
	}else{
		//셀렉트 박스 작업이 되어 있지 않다면 원복
		if($('#footSelGrp').length == 0){
			//기존에 셀렉트박스 영역이 없다면 아무것도 하지 않는다
		}else{
			// 셀렉트 박스를 원위치로 돌린다
			$('#footSelGrp li').each(function(){
				//console.log($(this));
				$('.ftrmenu ul').append($(this));
			});
			
			$('#footSelGrp').remove();
			// 셀렉트 박스 영역을 삭제한다
		}
	}
	alert('<spring:message code="wzwg.cmm.msg.MSG080" />');
	wzModalClose();
}

/* moo0506 서브 leftmenu CSS 변경 */
function changeSubCss(cssPath, cssType){
	var dummy = parseInt(Math.random()*1000); // 템플릿마다 파일명이 같아서 캐시가 남는 문제 해결을 위한 핵
	var topMenuStr = cssPath+"?dummy=" + dummy ;
	$("#submenu").attr("href",topMenuStr);
	alert('<spring:message code="wzwg.cmm.msg.MSG080" />');
	
	if(cssType){
		$("#submenu").attr("data-type",cssType);
	}
	wzModalClose();
	 /* try{$('#menuCssSeq').val(topMenuNum);}catch(e){} */
}

 
	function footerFtrMenuInfoParsing() {

		 var startMenuLv = 1;
		 var stopMenuLv = 2;
		 
		 $.ajax({
			  type:'POST'
	        , url: '${fn:escapeXml(wzwg_contextPath)}/siteMngr/siteInfo/siteFtrMenuJsonAjax.do'
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
	    	 	        	}//end for 
	     	    	 });//end each
	     	    });//end each
	        }
	        , dataType: 'json'
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

function fnLoadTemplatInit(){ 
	document.frmSave.action="${fn:escapeXml(wzwg_contextPath)}/mngr/screen/selectSiteScreenTemplateInitMngr.do";
	document.frmSave.submit();
}

function fnChangeTempBackup(backupFile){
	$("#backup").val(backupFile);
	document.frmSave.action="${fn:escapeXml(wzwg_contextPath)}/mngr/screen/selectSiteScreenTempIndexMngr.do";
	document.frmSave.submit();
}

function fn_registSubmainCn(moduleNcnm){
	if(confirm('<spring:message code="common.save.msg" />')){
		//fnConvertDesign();
		applyPopup();//저장중 이미지
		
		saveDataReady();
		
		
		$.ajax({
			   type:'POST'
			 , url:'${fn:escapeXml(wzwg_contextPath)}/mngr/module/cntntsEditor/registModuleCntntsCnAjax.do'
			 , data:$("#frmSave").serialize()
			 , async : true
			 , success:function (data) { 
				 if(data.head.result == 'success'){
					
					try{
						//window.opener.location.href = window.opener.location; 
						window.opener.document.location.href = window.opener.document.URL;
					}catch(e){}
					
				 	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
				 	location.replace(location.pathname + '?cntntsCnSeq=' + data.body.cntntsCnSeq +'&cntntsSeq=' + $("#frmSave #cntntsSeq").val());
				 }else{
					 alert('<spring:message code="wzwg.cmm.msg.MSG179" />');
				 }
			 }
			 , dataType: 'json'
		});
		
		/* document.frmSave.action="${fn:escapeXml(wzwg_contextPath)}/mngr/screen/siteScreenTempSave.do";
		document.frmSave.target= "_self";
		document.frmSave.submit(); */
		
		
		
		
	}
}

function applyPopup(){
	var popupContent = $('#apply_pop').html();
	$("#divLayerPopup").html(popupContent);
	$("#divLayerPopup").show();
	
}


 </script>
 
<!-- moo0506 템플릿 index 파일 내에서 관리자 모드에서만 실행되어야 하는 준비 스크립트 -->
<script>
$(document).ready(function(){
	try{
		templateReady();
	}catch(e){
		console.log(e.message);
	}
	
	
	setTimeout(fnBannerBtnText, 1000);
});
</script>

<!-- moo0506 디자인 컨트롤 패널 스크립트 -->
<script>
function dgnCtlPannelToggle(){
	$('#dgnCtlLeft').toggle(0,function(){
		if($(this).css('display') == 'none'){
			$('#dgnCtlPannel').css('width', '45px');
			$('#dgnCtlPannel').addClass('hide');
			$('#dgnCtlToggleBtn').html('&#171');
		}else{
			$('#dgnCtlPannel').css('width', '98%');
			$('#dgnCtlPannel').removeClass('hide');
			$('#dgnCtlToggleBtn').html('&#187');
		}
	});
}

function fnBannerToggle(){
	if($('#top').hasClass('sub_visual_None')){
		$('#top').removeClass('sub_visual_None');
		$('.topSubImgOrign').removeAttr('data-topclass');
		$('.topSubImgOrign').show();
	}else{
		$('#top').addClass('sub_visual_None');
		$('.topSubImgOrign').attr('data-topclass', 'sub_visual_None');
		$('.topSubImgOrign').hide();
	}
	fnBannerBtnText();
}

function fnBannerBtnText(){
	var topClass = $('.topSubImgOrign').attr('data-topclass');
	
	if(topClass == 'sub_visual_None'){
		$('#bnrToggleBtn').html('<spring:message code="wzwg.cmm.word.sub" /><spring:message code="wzwg.cmm.word.banner" /> <spring:message code="wzwg.cmm.word.ex" />');
	}else{
		$('#bnrToggleBtn').html('<spring:message code="wzwg.cmm.word.sub" /><spring:message code="wzwg.cmm.word.banner" /> <spring:message code="wzwg.cmm.word.hide" />');
	}
	
}
</script>


</head>
<body>

	







    

	<!-- 상단 컨트롤러 -->
	<div id="dgnCtlPannel" class="ctrlTopMenu">
    
    	<div id="dgnCtlLeft" class="ctrlBtn">
			
        	<div class="ctrlBtnAlign wd100">
                <ul class="topMenu">
                    
                    <li>
                        <a href="javascript:;" id="GridToggleBtn" onclick="fnGridToggle();">
                            <spring:message code="wzwg.cmm.word.guidance" /><spring:message code="wzwg.cmm.word.line03" /> <spring:message code="wzwg.cmm.word.hide" />
                        </a>
                    </li>
                    
                    <li class="templateNameView">
                        <p>
                            <c:out value="${subMainName }"></c:out> : <strong><c:out value="${cntntnsInfoVO.cntntsNm }"></c:out></strong>
                        </p>
                    </li>
                </ul>
                
                
                <ul class="topMenu fr">            
                    
                    <li>
                        <a href="javascript:;" onclick="fnBannerToggle();" >
                        	<span id="bnrToggleBtn"></span>
                        	<!-- <div class="menu_help">
								<img src="/images/wzwg/site/mngr/ico_help_mngr.png" alt="메뉴 도움말">
								<div class="help_pop" style="top: 54px; left: -190px; width: 287px;">
										서브배너 숨김기능은 저장되지 않습니다.해당기능은 디자인관리 서브페이지 편집화면에서 진행해 주세요.<br>
								</div>
							</div> -->
                        </a>
                    </li>
                    <li class="btn_siteTempltChange">
                    	<a href="javascript:;" onclick="fn_registSubmainCn('${fn:escapeXml(moduleInfoVO.moduleNcnm)}');">
						    <spring:message code="wzwg.cmm.word.stre" />
						</a>
                    </li>
                </ul>
            </div>
    
        </div>
            
	</div>
    
    <!-- /상단 컨트롤러 -->
    

	<div id="editorDiv" class="editor" style="z-index: 0; position:relative;">
		<c:import url="${url}"></c:import>
	</div>

	<form name="frmSave" id="frmSave" method="post">
		<input type="hidden" id="cntntsSeq" name="cntntsSeq" value="${fn:escapeXml(mdCntntsVO.cntntsSeq)}"/>
		<input type="hidden" id="cntntsCn" name="cntntsCn" />
	</form>
	<div id="imgDiv"></div>


	<jsp:include page="/WEB-INF/jsp/wzwg/site/mngr/screen/siteScreenTempltDialogImp.jsp"></jsp:include>
	
	
	
	<form name="frmLayout" id="frmLayout" method="post">
		<input type="hidden" id="templateSeq" name="templateSeq" value="${fn:escapeXml(siteTemplateScreenVO.templateSeq)}" />
		<input type="hidden" id="templateStreCours" name="templateStreCours" value="${fn:escapeXml(siteTemplateScreenVO.templateStreCours)}" />
		<input type="hidden" id="layoutSeCode" name="layoutSeCode" value="${fn:escapeXml(siteTemplateScreenVO.layoutSeCode)}"/>
		<input type="hidden" id="headMenuType" name="headMenuType" />
		<input type="hidden" id="footMenuType" name="footMenuType" />
		<input type="hidden" id="subMenuType" name="subMenuType" />
		<input type="hidden" id="mvpId" name="mvpId" /> 
	</form>
	<!-- 레이어팝업 영역 Start -->
	<div id="divLayerPopup" class="modal fade in"
		style="display:; z-index: 99;"></div>
	<!-- 레이어팝업 영역 End -->
	
	<!-- 적용중 팝업 내용 -->
	<div id="apply_pop" style="display: none;">
		<div class="apply_pop" style="position: absolute; top: 45%; left: 45%; line-height: 20px;">
			<img src="/images/wzwg/cmm/saving.gif" />
		</div>
	</div>
	<div id="mvp_layout">
	 
	 </div>
</body>
</html>
