<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>jQuery UI Selectable - Display as grid</title>
<link rel="stylesheet" href="/css/wzwg/cmm/jquery-ui.css">
<script src="/js/wzwg/cmm/jquery-latest.min.js"></script>
<script src="/js/wzwg/cmm/jquery-ui.js"></script>
<link href="/css/wzwg/cmm/jquery.contextMenu.css" rel="stylesheet"
	type="text/css" />
<script src="/js/wzwg/cmm/jquery.contextMenu.js" type="text/javascript"></script>
<script src="/js/wzwg/cmm/jquery.ui.position.min.js"
	type="text/javascript"></script>
<script src="/js/wzwg/site/editMode.js" type="text/javascript"></script>
<script src="/js/wzwg/site/editFunc.js" type="text/javascript"></script>
<script src="/js/wzwg/cmm/medium-editor.min.js"></script>
<link rel="stylesheet" type="text/css" media="screen"
	href="/css/wzwg/cmm/0028_farbtastic.css" />

<script src="/design/module/sample/js/swiper.jquery.min.js"></script>
<script type="text/javascript" charset="utf-8"
	src="/js/wzwg/cmm/0028_farbtastic.js"></script>

<link rel="stylesheet" href="/css/wzwg/cmm/medium-editor.min.css"
	type="text/css" media="screen" charset="utf-8">
	
<link rel="stylesheet" href="/css/wzwg/site/mngr/screenMngr.css" type="text/css">

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
 
 
	var oEditors = [];
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
		    	$(ele).find('.menuSeq').attr("href","<c:out value="${wzwg_contextPath}"/>/subList/"+data.cntntsInfo.menuSeq);  
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
			 
			 /* $("#content").children("div").each(function(){
			   $(this).resizable();
			   $(this).resizable( "option", "disabled", true );
			}); */  
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
                "txtEdit": {name: "<spring:message code="wzwg.site.screen.msg.MSG017" />", icon: "edit"},
                "copy": {name: "<spring:message code="wzwg.site.screen.msg.MSG018" />", icon: "copy"},
                "size": {name: "<spring:message code="wzwg.site.screen.msg.MSG019" />", icon: "edit"}, 
                /**
                "zindex":{
	           		 name:"배열", icon : "edit",
	           		 items:{
	       				 "maxZindex": {name: "<spring:message code="wzwg.cmm.msg.MSG307" />", icon: "edit"},
	       				 "minZindex": {name: "<spring:message code="wzwg.cmm.msg.MSG308" />", icon: "edit"}
	       			}
       		   },
       		   **/
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
 
 function addContentsLayout(){
		$.ajax({
			   type:'POST'
			 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/screen/selectSiteLayoutTempltAjax.do'
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
			 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/screen/selectSiteLayoutAjax.do'
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
		 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/screen/selectLayoutContentsPopupAjax.do'
		 , cache : false
		 , async : false
		 , processData: false
		 , contentType: false
		 , data : form
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
 
 /* moo0506 레이아웃 영역에 컨텐츠 추가*/
 function addLayoutContents(_html, _css, _cssId){
	 $('#tmpReciveContents').html('');
	 
	 if($('#' + _cssId).length == 0){
		 $('#content').append('<link rel="stylesheet" href="' + _css + '" type="text/css" id="' + _cssId + '"/>' );
	 }
	 
	 $('.addLayoutContentsZone').find('.add_div').remove();
	 
	 var contents = $('<div/>');
	 contents.load(_html + '?ran=' + Math.random(), function(){
		 //console.log($(this).html());
		 $('.addLayoutContentsZone').append($(this).html());
		 editInit();
		 alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.word.cntnts" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.add" /></spring:argument></spring:message>');
	 	 fnLayerPopupClose();
	 })
	
 }
 
 function addContentsTxt(){
		$.ajax({
			   type:'POST'
			 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/screen/siteTxtContentsInfoAjax.do'
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
 
/*  function addQuickBanner(){
		 if($(".quickBannerZone").size() ==0){
			 alert('<spring:message code="wzwg.cmm.msg.MSG178" />');
			 return;
		 }
		
	 $.ajax({
		   type:'POST'
		 , url:'/mngr/screen/selectSiteQuickBannerAjax.do'
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
	} */
 
 /* moo0506 퀵배너 추가시 퀵배너 html에서 샘플 코드를 복사해서 퀵배너 영역에 바로 추가 */
 function addQuickBanner(qContents){

		var maxitem = $(qContents).attr('data-maxitem');
		var itemLength = $(qContents).find('.quickBannerZone').children().length;
		console.log(maxitem + '/' + itemLength);
		 
		maxitem = parseInt(maxitem);
		itemLength = parseInt(itemLength);
		
		if(maxitem <= itemLength){
			alert('<spring:message code="wzwg.cmm.msg.MSG177"><spring:argument>'+maxitem+'</spring:argument></spring:message>');
			return;
		}
		 
		var quickItem = $(qContents).find('.quick_sample').html();
		$(qContents).find('.quickBannerZone').append(quickItem);
	}
	
 function fnLayerPopupClose() {
	    $("#divLayerPopup").hide();
	    $("#divLayerPopup").empty();
	    $('body').css({overflow:'auto'});
	}
 $(document).ready(function(){
		 
		$(".hide").click(function(){
			$(".pop-box").hide();
		});
	});
 $(function() {
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
			if($("#top  .menu").length >0){
					topMenuParsing(); 
				  
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
							selectDiv.append("<li  data-cntseq=\"<c:out value="${firstNttMenuSeq.menuSeq}"/>\"><a href=\"javascript:void(0);\" class=\"menuNm\"><spring:message code="wzwg.cmm.word.notice02" />3</a></li>")
							var selectDiv2=$(this).find(".tab");
							selectDiv2.append ("<div class=\"tabbox tabbody1\"><div class=\"pd30\" data-cntseq=\"<c:out value="${firstNttMenuSeq.menuSeq}"/>\"> "
							+"<h3  class=\"menuNm\"><spring:message code="wzwg.cmm.word.notice02" /></h3> "
							+"<ul id=\"data\"> "
							+"	<li><a href=\"javascript:void(0);\"  data-href=\"bbsViewLink\"><span class=\"fl\" data-attr=\"nttSj\"><spring:message code="wzwg.site.screen.msg.MSG024" />01</span> <span class=\"fr\" data-attr=\"frstRegistPnttm\">2017-06-26</span></a></li>"
							+"	<li><a href=\"javascript:void(0);\" data-href=\"bbsViewLink\"><span class=\"fl\" data-attr=\"nttSj\"> <spring:message code="wzwg.site.screen.msg.MSG024" />01</span> <span class=\"fr\" data-attr=\"frstRegistPnttm\">2017-06-26</span></a></li>"
							+"	<li><a href=\"javascript:void(0);\" data-href=\"bbsViewLink\"><span class=\"fl\" data-attr=\"nttSj\"> <spring:message code="wzwg.site.screen.msg.MSG024" />01</span> <span class=\"fr\" data-attr=\"frstRegistPnttm\">2017-06-26</span></a></li>"
							+"	<li><a href=\"javascript:void(0);\" data-href=\"bbsViewLink\"><span class=\"fl\" data-attr=\"nttSj\"> <spring:message code="wzwg.site.screen.msg.MSG024" />01</span> <span class=\"fr\" data-attr=\"frstRegistPnttm\">2017-06-26</span></a></li>"
							+"	<li><a href=\"javascript:void(0);\" data-href=\"bbsViewLink\"><span class=\"fl\" data-attr=\"nttSj\"> <spring:message code="wzwg.site.screen.msg.MSG024" />01</span> <span class=\"fr\" data-attr=\"frstRegistPnttm\">2017-06-26</span></a></li>"
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
			     		/**
						"zindex":{
			        		 name:"배열", icon : "edit",
			        		 items:{
			    				 "maxZindex": {name: "<spring:message code="wzwg.cmm.msg.MSG307" />", icon: "edit"},
			    				 "minZindex": {name: "<spring:message code="wzwg.cmm.msg.MSG308" />", icon: "edit"}
			    			}
			 		   }, 
			 		   **/
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
			     					name: "<spring:message code="wzwg.site.screen.msg.MSG026" />", icon: "link",
			     					items:{
			     						  <c:if test="${fn:length(moduleSGC0000027)>0}"> 
			     			                								<c:forEach  items="${moduleSGC0000027}" var="subList" varStatus="statusSub">
			     			                								"<c:out value="${subList.menuSeq}"/>":{name:"<c:out value="${subList.menuNm}"/>",icon:"edit"}<c:if test="${!statusSub.last}">,</c:if>
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
			 		 "addBgColor": {name: "<spring:message code="wzwg.site.screen.msg.MSG036" />", icon: "edit"},
			         "sep1": "---------",
			         "quit": {name: "<spring:message code="wzwg.cmm.word.close" />", icon: function(){
			             return 'context-menu-icon context-menu-icon-close';
			         }}
			     }
			 });
			 /***

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
            	"addBanner": {name: "베너추가", icon: "edit"}, 
                <c:forEach  items="${moduleList}" var="module" varStatus="status">
                <c:if test="${fn:length(module.subList)==0}">
                <c:if test="${module.grpVo.grpcode eq 'SGC0000023'}">
                "addImage": {
        			name: "이미지추가", icon: "edit",
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
                "background-src": {name: "배경이미지",  icon: "edit"},
                "background": {name: "배경색상",  icon: "edit"},
                "sep1": "---------",
                "quit": {name: "<spring:message code="wzwg.cmm.word.close" />", icon: function(){
                    return 'context-menu-icon context-menu-icon-close';
                }}
            }
        });   
	**/
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
	
	writeContentTxt();
	
	//mouseHelpTxt();
	
	
	
	
	
 });/*end function()*/
 
function mouseHelpTxt(){
	 /*
	$('#editorDiv').mousemove(function(e) {
	      mouseX = e.pageX;
	      mouseY = e.pageY - $(document).scrollTop();
	      $('#mousehelp').css("display", 'block').css("left", mouseX+23).css("top", mouseY+10);
		console.log(mouseX + ' / ' + mouseY);
	      
	});
	
	$('#editorDiv').mouseleave(function(e) {
	      $('#mousehelp').css("display", 'none');
	});
	*/
	
	
	$('#editorDiv .bTitle').mousemove(function(e) {
	      mouseX = e.pageX;
	      mouseY = e.pageY - $(document).scrollTop();
	      $('#mousehelp').css("display", 'block').css("left", mouseX+23).css("top", mouseY+10);
	      
	});
	
	$('#editorDiv .bTitle').mouseleave(function(e) {
	      $('#mousehelp').css("display", 'none');
	});
	
	
	$('#editorDiv .bContent').mousemove(function(e) {
		  mouseX = e.pageX;
		  mouseY = e.pageY - $(document).scrollTop();
	      $('#mousehelp').css("display", 'block').css("left", mouseX+23).css("top", mouseY+10);
	});
	
	$('#editorDiv .bContent').mouseleave(function(e) {
	      $('#mousehelp').css("display", 'none');
	});
	
	$('#editorDiv .bn-p').mousemove(function(e) {
	      mouseX = e.pageX;
	      mouseY = e.pageY - $(document).scrollTop();
	      $('#mousehelp').css("display", 'block').css("left", mouseX+23).css("top", mouseY+10);
	});
	
	$('#editorDiv .bn-p').mouseleave(function(e) {
	      $('#mousehelp').css("display", 'none');
	});
	
	
	$('#editorDiv .swiper-container').mousemove(function(e) {
	      mouseX = e.pageX;
	      mouseY = e.pageY - $(document).scrollTop();
	      $('#mousehelp').css("display", 'block').css("left", mouseX+23).css("top", mouseY+10);
	});
	
	$('#editorDiv .swiper-container').mouseleave(function(e) {
	      $('#mousehelp').css("display", 'none');
	});
	
	
	$('#editorDiv .changeBg').mousemove(function(e) {
	      mouseX = e.pageX;
	      mouseY = e.pageY - $(document).scrollTop();
	      $('#mousehelp').css("display", 'block').css("left", mouseX+23).css("top", mouseY+10);
	});
	
	$('#editorDiv .changeBg').mouseleave(function(e) {
	      $('#mousehelp').css("display", 'none');
	});
	
	
	$('#editorDiv .cntContextSGC0000027').mousemove(function(e) {
	      mouseX = e.pageX;
	      mouseY = e.pageY - $(document).scrollTop();
	      $('#mousehelp').css("display", 'block').css("left", mouseX+23).css("top", mouseY+10);
	});
	
	$('#editorDiv .cntContextSGC0000027').mouseleave(function(e) {
	      $('#mousehelp').css("display", 'none');
	});
 }
 
/* moo0506 단순 텍스트 변경 활성화 */
function writeContentTxt(){
	 $('.edtFormTxt').css('border', 'dashed 1px #3899ec');
	 $('.edtFormTxt').attr('contenteditable', 'true');
}

/* moo0506 단순 텍스트 변경 비활성화*/
function removeContentTxt(){
	$('.edtFormTxt').removeAttr('contenteditable');
	$('.edtFormTxt').css('border', '');
}

/* moo0506 단순 텍스트 변경 활성/비활성 토글 */
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
	if(confirm('<spring:message code="wzwg.cmm.msg.MSG285" />')){
	try{templateSave()}catch(e){console.log(e.message);} // 템플릿 index 내에서 관리자 화면에서만 종료시켜야 하는 스크립트 없을수도 있어서 try 처리
	
	removeContentTxt();
	contentsSortableDestroy();
//	 $(".axebox").html("");
	$('.add_div').remove();  /* moo0506 레이아웃 영역 [클릭하세요...] 내용 삭제*/
	 $(".axebox").remove();  /* moo0506 삭제버튼은 editFunc.js 파일의 contentsSortable() 에서 추가되기 때문에 삭제*/
	 $(".axeboxboot").html("");
	 $(".sortWrapAll").children().unwrap();
	$("#top").removeClass("selected");   
	//$("#top").resizable( "destroy" );
	//$("#top").draggable();
	//$("#top").draggable("destroy"); 
	//$("#top").contextMenu("destroy");
	//$("#content").resizable( "destroy" );
	//$("#content").draggable();
	//$("#content").draggable("destroy"); 
	//$("#content").contextMenu("destroy");
	
	$("#footer").removeClass("selected");   
	//$("#footer").resizable( "destroy" );
	//$("#footer").draggable();
	//$("#footer").draggable("destroy"); 
	//$("#footer").contextMenu("destroy");
	 

	

	$("#content").wrap("<div id='contentsWrap'>");
	$("#contents").val($("#contentsWrap").html()); 
	$("#top").wrap("<div id='topMenu'>");
	$("#footer").wrap("<div id='footerWrap'>");
	$("#topContents").val($("#topMenu").html()); 
	$("#footerContents").val($("#footerWrap").html());  
	$("#topMenuSe").val($("#topMenuSeGb").val());
	document.frmSave.action="/mngr/screen/siteScreenSave.do";
	document.frmSave.submit();
	}
}

function getTempLoad(){
	$("#tempYn").val('Y');
	
	document.frmSave.action="<c:out value="${wzwg_contextPath}"/>/mngr/screen/selectSiteScreenIndexMngr.do";
	document.frmSave.submit();
}

function getTempSave(){ 
	if(confirm('<spring:message code="wzwg.cmm.msg.MSG286" />')){
	
	try{templateSave()}catch(e){console.log(e.message);} // 템플릿 index 내에서 관리자 화면에서만 종료시켜야 하는 스크립트 없을수도 있어서 try 처리
	
	removeContentTxt();
	contentsSortableDestroy();
	$('.add_div').remove();  /* moo0506 레이아웃 영역 [클릭하세요...] 내용 삭제*/
	$(".axebox").remove();  /* moo0506 삭제버튼은 editFunc.js 파일의 contentsSortable() 에서 추가되기 때문에 삭제*/
	 $(".axeboxboot").html("");
	 $(".sortWrapAll").children().unwrap();
	$("#top").removeClass("selected");   
	//$("#top").resizable( "destroy" );
	//$("#top").draggable();
	//$("#top").draggable("destroy"); 
	//$("#top").contextMenu("destroy");
	//$("#content").resizable( "destroy" );
	//$("#content").draggable();
	//$("#content").draggable("destroy"); 
	//$("#content").contextMenu("destroy");
	
	$("#footer").removeClass("selected");   
	//$("#footer").resizable( "destroy" );
	//$("#footer").draggable();
	//$("#footer").draggable("destroy"); 
	//$("#footer").contextMenu("destroy");
	 

	

	$("#content").wrap("<div id='contentsWrap'>");
	$("#contents").val($("#contentsWrap").html()); 
	$("#top").wrap("<div id='topMenu'>");
	$("#footer").wrap("<div id='footerWrap'>");
	$("#topContents").val($("#topMenu").html()); 
	$("#footerContents").val($("#footerWrap").html());  
	$("#topMenuSe").val($("#topMenuSeGb").val());
	$("#tempYn").val('Y');
	
	document.frmSave.action="<c:out value="${wzwg_contextPath}"/>/mngr/screen/siteScreenTempIndexSave.do";
	document.frmSave.submit();
	}
}

function footerFtrMenuParsing(lgnAt) {

	  var startMenuLv = 1;
	  var stopMenuLv = 2;
	  $('.ftrmenu').each(function (index, parentEle) {
	      $.ajax({
	          type:'POST'
	        , url:'<c:out value="${wzwg_contextPath}"/>/menu/siteHdftrMenuJsonAjax.do?hdftrCode=SC00000082&lgnAt='+lgnAt
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

function changeTopMenu(topMenuNum){
	var dummy = parseInt(Math.random()*1000); // 템플릿마다 파일명이 같아서 캐시가 남는 문제 해결을 위한 핵
	var topMenuStr = "headmenu0"+topMenuNum+".css" +"?dummy=" + dummy ;
	 var tempDir = $("#headmenu").attr("href").substring(0,$("#headmenu").attr("href").lastIndexOf("/")+1);
	 $("#headmenu").attr("href",tempDir+topMenuStr);
	 $("#headmenu").attr("data-menu-seq",topMenuNum);
	 /* try{$('#menuCssSeq').val(topMenuNum);}catch(e){console.log(e.message);} */
}

function topMenuParsing() {

	 $('a').each(function () {
	   	 if($(this).attr("href").indexOf("/subList") >-1){
	   		$(this).attr('href','/mngr/screen'+$(this).attr("href"));
	   	 }
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

<!-- moo0506 템플릿 index 파일 내에서 관리자 모드에서만 실행되어야 하는 준비 스크립트 -->
<script>
$(document).ready(function(){
	try{
		templateReady();
	}catch(e){console.log(e.message);}//없음 말고
});
</script>

<!-- moo0506 디자인 컨트롤 패널 스크립트 -->
<script>
function dgnCtlPannelToggle(){
	$('#dgnCtlLeft').toggle(0,function(){
		if($(this).css('display') == 'none'){
			$('#dgnCtlPannel').css('width', '45px');
			$('#dgnCtlToggleBtn').html('&#171');
		}else{
			$('#dgnCtlPannel').css('width', '98%');
			$('#dgnCtlToggleBtn').html('&#187');
		}
	});
}
</script>

</head>
<body>

	<!--
  <a href="javascript:;" onclick="addTxt();">텍스트추가하기</a>
  <a href="javascript:;" onclick="addImg();">이미지추가하기</a>
  
  <a href="javascript:;" class="ui-button ui-widget ui-corner-all" onclick="getSource();"><spring:message code="wzwg.cmm.word.preview" /></a>
  <a href="javascript:;" class="ui-button ui-widget ui-corner-all" onclick="setEdit();">편집모드</a>
  -->
  	<div style="display: none;">
		<a href="javascript:;" class="ui-button ui-widget ui-corner-all"
			onclick="getSave();"><spring:message code="wzwg.cmm.word.applc" /></a>
			<a href="javascript:;" class="ui-button ui-widget ui-corner-all"
			onclick="getTempSave();"><spring:message code="wzwg.cmm.word.temsve" text="temporary save" /></a> 
			<a href="javascript:;" class="ui-button ui-widget ui-corner-all"
			onclick="getTempLoad();"><spring:message code="wzwg.site.screen.msg.MSG037" /></a> <spring:message code="wzwg.cmm.word.import02" /> :
		<select id="backupFile" name="backupFile"
			onchange="fnChangeBackup(this.value)">
			<option value=""><spring:message code="wzwg.site.screen.msg.MSG034" /></option>
			<c:forEach items="${backupIndexList}" var="files" varStatus="status">
				<option value="<c:out value="${files.tmpbakupSeq}"/>"
					<c:if test="${files.tmpbakupSeq eq paramVO.backup}">selected="true"</c:if>><c:out value="${files.backupNm}"/></option>
			</c:forEach>
		</select>
	</div>
	<div class="adminTopText" style="line-height: 30px; background: #f1f1f1; text-align: center; border-bottom: solid 1px #999;">
		<div>
			<h4 style="font-weight: 100; display:inline-block;"> <spring:message code="wzwg.site.screen.msg.MSG038" /></h4>
			<a href="/" class="ui-button ui-widget ui-corner-all" target="_blank" style="margin-left: 10px;"><spring:message code="wzwg.site.screen.msg.MSG039" /></a>
		</div>
	</div>
	<div id="editorDiv" class="editor" style="z-index: 0;">
		<c:import url="${url}"></c:import>
	</div>

	<form name="frmSave" id="frmSave" method="post">
		<input type="hidden" id="contents" name="contents" /> <input
			type="hidden" id="topContents" name="topContents" /> <input
			type="hidden" id="footerContents" name="footerContents" /> <input
			type="hidden" id="backup" name="backup" value="<c:out value="${siteScreenVO.backup }"/>"/> 
			<input type="hidden"	id="topMenuSe" name="topMenuSe" />
			<input type="hidden" id="tempYn" name="tempYn" />
	</form>
	<div id="imgDiv"></div>


	<div id="imgLinkDiv" title="<spring:message code="wzwg.site.screen.msg.MSG035" />" style="z-index: 999;">
		<p>
			<input type="text" name="imgLink" id="imgLink" />
		</p>
		<a href="javascript:;" class="ui-button ui-widget ui-corner-all"
			onclick="addImg($('#imgLink').val());"><spring:message code="wzwg.cmm.word.stre" /></a>
	</div>

	<div id="imgLinkSilderDiv" title="<spring:message code="wzwg.site.screen.msg.MSG035" />" style="z-index: 999;">
		<p>
			<input type="text" name="imgLinkSilder" id="imgLinkSilder" />
		</p>
		<a href="javascript:;" class="ui-button ui-widget ui-corner-all"
			onclick="addImgSilder($('#imgLinkSilder').val(),selectDiv);"><spring:message code="wzwg.cmm.word.stre" /></a>
	</div>


	<div id="imgLinkUrlDiv" title="<spring:message code="wzwg.site.screen.msg.MSG190"/>" style="z-index: 999;">
		<p>
			<input type="text" name="imgLinkUrl" id=imgLinkUrl />
		</p>
		target :<select id="imgLinkTarget" name="imgLinkTarget">
			<option value="_self"><spring:message code="wzwg.cmm.word.nowwin" /></option>
			<option value="_blank"><spring:message code="wzwg.cmm.word.newwin" /></option>
		</select> <a href="javascript:;" class="ui-button ui-widget ui-corner-all"
			onclick="addImgLink($('#imgLinkUrl').val(),$('#imgLinkTarget').val());"><spring:message code="wzwg.cmm.word.stre" /></a>
	</div>

	<div id="pickerDiv" title="<spring:message code="wzwg.cmm.word.scrin.colTable" />" style="z-index: 999;">
		<div id="picker"></div>
	</div>
	<div id="pickerBorderDiv" title="<spring:message code="wzwg.cmm.word.scrin.colTable" />" style="z-index: 999;">
		<p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG040" />(<spring:message code="wzwg.site.screen.msg.MSG041" />)</p>
		<ul class="ul_font">
			<li><input type="radio" name="font_color" value=""
				id="font_color" onclick="addFontColor(fontPickerColor)"><span
				class="colorbox colorffffff fontCurrColor"><div 
				class="colorbox colorffffff fontCurrColor"></div><spring:message code="wzwg.site.screen.msg.MSG042" /></span></li>
			<li><input type="radio" name="font_color" value="#333333"
				id="font_color" onclick="addFontColor(this.value)"><span
				class="color333333"><div class="colorbox color333333">
					</div><spring:message code="wzwg.cmm.word.blackclr" /></span></li>
			<li><input type="radio" name="font_color" value="#ffffff"
				id="font_color" onclick="addFontColor(this.value)"><span
				class="color333333"><div class="colorbox colorffffff">
					</div><spring:message code="wzwg.cmm.word.whiteclr" /></span></li>

			<li><input type="radio" name="font_color" value="#a1a1a1"
				id="font_color" onclick="addFontColor(this.value)"><span
				class="colora1a1a1"><div class="colorbox colora1a1a1">
					</div>#a1a1a1 </span></li>
			<li><input type="radio" name="font_color" value="#0b56a7"
				id="font_color" onclick="addFontColor(this.value)"><span
				class="color0b56a7"><div class="colorbox color0b56a7">
					</div>#0b56a7 </span></li>


			<li><input type="radio" name="font_color" value="#3fb2bf"
				id="font_color" onclick="addFontColor(this.value)"><span
				class="color3fb2bf"><div class="colorbox color3fb2bf">
					</div>#3fb2bf </span></li>

			<li><input type="radio" name="font_color" value="#efc127"
				id="font_color" onclick="addFontColor(this.value)"><span
				class="colorefc127"><div class="colorbox colorefc127">
					</div>#efc127 </span></li>
			<li><input type="radio" name="font_color" value="#c80000"
				id="font_color" onclick="addFontColor(this.value)"><span
				class="colorc80000"><div class="colorbox colorc80000">
					</div>#c80000 </span></li>
		</ul>


		<!-- 자유롭게 색상 선택하기 링크버튼 -->
		<a href="javascript:;" onclick="changeColor()"><span
			class="choice_btn"><spring:message code="wzwg.cmm.msg.MSG258" /></span></a>
	</div>

	<div id="pickerBgDiv" title="<spring:message code="wzwg.cmm.word.scrin.colTable" />" style="z-index: 999;">
		<p class="bg_reco"><spring:message code="wzwg.site.screen.msg.MSG036" />(<spring:message code="wzwg.site.screen.msg.MSG041" />)</p>
		<ul class="ul_bg" style="width: 98%;">
			<li class="colorffffff bgCurrColor"><input type="radio"
				name="bg_color" value="" id="ffffff"
				onclick="addBgColor(bgPickerColor)"><span title="ffffff"><spring:message code="wzwg.site.screen.msg.MSG042" /></span></li>
			<li class="colorffffff"><input type="radio" name="bg_color"
				value="#ffffff" id="ffffff" onclick="addBgColor(this.value)"><span
				title="ffffff"><spring:message code="wzwg.cmm.word.whiteclr" /></span></li>
			<li class="colorblack fontwhite"><input type="radio"
				name="bg_color" value="#333333" id="333333"
				onclick="addBgColor(this.value)"><span title="333333"><spring:message code="wzwg.cmm.word.blackclr" /></span></li>
		</ul>


		<ul class="ul_bg">
			<li class="colore6e9ee"><input type="radio" name="bg_color"
				value="#e6e9ee" id="e6e9ee" onclick="addBgColor(this.value)"><span
				title="e6e9ee">#e6e9ee </span></li>
			<li class="colord7ecef"><input type="radio" name="bg_color"
				value="#d7ecef" id="d7ecef" onclick="addBgColor(this.value)"><span
				title="d7ecef">#d7ecef </span></li>
			<li class="color74c2d6"><input type="radio" name="bg_color"
				value="#74c2d6" id="74c2d6" onclick="addBgColor(this.value)"><span
				title="74c2d6">#74c2d6 </span></li>
			<li class="color35b0b8"><input type="radio" name="bg_color"
				value="#35b0b8" id="35b0b8" onclick="addBgColor(this.value)"><span
				title="35b0b8">#35b0b8 </span></li>
			<li class="color649d32"><input type="radio" name="bg_color"
				value="#649d32" id="649d32" onclick="addBgColor(this.value)"><span
				title="649d32">#649d32 </span></li>
		</ul>

		<ul class="ul_bg">
			<li class="colore9e7eb"><input type="radio" name="bg_color"
				value="#e9e7eb" id="e9e7eb" onclick="addBgColor(this.value)"><span
				title="e9e7eb">#e9e7eb </span></li>
			<li class="colorbec9cc"><input type="radio" name="bg_color"
				value="#bec9cc" id="bec9cc" onclick="addBgColor(this.value)"><span 
				title="bec9cc">#bec9cc </span></li>
			<li class="coloraab69e"><input type="radio" name="bg_color"
				value="#aab69e" id="aab69e" onclick="addBgColor(this.value)"><span
				title="aab69e">#aab69e </span></li>
			<li class="color848b99"><input type="radio" name="bg_color"
				value="#848b99" id="848b99" onclick="addBgColor(this.value)"><span
				title="848b99">#848b99 </span></li>
			<li class="color435c6d fontwhite"><input type="radio"
				name="bg_color" value="#435c6d" id="435c6d"
				onclick="addBgColor(this.value)"><span title="d7ecef">#435c6d
			</span></li>
		</ul>

		<ul class="ul_bg">
			<li class="colorf3f6fb"><input type="radio" name="bg_color"
				value="#f3f6fb" id="f3f6fb" onclick="addBgColor(this.value)"><span
				title="f3f6fb">#f3f6fb </span></li>
			<li class="colore6eef1"><input type="radio" name="bg_color"
				value="#e6eef1" id="e6eef1" onclick="addBgColor(this.value)"><span
				title="e6eef1">#e6eef1 </span></li>
			<li class="colorc8dae4"><input type="radio" name="bg_color"
				value="#c8dae4" id="c8dae4" onclick="addBgColor(this.value)"><span
				title="c8dae4">#c8dae4 </span></li>
			<li class="color74b4d8"><input type="radio" name="bg_color"
				value="#74b4d8" id="74b4d8" onclick="addBgColor(this.value)"><span
				title="74b4d8">#74b4d8 </span></li>
			<li class="color0ea8eb"><input type="radio" name="bg_color"
				value="#0ea8eb" id="0ea8eb" onclick="addBgColor(this.value)"><span
				title="0ea8eb">#0ea8eb </span></li>
			<li class="color0a58a3 fontwhite"><input type="radio"
				name="bg_color" value="#0a58a3" id="0a58a3"
				onclick="addBgColor(this.value)"><span title="0a58a3">#0a58a3
			</span></li>
			<li class="color385a73 fontwhite"><input type="radio"
				name="bg_color" value="#385a73" id="385a73"
				onclick="addBgColor(this.value)"><span title="385a73">#385a73
			</span></li>
		</ul>

		<ul class="ul_bg">
			<li class="colorf4f4f4"><input type="radio" name="bg_color"
				value="#f4f4f4" id="f4f4f4" onclick="addBgColor(this.value)"><span
				title="f4f4f4">#f4f4f4 </span></li>
			<li class="colorece9e7"><input type="radio" name="bg_color"
				value="#ece9e7" id="ece9e7" onclick="addBgColor(this.value)"><span
				title="ece9e7">#ece9e7 </span></li>
			<li class="colorf0eada"><input type="radio" name="bg_color"
				value="#f0eada" id="f0eada" onclick="addBgColor(this.value)"><span
				title="f0eada">#f0eada </span></li>
			<li class="colore9bb43"><input type="radio" name="bg_color"
				value="#e9bb43" id="e9bb43" onclick="addBgColor(this.value)"><span
				title="a1a1a1">#e9bb43 </span></li>
			<li class="colorcd8902"><input type="radio" name="bg_color"
				value="#cd8902" id="cd8902" onclick="addBgColor(this.value)"><span
				title="cd8902">#cd8902 </span></li>
			<li class="color424348 fontwhite"><input type="radio"
				name="bg_color" value="#424348" id="424348"
				onclick="addBgColor(this.value)"><span title="424348">#424348</span></li>
			<li class="color333333 fontwhite"><input type="radio"
				name="bg_color" value="#333333" id="333333"
				onclick="addBgColor(this.value)"><span title="333333">#333333</span></li>
		</ul>



		<!-- 자유롭게 색상 선택하기 링크버튼 -->
		<a href="javascript:;" onclick="changeBgColor()"><span
			class="choice_btn"><spring:message code="wzwg.cmm.msg.MSG258" /></span></a>
	</div>
	<div id="pickerFontDiv" title="<spring:message code="wzwg.cmm.word.scrin.colTable" />" style="z-index: 999;">
		<div id="pickerFont"></div>
	</div>

	<div id="pickerBgTotDiv" title="<spring:message code="wzwg.cmm.word.scrin.colTable" />" style="z-index: 999;">
		<div id="pickerBgTot"></div>
	</div>

	<div id="divSampleList" title="<spring:message code="wzwg.cmm.word.list"/>" style="z-index: 999;"></div>

	<div id="sizeDiv" title="<spring:message code="wzwg.site.screen.msg.MSG188"/>" style="z-index: 999;">
		<p>
			top : <input type="text" name="sTop" id="sTop" style="width: 100px;" />
		</p>
		<p>
			left : <input type="text" name="sLeft" id="sLeft"
				style="width: 100px;" />
		</p>
		<p>
			width : <input type="text" name="sWidth" id="sWidth"
				style="width: 100px;" />
		</p>
		<p>
			height: <input type="text" name="sHeight" id="sHeight"
				style="width: 100px;" />
		</p>
		<a href="javascript:;" class="ui-button ui-widget ui-corner-all"
			onclick="setDivSize(selectDiv);"><spring:message code="wzwg.cmm.word.stre" /></a>
	</div>

	<div id="txtBannerDiv" title="<spring:message code="wzwg.site.screen.msg.MSG189"/>" style="z-index: 999;">
		<p>
			<input type="text" name="txtBanner" id="txtBanner" />
		</p>
		<a href="javascript:;" class="ui-button ui-widget ui-corner-all"
			onclick="addBannerTxt($('#txtBanner').val());"><spring:message code="wzwg.cmm.word.stre" /></a>
	</div>

	<div id="bannerLinkUrlDiv" title="<spring:message code="wzwg.site.screen.msg.MSG186"/>" style="z-index: 999;">
		<p>
			<input type="text" name="bannerLinkUrl" id=bannerLinkUrl />
		</p>
		target :<select id="bannerLinkTarget" name="bannerLinkTarget">
			<option value="_self"><spring:message code="wzwg.cmm.word.nowwin" /></option>
			<option value="_blank"><spring:message code="wzwg.cmm.word.newwin" /></option>
		</select> <a href="javascript:;" class="ui-button ui-widget ui-corner-all"
			onclick="addBannerLink($('#bannerLinkUrl').val(),$('#bannerLinkTarget').val());"><spring:message code="wzwg.cmm.word.stre" /></a>
	</div>
	
	<div class="dgnCtlPannel" id="dgnCtlPannel">
		<div style="position: relative;" >
			<div style="float: left; width: 100%;" id="dgnCtlLeft">
					<a href="javascript:;" class="ui-button ui-widget ui-corner-all"
			onclick="getTempSave();"><spring:message code="wzwg.cmm.word.temsve" text="temporary save" /></a> 
			<a href="javascript:;" class="ui-button ui-widget ui-corner-all"
			onclick="getTempLoad();"><spring:message code="wzwg.site.screen.msg.MSG037" /></a><spring:message code="wzwg.cmm.word.import02" /> :
				<select id="backupFile" name="backupFile" class="ui-button ui-widget ui-corner-all"
					onchange="fnChangeBackup(this.value)">
					<option value=""><spring:message code="wzwg.site.screen.msg.MSG034" /></option>
					<c:forEach items="${backupIndexList}" var="files" varStatus="status">
					<option value="<c:out value="${files.tmpbakupSeq}"/>"
						<c:if test="${files.tmpbakupSeq eq paramVO.backup}">selected="true"</c:if>><c:out value="${files.backupNm}"/></option>
				</c:forEach>
				</select>
				<a href="<c:out value="${wzwg_contextPath}"/>/mngr/temp/index.do" class="ui-button ui-widget ui-corner-all" target="_blank" style="background: #a5d2af;"><spring:message code="wzwg.site.screen.msg.MSG043" /></a>
				
				<div style="float: right; margin-right: 45px;">
					<select id="topMenuSeGb" name="topMenuSe" class="ui-button ui-widget ui-corner-all"
						onchange="changeTopMenu(this.value);">
						<option value="0"><spring:message code="wzwg.site.screen.msg.MSG044" /></option>
						<option value="1">Template_menu1</option>
						<option value="2">Template_menu2</option>
					</select>
					<!-- 
				<a href="javascript:;" class="ui-button ui-widget ui-corner-all" onclick="addQuickBanner();">퀵메뉴변경</a>
			  
					<a href="javascript:;" class="ui-button ui-widget ui-corner-all"
						onclick="addContentsLayout();">컨텐츠추가</a>
				 -->	
					<a href="javascript:;" class="ui-button ui-widget ui-corner-all"
						onclick="addLayout();"><spring:message code="wzwg.site.screen.msg.MSG045" /></a>
						<a href="javascript:;" class="ui-button ui-widget ui-corner-all" style="background: #e02f2f; color: #fff;"
					onclick="getSave();"><spring:message code="wzwg.cmm.word.apply" /></a>
				</div>
			</div>
			
			<div style="position: absolute; right: 5px;">
				<span><button type="button" class="ui-button ui-widget ui-corner-all" onclick="dgnCtlPannelToggle()" id="dgnCtlToggleBtn" style="background: #000580; color:#fff;">&#187;</button></span>
			</div>
		</div>
	</div>
	
	
	<form name="frmLayout" id="frmLayout" method="post">
		<input type="hidden" id="templateSeq" name="templateSeq"
			value="<c:out value="${siteTemplateScreenVO.templateSeq}"/>" />
	</form>
	
	<!-- 레이어팝업 영역 Start -->
	<div id="divLayerPopup" class="modal fade in" style="z-index: 99;"></div>
	<!-- 레이어팝업 영역 End -->
	
	<div id="mousehelp" style="position:fixed; display:none;"><spring:message code="wzwg.cmm.msg.MSG287" /></div>
	
</body>
</html>
