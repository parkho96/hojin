<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

	<jsp:include page="/mngr/module/cmm/addform/selectMngrAddform.do">
			<jsp:param name="mdSeq" value="10000000001"/>
			<jsp:param name="mdNm" value="testModule"/>
			<jsp:param name="formTy" value="testForm"/>
		</jsp:include>		

		<jsp:include page="/module/cmm/addform/selectUsrAddform.do">
			<jsp:param name="mdSeq" value="10000000001"/>
			<jsp:param name="mdNm" value="testModule"/>
			<jsp:param name="formTy" value="testForm"/>
		</jsp:include>	