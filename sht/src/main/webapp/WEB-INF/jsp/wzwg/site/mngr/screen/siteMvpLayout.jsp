<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 


 <link rel="stylesheet" href="/css/wzwg/site/mngr/popupzone.css" type="text/css" />
 <link rel="stylesheet" href="/css/wzwg/cmm/pop.css" type="text/css" />
 <style>
 .main-design-edit-popup {
    width: 70% !important;
    /* height: 75%; */
    float: left;
    margin-left: 0 !important;
    margin: 0 15% !important;
    left: 0;
    box-sizing: border-box;
}
 </style>
 <script>
    $(document).ready(function(e){
       
        $('#modal-layout-mov').draggable({ handle: "#modal-layout-mov-move-handler" });
    	$("#modal-layout-mov-move-handler").css('cursor', 'move');
    });
    
    function fnLayerPopupClose() {
	    $("#divLayerPopup").hide();
	    $("#divLayerPopup").empty();
	    $('body').css({overflow:'auto'});
	}
</script>
								
								
 <div class="pop-box">
 	<div class="layer3 main-design-edit-popup" id="modal-layout-mov">	
		 <div class="popupzone_layer">
		 	<div class="pop-id-sch" id="modal-layout-mov-move-handler">
				<span>동영상 재생하기</span>
				<button class="close" type="button" onclick="fnLayerPopupClose();"><img src="/images/wzwg/site/mngr/pop-close.png" alt=""></button>
			</div>
			<div class="pop-container">
				<div class="pop-conts">
		
					 <div id="add_layer">
				          
							<!-- 레이아웃 탭 -->
				            <div class="tab_item layout_select01" style="border-top : none;">
				            	<div class="layer_preview" style="background: black;">
										<div id="layout_preview" style="float: left; width: 100%;height:450px;">
										<iframe width="100%" height="100%" src="https://www.youtube.com/embed/<c:out value="${param.mvpId}"/>" frameborder="0" allowfullscreen></iframe>
										</div>
				            	</div>
				            </div>						 
 					</div>
 				</div>
 				</div>
 				</div>
 				</div>
 				</div>
 				