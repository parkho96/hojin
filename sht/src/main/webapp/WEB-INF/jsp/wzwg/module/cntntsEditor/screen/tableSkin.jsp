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
							<tr class="thead"><th>제목1</th><th>제목2</th><th>제목3</th><th>제목4</th></tr>
							<tr><th>제목</th><td>내용</td><td>내용</td><td>내용</td></tr>
							<tr><th>제목</th><td>내용</td><td>내용</td><td>내용</td></tr>
							<tr><th>제목</th><td>내용</td><td>내용</td><td>내용</td></tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="skinBtn"><button type="button" class="wzbtn btn-save" onclick="selectSkin('table-basic');">적용</button></div>
		</div>
		
		<div class="skinItem">
			<div class="skinSample">
				<div class="table-underline">
					<table>
						<tbody>
							<tr class="thead"><th>제목1</th><th>제목2</th><th>제목3</th><th>제목4</th></tr>
							<tr><th>제목</th><td>내용</td><td>내용</td><td>내용</td></tr>
							<tr><th>제목</th><td>내용</td><td>내용</td><td>내용</td></tr>
							<tr><th>제목</th><td>내용</td><td>내용</td><td>내용</td></tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="skinBtn"><button type="button" class="wzbtn btn-save" onclick="selectSkin('table-underline');">적용</button></div>
		</div>
		
		<div class="skinItem">
			<div class="skinSample">
				<div class="table-basic2">
					<table>
						<tbody>
							<tr class="thead"><th>제목1</th><th>제목2</th><th>제목3</th><th>제목4</th></tr>
							<tr><th>제목</th><td>내용</td><td>내용</td><td>내용</td></tr>
							<tr><th>제목</th><td>내용</td><td>내용</td><td>내용</td></tr>
							<tr><th>제목</th><td>내용</td><td>내용</td><td>내용</td></tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="skinBtn"><button type="button" class="wzbtn btn-save" onclick="selectSkin('table-basic2');">적용</button></div>
		</div>
		
		<div class="skinItem">
			<div class="skinSample">
				<div class="table-vertical">
					<table>
						<tbody>
							<tr class="thead"><th>제목1</th><th>제목2</th><th>제목3</th><th>제목4</th></tr>
							<tr><th>제목</th><td>내용</td><td>내용</td><td>내용</td></tr>
							<tr><th>제목</th><td>내용</td><td>내용</td><td>내용</td></tr>
							<tr><th>제목</th><td>내용</td><td>내용</td><td>내용</td></tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="skinBtn"><button type="button" class="wzbtn btn-save" onclick="selectSkin('table-vertical');">적용</button></div>
		</div>
		
		<div class="skinItem">
			<div class="skinSample">
				<div class="table-headbg">
					<table>
						<tbody>
							<tr class="thead"><th>제목1</th><th>제목2</th><th>제목3</th><th>제목4</th></tr>
							<tr><th>제목</th><td>내용</td><td>내용</td><td>내용</td></tr>
							<tr><th>제목</th><td>내용</td><td>내용</td><td>내용</td></tr>
							<tr><th>제목</th><td>내용</td><td>내용</td><td>내용</td></tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="skinBtn"><button type="button" class="wzbtn btn-save" onclick="selectSkin('table-headbg');">적용</button></div>
		</div>
		
		<div class="skinItem">
			<div class="skinSample">
				<div class="table-horizontal">
					<table>
						<tbody>
							<tr class="thead"><th>제목1</th><th>제목2</th><th>제목3</th><th>제목4</th></tr>
							<tr><th>제목</th><td>내용</td><td>내용</td><td>내용</td></tr>
							<tr><th>제목</th><td>내용</td><td>내용</td><td>내용</td></tr>
							<tr><th>제목</th><td>내용</td><td>내용</td><td>내용</td></tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="skinBtn"><button type="button" class="wzbtn btn-save" onclick="selectSkin('table-horizontal');">적용</button></div>
		</div>
		
		
		<div class="skinItem">
			<div class="skinSample">
				<div class="table-timeline1">
					<table>
						<tbody>
							<tr class="thead"><th>제목1</th><th>제목2</th><th>제목3</th><th>제목4</th></tr>
							<tr><th>제목</th><td>내용</td><td>내용</td><td>내용</td></tr>
							<tr><th>제목</th><td>내용</td><td>내용</td><td>내용</td></tr>
							<tr><th>제목</th><td>내용</td><td>내용</td><td>내용</td></tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="skinBtn"><button type="button" class="wzbtn btn-save" onclick="selectSkin('table-timeline1');">적용</button></div>
		</div>
		
		
		<div class="skinItem">
			<div class="skinSample">
				<div class="table-timeline2">
					<table>
						<tbody>
							<tr class="thead"><th>제목1</th><th>제목2</th><th>제목3</th><th>제목4</th></tr>
							<tr><th>제목</th><td>내용</td><td>내용</td><td>내용</td></tr>
							<tr><th>제목</th><td>내용</td><td>내용</td><td>내용</td></tr>
							<tr><th>제목</th><td>내용</td><td>내용</td><td>내용</td></tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="skinBtn"><button type="button" class="wzbtn btn-save" onclick="selectSkin('table-timeline2');">적용</button></div>
		</div>
	</div>