package egovframework.wzwg.cmm.conectCtrl.service.impl;

import java.io.InputStreamReader;
import java.io.Reader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.CacheManager;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.service.Globals;
import egovframework.wzwg.cmm.conectCtrl.service.ConectCtrlService;
import egovframework.wzwg.cmm.conectCtrl.service.ConectCtrlVO;
import egovframework.wzwg.cmm.conectCtrl.service.RequestAcqsDataVO;
import egovframework.wzwg.cmm.util.Punycode;

@Service("ConectCtrlService")
public class ConectCtrlServiceImpl extends EgovAbstractServiceImpl implements ConectCtrlService {
    
    protected final static Log LOG = LogFactory.getLog(ConectCtrlServiceImpl.class);

    private final String BASE_SITE = Globals.BASE_SITE_URL;
    private final String ADMIN_LOGIN_PAGE = Globals.URL_PREFIX+"/cmm/mber/login/mngrLoginForm.do";
    private final String MAIN_PAGE = "/index.do";
    private final String ADMIN_MAIN_PAGE = Globals.URL_PREFIX+"/cmm/mber/login/actionMngrMain.do";
    private final String BASE_AUTHOR = "ROLE_PUBLIC";
    private final String ADMIN_PREFIX = Globals.URL_PREFIX+"/mngr";
    @SuppressWarnings("unused")
    private final String[] URL_AUTHOR_READ_PATTERN = {"select", "get", "list", "detail"};
    private final String[] URL_AUTHOR_WRITE_PATTERN = {"regist", "modify", "delete", "insert", "update"};
    private final String AUTH_READ_CODE = "R";
    @SuppressWarnings("unused")
    private final String AUTH_WRITE_CODE = "C";
    private final String ADMIN_SUPER_AUTH_CODE = "ASC001";
    @Resource(name="ConectCtrlDAO")
    private ConectCtrlDAO conectCtrlDAO;
    
    @Autowired
    HttpServletResponse response;
    
    public String getAdminPrefix() throws Exception {
        return ADMIN_PREFIX;
    }

    public RequestAcqsDataVO baseSiteInfoCheck(HttpServletRequest request, String siteUrl,String siteKey) throws Exception { 
        
        String  retUrl = "";
        boolean siteKeyYn=false;
        RequestAcqsDataVO radVO = new RequestAcqsDataVO();
        
        
        Map<String, String> sysSiteMap = this.selectSiteSeqBySysSiteSeq(siteUrl);
        if(siteKey.equals("")) {
        
        if (siteUrl.indexOf("xn--") > -1) {
        	
        	String chk = "";
        	String punyUrl = siteUrl.replace("xn--", "");
        	
        	if(siteUrl.indexOf(".xn--") > -1) {
        		chk = siteUrl.substring(0, siteUrl.indexOf(".xn--")+1) ;
        		punyUrl = punyUrl.replace(chk, "");
        	}
        	
/*        	if (siteUrl.indexOf("www.") > -1) {
        		punyUrl = punyUrl.replace("www.", "");
        		chk = "www.";
        	}*/
        	
        	String domn = "";
        	
        	if (punyUrl.indexOf(".") > -1) {
        		domn = punyUrl.substring(punyUrl.indexOf("."), punyUrl.length());
        		punyUrl = punyUrl.substring(0, punyUrl.indexOf("."));

        		punyUrl = Punycode.decode(punyUrl);
        	}
        	
        	siteUrl = chk+punyUrl+domn;
        	
        }
        Map<String, ConectCtrlVO> siteMap = this.selectSiteUrlBySiteSeq(siteUrl);
        if(siteUrl != null && siteMap.get(siteUrl) != null) {
        String siteSeq = StringUtils.defaultString(siteMap.get(siteUrl).getSiteSeq());
        String domnSeq = StringUtils.defaultString(siteMap.get(siteUrl).getDomnSeq());
        String siteNm = StringUtils.defaultString(siteMap.get(siteUrl).getSiteNm());
        String siteLclasGroup = StringUtils.defaultString(siteMap.get(siteUrl).getSiteLclasGroup());
        String siteMlsfcGroup = StringUtils.defaultString(siteMap.get(siteUrl).getSiteMlsfcGroup());
        String sslUseAt = StringUtils.defaultString(siteMap.get(siteUrl).getSslUseAt());
        String useLangCode = StringUtils.defaultString(siteMap.get(siteUrl).getUseLangCode());
        String ablEnncAt = StringUtils.defaultString(siteMap.get(siteUrl).getAblEnncAt());
        String sysSiteAt = StringUtils.defaultString(sysSiteMap.get(siteSeq));
        String asscNo = StringUtils.defaultString(siteMap.get(siteUrl).getAsscNo());
        siteKey = StringUtils.defaultString(siteMap.get(siteUrl).getSiteKey());
        
        if ("".equals(siteSeq)) {
            retUrl = StringUtils.defaultString(request.getHeader("Referer"));
             
            if ("".equals(retUrl)) {
                //retUrl = BASE_SITE;
                //radVO.setErrCd("ACCESS_ERR_02");
            	response.setStatus(404);  
        		throw new Exception("not SiteKey ");
            }
        }

        radVO.setSiteSeq(siteSeq);
        radVO.setSiteNm(siteNm);
        radVO.setSysSiteAt(sysSiteAt);
        radVO.setDomnSeq(domnSeq);
        radVO.setSiteLclasGroup(siteLclasGroup);
        radVO.setSiteMlsfcGroup(siteMlsfcGroup);
        radVO.setUseLangCode(useLangCode);
        radVO.setSslUseAt(sslUseAt);
        radVO.setAblEnncAt(ablEnncAt);
        radVO.setAsscNo(asscNo);
       // radVO.setSiteKey(siteKey);
        radVO.setRetUrl(retUrl);
        }
    }else {
        Reader reader = new InputStreamReader(getClass().getResourceAsStream("/egovframework/egovProps/globals.properties") );

    	Properties properties = new Properties();
    	properties.load(reader);
    	String oldSiteUrl=siteUrl;
    	  siteUrl =  properties.getProperty("reprsnt.domn.url");
    	  
    	  Map<String, ConectCtrlVO>     siteMap = this.selectSiteKeyBySiteSeq(siteKey,oldSiteUrl);
    	  if(siteMap.get(siteKey) != null) {
    	       // if(siteMap.get(siteKey) != null) {
    	        if (siteUrl.indexOf("xn--") > -1) {
    	        	
    	        	String chk = "";
    	        	String punyUrl = siteUrl.replace("xn--", "");

    	        	if(siteUrl.indexOf(".xn--") > -1) {
    	        		chk = siteUrl.substring(0, siteUrl.indexOf(".xn--")+1) ;
    	        		punyUrl = punyUrl.replace(chk, "");
    	        	}
    	        	/*
    	        	if (siteUrl.indexOf("www.") > -1) {
    	        		punyUrl = punyUrl.replace("www.", "");
    	        		chk = "www.";
    	        	}
    	        	*/
    	        	String domn = "";
    	        	
    	        	if (punyUrl.indexOf(".") > -1) {
    	        		domn = punyUrl.substring(punyUrl.indexOf("."), punyUrl.length());
    	        		punyUrl = punyUrl.substring(0, punyUrl.indexOf("."));

    	        		punyUrl = Punycode.decode(punyUrl);
    	        	}
    	        	
    	        	siteUrl = chk+punyUrl+domn;

    	        }
    	        
    	        String siteSeq = StringUtils.defaultString(siteMap.get(siteKey).getSiteSeq());
    	        String domnSeq = StringUtils.defaultString(siteMap.get(siteKey).getDomnSeq());
    	        String siteNm = StringUtils.defaultString(siteMap.get(siteKey).getSiteNm());
    	        String siteLclasGroup = StringUtils.defaultString(siteMap.get(siteKey).getSiteLclasGroup());
    	        String siteMlsfcGroup = StringUtils.defaultString(siteMap.get(siteKey).getSiteMlsfcGroup());
    	        String sslUseAt = StringUtils.defaultString(siteMap.get(siteKey).getSslUseAt());
    	        String useLangCode = StringUtils.defaultString(siteMap.get(siteKey).getUseLangCode());
    	        String ablEnncAt = StringUtils.defaultString(siteMap.get(siteKey).getAblEnncAt());
    	        String sysSiteAt = StringUtils.defaultString(sysSiteMap.get(siteSeq));
    	        String asscNo = StringUtils.defaultString(siteMap.get(siteKey).getAsscNo()); 
                siteKey = StringUtils.defaultString(siteMap.get(siteKey).getSiteKey());
    	        
    	        if ("".equals(siteSeq)) {
    	            retUrl = StringUtils.defaultString(request.getHeader("Referer"));
    	            
    	            if ("".equals(retUrl)) {
    	                //retUrl = BASE_SITE;
    	                //radVO.setErrCd("ACCESS_ERR_02");
    	            	response.setStatus(404);  
    	        		throw new Exception("not SiteKey ");
    	            }
    	        }
    	        
    	        
    	        radVO.setSiteSeq(siteSeq);
    	        radVO.setSiteNm(siteNm);
    	        radVO.setSysSiteAt(sysSiteAt);
    	        radVO.setDomnSeq(domnSeq);
    	        radVO.setSiteLclasGroup(siteLclasGroup);
    	        radVO.setSiteMlsfcGroup(siteMlsfcGroup);
    	        radVO.setUseLangCode(useLangCode);
    	        radVO.setSslUseAt(sslUseAt);
    	        radVO.setAblEnncAt(ablEnncAt);
    	        radVO.setAsscNo(asscNo);
    	        radVO.setSiteKey(siteKey);

    	        radVO.setRetUrl(retUrl);
    	        siteKeyYn = true;
    	        radVO.setSiteKeyYn(siteKeyYn);
    	  }else { 
      	       siteUrl = oldSiteUrl; 
       		 siteMap = this.selectSiteUrlBySiteSeq(siteUrl);
       	 
            	String reprsntDomn  =  properties.getProperty("reprsnt.domn.url");
            	  
       	        if (siteUrl.indexOf("xn--") > -1) {
       	        	
       	        	String chk = "";
       	        	String punyUrl = siteUrl.replace("xn--", "");
       	        	
       	        	if(siteUrl.indexOf(".xn--") > -1) {
    	        		chk = siteUrl.substring(0, siteUrl.indexOf(".xn--")+1) ;
    	        		punyUrl = punyUrl.replace(chk, "");
    	        	}
       	        	/*
       	        	if (siteUrl.indexOf("www.") > -1) {
       	        		punyUrl = punyUrl.replace("www.", "");
       	        		chk = "www.";
       	        	}
       	        	*/
       	        	String domn = "";
       	        	
       	        	if (punyUrl.indexOf(".") > -1) {
       	        		domn = punyUrl.substring(punyUrl.indexOf("."), punyUrl.length());
       	        		punyUrl = punyUrl.substring(0, punyUrl.indexOf("."));

       	        		punyUrl = Punycode.decode(punyUrl);
       	        	}

       	        	siteUrl = chk+punyUrl+domn;
       	        } 
       	        if(!siteKey.equals("")) {
       	        	 //retUrl = StringUtils.defaultString(request.getHeader("Referer"));
       	        	 //retUrl = BASE_SITE;
    	             //radVO.setErrCd("ACCESS_ERR_02");
       	        	response.setStatus(404);  
	        		throw new Exception("not SiteKey ");
       	        }
       	        
       	        if (siteMap==null) {
       	            retUrl = StringUtils.defaultString(request.getHeader("Referer"));
       	            
       	            if (siteMap== null) {
       	                //retUrl = BASE_SITE;
       	                //radVO.setErrCd("ACCESS_ERR_02");"
       	            	response.setStatus(404);  
    	        		throw new Exception("not SiteKey ");
       	            }
       	        }
       	        
       	        String siteSeq = StringUtils.defaultString(siteMap.get(siteUrl).getSiteSeq());
       	        String domnSeq = StringUtils.defaultString(siteMap.get(siteUrl).getDomnSeq());
       	        String siteNm = StringUtils.defaultString(siteMap.get(siteUrl).getSiteNm());
       	        String siteLclasGroup = StringUtils.defaultString(siteMap.get(siteUrl).getSiteLclasGroup());
       	        String siteMlsfcGroup = StringUtils.defaultString(siteMap.get(siteUrl).getSiteMlsfcGroup());
       	        String sslUseAt = StringUtils.defaultString(siteMap.get(siteUrl).getSslUseAt());
       	        String useLangCode = StringUtils.defaultString(siteMap.get(siteUrl).getUseLangCode());
       	        String ablEnncAt = StringUtils.defaultString(siteMap.get(siteUrl).getAblEnncAt());
       	        String sysSiteAt = StringUtils.defaultString(sysSiteMap.get(siteSeq));
       	        String asscNo = StringUtils.defaultString(siteMap.get(siteUrl).getAsscNo());
       	              siteKey = StringUtils.defaultString(siteMap.get(siteUrl).getSiteKey());
       	        
       	        if (siteMap==null && "".equals(siteSeq)) {
       	            retUrl = StringUtils.defaultString(request.getHeader("Referer"));
       	            
       	            if (siteMap== null && "".equals(retUrl)) {
       	                retUrl = BASE_SITE;
       	                radVO.setErrCd("ACCESS_ERR_02");
       	            }
       	        }
       	        radVO.setSiteSeq(siteSeq);
       	        radVO.setSiteNm(siteNm);
       	        radVO.setSysSiteAt(sysSiteAt);
       	        radVO.setDomnSeq(domnSeq);
       	        radVO.setSiteLclasGroup(siteLclasGroup);
       	        radVO.setSiteMlsfcGroup(siteMlsfcGroup);
       	        radVO.setUseLangCode(useLangCode);
       	        radVO.setSslUseAt(sslUseAt);
       	        radVO.setAblEnncAt(ablEnncAt);
       	        radVO.setAsscNo(asscNo);
       	        radVO.setSiteKey(siteKey);
       	        radVO.setRetUrl(retUrl);
       	  }
       }
        return radVO;
    }
    
    @Autowired 
    private CacheManager cacheManager;
    
	@Override
    public Map<String, ConectCtrlVO> selectSiteUrlBySiteSeq(String siteUrl) throws Exception {
        
        List<ConectCtrlVO> siteList = conectCtrlDAO.selectSiteUrlBySiteSeq(siteUrl);
        Map<String, ConectCtrlVO> siteMap = new HashMap<String, ConectCtrlVO>();

        for (int i=0; i<siteList.size(); i++) {
            ConectCtrlVO getVO = siteList.get(i);
            if(getVO.getSiteUrl() != null){
            siteMap.put(getVO.getSiteUrl(), getVO);
            }
        }

        return siteMap;
    }
	
    
    	public Map<String, ConectCtrlVO> selectSiteKeyBySiteSeq(String siteKey,String siteUrl) throws Exception {
        
        List<ConectCtrlVO> siteList = conectCtrlDAO.selectSiteKeyBySiteSeq(siteKey);
        Map<String, ConectCtrlVO> siteMap = new HashMap<String, ConectCtrlVO>();

        for (int i=0; i<siteList.size(); i++) {
            ConectCtrlVO getVO = siteList.get(i);
            if(getVO.getSiteKey() != null){
            if((siteUrl+"/"+siteKey).equals(getVO.getSiteUrl())) {
            siteMap.put(getVO.getSiteKey(), getVO);
            }
            }
        }

        return siteMap;
    }

    public Map<String, String> selectSiteSeqBySysSiteSeq(String siteUrl) throws Exception {
        
        List<ConectCtrlVO> siteList = conectCtrlDAO.selectSiteSeqBySysSiteSeq(siteUrl);
        Map<String, String> sysSiteMap = new HashMap<String, String>();

        for (int i=0; i<siteList.size(); i++) {
            ConectCtrlVO getVO = siteList.get(i);

            sysSiteMap.put(getVO.getSiteSeq(), "Y");
        }

        return sysSiteMap;
    }


    
}
