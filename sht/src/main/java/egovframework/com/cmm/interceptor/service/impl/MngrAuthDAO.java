package egovframework.com.cmm.interceptor.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.interceptor.service.MngrAuthVO;

@Repository("MngrAuthDAO")
public class MngrAuthDAO extends EgovAbstractMapper {

    
    @Cacheable(value="selectMngrConCodeList")
    public List<EgovMap> selectMngrConCodeList(EgovMap paramMap) throws Exception {
        return selectList("MngrAuthDAO_selectMngrConCodeList", paramMap);
    }

    
    @Cacheable(value="selectMngrConCodeGrpList")
    public List<EgovMap> selectMngrConCodeGrpList(EgovMap paramMap) throws Exception {
        return selectList("MngrAuthDAO_selectMngrConCodeGrpList", paramMap);
    }
    
    
    public List<EgovMap> selectMngrConAuthList(MngrAuthVO paramVO) throws Exception {
        return selectList("MngrAuthDAO_selectMngrConAuthList", paramVO);
    }
    
    public void deleteMngrConAuth(MngrAuthVO paramVO) throws Exception {
        delete("MngrAuthDAO_deleteMngrConAuth", paramVO);
    }
    
    public void registMngrConAuth(MngrAuthVO paramVO) throws Exception {
        insert("MngrAuthDAO_registMngrConAuth", paramVO);
    }

    
    public List<MngrAuthVO> selectMngrConAuthUsr(MngrAuthVO paramVO) throws Exception {
        return selectList("MngrAuthDAO_selectMngrConAuthUsr", paramVO);
    }
}
