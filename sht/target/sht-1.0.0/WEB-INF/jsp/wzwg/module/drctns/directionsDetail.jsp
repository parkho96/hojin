<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script type="text/javascript" src="/js/wzwg/cmm/jquery-latest.min.js"></script>
	
	<script type="text/javascript">
		$(window).load(function(){
			$.ajax({
				  type:'POST'
				, url:'http://maps.googleapis.com/maps/api/geocode/json?sensor=false&language=ko&address='+encodeURIComponent('<c:out value="${resultVO.adresBass}"/>')
				, dataType: 'json'
				, success:function(data){
					if(data.status == 'OK') {
						var dataList = data.results;
						
						$.each(dataList, function(key){
							
							var address_components = dataList[key].address_components;
							var formatted_address = dataList[key].formatted_address;
							var geometry = dataList[key].geometry;
							
							$.each(address_components, function(key){
								
								var short_name = address_components[key].short_name;
								
								if(short_name == 'KR'){	// 대한민국 코드
									
									var xcnts = geometry.location['lat'];
									var ydnts = geometry.location['lng'];
									
									$("#directionsDiv").append(
										'<img src="https://openapi.naver.com/v1/map/staticmap.bin?clientId=AeiYF016OfgXylNBTypI&url=http://127.0.0.1:8080/wizbuilder/&crs=EPSG:4326&center='+ydnts+','+xcnts+'&w=700&h=600&level=12&baselayer=default&markers='+ydnts+','+xcnts+'" width="700" height="500" />'
									);
									
								}
								
							});
							
						});
						
					} else if(data.status == 'ZERO_RESULTS') {
		                alert('<spring:message code="wzwg.cmm.msg.MSG132" />');
		            } else if(data.status == 'OVER_QUERY_LIMIT') {
		                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.word.quota" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.excess" /></spring:argument></spring:message>');
		            } else if(data.status == 'REQUEST_DENIED') {
		                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.word.requst" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.reject" /></spring:argument></spring:message>');
		            } else if(data.status == 'INVALID_REQUEST') {
		                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.word.adres" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.ovsite" /></spring:argument></spring:message>');
		            }
					
				}
				, error: function(result){
		  			alert('<spring:message code="fail.common.msg" text="error" />');
		  		}
			}); 
		});
	
	</script>
</head>
<body>
	<div id="directionsDiv"> </div>
	
</body>
</html>

