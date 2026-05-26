<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>   

<script type="text/javascript">

	$(document).ready(function(){
		
		if('<c:out value=${likeAt}"/>' < 1){
			$('#module_inc_<c:out value="${nttLikeVO.nttSeq}"/> #like_regist_div').show();
			$('#module_inc_<c:out value="${nttLikeVO.nttSeq}"/> #like_delete_div').hide();
		}
		
		if('<c:out value="${likeAt}"/>' > 0){
			$('#module_inc_<c:out value="${nttLikeVO.nttSeq}"/> #like_regist_div').hide();
			$('#module_inc_<c:out value="${nttLikeVO.nttSeq}"/> #like_delete_div').show();
		}
		
		// 좋아요 등록
		$("#module_inc_<c:out value=${nttLikeVO.nttSeq}'/> #like_regist_btn").click(function(){
			
			$.ajax({
				type:'POST'
				, dataType: 'xml'
				, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/like/registNttLikeAjax.do'
				, data:"nttSeq=${nttLikeVO.nttSeq}"
				, success:function (result) {
		    	  
					var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value != 'fail'){
						$('#module_inc_<c:out value="${nttLikeVO.nttSeq}"/> #delete_like_cnt').text(value);
						$('#module_inc_<c:out value="${nttLikeVO.nttSeq}"/> #like_regist_div').hide();
						$('#module_inc_<c:out value="${nttLikeVO.nttSeq}"/> #like_delete_div').show();

					//	if($("#module_id_<c:out value='${nttLikeVO.nttSeq}'/> > #module_div").children('.like').css('display') == 'none'){
							fnLikeList('Y', '<c:out value="${nttLikeVO.nttSeq}"/>');							
					//	}else{
					//		fnLikeList('N', '<c:out value="${nttLikeVO.nttSeq}"/>');
					//	}
								
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
					}
		    	  
				}
				, error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
			});
			
		});
		
		// 좋아요 취소
		$("#module_inc_<c:out value='${nttLikeVO.nttSeq}'/> #like_delete_btn").click(function(){

			$.ajax({
				type:'POST'
				, dataType: 'xml'
				, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/like/deleteNttLikeAjax.do'
				, data:"nttSeq=${nttLikeVO.nttSeq}"
				, success:function (result) {
		    	  
					var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value != 'fail'){
						
						if(value > 0){
							$('#module_inc_<c:out value="${nttLikeVO.nttSeq}"/> #regist_like_cnt').html("<font style='font-weight:bold;' color='#FF0000'>♥ "+value+"</font>");
						}else{
							$('#module_inc_<c:out value="${nttLikeVO.nttSeq}"/> #regist_like_cnt').html("<font style='font-weight:bold;' color='#FF0000'>♡ </font>"+value);
						}
						
						$('#module_inc_<c:out value="${nttLikeVO.nttSeq}"/> #like_regist_div').show();
						$('#module_inc_<c:out value="${nttLikeVO.nttSeq}"/> #like_delete_div').hide();
						
					//	if($("#module_id_<c:out value='${nttLikeVO.nttSeq}'/> > #module_div").children('.like').css('display') == 'none'){
							fnLikeList('Y', '<c:out value="${nttLikeVO.nttSeq}"/>');					
					//	}else{
					//		fnLikeList('N', '<c:out value="${nttLikeVO.nttSeq}"/>');
					//	}
						
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
					}
		    	  
				}
				, error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
			});
			
		});
		
		$('#module_inc_<c:out value="${nttLikeVO.nttSeq}"/> #like_ctrl_btn').click(function(){
			/*
			$("#module_inc_<c:out value='${nttLikeVO.nttSeq}'/>").each(function(){
				$('#module_inc_<c:out value="${nttLikeVO.nttSeq}"/> .font_txt').css('color', '#333333');
			});
			
			$('#module_inc_<c:out value="${nttLikeVO.nttSeq}"/> #like_txt').css('color', '#FF0000');
			*/
			if($("#module_div_<c:out value='${nttLikeVO.nttSeq}'/>").children('.like').css('display') == 'none'){
				fnLikeList('Y', '<c:out value="${nttLikeVO.nttSeq}"/>');
				$('#module_inc_<c:out value="${nttLikeVO.nttSeq}"/> .font_txt').css('color', '#FF0000');
				$('#like_ctrl_btn').attr('title','<spring:message code="wzwg.cmm.msg.wa.MSG006" />');
			}else{
				fnLikeList('N', '<c:out value="${nttLikeVO.nttSeq}"/>');
				$('#module_inc_<c:out value="${nttLikeVO.nttSeq}"/> .font_txt').css('color', '#333333');
				$('#like_ctrl_btn').attr('title','<spring:message code="wzwg.cmm.msg.wa.MSG003" />');
			}

		});
		
	});
	
	function fnLikeList(val, nttSeq){

		$('#module_div_'+nttSeq+'').each(function(){
			$(this).children().css('display', 'none');
		});
		
		$.ajax({
			type:'POST'
			, dataType: 'html'
			, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/like/selectNttLikeListAjax.do'
			, data:"nttSeq="+nttSeq
			, success:function (data) {
				$('#module_div_'+nttSeq+' #like_list_div').html(data);
				
				if(val == 'Y'){	// 펼침
					$('#module_div_'+nttSeq+'').children('.like').css('display', 'block');
					$('#module_div_'+nttSeq+' #like_list_div').show();
					$('#module_inc_'+nttSeq+' #like_list_ordr').text("▼");
				}else{			// 접음
					$('#module_div_'+nttSeq+'').children('.like').css('display', 'none');
					$('#module_div_'+nttSeq+' #like_list_div').hide();
					$('#module_inc_'+nttSeq+' #like_list_ordr').text("▲");
				}
				
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
		});
		
	}
	

</script>
	
	<!-- 좋아요 목록 영역 -->
	<div id="like_list_div" style="display:none;"></div>
		
	
