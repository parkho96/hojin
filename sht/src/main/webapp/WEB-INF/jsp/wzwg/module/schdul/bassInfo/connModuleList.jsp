<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">

	function fnCtgryDelete(schdulSeq, sitecntntsSeq, cntntsSeq, ctgrySeq){
		
		if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
			return;
		}else{
			
			$('#delSchdulSeq').val(schdulSeq);
			$('#delSitecntntsSeq').val(sitecntntsSeq);
			$('#delCntntsSeq').val(cntntsSeq);
			$('#delCtgrySeq').val(ctgrySeq);
			
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/schdul/bassInfo/deleteSchdulConnModuleAjax.do'
				, dataType: 'xml'
				, data : $("#regForm").serialize()
				, success : function (result) {
		    	  
		    	  	var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value == 'success'){
						$.ajax({
				            type : 'POST'
				            , url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/schdul/bassInfo/selectConnModuleListAjax.do'
				            , dataType : 'html'
				            , data : $("#regForm").serialize()
				            , success : function (data) {
				                $('#connModuleDiv').html(data);
				            }
				            , error : function (request, status, error) {
				                alert('<spring:message code="fail.common.msg" text="error" />');
				            }
				        });
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
	
</script>
	
	<input type="hidden" id="delSchdulSeq" 		name="delSchdulSeq" />
	<input type="hidden" id="delSitecntntsSeq" 	name="delSitecntntsSeq" />
	<input type="hidden" id="delCntntsSeq" 		name="delCntntsSeq" />
	<input type="hidden" id="delCtgrySeq" 		name="delCtgrySeq" />
	<b class="admpg-subp mt20 mb10 block"><spring:message code="wzwg.module.word.cnncedcntntslist" /></b>
	<table class="basic-table02 w70 mt15">
		<colgroup>
			<col width="5px" />
			<col width="100px" />
			<col width="10px" />
		</colgroup>
	 	<tbody>	
	
		<c:if test="${!empty connModuleList}">
			<c:forEach var="resultList" items="${connModuleList}" varStatus="status">
			
				<c:set var="ctgryColorCode" value="${resultList.ctgryColorCode}" />
				
				<tr>
					<td style="background-color:#<c:out value="${ctgryColorCode}" />;"></td>
					<td class="txt-l">
						<c:out value="${resultList.cntntsNm}" />
					</td>
					<td>
						<span>
							<a href="javascript:void(0);" onclick="fnCtgryDelete('<c:out value="${resultList.schdulSeq}" />', '<c:out value="${resultList.sitecntntsSeq}" />', '<c:out value="${resultList.cntntsSeq}" />', '<c:out value="${resultList.ctgrySeq}" />');" class="iconOnlyBtn btn-basic btn-delete" title="<spring:message code="wzwg.cmm.word.delete" />"></a>
						</span>
					</td>
				</tr>

			</c:forEach>
		</c:if>
	
		</tbody>
	</table>
	
	