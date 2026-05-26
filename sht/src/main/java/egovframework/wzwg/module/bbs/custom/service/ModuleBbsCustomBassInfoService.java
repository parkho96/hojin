package egovframework.wzwg.module.bbs.custom.service;

import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;

import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsVO;

public interface ModuleBbsCustomBassInfoService {


	/**
	 * ㅁ 게시판 기본정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleBbsVO selectBbsBassInfoDetail(ModuleBbsVO moduleBbsVO) throws Exception;
	
	/**
     * ㅁ 게시판 기본정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyBbsBassInfo(ModuleBbsVO moduleBbsVO) throws Exception;
    
    /**
     * ㅁ 게시판 기본정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registBbsBassInfo(ModuleBbsVO moduleBbsVO) throws Exception;
    
    /**
     * ㅁ 게시판 초기 기본정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public String registBbsBassInfoInit(ModuleBbsVO moduleBbsVO) throws Exception;
	
    /**
   	 * ㅁ 게시판 커스텀 필드정보 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<ModuleBbsCustomVO> selectBbsBassInfoCustomFieldList(Map<String, String> fieldVO) throws Exception;
    
    /**
     * ㅁ 게시판 커스텀 필드정보 입력
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registBbsBassInfoCustomField(Map<String, String> fieldVO) throws Exception;

    /**
     * ㅁ 게시판 커스텀 필드정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
//    public int updateBbsBassInfoCustomField(Map<String, String> moduleBbsVO) throws Exception;
    
    /**
     * ㅁ 게시판 커스텀 필드정보 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int deleteBbsBassInfoCustomField(Map<String, String> fieldVO) throws Exception;
    
    /**
     * ㅁ 게시판 커스텀 비밀번호 필드정보 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int deleteBbsBassInfoCustomPasswordField(Map<String, String> fieldVO) throws Exception;
    
    /**
     * ㅁ 게시판 커스텀 입력데이터 JSON 변환
     * @param paramVO
     * @return
     * @throws Exception
     */
    public String getCustomJsonContents(String siteSeq, String bbsSeq, String nttSeq, Map<String, String> files, HttpServletRequest request) throws Exception;
    
    /**
     * ㅁ 게시판 커스텀 입력데이터 JSON 변환
     * @param paramVO
     * @return
     * @throws Exception
     */
    public Map<String, String> getCustomContentsToMap(String nttCn) throws Exception;

    /**
	 * ㅁ 게시판 기본정보 추가기능
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleBbsVO selectBbsCustomFunctionDetail(ModuleBbsVO moduleBbsVO) throws Exception;
	
	/**
     * ㅁ 게시판 기본정보 추가기능 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyBbsCustomFunctionInfo(ModuleBbsVO moduleBbsVO) throws Exception;
    
    /**
     * ㅁ 게시판 기본정보 추가기능 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registBbsCustomFunctionInfo(ModuleBbsVO moduleBbsVO) throws Exception;
}
