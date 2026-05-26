<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=<c:out value='${resultVO.apiCrtfcKey}'/>"></script>
</head>
<body>
<div id="map" style="width:100%;height:400px;"></div>

<script>
var map = new naver.maps.Map('map', {
    center: new naver.maps.LatLng('<c:out value="${resultVO.xCnts}"/>','<c:out value="${resultVO.yCnts}"/>'),
    zoom: 10
});

var marker = new naver.maps.Marker({
    position: new naver.maps.LatLng('<c:out value="${resultVO.xCnts}"/>','<c:out value="${resultVO.yCnts}"/>'),
    map: map
});

</script>
</body>
</html>