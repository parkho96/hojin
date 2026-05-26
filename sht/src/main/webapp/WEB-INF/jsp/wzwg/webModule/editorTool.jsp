<%@page import="java.io.IOException"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="egovframework.wzwg.cmm.util.FileComparator"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Properties"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Random"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="java.io.File"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions" %>

	<%
	/*
	 * 이 모듈은 지정된 폴더의 하위 1차 폴더 까지만 검색하게끔 설계되어 있으므로 사용시 폴더 경로 유의 바람
	 * ex) /images/wzwg/webModule/bullet 지정시
	 * /images/wzwg/webModule/bullet/dir1 , /images/wzwg/webModule/bullet/dir2 등의 폴더의 내용을 검색함
	 * @since 2017.09.18 조원권
	 *
	 * 모듈 구성
	 * 본 파일과 editorTool.css 구성으로 되어 있다
	 *
	 * 준비작업
	 *    [프로젝트 웹루트]/images/.. 등 불렛 파일들이 들어간 경로 세팅
	 *    ex)/smartEditorCustom/images/bullet 지정시 bullet/ 이하 하위 폴더를 읽어서 불렛 템플릿으로 로드 합니다
	 *    ex)/smartEditorCustom/images/bullet/cu 폴더에 불렛파일들과 name.properties 파일에 내용으로 name=로고로 불렛그룹의 이름을 세팅합니다
	 *
	 * 사용법
	 * 1. 본 파일을 에디터가 있는 jsp 파일에 include 시킨다  -> <jsp:include page="/WEB-INF/jsp/wzwg/webModule/editorTool.jsp"></jsp:include>
	 * 2. editorTool.css 파일을 인클루드 한다  -> <link rel="stylesheet" href="/css/wzwg/webModule/editorTool.css" type="text/css" />
	 * 3. 스마트에디터에 CSS 파일을 인클루드 한다   -> 스마트에디터 폴더에 smart_editor2_inputarea.html 파일에 CSS 파일 인클루드 시키기(에디터상 CSS 적용)
	 * 4. javascript 에서 네이버 스마트 에디터를 로드한후 본파일의 스크립트를 초기화 한다
	 *   WzwgEditorTool.instance("tmplatCn");
	 * 5. 사용자 화면에도 CSS 파일을 인클루드 한다
	 *
	 * 위즈빌더 적용방법
	 * 반응형으로 보이기 위해서 textarea 태그에 style="width:100%;" 속성을 주어야 합니다
	 */
	String sourcePath = "/smartEditorCustom/images/bullet";
	String webRoot = "";
	//File f = new File(this.getClass().getResource("/").getFile());
	
	//webRoot = f.getParentFile().getParentFile().getAbsolutePath();
	//f = null;
	
	webRoot = request.getServletContext().getRealPath("/");
	
	//System.out.println(webRoot);
	File dir = new File(webRoot + sourcePath);
	
	/* 불렛 이미지에서 디자인폰트로 변경함 2022.03.31 CWK
	Map<String, List<String>> fileListMap = new LinkedHashMap<String, List<String>>();
	
	if(dir.exists()){
		if(dir.isDirectory()){
			// 메인 디렉토리 진입
			File []dirArr = dir.listFiles();
			Arrays.sort(dirArr, new  FileComparator()); // 파일명으로 목록 재정렬
			
			//List dirList = Arrays.asList(dir.listFiles()) ;
			List dirList = Arrays.asList(dirArr) ;
			// 1차 디렉토리 진입
			for(int ii = 0 ; ii < dirList.size() ; ii++){
				File srcDir = (File)dirList.get(ii);
				if(srcDir.exists() == false){
					break;
				}
				
				if(srcDir.isFile()){
					break;
				}
				
				File []fileArr = srcDir.listFiles(); // 폴더에서 파일목록 가져옴
				
				Arrays.sort(fileArr, new  FileComparator()); // 파일명으로 목록 재정렬
				
				List fileList = Arrays.asList(fileArr) ;
				  
				
				String name = "";
				List<String> fileNameList = new ArrayList<String>();//최종 파일목록
				for(int i = 0 ; i < fileList.size() ; i ++){
					File dataFile = (File)fileList.get(i);
					//System.out.println(dataFile.getName());
					String fileExtension = FilenameUtils.getExtension(dataFile.getName());
					//System.out.println("fileExtension : " + fileExtension);
					if(fileExtension.equalsIgnoreCase("properties") ){
						Properties prop = new Properties();
						prop.load(new FileInputStream(dataFile));
						name = String.valueOf(prop.get("name")); 
						//System.out.println("name : " + name);
					};
					
					if(fileExtension.equalsIgnoreCase("png") 
							|| fileExtension.equalsIgnoreCase("jpg") 
							|| fileExtension.equalsIgnoreCase("jgep")
							|| fileExtension.equalsIgnoreCase("gif") ){
						
						
						String fullPath = dataFile.getAbsolutePath();
						String systemSrcPath = FilenameUtils.separatorsToSystem(sourcePath);
						//System.out.println(fullPath);
						//System.out.println(systemSrcPath);
						int idx = fullPath.indexOf(systemSrcPath);
						//System.out.println(idx);
						//String fileNamePath = fullPath.substring(idx);
						//System.out.println(  fullPath.substring(idx)  ); 
						//System.out.println(  fullPath.substring(idx).replace(systemSrcPath, "")  ); 
						//System.out.println(dataFile.getAbsolutePath());
						
						 
						fileNameList.add(FilenameUtils.separatorsToUnix(fullPath.substring(idx).replace(systemSrcPath, "")));
						dataFile = null;
					}
				}// end for
				//System.out.println(fileNameList);
				fileListMap.put(name, fileNameList);
						
			}//end for 1차 디렉토리 작업
			
			
			
			
		}//end if dir.isDirectory() 메인 디렉토리 작업
		
	}// end bullet 이미지 파일작업 완료
	
	dir = null;
	
	ObjectMapper mapper = new ObjectMapper();  
	String bulletResult = mapper.writeValueAsString(fileListMap);
	*/
	
	//System.out.println(result);
	// 불렛 이미지에서 디자인폰트로 변경함 2022.03.31 CWK// request.setAttribute("imgItems", bulletResult);
	// 불렛 이미지에서 디자인폰트로 변경함 2022.03.31 CWK// request.setAttribute("sourcePath", sourcePath);
	Random jur  = SecureRandom.getInstance("SHA1PRNG");
	request.setAttribute("idr", jur.nextInt(Integer.MAX_VALUE));
	
	
 
	
	//템플릿 파일 소스 로딩하기
	/* 
	 * 템플릿은 사용하지 않기록 결정함 2018.09.03 조원권
	 */
	String templatePath = "/smartEditorCustom/template";
	dir = new File(webRoot + templatePath);
	
	List<String> templateList = new ArrayList<String>();
	Collections.sort(templateList);
	
	if(dir.exists()){
		List<File> htmlList = Arrays.asList(dir.listFiles());
		Collections.sort(htmlList);	
		
		for(int i = 0 ; i < htmlList.size(); i++){
			File html = htmlList.get(i);
			//System.out.println(html.getName());
			try{
				BufferedReader br = new BufferedReader(new FileReader(html));
				StringBuffer sb = new StringBuffer();
				//System.out.println(br.readLine());
				String s ="";
				try{
					// TOCTOU 방지를 위한 synchronized 블록
					synchronized(this) {
						while((s = br.readLine()) != null){
							sb.append(s);
						}
					}
					
				}catch(IOException ioe){
					out.println("IOException : template file not read!!");;
				}
				
				//System.out.println(sb.toString());
				templateList.add(sb.toString());
				sb.delete(0, sb.length());
				br.close();
				
			}catch(java.io.FileNotFoundException e){
				out.println("FileNotFoundException : File disappear (Race Condition)");
			}catch(NullPointerException e){
				out.println("NullPointerException: " + "오류");
		   	}catch(NumberFormatException e){
		   		out.println("NumberFormatException: " + "오류");
		   	}catch(ArrayIndexOutOfBoundsException e){
		   		out.println("ArrayIndexOutOfBoundsException: " + "오류");
		   	}catch(IOException e){
		   		out.println("IOException: " + "오류");
		   	}
			
		}
	}
	
	request.setAttribute("templateList", templateList);
	/**/
	%>
<!-- 	<link rel="stylesheet" href="/smartEditorCustom/css/editorTool.css" type="text/css" />
	<link rel="stylesheet" href="/smartEditorCustom/css/subcon_common.css" type="text/css" />
	<link rel="stylesheet" href="/smartEditorCustom/css/subcon_tamplate.css" type="text/css" /> -->

	<script>
		/*
		function addEditorTool(_id){
			console.log('호출됨');
			$('#' + _id).before("<div><button type='button'><img src='/images/wzwg/module/ntt/a.png' onclick='addEditorImageToImg(this)'/></button></div>");
		}
		
		function addEditorImageToImg(_img){
			var imgTag = '<img src="' + $(_img).attr('src') + '"/>';
			oEditors.getById["tmplatCn"].exec("PASTE_HTML", [imgTag]);
		}
		*/
		function WgFnSlideToggle(_id){
				$('#' + _id).slideToggle();
		}
		
		var WzwgEditorTool = {
			editorTool : '',
			editorId : '',
			// 불렛 이미지에서 디자인폰트로 변경함 2022.03.31// CWK imgItems : '$ {imgItems}',
			// 불렛 이미지에서 디자인폰트로 변경함 2022.03.31// CWK sourcePath : '$ {sourcePath}',
			instance : function( _id){
				//console.log($('#' + _id));
				this.editorId = _id;
				editorTool = this;
				this.attachToolbar(this.editorId);
				return editorTool;
			},
			attachToolbar : function(editorId){
				var toolbar = this.makeToolbar();

				//var imgs = $(toolbar).find('img');
				//console.log(imgs);
				
				// 이미지 추가 스크립트
				/* 불렛 이미지에서 디자인폰트로 변경함 2022.03.31 CWK
				$(toolbar).find('img').bind('click', function(){
					//this.addEditorImageToImg(this);
					console.log(editorId);
					//editorTool.consoleLog('click');
					if($(this).attr('data-name') == 'bullet'){
						editorTool.addEditorImageToImg(editorId, this);
					}
				});
				*/
				
				// 불렛 폰트 이미지 추가 스크립트
				$(toolbar).find('.subBullet').bind('click', function(){
					//console.log($(this));
					var bullet = $(this).clone();
					//bullet.removeClass('subBullet');
					//console.log(bullet);
					//console.log('add tag : ' + bullet[0].outerHTML);
					var tag = bullet[0].outerHTML;
					editorTool.addEditorTagLayer(editorId, tag);
				});
				
				// 레이어 추가 스크립트
				$(toolbar).find('.btnLayer').on('click',function(){
					//var data = $(this).attr('data-layer');
					//editorTool.addEditorTagLayer(data);
					var dataid = $(this).attr('data-id');
					var tag = $('#' + dataid).html();
					editorTool.addEditorTagLayer(editorId, tag);
					/* class="btnLayer" data-layer="2" */
				});
				
				
				// 버튼 추가 스크립트
				/* $(toolbar).find('#' + editorTool.editorId + '_button  button').on('click',function(){
					editorTool.addEditorButton(this);
				}); */
				$(toolbar).find('.btn-addWzwgBtn').on('click',function(){
					editorTool.WgFnAddWzwgButton(editorId);
				}); 
				
				$('#' + editorId).before(toolbar);
			},
			makeToolbar : function(){
				//console.log('나와야지');
				var toolbar = '';
				// 메인 버튼 그룹 설정
				toolbar += '<div class="btnbox-l editor_BtnBox">';
				toolbar += '	<button type="button" class="wzbtn-lg btn-black ico-bull" onclick="WgFnSlideToggle(\'' + this.editorId + '_bullet\')"><spring:message code="wzwg.cmm.word.bullet" text="bullet" /></button>';
				//toolbar += '	<button type="button" class="edt-btn-simple-gray" onclick="WgFnSlideToggle(\'' + this.editorId + '_button\')"><spring:message code="wzwg.cmm.word.button" text="button" /></button>';
				toolbar += '	<button type="button" class="wzbtn-lg btn-black ico-layer" onclick="WgFnSlideToggle(\'' + this.editorId + '_layer\')"><spring:message code="wzwg.cmm.word.layer" text="layer" /></button>';
				toolbar += '	<button type="button" class="wzbtn-lg btn-black ico-design" onclick="WgFnSlideToggle(\'' + this.editorId + '_template\')"><spring:message code="wzwg.cmm.word.component" text="component" /></button>';
				toolbar += '	<button type="button" class="wzbtn-lg btn-black btn-addWzwgBtn" ><spring:message code="wzwg.cmm.word.button" text="button" /></button>';
				toolbar += '	<p class="admpg-subp w100 fl mt15"><span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.tip.MSG070" text="button" /></p>';
				toolbar += '</div>';
				
				//toolbar += '<div class="edt-addbtn-group">';
				//toolbar += '	<button type="button" class="edt-btn-simple-gray" onclick="WgFnSlideToggle(\'' + this.editorId + '_bullet\')"><spring:message code="wzwg.cmm.word.bullet" text="bullet" /></button>';
				//toolbar += '	<button type="button" class="edt-btn-simple-gray" onclick="WgFnSlideToggle(\'' + this.editorId + '_button\')"><spring:message code="wzwg.cmm.word.button" text="button" /></button>';
				//toolbar += '	<button type="button" class="edt-btn-simple-gray" onclick="WgFnSlideToggle(\'' + this.editorId + '_layer\')"><spring:message code="wzwg.cmm.word.layer" text="layer" /></button>';
				//toolbar += '	<button type="button" class="edt-btn-simple-gray" onclick="WgFnSlideToggle(\'' + this.editorId + '_template\')"><spring:message code="wzwg.cmm.word.template" text="template" /></button>';
				//toolbar += '</div>';
				// 메인 버튼 그룹 설정 끝
				
				// 불렛 이미지에서 디자인폰트로 변경함 2022.03.31 CWK
				// 불렛 이미지 소스 로딩
				//var imgObj = JSON.parse(this.imgItems);
				//$(imgObj).each(function(index, data){
				//toolbar += '	<div class="edt-template-box tmplatCn_bullet" id="' + editorTool.editorId + '_bullet" style="display:none;">';
				//	for ( var key in data){
				//		toolbar += '	<div>';
				//		var keyName = '';
				//		var imgList = '';
				//		// object의 키와 데이터 분리
				//		//console.log(key);
				//		keyName = key;
				//		imgList = data[key];
				//		
				//		toolbar += '<span class="name">' + keyName + '</span>';
				//		$(imgList).each(function(index, img){
				//			//console.log(img);
				//			toolbar += '	<img src="' + editorTool.sourcePath + img + '" data-name="bullet">';
				//		});
				//		
				//		toolbar += '	</div>';
				//	}
				//toolbar += '	</div>';
				//});
				// 불렛 이미지 소스 로딩 끝
				
				// 불렛 폰트이미지 로딩
				toolbar += '<div class="edt-template-box tmplatCn_bullet" id="' + editorTool.editorId + '_bullet" style="display:none;">                    ';
				toolbar += '      <p class="admpg-subp w100 fl mb15"><span class="circle_no bg-grey-strong ml0">i</span><spring:message code="wzwg.cmm.msg.MSG437" /></p>';
				toolbar += '                                                                                                                                ';
				toolbar += '	  <div><span class="name"><spring:message code="wzwg.cmm.word.spcsyb" /></span>                                             ';
				toolbar += '	    <span class="subBullet fa fa-asterisk" aria-hidden="true"></span>                                                       ';
				toolbar += '	    <span class="subBullet fa fa-certificate" aria-hidden="true"></span>                                                    ';
				toolbar += '	    <span class="subBullet fa fa-heart" aria-hidden="true"></span>                                                          ';
				toolbar += '	    <span class="subBullet fa fa-star" aria-hidden="true"></span>                                                           ';
				toolbar += '	    <span class="subBullet fa fa-leaf" aria-hidden="true"></span>                                                           ';
				toolbar += '	    <span class="subBullet fa fa-bookmark" aria-hidden="true"></span>                                                       ';
				toolbar += '	    <span class="subBullet fa fa-cube" aria-hidden="true"></span>                                                           ';
				toolbar += '	    <span class="subBullet fa fa-thumb-tack" aria-hidden="true"></span>                                                     ';
				toolbar += '	    <span class="subBullet fa fa-pencil" aria-hidden="true"></span>                                                         ';
				toolbar += '	    <span class="subBullet fa fa-clock-o" aria-hidden="true"></span>                                                        ';
				toolbar += '	    <span class="subBullet fa fa-phone" aria-hidden="true"></span>                                                         	';
				toolbar += '	    <span class="subBullet fa fa-map-marker" aria-hidden="true"></span>                                                     ';
				toolbar += '	    <span class="subBullet fa fa-envelope" aria-hidden="true"></span>                                                       ';
				toolbar += '	    <span class="subBullet fa fa-hashtag" aria-hidden="true"></span>                                                        ';
				toolbar += '	                                                                                                                            ';
				toolbar += '	    <span class="subBullet fa fa-quote-left" aria-hidden="true"></span>                                                     ';
				toolbar += '	    <span class="subBullet fa fa-quote-right" aria-hidden="true"></span>                                                    ';
				toolbar += '	  </div>                                                                                                                    ';
				toolbar += '	                                                                                                                            ';
				toolbar += '	  <div><span class="name"><spring:message code="wzwg.cmm.word.wa.arrow" /></span>                                           ';
				toolbar += '	    <span class="subBullet fa fa-arrow-right" aria-hidden="true"></span>                                                    ';
				toolbar += '	    <span class="subBullet fa fa-arrow-left" aria-hidden="true"></span>                                                     ';
				toolbar += '	    <span class="subBullet fa fa-arrow-up" aria-hidden="true"></span>                                                       ';
				toolbar += '	    <span class="subBullet fa fa-arrow-down" aria-hidden="true"></span>                                                     ';
				toolbar += '	                                                                                                                            ';
				toolbar += '	    <span class="subBullet fa fa-arrow-circle-right" aria-hidden="true"></span>                                             ';
				toolbar += '	    <span class="subBullet fa fa-arrow-circle-left" aria-hidden="true"></span>                                              ';
				toolbar += '	    <span class="subBullet fa fa-arrow-circle-up" aria-hidden="true"></span>                                                ';
				toolbar += '	    <span class="subBullet fa fa-arrow-circle-down" aria-hidden="true"></span>                                              ';
				toolbar += '	                                                                                                                            ';
				toolbar += '	    <span class="subBullet fa fa-arrow-circle-o-right" aria-hidden="true"></span>                                           ';
				toolbar += '	    <span class="subBullet fa fa-arrow-circle-o-left" aria-hidden="true"></span>                                            ';
				toolbar += '	    <span class="subBullet fa fa-arrow-circle-o-up" aria-hidden="true"></span>                                              ';
				toolbar += '	    <span class="subBullet fa fa-arrow-circle-o-down" aria-hidden="true"></span>                                            ';
				toolbar += '	                                                                                                                            ';
				toolbar += '	    <span class="subBullet fa fa-chevron-circle-right" aria-hidden="true"></span>                                           ';
				toolbar += '	    <span class="subBullet fa fa-chevron-circle-left" aria-hidden="true"></span>                                            ';
				toolbar += '	    <span class="subBullet fa fa-chevron-circle-up" aria-hidden="true"></span>                                              ';
				toolbar += '	    <span class="subBullet fa fa-chevron-circle-down" aria-hidden="true"></span>                                            ';
				toolbar += '	    <br>                                                                                                                    ';
				toolbar += '	    <span class="subBullet fa fa-caret-right" aria-hidden="true"></span>                                                    ';
				toolbar += '	    <span class="subBullet fa fa-caret-square-o-right" aria-hidden="true"></span>                                           ';
				toolbar += '	    <span class="subBullet fa fa-play-circle-o" aria-hidden="true"></span>                                                  ';
				toolbar += '	    <span class="subBullet fa fa-angle-right" aria-hidden="true"></span>                                                    ';
				toolbar += '	    <span class="subBullet fa fa-angle-double-right" aria-hidden="true"></span>                                             ';
				toolbar += '	    <span class="subBullet fa fa-chevron-right" aria-hidden="true"></span>                                             		';
				toolbar += '	    <span class="subBullet fa fa-forward" aria-hidden="true"></span>                                                        ';
				toolbar += '	    <span class="subBullet fa fa-forward smallone" aria-hidden="true"></span>                                               ';
				toolbar += '	    <span class="subBullet fa fa-hand-o-right" aria-hidden="true"></span>                                                   ';
				toolbar += '	  </div>                                                                                                                    ';
				toolbar += '	                                                                                                                            ';
				toolbar += '	  <div><span class="name"><spring:message code="wzwg.cmm.word.circle" /></span>                                             ';
				toolbar += '	    <span class="subBullet fa fa-bandcamp" aria-hidden="true"></span>                                                       ';
				toolbar += '	    <span class="subBullet fa fa-stop-circle bullRotate1" aria-hidden="true"></span>                 						';
				toolbar += '	    <span class="subBullet fa fa-stop-circle-o bullRotate1" aria-hidden="true"></span>               						';
				toolbar += '	    <span class="subBullet fa fa-adjust" aria-hidden="true"></span>                                                         ';
				toolbar += '	    <span class="subBullet fa fa-bullseye" aria-hidden="true"></span>                                                       ';
				toolbar += '	    <span class="subBullet fa fa-dot-circle-o" aria-hidden="true"></span>                                                   ';
				toolbar += '	    <span class="subBullet fa fa-circle" aria-hidden="true"></span>                                                         ';
				toolbar += '	    <span class="subBullet fa fa-circle smallone" aria-hidden="true"></span>                                                ';
				toolbar += '	    <span class="subBullet fa fa-circle-o" aria-hidden="true"></span>                                                       ';
				toolbar += '	    <span class="subBullet fa fa-circle-thin" aria-hidden="true"></span>                                                    ';
				toolbar += '	    <span class="subBullet fa fa-genderless" aria-hidden="true"></span>                                                     ';
				toolbar += '	    <span class="subBullet fa fa-circle-o-notch bullRotate1" aria-hidden="true"></span>               						';
				toolbar += '	    <span class="subBullet fa fa-circle-o-notch bullRotate2" aria-hidden="true"></span>              						';
				toolbar += '	  </div>                                                                                                                    ';
				toolbar += '	                                                                                                                            ';
				toolbar += '	  <div><span class="name"><spring:message code="wzwg.cmm.word.quadral" /></span>                                            ';
				toolbar += '	    <span class="subBullet fa fa-square" aria-hidden="true"></span>                                                         ';
				toolbar += '	    <span class="subBullet fa fa-square-o" aria-hidden="true"></span>                                                       ';
				toolbar += '	    <span class="subBullet fa fa-square bullRotate1" aria-hidden="true""></span>                      						';
				toolbar += '	    <span class="subBullet fa fa-th-large" aria-hidden="true"></span>                                                       ';
				toolbar += '	    <span class="subBullet fa fa-flickr" aria-hidden="true"></span>                                                         ';
				toolbar += '	    <span class="subBullet fa fa-flickr bullRotate3" aria-hidden="true"></span>                       						';
				toolbar += '	    <span class="subBullet fa fa-bars" aria-hidden="true"></span>                                                           ';
				toolbar += '	    <span class="subBullet fa fa-delicious" aria-hidden="true"></span>                                                      ';
				toolbar += '	    <span class="subBullet parallelogram"></span>                                                                           ';
				toolbar += '	    <span class="subBullet basicBar"></span>                                                                                ';
				toolbar += '	  </div>                                                                                                                    ';
				toolbar += '	                                                                                                                            ';
				toolbar += '	  <div><span class="name"><spring:message code="wzwg.webModule.word.txtShape" /></span>  ';
				toolbar += '	    <span class="subBullet fa fa-minus-square" aria-hidden="true"></span>                                                   ';
				toolbar += '	    <span class="subBullet fa fa-minus-circle" aria-hidden="true"></span>                                                   ';
				toolbar += '	    <span class="subBullet fa fa-plus-square" aria-hidden="true"></span>                                                    ';
				toolbar += '	    <span class="subBullet fa fa-plus-circle" aria-hidden="true"></span>                                                    ';
				toolbar += '	    <span class="subBullet fa fa-question-circle" aria-hidden="true"></span>                                                ';
				toolbar += '	    <span class="subBullet fa fa-question-circle-o" aria-hidden="true"></span>                                              ';
				toolbar += '	    <span class="subBullet fa fa-times-circle" aria-hidden="true"></span>                                                   ';
				toolbar += '	    <span class="subBullet fa fa-times-circle-o" aria-hidden="true"></span>                                                 ';
				toolbar += '	    <span class="subBullet fa fa-info-circle" aria-hidden="true"></span>                                                    ';
				toolbar += '	    <span class="subBullet fa fa-exclamation-circle" aria-hidden="true"></span>                                             ';
				toolbar += '	    <span class="subBullet fa fa-exclamation-triangle" aria-hidden="true"></span>                                           ';
				toolbar += '	                                                                                                                            ';
				toolbar += '	    <span class="subBullet fa fa-check" aria-hidden="true"></span>                                                          ';
				toolbar += '	    <span class="subBullet fa fa-check-circle" aria-hidden="true"></span>                                                   ';
				toolbar += '	    <span class="subBullet fa fa-check-circle-o" aria-hidden="true"></span>                                                 ';
				toolbar += '	    <span class="subBullet fa fa-check-square" aria-hidden="true"></span>                                                   ';
				toolbar += '	    <span class="subBullet fa fa-check-square-o" aria-hidden="true"></span>                                                 ';
				toolbar += '	  </div>                                                                                                                    ';
				toolbar += '	                                                                                                                            ';
				toolbar += '	                                                                                                                            ';
				toolbar += '	  <div><span class="name"><spring:message code="wzwg.webModule.word.linkIcon" /></span>  ';
				toolbar += '	    <span class="subBullet fa fa-download" aria-hidden="true"></span>                                                		';
				toolbar += '	    <span class="subBullet fa fa-external-link" aria-hidden="true"></span>                                                  ';
				toolbar += '	    <span class="subBullet fa fa-external-link-square" aria-hidden="true"></span>                                           ';
				toolbar += '	    <span class="subBullet fa fa-paper-plane" aria-hidden="true"></span>                                                    ';
				toolbar += '	    <span class="subBullet fa fa-location-arrow" aria-hidden="true"></span>                                                 ';
				toolbar += '	    <span class="subBullet fa fa-paperclip" aria-hidden="true"></span>                                                      ';
				toolbar += '	    <span class="subBullet fa fa-cloud-download" aria-hidden="true"></span>                                                 ';
				toolbar += '	    <span class="subBullet fa fa-sign-in" aria-hidden="true"></span>                                                        ';
				toolbar += '	    <span class="subBullet fa fa-sign-out" aria-hidden="true"></span>                                                       ';
				toolbar += '	    <span class="subBullet fa fa-file-text" aria-hidden="true"></span>                                                      ';
				toolbar += '	    <span class="subBullet fa fa-file-text-o" aria-hidden="true"></span>                                                    ';
				toolbar += '	    <span class="subBullet fa fa-facebook-official" aria-hidden="true"></span>                                              ';
				toolbar += '	    <span class="subBullet fa fa-instagram" aria-hidden="true"></span>                                                      ';
				toolbar += '	    <span class="subBullet fa fa-youtube-play" aria-hidden="true"></span>                                                   ';
				toolbar += '	    <span class="subBullet fa fa-twitter" aria-hidden="true"></span>                                                        ';
				toolbar += '	    <span class="subBullet fa fa-comment" aria-hidden="true"></span>                                                        ';
				toolbar += '	  </div>                                                                                                                    ';
				toolbar += '</div>                                                                                                                          ';
				
				
				
				// 링크버튼 로딩
				toolbar += '	<div class="edt-template-box tmplatCn_button" id="' + editorTool.editorId + '_button" style="display:none;">';
				toolbar += '		<div><span class="name">SIMPLE</span>';
				toolbar += '			<button type="button" class="edt-btn-simple-gray" onclick="WzwgEditorTool.addEditorButtonPopup(\'' + editorTool.editorId + '\', this)"><spring:message code="wzwg.cmm.word.add" /></button>';
				toolbar += '			<button type="button" class="edt-btn-simple-navy" onclick="WzwgEditorTool.addEditorButtonPopup(\'' + editorTool.editorId + '\', this)"><spring:message code="wzwg.cmm.word.add" /></button>';
				toolbar += '		</div>';
				
				toolbar += '		<div class="popDim" id="' + editorTool.editorId + '_edt-addbtn-bg" style="display:none;"></div>';
				toolbar += '		<div class="popBox" id="' + editorTool.editorId + '_edt-pop-box" style="display:none;">';
				toolbar += '			<div class="header"><spring:message code="wzwg.cmm.word.button" /> <spring:message code="wzwg.cmm.word.add" /></div>';
				toolbar += '			<div class="body">';
				toolbar += '				<div class="btn-content" id="' + editorTool.editorId + '_edt-pop-box-btn">';
				toolbar += '				</div>';
				toolbar += '				<div class="edt-pop-control">';
				toolbar += '					<div>';
				toolbar += '						<input id="' + editorTool.editorId + '_edt-pop-btn-name" type="text" placeholder="<spring:message code="wzwg.webModule.word.nm02Chg" />">';
				toolbar += '						<select id="' + editorTool.editorId + '_edt-pop-btn-target">';
				toolbar += '							<option value=""><spring:message code="wzwg.cmm.word.nowwin" />';
				toolbar += '							<option value="_blink"><spring:message code="wzwg.cmm.word.newwin" />';
				toolbar += '						</select>';
				toolbar += '					</div>';
				toolbar += '					<div>';
				toolbar += '						<input id="' + editorTool.editorId + '_edt-pop-btn-link" type="text" placeholder="<spring:message code="wzwg.webModule.word.linkInsrt01" />" value="http://" style="width : 95%;">';
				toolbar += '					</div>';
				toolbar += '					<div>';
				toolbar += '						<button type="button" class="edt-btn-control" onclick="WzwgEditorTool.addEditorButtonPreview(\'' + editorTool.editorId + '\')"><spring:message code="wzwg.cmm.word.preview" /></button>';
				toolbar += '						<button type="button" class="edt-btn-control" onclick="WzwgEditorTool.addEditorButton(\'' + editorTool.editorId + '\')"><spring:message code="wzwg.cmm.word.add" /></button>';
				toolbar += '						<button type="button" class="edt-btn-control" onclick="WzwgEditorTool.addEditorButtonPopupClose(\'' + editorTool.editorId + '\')"><spring:message code="wzwg.cmm.word.close" /></button>';
				toolbar += '					</div>';
				toolbar += '					<div>';
				toolbar += '							※ <spring:message code="wzwg.cmm.msg.MSG310" />';
				toolbar += '					</div>';
				toolbar += '				</div>';
				toolbar += '			</div>';
				toolbar += '		</div>';
				toolbar += '	</div>';
				// 링크버튼 로딩 끝
				
				
				// 레이어 로딩
				toolbar += '	<div class="edt-template-box tmplatCn_layer" id="' + editorTool.editorId + '_layer" style="display:none;">';
				
				toolbar += '	<ul>';
				toolbar += '		<span class="template_kinds">2<spring:message code="wzwg.cmm.word.step" /></span>';
				
				toolbar += '		<li>		';
				toolbar += '			<div class="edt-layer-sample">                                      ';
				toolbar += '    			<div class="name"><button type="button" data-id="' + editorTool.editorId + '_layer_btn2" class="btnLayer" data-layer="2"><spring:message code="wzwg.webModule.word.step2Add" /></button>                           ';
				toolbar += '    			</div>                           ';
				toolbar += '    			<div class="sample">                                    ';
				toolbar += '		        	<div class="edt-layer-2">50</div>        ';
				toolbar += '		        	<div class="edt-layer-2">50</div>        ';
				toolbar += '		    	</div>                                                                   ';
				toolbar += '				<div class="data" style="display:none;">';	
				toolbar += '					<div id="' + editorTool.editorId + '_layer_btn2">';
				toolbar += ' 						<br>                                                                                ';
				toolbar += ' 						<table class="cmp_layerTBL layer02form layerPadding">';
				toolbar += ' 							<tbody>';
				toolbar += ' 								<tr>';
				toolbar += ' 									<td class="td td50">50</td>';
				toolbar += ' 									<td class="btwEmptyTd"></td>';
				toolbar += ' 									<td class="td td50">50</td>';
				toolbar += ' 								</tr>';
				toolbar += ' 							</tbody>';
				toolbar += ' 						</table>                                                                             ';
				toolbar += ' 						<br>&nbsp;';
				toolbar += '					</div>';	
				toolbar += '				</div>';	
				toolbar += '			</div>';
				toolbar += '		</li>';
				
				toolbar += '		<li>		';
				toolbar += '			<div class="edt-layer-sample">                                      ';
				toolbar += '    			<div class="name"><button type="button" data-id="' + editorTool.editorId + '_layer_btn2_1" class="btnLayer" data-layer="2_1"><spring:message code="wzwg.webModule.word.step2Add" /></button>                           ';
				toolbar += '    			</div>                           ';
				toolbar += '  		  		<div class="sample">                                    ';
				toolbar += '		        	<div class="edt-layer-2 half37_l">30</div>        ';
				toolbar += '		        	<div class="edt-layer-2 half37_r">70</div>        ';
				toolbar += '				</div>                                                                   ';
				toolbar += '				<div class="data" style="display:none;">';	
				toolbar += '					<div id="' + editorTool.editorId + '_layer_btn2_1">';
				toolbar += '							 <br>                                                                                ';
				toolbar += '							 <table class="cmp_layerTBL layer02form layerPadding">';
				toolbar += '							 	<tbody>';
				toolbar += '							 		<tr>';
				toolbar += '							 			<td class="td td30">30</td>';
				toolbar += '							 			<td class="btwEmptyTd"></td>';
				toolbar += '							 			<td class="td td70">70</td>';
				toolbar += '							 		</tr>';
				toolbar += '								 </tbody>';
				toolbar += '							 </table>                                                                            ';
				toolbar += '							 <br>&nbsp;';
				toolbar += '					</div>';	
				toolbar += '				</div><!-- end data -->';	
				toolbar += '			</div>';
				toolbar += '		</li>		';
				
				toolbar += '		<li>		';
				toolbar += '			<div class="edt-layer-sample">                                      ';
				toolbar += '	    		<div class="name"><button type="button" data-id="' + editorTool.editorId + '_layer_btn2_2" class="btnLayer" data-layer="2_2"><spring:message code="wzwg.webModule.word.step2Add" /></button>                           ';
				toolbar += '	    		</div>                           ';
				toolbar += '	    		<div class="sample">                                    ';
				toolbar += '			        <div class="edt-layer-2 half73_l">70</div>        ';
				toolbar += '			        <div class="edt-layer-2 half73_r">30</div>        ';
				toolbar += '			    </div>                                                                   ';
				toolbar += '				<div class="data" style="display:none;">';	
				toolbar += '					<div id="' + editorTool.editorId + '_layer_btn2_2">';
				toolbar += '								 <br>                                                                                ';
				toolbar += '								 <table class="cmp_layerTBL layer02form layerPadding">';
				toolbar += '								 	<tbody>';
				toolbar += '								 		<tr>';
				toolbar += '											 <td class="td td70">70</td>';
				toolbar += '											 <td class="btwEmptyTd"></td>';
				toolbar += '								 			<td class="td td30">30</td>';
				toolbar += '								 		</tr>';
				toolbar += '								 	</tbody>';
				toolbar += '								 </table>                                                                            ';
				toolbar += '								 <br>&nbsp;';
				toolbar += '					</div>';	
				toolbar += '				</div><!-- end data -->';	
				toolbar += '			</div>';
				toolbar += '		</li>		';

				
				toolbar += '	</ul>';
				
				toolbar += '	<ul>';
				toolbar += '		<span class="template_kinds">3<spring:message code="wzwg.cmm.word.step" /></span>';
				
				toolbar += '		<li>		';
				toolbar += '			<div class="edt-layer-sample">                                      ';
				toolbar += '    			<div class="name"><button type="button" data-id="' + editorTool.editorId + '_layer_btn3" class="btnLayer" data-layer="3"><spring:message code="wzwg.webModule.word.step3Add" /></button></div>                           ';
				toolbar += '    			<div class="sample">                                    ';
				toolbar += '			        <div class="edt-layer-3">33</div>        ';
				toolbar += '			        <div class="edt-layer-3">33</div>        ';
				toolbar += '			        <div class="edt-layer-3">33</div>        ';
				toolbar += '			    </div>                                                                   ';
				toolbar += '				<div class="data" style="display:none;">';	
				toolbar += '					<div id="' + editorTool.editorId + '_layer_btn3">';
				toolbar += '							 <br>                                                                                    ';
				toolbar += '							 <table class="cmp_layerTBL layer03form layerPadding">';
				toolbar += '							 	<tbody>';
				toolbar += '									 <tr>';
				toolbar += '										 <td class="td">33</td>';
				toolbar += '							 			 <td class="btwEmptyTd"></td>';
				toolbar += '							 		 	 <td class="td">33</td>';
				toolbar += '							 			 <td class="btwEmptyTd"></td>';
				toolbar += '										 <td class="td">33</td>';
				toolbar += '							 		</tr>';
				toolbar += '								 </tbody>';
				toolbar += '							 </table>                                                                                ';
				toolbar += '							 <br>&nbsp;                                                                                    ';
				toolbar += '					</div>';	
				toolbar += '				</div><!-- end data -->';	
				toolbar += '			</div>';
				toolbar += '		</li>		';
				toolbar += '		<li>		';
				toolbar += '			<div class="edt-layer-sample">                                      ';
				toolbar += '    			<div class="name"><button type="button" data-id="' + editorTool.editorId + '_layer_btn3_1" class="btnLayer" data-layer="3_1"><spring:message code="wzwg.webModule.word.step3Add" />(<spring:message code="wzwg.webModule.word.whiteSpace" /> X)</button></div>                           ';
				toolbar += '    			<div class="sample">                                    ';
				toolbar += ' 						<div class="edt-layer-3 layer3_np">33</div>                                ';
				toolbar += ' 						<div class="edt-layer-3 layer3_np">33</div>                                ';
				toolbar += ' 						<div class="edt-layer-3 layer3_np">33</div>                                ';
				toolbar += '			    </div>                                                                   ';
				toolbar += '				<div class="data" style="display:none;">';	
				toolbar += '					<div id="' + editorTool.editorId + '_layer_btn3_1">';
				toolbar += '							<br>';
				toolbar += '							<table class="cmp_layerTBL layer03form">';
				toolbar += '								<tbody>';
				toolbar += '									<tr>';
				toolbar += '							  			<td class="td">33</td>';
				toolbar += '							  			<td class="td">33</td>';
				toolbar += '							  			<td class="td">33</td>';
				toolbar += '									</tr>';
				toolbar += '								</tbody>';
				toolbar += '							</table>                                                                                ';
				toolbar += '							<br>&nbsp;                                                                                  ';
				toolbar += '					</div>';	
				toolbar += '				</div><!-- end data -->';	
				toolbar += '			</div>';
				toolbar += '		</li>		';
				
				toolbar += '	</ul>';
				
				toolbar += '	<ul>';
				toolbar += '		<span class="template_kinds">4<spring:message code="wzwg.cmm.word.step" /></span>';
				
				toolbar += '		<li>		';
				toolbar += '			<div class="edt-layer-sample">                                      ';
				toolbar += '    			<div class="name"><button type="button" data-id="' + editorTool.editorId + '_layer_btn4" class="btnLayer" data-layer="4"><spring:message code="wzwg.webModule.word.step4Add" /></button></div>                           ';
				toolbar += '    			<div class="sample">                                    ';
				toolbar += '			        <div class="edt-layer-4">25</div>        ';
				toolbar += '			        <div class="edt-layer-4">25</div>        ';
				toolbar += '			        <div class="edt-layer-4">25</div>        ';
				toolbar += '			        <div class="edt-layer-4">25</div>        ';
				toolbar += '			    </div>                                                                   ';
				toolbar += '				<div class="data" style="display:none;">';	
				toolbar += '					<div id="' + editorTool.editorId + '_layer_btn4">';
				toolbar += ' 						<br>                                                                                     ';
				toolbar += ' 						<table class="cmp_layerTBL layer04form layerPadding">';
				toolbar += ' 							<tbody>';
				toolbar += ' 								<tr>';
				toolbar += ' 									<td class="td">25</td>';
				toolbar += ' 									<td class="btwEmptyTd"></td>';
				toolbar += ' 									<td class="td">25</td>';
				toolbar += ' 									<td class="btwEmptyTd"></td>';
				toolbar += ' 									<td class="td">25</td>';
				toolbar += ' 									<td class="btwEmptyTd"></td>';
				toolbar += ' 									<td class="td">25</td>';
				toolbar += ' 								</tr>';
				toolbar += ' 							</tbody>';
				toolbar += ' 						</table>                                                                                  ';
				toolbar += ' 						<br>&nbsp;                                                                                     ';
				toolbar += '					</div>';	
				toolbar += '				</div><!-- end data -->';	
				toolbar += '			</div>';
				toolbar += '		</li>		';
				toolbar += '		<li>		';
				toolbar += '			<div class="edt-layer-sample">                                      ';
				toolbar += '    			<div class="name"><button type="button" data-id="' + editorTool.editorId + '_layer_btn4_1" class="btnLayer" data-layer="4_1">4<spring:message code="wzwg.webModule.word.step4Add" />(<spring:message code="wzwg.webModule.word.whiteSpace" /> X)</button></div>                           ';
				toolbar += '    			<div class="sample">                                    ';
				toolbar += '						<div class="edt-layer-4 layer4_np">25</div>                                ';
				toolbar += '						<div class="edt-layer-4 layer4_np">25</div>                                ';
				toolbar += '						<div class="edt-layer-4 layer4_np">25</div>                                ';
				toolbar += '						<div class="edt-layer-4 layer4_np">25</div>                                ';
				toolbar += '			    </div>                                                                   ';
				toolbar += '				<div class="data" style="display:none;">';	
				toolbar += '					<div id="' + editorTool.editorId + '_layer_btn4_1">';
				toolbar += '						<br>                                                                                   ';
				toolbar += '						<table class="cmp_layerTBL layer04form">';
				toolbar += '							<tbody>';
				toolbar += '								<tr>';
				toolbar += '									<td class="td">25</td>';
				toolbar += '									<td class="td">25</td>';
				toolbar += '									<td class="td">25</td>';
				toolbar += '									<td class="td">25</td>';
				toolbar += '								</tr>';
				toolbar += '							</tbody>';
				toolbar += '						</table>                                                                                ';
				toolbar += '						<br>&nbsp;                                                                                   ';
				toolbar += '					</div>';	
				toolbar += '				</div><!-- end data -->';	
				toolbar += '			</div>';
				toolbar += '		</li>		';
				
				toolbar += '	</ul>';
				
				
				toolbar += '	<ul>';
				toolbar += '		<span class="template_kinds"><spring:message code="wzwg.webModule.word.groupTy02" /></span>';
				
				toolbar += '		<li>		';
				toolbar += '			<div class="edt-layer-sample">                                      ';
				toolbar += '    			<div class="name"><button type="button" data-id="' + editorTool.editorId + '_layer_grp2" class="btnLayer" data-layer="grp2"><spring:message code="wzwg.webModule.word.step2groupAdd" /></button></div>                           ';
				toolbar += '    			<div class="sample">                                    ';
				toolbar += '					<div class="edt-layer-2">';
				toolbar += '						<div class="layerimg"><spring:message code="wzwg.cmm.word.photo" /></div>';
				toolbar += '						<div class="layerimg"><spring:message code="wzwg.cmm.word.posts" /></div>';
				toolbar += '					</div>        		        	';
				toolbar += '					<div class="edt-layer-2">';
				toolbar += '						<div class="layerimg"><spring:message code="wzwg.cmm.word.photo" /></div>';
				toolbar += '						<div class="layerimg"><spring:message code="wzwg.cmm.word.posts" /></div>';
				toolbar += '					</div>    ';
				toolbar += '			    </div>                                                                   ';
				toolbar += '				<div class="data" style="display:none;">';	
				toolbar += '					<div id="' + editorTool.editorId + '_layer_grp2">';
				toolbar += '						<br>';
				toolbar += '						<table class="cmp_layerTBL layer02form layerPadding grouplayer">';
				toolbar += '							<tbody>';
				toolbar += '								<tr>';
				toolbar += '									<td class="td">';
				toolbar += '										<table class="wd100 __se_tbl layerinnerTbl">';
				toolbar += '											<tbody>';
				toolbar += '												<tr><td class="tdimg"><spring:message code="wzwg.cmm.word.sj" /> <spring:message code="wzwg.cmm.word.or" /> <spring:message code="wzwg.cmm.word.image" /></td></tr>';
				toolbar += '												<tr><th class="thtitle"><b><spring:message code="wzwg.webModule.word.postsCn" /></b></th></tr>';
				toolbar += '												<tr><td class="tdco"><spring:message code="wzwg.webModule.word.postsCn" /></td></tr>';
				toolbar += '											</tbody>';
				toolbar += '										</table>';
				toolbar += '									</td>';
				toolbar += '									<td class="btwEmptyTd"></td>';
				toolbar += '									<td class="td">';
				toolbar += '										<table class="wd100 __se_tbl layerinnerTbl">';
				toolbar += '											<tbody>';
				toolbar += '												<tr><td class="tdimg"><spring:message code="wzwg.cmm.word.sj" /> <spring:message code="wzwg.cmm.word.or" /> <spring:message code="wzwg.cmm.word.image" /></td></tr>';
				toolbar += '												<tr><th class="thtitle"><b><spring:message code="wzwg.webModule.word.postsCn" /></b></th></tr>';
				toolbar += '												<tr><td class="tdco"><spring:message code="wzwg.webModule.word.postsCn" /></td></tr>';
				toolbar += '											</tbody>';
				toolbar += '										</table>';
				toolbar += '									</td>';
				toolbar += '								</tr>';
				toolbar += '							</tbody>';
				toolbar += '						</table>';
				toolbar += '						<br>&nbsp;';
				toolbar += '					</div>';	
				toolbar += '				</div><!-- end data -->';	
				toolbar += '			</div>';
				toolbar += '		</li>		';
				toolbar += '		<li>		';
				toolbar += '			<div class="edt-layer-sample">                                      ';
				toolbar += '    			<div class="name"><button type="button" data-id="' + editorTool.editorId + '_layer_grp3" class="btnLayer" data-layer="grp3"><spring:message code="wzwg.webModule.word.step3GroupAdd" /></button></div>                           ';
				toolbar += '    			<div class="sample">                                    ';
				toolbar += '					<div class="edt-layer-3">';
				toolbar += '						<div class="layerimg"><spring:message code="wzwg.cmm.word.photo" /></div>';
				toolbar += '						<div class="layerimg"><spring:message code="wzwg.cmm.word.posts" /></div>';
				toolbar += '					</div>        		        	';
				toolbar += '					<div class="edt-layer-3">';
				toolbar += '						<div class="layerimg"><spring:message code="wzwg.cmm.word.photo" /></div>';
				toolbar += '						<div class="layerimg"><spring:message code="wzwg.cmm.word.posts" /></div>';
				toolbar += '					</div>       ';
				toolbar += '					<div class="edt-layer-3">';
				toolbar += '						<div class="layerimg"><spring:message code="wzwg.cmm.word.photo" /></div>';
				toolbar += '						<div class="layerimg"><spring:message code="wzwg.cmm.word.posts" /></div>';
				toolbar += '					</div>  	';
				toolbar += '			    </div>                                                                   ';
				toolbar += '				<div class="data" style="display:none;">';	
				toolbar += '					<div id="' + editorTool.editorId + '_layer_grp3">';
				toolbar += '						<!-- 레이어 3단 그룹 -->';
				toolbar += '						<br>';
				toolbar += '						<table class="cmp_layerTBL layer03form layerPadding grouplayer">';
				toolbar += '						<tbody>';
				toolbar += '						<tr>';
				toolbar += '						<td class="td"><table class="wd100 __se_tbl layerinnerTbl"><tbody>';
				toolbar += '						<tr><td class="tdimg"><spring:message code="wzwg.cmm.word.sj" /> <spring:message code="wzwg.cmm.word.or" /> <spring:message code="wzwg.cmm.word.image" /></td></tr>';
				toolbar += '						<tr><th class="thtitle"><b><spring:message code="wzwg.webModule.word.postsCn" /></b></th></tr>';
				toolbar += '						<tr><td class="tdco"><spring:message code="wzwg.webModule.word.postsCn" /></td></tr>';
				toolbar += '						</tbody></table></td>';
				toolbar += '						<td class="btwEmptyTd"></td>';
				toolbar += '						<td class="td"><table class="wd100 __se_tbl layerinnerTbl"><tbody>';
				toolbar += '						<tr><td class="tdimg"><spring:message code="wzwg.cmm.word.sj" /> <spring:message code="wzwg.cmm.word.or" /> <spring:message code="wzwg.cmm.word.image" /></td></tr>';
				toolbar += '						<tr><th class="thtitle"><b><spring:message code="wzwg.webModule.word.postsCn" /></b></th></tr>';
				toolbar += '						<tr><td class="tdco"><spring:message code="wzwg.webModule.word.postsCn" /></td></tr>';
				toolbar += '						</tbody></table></td>';
				toolbar += '						<td class="btwEmptyTd"></td>';
				toolbar += '						<td class="td"><table class="wd100 __se_tbl layerinnerTbl"><tbody>';
				toolbar += '						<tr><td class="tdimg"><spring:message code="wzwg.cmm.word.sj" /> <spring:message code="wzwg.cmm.word.or" /> <spring:message code="wzwg.cmm.word.image" /></td></tr>';
				toolbar += '						<tr><th class="thtitle"><b><spring:message code="wzwg.webModule.word.postsCn" /></b></th></tr>';
				toolbar += '						<tr><td class="tdco"><spring:message code="wzwg.webModule.word.postsCn" /></td></tr>';
				toolbar += '						</tbody></table></td>';
				toolbar += '						</tr>';
				toolbar += '						</tbody>';
				toolbar += '						</table>';
				toolbar += '						<br>&nbsp;';
				toolbar += '					</div>';	
				toolbar += '				</div><!-- end data -->';	
				toolbar += '			</div>';
				toolbar += '		</li>		';
				toolbar += '		<li>		';
				toolbar += '			<div class="edt-layer-sample">                                      ';
				toolbar += '    			<div class="name"><button type="button" data-id="' + editorTool.editorId + '_layer_grp4" class="btnLayer" data-layer="grp4"><spring:message code="wzwg.webModule.word.step4GroupAdd" /></button></div>                           ';
				toolbar += '    			<div class="sample">                                    ';
				toolbar += '					<div class="edt-layer-4">';
				toolbar += '						<div class="layerimg"><spring:message code="wzwg.cmm.word.photo" /></div>';
				toolbar += '						<div class="layerimg"><spring:message code="wzwg.cmm.word.posts" /></div>';
				toolbar += '					</div>        		        	';
				toolbar += '					<div class="edt-layer-4">';
				toolbar += '						<div class="layerimg"><spring:message code="wzwg.cmm.word.photo" /></div>';
				toolbar += '						<div class="layerimg"><spring:message code="wzwg.cmm.word.posts" /></div>';
				toolbar += '					</div>       ';
				toolbar += '					<div class="edt-layer-4">';
				toolbar += '						<div class="layerimg"><spring:message code="wzwg.cmm.word.photo" /></div>';
				toolbar += '						<div class="layerimg"><spring:message code="wzwg.cmm.word.posts" /></div>';
				toolbar += '					</div>';
				toolbar += '					<div class="edt-layer-4">';
				toolbar += '						<div class="layerimg"><spring:message code="wzwg.cmm.word.photo" /></div>';
				toolbar += '						<div class="layerimg"><spring:message code="wzwg.cmm.word.posts" /></div>';
				toolbar += '					</div> 		        	       		';    
				toolbar += '			    </div>                                                                   ';
				toolbar += '				<div class="data" style="display:none;">';	
				toolbar += '					<div id="' + editorTool.editorId + '_layer_grp4">';
				toolbar += '						<!-- 레이어 4단 그룹 -->';
				toolbar += '						<br>';
				toolbar += '						<table class="cmp_layerTBL layer04form layerPadding grouplayer">';
				toolbar += '						<tbody>';
				toolbar += '						<tr>';
				toolbar += '						<td class="td"><table class="wd100 __se_tbl layerinnerTbl"><tbody>';
				toolbar += '						<tr><td class="tdimg"><spring:message code="wzwg.cmm.word.sj" /> <spring:message code="wzwg.cmm.word.or" /> <spring:message code="wzwg.cmm.word.image" /></td></tr>';
				toolbar += '						<tr><th class="thtitle"><b><spring:message code="wzwg.webModule.word.postsCn" /></b></th></tr>';
				toolbar += '						<tr><td class="tdco"><spring:message code="wzwg.webModule.word.postsCn" /></td></tr>';
				toolbar += '						</tbody></table></td>';
				toolbar += '						<td class="btwEmptyTd"></td>';
				toolbar += '						<td class="td"><table class="wd100 __se_tbl layerinnerTbl"><tbody>';
				toolbar += '						<tr><td class="tdimg"><spring:message code="wzwg.cmm.word.sj" /> <spring:message code="wzwg.cmm.word.or" /> <spring:message code="wzwg.cmm.word.image" /></td></tr>';
				toolbar += '						<tr><th class="thtitle"><b><spring:message code="wzwg.webModule.word.postsCn" /></b></th></tr>';
				toolbar += '						<tr><td class="tdco"><spring:message code="wzwg.webModule.word.postsCn" /></td></tr>';
				toolbar += '						</tbody></table></td>';
				toolbar += '						<td class="btwEmptyTd"></td>';
				toolbar += '						<td class="td"><table class="wd100 __se_tbl layerinnerTbl"><tbody>';
				toolbar += '						<tr><td class="tdimg"><spring:message code="wzwg.cmm.word.sj" /> <spring:message code="wzwg.cmm.word.or" /> <spring:message code="wzwg.cmm.word.image" /></td></tr>';
				toolbar += '						<tr><th class="thtitle"><b><spring:message code="wzwg.webModule.word.postsCn" /></b></th></tr>';
				toolbar += '						<tr><td class="tdco"><spring:message code="wzwg.webModule.word.postsCn" /></td></tr>';
				toolbar += '						</tbody></table></td>';
				toolbar += '						<td class="btwEmptyTd"></td>';
				toolbar += '						<td class="td"><table class="wd100 __se_tbl layerinnerTbl"><tbody>';
				toolbar += '						<tr><td class="tdimg"><spring:message code="wzwg.cmm.word.sj" /> <spring:message code="wzwg.cmm.word.or" /> <spring:message code="wzwg.cmm.word.image" /></td></tr>';
				toolbar += '						<tr><th class="thtitle"><b><spring:message code="wzwg.webModule.word.postsCn" /></b></th></tr>';
				toolbar += '						<tr><td class="tdco"><spring:message code="wzwg.webModule.word.postsCn" /></td></tr>';
				toolbar += '						</tbody></table></td>';
				toolbar += '						</tr>';
				toolbar += '						</tbody>';
				toolbar += '						</table>';
				toolbar += '						<br>&nbsp;';
				toolbar += '					</div>';	
				toolbar += '				</div><!-- end data -->';	
				toolbar += '			</div>';
				toolbar += '		</li>		';
				
				toolbar += '	</ul>';
				
				
				
				toolbar += '	</div>';
				// 레이어 로딩 끝
				
				// 템플릿 로딩
				toolbar += '	<div class="edt-template-box tmplatCn_template" id="' + editorTool.editorId + '_template" style="display:none;">';
				
				var templatList = $('#edtTmpArea_<c:out value="${idr }" />');
				//console.log(templatList);
				var groupName = '';
				templatList.children().each(function(idx,el){
					var element = $(el);
					var meta = element.find('meta');
					var thumbnail = meta.attr('thumbnail');
					var name = meta.attr('name');
					var idno = meta.attr('idno');
					//meta.remove();
					var group = meta.attr('group');
					/*console.log('meta grop : ' + group);
					console.log(groupName +'/'+ group);
					console.log('groupName != group : ');
					console.log(groupName != group);*/
					
					if(groupName != '' && groupName != group){
						toolbar += '	</ul>';
					}
					
					if(groupName != group){
						
						var groupText = "";
						
						
						if(group == '타이틀'){
							groupText = wz_msg('wzwg.cmm.word.title');
						}
							
						if(group == '목록형'){
							groupText = wz_msg('wzwg.cmm.word.listTy');
						}
						
						if(group == '표'){
							groupText = wz_msg('wzwg.cmm.word.wa.table');
						}
						
						if(group == '기타'){
							groupText = wz_msg('wzwg.cmm.word.etc');
						}
						
						toolbar += '	<ul>';
						toolbar += '		<span class="template_kinds">' + groupText + '</span>';
					}
					
					//console.log(thumbnail);
					if(element.attr('data-check') != ''){
						
						
						toolbar += '		<li>                                      ';
						toolbar += '		<div class="edt-template-sample" style="">                                      ';
						//toolbar += '    			<div class="name">' + name + '</div>                           ';
						toolbar += '    			<div class="sample">                                    ';
						toolbar += '    				<a onclick="WzwgEditorTool.addEditorTemplate(\'' + editorTool.editorId + '\', \'' + editorTool.editorId + '_template_' + idno + '\')" ><img src="' + thumbnail + '"></a>                                    ';
						toolbar += '					<div id="' + editorTool.editorId + '_template_' + idno + '" style="display: none;">                                                                           ';
						toolbar += 		element.html();
						toolbar += '					</div>  <!-- end area -->                                                                         ';
						toolbar += '    			</div>                                    ';
						toolbar += '			</div>';
						toolbar += '		</li>';
					}
					
					groupName = group;
				});
				
				//templatList.remove();
				
				
				
				
				toolbar += '	</div>';
				// 템플릿 로딩 끝
				
				return $(toolbar);
			},
			addEditorImageToImg : function(editorId, _img){
				var imgTag = '<img class="bullet" src="' + $(_img).attr('src') + '"/>';
				console.log(imgTag);
				console.log(editorId);
				console.log(oEditors);
				oEditors.getById[editorId].exec("PASTE_HTML", [imgTag]);
			},
			addEditorTagLayer : function(editorId, multiply){
				var tag = '';
					tag = multiply;

				oEditors.getById[editorId].exec("PASTE_HTML", [tag]);
			},
			addEditorButtonPopup : function(editorId, btnSrc){
				var btn = '<a id="' + editorId + '_edt-temp-btn" type="button" class="' + $(btnSrc).attr('class') + '"><spring:message code="wzwg.cmm.word.shrtcut" /></a>'; 
				$('#' + editorId + '_edt-pop-box-btn').html($(btn));
				$('#' + editorId + '_edt-addbtn-bg').show();
				$('#' + editorId + '_edt-pop-box').show();
			},
			addEditorButtonPopupClose : function(editorId){
				$('#' + editorId + '_edt-pop-box-btn').html('');
				$('#' + editorId + '_edt-pop-btn-link').val('http://');
				$('#' + editorId + '_edt-pop-btn-name').val('');
				$('#' + editorId + '_edt-pop-btn-target').val('');
				$('#' + editorId + '_edt-pop-box').hide();
				$('#' + editorId + '_edt-addbtn-bg').hide();
			},
			addEditorButtonPreview : function(editorId){
				if($('#' + editorId + '_edt-pop-btn-name').val() == ''){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
							'<spring:argument><spring:message code="wzwg.webModule.word.buttonNm02" /></spring:argument>'+
							'<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>'+
						  '</spring:message>');
					return false;
				}
				if($('#' + editorId + '_edt-pop-btn-link').val() == '' || $('#' + editorId + '_edt-pop-btn-link').val() == 'http://' || $('#' + editorId + '_edt-pop-btn-link').val() == 'https://'){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
							'<spring:argument><spring:message code="wzwg.webModule.word.linkAdres" /></spring:argument>'+
							'<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>'+
						  '</spring:message>');
					return false;
				}
				
				$('#' + editorId + '_edt-temp-btn').attr('href', $('#' + editorId + '_edt-pop-btn-link').val());
				$('#' + editorId + '_edt-temp-btn').attr('target', $('#' + editorId + '_edt-pop-btn-target').val());
				$('#' + editorId + '_edt-temp-btn').html($('#' + editorId + '_edt-pop-btn-name').val());
				return true;
			},
			addEditorButton : function(editorId){
				
				if($('#' + editorId + '_edt-temp-btn').html() == ''){
					alert('<spring:message code="wzwg.cmm.msg.MSG076" />');
					return false;
				}
				var process = WzwgEditorTool.addEditorButtonPreview();
				if(process){
					$('#' + editorId + '_edt-temp-btn').removeAttr('id');
					var aTag = '<span>' + $('#' + editorId + '_edt-pop-box-btn').html() +'</span>&nbsp;<br>';
					oEditors.getById[editorId].exec("PASTE_HTML", [aTag]);
					WzwgEditorTool.addEditorButtonPopupClose(editorId);
				}
			},
			addEditorTemplate : function(editorId, tagId){
				var tag = $('#' + tagId).html();
				oEditors.getById[editorId].exec("PASTE_HTML", [tag]);
			},
			//위디자인 버튼 추가 2019-07-24 조원권
			WgFnAddWzwgButton : function(editorId){
				var btn = '<span>&nbsp;</span><a class="wzbtn-lg btn-black fs17">&nbsp;<span><spring:message code="wzwg.cmm.msg.MSG438" /><span></a><span>&nbsp;</span>';
				oEditors.getById[editorId].exec("PASTE_HTML", [btn]);
			},
			consoleLog : function(text){
				// 이벤트 핸들러 호출 테스트용
				console.log(text);
			}
		}
	</script>
	<%-- 템플릿은 사용하지 않기로 결정함 2018.09.03 조원권
	 --%>
	<%--<div id="edtItemArea_<c:out value="${idr }" />" style="display: none;">
		<div id="edtTmpArea_<c:out value="${idr }" />" data-rows="<c:out value="${fn:length(templateList) }" />">
			<c:forEach items="${templateList }" var="list" varStatus="c"><div data-check="true"><c:out value="${list }" escapeXml="false"/></div></c:forEach>
				
		</div>
	</div>
 	--%>	
	
	<div id="edtItemArea_<c:out value="${idr}" />" style="display: none;">
	    <div id="edtTmpArea_<c:out value="${idr}" />" data-rows="<c:out value="${fn:length(templateList)}" />">
	        <c:forEach items="${templateList}" var="list">
	            <div data-check="true">
	                <c:out value="${list}" />
	            </div>
	        </c:forEach>
	    </div>
	</div>
	