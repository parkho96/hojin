<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
	
	function fnDelete(){
		if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
			$.ajax({
				type:'POST'
				, url:'<c:out value="${wzwg_contextPath}"/>/mngr/inqryDtls/deleteSiteInqryDtls.do'
				, data:$("#frmDetail").serialize()
				,success:function (result){
					$(result).find('value').each(function(){
						if($(this).text() == "success"){
						    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
							fnList();
						}else{
						    alert('<spring:message code="fail.common.msg" text="error" />');
						}
					})
				}
				, error:function (request, status, error) {
				    alert('<spring:message code="fail.common.msg" text="error" />');
		          }
			});
		}else{
			return;
		}
	}
	
	function fnList(){
		var frm = document.frmDetail;
		
        frm.action='<c:out value="${wzwg_contextPath}"/>/mngr/inqryDtls/selectSiteInqryDtlsList.do';
		frm.submit();
	}

</script>
	
	<form id="frmDetail" name="frmDetail" method="post">
        <input type="hidden" name="inqrydtlsSeq" id="inqrydtlsSeq" value="<c:out value="${resultVO.inqrydtlsSeq}"/>" />
        <input type="hidden" name="searchCondition" id="searchCondition" value="<c:out value="${paramVO.searchCondition}"/>"/>
        <input type="hidden" name="searchKeyword" id="searchKeyword" value="<c:out value="${paramVO.searchKeyword}"/>"/>
        <input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex}"/>"/>
        
		<table summary="<spring:message code="wzwg.site.inqrydtls.msg.MSG001" />" class="basic">
			<colgroup>
                <col width="20%"/>
                <col width="30%"/>
                <col width="20%"/>
                <col width="*"/>
			</colgroup>
			<tbody>
				<tr>
                    <th><spring:message code="wzwg.cmm.word.sj"/></th>
                    <td colspan="3">
                        <c:out value="${resultVO.inqrySj}"/>
                    </td>
                </tr>
				<tr>
                    <th><spring:message code="wzwg.cmm.word.wrter"/></th>
                    <td><c:out value="${resultVO.waterNm}"/></td>
                    <th><spring:message code="wzwg.cmm.word.rgsde02"/></th>
                    <td>
                        <c:out value="${resultVO.frstRegistPnttm}"/>
                    </td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.cmm.word.cttpc"/></th>
                    <td colspan="3">
                        <c:out value="${resultVO.waterCttpl}"/>
                    </td>
                </tr>
                <tr>
                    <th><spring:message code="wzwg.cmm.word.cn"/></th>
                    <td colspan="3">
                        <c:out value="${resultVO.inqryCn}"/>
                    </td>
                </tr>
			</tbody>
		</table>
	</form>

	<div class="rt-box">
		<a href="javascript:void(0);" class="wzbtn btn-del fl" onclick="fnDelete();"><spring:message code="wzwg.cmm.word.delete"/></a>
		<a href="javascript:void(0);" class="wzbtn btn-basic" onclick="fnList();"><spring:message code="wzwg.cmm.word.list"/></a>
	</div>
