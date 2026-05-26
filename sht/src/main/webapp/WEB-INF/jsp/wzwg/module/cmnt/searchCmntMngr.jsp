<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>


<script type="text/javascript">
	$(document).ready(function(){ 
		//$(".hid").click(function(){
		//	$(".pop-box").hide();
		//});
	});
	 
	/* function fn_init(){
		 
		
		$.ajax({
	        type:'POST'
	      , url:'/module/cmnt/selectCmntListAjax.do'
	   	  , data:$("#cmntFrm").serialize()
	      , cache : false
	      , async : false 
	      , success:function (data) {
	    	  $('#cntnts_area').html(data);
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	} */
	
	function fn_search(pageIndex){
		if(isNaN(pageIndex)){console.log('잘못된 페이지호출');return;}
		var frm = document.mngrFrm2;
		frm.pageIndex.value = pageIndex;
			$.ajax({
		        type:'POST'
		      , url:'<c:out value="${wzwg_contextPath}"/>/cmnt/mngr/searchCmntMngrAjax.do'
		   	  , data:$("#mngrFrm2").serialize()
		      , cache : false
		      , async : false 
		      , success:function (data) {
		    	  $('.pop-container').html(data);
		    	  $('#pageInfo').find('.on>a').focus();
		      }
		      , error:function (data) {
		          alert('<spring:message code="fail.common.msg" text="error" />');
		      }
		      , dataType: 'html'
		 	});
	}

	function fnSetMngrSeq(usrSeq,userId,userNm){ 
		$("#cmntMngrSeq").val(usrSeq);
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}"/>/usr/cmnt/info/modifyCmntMngrSeqAjax.do' 
	      , cache : false
	      , async : false 
	      , data  : $("#mngrFrm2").serialize()
	      , success:function (data) { 
	    	  alert('<spring:message code="wzwg.cmm.msg.MSG080" text="changed" />');
	    	  wzModalClose();
	    	  $("#mngrSpan").html(userId+"("+userNm+")");
	    	  //location.reload();
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
	
	function fn_searchClick() {
		fn_search('1');
		
		if($('.wztable').find('tbody tr').size() > 0){
			$('.wztable').find('tbody tr a')[0].focus();
		}else {
			$('.close').focus();
		}
	}
</script>
	
		
	
				 <form name="mngrFrm2" id="mngrFrm2" >
	 			<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value='${paramVO.pageIndex }'/>"/>
	 			<input type="hidden" name="cmntMngrSeq" id="cmntMngrSeq" />
	 			<input type="hidden" name="cmntSeq" id="cmntSeq" value="<c:out value='${param.cmntSeq}'/>"/>
							<div class="">
								<!--content //-->
								<div class="main-menu-bar mb10">
									 <select name="searchCondition" id="searchCondition" title="<spring:message code="wzwg.module.word.searchse" />">
										<option value="0"><spring:message code="wzwg.cmm.word.all" text="all" /></option>
										<option value="1" <c:if test="${paramVO.searchCondition eq '1' }">selected="true"</c:if>><spring:message code="wzwg.cmm.word.nm02" text="name" /></option> 
										<option value="2" <c:if test="${paramVO.searchCondition eq '2' }">selected="true"</c:if>><spring:message code="wzwg.cmm.word.id02" text="id" /></option>
									</select>
									<input type="text" class="txt" name="searchKeyword" onkeypress="if(event.keyCode==13){return false;}" value="<c:out value='${paramVO.searchKeyword }'/>" title="<spring:message code="wzwg.module.word.searchkeywordinput" />" />
									<a href="javascript:void(0);"  onclick="fn_searchClick()" class="wzbtn-table btn-srch"><spring:message code="wzwg.cmm.word.search01" text="search" /></a>
								</div>
								<table class="wztable">
									  <caption><spring:message code="wzwg.cmm.cmmMsg.CMG024"><spring:argument><spring:message code="wzwg.cmm.word.oprtr" /> <spring:message code="wzwg.cmm.word.change" /> <spring:message code="wzwg.cmm.word.wa.of" /> <spring:message code="wzwg.cmm.word.id02" />, <spring:message code="wzwg.cmm.word.nm02" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.wa.table" /></spring:argument></spring:message></caption>
									  <colgroup>
										<col width="20%" />
										<col width="40%" />
										<col width="20%" />
										<col width="20%" />
									  </colgroup>
									  <thead>
										<tr>
											<th scope="col">No.</th>
											<th scope="col"><spring:message code="wzwg.cmm.word.id02" text="id" /></th>
											<th scope="col"><spring:message code="wzwg.cmm.word.name02" text="name" /></th>
											<th scope="col"><spring:message code="wzwg.cmm.word.choise" text="choise" /></th>
										</tr>
									  </thead>
									  <tbody>
										<c:if test="${!empty usrInfoList}">
											<c:forEach var="result" items="${usrInfoList}" varStatus="status">
											<tr>
							                   <td class="txt-c"><c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * 5 + status.count) + 1}"/></td>
							                   <td class="txt-c"><c:out value="${result.userId}"/></td>
							                   <td class="txt-c"><c:out value="${result.userNm}"/></td>
							                   <td class="txt-c"> <a href="javascript:;" onclick="fnSetMngrSeq('<c:out value="${result.usrSeq}"/>','<c:out value="${result.userId}"/>','<c:out value="${result.userNm}"/>')" class="wzbtn-table btn-basic"><spring:message code="wzwg.cmm.word.choise" text="choise" /></a></td> 
											</tr>
											</c:forEach>
										</c:if>
									  </tbody>
								</table>
								<div class="subCon mt20 br-top0">	
	                                <ul id="pageInfo" class="num">
	                                 <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
	                                </ul>
                                </div>
							</div> <!-- pop-conts end -->
				</form>
