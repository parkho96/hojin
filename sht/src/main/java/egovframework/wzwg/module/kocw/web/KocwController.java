package egovframework.wzwg.module.kocw.web;

import java.io.IOException;
import java.net.SocketTimeoutException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.IllegalFormatException;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Parser;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.kocw.service.KocwVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoService;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class KocwController {
    
    @Resource(name="CntntsInfoService")
    private CntntsInfoService cntntsInfoService;

    @RequestMapping(value="/**/module/kocw/selectKocwInc.do")
    public String selectKocwInc(
            @ModelAttribute("paramVO") KocwVO paramVO
            , HttpServletRequest request 
            , ModelMap model
        ) throws Exception{  
        
        return "wzwg/module/kocw/kocwInc";
    }
    
    @RequestMapping(value="/**/module/kocw/kocwFormAjax.do")
    public String selectKocwDetailAjax(
            @ModelAttribute("paramVO") KocwVO paramVO
            , HttpServletRequest request 
            , ModelMap model
        ) throws Exception{
        
        String sitecntntsSeq = StringUtils.defaultString(paramVO.getSitecntntsSeq());
        
        if (!"".equals(sitecntntsSeq)) {
            CntntsInfoVO ciVO = new CntntsInfoVO();
            
            ciVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
            ciVO.setSearchCntntsSeq(paramVO.getSitecntntsSeq());
            
            CntntsInfoVO getCiVO = cntntsInfoService.selectCntntsBassInfo(ciVO);
            
            model.addAttribute("resultVO", getCiVO);   
        } else {
            CntntsInfoVO ciVO = new CntntsInfoVO();
            
            ciVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
            ciVO.setSearchModuleSeq(paramVO.getSearchModuleSeq());
            
            CntntsInfoVO getCiVO = cntntsInfoService.selectCntntsBassInfo(ciVO);
            
            model.addAttribute("selModuleVO", getCiVO);
            model.addAttribute("resultVO", new CntntsInfoVO());
        }
        
        return "/wzwg/module/kocw/kocwForm";
    } 
    
    @RequestMapping(value="/**/module/kocw/modifyKocwAjax.do")
    public ModelAndView modifyKocwAjax(
            @ModelAttribute("paramVO") KocwVO paramVO
            , HttpServletRequest request 
            , ModelMap model
        ) throws Exception{
    	
    	String result= "success";
        
        try {
            /** 로그인 한 사용자 입력 */
            CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
            
            CntntsInfoVO ciVO = new CntntsInfoVO();
            
            ciVO.setCntntsNm(paramVO.getSitecntntsNm());
            ciVO.setCntntsDc(paramVO.getSitecntntsNm());
            ciVO.setSitecntntsSeq(paramVO.getSitecntntsSeq());
            ciVO.setLastUpdusrId(loginVO.getUserId());
            
            cntntsInfoService.modifyCntntsInfoInit(ciVO);
            
        }  catch(NullPointerException e){          	 
          	 result = "fail";
      	}catch(NumberFormatException e){      		 
      		 result = "fail";
      	}catch(IllegalFormatException e){      		 
      		 result = "fail";
      	}catch(ArrayIndexOutOfBoundsException e){      		 
      		 result = "fail";
      	}
        
        return CmmAjaxUtil.getAjaxReturn(result);
    }
    
    @RequestMapping(value="/**/module/kocw/selectKocwListAjax.do")
    public String selectKocwListAjax(
            @ModelAttribute("paramVO") KocwVO paramVO
            , HttpServletRequest request 
            , ModelMap model
        ) throws Exception{
        
        Map<String, String> dataMap = new HashMap<String, String>();
        
        try {

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
        paginationInfo.setPageSize(paramVO.getPageSize());

        dataMap.put("key", "81037de60edfe9f599fd5c6892003f786d4abc5ebadf812a");
//        dataMap.put("start_num", Integer.toString(paginationInfo.getFirstRecordIndex()+1));
//        dataMap.put("end_num", Integer.toString(paginationInfo.getLastRecordIndex()));
        if (!"".equals(StringUtils.defaultString(paramVO.getCategoryId()))) {
            dataMap.put("category_id", paramVO.getCategoryId());
        }
        if (!"".equals(StringUtils.defaultString(paramVO.getFrom()))) {
            dataMap.put("from", paramVO.getFrom());
        }
        if (!"".equals(StringUtils.defaultString(paramVO.getTo()))) {
            dataMap.put("to", paramVO.getTo());
        }
        
        paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        Document doc = getJsoupConnData(dataMap);
        
        Map<String, String> infoMap = new HashMap<String, String>();
        
        if(doc != null) {
	        Elements infoEle = doc.select("header");
	        for (Element e : infoEle) {
	            infoMap.put("from", getDataFormat(e.select("from").text()));
	            infoMap.put("to", getDataFormat(e.select("to").text()));
	            infoMap.put("start_num", e.select("start_num").text());
	            infoMap.put("end_num", e.select("end_num").text());
	            infoMap.put("total_count", e.select("total_count").text());
	            infoMap.put("list_count", e.select("list_count").text());
	        }
        }
        paginationInfo.setTotalRecordCount(Integer.parseInt(StringUtils.defaultString(infoMap.get("total_count"),"0")));
        model.addAttribute("paginationInfo", paginationInfo);
        
        List<Map<String, String>> resultList = new ArrayList<Map<String, String>>();
        
        if(doc != null) {
	        // 결과
	        Elements listEle = doc.select("list_item");
	        for (Element e : listEle) {
	            // 야매 페이징  - 처리
	            // API 호출시 같은 조건으로 조회해도 total_cnt 값이 바뀜...
	            if (paginationInfo.getFirstRecordIndex()+1 <= Integer.parseInt(e.select("list_num").text())
	                    && paginationInfo.getLastRecordIndex() >= Integer.parseInt(e.select("list_num").text())) {
	                Map<String, String> listMap = new HashMap<String, String>();
	                
	                listMap.put("taxon", e.select("taxon").text());
	                listMap.put("list_num", e.select("list_num").text());
	                listMap.put("course_id", e.select("course_id").text());
	                listMap.put("course_url", e.select("course_url").text());
	                listMap.put("lecturer", e.select("lecturer").text());
	                listMap.put("course_title", e.select("course_title").text());
	                listMap.put("provider", e.select("provider").text());
	                listMap.put("term", e.select("term").text());
	                listMap.put("course_description", e.select("course_description").text());
	                listMap.put("thumbnail_url", e.select("thumbnail_url").text());
	//                listMap.put("syllabus_url", e.select("syllabus_url").text());
	                listMap.put("created_date", e.select("created_date").text());
	                
	                resultList.add(listMap);
	            }
	        }
        }

        model.addAttribute("resultVO", infoMap);
        model.addAttribute("resultList", resultList);   
        } catch(NullPointerException e){
         	 log.error("NullPointerException",e);
  	   	}catch(NumberFormatException e){
  	   		log.error("NumberFormatException",e);
  	   	}catch(IllegalFormatException e){
  	   		log.error("IllegalFormatException",e);
  	   	}catch(ArrayIndexOutOfBoundsException e){
  	   		log.error("ArrayIndexOutOfBoundsException",e);
  	   	}
        return "wzwg/module/kocw/kocwList";
    }
    
    private String getDataFormat(String dateStr) throws ParseException {

        SimpleDateFormat dt = new SimpleDateFormat("yyyymmdd"); 
        Date date = dt.parse(dateStr); 
        SimpleDateFormat dt1 = new SimpleDateFormat("yyyy-mm-dd");
        return dt1.format(date);
    }
    
    private int jsoupConnCnt = 0;
    
    private Document getJsoupConnData(Map<String, String> dataMap) {
        
        Document doc = null;
        if ( jsoupConnCnt > 10) {
            return doc;
        } 
        try {
            doc = Jsoup.connect("http://www.kocw.net/home/api/handler.do")
                    .data(dataMap)
                    .parser(Parser.xmlParser()).timeout(3000).get();
        } catch (SocketTimeoutException se) {
            jsoupConnCnt++;
            getJsoupConnData(dataMap);
        }  catch(NullPointerException e){
        	jsoupConnCnt++;
         	 log.error("NullPointerException",e);
  	   	}catch(NumberFormatException e){
  	   	jsoupConnCnt++;
  	   		log.error("NumberFormatException",e);
  	   	}catch(IllegalFormatException e){
  	   	jsoupConnCnt++;
  	   		log.error("IllegalFormatException",e);
  	   	}catch(ArrayIndexOutOfBoundsException e){
  	   	jsoupConnCnt++;
  	   		log.error("ArrayIndexOutOfBoundsException",e);
  	   	}catch(IOException e){
  	   	jsoupConnCnt++;
  	   		log.error("IOException",e);
  	   	}
        
        if (doc != null ) {
            return doc;
        } else {
            return getJsoupConnData(dataMap);
        }
    }
}
