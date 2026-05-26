<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>     

<script>
$( document ).ready(function() {
	fnMngrSearch(1);
});

function wzLoadingModal(imgObj){
	var pop = '';
	pop += '<div class="wzpopup-wrap" id="wzLodingModal">                                                            ';
	pop += '  <div class="wzpopup popup_la" style="box-shadow:none;">                                                                                  ';
	pop += '	<div class="pop-body">                                                                                           ';
	pop += '		<div class="pop-container txt-c" style="background: rgba(0,0,0,0);">                  ';
	pop += imgObj;
	pop += '		</div> <!-- pop-container end -->                                                                            ';
	pop += '	</div> <!-- pop-body end -->                                                                                     ';
	pop += '  </div>                                                                                                             ';
	pop += '</div>                                                                                   ';
    pop += '<div id="fadeLodingModal"></div>                                                                     ';
    
    
    wzHideScrollbar();
    $('body').append(pop);
	
	$("body").css("overflow","hidden");
	$(".wzpopup").show();
    $(".wzpopup").focus();
   
}
    

function wzLoadingModalClose(){
	if($(".wzpopup-wrap").length > 1){
		$('#wzLodingModal').remove();
		$('#fadeLodingModal').remove();
	}else{
		wzShowScrollbar();
		$(".wzpopup-wrap").remove();
		$("body").css("overflow","auto");
		$("#fadeLodingModal").remove();
	}
	
}

function fnLayCheckAll() {
    if ($('.wzpopup .layCheckall').is(':checked')) {
        $('.wzpopup input[name=linkSeqArr]').prop('checked', true);
    } else {
        $('.wzpopup input[name=linkSeqArr]').prop('checked', false);
    }
}

function fnMngrSearch(pageIndex) {
    if(isNaN(pageIndex)){console.log('잘못된 페이지호출');return;}
    var frm = document.detailMngrForm;
    frm.pageIndex.value = pageIndex;
    
    $.ajax({
        type:'POST'
      , url:'<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/menu/linkGrp/selectLinkInfoListMngrAjax.do'
      , data: $("#detailMngrForm").serialize()
      , success:function (data) {
          $('#divLayList').html(data);
      }
      , error:function (data) {
          alert('<spring:message code="fail.common.msg" text="error" />');
      }
      , dataType: 'html'
    });
}

function fnMngrForm(linkSeq) {
    var frm = document.detailMngrForm;
    
    frm.linkSeq.value = linkSeq;
    
    $.ajax({
        type:'POST'
      , url:'<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/menu/linkGrp/selectLinkInfoDetailMngrFormAjax.do'
      , data: $("#detailMngrForm").serialize()
      , success:function (data) {
    	  $('#divLayList').html(data);
      }
      , error:function (data) {
          alert('<spring:message code="fail.common.msg" text="error" />');
      }
      , dataType: 'html'
    });
}

function fnMngrAdd() {
  if ($('input:checkbox[id="linkSeqArr"]').is(':checked')) {
      if (confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.add" /></spring:argument></spring:message>')) {
          $.ajax({
              type:'POST'
            , url:'<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/menu/linkGrp/registLinkGrpAjax.do'
            , data:$("#detailMngrForm").serialize()
            , success:function (data) {
                $(data).find('value').each(function(){
                    if($(this).text() == "success"){
                        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.add" /></spring:argument></spring:message>');
                        // 부모창 갱신
                        fnDetailList();
                        // 현재창 닫기
                        fnLayerPopupClose();
                    }else{
                        alert('<spring:message code="wzwg.cmm.msg.MSG076" />');
                    }
                })
            }
            , error:function (data) {
                alert('<spring:message code="fail.common.msg" text="error" />');
            }
            , dataType: 'xml'
          });
      }
  } else {
      alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.data" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument></spring:message>');
  }
}


function fnLinkRegistExcelUpload() {
	if($('#uplaodLinkFile').val() == ''){
		alert('<spring:message code="wzwg.site.menu.msg.MSG058"/>');
		return;
	}
	
	/** 파일 확장자 체크 */
	var atchFile = document.getElementById('uplaodLinkFile');
    if(typeof atchFile != "undefind" && atchFile != null) {
    	atchFile = atchFile.value;
        
        var atchFileExt = atchFile.slice(atchFile.indexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로 만듭니다.
        
        if(atchFileExt != "xls" && atchFileExt != "xlsx"){ //확장자를 확인합니다.
            alert('<spring:message code="wzwg.site.menu.msg.MSG059"/>');
            return;
        }
    }
    
    if(confirm('[' + atchFile + ']<spring:message code="wzwg.site.menu.msg.MSG060"/>')){
    	$('#detailMngrForm').ajaxForm({
		    type:'POST'
		    , url:'<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/menu/linkGrp/redistLinkInfoExcelUploadAjax.do'
		    , beforeSend: function() {
		    	wzLoadingModal('<img src="/images/wzwg/cmm/loadingBak.gif" >');
		    }
		    , success: function(data) {
		    	if(data.head.result == 'success'){
		    		alert(data.body.resultCnt + '<spring:message code="wzwg.site.menu.msg.MSG061"/>');
		    		fnMngrSearch(1);
	 			}else{
	 				alert('<spring:message code="fail.common.msg" text="error" />');
	 			}
		    }
			, complete: function(xhr) {
				wzLoadingModalClose();
			}
		    , dataType: 'json'
		}); 
		
		$('#detailMngrForm').submit();
    }
}

</script>
        
                    <form:form modelAttribute="paramVO" id="detailMngrForm" name="detailMngrForm" method="post">
	                    <form:hidden path="pageIndex" />
	                    <form:hidden path="linkGrpSeq" />
	                    <input type="hidden" id="linkSeq" name="linkSeq" />
	                    <c:choose>
	                    <c:when test="${empty detailMngrVO.siteSeq}">
	                    <input type="hidden" id="siteSeq" name="siteSeq" value="<c:out value="${paramVO.siteSeq}"/>" />
	                    </c:when>
	                    <c:otherwise>
	                    <form:hidden path="siteSeq" name="siteSeq" />
	                    </c:otherwise>
	                    </c:choose>
                
<!--                     <div class="main-menu-bar"> -->
<%--                         <a href="javascript:void(0);" onclick="fnMngrForm('');" class="btn-a"><spring:message code="wzwg.cmm.word.regist" /></a> --%>
<!--                     </div> -->

                    <div id="divLayList"></div>
                   </form:form>
       