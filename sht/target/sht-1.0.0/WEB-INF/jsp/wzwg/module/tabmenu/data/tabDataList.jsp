<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script type="text/javascript" src="/js/wzwg/cmm/common.js"></script>

<script type="text/javascript">
	
	window.onpopstate = function(event){
		fnAutoDetailCtrl();
	}


	<c:if test="${!empty authorMessage}">
		alert('<c:out value="${authorMessage}" />');
		history.go(-1);
	</c:if>

	var queryMap = fnGetQueryMap();//파라미터맵 세팅
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
		
        
		// 글쓰기
		$('#cl_regist_form_btn').click(function(){
			
			$.ajax({
				  type : 'POST'
				, dataType: 'html'
				, url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/tabMenu/registTabMenuDataFormAjax.do'
				, cache : false
				, async : false
				, data:$("#clListFrm").serialize()
				, success:function (data) {
					$('#tabMenuArea').html(data);
					$("#content").css("height",$(document).height());
					$(window).scrollTop(0);
				}
				, error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});
			
		});
		
		<c:if test="${prefix eq '/mngr'}" >fnMngrlistOrderInit();</c:if>
		
		fnAutoDetailCtrl();
		
		
	}); // end ready
	
	function fnAutoDetailCtrl(){
		var reQueryMap = fnGetQueryMap();//파라미터맵 세팅
		$("ul.tabsTrack li").removeClass('active'); //기존 active 제거
		//파라미터에 넘어온 탭번호 이동하기
		var detailItems = $("ul.tabsTrack li");
		if(detailItems != undefined && detailItems.length > 0){
			if(reQueryMap.tabid == null || reQueryMap.tabid == '' || reQueryMap.tabid == undefined){
				var tabid =  $('.tabsTrack').children().eq(0).attr('data-tabdataseq');
				fnNttClDetail(tabid, true);
			}else{
				fnNttClDetail(reQueryMap.tabid, true);
			}
			
		}else{
			if(location.pathname.indexOf('/mngr') > -1){
				var infoDiv = '';
					infoDiv += '	<p class="admpg-subp w100 fl mt20 mb30">                                                                  ';
					infoDiv += '		<span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.MSG430" /></div>   ';
					infoDiv += '		<span class="wz_tableguide mt5 pl15"><spring:message code="wzwg.cmm.msg.MSG431" /></span>             ';
					infoDiv += '	</p>                                                                                                     ';
				$('#tabGuide').html(infoDiv);
			}
		}
	}
	
	function fnNttClDetail(tabdataSeq, isInitCall){
		//관리자는 컨트롤 버튼 노출
			
		//}else{
			
			var frm = document.clListFrm;
			
			frm.tabdataSeq.value = tabdataSeq;
			if(isInitCall){
				if(queryMap.pmode != undefined){
					frm.pmode.value = queryMap.pmode;
					frm.childNttSeq.value = queryMap.nttSeq;
				}
			}else{
				frm.pmode.value = '';
				frm.childNttSeq.value = '';
			}
			
			$.ajax({
				  type : 'POST'
				, dataType: 'html'
				, url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/tabMenu/selectTabMenuDataDetailAjax.do'
				, cache : false
				, async : false
				, data:$("#clListFrm").serialize()
				, success:function (data) {
					$('#detail_area').html(data);
					var nowUrl = '<c:out value="${nowUrl}" />';
					if(nowUrl.indexOf('/mngr') == -1 && isInitCall != true){
						history.pushState(null,null, location.pathname + '?tabid=' + tabdataSeq);
					}
					//$("#content").css("height",$(document).height());
					//$(window).scrollTop(0);
					//$(window).scrollTop($('#tabMenuArea').offset().top -50);
					$("ul.tabsTrack li#tab" + tabdataSeq).addClass('active');
					//상세화면값 초기화
					frm.pmode.value = '';
					frm.childNttSeq.value = '';
				}
				, error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});
		//}
		
	}
	
	//window.onkeydown = function() {
    //
	//    var keyCode = event.keyCode;
    //
	//    if(keyCode == 8
	//    		&& 'INPUT'.indexOf(event.target.nodeName.toUpperCase()) == -1 
	//    		&& 'TEXTAREA'.indexOf(event.target.nodeName.toUpperCase()) == -1) {
    //
	//    	fnPage(1);
	//    	return false;
	//	}
	//}	
	
	function fnMngrlistOrderInit(){
		var sortHandler = '<span class="handle">≡</span>';
		
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
				, url: '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/tabMenu/modifyTabMenuListOrdrAjax.do'
				, data: {
							'tabdataSeq' : $(this).attr('data-tabdataSeq')
						,	'tabClOrdr' : idx					
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
				}
				, error:function (request, status, error) {
			          alert('<spring:message code="fail.common.msg" text="error" />');
			     }
				
				, dataType: 'xml'
			}); 
		});
		
	}
	
	
	
	
	
	
	
	
	function fnTabStyleToggle(){
		if($('#tabStyle').css('display') == 'none'){
			$('#tabStyle').slideDown();
		}else{
			$('#tabStyle').slideUp();
		}
	}
</script>
		<c:if test="${not empty resultVO.bbsPrface}">
		<div class="bbsPrface">
			<c:out value='${resultVO.bbsPrface}' escapeXml="false" />
		</div>
		</c:if>
		
		<a href="javascript:void(0);" class="mainEditBtn" id="cl_regist_form_btn"><img src="/images/wzwg/site/mngr/layout/writeBtn.png" alt=""><spring:message code="wzwg.cmm.msg.tip.MSG0720"/></a>
		<div id="tabGuide"></div>
				
		<form:form modelAttribute="paramVO" path="clListFrm" id="clListFrm" name="clListFrm" method="post">
			<form:hidden path="siteSeq" />
			<form:hidden path="tabSeq" />
			<form:hidden path="tabdataSeq" />
			<form:hidden path="menuSeq" />
			<form:hidden path="mngrAt" />
			<form:hidden path="sitecntntsSeq" />
			<input type="hidden" name="pmode" id="pmode" value="" />
			<input type="hidden" name="childNttSeq" id="childNttSeq" value="" />

			<div id="tabListbox" class="tabListbox mb0 <c:out value="${fn:replace(resultVO.cssNm, ',', ' ') }" />">
				<c:if test="${prefix eq '/mngr'}">
					<%-- <a href="javascript:void(0);" class="wzbtn btn-save mt10 mb10 fr" id="cl_regist_form_btn"><spring:message code="wzwg.cmm.word.regist" /></a>
					<div class="admpg-subp w100 fl txt-r block"><span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.tip.MSG071" /></div> --%>
					<div class="wzAdmSTit wd100 fl mt30">
						<h3 class="i-block"><spring:message code="wzwg.cmm.word.wa.tabSetting"/></h3>
					</div>
				</c:if>
				<c:if test="${!empty resultList}">
					<div class="wd100 fl">
						<div class="wd100 box-border pl20 pr20 fl TabBoxWrap">
							<c:if test="${prefix eq '/mngr'}">
								<div class="admpg-subp w100 fl txt-l block mb20"><span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.tip.MSG072"/></div>
							</c:if>
							<div class="rollingList wm100">
								<ul class="tabsTrack">
									<c:forEach var="resultList" items="${resultList}" varStatus="status">
										<c:if test="${resultList.tabClSe eq 'L' and prefix ne '/mngr'}">
											<c:set var="temp_tabdataSj"><a <c:if test="${resultList.menuLinkTarget eq 'N'}">target="_blank" title="<spring:message code="wzwg.cmm.word.ordr"/>"</c:if> href="<c:out value="${resultList.menuLinkUrl}" />"><c:out value="${resultList.tabdataSj}" /></a></c:set>
											<c:set var="tabdataSj"><c:out value="${temp_tabdataSj}" /></c:set>
											<li id="tab<c:out value="${resultList.tabdataSeq}" />" rel="tab<c:out value="${resultList.tabdataSeq}" />" title="<c:out value="${resultList.tabdataSj}" />" data-link="true" data-tabdataSeq="<c:out value="${resultList.tabdataSeq}" />">
												<c:out value="${tabdataSj}" />
											</li>
										</c:if>
										
										<c:if test="${resultList.tabClSe eq 'L' and prefix eq '/mngr'}">
											<li id="tab<c:out value="${resultList.tabdataSeq}" />" rel="tab<c:out value="${resultList.tabdataSeq}" />" onclick="fnNttClDetail('<c:out value="${resultList.tabdataSeq}" />')" title="<c:out value="${resultList.tabdataSj}" />" data-tabdataSeq="<c:out value="${resultList.tabdataSeq}" />">
												<button type="button"><c:out value="${resultList.tabdataSj}" /></button>
											</li>
										</c:if>
										
										<c:if test="${resultList.tabClSe eq 'C'}">
											<li id="tab<c:out value="${resultList.tabdataSeq}" />" rel="tab<c:out value="${resultList.tabdataSeq}" />" onclick="fnNttClDetail('<c:out value="${resultList.tabdataSeq}" />')" title="<c:out value="${resultList.tabdataSj}" />" data-tabdataSeq="<c:out value="${resultList.tabdataSeq}" />">
												<button type="button"><c:out value="${resultList.tabdataSj}" /></button>
											</li>
										</c:if>
										
										<c:if test="${resultList.tabClSe eq 'M'}">
											<li id="tab<c:out value="${resultList.tabdataSeq}" />" rel="tab<c:out value="${resultList.tabdataSeq}" />" onclick="fnNttClDetail('<c:out value="${resultList.tabdataSeq}" />')" title="<c:out value="${resultList.tabdataSj}" />" data-tabdataSeq="<c:out value="${resultList.tabdataSeq}" />">
												<button type="button"><c:out value="${resultList.tabdataSj}" /></button>
											</li>
										</c:if>
									</c:forEach>
								</ul>
								<c:if test="${prefix ne '/mngr'}">
									<c:if test="${not empty resultVO.skinImgFileId }">
										<div class="tabimg mobile-none">
								          <img src="<c:out value="${wzwg_contextPath}" />/module/upload/image/selectImageDetail.do?usrimgId=<c:out value="${resultVO.skinImgFileId}" />" alt="<c:out value="${resultVO.skinImgReplcText }" />">
								        </div>
									</c:if>
								</c:if>
							</div>
							
							<c:if test="${prefix eq '/mngr' }">
							<div class="rt-box txt-r wd100 wm100 mb0 pb20">
								<button type="button" class="wzbtn btn-edit" onclick="fnTabStyleToggle()"><spring:message code="wzwg.module.word.tabmenudesignchange" /></button>
								<button type="button" class="wzbtn btn-save" onclick="fnNttClListOrdr()"><spring:message code="wzwg.module.word.ordrstre"/></button>
							</div>
							</c:if>
						</div>

						<c:if test="${prefix eq '/mngr'}">
							<div id="tabStyle" class="wd100" style="display:none;">
								<jsp:include page="/WEB-INF/jsp/wzwg/module/tabmenu/info/tabMenuStyleModifyInc.jsp">
									<jsp:param value="${fn:escapeXml(resultVO.cssNm)}" name="cssNm"/>
            						<jsp:param value="${fn:escapeXml(resultVO.tabSeq)}" name="tabSeq"/>
								</jsp:include>
							</div>
						</c:if>
					</div>
					
				
					
					
				</c:if>
			</div>
			
			<div id="detail_area" class="tab_container mt0"></div>
			<c:if test="${!empty resultList}">
			</c:if>
			
		</form:form>
		
