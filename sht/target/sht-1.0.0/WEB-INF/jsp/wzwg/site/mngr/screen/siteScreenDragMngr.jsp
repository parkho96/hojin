<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>jQuery UI Selectable - Display as grid</title>  
   <link rel="stylesheet" href="/css/wzwg/cmm/jquery-ui.css"> 
  <script src="/js/wzwg/cmm/jquery-latest.min.js"></script>
  <script src="/js/wzwg/cmm/jquery-ui.js"></script> 
    <link href="/css/wzwg/cmm/jquery.contextMenu.css" rel="stylesheet" type="text/css" />
    <script src="/js/wzwg/cmm/jquery.contextMenu.js" type="text/javascript"></script>
    <script src="/js/wzwg/cmm/jquery.ui.position.min.js" type="text/javascript"></script> 
    <script src="/js/wzwg/site/editDragMode.js" type="text/javascript"></script>
    <script src="/js/wzwg/site/editDragFunc.js" type="text/javascript"></script>
<script src="/js/wzwg/cmm/medium-editor.min.js"></script>
<link rel="stylesheet" type="text/css" media="screen" href="/css/wzwg/cmm/0028_farbtastic.css" />

<script src="/design/module/sample/js/swiper.jquery.min.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/wzwg/cmm/0028_farbtastic.js"></script>
		
<link rel="stylesheet" href="/css/wzwg/cmm/medium-editor.min.css" type="text/css" media="screen" charset="utf-8">
<style type="text/css">   
 .medium-editor-toolbar-input {border:1px solid #3899ec !important;}
  .medium-editor-toolbar li {border:1px solid #3899ec !important;}
  .medium-editor-toolbar li button{padding:10px !important;}
  .medium-editor-toolbar {padding-bottom: 15px !important;}
 .selected {border:1px solid #3899ec !important; }
  .ui-resizable-handle{
      width: 7px;
      height: 7px;
      background-color: #fff;
      border: 1px solid #3899ec; 
      z-index: 1; }
	 .ui-resizable-n{
		left:50%;
	 }
	 .ui-resizable-e{
		top:50%;
	 }
	 .ui-resizable-s{
		left:50%;
	 }
 
    .ui-resizable-w{
		top:50%;
	 }
	
	 .ui-resizable-se{
		right:-5px;
		bottom:-5px;
	 }
	 .txtBtn{
		top:-50px;
		left:-50px;
		position:relative;
	 }
	.top{ 
	   background-color: #fff;
		border-bottom: 2px dotted #3899ec; 
		z-index: 1;
	}  
	
	#content{ 
	   background-color: #fff;
		border-bottom: 2px dotted #3899ec; 
		z-index: 1;
		margin:0px !important;
	}  
	
	
	#footer{ 
	   background-color: #fff;
		border-bottom: 2px dotted #3899ec; 
		z-index: 1;
		margin:0px !important;
	}  
	
	
   .slider li{ 
	display: inline-block; 
	margin:2px;
    padding: 0;
    height: 7px;
    width: 7px;
    cursor: pointer;
	border: 2px solid #888;
	border-radius: 7px;
    -moz-border-radius: 7px;
    -webkit-border-radius: 7px;
    -khtml-border-radius: 7px;
    position: relative;
    left:30px;
    top:-20px;
	}
	
	.slider li.active{ 
	 background-color:  #888;
	}  
 </style> 
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
//중분류 선택시 중분류에 맞는 샘플 목록을 출력함
 function fnMenuMlcListSelect(codeVal2,cntseq2) { 
     $.ajax({
         type:'POST'
       , url:'<c:out value="${wzwg_contextPath}"/>/module/scrin/module/selectSampleList.do?mode=1'
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
       , url:'<c:out value="${wzwg_contextPath}"/>/module/scrin/module/selectSampleList.do?mode='+mode
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

 function fnDivJsonDataRead(callback){
	    $('.cntContextSGC0000027').each(function (index, parentEle) {
	        var cntseq = $(this).data('cntseq');
	        
	        $.ajax({
	            type:'POST'
	          , url:'<c:out value="${wzwg_contextPath}"/>/module/scrin/scrinCntntsJson.do'
	          , data:{menuSeq:cntseq}
	          , success:function (data) {
	              fnDivJsonDataPrint(data, parentEle,callback);
	              
	          }
	          , dataType: 'json'
	      });
	    }); 
	    
 }
 function fnDivJsonTabDataRead(callback){
	    $('.tabmenu').children("li").each(function (index, parentEle) {
	        var cntseq = $(this).data('cntseq');
	        
	        $.ajax({
	            type:'POST'
	          , url:'<c:out value="${wzwg_contextPath}"/>/module/scrin/scrinCntntsJson.do'
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
	          , url:'<c:out value="${wzwg_contextPath}"/>/module/scrin/scrinCntntsJson.do'
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
		        	$(childEle).css("display","");
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
		        //	alert(1);
		        	$(childEle).css("display","none");
		        }
			   
		    });
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
				  $(this).draggable( "option", "disabled", true ); 
				  txtEditMode ='Y';
				}

				if(key == "txtEditEnd"){     
				  opt.items.txtEditEnd.disabled=true;	
				  opt.items.txtEdit.disabled=false;	
				  opt.items.copy.disabled=false;	
				  editor.destroy();
				  $(this).draggable( "option", "disabled", false ); 
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
                "txtEdit": {name: "<spring:message code="wzwg.site.screen.msg.MSG017" />", icon: "edit"},
                "copy": {name: "<spring:message code="wzwg.site.screen.msg.MSG018" />", icon: "copy"},
                "size": {name: "<spring:message code="wzwg.site.screen.msg.MSG019" />", icon: "edit"},  
                "zindex":{
	           		 name:"배열", icon : "edit",
	           		 items:{
	       				 "maxZindex": {name: "<spring:message code="wzwg.cmm.msg.MSG307" />", icon: "edit"},
	       				 "minZindex": {name: "<spring:message code="wzwg.cmm.msg.MSG308" />", icon: "edit"}
	       			}
       		   }, 
				"txtEditEnd": {name: "<spring:message code="wzwg.site.screen.msg.MSG020" />", icon: "edit",disabled:true},
				"delete": {name: "<spring:message code="wzwg.site.screen.msg.MSG021" />", icon: "trash"},
				"background": {name: "<spring:message code="wzwg.site.screen.msg.MSG022" />", icon: "edit"},
		         "border-color": {name: "<spring:message code="wzwg.site.screen.msg.MSG023" />", icon: "edit"},
                "sep1": "---------",
                "quit": {name: "<spring:message code="wzwg.cmm.word.close" />", icon: function(){
                    return 'context-menu-icon context-menu-icon-close';
                }}
            }
        });
 }
 function uploadImg(mode){
		$.ajax({
	        type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}"/>/module/upload/image/imageForm.do?mode='+mode
			, dataType : 'html'
			, success : function (data) {
				$("#imgDiv").html(data);
				$("#imgDiv").show();
			}
			, error : function (request, status, error) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
		}); 
 }
 $(function() {
	 fnDivJsonTabDataRead();
	 fnDivJsonDataRead();
	 txtContextMenu();
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
			if($("#top  .menu").length >0){
				if($(".menu").data("sample") != undefined){
				  fnAddTopDiv($(".menu").data("sample"));
				}else{
					topMenuParsing();
				}
				  
			}
			
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

			editDialog();
			editContextMenu();
			
			 $.contextMenu({
			     selector: '.tabboard', 
			     callback: function(key, opt) {
			    	 if(key =='addBbs'){
							//addImg();
							selectDiv=$(this).find(".tabmenu"); 
							selectDiv.append("<li  data-cntseq=\"<c:out value="${firstNttMenuSeq.menuSeq}"/>\"><a href=\"javascript:void(0);\" class=\"menuNm\"><spring:message code="wzwg.cmm.word.notice" />3</a></li>")
							var selectDiv2=$(this).find(".tab");
							selectDiv2.append ("<div class=\"tabbox tabbody1\"><div class=\"pd30\" data-cntseq=\"<c:out value="${firstNttMenuSeq.menuSeq}"/>\"> "
							+"<h3  class=\"menuNm\"><spring:message code="wzwg.cmm.word.notice" /></h3> "
							+"<ul id=\"data\"> "
							+"	<li><a href=\"javascript:void(0);\"  data-href=\"bbsViewLink\"><span class=\"fl\" data-attr=\"nttSj\"><spring:message code="wzwg.site.screen.msg.MSG024" /> 01</span> <span class=\"fr\" data-attr=\"frstRegistPnttm\">2017-06-26</span></a></li>"
							+"	<li><a href=\"javascript:void(0);\" data-href=\"bbsViewLink\"><span class=\"fl\" data-attr=\"nttSj\"> <spring:message code="wzwg.site.screen.msg.MSG024" /> 01</span> <span class=\"fr\" data-attr=\"frstRegistPnttm\">2017-06-26</span></a></li>"
							+"	<li><a href=\"javascript:void(0);\" data-href=\"bbsViewLink\"><span class=\"fl\" data-attr=\"nttSj\"> <spring:message code="wzwg.site.screen.msg.MSG024" /> 01</span> <span class=\"fr\" data-attr=\"frstRegistPnttm\">2017-06-26</span></a></li>"
							+"	<li><a href=\"javascript:void(0);\" data-href=\"bbsViewLink\"><span class=\"fl\" data-attr=\"nttSj\"> <spring:message code="wzwg.site.screen.msg.MSG024" /> 01</span> <span class=\"fr\" data-attr=\"frstRegistPnttm\">2017-06-26</span></a></li>"
							+"	<li><a href=\"javascript:void(0);\" data-href=\"bbsViewLink\"><span class=\"fl\" data-attr=\"nttSj\"> <spring:message code="wzwg.site.screen.msg.MSG024" /> 01</span> <span class=\"fr\" data-attr=\"frstRegistPnttm\">2017-06-26</span></a></li>"
							+"</ul> "
							+"</div> </div> "); 
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
							$('.tabmenu').children("li").children("a").eq($('.tabmenu').children("li").children("a").size()-1).click();
							fnDivJsonTabDataRead();
					}else if(key =='delBbs'){
						$(this).find(".tabmenu").children(".currentBtn").remove();
						$(this).find(".tab").children(".currentDiv").remove();
						$('.tab').children("div").eq(0).css('display','block');
						$('.tabmenu').children("li").children("a").eq(0).addClass("on");
						$('.tabmenu').children("li").eq(0).addClass("currentBtn");
						$('.tab').children("div").eq(0).addClass("currentDiv");
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
					}else if(key =='maxZindex'){
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
							
							sThis = $(this);
							selectDiv=$(this).find(".tabmenu").children(".currentBtn");
							selectDiv.data("cntseq",key);
							selectDiv.attr("data-cntseq",key); 
							var selectDiv2=$(this).find(".tab").children(".currentDiv").find("div");
							selectDiv2.data("cntseq",key);
							selectDiv2.attr("data-cntseq",key); 
							fnDivJsonTabDataRead();
						}
						
			     },
			     items: {
			     	"addBbs": {name: "<spring:message code="wzwg.site.screen.msg.MSG025" />", icon: "edit"}, 
			     	"dataReplace": {
			     					name: "<spring:message code="wzwg.site.screen.msg.MSG026" />", icon: "link",
			     					items:{
			     						  <c:if test="${fn:length(moduleSGC0000027)>0}"> 
			     			                								<c:forEach  items="${moduleSGC0000027}" var="subList" varStatus="statusSub">
			     			                								"<c:out value="${subList.menuSeq}"/>":{name:"<c:out value="${subList.menuNm}"/>",icon:"edit"}<c:if test="${!statusSub.last}">,</c:if>
			     			                								</c:forEach>
			     			                </c:if>
			     					}
			     					}, 
			     		"delBbs": {name: "<spring:message code="wzwg.site.screen.msg.MSG027" />", icon: "edit"},  
						"zindex":{
			        		 name:"<spring:message code="wzwg.cmm.word.array" />", icon : "edit",
			        		 items:{
			    				 "maxZindex": {name: "<spring:message code="wzwg.cmm.msg.MSG307" />", icon: "edit"},
			    				 "minZindex": {name: "<spring:message code="wzwg.cmm.msg.MSG308" />", icon: "edit"}
			    			}
			 		   },  
			         "sep1": "---------",
			         "quit": {name: "<spring:message code="wzwg.cmm.word.close" />", icon: function(){
			             return 'context-menu-icon context-menu-icon-close';
			         }}
			     }
			 });
			 

			 $.contextMenu({
			     selector: '.cntContextSGC0000027', 
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
							if($(this).parent().data("tab") =='Y'){
								 $(this).parent().children("ul:first").children("li").each(function(){
									if($(this).children("a").attr("href")=="#"+sThis.attr("id")){
										$(this).children("a").html("<h3>"+opt.items.dataReplace.items[key].name+"</h3>");
									} 
								 }); 
							} 
							 fnDivJsonDataRead();
						}
						
			     },
			     items: {
			     	//"skinReplace": {name: "스킨변경", icon: "edit"}, 
			     	"dataReplace": {
			     					name: "<spring:message code="wzwg.site.screen.msg.MSG026" />", icon: "link",
			     					items:{
			     						  <c:if test="${fn:length(moduleSGC0000027)>0}"> 
			     			                								<c:forEach  items="${moduleSGC0000027}" var="subList" varStatus="statusSub">
			     			                								"<c:out value="${subList.menuSeq}"/>":{name:"<c:out value="${subList.menuNm}"/>",icon:"edit"}<c:if test="${!statusSub.last}">,</c:if>
			     			                								</c:forEach>
			     			                </c:if>
			     					}
			     					}, 
						"zindex":{
			        		 name:"<spring:message code="wzwg.cmm.word.array" />", icon : "edit",
			        		 items:{
			    				 "maxZindex": {name: "<spring:message code="wzwg.cmm.msg.MSG307" />", icon: "edit"},
			    				 "minZindex": {name: "<spring:message code="wzwg.cmm.msg.MSG308" />", icon: "edit"}
			    			}
			 		   },  
			         "sep1": "---------",
			         "quit": {name: "<spring:message code="wzwg.cmm.word.close" />", icon: function(){
			             return 'context-menu-icon context-menu-icon-close';
			         }}
			     }
			 }); 

		$.contextMenu({
            selector: '#content', 
            callback: function(key, options) {
                if(key=='SGC0000022'){
					addTxt();
				}else if(key =='uploadImg'){
					//addImg();
					uploadImg(1);
				}else if(key =='linkImg'){
					   $( "#imgLinkDiv" ).dialog("open");
				}else if(key =='background-src'){
					selectDiv=$(this); 
					uploadImg(3);
				}else if(key=='background'){
						 $( "#pickerDiv" ).dialog("open");
						jQuery.farbtastic('#picker').linkTo('#'+$(this).attr("id"));
            	}else if(key=='addBanner'){
					addBanner();
         		}else{  
					fnMenuMlcListSelect(key.split("-")[0],key.split("-")[1]);
				}
            },
            items: {
            	"addBanner": {name: "<spring:message code="wzwg.site.screen.msg.MSG028" />", icon: "edit"}, 
                <c:forEach  items="${moduleList}" var="module" varStatus="status">
                <c:if test="${fn:length(module.subList)==0}">
                <c:if test="${module.grpVo.grpcode eq 'SGC0000023'}">
                "addImage": {
        			name: "<spring:message code="wzwg.site.screen.msg.MSG029" />", icon: "edit",
        			items:{
        				 "uploadImg": {name: "<spring:message code="wzwg.site.screen.msg.MSG030" />", icon: "edit"},
        				 "linkImg": {name: "<spring:message code="wzwg.site.menu.msg.MSG019" />", icon: "edit"}
        			}
  			      },
                </c:if>
                <c:if test="${module.grpVo.grpcode ne 'SGC0000023'}">
                "<c:out value="${module.grpVo.grpcode}"/>":{name:"<c:out value="${module.grpVo.grpcodeNm}"/>", icon: "edit"},
                </c:if>
                </c:if>
                <c:if test="${fn:length(module.subList)>0}">
                "<c:out value="${module.grpVo.grpcode}"/>":{
                	name:"<c:out value="${module.grpVo.grpcodeNm}"/>", icon: "edit",
                							items:{
                								<c:forEach  items="${module.subList}" var="subList" varStatus="statusSub">
                								"<c:out value="${module.grpVo.grpcode}-${subList.menuSeq}"/>":{name:"<c:out value="${subList.menuNm}"/>",icon:"edit"}<c:if test="${!statusSub.last}">,</c:if>
                								</c:forEach>
                							}
                						  },
                </c:if>
                </c:forEach>
                "background-src": {name: "<spring:message code="wzwg.site.screen.msg.MSG031" />",  icon: "edit"},
                "background": {name: "<spring:message code="wzwg.site.screen.msg.MSG032" />",  icon: "edit"},
                "sep1": "---------",
                "quit": {name: "<spring:message code="wzwg.cmm.word.color" />", icon: function(){
                    return 'context-menu-icon context-menu-icon-close';
                }}
            }
        });   
    document.onkeydown = backSpaceKey;  
editInit(); 
	if($(".mainSlider").size() >0){
		      swiper = new Swiper('.mainSlider', {
		    	loop: true, 
				simulateTouch :false , 
		        pagination: '.swiper-pagination', 
		        nextButton: '.swiper-button-next',
		        prevButton: '.swiper-button-prev', 
		    	paginationClickable: true
		    });
		
	}
 });
function txtEdit(idName){  
	if($('#'+idName.id).parent().attr("contenteditable") =="true"){
	$('#'+idName.id).parent().attr("contenteditable","false");
	}else{ 
	$('#'+idName.id).parent().attr("contenteditable","true");
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

function getSave(){ 
	$("#top").removeClass("selected");   
	//$("#top").resizable( "destroy" );
	//$("#top").draggable();
	//$("#top").draggable("destroy"); 
	//$("#top").contextMenu("destroy");
	$("#content").resizable( "destroy" );
	$("#content").draggable();
	$("#content").draggable("destroy"); 
	$("#content").contextMenu("destroy");
	
	$("#footer").removeClass("selected");   
	$("#footer").resizable( "destroy" );
	$("#footer").draggable();
	$("#footer").draggable("destroy"); 
	$("#footer").contextMenu("destroy");
	 

	

	$("#content").wrap("<div id='contentsWrap'>");
	$("#contents").val($("#contentsWrap").html()); 
	$("#top").wrap("<div id='topMenu'>");
	$("#footer").wrap("<div id='footerWrap'>");
	$("#topContents").val($("#topMenu").html()); 
	$("#footerContents").val($("#footerWrap").html());  
	document.frmSave.action="<c:out value="${wzwg_contextPath}"/>/mngr/screen/siteScreenSave.do";
	document.frmSave.submit();
}



function footerFtrMenuParsing(lgnAt) {

 var startMenuLv = 1;
 var stopMenuLv = 2;
 $('.ftrmenu').load("/design/sample/etc/FTRMENU.html",function(){
 $('.ftrmenu').each(function (index, parentEle) {
     $.ajax({
         type:'POST'
       , url:'<c:out value="${wzwg_contextPath}"/>/mngr/menu/siteHdftrMenuJsonAjax.do?hdftrCode=SC00000082&lgnAt='+lgnAt
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
          , url:'<c:out value="${wzwg_contextPath}"/>/mngr/menu/siteHdftrMenuJsonAjax.do?hdftrCode=SC00000081&lgnAt='+lgnAt
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

function topMenuParsing() {

    var startMenuLv = 1;
    var stopMenuLv = 2;
    
    $('.menu').each(function (index, parentEle) {
        $.ajax({
            type:'POST'
          , url:'<c:out value="${wzwg_contextPath}"/>/module/scrin/scrinMenuJson.do'
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
  
	function footerFtrMenuInfoParsing() {

		 var startMenuLv = 1;
		 var stopMenuLv = 2;
		 
		 $('.ftrmenu').each(function (index, parentEle) {
		     $.ajax({
		         type:'POST'
		       , url:'<c:out value="${wzwg_contextPath}"/>/mngr/siteMngr/siteInfo/siteFtrMenuJsonAjax.do'
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
 </script>
 

</head>
<body>
			
 <!--
  <a href="#" onclick="addTxt();">텍스트추가하기</a>
  <a href="#" onclick="addImg();">이미지추가하기</a>
  
  <a href="#" class="ui-button ui-widget ui-corner-all" onclick="getSource();"><spring:message code="wzwg.cmm.word.preview" /></a>
  <a href="#" class="ui-button ui-widget ui-corner-all" onclick="setEdit();"><spring:message code="wzwg.site.screen.msg.MSG033" /></a>
  -->
  <a href="#" class="ui-button ui-widget ui-corner-all" onclick="getSave();"><spring:message code="wzwg.cmm.word.stre" /></a> 
  <spring:message code="wzwg.cmm.word.import02" /> : <select id="backupFile" name="backupFile" onchange="fnChangeBackup(this.value)">
  	<option value=""><spring:message code="wzwg.site.screen.msg.MSG034" /></option>
  	<c:forEach items="${backupIndexList}" var="files" varStatus="status">
  		<option value="<c:out value="${files}"/>" <c:if test="${files eq paramVO.backup}">selected="true"</c:if>><c:out value="${files}"/></option>
  	</c:forEach>
  </select>

  <div id="editorDiv" class="editor"  style="z-index:0;">
	  <c:import url="${url}"></c:import>
 </div> 
 
<form name="frmSave" id="frmSave" method="post">
 	<input type="hidden" id="contents" name="contents"/>
 	<input type="hidden" id="topContents" name="topContents"/>
 	<input type="hidden" id="footerContents" name="footerContents"/>
 	<input type="hidden" id="backup" name="backup"/>
 </form>
<div id="imgDiv"></div>


 <div id="imgLinkDiv" title="<spring:message code="wzwg.site.screen.msg.MSG035" />" style="z-index: 999;">
  <p><input type="text" name="imgLink" id="imgLink" /></p>
   <a href="#" class="ui-button ui-widget ui-corner-all" onclick="addImg($('#imgLink').val());"><spring:message code="wzwg.cmm.word.stre" /></a>
</div>

 <div id="imgLinkSilderDiv" title="<spring:message code="wzwg.site.screen.msg.MSG035" />" style="z-index: 999;">
  <p><input type="text" name="imgLinkSilder" id="imgLinkSilder" /></p>
   <a href="#" class="ui-button ui-widget ui-corner-all" onclick="addImgSilder($('#imgLinkSilder').val(),selectDiv);"><spring:message code="wzwg.cmm.word.stre" /></a>
</div>

 <div id="imgLinkBootSilderDiv" title="<spring:message code="wzwg.site.screen.msg.MSG035" />" style="z-index: 999;">
  <p><input type="text" name="imgLinkBootSilder" id="imgLinkBootSilder" /></p>
   <a href="#" class="ui-button ui-widget ui-corner-all" onclick="addImgSilder($('#imgLinkBootSilder').val(),selectDiv);"><spring:message code="wzwg.cmm.word.stre" /></a>
</div>

 <div id="imgLinkUrlDiv" title="이미지링크경로" style="z-index: 999;">
  <p><input type="text" name="imgLinkUrl" id=imgLinkUrl /></p>
  target :<select id="imgLinkTarget" name="imgLinkTarget">
  	<option value="_self"><spring:message code="wzwg.cmm.word.nowwin" /></option>
  	<option value="_blank"><spring:message code="wzwg.cmm.word.newwin" /></option>
  </select>
   <a href="#" class="ui-button ui-widget ui-corner-all" onclick="addImgLink($('#imgLinkUrl').val(),$('#imgLinkTarget').val());"><spring:message code="wzwg.cmm.word.stre" /></a>
</div>

<div id="pickerDiv" title="<spring:message code="wzwg.cmm.word.scrin.colTable" />" style="z-index: 999;">
   <div id="picker"></div>
</div>
<div id="pickerBorderDiv" title="<spring:message code="wzwg.cmm.word.scrin.colTable" />" style="z-index: 999;"> 
   <div id="pickerBorder"></div>
</div>
<div id="divSampleList" title="목록리스트" style="z-index: 999;"></div>
 
  <div id="sizeDiv" title="위치 및 크기" style="z-index: 999;">
  <p>top   : <input type="text" name="sTop" id="sTop" style="width:100px;" /> </p>
  <p>left  : <input type="text" name="sLeft" id="sLeft" style="width:100px;"/> </p>
  <p>width : <input type="text" name="sWidth" id="sWidth" style="width:100px;"/> </p>
  <p>height: <input type="text" name="sHeight" id="sHeight" style="width:100px;"/> </p>
   <a href="#" class="ui-button ui-widget ui-corner-all" onclick="setDivSize(selectDiv);"><spring:message code="wzwg.cmm.word.stre" /></a>
</div>

<div id="txtBannerDiv" title="메인베너" style="z-index: 999;">
  <p><input type="text" name="txtBanner" id="txtBanner" /></p>
   <a href="#" class="ui-button ui-widget ui-corner-all" onclick="addBannerTxt($('#txtBanner').val());"><spring:message code="wzwg.cmm.word.stre" /></a>
</div>

 <div id="bannerLinkUrlDiv" title="바로가기링크경로" style="z-index: 999;">
  <p><input type="text" name="bannerLinkUrl" id=bannerLinkUrl /></p>
  target :<select id="bannerLinkTarget" name="bannerLinkTarget">
  	<option value="_self"><spring:message code="wzwg.cmm.word.nowwin" /></option>
  	<option value="_blank"><spring:message code="wzwg.cmm.word.newwin" /></option>
  </select>
   <a href="#" class="ui-button ui-widget ui-corner-all" onclick="addBannerLink($('#bannerLinkUrl').val(),$('#bannerLinkTarget').val());"><spring:message code="wzwg.cmm.word.stre" /></a>
</div>

 
 
</body>
</html>
