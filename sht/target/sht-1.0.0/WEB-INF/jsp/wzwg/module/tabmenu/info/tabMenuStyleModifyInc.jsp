<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script>
//var tabStyleCssPath = '/css/wzwg/module/tabMenu/tabMenu.css';
var tabStyleJsonPath = '/css/wzwg/module/tabMenu/tabMenu.json';
var tabStyleJsonData = null;
var paramCssNm = '<c:out value="${param.cssNm}" />';
var paramTabSeq = '<c:out value="${param.tabSeq}" />';
//var cssNmInp = null;
//
$(document).ready(function(){
//	
	$.ajax({
	    type : 'GET'
		, url : tabStyleJsonPath
		, async : false
		, dataType : 'json'
		, success : function (data) {
//			//$("#imgDiv").html(data);
//			//$("#imgDiv").show();
//			//console.log(data);
			tabStyleJsonData = data
		}
		, error : function (request, status, error) {
			alert('error');
		}
	}); 
	
	fnMakeTabStylePannel();
	
});

function fnMakeTabStylePannel(){
	var tabStylePannel = $('#styleSelectPannel');
	tabStylePannel.empty();
	
	$(tabStyleJsonData.cssgroups).each(function(idx){
		var grpNm = tabStyleJsonData.cssgroups[idx].name;
		var grpNmDc = '';
		if(tabStyleJsonData.cssgroups[idx].langcode == undefined || tabStyleJsonData.cssgroups[idx].langcode == ''){
			grpNmDc = tabStyleJsonData.cssgroups[idx].namedc;
		}else{
			try{
				grpNmDc = wz_msg(tabStyleJsonData.cssgroups[idx].langcode);
			}catch(e){
				log(e.message);
				grpNmDc = tabStyleJsonData.cssgroups[idx].namedc;
			}
		}
		//console.log(tabStyleJsonData[grpNm]);
		var item = '<table class="basic mb0"><colgroup><col width="15%"><col width="85%"></colgroup><tbody>';
			item += '<tr><th>'  + grpNmDc + ' ' + wz_msg('wzwg.cmm.word.choise');
			item += '</th>';
			item += '<td><ul class="item i-block wzForm">';
			$(tabStyleJsonData[grpNm]).each(function(idx){
				var styleData = this;
				//console.log(styleData);
				var classDc = '';
				if(styleData.langcode == undefined || styleData.langcode == ''){
					classDc = styleData.classdc;
				}else{
					try{
						classDc = wz_msg(styleData.langcode);	
					}catch(e){
						log(e.message);
						classDc = styleData.classdc;
					}
					
				}
				
				var useCssNms = paramCssNm.split(',');
				var checked = '';
				
				//console.log(styleData.classname);
				for(var i = 0 ; i < useCssNms.length; i++){
					//console.log(useCssNms[i]);
					if(styleData.classname == useCssNms[i]){
						checked = 'checked="checked"';
						console.log(checked);
						break;
					}
				}
				
				item += '	<li class="i-block">';
				item += '		<input type="radio" name="addStyle_' + grpNm + '" id="addStyle_' + grpNm + '_' + idx + '" onchange="fnChangeStyle(\'' + grpNm + '\', this)" value="' + styleData.classname + '" ' + checked + '/>';
				item += '		<label for="addStyle_' + grpNm + '_' + idx + '" >' + classDc + '<span class="prevTalStyle"></span></label>';
				item += '	</li>';
			})
			item += '<tbody></table>';
			
		//console.log(item);
		tabStylePannel.append(item);
	});
	
	
	return;
	
	var item = '<ul class="i-block wzForm">';
//		item += '';
		$(tabStyleJsonData.style).each(function(idx){
		item += '	<li class="i-block">';
		item += '		<input type="radio" name="addTabStyle" id="addTabStyle_' + idx + '" onchange="fnChangeTabStyle(this)" value="' + tabStyleJsonData.style[idx].classname + '"/>';
		item += '		<label for="addTabStyle_' + idx + '" >' + tabStyleJsonData.style[idx].classname + '<span class="prevTalStyle"></span></label>';
		item += '	</li>';
			
		});
		item += '</ul></td></tr>';
	
	tabStylePannel.append(item);
	
	
	
}

function fnChangeStyle(grpNm, _inp){
	var tabListbox = $('#tabListbox');
	
	$(tabStyleJsonData[grpNm]).each(function(idx){
		var styleData = this;
		tabListbox.removeClass(styleData.classname);
	});
	
	var addClassName = $(_inp).val();
	if(addClassName != ''){
		tabListbox.addClass($(_inp).val());
	}
}

//function fnChangeTabStyle(_inp){
//	var tabListbox = $('.tabListbox');
//	
//	$(tabStyleJsonData.style).each(function(idx){
//		tabListbox.removeClass(tabStyleJsonData.style[idx].classname);
//	});
//	
//	tabListbox.addClass($(_inp).val());
//}
//
//function fnChangeTabTheme(_inp){
//	var tabListbox = $('.tabListbox');
//	
//	$(tabStyleJsonData.theme).each(function(idx){
//		tabListbox.removeClass(tabStyleJsonData.theme[idx].classname);
//	});
//	
//	tabListbox.addClass($(_inp).val());
//}

function fnSaveCssStyle(){
	var cssNm = '';
	$('#styleSelectPannel input:checked').each(function(idx){
		if(idx > 0){
			cssNm += ',';
		}
		
		cssNm += $(this).val();
	})
	
	//console.log(cssNm);
	
	if(cssNm == ''){
		alert('<spring:message code="wzwg.cmm.msg.MSG490" />');
		return;
	}
	
	$.ajax({
        type : 'POST'
        , url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/tabMenu/modifyTabMenuCssNmAjax.do'
        , dataType: 'xml'
        , data : {'tabSeq' : paramTabSeq , 'cssNm' : cssNm}
        , success : function (result) {
          
            var value = "";
            
            $(result).find("value").each(function() {  
                value = $(this).text();  
            });
            
            if(value == 'success'){
            	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>');
            }else{
                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
            }
          
        }
        , error : function (request, status, error) {
            alert('<spring:message code="fail.common.msg" text="error" />');
        }
    });
	
	
}
</script>

<div class="mt10 mb10">
	<div class="wzAdmSTit wd100 fl mt10">
		<h3 class="i-block"><spring:message code="wzwg.module.word.tabmenudesignchange" /></h3>
	</div>
	<div class="admpg-subp fl txt-l block mb20 wm100 pl20 fl wd100 pb10"><span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.tip.MSG0731" /></div>
	<div id="styleSelectPannel" class="box-border pl20 pr20 mb10">
	</div>
	<div class="txt-r box-border pr20">
		<button type="button" class="wzbtn btn-save" onclick="fnSaveCssStyle()">변경 디자인 저장</button>
	</div>
</div>