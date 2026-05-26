<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<%@ page import="egovframework.wzwg.site.mngr.menu.service.SiteMngrMenuVO" %>
<%@ page import="java.util.List" %>

<!doctype html >
<html lang="ko">
<head>
	<jsp:include page="/WEB-INF/jsp/wzwg/cmm/include/incDecoMngrHead.jsp" />
</head>
 <body>  
	<div id="wrap">
		<div id="container">
		<jsp:include page="/WEB-INF/jsp/wzwg/cmm/include/incDecoMngrHeader.jsp" />
        <jsp:include page="/WEB-INF/jsp/wzwg/cmm/include/incDecoMngrLeft.jsp" />
          <div id="contents">
				<div id="main">
					<div class="content-wrapper">
						<%
							List<SiteMngrMenuVO> siteMenuList = (List<SiteMngrMenuVO>) request.getAttribute("menuMngrList");
						
							if(siteMenuList != null){
								for(int i = 0; i < siteMenuList.size(); i++){
						%>
									<c:set value="<%=siteMenuList.get(i).getLinkUrl() %>" var="menuUrl"/>
									<c:set value="<%=siteMenuList.get(i).getMenuPrefix() %>" var="menuPrefix"/>

									<c:choose>
										<c:when test="${!empty menuUrl and (fn:indexOf(nowUrl, menuUrl) > -1 or fn:indexOf(nowUrl, menuPrefix) > -1)}">
										<%-- <c:when test="${!empty menuUrl and fn:indexOf(nowUrl, menuPrefix) > -1}"> --%>
											<c:set value="<%=siteMenuList.get(i).getMngrMenuSeq() %>" var="mngrMenuSeq"/>								
											<c:set value="<%=siteMenuList.get(i).getSysmoduleSeq() %>" var="sysmoduleSeq"/>				
										</c:when>
										<c:otherwise>
											<c:if test="${fn:indexOf(nowUrl, '/siteMngr/siteInfo/') > -1}"><c:set value="10000000011" var="mngrMenuSeq"/></c:if>
											<c:if test="${fn:indexOf(nowUrl, '/siteMngr/siteStplat/') > -1}"><c:set value="10000000011" var="mngrMenuSeq"/></c:if>
											
											<c:if test="${fn:indexOf(nowUrl, '/cntnts/cntntsInfo/') > -1}"><c:set value="10000000026" var="mngrMenuSeq" /></c:if>
															
					            			<c:if test="${fn:indexOf(nowUrl, '/mngr/menu/selectSiteMenuRegistFrmMngr.do') > -1 and param.hdftrCode eq 'SC00000081'}"><c:set value="10000000021" var="mngrMenuSeq"/></c:if>
					            			<c:if test="${fn:indexOf(nowUrl, '/mngr/menu/selectSiteMenuModifyFrmMngr.do') > -1  and param.hdftrCode eq 'SC00000081'}"><c:set value="10000000021" var="mngrMenuSeq"/></c:if>
								            <c:if test="${fn:indexOf(nowUrl, '/mngr/menu/selectSiteMenuRegistFrmMngr.do') > -1  and param.hdftrCode eq 'SC00000082'}"><c:set value="10000000022" var="mngrMenuSeq"/></c:if>
								            <c:if test="${fn:indexOf(nowUrl, '/mngr/menu/selectSiteMenuModifyFrmMngr.do') > -1  and param.hdftrCode eq 'SC00000082'}"><c:set value="10000000022" var="mngrMenuSeq"/></c:if>
		                        
					                        <c:if test="${fn:indexOf(nowUrl, '/module/bbs/unity/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000003" var="sysmoduleSeq"/></c:if>
								            <c:if test="${fn:indexOf(nowUrl, '/module/bbs/image/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000237" var="sysmoduleSeq"/></c:if>
								            <c:if test="${fn:indexOf(nowUrl, '/module/bbs/qna/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000101" var="sysmoduleSeq"/></c:if>
								            <c:if test="${fn:indexOf(nowUrl, '/module/bbs/simp/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000103" var="sysmoduleSeq"/></c:if>
					                        <c:if test="${fn:indexOf(nowUrl, '/module/bbs/link/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000218" var="sysmoduleSeq"/></c:if>
								            <c:if test="${fn:indexOf(nowUrl, '/module/bbs/faq/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000220" var="sysmoduleSeq"/></c:if>
								            <c:if test="${fn:indexOf(nowUrl, '/module/bbs/mvp/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000204" var="sysmoduleSeq"/></c:if>
								            <c:if test="${fn:indexOf(nowUrl, '/module/bbs/custom/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000215" var="sysmoduleSeq"/></c:if>
	
								            <c:if test="${fn:indexOf(nowUrl, '/module/onlineReqst/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000210" var="sysmoduleSeq"/></c:if>
								            <c:if test="${fn:indexOf(nowUrl, '/module/map/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000213" var="sysmoduleSeq"/></c:if>
								            <c:if test="${fn:indexOf(nowUrl, '/module/tabMenu/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000238" var="sysmoduleSeq"/></c:if>
								            <c:if test="${fn:indexOf(nowUrl, '/module/cntnts/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000105" var="sysmoduleSeq"/></c:if>
								            <c:if test="${fn:indexOf(nowUrl, '/module/cntntsEditor/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000240" var="sysmoduleSeq"/></c:if>
								            <c:if test="${fn:indexOf(nowUrl, '/module/schdul/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000104" var="sysmoduleSeq"/></c:if>
											
											<%-- <c:if test="${fn:indexOf(nowUrl, '/module/upload/imageStore/') > -1}"><c:set value="10000000042" var="mngrMenuSeq"/></c:if> --%>
											<c:if test="${fn:indexOf(nowUrl, '/opnsu/bbs/unity/selectBbsInc.do') > -1 and param.bbsSeq eq '10000000001'}"><c:set value="10000000050" var="mngrMenuSeq"/></c:if>
								            <c:if test="${fn:indexOf(nowUrl, '/opnsu/bbs/unity/selectBbsInc.do') > -1 and param.bbsSeq eq '10000000002'}"><c:set value="10000000051" var="mngrMenuSeq"/></c:if>
								            <c:if test="${fn:indexOf(nowUrl, '/opnsu/bbs/qna/selectBbsInc.do') > -1 and param.bbsSeq eq '10000000003'}"><c:set value="10000000052" var="mngrMenuSeq"/></c:if>
								            <c:if test="${fn:indexOf(nowUrl, '/opnsu/bbs/unity/selectBbsInc.do') > -1 and param.bbsSeq eq '10000000004'}"><c:set value="10000000053" var="mngrMenuSeq"/></c:if>
										</c:otherwise>
									</c:choose>
						<%		
								}
							}
							
						%>

						<%-- <c:choose>
	            			<c:when test="${fn:indexOf(nowUrl, '/siteMngr/siteInfo/') > -1}"><c:set value="10000000011" var="mngrMenuSeq"/></c:when>
		                    <c:when test="${fn:indexOf(nowUrl, '/siteMngr/siteStplat/') > -1}"><c:set value="10000000011" var="mngrMenuSeq"/></c:when>
		                    <c:when test="${fn:indexOf(nowUrl, '/siteMngr/bbsDataMngr/') > -1}"><c:set value="10000000009" var="mngrMenuSeq"/></c:when>
							<c:when test="${fn:indexOf(nowUrl, '/siteMngr/bbsDataBckpRcvr/') > -1}"><c:set value="10000000005" var="mngrMenuSeq"/></c:when>
		                    <c:when test="${fn:indexOf(nowUrl, '/siteMngr/snsKeyMngr/') > -1}"><c:set value="10000000059" var="mngrMenuSeq"/></c:when>	
							
	            			<c:when test="${fn:indexOf(nowUrl, '/screen/selectSiteScreenTempltMain.do') > -1}"><c:set value="10000000013" var="mngrMenuSeq"/></c:when>
						    <c:when test="${fn:indexOf(nowUrl, '/subCss/') > -1}"><c:set value="10000000014" var="mngrMenuSeq"/></c:when>
	            			
							<c:when test="${fn:indexOf(nowUrl, '/mngr/menu/selectSiteMenuMngrList.do') > -1}"><c:set value="10000000020" var="mngrMenuSeq"/></c:when>
	         				<c:when test="${fn:indexOf(nowUrl, '/mngr/menu/selectSiteHdMenuMngrList.do') > -1}"><c:set value="10000000021" var="mngrMenuSeq"/></c:when>
							<c:when test="${fn:indexOf(nowUrl, '/mngr/menu/selectSiteHdMenuMngrList.do') > -1}"><c:set value="10000000021" var="mngrMenuSeq"/></c:when>
	            			<c:when test="${fn:indexOf(nowUrl, '/mngr/menu/selectSiteMenuRegistFrmMngr.do') > -1 and param.hdftrCode eq 'SC00000081'}"><c:set value="10000000021" var="mngrMenuSeq"/></c:when>
	            			<c:when test="${fn:indexOf(nowUrl, '/mngr/menu/selectSiteMenuModifyFrmMngr.do') > -1  and param.hdftrCode eq 'SC00000081'}"><c:set value="10000000021" var="mngrMenuSeq"/></c:when>
	            			<c:when test="${fn:indexOf(nowUrl, '/mngr/menu/selectSiteFtrMenuMngrList.do') > -1 }"><c:set value="10000000022" var="mngrMenuSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/mngr/menu/selectSiteMenuRegistFrmMngr.do') > -1  and param.hdftrCode eq 'SC00000082'}"><c:set value="10000000022" var="mngrMenuSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/mngr/menu/selectSiteMenuModifyFrmMngr.do') > -1  and param.hdftrCode eq 'SC00000082'}"><c:set value="10000000022" var="mngrMenuSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/menu/linkGrp/') > -1}"><c:set value="10000000023" var="mngrMenuSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/mngr/module/sideQuick/') > -1}"><c:set value="10000000024" var="mngrMenuSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/mngr/menu/selectSiteMenuByUsrGroup.do') > -1}"><c:set value="10000000025" var="mngrMenuSeq"/></c:when>
							
				            <c:when test="${fn:indexOf(nowUrl, '/module/bbs/bbsForm/') > -1}"><c:set value="10000000027" var="mngrMenuSeq"/></c:when>
	      				    <c:when test="${fn:indexOf(nowUrl, '/cntnts/cntntsInfo/selectCntntsInfoDashboard.do') > -1}"><c:set value="10000000028" var="mngrMenuSeq"/></c:when>
	      				    
	      				    <c:when test="${fn:indexOf(nowUrl, '/cntnts/cntntsInfo/') > -1}">
			                        <c:set value="10000000026" var="mngrMenuSeq" />
	                        </c:when>
	                        
	                        <c:when test="${fn:indexOf(nowUrl, '/module/bbs/unity/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000003" var="sysmoduleSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/module/bbs/image/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000237" var="sysmoduleSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/module/bbs/qna/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000101" var="sysmoduleSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/module/bbs/simp/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000103" var="sysmoduleSeq"/></c:when>
	                        <c:when test="${fn:indexOf(nowUrl, '/module/schdul/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000104" var="sysmoduleSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/module/schdul/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000104" var="sysmoduleSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/module/onlineReqst/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000210" var="sysmoduleSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/module/bbs/mvp/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000204" var="sysmoduleSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/module/map/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000213" var="sysmoduleSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/module/tabMenu/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000238" var="sysmoduleSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/module/bbs/custom/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000215" var="sysmoduleSeq"/></c:when>  
				            <c:when test="${fn:indexOf(nowUrl, '/module/cntnts/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000105" var="sysmoduleSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/module/cntntsEditor/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000240" var="sysmoduleSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/module/bbs/link/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000218" var="sysmoduleSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/module/bbs/faq/') > -1}"><c:set value="10000000026" var="mngrMenuSeq"/><c:set value="10000000220" var="sysmoduleSeq"/></c:when>
				            
				              
				            <c:when test="${fn:indexOf(nowUrl, '/module/onlineQustnr/') > -1}"><c:set value="10000000017" var="mngrMenuSeq"/></c:when> 
							
							<c:when test="${fn:indexOf(nowUrl, '/mngr/cmnt/info/') > -1}"><c:set value="10000000029" var="mngrMenuSeq"/></c:when>
	      				    <c:when test="${fn:indexOf(nowUrl, '/mngr/cmnt/config/') > -1}"><c:set value="10000000030" var="mngrMenuSeq"/></c:when>
	      				     
				            <c:when test="${fn:indexOf(nowUrl, '/module/upload/imageStore/') > -1}"><c:set value="10000000042" var="mngrMenuSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/module/popup/') > -1}"><c:set value="10000000040" var="mngrMenuSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/module/banner/') > -1}"><c:set value="10000000041" var="mngrMenuSeq"/></c:when>
	                        <c:when test="${fn:indexOf(nowUrl, '/mngr/inqryDtls/') > -1}"><c:set value="10000000044" var="mngrMenuSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/module/upload/usr/file/') > -1}"><c:set value="10000000043" var="mngrMenuSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/module/beffatPlbc/') > -1}"><c:set value="10000000060" var="mngrMenuSeq"/></c:when>
				            
				            <c:when test="${fn:indexOf(nowUrl, '/module/orgnztInfo/') > -1}"><c:set value="10000000031" var="mngrMenuSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/module/tabMenu/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.word.tab" /> <spring:message code="wzwg.cmm.word.menu" /></c:set></c:when>
	            			
							
							<c:when test="${fn:indexOf(nowUrl, '/stat/selectVisitStat.do') > -1}"><c:set value="10000000045" var="mngrMenuSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/stat/selectUsrStat.do') > -1}"><c:set value="10000000046" var="mngrMenuSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/stat/selectCmntStat.do') > -1}"><c:set value="10000000047" var="mngrMenuSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/stat/selectMenuStat.do') > -1}"><c:set value="10000000048" var="mngrMenuSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/stat/selectBbsStat.do') > -1}"><c:set value="10000000049" var="mngrMenuSeq"/></c:when> 
							
							<c:when test="${fn:indexOf(nowUrl, '/usrMngr/usrInfo/') > -1}"><c:set value="10000000033" var="mngrMenuSeq"/></c:when>
		                    <c:when test="${fn:indexOf(nowUrl, '/usrMngr/usrGroup/') > -1}"><c:set value="10000000034" var="mngrMenuSeq"/></c:when>
		                    <c:when test="${fn:indexOf(nowUrl, '/usrMngr/usrTy/') > -1}"><c:set value="10000000035" var="mngrMenuSeq"/></c:when>
		                    <c:when test="${fn:indexOf(nowUrl, '/usrMngr/sbscrbCrtfcEstbs/') > -1}"><c:set value="10000000036" var="mngrMenuSeq"/></c:when>
							
							
							<c:when test="${fn:indexOf(nowUrl, '/opnsu/bbs/unity/selectBbsInc.do') > -1 and param.bbsSeq eq '10000000001'}"><c:set value="10000000050" var="mngrMenuSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/opnsu/bbs/unity/selectBbsInc.do') > -1 and param.bbsSeq eq '10000000002'}"><c:set value="10000000051" var="mngrMenuSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/opnsu/bbs/qna/selectBbsInc.do') > -1 and param.bbsSeq eq '10000000003'}"><c:set value="10000000052" var="mngrMenuSeq"/></c:when>
				            <c:when test="${fn:indexOf(nowUrl, '/opnsu/bbs/unity/selectBbsInc.do') > -1 and param.bbsSeq eq '10000000004'}"><c:set value="10000000053" var="mngrMenuSeq"/></c:when>
				             <c:when test="${fn:indexOf(nowUrl, '/menu/bkmk/') > -1}"><c:set value="10000000070" var="mngrMenuSeq"/></c:when>
						
						</c:choose>  --%>
						
            			<c:choose>
            				<c:when test="${not empty mngrMenuSeq and empty sysmoduleSeq }">
		            			<jsp:include page="/mngr/menu/selectMngrLocationView.do">
		            				<jsp:param value="${fn:escapeXml(mngrMenuSeq)}" name="mngrMenuSeq"/>
		            			</jsp:include>
            				</c:when>
            				<c:when test="${not empty mngrMenuSeq and not empty sysmoduleSeq }">
            					<jsp:include page="/mngr/menu/selectMngrLocationView.do">
			            			<jsp:param name="mngrMenuSeq" value="${fn:escapeXml(mngrMenuSeq)}" />
	        						<jsp:param name="sysmoduleSeq" value="${fn:escapeXml(sysmoduleSeq)}" />
        						</jsp:include>
            				</c:when>
            			</c:choose>
        <!-- //header_m -->
                <decorator:body />
        <!-- //contentpanel -->
        	</div>
				</div>				
			</div>	
		<jsp:include page="/WEB-INF/jsp/wzwg/cmm/include/incDecoMngrFooter.jsp" />
        <!-- //footer -->
        
		</div>
	</div>
    <!-- //wrap -->
 </body>
</html>
