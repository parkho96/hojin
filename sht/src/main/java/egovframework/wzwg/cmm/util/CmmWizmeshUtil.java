package egovframework.wzwg.cmm.util;

import java.util.HashMap;
import java.util.Iterator;

import jakarta.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.AntPathMatcher;

import egovframework.wzwg.cmm.wizmesh.WizmeshService;

@Component("CmmWizmeshUtil")
public class CmmWizmeshUtil {

    private static final Log LOG = LogFactory.getLog(CmmWizmeshUtil.class.getName());
    
    @Resource(name="WizmeshService")
    private WizmeshService wizmeshService;
    
    public String getPagePath(String callSe, String url) throws Exception {
        HashMap<String, String> getMap = ("E".equals(callSe))? wizmeshService.getExcludeMap():wizmeshService.getMapperMap();
        
      Iterator<String> mapIter = getMap.keySet().iterator();
    
      AntPathMatcher m = new AntPathMatcher();
      String pagePath = "";
      while(mapIter.hasNext()){
          String key = mapIter.next();
          String value = (String)getMap.get( key );
          
          if (m.match(key, url)) {
              pagePath = value;
              LOG.debug("* ["+callSe+"] 타겟 데코 파일 : " + pagePath);
              break;
          }
      }
      
      return pagePath;
    }

}
