<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags" %>
<%-- 

<c:set var="textColorPalette">
        <div class="bg_palette_area">
          <span class="list_tit"><spring:message code="wzwg.cmm.word.recent" /></span>
          <ul class="bg_palette basicEditorTextUseColors">
          	<li></li>
          </ul>
        </div>

        <div class="bg_palette_area">
          <span class="list_tit"><spring:message code="wzwg.cmm.word.recomend" /></span>
          <ul class="bg_palette col2">
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#c80000'); basicEditorTxtPalette('red'); basicEditorTxtUseCol('c80000');" data-color="#c80000">
              	<label for="" class="inp_c80000"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#e64856'); basicEditorTxtPalette('pink'); basicEditorTxtUseCol('e64856');" data-color="#e64856">
              	<label for="" class="inp_e64856"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#f7630d'); basicEditorTxtPalette('orange'); basicEditorTxtUseCol('f7630d');" data-color="#f7630d">
              	<label for="" class="inp_f7630d"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#efc127'); basicEditorTxtPalette('yellow'); basicEditorTxtUseCol('efc127');" data-color="#efc127">
              	<label for="" class="inp_efc127"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#4a8205'); basicEditorTxtPalette('green'); basicEditorTxtUseCol('4a8205');" data-color="#4a8205">
              	<label for="" class="inp_4a8205"></label>
              </button>
            </li>
          </ul>
          <ul class="bg_palette col2">
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#0b56a7'); basicEditorTxtPalette('blue'); basicEditorTxtUseCol('0b56a7');" data-color="#0b56a7">
              	<label for="" class="inp_0b56a7"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#8d47ad'); basicEditorTxtPalette('purple'); basicEditorTxtUseCol('8d47ad');" data-color="#8d47ad">
              	<label for="" class="inp_8d47ad"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#343434'); basicEditorTxtPalette('black'); basicEditorTxtUseCol('333333');" data-color="#343434">
              	<label for="" class="inp_333333"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#a1a1a1'); basicEditorTxtPalette('grey'); basicEditorTxtUseCol('a1a1a1');" data-color="#a1a1a1">
              	<label for="" class="inp_a1a1a1"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#ffffff'); basicEditorTxtPalette('white-grey'); basicEditorTxtUseCol('ffffff');" data-color="#ffffff">
              	<label for="" class="inp_ffffff"></label>
              </button>
            </li>
          </ul>
        </div>




        <div class="bg_palette_area txt_palette_area" style="display: block;">
          <span class="list_tit"><spring:message code="wzwg.cmm.word.shdw" /></span>
          <ul class="bg_palette" id="txt_palette_trans_red">
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#eee4e4'); basicEditorTxtUseCol('eee4e4');" data-color="#eee4e4">
              	<label for="" class="inp_eee4e4"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#fbd5d5'); basicEditorTxtUseCol('fbd5d5');" data-color="#fbd5d5">
              	<label for="" class="inp_fbd5d5"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#f7acac'); basicEditorTxtUseCol('f7acac');" data-color="#f7acac">
              	<label for="" class="inp_f7acac"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#ef5658'); basicEditorTxtUseCol('ef5658');" data-color="#ef5658">
              	<label for="" class="inp_ef5658"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#ce1313'); basicEditorTxtUseCol('ce1313');" data-color="#ce1313">
              	<label for="" class="inp_ce1313"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#830b0b'); basicEditorTxtUseCol('830b0b');" data-color="#830b0b">
              	<label for="" class="inp_830b0b"></label>
              </button>
            </li>
          </ul>
          
          
          <ul class="bg_palette" id="txt_palette_trans_pink" style="display: none;">
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#f0e7ec'); basicEditorTxtUseCol('f0e7ec');" data-color="#f0e7ec">
              	<label for="" class="inp_f0e7ec"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#f8c3c5'); basicEditorTxtUseCol('f8c3c5');" data-color="#f8c3c5">
              	<label for="" class="inp_f8c3c5"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#f9a7ab'); basicEditorTxtUseCol('f9a7ab');" data-color="#f9a7ab">
              	<label for="" class="inp_f9a7ab"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#f28183'); basicEditorTxtUseCol('f28183');" data-color="#f28183">
              	<label for="" class="inp_f28183"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#ea2364'); basicEditorTxtUseCol('ea2364');" data-color="#ea2364">
              	<label for="" class="inp_ea2364"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#c40052'); basicEditorTxtUseCol('c40052');" data-color="#c40052">
              	<label for="" class="inp_c40052"></label>
              </button>
            </li>
          </ul>
          
          
          <ul class="bg_palette" id="txt_palette_trans_orange" style="display: none;">
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#fdf0e7'); basicEditorTxtUseCol('fdf0e7');" data-color="#fdf0e7">
              	<label for="" class="inp_fdf0e7"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#f4dac7'); basicEditorTxtUseCol('f4dac7');" data-color="#f4dac7">
              	<label for="" class="inp_f4dac7"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#f7cbac'); basicEditorTxtUseCol('f7cbac');" data-color="#f7cbac">
              	<label for="" class="inp_f7cbac"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#f4b183'); basicEditorTxtUseCol('f4b183');" data-color="#f4b183">
              	<label for="" class="inp_f4b183"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#d96a1e'); basicEditorTxtUseCol('d96a1e');" data-color="#d96a1e">
              	<label for="" class="inp_d96a1e"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#833c0b'); basicEditorTxtUseCol('833c0b');" data-color="#833c0b">
              	<label for="" class="inp_833c0b"></label>
              </button>
            </li>
          </ul>
          
          
          <ul class="bg_palette" id="txt_palette_trans_yellow" style="display: none;">
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#fcf8eb'); basicEditorTxtUseCol('fcf8eb');" data-color="#fcf8eb">
              	<label for="" class="inp_fcf8eb"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#fff2cc'); basicEditorTxtUseCol('fff2cc');" data-color="#fff2cc">
              	<label for="" class="inp_fff2cc"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#f1d88c'); basicEditorTxtUseCol('f1d88c');" data-color="#f1d88c">
              	<label for="" class="inp_f1d88c"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#e3bb43'); basicEditorTxtUseCol('e3bb43');" data-color="#e3bb43">
              	<label for="" class="inp_e3bb43"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#bf9000'); basicEditorTxtUseCol('bf9000');" data-color="#bf9000">
              	<label for="" class="inp_bf9000"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#7f6000'); basicEditorTxtUseCol('7f6000');" data-color="#7f6000">
              	<label for="" class="inp_7f6000"></label>
              </button>
            </li>
          </ul>
          
          
          <ul class="bg_palette" id="txt_palette_trans_green" style="display: none;">
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#f1f8ec'); basicEditorTxtUseCol('f1f8ec');" data-color="#f1f8ec">
              	<label for="" class="inp_f1f8ec"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#c5e0b3'); basicEditorTxtUseCol('c5e0b3');" data-color="#c5e0b3">
              	<label for="" class="inp_c5e0b3"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#8ebf6d'); basicEditorTxtUseCol('8ebf6d');" data-color="#8ebf6d">
              	<label for="" class="inp_8ebf6d"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#64a13c'); basicEditorTxtUseCol('64a13c');" data-color="#64a13c">
              	<label for="" class="inp_64a13c"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#538135'); basicEditorTxtUseCol('538135');" data-color="#538135">
              	<label for="" class="inp_538135"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#375623'); basicEditorTxtUseCol('375623');" data-color="#375623">
              	<label for="" class="inp_375623"></label>
              </button>
            </li>
          </ul>
          
          
          <ul class="bg_palette" id="txt_palette_trans_blue" style="display: none;">
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#d6dce4'); basicEditorTxtUseCol('d6dce4');" data-color="#d6dce4">
              	<label for="" class="inp_d6dce4"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#adb9ca'); basicEditorTxtUseCol('adb9ca');" data-color="#adb9ca">
              	<label for="" class="inp_adb9ca"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#8eaadb'); basicEditorTxtUseCol('8eaadb');" data-color="#8eaadb">
              	<label for="" class="inp_8eaadb"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#2f5496'); basicEditorTxtUseCol('2f5496');" data-color="#2f5496">
              	<label for="" class="inp_2f5496"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#323f4f'); basicEditorTxtUseCol('323f4f');" data-color="#323f4f">
              	<label for="" class="inp_323f4f"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#222a35'); basicEditorTxtUseCol('222a35');" data-color="#222a35">
              	<label for="" class="inp_222a35"></label>
              </button>
            </li>
          </ul>
          
          
          <ul class="bg_palette" id="txt_palette_trans_purple" style="display: none;">
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#ebdef6'); basicEditorTxtUseCol('ebdef6');" data-color="#ebdef6">
              	<label for="" class="inp_ebdef6"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#bb97c7'); basicEditorTxtUseCol('bb97c7');" data-color="#bb97c7">
              	<label for="" class="inp_bb97c7"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#9a6baf'); basicEditorTxtUseCol('9a6baf');" data-color="#9a6baf">
              	<label for="" class="inp_9a6baf"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#824f9e'); basicEditorTxtUseCol('824f9e');" data-color="824f9e">
              	<label for="" class="inp_824f9e"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#872eb5'); basicEditorTxtUseCol('872eb5');" data-color="#872eb5">
              	<label for="" class="inp_872eb5"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#581f79'); basicEditorTxtUseCol('581f79');" data-color="#581f79">
              	<label for="" class="inp_581f79"></label>
              </button>
            </li>
          </ul>
          
          
          <ul class="bg_palette" id="txt_palette_trans_grey" style="display: none;">
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#d0cece'); basicEditorTxtUseCol('d0cece');" data-color="#d0cece">
              	<label for="" class="inp_d0cece"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#bbbbbb'); basicEditorTxtUseCol('bbbbbb');" data-color="#bbbbbb">
              	<label for="" class="inp_bbbbbb"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#aeabab'); basicEditorTxtUseCol('aeabab');" data-color="#aeabab">
              	<label for="" class="inp_aeabab"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#757070'); basicEditorTxtUseCol('757070');" data-color="#757070">
              	<label for="" class="inp_757070"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#3a3838'); basicEditorTxtUseCol('3a3838');" data-color="#3a3838">
              	<label for="" class="inp_3a3838"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#171616'); basicEditorTxtUseCol('171616');" data-color="#171616">
              	<label for="" class="inp_171616"></label>
              </button>
            </li>
          </ul>
          
          
          <ul class="bg_palette" id="txt_palette_trans_white-grey" style="display: none;">
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#f2f2f2'); basicEditorTxtUseCol('f2f2f2');" data-color="#f2f2f2">
              	<label for="" class="inp_f2f2f2"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#d8d8d8'); basicEditorTxtUseCol('d8d8d8');" data-color="#d8d8d8">
              	<label for="" class="inp_d8d8d8"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#bfbfbf'); basicEditorTxtUseCol('bfbfbf');" data-color="#bfbfbf">
              	<label for="" class="inp_bfbfbf"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#a5a5a5'); basicEditorTxtUseCol('a5a5a5');" data-color="#a5a5a5">
              	<label for="txt_a5a5a5" class="inp_a5a5a5"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#7f7f7f'); basicEditorTxtUseCol('7f7f7f');" data-color="#7f7f7f">
              	<label for="" class="inp_7f7f7f"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#707070'); basicEditorTxtUseCol('707070');" data-color="#707070">
              	<label for="" class="inp_707070"></label>
              </button>
            </li>
          </ul>
          
          
          <ul class="bg_palette" id="txt_palette_trans_black" style="display: none;">
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#666666'); basicEditorTxtUseCol('666666');" data-color="#666666">
              	<label for="" class="inp_666666"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#595959'); basicEditorTxtUseCol('595959');" data-color="#595959">
              	<label for="" class="inp_595959"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#3f3f3f'); basicEditorTxtUseCol('3f3f3f');" data-color="#3f3f3f">
              	<label for="" class="inp_3f3f3f"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#262626'); basicEditorTxtUseCol('262626');" data-color="#262626">
              	<label for="" class="inp_262626"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#212121'); basicEditorTxtUseCol('212121');" data-color="#212121">
              	<label for="" class="inp_212121"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="callTextEditorCommand('foreColor','#000000'); basicEditorTxtUseCol('000000');" data-color="#000000">
              	<label for="" class="inp_000000"></label>
              </button>
            </li>
          </ul>
        </div>

        <div class="bg_palette_area">
          <span class="list_tit code"><spring:message code="wzwg.cmm.word.code" /></span>
          <input type="text" id="basicEditorTxtCustomCode" class="code_num" name="code_num" value="" placeholder="#aabbcc">
          <label for="code_num"></label>
          <button type="button" class="btn_apply" onclick="basicEditorTxtCustomCol()"><spring:message code="wzwg.cmm.word.applc" /></button>
        </div>

        <!-- <div class="bg_palette_area">
          <button type="button" class="btn_templt" onclick="basicEditorTxtDefault()"><spring:message code="wzwg.cmm.word.scrin.templtDefault" /></button>
        </div> -->
</c:set> --%>






















<c:set var="bgColorPalette">
	<div id="basicEditorBgPalette">
        <div class="bg_palette_area">
          <span class="list_tit"><spring:message code="wzwg.cmm.word.recent" /></span>
          <ul class="bg_palette" id="basicEditorBgUseColors">
          	<li style="height: 30px;"></li>
          </ul>
        </div>

        <div class="bg_palette_area">
          <span class="list_tit"><spring:message code="wzwg.cmm.word.recomend" /></span>
          <ul class="bg_palette col2">
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgPalette('red'); basicEditorBgUseCol('c80000');" data-color="#c80000">
              	<input type="radio" id="bg_c80000" name="bg_rcmd" value=""  checked="">
              	<label for="bg_c80000" class="inp_c80000"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgPalette('pink'); basicEditorBgUseCol('e64856');" data-color="#e64856">
              	<input type="radio" id="bg_e64856" name="bg_rcmd" value="" >
              	<label for="bg_e64856" class="inp_e64856"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgPalette('orange'); basicEditorBgUseCol('f7630d');" data-color="#f7630d">
              	<input type="radio" id="bg_f7630d" name="bg_rcmd" value="" >
              	<label for="bg_f7630d" class="inp_f7630d"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgPalette('yellow'); basicEditorBgUseCol('efc127');" data-color="#efc127">
              	<input type="radio" id="bg_efc127" name="bg_rcmd" value="" >
              	<label for="bg_efc127" class="inp_efc127"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgPalette('green'); basicEditorBgUseCol('4a8205');" data-color="#4a8205">
              	<input type="radio" id="bg_4a8205" name="bg_rcmd" value="" >
              	<label for="bg_4a8205" class="inp_4a8205"></label>
              </button>
            </li>
          </ul>
          <ul class="bg_palette col2">
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgPalette('blue'); basicEditorBgUseCol('0b56a7');" data-color="#0b56a7">
              	<input type="radio" id="bg_0b56a7" name="bg_rcmd" value="" >
              	<label for="bg_0b56a7" class="inp_0b56a7"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgPalette('purple'); basicEditorBgUseCol('8d47ad');" data-color="#8d47ad">
              	<input type="radio" id="bg_8d47ad" name="bg_rcmd" value="" >
              	<label for="bg_8d47ad" class="inp_8d47ad"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgPalette('black'); basicEditorBgUseCol('333333');" data-color="#343434">
              	<input type="radio" id="bg_333333" name="bg_rcmd" value="" >
              	<label for="bg_333333" class="inp_333333"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgPalette('grey'); basicEditorBgUseCol('a1a1a1');" data-color="#a1a1a1">
              	<input type="radio" id="bg_a1a1a1" name="bg_rcmd" value="">
              	<label for="bg_a1a1a1" class="inp_a1a1a1"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgPalette('white-grey'); basicEditorBgUseCol('ffffff');" data-color="#ffffff">
              	<input type="radio" id="bg_ffffff" name="bg_rcmd" value="" >
              	<label for="bg_ffffff" class="inp_ffffff"></label>
              </button>
            </li>
            <li>
            	<button type="button" onclick="addBgColor('rgba(0,0,0,0)');" data-color="rgba(0,0,0,0)">
	                <input type="radio" id="bg_transp" name="bg_rcmd" value="">
	                <label for="bg_transp" class="inp_transp">
	                  <div class="tooltip">
	                    <img src="/images/wzwg/site/mngr/screen/ico_transparent.png" alt="">
	                    <span class="tooltip_txt">색상없음</span>
	                  </div>
	                </label>
                </button>
              </li>
          </ul>
        </div>




        <div class="bg_palette_area bg_palette_trnas_area" style="display: block;">
          <span class="list_tit"><spring:message code="wzwg.cmm.word.shdw" /></span>
          <ul class="bg_palette" id="bg_palette_trans_red">
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('eee4e4');" data-color="#eee4e4">
              	<input type="radio" id="bg_eee4e4" name="rgb_color" value="" >
              	<label for="bg_eee4e4" class="inp_eee4e4"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('fbd5d5');" data-color="#fbd5d5">
              	<input type="radio" id="bg_fbd5d5" name="rgb_color" value="" >
              	<label for="bg_fbd5d5" class="inp_fbd5d5"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('f7acac');" data-color="#f7acac">
              	<input type="radio" id="bg_f7acac" name="rgb_color" value="">
              	<label for="bg_f7acac" class="inp_f7acac"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('ef5658');" data-color="#ef5658">
              	<input type="radio" id="bg_ef5658" name="rgb_color" value="">
              	<label for="bg_ef5658" class="inp_ef5658"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('ce1313');" data-color="#ce1313">
              	<input type="radio" id="bg_ce1313" name="rgb_color" value="">
              	<label for="bg_ce1313" class="inp_ce1313"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('830b0b');" data-color="#830b0b">
              	<input type="radio" id="bg_830b0b" name="rgb_color" value="">
              	<label for="bg_830b0b" class="inp_830b0b"></label>
              </button>
            </li>
          </ul>
          
          
          <ul class="bg_palette" id="bg_palette_trans_pink" style="display: none;">
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('f0e7ec');" data-color="#f0e7ec">
              	<input type="radio" id="bg_f0e7ec" name="rgb_color" value=""  checked="">
              	<label for="bg_f0e7ec" class="inp_f0e7ec"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('f8c3c5');" data-color="#f8c3c5">
              	<input type="radio" id="bg_f8c3c5" name="rgb_color" value="" >
              	<label for="bg_f8c3c5" class="inp_f8c3c5"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('f9a7ab');" data-color="#f9a7ab">
              	<input type="radio" id="bg_f9a7ab" name="rgb_color" value="" >
              	<label for="bg_f9a7ab" class="inp_f9a7ab"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('f28183');" data-color="#f28183">
              	<input type="radio" id="bg_f28183" name="rgb_color" value="">
              	<label for="bg_f28183" class="inp_f28183"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('ea2364');" data-color="#ea2364">
              	<input type="radio" id="bg_ea2364" name="rgb_color" value="">
              	<label for="bg_ea2364" class="inp_ea2364"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('c40052');" data-color="#c40052">
              	<input type="radio" id="bg_c40052" name="rgb_color" value="">
              	<label for="bg_c40052" class="inp_c40052"></label>
              </button>
            </li>
          </ul>
          
          
          <ul class="bg_palette" id="bg_palette_trans_orange" style="display: none;">
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('fdf0e7');" data-color="#fdf0e7">
              	<input type="radio" id="bg_fdf0e7" name="rgb_color" value=""  checked="">
              	<label for="bg_fdf0e7" class="inp_fdf0e7"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('f4dac7');" data-color="#f4dac7">
              	<input type="radio" id="bg_f4dac7" name="rgb_color" value="" >
              	<label for="bg_f4dac7" class="inp_f4dac7"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('f7cbac');" data-color="#f7cbac">
              	<input type="radio" id="bg_f7cbac" name="rgb_color" value="" >
              	<label for="bg_f7cbac" class="inp_f7cbac"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('f4b183');" data-color="#f4b183">
              	<input type="radio" id="bg_f4b183" name="rgb_color" value="">
              	<label for="bg_f4b183" class="inp_f4b183"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('d96a1e');" data-color="#d96a1e">
              	<input type="radio" id="bg_d96a1e" name="rgb_color" value="">
              	<label for="bg_d96a1e" class="inp_d96a1e"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('833c0b');" data-color="#833c0b">
              	<input type="radio" id="bg_833c0b" name="rgb_color" value="">
              	<label for="bg_833c0b" class="inp_833c0b"></label>
              </button>
            </li>
          </ul>
          
          
          <ul class="bg_palette" id="bg_palette_trans_yellow" style="display: none;">
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('fcf8eb');" data-color="#fcf8eb">
              	<input type="radio" id="bg_fcf8eb" name="rgb_color" value=""  checked="">
              	<label for="bg_fcf8eb" class="inp_fcf8eb"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('fff2cc');" data-color="#fff2cc">
              	<input type="radio" id="bg_fff2cc" name="rgb_color" value="" >
              	<label for="bg_fff2cc" class="inp_fff2cc"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('f1d88c');" data-color="#f1d88c">
              	<input type="radio" id="bg_f1d88c" name="rgb_color" value="" >
              	<label for="bg_f1d88c" class="inp_f1d88c"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('e3bb43');" data-color="#e3bb43">
              	<input type="radio" id="bg_e3bb43" name="rgb_color" value="">
              	<label for="bg_e3bb43" class="inp_e3bb43"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('bf9000');" data-color="#bf9000">
              	<input type="radio" id="bg_bf9000" name="rgb_color" value="">
              	<label for="bg_bf9000" class="inp_bf9000"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('7f6000');" data-color="#7f6000">
              	<input type="radio" id="bg_7f6000" name="rgb_color" value="">
              	<label for="bg_7f6000" class="inp_7f6000"></label>
              </button>
            </li>
          </ul>
          
          
          <ul class="bg_palette" id="bg_palette_trans_green" style="display: none;">
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('f1f8ec');" data-color="#f1f8ec">
              	<input type="radio" id="bg_f1f8ec" name="rgb_color" value=""  checked="">
              	<label for="bg_f1f8ec" class="inp_f1f8ec"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('c5e0b3');" data-color="#c5e0b3">
              	<input type="radio" id="bg_c5e0b3" name="rgb_color" value="" >
              	<label for="bg_c5e0b3" class="inp_c5e0b3"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('8ebf6d');" data-color="#8ebf6d">
              	<input type="radio" id="bg_8ebf6d" name="rgb_color" value="" >
              	<label for="bg_8ebf6d" class="inp_8ebf6d"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('64a13c');" data-color="#64a13c">
              	<input type="radio" id="bg_64a13c" name="rgb_color" value="">
              	<label for="bg_64a13c" class="inp_64a13c"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('538135');" data-color="#538135">
              	<input type="radio" id="bg_538135" name="rgb_color" value="">
              	<label for="bg_538135" class="inp_538135"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('375623');" data-color="#375623">
              	<input type="radio" id="bg_375623" name="rgb_color" value="">
              	<label for="bg_375623" class="inp_375623"></label>
              </button>
            </li>
          </ul>
          
          
          <ul class="bg_palette" id="bg_palette_trans_blue" style="display: none;">
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('d6dce4');" data-color="#d6dce4">
              	<input type="radio" id="bg_d6dce4" name="rgb_color" value=""  checked="">
              	<label for="bg_d6dce4" class="inp_d6dce4"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('adb9ca');" data-color="#adb9ca">
              	<input type="radio" id="bg_adb9ca" name="rgb_color" value="" >
              	<label for="bg_adb9ca" class="inp_adb9ca"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('8eaadb');" data-color="#8eaadb">
              	<input type="radio" id="bg_8eaadb" name="rgb_color" value="" >
              	<label for="bg_8eaadb" class="inp_8eaadb"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('2f5496');" data-color="#2f5496">
              	<input type="radio" id="bg_2f5496" name="rgb_color" value="">
              	<label for="bg_2f5496" class="inp_2f5496"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('323f4f');" data-color="#323f4f">
              	<input type="radio" id="bg_323f4f" name="rgb_color" value="">
              	<label for="bg_323f4f" class="inp_323f4f"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('222a35');" data-color="#222a35">
              	<input type="radio" id="bg_222a35" name="rgb_color" value="">
              	<label for="bg_222a35" class="inp_222a35"></label>
              </button>
            </li>
          </ul>
          
          
          <ul class="bg_palette" id="bg_palette_trans_purple" style="display: none;">
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('ebdef6');" data-color="#ebdef6">
              	<input type="radio" id="bg_ebdef6" name="rgb_color" value=""  checked="">
              	<label for="bg_ebdef6" class="inp_ebdef6"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('bb97c7');" data-color="#bb97c7">
              	<input type="radio" id="bg_bb97c7" name="rgb_color" value="" >
              	<label for="bg_bb97c7" class="inp_bb97c7"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('9a6baf');" data-color="#9a6baf">
              	<input type="radio" id="bg_9a6baf" name="rgb_color" value="" >
              	<label for="bg_9a6baf" class="inp_9a6baf"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('824f9e');" data-color="824f9e">
              	<input type="radio" id="bg_824f9e" name="rgb_color" value="">
              	<label for="bg_824f9e" class="inp_824f9e"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('872eb5');" data-color="#872eb5">
              	<input type="radio" id="bg_872eb5" name="rgb_color" value="">
              	<label for="bg_872eb5" class="inp_872eb5"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('581f79');" data-color="#581f79">
              	<input type="radio" id="bg_581f79" name="rgb_color" value="">
              	<label for="bg_581f79" class="inp_581f79"></label>
              </button>
            </li>
          </ul>
          
          
          <ul class="bg_palette" id="bg_palette_trans_grey" style="display: none;">
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('d0cece');" data-color="#d0cece">
              	<input type="radio" id="bg_d0cece" name="rgb_color" value=""  checked="">
              	<label for="bg_d0cece" class="inp_d0cece"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('bbbbbb');" data-color="#bbbbbb">
              	<input type="radio" id="bg_bbbbbb" name="rgb_color" value="" >
              	<label for="bg_bbbbbb" class="inp_bbbbbb"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('aeabab');" data-color="#aeabab">
              	<input type="radio" id="bg_aeabab" name="rgb_color" value="" >
              	<label for="bg_aeabab" class="inp_aeabab"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('757070');" data-color="#757070">
              	<input type="radio" id="bg_757070" name="rgb_color" value="">
              	<label for="bg_757070" class="inp_757070"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('3a3838');" data-color="#3a3838">
              	<input type="radio" id="bg_3a3838" name="rgb_color" value="">
              	<label for="bg_3a3838" class="inp_3a3838"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('171616');" data-color="#171616">
              	<input type="radio" id="bg_171616" name="rgb_color" value="">
              	<label for="bg_171616" class="inp_171616"></label>
              </button>
            </li>
          </ul>
          
          
          <ul class="bg_palette" id="bg_palette_trans_white-grey" style="display: none;">
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('f2f2f2');" data-color="#f2f2f2">
              	<input type="radio" id="bg_f2f2f2" name="rgb_color" value=""  checked="">
              	<label for="bg_f2f2f2" class="inp_f2f2f2"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('d8d8d8');" data-color="#d8d8d8">
              	<input type="radio" id="bg_d8d8d8" name="rgb_color" value="" >
              	<label for="bg_d8d8d8" class="inp_d8d8d8"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('bfbfbf');" data-color="#bfbfbf">
              	<input type="radio" id="bg_bfbfbf" name="rgb_color" value="" >
              	<label for="bg_bfbfbf" class="inp_bfbfbf"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('a5a5a5');" data-color="#a5a5a5">
              	<input type="radio" id="bg_a5a5a5" name="rgb_color" value="">
              	<label for="bg_a5a5a5" class="inp_a5a5a5"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('7f7f7f');" data-color="#7f7f7f">
              	<input type="radio" id="bg_7f7f7f" name="rgb_color" value="">
              	<label for="bg_7f7f7f" class="inp_7f7f7f"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('707070');" data-color="#707070">
              	<input type="radio" id="bg_707070" name="rgb_color" value="">
              	<label for="bg_707070" class="inp_707070"></label>
              </button>
            </li>
          </ul>
          
          
          <ul class="bg_palette" id="bg_palette_trans_black" style="display: none;">
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('666666');" data-color="#666666">
              	<input type="radio" id="bg_666666" name="rgb_color" value=""  checked="">
              	<label for="bg_666666" class="inp_666666"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('595959');" data-color="#595959">
              	<input type="radio" id="bg_595959" name="rgb_color" value="" >
              	<label for="bg_595959" class="inp_595959"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('3f3f3f');" data-color="#3f3f3f">
              	<input type="radio" id="bg_3f3f3f" name="rgb_color" value="" >
              	<label for="bg_3f3f3f" class="inp_3f3f3f"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('262626');" data-color="#262626">
              	<input type="radio" id="bg_262626" name="rgb_color" value="">
              	<label for="bg_262626" class="inp_262626"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('212121');" data-color="#212121">
              	<input type="radio" id="bg_212121" name="rgb_color" value="">
              	<label for="bg_212121" class="inp_212121"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addBgColor($(this).attr('data-color')); basicEditorBgUseCol('000000');" data-color="#000000">
              	<input type="radio" id="bg_000000" name="rgb_color" value="">
              	<label for="bg_000000" class="inp_000000"></label>
              </button>
            </li>
          </ul>
        </div>

        <div class="bg_palette_area">
          <span class="list_tit code"><spring:message code="wzwg.cmm.word.code" /></span>
          <input type="text" id="basicEditorBgCustomCode" class="code_num" name="code_num" value="" placeholder="#aabbcc" style="width: 160px">
          <label for="code_num"></label>
          <button type="button" class="btn_apply" onclick="basicEditorBgCustomCol()"><spring:message code="wzwg.cmm.word.applc" /></button>
        </div>

        <!-- <div class="bg_palette_area">
          <button type="button" class="btn_templt" onclick="basicEditorTxtDefault()"><spring:message code="wzwg.cmm.word.scrin.templtDefault" /></button>
        </div> -->
      </div>
</c:set>


	<div id="imgLinkDiv" title="<spring:message code="wzwg.cmm.word.scrin.imgLink" />" style="z-index: 999;" class="ui-dialog-content ui-widget-content">
		<p>
			<input type="text" name="imgLink" id="imgLink" />
		</p>
		<a href="javascript:;" class="ui-button ui-widget ui-corner-all"
			onclick="addImg($('#imgLink').val());"><spring:message code="wzwg.cmm.word.stre" /></a>
	</div>

	<div id="imgLinkSilderDiv" title="<spring:message code="wzwg.cmm.word.scrin.imgLink" />" style="z-index: 999;" class="ui-dialog-content ui-widget-content">
		<p>
			<input type="text" name="imgLinkSilder" id="imgLinkSilder" />
		</p>
		<a href="javascript:;" class="ui-button ui-widget ui-corner-all"
			onclick="addImgSilder($('#imgLinkSilder').val(),selectDiv);"><spring:message code="wzwg.cmm.word.stre" /></a>
	</div>

	<div id="pickerDiv" title="<spring:message code="wzwg.cmm.word.scrin.colTable" />" style="z-index: 999;">
		<div id="picker"></div>
	</div>
	
	
	<div id="pickerBorderDiv" title="<spring:message code="wzwg.cmm.word.scrin.fontColChg"/>" style="z-index:999;" >
		<div class="pop-notice"><span class="circle_no bg-red-strong">!</span><spring:message code="wzwg.cmm.msg.screen.MSG048" /></div>
		<div class="bg_palette_area">
          <span class="list_tit"><spring:message code="wzwg.cmm.word.recent" /></span>
          <ul class="bg_palette" id="txtColDivUseColors">
          	<li></li> 
          </ul>
        </div>

        <div class="bg_palette_area">
          <span class="list_tit"><spring:message code="wzwg.cmm.word.recomend" /></span>
          <ul class="bg_palette col2">
            <li>
              <button type="button" onclick="changeTxtPalette('red'); addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#c80000">
              	<input type="radio" id="txt_recom_r_1" name="txt_recom_r" value=""  checked="">
              	<label for="txt_recom_r_1" class="inp_c80000"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="changeTxtPalette('pink'); addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#e64856">
              	<input type="radio" id="txt_recom_r_2" name="txt_recom_r" value=""  checked="">
              	<label for="txt_recom_r_2" class="inp_e64856"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="changeTxtPalette('orange'); addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#f7630d">
              	<input type="radio" id="txt_recom_r_3" name="txt_recom_r" value=""  checked="">
              	<label for="txt_recom_r_3" class="inp_f7630d"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="changeTxtPalette('yellow'); addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#efc127">
              	<input type="radio" id="txt_recom_r_4" name="txt_recom_r" value=""  checked="">
              	<label for="txt_recom_r_4" class="inp_efc127"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="changeTxtPalette('green'); addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#4a8205">
              	<input type="radio" id="txt_recom_r_5" name="txt_recom_r" value=""  checked="">
              	<label for="txt_recom_r_5" class="inp_4a8205"></label>
              </button>
            </li>
          </ul>
          <ul class="bg_palette col2">
            <li>
              <button type="button" onclick="changeTxtPalette('blue'); addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#0b56a7">
              	<input type="radio" id="txt_recom_r_6" name="txt_recom_r" value=""  checked="">
              	<label for="txt_recom_r_6" class="inp_0b56a7"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="changeTxtPalette('purple'); addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#8d47ad">
              	<input type="radio" id="txt_recom_r_7" name="txt_recom_r" value=""  checked="">
              	<label for="txt_recom_r_7" class="inp_8d47ad"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="changeTxtPalette('black'); addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#343434">
              	<input type="radio" id="txt_recom_r_8" name="txt_recom_r" value=""  checked="">
              	<label for="txt_recom_r_8" class="inp_333333"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="changeTxtPalette('grey'); addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#a1a1a1">
              	<input type="radio" id="txt_recom_r_9" name="txt_recom_r" value=""  checked="">
              	<label for="txt_recom_r_9" class="inp_a1a1a1"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="changeTxtPalette('white-grey'); addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#ffffff">
              	<input type="radio" id="txt_recom_r_10" name="txt_recom_r" value=""  checked="">
              	<label for="txt_recom_r_10" class="inp_ffffff"></label>
              </button>
            </li>
          </ul>
        </div>




        <div class="bg_palette_area txtColDiv_palette_area" style="display: block;">
          <span class="list_tit"><spring:message code="wzwg.cmm.word.shdw" /></span>
          <ul class="bg_palette" id="txtColDiv_palette_trans_red">
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#eee4e4">
              	<input type="radio" id="txt_trns_bb_1" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_1" class="inp_eee4e4"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#fbd5d5">
              	<input type="radio" id="txt_trns_bb_2" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_2" class="inp_fbd5d5"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#f7acac">
              	<input type="radio" id="txt_trns_bb_3" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_3" class="inp_f7acac"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#ef5658">
              	<input type="radio" id="txt_trns_bb_4" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_4" class="inp_ef5658"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#ce1313">
              	<input type="radio" id="txt_trns_bb_5" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_5" class="inp_ce1313"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#830b0b">
              	<input type="radio" id="txt_trns_bb_6" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_6" class="inp_830b0b"></label>
              </button>
            </li>
          </ul>
          
          
          <ul class="bg_palette" id="txtColDiv_palette_trans_pink" style="display: none;">
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#f0e7ec">
              	<input type="radio" id="txt_trns_bb_7" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_7" class="inp_f0e7ec"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#f8c3c5">
              	<input type="radio" id="txt_trns_bb_8" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_8" class="inp_f8c3c5"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#f9a7ab">
              	<input type="radio" id="txt_trns_bb_9" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_9" class="inp_f9a7ab"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#f28183">
              	<input type="radio" id="txt_trns_bb_10" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_10" class="inp_f28183"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#ea2364">
              	<input type="radio" id="txt_trns_bb_11" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_11" class="inp_ea2364"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#c40052">
              	<input type="radio" id="txt_trns_bb_12" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_12" class="inp_c40052"></label>
              </button>
            </li>
          </ul>
          
          
          <ul class="bg_palette" id="txtColDiv_palette_trans_orange" style="display: none;">
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#fdf0e7">
              	<input type="radio" id="txt_trns_bb_13" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_13" class="inp_fdf0e7"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#f4dac7">
              	<input type="radio" id="txt_trns_bb_14" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_14" class="inp_f4dac7"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#f7cbac">
              	<input type="radio" id="txt_trns_bb_15" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_15" class="inp_f7cbac"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#f4b183">
              	<input type="radio" id="txt_trns_bb_16" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_16" class="inp_f4b183"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#d96a1e">
              	<input type="radio" id="txt_trns_bb_17" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_17" class="inp_d96a1e"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#833c0b">
              	<input type="radio" id="txt_trns_bb_18" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_18" class="inp_833c0b"></label>
              </button>
            </li>
          </ul>
          
          
          <ul class="bg_palette" id="txtColDiv_palette_trans_yellow" style="display: none;">
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#fcf8eb">
              	<input type="radio" id="txt_trns_bb_19" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_19" class="inp_fcf8eb"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#fff2cc">
              	<input type="radio" id="txt_trns_bb_20" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_20" class="inp_fff2cc"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#f1d88c">
              	<input type="radio" id="txt_trns_bb_21" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_21" class="inp_f1d88c"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#e3bb43">
              	<input type="radio" id="txt_trns_bb_22" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_22" class="inp_e3bb43"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#bf9000">
              	<input type="radio" id="txt_trns_bb_23" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_23" class="inp_bf9000"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#7f6000">
              	<input type="radio" id="txt_trns_bb_24" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_24" class="inp_7f6000"></label>
              </button>
            </li>
          </ul>
          
          
          <ul class="bg_palette" id="txtColDiv_palette_trans_green" style="display: none;">
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#f1f8ec">
              	<input type="radio" id="txt_trns_bb_25" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_25" class="inp_f1f8ec"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#c5e0b3">
              	<input type="radio" id="txt_trns_bb_26" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_26" class="inp_c5e0b3"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#8ebf6d">
              	<input type="radio" id="txt_trns_bb_27" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_27" class="inp_8ebf6d"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#64a13c">
              	<input type="radio" id="txt_trns_bb_28" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_28" class="inp_64a13c"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#538135">
              	<input type="radio" id="txt_trns_bb_29" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_29" class="inp_538135"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#375623">
              	<input type="radio" id="txt_trns_bb_30" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_30" class="inp_375623"></label>
              </button>
            </li>
          </ul>
          
          
          <ul class="bg_palette" id="txtColDiv_palette_trans_blue" style="display: none;">
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#d6dce4">
              	<input type="radio" id="txt_trns_bb_31" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_31" class="inp_d6dce4"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#adb9ca">
              	<input type="radio" id="txt_trns_bb_32" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_32" class="inp_adb9ca"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#8eaadb">
              	<input type="radio" id="txt_trns_bb_33" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_33" class="inp_8eaadb"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#2f5496">
              	<input type="radio" id="txt_trns_bb_34" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_34" class="inp_2f5496"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#323f4f">
              	<input type="radio" id="txt_trns_bb_35" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_35" class="inp_323f4f"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#222a35">
              	<input type="radio" id="txt_trns_bb_36" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_36" class="inp_222a35"></label>
              </button>
            </li>
          </ul>
          
          
          <ul class="bg_palette" id="txtColDiv_palette_trans_purple" style="display: none;">
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#ebdef6">
              	<input type="radio" id="txt_trns_bb_37" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_37" class="inp_ebdef6"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#bb97c7">
              	<input type="radio" id="txt_trns_bb_38" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_38" class="inp_bb97c7"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#9a6baf">
              	<input type="radio" id="txt_trns_bb_39" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_39" class="inp_9a6baf"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="824f9e">
              	<input type="radio" id="txt_trns_bb_40" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_40" class="inp_824f9e"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#872eb5">
              	<input type="radio" id="txt_trns_bb_41" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_41" class="inp_872eb5"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#581f79">
              	<input type="radio" id="txt_trns_bb_42" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_42" class="inp_581f79"></label>
              </button>
            </li>
          </ul>
          
          
          <ul class="bg_palette" id="txtColDiv_palette_trans_grey" style="display: none;">
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#d0cece">
              	<input type="radio" id="txt_trns_bb_43" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_43" class="inp_d0cece"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#bbbbbb">
              	<input type="radio" id="txt_trns_bb_44" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_44" class="inp_bbbbbb"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#aeabab">
              	<input type="radio" id="txt_trns_bb_45" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_45" class="inp_aeabab"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#757070">
              	<input type="radio" id="txt_trns_bb_46" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_46" class="inp_757070"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#3a3838">
              	<input type="radio" id="txt_trns_bb_47" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_47" class="inp_3a3838"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#171616">
              	<input type="radio" id="txt_trns_bb_48" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_48" class="inp_171616"></label>
              </button>
            </li>
          </ul>
          
          
          <ul class="bg_palette" id="txtColDiv_palette_trans_white-grey" style="display: none;">
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#f2f2f2">
              	<input type="radio" id="txt_trns_bb_49" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_49" class="inp_f2f2f2"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#d8d8d8">
              	<input type="radio" id="txt_trns_bb_50" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_50" class="inp_d8d8d8"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#bfbfbf">
              	<input type="radio" id="txt_trns_bb_51" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_51" class="inp_bfbfbf"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#a5a5a5">
              	<input type="radio" id="txt_trns_bb_52" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_52" class="inp_a5a5a5"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#7f7f7f">
              	<input type="radio" id="txt_trns_bb_53" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_53" class="inp_7f7f7f"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#707070">
              	<input type="radio" id="txt_trns_bb_54" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_54" class="inp_707070"></label>
              </button>
            </li>
          </ul>
          
          
          <ul class="bg_palette" id="txtColDiv_palette_trans_black" style="display: none;">
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#666666">
              	<input type="radio" id="txt_trns_bb_55" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_55" class="inp_666666"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#595959">
              	<input type="radio" id="txt_trns_bb_56" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_56" class="inp_595959"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#3f3f3f">
              	<input type="radio" id="txt_trns_bb_57" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_57" class="inp_3f3f3f"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#262626">
              	<input type="radio" id="txt_trns_bb_58" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_58" class="inp_262626"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#212121">
              	<input type="radio" id="txt_trns_bb_59" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_59" class="inp_212121"></label>
              </button>
            </li>
            <li>
              <button type="button" onclick="addFontColor($(this).attr('data-color')); rememberTxtUseCol($(this).attr('data-color'));" data-color="#000000">
              	<input type="radio" id="txt_trns_bb_60" name="txt_trns_bb" value=""  checked="">
              	<label for="txt_trns_bb_60" class="inp_000000"></label>
              </button>
            </li>
          </ul>
        </div>

        <div class="bg_palette_area">
          <span class="list_tit code"><spring:message code="wzwg.cmm.word.code" /></span>
          <input type="text" id="txtColDivTxtCustomCode" class="code_num" name="code_num" value="" placeholder="#aabbcc">
          <label for="code_num"></label>
          <button type="button" class="btn_apply" onclick="txtColCustomSet()"><spring:message code="wzwg.cmm.word.applc" /></button>
        </div>
	</div>
	<%-- <div id="pickerBorderDiv" title="<spring:message code="wzwg.cmm.word.scrin.fontColChg"/>" style="z-index:999; width:auto; min-height:102px; max-height:none; height:auto;" class="ui-dialog-content ui-widget-content">
		<ul class="ul_font ul_font_basic">
			<li><input type="radio" name="font_color" value="" id="font_color" onclick="addFontColor(fontPickerColor)">
				<label for="font_color">
					<span class="colorbox colorffffff fontCurrColor" style="border:none !important;">
						<div class="colorbox colorffffff fontCurrColor"></div><spring:message code="wzwg.site.screen.msg.MSG054" />
					</span>
				</label>
			</li>
		</ul>

		<p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG041" /> <span><spring:message code="wzwg.cmm.msg.MSG244" /></span></p>
		<ul class="color_pallet">
			<li><!-- 1. black -->
				<ul class="ul_font ul_font_reco">
					<li class="color333333"><input type="radio" name="font_color" value="#343434" id="font_333333" onclick="addFontColor(this.value)"><label for="font_333333">검정색</label></li>

					<li class="color666666"><input type="radio" name="font_color" value="#666666" id="font_666666" onclick="addFontColor(this.value)"><label for="font_666666">#666666</label></li>
					<li class="color595959"><input type="radio" name="font_color" value="#595959" id="font_595959" onclick="addFontColor(this.value)"><label for="font_595959">#595959</label></li>
					<li class="color3f3f3f"><input type="radio" name="font_color" value="#3f3f3f" id="font_3f3f3f" onclick="addFontColor(this.value)"><label for="font_3f3f3f">#3f3f3f</label></li>
					<li class="color262626"><input type="radio" name="font_color" value="#262626" id="font_262626" onclick="addFontColor(this.value)"><label for="font_262626">#262626</label></li>
					<li class="color212121"><input type="radio" name="font_color" value="#212121" id="font_212121" onclick="addFontColor(this.value)"><label for="font_212121">#212121</label></li>
					<li class="color000000"><input type="radio" name="font_color" value="#000000" id="font_000000" onclick="addFontColor(this.value)"><label for="font_000000">#000</label></li>
				</ul>
			</li>
			<li><!-- 2. white-grey -->
				<ul class="ul_font ul_font_reco">
					<li class="colorffffff"><input type="radio" name="font_color" value="#ffffff" id="font_ffffff" onclick="addFontColor(this.value)"><label for="font_ffffff">흰색</label></li>
					<li class="colorf2f2f2"><input type="radio" name="font_color" value="#f2f2f2" id="font_f2f2f2" onclick="addFontColor(this.value)"><label for="font_f2f2f2">#f2f2f2</label></li>
					<li class="colord8d8d8"><input type="radio" name="font_color" value="#d8d8d8" id="font_d8d8d8" onclick="addFontColor(this.value)"><label for="font_d8d8d8">#d8d8d8</label></li>
					<li class="colorbfbfbf"><input type="radio" name="font_color" value="#bfbfbff" id="font_bfbfbf" onclick="addFontColor(this.value)"><label for="font_bfbfbf">#bfbfbf</label></li>
					<li class="colora5a5a5"><input type="radio" name="font_color" value="#a5a5a5" id="font_a5a5a5" onclick="addFontColor(this.value)"><label for="font_a5a5a5">#a5a5a5</label></li>
					<li class="color7f7f7f"><input type="radio" name="font_color" value="#7f7f7f" id="font_7f7f7f" onclick="addFontColor(this.value)"><label for="font_7f7f7f">#7f7f7f</label></li>
					<li class="color707070"><input type="radio" name="font_color" value="#707070" id="font_707070" onclick="addFontColor(this.value)"><label for="font_707070">#707070</label></li>
				</ul>
			</li>
			<li><!-- 3. grey -->
				<ul class="ul_font ul_font_reco">
					<li class="colora1a1a1"><input type="radio" name="font_color" value="#a1a1a1" id="font_a1a1a1" onclick="addFontColor(this.value)"><label for="font_a1a1a1">회색</label></li>
					<li class="colord0cece"><input type="radio" name="font_color" value="#d0cece" id="font_d0cece" onclick="addFontColor(this.value)"><label for="font_d0cece">#d0cece</label></li>
					<li class="colorbbbbbb"><input type="radio" name="font_color" value="#bbbbbb" id="font_bbbbbb" onclick="addFontColor(this.value)"><label for="font_bbbbbb">#bbbbbb</label></li>
					<li class="coloraeabab"><input type="radio" name="font_color" value="#aeabab" id="font_aeabab" onclick="addFontColor(this.value)"><label for="font_aeabab">#aeabab</label></li>
					<li class="color757070"><input type="radio" name="font_color" value="#757070" id="font_757070" onclick="addFontColor(this.value)"><label for="font_757070">#757070</label></li>
					<li class="color3a3838"><input type="radio" name="font_color" value="#3a3838" id="font_3a3838" onclick="addFontColor(this.value)"><label for="font_3a3838">#3a3838</label></li>
					<li class="color171616"><input type="radio" name="font_color" value="#171616" id="font_171616" onclick="addFontColor(this.value)"><label for="font_171616">#171616</label></li>
				</ul>
			</li>

			<li><!-- 4. purple -->
				<ul class="ul_font ul_font_reco">
					<li class="color8d47ad"><input type="radio" name="font_color" value="#8d47ad" id="font_8d47ad" onclick="addFontColor(this.value)"><label for="font_8d47ad">보라색</label></li>
					<li class="colorebdef6"><input type="radio" name="font_color" value="#ebdef6" id="font_ebdef6" onclick="addFontColor(this.value)"><label for="font_ebdef6">#ebdef6</label></li>
					<li class="colorbb97c7"><input type="radio" name="font_color" value="#bb97c7" id="font_bb97c7" onclick="addFontColor(this.value)"><label for="font_bb97c7">#bb97c7</label></li>
					<li class="color9a6baf"><input type="radio" name="font_color" value="#9a6baf" id="font_9a6baf" onclick="addFontColor(this.value)"><label for="font_9a6baf">#9a6baf</label></li>
					<li class="color824f9e"><input type="radio" name="font_color" value="#824f9e" id="font_824f9e" onclick="addFontColor(this.value)"><label for="font_824f9e">#824f9e</label></li>
					<li class="color872eb5"><input type="radio" name="font_color" value="#872eb5" id="font_872eb5" onclick="addFontColor(this.value)"><label for="font_872eb5">#872eb5</label></li>
					<li class="color581f79"><input type="radio" name="font_color" value="#581f79" id="font_581f79" onclick="addFontColor(this.value)"><label for="font_581f79">#581f79</label></li>
				</ul>
			</li>

			<li><!-- 5. blue -->
				<ul class="ul_font ul_font_reco">
					<li class="color0b56a7"><input type="radio" name="font_color" value="#0b56a7" id="font_0b56a7" onclick="addFontColor(this.value)"><label for="font_0b56a7">파랑색</label></li>
					<li class="colord6dce4"><input type="radio" name="font_color" value="#d6dce4" id="font_d6dce4" onclick="addFontColor(this.value)"><label for="font_d6dce4">#d6dce4</label></li>
					<li class="coloradb9ca"><input type="radio" name="font_color" value="#adb9ca" id="font_adb9ca" onclick="addFontColor(this.value)"><label for="font_adb9ca">#adb9ca</label></li>
					<li class="color8eaadb"><input type="radio" name="font_color" value="#8eaadb" id="font_8eaadb" onclick="addFontColor(this.value)"><label for="font_8eaadb">#8eaadb</label></li>
					<li class="color2f5496"><input type="radio" name="font_color" value="#2f5496" id="font_2f5496" onclick="addFontColor(this.value)"><label for="font_2f5496">#2f5496</label></li>
					<li class="color323f4f"><input type="radio" name="font_color" value="#323f4f" id="font_323f4f" onclick="addFontColor(this.value)"><label for="font_323f4f">#323f4f</label></li>
					<li class="color222a35"><input type="radio" name="font_color" value="#222a35" id="font_222a35" onclick="addFontColor(this.value)"><label for="font_222a35">#222a35</label></li>
				</ul>
			</li>
			
			<li><!-- 6. green -->
				<ul class="ul_font ul_font_reco">
					<li class="color4a8205"><input type="radio" name="font_color" value="#4a8205" id="font_4a8205" onclick="addFontColor(this.value)"><label for="font_4a8205">초록색</label></li>
					<li class="colorf1f8ec"><input type="radio" name="font_color" value="#f1f8ec" id="font_f1f8ec" onclick="addFontColor(this.value)"><label for="font_f1f8ec">#f1f8ec</label></li>
					<li class="colorc5e0b3"><input type="radio" name="font_color" value="#c5e0b3" id="font_c5e0b3" onclick="addFontColor(this.value)"><label for="font_c5e0b3">#c5e0b3</label></li>
					<li class="color8ebf6d"><input type="radio" name="font_color" value="#8ebf6d" id="font_8ebf6d" onclick="addFontColor(this.value)"><label for="font_8ebf6d">#8ebf6d</label></li>
					<li class="color64a13c"><input type="radio" name="font_color" value="#64a13c" id="font_64a13c" onclick="addFontColor(this.value)"><label for="font_64a13c">#64a13c</label></li>
					<li class="color538135"><input type="radio" name="font_color" value="#538135" id="font_538135" onclick="addFontColor(this.value)"><label for="font_538135">#538135</label></li>
					<li class="color375623"><input type="radio" name="font_color" value="#375623" id="font_375623" onclick="addFontColor(this.value)"><label for="font_375623">#375623</label></li>
				</ul>
			</li>
			<li><!-- 7. yellow -->
				<ul class="ul_font ul_font_reco">
					<li class="colorefc127"><input type="radio" name="font_color" value="#efc127" id="font_efc127" onclick="addFontColor(this.value)"><label for="font_efc127">노랑색</label></li>
					<li class="colorfcf8eb"><input type="radio" name="font_color" value="#fcf8eb" id="font_fcf8eb" onclick="addFontColor(this.value)"><label for="font_fcf8eb">#fcf8eb</label></li>
					<li class="colorfff2cc"><input type="radio" name="font_color" value="#fff2cc" id="font_fff2cc" onclick="addFontColor(this.value)"><label for="font_fff2cc">#fff2cc</label></li>
					<li class="colorf1d88c"><input type="radio" name="font_color" value="#f1d88c" id="font_f1d88c" onclick="addFontColor(this.value)"><label for="font_f1d88c">#f1d88c</label></li>
					<li class="colore3bb43"><input type="radio" name="font_color" value="#e3bb43" id="font_e3bb43" onclick="addFontColor(this.value)"><label for="font_e3bb43">#e3bb43</label></li>
					<li class="colorbf9000"><input type="radio" name="font_color" value="#bf9000" id="font_bf9000" onclick="addFontColor(this.value)"><label for="font_bf9000">#bf9000</label></li>
					<li class="color7f6000"><input type="radio" name="font_color" value="#7f6000" id="font_7f6000" onclick="addFontColor(this.value)"><label for="font_7f6000">#7f6000</label></li>
				</ul>
			</li>
			<li><!-- 8. orange -->
				<ul class="ul_font ul_font_reco">
					<li class="colorf7630d"><input type="radio" name="font_color" value="#f7630d" id="font_f7630d" onclick="addFontColor(this.value)"><label for="font_f7630d">주황색</label></li>
					<li class="colorfdf0e7"><input type="radio" name="font_color" value="#fdf0e7" id="font_fdf0e7" onclick="addFontColor(this.value)"><label for="font_fdf0e7">#fdf0e7</label></li>
					<li class="colorf4dac7"><input type="radio" name="font_color" value="#f4dac7" id="font_f4dac7" onclick="addFontColor(this.value)"><label for="font_f4dac7">#f4dac7</label></li>
					<li class="colorf7cbac"><input type="radio" name="font_color" value="#f7cbac" id="font_f7cbac" onclick="addFontColor(this.value)"><label for="font_f7cbac">#f7cbac</label></li>
					<li class="colorf4b183"><input type="radio" name="font_color" value="#f4b183" id="font_f4b183" onclick="addFontColor(this.value)"><label for="font_f4b183">#f4b183</label></li>
					<li class="colord96a1e"><input type="radio" name="font_color" value="#d96a1e" id="font_d96a1e" onclick="addFontColor(this.value)"><label for="font_d96a1e">#d96a1e</label></li>
					<li class="color833c0b"><input type="radio" name="font_color" value="#833c0b" id="font_833c0b" onclick="addFontColor(this.value)"><label for="font_833c0b">#833c0b</label></li>
				</ul>
			</li>
			<li><!-- 9.pink -->
				<ul class="ul_font ul_font_reco">
					<li class="colore64856"><input type="radio" name="font_color" value="#e64856" id="font_e64856" onclick="addFontColor(this.value)"><label for="font_e64856">분홍색</label></li>
					<li class="colorf0e7ec"><input type="radio" name="font_color" value="#f0e7ec" id="font_f0e7ec" onclick="addFontColor(this.value)"><label for="font_f0e7ec">#f0e7ec</label></li>
					<li class="colorf8c3c5"><input type="radio" name="font_color" value="#f8c3c5" id="font_f8c3c5" onclick="addFontColor(this.value)"><label for="font_f8c3c5">#f8c3c5</label></li>
					<li class="colorf9a7ab"><input type="radio" name="font_color" value="#f9a7ab" id="font_f9a7ab" onclick="addFontColor(this.value)"><label for="font_f9a7ab">#f9a7ab</label></li>
					<li class="colorf28183"><input type="radio" name="font_color" value="#f28183" id="font_f28183" onclick="addFontColor(this.value)"><label for="font_f28183">#f28183</label></li>
					<li class="colorea2364"><input type="radio" name="font_color" value="#ea2364" id="font_ea2364" onclick="addFontColor(this.value)"><label for="font_ea2364">#ea2364</label></li>
					<li class="colorc40052"><input type="radio" name="font_color" value="#c40052" id="font_c40052" onclick="addFontColor(this.value)"><label for="font_c40052">#c40052</label></li>
				</ul>
			</li>
			<li><!-- 10.red -->
				<ul class="ul_font ul_font_reco">
					<li class="colorc80000"><input type="radio" name="font_color" value="#c80000" id="font_c80000" onclick="addFontColor(this.value)"><label for="font_c80000">빨강색</label></li>
					<li class="coloreee4e4"><input type="radio" name="font_color" value="#eee4e4" id="font_eee4e4" onclick="addFontColor(this.value)"><label for="font_eee4e4">#eee4e4</label></li>
					<li class="colorfbd5d5"><input type="radio" name="font_color" value="#fbd5d5" id="font_fbd5d5" onclick="addFontColor(this.value)"><label for="font_fbd5d5">#fbd5d5</label></li>
					<li class="colorf7acac"><input type="radio" name="font_color" value="#f7acac" id="font_f7acac" onclick="addFontColor(this.value)"><label for="font_f7acac">#f7acac</label></li>
					<li class="coloref5658"><input type="radio" name="font_color" value="#ef5658" id="font_ef5658" onclick="addFontColor(this.value)"><label for="font_ef5658">#ef5658</label></li>
					<li class="colorce1313"><input type="radio" name="font_color" value="#ce1313" id="font_ce1313" onclick="addFontColor(this.value)"><label for="font_ce1313">#ce1313</label></li>
					<li class="color830b0b"><input type="radio" name="font_color" value="#830b0b" id="font_830b0b" onclick="addFontColor(this.value)"><label for="font_830b0b">#830b0b</label></li>
				</ul>
			</li>
		</ul>

		<!-- 자유롭게 색상 선택하기 링크버튼 -->
		<a href="javascript:;" onclick="changeColor()"><span class="choice_btn choice_free"><spring:message code="wzwg.cmm.msg.MSG258" /></span></a>
		<a href="javascript:;" onclick="changeColorCodePopup('fontColor');"><span class="choice_btn choice_code"><spring:message code="wzwg.cmm.msg.MSG259" /></span></a>
	</div> --%>
	

	<%-- <div id="pickerBgDiv" title="<spring:message code="wzwg.cmm.word.scrin.bcrnColChg"/>" style="z-index: 999; width: auto; min-height: 102px; max-height:none; height:auto;" class="ui-dialog-content ui-widget-content">

		<p class="bg_reco"><spring:message code="wzwg.site.screen.msg.MSG055" /> <span><spring:message code="wzwg.cmm.msg.MSG244" /></span></p>
		<ul class="ul_bg ul_bg_basic" style="width: 98%;">
			<li class="colorffffff bgCurrColor" style="background-color: rgb(116, 194, 214);">
				<input type="radio" name="bg_color" value="" id="bg_color" onclick="addBgColor(bgPickerColor)">
				<label title="ffffff" for="bg_color" style="text-shadow: 0px 0px 2px rgba(0,0,0,1);color: #ffffff;"><spring:message code="wzwg.site.screen.msg.MSG054" /></label>
			</li>
			<li class="colorffffff"><input type="radio" name="bg_color" value="#ffffff" id="bg_ffffff" onclick="addBgColor(this.value)"><label title="ffffff" for="bg_ffffff"><spring:message code="wzwg.cmm.word.whiteclr" /></label></li>
			<li class="colorblack fontwhite"><input type="radio" name="bg_color" value="#343434" id="bg_333333" onclick="addBgColor(this.value)"><label title="333333" for="bg_333333"><spring:message code="wzwg.cmm.word.blackclr" /></label></li>
			<li class="colorffffff"><input type="radio" name="bg_color" value="rgba(0,0,0,0)" id="bg_invisible" onclick="addBgColor(this.value)"><label title="333333" for="bg_invisible"><spring:message code="wzwg.cmm.word.trnsprcclr" /></label></li>
		</ul>
		
		<!-- 추천 색상 -->
		<p class="bg_reco"><spring:message code="wzwg.site.screen.msg.MSG041" /> </p>
		<ul class="color_pallet">
			<li><!-- 1. black -->
				<ul class="ul_bg ul_bg_reco">
					<li class="color333333"><input type="radio" name="bg_color" value="#343434" id="bg_333333" onclick="addBgColor(this.value)"><label for="bg_333333">검정색</label></li>
					<li class="color666666"><input type="radio" name="bg_color" value="#666666" id="bg_666666" onclick="addBgColor(this.value)"><label for="bg_666666">#666666</label></li>
					<li class="color595959"><input type="radio" name="bg_color" value="#595959" id="bg_595959" onclick="addBgColor(this.value)"><label for="bg_595959">#595959</label></li>
					<li class="color3f3f3f"><input type="radio" name="bg_color" value="#3f3f3f" id="bg_3f3f3f" onclick="addBgColor(this.value)"><label for="bg_3f3f3f">#3f3f3f</label></li>
					<li class="color262626"><input type="radio" name="bg_color" value="#262626" id="bg_262626" onclick="addBgColor(this.value)"><label for="bg_262626">#262626</label></li>
					<li class="color212121"><input type="radio" name="bg_color" value="#212121" id="bg_212121" onclick="addBgColor(this.value)"><label for="bg_212121">#212121</label></li>
					<li class="color000000"><input type="radio" name="bg_color" value="#000000" id="bg_000000" onclick="addBgColor(this.value)"><label for="bg_000000">#000</label></li>
				</ul>
			</li>
			<li><!-- 2. white-grey -->
				<ul class="ul_bg ul_bg_reco">
					<li class="colorffffff"><input type="radio" name="bg_color" value="#ffffff" id="bg_ffffff" onclick="addBgColor(this.value)"><label for="bg_ffffff">흰색</label></li>
					<li class="colorf2f2f2"><input type="radio" name="bg_color" value="#f2f2f2" id="bg_f2f2f2" onclick="addBgColor(this.value)"><label for="bg_f2f2f2">#f2f2f2</label></li>
					<li class="colord8d8d8"><input type="radio" name="bg_color" value="#d8d8d8" id="bg_d8d8d8" onclick="addBgColor(this.value)"><label for="bg_d8d8d8">#d8d8d8</label></li>
					<li class="colorbfbfbf"><input type="radio" name="bg_color" value="#bfbfbf" id="bg_bfbfbf" onclick="addBgColor(this.value)"><label for="bg_bfbfbf">#bfbfbf</label></li>
					<li class="colora5a5a5"><input type="radio" name="bg_color" value="#a5a5a5" id="bg_a5a5a5" onclick="addBgColor(this.value)"><label for="bg_a5a5a5">#a5a5a5</label></li>
					<li class="color7f7f7f"><input type="radio" name="bg_color" value="#7f7f7f" id="bg_7f7f7f" onclick="addBgColor(this.value)"><label for="bg_7f7f7f">#7f7f7f</label></li>
					<li class="color707070"><input type="radio" name="bg_color" value="#707070" id="bg_707070" onclick="addBgColor(this.value)"><label for="bg_707070">#707070</label></li>
				</ul>
			</li>
			<li><!-- 3. grey -->
				<ul class="ul_bg ul_bg_reco">
					<li class="colora1a1a1"><input type="radio" name="bg_color" value="#a1a1a1" id="bg_a1a1a1" onclick="addBgColor(this.value)"><label for="bg_a1a1a1">회색</label></li>
					<li class="colord0cece"><input type="radio" name="bg_color" value="#d0cece" id="bg_d0cece" onclick="addBgColor(this.value)"><label for="bg_d0cece">#d0cece</label></li>
					<li class="colorbbbbbb"><input type="radio" name="bg_color" value="#bbbbbb" id="bg_bbbbbb" onclick="addBgColor(this.value)"><label for="bg_bbbbbb">#bbbbbb</label></li>
					<li class="coloraeabab"><input type="radio" name="bg_color" value="#aeabab" id="bg_aeabab" onclick="addBgColor(this.value)"><label for="bg_aeabab">#aeabab</label></li>
					<li class="color757070"><input type="radio" name="bg_color" value="#757070" id="bg_757070" onclick="addBgColor(this.value)"><label for="bg_757070">#757070</label></li>
					<li class="color3a3838"><input type="radio" name="bg_color" value="#3a3838" id="bg_3a3838" onclick="addBgColor(this.value)"><label for="bg_3a3838">#3a3838</label></li>
					<li class="color171616"><input type="radio" name="bg_color" value="#171616" id="bg_171616" onclick="addBgColor(this.value)"><label for="bg_171616">#171616</label></li>
				</ul>
			</li>

			<li><!-- 4. purple -->
				<ul class="ul_bg ul_bg_reco">
					<li class="color8d47ad"><input type="radio" name="bg_color" value="#8d47ad" id="bg_8d47ad" onclick="addBgColor(this.value)"><label for="bg_8d47ad">보라색</label></li>
					<li class="colorebdef6"><input type="radio" name="bg_color" value="#ebdef6" id="bg_ebdef6" onclick="addBgColor(this.value)"><label for="bg_ebdef6">#ebdef6</label></li>
					<li class="colorbb97c7"><input type="radio" name="bg_color" value="#bb97c7" id="bg_bb97c7" onclick="addBgColor(this.value)"><label for="bg_bb97c7">#bb97c7</label></li>
					<li class="color9a6baf"><input type="radio" name="bg_color" value="#9a6baf" id="bg_9a6baf" onclick="addBgColor(this.value)"><label for="bg_9a6baf">#9a6baf</label></li>
					<li class="color824f9e"><input type="radio" name="bg_color" value="#824f9e" id="bg_824f9e" onclick="addBgColor(this.value)"><label for="bg_824f9e">#824f9e</label></li>
					<li class="color872eb5"><input type="radio" name="bg_color" value="#872eb5" id="bg_872eb5" onclick="addBgColor(this.value)"><label for="bg_872eb5">#872eb5</label></li>
					<li class="color581f79"><input type="radio" name="bg_color" value="#581f79" id="bg_581f79" onclick="addBgColor(this.value)"><label for="bg_581f79">#581f79</label></li>
				</ul>
			</li>

			<li><!-- 5. blue -->
				<ul class="ul_bg ul_bg_reco">
					<li class="color0b56a7"><input type="radio" name="bg_color" value="#0b56a7" id="bg_0b56a7" onclick="addBgColor(this.value)"><label for="bg_0b56a7">파랑색</label></li>
					<li class="colord6dce4"><input type="radio" name="bg_color" value="#d6dce4" id="bg_d6dce4" onclick="addBgColor(this.value)"><label for="bg_d6dce4">#d6dce4</label></li>
					<li class="coloradb9ca"><input type="radio" name="bg_color" value="#adb9ca" id="bg_adb9ca" onclick="addBgColor(this.value)"><label for="bg_adb9ca">#adb9ca</label></li>
					<li class="color8eaadb"><input type="radio" name="bg_color" value="#8eaadb" id="bg_8eaadb" onclick="addBgColor(this.value)"><label for="bg_8eaadb">#8eaadb</label></li>
					<li class="color2f5496"><input type="radio" name="bg_color" value="#2f5496" id="bg_2f5496" onclick="addBgColor(this.value)"><label for="bg_2f5496">#2f5496</label></li>
					<li class="color323f4f"><input type="radio" name="bg_color" value="#323f4f" id="bg_323f4f" onclick="addBgColor(this.value)"><label for="bg_323f4f">#323f4f</label></li>
					<li class="color222a35"><input type="radio" name="bg_color" value="#222a35" id="bg_222a35" onclick="addBgColor(this.value)"><label for="bg_222a35">#222a35</label></li>
				</ul>
			</li>
			
			<li><!-- 6. green -->
				<ul class="ul_bg ul_bg_reco">
					<li class="color4a8205"><input type="radio" name="bg_color" value="#4a8205" id="bg_4a8205" onclick="addBgColor(this.value)"><label for="bg_4a8205">초록색</label></li>
					<li class="colorf1f8ec"><input type="radio" name="bg_color" value="#f1f8ec" id="bg_f1f8ec" onclick="addBgColor(this.value)"><label for="bg_f1f8ec">#f1f8ec</label></li>
					<li class="colorc5e0b3"><input type="radio" name="bg_color" value="#c5e0b3" id="bg_c5e0b3" onclick="addBgColor(this.value)"><label for="bg_c5e0b3">#c5e0b3</label></li>
					<li class="color8ebf6d"><input type="radio" name="bg_color" value="#8ebf6d" id="bg_8ebf6d" onclick="addBgColor(this.value)"><label for="bg_8ebf6d">#8ebf6d</label></li>
					<li class="color64a13c"><input type="radio" name="bg_color" value="#64a13c" id="bg_64a13c" onclick="addBgColor(this.value)"><label for="bg_64a13c">#64a13c</label></li>
					<li class="color538135"><input type="radio" name="bg_color" value="#538135" id="bg_538135" onclick="addBgColor(this.value)"><label for="bg_538135">#538135</label></li>
					<li class="color375623"><input type="radio" name="bg_color" value="#375623" id="bg_375623" onclick="addBgColor(this.value)"><label for="bg_375623">#375623</label></li>
				</ul>
			</li>
			<li><!-- 7. yellow -->
				<ul class="ul_bg ul_bg_reco">
					<li class="colorefc127"><input type="radio" name="bg_color" value="#efc127" id="bg_efc127" onclick="addBgColor(this.value)"><label for="bg_efc127">노랑색</label></li>
					<li class="colorfcf8eb"><input type="radio" name="bg_color" value="#fcf8eb" id="bg_fcf8eb" onclick="addBgColor(this.value)"><label for="bg_fcf8eb">#fcf8eb</label></li>
					<li class="colorfff2cc"><input type="radio" name="bg_color" value="#fff2cc" id="bg_fff2cc" onclick="addBgColor(this.value)"><label for="bg_fff2cc">#fff2cc</label></li>
					<li class="colorf1d88c"><input type="radio" name="bg_color" value="#f1d88c" id="bg_f1d88c" onclick="addBgColor(this.value)"><label for="bg_f1d88c">#f1d88c</label></li>
					<li class="colore3bb43"><input type="radio" name="bg_color" value="#e3bb43" id="bg_e3bb43" onclick="addBgColor(this.value)"><label for="bg_e3bb43">#e3bb43</label></li>
					<li class="colorbf9000"><input type="radio" name="bg_color" value="#bf9000" id="bg_bf9000" onclick="addBgColor(this.value)"><label for="bg_bf9000">#bf9000</label></li>
					<li class="color7f6000"><input type="radio" name="bg_color" value="#7f6000" id="bg_7f6000" onclick="addBgColor(this.value)"><label for="bg_7f6000">#7f6000</label></li>
				</ul>
			</li>
			<li><!-- 8. orange -->
				<ul class="ul_bg ul_bg_reco">
					<li class="colorf7630d"><input type="radio" name="bg_color" value="#f7630d" id="bg_f7630d" onclick="addBgColor(this.value)"><label for="bg_f7630d">주황색</label></li>
					<li class="colorfdf0e7"><input type="radio" name="bg_color" value="#fdf0e7" id="bg_fdf0e7" onclick="addBgColor(this.value)"><label for="bg_fdf0e7">#fdf0e7</label></li>
					<li class="colorf4dac7"><input type="radio" name="bg_color" value="#f4dac7" id="bg_f4dac7" onclick="addBgColor(this.value)"><label for="bg_f4dac7">#f4dac7</label></li>
					<li class="colorf7cbac"><input type="radio" name="bg_color" value="#f7cbac" id="bg_f7cbac" onclick="addBgColor(this.value)"><label for="bg_f7cbac">#f7cbac</label></li>
					<li class="colorf4b183"><input type="radio" name="bg_color" value="#f4b183" id="bg_f4b183" onclick="addBgColor(this.value)"><label for="bg_f4b183">#f4b183</label></li>
					<li class="colord96a1e"><input type="radio" name="bg_color" value="#d96a1e" id="bg_d96a1e" onclick="addBgColor(this.value)"><label for="bg_d96a1e">#d96a1e</label></li>
					<li class="color833c0b"><input type="radio" name="bg_color" value="#833c0b" id="bg_833c0b" onclick="addBgColor(this.value)"><label for="bg_833c0b">#833c0b</label></li>
				</ul>
			</li>
			<li><!-- 9.pink -->
				<ul class="ul_bg ul_bg_reco">
					<li class="colore64856"><input type="radio" name="bg_color" value="#e64856" id="bg_e64856" onclick="addBgColor(this.value)"><label for="bg_e64856">분홍색</label></li>
					<li class="colorf0e7ec"><input type="radio" name="bg_color" value="#f0e7ec" id="bg_f0e7ec" onclick="addBgColor(this.value)"><label for="bg_f0e7ec">#f0e7ec</label></li>
					<li class="colorf8c3c5"><input type="radio" name="bg_color" value="#f8c3c5" id="bg_f8c3c5" onclick="addBgColor(this.value)"><label for="bg_f8c3c5">#f8c3c5</label></li>
					<li class="colorf9a7ab"><input type="radio" name="bg_color" value="#f9a7ab" id="bg_f9a7ab" onclick="addBgColor(this.value)"><label for="bg_f9a7ab">#f9a7ab</label></li>
					<li class="colorf28183"><input type="radio" name="bg_color" value="#f28183" id="bg_f28183" onclick="addBgColor(this.value)"><label for="bg_f28183">#f28183</label></li>
					<li class="colorea2364"><input type="radio" name="bg_color" value="#ea2364" id="bg_ea2364" onclick="addBgColor(this.value)"><label for="bg_ea2364">#ea2364</label></li>
					<li class="colorc40052"><input type="radio" name="bg_color" value="#c40052" id="bg_c40052" onclick="addBgColor(this.value)"><label for="bg_c40052">#c40052</label></li>
				</ul>
			</li>
			<li><!-- 10.red -->
				<ul class="ul_bg ul_bg_reco">
					<li class="colorc80000"><input type="radio" name="bg_color" value="#c80000" id="bg_c80000" onclick="addBgColor(this.value)"><label for="bg_c80000">빨강색</label></li>
					<li class="coloreee4e4"><input type="radio" name="bg_color" value="#eee4e4" id="bg_eee4e4" onclick="addBgColor(this.value)"><label for="bg_eee4e4">#eee4e4</label></li>
					<li class="colorfbd5d5"><input type="radio" name="bg_color" value="#fbd5d5" id="bg_fbd5d5" onclick="addBgColor(this.value)"><label for="bg_fbd5d5">#fbd5d5</label></li>
					<li class="colorf7acac"><input type="radio" name="bg_color" value="#f7acac" id="bg_f7acac" onclick="addBgColor(this.value)"><label for="bg_f7acac">#f7acac</label></li>
					<li class="coloref5658"><input type="radio" name="bg_color" value="#ef5658" id="bg_ef5658" onclick="addBgColor(this.value)"><label for="bg_ef5658">#ef5658</label></li>
					<li class="colorce1313"><input type="radio" name="bg_color" value="#ce1313" id="bg_ce1313" onclick="addBgColor(this.value)"><label for="bg_ce1313">#ce1313</label></li>
					<li class="color830b0b"><input type="radio" name="bg_color" value="#830b0b" id="bg_830b0b" onclick="addBgColor(this.value)"><label for="bg_830b0b">#830b0b</label></li>
				</ul>
			</li>
		</ul>


		<div>
			<p class="bg_reco"><spring:message code="wzwg.site.screen.msg.MSG056" /></p>
			<input type="range" id="editBgRange" value="255" min="0" max="100" class="w70 pl10 pr10 br-none" step="10" onchange="$('#bgRangeValue').html($(this).val() + '%');">
			<span id="bgRangeValue" class="wz-box br3 ml15 p5 br-grey" style="width: 40px; display: inline-block; text-align: right;">100%</span>
		</div>
		<!-- 자유롭게 색상 선택하기 링크버튼 -->
		<a href="javascript:;" onclick="changeBgColor()"><span class="choice_btn choice_free"><spring:message code="wzwg.cmm.msg.MSG258" /></span></a>
		<a href="javascript:;" onclick="changeColorCodePopup('bgColor');"><span class="choice_btn choice_code"><spring:message code="wzwg.cmm.msg.MSG259" /></span></a>
	</div> --%>
	
	<div id="pickerBgDiv" title="<spring:message code="wzwg.cmm.word.scrin.bcrnColChg"/>" style="z-index: 999;">
		<div class="pop-notice"><span class="circle_no bg-red-strong">!</span><spring:message code="wzwg.cmm.msg.screen.MSG048" /></div>
		<c:out value="${bgColorPalette }" escapeXml="false"/>
		<div class="bg_palette_area">
            <button type="button" class="btn_palette" onclick="changePickerColor()"><spring:message code="wzwg.cmm.word.scrin.choisefree" /></button>
        </div>
        <div class="bg_palette_area">
          	<span><spring:message code="wzwg.cmm.word.trspy" /> - <span id="bg_trans_range_val">0</span>%</span>
          	<div id="bg_trans_range"></div>
        </div>
        <div class="bg_palette_area">
          	<button type="button" class="btn_templt" onclick="addBgDefaultCol()"><spring:message code="wzwg.cmm.word.scrin.templtDefault" /></button>
        </div>
	</div>
	
	<div id="pickerFontDiv" title="<spring:message code="wzwg.cmm.word.scrin.colTable" />" style="z-index: 999;">
		<div id="pickerFont"></div>
	</div>

	<div id="pickerBgTotDiv" title="<spring:message code="wzwg.cmm.word.scrin.colTable" />" style="z-index: 999;">
		<div id="pickerBgTot"></div>
	</div>

	<div id="pickerCodeDiv" title="<spring:message code="wzwg.site.screen.msg.MSG057" />" style="z-index: 999;">
		<div>
			<p><input type="text" name="codeTxt" id="codeTxt"  style="width:98%;"/></p>
			<a href="javascript:;" class="ui-button ui-widget ui-corner-all" onclick="changeColorCode($('#codeTxt').val());"><spring:message code="wzwg.cmm.word.stre" /></a>
		</div>
	</div>

	<div id="divSampleList" title="<spring:message code="wzwg.cmm.word.list"/>" style="z-index: 999;"></div>

	<div id="sizeDiv" title="<spring:message code="wzwg.site.screen.msg.MSG188"/>" style="z-index: 999;">
		<p>
			top : <input type="text" name="sTop" id="sTop" style="width: 100px;" />
		</p>
		<p>
			left : <input type="text" name="sLeft" id="sLeft"
				style="width: 100px;" />
		</p>
		<p>
			width : <input type="text" name="sWidth" id="sWidth"
				style="width: 100px;" />
		</p>
		<p>
			height: <input type="text" name="sHeight" id="sHeight"
				style="width: 100px;" />
		</p>
		<a href="javascript:;" class="ui-button ui-widget ui-corner-all"
			onclick="setDivSize(selectDiv);"><spring:message code="wzwg.cmm.word.stre" /></a>
	</div>

	<div id="imgCaptionDiv" title="<spring:message code="wzwg.site.menu.msg.MSG039"/>" style="z-index: 999;">
		<div class="wzwg_dialog_pop">
			<p class="admpg-subp mb15">
			    <span class="circle_no bg-green-strong">i</span><strong class="grey fs14"><spring:message code="wzwg.cmm.msg.screen.MSG052" /></strong>
			    <span class="fs14"><spring:message code="wzwg.cmm.msg.screen.MSG053" /></span>
			</p>
			<p>
				<input type="text" name="imgCaption" id="imgCaption"  style="width:98%;"/>
			</p>
			<span class="grey">* <spring:message code="wzwg.cmm.msg.screen.MSG054" /></span>
			<a href="javascript:;" class="ui-button ui-widget ui-corner-all"
				onclick="addImgCaption($('#imgCaption').val());"><spring:message code="wzwg.cmm.word.stre" /></a>
		</div>
	</div>
	
	<div id="txtBannerDiv" title="<spring:message code="wzwg.site.screen.msg.MSG187"/>" style="z-index: 999;">
		<div class="wzwg_dialog_pop">
			<p>
				<input type="text" name="txtBanner" id="txtBanner"  style="width:98%;"/>
			</p>
			<a href="javascript:;" class="ui-button ui-widget ui-corner-all"
				onclick="addBannerTxt($('#txtBanner').val());"><spring:message code="wzwg.cmm.word.stre" /></a>
		</div>
	</div>
	
	<div id="txtareaContentDiv" title="<spring:message code="wzwg.site.screen.msg.MSG187"/>" style="z-index: 999;">
		<p style="margin-bottom: 10px;">
			<textarea rows="5" name="txtareaContent" id="txtareaContent" style="width:98%; height: 75px;"></textarea>
		</p>
		<a href="javascript:;" class="ui-button ui-widget ui-corner-all"
			onclick="addContentTxtarea($('#txtareaContent').val());"><spring:message code="wzwg.cmm.word.stre" /></a>
	</div>

	<div id="bannerLinkUrlDiv" title="<spring:message code="wzwg.site.screen.msg.MSG186"/>" style="z-index: 999;">
	 <span><spring:message code="wzwg.cmm.msg.screen.MSG051" /></span>
		<div class= "linkSelect pop_link" >
			<button type="button" class="btn-c linkSelectMenu" onclick="javascript:$('#linkMenuList2').toggle(300);"><spring:message code="wzwg.site.menu.msg.MSG042" /></button>
			
				<ul class="linkMenuList" id="linkMenuList2" style="display:none;">
						   
					<c:choose>
						<c:when test="${subPrefix eq '/subMngr' or subPrefix eq '/subsite' }">
							<c:forEach items="${menuList}" var="oneDepth" varStatus="status">
								<c:if test="${empty oneDepth.upperMenuSeq or oneDepth.upperMenuSeq eq '0' }">
									<li>
									 <c:choose>
									 	<c:when test="${oneDepth.menuDivision eq 'group' }">
									 		<a href="javascript:void(0);" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${oneDepth.menuNm }"/></a>
									 	</c:when>
									 	<c:when test="${oneDepth.menuDivision eq 'link' }">
									 		<a href="javascript:void(0);" onclick="$('#bannerLinkUrl').val('<c:out value="${oneDepth.menuLinkUrl}"/>');$('#bannerLinkTitle').val('<c:out value="${oneDepth.menuNm}"/>');" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${oneDepth.menuNm }"/></a>
									 	</c:when>
									 	<c:when test="${oneDepth.menuDivision eq 'anchor'}">
											<a href="javascript:void(0);" onclick="alert('앵커메뉴는 연결할 수 없습니다.');"  data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${oneDepth.menuNm }"/></a>
										</c:when>
									 	<c:otherwise>
									 		<a href="javascript:void(0);" onclick="$('#bannerLinkUrl').val('<c:out value="${wzwg_contextPath}"/>/subsite/<c:out value="${subsiteKey}"/>/subList/<c:out value="${oneDepth.menuLinkSeq}"/>');$('#bannerLinkTitle').val('<c:out value="${oneDepth.menuNm}"/>');" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${oneDepth.menuNm }"/></a>	
									 	</c:otherwise>
									 	
									 </c:choose>
										<ul>
										<c:forEach items="${menuList}" var="twoDepth" varStatus="status">
										<c:if test="${oneDepth.menuSeq eq twoDepth.upperMenuSeq}">
											<li>
												<c:choose>
												 	<c:when test="${twoDepth.menuDivision eq 'group' }">
												 		<a href="javascript:void(0);"  data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${twoDepth.menuNm }"/></a>
												 	</c:when>
												 	<c:when test="${twoDepth.menuDivision eq 'link'}">
												 		<a href="javascript:void(0);" onclick="$('#bannerLinkUrl').val('<c:out value="${twoDepth.menuLinkUrl}"/>');$('#bannerLinkTitle').val('<c:out value="${twoDepth.menuNm}"/>');"  data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${twoDepth.menuNm }"/></a>
												 	</c:when>
												 	<c:otherwise>
												 		<a href="javascript:void(0);" onclick="$('#bannerLinkUrl').val('<c:out value="${wzwg_contextPath}"/>/subsite/<c:out value="${subsiteKey}"/>/subList/<c:out value="${twoDepth.menuLinkSeq}"/>');$('#bannerLinkTitle').val('<c:out value="${twoDepth.menuNm}"/>');" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${twoDepth.menuNm }"/></a>	
												 	</c:otherwise>
												 </c:choose>
												<ul>    
												<c:forEach items="${menuList}" var="threeDepth" varStatus="status">
												  <c:if test="${twoDepth.menuSeq eq threeDepth.upperMenuSeq}"> 
													<li>
													<c:choose>
													 	<c:when test="${threeDepth.menuDivision eq 'group' }">
													 		<a href="javascript:void(0);"  data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${threeDepth.menuNm }"/></a>
													 	</c:when>
													 	<c:when test="${threeDepth.menuDivision eq 'link'}">
													 		<a href="javascript:void(0);" onclick="$('#bannerLinkUrl').val('<c:out value="${threeDepth.menuLinkUrl}"/>');$('#bannerLinkTitle').val('<c:out value="${threeDepth.menuNm}"/>');" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${threeDepth.menuNm }"/></a>
													 	</c:when>
													 	<c:otherwise>
													 		<a href="javascript:void(0);" onclick="$('#bannerLinkUrl').val('<c:out value="${wzwg_contextPath}"/>/subsite/<c:out value="${subsiteKey}"/>/subList/<c:out value="${threeDepth.menuLinkSeq}"/>');$('#bannerLinkTitle').val('<c:out value="${threeDepth.menuNm}"/>');" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${threeDepth.menuNm }"/></a>	
													 	</c:otherwise>
													 	
													 </c:choose>
			
													</li>
												</c:if>
												</c:forEach>
												</ul>
											</li>
										</c:if>
										</c:forEach>	 
										</ul>  
									</li>   
								</c:if>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:forEach items="${menuList}" var="oneDepth" varStatus="status">
								<c:if test="${empty oneDepth.upperMenuSeq or oneDepth.upperMenuSeq eq '0' }">
									<li>
									 <c:choose>
									 	<c:when test="${oneDepth.menuDivision eq 'group' }">
									 		<a href="javascript:void(0);" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${oneDepth.menuNm }"/></a>
									 	</c:when>
									 	<c:when test="${oneDepth.menuDivision eq 'link'}">
									 		<a href="javascript:void(0);" onclick="$('#bannerLinkUrl').val('<c:out value="${oneDepth.menuLinkUrl}"/>');$('#bannerLinkTitle').val('<c:out value="${oneDepth.menuNm}"/>');" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${oneDepth.menuNm }"/></a>
									 	</c:when>
									 	<c:when test="${oneDepth.menuDivision eq 'anchor'}">
									 		<a href="javascript:void(0);" onclick="alert('앵커메뉴는 연결할 수 없습니다.');" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${oneDepth.menuNm }"/></a>
									 	</c:when>
									 	<c:otherwise>
									 		<a href="javascript:void(0);" onclick="$('#bannerLinkUrl').val('<c:out value="${wzwg_contextPath}"/>/subList/<c:out value="${oneDepth.menuLinkSeq}"/>');$('#bannerLinkTitle').val('<c:out value="${oneDepth.menuNm}"/>');" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${oneDepth.menuNm }"/></a>	
									 	</c:otherwise>
									 </c:choose>
										<ul>
										<c:forEach items="${menuList}" var="twoDepth" varStatus="status">
										<c:if test="${oneDepth.menuSeq eq twoDepth.upperMenuSeq}">
											<li>
												<c:choose>
												 	<c:when test="${twoDepth.menuDivision eq 'group' }">
												 		<a href="javascript:void(0);"  data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${twoDepth.menuNm }"/></a>
												 	</c:when>
												 	<c:when test="${twoDepth.menuDivision eq 'link'}">
												 		<a href="javascript:void(0);" onclick="$('#bannerLinkUrl').val('<c:out value="${twoDepth.menuLinkUrl}"/>');$('#bannerLinkTitle').val('<c:out value="${twoDepth.menuNm}"/>');"  data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${twoDepth.menuNm }"/></a>
												 	</c:when>
												 	<c:otherwise>
												 		<a href="javascript:void(0);" onclick="$('#bannerLinkUrl').val('<c:out value="${wzwg_contextPath}"/>/subList/<c:out value="${twoDepth.menuLinkSeq}"/>');$('#bannerLinkTitle').val('<c:out value="${twoDepth.menuNm}"/>');" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${twoDepth.menuNm }"/></a>	
												 	</c:otherwise>
												 </c:choose>
						                        
												<ul>
												<c:forEach items="${menuList}" var="threeDepth" varStatus="status">
												  <c:if test="${twoDepth.menuSeq eq threeDepth.upperMenuSeq}"> 
													<li>
													<c:choose>
													 	<c:when test="${threeDepth.menuDivision eq 'group' }">
													 		<a href="javascript:void(0);"  data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${threeDepth.menuNm }"/></a>
													 	</c:when>
													 	<c:when test="${threeDepth.menuDivision eq 'link'}">
													 		<a href="javascript:void(0);" onclick="$('#bannerLinkUrl').val('<c:out value="${threeDepth.menuLinkUrl}"/>');$('#bannerLinkTitle').val('<c:out value="${threeDepth.menuNm}"/>');" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${threeDepth.menuNm }"/></a>
													 	</c:when>
													 	<c:otherwise>
													 		<a href="javascript:void(0);" onclick="$('#bannerLinkUrl').val('<c:out value="${wzwg_contextPath}"/>/subList/<c:out value="${threeDepth.menuLinkSeq}"/>');$('#bannerLinkTitle').val('<c:out value="${threeDepth.menuNm}"/>');" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${threeDepth.menuNm }"/></a>	
													 	</c:otherwise>
													 </c:choose>
			
													</li>
												</c:if>
												</c:forEach>
												</ul>
											</li>
										</c:if>
										</c:forEach>	 
										</ul>  
									</li>   
								</c:if>
							</c:forEach>
						</c:otherwise>
					</c:choose>
					</ul>
		</div>
		
		<p>
			<span>url :</span> <input type="text" name="bannerLinkUrl" id="bannerLinkUrl"  value=""/>
		</p>
		
		target :
		<select id="bannerLinkTarget" name="bannerLinkTarget">
			<option value="_self"><spring:message code="wzwg.cmm.word.nowwin" /></option>
			<option value="_blank"><spring:message code="wzwg.cmm.word.newwin" /></option>
		</select> 
		
		
		<div>
			<br><br><span><spring:message code="wzwg.cmm.word.dc" /> :</span><input type="text" name="bannerLinkTitle" id="bannerLinkTitle"  value=""/>
		</div>
		
		<a href="javascript:;" class="ui-button ui-widget ui-corner-all"
			onclick="addBannerLink($('#bannerLinkUrl').val(),$('#bannerLinkTarget').val(),$('#bannerLinkTitle').val());"><spring:message code="wzwg.cmm.word.stre" />
		</a>
		</div>
	
	
	<div id="anchorMenuLinkDiv" title="<spring:message code="wzwg.site.screen.msg.MSG185"/>" style="z-index: 999;">
		<div class="linkSelect pop_link">
			<%-- <button type="button" class="btn-c linkSelectMenu" onclick="javascript:$('#anchorMenuList2').toggle(300);"><spring:message code="wzwg.site.menu.msg.MSG042" /></button> --%>
			
				<ul class="anchorMenuList" id="anchorMenuList2">
					<c:forEach items="${menuList}" var="list" varStatus="status">
						<c:if test="${list.sysmoduleSeq eq '888888888888' }">
						<li>
						<a href="javascript:void(0);" onclick="addAnchorid('<c:out value="${list.menuSeq}"/>', '<c:out value="${list.menuNm }"/>')" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${list.menuNm }"/></a>
						</li>
						</c:if>
					</c:forEach>
				</ul>
					
		</div>
		<p>
			<span class="red"><spring:message code="wzwg.site.screen.msg.MSG184"/></span> 
		</p>
		
	</div>
	
	
	<%-- <div id="slideTxtPositionDiv" title="<spring:message code="wzwg.site.screen.msg.MSG183"/>" style="z-index: 999;">
		<div class="slideTxtPosition">
			<div>
				<input type="radio" name="dialogTextPosition" value="copy_position_lh" onclick="modifyTxtPosition($(this).val())" id="stp1"><label for="stp1"><spring:message code="wzwg.site.screen.msg.MSG058" /></label>
				<input type="radio" name="dialogTextPosition" value="copy_position_ch" onclick="modifyTxtPosition($(this).val())" id="stp2"><label for="stp2"><spring:message code="wzwg.site.screen.msg.MSG059" /></label>
				<input type="radio" name="dialogTextPosition" value="copy_position_rh" onclick="modifyTxtPosition($(this).val())" id="stp3"><label for="stp3"><spring:message code="wzwg.site.screen.msg.MSG060" /></label>
			</div>
			<div>
				<input type="radio" name="dialogTextPosition" value="copy_position_lm" onclick="modifyTxtPosition($(this).val())" id="stp4"><label for="stp4"><spring:message code="wzwg.site.screen.msg.MSG061" /></label>
				<input type="radio" name="dialogTextPosition" value="copy_position_cm" onclick="modifyTxtPosition($(this).val())" id="stp5"><label for="stp5"><spring:message code="wzwg.site.screen.msg.MSG062" /></label>
				<input type="radio" name="dialogTextPosition" value="copy_position_rm" onclick="modifyTxtPosition($(this).val())" id="stp6"><label for="stp6"><spring:message code="wzwg.site.screen.msg.MSG063" /></label>
			</div>
			<div>
				<input type="radio" name="dialogTextPosition" value="copy_position_ll" onclick="modifyTxtPosition($(this).val())" id="stp7"><label for="stp7"><spring:message code="wzwg.site.screen.msg.MSG064" /></label>
				<input type="radio" name="dialogTextPosition" value="copy_position_cl" onclick="modifyTxtPosition($(this).val())" id="stp8"><label for="stp8"><spring:message code="wzwg.site.screen.msg.MSG065" /></label>
				<input type="radio" name="dialogTextPosition" value="copy_position_rl" onclick="modifyTxtPosition($(this).val())" id="stp9"><label for="stp9"><spring:message code="wzwg.site.screen.msg.MSG066" /></label>
			</div>
		</div>
	</div> --%>
	
	<div id="slideTxtPositionDiv" title="<spring:message code="wzwg.site.screen.msg.MSG183"/>" style="z-index: 999; padding:0;">
		<div class="p0">
			<ul class="align_wrap_detail">
            <li>
              <button type="button" onclick="modifyTxtPosition('copy_position_lh')" class="b_leftTop txt-r"><span><spring:message code="wzwg.site.screen.msg.MSG058" /></span></button>
              <button type="button" onclick="modifyTxtPosition('copy_position_lm')" class="b_leftCenter txt-r"><span><spring:message code="wzwg.site.screen.msg.MSG061" /></span></button>
              <button type="button" onclick="modifyTxtPosition('copy_position_ll')" class="b_leftBtm txt-r"><span><spring:message code="wzwg.site.screen.msg.MSG064" /></span></button>
            </li>
            <li>
              <button type="button" onclick="modifyTxtPosition('copy_position_ch')" class="b_midTop txt-c"><span><spring:message code="wzwg.site.screen.msg.MSG059" /></span></button>
              <button type="button" onclick="modifyTxtPosition('copy_position_cm')" class="b_midCenter txt-c"><span><spring:message code="wzwg.site.screen.msg.MSG062" /></span></button>
              <button type="button" onclick="modifyTxtPosition('copy_position_cl')" class="b_midBtm txt-c"><span><spring:message code="wzwg.site.screen.msg.MSG065" /></span></button>
            </li>
            <li>
              <button type="button" onclick="modifyTxtPosition('copy_position_rh')" class="b_rgtTop txt-l"><span><spring:message code="wzwg.site.screen.msg.MSG060" /></span></button>
              <button type="button" onclick="modifyTxtPosition('copy_position_rm')" class="b_rgtCenter txt-l"><span><spring:message code="wzwg.site.screen.msg.MSG063" /></span></button>
              <button type="button" onclick="modifyTxtPosition('copy_position_rl')" class="b_rgtBtm txt-l"><span><spring:message code="wzwg.site.screen.msg.MSG066" /></span></button>
            </li>
          </ul>
		</div>
	</div>
	
	
	<%-- <div id="slideTxtPositionTopDiv" title="<spring:message code="wzwg.site.screen.msg.MSG183"/>" style="z-index: 999;">
		<div class="slideTxtPosition">
			<div>
				<input type="radio" name="dialogTextPosition" value="copy_position_lh" onclick="modifyTxtPosition($(this).val())" id="stp1"><label for="stp1"><spring:message code="wzwg.cmm.word.left02" /></label>
				<input type="radio" name="dialogTextPosition" value="copy_position_ch" onclick="modifyTxtPosition($(this).val())" id="stp2"><label for="stp2"><spring:message code="wzwg.cmm.word.centr" /></label>
				<input type="radio" name="dialogTextPosition" value="copy_position_rh" onclick="modifyTxtPosition($(this).val())" id="stp3"><label for="stp3"><spring:message code="wzwg.cmm.word.rght02" /></label>
			</div>
		</div>
	</div> --%>
	
	<div id="slideTxtPositionTopDiv" title="<spring:message code="wzwg.site.screen.msg.MSG183"/>" style="z-index: 999; padding:0;">
			<ul class="align_wrap">
	            <li>
	              <button type="button" onclick="modifyTxtPosition('copy_position_lh')">
	                <img src="/images/wzwg/site/mngr/screen/ico_align_left.png" alt="">
	                <p><spring:message code="wzwg.cmm.word.left02" /></p>
	              </button>
	            </li>
	            <li>
	              <button type="button" onclick="modifyTxtPosition('copy_position_ch')">
	                <img src="/images/wzwg/site/mngr/screen/ico_align_center.png" alt="">
	                <p><spring:message code="wzwg.cmm.word.centr" /></p>
	              </button>
	            </li>
	            <li>
	              <button type="button" onclick="modifyTxtPosition('copy_position_rh')">
	                <img src="/images/wzwg/site/mngr/screen/ico_align_right.png" alt="">
	                <p><spring:message code="wzwg.cmm.word.rght02" /></p>
	              </button>
	            </li>
	         </ul>
	</div>
	
	<%-- <div id="contentsAlignDiv" title="<spring:message code="wzwg.site.screen.msg.MSG170"/>" style="z-index: 999;">
		<div class="slideTxtPosition">
			<div>
				<input type="radio" name="dialogTextPosition" value="left" onclick="modifyContentsAlign($(this).val())" id="align-left"><label for="align-left"><spring:message code="wzwg.cmm.word.left02" /></label>
				<input type="radio" name="dialogTextPosition" value="center" onclick="modifyContentsAlign($(this).val())" id="align-center"><label for="align-center"><spring:message code="wzwg.cmm.word.centr" /></label>
				<input type="radio" name="dialogTextPosition" value="right" onclick="modifyContentsAlign($(this).val())" id="align-right"><label for="align-right"><spring:message code="wzwg.cmm.word.rght02" /></label>
			</div>
		</div>
	</div> --%>
	
	<div id="contentsAlignDiv" title="<spring:message code="wzwg.site.screen.msg.MSG170"/>" style="z-index: 999; padding:0;">
		<ul class="align_wrap">
            <li>
              <button type="button" onclick="modifyContentsAlign('left')">
                <img src="/images/wzwg/site/mngr/screen/ico_align_left.png" alt="">
                <p><spring:message code="wzwg.cmm.word.left02" /></p>
              </button>
            </li>
            <li>
              <button type="button" onclick="modifyContentsAlign('center')">
                <img src="/images/wzwg/site/mngr/screen/ico_align_center.png" alt="">
                <p><spring:message code="wzwg.cmm.word.centr" /></p>
              </button>
            </li>
            <li>
              <button type="button" onclick="modifyContentsAlign('right')">
                <img src="/images/wzwg/site/mngr/screen/ico_align_right.png" alt="">
                <p><spring:message code="wzwg.cmm.word.rght02" /></p>
              </button>
            </li>
         </ul>
	</div>
	
	<div id="youtubeLink" title="<spring:message code="wzwg.site.screen.msg.MSG117"/>" style="z-index: 999;">
		<div class="youtube-link-control">
			<p>
			<span>url :</span> <input type="text" name="youtubeLinkUrl" id="youtubeLinkUrl" />
			</p>
			<button type="button" class="ui-button ui-widget ui-corner-all"	onclick="addYoutubeLink()"><spring:message code="wzwg.cmm.word.stre" /></button>
		</div>
	</div>
	
	
	<div id="dialog_changeImgPath" title="<spring:message code="wzwg.site.screen.msg.MSG067" />" style="z-index: 999;">
		<p>
			<input type="text" name="inp_changeImgPath" id="inp_changeImgPath" style="width: 98%; height: 30px; padding-left:5px; "/>
		</p>
		<a href="javascript:;" class="ui-button ui-widget ui-corner-all"
			onclick="changeImgSrc();"><spring:message code="wzwg.cmm.word.stre" /></a>
	</div>
	
	<%-- <div id="shopProductEdit" title="쇼핑몰상품진열" style="z-index: 999;">
		<div class="product-bache-control">
			<select>
				<c:forEach  items="${wigetShopList}" var="subList" varStatus="statusSub">
				<option value="<c:out value="${subList.menuSeq}"/>"><c:out value="${subList.menuNm}"/></option>
				"<c:out value="${subList.menuSeq}"/>":{name:"<c:out value="${subList.menuNm}"/>",icon:"edit", shopinfoSeq : "<c:out value="${subList.cntntsSeq}"/>"}<c:if test="${!statusSub.last}">,</c:if>
				</c:forEach>
			</select>
			<button type="button" class="ui-button ui-widget ui-corner-all"	onclick="addYoutubeLink()"><spring:message code="wzwg.cmm.word.stre" /></button>
		</div>
	</div> --%>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	<%-- 에디터 html 조각들 --%>
	<c:set var="bulletList">
						<ul class="inline-list">
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-angle-up')" class="wzbtn-table btn-basic">
									<span class="fa fa-angle-up"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-angle-down')" class="wzbtn-table btn-basic">
									<span class="fa fa-angle-down"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-angle-left')" class="wzbtn-table btn-basic">
									<span class="fa fa-angle-left"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-angle-right')" class="wzbtn-table btn-basic">
									<span class="fa fa-angle-right"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-angle-double-left')" class="wzbtn-table btn-basic">
									<span class="fa fa-angle-double-left"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-angle-double-right')" class="wzbtn-table btn-basic">
									<span class="fa fa-angle-double-right"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-arrow-circle-up')" class="wzbtn-table btn-basic">
									<span class="fa fa-arrow-circle-up"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-arrow-circle-down')" class="wzbtn-table btn-basic">
									<span class="fa fa-arrow-circle-down"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-arrow-circle-left')" class="wzbtn-table btn-basic">
									<span class="fa fa-arrow-circle-left"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-arrow-circle-right')" class="wzbtn-table btn-basic">
									<span class="fa fa-arrow-circle-right"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-arrow-up')" class="wzbtn-table btn-basic">
									<span class="fa fa-arrow-up"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-arrow-down')" class="wzbtn-table btn-basic">
									<span class="fa fa-arrow-down"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-arrow-left')" class="wzbtn-table btn-basic">
									<span class="fa fa-arrow-left"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-arrow-right')" class="wzbtn-table btn-basic">
									<span class="fa fa-arrow-right"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-asterisk')" class="wzbtn-table btn-basic">
									<span class="fa fa-asterisk"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-ban')" class="wzbtn-table btn-basic">
									<span class="fa fa-ban"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-caret-up')" class="wzbtn-table btn-basic">
									<span class="fa fa-caret-up"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-caret-down')" class="wzbtn-table btn-basic">
									<span class="fa fa-caret-down"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-caret-left')" class="wzbtn-table btn-basic">
									<span class="fa fa-caret-left"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-caret-right')" class="wzbtn-table btn-basic">
									<span class="fa fa-caret-right"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-caret-square-o-up')" class="wzbtn-table btn-basic">
									<span class="fa fa-caret-square-o-up"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-caret-square-o-down')" class="wzbtn-table btn-basic">
									<span class="fa fa-caret-square-o-down"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-caret-square-o-left')" class="wzbtn-table btn-basic">
									<span class="fa fa-caret-square-o-left"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-caret-square-o-right')" class="wzbtn-table btn-basic">
									<span class="fa fa-caret-square-o-right"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-check')" class="wzbtn-table btn-basic">
									<span class="fa fa-check"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-check-circle')" class="wzbtn-table btn-basic">
									<span class="fa fa-check-circle"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-check-circle-o')" class="wzbtn-table btn-basic">
									<span class="fa fa-check-circle-o"></span>
								</button>
							</li>
							<!-- <li>
								<button type="button" onclick="wzEditorBullet('fa fa-user-circle')" class="wzbtn-table btn-basic">
									<span class="fa fa-user-circle"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-user-circle-o')" class="wzbtn-table btn-basic">
									<span class="fa fa-user-circle-o"></span>
								</button>
							</li> -->
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-user-o')" class="wzbtn-table btn-basic">
									<span class="fa fa-user-o"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-cloud')" class="wzbtn-table btn-basic">
									<span class="fa fa-cloud"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-cloud-download')" class="wzbtn-table btn-basic">
									<span class="fa fa-cloud-download"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-cloud-upload')" class="wzbtn-table btn-basic">
									<span class="fa fa-cloud-upload"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-download')" class="wzbtn-table btn-basic">
									<span class="fa fa-download"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-coffee')" class="wzbtn-table btn-basic">
									<span class="fa fa-coffee"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-cog')" class="wzbtn-table btn-basic">
									<span class="fa fa-cog"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-cogs')" class="wzbtn-table btn-basic">
									<span class="fa fa-cogs"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-commenting')" class="wzbtn-table btn-basic">
									<span class="fa fa-commenting"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-commenting-o')" class="wzbtn-table btn-basic">
									<span class="fa fa-commenting-o"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-copyright')" class="wzbtn-table btn-basic">
									<span class="fa fa-copyright"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-envelope')" class="wzbtn-table btn-basic">
									<span class="fa fa-envelope"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-envelope-o')" class="wzbtn-table btn-basic">
									<span class="fa fa-envelope-o"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-exclamation-circle')" class="wzbtn-table btn-basic">
									<span class="fa fa-exclamation-circle"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-exclamation-triangle')" class="wzbtn-table btn-basic">
									<span class="fa fa-exclamation-triangle"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-info')" class="wzbtn-table btn-basic">
									<span class="fa fa-info"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-info-circle')" class="wzbtn-table btn-basic">
									<span class="fa fa-info-circle"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-plus')" class="wzbtn-table btn-basic">
									<span class="fa fa-plus"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-minus')" class="wzbtn-table btn-basic">
									<span class="fa fa-minus"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-question')" class="wzbtn-table btn-basic">
									<span class="fa fa-question"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-picture-o')" class="wzbtn-table btn-basic">
									<span class="fa fa-picture-o"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-phone')" class="wzbtn-table btn-basic">
									<span class="fa fa-phone"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-phone-square')" class="wzbtn-table btn-basic">
									<span class="fa fa-phone-square"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-quote-left')" class="wzbtn-table btn-basic">
									<span class="fa fa-quote-left"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-quote-right')" class="wzbtn-table btn-basic">
									<span class="fa fa-quote-right"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-star')" class="wzbtn-table btn-basic">
									<span class="fa fa-star"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-star-o')" class="wzbtn-table btn-basic">
									<span class="fa fa-star-o"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-circle')" class="wzbtn-table btn-basic">
									<span class="fa fa-circle"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-circle-o')" class="wzbtn-table btn-basic">
									<span class="fa fa-circle-o"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-square')" class="wzbtn-table btn-basic">
									<span class="fa fa-square"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-square-o')" class="wzbtn-table btn-basic">
									<span class="fa fa-square-o"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-heart')" class="wzbtn-table btn-basic">
									<span class="fa fa-heart"></span>
								</button>
							</li>
							<li>
								<button type="button" onclick="wzEditorBullet('fa fa-heart-o')" class="wzbtn-table btn-basic">
									<span class="fa fa-heart-o"></span>
								</button>
							</li>
						</ul>
	</c:set>
	
	<c:set var="fontListKR">
						<ul class="font-list kr">
							<li><button type="button" onclick="wzEditorFontFamily('돋움,dotum,FontAwesome')" data-font="돋움,dotum,FontAwesome" style="font-family: 돋움,dotum; font-weight:bold;"><spring:message code="wzwg.site.font.msg.dotum"/></button></li>
							<li><button type="button" onclick="wzEditorFontFamily('궁서,gungsuh,gungseo,FontAwesome')" data-font="궁서,gungsuh,gungseo,FontAwesome" style="font-family: 궁서,gungsuh,gungseo; font-weight:bold;"><spring:message code="wzwg.site.font.msg.gungsuh"/></button></li>
							<li><button type="button" onclick="wzEditorFontFamily('NanumGothic,FontAwesome')"  data-font="NanumGothic,FontAwesome" style="font-family: NanumGothic; font-weight:bold;"><spring:message code="wzwg.site.font.msg.NanumGothic"/></button></li>
							<li><button type="button" onclick="wzEditorFontFamily('NanumSquareR,FontAwesome')"  data-font="NanumSquareR,FontAwesome" style="font-family: NanumSquareR; font-weight:bold;"><spring:message code="wzwg.site.font.msg.NanumSquareR"/>R</button></li>
							<li><button type="button" onclick="wzEditorFontFamily('NanumBrush,FontAwesome')"  data-font="NanumBrush,FontAwesome" style="font-family: NanumBrush; font-weight:bold;"><spring:message code="wzwg.site.font.msg.NanumBrush"/></button></li>
							<li><button type="button" onclick="wzEditorFontFamily('IropkeBatang,FontAwesome')"  data-font="IropkeBatang,FontAwesome" style="font-family: IropkeBatang; font-weight:bold;"><spring:message code="wzwg.site.font.msg.IropkeBatang"/></button></li>
						</ul>
	</c:set>
	
	
	<c:set var="textColorList">
					<ul class="color_pallet">
						<li><!-- 1. black -->
							<ul class="ul_font ul_font_reco">
								<li class="color333333"><button type="button" onclick="callTextEditorCommand('foreColor','#343434')" data-color="#343434"><label></label></button></li>
								<li class="color666666"><button type="button" onclick="callTextEditorCommand('foreColor','#666666')" data-color="#666666"><label></label></button></li>
								<li class="color595959"><button type="button" onclick="callTextEditorCommand('foreColor','#595959')" data-color="#595959"><label></label></button></li>
								<li class="color3f3f3f"><button type="button" onclick="callTextEditorCommand('foreColor','#3f3f3f')" data-color="#3f3f3f"><label></label></button></li>
								<li class="color262626"><button type="button" onclick="callTextEditorCommand('foreColor','#262626')" data-color="#262626"><label></label></button></li>
								<li class="color212121"><button type="button" onclick="callTextEditorCommand('foreColor','#212121')" data-color="#212121"><label></label></button></li>
								<li class="color000000"><button type="button" onclick="callTextEditorCommand('foreColor','#000000')" data-color="#000000"><label></label></button></li>
							</ul>
						</li>
						<li><!-- 2. white-grey -->
							<ul class="ul_font ul_font_reco">
								<li class="colorffffff"><button type="button" onclick="callTextEditorCommand('foreColor','#ffffff')" data-color="#ffffff"><label></label></button></li>
								<li class="colorf2f2f2"><button type="button" onclick="callTextEditorCommand('foreColor','#f2f2f2')" data-color="#f2f2f2"><label></label></button></li>
								<li class="colord8d8d8"><button type="button" onclick="callTextEditorCommand('foreColor','#d8d8d8')" data-color="#d8d8d8"><label></label></button></li>
								<li class="colorbfbfbf"><button type="button" onclick="callTextEditorCommand('foreColor','#bfbfbf')" data-color="#bfbfbf"><label></label></button></li>
								<li class="colora5a5a5"><button type="button" onclick="callTextEditorCommand('foreColor','#a5a5a5')" data-color="#a5a5a5"><label></label></button></li>
								<li class="color7f7f7f"><button type="button" onclick="callTextEditorCommand('foreColor','#7f7f7f')" data-color="#7f7f7f"><label></label></button></li>
								<li class="color707070"><button type="button" onclick="callTextEditorCommand('foreColor','#707070')" data-color="#707070"><label></label></button></li>
							</ul>
						</li>
						<li><!-- 3. grey -->
							<ul class="ul_font ul_font_reco">
								<li class="colora1a1a1"><button type="button" onclick="callTextEditorCommand('foreColor','#a1a1a1')" data-color="#a1a1a1"><label></label></button></li>
								<li class="colord0cece"><button type="button" onclick="callTextEditorCommand('foreColor','#d0cece')" data-color="#d0cece"><label></label></button></li>
								<li class="colorbbbbbb"><button type="button" onclick="callTextEditorCommand('foreColor','#bbbbbb')" data-color="#bbbbbb"><label></label></button></li>
								<li class="coloraeabab"><button type="button" onclick="callTextEditorCommand('foreColor','#aeabab')" data-color="#aeabab"><label></label></button></li>
								<li class="color757070"><button type="button" onclick="callTextEditorCommand('foreColor','#757070')" data-color="#757070"><label></label></button></li>
								<li class="color3a3838"><button type="button" onclick="callTextEditorCommand('foreColor','#3a3838')" data-color="#3a3838"><label></label></button></li>
								<li class="color171616"><button type="button" onclick="callTextEditorCommand('foreColor','#171616')" data-color="#171616"><label></label></button></li>
							</ul>
						</li>
			
						<li><!-- 4. purple -->
							<ul class="ul_font ul_font_reco">
								<li class="color8d47ad"><button type="button" onclick="callTextEditorCommand('foreColor','#8d47ad')" data-color="#8d47ad"><label></label></button></li>
								<li class="colorebdef6"><button type="button" onclick="callTextEditorCommand('foreColor','#ebdef6')" data-color="#ebdef6"><label></label></button></li>
								<li class="colorbb97c7"><button type="button" onclick="callTextEditorCommand('foreColor','#bb97c7')" data-color="#bb97c7"><label></label></button></li>
								<li class="color9a6baf"><button type="button" onclick="callTextEditorCommand('foreColor','#9a6baf')" data-color="#9a6baf"><label></label></button></li>
								<li class="color824f9e"><button type="button" onclick="callTextEditorCommand('foreColor','#824f9e')" data-color="#824f9e"><label></label></button></li>
								<li class="color872eb5"><button type="button" onclick="callTextEditorCommand('foreColor','#872eb5')" data-color="#872eb5"><label></label></button></li>
								<li class="color581f79"><button type="button" onclick="callTextEditorCommand('foreColor','#581f79')" data-color="#581f79"><label></label></button></li>
							</ul>
						</li>
			
						<li><!-- 5. blue -->
							<ul class="ul_font ul_font_reco">
								<li class="color0b56a7"><button type="button" onclick="callTextEditorCommand('foreColor','#0b56a7')" data-color="#0b56a7"><label></label></button></li>
								<li class="colord6dce4"><button type="button" onclick="callTextEditorCommand('foreColor','#d6dce4')" data-color="#d6dce4"><label></label></button></li>
								<li class="coloradb9ca"><button type="button" onclick="callTextEditorCommand('foreColor','#adb9ca')" data-color="#adb9ca"><label></label></button></li>
								<li class="color8eaadb"><button type="button" onclick="callTextEditorCommand('foreColor','#8eaadb')" data-color="#8eaadb"><label></label></button></li>
								<li class="color2f5496"><button type="button" onclick="callTextEditorCommand('foreColor','#2f5496')" data-color="#2f5496"><label></label></button></li>
								<li class="color323f4f"><button type="button" onclick="callTextEditorCommand('foreColor','#323f4f')" data-color="#323f4f"><label></label></button></li>
								<li class="color222a35"><button type="button" onclick="callTextEditorCommand('foreColor','#222a35')" data-color="#222a35"><label></label></button></li>
							</ul>
						</li>
						
						<li><!-- 6. green -->
							<ul class="ul_font ul_font_reco">
								<li class="color4a8205"><button type="button" onclick="callTextEditorCommand('foreColor','#4a8205')" data-color="#4a8205"><label></label></button></li>
								<li class="colorf1f8ec"><button type="button" onclick="callTextEditorCommand('foreColor','#f1f8ec')" data-color="#f1f8ec"><label></label></button></li>
								<li class="colorc5e0b3"><button type="button" onclick="callTextEditorCommand('foreColor','#c5e0b3')" data-color="#c5e0b3"><label></label></button></li>
								<li class="color8ebf6d"><button type="button" onclick="callTextEditorCommand('foreColor','#8ebf6d')" data-color="#8ebf6d"><label></label></button></li>
								<li class="color64a13c"><button type="button" onclick="callTextEditorCommand('foreColor','#64a13c')" data-color="#64a13c"><label></label></button></li>
								<li class="color538135"><button type="button" onclick="callTextEditorCommand('foreColor','#538135')" data-color="#538135"><label></label></button></li>
								<li class="color375623"><button type="button" onclick="callTextEditorCommand('foreColor','#375623')" data-color="#375623"><label></label></button></li>
							</ul>
						</li>
						<li><!-- 7. yellow -->
							<ul class="ul_font ul_font_reco">
								<li class="colorefc127"><button type="button" onclick="callTextEditorCommand('foreColor','#efc127')" data-color="#efc127"><label></label></button></li>
								<li class="colorfcf8eb"><button type="button" onclick="callTextEditorCommand('foreColor','#fcf8eb')" data-color="#fcf8eb"><label></label></button></li>
								<li class="colorfff2cc"><button type="button" onclick="callTextEditorCommand('foreColor','#fff2cc')" data-color="#fff2cc"><label></label></button></li>
								<li class="colorf1d88c"><button type="button" onclick="callTextEditorCommand('foreColor','#f1d88c')" data-color="#f1d88c"><label></label></button></li>
								<li class="colore3bb43"><button type="button" onclick="callTextEditorCommand('foreColor','#e3bb43')" data-color="#e3bb43"><label></label></button></li>
								<li class="colorbf9000"><button type="button" onclick="callTextEditorCommand('foreColor','#bf9000')" data-color="#bf9000"><label></label></button></li>
								<li class="color7f6000"><button type="button" onclick="callTextEditorCommand('foreColor','#7f6000')" data-color="#7f6000"><label></label></button></li>
							</ul>
						</li>
						<li><!-- 8. orange -->
							<ul class="ul_font ul_font_reco">
								<li class="colorf7630d"><button type="button" onclick="callTextEditorCommand('foreColor','#f7630d')" data-color="#f7630d"><label></label></button></li>
								<li class="colorfdf0e7"><button type="button" onclick="callTextEditorCommand('foreColor','#fdf0e7')" data-color="#fdf0e7"><label></label></button></li>
								<li class="colorf4dac7"><button type="button" onclick="callTextEditorCommand('foreColor','#f4dac7')" data-color="#f4dac7"><label></label></button></li>
								<li class="colorf7cbac"><button type="button" onclick="callTextEditorCommand('foreColor','#f7cbac')" data-color="#f7cbac"><label></label></button></li>
								<li class="colorf4b183"><button type="button" onclick="callTextEditorCommand('foreColor','#f4b183')" data-color="#f4b183"><label></label></button></li>
								<li class="colord96a1e"><button type="button" onclick="callTextEditorCommand('foreColor','#d96a1e')" data-color="#d96a1e"><label></label></button></li>
								<li class="color833c0b"><button type="button" onclick="callTextEditorCommand('foreColor','#833c0b')" data-color="#833c0b"><label></label></button></li>
							</ul>
						</li>
						<li><!-- 9.pink -->
							<ul class="ul_font ul_font_reco">
								<li class="colore64856"><button type="button" onclick="callTextEditorCommand('foreColor','#e64856')" data-color="#e64856"><label></label></button></li>
								<li class="colorf0e7ec"><button type="button" onclick="callTextEditorCommand('foreColor','#f0e7ec')" data-color="#f0e7ec"><label></label></button></li>
								<li class="colorf8c3c5"><button type="button" onclick="callTextEditorCommand('foreColor','#f8c3c5')" data-color="#f8c3c5"><label></label></button></li>
								<li class="colorf9a7ab"><button type="button" onclick="callTextEditorCommand('foreColor','#f9a7ab')" data-color="#f9a7ab"><label></label></button></li>
								<li class="colorf28183"><button type="button" onclick="callTextEditorCommand('foreColor','#f28183')" data-color="#f28183"><label></label></button></li>
								<li class="colorea2364"><button type="button" onclick="callTextEditorCommand('foreColor','#ea2364')" data-color="#ea2364"><label></label></button></li>
								<li class="colorc40052"><button type="button" onclick="callTextEditorCommand('foreColor','#c40052')" data-color="#c40052"><label></label></button></li>
							</ul>
						</li>
						<li><!-- 10.red -->
							<ul class="ul_font ul_font_reco">
								<li class="colorc80000"><button type="button" onclick="callTextEditorCommand('foreColor','#c80000')" data-color="#c80000"><label></label></button></li>
								<li class="coloreee4e4"><button type="button" onclick="callTextEditorCommand('foreColor','#eee4e4')" data-color="#eee4e4"><label></label></button></li>
								<li class="colorfbd5d5"><button type="button" onclick="callTextEditorCommand('foreColor','#fbd5d5')" data-color="#fbd5d5"><label></label></button></li>
								<li class="colorf7acac"><button type="button" onclick="callTextEditorCommand('foreColor','#f7acac')" data-color="#f7acac"><label></label></button></li>
								<li class="coloref5658"><button type="button" onclick="callTextEditorCommand('foreColor','#ef5658')" data-color="#ef5658"><label></label></button></li>
								<li class="colorce1313"><button type="button" onclick="callTextEditorCommand('foreColor','#ce1313')" data-color="#ce1313"><label></label></button></li>
								<li class="color830b0b"><button type="button" onclick="callTextEditorCommand('foreColor','#830b0b')" data-color="#830b0b"><label></label></button></li>
							</ul>
						</li>
					</ul>
	
	</c:set>
	
	<div style="display: none">
		<div id="wzEditorBGControll">
					<div id="cellBgTargetBox" style="display: none;">
						<p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG076"/></p>
						<ul>
							<li><label><input type="radio" name="cellBgTarget" value="this" checked="checked"><spring:message code="wzwg.site.screen.msg.MSG077"/></label></li>
							<li><label><input type="radio" name="cellBgTarget" value="row"><spring:message code="wzwg.site.screen.msg.MSG078"/></label></li>
							<li><label><input type="radio" name="cellBgTarget" value="vertical"><spring:message code="wzwg.site.screen.msg.MSG079"/></label></li>
						</ul>
					</div> 
					<p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG080"/></p>
					<ul class="ul_bg ul_bg_basic" style="width: 98%;">
						<li class="colorffffff wzEdtGbCurrColor" style="background-color: rgb(116, 194, 214);">
							<button type="button" name="bg_color" value="" id="wzEdtGb_color" onclick="wzEditorTextBgCol($('.wzEdtGbCurrColor').css('background-color'))">
							<label style="text-shadow: 0px 0px 2px rgba(0,0,0,1);color: #ffffff;"><spring:message code="wzwg.site.screen.msg.MSG054" /></label>
							</button>
						</li>
						<li class="colorffffff"><button type="button" name="bg_color" value="#ffffff" id="wzEdtGb_ffffff" onclick="wzEditorTextBgCol(this.value)"><label><spring:message code="wzwg.cmm.word.whiteclr" /></label></button></li>
						<li class="colorblack" ><button type="button" name="bg_color" class="fontwhite" value="#343434" id="wzEdtGb_333333" onclick="wzEditorTextBgCol(this.value)"><label><spring:message code="wzwg.cmm.word.blackclr" /></label></button></li>
						<li class="colorffffff"><button type="button" name="bg_color" value="rgba(0,0,0,0)" id="wzEdtGb_invisible" onclick="wzEditorTextBgCol(this.value)"><label><spring:message code="wzwg.cmm.word.trnsprcclr" /></label></button></li>
					</ul>
					
					<!-- 추천 색상 -->
					<p class="bg_reco"><spring:message code="wzwg.site.screen.msg.MSG041" /> </p>
					<ul class="color_pallet">
						<li><!-- 1. black -->
							<ul class="ul_bg ul_bg_reco">
								<li class="color333333"><button type="button" name="bg_color" value="#343434" id="wzEdtGb_333333" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="color666666"><button type="button" name="bg_color" value="#666666" id="wzEdtGb_666666" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="color595959"><button type="button" name="bg_color" value="#595959" id="wzEdtGb_595959" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="color3f3f3f"><button type="button" name="bg_color" value="#3f3f3f" id="wzEdtGb_3f3f3f" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="color262626"><button type="button" name="bg_color" value="#262626" id="wzEdtGb_262626" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="color212121"><button type="button" name="bg_color" value="#212121" id="wzEdtGb_212121" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="color000000"><button type="button" name="bg_color" value="#000000" id="wzEdtGb_000000" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
							</ul>
						</li>
						<li><!-- 2. white-grey -->
							<ul class="ul_bg ul_bg_reco">
								<li class="colorffffff"><button type="button" name="bg_color" value="#ffffff" id="wzEdtGb_ffffff" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="colorf2f2f2"><button type="button" name="bg_color" value="#f2f2f2" id="wzEdtGb_f2f2f2" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="colord8d8d8"><button type="button" name="bg_color" value="#d8d8d8" id="wzEdtGb_d8d8d8" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="colorbfbfbf"><button type="button" name="bg_color" value="#bfbfbf" id="wzEdtGb_bfbfbf" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="colora5a5a5"><button type="button" name="bg_color" value="#a5a5a5" id="wzEdtGb_a5a5a5" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="color7f7f7f"><button type="button" name="bg_color" value="#7f7f7f" id="wzEdtGb_7f7f7f" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="color707070"><button type="button" name="bg_color" value="#707070" id="wzEdtGb_707070" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
							</ul>
						</li>
						<li><!-- 3. grey -->
							<ul class="ul_bg ul_bg_reco">
								<li class="colora1a1a1"><button type="button" name="bg_color" value="#a1a1a1" id="wzEdtGb_a1a1a1" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="colord0cece"><button type="button" name="bg_color" value="#d0cece" id="wzEdtGb_d0cece" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="colorbbbbbb"><button type="button" name="bg_color" value="#bbbbbb" id="wzEdtGb_bbbbbb" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="coloraeabab"><button type="button" name="bg_color" value="#aeabab" id="wzEdtGb_aeabab" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="color757070"><button type="button" name="bg_color" value="#757070" id="wzEdtGb_757070" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="color3a3838"><button type="button" name="bg_color" value="#3a3838" id="wzEdtGb_3a3838" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="color171616"><button type="button" name="bg_color" value="#171616" id="wzEdtGb_171616" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
							</ul>
						</li>
			
						<li><!-- 4. purple -->
							<ul class="ul_bg ul_bg_reco">
								<li class="color8d47ad"><button type="button" name="bg_color" value="#8d47ad" id="wzEdtGb_8d47ad" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="colorebdef6"><button type="button" name="bg_color" value="#ebdef6" id="wzEdtGb_ebdef6" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="colorbb97c7"><button type="button" name="bg_color" value="#bb97c7" id="wzEdtGb_bb97c7" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="color9a6baf"><button type="button" name="bg_color" value="#9a6baf" id="wzEdtGb_9a6baf" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="color824f9e"><button type="button" name="bg_color" value="#824f9e" id="wzEdtGb_824f9e" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="color872eb5"><button type="button" name="bg_color" value="#872eb5" id="wzEdtGb_872eb5" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="color581f79"><button type="button" name="bg_color" value="#581f79" id="wzEdtGb_581f79" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
							</ul>
						</li>
			
						<li><!-- 5. blue -->
							<ul class="ul_bg ul_bg_reco">
								<li class="color0b56a7"><button type="button" name="bg_color" value="#0b56a7" id="wzEdtGb_0b56a7" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="colord6dce4"><button type="button" name="bg_color" value="#d6dce4" id="wzEdtGb_d6dce4" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="coloradb9ca"><button type="button" name="bg_color" value="#adb9ca" id="wzEdtGb_adb9ca" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="color8eaadb"><button type="button" name="bg_color" value="#8eaadb" id="wzEdtGb_8eaadb" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="color2f5496"><button type="button" name="bg_color" value="#2f5496" id="wzEdtGb_2f5496" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="color323f4f"><button type="button" name="bg_color" value="#323f4f" id="wzEdtGb_323f4f" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="color222a35"><button type="button" name="bg_color" value="#222a35" id="wzEdtGb_222a35" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
							</ul>
						</li>
						
						<li><!-- 6. green -->
							<ul class="ul_bg ul_bg_reco">
								<li class="color4a8205"><button type="button" name="bg_color" value="#4a8205" id="wzEdtGb_4a8205" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="colorf1f8ec"><button type="button" name="bg_color" value="#f1f8ec" id="wzEdtGb_f1f8ec" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="colorc5e0b3"><button type="button" name="bg_color" value="#c5e0b3" id="wzEdtGb_c5e0b3" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="color8ebf6d"><button type="button" name="bg_color" value="#8ebf6d" id="wzEdtGb_8ebf6d" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="color64a13c"><button type="button" name="bg_color" value="#64a13c" id="wzEdtGb_64a13c" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="color538135"><button type="button" name="bg_color" value="#538135" id="wzEdtGb_538135" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="color375623"><button type="button" name="bg_color" value="#375623" id="wzEdtGb_375623" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
							</ul>
						</li>
						<li><!-- 7. yellow -->
							<ul class="ul_bg ul_bg_reco">
								<li class="colorefc127"><button type="button" name="bg_color" value="#efc127" id="wzEdtGb_efc127" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="colorfcf8eb"><button type="button" name="bg_color" value="#fcf8eb" id="wzEdtGb_fcf8eb" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="colorfff2cc"><button type="button" name="bg_color" value="#fff2cc" id="wzEdtGb_fff2cc" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="colorf1d88c"><button type="button" name="bg_color" value="#f1d88c" id="wzEdtGb_f1d88c" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="colore3bb43"><button type="button" name="bg_color" value="#e3bb43" id="wzEdtGb_e3bb43" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="colorbf9000"><button type="button" name="bg_color" value="#bf9000" id="wzEdtGb_bf9000" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="color7f6000"><button type="button" name="bg_color" value="#7f6000" id="wzEdtGb_7f6000" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
							</ul>
						</li>
						<li><!-- 8. orange -->
							<ul class="ul_bg ul_bg_reco">
								<li class="colorf7630d"><button type="button" name="bg_color" value="#f7630d" id="wzEdtGb_f7630d" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="colorfdf0e7"><button type="button" name="bg_color" value="#fdf0e7" id="wzEdtGb_fdf0e7" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="colorf4dac7"><button type="button" name="bg_color" value="#f4dac7" id="wzEdtGb_f4dac7" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="colorf7cbac"><button type="button" name="bg_color" value="#f7cbac" id="wzEdtGb_f7cbac" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="colorf4b183"><button type="button" name="bg_color" value="#f4b183" id="wzEdtGb_f4b183" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="colord96a1e"><button type="button" name="bg_color" value="#d96a1e" id="wzEdtGb_d96a1e" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="color833c0b"><button type="button" name="bg_color" value="#833c0b" id="wzEdtGb_833c0b" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
							</ul>
						</li>
						<li><!-- 9.pink -->
							<ul class="ul_bg ul_bg_reco">
								<li class="colore64856"><button type="button" name="bg_color" value="#e64856" id="wzEdtGb_e64856" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="colorf0e7ec"><button type="button" name="bg_color" value="#f0e7ec" id="wzEdtGb_f0e7ec" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="colorf8c3c5"><button type="button" name="bg_color" value="#f8c3c5" id="wzEdtGb_f8c3c5" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="colorf9a7ab"><button type="button" name="bg_color" value="#f9a7ab" id="wzEdtGb_f9a7ab" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="colorf28183"><button type="button" name="bg_color" value="#f28183" id="wzEdtGb_f28183" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="colorea2364"><button type="button" name="bg_color" value="#ea2364" id="wzEdtGb_ea2364" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
								<li class="colorc40052"><button type="button" name="bg_color" value="#c40052" id="wzEdtGb_c40052" onclick="wzEditorTextBgCol(this.value)"><label></label></button></li>
							</ul>
						</li>
						<li><!-- 10.red -->
							<ul class="ul_bg ul_bg_reco">
								<li class="colorc80000"><button type="button" name="bg_color" value="#c80000" id="wzEdtGb_c80000" onclick="wzEditorTextBgCol(this.value)"><label></label></button> </li>
								<li class="coloreee4e4"><button type="button" name="bg_color" value="#eee4e4" id="wzEdtGb_eee4e4" onclick="wzEditorTextBgCol(this.value)"><label></label></button> </li>
								<li class="colorfbd5d5"><button type="button" name="bg_color" value="#fbd5d5" id="wzEdtGb_fbd5d5" onclick="wzEditorTextBgCol(this.value)"><label></label></button> </li>
								<li class="colorf7acac"><button type="button" name="bg_color" value="#f7acac" id="wzEdtGb_f7acac" onclick="wzEditorTextBgCol(this.value)"><label></label></button> </li>
								<li class="coloref5658"><button type="button" name="bg_color" value="#ef5658" id="wzEdtGb_ef5658" onclick="wzEditorTextBgCol(this.value)"><label></label></button> </li>
								<li class="colorce1313"><button type="button" name="bg_color" value="#ce1313" id="wzEdtGb_ce1313" onclick="wzEditorTextBgCol(this.value)"><label></label></button> </li>
								<li class="color830b0b"><button type="button" name="bg_color" value="#830b0b" id="wzEdtGb_830b0b" onclick="wzEditorTextBgCol(this.value)"><label></label></button> </li>
							</ul>
						</li>
					</ul>
			
			
					<div>
						<p class="bg_reco"><spring:message code="wzwg.site.screen.msg.MSG056" /></p>
						<input type="range" id="wzEdtGbRange" value="255" min="0" max="100" class="w70 pl10 pr10 br-none" step="10" onchange="$('#wzEdtGbRangeValue').html($(this).val() + '%');">
						<span id="wzEdtGbRangeValue" class="wz-box br3 ml15 p5 br-grey" style="width: 40px; display: inline-block; text-align: right;">100%</span>
					</div>
					
					<div><p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG068" /></p>
						<input type="text" id="wzEdtGbCustomCol" >
						<button class="wzbtn-table btn-basic" onclick="callTextEditorCommand('backColor',$('#wzEdtGbCustomCol').val());$('.wzEditTarget').focus();" style="padding: 0 10px;"><spring:message code="wzwg.cmm.word.applc" /></button> 
					</div>
		</div><!-- end wzEditorBgController -->
		
		
		<div id="wzEditorLinkSelector">
					<div class="linkSelect pop_link">
						<p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG075"/></p>
						<ul class="linkMenuList" >
							   
						<c:choose>
							<c:when test="${subPrefix eq '/subMngr' or subPrefix eq '/subsite' }">
								<c:forEach items="${menuList}" var="oneDepth" varStatus="status">
									<c:if test="${empty oneDepth.upperMenuSeq or oneDepth.upperMenuSeq eq '0' }">
										<li>
										 <c:choose>
										 	<c:when test="${oneDepth.sysmoduleSeq eq '0' }">
										 		<a href="javascript:void(0);" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${oneDepth.menuNm }"/></a>
										 	</c:when>
										 	<c:when test="${oneDepth.sysmoduleSeq eq '99999999999' }">
										 		<a href="javascript:void(0);" onclick="$('#wzEditorUrl').val('<c:out value="${oneDepth.menuLinkUrl}"/>');" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${oneDepth.menuNm }"/></a>
										 	</c:when>
										 	<c:otherwise>
										 		<a href="javascript:void(0);" onclick="$('#wzEditorUrl').val('/subsite/<c:out value="${subsiteKey}"/>/subList/<c:out value="${oneDepth.menuLinkSeq}"/>');" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${oneDepth.menuNm }"/></a>	
										 	</c:otherwise>
										 </c:choose>
											<ul>
											<c:forEach items="${menuList}" var="twoDepth" varStatus="status">
											<c:if test="${oneDepth.menuSeq eq twoDepth.upperMenuSeq}">
												<li>
													<c:choose>
													 	<c:when test="${twoDepth.sysmoduleSeq eq '0' }">
													 		<a href="javascript:void(0);"  data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${twoDepth.menuNm }"/></a>
													 	</c:when>
													 	<c:when test="${twoDepth.sysmoduleSeq eq '99999999999'}">
													 		<a href="javascript:void(0);" onclick="$('#wzEditorUrl').val('<c:out value="${twoDepth.menuLinkUrl}"/>');"  data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${twoDepth.menuNm }"/></a>
													 	</c:when>
													 	<c:otherwise>
													 		<a href="javascript:void(0);" onclick="$('#wzEditorUrl').val('<c:out value="${wzwg_contextPath}"/>/subsite/<c:out value="${subsiteKey}"/>/subList/<c:out value="${oneDepth.menuLinkSeq}"/>');" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${twoDepth.menuNm }"/></a>	
													 	</c:otherwise>
													 </c:choose>
							                        
													<ul>
													<c:forEach items="${menuList}" var="threeDepth" varStatus="status">
													  <c:if test="${twoDepth.menuSeq eq threeDepth.upperMenuSeq}"> 
														<li>
														<c:choose>
														 	<c:when test="${threeDepth.sysmoduleSeq eq '0' }">
														 		<a href="javascript:void(0);"  data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${threeDepth.menuNm }"/></a>
														 	</c:when>
														 	<c:when test="${threeDepth.sysmoduleSeq eq '99999999999'}">
														 		<a href="javascript:void(0);" onclick="$('#wzEditorUrl').val('<c:out value="${threeDepth.menuLinkUrl}"/>');" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${threeDepth.menuNm }"/></a>
														 	</c:when>
														 	<c:otherwise>
														 		<a href="javascript:void(0);" onclick="$('#wzEditorUrl').val('<c:out value="${wzwg_contextPath}"/>/subsite/<c:out value="${subsiteKey}"/>/subList/<c:out value="${oneDepth.menuLinkSeq}"/>');" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${threeDepth.menuNm }"/></a>	
														 	</c:otherwise>
														 </c:choose>
				
														</li>
													</c:if>
													</c:forEach>
													</ul>
												</li>
											</c:if>
											</c:forEach>	 
											</ul>  
										</li>   
									</c:if>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<c:forEach items="${menuList}" var="oneDepth" varStatus="status">
									<c:if test="${empty oneDepth.upperMenuSeq or oneDepth.upperMenuSeq eq '0' }">
										<li>
										 <c:choose>
										 	<c:when test="${oneDepth.menuDivision eq 'group' }">
										 		<a href="javascript:void(0);" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${oneDepth.menuNm }"/></a>
										 	</c:when>
										 	<c:when test="${oneDepth.menuDivision eq 'link'}">
										 		<a href="javascript:void(0);" onclick="$('#wzEditorUrl').val('<c:out value="${oneDepth.menuLinkUrl}"/>'); $('#wzEditorUrl').attr('data-title', '<c:out value="${oneDepth.menuNm }"/>');" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${oneDepth.menuNm }"/></a>
										 	</c:when>
										 	<c:otherwise>
										 		<a href="javascript:void(0);" onclick="$('#wzEditorUrl').val('<c:out value="${wzwg_contextPath}"/>/subList/<c:out value="${oneDepth.menuLinkSeq}"/>'); $('#wzEditorUrl').attr('data-title', '<c:out value="${oneDepth.menuNm }"/>');" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${oneDepth.menuNm }"/></a>	
										 	</c:otherwise>
										 </c:choose>
											<ul>
											<c:forEach items="${menuList}" var="twoDepth" varStatus="status">
											<c:if test="${oneDepth.menuSeq eq twoDepth.upperMenuSeq}">
												<li>
													<c:choose>
													 	<c:when test="${twoDepth.menuDivision eq 'group' }">
													 		<a href="javascript:void(0);"  data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${twoDepth.menuNm }"/></a>
													 	</c:when>
													 	<c:when test="${twoDepth.menuDivision eq 'link'}">
													 		<a href="javascript:void(0);" onclick="$('#wzEditorUrl').val('<c:out value="${twoDepth.menuLinkUrl}"/>'); $('#wzEditorUrl').attr('data-title', '<c:out value="${twoDepth.menuNm }"/>');"  data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${twoDepth.menuNm }"/></a>
													 	</c:when>
													 	<c:otherwise>
													 		<a href="javascript:void(0);" onclick="$('#wzEditorUrl').val('<c:out value="${wzwg_contextPath}"/>/subList/<c:out value="${twoDepth.menuLinkSeq}"/>'); $('#wzEditorUrl').attr('data-title', '<c:out value="${twoDepth.menuNm }"/>');" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${twoDepth.menuNm }"/></a>	
													 	</c:otherwise>
													 </c:choose>
							                        
													<ul>
													<c:forEach items="${menuList}" var="threeDepth" varStatus="status">
													  <c:if test="${twoDepth.menuSeq eq threeDepth.upperMenuSeq}"> 
														<li>
														<c:choose>
														 	<c:when test="${threeDepth.menuDivision eq 'group' }">
														 		<a href="javascript:void(0);"  data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${threeDepth.menuNm }"/></a>
														 	</c:when>
														 	<c:when test="${threeDepth.menuDivision eq 'link'}">
														 		<a href="javascript:void(0);" onclick="$('#wzEditorUrl').val('<c:out value="${threeDepth.menuLinkUrl}"/>'); $('#wzEditorUrl').attr('data-title', '<c:out value="${threeDepth.menuNm }"/>');" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${threeDepth.menuNm }"/></a>
														 	</c:when>
														 	<c:otherwise>
														 		<a href="javascript:void(0);" onclick="$('#wzEditorUrl').val('<c:out value="${wzwg_contextPath}"/>/subList/<c:out value="${threeDepth.menuLinkSeq}"/>'); $('#wzEditorUrl').attr('data-title', '<c:out value="${threeDepth.menuNm }"/>');" data-href="menuLinkSeq" data-attr="menuNm"><c:out value="${threeDepth.menuNm }"/></a>	
														 	</c:otherwise>
														 </c:choose>
				
														</li>
													</c:if>
													</c:forEach>
													</ul>
												</li>
											</c:if>
											</c:forEach>	 
											</ul>  
										</li>   
									</c:if>
								</c:forEach>
							</c:otherwise>
						</c:choose>
						</ul>
					</div>
					<p>
						<span>url :</span> <input type="text" name="wzEditorUrl" id="wzEditorUrl"  value=""/>
					</p>
					target :<select id="wzEditorLinkTarget" name="wzEditorLinkTarget">
						<option value="_self"><spring:message code="wzwg.cmm.word.nowwin" /></option>
						<option value="_blank"><spring:message code="wzwg.cmm.word.newwin" /></option>
					</select> 
		</div>
		
		
		
	</div><!-- end display none -->
	
	
	<div id="wzEditorDialog" title="WIZWIG - EDITOR" style="z-index:999;">
		<div class="wzEditor">
			<div class="wzEditor-command">
				<p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG089"/></p>
				<div class="tools">
					<div class="wzbtn-group">
						<!-- <span class="wzbtn-table btn-basic" ><i class="fa fa-font"></i></span> -->
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorTap('fontStyle')"  >Font</button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorTap('fontSize')" >Size</button>
					</div>
					<div class="wzbtn-group">
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="callTextEditorCommand('bold',null)"  title="<spring:message code="wzwg.site.screen.msg.MSG182"/>"><i class="fa fa-bold"></i></button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="callTextEditorCommand('italic', null)"  title="<spring:message code="wzwg.site.screen.msg.MSG181"/>"><i class="fa fa-italic"></i></button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="callTextEditorCommand('strikethrough', null)"  title="<spring:message code="wzwg.site.screen.msg.MSG180"/>"><i class="fa fa-strikethrough"></i></button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="callTextEditorCommand('underline', null)"  title="<spring:message code="wzwg.site.screen.msg.MSG179"/>"><i class="fa fa-underline"></i></button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorTap('lineHeight')"  title="<spring:message code="wzwg.site.screen.msg.MSG178"/>"><i class="fa fa-text-height"></i></button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorNewParagraph()"  title="<spring:message code="wzwg.site.screen.msg.MSG177"/>"><i class="fa fa-level-down"></i></button>
					</div>
					<div class="wzbtn-group">
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="callTextEditorCommand('justifyCenter')"  title="<spring:message code="wzwg.cmm.word.scrin.alignCenter"/>"><i class="fa fa-align-center"></i></button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="callTextEditorCommand('justifyFull')"  title="<spring:message code="wzwg.cmm.word.scrin.alignFull"/>"><i class="fa fa-align-justify"></i></button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="callTextEditorCommand('justifyLeft')"  title="<spring:message code="wzwg.cmm.word.scrin.alignLeft"/>"><i class="fa fa-align-left"></i></button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="callTextEditorCommand('justifyRight')"  title="<spring:message code="wzwg.cmm.word.scrin.alignRight"/>"><i class="fa fa-align-right"></i></button>
					</div>
					<div class="wzbtn-group">
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorTap('foreColor')"  title="<spring:message code="wzwg.site.screen.msg.MSG175"/>"><i class="fa fa-pencil"></i></button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorTap('bgColor');wzEditorChangeBgMode('text');"  title="<spring:message code="wzwg.site.screen.msg.MSG174"/>"><i class="fa fa-at"></i></button>
					</div>
					<!-- <div class="wzbtn-group">
						<span class="wzbtn-table btn-basic bg-grey" style="padding: 0 8px;line-height: 25px;height: 25px;font-size: 1em;cursor: default;">Table :</span>
						
						<button type="button" class="wzbtn-table btn-basic" onclick="wzEditorTap('tableStyle')"  title="<spring:message code="wzwg.site.screen.msg.MSG176"/>">Style</button>
					</div> -->
					<div class="wzbtn-group">
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorTap('menuLink')"  title="<spring:message code="wzwg.site.screen.msg.MSG075"/>"><i class="fa fa-link"></i></button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="callTextEditorCommand('unlink')"  title="<spring:message code="wzwg.site.screen.msg.MSG086"/>"><i class="fa fa-unlink"></i></button>
						<!-- <button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="alert('<spring:message code="wzwg.site.screen.msg.MSG171"/>\n<spring:message code="wzwg.cmm.word.fileStore"/>')"  title="<spring:message code="wzwg.site.screen.msg.MSG172"/>"><i class="fa fa-file"></i></button> -->
						<!-- <button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="alert('<spring:message code="wzwg.site.screen.msg.MSG171"/>\n<spring:message code="wzwg.cmm.word.imageStoree"/>')"  title="<spring:message code="wzwg.site.screen.msg.MSG173"/>"><i class="fa fa-image"></i></button> -->
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorTap('bullet')"  title="<spring:message code="wzwg.site.screen.msg.MSG169"/>"><i class="fa fa-circle"></i></button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorAddBtn()"  title="<spring:message code="wzwg.site.screen.msg.MSG168"/>">Add Button</button>
					</div>
					
					<div class="wzbtn-group " id="tableCtrlGrp">
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorChangeTableCell('th');"  title="<spring:message code="wzwg.site.screen.msg.MSG167"/>">TH</button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorChangeTableCell('td');;"  title="<spring:message code="wzwg.site.screen.msg.MSG166"/>">TD</button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorTap('bgColor');wzEditorChangeBgMode('table');"  title="<spring:message code="wzwg.site.screen.msg.MSG165"/>">Cell BG</button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorTap('tableCellWidth');wzEditorTableWidthInpSet();"  title="<spring:message code="wzwg.site.screen.msg.MSG164"/>">WIDTH</button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorDialChangeFrame();"  title="<spring:message code="wzwg.site.screen.msg.MSG163"/>">Frame</button>
					</div>
				</div>
			</div>
			
			
			
			
			
			
			<div class="wzEditor-contents">
				<div class="wzEditor-func fontStyle">
					<div>
						<p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG073"/></p>
						<c:out value="${fontListKR }" escapeXml="false"/>
					</div>
					<button type="button" onclick="wzEditorFontFamily('')"  ><spring:message code="wzwg.site.screen.msg.MSG074"/></button>
				</div>
				
				
				
				
				
				<div class="wzEditor-func fontSize">
					<div>
						<p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG090"/></p>
						<ul class="font-list">
							<li class="i-block"><button type="button" onclick="wzEditorFontSize('minus')" class="wzbtn-table btn-basic cntlBtn"><i class="fa fa-minus"></i></button></li>
							<li class="i-block"><button type="button" onclick="wzEditorFontSize('plus')" class="wzbtn-table btn-basic cntlBtn"><i class="fa fa-plus"></i></button></li>
						</ul>
					</div>
				</div>
				
				
				
				<div class="wzEditor-func lineHeight">
					<div>
						<p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG082"/></p>
						<ul class="font-list">
							<li class="i-block"><button type="button" onclick="wzEditorLineHeight('minus')" class="wzbtn-table btn-basic cntlBtn"><i class="fa fa-minus"></i></button></li>
							<li class="i-block"><button type="button" onclick="wzEditorLineHeight('plus')" class="wzbtn-table btn-basic cntlBtn"><i class="fa fa-plus"></i></button></li>
						</ul>
					</div>
				</div>
				
				
				
				
				
				<div class="wzEditor-func foreColor"> 
					<p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG092"/></p>
					<c:out value="${textColorList}" escapeXml="false"/>
					<div><p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG068" /></p>
						<input type="text" id="editTextCustomCol" >
						<button class="wzbtn-table btn-basic" onclick="callTextEditorCommand('foreColor',$('#editTextCustomCol').val());$('.wzEditTarget').focus();" style="padding: 0 10px;"><spring:message code="wzwg.cmm.word.applc" /></button> 
					</div>
				</div><!-- end foreColor -->
				
				
				
				
				
				
				<div class="wzEditor-func bgColor">
					
					
				</div><!-- end bgColor -->
				
				
				
				
				
				
				<div class="wzEditor-func menuLink"> 
					
					
					<a href="javascript:;" class="ui-button ui-widget ui-corner-all" onclick="wzEditorConvertLink()"><spring:message code="wzwg.cmm.word.applc" /></a>
				</div><!-- end menuLink -->
				
				
				
				
				
				
				<!-- <div class="wzEditor-func button">
					<div class="button-pannel">
						<p class="font_reco">버튼스타일</p>
						<button type="button" onclick="wzEditorAddBtn()">버튼추가</button>
						<ul class="font-list">
							<li><button type="button" onclick="wzEditorFontSize(12)">작게</button></li>
							<li><button type="button" onclick="wzEditorFontSize(14)">보통</button></li>
							<li><button type="button" onclick="wzEditorFontSize(18)">크게</button></li>
						</ul>
					</div>
				</div> -->
				
				
				
				
				
				
				<div class="wzEditor-func bullet">
					<div>
						<p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG102"/></p>
							<c:out value="${bulletList }" escapeXml="false"/>
					</div>
					<!-- <div>
						<p class="font_reco">CSS 불렛</p>
						<ul class="font-list">
							<li><button type="button" >준비중입니다</button></li>
						</ul>
					</div> -->
				</div>
				
				<div class="wzEditor-func tableCellWidth">
					<div>
						<p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG164="/> <button type="button" class="wzbtn-table btn-basic fr icoBtn" onclick="wzEditorTableWidthInpSet()"><i class="fa fa-refresh"></i></button></p>
						<ul class="table-width-controll">
							<li>
							<input type="number" class="w40" id="wzEditorTableWidthInp">
							<span>
								<label class="ml5"><input type="radio" name="wzEditorTableWidthType" checked="checked" value="%" onclick="$('#wzEditorTableWidthInp').removeAttr('disabled')"> %</label>
								<label class="ml5"><input type="radio" name="wzEditorTableWidthType" value="px" onclick="$('#wzEditorTableWidthInp').removeAttr('disabled')"> PX</label>
								<label class="ml5"><input type="radio" name="wzEditorTableWidthType" value="auto" onclick="$('#wzEditorTableWidthInp').attr('disabled', 'disabled')"> AUTO</label>
							</span>
							</li>
							<li><button type="button" class="wzbtn-table btn-save wzbtn-block cntlBtn" onclick="wzEditorTableWidthAccept()"><spring:message code="wzwg.cmm.word.applc" /></button></li>
							<li class="wz_tableguide wz-box br-grey">
								<p>※ <spring:message code="wzwg.site.screen.msg.MSG069"/></p>
								<p>※ <spring:message code="wzwg.site.screen.msg.MSG070"/></p>
								<p>※ <spring:message code="wzwg.site.screen.msg.MSG071"/></p>
							</li>
						</ul>
					</div>
					
				</div>
				
				
			</div><!-- end wzEditor-contents -->
			
		</div><!-- end wzEditor -->
	</div><!-- end dialog -->
	
	<div id="wzEditorBtnDialog" title="WIZWIG - EDITOR (BUTTON)" style="z-index:999;">
		<div class="wzEditor">
			<div class="wzEditor-command">
				<p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG089"/></p>
				<div class="tools">
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorBtnTap('textEdit');wzEditorChangeBtnTextMode()"  >Text</button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorBtnTap('fontStyle');wzEditorChangeFontMode('button')"  >Font</button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorChangeBtnTextModeBold()"  title="<spring:message code="wzwg.site.screen.msg.MSG081"/>"><i class="fa fa-bold"></i></button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorBtnTap('fontSize')" >Size</button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorBtnTap('lineHeight')"  title="<spring:message code="wzwg.site.screen.msg.MSG082"/>"><i class="fa fa-text-height"></i></button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorBtnTap('foreColor');wzEditorChangeBtnTextColMode('button')"  title="<spring:message code="wzwg.site.screen.msg.MSG083"/>"><i class="fa fa-pencil"></i></button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorBtnTap('bgColor');wzEditorChangeBtnStyleMode()"  title="<spring:message code="wzwg.site.screen.msg.MSG084"/>">Style</button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorBtnTap('corner');"  title="<spring:message code="wzwg.site.screen.msg.MSG085"/>">Rounded corner</button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorBtnTap('menuLink')"  title="<spring:message code="wzwg.site.screen.msg.MSG075"/>"><i class="fa fa-link"></i></button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorBtnUnLink()"  title="<spring:message code="wzwg.site.screen.msg.MSG086"/>"><i class="fa fa-unlink"></i></button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEidtorFileStore($('.wzEditBtnTarget'))"  title="<spring:message code="wzwg.site.screen.msg.MSG087"/>"><i class="fa fa-file"></i></button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorBtnTap('bullet');wzEditorChangeBtnBulletMode()"  title="<spring:message code="wzwg.site.screen.msg.MSG088"/>"><i class="fa fa-circle"></i></button>
				</div>
			</div>
			
			<div class="wzEditor-btn-contents">
				<div class="wzEditor-func textEdit">
					<div class="mb10">
						<p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG072"/> <button type="button" class="wzbtn-table btn-basic fr icoBtn" onclick="wzEditorBtnTextSizeToggle()" ><i class="fa fa-expand"></i></button></p>
						<textarea id="wzEditorBtnText" style="width: 99%; height: 50px;"></textarea>
					</div>
							
					<button type="button" class="wzbtn-table wzbtn-block btn-save cntlBtn" onclick="wzEditorBtnTextAccept()"  ><spring:message code="wzwg.cmm.word.apply" /></button>
				</div>
				
				<div class="wzEditor-func fontStyle">
					<div>
						<p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG073"/></p>
						<c:out value="${fontListKR }" escapeXml="false"/>
					</div>
					<button type="button" onclick="wzEditorFontFamily('')"  ><spring:message code="wzwg.site.screen.msg.MSG074"/></button>
				</div>
				
				
				<div class="wzEditor-func fontSize">
					<div>
						<p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG090"/></p>
						<ul class="">
							<li class="i-block"><button type="button" onclick="wzEditorBtnFontSize('minus')" class="wzbtn-table btn-basic cntlBtn"><i class="fa fa-minus"></i></button></li>
							<li class="i-block"><button type="button" onclick="wzEditorBtnFontSize('plus')" class="wzbtn-table btn-basic cntlBtn"><i class="fa fa-plus"></i></button></li>
						</ul>
					</div>
				</div>
				
				
				<div class="wzEditor-func lineHeight">
					<div>
						<p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG091"/></p>
						<ul class="">
							<li class="i-block"><button type="button" onclick="wzEditorBtnLineHeight('minus')" class="wzbtn-table btn-basic cntlBtn"><i class="fa fa-minus"></i></button></li>
							<li class="i-block"><button type="button" onclick="wzEditorBtnLineHeight('plus')" class="wzbtn-table btn-basic cntlBtn"><i class="fa fa-plus"></i></button></li>
						</ul>
					</div>
				</div>
				
				
				
				
				<div class="wzEditor-func foreColor"> 
					<p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG092"/></p>
					<c:out value="${textColorList}" escapeXml="false"/>
					<div><p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG068" /></p>
						<input type="text" id="wzEditBtnCustomCol" >
						<button class="wzbtn-table btn-basic" onclick="wzEditBtnTextCol( $('#wzEditBtnCustomCol').val() );" style="padding: 0 10px;"><spring:message code="wzwg.cmm.word.applc" /></button> 
					</div>
				</div><!-- end foreColor -->
				
				
				
				<div class="wzEditor-func bgColor"> 
					<p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG093"/></p>
					<div class="btn-list">
						<ul>
						</ul>
					</div>
				</div><!-- end foreColor -->
				
				
				
				<div class="wzEditor-func corner"> 
					<p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG094"/></p>
					<div class="corner-list">
						<ul>
							<li><button type="button" onclick="wzEditorBtnBorderRodius('')"    ><spring:message code="wzwg.site.screen.msg.MSG095"/></button></li>
							<li><button type="button" onclick="wzEditorBtnBorderRodius('br0')" ><spring:message code="wzwg.site.screen.msg.MSG096"/></button></li>
							<li><button type="button" onclick="wzEditorBtnBorderRodius('br3')" ><spring:message code="wzwg.site.screen.msg.MSG097"/></button></li>
							<li><button type="button" onclick="wzEditorBtnBorderRodius('br5')" ><spring:message code="wzwg.site.screen.msg.MSG098"/></button></li>
							<li><button type="button" onclick="wzEditorBtnBorderRodius('br10')"><spring:message code="wzwg.site.screen.msg.MSG099"/></button></li>
							<li><button type="button" onclick="wzEditorBtnBorderRodius('br15')"><spring:message code="wzwg.site.screen.msg.MSG100"/></button></li>
							<li><button type="button" onclick="wzEditorBtnBorderRodius('br20')"><spring:message code="wzwg.site.screen.msg.MSG101"/></button></li>
						</ul>
					</div>
				</div><!-- end foreColor -->
				
				<div class="wzEditor-func menuLink"> 
					
					
					<a href="javascript:;" class="ui-button ui-widget ui-corner-all" onclick="wzEditorBtnLink()"><spring:message code="wzwg.cmm.word.applc" /></a>
				</div><!-- end menuLink -->
				
				
				<div class="wzEditor-func bullet">
					<div class="icon-bullet-list">
						<p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG102"/></p>
							<c:out value="${bulletList }" escapeXml="false"/>
					</div>
					<!-- <div >
						<p class="font_reco">CSS 불렛</p>
						<ul>
							<li><button type="button" >준비중입니다</button></li>
						</ul>
					</div> -->
				</div>
				
				
			</div><!-- end wzEditor-btn-contents -->
		</div><!-- end wzEditor -->
	</div><!-- end dialog -->
	
	
	
	
	
	<div id="wzEditorBoxDialog" title="WIZWIG - EDITOR (IMAGE)" style="z-index:999;">
		<div class="wzEditor">
			<div class="wzEditor-command">
				<p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG089"/></p>
				<div class="tools">
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorTapType('img','cover')" id="wzEditorBtn-boxCover" title="<spring:message code="wzwg.site.screen.msg.MSG162"/>">cover</button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorTapType('img','border')"  ><spring:message code="wzwg.cmm.word.borr"/></button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorTapType('img','size')" >Size</button>
						<div class="wzbtn-group">
							<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorImgAlign('left')"  title="<spring:message code="wzwg.cmm.word.scrin.alignLeft"/>"><i class="fa fa-align-left"></i></button>
							<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorImgAlign('center')"  title="<spring:message code="wzwg.cmm.word.scrin.alignCenter"/>"><i class="fa fa-align-center"></i></button>
							<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorImgAlign('right')"  title="<spring:message code="wzwg.cmm.word.scrin.alignRight"/>"><i class="fa fa-align-right"></i></button>
						</div>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEidtorImgChange()"  id="wzEditorBtn-boxImage" title="<spring:message code="wzwg.site.screen.msg.MSG103"/>"><i class="fa fa-picture-o"></i></button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorTapType('img', 'menuLink')"  id="wzEditorBtn-boxLink" title="<spring:message code="wzwg.site.screen.msg.MSG075"/>"><i class="fa fa-link"></i></button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorTapType('img', 'youtube'); wzEditorYoutubeSetlink()"  id="wzEditorBtn-youtubeLink" title="<spring:message code="wzwg.site.screen.msg.MSG104"/>"><i class="fa fa-youtube-play"></i></button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEidtorImageFileStore()" id="wzEditorBtn-boxFile" title="<spring:message code="wzwg.site.screen.msg.MSG087"/>"><i class="fa fa-file"></i></button>
						<button type="button" class="wzbtn-table btn-basic cntlBtn" onclick="wzEditorImgCaptionFocus()"  id="wzEditorBtn-boxImgHint" title="<spring:message code="wzwg.site.menu.msg.MSG039"/>">Caption</button>
						<!-- <button type="button" class="wzbtn-table btn-basic" onclick="wzEditorTapType('img', 'caption');wzEditorImgCaptionMode();"  title="<spring:message code="wzwg.site.screen.msg.MSG161"/>">Caption</button> -->
				</div>
			</div>
			
			<div class="wzEditor-img-contents">
				<div class="wzEditor-func border">
					<div class="mb10">
						<p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG105"/> <button type="button" class="wzbtn-table btn-basic fr wz-collapse icoBtn" data-for="#wzEditor-cntl-imgBorderStyle" data-act="fade" ><i class="fa fa-caret-down"></i></button></p>
						<ul class="dp-none" id="wzEditor-cntl-imgBorderStyle">
							<li><button type="button" onclick="wzEditorImgBorderSet('style', 'hidden')">hidden</button></li>
							<li><button type="button" onclick="wzEditorImgBorderSet('style', 'solid')">solid</button></li>
							<li><button type="button" onclick="wzEditorImgBorderSet('style', 'dashed')">dashed</button></li>
							<li><button type="button" onclick="wzEditorImgBorderSet('style', 'dotted')">dotted</button></li>
							<li><button type="button" onclick="wzEditorImgBorderSet('style', 'double')">double</button></li>
							<li><button type="button" onclick="wzEditorImgBorderSet('style', 'ridge')">ridge</button></li>
							<li><button type="button" onclick="wzEditorImgBorderSet('style', 'inset')">inset</button></li>
							<li><button type="button" onclick="wzEditorImgBorderSet('style', 'outset')">outset</button></li>
							<li><button type="button" onclick="wzEditorImgBorderSet('style', 'groove')">groove</button></li>
						</ul>
					</div>
					
					<div class="">
						<p class="font_reco"><spring:message code="wzwg.cmm.word.mg02"/> <button type="button" class="wzbtn-table btn-basic fr wz-collapse icoBtn" data-for="#wzEditor-cntl-imgBorderSize" data-act="fade" ><i class="fa fa-caret-down"></i></button></p>
						<ul class="dp-none" id="wzEditor-cntl-imgBorderSize">
							<li class="i-block"><button type="button" onclick="wzEditorImgBorderSet('width', 'minus')" class="wzbtn-table btn-basic cntlBtn"><i class="fa fa-minus"></i></button></li>
							<li class="i-block"><button type="button" onclick="wzEditorImgBorderSet('width', 'plus')" class="wzbtn-table btn-basic cntlBtn"><i class="fa fa-plus"></i></button></li>
						</ul>
					</div>
					
					<div class="imgBorderBgCol">
						<p class="font_reco"><spring:message code="wzwg.cmm.word.color"/> <button type="button" class="wzbtn-table btn-basic fr wz-collapse icoBtn" data-for="#wzEditorBGControll" data-act="fade" ><i class="fa fa-caret-down"></i></button></p>
					</div>
					
					<div class="">
						<p class="font_reco"><spring:message code="wzwg.cmm.word.scrin.padding"/> <button type="button" class="wzbtn-table btn-basic fr wz-collapse icoBtn" data-for="#wzEditor-cntl-imgBorderPadding" data-act="fade" ><i class="fa fa-caret-down"></i></button></p>
						<ul class="dp-none" id="wzEditor-cntl-imgBorderPadding">
							<li class="i-block"><button type="button" onclick="wzEditorImgBorderPaddingChange('minus')" class="wzbtn-table btn-basic cntlBtn"><i class="fa fa-minus"></i></button></li>
							<li class="i-block"><button type="button" onclick="wzEditorImgBorderPaddingChange('plus')" class="wzbtn-table btn-basic cntlBtn"><i class="fa fa-plus"></i></button></li>
						</ul>
					</div>
					
					<div class="">
						<p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG085"/> <button type="button" class="wzbtn-table btn-basic fr wz-collapse icoBtn" data-for="#wzEditor-cntl-imgBorderRound" data-act="fade" ><i class="fa fa-caret-down"></i></button></p>
						<div class="dp-none" id="wzEditor-cntl-imgBorderRound">
							<div>
								<div class="subTitle"><spring:message code="wzwg.site.screen.msg.MSG107"/></div>
								<ul >
									<li class="i-block"><button type="button" onclick="wzEditorImgBorderRoundChange('minus')" class="wzbtn-table btn-basic cntlBtn"><i class="fa fa-minus"></i></button></li>
									<li class="i-block"><button type="button" onclick="wzEditorImgBorderRoundChange('plus')" class="wzbtn-table btn-basic cntlBtn"><i class="fa fa-plus"></i></button></li>
								</ul>
							</div>
							<div class="imgEdge dp-none">
								<div class="subTitle"><spring:message code="wzwg.site.screen.msg.MSG108"/></div>
								<ul >
									<li class="i-block"><button type="button" onclick="wzEditorImgBorderContentsChange('minus')" class="wzbtn-table btn-basic cntlBtn"><i class="fa fa-minus"></i></button></li>
									<li class="i-block"><button type="button" onclick="wzEditorImgBorderContentsChange('plus')" class="wzbtn-table btn-basic cntlBtn"><i class="fa fa-plus"></i></button></li>
								</ul>
							</div>
						</div>
					</div>
					
					
				</div>
				
				<div class="wzEditor-func cover imgFunc">
					<div>
						<p class="font_reco"><spring:message code="wzwg.site.screen.msg.MSG109"/></p>
						<ul>
							<li><button type="button" onclick="wzEditorImgCoverChange('blur')"  ><spring:message code="wzwg.site.screen.msg.MSG110"/></button></li>
							<li><button type="button" onclick="wzEditorImgCoverChange('filter')"><spring:message code="wzwg.site.screen.msg.MSG111"/></button></li>
							<li><button type="button" onclick="wzEditorImgCoverChange('fade')"  ><spring:message code="wzwg.site.screen.msg.MSG112"/></button></li>
							<li><button type="button" onclick="wzEditorImgCoverChange('flip')"  ><spring:message code="wzwg.site.screen.msg.MSG113"/></button></li>
							<li><button type="button" onclick="wzEditorImgCoverChange('shadow')"><spring:message code="wzwg.site.screen.msg.MSG114"/></button></li>
							<li><button type="button" onclick="wzEditorImgCoverChange('new')"   ><spring:message code="wzwg.site.screen.msg.MSG115"/></button></li>
							<li><button type="button" onclick="wzEditorImgCoverChange('best')"  ><spring:message code="wzwg.site.screen.msg.MSG116"/></button></li>
						</ul>
					</div>
					<button type="button" onclick="wzEditorImgCoverChange('')"  ><spring:message code="wzwg.site.screen.msg.MSG074"/></button>
				</div>
				
				
				<div class="wzEditor-func size">
					<div>
						<p class="font_reco"><spring:message code="wzwg.cmm.word.mg02"/></p>
						<ul class="">
							<li class="i-block"><button type="button" onclick="wzEditorImgSize('minus')" class="wzbtn-table btn-basic cntlBtn"><i class="fa fa-minus"></i></button></li>
							<li class="i-block"><button type="button" onclick="wzEditorImgSize('plus')" class="wzbtn-table btn-basic cntlBtn"><i class="fa fa-plus"></i></button></li>
						</ul>
					</div>
				</div>
				
				<div class="wzEditor-func menuLink imgFunc"> 
					
					
					<a href="javascript:;" class="ui-button ui-widget ui-corner-all" onclick="wzEditorImageLink()"><spring:message code="wzwg.cmm.word.applc" /></a>
				</div><!-- end menuLink -->
				
				<!-- <div class="wzEditor-func caption">
					<div class="mb10">
						<p class="font_reco">이미지 설명</p>
						<textarea id="wzEditorImgCaption" style="width: 99%; height: 50px;"></textarea>
					</div>
							
					<button type="button" class="wzbtn-table wzbtn-block btn-save" onclick="wzEditorImgCaptionAccept()"  ><spring:message code="wzwg.cmm.word.apply" /></button>
				</div> -->
				
				<div class="wzEditor-func youtube imgFunc"> 
					
					<div class="mb10">
						<p class="font_reco" style="border-bottom: 1px solid #f0f0f0;"><spring:message code="wzwg.site.screen.msg.MSG117"/></p>
						<span class="mt10 fl w100">URL : <input type="text" class="w100" id="wzEditorYoutubeLink-inp"></span>
					</div>
							
					<button type="button" class="wzbtn-table wzbtn-block btn-save cntlBtn" onclick="wzEditorImgYoutubeAccept()"  ><spring:message code="wzwg.cmm.word.apply" /></button>
					<div class="wz_tableguide wz-box br-grey"><spring:message code="wzwg.site.screen.msg.MSG118"/></div>
					
				</div><!-- end menuLink -->
				
				
			</div><!-- end wzEditor-btn-contents -->
		</div><!-- end wzEditor -->
	</div><!-- end dialog -->
	
	
	
	<!-- 베이직 에디터  -->
	<div id="basicTextEditor" title="<spring:message code="wzwg.site.screen.msg.MSG119"/>" class="p0" style="width:300px; overflow: visible;">
		<div class="basicEditorForm">
			<ul class="btn_tit_wrap">
				<li class="fontFamily" style="display:none;">
					<select onchange="basicEditorFontFamily(this, event);">
						<option value="none">::<spring:message code="wzwg.webModule.word.changeFont"/>::</option>
						<option value="Noto Sans KR" 	style="font-family: Noto Sans KR" 		><spring:message code="wzwg.webModule.word.default"/></option>
						<option value="굴림체,GulimChe" style="font-family: 굴림체,GulimChe" 	><spring:message code="wzwg.webModule.word.gulimChe"/></option>
						<option value="NanumSquareR" 	style="font-family: NanumSquareR"   	><spring:message code="wzwg.webModule.word.nanumSquareR"/></option>
						<option value="NanumGothic" 	style="font-family: NanumGothic" 		><spring:message code="wzwg.webModule.word.nanumGothic"/></option>
						<option value="IropkeBatang" 	style="font-family: IropkeBatang" 		><spring:message code="wzwg.webModule.word.iropkeBatang"/></option>
						<option value="NanumBrush" 		style="font-family: NanumBrush" 		><spring:message code="wzwg.webModule.word.nanumBrush"/></option>
					</select>
				</li>
	            <li>
	              <button type="button" onclick="document.execCommand('bold')">
	                <img src="/images/wzwg/site/mngr/screen/ico_bold.png" alt="">
	              </button>
	            </li>
	            <li>
	              <button type="button" onclick="document.execCommand('Italic')">
	                <img src="/images/wzwg/site/mngr/screen/ico_italic.png" alt="">
	              </button>
	            </li>
	            <li>
	              <button type="button" onclick="document.execCommand('Underline')">
	                <img src="/images/wzwg/site/mngr/screen/ico_underline.png" alt="">
	              </button>
	            </li>
	            <li>
	              <button type="button" onclick="document.execCommand('StrikeThrough')">
	                <img src="/images/wzwg/site/mngr/screen/ico_line_through.png" alt="">
	              </button>
	            </li>
	            <li onclick="basicEditorPaletteToggle(this)">
	              <button type="button" >
	                <img src="/images/wzwg/site/mngr/screen/ico_palette.png" alt="">
	              </button>
	            </li>
          	</ul>
	        <div class="cnt_textarea">
	            <p class="blt_point_blue" id="basicEditorLineHint"><spring:message code="wzwg.cmm.msg.screen.MSG050" /></p>
	            <div class="textarea" id="basicTextValue"  contenteditable="true" style="overflow-y: scroll; max-height: 250px;"></div>
	            <div class="pop-notice"><span class="circle_no bg-red-strong">!</span><spring:message code="wzwg.cmm.msg.screen.MSG049" /></div>
	            <div class="wzEditor-func btn_box">
				      <button type="button" class="cntlBtn wzbtn-block mt10 btn_apply" value="<spring:message code="wzwg.cmm.word.applc" />" onclick="wzBasicEditorCnfirm();"><spring:message code="wzwg.cmm.word.applc" /></button>
			      </div>
	        </div>
			
			<div class="pop_inner_wrap" id="basicEditorTextPalette" style="display:none;">
				<div class="bg_palette_area">
		          <span class="list_tit"><spring:message code="wzwg.cmm.word.recent" /></span>
		          <ul class="bg_palette" id="basicEditorTextUseColors">
		          	<li></li>
		          </ul>
		        </div>
		
		        <div class="bg_palette_area">
		          <span class="list_tit"><spring:message code="wzwg.cmm.word.recomend" /></span>
		          <ul class="bg_palette col2">
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#c80000'); basicEditorTxtPalette('red'); basicEditorTxtUseCol('c80000');" data-color="#c80000">
		              	<input type="radio" id="txt_c_1" name="txt_rcmd" value="" >
		              	<label for="txt_c_1" class="inp_c80000"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#e64856'); basicEditorTxtPalette('pink'); basicEditorTxtUseCol('e64856');" data-color="#e64856">
		              	<input type="radio" id="txt_c_2" name="txt_rcmd" value="" >
		              	<label for="txt_c_2" class="inp_e64856"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#f7630d'); basicEditorTxtPalette('orange'); basicEditorTxtUseCol('f7630d');" data-color="#f7630d">
		              	<input type="radio" id="txt_c_3" name="txt_rcmd" value="" >
		              	<label for="txt_c_3" class="inp_f7630d"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#efc127'); basicEditorTxtPalette('yellow'); basicEditorTxtUseCol('efc127');" data-color="#efc127">
		              	<input type="radio" id="txt_c_4" name="txt_rcmd" value="" >
		              	<label for="txt_c_4" class="inp_efc127"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#4a8205'); basicEditorTxtPalette('green'); basicEditorTxtUseCol('4a8205');" data-color="#4a8205">
		              	<input type="radio" id="txt_c_5" name="txt_rcmd" value="" >
		              	<label for="txt_c_5" class="inp_4a8205"></label>
		              </button>
		            </li>
		          </ul>
		          <ul class="bg_palette col2">
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#0b56a7'); basicEditorTxtPalette('blue'); basicEditorTxtUseCol('0b56a7');" data-color="#0b56a7">
		              	<input type="radio" id="txt_c_6" name="txt_rcmd" value="" >
		              	<label for="txt_c_6" class="inp_0b56a7"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#8d47ad'); basicEditorTxtPalette('purple'); basicEditorTxtUseCol('8d47ad');" data-color="#8d47ad">
		              	<input type="radio" id="txt_c_7" name="txt_rcmd" value="" >
		              	<label for="txt_c_7" class="inp_8d47ad"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#343434'); basicEditorTxtPalette('black'); basicEditorTxtUseCol('333333');" data-color="#343434">
		              	<input type="radio" id="txt_c_8" name="txt_rcmd" value="" >
		              	<label for="txt_c_8" class="inp_333333"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#a1a1a1'); basicEditorTxtPalette('grey'); basicEditorTxtUseCol('a1a1a1');" data-color="#a1a1a1">
		              	<input type="radio" id="txt_c_9" name="txt_rcmd" value="" >
		              	<label for="txt_c_9" class="inp_a1a1a1"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#ffffff'); basicEditorTxtPalette('white-grey'); basicEditorTxtUseCol('ffffff');" data-color="#ffffff">
		              	<input type="radio" id="txt_c_10" name="txt_rcmd" value="" >
		              	<label for="txt_c_10" class="inp_ffffff"></label>
		              </button>
		            </li>
		          </ul>
		        </div>
		
		
		
		
		        <div class="bg_palette_area txt_palette_area" style="display: block;">
		          <span class="list_tit"><spring:message code="wzwg.cmm.word.shdw" /></span>
		          <ul class="bg_palette" id="txt_palette_trans_red">
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#eee4e4'); basicEditorTxtUseCol('eee4e4');" data-color="#eee4e4">
		              	<input type="radio" id="txt_t_1" name="txt_trns_c" value="" >
		              	<label for="txt_t_1" class="inp_eee4e4"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#fbd5d5'); basicEditorTxtUseCol('fbd5d5');" data-color="#fbd5d5">
		              	<input type="radio" id="txt_t_2" name="txt_trns_c" value="" >
		              	<label for="txt_t_2" class="inp_fbd5d5"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#f7acac'); basicEditorTxtUseCol('f7acac');" data-color="#f7acac">
		              	<input type="radio" id="txt_t_3" name="txt_trns_c" value="" >
		              	<label for="txt_t_3" class="inp_f7acac"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#ef5658'); basicEditorTxtUseCol('ef5658');" data-color="#ef5658">
		              	<input type="radio" id="txt_t_4" name="txt_trns_c" value="" >
		              	<label for="txt_t_4" class="inp_ef5658"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#ce1313'); basicEditorTxtUseCol('ce1313');" data-color="#ce1313">
		              	<input type="radio" id="txt_t_5" name="txt_trns_c" value="" >
		              	<label for="txt_t_5" class="inp_ce1313"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#830b0b'); basicEditorTxtUseCol('830b0b');" data-color="#830b0b">
		              	<input type="radio" id="txt_t_6" name="txt_trns_c" value="" >
		              	<label for="txt_t_6" class="inp_830b0b"></label>
		              </button>
		            </li>
		          </ul>
		          
		          
		          <ul class="bg_palette" id="txt_palette_trans_pink" style="display: none;">
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#f0e7ec'); basicEditorTxtUseCol('f0e7ec');" data-color="#f0e7ec">
		              	<input type="radio" id="txt_t_7" name="txt_trns_c" value="" >
		              	<label for="txt_t_7" class="inp_f0e7ec"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#f8c3c5'); basicEditorTxtUseCol('f8c3c5');" data-color="#f8c3c5">
		              	<input type="radio" id="txt_t_8" name="txt_trns_c" value="" >
		              	<label for="txt_t_8" class="inp_f8c3c5"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#f9a7ab'); basicEditorTxtUseCol('f9a7ab');" data-color="#f9a7ab">
		              	<input type="radio" id="txt_t_9" name="txt_trns_c" value="" >
		              	<label for="txt_t_9" class="inp_f9a7ab"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#f28183'); basicEditorTxtUseCol('f28183');" data-color="#f28183">
		              	<input type="radio" id="txt_t_10" name="txt_trns_c" value="" >
		              	<label for="txt_t_10" class="inp_f28183"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#ea2364'); basicEditorTxtUseCol('ea2364');" data-color="#ea2364">
		              	<input type="radio" id="txt_t_11" name="txt_trns_c" value="" >
		              	<label for="txt_t_11" class="inp_ea2364"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#c40052'); basicEditorTxtUseCol('c40052');" data-color="#c40052">
		              	<input type="radio" id="txt_t_12" name="txt_trns_c" value="" >
		              	<label for="txt_t_12" class="inp_c40052"></label>
		              </button>
		            </li>
		          </ul>
		          
		          
		          <ul class="bg_palette" id="txt_palette_trans_orange" style="display: none;">
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#fdf0e7'); basicEditorTxtUseCol('fdf0e7');" data-color="#fdf0e7">
		              	<input type="radio" id="txt_t_13" name="txt_trns_c" value="" >
		              	<label for="txt_t_13" class="inp_fdf0e7"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#f4dac7'); basicEditorTxtUseCol('f4dac7');" data-color="#f4dac7">
		              	<input type="radio" id="txt_t_14" name="txt_trns_c" value="" >
		              	<label for="txt_t_14" class="inp_f4dac7"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#f7cbac'); basicEditorTxtUseCol('f7cbac');" data-color="#f7cbac">
		              	<input type="radio" id="txt_t_15" name="txt_trns_c" value="" >
		              	<label for="txt_t_15" class="inp_f7cbac"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#f4b183'); basicEditorTxtUseCol('f4b183');" data-color="#f4b183">
		              	<input type="radio" id="txt_t_16" name="txt_trns_c" value="" >
		              	<label for="txt_t_16" class="inp_f4b183"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#d96a1e'); basicEditorTxtUseCol('d96a1e');" data-color="#d96a1e">
		              	<input type="radio" id="txt_t_17" name="txt_trns_c" value="" >
		              	<label for="txt_t_17" class="inp_d96a1e"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#833c0b'); basicEditorTxtUseCol('833c0b');" data-color="#833c0b">
		              	<input type="radio" id="txt_t_18" name="txt_trns_c" value="" >
		              	<label for="txt_t_18" class="inp_833c0b"></label>
		              </button>
		            </li>
		          </ul>
		          
		          
		          <ul class="bg_palette" id="txt_palette_trans_yellow" style="display: none;">
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#fcf8eb'); basicEditorTxtUseCol('fcf8eb');" data-color="#fcf8eb">
		              	<input type="radio" id="txt_t_19" name="txt_trns_c" value="" >
		              	<label for="txt_t_19" class="inp_fcf8eb"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#fff2cc'); basicEditorTxtUseCol('fff2cc');" data-color="#fff2cc">
		              	<input type="radio" id="txt_t_20" name="txt_trns_c" value="" >
		              	<label for="txt_t_20" class="inp_fff2cc"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#f1d88c'); basicEditorTxtUseCol('f1d88c');" data-color="#f1d88c">
		              	<input type="radio" id="txt_t_21" name="txt_trns_c" value="" >
		              	<label for="txt_t_21" class="inp_f1d88c"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#e3bb43'); basicEditorTxtUseCol('e3bb43');" data-color="#e3bb43">
		              	<input type="radio" id="txt_t_22" name="txt_trns_c" value="" >
		              	<label for="txt_t_22" class="inp_e3bb43"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#bf9000'); basicEditorTxtUseCol('bf9000');" data-color="#bf9000">
		              	<input type="radio" id="txt_t_23" name="txt_trns_c" value="" >
		              	<label for="txt_t_23" class="inp_bf9000"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#7f6000'); basicEditorTxtUseCol('7f6000');" data-color="#7f6000">
		              	<input type="radio" id="txt_t_24" name="txt_trns_c" value="" >
		              	<label for="txt_t_24" class="inp_7f6000"></label>
		              </button>
		            </li>
		          </ul>
		          
		          
		          <ul class="bg_palette" id="txt_palette_trans_green" style="display: none;">
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#f1f8ec'); basicEditorTxtUseCol('f1f8ec');" data-color="#f1f8ec">
		              	<input type="radio" id="txt_t_25" name="txt_trns_c" value="" >
		              	<label for="txt_t_25" class="inp_f1f8ec"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#c5e0b3'); basicEditorTxtUseCol('c5e0b3');" data-color="#c5e0b3">
		              	<input type="radio" id="txt_t_26" name="txt_trns_c" value="" >
		              	<label for="txt_t_26" class="inp_c5e0b3"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#8ebf6d'); basicEditorTxtUseCol('8ebf6d');" data-color="#8ebf6d">
		              	<input type="radio" id="txt_t_27" name="txt_trns_c" value="" >
		              	<label for="txt_t_27" class="inp_8ebf6d"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#64a13c'); basicEditorTxtUseCol('64a13c');" data-color="#64a13c">
		              	<input type="radio" id="txt_t_28" name="txt_trns_c" value="" >
		              	<label for="txt_t_28" class="inp_64a13c"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#538135'); basicEditorTxtUseCol('538135');" data-color="#538135">
		              	<input type="radio" id="txt_t_29" name="txt_trns_c" value="" >
		              	<label for="txt_t_29" class="inp_538135"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#375623'); basicEditorTxtUseCol('375623');" data-color="#375623">
		              	<input type="radio" id="txt_t_30" name="txt_trns_c" value="" >
		              	<label for="txt_t_30" class="inp_375623"></label>
		              </button>
		            </li>
		          </ul>
		          
		          
		          <ul class="bg_palette" id="txt_palette_trans_blue" style="display: none;">
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#d6dce4'); basicEditorTxtUseCol('d6dce4');" data-color="#d6dce4">
		              	<input type="radio" id="txt_t_31" name="txt_trns_c" value="" >
		              	<label for="txt_t_31" class="inp_d6dce4"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#adb9ca'); basicEditorTxtUseCol('adb9ca');" data-color="#adb9ca">
		              	<input type="radio" id="txt_t_32" name="txt_trns_c" value="" >
		              	<label for="txt_t_32" class="inp_adb9ca"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#8eaadb'); basicEditorTxtUseCol('8eaadb');" data-color="#8eaadb">
		              	<input type="radio" id="txt_t_33" name="txt_trns_c" value="" >
		              	<label for="txt_t_33" class="inp_8eaadb"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#2f5496'); basicEditorTxtUseCol('2f5496');" data-color="#2f5496">
		              	<input type="radio" id="txt_t_34" name="txt_trns_c" value="" >
		              	<label for="txt_t_34" class="inp_2f5496"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#323f4f'); basicEditorTxtUseCol('323f4f');" data-color="#323f4f">
		              	<input type="radio" id="txt_t_35" name="txt_trns_c" value="" >
		              	<label for="txt_t_35" class="inp_323f4f"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#222a35'); basicEditorTxtUseCol('222a35');" data-color="#222a35">
		              	<input type="radio" id="txt_t_36" name="txt_trns_c" value="" >
		              	<label for="txt_t_36" class="inp_222a35"></label>
		              </button>
		            </li>
		          </ul>
		          
		          
		          <ul class="bg_palette" id="txt_palette_trans_purple" style="display: none;">
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#ebdef6'); basicEditorTxtUseCol('ebdef6');" data-color="#ebdef6">
		              	<input type="radio" id="txt_t_37" name="txt_trns_c" value="" >
		              	<label for="txt_t_37" class="inp_ebdef6"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#bb97c7'); basicEditorTxtUseCol('bb97c7');" data-color="#bb97c7">
		              	<input type="radio" id="txt_t_38" name="txt_trns_c" value="" >
		              	<label for="txt_t_38" class="inp_bb97c7"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#9a6baf'); basicEditorTxtUseCol('9a6baf');" data-color="#9a6baf">
		              	<input type="radio" id="txt_t_39" name="txt_trns_c" value="" >
		              	<label for="txt_t_39" class="inp_9a6baf"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#824f9e'); basicEditorTxtUseCol('824f9e');" data-color="824f9e">
		              	<input type="radio" id="txt_t_40" name="txt_trns_c" value="" >
		              	<label for="txt_t_40" class="inp_824f9e"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#872eb5'); basicEditorTxtUseCol('872eb5');" data-color="#872eb5">
		              	<input type="radio" id="txt_t_41" name="txt_trns_c" value="" >
		              	<label for="txt_t_41" class="inp_872eb5"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#581f79'); basicEditorTxtUseCol('581f79');" data-color="#581f79">
		              	<input type="radio" id="txt_t_42" name="txt_trns_c" value="" >
		              	<label for="txt_t_42" class="inp_581f79"></label>
		              </button>
		            </li>
		          </ul>
		          
		          
		          <ul class="bg_palette" id="txt_palette_trans_grey" style="display: none;">
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#d0cece'); basicEditorTxtUseCol('d0cece');" data-color="#d0cece">
		              	<input type="radio" id="txt_t_43" name="txt_trns_c" value="" >
		              	<label for="txt_t_43" class="inp_d0cece"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#bbbbbb'); basicEditorTxtUseCol('bbbbbb');" data-color="#bbbbbb">
		              	<input type="radio" id="txt_t_44" name="txt_trns_c" value="" >
		              	<label for="txt_t_44" class="inp_bbbbbb"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#aeabab'); basicEditorTxtUseCol('aeabab');" data-color="#aeabab">
		              	<input type="radio" id="txt_t_45" name="txt_trns_c" value="" >
		              	<label for="txt_t_45" class="inp_aeabab"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#757070'); basicEditorTxtUseCol('757070');" data-color="#757070">
		              	<input type="radio" id="txt_t_46" name="txt_trns_c" value="" >
		              	<label for="txt_t_46" class="inp_757070"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#3a3838'); basicEditorTxtUseCol('3a3838');" data-color="#3a3838">
		              	<input type="radio" id="txt_t_47" name="txt_trns_c" value="" >
		              	<label for="txt_t_47" class="inp_3a3838"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#171616'); basicEditorTxtUseCol('171616');" data-color="#171616">
		              	<input type="radio" id="txt_t_48" name="txt_trns_c" value="" >
		              	<label for="txt_t_48" class="inp_171616"></label>
		              </button>
		            </li>
		          </ul>
		          
		          
		          <ul class="bg_palette" id="txt_palette_trans_white-grey" style="display: none;">
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#f2f2f2'); basicEditorTxtUseCol('f2f2f2');" data-color="#f2f2f2">
		              	<input type="radio" id="txt_t_49" name="txt_trns_c" value="" >
		              	<label for="txt_t_49" class="inp_f2f2f2"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#d8d8d8'); basicEditorTxtUseCol('d8d8d8');" data-color="#d8d8d8">
		              	<input type="radio" id="txt_t_50" name="txt_trns_c" value="" >
		              	<label for="txt_t_50" class="inp_d8d8d8"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#bfbfbf'); basicEditorTxtUseCol('bfbfbf');" data-color="#bfbfbf">
		              	<input type="radio" id="txt_t_51" name="txt_trns_c" value="" >
		              	<label for="txt_t_51" class="inp_bfbfbf"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#a5a5a5'); basicEditorTxtUseCol('a5a5a5');" data-color="#a5a5a5">
		              	<input type="radio" id="txt_t_52" name="txt_trns_c" value="" >
		              	<label for="txt_t_52" class="inp_a5a5a5"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#7f7f7f'); basicEditorTxtUseCol('7f7f7f');" data-color="#7f7f7f">
		              	<input type="radio" id="txt_t_53" name="txt_trns_c" value="" >
		              	<label for="txt_t_53" class="inp_7f7f7f"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#707070'); basicEditorTxtUseCol('707070');" data-color="#707070">
		              	<input type="radio" id="txt_t_54" name="txt_trns_c" value="" >
		              	<label for="txt_t_54" class="inp_707070"></label>
		              </button>
		            </li>
		          </ul>
		          
		          
		          <ul class="bg_palette" id="txt_palette_trans_black" style="display: none;">
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#666666'); basicEditorTxtUseCol('666666');" data-color="#666666">
		              	<input type="radio" id="txt_t_55" name="txt_trns_c" value="" >
		              	<label for="txt_t_55" class="inp_666666"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#595959'); basicEditorTxtUseCol('595959');" data-color="#595959">
		              	<input type="radio" id="txt_t_56" name="txt_trns_c" value="" >
		              	<label for="txt_t_56" class="inp_595959"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#3f3f3f'); basicEditorTxtUseCol('3f3f3f');" data-color="#3f3f3f">
		              	<input type="radio" id="txt_t_57" name="txt_trns_c" value="" >
		              	<label for="txt_t_57" class="inp_3f3f3f"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#262626'); basicEditorTxtUseCol('262626');" data-color="#262626">
		              	<input type="radio" id="txt_t_58" name="txt_trns_c" value="" >
		              	<label for="txt_t_58" class="inp_262626"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#212121'); basicEditorTxtUseCol('212121');" data-color="#212121">
		              	<input type="radio" id="txt_t_59" name="txt_trns_c" value="" >
		              	<label for="txt_t_59" class="inp_212121"></label>
		              </button>
		            </li>
		            <li>
		              <button type="button" onclick="callTextEditorCommand('foreColor','#000000'); basicEditorTxtUseCol('000000');" data-color="#000000">
		              	<input type="radio" id="txt_t_60" name="txt_trns_c" value="" >
		              	<label for="txt_t_60" class="inp_000000"></label>
		              </button>
		            </li>
		          </ul>
		        </div>
		
		        <div class="bg_palette_area">
		          <span class="list_tit code"><spring:message code="wzwg.cmm.word.code" /></span>
		          <input type="text" id="basicEditorTxtCustomCode" class="code_num" name="code_num" value="" placeholder="#aabbcc">
		          <label for="code_num"></label>
		          <button type="button" class="btn_apply" onclick="basicEditorTxtCustomCol()"><spring:message code="wzwg.cmm.word.applc" /></button>
		        </div>
			</div>
        </div>
	</div>
	
	<!-- 메뉴폰트변경 다이얼로그 -->
	<div id="menuFontModifyDiv" title="<spring:message code="wzwg.webModule.word.changeFont"/>" style="z-index: 999; padding:0;">
		<div class="pop-notice subMenuInfo" style="display:none;"><span class="circle_no bg-red-strong">!</span><spring:message code="wzwg.cmm.msg.screen.MSG094"/></div>
		<ul class="font_wrap">
            <li>
              <button type="button" onclick="menuFontModify('Noto Sans KR')">                
                <p style="font-family: Noto Sans KR;"><spring:message code="wzwg.webModule.word.default"/></p>
              </button>
            </li>            
            <li>
              <button type="button" onclick="menuFontModify('굴림체,GulimChe')">                
                <p style="font-family: 굴림체,GulimChe;"><spring:message code="wzwg.webModule.word.gulimChe"/> </p>
              </button>
            </li>            
            <li>
              <button type="button" onclick="menuFontModify('NanumSquareR')">                
                <p style="font-family: NanumSquareR;"><spring:message code="wzwg.webModule.word.nanumSquareR"/></p>
              </button>
            </li>            
            <li>
              <button type="button" onclick="menuFontModify('NanumGothic')">                
                <p style="font-family: NanumGothic;"><spring:message code="wzwg.webModule.word.nanumGothic"/></p>
              </button>
            </li>            
            <li>
              <button type="button" onclick="menuFontModify('IropkeBatang')">                
                <p style="font-family: IropkeBatang;"><spring:message code="wzwg.webModule.word.iropkeBatang"/></p>
              </button>
            </li>            
            <li>
              <button type="button" onclick="menuFontModify('NanumBrush')">                
                <p style="font-family: NanumBrush;"><spring:message code="wzwg.webModule.word.nanumBrush"/></p>
              </button>
            </li>            
         </ul>
	</div>
	
	<!-- CSS 리스트 -->
	<div id="cssListDiv" title="<spring:message code="wzwg.site.screen.msg.MSG120"/>"></div>
	
	<!-- 게시판변경 -->
	<div id="boardChangeDiv" title="<spring:message code="wzwg.site.screen.msg.MSG121"/>" ></div>
		