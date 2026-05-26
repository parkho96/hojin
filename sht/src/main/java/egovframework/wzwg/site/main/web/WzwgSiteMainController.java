package egovframework.wzwg.site.main.web;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.util.UrlPathHelper;

import dggb.util.FileUtils;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.service.Globals;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.scrin.service.ScrinMenuVO;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuService;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuVO;
import egovframework.wzwg.site.mngr.screen.service.SiteScreenService;
import egovframework.wzwg.site.mngr.screen.service.SiteTemplateScreenService;
import egovframework.wzwg.site.mngr.screen.service.SiteTemplateScreenVO;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoVO;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class WzwgSiteMainController {
	
    
    @Resource(name="egovMessageSource")
    private EgovMessageSource egovMessageSource;
    
    @Resource(name="SiteScreenService")
    private SiteScreenService siteScreenService;
     
    @Resource(name="SiteTemplateScreenService")
    private SiteTemplateScreenService siteTemplateScreenService;
    
    @Resource(name="SiteMenuService")
    private SiteMenuService siteMenuService;
    
    @Resource(name="SysMngrSiteAdiInfoService")
    private SysMngrSiteAdiInfoService siteAdiInfoService;

    @RequestMapping(value={"/","/{siteKey}","/{siteKey}/","/index.do","/{siteKey}/index.do"})
    public String selectSitemain(HttpServletRequest request, 
            HttpSession session, 
            ModelMap model) throws Exception{
    	
    	UrlPathHelper urlPathHelper = new UrlPathHelper();
    	String   nowUri  = urlPathHelper.getOriginatingRequestUri(request);
    	
    	//System.out.println("nowUri : "+nowUri );
    	
    	String reprsntSiteKey = Globals.REPRSNT_SITEKEY;
    	if(nowUri.lastIndexOf(".do") >1 && nowUri.indexOf("/index.do")<0) {
    		//response.setStatus(404);
    		//throw new Exception("not SiteKey ");	
    		return "redirect:/"+reprsntSiteKey+"/index.do";
    	}
    	if(!nowUri.equals("") && !nowUri.equals("/") && nowUri.indexOf("/index.do")<0) {
    		return "redirect:/"+nowUri.replaceAll("/", "")+"/index.do";
    		//response.setStatus(404);  
    		//throw new Exception("not SiteKey ");
    	}
    	
    	if(nowUri.equals("") || nowUri.equals("/")) {
    		return "redirect:/index.do";
    		//response.setStatus(404);  
    		//throw new Exception("not SiteKey ");
    	}
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        String realPath =request.getServletContext().getRealPath("/");
        String siteDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request);
        String retUrl = "site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/index";
        SiteTemplateScreenVO siteTemplateScreenParam = new SiteTemplateScreenVO();
          if(session.getAttribute("subMenuSeq") != null){
                session.removeAttribute("subMenuSeq");
              }
              
          if(session.getAttribute("subMenuSeq") != null){
                session.removeAttribute("subMenuSeq");
              }
              
        /**도메인 SEQ */
        String domnSeq = CmmSessionUtil.getSessionDomnSeq(request);
        siteTemplateScreenParam.setSiteSeq(siteSeq);
        siteTemplateScreenParam.setDomnSeq(domnSeq);
        siteTemplateScreenParam.setUserId(CmmSessionUtil.getSessionUserId());
        if(siteTemplateScreenService.selectSiteTemplateScreenChk(siteTemplateScreenParam) <1){
            return "wzwg/site/cmm/work";
        }
        SiteTemplateScreenVO siteTemplateScreenVO = siteTemplateScreenService.selectSiteTemplateScreen(siteTemplateScreenParam);
        if("drag".equals(siteTemplateScreenVO.getTemplateNcnm())){
            String userAgentStr = request.getHeader("user-agent");
            String os ="";
            if(userAgentStr != null) {
                String upperUserAgent = userAgentStr.toUpperCase();
                if(upperUserAgent.indexOf("WINDOWS") != -1) {
                    os = "PC";
                } else if(upperUserAgent.indexOf("ANDROID") != -1) {
                    os = "MOBILE";
                } else if(upperUserAgent.indexOf("IPAD") != -1) {
                    os = "MOBILE";
                } else if(upperUserAgent.indexOf("IPHONE") != -1) {
                    os = "MOBILE";
                } else if(upperUserAgent.indexOf("MAC") != -1) {
                    os = "PC";
                } else {
                    os = "PC";
                }
            } else {
                os = "PC";
            }
            if("MOBILE".equals(os)){
              retUrl = "site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/mIndex";
            }
        }
        File siteDir = new File(siteDirStr);
        if(!siteDir.exists()){
        	 if(!siteDir.mkdirs()) {
            	 throw new IOException("Directory creation Failed ");	
            }
        }
        File indexFile = new File(siteDirStr+"/index.jsp");
        if(!indexFile.exists()){
            FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+EgovProperties.getProperty("defaultTempltJsp")), indexFile);
        }
        File topFile = new File(siteDirStr+"/topMenu.jsp");
        if(!indexFile.exists()){
            FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"topMenu.jsp"), topFile);
        }
        
        
        File footerFile = new File(siteDirStr+"/footerMenu.jsp");
        if(!topFile.exists()){
            FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"topMenu.jsp"), topFile);
        }
        if(!footerFile.exists()){
            FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"footerMenu.jsp"), footerFile);
        }
        String siteCssDirStr =realPath+"site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/css";
        File siteCssDir = new File(siteCssDirStr);
        if(!siteCssDir.exists()){
        	if(!siteCssDir.mkdirs()) {
              	 throw new IOException("Directory creation Failed ");	
              }
            FileUtils.copyDir(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"css"), siteCssDir);
        }
        ScrinMenuVO scrinMenuVO = new ScrinMenuVO();
        scrinMenuVO.setSiteSeq(siteSeq);
        model.addAttribute("firstNttMenuSeq", siteScreenService.selectFirstNttMenuSeq(scrinMenuVO));
        model.addAttribute("url", "/WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/index.jsp");
        model.addAttribute("topUrl", "/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/topMenu.do");
        model.addAttribute("footerUrl", "/WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/footerMenu.jsp");
        
        /* 메타키 조회를 위해 사이트 부가정보 추가 2018.08.16 moo0506 */
        SysMngrSiteAdiInfoVO siteAdinfoVO = new SysMngrSiteAdiInfoVO();
        siteAdinfoVO.setSiteSeq(siteSeq);
        siteAdinfoVO = siteAdiInfoService.selectSiteAdiInfoDetail(siteAdinfoVO);
        model.addAttribute("siteAdinfoVO", siteAdinfoVO);
        
        return retUrl;
    }
    
    @RequestMapping(value= {"/mngr/temp/index.do","/{siteKey}/mngr/temp/index.do"})
    public String selectSiteTempMain(HttpServletRequest request, 
            ModelMap model) throws Exception{
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        String realPath =request.getServletContext().getRealPath("/");
        String siteDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request);
        String retUrl = "site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/temp/index";
        SiteTemplateScreenVO siteTemplateScreenParam = new SiteTemplateScreenVO();
        String siteDirTempStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/temp";
        File siteTempDir = new File(siteDirTempStr);
        if(!siteTempDir.exists()){
            model.addAttribute("errCd", egovMessageSource.getMessage("wzwg.cmm.msg.MSG502"));
            return "wzwg/cmm/errorPopupForward";
        }
        /**도메인 SEQ */
        String domnSeq = CmmSessionUtil.getSessionDomnSeq(request);
        siteTemplateScreenParam.setSiteSeq(siteSeq);
        siteTemplateScreenParam.setDomnSeq(domnSeq);
        siteTemplateScreenParam.setUserId(CmmSessionUtil.getSessionUserId());
        if(siteTemplateScreenService.selectSiteTemplateScreenChk(siteTemplateScreenParam) <1){
            return "wzwg/site/cmm/work";
        }
        //SiteTemplateScreenVO siteTemplateScreenVO = siteTemplateScreenService.selectSiteTemplateScreen(siteTemplateScreenParam);
 
        ScrinMenuVO scrinMenuVO = new ScrinMenuVO();
        scrinMenuVO.setSiteSeq(siteSeq);
        model.addAttribute("firstNttMenuSeq", siteScreenService.selectFirstNttMenuSeq(scrinMenuVO));
        model.addAttribute("url", "/WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/temp/index.jsp");
        model.addAttribute("topUrl", "/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/topMenu.do");
        model.addAttribute("footerUrl", "/WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/footerMenu.jsp");
        
        return retUrl;
    }
    
    @RequestMapping(value= {"/mngr/{templateSeq}/template/index.do","/{siteKey}/mngr/{templateSeq}/template/index.do"})
    public String selectSiteTemplateMain(HttpServletRequest request, 
            @PathVariable(value = "templateSeq") String templateSeq,
            ModelMap model) throws Exception{
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        String realPath =request.getServletContext().getRealPath("/");
        String siteDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request);
        String retUrl = "site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/"+templateSeq+"/index";
        SiteTemplateScreenVO siteTemplateScreenParam = new SiteTemplateScreenVO();
        String siteDirTempStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/temp";
        File siteTempDir = new File(siteDirTempStr);
        if(!siteTempDir.exists()){
            
        }
        /**도메인 SEQ */
        String domnSeq = CmmSessionUtil.getSessionDomnSeq(request);
        siteTemplateScreenParam.setSiteSeq(siteSeq);
        siteTemplateScreenParam.setDomnSeq(domnSeq);
        siteTemplateScreenParam.setUserId(CmmSessionUtil.getSessionUserId());
        if(siteTemplateScreenService.selectSiteTemplateScreenChk(siteTemplateScreenParam) <1){
            return "wzwg/site/cmm/work";
        }
        //SiteTemplateScreenVO siteTemplateScreenVO = siteTemplateScreenService.selectSiteTemplateScreen(siteTemplateScreenParam);
 
        ScrinMenuVO scrinMenuVO = new ScrinMenuVO();
        scrinMenuVO.setSiteSeq(siteSeq);
        model.addAttribute("firstNttMenuSeq", siteScreenService.selectFirstNttMenuSeq(scrinMenuVO));
        model.addAttribute("url", "/WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/"+templateSeq+"/index.jsp");
        model.addAttribute("topUrl", "/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/topMenu.do?templateSeq="+templateSeq);
        model.addAttribute("footerUrl", "/WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/"+templateSeq+"/footerMenu.jsp");
        
        return retUrl;
    }
    
    @RequestMapping(value={"/working.do", "/{siteKey}/working.do"})
    public String selectWorking(
            @ModelAttribute("paramVO") SysMngrSiteAdiInfoVO paramVO,
            HttpServletRequest request, 
            ModelMap model) throws Exception{
          String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
          
          paramVO.setSiteSeq(siteSeq); 
          model.addAttribute("ftrMenuInfo", siteAdiInfoService.selectSiteFtrInfoDetail(paramVO));
        return "wzwg/site/cmm/work";
    }
    
    @RequestMapping(value= {"/indexSave.do","/{siteKey}/indexSave.do"})
    public String selectSitemainSave(HttpServletRequest request, 
            ModelMap model) throws Exception{
    	  FileWriter writer = null;
    	  BufferedWriter bw = null;
    	try {
        String realPath =request.getServletContext().getRealPath("/");
        String siteDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request);
        File siteDir = new File(siteDirStr);
        if(!siteDir.exists()){
        	 if(!siteDir.mkdirs()) {
            	 throw new IOException("Directory creation Failed ");	
            }
        }
        File indexFile = new File(siteDirStr+"/index.jsp");
        
          writer = new FileWriter(indexFile);
          bw = new BufferedWriter(writer);
        bw.write("<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\"    pageEncoding=\"UTF-8\"%>");
        bw.newLine();
        bw.write("<html lang=\"en\">");
        bw.newLine();
        bw.write("<head>");
        bw.newLine();
        bw.write("<meta charset=\"utf-8\">");
        bw.newLine();
        bw.write("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">");
        bw.newLine();
        bw.write("<title>jQuery UI Selectable - Display as grid</title>");
        bw.newLine();
        bw.write("<link rel=\"stylesheet\" href=\"http://code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css\">");
        bw.newLine();
        bw.write("<script src=\"https://code.jquery.com/jquery-1.12.4.js\"></script>");
        bw.newLine();
        bw.write("<script src=\"https://code.jquery.com/ui/1.12.0/jquery-ui.js\"></script>");
        bw.newLine();
        bw.write("</head>");
        bw.newLine();
        bw.write("<body>");
        bw.newLine();
        bw.write(" <div id=\"wrap\" class=\"wrap\" >");
        bw.newLine();
        bw.write(request.getParameter("contents")); 
        bw.newLine();
        bw.write("</div></body></html>");
        
        bw.close();
        writer.close();
    	}catch (IOException e) {
			// TODO: handle exception
    		log.error("IOException",e);
		}finally {
			 if(bw != null) try { bw.close(); } catch(IOException e) {log.error("IOException",e);}
			 if(writer != null) try { writer.close(); } catch(IOException e) {log.error("IOException",e);}
		}
        return "site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/index";
    }
    
    
    @RequestMapping(value={"/sitemap.do","/{siteKey}/sitemap.do"})
    public String sitemapTemplat(HttpServletRequest request, 
            @ModelAttribute("paramVO") SiteMenuVO paramVO,
            ModelMap model) throws Exception{

        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
                
        paramVO.setSiteSeq(siteSeq);
        paramVO.setMngrSiteMenuSe("N");
        List<SiteMenuVO> resultList = siteMenuService.selectSiteMenuList(paramVO);
        model.addAttribute("resultList",resultList);
        return "wzwg/site/cmm/sitemap";
    }
    
    @RequestMapping(value= {"/sitemap.xml","/{siteKey}/sitemap.xml"})
    public String sitemapXml(HttpServletRequest request, 
    		@ModelAttribute("paramVO") SiteMenuVO paramVO,
    		ModelMap model) throws Exception{
    	
    	String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
    	
    	String domain = "";
		String url = String.valueOf(request.getRequestURL());
		String uri = request.getRequestURI();

		domain = url.replace(uri, "");
		
		model.addAttribute("domain", domain);
		
    	paramVO.setSiteSeq(siteSeq);
    	List<SiteMenuVO> resultList = siteMenuService.selectSiteMenuList(paramVO);
    	model.addAttribute("resultList",resultList);
    	return "wzwg/site/cmm/sitemapXml";
    }
    
}
