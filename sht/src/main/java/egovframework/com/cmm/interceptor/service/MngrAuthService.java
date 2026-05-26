package egovframework.com.cmm.interceptor.service;

import java.util.HashMap;
import java.util.List;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

public interface MngrAuthService {

    public HashMap<String,List<String[]>> selectMngrConCodeList(EgovMap paramMap) throws Exception;

    public List<EgovMap> selectMngrConAuthList(MngrAuthVO paramVO) throws Exception;
        
    public void registMngrConAuth(MngrAuthVO paramVO) throws Exception;
    
    public List<MngrAuthVO> selectMngrConAuthUsr(MngrAuthVO paramVO) throws Exception;
}
