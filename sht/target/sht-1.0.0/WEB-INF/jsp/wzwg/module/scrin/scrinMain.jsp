<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.apache.commons.lang3.StringUtils" %>

<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript" src="/js/wzwg/cmm/jquery-latest.min.js"></script>
<script>
// 대분류 선택시 대분류에 맞는 중분류를 불러옴
function fnMenuClcListSelect(codeVal) {
    $.ajax({
        type:'POST'
      , url:'<c:out value="${wzwg_contextPath}" />/cmm/code/selectCmmGrpCodeList.do'
      , data:{upperGrpcode:codeVal}
      , success:function (data) {
          
          $('#menuMclCode').empty();
          
          $(data).find('response').find('item').each(function (idx) {
              
              var classId = $(this).find('name').text();
              var classNm = $(this).find('value').text();
              $('#menuMclCode').append('<option value="'+classId+'">'+classNm+'</option>');
          });
        }
      , dataType: 'xml'
  });
}

// 중분류 선택시 중분류에 맞는 샘플 목록을 출력함
function fnMenuMlcListSelect(codeVal) {
    $.ajax({
        type:'POST'
      , url:'<c:out value="${wzwg_contextPath}" />/module/scrin/module/selectSampleList.do'
      , data:{menuMclCode:codeVal}
      , success:function (data) {

          $('#divSampleList').html(data);
          
          fnCntntsModuleSelect(codeVal);
        }
      , dataType: 'html'
  });
}

// 중분류에 맞는 사이트 컨텐츠 목록을 가져옴
function fnCntntsModuleSelect(codeVal) {
    $.ajax({
        type:'POST'
      , url:'<c:out value="${wzwg_contextPath}" />/module/scrin/module/selectScrinCntntsModuleList.do'
      , data:{menuMclCode:codeVal}
      , success:function (data) {
          
          $('#sitecntntsSeq').empty();

          $('#sitecntntsSeq').append('<option value=""><spring:message code="wzwg.cmm.word.choise" /></option>');
          
          $(data).find('response').find('item').each(function (idx) {
              
              var classId = $(this).find('name').text();
              var classNm = $(this).find('value').text();
              $('#sitecntntsSeq').append('<option value="'+classId+'">'+classNm+'</option>');
          });
        }
      , dataType: 'xml'
  });
}

// sitecntntsSeq 콤보박스에서 선택한 모듈 데이터를 JSON으로 가져와서 글로벌 변수에 등록
var $sampleData = null;
function fnSelectCntntsJson(val) {
    $.ajax({
        type:'POST'
      , url:'<c:out value="${wzwg_contextPath}" />/module/scrin/scrinCntntsJson.do'
      , data:{sitecntntsSeq:val}
      , success:function (data) {
          $sampleData = data;
      }
      , dataType: 'json'
  });
}

// 샘플 HTML에 JOSN 데이터를 출력/적용
function fnSelectCntnts() {
    // 컨텐츠 정보 - 컨텐츠 <spring:message code="wzwg.cmm.word.sj" />
    $('#divSampleList .infoSj').text($sampleData.cntntsInfo.cntntsNm);

    // 컨텐츠 정보 - 목록 <spring:message code="wzwg.cmm.word.sj" />
    $('#divSampleList .listSj').each(function (index) {
        if ($sampleData['cntntsData'].length > index) {
            $(this).text($sampleData['cntntsData'][index].nttSj);   
        }
    });
}

$(document).ready(function() {

    fnDivCalCreate();
    
    $('.cntntsMd').each(function (index, parentEle) {
        var cntseq = $(this).data('cntseq');
        
        $.ajax({
            type:'POST'
          , url:'<c:out value="${wzwg_contextPath}" />/module/scrin/scrinCntntsJson.do'
          , data:{sitecntntsSeq:cntseq}
          , success:function (data) {
              fnDivJsonDataPrint(data, parentEle);
              
              
              
              
          }
          , dataType: 'json'
      });
    });
    
    $('.menuMd').each(function (index, parentEle) {
        $.ajax({
            type:'POST'
          , url:'<c:out value="${wzwg_contextPath}" />/module/scrin/scrinMenuJson.do'
          , contentType : "application/json"
          , success:function (data) {
//               alert(data['cntntsData'][0].menuNm);
//               fnDivJsonDataPrint(data, parentEle);
//                 if (data['cntntsData'].length > index) {
//                     $(this).html(data['cntntsData'][index].menuNm);   
//                 }
                // li 
                var liChk = 0;
                var preLv = 0;
                for (var i=0; i<data['cntntsData'].length; i++) {
                    if (data['cntntsData'][i].menuLv == 1) {
                        $('.testMenu').append('<li id="'+data['cntntsData'][i].menuSeq+'" class="depth1">['+data['cntntsData'][i].menuSeq+']'+data['cntntsData'][i].menuNm+'</li>');
                        liChk = 0;   
                    } else {
                        // 1차만 들어감
                        if (liChk == 0) {
                            $('.testMenu').find('li').last().append('<ul class="depth'+data['cntntsData'][i].menuLv+'"></ul>');   
                        } else {
                            // 이전 뎁스와 틀리면 UL 생성
                            if (preLv != data['cntntsData'][i].menuLv) {
                                $('.testMenu').find('li').last().append('<ul class="depth'+data['cntntsData'][i].menuLv+'"></ul>');   
                            }
                        }
                        // 마지막 UL에 메뉴 추가
                        $('.testMenu').find('ul').last().append('<li id="'+data['cntntsData'][i].menuSeq+'" class="depth'+data['cntntsData'][i].menuLv+'">['+data['cntntsData'][i].menuSeq+']'+data['cntntsData'][i].menuNm+'</li>');
                        preLv = data['cntntsData'][i].menuLv;
                        liChk = 1;
                    }
                }
            }
            , dataType: 'json'
        });
    });
});
var ttt = eval([{'menuSeq':10000000001,'menuTySe':'bbs'}]);
function fnRestful() {

    $.ajax({
        type:'POST'
      , url:'<c:out value="${wzwg_contextPath}" />/bbs/10000000001'
      , data:JSON.stringify(ttt)
      , success:function (data) {
      }
      , dataType: 'html'
  });
}

// JOSN 데이터를 출력/적용
function fnDivJsonDataPrint(data, ele) {

    // 컨텐츠 정보 - 컨텐츠 <spring:message code="wzwg.cmm.word.sj" />
    $(ele).find('.infoSj').html(data.cntntsInfo.cntntsNm);
    
    // 컨텐츠 정보 - 목록 <spring:message code="wzwg.cmm.word.sj" />
    $(ele).find('.listSj').each(function (index, childEle) {
        if (data['cntntsData'].length > index) {
            $(childEle).html(data['cntntsData'][index].nttSj);   
        }
    });
}

// 달력
var cal = eval([{0:28,1:29,2:30,3:31,4:1,5:2,6:3},{0:4,1:5,2:6,3:7,4:8,5:9,6:10},{0:11,1:12,2:13,3:14,4:15,5:16,6:17},{0:18,1:19,2:20,3:21,4:22,5:23,6:24},{0:25,1:26,2:27,3:28,4:29,5:30,6:1}]);

// 스케줄
var schl = eval([{0:[{'seq':1000,'sj':'ㅋㅋㅋㅋ'},{'seq':1001,'sj':'ㄷㄷㄷㄷ'}],1:'',2:'',3:[{'seq':1002,'sj':'DDDDDDD'}],4:'',5:'',6:[{'seq':1003,'sj':'00000000'}]},{0:[{'seq':1003,'sj':'00000000'},{'seq':1004,'sj':'1111111'}],1:[{'seq':1003,'sj':'00000000'}],2:'',3:'',4:'',5:'',6:[{'seq':1005,'sj':'테스트다'}]},{0:[{'seq':1005,'sj':'테스트다'}],1:[{'seq':1005,'sj':'테스트다'}],2:[{'seq':1005,'sj':'테스트다'},{'seq':1008,'sj':'겹침테스트다33'}],3:[{'seq':1005,'sj':'테스트다'},{'seq':1006,'sj':'겹침테스트다'},{'seq':1007,'sj':'겹침테스트다22'},{'seq':1008,'sj':'겹침테스트다33'}],4:[{'seq':1005,'sj':'테스트다'},{'seq':1006,'sj':'겹침테스트다'},{'seq':1007,'sj':'겹침테스트다22'}],5:[{'seq':1005,'sj':'테스트다'},{'seq':1006,'sj':'겹침테스트다'}],6:[{'seq':1005,'sj':'테스트다'}]},{},{}]);

function fnDivCalCreate() {

    $(cal).each(function (index) {
        var divColor = (index%2)? 'red':'blue';
        // week row 생성
        $('#divCal').append('<div class="wekRow" style="background-color:'+divColor+';"><table id="tbWek'+index+'"><tr></tr></table><table id="tbSch'+index+'"><colgroup><col width="100px"/><col width="100px"/><col width="100px"/><col width="100px"/><col width="100px"/><col width="100px"/><col width="100px"/></colgroup></table></div>');        

        
        // day 생성
        for (var i=0; i<7; i++) {
            $('#tbWek'+index).find('tr').eq(0).append('<td style="width:100px;">'+cal[index][i]+'</td>'); 
            
        }
        
        // week row 생성
        $('#divCal').append('<div class="wekRow" style="background-color:'+divColor+';"><table id="tbSch'+index+'"></table></div>');
    });

    $(schl).each(function (index) {
        
        // day 생성
        for (var i=0; i<7; i++) {
            
            // 주단위 스케줄 데이터
            var wekSchData = schl[index][i];
            
            // day 스케줄 있을때..
            if (wekSchData != undefined) {

                console.log(wekSchData.length+':'+$('#tbSch'+index).find('tr').length);
                // 스케줄 크기만큼 tr 생성
                if ($('#tbSch'+index).find('tr').length != wekSchData.length) {
                    
                    for (var chlIdx=$('#tbSch'+index).find('tr').length; chlIdx<wekSchData.length; chlIdx++) {
                        $('#tbSch'+index).append('<tr class="trSch'+chlIdx+'" style="background-color:pink;"><td class="td0"></td><td class="td1"></td><td class="td2"></td><td class="td3"></td><td class="td4"></td><td class="td5"></td><td class="td6"></td></tr>');
                    }
                }
                
                // 스케줄 갯수대로...
                for (var chlIdx=0; chlIdx<wekSchData.length; chlIdx++) {
                    
                    
                    // 일단위 스케줄 데이터
                    var daySchData = wekSchData[chlIdx];
                    
                    // 현재 이벤트 줘야되는 td
                    var eventTd = $('#tbSch'+index).find('.trSch'+chlIdx).find('.td'+i);
//                     console.log("* row : "+chlIdx+" , tr : "+chlIdx+", td : "+i+", sj : "+daySchData.sj);

                    console.log(eventTd.prev().text() + ", " + daySchData.sj);
                    // 이전 값이 있나?
                    if (eventTd.prev().text() != '') {
                        // find('.td'+i)             
                        // 이전 노드의 colspan
                        var prevColspan = eventTd.prev().attr('colspan');
                        
                        // 값이 셋팅 되지 않았을때
                        if (prevColspan == undefined) {
                            prevColspan = 2;
                        } else {
                            prevColspan++;
                        }
                        
                        // 이전 노드의 colspan 추가
                        eventTd.prev().attr('colspan', prevColspan);
                        
                        // 현재 td 삭제
                        eventTd.remove();
                    } else {
                        // 스케줄 생성
                        eventTd.append(daySchData.sj);
                    }
                }
            }
        }
        
    });
}

function fnDivCalCreate22() {
    
    $(cal).each(function (index) {
        var divColor = (index%2)? 'red':'blue';
        // week row 생성
        $('#divCal').append('<div class="wekRow" style="background-color:'+divColor+';"><table id="tbWek'+index+'"><tr></tr></table><table id="tbSch'+index+'"><colgroup><col width="100px"/><col width="100px"/><col width="100px"/><col width="100px"/><col width="100px"/><col width="100px"/><col width="100px"/></colgroup></table></div>');        

        
        // day 생성
        for (var i=0; i<7; i++) {
            $('#tbWek'+index).find('tr').eq(0).append('<td style="width:100px;">'+cal[index][i]+'</td>'); 
            
        }
        
        // week row 생성
        $('#divCal').append('<div class="wekRow" style="background-color:'+divColor+';"><table id="tbSch'+index+'"></table></div>');
    });

    $(schl).each(function (index) {
        
        // day 생성
        for (var i=0; i<7; i++) {
            
            // 주단위 스케줄 데이터
            var wekSchData = schl[index][i];
            
            // day 스케줄 있을때..
            if (wekSchData != undefined) {
            
                // 스케줄 갯수대로...
                for (var chlIdx=0; chlIdx<wekSchData.length; chlIdx++) {
                    
                    // 일단위 스케줄 데이터
                    var daySchData = wekSchData[chlIdx];
                    
                    // 스케줄 ROW 없을때..
                    if ($('#tbSch'+index).find('.trSch'+daySchData.seq).length == 0) {
                        $('#tbSch'+index).append('<tr class="trSch'+daySchData.seq+'" style="background-color:pink;"><td class="td0"></td><td class="td1"></td><td class="td2"></td><td class="td3"></td><td class="td4"></td><td class="td5"></td><td class="td6"></td></tr>');
                    }
                    
                    // 현재 이벤트 줘야되는 td
                    var eventTd = $('#tbSch'+index).find('.trSch'+daySchData.seq).find('.td'+i);
                    
                    // 이전 값이 있나?
                    if (eventTd.prev().text() != '') {
                        // find('.td'+i)             
                        // 이전 노드의 colspan
                        var prevColspan = eventTd.prev().attr('colspan');
                        
                        // 값이 셋팅 되지 않았을때
                        if (prevColspan == undefined) {
                            prevColspan = 2;
                        } else {
                            prevColspan++;
                        }
                        
                        // 이전 노드의 colspan 추가
                        eventTd.prev().attr('colspan', prevColspan);
                        
                        // 현재 td 삭제
                        eventTd.remove();
                    } else {
                        // 스케줄 생성
                        eventTd.append(daySchData.sj);
                    }
                    
                }
            }
        }
        
    });
}
</script>
</head>
<body>

<form id="frmRestful" name="frmRestful" method="post">
<input type="text" id="menuTySe" name="menuTySe" value="bbs" />
<input type="text" id="menuSeq" name="menuSeq" value="10000000001" />
<a href="javascript:void(0);" onclick="javascript:fnRestful();">test restful</a>
</form>

<div id="divCal" style="width:700px;background-color:yellow;">
</div>


<form:form modelAttribute="paramVO" id="frmInfo">
<form:select path="menuLclCode" size="6" onchange="javascript:fnMenuClcListSelect(this.value);">
<c:forEach var="item" items="${menuLclList}">
    <form:option value="${fn:escapeXml(item.grpcode)}" label="${fn:escapeXml(item.grpcodeNm)}" />
</c:forEach>
</form:select>
<form:select path="menuMclCode" size="6" onchange="javascript:fnMenuMlcListSelect(this.value);">
</form:select>
<form:select path="sitecntntsSeq" onchange="javascript:fnSelectCntntsJson(this.value);">
</form:select>
<a href="javascript:void(0):" onclick="javascript:alert($sampleData.cntntsData);" ><spring:message code="wzwg.module.word.datacnfirm" /></a>
<a href="javascript:void(0):" onclick="javascript:fnSelectCntnts();" ><spring:message code="wzwg.module.word.dataapplc" /></a>
<div id="divSampleList"></div>
</form:form>

<div class="menu">
<table>
<tr class="menuLv1">
    <td class="menuNm"></td>
</tr>
</table>
</div>

<div class="menuMd">
<ul class="testMenu">
</ul>
</div>

<div id="77777" class="cntntsMd" data-cntseq="10000000001">
<ul>
    <li class="infoSj">111111111</li>
    <li class="listSj">2</li>
    <li class="listSj">3</li>
</ul>
</div>

<div id="77777" class="cntntsMd" data-cntseq="10000000002">
<ul>
    <li class="infoSj">111111111</li>
    <li class="listSj">2</li>
    <li class="listSj">3</li>
</ul>
</div>

</body>
</html> 