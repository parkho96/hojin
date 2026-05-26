<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<link rel="stylesheet" href="/css/wzwg/cmm/jquery-ui.css">
<script type="text/javascript" src="/js/wzwg/cmm/jquery-ui.js"></script>


<style type="text/css">
/* table{width: 100%;}
table th{border: solid 1px #aaa;}
table td{border: solid 1px #aaa;}
button {border: solid 1px #aaa;}
 */
.tab-calc {border: none !important;}
.tab-calc > ul {background: #fff; border: none;}
.tab-calc > ul > div {border: solid 1px #c5c5c5;}
.tab-calc > ul > div > a {border: 1px solid #a1a1a1; background: #a1a1a1;}
.tab-calc > ul > li.ui-tab {border: 1px solid #a1a1a1; background: #fff; border-radius: 3px;}
.tab-calc > ul > li.ui-tab:hover {background: #f6f6f6;}
.tab-calc > ul > li.ui-tab.ui-tabs-active {border: 1px solid #a1a1a1; background: #a1a1a1;}

.ui-tabs .ui-tabs-nav li.ui-tabs-active {margin-bottom: 0px; padding-bottom: 0px;}

</style>
<!-- 
.ui-tabs .ui-tabs-panel {
   /* border: solid 1px #c5c5c5; */
}
.ui-tabs a:fucus{
outline: none;
}
.ui-state-active a, .ui-state-active a:link, .ui-state-active a:visited {
    outline: none;
}
.ui-state-active a, .ui-state-active a:link, .ui-state-active a:focus {
    outline: none;
}
.ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active, a.ui-button:active, .ui-button:active, .ui-button.ui-state-active:hover {
    border: 1px solid #a1a1a1;
    background: #a1a1a1;
    font-weight: normal;
    color: #ffffff;
}

.ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default, .ui-button, html .ui-button.ui-state-disabled:hover, html .ui-button.ui-state-disabled:active {
    background: #fff;
    outline: none;
}

 -->
<%-- ${not empty result.calcCn}
${paramVO.calcType eq result.calcType}
${userMode } --%>

<script>
var tax014 = parseFloat('<c:out value="${1 - (param.taxFree / 100)}"/>'); //0.986; // 1.4%
var tax095 = parseFloat('<c:out value="${1 - (param.taxPref / 100)}"/>'); //0.905; // 9.5%
var tax165 = parseFloat('<c:out value="${1 - (param.taxNomal / 100)}"/>'); //0.846; // 16.5%

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
function exprNumber(str) {
//	return str.replace(/[^0-9]/g,'');	// 숫자외 나머지 필터
//	return str.replace(/[^-\.0-9]/g,''); // 음수부호(-), 소수점(.), 숫자외 나머지 필터
	str += '';
	var t = str.replace(/[^-\.0-9]/g,'');
	if(!t){
		return -1;
	}else{
		return t;
	}
} 


function calc1(){
	var price = exprNumber($('#inp-a').val());
	if(price == ''){
		alert('금액을 입력해 주세요');
		$('#inp-a').focus();
		return;
	}
	
	price = parseInt(price);
	
	clac1Process($('#a-row-3'), price);
	clac1Process($('#a-row-6'), price);
	clac1Process($('#a-row-12'), price);
	clac1Process($('#a-row-24'), price);
	clac1Process($('#a-row-36'), price);
	
	
}

function clac1Process(row, price){
	
	var rate = $($(row).find('.rate')[0]).html();
	
	var reteP = parseFloat(rate/100);
	var month = parseInt($(row).attr('data-month'));
	
	var eja = price * reteP * month / 12
	
	row.children().each(function(idx,el){
		if(idx < 2){
			return;
		}
		
		if(idx == 2){
			var c = eja / month;
			$(el).html(setComma(parseInt(c)) + '원');
		}
		if(idx == 3){
			var c = (eja / month) * tax014; //0.986;
			$(el).html(setComma(parseInt(c)) + '원');
		}
		if(idx == 4){
			var c = (eja / month) * tax165; //0.846;
			$(el).html(setComma(parseInt(c)) + '원');
		}
		if(idx == 5){
			$(el).html(setComma(parseInt(eja)) + '원');
		}
		//console.log(el);
	})
}

function calc2(){
	var price = exprNumber($('#inp-b').val());
	if(price == ''){
		alert('금액을 입력해 주세요');
		$('#inp-b').focus();
		return;
	}
	
	price = parseInt(price);
	
	clac2Process($('#b-row-12'), price);
	clac2Process($('#b-row-24'), price);
	clac2Process($('#b-row-36'), price);
	
	
}

function clac2Process(row, price){
	
	var rate = $($(row).find('.rate')[0]).html();
	
	var rateP = parseFloat((rate/100)/12);
	var month = parseInt($(row).attr('data-month'));
	
	//월불입
	var monPrice = price / (month + ((( month * (month + 1)) /2) * rateP ));
	var eja = monPrice * (( month * (month + 1)) /2) * rateP; 
	
	row.children().each(function(idx,el){
		if(idx < 2){
			return;
		}
		
		if(idx == 2){
			$(el).html(setComma(parseInt(monPrice)) + '원');
		}
		if(idx == 3){
			$(el).html(setComma(parseInt(eja)) + '원');
		}
		if(idx == 4){
			var c = eja * tax014; //0.986;
			$(el).html(setComma(parseInt(c)) + '원');
		}
		if(idx == 5){
			var c = eja * tax165; //0.846;
			$(el).html(setComma(parseInt(c)) + '원');
		}
		//console.log(el);
	})
}

function calc3(){
	var price = exprNumber($('#inp-c').val());
	if(price == ''){
		alert('금액을 입력해 주세요');
		$('#inp-c').focus();
		return;
	}
	
	price = parseInt(price);
	
	clac3Process($('#c-row-12'), price);
	clac3Process($('#c-row-24'), price);
	clac3Process($('#c-row-36'), price);
	
}

function clac3Process(row, price){
	
	var rate = $($(row).find('.rate')[0]).html();
	
	var reteP = parseFloat(rate/100);
	var month = parseInt($(row).attr('data-month'));
	
	var eja = price * reteP * (month * (month + 1))/2/12;
	
	console.log('eja = ' + price + '*' + reteP + '*' + '(' + month + '*' + '(' + month + '+' + 1 + '))' + '/' + 2 + '/' +12);
	console.log(eja);
	var totalPrice = price * month; 
	
	row.children().each(function(idx,el){
		if(idx < 2){
			return;
		}
		
		if(idx == 2){
			var c = eja + totalPrice;
			$(el).html(setComma(parseInt(c)) + '원');
		}
		if(idx == 3){
			var c = totalPrice + (eja * tax014); // 0.986
			$(el).html(setComma(parseInt(c)) + '원');
		}
		if(idx == 4){
			var c = totalPrice + (eja * tax095); // 0.905
			$(el).html(setComma(parseInt(c)) + '원');
		}
		if(idx == 5){
			$(el).html(setComma(parseInt(totalPrice)) + '원');
		}
		//console.log(el);
	})
}


//금액란 콤마 자동화

var inpA = $('#inp-a');
var inpB = $('#inp-b');
var inpC = $('#inp-c');
function viewPriceCommaA(){
	if(inpA.val() == ''){
		return;
	}
	try{
		//console.log(inp.val());
		var num = exprNumber(inpA.val());
		var val = setComma(num);
		//console.log(num + '/' + val);
		inpA.val(val);
	}catch(e){
		console.log(e);
	}
	
}
function viewPriceCommaB(){
	if(inpB.val() == ''){
		return;
	}
	try{
		//console.log(inp.val());
		var num = exprNumber(inpB.val());
		var val = setComma(num);
		//console.log(num + '/' + val);
		inpB.val(val);
	}catch(e){
		console.log(e);
	}
	
}
function viewPriceCommaC(){
	if(inpC.val() == ''){
		return;
	}
	try{
		//console.log(inp.val());
		var num = exprNumber(inpC.val());
		var val = setComma(num);
		//console.log(num + '/' + val);
		inpC.val(val);
	}catch(e){
		console.log(e);
	}
	
}


$(document).ready(function(){ 
	inpA = $('#inp-a');  
	inpB = $('#inp-b');  
	inpC = $('#inp-c');  
	setInterval(viewPriceCommaA, 0);
	setInterval(viewPriceCommaB, 0);
	setInterval(viewPriceCommaC, 0);
	
	 $( "#tabs" ).tabs();
});
</script>

<div id="calcContents">


	<c:choose>
		<c:when test="${paramVO.calcType eq result.calcType and not empty result.calcCn}"><c:out value="${result.calcCn }"/></c:when>
		<c:when test="${userMode and not empty result.calcCn}"><c:out value="${result.calcCn }"/></c:when>
		<c:otherwise>
		
		
		<div id="tabs" class="tab-calc">
		  <ul>
		    <li><a href="#tabs-1">정기예탁금</a></li>
		    <li><a href="#tabs-2">정기적금 - 계약금기준</a></li>
		    <li><a href="#tabs-3">정기적금 - 월불입금기준</a></li>
		  </ul>
		  <div id="tabs-1">
			    <div class="subCon_carcul01" style="float:none;">
					<div class="tit">
						<h3>정기예탁금</h3>	
						<div class="div_inputbtn">
							<span>예치금액 : </span>
							<input name="a" id="inp-a" type="text">
							<button type="button" onclick="calc1();">계산하기</button>
						</div>
					</div>
					<div class="calculator" style="float:none;">
						<table border="1" cellpadding="0" cellspacing="0">
							<thead>
								<tr>
									<th rowspan="2" width="100px;">개월</th>
									<td rowspan="2">이율</td>
									<td colspan="3">월지급식(이자)</td>
									<td rowspan="2">만기지급식<br>
									(세전이자)</td>
								</tr>
								<tr>
									<td>비과세 종합</td>
									<td>비과세</td>
									<td>과세</td>
								</tr>
							</thead>
							<tbody>
								<tr id="a-row-3" data-month="3">
									<th><div>3개월</div></th>
									<td><div><span class="edt_text rate">1.4</span>%</div></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
								</tr>
								<tr id="a-row-6" data-month="6">
									<th><div>6개월</div></th>
									<td><div><span class="edt_text rate">1.7</span>%</div></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
								</tr>
								<tr id="a-row-12" data-month="12">
									<th><div>12개월</div></th>
									<td><div><span class="edt_text rate">1.95</span>%</div></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
								</tr>
								<tr id="a-row-24" data-month="24">
									<th><div>24개월</div></th>
									<td><div><span class="edt_text rate">2.0</span>%</div></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
								</tr>
								<tr id="a-row-36" data-month="36">
									<th><div>36개월</div></th>
									<td><div><span class="edt_text rate">2.0</span>%</div></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
		  </div>
		  
		  
		  
		  
		  <div id="tabs-2">
			    <div class="subCon_carcul01" style="float:none;">
					<div class="tit">
						<h3>정기적금 - 계약금기준</h3>	
						<div class="div_inputbtn">
							<span>계약금액 : </span>
							<input name="inp-b" id="inp-b" type="text">
							<button type="button" onclick="calc2();">계산하기</button>
						</div>
					</div>
					<div class="calculator" style="float:none;">
						<table border="1" cellpadding="0" cellspacing="0">
							<thead>
								<tr>
									<th rowspan="2" width="100px;">개월</th>
									<td rowspan="2">이율</td>
									<td rowspan="2">월불입</td>
									<td colspan="3" style="border-bottom:1px solid #ebeced;">이자</td>
								</tr>
								<tr>
									<td>비과세 종합저축</td>
									<td>비과세</td>
				 
									<td>과세</td>
								</tr>
							</thead>
							<tbody>
								<tr id="b-row-12" data-month="12">
									<th><div>12개월</div></th>
									<td><div><span class="edt_text rate">2.1</span>%</div></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
								</tr>
								<tr id="b-row-24" data-month="24">
									<th class="a_Center"><div>24개월</div></th>
									<td><div><span class="edt_text rate">2.1</span>%</div></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
								</tr>
								<tr id="b-row-36" data-month="36">
									<th><div>36개월</div></th>
									<td><div><span class="edt_text rate">2.1</span>%</div></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
								</tr>
							</tbody>
						</table>
					</div>	
				</div>	
		  </div>
		  
		  
		  
		  
		  
		  <div id="tabs-3">
			    <div class="subCon_carcul01" style="float:none;">
					<div class="tit">
						<h3>정기적금 - 월불입금기준</h3>	
						<div class="div_inputbtn">
							<span>계약금액 :</span>
							<input name="inp-c" id="inp-c" type="text">
							<button type="button" onclick="calc3();">계산하기</button>
						</div>
					</div>
					<div class="calculator" style="float:none;">
						<table border="1" cellpadding="0" cellspacing="0">
							<thead>
								<tr>
									<th rowspan="2" width="100px;">개월</th>
									<td rowspan="2">이율</td>
									<td colspan="3" style="border-bottom:1px solid #ebeced;">만기수령금액</td>
									<td rowspan="2">본인납입총액</td>
								</tr>
								<tr>
									<td>비과세 종합저축</td>
									<td>비과세</td>
									<td>과세</td>
								</tr>
							</thead>
							<tbody>
								<tr id="c-row-12" data-month="12">
									<th><div>12개월</div></th>
									<td><div><span class="edt_text rate">2.1</span>%</div></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
								</tr>
								<tr id="c-row-24" data-month="24">
									<th><div>24개월</div></th>
									<td><div><span class="edt_text rate">2.1</span>%</div></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
								</tr>
								<tr id="c-row-36" data-month="36">
									<th><div>36개월</div></th>
									<td><div><span class="edt_text rate">2.1</span>%</div></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
									<td class="edtClean"></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
		  </div>
		  
		  
		  
		  
		</div>
		
		
		</c:otherwise>
	</c:choose>
</div>