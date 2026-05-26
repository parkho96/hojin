<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

                        <table class="basic-table">
                            <colgroup>
                                <col width="5%" />
                                <col width="15%" />
                                <col width="*" />
                                <col width="15%" />
                            </colgroup>
                            <thead>
                              <tr>
                               <th><ul class="wzForm"><li><label><input type="checkbox" id="layCheckAll" name="layCheckAll" class="layCheckall" onclick="fnLayCheckAll();" /><span class="spanLabel"></span></label></li></ul></th>
                                <th><spring:message code="wzwg.cmm.word.link" /></th>
                                <th><spring:message code="wzwg.cmm.word.url" /></th>
                                <th><spring:message code="wzwg.cmm.word.rgsde" /></th>
                              </tr>
                            </thead>
                            <tbody>
                            <c:if test="${empty resultList}">
                            <tr>
                                <td colspan="4">
                                    <spring:message code="wzwg.cmm.cmmMsg.CMG014">
                                        <spring:argument><spring:message code="wzwg.cmm.word.dtartv" /></spring:argument>
                                    </spring:message>
                                </td>
                            </tr>
                            </c:if>
                            <c:forEach items="${resultList}" var="result" varStatus="status">
                            <tr>
                            	<td><ul class="wzForm"><li><label><input type="checkbox" id="linkSeqArr" name="linkSeqArr" value="<c:out value="${result.linkSeq}"/>" /><span class="spanLabel"></span></label></li></ul></td>
                                <td style="cursor:pointer;" onclick="fnMngrForm('<c:out value="${result.linkSeq}"/>'); return false;"><c:out value="${result.linkNm}" /></td>
                                <td style="cursor:pointer;" onclick="fnMngrForm('<c:out value="${result.linkSeq}"/>'); return false;"><c:out value="${result.linkUrl}" /></td>
                                <td style="cursor:pointer;" onclick="fnMngrForm('<c:out value="${result.linkSeq}"/>'); return false;"><c:out value="${result.frstRegistPnttm}" /></td>
                            </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        
                        <!--//기본정보 table -->
                       <c:if test="${!empty resultList}">
                       <div class="ctr-box">
                           <ul class="num mt0">
                                 <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnMngrSearch" />
                            </ul>
                       </div>
                       </c:if>
                   
                       <div class="lt-box wd100 fl pb10 mb20 brsolid br-btm1 br-top0 br-rgt0 br-lft0 br-lightgrey">
                            <span class="wd100 fw600 mb10 linehgt150 block fs16"><spring:message code="wzwg.cmm.msg.tip.MSG068" /></span>
                            <div class="wzfile_inputbox wd50 fl wm100 mb10">
                                <input type="text" id="file_text_1" class="file_route fl wd60 fs14" readonly="readonly" style="text-overflow:ellipsis;">
                                <span class="wzbtn btn-basic fl wd40" style="padding-left:5px; padding-right:5px; font-size:15px;"><spring:message code="wzwg.cmm.word.wa.fileSelect" /></span>
                                <input type="file" id="uplaodLinkFile" name="uplaodLinkFile" class="attatchfile" onchange="document.getElementById('file_text_1').value=this.value;">
                            </div>
                            <button type="button" class="wzbtn btn-black wd24 wm50 fs15" onclick="fnLinkRegistExcelUpload()" style="padding-left:5px; padding-right:5px;"><i class="fa fa-upload"></i><spring:message code="wzwg.cmm.word.wa.uploadFile" /></button>
                            <a class="wzbtn btn-green ico-excel fr fs15 wd25 wm50" href="/excelTemplit/siteLinkGrpSample.xlsx" target="_blank" style="height:40px;padding-left: 5px;padding-right: 5px;"><spring:message code="wzwg.cmm.word.wa.downloadForm" /></a>  
                       </div>
                   
                       <div class="rt-box">
                            <a href="javascript:void(0);" onclick="fnMngrAdd();" class="wzbtn btn-black fl"><spring:message code="wzwg.cmm.word.selectedLinkAdd" /></a>
                            <a href="javascript:void(0);" onclick="fnMngrForm('');" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.newpLink" /></a>
                       </div>