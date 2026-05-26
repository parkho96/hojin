<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<!doctype html >
<html lang="ko">
<head>

	<jsp:include page="/WEB-INF/jsp/wzwg/cmm/include/incDecoMngrHead.jsp" />
	<script>
	sessionStorage.removeItem('authgrpId');
	</script>
</head>
 <body>  
 
 
	<div id="wrap">
		<div id="container">
		<jsp:include page="/WEB-INF/jsp/wzwg/cmm/include/incDecoMngrHeader.jsp" />
                <jsp:include page="/WEB-INF/jsp/wzwg/cmm/include/incDecoMngrLeft.jsp" />
          <div id="contents">
				<div id="main">
					<div class="content-wrapper">
						<div class="location-001">
							<ul>
								<li> 
										<img src="/images/wzwg/site/mngr/lo-home.png" alt="<spring:message code="wzwg.cmm.word.home" />" /> 
								</li>
								<li> 
										<spring:message code="wzwg.cmm.cntnts.dashboard" /> 
								</li>
							</ul>
						</div>
						<h2><spring:message code="wzwg.cmm.cntnts.dashboard" /></h2>
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
