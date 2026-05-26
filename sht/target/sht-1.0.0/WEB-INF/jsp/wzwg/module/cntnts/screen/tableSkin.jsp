<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 

 
 <script>
   function selectSkin(skinCls){
	   selectDiv.attr('class', skinCls + ' tableZone');
	   alert('<spring:message code="wzwg.cmm.msg.MSG080"/>');
	   wzModalClose();
   }
</script>
								

	<div class="skinZone">
		<div class="skinItem">
			<div class="skinSample">
				<div class="table-basic">
					<table>
						<tbody>
							<tr class="thead"><th><spring:message code="wzwg.cmm.word.sj" />1</th><th><spring:message code="wzwg.cmm.word.sj" />2</th><th><spring:message code="wzwg.cmm.word.sj" />3</th><th><spring:message code="wzwg.cmm.word.sj" />4</th></tr>
							<tr><th><spring:message code="wzwg.cmm.word.sj" /></th><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td></tr>
							<tr><th><spring:message code="wzwg.cmm.word.sj" /></th><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td></tr>
							<tr><th><spring:message code="wzwg.cmm.word.sj" /></th><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td></tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="skinBtn"><button type="button" class="wzbtn btn-save" onclick="selectSkin('table-basic');"><spring:message code="wzwg.cmm.word.applc" /></button></div>
		</div>
		
		<div class="skinItem">
			<div class="skinSample">
				<div class="table-underline">
					<table>
						<tbody>
							<tr class="thead"><th><spring:message code="wzwg.cmm.word.sj" />1</th><th><spring:message code="wzwg.cmm.word.sj" />2</th><th><spring:message code="wzwg.cmm.word.sj" />3</th><th><spring:message code="wzwg.cmm.word.sj" />4</th></tr>
							<tr><th><spring:message code="wzwg.cmm.word.sj" /></th><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td></tr>
							<tr><th><spring:message code="wzwg.cmm.word.sj" /></th><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td></tr>
							<tr><th><spring:message code="wzwg.cmm.word.sj" /></th><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td></tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="skinBtn"><button type="button" class="wzbtn btn-save" onclick="selectSkin('table-underline');"><spring:message code="wzwg.cmm.word.applc" /></button></div>
		</div>
		
		<div class="skinItem">
			<div class="skinSample">
				<div class="table-basic2">
					<table>
						<tbody>
							<tr class="thead"><th><spring:message code="wzwg.cmm.word.sj" />1</th><th><spring:message code="wzwg.cmm.word.sj" />2</th><th><spring:message code="wzwg.cmm.word.sj" />3</th><th><spring:message code="wzwg.cmm.word.sj" />4</th></tr>
							<tr><th><spring:message code="wzwg.cmm.word.sj" /></th><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td></tr>
							<tr><th><spring:message code="wzwg.cmm.word.sj" /></th><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td></tr>
							<tr><th><spring:message code="wzwg.cmm.word.sj" /></th><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td></tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="skinBtn"><button type="button" class="wzbtn btn-save" onclick="selectSkin('table-basic2');"><spring:message code="wzwg.cmm.word.applc" /></button></div>
		</div>
		
		<div class="skinItem">
			<div class="skinSample">
				<div class="table-vertical">
					<table>
						<tbody>
							<tr class="thead"><th><spring:message code="wzwg.cmm.word.sj" />1</th><th><spring:message code="wzwg.cmm.word.sj" />2</th><th><spring:message code="wzwg.cmm.word.sj" />3</th><th><spring:message code="wzwg.cmm.word.sj" />4</th></tr>
							<tr><th><spring:message code="wzwg.cmm.word.sj" /></th><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td></tr>
							<tr><th><spring:message code="wzwg.cmm.word.sj" /></th><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td></tr>
							<tr><th><spring:message code="wzwg.cmm.word.sj" /></th><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td></tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="skinBtn"><button type="button" class="wzbtn btn-save" onclick="selectSkin('table-vertical');"><spring:message code="wzwg.cmm.word.applc" /></button></div>
		</div>
		
		<div class="skinItem">
			<div class="skinSample">
				<div class="table-headbg">
					<table>
						<tbody>
							<tr class="thead"><th><spring:message code="wzwg.cmm.word.sj" />1</th><th><spring:message code="wzwg.cmm.word.sj" />2</th><th><spring:message code="wzwg.cmm.word.sj" />3</th><th><spring:message code="wzwg.cmm.word.sj" />4</th></tr>
							<tr><th><spring:message code="wzwg.cmm.word.sj" /></th><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td></tr>
							<tr><th><spring:message code="wzwg.cmm.word.sj" /></th><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td></tr>
							<tr><th><spring:message code="wzwg.cmm.word.sj" /></th><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td></tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="skinBtn"><button type="button" class="wzbtn btn-save" onclick="selectSkin('table-headbg');"><spring:message code="wzwg.cmm.word.applc" /></button></div>
		</div>
		
		<div class="skinItem">
			<div class="skinSample">
				<div class="table-horizontal">
					<table>
						<tbody>
							<tr class="thead"><th><spring:message code="wzwg.cmm.word.sj" />1</th><th><spring:message code="wzwg.cmm.word.sj" />2</th><th><spring:message code="wzwg.cmm.word.sj" />3</th><th><spring:message code="wzwg.cmm.word.sj" />4</th></tr>
							<tr><th><spring:message code="wzwg.cmm.word.sj" /></th><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td></tr>
							<tr><th><spring:message code="wzwg.cmm.word.sj" /></th><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td></tr>
							<tr><th><spring:message code="wzwg.cmm.word.sj" /></th><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td></tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="skinBtn"><button type="button" class="wzbtn btn-save" onclick="selectSkin('table-horizontal');"><spring:message code="wzwg.cmm.word.applc" /></button></div>
		</div>
		
		
		<div class="skinItem">
			<div class="skinSample">
				<div class="table-timeline1">
					<table>
						<tbody>
							<tr class="thead"><th><spring:message code="wzwg.cmm.word.sj" />1</th><th><spring:message code="wzwg.cmm.word.sj" />2</th><th><spring:message code="wzwg.cmm.word.sj" />3</th><th><spring:message code="wzwg.cmm.word.sj" />4</th></tr>
							<tr><th><spring:message code="wzwg.cmm.word.sj" /></th><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td></tr>
							<tr><th><spring:message code="wzwg.cmm.word.sj" /></th><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td></tr>
							<tr><th><spring:message code="wzwg.cmm.word.sj" /></th><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td></tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="skinBtn"><button type="button" class="wzbtn btn-save" onclick="selectSkin('table-timeline1');"><spring:message code="wzwg.cmm.word.applc" /></button></div>
		</div>
		
		
		<div class="skinItem">
			<div class="skinSample">
				<div class="table-timeline2">
					<table>
						<tbody>
							<tr class="thead"><th><spring:message code="wzwg.cmm.word.sj" />1</th><th><spring:message code="wzwg.cmm.word.sj" />2</th><th><spring:message code="wzwg.cmm.word.sj" />3</th><th><spring:message code="wzwg.cmm.word.sj" />4</th></tr>
							<tr><th><spring:message code="wzwg.cmm.word.sj" /></th><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td></tr>
							<tr><th><spring:message code="wzwg.cmm.word.sj" /></th><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td></tr>
							<tr><th><spring:message code="wzwg.cmm.word.sj" /></th><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td><td><spring:message code="wzwg.cmm.word.cn" /></td></tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="skinBtn"><button type="button" class="wzbtn btn-save" onclick="selectSkin('table-timeline2');"><spring:message code="wzwg.cmm.word.applc" /></button></div>
		</div>
	</div>