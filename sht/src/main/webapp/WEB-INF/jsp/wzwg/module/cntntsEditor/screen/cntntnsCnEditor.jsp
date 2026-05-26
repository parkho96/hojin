<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<!-- cntntnsCnEditor.jsp -->
<script>
$(document).ready(function(){
	var opt = {}
		opt.editType = 'contents' 
		opt.fullScreen = ''; 
		opt.contentmove = 'drag';
		opt.fileStore = 'true';
		opt.imageStore = 'true';
		console.log(opt);
		
		$('#cntntsCnEditor').wizonEditor(opt);
})
</script>
<div id="cntntsCnEditor"><c:out value="${cntntsVO.cntntsCn }" escapeXml="false"/></div>