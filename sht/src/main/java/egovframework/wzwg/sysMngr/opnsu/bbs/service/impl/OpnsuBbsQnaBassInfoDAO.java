package egovframework.wzwg.sysMngr.opnsu.bbs.service.impl;

import java.util.IllegalFormatException;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.opnsu.bbs.service.OpnsuBbsVO;


@Repository("OpnsuBbsQnaBassInfoDAO")
public class OpnsuBbsQnaBassInfoDAO extends EgovAbstractMapper {

	
	/**
	 * ㅁ 게시판 기본정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public OpnsuBbsVO selectBbsBassInfoDetail(OpnsuBbsVO bbsVO) throws Exception {
		return (OpnsuBbsVO) selectOne("OpnsuBbsQnaBassInfoDAO_selectBbsBassInfoDetail_S", bbsVO);
	}
	
	/**
	 * ㅁ 글양식 저장
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyBbsBassInfo(OpnsuBbsVO bbsVO) throws Exception {
		
		// 기본정보 등록
		return update("OpnsuBbsQnaBassInfoDAO_modifyBbsBassInfo_U", bbsVO);
	}
    
    /**
     * ㅁ 게시판 기본정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registBbsBassInfo(OpnsuBbsVO bbsVO) throws Exception {
    	
    	int resultInt = 1;
        
        try {
            // 기본정보 등록
            insert("OpnsuBbsQnaBassInfoDAO_registBbsBassInfo_I", bbsVO);

        } catch(NullPointerException e){        	
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
