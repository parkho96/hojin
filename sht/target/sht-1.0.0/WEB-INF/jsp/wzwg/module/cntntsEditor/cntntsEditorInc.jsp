<%@page import="egovframework.com.cmm.service.Globals"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<link rel="stylesheet" href="/css/wzwg/cmm/layout.css" type="text/css" />
<link rel="stylesheet" href="/css/wzwg/cmm/empty_line.css" type="text/css" />
<link rel="stylesheet" href="/css/wzwg/module/cntntsEditor/cntnts.css" type="text/css" />

<!-- 셀렉트 검색 라이브러리 -->
<link href="/js/wzwg/cmm/select2/select2.css" rel="stylesheet" />
<script src="/js/wzwg/cmm/select2/select2.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		fnTabChange('bassInfo');
		
		$('#cntntsSelect').select2();
	});
	
	function fnPageReload() {
	    var frm = document.cntntsFrm;

        var arrVal = $('#cntntsSelect').val().split("|");
        frm.cntntsSeq.value = arrVal[0];
        frm.sitecntntsSeq.value = arrVal[1];
        
	    frm.action = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/cntntsEditor/selectModuleCntntsInc.do';
	    frm.submit();
	}
	/** 타입 변경(기본정보, 데이터관리, 권한, 담당자) */
	function fnTabChange(paramValue){
		var pageUrl = "";
		
		if(paramValue == 'bassInfo'){
			pageUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/cntntsEditor/selectCntntsBassInfoDetailAjax.do'
		}else if(paramValue == 'dataManage'){
			pageUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/cntntsEditor/selectCntntsCnListAjax.do'
		}else if(paramValue == 'author'){
            //document.getElementById('sitecntntsSeq').value = $.urlParam('sitecntntsSeq');
            pageUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/cntnts/cntntsAuth/selectCntntsAuthListAjax.do';
        }else if(paramValue == 'charger'){
            //document.getElementById('sitecntntsSeq').value = $.urlParam('sitecntntsSeq');
            pageUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/cntnts/cntntsCharger/selectCntntsChargerAjax.do';
        }else if(paramValue == 'cntPagadiEstbs'){
            //document.getElementById('sitecntntsSeq').value = $.urlParam('sitecntntsSeq');
            pageUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/cntnts/cntPagadiEstbs/selectCntPagadiEstbsAjax.do';
                                 
        }
				
		$('#tabTyCode').val(paramValue);
		
		$('#searchCondition').val('');
		$('#searchKeyword').val('');
		$('#pageIndex').val(1);
		
		$.ajax({
	        type:'POST'
	      , url:pageUrl
	      , cache : false
	      , async : false
	      , data:$("#cntntsFrm").serialize()
	      , success:function (data) {
	    	  if($('#cntntsVer').val() == '2'){
		    	  $('#cntnts_area_v2').html(data);
		    	  $('#cntnts_area').html('');
	    	  }else{
		    	  $('#cntnts_area').html(data);
	    	  }

	          $(".step > .tapMenu > li > a").removeClass("on");
	          $("#"+paramValue).addClass("on");	          
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
	
	/** 컨텐츠 선택 */
	function fnChangeCntntsSeq(val){
		var frm = document.cntntsFrm;
		var arrVal = val.split("|");
		frm.cntntsSeq.value = arrVal[0];
		frm.sitecntntsSeq.value = arrVal[1];

		fnTabChange($('#tabTyCode').val());
	}
	
	/** 컨텐츠 내용 삭제 */
	function fn_deleteCntntsCn(paramSeq){
		if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
			return;
		}else{
			document.cntntsFrm.cntntsCnSeq.value = paramSeq;
			
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/cntntsEditor/deleteModuleCntntsCnAjax.do'
				, data : $("#cntntsFrm").serialize()
				, success : function (result) {
					$(result).find('value').each(function(){
						if($(this).text() == "success"){
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
							fn_init();
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
						}
					})
				}
				, error : function (request, status, error) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
			});
		}
	}
    
    /** 컨텐츠 내용 수정 */
    function fn_modifyCntntsCnForm(paramSeq){
        if(paramSeq != 'regist'){
            document.cntntsFrm.cntntsCnSeq.value = paramSeq;
        }
        var cntntsVer = $('#cntntsVer').val();
        
        if(cntntsVer == '1'){
	       $.ajax({
	              type : 'POST'
	            , dataType: 'html'
	            , url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/cntntsEditor/registModuleCntntsCnFormAjax.do'
	            , cache : false
	            , async : false
	            , data:$("#cntntsFrm").serialize()
	            , success:function (data) {
	  	    	  if($('#cntntsVer').val() == '2'){
			    	  $('#cntnts_area_v2').html(data);
			    	  $('#cntnts_area').html('');
		    		  
		    	  }else{
			    	  $('#cntnts_area').html(data);
		    	  }
	
	            }
	            , error:function (data) {
	                alert('<spring:message code="fail.common.msg" text="error" />');
	            }
	        });
        	
        }else if(cntntsVer == '2'){
	        var gsWin = window.open("about:blank", "newScrnCntntsFrm");
	        var frm = document.cntntsFrm;
	        frm.action = "<c:out value='${wzwg_contextPath}${prefix}'/>/module/cntntsEditor/registModuleCntntsCnFormAjax.do";
	        frm.target = "newScrnCntntsFrm";
	        frm.submit();
        }

    }
	
	/** 컨텐츠 내용 초기화(데이터관리 리스트로 이동) */
	function fn_init(){
		document.cntntsFrm.cntntsCnSeq.value ='';
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/cntntsEditor/selectCntntsCnListAjax.do'
	      , cache : false
	      , async : false
	      , data:$("#cntntsFrm").serialize()
	      , success:function (data) {
	    	  if($('#cntntsVer').val() == '2'){
		    	  $('#cntnts_area_v2').html(data);
		    	  $('#cntnts_area').html('');
	    		  
	    	  }else{
		    	  $('#cntnts_area').html(data);
	    	  }
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
		
		try{
			$(".ui-dialog-content").dialog("close");
		}catch(e){console.log(e.message);}
	}
    
    /** 컨텐츠 내용 - 설정된 템플릿으로 초기화 */
    function fn_registCntntsCnInit(){
        
        if (!confirm('<spring:message code="wzwg.cmm.msg.MSG303" />')) return false;
        
        $.ajax({
              type : 'POST'
            , dataType: 'json'
            , url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/cntntsEditor/registModuleCntntsCnTemplatInitAjax.do'
            , data:$("#cntntsFrm").serialize()
            , success:function (data) {
//                var result = $(data).find('value').text();
                var result = data.head.result;
                
                if (result == 'success') {
                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.applc" /></spring:argument></spring:message>');
                    fnTabChange('dataManage');
                } else {
                    alert('<spring:message code="wzwg.cmm.msg.MSG099" />');
                }
            }
            , error:function (data) {
                alert('<spring:message code="fail.common.msg" text="error" />');
            }
        });
    }

	
</script>
	<c:set var="pageadiAt" value="<%=Globals.CNTNTS_PAGEADI_USEAT %>"/>
	
	<form:form modelAttribute="paramVO" path="cntntsFrm" id="cntntsFrm" name="cntntsFrm" method="post" onsubmit="return false;">
		<form:hidden path="searchCondition"/>
		<form:hidden path="searchKeyword"/>
		<form:hidden path="pageIndex"/>
		<form:hidden path="cntntsSeq"/>
        <input type="hidden" name="sitecntntsSeq" id="sitecntntsSeq" value="<c:out value='${paramVO.sitecntntsSeq}'/>" />
		<input type="hidden" name="tabTyCode" id="tabTyCode" value=""/>
		<input type="hidden" name="cntntsCnSeq" id="cntntsCnSeq"/>
		<input type="hidden" name="cntntsVer" id="cntntsVer" value="<c:out value='${resultVO.cntntsVer}'/>"/>
		
		<!-- 컨텐츠 목록 -->
		<select id="cntntsSelect" name="cntntsSelect" onchange="fnChangeCntntsSeq(this.value);" class="w20">
			<c:forEach var="moduleCntntsList" items="${moduleCntntsList}">
				<option value="<c:out value='${moduleCntntsList.cntntsSeq}'/>|<c:out value='${moduleCntntsList.sitecntntsSeq}'/>" <c:if test="${paramVO.cntntsSeq eq moduleCntntsList.cntntsSeq }">selected="selected"</c:if>><c:out value="${moduleCntntsList.cntntsNm }"/></option>
			</c:forEach>
		</select>
		
		<!-- tab 메뉴 -->
	    <div class="step wztab underLine theme-blue adminIcon">
	    	<ul class="tapMenu wztab-list">
				<li class="wztab-item"><span class="ico-info"></span><a href="javascript:void(0);" onclick="fnTabChange('bassInfo');" 	title="<spring:message code="wzwg.cmm.menu.bassinfo" />" 	id="bassInfo" 	name="bbsTab"><spring:message code="wzwg.cmm.menu.bassinfo" /></a></li>
				<c:if test="${sessionScope.SYSMNGR_AT ne 'Y' and pageadiAt eq 'Y'}">
				<li class="wztab-item"><span class="ico-info"></span><a href="javascript:void(0);" onclick="fnTabChange('cntPagadiEstbs');" title="<spring:message code="wzwg.module.word.addestbs" />" 	id="cntPagadiEstbs" name="bbsTab"><spring:message code="wzwg.module.word.addestbs" /></a></li>
				</c:if>
				<li class="wztab-item"><span class="ico-data"></span><a href="javascript:void(0);" onclick="fnTabChange('dataManage');" 	title="<spring:message code="wzwg.cmm.menu.datamanage" />" 	id="dataManage" name="bbsTab"><spring:message code="wzwg.cmm.menu.datamanage" /></a></li>
				<li class="wztab-item"><span class="ico-auth"></span><a href="javascript:void(0);" onclick="fnTabChange('author');" 		title="권한" 		id="author" 	name="bbsTab"><spring:message code="wzwg.cmm.word.author" /></a></li>
			</ul>
		</div>
	</form:form>
		
		<div id="cntnts_area" class="w100"></div>
		<div id="cntnts_area_v2" class="w100"></div>
	
	