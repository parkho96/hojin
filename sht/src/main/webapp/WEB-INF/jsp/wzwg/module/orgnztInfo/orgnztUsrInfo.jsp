<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<%-- [${sessionScope.LANG }] SC00000019 en SC00000016 kr --%>
<c:if test="${sessionScope.LANG eq 'SC00000016'}"><c:set var="langCode" value="kr"/></c:if>
<c:if test="${sessionScope.LANG eq 'SC00000019'}"><c:set var="langCode" value="en"/></c:if>

<link href="/css/wzwg/module/orgnzt/orgnzt.css" type="text/css" rel="stylesheet" />

<script type="text/javascript">
try{document.title = $('#menuPath').val().replace(/>/gi,'-').slice(0,-1);}catch(e){console.log(e.message);}
$(document).ready(function(){
   $('.org_open').click(function(){
      $('.hidn_org').slideDown();
      $('.org_close').focus();    
   });
    $('.org_close').click(function(){
      $('.hidn_org').slideUp();
      $('.org_open').focus();
    });
    
    if($('li.org03 > ul').children().length >= 5){
        $('li.org03 > ul').addClass('extends');
    }
    
    
  }); //end ready


<c:if test="${langCode eq 'en' }">
function fnGetOrgUsrInfoMemList(orgnztSeq, orgnztNmKr, orgnztTySe){
}
</c:if>

<c:if test="${langCode eq 'kr' }">
/* 구성원 리스트 */
function fnGetOrgUsrInfoMemList(orgnztSeq, orgnztNmKr, orgnztTySe){
	
	document.frmOrgUsrInfo.orgnztNmKr.value = orgnztNmKr;
	
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}" />/module/orgnztInfo/selectOrgUsrInfoMemListAjax.do'
		 , data : {'orgnztSeq' : orgnztSeq , 'orgnztTySe' : orgnztTySe}
		 , success:function (data) {
			
			$('.orgUsrInfoList').show();
			 	
			$('#labelMember').html('[' + orgnztNmKr + '] <spring:message code="wzwg.module.word.jobdfwrl"/>');
			$('.orgUsrInfoList .basic_orgbox button').css('display','inline-block');
			$('.txt-l').html(data.body.orgDcKr);
			
			
			$('#orgInfoMemList').show();

			$('#orgtbl > tbody').remove();
			$('#orgtbl').append(data.html.orgUsrInfoMemListAjax);
			
			
			if(orgnztTySe == 'ctrd'){
		 		$('.ctrdTh').show();
		 		$('.normalTh').hide();
			}else{
				$('.ctrdTh').hide();
				$('.normalTh').show();
			}
			
			$('#orgnztTySe').val(orgnztTySe);
			
			//스크롤 이동 추가 2019-11-28 조원권
			//접근성 이슈로 자동이동 주석처리함
			//$('html, body').animate({scrollTop: $('.orgUsrInfoList').offset().top})
			
		 }
		 , dataType: 'json'
	});
}
</c:if>
/* 구성원 검색 */
function fnOrgMemSearch(){
	var memSearchSel = $('#memSearchSel option:selected').val();
	var memSearchVal = $('#memSearchVal').val();
	var acctoSearchSel = $('#acctoSearchSel option:selected').val();
	
	$('#orgnztMemSearchSel').val(memSearchSel);
	$('#orgnztMemSearchVal').val(memSearchVal);
	$('#orgnztAcctoSearchSel').val(acctoSearchSel);
	
	$.ajax({
		  type:'POST'
		, url: '<c:out value="${wzwg_contextPath}" />/module/orgnztInfo/selectOrgUsrInfoMemListAjax.do'
		, data : $('#frmOrgUsrInfo').serialize()
		, success:function (data) {
			
			$('.orgUsrInfoList').show();
			
			$('#labelMember').html('[ <spring:message code="wzwg.module.word.searchresult"/> ]');
			$('.orgUsrInfoList .basic_orgbox button').css('display','none');
			$('.orgUsrInfoList .hidn_org').css('display','none');
			

			$('#orgInfoMemList').show();
			
			$('#orgtbl > tbody').remove();
			$('#orgtbl').append(data.html.orgUsrInfoMemListAjax);
			
			
			//$('.ctrdTh').hide();
			$('.normalTh').show();
			
			$('#orgnztTySe').val(orgnztTySe);
			
		}	
		, dataType: 'json'
	});
	
}

</script>


<div style="min-height: 500px;" id="mainContent">
	<form id="frmOrgUsrInfo" name="frmOrgUsrInfo" method="post" onsubmit="return false;">
		
	<input type="hidden" name="orgnztSeq" id="orgnztSeq" value="<c:out value="${paramVO.orgnztSeq}" />"/>
	<input type="hidden" name="orgnztNmKr" id="orgnztNmKr" value=""/>
	<input type="hidden" name="orgnztTySe" id="orgnztTySe" value=""/>
	
	<input type="hidden" name="orgnztMemSearchSel" id="orgnztMemSearchSel" value=""/>
	<input type="hidden" name="orgnztMemSearchVal" id="orgnztMemSearchVal" value=""/>
	<input type="hidden" name="orgnztAcctoSearchSel" id="orgnztAcctoSearchSel" value=""/>

<!-- 2020.09.21 구조변경 -->
 <div class="org_wrap">
     <div class="org_container <c:out value="${orgnztEstbsVO.cssClssNm}" />">
         <ul>
         	<li>
             <c:forEach items="${orgnztInfoList}" var="oneDepth">
                 <c:if test="${oneDepth.orgnztLv eq 1}">
                     <c:if test="${langCode eq 'kr' }">
                         <c:set var="orgNm"><c:out value="${oneDepth.orgnztNmKr}" /></c:set>
                     </c:if>
                     <c:if test="${langCode eq 'en' }">
                         <c:set var="orgNm"><c:out value="${oneDepth.orgnztNmEn}" /></c:set>
                     </c:if>
                         <p class="section_tit <c:out value="${oneDepth.cssClssNm}" />">
                             <a href="javascript:void(0);" class="bg_pt<c:if test="${fn:indexOf(oneDepth.cssClssNm, 'strong') >= 0 }"> white</c:if>" onclick="fnGetOrgUsrInfoMemList('<c:out value="${oneDepth.orgnztSeq}" />','<c:out value="${orgNm}" />','<c:out value="${oneDepth.orgnztTySe}" />')" title="<spring:message code="wzwg.cmm.msg.tip.MSG0960"/>"><c:out value="${orgNm}" /></a>
                         </p>
                 </c:if>
             </c:forEach>
			 	<ul>
             	<c:forEach items="${orgnztInfoList}" var="twoDepth">
                 	<c:if test="${twoDepth.orgnztLv eq 2 and twoDepth.orgnztTySe eq 'n'}">
                    <c:if test="${langCode eq 'kr' }">
                        <c:set var="orgNm"><c:out value="${twoDepth.orgnztNmKr}" /></c:set>
                    </c:if>
                    <c:if test="${langCode eq 'en' }">
                        <c:set var="orgNm"><c:out value="${twoDepth.orgnztNmEn}" /></c:set>
                    </c:if>
                	<li>
	                    <p class="section_tit <c:out value="${twoDepth.cssClssNm}" />">
	                        <a href="javascript:void(0);" class="bg_pt<c:if test="${fn:indexOf(twoDepth.cssClssNm, 'strong') >= 0 }"> white</c:if>" onclick="fnGetOrgUsrInfoMemList('<c:out value="${twoDepth.orgnztSeq}" />','<c:out value="${orgNm}" />','<c:out value="${twoDepth.orgnztTySe}" />')" title="<spring:message code="wzwg.cmm.msg.tip.MSG0960"/>"><c:out value="${orgNm}" /></a>
	                    </p>
                     	<ul class="list_line">
                     	<c:set var="threeVal" value="0" />
                     	<c:forEach items="${orgnztInfoList}" var="threeDepth" varStatus="status">
                        	<c:if test="${threeDepth.orgnztLv eq 3 and twoDepth.orgnztSeq eq threeDepth.parntsOrgnztSeq}">
                         	<c:set var="threeVal" value="${threeVal+1}" />
                            	<c:if test="${threeDepth.orgnztTySe eq 'n'}">
                                	<c:if test="${langCode eq 'kr' }">
                                    	<c:set var="orgNm"><c:out value="${threeDepth.orgnztNmKr}" /></c:set>
                                 	</c:if>
                                 	<c:if test="${langCode eq 'en' }">
                                    	<c:set var="orgNm"><c:out value="${threeDepth.orgnztNmEn}" /></c:set>
                                 	</c:if>
                               		<li <c:if test="${ threeVal mod 4 == 0 }">class="lasted"</c:if>>
                                  		<div class="part_tit <c:out value="${threeDepth.cssClssNm}" />">
                                          	<a class="<c:if test="${fn:indexOf(threeDepth.cssClssNm, 'strong') >= 0 }">white</c:if>" href="javascript:void(0);" onclick="fnGetOrgUsrInfoMemList('<c:out value="${threeDepth.orgnztSeq}" />','<c:out value="${orgNm}" />','<c:out value="${threeDepth.orgnztTySe}" />')" title="<spring:message code="wzwg.cmm.msg.tip.MSG0960"/>"><c:out value="${orgNm}" /></a>
                                       	</div>
                                       	<ul>
                                          <c:forEach items="${orgnztInfoList}" var="fourDepth">
                                          	<c:if test="${fourDepth.orgnztLv eq 4 and fourDepth.orgnztTySe eq 'n' and threeDepth.orgnztSeq eq fourDepth.parntsOrgnztSeq}">
                                                   <c:if test="${langCode eq 'kr' }">
                                                       <c:set var="orgNm"><c:out value="${fourDepth.orgnztNmKr}" /></c:set>
                                                   </c:if>
                                                   <c:if test="${langCode eq 'en' }">
                                                       <c:set var="orgNm"><c:out value="${fourDepth.orgnztNmEn}" /></c:set>
                                                   </c:if>
                                                   <li>
                                                   	<div class="colorBox <c:out value="${fourDepth.cssClssNm}" />"></div>
                                                   	<a class="<c:if test="${fn:indexOf(fourDepth.cssClssNm, 'strong') >= 0 }">white</c:if>" href="javascript:void(0);" onclick="fnGetOrgUsrInfoMemList('<c:out value="${fourDepth.orgnztSeq}" />','<c:out value="${orgNm}" />','<c:out value="${fourDepth.orgnztTySe}" />')" title="<spring:message code="wzwg.cmm.msg.tip.MSG0960"/>"><c:out value="${orgNm}" /></a>
                                                   </li>
                                               </c:if>
                                           </c:forEach>
                                       	</ul>
                                   	</li>
                             	</c:if>
		                        <c:if test="${ threeVal mod 4 == 0 }">
		                        </ul>
		                        <ul class="list_line">
		                        </c:if>
                          	</c:if>
                     	</c:forEach>
                    </li>
                    </ul>
                 </c:if>
             </c:forEach>
             	</ul>
            </li>
         </ul>
     </div>
 </div>
 
 <script>
 	$('.list_line').each(function() {
	    var a = $(this).children().length;
	    $(this).addClass('col' + a);
	})
 </script>
 
    <!-- ///////////////////	검색		/////////////////////// -->
    <c:if test="${langCode eq 'kr' }">
    <div class="orgUsrInfoSearch">
    	<div>
	    	<label for="memSearchSel"><span><spring:message code="wzwg.module.word.staffsearch"/></span></label>
	    	<select name="memSearchSel" id="memSearchSel" class="w30" title="<spring:message code="wzwg.module.word.staffsearchse"/>">
					<option value="name" <c:if test="${paramVO.orgnztMemSearchSel eq 'name'}">selected</c:if>><spring:message code="wzwg.cmm.word.nm02"/></option>
					<option value="telno" <c:if test="${paramVO.orgnztMemSearchSel eq 'telno'}">selected</c:if>><spring:message code="wzwg.cmm.word.telno"/></option>
					<option value="chrgJob" <c:if test="${paramVO.orgnztMemSearchSel eq 'chrgJob'}">selected</c:if>><spring:message code="wzwg.module.word.chrgjob"/></option>
			</select>
			<input type="text" name="memSearchVal" id="memSearchVal" value="<c:out value="${paramVO.orgnztMemSearchVal}" />" title="<spring:message code="wzwg.module.word.searchkeywordinput"/>" onkeypress="if(event.keyCode == 13){fnOrgMemSearch();}"/> 
    	</div>
    	
    	<div>
	    	<label for="acctoSearchSel"><span><spring:message code="wzwg.module.word.byorgtionsearchse"/></span></label>
	    	<select name="acctoSearchSel" id="acctoSearchSel" class="w30" title="<spring:message code="wzwg.module.word.byorgtionsearchse"/>">
				<option value="all"><spring:message code="wzwg.module.word.allsearch"/></option>
				<c:forEach items="${orgnztInfoList}" var="list" varStatus="status">
					<option value="<c:out value="${list.orgnztSeq}" />" <c:if test="${paramVO.orgnztAcctoSearchSel eq list.orgnztSeq}">selected</c:if>><c:out value="${list.orgnztNmKr}" /></option>
	    		</c:forEach>
			</select>
		</div>
			
		<button type="button" class="wzbtn-table" onclick="fnOrgMemSearch();"><spring:message code="wzwg.cmm.word.search01"/></button>
    	
    </div>
    </c:if>
    
    
    
    
    <!-- //////////////////		구성원	////////////////////// -->
   
   
	<div class="orgUsrInfoList" style="display:none;">
	    <div class="basic_orgbox">
	    	<h4><span id="labelMember"></span></h4>
	        
	        <button type="button" class="wzbtn-table btn-basic org_open">
	        	<spring:message code="wzwg.cmm.word.job"/>
				<spring:message code="wzwg.cmm.word.detail"/>
			    <spring:message code="wzwg.cmm.word.readng"/>
			    <spring:message code="wzwg.cmm.word.open01"/>
	        </button>
	        
	        <div class="hidn_org">
	            <table class="basic_orginfo">
	                <caption><spring:message code="wzwg.cmm.module.org.MSG009"/></caption>
	                <colgroup>
	                    <col width="20%">
	                    <col width="80%">
	                </colgroup>
	                <tbody>
	                    <tr>
	                        <th scope="row"><spring:message code="wzwg.module.word.jobintrcn"/></th>
	                        <td class="txt-l"><spring:message code="wzwg.cmm.module.org.MSG010"/></td>
	                    </tr>
	                </tbody>
	            </table>
	            
	           <button type="button" class="wzbtn-table btn-basic org_close">
	            	<spring:message code="wzwg.cmm.word.job"/>
	        		<spring:message code="wzwg.cmm.word.detail"/>
	        		<spring:message code="wzwg.cmm.word.readng"/>
	        		<spring:message code="wzwg.cmm.word.close"/>
	        	</button>
	        </div>
	      
	    </div>
		    
		<div id="orgInfoMemList">
		    <table class="basic_orgtbl" id="orgtbl">
		        <caption><spring:message code="wzwg.cmm.module.org.MSG011"/></caption>
		        <thead>
		            <tr>
		            	<th scope="col" class="normalTh mobile-none"><spring:message code="wzwg.module.word.deptnm"/></th>
		                <th scope="col"><spring:message code="wzwg.cmm.word.nm02"/></th>
		                <th scope="col"><spring:message code="wzwg.cmm.word.rspofc" /></th>
		                <th scope="col" class="txt-c" ><spring:message code="wzwg.module.word.chrgjob"/></th>
		                <th scope="col" class="txt-c" ><spring:message code="wzwg.cmm.word.cttpc"/></th>
		            </tr>
		            
		        </thead>
		        
		        	<!-- list data ajax -->
		        
		    </table>
		</div>
	</div>	

	</form>
	</div>
			<c:if test="${nowUrl.indexOf('/mngr') == -1 }">
			<div class="mt20" style="max-width: 1300px; margin: 0 auto;">
				<c:import url="${wzwg_contextPath}/usr/cntnts/cntPagadiEstbs/selectCntPagadiEstbsUsrAjax.do">
					<c:param name="nttSeqAt" value="N" />
					<c:param name="cntntsSeq" value="49000009102" /><%-- 컨텐츠 모듈이 아니기 때문에 가상번호 추가 --%>
					<c:param name="sitecntntsSeq" value="49000009102" /><%-- 컨텐츠 모듈이 아니기 때문에 가상번호 추가 --%>
				</c:import>
			</div>
			</c:if>