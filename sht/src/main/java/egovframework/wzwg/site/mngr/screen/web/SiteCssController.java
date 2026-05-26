package egovframework.wzwg.site.mngr.screen.web;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import dggb.util.DateUtils;
import egovframework.com.cmm.interceptor.AuthenticCmntInterceptor;
import egovframework.wzwg.cmm.util.CmmJsonAjaxResponser;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.site.mngr.screen.service.SiteScreenVO;

@Controller
public class SiteCssController {
	private final Log LOG = LogFactory.getLog(AuthenticCmntInterceptor.class.getName());
	
	@RequestMapping(value={"/mngr/subCss/selectSubCssInc.do","/{siteKey}/mngr/subCss/selectSubCssInc.do"})
    public String selectSubCssInc(
            @ModelAttribute("paramVO") SiteScreenVO paramVO
            , HttpServletRequest request
            , Model model
            ) throws Exception{
        
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        HttpSession session = request.getSession();
        
        String webRootPath = session.getServletContext().getRealPath("/"); //끝에 '/' 이 포함되어 있음
        //System.out.println(webRootPath);
        String cssPath = "upload/subCss/" + CmmSessionUtil.getSessionSiteSeq(request) + "/sub.css";
        
        File cssFile = new File(FilenameUtils.separatorsToSystem(webRootPath + cssPath));
        
        if(cssFile != null && cssFile.getParentFile() != null && cssFile.getParentFile().exists() == false) { //부모폴더 체크
        	boolean b = cssFile.getParentFile().mkdirs(); //만들면 true 아니면 false(못만들었거나 이미 있거나?)
        	if(b == false) {
        		throw new IOException("DIR Access fail");
        	}
        }
        
        if(cssFile.exists() == false) {
        	// CSS 파일이 없다면 기본 생성 
        	FileWriter fw = null;
        	try {
        		fw = new FileWriter(cssFile);
        		fw.write("/*not found Sub css file*/");			
        	} catch (IOException e) {
        		LOG.error(e);
        	} catch (RuntimeException e) {
        		LOG.error(e);
        	}finally {
        		try {
        			if(fw != null) {
        				fw.close();
        			}
        		} catch (IOException e2) {
        			LOG.error(e2);
        			throw new IOException("FILE Close fail");
        			
        		}
        	}
        }
        //System.out.println(FilenameUtils.separatorsToSystem(webRootPath + cssPath));
        
        paramVO.setSubCss("/" + cssPath);
        
        return "wzwg/site/mngr/screen/subcss/subcssInc";
    }
	
	@RequestMapping(value={"/mngr/subCss/registSubCssAjax.do","/{siteKey}/mngr/subCss/registSubCssAjax.do"})
	public String registSubCssAjax(
			@ModelAttribute("paramVO") SiteScreenVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception{
		
		String resultCode = "1";
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		HttpSession session = request.getSession();
		
		String webRootPath = session.getServletContext().getRealPath("/"); //끝에 '/' 이 포함되어 있음
		//System.out.println(webRootPath);
		
		/**
		 * 1. 백업폴더에 현제일 기준으로 저장 한다
		 */
		String cssBakPath = "upload/subCss/" + CmmSessionUtil.getSessionSiteSeq(request) + "/bak/sub_" + DateUtils.getCurrentDate("yyyyMMddHHmmss") + ".css";
		
		File cssBakFile = new File(FilenameUtils.separatorsToSystem(webRootPath + cssBakPath));
		
		if(cssBakFile != null && cssBakFile.getParentFile() != null && cssBakFile.getParentFile().exists() == false) { //부모폴더(백업폴더) 체크 
			boolean b = cssBakFile.getParentFile().mkdirs(); //만들면 true 아니면 false(못만들었거나 이미 있거나?)
			if(b == false) {
				//throw new IOException("DIR Access fail");
				resultCode = "2";
			}
		}
		
		if(cssBakFile.exists() == false) {
			// CSS 파일이 없다면 기본 생성 
			FileWriter fw = null;
			try {
				fw = new FileWriter(cssBakFile);
				fw.write(paramVO.getContents());			
			} catch (IOException e) {
				LOG.error(e);
			} catch (RuntimeException e) {
				LOG.error(e);
			}finally {
				try {
					if(fw != null) {
						fw.close();
					}
				} catch (IOException e2) {
					LOG.error(e2);
					//throw new IOException("FILE Close fail");
					resultCode = "3";
					
				}
			}
		}

		/**
		 * 2. 기준 파일에 덮어 씌운다
		 */
		String cssPath = "upload/subCss/" + CmmSessionUtil.getSessionSiteSeq(request) + "/sub.css";
        
        File cssFile = new File(FilenameUtils.separatorsToSystem(webRootPath + cssPath));
        
        if(cssFile != null && cssFile.getParentFile() != null && cssFile.getParentFile().exists() == false) { //부모폴더 체크
        	boolean b = cssFile.getParentFile().mkdirs(); //만들면 true 아니면 false(못만들었거나 이미 있거나?)
        	if(b == false) {
        		//throw new IOException("DIR Access fail");
        		resultCode = "4";
        	}
        }
        
        //if(cssFile.exists() == false) {
        	// CSS 파일이 없다면 기본 생성 
        	FileWriter fw = null;
        	try {
        		fw = new FileWriter(cssFile, false); //덮어쓰기 옵션추가
        		fw.write(paramVO.getContents());			
        	} catch (IOException e) {
        		LOG.error(e);
        	} catch (RuntimeException e) {
        		LOG.error(e);
        	}finally {
        		try {
        			if(fw != null) {
        				fw.close();
        			}
        		} catch (IOException e2) {
        			LOG.error(e2);
        			//throw new IOException("FILE Close fail");
        			resultCode = "5";
        			
        		}
        	}
        //}
		
		String resultMsg = "";
		if(resultCode.equals("2")) {
			resultMsg = "backup directory make fail";
		}else if(resultCode.equals("3")) {
			resultMsg = "backup file close fail";
		}else if(resultCode.equals("4")) {
			resultMsg = "css directory make fail";
		}else if(resultCode.equals("4")) {
			resultMsg = "css file close fail";
		}
		
		if(resultCode.equals("1")) {
			resultCode = "success";
		}else {
			resultCode = "fail";
		}
		
		return CmmJsonAjaxResponser.getInstance().setResultCode(resultCode).setResultMsg(resultMsg).returnJsp(model);
	}
	
	@RequestMapping(value={"/mngr/subCss/selectSubCssSaveFileListAjax.do","/{siteKey}/mngr/subCss/selectSubCssSaveFileListAjax.do"})
    public String selectSubCssSaveFileListAjax(
            @ModelAttribute("paramVO") SiteScreenVO paramVO
            , HttpServletRequest request
            , Model model
            ) throws Exception{
        
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        HttpSession session = request.getSession();
        
        String webRootPath = session.getServletContext().getRealPath("/"); //끝에 '/' 이 포함되어 있음
        //System.out.println(webRootPath);
        String cssPath = "upload/subCss/" + CmmSessionUtil.getSessionSiteSeq(request) + "/sub.css";
        
        /**
		 * 1. 백업폴더에 현제일 기준으로 저장 한다
		 */
        List<String> resultList = null;
		String cssBakPath = "upload/subCss/" + CmmSessionUtil.getSessionSiteSeq(request) + "/bak";
		
		File cssBakDir = new File(FilenameUtils.separatorsToSystem(webRootPath + cssBakPath));
		
		if(cssBakDir.exists() == false) { //폴더(백업폴더) 체크 
			//백업폴더가 생성되어 있지 않으면 패스
		}else {
			String[] cssFiles = cssBakDir.list();
			
			Arrays.sort(cssFiles, new Comparator<String>() {
				   public int compare(String arg0, String arg1) {
				    
				    return arg1.compareToIgnoreCase(arg0); //최신파일이 위로 올라오게 설정
				   }
				});

			if(cssFiles != null && cssFiles.length > 30) {
				//히스토리는 30개 까지만 유지하고 넘을경우 삭제해버린다
				// TOCTOU 방지를 위한 synchronized 블록
				synchronized(this) {
					for (int i = (cssFiles.length -1); i >= 30; i--) {
						File delCssFile = new File(cssBakDir.getPath() + "/" + cssFiles[i]);
						try {
							if(!delCssFile.delete() && delCssFile.exists()) {
								LOG.error("CSS bakup File delete Not Exists : " + delCssFile.getAbsolutePath());
							}
						} catch (RuntimeException e) {
							LOG.error("selectSubCssSaveFileListAjax RuntimeException" , e);
						}
					}
				}
				resultList = Arrays.asList(Arrays.copyOfRange(cssFiles, 0, 29));
			}else {
				resultList = Arrays.asList(cssFiles);
			}
		}
		
		if(resultList == null) {
			resultList = new ArrayList<String>();
		}
        
		return CmmJsonAjaxResponser.getInstance().setResultCode("success").setBodyData("resultList", resultList).returnJsp(model);
    }
}
