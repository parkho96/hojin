package egovframework.wzwg.module.schdul.service;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;


public interface ModuleSchdulBassInfoService {
	
	/**
	 * ㅁ 일정  목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<CntntsInfoVO> selectSchdulBassInfoList(ModuleSchdulBassInfoVO paramVO) throws Exception;
	
	/**
	 * ㅁ 일정 기본정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleSchdulBassInfoVO selectSchdulBassInfoDetail(ModuleSchdulBassInfoVO paramVO) throws Exception;
	
	/**
     * ㅁ 일정 기본정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifySchdulBassInfo(ModuleSchdulBassInfoVO paramVO) throws Exception;
    
    /**
     * ㅁ 일정 기본정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registSchdulBassInfo(ModuleSchdulBassInfoVO paramVO) throws Exception;
    
    /**
     * ㅁ 일정 기본정보 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int deleteSchdulBassInfo(ModuleSchdulBassInfoVO paramVO) throws Exception;
    
    /**
     * ㅁ 일정 아이디 생성
     * @return
     * @throws Exception
     */
    public String selectSchdulNextSeq() throws Exception;
    
    public List<ModuleSchdulBassInfoVO> selectSchdulMainScrinCntnts(ModuleSchdulBassInfoVO paramVO) throws Exception;
    
    public List<ModuleSchdulBassInfoVO> selectSchdulMainScrinCntntsToMonth(ModuleSchdulBassInfoVO paramVO) throws Exception;
    
    
    public   ModuleSchdulBassInfoVO  selectSchdulScrinCntnts(ModuleSchdulBassInfoVO paramVO) throws Exception;
	 
    
    /**
     * ㅁ 일정 초기 기본정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public String registSchdulBassInfoInit(ModuleSchdulBassInfoVO paramVO) throws Exception;

    /**
     * ㅁ 일정 CSS 리스트 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<ModuleSchdulCssVO> selectSchdulCssList(ModuleSchdulBassInfoVO paramVO) throws Exception;
    
    /**
     * ㅁ 일정 CSS 상세 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
    public ModuleSchdulCssVO selectSchdulCssDetail(ModuleSchdulCssVO paramVO) throws Exception;
    
    /**
     * ㅁ 일정 CSS 등록/수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifySchdulCss(ModuleSchdulBassInfoVO paramVO) throws Exception;
    
    /**
     * ㅁ 일정 CSS 시퀀스 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
    public String selectSchdulCssSeq(ModuleSchdulBassInfoVO paramVO) throws Exception;
    
    /**
     * ㅁ 일정 모듈연결 - 생성된 모듈 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleSchdulBassInfoVO> selectModuleList(ModuleSchdulBassInfoVO paramVO) throws Exception;
	
	/**
     * ㅁ 일정 모듈연결 - 모듈 연결
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registConnModuleList(ModuleSchdulBassInfoVO paramVO) throws Exception;
	
	/**
     * ㅁ 일정 모듈연결 - 연결된 모듈 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleSchdulBassInfoVO> selectConnModuleList(ModuleSchdulBassInfoVO paramVO) throws Exception;
	
	/**
     * ㅁ 일정 모듈연결 - 연결 모듈 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteConnModule(ModuleSchdulBassInfoVO paramVO) throws Exception;
	
	public List<EgovMap> selectCalMonList(ModuleSchdulBassInfoVO paramVO);
	
	public List<EgovMap> selectCalList(ModuleSchdulBassInfoVO paramVO);
	
}
