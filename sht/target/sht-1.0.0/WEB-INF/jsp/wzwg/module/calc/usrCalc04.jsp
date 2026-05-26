<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<style type="text/css">
table{width: 100%;}
table th{border: solid 1px #aaa;}
table td{border: solid 1px #aaa;}
button {border: solid 1px #aaa;}
</style>


<script>
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

function viewKorean(num) {	
	var hanA = new Array("","일","이","삼","사","오","육","칠","팔","구","십"); 
	var danA = new Array("","십","백","천","","십","백","천","","십","백","천","","십","백","천"); 
	var result = ""; 
	for(i=0; i<num.length; i++) {	
		str = ""; 
		han = hanA[num.charAt(num.length-(i+1))]; 
		if(han != "") str += han+danA[i]; 
		if(i == 4){
			if( (num.length > 8 && num.substring(num.length - 4, num.length - 8) == '0000') == false ){
				str += "만"; 
				//console.log(num.length +'/' + num.substring(num.length - 4, num.length - 8));
			}
				
		}
		if(i == 8){
			if( (num.length > 12 && num.substring(num.length - 8, num.length - 12) == '0000') == false ){
				str += "억"; 
				
			}
		}
		if(i == 12) str += "조"; 
		result = str + result; 
	} 
	
	if(num != 0) result = result + "원";
	
	/* if(num.length > 1 ){
		result = result.substring(1,result.length);
	} */

	return result ; 
}



function loanCalc(){
	var price = exprNumber($('#lnPrice').val());
	var month = $('#lnMonth').val();
	var rate = $('#lnRate').val();
	var loanType = $('#lnType').val();
	
	if(!price || price == '0'){
		alert('대출금액을 입력해 주세요.');
		$('#lnPrice').focus();
		return;
	}
	
	if(exprNumber(price) < 0){
		alert('대출금액이 올바르지 않습니다.');
		$('#lnPrice').val('');
		$('#lnPrice').focus();
		return;
	}
	
	if(!month || month == '0'){
		alert('대출 기간을 입력해 주세요.');
		$('#lnMonth').focus();
		return;
	}
	
	if(exprNumber(month) < 0){
		alert('대출기간 올바르지 않습니다.');
		$('#lnMonth').val('');
		$('#lnMonth').focus();
		return;
	}
	
	if(!rate || rate == '0'){
		alert('대출 이율을 입력해 주세요.');
		$('#lnRate').focus();
		return;
	}
	
	if(exprNumber(rate) < 0){
		alert('대출 이율이 올바르지 않습니다.');
		$('#lnRate').val('');
		$('#lnRate').focus();
		return;
	}
	
	
	var loanType = $('#lnType').val();
	
	price    = parseInt(price   );
	month    = parseInt(month   );
	rate     = parseFloat(rate    );
	loanType = parseInt(loanType);
	//console.log(price + '/' + month + '/' + rate);
	
	resultViewClear();
	
	var rateP = rate / 12 / 100;
	
	if(loanType == '1'){
		//console.log(rateP);
		var mm = price * rateP * (Math.pow((1+ rateP) , month));
		//console.log(mm);
		var nn = Math.pow((1 + rateP) , month) -1;
		//console.log(nn);
		var mp = mm/nn;
		//console.log(parseInt(mp));
		
		var monthPrice = price * rateP * Math.pow((1 + rateP) , month) / ( Math.pow((1 + rateP) , month) -1);
		               // =C2  *  C3  /12 * (1 + C3   / 12) ^  C4   / ((1 +  C3  / 12) ^ C4    -1)
		//var monthPrice2 = price + '*' + rate + '/' + 12 + '*' + '(' + 1 + '+' + rate + '/' + 12 + ')' + '^' + month + '/' + '((1 +' + rate + '/ 12) ^' + month + ' -1)';
		//console.log(monthPrice);
		//console.log(monthPrice2);
		loanType1Calc(monthPrice, rateP, month, price);
	}else if(loanType == '2'){
		loanType2Calc(rateP, month, price);
	}else if(loanType == '3'){
		loanType3Calc(rateP, month, price);
	}
	
}

function loanType1Calc(monthPrice, rate, month, price ){
	var sumPrice = price; //대출잔액
	var sumOnePrice = 0; //원금누계
	var sumEja = 0;
	$('.lnTempTr').remove();
	
	for(var i = 1 ; i <= month; i++ ){
		var _rate = sumPrice * rate;
		var _onePrice = monthPrice - _rate;
		//console.log(monthPrice + ' - ' + _rate + ' = ' + (monthPrice - _rate) + ' : ' + _onePrice);
		sumOnePrice += _onePrice;
		sumPrice -= _onePrice;
		//console.log(sumPrice);
		sumEja += _rate; 
		var row = '';
		if(i % 12 == 0){
			row += ' <tr class="lnTempTr line12">           ';
		}else{
			row += ' <tr class="lnTempTr">           ';
		}
		row += ' 	<td>' + i + '</td>   ';
		row += ' 	<td>' + setComma(Math.round(monthPrice)) + '원</td>   '; //월 상환액
		row += ' 	<td>' + setComma(Math.round(_onePrice)) + '원</td>   '; //원금
		row += ' 	<td>' + setComma(Math.round(_rate)) + '원</td>   '; //이자
		row += ' 	<td>' + setComma(Math.round(sumOnePrice)) + '원</td>   '; //원금누계
		row += ' 	<td>' + setComma(Math.round(sumPrice)) + '원</td>   '; //대출잔액
		row += ' </tr>          ';
		
		
		
		$('#loanResultType1').append(row);
	}
	
	//summary
	$('#loan1Price').html(setComma(Math.round(price)) + '원');
	$('#loan1Month').html(setComma(month) + '개월');
	$('#loan1OnePrice').html(setComma(Math.round(monthPrice)) + '원');
	$('#loan1Eja').html(setComma(Math.round(sumEja)) + '원');
	$('#loan1TotalPrice').html(setComma(Math.round(monthPrice * month)) + '원');
	
	$('#loanAreaType1').show();
}

function loanType2Calc(rate, month, price){
	var sumPrice = price; //대출잔액
	var sumOnePrice = 0; //원금누계
	var sumEja = 0;
	var _onePrice = 0; //월 상환원금
	$('.lnTempTr').remove();
	
	for(var i = 1 ; i <= month; i++ ){
		var monthPrice = (price / month) + (sumPrice * rate);
		//console.log(monthPrice);
		var _rate = sumPrice * rate;
		_onePrice = monthPrice - _rate;
		//console.log(monthPrice + ' - ' + _rate + ' = ' + (monthPrice - _rate) + ' : ' + _onePrice);
		sumOnePrice += _onePrice;
		sumPrice -= _onePrice;
		//console.log(sumPrice);
		sumEja += _rate; 
		var row = '';
		if(i % 12 == 0){
			row += ' <tr class="lnTempTr line12">           ';
		}else{
			row += ' <tr class="lnTempTr">           ';
		}
		row += ' 	<td>' + i + '</td>   ';
		row += ' 	<td>' + setComma(Math.round(monthPrice)) + '원</td>   '; //월 상환액
		row += ' 	<td>' + setComma(Math.round(_onePrice)) + '원</td>   '; //원금
		row += ' 	<td>' + setComma(Math.round(_rate)) + '원</td>   '; //이자
		row += ' 	<td>' + setComma(Math.round(sumOnePrice)) + '원</td>   '; //원금누계
		row += ' 	<td>' + setComma(Math.round(sumPrice)) + '원</td>   '; //대출잔액
		row += ' </tr>          ';
		
		
		
		$('#loanResultType2').append(row);
	}
	
	//summary
	$('#loan2Price').html(setComma(Math.round(price)) + '원');
	$('#loan2Month').html(setComma(month) + '개월');
	$('#loan2OnePrice').html(setComma(Math.round(_onePrice)) + '원');
	$('#loan2Eja').html(setComma(Math.round(sumEja)) + '원');
	$('#loan2TotalPrice').html(setComma(Math.round(price + sumEja)) + '원');
	
	$('#loanAreaType2').show();
}

function loanType3Calc(rate, month, price){
	var sumPrice = price; //대출잔액
	var _oneEja = price * rate; //월 상환원금
	var sumEja = _oneEja * month;
	$('.lnTempTr').remove();
	
	
	
	//summary
	$('#loan3Price').html(setComma(Math.round(price)) + '원');
	$('#loan3Month').html(setComma(month) + '개월');
	$('#loan3OneEja').html(setComma(Math.round(_oneEja)) + '원');
	$('#loan3Eja').html(setComma(Math.round(sumEja)) + '원');
	$('#loan3TotalPrice').html(setComma(Math.round(price + sumEja)) + '원');
	
	$('#loanAreaType3').show();
}

function lnResultViewToggle(viewId, btn){
	//console.log($('#' + viewId).css('height'));
	
	var contentsHeight = parseInt(exprNumber($('#' + viewId).find('table').css('height')));
	
	
	if(contentsHeight < 325){
		return;
	}else{
		contentsHeight += 60;
	}
	//console.log(contentsHeight);
	
	if($('#' + viewId).css('height') == '325px'){
		$('#' + viewId).animate({height: contentsHeight});
		$(btn).html('접기');
	}else{
		$('#' + viewId).animate({height: '325px'});
		$(btn).html('펼쳐보기');
	}
}

var inp = $('#lnPrice');
function viewPriceKr(){
	if(inp.val() == ''){
		$('#lnPriceKr').html('');
	}
	
	var num = exprNumber(inp.val());
	//console.log(num);

	if(num == -1){
		$('#lnPriceKr').html('');
		return;
	}
	
	var kr = viewKorean(num);
	$('#lnPriceKr').html(kr);
	
}

function viewPriceComma(){
	if(inp.val() == ''){
		return;
	}
	try{
		//console.log(inp.val());
		var num = exprNumber(inp.val());
		var val = setComma(num);
		//console.log(num + '/' + val);
		inp.val(val);
	}catch(e){
		console.log(e);
	}
	
}

function resultViewClear(){
	$('#loanAreaType1').hide();
	$('#loanAreaType2').hide();
	$('#loanAreaType3').hide();
}

function inputClear(id){
	$('#' + id).val('');
}

function inputValue(id, val){
	$('#' + id).val(val);	
}

function inputSumValue(id, val){
	var v = parseInt($('#' + id).val() * 1000);
	if(!v) v=0;
	val = parseInt(val * 1000);
	var sum = v + val;
	$('#' + id).val(sum/1000);
	//console.log(v + '/' + val + ":" + (v+val));
}

function userInputClear(){
	resultViewClear();
	inputClear('lnPrice');
	inputClear('lnMonth');
	inputClear('lnRate');
}

$(document).ready(function(){ 
	inp = $('#lnPrice');
	setInterval(viewPriceKr, 1000);
	setInterval(viewPriceComma, 0);
});
</script>

<div id="calcContents">


	<c:choose>
		<c:when test="${paramVO.calcType eq result.calcType and not empty result.calcCn}"><c:out value="${result.calcCn }"/></c:when>
		<c:when test="${userMode and not empty result.calcCn}"><c:out value="${result.calcCn }"/></c:when>
		<c:otherwise>
		
			<!-- 서브콘텐츠 대출계산기01 -->
			<div class="subCon_carcul02">
				<!-- 사용자 입력칸 -->
				<div> 
					<table class="btn_table" border="1" cellpadding="0" cellspacing="0">
						<tbody>
						<tr>
							<th>대출금액</th>
							<td>
								<input type="text" maxlength="18" value="1000000" id="lnPrice" onkeyup="viewPriceKr(this)"> <strong>원</strong>
								<br><span id="lnPriceKr">일백만원</span>
							</td>
							<td>입력예시) <span class="small">클릭하면 적용됩니다.</span><br>
								<input type="button" value="100만" onclick="inputValue('lnPrice',1000000)">
								<input type="button" value="500만" onclick="inputValue('lnPrice',5000000)">
								<input type="button" value="1,000만" onclick="inputValue('lnPrice',10000000)">
								<input type="button" value="5,000만" onclick="inputValue('lnPrice',50000000)">
								<input type="button" value="1억" onclick="inputValue('lnPrice',100000000)">
								<input type="button" value="정정" onclick="inputClear('lnPrice')">
							</td>
						</tr>
						<tr>
							<th>대출기간</th>
							<td>
								<input type="text" value="12" maxlength="3" id="lnMonth"> <strong>개월</strong>
							</td>
							<td>입력예시) <span class="small">클릭하면 적용됩니다.</span><br>
								<input type="button" value="6개월" onclick="inputValue('lnMonth',6)">
								<input type="button" value="1년" onclick="inputValue('lnMonth',12)">
								<input type="button" value="2년" onclick="inputValue('lnMonth',24)">
								<input type="button" value="3년" onclick="inputValue('lnMonth',36)">
								<input type="button" value="5년" onclick="inputValue('lnMonth',60)">
								<input type="button" value="10년" onclick="inputValue('lnMonth',120)">
								<input type="button" value="20년" onclick="inputValue('lnMonth',240)">
								<input type="button" value="30년" onclick="inputValue('lnMonth',360)">
								<input type="button" value="정정" onclick="inputClear('lnMonth')">
							</td>
						</tr>
						<tr>
							<th>대출금리</th>
							<td>
								<input type="text" id="lnRate" value="3.5"> <strong>%</strong>
							</td>
							<td>입력예시) <span class="small">클릭하면 적용됩니다.</span><br>
								<input type="button" value="+5"  onclick="inputSumValue('lnRate', 5)">
								<input type="button" value="+1"    onclick="inputSumValue('lnRate', 1)">
								<input type="button" value="+0.1"  onclick="inputSumValue('lnRate', 0.1)">
								<input type="button" value="+0.01" onclick="inputSumValue('lnRate', 0.01)">
								<input type="button" value="-1"    onclick="inputSumValue('lnRate', -1)">
								<input type="button" value="-0.1"  onclick="inputSumValue('lnRate', -0.1)">
								<input type="button" value="-0.01" onclick="inputSumValue('lnRate', -0.01)">
								<input type="button" value="정정" onclick="inputClear('lnRate')">
							</td>
						</tr>
						<tr>
							<th>상환방식</th>
							<td colspan="2">
								<select id="lnType">
									<option value="1">원금이자 균등 상환방식</option>
									<option value="2">원금 균등 상환방식</option>
									<option value="3">만기 일시 상환방식</option>
								</select>
							</td>
						</tr>
						</tbody>
					</table>
					<div class="text-center">
						<button type="button" onclick="loanCalc()">계산하기</button>
						<button type="button" onclick="userInputClear()"><spring:message code="wzwg.cmm.word.initl" /></button>
					</div>
				</div><!-- 사용자 입력칸 끝 -->



					<!-- 원리금 균등 결과 -->			
					<div id="loanAreaType1" style="display:none;">
						<div class="tit">요약</div>
						<table class="cal_result01" border="1" cellpadding="0" cellspacing="0">
							<tbody>
								<tr>
									<th>대출금액</th>
									<th>대출기간</th>
									<th>월상환액</th>
									<th>총이자</th>
									<th>총상환액</th>
								</tr>
								<tr>
									<td id="loan1Price"></td>
									<td id="loan1Month"></td>
									<td id="loan1OnePrice"></td>
									<td id="loan1Eja"></td>
									<td id="loan1TotalPrice"></td>
								</tr>
							</tbody>
						</table>
						
						<div id="loanResultView1" >
						<div class="tit">계산결과</div>
							<table class="cal_result01 cal_result01_1" border="1" cellpadding="0" cellspacing="0">
							<tbody id="loanResultType1">
								<tr>
									<th>회차(월)</th>
									<th>상환금액</th>
									<th>원금</th>
									<th>이자</th>
									<th>납입원금계</th>
									<th>대출 잔액</th>
								</tr>
								<!-- 샘플 -->
								<!--   
								<tr class="lnTempTr">
									<td>1</td>
									<td>849,216,298원</td>
									<td>820,049,632원</td>
									<td>29,166,667원</td>
									<td>820,049,632원</td>
									<td>9,179,950,368원</td>
								</tr>
								<tr class="lnTempTr">
									<td>2</td>
									<td>849,216,298원</td>
									<td>822,441,443원</td>
									<td>26,774,855원</td>
									<td>1,642,491,075원</td>
									<td>8,357,508,925원</td>
								</tr>
								<tr class="lnTempTr">
									<td>3</td>
									<td>849,216,298원</td>
									<td>824,840,231원</td>
									<td>24,376,068원</td>
									<td>2,467,331,306원</td>
									<td>7,532,668,694원</td>
								</tr>
								<tr class="lnTempTr">
									<td>4</td>
									<td>849,216,298원</td>
									<td>827,246,015원</td>
									<td>21,970,284원</td>
									<td>3,294,577,320원</td>
									<td>6,705,422,680원</td>
								</tr>
								<tr class="lnTempTr">
									<td>5</td>
									<td>849,216,298원</td>
									<td>829,658,816원</td>
									<td>19,557,483원</td>
									<td>4,124,236,136원</td>
									<td>5,875,763,864원</td>
								</tr>
								<tr class="lnTempTr">
									<td>6</td>
									<td>849,216,298원</td>
									<td>832,078,654원</td>
									<td>17,137,645원</td>
									<td>4,956,314,790원</td>
									<td>5,043,685,210원</td>
								</tr>
								<tr class="lnTempTr">
									<td>7</td>
									<td>849,216,298원</td>
									<td>834,505,550원</td>
									<td>14,710,749원</td>
									<td>5,790,820,340원</td>
									<td>4,209,179,660원</td>
								</tr>
								<tr class="lnTempTr">
									<td>8</td>
									<td>849,216,298원</td>
									<td>836,939,524원</td>
									<td>12,276,774원</td>
									<td>6,627,759,864원</td>
									<td>3,372,240,136원</td>
								</tr>
								<tr class="lnTempTr">
									<td>9</td>
									<td>849,216,298원</td>
									<td>839,380,598원</td>
									<td>9,835,700원</td>
									<td>7,467,140,462원</td>
									<td>2,532,859,538원</td>
								</tr>
								<tr class="lnTempTr">
									<td>10</td>
									<td>849,216,298원</td>
									<td>841,828,791원</td>
									<td>7,387,507원</td>
									<td>8,308,969,254원</td>
									<td>1,691,030,746원</td>
								</tr>
								<tr class="lnTempTr">
									<td>11</td>
									<td>849,216,298원</td>
									<td>844,284,125원</td>
									<td>4,932,173원</td>
									<td>9,153,253,379원</td>
									<td>846,746,621원</td>
								</tr>
								<tr class="lnTempTr line12">
									<td>12</td>
									<td>849,216,298원</td>
									<td>846,746,621원</td>
									<td>2,469,678원</td>
									<td>10,000,000,000원</td>
									<td>0원</td>
								</tr> -->
							</tbody>
						</table>
						</div>
						<div class="readmore_btn">
							<button type="button" onclick="lnResultViewToggle('loanResultView1', this)">펼쳐보기</button>
						</div>
					</div><!-- 원리금 균등 결과 끝 -->
					

					<!-- 원금 균등 결과 -->
					<div id="loanAreaType2" style="display:none;">
						<div class="tit">요약</div>
						<table class="cal_result01" border="1" cellpadding="0" cellspacing="0">
							<tbody>
								<tr>
									<th>대출금액</th>
									<th>대출기간</th>
									<th>월상환원금</th>
									<th>총이자</th>
									<th>총상환액</th>
								</tr>
								<tr>
									<td id="loan2Price"></td>
									<td id="loan2Month"></td>
									<td id="loan2OnePrice"></td>
									<td id="loan2Eja"></td>
									<td id="loan2TotalPrice"></td>
								</tr>
							</tbody>
						</table>
						
						<div id="loanResultView2">
						<div class="tit">계산결과</div>
							<table class="cal_result01" border="1" cellpadding="0" cellspacing="0">
								<tbody id="loanResultType2">
									<tr>
										<th>회차(월)</th>
										<th>상환금액</th>
										<th>원금</th>
										<th>이자</th>
										<th>납입원금계</th>
										<th>대출 잔액</th>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="readmore_btn">
							<button type="button" onclick="lnResultViewToggle('loanResultView2', this)">펼쳐보기</button>
						</div>
					</div><!-- 원금 균등 결과 끝 -->
					
					<!-- 만기상환 결과 -->
					<div id="loanAreaType3" style="display:none;">
						<div class="tit">요약</div>
						<table class="cal_result01" border="1" cellpadding="0" cellspacing="0">
							<tbody>
								<tr>
									<th>대출금액</th>
									<th>대출기간</th>
									<th>월이자</th>
									<th>총이자</th>
									<th>총상환액</th>
								</tr>
								<tr>
									<td id="loan3Price"></td>
									<td id="loan3Month"></td>
									<td id="loan3OneEja"></td>
									<td id="loan3Eja"></td>
									<td id="loan3TotalPrice"></td>
								</tr>
							</tbody>
						</table>
					</div><!-- 만기상환 결과 끝 -->
					
				</div>
		
		
		
		
		
		</c:otherwise>
	</c:choose>
</div>