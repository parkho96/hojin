package egovframework.wzwg.cmm.wizmesh;

import java.util.HashMap;

public interface WizmeshService {
    
    public HashMap<String, String> getMapperMap() throws Exception;
    
    public HashMap<String, String> getExcludeMap() throws Exception;
	
}
