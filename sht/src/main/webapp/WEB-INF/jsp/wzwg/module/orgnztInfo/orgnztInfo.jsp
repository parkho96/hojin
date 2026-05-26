<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<style>
	@media (max-width:599px){
   		td .wzbtn-table + .wzbtn-table { margin-top:0;}
	}	
</style>

<link href="/css/wzwg/module/orgnzt/orgnzt.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="/js/wzwg/cmm/tendina.min.js"></script>
<script type="text/javascript">





$(document).ready(function(){
	fnGetOrgInfoDataList();
	
	$('#orgInfoMemList').show();
	$('#dataMemTable').append('<tbody><tr><td colspan="10" class="txt-c"><spring:message code="wzwg.cmm.module.org.MSG006"/></td></tr></tbody>');
	$('#labelMember').html('<spring:message code="wzwg.cmm.word.orgMberSetting"/>');
})

/* 조직도 목록 */
function fnGetOrgInfoDataList(){
	
	var frm = document.frmOrgInfo;
	
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}" />/mngr/module/orgnztInfo/selectOrgnztInfoDataListAjax.do'
		 , success:function (data) {
			$('#dataList').remove();
			$('#orgInfoTable').append(data);
			
			
			$('.dropGroup').droppable({
				greedy: true,
				classes: {
			        "ui-droppable-hover": "bg-blue"
			      }
			     , drop: function( event, ui ) {

			    	 var dataOrgInfoSeq = $(this).attr('data-orgInfoSeq');
			         fnOrgInfoMemModifyDept(dataOrgInfoSeq, dataOrgMemSeq);
			         
			         var orgnztSeq = frm.orgnztSeq.value; 
			     	 var orgnztNmKr = frm.orgnztNmKr.value;
			     	 var orgnztTySe = frm.orgnztTySe.value;
						
			     	 fnGetOrgInfoMemList(orgnztSeq, orgnztNmKr, orgnztTySe);
			      }
			})
			
			$('.dropGroupCtrd').droppable({
				greedy: true,
				classes: {
			        "ui-droppable-hover": "bg-red br-grey"
			      }
			 	, drop: function( event, ui ) {
			 		//alert('구성원 부서 이동이 불가합니다.');
			 	}
			})
		
		 }//end success
		 , dataType: 'html'
	});
}


/* 구성원 그룹 변경 */
function fnOrgInfoMemModifyDept(orgnztSeq, orgnztmberSeq) {
	var frm = document.frmOrgInfo;
	
	$.ajax({
		type:'POST'
		, url: '<c:out value="${wzwg_contextPath}" />/mngr/module/orgnztInfo/modifyOrgnztInfoMemDeptAjax.do'
		, data: {'orgnztSeq': orgnztSeq, 'orgnztmberSeq': orgnztmberSeq}
		, success:function (data) {
			
			if(data.head.result == 'success'){
				
			}else{
				alert('<spring:message code="wzwg.module.word.mvmnfailr"/>. <spring:message code="wzwg.cmm.msg.MSG331"/>');
			}
		}
	})

}



/* 조직도 추가 */
function fnOrgInfoRegistFrmAjax(orgnztLv, orgnztSeq, orgnztNmKr) {

	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}" />/mngr/module/orgnztInfo/selectOrgnztInfoRegistFrmAjax.do'
		 , data:{'orgnztLv': orgnztLv, 'orgnztSeq': orgnztSeq}
		 , success:function (data) {
			 
			 if(orgnztNmKr != null){
			 	wzAjaxModal('popup_l', '\[' + orgnztNmKr  + '\] <spring:message code="wzwg.module.word.lwprtgroupadd"/>', data);
			 }else{
				wzAjaxModal('popup_l', '\[<spring:message code="wzwg.module.word.firstgroup"/> \] <spring:message code="wzwg.cmm.word.add"/>', data);
			 }
			 
		}
		 , dataType: 'html'
	});
}

/* 조직도 수정 */
function fnOrgInfoModifyFrmAjax(orgnztSeq) {
	
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}" />/mngr/module/orgnztInfo/selectOrgnztInfoModifyFrmAjax.do'
		 , data:{'orgnztSeq': orgnztSeq}
		 , success:function (data) {
			 
			 wzAjaxModal('popup_l', '<spring:message code="wzwg.module.word.orgnztchartupdt"/>', data);
		 }
		 , dataType: 'html'
	});
}



// cmd = 'prev' or 'next'
// btn = this
// 조직도 순서 변경
function fnOrgInfoOrdrChange(cmd, btn){
	
	$.ajax({
		type:'POST'
		, url:'<c:out value="${wzwg_contextPath}" />/mngr/module/orgnztInfo/modifyOrgnztInfoOrdrAjax.do'
		, cache : false
		, async : false
		, data:{
				orgnztSeq : $(btn).attr('data-orgInfoSeq')
				, command : cmd
		}			
		,success:function (data){ 
			
			if(data.head.result == 'update'){
				fnGetOrgInfoDataList();
				
			}else if(data.head.result == 'notOrderby'){
				alert('<spring:message code="wzwg.cmm.module.org.MSG012"/>');
			
			}else{
				alert('<spring:message code="wzwg.module.word.mvmnfailr" />. <spring:message code="wzwg.cmm.msg.MSG331"/>');
			}
		}   
		, error:function (request, status, error) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	     }     
	})
}    



var dataOrgMemSeq = '';

/* 구성원 목록 */
function fnGetOrgInfoMemList(orgnztSeq, orgnztNmKr, orgnztTySe){
	$("#frmOrgInfo #orgnztSeq").val(orgnztSeq);
	$("#frmOrgInfo #orgnztNmKr").val(orgnztNmKr);
	$("#frmOrgInfo #orgnztTySe").val(orgnztTySe);
	
	
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}" />/mngr/module/orgnztInfo/selectOrgnztInfoMemListAjax.do'
		 , data : {'orgnztSeq' : orgnztSeq , 'orgnztNmKr' : orgnztNmKr , 'orgnztTySe' : orgnztTySe}
		 , success:function (data) {
	
			$('#labelMember').html('['  + orgnztNmKr + '] <spring:message code="wzwg.cmm.word.orgMberSetting"/>');
			
			$('#dataMemTable > tbody').remove();
			$('#dataMemTable').append(data);
			
			$('.memListOn').show();
			$('.memListOff').hide();
			
			
			var btnOrdFirst = $('.ordBtns').first().find('button').first();
			var btnOrdLast = $('.ordBtns').last().find('button').last();
			
			btnOrdFirst.attr('disabled', 'disabled');
			btnOrdFirst.css({'cursor' : 'auto', 'color' : 'rgb(204, 204, 204)'});
			btnOrdLast.attr('disabled', 'disabled');
			btnOrdLast.css({'cursor' : 'auto', 'color' : 'rgb(204, 204, 204)'});
			
		
			
			if(orgnztTySe == 'ctrd'){ 
				$('#dataMemTable tr').each(function(){
					$(this).children().eq(4).css('display', 'table-cell');
				});

				$('#btn_orgCode').show();

			}else{
				$('#dataMemTable tr').each(function(){
					//$(this).children().eq(4).css('display', 'none');
				});

				$('#btn_orgCode').hide();
			
				// draggable dept group change event
				$('#dataMemTable .dragMember').draggable({
					  start: function( event, ui ) {
						  dataOrgMemSeq = $(this).attr('data-orgMemSeq');
					  }
					,revert: true
					
				});
			}	 
			  
			$('#orgnztSeq').val(orgnztSeq);
			$('#orgnztNmKr').val(orgnztNmKr);
			$('#orgnztTySe').val(orgnztTySe);
		 }
		 , dataType: 'html'
	});
}


/* 구성원 추가 */
function fnOrgInfoMemRegistFrmAjax() {
	
	var orgnztNmKr = $("#orgnztNmKr").val();
	var orgnztSeq = $("#orgnztSeq").val();
	var orgnztTySe = $("#orgnztTySe").val();
	
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}" />/mngr/module/orgnztInfo/selectOrgnztInfoMemRegistFrmAjax.do'
		 , data:{'orgnztSeq' : orgnztSeq, 'orgnztNmKr' : orgnztNmKr, 'orgnztTySe': orgnztTySe}
		 , success:function (data) {
			 
			 wzAjaxModal('popup_s', '\[' +orgnztNmKr + '\] <spring:message code="wzwg.module.word.constntregist"/>', data);
		 }
		 , dataType: 'html'
	});
}



function fnModifyOrgInfoMemForm(orgnztSeq, orgnztmberSeq, orgnztNmKr, orgnztTySe){
	
	//var formData = $("#frmOrgMem").serialize();
	
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}" />/mngr/module/orgnztInfo/selectOrgnztInfoMemModifyFrmAjax.do'
		 //, data:formData
		 , data: {'orgnztSeq':orgnztSeq, 'orgnztmberSeq':orgnztmberSeq, 'orgnztNmKr':orgnztNmKr, 'orgnztTySe':orgnztTySe}
		 , success:function (data) {
			 wzAjaxModal('popup_s', '\[' +orgnztNmKr + '\] <spring:message code="wzwg.module.word.constntupdt"/>', data);
		 }
		 , dataType: 'html'
	});
	
}

/* 시도 코드 컨트롤러 */
function fnSelectCodeControll(changeCntns){
	var grpCode = 'cityList';
	
	$.ajax({
        type:'POST'
      , url: '<c:out value="${wzwg_contextPath}" />/mngr/module/orgnztInfo/selectOrgnztCodeCntrlAjax.do'
      , cache : false
      , async : false
      , data: {publicCodeGrp : grpCode}
      , success:function (data) {
    	 
    	  if(changeCntns == true){
    		  $('.pop-container').html(data);
    		  
    	  }else{
	    	  var title = '<spring:message code="wzwg.module.word.sidolistset"/>';
	      }
	    
    	  wzAjaxModal('popup_s', title, data);
	    	  
    	 }
      
      , error:function (data) {
          alert('<spring:message code="fail.common.msg" text="error" />');
      }
      , dataType: 'html'
 	});
}


/* 구성원 순서 변경 
   prev:위로, next:아래로 */
function fnOrgMemOrdrChange(cmd, btn){

	$.ajax({
		type:'POST'
		, url:'<c:out value="${wzwg_contextPath}" />/mngr/module/orgnztInfo/modifyOrgnztMemOrdrAjax.do'
		, cache : false
		, async : false
		, data:{
				orgnztmberSeq : $(btn).attr('data-orgMemSeq')
				, command : cmd
		}
		
		,success:function (data){ 
			console.log(data);
			var orgnztSeq = data.body.orgnztInfoVO.orgnztSeq;
			
			if(data.head.result == 'update'){
				
				$.ajax({
					type:'POST'
					, url:'<c:out value="${wzwg_contextPath}" />/mngr/module/orgnztInfo/selectOrgnztInfoAjax.do'
					, cache : false
					, async : false
					, data:{
							orgnztSeq : orgnztSeq
							, command : cmd
					}
					
					,success:function (data){ 
						
						var orgnztNmKr = data.orgnztInfoVO.orgnztNmKr;
						var orgnztTySe = data.orgnztInfoVO.orgnztTySe;
						
						fnGetOrgInfoMemList(orgnztSeq, orgnztNmKr, orgnztTySe);
						
					}
					, error:function (request, status, error) {
				          alert('<spring:message code="fail.common.msg" text="error" />');
					}
				    , dataType: 'json'
				});
				
								
			}else if(data.head.result == 'notOrderby'){
				alert('<spring:message code="wzwg.cmm.module.org.MSG012"/>');
			
			}else{
				alert('<spring:message code="wzwg.module.word.mvmnfailr" />. <spring:message code="wzwg.cmm.msg.MSG331"/>');
			}
		}
		, error:function (request, status, error) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	    }
	});
}

var classNmList = [];

<c:forEach var="list" items="${cssList }" varStatus="c">
	<c:set var="temp_cssNm" value="${fn:escapeXml(list.cssNm)}" />
	classNmList[${c.count -1}] = '${fn:escapeXml(temp_cssNm)}';
</c:forEach>

/*디자인 변경*/
function selectCssStyle(cssSeq, cssNm, btn){
	
	
	for(var i=0; i<classNmList.length; i++) {
		$('#orgnztSet').removeClass(classNmList[i]);
				
	}
	
	if(cssNm != '') {
		$('#orgnztSet').addClass(cssNm);
	}
	
	$('.orgnztStyleList .styleBtn').removeClass('adm_active');
	$(btn).addClass('adm_active');
	$('#cssSeq').val(cssSeq);
	$('#cssClssNm').val(cssNm);

}

/* 디자인 변경 펼치기 */
function orgnztStyleUnfold() {
	$('#orgnztStyleZone').toggle();
}

/* 조직도 디자인 적용 */
function modifyOrgnztEstbs() {
	$.ajax({
		type:'POST'
		, url: '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/orgnztInfo/registOrgnztEstbsAjax.do'
		, data:$("#frmOrgInfo").serialize()
		, success:function (data){ 
			console.log(data);

			if(data.head.result == 'success'){
				alert('<spring:message code="wzwg.cmm.msg.MSG080"/>');
			}else{
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
		}
		, error:function (request, status, error) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	});
}


</script>

	
	<form id="frmOrgInfo" name="frmOrgInfo" method="post">
		<input type="hidden" name="orgnztSeq" id="orgnztSeq" value="<c:out value="${paramVO.orgnztSeq}" />"/>
		<input type="hidden" name="orgnztNmKr" id="orgnztNmKr" value="<c:out value="${paramVO.orgnztNmKr}" />"/>
		<input type="hidden" name="orgnztTySe" id="orgnztTySe" value="<c:out value="${paramVO.orgnztTySe}" />"/>
		<input type="hidden" name="cssSeq" id="cssSeq" value="<c:out value="${orgnztEstbsVO.cssSeq }"/>"/>
		<input type="hidden" name="cssClssNm" id="cssClssNm" value="<c:out value="${orgnztEstbsVO.cssClssNm}" />"/>

		
		
		<div class="wz_notice brbox bg-white br-blue-strong" style="margin:0 0 30px;">
			<!-- <h4 class="admpg-tit2"><spring:message code="wzwg.cmm.msg.tip.MSG095"/></h4> -->
			<ul class="wd100">
				<li class="admpg-subp wd100">· <b><spring:message code="wzwg.cmm.msg.tip.MSG096"/></b></li>
				<li class="admpg-subp wd100 linehgt150 mb0">
					<p>· <span class="btn-plus iconOnlyBtn btn-basic ml0"></span> <spring:message code="wzwg.cmm.msg.tip.MSG099"/> </p>
					<p>· <spring:message code="wzwg.cmm.msg.tip.MSG097"/> </p>
					<p>· <span class="btn-basic iconOnlyBtn btn-sortUp ml0 mr0">▲</span> <span class="btn-basic iconOnlyBtn btn-sortDown ml0">▼</span> <spring:message code="wzwg.cmm.msg.tip.MSG098"/></p>
					<p>· <b>[<spring:message code="wzwg.cmm.word.orgaddsubGrp"/>]</b> : <spring:message code="wzwg.cmm.msg.tip.MSG100"/> <spring:message code="wzwg.cmm.msg.tip.MSG101"/></p>
					<p>· <b>[<spring:message code="wzwg.cmm.word.orgMberSet"/>]</b> : <spring:message code="wzwg.cmm.msg.tip.MSG0980"/></p>
				</li>
			</ul>
		</div>
		
		<h3 class="wzAdmSTit wd100 fl">
			<spring:message code="wzwg.module.word.orgnztchartstrct"/>
		</h3>
		
		
		<!-- 조직도 설정 -->
		<div id ="orgnztSet" class="mngrMenu bg-white pl15 pr15 box-border <c:out value="${orgnztEstbsVO.cssClssNm}" />">
			<table id="orgInfoTable">
			
				<!-- orgInfoList data ajax -->
			
			</table>
		</div>		

		<!-- 디자인 변경 -->
		<h3 class="wzAdmSTit wd100 fl"><spring:message code="wzwg.module.word.designchange"/><button type="button" class="wzbtn-table btn-basic fr fs12" onclick="orgnztStyleUnfold();">▼</button></h3>
		<div id="orgnztStyleZone" class="mb20" style="display:none;">
			<div class="admpg-subp fl txt-l block mb20 wm100 pl20 fl wd100 pb10"><span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.tip.MSG0731" /></div>
			<ul class="orgnztStyleList">
				<c:if test="${empty orgnztEstbsVO.cssClssNm}"><c:set var="selectStyleBg">adm_active</c:set></c:if>
				<li class="wm-auto">
					<button type="button" class="styleBtn <c:out value="${selectStyleBg }" />" onclick="selectCssStyle('', '', this)">
						<div class="orgnztThumb"><img src="/images/wzwg/module/orgnzt/initial.jpg"></div>
						<div class="wz_tableguide fs18"><spring:message code="wzwg.module.word.basicType"/></div>
					</button>
				</li>
				<c:forEach var="list" items="${cssList }">
					<c:set var="selectStyleBg"></c:set>
					<c:if test="${orgnztEstbsVO.cssClssNm eq list.cssNm}"><c:set var="selectStyleBg">adm_active</c:set></c:if>
					<li class="wm-auto">
						<button type="button" class="styleBtn <c:out value="${selectStyleBg }" />" onclick="selectCssStyle('<c:out value="${list.cssSeq}" />', '<c:out value="${list.cssNm}" />', this)">
							<div class="orgnztThumb"><img src="<c:out value="${list.prevewPath }" />"></div>
							<div class="wz_tableguide fs18"><c:out value="${list.cssNm }" /></div>
						</button>
					</li>
				</c:forEach>						
			</ul>
			
			<div class="txt-r box-border pr20 mt20">
				<button type="button"  class="wzbtn btn-save" onclick="modifyOrgnztEstbs()"><spring:message code="wzwg.cmm.word.stre" /></button>
			</div>
		</div>
		
		<!-- 구성원 설정 -->
		<div id="orgInfoMemList" class="bg-white" style="float:left;">	
			<table class="basic">
				<colgroup>
					<col width="20%">
					<col width="80%">
				</colgroup>
				<thead>
				<tr class="wideth">
					<th class="wzAdmSTit" colspan="2"><span id="labelMember"></span></th>
				</tr>
				</thead>
			</table>

		
			<div id="orgInfoMemListArea">
				<div class="cntntsFrm memListOff">
				     <p class="admpg-subp w100 fl"><span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.tip.MSG036" /></p>
				</div>
				<div class="cntntsFrm memListOn" style="display: none;">
				       <p class="admpg-subp w100 fl">
				                <span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.tip.MSG037" /><span class="mt5 pl20 fl wd100"><spring:message code="wzwg.cmm.msg.tip.MSG038" /></span>
				       </p>
				</div>
				<div class="wz-box mb0 br-none bg-white txt-r  memListOn" style="display: none;">
					<button type="button" class="wzbtn btn-basic dp-none" id="btn_orgCode" onclick="fnSelectCodeControll()">
						<spring:message code="wzwg.cmm.word.sido"/>
						<spring:message code="wzwg.cmm.word.list"/>
						<spring:message code="wzwg.cmm.word.set"/>
					</button>
					<button type="button" class="wzbtn btn-save" onclick="fnOrgInfoMemRegistFrmAjax();">
					<spring:message code="wzwg.cmm.word.regist" /></button>
				</div>
				
				<table class="basic-table mt20  memListOn" id="dataMemTable" style="display: none;">
					<thead>
						<tr>
							<th><spring:message code="wzwg.module.word.deptnm" /></th>
							<th><spring:message code="wzwg.cmm.word.nm02" /></th>
							<th><spring:message code="wzwg.cmm.word.rspofc" /></th>
							<th><spring:message code="wzwg.module.word.chrgjob" /></th>
							<th class="mobile-none"><spring:message code="wzwg.cmm.word.cttpc" /></th>
							<th><spring:message code="wzwg.cmm.word.ordr" /></th>
							<th><spring:message code="wzwg.cmm.word.manage"/></th>
						</tr>
					</thead>   
					
						<!-- orgMemList data ajax -->
					
				</table>
				
				
			</div>
		</div>
				
		
	</form>
