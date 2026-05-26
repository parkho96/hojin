package egovframework.wzwg.module.bbs.simp.service.impl;

import java.util.IllegalFormatException;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsVO;


@Repository("ModuleBbsSimpBassInfoDAO")
public class ModuleBbsSimpBassInfoDAO extends EgovAbstractMapper {

	
	/**
	 * ㅁ 게시판 기본정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleBbsVO selectBbsBassInfoDetail(ModuleBbsVO moduleBbsVO) throws Exception {
		return (ModuleBbsVO) selectOne("ModuleBbsSimpBassInfoDAO_selectBbsBassInfoDetail_S", moduleBbsVO);
	}
	
	/**
	 * ㅁ 글양식 저장
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyBbsBassInfo(ModuleBbsVO moduleBbsVO) throws Exception {
		return update("ModuleBbsSimpBassInfoDAO_modifyBbsBassInfo_U", moduleBbsVO);
	}
    
    /**
     * ㅁ 게시판 기본정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registBbsBassInfo(ModuleBbsVO moduleBbsVO) throws Exception {
    	
    	int resultInt = 1;
        
        try {
            // 기본정보 등록
            insert("ModuleBbsSimpBassInfoDAO_registBbsBassInfo_I", moduleBbsVO);
        }  catch(NullPointerException e){
        	resultInt = 0;
    	}catch(NumberFormatException e){
    		resultInt = 0;
    	}catch(IllegalFormatException e){
    		resultInt = 0;
    	}catch(ArrayIndexOutOfBoundsException e){
    		resultInt = 0;
    	}  
        
        return resultInt;
    }
   	
}
