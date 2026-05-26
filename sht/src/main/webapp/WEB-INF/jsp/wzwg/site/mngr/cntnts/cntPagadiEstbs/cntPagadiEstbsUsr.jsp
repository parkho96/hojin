<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<%@ page trimDirectiveWhitespaces="true" %>

	<c:choose>
		<c:when test="${fn:length(oclhgList) > 0 or cpyrhtVO.useAt eq 'Y' or evlEstbsVO.useAt eq 'Y' }">
		<c:set var="isCntPAgAdiEstbs" value="true"></c:set>
		</c:when>
		
		<c:otherwise><c:set var="isCntPAgAdiEstbs" value="false"></c:set></c:otherwise>
	</c:choose>
	<%-- ${pageadiEstbsVO }<br>
	${fn:length(oclhgList) }<br>
	${cpyrhtVO.useAt}<br>
	${evlEstbsVO.useAt}<br>
	[isCntPAgAdiEstbs] : ${isCntPAgAdiEstbs}<br> --%>
	
	<c:if test="${isCntPAgAdiEstbs}">
	<script>
	$(document).ready(function(){
		if('<c:out value="${pageadiEstbsVO.sysmoduleSeq}"/>' == '10000000105' || '<c:out value="${pageadiEstbsVO.sysmoduleSeq}"/>' == '10000000216') {
			$('.mnginfo').removeClass('boardinfo');
		}
	});
	
	function fnRegistCntntsRating(){
		//alert('<c:out value="${paramVO.cntntsSeq}"/>');
		var evlScore = $('input[name="evlScore"]:checked');
		
		if(evlScore.length == 0){
			alert('<spring:message code="wzwg.cmm.cncnts.pagad.MSG001"/>');
			return;
		}

		if($('#evlOpinion').length){
			if($('#evlOpinion').val().length > 100){
				var evlOpinion = $('#evlOpinion').val();
				$('#evlOpinion').val(evlOpinion.substring(0,100));
				alert('<spring:message code="wzwg.cmm.cncnts.pagad.MSG006"/>');
				return;
			} 
		}
		
        $.ajax({
              type : 'POST'
            , dataType: 'html'
            , url : '<c:out value="${wzwg_contextPath}"/>/usr/cntnts/cntPagadiEstbs/registEvlScoreAjax.do'
            , cache : false
            , async : false
            , data:{
            		  pagadiestbsSeq: '<c:out value="${pageadiEstbsVO.pagadiestbsSeq}"/>'
            		, sitecntntsSeq : '<c:out value="${pageadiEstbsVO.sitecntntsSeq }"/>'
            		, evlScore : evlScore.val()
            		, evlOpinion : $('#evlOpinion').val()
            		}
            , success:function (data) {
                if(data.head.result == 'success'){
                	alert('<spring:message code="wzwg.cmm.cncnts.pagad.MSG002"/>');
                	$('#evlOpinion').val('');
                	$('input[name="evlScore"]:checked').prop('checked',false);
                }else{
                	alert(wz_msg('wzwg.cmm.cncnts.pagad.MSG003'));
                }
            }
            , error:function (data) {
                alert('<spring:message code="fail.common.msg" text="error" />');
            }
        });
        
	}
	
	/* var limitByte = 10;
	
	function checkByte(textBox) {
	        var totalByte = 0;
	        var message = $(textBox).val();
	
	        for(var i =0; i < message.length; i++) {
	                var currentByte = message.charCodeAt(i);
	                if(currentByte > 128){
	                	totalByte += 2;
	                }else{
	                	totalByte++;
	                }
	        }
	
	
	
	        // 현재 입력한 문자의 바이트 수를 체크하여 표시
	        //$('#messagebyte').text(totalByte);
	
	
	
	        // 입력된 바이트 수가 limitByet를 초과 할 경우 경고창 
	        if(totalByte > limitByte) {
	            alert( limitByte+"바이트까지 전송가능합니다.");
	        	$(textBox).val(message.substring(0,limitByte));
	        }
	//[출처] textarea에 입력 글자수 제한하기|작성자 mpruser
	}
 */

	</script>
	<link type="text/css" href="/css/wzwg/module/cntpagead/cntpagead.css" rel="stylesheet" />
	
	<div id="sub_bottominfo" class="<c:out value="${skinEstbsVO.skinTy }"/><c:if test="${empty skinEstbsVO.skinTy }">skin01</c:if>">
		<c:if test="${fn:length(oclhgList) > 0 }">
		<div class="mnginfo boardinfo">
			<c:forEach items="${oclhgList }" var="list" varStatus="c">
			<ul class="admin">
				<c:if test="${not empty list.departNm  }"><li class="ico_part"><strong><spring:message code="wzwg.site.cntnts.msg.MSG033"/></strong><c:out value="${list.departNm }"/></li></c:if>
				<c:if test="${not empty list.oclhgNm  }"><li class="ico_person"><strong><spring:message code="wzwg.cmm.word.charger"/></strong><c:out value="${list.oclhgNm }"/></li></c:if>
				<c:if test="${not empty list.oclhgCttpl  }"><li class="ico_phone"><strong><spring:message code="wzwg.cmm.word.cttpc"/></strong><c:out value="${list.oclhgCttpl }"/></li></c:if>
				<c:if test="${not empty paramVO.frstRegistPnttm  }">
				<li class="ico_clock">
					<c:if test="${c.count eq 1 }"><strong><spring:message code="wzwg.cmm.word.lastupdtde"/></strong><c:out value="${paramVO.lastUpdtPnttm ? paramVO.lastUpdtPnttm  : list.lastUpdtPnttm}"/></c:if>
				</li>
				</c:if>
			</ul>
			</c:forEach>
		</div>
		</c:if> 
	
	
	<c:if test="${evlEstbsVO.useAt eq 'Y' }">
		<div class="satisfaction">
	    	<p><spring:message code="wzwg.cmm.cncnts.pagad.MSG004" /></p>
	        <ul>
	            <li class="survey">
	            	<ul>
	            		<li>
			                <input id="point_1" type="radio" name="evlScore" value="5">
			                <label for="point_1"><spring:message code="wzwg.cmm.word.verygood"/></label>
			            </li>
			            <li>
			                <input id="point_2" type="radio" name="evlScore" value="4">
			                <label for="point_2"><spring:message code="wzwg.cmm.word.good"/></label>
			            </li>
			            <li>
			                <input id="point_3" type="radio" name="evlScore" value="3">
			                <label for="point_3"><spring:message code="wzwg.cmm.word.usually"/></label>
			            </li>
			            <li>
			                <input id="point_4" type="radio" name="evlScore" value="2">
			                <label for="point_4"><spring:message code="wzwg.cmm.word.poor"/></label>
			            </li>
			            <li>
			                <input id="point_5" type="radio" name="evlScore" value="1">
			                <label for="point_5"><spring:message code="wzwg.cmm.word.verybad"/></label>
	            		</li>
	        		</ul>
	            </li>
	            <c:if test="${evlEstbsVO.opinionUseAt eq 'Y'}">
	            <li class="etc_comment">
					<label for="evlOpinion" title="<spring:message code="wzwg.site.cntnts.msg.MSG039" />" class="moehidden"><spring:message code="wzwg.site.cntnts.msg.MSG039"/></label>
					<input class="comments" name="etc" type="text" id="evlOpinion" maxlength="100"> 
				</li>
	            </c:if> 
				<button class="wzbtn btn-save" type="button" onclick="fnRegistCntntsRating()"><spring:message code="wzwg.cmm.word.rate"/></button>                                                                                             
	        </ul>
		</div>
	</c:if>
	
	<c:set var="cpyrhtAlt">
		<c:if test="${cpyrhtVO.cpyrhtSe eq '2'}"><spring:message code="wzwg.cmm.word.wa.comperUsProhi" /></c:if>
		<c:if test="${cpyrhtVO.cpyrhtSe eq '3'}"><spring:message code="wzwg.cmm.word.wa.chaProhi" /></c:if>
		<c:if test="${cpyrhtVO.cpyrhtSe eq '4'}"><spring:message code="wzwg.cmm.word.wa.comperUsProhi" /> <spring:message code="wzwg.cmm.word.wa.chaProhi" /></c:if>
	</c:set>
	<c:if test="${cpyrhtVO.useAt eq 'Y'}">
		<div class="copyinfo">
			<img src="/images/wzwg/module/cntpagead/cpyrht/img_opentype0<c:out value="${cpyrhtVO.cpyrhtSe }"/>.jpg" alt="OPEN <spring:message code="wzwg.cmm.cncnts.pagad.MSG007"/> <c:out value="${cpyrhtAlt}"/>">
			<ul class="copyComment">
			<c:choose>
				<c:when test="${cpyrhtVO.cpyrhtSe eq '1'}">
					<li style="float: none;"><spring:message code="wzwg.cmm.cntnts.cpyrht.MSG001"/></li>
					<li style="float: none;"><spring:message code="wzwg.cmm.cntnts.cpyrht.MSG002"/></li>
					<li style="float: none;"><spring:message code="wzwg.cmm.cntnts.cpyrht.MSG003"/></li>
				</c:when>
				<c:when test="${cpyrhtVO.cpyrhtSe eq '2'}">
					<li style="float: none;"><spring:message code="wzwg.cmm.cntnts.cpyrht.MSG001"/></li>
					<li style="float: none;"><spring:message code="wzwg.cmm.cntnts.cpyrht.MSG004"/></li>
					<li style="float: none;"><spring:message code="wzwg.cmm.cntnts.cpyrht.MSG003"/></li>
				</c:when>
				<c:when test="${cpyrhtVO.cpyrhtSe eq '3'}">
					<li style="float: none;"><spring:message code="wzwg.cmm.cntnts.cpyrht.MSG001"/></li>
					<li style="float: none;"><spring:message code="wzwg.cmm.cntnts.cpyrht.MSG002"/></li>
					<li style="float: none;"><spring:message code="wzwg.cmm.cntnts.cpyrht.MSG005"/></li>
				</c:when>
				<c:when test="${cpyrhtVO.cpyrhtSe eq '4'}">
					<li style="float: none;"><spring:message code="wzwg.cmm.cntnts.cpyrht.MSG001"/></li>
					<li style="float: none;"><spring:message code="wzwg.cmm.cntnts.cpyrht.MSG004"/></li>
					<li style="float: none;"><spring:message code="wzwg.cmm.cntnts.cpyrht.MSG005"/></li>
				</c:when>
			</c:choose>
			</ul> 
			<%-- <textarea readonly="readonly" style="resize:none;" ><c:out value="${cntntsRatingSkinVO.comment }"/><c:if test="${empty cntntsRatingSkinVO.comment }"><spring:message code="wzwg.cmm.cncnts.pagad.MSG015"/></c:if></textarea> --%>
		</div>
	</c:if>
	</div>
	<div class="mb20" style="clear: both;"></div>
	</c:if>