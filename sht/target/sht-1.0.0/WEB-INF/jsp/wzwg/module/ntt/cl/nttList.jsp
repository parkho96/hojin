<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
	
	<c:if test="${!empty authorMessage}">
		alert('<c:out value="${authorMessage}"/>');
		history.go(-1);
	</c:if>

	$(document).ready(function(){
	    
		//$(".tab_content").hide();
	    //$(".tab_content:first").show();
	
	    $("ul.tabsTrack li").click(function () {
	    	if($(this).attr('data-link') == 'true'){
	    		return;
	    	}
	    	
	        $("ul.tabsTrack li").removeClass("active").css("color", "#000");
	        $(this).addClass("active").css("color", "#fff");
	        //$(".tab_content").hide()
	        var activeTab = $(this).attr("rel");
	        $("#" + activeTab).fadeIn()
	    });
		
        var $tabs = $(".tabsTrack"); 
        var bannerLength = $tabs.find("li").length;
        var bannerWidth=$(".rollingList").width();
        var currentIndex = 0;
        
        // index 번째 배너 이미지 출력
        function showImage(index){
            var left = -(index*bannerWidth);
            //$tabs.css("left", left);

            $tabs.stop().animate({
                left:left
            },600,"easeOutCubic");
        }
        
	    $(".prev").click(function(){
            // 인덱스 값 구하기
            currentIndex--;
            if(currentIndex<0)
                currentIndex= bannerLength-1;       
            
            // currentIndex 번째 배너 이미지 출력     
            showImage(currentIndex);
        });
        
        $(".next").click(function(){
            // 인덱스 값 구하기
            currentIndex++;
            if(currentIndex>=bannerLength)
                currentIndex= 0;
                
            // currentIndex 번째 배너 이미지 출력
            showImage(currentIndex);
        });
		
		if('<c:out value="${paramVO.nttSeq}"/>' == ''){
			$(".tabListbox > .rollingList > .tabsTrack > li").removeClass("active");
			$("#tab<c:out value='${firstNttSeq}'/>").addClass("active");
			
			fnNttDetail('<c:out value="${firstNttSeq}"/>');
		}else{
			fnNttDetail('<c:out value="${paramVO.nttSeq}"/>');
		}
		
		// 글쓰기
		$('#regist_form_btn').click(function(){
			
			$.ajax({
				  type : 'POST'
				, dataType: 'html'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cl/registNttFormAjax.do'
				, cache : false
				, async : false
				, data:$("#listFrm").serialize()
				, success:function (data) {
					$('#bbs_area').html(data);
					$("#content").css("height",$(document).height());
					$(window).scrollTop(0);
				}
				, error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});
			
		});
		
		<c:if test="${prefix eq '/mngr'}" >fnMngrlistOrderInit();</c:if>
		
	}); // end ready
	
	function fnNttDetail(nttSeq){
		
		var frm = document.listFrm;
		
		frm.nttSeq.value = nttSeq;
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cl/selectNttDetailAjax.do'
			, cache : false
			, async : false
			, data:$("#listFrm").serialize()
			, success:function (data) {
				$('#detail_area').html(data);
				//$("#content").css("height",$(document).height());
				//$(window).scrollTop(0);
				//$(window).scrollTop($('#bbs_area').offset().top -50);
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
		
	}
	
	window.onkeydown = function() {

	    var keyCode = event.keyCode;

	    if(keyCode == 8
	    		&& 'INPUT'.indexOf(event.target.nodeName.toUpperCase()) == -1 
	    		&& 'TEXTAREA'.indexOf(event.target.nodeName.toUpperCase()) == -1) {

	    	fnPage(1);
	    	return false;
		}
	}	
	
	function fnMngrlistOrderInit(){
		var sortHandler = '<span class="bg-grey fl grey handle" style="height: 100%;position: absolute;left: 0;width: 24px;top: 0;font-size: 22px;line-height: 35px;font-weight: bold;">≡</span>';
		
		$('.tabsTrack li').each(function(){
			$(this).append(sortHandler);
		});
		
		$(".tabsTrack").sortable({
			handle : ".handle" 
			/* , placeholder: "ui-state-highlight" */
			/* , change : function(event, ui){
				console.log(ui);
			} */
		});
		
		
	}
	
	function fnNttClListOrdr(){
		var updLen = $('.tabsTrack li').length;
		var resultLen = 0;
		$('.tabsTrack li').each(function(idx){
			//console.log(this)
			 $.ajax({
				type:'post'
				, url: '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cl/modifyNttListOrdrAjax.do'
				, data: {
							'nttSeq' : $(this).attr('data-nttSeq')
						,	'nttClOrdr' : idx					
						}
				, success:function (data) {
					
					var value = "";
	                    
                    $(data).find("value").each(function() {  
                        value = $(this).text();  
                    });
                    
                    if(value == 'success'){
                    	resultLen ++;
                    }
                    
                    if(updLen == resultLen){
                    	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
                    }
                    //console.log(value);
				}
				, error:function (request, status, error) {
			          alert('<spring:message code="fail.common.msg" text="error" />');
			     }
				
				, dataType: 'xml'
			}); 
		});
		
	}
	
	
</script>

		<c:set var="adminAuthAt" value="N"/>
		
		<c:if test="${resultVO.cmntUseAt eq 'Y'}">
			<c:if test="${sessionScope.cmntMngrAt == true}">
				<c:set var="adminAuthAt" value="Y"/>
			</c:if>
		</c:if>

		<c:if test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or sessionScope.CNTNTS_ADMIN_AT}">
			<c:set var="adminAuthAt" value="Y"/>
		</c:if>
		
		<c:if test="${not empty resultVO.bbsPrface}">
		<div class="">
			<c:out value='${resultVO.bbsPrface}' escapeXml="false" />
		</div>
		</c:if>

		<form:form modelAttribute="paramVO" path="listFrm" id="listFrm" name="listFrm" method="post">
			<form:hidden path="siteSeq" />
			<form:hidden path="bbsSeq" />
			<form:hidden path="nttSeq" />
			<form:hidden path="menuSeq" />
			<form:hidden path="mngrAt" />
			<form:hidden path="sitecntntsSeq" />
			<input type="hidden" name="cmntUseAt" id="cmntUseAt" value="<c:out value='${resultVO.cmntUseAt}'/>" />
			
			<c:set var="movAuthAt" value="" />
			<c:set var="delAuthAt" value="" />
			<c:set var="regAuthAt" value="" />					
		
			<c:if test="${nttAuthVO.authorSe eq 'W' or cmntAuthW eq 'Y'}">
				<c:set var="regAuthAt" value="Y" />
			</c:if>
			
			<c:if test="${adminAuthAt eq 'Y'}">
				<c:set var="movAuthAt" value="Y" />
				<c:set var="delAuthAt" value="Y" />
				<c:set var="regAuthAt" value="Y" />
			</c:if> 
			
			<div class="tabListbox">
				<c:if test="${prefix eq '/mngr'}">
					<c:if test="${regAuthAt eq 'Y'}">
						<a href="javascript:void(0);" class="wzbtn btn-save mt10 mb10 fr" id="regist_form_btn"><spring:message code="wzwg.cmm.word.regist" /></a>
						<div class="admpg-subp w100 fl txt-r block"><span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.tip.MSG071" /></div>
					</c:if>
					<h3 class="wzAdmSTit wd100 fl mt15"><spring:message code="wzwg.cmm.word.wa.tabSetting"/></h3>
				</c:if>
				<c:if test="${!empty resultList}">
					<div class="wd100 box-border pl20 pr20 fl">
						<c:if test="${prefix eq '/mngr'}">
							<div class="admpg-subp w100 fl txt-l block mb20"><span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.tip.MSG072"/></div>
						</c:if>
						<div class="rollingList wd90 wm100">
							<ul class="tabsTrack">
								<c:forEach var="resultList" items="${resultList}" varStatus="status">
									<%-- <li id="tab${resultList.nttSeq}" rel="tab${resultList.nttSeq}" onclick="fnNttDetail('${resultList.nttSeq}')" title="${resultList.nttSj}">${resultList.nttSj}</li> --%>
									<c:if test="${resultList.nttClSe eq 'L' and prefix ne '/mngr'}">
										<c:set var="url">${fn:substring(resultList.nttCn, 3, fn:length(resultList.nttCn)) }</c:set>
										<c:set var="nttSj"><a <c:if test="${fn:substring(resultList.nttCn, 1,2) eq 'N'}">target="_blank" title="<spring:message code="wzwg.cmm.word.ordr"/>"</c:if> href="${url}"><c:out value="${resultList.nttSj}"/></a></c:set>
										<li id="tab<c:out value='${resultList.nttSeq}'/>" rel="tab<c:out value='${resultList.nttSeq}'/>" title="<c:out value='${resultList.nttSj}'/>" data-link="true" data-nttSeq="<c:out value='${resultList.nttSeq}'/>">
											<c:out value="${nttSj }"/>
										</li>
									</c:if>
									
									<c:if test="${resultList.nttClSe eq 'C' or prefix eq '/mngr'}">
										<li id="tab<c:out value='${resultList.nttSeq}'/>" rel="tab<c:out value='${resultList.nttSeq}'/>" onclick="fnNttDetail('<c:out value="${resultList.nttSeq}"/>')" title="<c:out value='${resultList.nttSj}'/>" data-nttSeq="<c:out value='${resultList.nttSeq}'/>">
											<button type="button"><c:out value="${resultList.nttSj}"/></button>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</div>
						
						<c:if test="${adminAuthAt eq 'Y' and prefix eq '/mngr' }">
						<div class="rt-box txt-r wd10 wm100">
							<button type="button" class="wzbtn btn-basic" onclick="fnNttClListOrdr()"><spring:message code="wzwg.module.word.ordrstre"/></button>
						</div>
						</c:if>
					</div>
					
				
					<div class="tab_container">
						<c:if test="${prefix eq '/mngr'}">
							<h3 class="wzAdmSTit wd100 fl"><spring:message code="wzwg.cmm.word.wa.tabContents"/></h3>
						</c:if>
						<div class="wd100 box-border pl20 pr20 fl">
							<c:if test="${prefix eq '/mngr'}">
								<div class="admpg-subp w100 fl txt-l block mb20"><span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.tip.MSG073"/></div>
							</c:if>
							<div id="detail_area"></div>
						</div>
					</div>
					
				</c:if>
							  	
				<div class="rt-box">
					<c:if test="${regAuthAt eq 'Y' and prefix ne '/mngr'}">
						<a href="javascript:void(0);" class="wzbtn btn-save mt20 fl" id="regist_form_btn"><spring:message code="wzwg.cmm.word.regist" /></a>
					</c:if>																	
				</div>	
			</div>
			
		</form:form>
		
		<c:if test="${not empty resultVO.bbsCnclsn}">
		<div class="mt30">
			<c:out value='${resultVO.bbsCnclsn}' escapeXml="false" />
		</div>
		</c:if>
