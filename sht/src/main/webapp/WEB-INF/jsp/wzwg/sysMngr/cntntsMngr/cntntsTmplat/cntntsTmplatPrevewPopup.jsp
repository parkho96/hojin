<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />

<title><spring:message code="wzwg.sysMngr.word.subPgCntntsPreview" /></title>

<link rel="stylesheet" href="/css/wzwg/sysMngr/dashboard/main.css" type="text/css" />
<link rel="stylesheet" href="/css/wzwg/sysMngr/dashboard/contents.css" type="text/css" />
<link rel="stylesheet" href="/css/wzwg/cmm/common.css" type="text/css" />
<link rel="stylesheet" href="/css/wzwg/cmm/font.css" type="text/css" />
<link rel="stylesheet" href="/css/wzwg/sysMngr/dashboard/style.css" type="text/css" />
<link rel="stylesheet" href="/css/wzwg/sysMngr/dashboard/form.css" type="text/css" />
<link rel="stylesheet" href="/css/wzwg/site/mngr/style.css" type="text/css" />

<!-- 에디터 커스터마이징 CSS 추가 -->
<link rel="stylesheet" href="/smartEditorCustom/css/editorTool.css" type="text/css" />
<link rel="stylesheet" href="/smartEditorCustom/css/subcon_common.css" type="text/css" />
<link rel="stylesheet" href="/smartEditorCustom/css/subcon_tamplate.css" type="text/css" />

<link rel="stylesheet" href="/smartEditorCustom/css/font-awesome.css" type="text/css">

<!-- 위디자인 -->
<link rel="stylesheet" href="/widesign/widesigncore.css" type="text/css" />
<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js"></script>
	
	<div class="cntntsTmplt_prvwPOP">
		<c:out value="${cntntsTmplatVO.tmplatCn }" escapeXml="false"/>
	</div>
	
	<div class="ctr-box mb20">
		<a href="javascript:void(0);" onclick="self.close();"><span class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.close" /></span></a>
	</div>
	
	<style>
	table.__se_tbl tr th,
	table.__se_tbl tr td {outline:none !important;}
	</style>
	