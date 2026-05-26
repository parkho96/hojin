<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script>
$(document).ready(function() {
    fnDateSet();
});
</script>

                <input type="hidden" id="stplatsimpSeq" name="stplatsimpSeq" value="<c:out value="${infoSimpVO.stplatsimpSeq}" />" />
                <!--기본정보 table// -->
                <table summary="<spring:message code="wzwg.sysMngr.word.stplatInfo" />" class="basic">
                    <colgroup>
                        <col width="15%">
                        <col width="*">
                    </colgroup>
                    <tbody>
                        <tr>
                            <th><spring:message code="wzwg.cmm.word.opertnDe" /></th>
                            <td>
                                <input type="text" id="opertnDe" name="opertnDe" dir="required" class="datePicker cal w10" readonly="readonly" title="<spring:message code="wzwg.cmm.word.opertnDe" />" value="<c:out value="${infoSimpVO.opertnDe}" />" /> 
                            </td>
                        </tr>
                        <tr>
                            <th><spring:message code="wzwg.cmm.word.sj" /></th>
                            <td>
                                <input type="text" class="w70" name="stplatSj" id="stplatSj" dir="required" title="<spring:message code="wzwg.cmm.word.sj" />" value="<c:out value="${infoSimpVO.stplatSj}" />" placeholder="<spring:message code="wzwg.cmm.word.sj" />" />
                            </td>
                        </tr>
                        <tr>
                            <th><spring:message code="wzwg.cmm.word.cn" /></th>
                            <td>
                                <textarea name=stplatCn id="stplatCn" rows="30" class="w90" dir="required" title="<spring:message code="wzwg.cmm.word.cn" />" style="width:100%;">
                                <c:out value="${infoSimpVO.stplatCn}" />
                                </textarea>
                                
                                <script type="text/javascript">
                                    var oEditors = [];
                                    nhn.husky.EZCreator.createInIFrame({
                                        oAppRef: oEditors,
                                        elPlaceHolder: "stplatCn",
                                        sSkinURI: "<c:out value="${wzwg_contextPath}" />/smartEditor2.8.2.1/smartEditor2Skin.do",
                                        fCreator: "createSEditor2",
                                        htParams: {fOnBeforeUnload : function(){},aAdditionalFontList : [['NanumSquareR', 'NanumSquareR']]}
                                    });
                                    
                                    WzwgEditorTool.instance("stplatCn");
                                </script>
                            </td>
                        </tr>
                    </tbody>
                </table>