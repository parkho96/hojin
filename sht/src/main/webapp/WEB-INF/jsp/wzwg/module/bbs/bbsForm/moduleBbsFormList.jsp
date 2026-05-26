<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
 
	
	<script type="text/javascript">
		/** 게시판 양식 등록 폼 */
		function fn_moduleBbsFormRegistForm(){
			document.moduleBbsForm.action='<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/bbsForm/registModuleBbsFormForm.do';
			document.moduleBbsForm.submit();
		}
		
		/** 게시판 양식 상세조회 */
		function fn_moduleBbsFormDetail(paramSeq){
			document.moduleBbsForm.formSeq.value = paramSeq;
			document.moduleBbsForm.action='<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/bbsForm/selectModuleBbsFormDetail.do';
			document.moduleBbsForm.submit();
		}
		
		/** 게시판 양식 삭제(한건) */
		function fn_moduleBbsFormDelete(paramSeq){
			if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" text="delete" /></spring:argument></spring:message>')){
				document.moduleBbsForm.formSeq.value = paramSeq;
				
				$.ajax({
					type:'POST'
					, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/bbsForm/deleteModuleBbsFormAjax.do'
					, data:$("#moduleBbsForm").serialize()
					,success:function (result){
						$(result).find('value').each(function(){
							if($(this).text() == "success"){
								alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
								fnSearch();
							}else{
								alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
							}
						})
					}
					, error:function (request, status, error) {
			              alert('<spring:message code="fail.common.msg" text="error" />');
			          }
				});
			}else{
				return;
			}
		}
		
		/** 검색 */
		function fnSearch(){
			document.moduleBbsForm.pageIndex.value = 1;
			document.moduleBbsForm.action='<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/bbsForm/selectModuleBbsFormList.do';
			document.moduleBbsForm.submit();
		}

		/** 페이징 */
		function fnPage(paramPageIndex){
			if(isNaN(paramPageIndex)){console.log('잘못된 페이지호출');return;}
			document.moduleBbsForm.pageIndex.value = paramPageIndex;
			document.moduleBbsForm.action='<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/bbsForm/selectModuleBbsFormList.do';
			document.moduleBbsForm.submit();
		}

		/** 게시판 리스트 팝업 */
		function fn_bbsApplcListPopup(paramFormSeq){
			
			document.bbsApplcListForm.formSeq.value = paramFormSeq;
			
        	$('body').css({overflow:'hidden'});
            
            $.ajax({
                type : 'POST'
                , url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/bbsForm/selectBbsApplcListPopup.do'
                , dataType : 'html'
                , data : $("#bbsApplcListForm").serialize()
                , success : function (result) {
					//$("#divLayerPopup").html(result);
					//$("#divLayerPopup").show();
                	 var title = '<spring:message code="wzwg.cmm.word.bbs" /> <spring:message code="wzwg.cmm.word.list" />';
       	    	 	 wzAjaxModal('popup_s', title, result);
                }
                , error : function (request, status, error) {
                    alert('<spring:message code="fail.common.msg" text="error" />');
                }
            });

			
		}
		
		/** fn_applcList는 게시판 양식에 적용된 게시판 리스트들을 불러오는 역할을 함(Ajax로 단순 페이지 호출) */
		$(document).ready(function(){
			<c:forEach items="${bbsFormList}" var="bbsFormList">
				fn_applcList('<c:out value="${bbsFormList.formSeq}"/>');
			</c:forEach>
		});
		
		function fn_applcList(paramSeq){
			document.moduleBbsForm.formSeq.value = paramSeq;
			
			$.ajax({
				type:'POST'
				, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/bbsForm/selectModuleBbsFormApplcListAjax.do'
				, data:$("#moduleBbsForm").serialize()
				, dataType: 'html'
				, async:false
				,success:function (result){
					$('#applcDiv'+paramSeq).html(result);
				}
				,error:function (result){
					//통신 실패시 실행할 function
				}
			});
		}
		
		function fn_moduleBbsFormPreview(formSeq){
			document.moduleBbsForm.formSeq.value = formSeq;
			
			$.ajax({
				type:'POST'
				, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/bbsForm/selectModuleBbsFormPrevewPopup.do'
				, data:$("#moduleBbsForm").serialize()
				, dataType: 'html'
				, async:false
				,success:function (result){
					//$('#divLayerPopup').html(result);
					//$('#divLayerPopup').show();
					var title = '<spring:message code="wzwg.cmm.cntnts.nttform" /> <spring:message code="wzwg.cmm.word.preview" />';
					wzAjaxModal('popup_s', title, result);
				}
				,error:function (result){
					//통신 실패시 실행할 function
				}
			});
		}

	</script>

	<div class="wz_notice brbox bg-white br-blue-strong" style="overflow: visible;">
	        <ul class="wd100">
	                <li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG025" /></li>
	                <li class="admpg-subp wd100 wzAdmSTit p0 mb0" style="background: transparent;">· <spring:message code="wzwg.module.word.applcex" />
	                        <div class="menu_help">
		                <img src="/images/wzwg/site/mngr/ico_help_grey.png" alt="">
		                <div class="help_pop">
		                       <img src="/images/wzwg/site/mngr/helpimg_boardForm.jpg" class="mxwd100" alt="">
	                                </div>
	                        </div>
	                </li>	
	        </ul>
	</div>
		
	<!-- 레이어팝업 영역 Start -->
	<div id="divLayerPopup" class="pop-box"></div>
	<!-- 레이어팝업 영역 End -->
       
	<form name="bbsApplcListForm" id="bbsApplcListForm" method="post">
		<input type="hidden" name="formSeq" id="formSeq" value=""/>
		<input type="hidden" name="formSttusCode" id="formSttusCode" value="list"/>
	</form>

	<form id="moduleBbsForm" name="moduleBbsForm" method="post">
		<input type="hidden" name="formSeq" id="formSeq" value=""/>
		<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex}"/>" />
		<input type="hidden" name="pageUnit" value="10" />
		<div class="main-menu-bar">
			<select name="searchCondition" id="searchCondition">
				<option value=""  <c:if test="${empty paramVO.searchCondition  }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.all" /></option>
				<option value="1" <c:if test="${paramVO.searchCondition eq '1' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.sj" /></option>
				<option value="2" <c:if test="${paramVO.searchCondition eq '2' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.cn" /></option>
			</select>
			
			<c:set var="srchwrd">
				<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
			</c:set>

			<input type="text" name="searchKeyword" id="searchKeyword" placeholder="<c:out value='${srchwrd}'/>" class="txt" onkeypress="if(window.event.keyCode == 13) {fnSearch();}" <c:if test="${!empty paramVO.searchKeyword}">value="<c:out value='${paramVO.searchKeyword }'/>"</c:if> />
	 		<a href="javascript:void(0);" class="wzbtn-table btn-srch" onclick="fnSearch();"><spring:message code="wzwg.cmm.word.search01" /></a>
		</div>
	
		<table class="basic-table">
			<colgroup>
				<col width="5%" />
				<col width="10%" />
		        <col width="30%" />
		        <col width="*" />
		        <col width="15%" />
		        <!-- <col width="10%"/> -->
		        <col width="15%"/>
			</colgroup>
			<thead>
			  	<tr>
			  		<th>No</th>
					<th><spring:message code="wzwg.cmm.word.cl" /></th>
					<th><spring:message code="wzwg.cmm.word.sj" /></th>
					<th colspan="2"><spring:message code="wzwg.module.word.applcbbs" /></th>
					<!-- <th><spring:message code="wzwg.cmm.word.wrter" /></th> -->
					<th><spring:message code="wzwg.cmm.word.rm" /></th>
		  		</tr>	
			</thead>
			<tbody>
			<c:choose>
				<c:when test="${!empty bbsFormList }">
					<c:forEach items="${bbsFormList }" var="bbsFormList" varStatus="status">
					<tr>
						<td>
							<c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.pageSize + status.count) + 1}"/>
						</td>
						<td>
							<c:out value="${bbsFormList.formClCodeNm }"/>
						</td>
						<td class="txt-l"><c:out value="${bbsFormList.formSj }"/></td>
						<td class="txt-l">
							<div id="applcDiv<c:out value='${bbsFormList.formSeq }'/>"/>
						</td>
						<td>
							<a href="javascript:void(0);" onclick="fn_bbsApplcListPopup('<c:out value="${bbsFormList.formSeq}"/>');" class="iconOnlyBtnSameSize btn-basic"><spring:message code="wzwg.module.word.bbsadd" /></a>
						</td>
						<!-- <td>
							<c:out value="${bbsFormList.userId }"/>
						</td> -->
						<td>
							<a href="javascript:void(0);" onclick="fn_moduleBbsFormPreview('<c:out value="${bbsFormList.formSeq}"/>')" class="iconOnlyBtnSameSize btn-basic"><spring:message code="wzwg.cmm.word.preview" /></a>
							<a href="javascript:void(0);" onclick="fn_moduleBbsFormDetail('<c:out value="${bbsFormList.formSeq}"/>')" class="iconOnlyBtn btn-basic btn-modify" title="<spring:message code="wzwg.cmm.word.updt" />"><spring:message code="wzwg.cmm.word.updt" /></a>
							<a href="javascript:void(0);" onclick="fn_moduleBbsFormDelete('<c:out value="${bbsFormList.formSeq}"/>')" class="iconOnlyBtn btn-basic btn-delete" title="<spring:message code="wzwg.cmm.word.delete" />"><spring:message code="wzwg.cmm.word.delete" /></a>
						</td>
					</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<td colspan="7"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
				</c:otherwise>
			</c:choose>
			</tbody>
		</table>
	 </form>
	 
	 <c:if test="${!empty bbsFormList}">
	 	<div class="ctr-box" id="pageInfo">
			<ul class="num mobile-none">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnPage" />
			</ul>
			
			<ul class="num pc-none">
				<ui:pagination paginationInfo="${mobilePaginationInfo}" type="image" jsFunction="fnPage" />
			</ul>
		</div>
	 </c:if>

	 <div class="rt-box">
		<a href="javascript:void(0);" class="wzbtn btn-save bg" onclick="fn_moduleBbsFormRegistForm();"><spring:message code="wzwg.cmm.word.regist" /></a>
	 </div>
