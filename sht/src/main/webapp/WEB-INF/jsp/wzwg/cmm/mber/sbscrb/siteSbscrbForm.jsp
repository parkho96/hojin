<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

         <table class="sbscrbTable">
         	<caption><spring:message code="wzwg.cmm.cmmMsg.CMG024"><spring:argument><spring:message code="wzwg.cmm.word.mber" /> <spring:message code="wzwg.cmm.word.info" /> <spring:message code="wzwg.cmm.word.wa.of" /> <spring:message code="wzwg.cmm.word.nm02" />, <spring:message code="wzwg.cmm.word.id02" />, <spring:message code="wzwg.cmm.word.password" /> <c:if test="${empty paramVO.frmGubun}"><spring:message code="wzwg.cmm.word.input" /></c:if></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.wa.table" /></spring:argument></spring:message></caption>
            <colgroup>
                <col width="20%">
                <col width="40%">
                <col width="20%">
                <col width="*%">
            </colgroup>
            
            <c:choose>
            <c:when test="${!empty unityUsr && unityUsr}">
            <tr>
                <th scope="row" ><spring:message code="wzwg.cmm.word.nm02" /><span class="sbscrbPointc">*</span></th>
                <td colspan="3"><c:out value="${infoVO.userNm}" /></td>
            </tr>
            <tr>
                <th scope="row" ><spring:message code="wzwg.cmm.word.id02" /><span class="sbscrbPointc">*</span></th>
                <td colspan="3">
                    <input type="hidden" id="usrSeq" name="usrSeq" value="<c:out value="${infoVO.usrSeq}" />" />
                    <c:out value="${infoVO.userId}" />
                </td>
            </tr>
            </c:when>
            <c:otherwise>
            <c:choose>
            <c:when test="${empty paramVO.frmGubun}">
            <tr>
                <th scope="row" ><label for="userNm"><spring:message code="wzwg.cmm.word.nm02" /><span class="sbscrbPointc">*</span></label></th>
                <td colspan="3">
                    <c:choose>
                    <c:when test="${empty paramVO.crtfc_name}">
                    <form:input path="userNm" maxlength="25" onkeyup="fnKeyUpEvent('userNm', '5');" />
                    </c:when>
                    <c:otherwise>
                    <c:choose>
                    <c:when test="${paramVO.crtfctSeCode eq 'SC00000433'}">
                    <input type="hidden" id="userNm" name="userNm" value="<c:out value="${paramVO.crtfc_name}" />" /> 
                    <c:out value="${paramVO.crtfc_name}" />
                    </c:when>
                     <c:otherwise>
                     <input type="text" id="userNm" name="userNm" maxlength="25" onkeyup="fnKeyUpEvent('userNm', '5');" value="<c:out value="${paramVO.crtfc_name}" />" />
                     </c:otherwise>
                     </c:choose>
                    </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th scope="row" ><label for="inputUserId"><spring:message code="wzwg.cmm.word.id02" /><span class="sbscrbPointc">*</span></label></th>
                <td colspan="3">
                    <input type="text" id="inputUserId" name="inputUserId" maxlength="20" style="ime-mode:inactive;" onkeyup="fnKeyUpEvent('inputUserId', '6');" />
                    <a href="javascript:void(0);" id="dplct_btn" class="cfmBtn"><spring:message code="wzwg.cmm.word.dplctcnfirm" /></a>
                    <span id="dplct_div" style="display:none;" class="id_select_ok"><spring:message code="wzwg.cmm.word.iddplctcnfirmcompt" /></span>                       
                </td>
            </tr>
            </c:when>            
            <c:otherwise>
            <tr>
                <th scope="row" ><spring:message code="wzwg.cmm.word.nm02" /><span class="sbscrbPointc">*</span></th>
                <td colspan="3"><c:out value="${infoVO.userNm}" /></td>
            </tr>
            <tr>
                <th scope="row" ><spring:message code="wzwg.cmm.word.id02" /><span class="sbscrbPointc">*</span></th>
                <td colspan="3">
                    <c:out value="${infoVO.userId}" />
                </td>
            </tr>
            </c:otherwise>
            </c:choose>
            <c:if test="${empty paramVO.crtfctSeCode or paramVO.crtfctSeCode eq 'SC00000306'}">
            <tr>
                <th scope="row" ><label for="password"><spring:message code="wzwg.cmm.word.password" /><span class="sbscrbPointc">*</span></label></th>
                <td><form:password path="password" maxlength="20" /><span class="sbscrbPwspan"><spring:message code="wzwg.cmm.msg.MSG052" /></span></td>
                <th scope="row" ><label for="passwordCnfirm"><spring:message code="wzwg.cmm.word.passwordcnfirm" /><span class="sbscrbPointc">*</span></label></th>
                <td><input type="password" name="passwordCnfirm" id="passwordCnfirm" maxlength="20" autocomplete="off" /><a class="id_select_bt" href="javascript:void(0);"></td>
            </tr>        
            </c:if>
            <c:if test="${!empty sbsFormList}">
            <c:forEach items="${sbsFormList}" var="result">
           
            <c:if test="${result.mberSbsfrmCode eq 'SC00000085' && result.qesitmEstbsSe ne 'N'}">                   
            <tr>
                <th scope="row"  rowspan="2">
                	<spring:message code="wzwg.cmm.word.adres" />
                    <c:if test="${result.qesitmEstbsSe eq 'E'}">
                    <span class="sbscrbPointc">*</span>
                    </c:if>
                </th>
                <td colspan="3">
                    <input type="text" id="zip" name="zip" readonly="readonly" value="<c:out value='${infoVO.zip}'/>">
                    <a class="cfmBtn" onclick="execKakaoPostcode();"><spring:message code="wzwg.cmm.word.zipsearch" /></a>
                    <script src="https://t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
                    <script>

                        function execKakaoPostcode() {
                            new kakao.Postcode({
                                oncomplete: function(data) {
                                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                    
                                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                                    var fullAddr = ''; // 최종 주소 변수
                                    var extraAddr = ''; // 조합형 주소 변수
                    
                                    // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                                        fullAddr = data.roadAddress;
                    
                                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                                        fullAddr = data.jibunAddress;
                                    }
                    
                                    // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                                    if(data.userSelectedType === 'R'){
                                        //법정동명이 있을 경우 추가한다.
                                        if(data.bname !== ''){
                                            extraAddr += data.bname;
                                        }
                                        // 건물명이 있을 경우 추가한다.
                                        if(data.buildingName !== ''){
                                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                                        }
                                        // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                                        fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                                    }
                    
                                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                                    document.getElementById('zip').value = data.zonecode; //5자리 새우편번호 사용
                                    document.getElementById('bassAdres').value = fullAddr;
                    
                                    // 커서를 상세주소 필드로 이동한다.
                                    document.getElementById('detailAdres').focus();
                                }
                            }).open();
                        }
                    </script>         
                </td>
            </tr>
            <tr>            
                <td colspan="3">
                    <input type="text" name="bassAdres" id="bassAdres" placeholder="<spring:message code="wzwg.cmm.word.basadr" />" readonly="readonly" value="<c:out value="${infoVO.bassAdres}" />">
                    <input type="text" name="detailAdres" id="detailAdres" placeholder="<spring:message code="wzwg.cmm.word.detailadr" />" value="<c:out value="${infoVO.detailAdres}" />" />
                </td>
            </tr>               
            </c:if>
                
            <c:if test="${result.mberSbsfrmCode eq 'SC00000086' && result.qesitmEstbsSe ne 'N'}">
            <tr>
                <th scope="row" >
                	<spring:message code="wzwg.cmm.word.cttpc" />
                    <c:if test="${result.qesitmEstbsSe eq 'E'}">
                        <span class="sbscrbPointc">*</span>
                    </c:if>
                </th>
                <td colspan="3">
                    <select name="mTelnoF" id="mTelnoF">
                        <c:forEach items="${mTelnoList}" var="mTelno" varStatus="i">
                            <option value="<c:out value="${mTelno.codeNm}" />" <c:if test="${infoVO.mTelnoF eq mTelno.codeNm}">selected="selected"</c:if>><c:out value="${mTelno.codeNm}" /></option>
                        </c:forEach>
                    </select>                       
                    <span class="pd_3b">-</span>
                    <input type="text" name="mTelnoC" id="mTelnoC" value="<c:out value="${infoVO.mTelnoC}" />" maxlength="4" style="IME-MODE:disabled;" onkeypress="return numkeyCheck(event);" />
                    <span class="pd_3b">-</span>
                    <input type="text" name="mTelnoL" id="mTelnoL" value="<c:out value="${infoVO.mTelnoL}" />" maxlength="4" style="IME-MODE:disabled;" onkeypress="return numkeyCheck(event);" />
                </td>
            </tr>
            </c:if>     
            
            <c:if test="${result.mberSbsfrmCode eq 'SC00000087' && result.qesitmEstbsSe ne 'N'}">           
            <tr>
                <th scope="row" >
                	<spring:message code="wzwg.cmm.word.mbtlnum" />
                    <c:if test="${result.qesitmEstbsSe eq 'E'}">
                        <span class="sbscrbPointc">*</span>
                    </c:if>
                </th>
                <td colspan="3">
                    <select name="hTelnoF" id="hTelnoF">
                        <c:forEach items="${hTelnoList}" var="hTelno" varStatus="i">
                            <option value="<c:out value="${hTelno.codeNm}" />" <c:if test="${infoVO.hTelnoF eq hTelno.codeNm}">selected="selected"</c:if>><c:out value="${hTelno.codeNm}" /></option>
                        </c:forEach>
                    </select>
                    <span class="pd_3b">-</span>
                    <input type="text" name="hTelnoC" id="hTelnoC" value="<c:out value="${infoVO.hTelnoC}" />" maxlength="4" style="IME-MODE:disabled;" onkeypress="return numkeyCheck(event);" />
                    <span class="pd_3b">-</span>
                    <input type="text" name="hTelnoL" id="hTelnoL" value="<c:out value="${infoVO.hTelnoL}" />" maxlength="4" style="IME-MODE:disabled;" onkeypress="return numkeyCheck(event);" />
                </td>
            </tr>
           </c:if>
           <c:if test="${result.mberSbsfrmCode eq 'SC00000088' && result.qesitmEstbsSe ne 'N'}">
           <tr>
               <th scope="row" >
              		<spring:message code="wzwg.cmm.word.email" />	
                    <c:if test="${result.qesitmEstbsSe eq 'E'}">
                        <span class="sbscrbPointc">*</span>
                    </c:if>
               </th>
               <td colspan="3">
                   <c:if test="${!empty paramVO.crtfc_email}">
                   <c:set var="emailAdres" value="${paramVO.crtfc_email}"/>
                   </c:if>
                   <c:if test="${!empty infoVO.emailAdres}">
                   <c:set var="emailAdres" value="${infoVO.emailAdres}"/>
                   </c:if>
                   <c:set var="email" value="${fn:split(emailAdres, '@')}"/>
                    
                   <c:forEach items="${email}" var="emailData" varStatus="status">
                       <c:if test="${status.count == 1}"><c:set var="email1" value="${emailData}"/></c:if>
                       <c:if test="${status.count == 2}"><c:set var="email2" value="${emailData}"/></c:if>
                   </c:forEach>
                   <input type="text" name="email" id="email" value="<c:out value="${email1}" />" style="float:none;" />@
                   <input type="text" name="typeInput" id="typeInput" onchange="fn_emailDirectInput();" value="<c:out value="${email2}" />" style="float:none;"/>
                   <select onchange="fn_emailChange(this.value);" name="emailType" id="emailType" style="float:none;">
                       <option value=""><spring:message code="wzwg.cmm.word.drtinp" /></option>
                       <option value="naver.com">naver.com</option>
                       <option value="daum.com">daum.com</option>
                       <option value="gmail.com">gmail.com</option>
                       <option value="hanmail.net">hanmail.net</option>
                       <option value="dreamwiz.com">dreamwiz.com</option>
                   </select>
                   <input type="hidden" name="emailAdres" id="emailAdres" title="<spring:message code="wzwg.cmm.word.email" />" value="<c:out value="${emailAdres}" />"/>
               </td>
           </tr>
           </c:if>
           </c:forEach>
           </c:if>
           </c:otherwise>
           </c:choose>
            
         </table>

            <jsp:include page="/WEB-INF/jsp/wzwg/cmm/mber/sbscrb/siteSbscrbAdiForm.jsp" />
