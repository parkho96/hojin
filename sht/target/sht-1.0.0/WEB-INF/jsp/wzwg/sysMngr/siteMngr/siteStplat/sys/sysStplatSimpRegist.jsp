<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp"%>

<jsp:include page="/WEB-INF/jsp/wzwg/webModule/editorTool.jsp"></jsp:include>

<script type="text/javascript"
	src="/smartEditor2.8.2.1/js/HuskyEZCreator.js"></script>

<script type="text/javascript"
	src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>

<link href="/css/wzwg/cmm/jquery-ui-1.10.3.custom.css" rel="stylesheet"
	type="text/css" />

<script>
	$(document).ready(function() {
		fnDateSet();
	});

	function fnDateSet() {

		$(".datePicker")
				.datepicker(
						{
							dateFormat : 'yymmdd',
							monthNamesShort : [
									'1<spring:message code="wzwg.cmm.word.mt" />',
									'2<spring:message code="wzwg.cmm.word.mt" />',
									'3<spring:message code="wzwg.cmm.word.mt" />',
									'4<spring:message code="wzwg.cmm.word.mt" />',
									'5<spring:message code="wzwg.cmm.word.mt" />',
									'6<spring:message code="wzwg.cmm.word.mt" />',
									'7<spring:message code="wzwg.cmm.word.mt" />',
									'8<spring:message code="wzwg.cmm.word.mt" />',
									'9<spring:message code="wzwg.cmm.word.mt" />',
									'10<spring:message code="wzwg.cmm.word.mt" />',
									'11<spring:message code="wzwg.cmm.word.mt" />',
									'12<spring:message code="wzwg.cmm.word.mt" />' ],
							dayNamesMin : [
									'<spring:message code="wzwg.cmm.word.sun01" />',
									'<spring:message code="wzwg.cmm.word.mon01" />',
									'<spring:message code="wzwg.cmm.word.tue01" />',
									'<spring:message code="wzwg.cmm.word.wed01" />',
									'<spring:message code="wzwg.cmm.word.thu01" />',
									'<spring:message code="wzwg.cmm.word.fri01" />',
									'<spring:message code="wzwg.cmm.word.sat01" />' ],
							weekHeader : 'Wk',
							changeMonth : true, //월변경가능
							changeYear : true, //년변경가능
							yearRange : '-10:+10', // 연도 셀렉트 박스 범위(현재와 같으면 1988~현재년)
							showMonthAfterYear : true, //년 뒤에 월 표시
							buttonImageOnly : false, //이미지표시  
							buttonText : '<spring:message code="wzwg.cmm.msg.MSG088" />',
							autoSize : false
						//오토리사이즈(body등 상위태그의 설정에 따른다) 
						});
	}

	function fnRegistStplatsimp() {

		var frm = document.frmInfoSimp;

		var stplatsimpSeq = frm.stplatsimpSeq.value;

		var actionNm = '';
		var actionUrl = '';

		actionNm = '<spring:message code="wzwg.cmm.word.stre" />';
		actionUrl = '<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/sysSiteStplat/sys/registSysSiteStplatSimp.do';

		oEditors.getById["stplatCn"].exec("UPDATE_CONTENTS_FIELD", []);

		if (!Validator.validate(frm)) {
			return;
		}

		if (frm.opertnDe.value > frm.endDe.value) {
			return alert('<spring:message code="wzwg.cmm.msg.MSG274" />');
		}

		if (confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006">'
				+ '<spring:argument><spring:message code="wzwg.sysMngr.word.siguupStplat" /></spring:argument>'
				+ '<spring:argument>' + actionNm + '</spring:argument>'
				+ '</spring:message>')) {

			$
					.ajax({
						type : 'POST',
						url : actionUrl,
						async : true,
						data : $("#frmInfoSimp").serialize(),
						success : function(data) {
							$(data)
									.find('value')
									.each(
											function() {
												if ($(this).text() == "success") {
													alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
													location.href = '<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/sysSiteStplat/sys/selectSysSiteStplatSimpList.do';

												} else {
													alert('<spring:message code="fail.common.msg" text="error" />');
												}
											})
						},
						dataType : 'html'
					});
		}
	}

	function fnStplatsimpClear() {
		var frm = document.frmInfoSimp;

		frm.stplatSeq.value = '<c:out value="${resultVO.stplatSeq}" />';
		frm.stplatsimpSeq.value = '';
		frm.opertnDe.value = '';
		frm.endDe.value = '';
		frm.stplatSj.value = '';
		frm.stplatCn.value = '';
		oEditors.getById["stplatCn"].exec("SET_IR", [ "" ]);
	}

	function fnList() {
		document.frmInfoSimp.action = '<c:out value="${wzwg_contextPath}${prefix}" />/sysSiteStplat/sys/selectSysSiteStplatSimpList.do';
		document.frmInfoSimp.submit();
	}
</script>

<form:form modelAttribute="resultVO" id="frmInfoSimp" name="frmInfoSimp" method="post">
	<input type="hidden" id="stplatSeq" name="stplatSeq" value="<c:out value='${resultVO.stplatSeq}' />" />
	<c:choose>
		<c:when test="${sessionScope.SYSMNGR_AT eq 'Y'}">
			<input type="hidden" id="siteSeq" name="siteSeq" value="<c:out value="${paramVO.siteSeq}" />" />
		</c:when>
		<c:otherwise>
			<form:hidden path="siteSeq" name="siteSeq" />
		</c:otherwise>
	</c:choose>
	<div id="divInfoSimp">
		<form:hidden path="stplatsimpSeq" name="stplatsimpSeq" />
		<!--기본정보 table// -->
		<table summary="<spring:message code="wzwg.sysMngr.word.stplatInfo" />" class="basic">
			<colgroup>
				<col width="15%">
				<col width="35%">
				<col width="15%">
				<col width="*">
			</colgroup>
			<tbody>
				<tr>
					<th><spring:message code="wzwg.cmm.word.opertnDe" /></th>
					<td><input type="text" id="opertnDe" name="opertnDe"
						dir="required" class="datePicker cal w10" readonly="readonly"
						title="<spring:message code="wzwg.cmm.word.opertnDe" />" value="" />
					</td>
					<th><spring:message code="wzwg.cmm.word.endde" /></th>
					<td><input type="text" id="endDe" name="endDe"
						class="datePicker cal w10" readonly="readonly"
						title="<spring:message code="wzwg.cmm.word.endde" />" value="" />
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.cmm.word.sj" /></th>
					<td colspan="3"><input type="text" class="w70" name="stplatSj"
						id="stplatSj" size="60" maxlength="60" dir="required,vmaxlenb=60"
						title="<spring:message code="wzwg.cmm.word.sj" />"
						placeholder="<spring:message code="wzwg.cmm.word.sj" />" /></td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.cmm.word.cn" /></th>
					<td colspan="3">
						<textarea name="stplatCn" id="stplatCn" rows="30" class="w90" dir="required" title="<spring:message code="wzwg.cmm.word.cn" />" style="width: 100%;">
                        </textarea> 
                      	<script type="text/javascript">
							var oEditors = [];
							nhn.husky.EZCreator
									.createInIFrame({
										oAppRef : oEditors,
										elPlaceHolder : "stplatCn",
										sSkinURI : "<c:out value="${wzwg_contextPath}" />/smartEditor2.8.2.1/smartEditor2Skin.do",
										fCreator : "createSEditor2",
										htParams : {
											fOnBeforeUnload : function() {
											}
										}
									});
					
							WzwgEditorTool.instance("stplatCn");
						</script>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<!--//기본정보 table -->
</form:form>

<div class="rt-box">
	<a href="javascript:void(0);" class="wzbtn btn-black fl"
		onclick="fnStplatsimpClear()"><spring:message
			code="wzwg.cmm.word.initl" /></a> <a href="javascript:void(0);"
		class="wzbtn btn-save" onclick="fnRegistStplatsimp()"><spring:message
			code="wzwg.cmm.word.stre" /></a> <a href="javascript:void(0);"
		class="wzbtn btn-basic" onclick="fnList();"><spring:message
			code="wzwg.cmm.word.list" /></a>
</div>
