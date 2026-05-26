<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
    <%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<c:import url="${topUrl}"></c:import>
<div id="content" class="content" style="width:100%;height:500px;">
 <link type="text/css" href="/css/wzwg/cmm/common.css" rel="stylesheet" />
  <link type="text/css" href="/design/module/sample/css/style.css" rel="stylesheet" />
<div id="place001-2">
		<div class="slide-images-001">
		<ul class="slide_list">
			<li><img src="/design/module/sample/img/slide_img_001.jpg" alt="" /></li>
			<!--<li><img src="/design/module/sample/img/slide_img_002.jpg" alt="" /></li>-->
		</ul>
		<a href="#" class="slide_prev">
			<img src="/design/module/sample/img/slideprev.png" alt="" />
		</a>
		<a href="#" class="slide_next">
			<img src="/design/module/sample/img/slidenext.png" alt="" />
		</a>
	 </div>
	</div>
		
	<div id="place002">
		<div class="news-area-001">
		<h3 class="main_sub">공지사항</h3>
		<p class="main_copy">면접결과와 합격자발표 확인하세요.</p>
		<ul class="news_list">
			<li>
				<a href="#">2016년 하반기 동계 인턴십/SPEC태클/외국인유학생..</a>
				<span class="date">2016.11.30</span>
			</li>
			<li>
				<a href="#">2016년 하반기 신입사원/장애인 특별채용 면접전형 결..</a>
				<span class="date">2016.11.23</span>
			</li>
			<li>
				<a href="#">2016년 하반기 롯데 SPEC태클 오디션 / 동계 인..</a>
				<span class="date">2016.11.14</span>
			</li>
		</ul>
		<a class="news_plus" href="#">
			<img class="plus" src="/design/module/sample/img/plus.png" alt="<spring:message code="wzwg.cmm.word.plus" />" />
			<span class="more"><spring:message code="wzwg.cmm.word.more" /></span>
		</a>
	 </div>
	</div>

	<div id="place003">
		<div class="event-area-001">
			<h3 class="main_sub">이벤트</h3>
			<ul class="event_list">
				<li>
					<a href="#"><img class="move" src="/design/module/sample/img/img001.jpg" alt="" /></a>
					<span class="event_txt"><a href="#">2016 하반기 동계</a></span>
				</li>
				<li>
					<a href="#"><img class="move" src="/design/module/sample/img/img001.jpg" alt="" /></a>
					<span class="event_txt"><a href="#">2016 하반기 동계</a></span>
				</li>
			</ul>
			<a class="event_plus" href="#">
				<span class="more"><spring:message code="wzwg.cmm.word.more" /></span>
			</a>
		</div>
	</div>

	<div id="place004">
		 <div class="footer-list-001">
		   <div class="footer-center-001">
			<ul>
				<li><a href="#">회사소개</a></li>
				<li><a href="#">이용약관</a></li>
				<li><a href="#">개인정보처리방침</a></li>
				<li><a href="#">협력사여러분</a></li>
				<li><a href="#">제휴 도서홍보</a></li>
				<li><a href="#">광고센터</a></li>
				<li><a href="#">채용정보</a></li>
				<li><a href="#">서비스 전체보기</a></li>
			</ul>
		   </div>
		</div> 
	</div>

	<div id="place004-1">
		<div class="calendar-001">	
		<h3 class="cal_sub"><spring:message code="wzwg.cmm.word.cldr" /></h3>
		<div class="cal_center">
			<a href="#">&lt;</a>
			<span class="date_txt">2017-01</span>
			<a href="#">&gt;</a>
		</div>
		<table class="cal_date">
			<thead>
				<tr class="dateTop">
					<th><a href="#">S</a></th>
					<th><a href="#">M</a></th>
					<th><a href="#">T</a></th>
					<th><a href="#">W</a></th>
					<th><a href="#">T</a></th>
					<th><a href="#">F</a></th>
					<th><a href="#">S</a></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th><a href="#">01</a></th>
					<th><a href="#">02</a></th>
					<th><a href="#">03</a></th>
					<th><a href="#">04</a></th>
					<th><a href="#" class="dateOn">05</a></th>
					<th><a href="#">06</a></th>
					<th><a href="#">07</a></th>
				</tr>
				<tr>
					<th><a href="#">08</a></th>
					<th><a href="#">09</a></th>
					<th><a href="#">10</a></th>
					<th><a href="#">11</a></th>
					<th><a href="#">12</a></th>
					<th><a href="#">13</a></th>
					<th><a href="#">14</a></th>
				</tr>
				<tr>
					<th><a href="#">15</a></th>
					<th><a href="#">16</a></th>
					<th><a href="#">17</a></th>
					<th><a href="#">18</a></th>
					<th><a href="#">19</a></th>
					<th><a href="#">20</a></th>
					<th><a href="#">21</a></th>
				</tr>
				<tr>
					<th><a href="#">22</a></th>
					<th><a href="#">23</a></th>
					<th><a href="#">24</a></th>
					<th><a href="#">25</a></th>
					<th><a href="#">26</a></th>
					<th><a href="#">27</a></th>
					<th><a href="#">28</a></th>
				</tr>
				<tr>
					<th><a href="#">29</a></th>
					<th><a href="#">30</a></th>
					<th><a href="#">31</a></th>
					<th><a href="#" class="noneColor">1</a></th>
					<th><a href="#" class="noneColor">2</a></th>
					<th><a href="#" class="noneColor">3</a></th>
					<th><a href="#" class="noneColor">4</a></th>
				</tr>
			</tbody>
		</table>
	</div>
	</div>
	
	<div id="place004-2">
		<div class="board-area-001">
			<h3 class="board_sub"><spring:message code="wzwg.cmm.word.banner" /></h3>
			<ul class="board_list">
				<li>
					<a href="#"><img class="move" src="/design/module/sample/img/borad001.jpg" alt="" /></a>
					<a href="#"><span class="board_txt">Music playground.<br/>
					Vinyl & plastic by hynudai card</span></a>
				</li>
			</ul>
			<a href="#" class="board_plus">
				<span><spring:message code="wzwg.cmm.word.more" /></span>
			</a>
	    </div>
	</div>


	<div id="place004-3">
			<div class="site-ft-001">
			 <div class="site_inner">
				<ul>
					<li><a href="#">
						<img src="/design/module/sample/img/site_logo_001.png" alt="" />
					</a></li>
					<li><a href="#">
						<img src="/design/module/sample/img/site_logo_001.png" alt="" />
					</a></li>
					<li><a href="#">
						<img src="/design/module/sample/img/site_logo_001.png" alt="" />
					</a></li>
					<li><a href="#">
						<img src="/design/module/sample/img/site_logo_001.png" alt="" />
					</a></li>
					<li><a href="#">
						<img src="/design/module/sample/img/site_logo_001.png" alt="" />
					</a></li>
					<li><a href="#">
						<img src="/design/module/sample/img/site_logo_001.png" alt="" />
					</a></li>
				 </ul>
				<a href="#" class="fb_prev">
					<img src="/design/module/sample/img/siteprev.png" alt="" />
				</a>
				<a href="#" class="fb_next">
					<img src="/design/module/sample/img/sitenext.png" alt="" />
				</a>
		    </div>
		  </div> 
	</div>

</div>
<c:import url="${footerUrl}"></c:import>