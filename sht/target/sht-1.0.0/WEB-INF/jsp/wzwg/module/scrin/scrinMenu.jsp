<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Simplest jQuery Dropdown Nav Demo</title>
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.6.2/css/font-awesome.min.css">
<script type="text/javascript" src="/js/wzwg/cmm/jquery-latest.min.js"></script>
<style>
@import url(https://fonts.googleapis.com/css?family=Roboto:400,700,500);

/* main Styles */

html { box-sizing: border-box; }

*, *:before, *:after { box-sizing: inherit; }

body {
  background: #fafafa;
  font-family: NanumGothic;
  font-size: 14px;
  margin: 0;
}

a { text-decoration: none; }

#menu {
  margin: auto;
}

h1 { text-align:center; margin-top:150px;}

/* Navigation Styles */

#menu { background: #2ba0db; }

#menu ul {
  font-size: 0;
  margin: 0;
  padding: 0;
}

#menu ul li {
  display: inline-block;
  position: relative;
}

#menu ul li a {
  color: #fff;
  display: block;
  font-size: 14px;
  padding: 15px 14px;
  transition: 0.3s linear;
}

#menu ul li:hover { background: #126d9b; }

#menu ul li ul {
  border-bottom: 5px solid #2ba0db;
  display: none;
  position: absolute;
  width: 250px;
}

#menu ul li ul li {
  border-top: 1px solid #444;
  display: block;
}

#menu ul li ul li:first-child { border-top: none; }

#menu ul li ul li a {
  background: #373737;
  display: block;
  padding: 10px 14px;
}

#menu ul li ul li a:hover { background: #126d9b; }

#menu .fa.fa-angle-down { margin-left: 6px; }
</style>
</head>
<script type="text/javascript">



$(document).ready(function() {

    var startMenuLv = 1;
    var stopMenuLv = 2;
    
    $('#menu').each(function (index, parentEle) {
        $.ajax({
            type:'POST'
          , url:'<c:out value="${wzwg_contextPath}" />/module/scrin/scrinMenuJson.do'
          , contentType : "application/json"
          , success:function (data) {
        	 var firstMenu = jsonFilter(data,'menuLv', '1');
        	 
        	 
        	    $("#menu").find(".data").children().each(function (index, childEle) {  
        	        if (firstMenu.length > index) { 
        	        	 var subMenu = jsonFilter(data,'upperMenuNo', firstMenu[index].menuSeq);
        	        	
        	        	 $(childEle).find("*").each(function(i,cl){
        	        		 for(var key in firstMenu[index]){ 
        	 	        		if(key ==  $(cl).data("attr")){
        	  	    	            $(cl).html(firstMenu[index][key]);   
        	 	        		}
        	 	        		if(key ==  $(cl).data("href")){
        	  	    	            $(cl).attr("href",firstMenu[index][key]);   
        	 	        		}
        	 	        		
        	 	        		if(key ==  $(cl).data("src")){
        	  	    	            $(cl).attr("src",firstMenu[index][key]);   
        	 	        		}
        	 	        	}
        	        	 });
        	        	 
        	        	 $(childEle).find(".sub-menu").children().each(function (indexSub, childSubEle) {  
        	        		 if(subMenu.length > indexSub){
        	        		 $(childSubEle).find("*").each(function(i,cl){
            	        		 for(var key in subMenu[indexSub]){ 
            	 	        		if(key ==  $(cl).data("attr")){
            	  	    	            $(cl).html(subMenu[indexSub][key]);   
            	 	        		}
            	 	        		if(key ==  $(cl).data("href")){
            	  	    	            $(cl).attr("href",subMenu[indexSub][key]);   
            	 	        		}
            	 	        		
            	 	        		if(key ==  $(cl).data("src")){
            	  	    	            $(cl).attr("src",subMenu[indexSub][key]);   
            	 	        		}
            	 	        	}
            	        	 });
        	        		 }else{
        	        			 $(childSubEle).remove();
        	        		 }
        	        	 });
        	        	if(subMenu.length ==0){
        	        		$(childEle).find(".sub-menu").remove();
        	        	}
        	        }else{
        	        	$(childEle).remove();
        	        }
        		   
        	    });
        	    /****
                // li 
                var liChk = 0;
                var preLv = 0;
                for (var i=0; i<data['cntntsData'].length; i++) {
                    // 1차메뉴
                    if (data['cntntsData'][i].menuLv == startMenuLv) {
                        $('.container ul').eq(0).append('<li id="'+data['cntntsData'][i].menuSeq+'"><a href="#">['+data['cntntsData'][i].menuSeq+']'+data['cntntsData'][i].menuNm+'</a></li>');
                        liChk = 0;   
                    } else {
                        // 서브메뉴
                        if (data['cntntsData'][i].menuLv == stopMenuLv) {
                            // 1차만 들어감
                            if (liChk == 0) {
                                $('.container ul').find('li').last().addClass('sub-menu');
                                $('.container ul').find('li').last().append('<ul></ul>');   
                            }
                            
                            // 마지막 UL에 메뉴 추가
                            $('.container ul').find('ul').last().append('<li id="'+data['cntntsData'][i].menuSeq+'"><a href="#">['+data['cntntsData'][i].menuSeq+']'+data['cntntsData'][i].menuNm+'</a></li>');
                            liChk = 1;
                        } 
                    }
                }
                ***/
            }
            , dataType: 'json'
        });
    });
});
function jsonFilter(data,key, value){
	 var arrJson = new  Array();
	 var obj = new  Object();
	  for (var i=0; i<data['cntntsData'].length; i++) {
			  if (data['cntntsData'][i][key] == value) {
				  obj =data['cntntsData'][i];
				  arrJson.push(obj);
		  }
	  }
	  return arrJson;
}
</script>
<body> 
    <div id="menu">
        <ul class="data">
        <li id=""><a href="#" data-attr="menuNm"></a>
        		<ul class="sub-menu">
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        		</ul>
        </li>
        <li id=""><a href="#" data-attr="menuNm"></a>
        		<ul class="sub-menu">
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        		</ul>
        </li>
        <li id=""><a href="#" data-attr="menuNm"></a>
        		<ul class="sub-menu">
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        		</ul>
        </li>
        <li id=""><a href="#" data-attr="menuNm"></a>
        		<ul  class="sub-menu">
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        		</ul>
        </li>
          <li id=""><a href="#" data-attr="menuNm"></a>
        		<ul  class="sub-menu">
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        		</ul>
        </li>
          <li id=""><a href="#" data-attr="menuNm"></a>
        		<ul  class="sub-menu">
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        		</ul>
        </li>
          <li id=""><a href="#" data-attr="menuNm"></a>
        		<ul  class="sub-menu">
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        		</ul>
        </li>
          <li id=""><a href="#" data-attr="menuNm"></a>
        		<ul  class="sub-menu">
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        		</ul>
        </li>
          <li id=""><a href="#" data-attr="menuNm"></a>
        		<ul  class="sub-menu">
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        			<li id=""><a href="#" data-attr="menuNm"></a></li>
        		</ul>
        </li>
        </ul>
    </div> 

<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script> 
<script>
$('#menu li').hover(
  function() {
      $('ul', this).stop().slideDown(200);
  },
    function() {
    $('ul', this).stop().slideUp(200);
  }
);
</script>


</body>
</html>
