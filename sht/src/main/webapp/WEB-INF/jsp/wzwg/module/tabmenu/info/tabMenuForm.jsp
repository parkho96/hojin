<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<jsp:include page="/WEB-INF/jsp/wzwg/webModule/editorTool.jsp"></jsp:include>

<script language="javascript" type="text/javascript" src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>
<script language="javascript" type="text/javascript" src="/jquery/js/jquery.form.min.js"></script>

<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">

	$(document).ready(function(){
	    
	    //fnCssInfo();
	    
	   /*  $("#listCountAtY").click(function(){
	    	$("#listCountUnit").prop('disabled', false);
	    });
	    
	    $("#listCountAtN").click(function(){
	    	$("#listCountUnit").prop('disabled', true);
	    }); */
	    
	});

    function fnRegist(callGubun) {
    	$('#tabDc').val($("#tabNm").val());
    	
        var ajaxUrl = '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/tabMenu';
        ajaxUrl += (callGubun != 'M')? '/registTabMenuInfoAjax.do':'/modifyTabMenuInfoAjax.do';
        
        $("#bbsPrface").val(oEditors.getById["bbsPrface"].getIR());
       // $("#bbsCnclsn").val(oEditors.getById["bbsCnclsn"].getIR());
        
        if(callGubun != 'M') {
        	$("#cntntsNm").val($("#tabNm").val());
        }
        
        if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>')){
            return;
        }else{
        	
			if(!Validator.validate(document.regForm)){
				return;
			}
			
			if($('#skinImgFileId').val() != 'del'){
				if($('#skinImgFileId').val() != '' && $('#skinImgReplcText').val() == ''){
					alert('<spring:message code="wzwg.cmm.msg.MSG489" />');
					$('#skinImgReplcText').focus();
					return;
				}
			}
			
            $.ajax({
                type : 'POST'
                , url : ajaxUrl
                , dataType: 'xml'
                , data : $("#regForm").serialize()
                , success : function (result) {
                  
                    var value = "";
                    
                    $(result).find("value").each(function() {  
                        value = $(this).text();  
                    });
                    
                    if(value == 'success'){
                        if (callGubun != 'M') {
                            fnCntntsRegist();   
                        } else {
                        	
                        	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>');
                            fnBbsChage($('#bbsSel').val());
                            
                        	//if($('#skinImgFileId').val() != ''){
                        	//	fnModifyBassInfoSkin();
                        	//}else{
	                        //    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>');
	                        //    fnBbsChage($('#bbsSel').val());
                        	//}
                        	
                        }
                    }else{
                        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
                    }
                  
                }
                , error : function (request, status, error) {
                    alert('<spring:message code="fail.common.msg" text="error" />');
                }
            });
        
        }
    }
    
    function fnReset_btn() {
        document.regForm.action='<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/cntnts/cntntsInfo/selectCntntsInfoList.do';
        document.regForm.submit();
    }
    
    function fnCntntsStylePopup(){
    	$.ajax({
			type:'POST'
			, url:'<c:out value="${wzwg_contextPath}" />/mngr/module/bbs/cmmn/selectCssListPopup.do'
			, data : $("#regForm").serialize()
			, success:function (data) {
			 	//$("#divLayerPopup").html(data);
	    	  	//$("#divLayerPopup").show();
				var title = '<spring:message code="wzwg.module.word.skinestbs" />';
			 	wzAjaxModal('popup_l', title, data);
			}
			, dataType: 'html'
    	});
    }
    
    function fnLayerPopupClose() {
        $("#divLayerPopup").hide();
        $("#divLayerPopup").empty();
        $('body').css({overflow:'auto'});
    }   
    
    function fnCssInfo() {

	    $.ajax({
	        type : 'POST'
	        , url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/bbs/cmmn/selectCssInfoAjax.do'
                , dataType : 'html'
                , data : $("#regForm").serialize()
                , success : function (data) {
                    $('#divInfoArea').html(data);
                }
                , error : function (request, status, error) {
                    alert('<spring:message code="fail.common.msg" text="error" />');
                }

	    });
    }    
    
    
    /**
    * 코트라 개발로 커스텀
    */
    
    function fnThumbCheck(){
    	//console.log('fnThumbCheck');
    	if($('#thumbFile').val() == ''){
    		$('#thumbFile_preview').attr('src', '/images/wzwg/site/mngr/no-img.png');
    	}
    }
    
    function fnModifyBassInfoSkin(){
    	var frm = $("#regForm");
 		var formData = frm.serialize();

 		frm.ajaxSubmit({
			type:'POST'
			, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/tabMenu/modifyBbsBassInfoSkinAjax.do'
			, async: false
	        , data: formData 
	        , mimeType: 'multipart/form-data'
			, success:function(result){
				$(result).find('value').each(function(){
					if($(this).text() == "success"){
						
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>');
                        fnBbsChage($('#bbsSel').val());
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
					}
				});
			}
			, error:function (request, status, error) {
	              alert('<spring:message code="fail.common.msg" text="error" />');
	          }
			, dataType: 'xml'
		  
		});
    }
    
    var selectDiv;
    function openImageStoreToSkinImg(){   
    	$.ajax({
            type : 'POST'
    		, url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/image/imageForm.do?mode=200&id=skinImgFileId'
    		, dataType : 'html'
    		, success : function (data) {
    			//$("#imgDiv").html(data);
    			//$("#imgDiv").show();
    			wzAjaxModal('popup_s wd50', wz_msg('wzwg.cmm.word.imageStore'), data);
    		}
    		, error : function (request, status, error) {
    			alert('error');
    		}
    	}); 
    }
    
    function selectImgCntnts(imgSrc,id){
    	//alert(imgSrc);
    	$('#thumbFile_preview').attr('src', imgSrc);
    	$('#skinImgFileId').val(imgSrc.replace('<c:out value="${wzwg_contextPath}" />/module/upload/image/selectImageDetail.do?usrimgId=',''));
    	wzModalClose();
    }
    
    function fnDeleteThumbFile(){
    	$('#skinImgFileId').val('del');
    	$('#thumbFile_preview').attr('src', '/images/wzwg/site/mngr/no-img.png');
    	$('#skinImgReplcText').val('');
    }
</script>

        <form:form modelAttribute="resultVO" path="regForm" id="regForm" name="regForm" method="post">
            <form:hidden path="sitecntntsSeq" />
            <form:hidden path="siteSeq" />
            <form:hidden path="tabSeq" />
            <form:hidden path="cssSeq" />
            <form:hidden path="cssNm" />
                    
            <!--기본정보 table// -->
            <table class="basic" summary="<spring:message code="wzwg.cmm.menu.bassinfo" />">
            <colgroup>
                <col width="15%"/>
                <col width="*"/>
            </colgroup>
            <tbody>
                <tr>
                    <th><spring:message code="wzwg.module.word.cntntsnm" />
                    	<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
                    </th>
                    <td>
                    	<c:set var="cntntsnm"><spring:message code="wzwg.module.word.cntntsnm" /></c:set>
                        <form:input path="tabNm" id="tabNm" cssClass="w70" dir="required" title="${fn:escapeXml(cntntsnm)}" />
                    </td>
                <tr>
                    <th class="headwrite_board"><spring:message code="wzwg.module.word.prefaceestbs" />
                    	<div class="menu_help">
							<img src="/images/wzwg/site/mngr/ico_help_grey.png">
							<div class="help_pop">
								<img src="/images/wzwg/site/mngr/helpimg_headwrite.jpg">
					
							</div>
						</div>
                    </th>
                    <td colspan="3">
                        <textarea name="bbsPrface" id="bbsPrface" rows="10" style="width:100%;"><c:out value="${resultVO.bbsPrface}" /></textarea>
			
						<script type="text/javascript">
							var oEditors = [];
							nhn.husky.EZCreator.createInIFrame({
								oAppRef: oEditors,
								elPlaceHolder: "bbsPrface",
								sSkinURI: "/smartEditor2.8.2.1/smartEditor2Skin.do",
								fCreator: "createSEditor2",
								htParams: {fOnBeforeUnload : function(){}, aAdditionalFontList : [['NanumSquareR', 'NanumSquareR']]}
							});
							WzwgEditorTool.instance("bbsPrface");
						</script>                        
                    </td>
                </tr>
                
				<c:if test="${not empty resultVO.tabSeq}">
                </c:if>
                        
            </tbody>
            </table>
            <!--//기본정보 table -->
            
        </form:form>
                
        <div class="rt-box"> 
            <a href="javascript:void(0);" id="regist_btn" onclick="fnRegist('M');" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" text="stre" /></a>
            <a href="javascript:void(0);" id="reset_btn" onclick="fnReset_btn();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" text="list" /></a>
        </div>
