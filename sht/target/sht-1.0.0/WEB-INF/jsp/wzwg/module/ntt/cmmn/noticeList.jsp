<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
//공지 게시물 삭제
function fnDelNotice(nttSeq){
	var frm = document.listFrm;
	
	frm.nttSeq.value = nttSeq;
	
	if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006"><spring:argument><spring:message code="wzwg.cmm.word.notice02" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cmmn/modifyNttNoticeAjax.do'
	      , cache : false
	      , async : false
	      , data:$("#listFrm").serialize()
	      , success:function (result) {
	    	  var value = "";
				
				$(result).find("value").each(function() {  
					value = $(this).text();  
				});
				
				if(value == 'success'){
					fnPage(1);
				}else{
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
				}
	      }
	      , error:function (request, status, error) {
	    	  alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'xml'
	 	});
	}
}
	
</script>


<c:set var="expsrAtNoAt" value="N"/>
<c:set var="expsrAtWrtrAt" value="N"/>
<c:set var="expsrAtRgsdAt" value="N"/>
<c:set var="expsrAtIngrAt" value="N"/>

<c:forEach items="${fn:split(expsrAt, ',')}" var="expsrArr">
	<c:choose>
		<c:when test="${expsrArr eq 'N'}"><c:set var="expsrAtNoAt" value="Y"/></c:when>
		<c:when test="${expsrArr eq 'W'}"><c:set var="expsrAtWrtrAt" value="Y"/></c:when>
		<c:when test="${expsrArr eq 'R'}"><c:set var="expsrAtRgsdAt" value="Y"/></c:when>
		<c:when test="${expsrArr eq 'I'}"><c:set var="expsrAtIngrAt" value="Y"/></c:when>
		<c:otherwise></c:otherwise>
	</c:choose>
</c:forEach>


<c:if test="${empty fieldList}">

	<!-- 공지 게시물 목록 -->
	<c:if test="${!empty noticeList && (subospecSeq eq null or subospecSeq eq '')}">
		<c:forEach var="noticeList" items="${noticeList}" varStatus="status">		
			
			<c:set var="noticeDetAuthAt" value="" />
			
			<c:if test="${loginVO.usrSeq eq noticeList.ntcrSeq or nttAuthVO.authorSe eq 'R' or nttAuthVO.authorSe eq 'W' or adminAuthAt eq 'Y' or cmntAuthR eq 'Y' or cmntAuthW eq 'Y'}">
				<c:set var="noticeDetAuthAt" value="Y" />
			</c:if>							
								
			<tr>
				<c:if test="${adminAuthAt eq 'Y'}">
					<td>
						<a title="<spring:message code="wzwg.module.word.noticepostsdelete" />" href="javascript:void(0);" onclick="fnDelNotice('${noticeList.nttSeq}');">
							<img class="icoCenter" src="/images/wzwg/cmm/btn-del.gif" alt="<spring:message code="wzwg.module.word.deleteicon" />" />
						</a>
					</td>				
				</c:if>
		
				<c:if test="${mobileAt eq 'N' and expsrAtNoAt eq 'Y'}">
					<td></td>
				</c:if>
				
				<td class="txt-l fw600">
					<c:if test="${noticeSe eq 'N'}">
					<img class="icoCenter" src="/images/wzwg/module/ntt/icoNotice.png" alt="<spring:message code="wzwg.module.word.noticeicon" />" />
					</c:if>
					
					<c:if test="${noticeSe eq 'F'}">
					<img class="icoCenter" src="/images/wzwg/module/ntt/faq.png" alt="FAQ <spring:message code="wzwg.cmm.word.icon" />" />
					</c:if>
					
					<c:choose>
						<c:when test="${!empty noticeList.nttSj}">
							<c:if test="${fn:length(noticeList.nttSj) > 59}">
								<c:set var="nttSj" value="${fn:substring(noticeList.nttSj, 0, 59)}..." />
							</c:if>
							<c:if test="${fn:length(noticeList.nttSj) < 60}">
								<c:set var="nttSj" value="${noticeList.nttSj}" />
							</c:if>
						</c:when>
						<c:otherwise>
							<c:set var="nttSj"><spring:message code="wzwg.cmm.word.untitle"/></c:set>
						</c:otherwise>
					</c:choose>		
					
					<c:if test="${!empty noticeList.subospecSj}">
						<span class="red fw900">[<c:out value="${noticeList.subospecSj}"/>]</span>
					</c:if>
					
					<c:if test="${noticeList.secretAt eq 'Y'}">
						<span class="lock"><i class="fa fa-lock" aria-hidden="true"></i><span>비공개글</span></span>
					</c:if>
					
					<c:choose>
						<c:when test="${noticeDetAuthAt eq 'Y'}">
							<a href="javascript:void(0);" class="notice_p" onclick="fnView('<c:out value="${noticeList.nttSeq}"/>', '<c:out value="${noticeList.ntcrId}"/>', '<c:out value="${noticeList.secretAt}"/>', '<c:out value="${noticeList.parntsNttSeq}"/>','<c:out value="${noticeList.parntsNtcrId}"/>');"><c:out value="${nttSj}"/></a>
						</c:when>
						<c:otherwise>
							<a href="javascript:void(0);" class="notice_p" onclick="alert('<spring:message code="wzwg.cmm.msg.MSG084" />');"><c:out value="${nttSj}"/></a>
						</c:otherwise>
					</c:choose>
					
					<c:if test="${resultVO.atchFilePosblAt eq 'Y' and noticeList.atchFileCnt ne '0'}">
						<span class="atchFileIcon">
						<i class="fa fa-paperclip" aria-hidden="true"></i>
						<span class="blind"><spring:message code="wzwg.cmm.word.file" /></span>
						</span>
					</c:if>
				</td>
				
				<c:if test="${expsrAtWrtrAt eq 'Y' }">
					<td class="smalltd"><spring:message code="wzwg.cmm.word.mngr" /></td>
				</c:if>
				
				<c:if test="${expsrAtRgsdAt eq 'Y' }">
					<td class="smalltd"><c:out value="${noticeList.frstRegistPnttm}"/></td>
				</c:if>
				
				<c:if test="${mobileAt eq 'N' and expsrAtIngrAt eq 'Y'}">
					<td class="txt-c"><c:out value="${noticeList.inqireCnt}"/></td>
				</c:if>
			</tr>
					
		</c:forEach>
	</c:if>	
	
</c:if>



<c:if test="${!empty fieldList}">
			
	<!-- 공지 게시물 목록 -->
	<c:if test="${!empty noticeList && (subospecSeq eq null or subospecSeq eq '')}">
		<c:forEach var="noticeList" items="${noticeList}" varStatus="status">		
		
			<c:set var="noticeDetAuthAt" value="" />
			
			<c:if test="${loginVO.usrSeq eq noticeList.ntcrSeq or nttAuthVO.authorSe eq 'R' or nttAuthVO.authorSe eq 'W' or adminAuthAt eq 'Y' or cmntAuthR eq 'Y' or cmntAuthW eq 'Y'}">
				<c:set var="noticeDetAuthAt" value="Y" />
			</c:if>			
								
			<tr id="noti-row-${noticeList.nttSeq}" data-fileid="${noticeList.atchFileId}" >
				<c:if test="${adminAuthAt eq 'Y'}">
					<td>
						<a title="<spring:message code="wzwg.module.word.noticepostsdelete" />" href="javascript:void(0);" onclick="fnDelNotice('<c:out value="${noticeList.nttSeq}"/>');">
							<img class="icoCenter" src="/images/wzwg/cmm/btn-del.gif" alt="<spring:message code="wzwg.module.word.deleteicon" />" />
						</a>
					</td>
				</c:if>
				
				<c:if test="${mobileAt eq 'N' and expsrAtNoAt eq 'Y'}">
					<td></td>
				</c:if>
		
				<%-- 커스텀 필드세팅 --%>
				<c:forEach items="${fieldList }" var="list">
					<%-- <spring:message code="wzwg.cmm.word.sj" /> 필드일 경우 --%>
					<c:if test="${list.listAt eq 'Y' and list.useAt eq 'Y' and list.fieldTy eq 'title'}">
						<td class="txt-l">
							<img class="icoCenter" src="/images/wzwg/module/ntt/icoNotice.png" alt="<spring:message code="wzwg.module.word.noticeicon" />" />
							
							<c:choose>
								<c:when test="${!empty noticeList.nttSj}">
									<c:if test="${fn:length(noticeList.nttSj) > 43}">
										<c:set var="nttSj" value="${fn:substring(noticeList.nttSj, 0, 43)}..." />
									</c:if>
									<c:if test="${fn:length(noticeList.nttSj) < 44}">
										<c:set var="nttSj" value="${noticeList.nttSj}" />
									</c:if>
								</c:when>
								<c:otherwise>
									<c:set var="nttSj"><spring:message code="wzwg.cmm.word.untitle"/></c:set>
								</c:otherwise>
							</c:choose>		
							
							<c:if test="${!empty noticeList.subospecSj}">
								<span class="red fw900">[<c:out value="${noticeList.subospecSj}"/>]</span>
							</c:if>
							
							<c:if test="${noticeList.secretAt eq 'Y'}">
								<img src="/images/wzwg/module/ntt/ico-secret.png" alt="<spring:message code="wzwg.module.word.secretposts" />" />
							</c:if>
							
							<c:choose>
								<c:when test="${noticeDetAuthAt eq 'Y'}">
									<a href="javascript:void(0);" class="notice_p" onclick="fnView('<c:out value="${noticeList.nttSeq}"/>', '<c:out value="${noticeList.ntcrId}"/>', '<c:out value="${noticeList.secretAt}"/>', '<c:out value="${noticeList.parntsNttSeq}"/>');"><c:out value="${nttSj}"/></a>
									<c:if test="${noticeList.answerCnt > 0}">
										<span class="colorRed">[<c:out value="${noticeList.answerCnt}"/>]</span>
									</c:if>							
								</c:when>
								<c:otherwise>
									<a href="javascript:void(0);" class="notice_p" onclick="alert('<spring:message code="wzwg.cmm.msg.MSG084" />');"><c:out value="${nttSj}"/></a>
									<c:if test="${noticeList.answerCnt > 0}">
										<a href="javascript:void(0);" onclick="alert('<spring:message code="wzwg.cmm.msg.MSG084" />');">
											<span class="colorRed">[<c:out value="${noticeList.answerCnt}"/>]</span>
										</a>
									</c:if>								
								</c:otherwise>
							</c:choose>
							
							<c:if test="${noticeList.atchFileCnt ne '0'}">
								<img src="/images/wzwg/module/ntt/ico-file.gif" alt="<spring:message code="wzwg.module.word.atchfileicon" />"/>
							</c:if>
						</td>
					</c:if>
					
					<c:if test="${list.listAt eq 'Y' and list.useAt eq 'Y' and list.fieldTy ne 'title'}">
						<td data-nm="${list.fieldNm }" data-id="${list.fieldId}" data-ty="${list.fieldTy }"></td>
					</c:if>
				</c:forEach>
				
				<c:if test="${expsrAtWrtrAt eq 'Y' }">
					<td><spring:message code="wzwg.cmm.word.mngr" /></td>
				</c:if>
				
				<c:if test="${expsrAtRgsdAt eq 'Y' }">
					<td><c:out value="${noticeList.frstRegistPnttm}"/></td>
				</c:if>
				
				<c:if test="${mobileAt eq 'N' and expsrAtIngrAt eq 'Y'}">
					<td><c:out value="${noticeList.inqireCnt}"/></td>
				</c:if>
			</tr>
	
			<%-- 인터넷에서 어디 이상한놈이 해놓은거 잘됨 --%>
			<c:set var="myContent" value="${noticeList.nttCn}"/>
		    <c:set var="singlequote" value="'"/>
		    <c:set var="backslash" value="\\"/>
		    
		    <c:if test="${fn:contains(myContent, singlequote) && !fn:contains(myContent,backslash)}">
	            <c:set var="search" value="'" />
	            <c:set var="replace" value="&apos;" />
	            <c:set var="myContent"><c:out value='${fn:replace(myContent, search, replace)}'/></c:set>
		    </c:if>
		    
		    <c:if test="${fn:contains(myContent, backslash) && !fn:contains(myContent,singlequote)}">
	            <c:set var="search" value="\\" />
	            <c:set var="replace" value="\\\\" />
	            <c:set var="myContent"><c:out value='${fn:replace(myContent, search, replace)}'/></c:set>
		    </c:if>
		    
		    <c:if test="${fn:contains(myContent, singlequote) && fn:contains(myContent,backslash)}">
	            <c:set var="search" value="\\"/>
	            <c:set var="replace" value="\\\\" />
	            <c:set var="myContent"><c:out value='${fn:replace(myContent, search, replace)}'/></c:set>
	            <c:set var="find" value="'"/>
	            <c:set var="change" value="\\'" />
	            <c:set var="myContent"><c:out value='${fn:replace(myContent, find, change)}'/></c:set>
		    </c:if>
			
			<script class="customScript">
				ntDataList.push('${myContent}');
			</script>
			
		</c:forEach>
	</c:if>	

</c:if>