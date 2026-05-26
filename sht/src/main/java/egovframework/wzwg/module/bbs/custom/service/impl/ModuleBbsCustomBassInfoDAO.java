package egovframework.wzwg.module.bbs.custom.service.impl;

import java.util.IllegalFormatException;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsVO;
import egovframework.wzwg.module.bbs.custom.service.ModuleBbsCustomVO;


@Repository("ModuleBbsCustomBassInfoDAO")
public class ModuleBbsCustomBassInfoDAO extends EgovAbstractMapper {

	
	/**
	 * ㅁ 게시판 기본정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleBbsVO selectBbsBassInfoDetail(ModuleBbsVO moduleBbsVO) throws Exception {
		return (ModuleBbsVO) selectOne("ModuleBbsUnityBassInfoDAO_selectBbsBassInfoDetail_S", moduleBbsVO);
	}
	
	/**
     * ㅁ 게시판 기본정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyBbsBassInfo(ModuleBbsVO moduleBbsVO) throws Exception {
		
		// 기본정보 등록
		update("ModuleBbsUnityBassInfoDAO_modifyBbsBassInfo_U", moduleBbsVO);
		
		// 양식정보 등록
		return update("ModuleBbsUnityBassInfoDAO_modifyBbsFormInfo_U", moduleBbsVO);
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
            insert("ModuleBbsUnityBassInfoDAO_registBbsBassInfo_I", moduleBbsVO);
            
            if (!"".equals(StringUtils.defaultString(moduleBbsVO.getBbsSeq()))) {
                update("ModuleBbsUnityBassInfoDAO_modifyBbsFormInfo_U", moduleBbsVO);
            }   
        }  catch (NullPointerException e) {			
			resultInt = 0;
		}catch (NumberFormatException e) {			
			resultInt = 0;
		}catch (IllegalFormatException e) {			
			resultInt = 0;
		}
        
        return resultInt;
    }
    
    /**
     * ㅁ 게시판 필드 시퀀스 조회
     * @param paramVO
     * @return String
     * @throws Exception
     */
    public String selectBbsBassInfoCustomFieldSeq() throws Exception {
    	return (String) selectOne("ModuleBbsCustomBassInfoDAO_selectModuleBbsCustomSeq");
    }
    
    /**
	 * ㅁ 게시판 필드 리스트
     * @param paramVO
     * @return
     * @throws Exception
     */
	
	public List<ModuleBbsCustomVO> selectBbsBassInfoCustomFieldList(Map<String, String> fieldVO) throws Exception {
		return selectList("ModuleBbsCustomBassInfoDAO_selectBbsBassInfoCustomFieldList", fieldVO);
	}
	
	/**
	 * ㅁ 게시판 필드 등록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	
	public int registBbsBassInfoCustomField(Map<String, String> fieldVO) throws Exception {
		
		int resultInt = 1;
		
		String fieldSeq = fieldVO.get("fieldSeq");
		
		if(fieldSeq == null || fieldSeq.equals("")){
			fieldVO.put("fieldSeq", selectBbsBassInfoCustomFieldSeq());
		}
		
		try {
			insert("ModuleBbsCustomBassInfoDAO_registBbsBassInfoCustomField", fieldVO);
		}  catch (NullPointerException e) {
			resultInt = 0;
		}catch (NumberFormatException e) {
			resultInt = 0;
		}catch (IllegalFormatException e) {
			resultInt = 0;
		}
		return resultInt;
		
	}
	
	/**
	 * ㅁ 게시판 필드 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	
	public int deleteBbsBassInfoCustomField(Map<String, String> fieldVO) throws Exception {
		
		int resultInt = 1;
		
		try {
			delete("ModuleBbsCustomBassInfoDAO_deleteBbsBassInfoCustomField", fieldVO);
		}  catch (NullPointerException e) {
			resultInt = 0;
		}catch (NumberFormatException e) {
			resultInt = 0;
		}catch (IllegalFormatException e) {
			resultInt = 0;
		}
		return resultInt;
	}
	
	/**
	 * ㅁ 게시판 비밀번호 필드 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	
	public int deleteBbsBassInfoCustomPasswordField(Map<String, String> fieldVO) throws Exception {
		
		int resultInt = 1;
		
		try {
			delete("ModuleBbsCustomBassInfoDAO_deleteBbsBassInfoCustomPasswordField", fieldVO);
		} catch (NullPointerException e) {
			resultInt = 0;
		}catch (NumberFormatException e) {
			resultInt = 0;
		}catch (IllegalFormatException e) {
			resultInt = 0;
		}
		return resultInt;
	}
	
	/**
   	 * ㅁ 게시판 기본정보 추가기능 조회
        * @param paramVO
        * @return
        * @throws Exception
        */
   	public ModuleBbsVO selectBbsCustomFunctionDetail(ModuleBbsVO moduleBbsVO) throws Exception{
   	
   		return (ModuleBbsVO)selectOne("ModuleBbsCustomBassInfoDAO_selectBbsCustomFunctionDetail", moduleBbsVO);
   	}
   	
   	/**
        * ㅁ 게시판 기본정보 추가기능 수정
        * @param paramVO
        * @return
        * @throws Exception
        */
   	public int modifyBbsCustomFunctionInfo(ModuleBbsVO moduleBbsVO) throws Exception{
   	
   		return update("ModuleBbsCustomBassInfoDAO_modifyBbsCustomFunctionInfo", moduleBbsVO);
   	}
       
   /**
	    * ㅁ 게시판 기본정보 추가기능 등록
	    * @param paramVO
	    * @return
	    * @throws Exception
    */
   	public int registBbsCustomFunctionInfo(ModuleBbsVO moduleBbsVO) throws Exception{
   		Integer result = (Integer) insert("ModuleBbsCustomBassInfoDAO_registBbsCustomFunctionInfo", moduleBbsVO);
   		
   		return result == null ? -1 : 1;
   	}
   	
    /**
     * ㅁ 게시판 기본정보 추가기능 등록 - 메뉴자동등록을 위한..
     * @param paramVO
     * @return
     * @throws Exception
     */
   	public void registBbsCustomFunctionInfoCopy(ModuleBbsVO moduleBbsVO) {
   	    insert("ModuleBbsCustomBassInfoDAO_registBbsCustomFunctionInfoCopy", moduleBbsVO);
   	}
    
    /**
     * ㅁ 게시판 필드 등록 - 메뉴자동등록을 위한..
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void registBbsBassInfoCustomFieldCopy(ModuleBbsVO moduleBbsVO) throws Exception {
        insert("ModuleBbsCustomBassInfoDAO_registBbsBassInfoCustomFieldCopy", moduleBbsVO);
    }        
   	
   	
}
