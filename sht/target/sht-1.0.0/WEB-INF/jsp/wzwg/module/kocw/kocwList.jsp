<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<link href="/css/wzwg/cmm/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="/css/wzwg/module/kocw/style.css" media="all" />

<script type="text/javascript" src="/js/wzwg/cmm/common.js" ></script>
<script language="javascript" type="text/javascript" src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>
<script language="javascript" type="text/javascript" src="/jquery/js/jquery.form.min.js"></script>

<script type="text/javascript">

$(document).ready(function(){
    $(".datePicker").datepicker({       
        dateFormat: 'yy-mm-dd',
        monthNamesShort: ['1<spring:message code="wzwg.cmm.word.mt" />','2<spring:message code="wzwg.cmm.word.mt" />','3<spring:message code="wzwg.cmm.word.mt" />','4<spring:message code="wzwg.cmm.word.mt" />','5<spring:message code="wzwg.cmm.word.mt" />','6<spring:message code="wzwg.cmm.word.mt" />','7<spring:message code="wzwg.cmm.word.mt" />','8<spring:message code="wzwg.cmm.word.mt" />','9<spring:message code="wzwg.cmm.word.mt" />','10<spring:message code="wzwg.cmm.word.mt" />','11<spring:message code="wzwg.cmm.word.mt" />','12<spring:message code="wzwg.cmm.word.mt" />'],
        dayNamesMin: ['<spring:message code="wzwg.cmm.word.sun01" />','<spring:message code="wzwg.cmm.word.mon01" />','<spring:message code="wzwg.cmm.word.tue01" />','<spring:message code="wzwg.cmm.word.wed01" />','<spring:message code="wzwg.cmm.word.thu01" />','<spring:message code="wzwg.cmm.word.fri01" />','<spring:message code="wzwg.cmm.word.sat01" />'],
        weekHeader: 'Wk',
        changeMonth: true,     //월변경가능
        changeYear: true,  //년변경가능
        yearRange:'-10:+10',   // 연도 셀렉트 박스 범위(현재와 같으면 1988~현재년)
        showMonthAfterYear: true,  //년 뒤에 월 표시
        buttonImageOnly: false, //이미지표시  
        buttonText: '<spring:message code="wzwg.cmm.msg.MSG088" />', 
        autoSize: false     //오토리사이즈(body등 상위태그의 설정에 따른다)
       });
});


function fnKocwSearch(pageIndex) {
    if(isNaN(pageIndex)){console.log('잘못된 페이지호출');return;}
    
    var frm = document.frmSrh;
    
    frm.pageIndex.value = pageIndex;
    
    $.ajax({
        type:'POST'
      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/kocw/selectKocwListAjax.do'
      , cache : false
      , async : false
      , data:$("#frmSrh").serialize()
      , success:function (data) {
          $('#kocw_area').html(data);
      }
      , error:function (data) {
          alert('<spring:message code="fail.common.msg" text="error" />');
      }
      , dataType: 'html'
    });
}
</script>


    <form:form modelAttribute="paramVO" id="frmSrh" name="frmSrh">
    <input type="hidden" id="pageIndex" name="pageIndex" value="<c:out value='${resultVO.pageIndex}'/>" />
    <div class="ocwWrap">

        <div class="ocwfx">
            <ul>
                <li>
                    <select name="categoryId" id="categoryId">
                        <option value="00" <c:if test="${empty resultVO.categoryId}">selected</c:if> >전체</option>
                        <option value="01" <c:if test="${resultVO.categoryId eq '01'}">selected</c:if> >인문</option>
                        <option value="02" <c:if test="${resultVO.categoryId eq '02'}">selected</c:if> >사회</option>
                        <option value="03" <c:if test="${resultVO.categoryId eq '03'}">selected</c:if> >공학</option>
                        <option value="04" <c:if test="${resultVO.categoryId eq '04'}">selected</c:if> >자연과학</option>
                        <option value="05" <c:if test="${resultVO.categoryId eq '05'}">selected</c:if> >교육학</option>
                        <option value="06" <c:if test="${resultVO.categoryId eq '06'}">selected</c:if> >의약학</option>
                        <option value="07" <c:if test="${resultVO.categoryId eq '07'}">selected</c:if> >예술체육</option>
                    </select>
                </li>
                <li>
                    <input type="text" id="from" name="from" class="datePicker cal" value="<c:out value='${resultVO.from}'/>"  readonly="readonly" title="<spring:message code="wzwg.cmm.word.bgnde" />" placeholder="시작일을(를) 선택해주세요" >
                    <span>~</span>
                    <input type="text" id="to" name="to" class="datePicker cal" value="<c:out value='${resultVO.to}'/>" readonly="readonly" title="<spring:message code="wzwg.cmm.word.endde" />" placeholder="종료일을(를) 선택해주세요" >
                    <a href="javascript:void(0);" onclick="fnSearch(1);" class="ocwbtn">검색</a>
                </li>
            </ul>
            <ul>
                <li>총 게시물 <c:out value="${paginationInfo.totalRecordCount}" />개,</li>
                <c:set var="totalPageCnt" value="${paginationInfo.totalRecordCount/paginationInfo.pageSize}" />
                <c:set var="temp" value="${totalPageCnt + (1 - (totalPageCnt % 1)) % 1}" />
                <li>페이지 <c:out value="${paginationInfo.currentPageNo}" /> / <fmt:formatNumber value="${fn:escapeXml(temp)}" type="number" /></li>
            </ul>
        </div>
        
        <ul class="ocwBoard">
            
            <c:choose>
            <c:when test="${!empty resultList}">
            <c:forEach var="result" items="${resultList}">
            <li>    
                <div class="ocwBoard-img">
                    <div class="imgbox">
                        <a href="javascript:void(0);">
                            <img src="<c:out value='${result.thumbnail_url}'/>" alt="" />
                        </a>
                    </div> 
                </div>
                <div class="ocwBoard-txt"> 
                    <h3>
                        <a href="javascript:void(0);"><c:out value="${result.course_title}" /></a>
                    </h3>
                    <ul>
                        <li><a href="javascript:void(0);"><c:out value="${result.provider}" /></a></li>
                        <li><a href="javascript:void(0);"><c:out value="${result.lecturer}" /></a></li>
                        <li><a href="javascript:void(0);"><c:out value="${result.term}" /></a></li>
                    </ul>
                    <div class="comM_txt">
                        <a href="javascript:void(0);"><c:out value="${result.course_description}" /></a>
                    </div>
                        <a href="<c:out value='${result.course_url}'/>" class="ocwbtn">강의보기</a>
<!--                         <ul class="ocwFile"> -->
<!--                             <li><a href="javascript:void(0);" class="fff"><img src="/images/wzwg/module/kocw/pdfIcon.png" alt="" /></a></li> -->
<!--                             <li><a href="javascript:void(0);" class="fff"><img src="/images/wzwg/module/kocw/pdfIcon.png" alt="" /></a></li> -->
<!--                         </ul> -->
                </div>
            </li>
            </c:forEach>
            </c:when>
            <c:otherwise>
            </c:otherwise>
            </c:choose>
        </ul>
    <c:if test="${!empty resultList}">
    <div class="ctr-box">
        <ul class="num">
            <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnKocwSearch" />
        </ul>
    </div>
    </c:if>
    </div>
    </form:form>
                