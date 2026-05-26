<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

			<c:forEach items="${mapImgList }" var="list">
	    	 <div class="mapImgPannel wd30" style="display: none;" id="mapImg_<c:out value='${list.mapImgSeq}'/>">
	    	 	<img src="/<c:out value='${list.imgPath}'/>" style="width:inherit;" data-addr="<c:out value='${list.mapAddr}'/>" data-mapImgSeq="<c:out value='${list.mapImgSeq}'/>"/>
	    	 	<span class="defaultControl label-addr">
	    	 	<span class="ico">ⓘ</span> <c:out value="${list.mapAddr}"/>
	    	 	</span>
	    	 	<span><spring:message code="wzwg.cmm.cntnts.insertimg" /><!-- 이미지삽입 --> : </span>
	    	 	<button type="button" class="iconOnlyBtnSameSize btn-basic" style="" onclick="addCntnsImg(this,25);">25%</button>
	    	 	<button type="button" class="iconOnlyBtnSameSize btn-basic" style="" onclick="addCntnsImg(this,50);">50%</button>
	    	 	<button type="button" class="iconOnlyBtnSameSize btn-basic" style="" onclick="addCntnsImg(this,100);">100%</button>
	    	 	<button type="button" class="iconOnlyBtn btn-basic btn-delete red" style="position: absolute; top: 5px; right: 5px;" onclick="deleteMapImg(this);">X</button>
	    	 	<div class="defaultControl">
	    	 		<c:set var="checked"><c:if test="${list.defaultYn eq 'Y' }">checked="checked"</c:if></c:set>
		    	 	<ul class="wzForm">
		    	 		<li>
		    	 			<input type="radio" name="map_default" id="map_def_<c:out value='${list.mapImgSeq}'/>" onchange="defImgChange('mapImg_<c:out value='${list.mapImgSeq}'/>')" <c:out value="${checked }"/>>
		    	 			<label for="map_def_<c:out value='${list.mapImgSeq}'/>" style="vertical-align: middle;"><spring:message code="wzwg.cmm.cntnts.defaultimgset" /><!-- 대표이미지 설정 --></label>
		    	 		</li>
		    	 	</ul>
	    	 	</div>
	    	 </div>
			</c:forEach>
	   		<script id="tmpScript">
	   		
		   		$('.mapImgPannel').each(function(){
		   			if($(this).css('display') == 'none'){
			   			$(this).fadeIn(150);
		   			}
		   		})
	   		
	   		</script>