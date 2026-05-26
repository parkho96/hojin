<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><spring:message code="wzwg.site.screen.msg.MSG050"/></title>
<link rel="stylesheet" href="/css/wzwg/cmm/jquery-ui.css">
<script src="/js/wzwg/cmm/jquery-latest.min.js"></script>
<script src="/js/wzwg/cmm/jquery-ui.js"></script>

<!-- 위즈위그 메시지 로드 -->
  	<script type="text/javascript" language="JavaScript"  src="/js/wzwg/cmm/jquery.i18n.properties-min-1.0.9.js"></script>
  	<script type="text/javascript" language="JavaScript"  src="/js/wzwg/site/wzwgMessage.js"></script>
	<script>
	jQuery(document).ready(function() {
		onloadWzwgMsg("<c:out value="${sessionScope.langCode}"/>");
	});
	</script>
	
	
<link rel="stylesheet" href="/smartEditorCustom/css/font-awesome.css" type="text/css" />
<link href="/css/wzwg/cmm/jquery.contextMenu.css" rel="stylesheet" type="text/css" />
<script src="/js/wzwg/cmm/jquery.contextMenu.js" type="text/javascript"></script>
<script src="/js/wzwg/cmm/jquery.ui.position.min.js" type="text/javascript"></script>
<script src="/js/wzwg/site/editFunc.js" type="text/javascript"></script>

<link rel="stylesheet" type="text/css" media="screen" href="/css/wzwg/cmm/0028_farbtastic.css" />
<script type="text/javascript" charset="utf-8" src="/js/wzwg/cmm/0028_farbtastic.js"></script>

<script src="/design/module/sample/js/swiper.jquery.min.js"></script>
<link rel="stylesheet" href="/js/wzwg/cmm/slick/slick.css" type="text/css" />
<script src="/js/wzwg/cmm/slick/slick.js"></script> 

<link rel="stylesheet" href="/css/wzwg/site/mngr/screenMngr.css" type="text/css">

<script src="/js/wzwg/site/schedule.js"></script>
<script src="/js/wzwg/site/timetable.js"></script>
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
 

 function topMenuSubParsing() {  
	    $('a').each(function () {
		   	 if($(this).attr("href").indexOf("/subList") >-1){
		   		 //$(this).attr('data-href',$(this).attr("href"));
		       //$(this).attr('href','/mngr/<c:out value="${templateSeq}"/>/screen'+$(this).attr("href")+'?templateSeq=<c:out value="${templateSeq}"/>');
		       /* $(this).attr('href','/mngr/screen'+$(this).attr("href")+'?templateSeq=<c:out value="${param.templateSeq}"/>'); */
		   		$(this).attr('href','<c:out value="${wzwg_contextPath}"/>/mngr/screen/subList/'+$(this).attr('data-mnseq')+'?templateSeq=<c:out value="${param.templateSeq}"/>');
		   	 }
		   	 if($(this).attr("href") =='<c:out value="${wzwg_contextPath}"/>/'){
		   		$(this).attr('href','<c:out value="${wzwg_contextPath}"/>/mngr/screen/selectSiteScreenTempIndexMngr.do?templateSeq=<c:out value="${templateSeq}"/>');
		   	 }
	    });
 }
 function uploadImg(mode){
		$.ajax({
	        type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}"/>/module/upload/image/imageForm.do?mode='+mode
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
 
 function addQuickBanner(){
		 if($(".quickBannerZone").size() ==0){
			 alert('<spring:message code="wzwg.cmm.msg.MSG178" />');
			 return;
		 }
		
	 $.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/screen/selectSiteQuickBannerAjax.do'
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
 function fnLayerPopupClose() {
	    $("#divLayerPopup").hide();
	    $("#divLayerPopup").empty();
	    $('body').css({overflow:'auto'});
	}
 
 function fnLinkCntl(){
	 $('#editorDiv').on('click', function(e){
		 console.log(e);
		 console.log(e.target);
		 //console.log($(e.target).prop('tagName'));
		 //console.log($(e.target).is('a'));
		 //console.log(e.target == 'a');
		 //console.log($(e.target).prop('tagName') == 'A');
		 if($(e.target).is('img')){
			 e.preventDefault(); //이벤트 중지
			 e.stopPropagation(); //이벤트 전파 방지
		 }
		 
		 if($(e.target).is('button') && $(e.target).parent().filter('.link-group').length == 1){
			 e.preventDefault(); //이벤트 중지
			 e.stopPropagation(); //이벤트 전파 방지
			 alert(wz_msg('wzwg.cmm.msg.screen.MSG081'));
		 }
		 
		 $(e.target).parents().filter('a').each(function(){
			 var href = $(this).attr('href');
			 
			 if(href.indexOf('screen') > -1){
				 
			 }else{
				 e.preventDefault(); //이벤트 중지
				 if(href.indexOf('javascript') > -1 || href == '' || href == '#' ){
					   href = wz_msg('wzwg.cmm.msg.screen.MSG043');
				 }
				 var alertMsg = wz_msg('wzwg.cmm.msg.screen.MSG065') + ' ' + href;
				 var title = $(this).attr('title');
				 if(title && title.length > 0){
					   alertMsg += '\r\n' + wz_msg('wzwg.site.menu.msg.MSG026') + ' : ' + title;
				 }
				   alert(alertMsg);
				 
			 }
		 })
		 
		 if($(e.target).is('a')){
			 var href = $(e.target).attr('href');
			 
			 if(href.indexOf('screen') > -1){
				 
			 }else{
				 e.preventDefault(); //이벤트 중지
				 if(href.indexOf('javascript') > -1 || href == '' || href == '#' ){
					   href = wz_msg('wzwg.cmm.msg.screen.MSG043');
				 }
				 var alertMsg = wz_msg('wzwg.cmm.msg.screen.MSG065') + ' ' + href;
				 var title = $(this).attr('title');
				 if(title && title.length > 0){
					   alertMsg += '\r\n' + wz_msg('wzwg.site.menu.msg.MSG026') + ' : ' + title;
				 }
				   alert(alertMsg);
				 
			 }
			 
		 }
	 });
 }
 $(document).ready(function(){
		 
		$(".hide").click(function(){
			$(".pop-box").hide();
		});
		
		setTimeout(fnBannerBtnText, 1000);
		
		$('.logo a').attr('href', 'javascript:void(0);');
		
		fnLinkCntl()
		
		//로그인 시간 유지 스크립트
		<c:if test="${not empty sessintvl and sessintvl ne '0'  }">
		fnLoginTimeCheck();
		</c:if>
	});
 
 	var sessionInterval = parseInt('<c:out value="${sessintvl}"/>');
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
		$('.lognTimer').html(m + ':' + s);
		return m + ':' + s;
	}
	
	function fnAddSessionTime(){
		$.ajax({
         type:'POST'
         , url:'<c:out value="${wzwg_contextPath}"/>/cmm/code/selectSessionIntervalAjax.do'
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
             	wzToast(wz_msg('wzwg.cmm.msg.screen.MSG080'), option);
             }
         }
         , error:function (request, status, error) {
               alert('<spring:message code="fail.common.msg" text="error" />');
           }
     });
	}
	
 $(function() {
		topMenuSubParsing();  
		editDialog();
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
			        		 name:"<spring:message code="wzwg.cmm.word.array" />", icon : "edit",
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
						
			     },
			     items: {
			     	//"skinReplace": {name: "<spring:message code="wzwg.site.screen.msg.MSG046" />", icon: "edit"}, 
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
			        		 name:"<spring:message code="wzwg.cmm.word.array" />", icon : "edit",
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
	
	 writeContentTxt(); // 직접입력 객체 활성화
	 editDialog(); // 다이얼로그 준비
	 wzwgCMBuilder(); // 컨텍스트 메뉴 준비
	 
	 fnScreenHederScroll(); //
 });/*end function()*/
 

var footerTopPos;
function fnScreenHederScroll(){
	console.log('fnScreenHederScroll ::::3');
	 
	footerTopPos = $('#footer').height();
 	$(document).scroll(function(){
 		
 		var movScrolpx = $(this).scrollTop();
 		
 		
 			/* 왼쪽메뉴 유형 fixed 일때 푸터 겹치지 않도록 조절 2019-04-26 조원권*/
			
			if( $('#headmenu').attr('data-type') == 'wide' && $('.head-group').css('position') == 'fixed' ){
				
				if(movScrolpx == 0){
					$('.head-group').css('top', '');
		 			
		 		}else{
					var dgnCtlPannelHeight = $('#dgnCtlPannel').outerHeight();
					$('.head-group').css('top', dgnCtlPannelHeight + 'px');
		 		}
				
			}
 	  });
 }
function writeContentTxt(){
	 $('.edtFormTxt').css('border', 'dashed 1px #3899ec');
	 $('.edtFormTxt').attr('contenteditable', 'true');
}
 
function removeContentTxt(){
	$('.edtFormTxt').removeAttr('contenteditable');
	$('.edtFormTxt').css('border', '');
}
 
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

function fnSavePageList(){
	 $.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/screen/selectSaveSubPageListAjax.do'
		 , data:{menuSeq : '<c:out value="${menuSeq}"/>'}
		 , success:function (data) {
			 wzAjaxModal('popup_l', wz_msg('wzwg.site.screen.msg.MSG051'), data);
			 }
		 , dataType: 'html'
	});
}

function getSave(){ 
	removeContentTxt();
	
	 $(".axebox").html("");
	 $(".axeboxboot").html("");
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
	if($(".topSubImgOrign").size() >0){
	 	$(".topSubImgOrign").wrap("<div id='topSubImgWrap'>");
        $("#topSubImgSource").val($("#topSubImgWrap").html());
	}
	if($(".btnSubImgOrign").size() >0){
        $(".btnSubImgOrign").wrap("<div id='btnSubImgWrap'>");
        $("#btnSubImgSource").val($("#btnSubImgWrap").html());
	}
	
	document.frmSave.action="<c:out value="${wzwg_contextPath}"/>/mngr/screen/siteScreenTemplateSubSave.do";
	document.frmSave.submit();
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


<!-- 디자인 컨트롤 패널 스크립트 -->
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
		$('#bnrToggleBtn').html('<spring:message code="wzwg.site.screen.msg.MSG052" />');
	}else{
		$('#bnrToggleBtn').html('<spring:message code="wzwg.site.screen.msg.MSG053" />');
	}
	
	/* 
	if($('.topSubImgOrign').css('display') == 'none'){
		$('#bnrToggleBtn').html('<spring:message code="wzwg.site.screen.msg.MSG052" />');
	}else{
		$('#bnrToggleBtn').html('<spring:message code="wzwg.site.screen.msg.MSG053" />');
	}
	 */
}
</script>

</head>
<body>

	<!-- 상단 컨트롤러 -->
	<div id="dgnCtlPannel" class="ctrlTopMenu subController">
    
    	<div id="dgnCtlLeft" class="ctrlBtn">
        	<div class="ctrlBtnAlign wd100">
                <ul class="topMenu">
                    <li class="templateNameView">
                        <span class="subPageSabeHelp">※<spring:message code="wzwg.cmm.msg.screen.MSG079" /></span>
                    </li>
                </ul>
                
                
                <ul class="topMenu fr">            
                    <li>
                        <a href="javascript:;" onclick="fnBannerToggle();" id="bnrToggleBtn"></a>
                    </li>
                    
                    <li class="btn_siteTempltChange">
                        <%-- <a href="javascript:;" onclick="getSave();"><spring:message code="wzwg.cmm.word.stre" /></a> --%>
                        <a href="javascript:;" onclick="fnSavePageList();"><spring:message code="wzwg.cmm.word.stre" /></a>
                    </li>
                </ul>
            </div>
        </div>
            
	</div>
	
	
	
	
	
	
	<div id="editorDiv" class="editor" style="z-index: 0;">
		<c:import url="${url}"></c:import>
	</div>
	
	<form name="frmSave" id="frmSave" method="post">
		<input type="hidden" id="contents" name="contents" /> 
		<input type="hidden" id="topSubImgSource" name="topSubImgSource" /> 
		<input type="hidden" id="btnSubImgSource" name="btnSubImgSource" /> 
		<input type="hidden" id="menuSeq" name="menuSeq"  value="<c:out value="${menuSeq}"/>"/> 
		<input type="hidden" id="backup" name="backup" /> 
		<input type="hidden" id="templateSeq" name="templateSeq" value="<c:out value="${param.templateSeq}"/>" />
		<input type="hidden" id="topMenuSe" name="topMenuSe" />
		<input type="hidden" id="subMenuSeqs" name="subMenuSeqs" />
		<input type="hidden" id="usrSubEdit" name="usrSubEdit" />
	</form>
	<div id="imgDiv"></div>
	
	<jsp:include page="siteScreenTempltDialogImp.jsp"></jsp:include>


	
	
	
	
	
	<form name="frmLayout" id="frmLayout" method="post">
		<input type="hidden" id="templateSeq" name="templateSeq"
			value="<c:out value="${siteTemplateScreenVO.templateSeq}"/>" />
	</form>
	
	
	<!-- 레이어팝업 영역 Start -->
	<div id="divLayerPopup" class="modal fade in" style="z-index: 99;"></div>
	<!-- 레이어팝업 영역 End --> 
	<div id="contentTesty"></div>
	
	
	<!-- 레이어팝업 영역 Start -->
	<div id="divLayerPopup" class="modal fade in" style="z-index: 99;"></div>
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
