<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
      <script>
      function fnDetail(seq){
    	  document.frm.stplatsimpSeq.value=seq;
    	  document.frm.action="<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/sysSiteStplat/sys/selectSysSiteStplatSimpDetail.do";
    	  document.frm.submit();
      }
      
	  function fnDefault(stplatSeq,stplatsimpSeq){
		  document.frm.stplatsimpSeq.value=stplatsimpSeq;
		  document.frm.stplatSeq.value=stplatSeq;
		  
		  $.ajax({
	            type:'POST'
	          , url:"<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/sysSiteStplat/sys/defaultSysSiteStplatSimp.do"
	          , async : true
	          , data:$("#frm").serialize()
	          , success:function (data) {
	              $(data).find('value').each(function(){
	                  if($(this).text() == "success"){ 
	                          alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.applc" /></spring:argument></spring:message>');
	                       location.href='<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/sysSiteStplat/sys/selectSysSiteStplatSimpList.do';
	                       
	                  }else{
	                      alert('<spring:message code="fail.common.msg" text="error" />');
	                  }
	              })
	          }
	          , dataType: 'xml'
	         });
      }
	  
	  function fnApply(stplatSeq,stplatsimpSeq){
		  document.frm.stplatsimpSeq.value=stplatsimpSeq;
		  document.frm.stplatSeq.value=stplatSeq;
		  if(!confirm('<spring:message code="wzwg.cmm.msg.MSG327"  />')){
			  return false;
		  }
		  $.ajax({
	            type:'POST'
	          , url:"<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/sysSiteStplat/sys/applySysSiteStplatSimp.do"
	          , async : true
	          , data:$("#frm").serialize()
	          , success:function (data) {
	              $(data).find('value').each(function(){
	                  if($(this).text() == "success"){ 
	                          alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.applc" /></spring:argument></spring:message>');
	                       location.href='<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/sysSiteStplat/sys/selectSysSiteStplatSimpList.do';
	                       
	                  }else{
	                      alert('<spring:message code="fail.common.msg" text="error" />');
	                  }
	              })
	          }
	          , dataType: 'xml'
	         });
      }
	  
	  
      </script>
      	<form name="frm" id="frm" method="post">
      	<input type="hidden" name="stplatsimpSeq" id="stplatsimpSeq" />
      	<input type="hidden" name="stplatSeq" id="stplatSeq" />
      	</form>
                  <table class="basic-table">
                    <colgroup>
                        <col width="5%" />
                        <col width="*" />
                        <col width="15%" />
                        <col width="15%" />
                        <col width="15%" />
                        <col width="10%" />
                        <col width="15%" />
                    </colgroup>
                    <thead>
                      <tr>
                        <th>No</th>
                        <th><spring:message code="wzwg.sysMngr.word.stplatSj" /></th>
                        <th><spring:message code="wzwg.cmm.word.opertnDe" /></th>
                        <th><spring:message code="wzwg.cmm.word.endde" /></th>
                        <th><spring:message code="wzwg.cmm.word.rgsde" /></th>
                        <th><spring:message code="wzwg.sysMngr.word.bassEstbsAt" /></th>
                        <th><spring:message code="wzwg.cmm.word.manage" /></th>
                      </tr>
                    </thead>
                    <tbody>
                    <c:if test="${empty resultList}">
                    <tr>
                        <td colspan="6">
                        <spring:message code="wzwg.cmm.cmmMsg.CMG014">
                            <spring:argument><spring:message code="wzwg.cmm.word.dtartv" /></spring:argument>
                        </spring:message>
                        </td>
                    </tr>
                    </c:if>
                    <c:forEach items="${resultList}" var="list" varStatus="status">
                    <tr>
                        <td style="cursor: pointer;" onclick="fnDetail('<c:out value="${list.stplatsimpSeq}" />')"><c:out value="${(fn:length(resultList) - status.count) + 1}" /></td>
                        <td style="cursor: pointer;" onclick="fnDetail('<c:out value="${list.stplatsimpSeq}" />')"><c:out value="${list.stplatSj}" /></td>
                        <td style="cursor: pointer;" onclick="fnDetail('<c:out value="${list.stplatsimpSeq}" />')"><c:out value="${list.opertnDe}" /></td>
                        <td style="cursor: pointer;" onclick="fnDetail('<c:out value="${list.stplatsimpSeq}" />')"><c:out value="${list.endDe}" /></td>
                        <td style="cursor: pointer;" onclick="fnDetail('<c:out value="${list.stplatsimpSeq}" />')"><c:out value="${list.frstRegistPnttm}" /></td>
                        <td> 
                       	<c:if test="${list.defaultAt eq 'N'}"> <a class="btn-c" onclick="fnDefault('<c:out value="${list.stplatSeq}" />','<c:out value="${list.stplatsimpSeq}" />'); return false;" href="javascript:void(0);"><spring:message code="wzwg.sysMngr.word.bassEstbs" /></a></c:if>
                       	<c:if test="${list.defaultAt eq 'Y'}"> <spring:message code="wzwg.sysMngr.word.bassEstbs" /> </c:if>
                        </td>
                        <td>
                       	 <a class="wzbtn-table btn-save" onclick="fnApply('<c:out value="${list.stplatSeq}" />','<c:out value="${list.stplatsimpSeq}" />'); return false;" href="javascript:void(0);"><spring:message code="wzwg.sysMngr.word.allSiteApplc" /></a> 
                        </td>
                    </tr>
                    </c:forEach>
                    </tbody>
                  </table>
				 <div class="rt-box">
                    <a href="<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/sysSiteStplat/sys/selectSysSiteStplatSimpRegist.do" class="wzbtn btn-basic" ><spring:message code="wzwg.cmm.word.regist" /></a>
                </div>