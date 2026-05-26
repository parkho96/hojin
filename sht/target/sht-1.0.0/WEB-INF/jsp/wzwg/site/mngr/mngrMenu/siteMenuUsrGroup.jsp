<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
    
<script type="text/javascript">
function fnAuthorSeAllChk(chk, chkVal) {
    
    $('.authorSe').prop('checked', false); // 해제하기

    if (chk) {
        $('.rdoAuthorSe'+chkVal).prop('checked', true); // 선택하기
    }
}
function fnSearch(){
    var frm = document.frmReg;
    frm.action='<c:out value="${wzwg_contextPath}"/>/mngr/menu/selectSiteMenuByUsrGroup.do';
    frm.submit();
}
function fnRegist() {
    if(confirm('<spring:message code="wzwg.site.menu.msg.MSG055"/>')){
        
        var authorSeArr = new Array();
        
        $('.authorSe').each(function(idx){
            if ($(this).prop('checked')) {
                
                var chkVal = $(this).val();
                var chkValArr = chkVal.split(':');
                var data = new Object();
                
                data.sitecntntsSeq  = chkValArr[0];
                data.authorSe       = chkValArr[1];
                data.menuSeq        = chkValArr[2];

                authorSeArr.push(data);
            }
        });
        
//         alert(JSON.stringify(authorSeArr));
        var frm = document.frmReg;
        
        frm.authorSeStrArr.value = JSON.stringify(authorSeArr);
        frm.usrgroupSeq.value = frm.srhUsrGroupSeq.value;
        
        $.ajax({
            type:'POST'
            , url:'<c:out value="${wzwg_contextPath}"/>/mngr/menu/registSiteMenuByUsrGroup.do'
            , data:$("#frmReg").serialize()
            ,success:function (result){
                $(result).find('value').each(function(){
                    if($(this).text() == "success"){
                        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
                        fnSearch();
                    }else{
                        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
                    }
                })
            }
            , error:function (request, status, error) {
                  alert('<spring:message code="fail.common.msg" text="error" />');
              }
        });
    }
}
</script>
      
 		<div class="wz_notice brbox bg-white br-blue-strong">	
	        <ul class="wd100">
	                <li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG054" /></li>
	                <li class="admpg-subp wd100 mb0 grey">· <spring:message code="wzwg.cmm.msg.tip.MSG055" /></li>
	         </ul>
		</div>
         <!-- <h3 class="wzAdmSTit  wd100 fl"><spring:message code="wzwg.site.menu.msg.MSG045"/></h3> -->
        
        <form id="frmReg" name="frmReg" method="post">
        <input type="hidden" id="usrgroupSeq" name="usrgroupSeq" />
        <input type="hidden" id="authorSeStrArr" name="authorSeStrArr" />
        
        <div class="wzAdmSrchbox txt-l wd50">
        	<b class="fs17 linehgt40 i-block"><spring:message code="wzwg.site.menu.msg.MSG046" /></b> : 
            <select name="srhUsrGroupSeq" id="srhUsrGroupSeq" onchange="fnSearch();">
                <c:forEach items="${usrGroupList}" var="result">
                <c:if test="${result.usrGroupSeq ne 10000000001 && result.usrGroupSeq ne 10000000002}">
                <option value="<c:out value="${result.usrGroupSeq}"/>" <c:if test="${result.usrGroupSeq eq paramVO.srhUsrGroupSeq}">selected</c:if>><c:out value="${result.usrGroupNm}" /></option>
                </c:if>
                </c:forEach>
            </select>
        </div>
            
        <div class="rt-box">
            <a href="javascript:void(0);" class="wzbtn btn-save" onclick="fnRegist();"><spring:message code="wzwg.cmm.word.stre" /></a>
        </div>
        
        <table class="basic-table">
            <colgroup>
                   <col width="18%"/>
                   <col width="18%"/> 
                   <col width="18%"/>
                   <col width="*"/>
            </colgroup>
             <thead>
                <tr class="bg-white">
                    <th rowspan="2"><spring:message code="wzwg.site.menu.msg.MSG052" /></th>
                    <th rowspan="2"><spring:message code="wzwg.site.menu.msg.MSG053" /></th>
                    <th rowspan="2"><spring:message code="wzwg.site.menu.msg.MSG054" /></th>
                    <th style="border-left:1px solid #f2f2f2;"><spring:message code="wzwg.cmm.word.author" /></th>
                </tr>
                <tr class="bg-white">
                	<th>
	                	<input id="read" type="radio" name="authorSeAll" value="R" onclick="fnAuthorSeAllChk(this.checked, this.value);" />
	                	<label for="read" class="fw400 fs16 mr10"><spring:message code="wzwg.cmm.word.redng" /></label>
	                	
	                    <c:if test="${fn:indexOf(baseUsrgroupSeq,paramVO.srhUsrGroupSeq) < 0 || paramVO.srhUsrGroupSeq ne '10000000003'}">
	                    <input id="write" type="radio" name="authorSeAll" value="W" onclick="fnAuthorSeAllChk(this.checked, this.value);" />
	                    <label for="write" class="fw400 fs16 mr10"><spring:message code="wzwg.cmm.word.regist" /></label>
	                    </c:if>
	                    
	                    <input id="nothing" type="radio" name="authorSeAll" value="N" onclick="fnAuthorSeAllChk(this.checked, this.value);" />
	                    <label for="nothing" class="fw400 fs16"><spring:message code="wzwg.cmm.word.noauthor" /></label>
                	</th>
                </tr>
                
            </thead>
            <tbody>
            
            <c:forEach items="${resultList}" var="oneDepth" varStatus="oneStatus">
            <c:if test="${empty oneDepth.upperMenuSeq or oneDepth.upperMenuSeq eq '0' }"> 
                <tr>
                        <td><c:out value="${oneDepth.menuNm}"/></td>
                        <td></td>
                        <td></td>
                        <td>
                    <c:set var="authorSe" value="" />
                    <c:if test="${!empty oneDepth.menuDivision && oneDepth.menuDivision ne 'group' && oneDepth.menuDivision ne 'link'}">
                    
                    <c:forEach items="${authList}" var="auth">
                        <c:if test="${oneDepth.sitecntntsSeq eq auth.sitecntntsSeq}">
                            <c:set var="authorSe" value="${auth.authorSe}" />
                        </c:if>
                    </c:forEach>
                    
                    <!-- <input type="hidden" class="authorSeArr" id="authorSeArr" name="authorSeArr" /> -->
                    <input type="radio" class="authorSe rdoAuthorSeR" name="authorSe_<c:out value="${oneStatus.count}"/>" value="<c:out value="${oneDepth.sitecntntsSeq}"/>:R:<c:out value="${oneDepth.menuSeq}"/>" <c:if test="${authorSe eq 'R'}">checked</c:if> /> <spring:message code="wzwg.cmm.word.redng" />
                    <c:if test="${fn:indexOf(baseUsrgroupSeq,paramVO.srhUsrGroupSeq) < 0 || paramVO.srhUsrGroupSeq ne '10000000003'}">
                    <c:if test="${oneDepth.menuTyCode ne 'SC00000033'}">
                    <input type="radio" class="authorSe rdoAuthorSeW" name="authorSe_<c:out value="${oneStatus.count}"/>" value="<c:out value="${oneDepth.sitecntntsSeq}"/>:W:<c:out value="${oneDepth.menuSeq}"/>" <c:if test="${authorSe eq 'W'}">checked</c:if> /> <spring:message code="wzwg.cmm.word.regist" />
                    </c:if>
                    </c:if>
                    <input type="radio" class="authorSe rdoAuthorSeN" name="authorSe_<c:out value="${oneStatus.count}"/>" value="<c:out value="${oneDepth.sitecntntsSeq}"/>:N:<c:out value="${oneDepth.menuSeq}"/>" <c:if test="${authorSe eq 'N' || empty authorSe}">checked</c:if> /> <spring:message code="wzwg.cmm.word.noauthor" />
                    </c:if>
                        </td>
                </tr>
                
                     <c:forEach items="${resultList}" var="twoDepth" varStatus="twoStatus">
                        <c:if test="${oneDepth.menuSeq eq twoDepth.upperMenuSeq}"> 
                        <tr>
                        <td></td>  
                        <td><c:out value="${twoDepth.menuNm}"/></td>  
                        <td></td>  
                        <td>
                            <c:set var="authorSe" value="" />
                            <c:if test="${!empty twoDepth.menuDivision && twoDepth.menuDivision ne 'group' && twoDepth.menuDivision ne 'link'}">
                            
                            <c:forEach items="${authList}" var="auth">
                                <c:if test="${twoDepth.sitecntntsSeq eq auth.sitecntntsSeq}">
                                    <c:set var="authorSe" value="${auth.authorSe}" />
                                </c:if>
                            </c:forEach>
                            
                            <!-- <input type="hidden" class="authorSeArr" id="authorSeArr" name="authorSeArr" /> -->
                            <input type="radio" class="authorSe rdoAuthorSeR" name="authorSe_<c:out value="${twoStatus.count}"/>" value="<c:out value="${twoDepth.sitecntntsSeq}"/>:R:<c:out value="${twoDepth.menuSeq}"/>" <c:if test="${authorSe eq 'R'}">checked</c:if> /> <spring:message code="wzwg.cmm.word.redng" />
                            <c:if test="${fn:indexOf(baseUsrgroupSeq,paramVO.srhUsrGroupSeq) < 0 || paramVO.srhUsrGroupSeq ne '10000000003'}">
                            <c:if test="${twoDepth.menuTyCode ne 'SC00000033'}">
                            <input type="radio" class="authorSe rdoAuthorSeW" name="authorSe_<c:out value="${twoStatus.count}"/>" value="<c:out value="${twoDepth.sitecntntsSeq}"/>:W:<c:out value="${twoDepth.menuSeq}"/>" <c:if test="${authorSe eq 'W'}">checked</c:if> /> <spring:message code="wzwg.cmm.word.regist" />
                            </c:if>
                            </c:if>
                            <input type="radio" class="authorSe rdoAuthorSeN" name="authorSe_<c:out value="${twoStatus.count}"/>" value="<c:out value="${twoDepth.sitecntntsSeq}"/>:N:<c:out value="${twoDepth.menuSeq}"/>" <c:if test="${authorSe eq 'N' || empty authorSe}">checked</c:if> /> <spring:message code="wzwg.cmm.word.noauthor" />
                            </c:if>
                        </td>
                        </tr>
                        <c:forEach items="${resultList}" var="threeDepth" varStatus="treeStatus">
                            <c:if test="${twoDepth.menuSeq eq threeDepth.upperMenuSeq}"> 
                            <tr>
                        <td></td>  
                        <td></td>  
                        <td><c:out value="${threeDepth.menuNm}"/></td>  
                        <td>
		                    <c:set var="authorSe" value="" />
		                    <c:if test="${!empty threeDepth.menuDivision && threeDepth.menuDivision ne 'group' && threeDepth.menuDivision ne 'link'}">
		                    
		                    <c:forEach items="${authList}" var="auth">
		                        <c:if test="${threeDepth.sitecntntsSeq eq auth.sitecntntsSeq}">
		                            <c:set var="authorSe" value="${auth.authorSe}" />
		                        </c:if>
		                    </c:forEach>
		                    
		                   <!--  <input type="hidden" class="authorSeArr" id="authorSeArr" name="authorSeArr" /> -->
		                    <input type="radio" class="authorSe rdoAuthorSeR" name="authorSe_<c:out value="${treeStatus.count}"/>" value="<c:out value="${threeDepth.sitecntntsSeq}"/>:R:<c:out value="${threeDepth.menuSeq}"/>" <c:if test="${authorSe eq 'R'}">checked</c:if> /> <spring:message code="wzwg.cmm.word.redng" />
		                    <c:if test="${fn:indexOf(baseUsrgroupSeq,paramVO.srhUsrGroupSeq) < 0 || paramVO.srhUsrGroupSeq ne '10000000003'}">
		                    <c:if test="${threeDepth.menuTyCode ne 'SC00000033'}">
		                    <input type="radio" class="authorSe rdoAuthorSeW" name="authorSe_<c:out value="${treeStatus.count}"/>" value="<c:out value="${threeDepth.sitecntntsSeq}"/>:W:<c:out value="${threeDepth.menuSeq}"/>" <c:if test="${authorSe eq 'W'}">checked</c:if> /> <spring:message code="wzwg.cmm.word.regist" />
		                    </c:if>
		                    </c:if>
		                    <input type="radio" class="authorSe rdoAuthorSeN" name="authorSe_<c:out value="${treeStatus.count}"/>" value="<c:out value="${threeDepth.sitecntntsSeq}"/>:N:<c:out value="${threeDepth.menuSeq}"/>" <c:if test="${authorSe eq 'N' || empty authorSe}">checked</c:if> /> <spring:message code="wzwg.cmm.word.noauthor" />
		                    </c:if>
                        </td>
                            </tr>
                             </c:if>
                         </c:forEach> 
                         </c:if>
                        </c:forEach>
                </c:if>
                </c:forEach>
            </tbody>
        </table>
        </form>
      <!--   
    <div class="rt-box">
        <a href="javascript:void(0);" class="wzbtn btn-save" onclick="fnRegist();"><spring:message code="wzwg.cmm.word.stre" /></a>
    </div>
       -->
      
        
         
      
