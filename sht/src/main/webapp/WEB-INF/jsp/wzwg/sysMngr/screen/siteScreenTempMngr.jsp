<%@page import="java.net.InetAddress"%>
<%@page import="java.net.NetworkInterface"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp"%>
<%
String isResource = "false";
Enumeration e = NetworkInterface.getNetworkInterfaces();
while(e.hasMoreElements())
{
    NetworkInterface n = (NetworkInterface) e.nextElement();
    Enumeration ee = n.getInetAddresses();
    while (ee.hasMoreElements())
    {
        InetAddress i = (InetAddress) ee.nextElement();
        //out.println(i.getHostAddress() + "<br>");
        if(i.getHostAddress().equals("192.168.42.177")){
        	isResource = "true";
        }
    }
}

request.setAttribute("isResource", isResource);
%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title><spring:message code="wzwg.sysMngr.word.sysmngr/templatEdit"/></title>
	<link rel="stylesheet" href="/css/wzwg/cmm/jquery-ui.css">
	<script src="/js/wzwg/cmm/jquery-latest.min.js"></script>
	<script src="/js/wzwg/cmm/jquery-ui.js"></script>
	
	<!-- 위즈위그 메시지 로드 -->
  	<script type="text/javascript" language="JavaScript"  src="/js/wzwg/cmm/jquery.i18n.properties-min-1.0.9.js"></script>
  	<script type="text/javascript" language="JavaScript"  src="/js/wzwg/site/wzwgMessage.js"></script>
	<script>
	jQuery(document).ready(function() {
		onloadWzwgMsg("<c:out value="${sessionScope.langCode}" />");
	});
	</script>
	
	<link rel="stylesheet" href="/smartEditorCustom/css/font-awesome.css" type="text/css" />
	<link href="/css/wzwg/cmm/jquery.contextMenu.css" rel="stylesheet"
		type="text/css" />
	<script src="/js/wzwg/cmm/jquery.contextMenu.js" type="text/javascript"></script>
	<script src="/js/wzwg/cmm/jquery.ui.position.min.js"
		type="text/javascript"></script>
	<!-- <script src="/js/wzwg/site/editMode.js" type="text/javascript"></script>
	<script src="/js/wzwg/site/editMode_wzwg.js" type="text/javascript"></script> -->
	
	<link rel="stylesheet" type="text/css" media="screen" href="/css/wzwg/cmm/0028_farbtastic.css" />
	<script type="text/javascript" charset="utf-8" src="/js/wzwg/cmm/0028_farbtastic.js"></script>
	
	
	<script src="/js/wzwg/site/editFunc.js" type="text/javascript"></script>
	<!-- <script src="/js/wzwg/site/wzwgContextMenu.js" type="text/javascript"></script> -->
	
	<script src="/design/module/sample/js/swiper.jquery.min.js"></script>
	<link rel="stylesheet" href="/js/wzwg/cmm/slick/slick.css" type="text/css" />
	<script src="/js/wzwg/cmm/slick/slick.js"></script> 
	
		
	<link rel="stylesheet" href="/css/wzwg/site/mngr/screenMngr.css" type="text/css">
	
	<script src="/js/wzwg/cmm/html2canvas.js" type="text/javascript"></script>
	 <script src="/js/wzwg/cmm/jquery.form.min.js"></script> 
	
	<c:import url="/WEB-INF/jsp/wzwg/webModule/wzwgContextMenu.jsp"></c:import>
	
	<!-- 위디자인 -->
	<link rel="stylesheet" href="/widesign/widesigncore.css" type="text/css" />
	<script type="text/javascript" src="/widesign/widesign.js"></script>
	
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
	       , url:'<c:out value="${wzwg_contextPath}" />/module/scrin/module/selectSampleList.do?mode=1'
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
	       , url:'<c:out value="${wzwg_contextPath}" />/module/scrin/module/selectSampleList.do?mode='+mode
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
	
	 var firstNttMenuSeq = '<c:out value="${firstNttMenuSeq.menuSeq}" />';
	 function fnDivJsonDataRead(callback){
		    $('.cntContextSGC0000027').each(function (index, parentEle) {
		        var cntseq = $(this).data('cntseq');
		        if(cntseq == ''){
		        	cntseq = firstNttMenuSeq;
		        	 $(this).data('cntseq',cntseq);
		        }
		        
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
	                "txtEdit": {name: "<spring:message code="wzwg.sysMngr.word.txtUpdt" />", icon: "edit"},
	                "copy": {name: "<spring:message code="wzwg.sysMngr.word.relmCopy" />", icon: "copy"},
	                "size": {name: "<spring:message code="wzwg.cmm.word.size" /> <spring:message code="wzwg.cmm.word.and" /> <spring:message code="wzwg.cmm.word.lc" />", icon: "edit"}, 
	                /**
	                "zindex":{
		           		 name:"<spring:message code="wzwg.cmm.word.array" />", icon : "edit",
		           		 items:{
		       				 "maxZindex": {name: "<spring:message code="wzwg.cmm.msg.MSG307" />", icon: "edit"},
		       				 "minZindex": {name: "<spring:message code="wzwg.cmm.msg.MSG308" />", icon: "edit"}
		       			}
	       		   },
	       		   **/
					"txtEditEnd": {name: "<spring:message code="wzwg.sysMngr.word.txtUpdtCompt" />", icon: "edit",disabled:true},
					"delete": {name: "<spring:message code="wzwg.sysMngr.word.relmDelete" />", icon: "trash"},
					"background": {name: "<spring:message code="wzwg.sysMngr.word.bcrnColor" />", icon: "edit"},
			         "border-color": {name: "<spring:message code="wzwg.sysMngr.word.borrColor" />", icon: "edit"},
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
				, url : '<c:out value="${wzwg_contextPath}" />/module/upload/image/imageForm.do?mode='+mode
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
				 , url:'<c:out value="${wzwg_contextPath}" />/mngr/screen/selectSiteLayoutTempltAjax.do'
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
				 , url:'<c:out value="${wzwg_contextPath}" />/mngr/screen/selectSiteLayoutAjax.do'
				 , data:$("#frmLayout").serialize()
				 , success:function (data) { 
				 		wzAjaxModal('popup_l', '<spring:message code="wzwg.sysMngr.word.layoutAdd02" />', data);
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
			 , url:'<c:out value="${wzwg_contextPath}" />/mngr/screen/selectLayoutContentsPopupAjax.do'
			 , cache : false
			 , async : false
			 , processData: false
			 , contentType: false
			 , data : form
			 , success:function (data) { 
			 		wzAjaxModal('popup_l', '<spring:message code="wzwg.sysMngr.word.cntntsAdd02" />', data);
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
	
	/* moo0506 레이아웃 영역에 컨텐츠 추가*/
	function addLayoutContents(_html, _css, _cssId, _cssNm){
		
		 //와이드30 템플릿때문에 추가 (mainVisual00 영역은 슬라이드 영역이여서 슬라이드는 추가못하도록 수정)
		 if($('.addLayoutContentsZone').parents('#mainVisual00').length > 0 ){
			 if(_html.indexOf('slide') > -1 || _cssNm.indexOf('슬라이드') > -1) {
				 alert('<spring:message code="wzwg.cmm.msg.screen.MSG084" />');
				 return;
			 }
		 }
		
		 $('#tmpReciveContents').html('');
		 
		 if($('#' + _cssId).length == 0){
			 $('#content').append('<link rel="stylesheet" href="' + _css + '" type="text/css" id="' + _cssId + '"/>' );
		 }
		 
		 $('.addLayoutContentsZone').find('.add_div').remove();
		 
		 var contents = $('<div/>');
		 contents.load(_html + '?ran=' + Math.random(), function(){
			 //console.log($(this).html());
			 var htmlContents = $(this).html();
			 
			 $('.addLayoutContentsZone').append(htmlContents);
			 
			 $('.addLayoutContentsZone').children().each(function(){
				 if($(this).is('script') == false){
					 var cssId = _cssId.replace('CSS_', '');
					 
					 $(this).addClass('wzwgWidget').attr('data-id', cssId).attr('data-nm', _cssNm);
					 return;//$.each()만 빠져나감
				 }
			 });
	
			 //wzwgSwiper();
			 var findSwiper = $('.addLayoutContentsZone').find('.wzwg-swiper');
			 //console.log(findSwiper.length);
			 
			 if(findSwiper.length == 1){
				swiperPlay(findSwiper);
			 }
			 
			 var findSwiperBanner = $('.addLayoutContentsZone').find('.wzwg-banner-swiper');
			 //console.log(findSwiper.length);
			 
			 if(findSwiperBanner.length == 1){
				 swiperBannerPlay(findSwiperBanner);
			 }
			 
			 var findSlide = $('.addLayoutContentsZone').find('.wzwg-slide-info');
			 //console.log(findSwiper.length);
			 
			 if(findSlide.length == 1){
				 playSlideSlick(findSlide);
			 }
			 
			 var findBannerSlide = $('.addLayoutContentsZone').find('.wzwg-banner-slide-info');
			 //console.log(findSwiper.length);
			 
			 if(findBannerSlide.length == 1){
				 playBannerSlideSlick(findBannerSlide);
			 }
			 
			//퀵메뉴 높이별로 최대 퀵메뉴추가 개수가 다를때 데이터 정리
			 var findQuick = $('.addLayoutContentsZone').find('.quickBannerConfZone');
			 
			 if($(findQuick).attr('data-maxuseat') == 'Y') {
				 var dataH = $('.addLayoutContentsZone').attr('data-h');
				 var dataW = $('.addLayoutContentsZone').attr('data-w');
				 
				 var quickCnt = $(findQuick).find('.quickBannerZone').children().size();
				 
				 if(dataW == '100') {
					 var wItemCnt = parseInt($(findQuick).attr('data-wmaxitem'));
					 
					 if(quickCnt != wItemCnt) {
						 for(var i=quickCnt-1; i >= wItemCnt; i--) {
							 $(findQuick).find('.quickBannerZone').children()[i].remove();
						 }
					 }
				 }else {
					 var itemCnt = parseInt($(findQuick).attr('data-'+dataH+'maxitem'));
					 
					 if(quickCnt != itemCnt) {
						 for(var i=quickCnt-1; i >= itemCnt; i--) {
							 $(findQuick).find('.quickBannerZone').children()[i].remove();
						 }
					 }
				 }
			 }
			 
			 //탭게시판 반응형 셀렉트박스 스크립트
			 $('.addLayoutContentsZone').find('.wzwg-resp-tab').each(function(){
				 
				 responsiveTabActive($(this));
			 });
			 
			 editInit();
			 
			 alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.word.cntnts" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.add" /></spring:argument></spring:message>');
			 wzModalClose();
		 	 wzwgCMSelectorInit();
		 	 
			 /* if($(".wzwg-swiper").size() >0){
		 	 	wzwgSwiperCall();
		 	 } */ 
		 });
	 
	
	}
	 
	 function addContentsTxt(){
			$.ajax({
				   type:'POST'
				 , url:'<c:out value="${wzwg_contextPath}" />/mngr/screen/siteTxtContentsInfoAjax.do'
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
				 , url:'<c:out value="${wzwg_contextPath}" />/mngr/screen/selectSiteScreenTempltHeadmenuAjax.do'
				 , data:$("#frmLayout").serialize()
				 , success:function (data) { 
				 		var title = '<spring:message code="wzwg.sysMngr.word.headMenuTochange" />'
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
	 
	  function fnNewTemplatePopup(){
			$.ajax({
				   type:'POST'
				 , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/screen/selectSiteScreenNewTempltSaveFormAjax.do'
				 , data:$("#frmLayout").serialize()
				 , success:function (data) {
					 wzAjaxModal('popup_l', '<spring:message code="wzwg.cmm.msg.MSG283" />', data);
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
			$(".hide").click(function(){
				$(".pop-box").hide();
			});
			
			//로그인 시간 유지 스크립트
			<c:if test="${not empty sessintvl and sessintvl ne '0'  }">
			fnLoginTimeCheck();
			</c:if>
			
		});
	 
	 	var sessionInterval = parseInt('<c:out value="${sessintvl}" />');
		var lognPopupTime = 30;//로그인 연장 시간
		var lognPopupCheck = false;
		function fnLoginTimeCheck(){
			
			setInterval(function() {  
				--sessionInterval;
				//var t = fnLoginTimerCalc();
				//console.log(sessionInterval + " : " + lognPopupTime);
				//$('#sessionTimer').html(t);
				if(sessionInterval < lognPopupTime){
					fnAddSessionTime();
				}
			}, 1000);
			
		}
		
		function fnLoginTimerCalc(){
			var m = Math.floor(sessionInterval / 60);
			m = m < 10 ? '0'+m : m;
			var s = sessionInterval % 60;
			s = s < 10 ? '0'+s : s;
			//console.log(m + ':' + s);
			//$('.lognTimer').html(m + ':' + s);
			return m + ':' + s;
		}
		
		function fnAddSessionTime(){
			$.ajax({
	         type:'POST'
	         , url:'<c:out value="${wzwg_contextPath}" />/cmm/code/selectSessionIntervalAjax.do'
	         /* , data:$("#usrTyModifyForm").serialize() */
	         ,success:function (data){
	             //console.log(data.body.sessionInterval);
	             //console.log(data.head.result);
	             if(data.body.sessionInterval == 0){
	             	//console.log('여기도 안옴?');
	             	//$('.sessIntvl').hide();//?뭔가이상한데
	             }else{
	             	//console.log('여기안옴?');
	             	sessionInterval = parseInt(data.body.sessionInterval);
	             	try{parent.sessionInterval = parseInt(data.body.sessionInterval);}catch(e){console.log(e.message);}
                	try{opener.fnLoginSetInterval(parseInt(data.body.sessionInterval));}catch(e){console.log(e.message);}
	             	lognPopupCheck = false;
	             	var option={'timeOut' : 5000, 'timerUseAt' : false}
	             	wzToast('<spring:message code="wzwg.cmm.msg.screen.MSG080" />', option);
	             }
	         }
	         , error:function (request, status, error) {
	               alert('<spring:message code="fail.common.msg" text="error" />');
	           }
	     });
		}
		
		
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
	
	    
				 document.onkeydown = backSpaceKey;
				 editInit(); //화면구성에 필요한 객체 추가 
				 wzwgSwiperAll(); //공용 스와이퍼 스크립트 자동
				 writeContentTxt(); // 직접입력 객체 활성화
				 editDialog(); // 다이얼로그 준비
				 wzwgCMBuilder(); // 컨텍스트 메뉴 준비
				 swiperBannerAll(); // 배너 스와이퍼 스크립트
				 
				//탭게시판 반응형 셀렉트박스 스크립트
				$('.wzwg-resp-tab').each(function(){
						 
					 responsiveTabActive($(this));
				});
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
		
				
				/* 시스템관리자 템플릿 편집 고정 로고추가 2023.03.02 */
				$('#img_topLogo').attr('src', '/images/wzwg/sysmngr/sysmngr_tmp_logo_top.png');
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
	       $(this).attr('href','javascript:void(0);');
	   	 }
	    });
	    if($('#top .logo a').attr("href") == '/'){
	    	$('#top .logo a').attr("href", "javascript:void(0);");
	    }
	}
	
	function saveFileNameShow(){
		$('#saveFileInput').show();
	}
	
	function getSave(){ 
		if(confirm('<spring:message code="wzwg.cmm.msg.MSG256" />')){
			
			sceneSaveReady();
			
			if('<c:out value="${isResource}" />' == 'true'){
				alert('리소스 서버에서 템플릿 최종 작업후 꼭 개발자에게 알려주세요^^;;');
			}
			
			document.frmSave.action="<c:out value="${wzwg_contextPath}" />/sysMngr/screen/siteScreenTempSave.do";
			document.frmSave.target= "_self";
			document.frmSave.submit();
		}
	}
	
	
	function sceneSaveReady(){
		
		/* 레이아웃 이펙트 제거 */
		wzStopScrollEffec();
		$('#layout_wrap').each(function(){
			$(this).removeClass('animate-fade');
			$(this).removeClass('animate-slideUp');
			$(this).removeClass('animate-slideNfade');
		});
	
		try{templateSave()}catch(e){console.log(e.message);} // 템플릿 index 내에서 관리자 화면에서만 종료시켜야 하는 스크립트 없을수도 있어서 try 처리
		
		removeContentTxt();
		contentsSortableDestroy();
		wzwgSwiperAllDestroy();
	
	    $('.swiper-slide').css('width', 'auto');
	    $('.swiper-wrapper').removeAttr('style');
	    $(".context-menu-active").removeClass("context-menu-active");
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
		 
	
		/* 위젯 CSS 링크를 컨텐츠 위로 올리도록 변경 2020.03.09 */
		var cssZone = $('#cssZone');
		if(cssZone.length == 0){
			$('.contents').before('<div id="cssZone" style="display:none;"></div>');
		}
		
		var cssLink = $('link[id^="CSS"]');
		$('#cssZone').append(cssLink);
		
		
	
		$("#content").wrap("<div id='contentsWrap'>");
		$("#contents").val($("#contentsWrap").html()); 
		$("#top").wrap("<div id='topMenu'>");
		$("#footer").wrap("<div id='footerWrap'>");
		$("#topContents").val($("#topMenu").html()); 
		$("#footerContents").val($("#footerWrap").html());  
		$("#topMenuSe").val($("#topMenuSeGb").val());
		
		//$('#headCss').val($('#headmenu').attr('href'));
		//$('#footCss').val($('#footmenu').attr('href'));
		//$('#subCss').val($('#submenu').attr('href'));
		$('#headCss').val($('#headmenu')[0].outerHTML);
		$('#footCss').val($('#footmenu')[0].outerHTML);
		$('#subCss').val($('#submenu')[0].outerHTML);
		
		$('#headMenuCss').val($('#headMenuStyle').html());
		$('#headMenuData').val(JSON.stringify(menuCss));
		
		//$('#fileName').val($('#saveFileInput').val());
		
		/** 웹방화벽 이슈로 base64 encoding 처리 **/
		$("#contents").val(btoa(unescape(encodeURIComponent($('#contents').val())))); 
		$("#topContents").val(btoa(unescape(encodeURIComponent($('#topContents').val())))); 
		$("#footerContents").val(btoa(unescape(encodeURIComponent($('#footerContents').val())))); 
		$("#headCss").val(btoa(unescape(encodeURIComponent($('#headCss').val())))); 
		$("#footCss").val(btoa(unescape(encodeURIComponent($('#footCss').val())))); 
		$("#subCss").val(btoa(unescape(encodeURIComponent($('#subCss').val())))); 
		$("#headMenuCss").val(btoa(unescape(encodeURIComponent($('#headMenuCss').val())))); 
		$("#headMenuData").val(btoa(unescape(encodeURIComponent($('#headMenuData').val())))); 
	}
	
	
	function newTemplateSave(){ 
		//템플릿명 확인 	newTemplateNm
		var isChk = true;
		$.ajax({
			   type:'POST'
			 , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/screen/siteScreenTempCheck.do'
			 , data:{templateNm : $('#newTemplateNm').val()}
			 , async:false
			 , dataType: 'json'
			 , success:function (data) { 
				 			if(data.head.result != 'success'){
				 				alert('<spring:message code="wzwzwg.sysMngr.msg.MSG046" />');
				 				isChk = false;
				 				return;
				 			}
					   }
		});
		
		if(isChk == false){
			return;
		}
		//템플릿경로 확인	newTemplateNcnm
		//$('#templateStreCours').val($('#tempalteStreCours').val() + $('#newTemplateNcnm').val());
		$.ajax({
			   type:'POST'
			 , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/screen/siteScreenTempCheck.do'
			 , data:{templateStreCours : $('#tempalteStreCours').val() + $('#newTemplateNcnm').val() + '/'}
			 , async:false
			 , dataType: 'json'
			 , success:function (data) { 
				 			if(data.head.result != 'success'){
				 				alert('<spring:message code="wzwg.sysMngr.msg.MSG047" />');
				 				isChk = false;
				 				return;
				 			}
					   }
		});
		
		if(isChk == false){
			return;
		}
		
		//alert(isChk);
		//return;
	
		if(confirm('<spring:message code="wzwg.cmm.msg.MSG309" />')){
			
			/* 레이아웃 이펙트 제거 */
			wzStopScrollEffec();
			$('#layout_wrap').each(function(){
				$(this).removeClass('animate-fade');
				$(this).removeClass('animate-slideUp');
				$(this).removeClass('animate-slideNfade');
			});
			
			
			try{templateSave()}catch(e){console.log(e.message);} // 템플릿 index 내에서 관리자 화면에서만 종료시켜야 하는 스크립트 없을수도 있어서 try 처리
			
			
			removeContentTxt();
			contentsSortableDestroy();
			wzwgSwiperAllDestroy();
			
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
			 
		
			/* 위젯 CSS 링크를 컨텐츠 위로 올리도록 변경 2020.03.09 */
			var cssZone = $('#cssZone');
			if(cssZone.length == 0){
				$('.contents').before('<div id="cssZone" style="display:none;"></div>');
			}
			
			var cssLink = $('link[id^="CSS"]');
			$('#cssZone').append(cssLink);
			
		
			$("#content").wrap("<div id='contentsWrap'>");
			$("#contents").val($("#contentsWrap").html()); 
			$("#top").wrap("<div id='topMenu'>");
			$("#footer").wrap("<div id='footerWrap'>");
			$("#topContents").val($("#topMenu").html()); 
			$("#footerContents").val($("#footerWrap").html());  
			$("#topMenuSe").val($("#topMenuSeGb").val());
			
			//$('#fileName').val($('#saveFileInput').val());
			
			$('#templateStreCours').val($('#tempalteStreCours').val() + $('#newTemplateNcnm').val());
			$('#templateNm').val($('#newTemplateNm').val());
			$('#templateNcnm').val($('#newTemplateNcnm').val());
			$('#templateCntns').val($('#newTemplateCntns').val());
			
			
			/** 웹방화벽 이슈로 base64 encoding 처리 **/
			$("#contents").val(btoa(unescape(encodeURIComponent($('#contents').val())))); 
			$("#topContents").val(btoa(unescape(encodeURIComponent($('#topContents').val())))); 
			$("#footerContents").val(btoa(unescape(encodeURIComponent($('#footerContents').val())))); 
			$("#headCss").val(btoa(unescape(encodeURIComponent($('#headCss').val())))); 
			$("#footCss").val(btoa(unescape(encodeURIComponent($('#footCss').val())))); 
			$("#subCss").val(btoa(unescape(encodeURIComponent($('#subCss').val())))); 
			$("#headMenuCss").val(btoa(unescape(encodeURIComponent($('#headMenuCss').val())))); 
			$("#headMenuData").val(btoa(unescape(encodeURIComponent($('#headMenuData').val())))); 
			
			
			fnLayerPopupClose();
			
			document.frmSave.action="<c:out value="${wzwg_contextPath}" />/sysMngr/screen/siteScreenNewTempltSave.do";
			document.frmSave.target= "_self";
			document.frmSave.submit();
		} 
	}
	
	function goTemplatePriview(){
		document.frmSave.action="<c:out value="${wzwg_contextPath}" />/mngr/<c:out value="${siteTemplateScreenVO.templateSeq}" />/template/index.do";
		document.frmSave.target="_blank";
		document.frmSave.submit();
		
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
		      	        	$(childEle).show();
		      	        }else{
		      	        	$(childEle).hide();
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
	        	        	$('.hdmenu .gnb').show();
	        	        	//console.log($('.hdmenu .gnb'));
	        	        	$(childEle).parent().show();
	        	        }else{
	        	        	//$(childEle).remove();
	        	        	$(childEle).parent().hide();
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
		 /* try{$('#menuCssSeq').val(topMenuNum);}catch(e){log(e.message);} */
	}
	
	/* moo0506 메인메뉴 CSS 변경 */
	function changeTopMenuCss(cssPath){
		var dummy = parseInt(Math.random()*1000); // 템플릿마다 파일명이 같아서 캐시가 남는 문제 해결을 위한 핵
		var topMenuStr = cssPath+"?dummy=" + dummy ;
		$("#headmenu").attr("href",topMenuStr);
		 /* try{$('#menuCssSeq').val(topMenuNum);}catch(e){console.log(e.message);} */
		alert('<spring:message code="wzwg.cmm.msg.MSG080" />')
	}
	
	/* moo0506 푸터 CSS 변경 */
	function changeFooterCss(cssPath){
		var dummy = parseInt(Math.random()*1000); // 템플릿마다 파일명이 같아서 캐시가 남는 문제 해결을 위한 핵
		var topMenuStr = cssPath+"?dummy=" + dummy ;
		$("#footmenu").attr("href",topMenuStr);
		 /* try{$('#menuCssSeq').val(topMenuNum);}catch(e){console.log(e.message);} */
		 
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
		 /* try{$('#menuCssSeq').val(topMenuNum);}catch(e){console.log(e.message);} */
	}
	
	 
		function footerFtrMenuInfoParsing() {
	
			 var startMenuLv = 1;
			 var stopMenuLv = 2;
			 
			 $('.ftrmenu').each(function (index, parentEle) {
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
		document.frmSave.action="<c:out value="${wzwg_contextPath}" />/mngr/screen/selectSiteScreenTemplateInitMngr.do";
		document.frmSave.submit();
	}
	
	/* function fnChangeTempBackup(backupFile){
		$("#backup").val(backupFile);
		document.frmSave.action="/mngr/screen/selectSiteScreenTempIndexMngr.do";
		document.frmSave.submit();
	} */
	
	function fn_siteTempltChange(){
		//getSave();
		if(confirm('<spring:message code="wzwg.cmm.msg.MSG257" />')){ 
			document.frmSave.action  ="<c:out value="${wzwg_contextPath}" />/mngr/screen/changeSiteScreenTemplt.do";
			document.frmSave.target= "_self";
			document.frmSave.method="post";
			document.frmSave.submit();
			try{
				window.opener.location.href = window.opener.location; 
			}catch(e){console.log(e.message);}
			
		}
	}
	
	function backupFileLoad(){
		//$("#backupFileName").val($('#backupFile').val());
		if($('#backupFileName').val() == ''){
			alert('<spring:message code="wzwg.sysMngr.msg.MSG048" />');
			return;
		}
		document.frmSave.action="<c:out value="${wzwg_contextPath}" />/sysMngr/screen/selectSiteScreenTempIndexMngr.do";
		document.frmSave.submit();
	}
	
	function backupFileDelete(){
		//$("#backupFileName").val($('#backupFile').val());
		if($('#backupFileName').val() == ''){
			alert('<spring:message code="wzwg.sysMngr.msg.MSG048" />');
			return;
		}
		document.frmSave.action="<c:out value="${wzwg_contextPath}" />/sysMngr/screen/siteScreenTempDelete.do";
		document.frmSave.submit();
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
	
	function fnScreenshotDownload() {
		fnGridToggle();
		$(document).scrollTop(0);
		html2canvas($("#editorDiv"), {
			//allowTaint: true,
			//taintTest: false,
			useCORS: true,
			proxy: '/etc/proxy_image',
			onrendered: function(canvas) {
				var image = canvas.toDataURL();
				//meta.cmn.submitHiddenForm("/etc/bypass_image", { image : image });
				var a = document.createElement('a');
				a.style = "display: none";
				a.href = image;
				a.download = "new_file_name.png";
				document.body.appendChild(a);
				a.click();
				setTimeout(function() { // 다운로드가 안되는 경우 방지
				    document.body.removeChild(a);
				}, 100);
				
			}
		});
		fnGridToggle();
	}        
	
	function fnTemplateFileMngr(){
		$.ajax({
			   type:'POST'
			 , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/screen/selectScreenTempltMngrAjax.do'
			 , data:$("#frmLayout").serialize()
			 , success:function (data) { 
				 	wzAjaxModal('popup_l', '<spring:message code="wzwg.sysMngr.word.tmplatFileMngr" />', data);
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
	
	function fnSelectBackupFile(fileNm){
		$('#backupFile').find('a').removeClass('bg-blue');
		$('#backupFile').find('a[data-nm="' + fileNm + '"]').addClass('bg-blue');
		$('#backupFileName').val(fileNm);
	}
	
	function fnCssCleanupPop() {
		var tag = '';
		var widgetData = {};

		$('#cssListDiv').empty();
		
		$('.wzwgWidget').each(function() {
			widgetData[$(this).attr('data-id')] = $(this).attr('data-nm');
		});
		
		$('link[id^="CSS"]').each(function() {
			var cssId = $(this).attr('id');
			var cssHref = $(this).attr('href');
			var widgetCssId = cssId.replace('CSS_', '');
			
			if(widgetData[widgetCssId]) {
				tag = '<div id="'+widgetCssId+'wrap"><p>'+widgetData[widgetCssId]+'</p></div>'
			}else {
				tag = '<div id="'+widgetCssId+'wrap"><p>'+cssHref+'</p><div><button id="cssTestBtn'+cssId+'" type="button" class="wzbtn btn-black" onclick="fnWidgetCssTest('+cssId+')"><spring:message code="wzwg.sysMngr.word.useAtCnfirm" /></button><button id="cssResetBtn'+cssId+'" type="button" class="wzbtn btn-blue" style="display:none;" onclick="fnWidgetCssReset('+cssId+')"><spring:message code="wzwg.sysMngr.word.revert" /></button><button type="button" class="wzbtn btn-del" onclick="fnWidgetCssDel('+cssId+')"><spring:message code="wzwg.cmm.word.delete" /></button></div></div>'
			}
			$('#cssListDiv').append(tag);
		});
		
		$('#cssListDiv' ).dialog('open');
	}
	
	function fnWidgetCssTest(id) {
		$(id).attr('href', '/test'+$(id).attr('href'));
		
		$('#cssTestBtn'+$(id).attr('id')).css('display', 'none');
		$('#cssResetBtn'+$(id).attr('id')).css('display', '');
	}
	
	function fnWidgetCssReset(id) {
		var cssOrignHref = $(id).attr('href').replace('/test', '');
		$(id).attr('href', cssOrignHref);
		
		$('#cssResetBtn'+$(id).attr('id')).css('display', 'none');
		$('#cssTestBtn'+$(id).attr('id')).css('display', '');
	}
	
	function fnWidgetCssDel(id) {
		var widgetCssId = $(id).attr('id').replace('CSS_', '');
		
		if(confirm('<spring:message code="wzwg.sysMngr.msg.MSG049" />')){
			$(id).remove();
			$('#cssListDiv').find('#'+widgetCssId+'wrap').remove();
			alert('<spring:message code="wzwg.sysMngr.msg.MSG028" />');
		}else {
			return;
		}
	}
	
	</script>

</head>
<body>

	
	
	<!-- 상단 컨트롤러 -->
	<div id="dgnCtlPannel" class="ctrlTopMenu sysTopCtlpanl">
    
    	<div id="dgnCtlLeft" class="ctrlBtn">
        	<div class="ctrlBtnAlign wd100">
                <ul class="topMenu">
                    <li class="btn_menuDesign">
                        <a href="javascript:;" onclick="fnChangeMenuPopup();">
                            <span></span>
                            <p class="tooltip"><spring:message code="wzwg.sysMngr.word.menuDesignChg" /></p>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;" id="GridToggleBtn" onclick="fnGridToggle();">
                            <spring:message code="wzwg.sysMngr.word.guidanceLine03Hide" />
                        </a>
                    </li>
                    
                    <li class="templateNameView">
                        <p>
                            <spring:message code="wzwg.cmm.word.template" /> : <strong><c:out value="${templtVO.templateNm }" /></strong>
                        </p>
                    </li>
                </ul>
                
                
                <ul class="topMenu fr">            
                   <%--  <li class="backupFileLoad">               
				     
                        <a href="javascript:;" onclick="$('#backupFile').toggleClass('open');"><spring:message code="wzwg.cmm.word.backup" /> <spring:message code="wzwg.cmm.word.file" /></a>
                        
                        <ul class="backupFileList" id="backupFile" name="backupFile">
                            <li>
                                <a href="javascript:;" onclick="fnSelectBackupFile('')" data-nm=""><spring:message code="wzwg.cmm.word.now" /> <spring:message code="wzwg.cmm.word.file" /></a>
                            </li>
                            <c:forEach items="${backupList}" var="files" varStatus="status">
                            <li>
                                <a href="javascript:;" onclick="fnSelectBackupFile('${files}')" class="<c:if test="${backupFile eq files}">bg-blue</c:if>" data-nm="${files }">${files }</a>
                            </li>
							</c:forEach>
                           <!--  <li>
                                <a href="javascript:;" onclick="fnSelectBackupFile('test')" data-nm="test">test</a>
                            </li> -->
							
                        </ul>
                        <a href="javascript:;"  onclick="backupFileLoad()" class="wzbtn btn-basic fs16" style="padding:10px;"><spring:message code="wzwg.cmm.word.import" /></a>
						<a href="javascript:;"  onclick="backupFileDelete()" class="wzbtn btn-del fs16" style="padding:10px; margin-right:10px;"><spring:message code="wzwg.cmm.word.delete01" /></a>
                    </li> --%>
                    <li>
                        <a href="javascript:;"  onclick="fnCssCleanupPop();" ><spring:message code="wzwg.sysMngr.word.widgCssArng" /></a>
                    </li>
                    <li>
                        <a href="javascript:;"  onclick="fnScreenshotDownload();" ><spring:message code="wzwg.sysMngr.word.capture" /></a>
                    </li>
                    <li>
                        <a href="javascript:;"  onclick="fnNewTemplatePopup();" ><spring:message code="wzwg.cmm.word.newtmplstre" /></a>
                    </li>
                    <li>
						<a href="javascript:;"  onclick="fnTemplateFileMngr();" ><spring:message code="wzwg.sysMngr.word.tmplatFileMng" /></a>
                    </li>
                    
                    <li class="btn_siteTempltChange">
                        <a href="javascript:;" onclick="getSave();"><spring:message code="wzwg.cmm.word.stre" /></a>
                    </li>
                </ul>
            </div>
    
        </div>
            
	</div>
    
    <!-- /상단 컨트롤러 -->
    
    
	<div id="editorDiv" class="editor" style="z-index: 0;">
		<c:import url="${url}"></c:import>
		
	</div>

	<form name="frmSave" id="frmSave" method="post">
		<input type="hidden" id="contents" name="contents" /> 
		<input type="hidden" id="topContents" name="topContents" /> 
		<input type="hidden" id="footerContents" name="footerContents" /> 
			<!-- <input type="hidden" id="backup" name="backup" value="" /> --> 
		<input type="hidden" id="topMenuSe" name="topMenuSe" />
		<input type="hidden" id="templateSeq" name="templateSeq" value="<c:out value="${templtVO.templateSeq}" />" />
		<input type="hidden" name="fileName" id="fileName"/>
		<input type="hidden" name="backupFileName" id="backupFileName"/>
		<input type="hidden" name="templateStreCours" id="templateStreCours"/>
		<input type="hidden" name="templateNm" id="templateNm"/>
		<input type="hidden" name="templateNcnm" id="templateNcnm"/>
		<input type="hidden" name="templateCntns" id="templateCntns"/>
			
		<input type="hidden" id="headCss" name="headCss" />
		<input type="hidden" id="footCss" name="footCss" />
		<input type="hidden" id="subCss" name="subCss" />
			
		<input type="hidden" id="headMenuCss" name="headMenuCss" />
		<input type="hidden" id="headMenuData" name="headMenuData" />
	</form>
	<div id="imgDiv"></div>


	<jsp:include page="/WEB-INF/jsp/wzwg/site/mngr/screen/siteScreenTempltDialogImp.jsp"></jsp:include>
	
	
	
	<form name="frmLayout" id="frmLayout" method="post">
		<input type="hidden" id="templateSeq" name="templateSeq"
			value="<c:out value="${siteTemplateScreenVO.templateSeq}${templtVO.templateSeq}" />" />
		<input type="hidden" id="templateStreCours" name="templateStreCours" value="<c:out value="${templtVO.templateStreCours }" />" />
		<input type="hidden" id="headMenuType" name="headMenuType" />
		<input type="hidden" id="footMenuType" name="footMenuType" />
		<input type="hidden" id="subMenuType" name="subMenuType" />
	</form>
	<!-- 레이어팝업 영역 Start -->
	<div id="divLayerPopup" class="modal fade in" style="z-index: 99;"></div>
	<!-- 레이어팝업 영역 End -->
	<%-- <jsp:include page="siteScreenTemlptFileMngrImp.jsp"><jsp:param value="${templtVO.templateStreCours}" name="templatePath"/></jsp:include> --%>
</body>
</html>