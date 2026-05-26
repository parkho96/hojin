package egovframework.wzwg.module.bbs.link.service.impl;

import java.util.IllegalFormatException;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsVO;


@Repository("ModuleBbsLinkBassInfoDAO")
public class ModuleBbsLinkBassInfoDAO extends EgovAbstractMapper {

	
	/**
	 * ㅁ 게시판 기본정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleBbsVO selectBbsBassInfoDetail(ModuleBbsVO moduleBbsVO) throws Exception {
		return (ModuleBbsVO) selectOne("ModuleBbsLinkBassInfoDAO_selectBbsBassInfoDetail_S", moduleBbsVO);
	}
	
	/**
     * ㅁ 게시판 기본정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyBbsBassInfo(ModuleBbsVO moduleBbsVO) throws Exception {
		
		// 기본정보 등록
		update("ModuleBbsLinkBassInfoDAO_modifyBbsBassInfo_U", moduleBbsVO);
		
		// 양식정보 등록
		return update("ModuleBbsLinkBassInfoDAO_modifyBbsFormInfo_U", moduleBbsVO);
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
            insert("ModuleBbsLinkBassInfoDAO_registBbsBassInfo_I", moduleBbsVO);
            
            if (!"".equals(StringUtils.defaultString(moduleBbsVO.getBbsSeq()))) {
                update("ModuleBbsLinkBassInfoDAO_modifyBbsFormInfo_U", moduleBbsVO);
            }   
        }catch(NullPointerException e){
        	resultInt = 0;
    	}catch(NumberFormatException e){
    		resultInt = 0;
    	}catch(IllegalFormatException e){
    		resultInt = 0;
    	} 
        
        return resultInt;
    }
   	
}
