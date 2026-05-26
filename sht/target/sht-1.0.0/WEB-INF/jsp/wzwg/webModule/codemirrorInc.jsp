<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/lib/codemirror.css">
		<script src="/js/wzwg/cmm/codemirror/lib/codemirror.js"></script>
		<script src="/js/wzwg/cmm/codemirror/mode/xml/xml.js"></script>
		<script src="/js/wzwg/cmm/codemirror/mode/javascript/javascript.js"></script>
		<script src="/js/wzwg/cmm/codemirror/mode/css/css.js"></script>
		<script src="/js/wzwg/cmm/codemirror/mode/vbscript/vbscript.js"></script>
		<script src="/js/wzwg/cmm/codemirror/mode/htmlmixed/htmlmixed.js"></script>
		
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/3024-day.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/3024-night.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/abcdef.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/ambiance.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/base16-dark.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/bespin.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/base16-light.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/blackboard.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/cobalt.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/colorforth.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/dracula.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/duotone-dark.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/duotone-light.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/eclipse.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/elegant.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/erlang-dark.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/gruvbox-dark.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/hopscotch.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/icecoder.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/isotope.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/lesser-dark.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/liquibyte.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/lucario.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/material.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/mbo.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/mdn-like.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/midnight.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/monokai.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/neat.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/neo.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/night.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/oceanic-next.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/panda-syntax.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/paraiso-dark.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/paraiso-light.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/pastel-on-dark.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/railscasts.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/rubyblue.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/seti.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/shadowfox.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/solarized.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/the-matrix.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/tomorrow-night-bright.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/tomorrow-night-eighties.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/ttcn.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/twilight.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/vibrant-ink.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/xq-dark.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/xq-light.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/yeti.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/idea.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/darcula.css">
		<link rel="stylesheet" href="/js/wzwg/cmm/codemirror/theme/zenburn.css">
		
		<script>
			function cmStart(textareaId, _mode, select){
				var cm = CodeMirror.fromTextArea(document.getElementById(textareaId), {
					  mode: _mode,
					  styleActiveLine: true,
					  lineNumbers: true,
					  lineWrapping: true
					});
				return cm;
				//selectTheme();
				if(select){
					makeCodemirrorThemeOption(select);
				}
			}
			
			function cmSetTheme(codeMirror, select) {
			    //var theme = $("#select option:selected").text();
			    var theme = $(select.selector + ' option:selected').text()
			    //console.log(theme);
			    //var theme = $("#select").options[$("#select").selectedIndex].textContent;
			    codeMirror.setOption("theme", theme);
			    //location.hash = "#" + theme;
			}
			function secureRandom(wordCount){
				   var randomWords;
				 
				   if( window.crypto && window.crypto.getRandomValues){
				       // 크롬 등에서 지원
				       randomWords = new Int32Array(wordCount);
				       window.crypto.getRandomValues(randomWords);
				   }else if(window.msCrypto && window.msCrypto.getRandomValues){
				       // Internet Explorer 11에서 지원
				       randomWords = new Int32Array(wordCount);
				       window.msCrypto.getRandomValues(randomWords);
				   }else{
				       // Internet Explorer 10 이하의 버전
				       return 0.9959054245998751;  // 아무값이나 리턴
				       /* 또는 그냥 
				         return Math.random(); 
				        */
				   }
				   
				   var result = randomWords[0] * Math.pow(2, -32);
				   result = Math.abs(result);
				   return result;
				}
			function cmSetWebSorceText(codeMirror, filePath){
				 var tmpSrc = $('<div id="srcEditor"></div>');
				 var dummy = '?d=' + secureRandom();
				 $(tmpSrc).load(filePath + dummy, function(){
					 //$('#srcEditor').html($(this).html());
					 //$('#cssFileName').val(fileName);
					 //aceEditorInit($(this));
					 var loadText = $(this).html();
					 loadText = cmConvertXmlExprToText(loadText);
					 //loadText = loadText.replace(new RegExp('&gt;', "g"), '>');
					 //loadText = loadText.replace(new RegExp('&lt;', "g"), '<');
					 codeMirror.doc.setValue(loadText);
					 
					 $(this).remove();
				 });	
			}
			
			function cmSetSorceText(codeMirror, src){
				codeMirror.doc.setValue(src);
			}
			
			function cmGetText(codeMirror){
				return codeMirror.doc.getValue();
			}
			
			function cmConvertXmlExprToText(xmlText){
				xmlText = xmlText.replace(new RegExp('&gt;', "g"), '>');
				xmlText = xmlText.replace(new RegExp('&lt;', "g"), '<');
				
				return xmlText;
			}
			
			function cmConvertTextToXmlExpr(xmlText){
				xmlText = xmlText.replace(new RegExp('>', "g"), '&gt;');
				xmlText = xmlText.replace(new RegExp('<', "g"), '&lt;');
				
				return xmlText;
			}
			
			
			
			
			
			function makeCodemirrorThemeOption(select){
				var opt = '';
					opt += '<option>      default</option>                     ';
				    opt += '<option>      3024-day</option>                    ';
				    opt += '<option>      3024-night</option>                  ';
				    opt += '<option>      abcdef</option>                      ';
				    opt += '<option>      ambiance</option>                    ';
				    opt += '<option>      base16-dark</option>                 ';
				    opt += '<option>      base16-light</option>                ';
				    opt += '<option>      bespin</option>                      ';
				    opt += '<option>      blackboard</option>                  ';
				    opt += '<option>      cobalt</option>                      ';
				    opt += '<option>      colorforth</option>                  ';
				    opt += '<option>      darcula</option>            ';
				    opt += '<option>      dracula</option>                     ';
				    opt += '<option>      duotone-dark</option>                ';
				    opt += '<option>      duotone-light</option>               ';
				    opt += '<option>      eclipse</option>                     ';
				    opt += '<option>      elegant</option>                     ';
				    opt += '<option>      erlang-dark</option>                 ';
				    opt += '<option>      gruvbox-dark</option>                ';
				    opt += '<option>      hopscotch</option>                   ';
				    opt += '<option>      icecoder</option>                    ';
				    opt += '<option>      idea</option>                        ';
				    opt += '<option>      isotope</option>                     ';
				    opt += '<option>      lesser-dark</option>                 ';
				    opt += '<option>      liquibyte</option>                   ';
				    opt += '<option>      lucario</option>                     ';
				    opt += '<option selected>      material</option>                    ';
				    opt += '<option>      mbo</option>                         ';
				    opt += '<option>      mdn-like</option>                    ';
				    opt += '<option>      midnight</option>                    ';
				    opt += '<option>      monokai</option>                     ';
				    opt += '<option>      neat</option>                        ';
				    opt += '<option>      neo</option>                         ';
				    opt += '<option>      night</option>                       ';
				    opt += '<option>      oceanic-next</option>                ';
				    opt += '<option>      panda-syntax</option>                ';
				    opt += '<option>      paraiso-dark</option>                ';
				    opt += '<option>      paraiso-light</option>               ';
				    opt += '<option>      pastel-on-dark</option>              ';
				    opt += '<option>      railscasts</option>                  ';
				    opt += '<option>      rubyblue</option>                    ';
				    opt += '<option>      seti</option>                        ';
				    opt += '<option>      shadowfox</option>                   ';
				    opt += '<option>      solarized dark</option>              ';
				    opt += '<option>      solarized light</option>             ';
				    opt += '<option>      the-matrix</option>                  ';
				    opt += '<option>      tomorrow-night-bright</option>       ';
				    opt += '<option>      tomorrow-night-eighties</option>     ';
				    opt += '<option>      ttcn</option>                        ';
				    opt += '<option>      twilight</option>                    ';
				    opt += '<option>      vibrant-ink</option>                 ';
				    opt += '<option>      xq-dark</option>                     ';
				    opt += '<option>      xq-light</option>                    ';
				    opt += '<option>      yeti</option>                        ';
				    opt += '<option>      zenburn</option>                     ';
				    $(select).append(opt);
			}
		</script>