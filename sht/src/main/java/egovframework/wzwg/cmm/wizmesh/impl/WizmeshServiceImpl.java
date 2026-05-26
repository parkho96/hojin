package egovframework.wzwg.cmm.wizmesh.impl;

import java.io.IOException;
import java.util.HashMap;
import java.util.IllegalFormatException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.w3c.dom.Text;

import egovframework.wzwg.cmm.wizmesh.WizmeshService;

@Service("WizmeshService")
public class WizmeshServiceImpl extends EgovAbstractServiceImpl implements WizmeshService {

    private static final Log LOG = LogFactory.getLog(WizmeshService.class.getName());

    @Cacheable(value="wizmeshMapperMap")
    public HashMap<String, String> getMapperMap() throws Exception {
        
        LOG.debug("setWizmeshMap - URL decorator - start");

        HashMap<String, String> returnMap = new HashMap<String, String>();
        
        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder documentBuilder = factory.newDocumentBuilder();
            
            DefaultResourceLoader defaultTest = new DefaultResourceLoader();
            Resource resource = defaultTest.getResource("classpath:/egovframework/wizmesh/decorators.xml");
            
            Document document = documentBuilder.parse(resource.getURI().toString());
        
            Element root = document.getDocumentElement();
        
            String defaultDir = getAttribute(root, "defaultdir");
            
            NodeList decoratorNodes = null;
            
            if(root != null) {
            	decoratorNodes = root.getElementsByTagName("decorator");	
            }
      
            if(decoratorNodes != null && decoratorNodes.getLength() > 0) {

                for (int i = 0; i < decoratorNodes.getLength(); ++i) {
                    
                    Element decoratorElement = (Element)decoratorNodes.item(i);
                    
                    if (decoratorElement == null) continue;
                    
                    if (getAttribute(decoratorElement, "name") != null) {
                        String page = getAttribute(decoratorElement, "page");
                        String pageSe = getAttribute(decoratorElement, "pageSe");
                        
                        if (pageSe != null && "custom".equals(pageSe)) {
//                        	page = page;
                        } else {
                            if ((defaultDir != null) && (page != null) && (page.length() > 0) && (!(page.startsWith("/")))) {
                                if (page.charAt(0) == '/') page = defaultDir + page;
                                else page = defaultDir + '/' + page;
                            }
                        }
                        
                        setWizmeshMap(decoratorElement.getElementsByTagName("pattern"), page, returnMap);
                    }
                }
            }
        } catch(NullPointerException e){
        	LOG.error("NullPointerException",e);
	   	}catch(NumberFormatException e){
	   		LOG.error("NumberFormatException",e);
	   	}catch(IllegalFormatException e){
	   		LOG.error("IllegalFormatException",e);
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		LOG.error("ArrayIndexOutOfBoundsException",e);
	   	}catch(IOException e){
	   		LOG.error("IOException",e);
	   	}
        
        LOG.debug("setWizmeshMap - URL exclude - end");
        
        return returnMap;
    }

    @Cacheable(value="wizmeshExcludeMap")
    public HashMap<String, String> getExcludeMap() throws Exception {

        LOG.debug("setWizmeshMap - URL exclude - start");
        
        HashMap<String, String> returnMap = new HashMap<String, String>();
        
        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder documentBuilder = factory.newDocumentBuilder();
            
            DefaultResourceLoader defaultTest = new DefaultResourceLoader();
            Resource resource = defaultTest.getResource("classpath:/egovframework/wizmesh/decorators.xml");
            Document document = documentBuilder.parse(resource.getURI().toString());
            
            Element root = document.getDocumentElement();
            
            NodeList excludeNodes = root.getElementsByTagName("excludes");
            
            for (int i = 0; i < excludeNodes.getLength(); ++i) {
                Element decoratorElement = (Element)excludeNodes.item(i);
                   
                setWizmeshMap(decoratorElement.getElementsByTagName("pattern"), "EXCLUDE", returnMap);
            }
        }catch(NullPointerException e){
        	LOG.error("NullPointerException",e);
	   	}catch(NumberFormatException e){
	   		LOG.error("NumberFormatException",e);
	   	}catch(IllegalFormatException e){
	   		LOG.error("IllegalFormatException",e);
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		LOG.error("ArrayIndexOutOfBoundsException",e);
	   	}catch(IOException e){
	   		LOG.error("IOException",e);
	   	}
        
        LOG.debug("setWizmeshMap - URL exclude - end");
           
        return returnMap;
    }
    
    private void setWizmeshMap(NodeList patternNodes, String page, HashMap<String, String> returnMap) {
        for (int j = 0; j < patternNodes.getLength(); ++j) {
            
            Element p = (Element)patternNodes.item(j);
            
            Text patternText = (Text)p.getFirstChild();
            
            if (patternText != null) {
                String pattern = patternText.getData().trim();
                if (pattern != null) {
                    LOG.debug("setWizmeshMap - put : "+pattern+", "+page);
                    returnMap.put(pattern, page);
                }
            }
        }
    }

    private String getAttribute(Element element, String name) {
        if ((element != null) && (element.getAttribute(name) != null) 
                && (element.getAttribute(name).trim() != "")) {
            return element.getAttribute(name).trim();
        }

        return null;
    }

}
