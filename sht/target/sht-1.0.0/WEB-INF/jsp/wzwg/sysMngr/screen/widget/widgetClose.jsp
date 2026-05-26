<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
	<head>
		<title><spring:message code="wzwg.sysMngr.word.wizwigWidgEdit" /></title>
		<script>
		alert(wz_msg('wzwg.sysMngr.msg.MSG001'));
		window.close();
		try{
			window.open('','_self').close();
		}catch(e){
			console.log(e);
		}
		</script>
	</head>
	<body>
	</body>  
</html>