<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
$( document ).ready(function() {
    
    $('.checkall').click(function() {

        if ($(this).is(':checked')) {
            $('input[name=usrgroupSeqArr]').prop('checked', true);

            $('.authorSe').removeAttr('disabled');
            $('.authorSeArr').removeAttr('disabled');
        } else {
            $('input[name=usrgroupSeqArr]').prop('checked', false);

            $('.authorSe').attr('disabled', true);
            $('.authorSeArr').attr('disabled', true);
        }
    });
    
    $('#tbInfo').find('tr').each(function(index, parentEle) {
        
        // 체크 박스 클릭 이벤트
        $(parentEle).find('td:first > ul > li > label').children('input[name=usrgroupSeqArr]').click(function() { 
            $(parentEle).find('td:last >ul >li').children('.authorSe').attr('disabled', true);
            $(parentEle).find('td:last >ul').children('input[name=authorSeArr]').prop('disabled', true); 
            
            if ($(this).is(':checked')) {
                $(parentEle).find('td:last >ul >li').children('.authorSe').removeAttr('disabled');
                $(parentEle).find('td:last >ul').children('input[name=authorSeArr]').prop('disabled', false); 
            }
               
        });
        
        // 히든값 초기설정 - disabled = true
        $(parentEle).find('td:last > ul').children('.authorSeArr').each(function(index, childEle) {

            $(parentEle).find('td:last > ul').children('input[name=authorSeArr]').prop('disabled', true); 
        });
        
        $(parentEle).find('td:last >ul >li').children('.authorSe').each(function(index, childEle) {
            
            // 클릭시 넘길 hidden element에 넣기
            $(childEle).click(function() {
                $(parentEle).find('td:last >ul >li').children('.authorSe').prop('checked', false);
                $(childEle).prop('checked', true);
                $(parentEle).find('td:last >ul').children('.authorSeArr').val($(childEle).val());
                
                $(parentEle).find('td:last').children('.usrgroupSeqArr').prop('checked', true);
            });
            
            // 초기값 셋팅
            if ($(childEle).is(':checked')) {
                $(parentEle).find('td:last >ul').children('.authorSeArr').val($(childEle).val());
            };
            
            $(childEle).attr('disabled', true);
        });
    });
});

function fnModify() {
    var frm = document.frmInfo;
    
    //frm.sitecntntsSeq.value = $.urlParam('sitecntntsSeq');

    $.ajax({
        type:'POST'
      , url:'<c:out value="${wzwg_contextPath}"/>/mngr/cntnts/cntntsAuth/registCntntsAuth.do'
      , cache : false
      , async : false
      , data:$("#frmInfo").serialize()
      , success:function (data) {
          alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.compt" /></spring:argument></spring:message>');
      }
      , error:function (data) {
          alert('<spring:message code="fail.common.msg" text="error" />');
      }
      , dataType: 'html'
    });
}
</script>

			<div class="wz_notice brbox bg-white br-blue-strong fl mt10" style="overflow:visible;">
		        <ul class="wd100 pl0">
		                <li class="admpg-subp wd100" style="list-style:none;">· <spring:message code="wzwg.cmm.msg.tip.MSG054" /></li>
		        </ul>
			</div>
	
            <form id="frmInfo" name="frmInfo" method="post">
            <input type="hidden" id="sitecntntsSeq" name="sitecntntsSeq" value="<c:out value="${paramVO.sitecntntsSeq}"/>"/>
            
			<table class="basic-table" id="tbInfo">
				<colgroup>
					<col width="5%"/>
                    <col width="*"/>
                    <col width="60%"/>
				</colgroup>
				  <thead>
					<tr>
						<th><ul class="wzForm"><li><input type="checkbox" value="" class="checkall" id="checkAll" /><label for="checkAll"><span class="dp-none"><spring:message code="wzwg.site.cmm.msg.MSG006"/></span></label></li></ul></th>
						<th><spring:message code="wzwg.site.cntnts.msg.MSG001" /></th>
						<th><spring:message code="wzwg.cmm.word.author" /></th>
					</tr>
			      </thead>
				  <tbody>
					<c:if test="${!empty resultList}">
					<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr class="trInfo">
	                    <td><ul class="wzForm"><li><label><input type="checkbox" id="usrgroupSeq" name="usrgroupSeqArr" value="<c:out value="${result.usrgroupSeq}"/>" /><span class="spanLabel"></span></label></li></ul></td>
	                    <td style="text-align:left;"><c:out value="${result.usrGroupNm}"/></td>
	                    <td>
	                    	<ul class="wzForm">
	                    		<input type="hidden" class="authorSeArr" id="authorSeArr" name="authorSeArr" />
	                    		<li class="wd-auto i-block mr20"><input type="radio" class="authorSe" value="R" id="authorSeR<c:out value="${status.index }"/>" <c:if test="${result.authorSe eq 'R'}">checked</c:if> /><label for="authorSeR<c:out value="${status.index }"/>"><spring:message code="wzwg.cmm.word.redng" /> </label></li>
		                        <c:if test="${fn:indexOf(baseUsrgroupSeq,result.usrgroupSeq) <0 }">
			                         <c:if test="${writeAuthAt eq 'Y' }">
			                         <li class="wd-auto i-block mr20"><input type="radio" class="authorSe" value="W" id="authorSeW<c:out value="${status.index }"/>" <c:if test="${result.authorSe eq 'W'}">checked</c:if> /><label for="authorSeW<c:out value="${status.index }"/>"><spring:message code="wzwg.cmm.word.regist" /></label></li>
			                         
			                         </c:if>
		                        </c:if>
		                        <li class="wd-auto i-block"><input type="radio" class="authorSe" value="N" id="authorSeN<c:out value="${status.index }"/>" <c:if test="${result.authorSe eq 'N'}">checked</c:if> /><label for="authorSeN<c:out value="${status.index }"/>"><spring:message code="wzwg.cmm.word.noauthor" /></label></li>
	                        </ul>
	                    </td>
					</tr>
					</c:forEach>
					</c:if>
				  </tbody>
			</table>
			<div class="rt-box">
				<a href="javascript:void(0);" class="wzbtn btn-save" onclick="javascript:fnModify();"><spring:message code="wzwg.cmm.word.stre" /></a>
			</div>            

            </form>