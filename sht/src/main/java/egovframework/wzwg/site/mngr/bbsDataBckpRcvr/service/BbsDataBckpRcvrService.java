package egovframework.wzwg.site.mngr.bbsDataBckpRcvr.service;

import java.util.List;

import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;

public interface BbsDataBckpRcvrService {

	/**
	 * 게시판 모듈 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<CntntsInfoVO> selectBbsModuleList() throws Exception;
	
	/**
	 * 게시판  목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<CntntsInfoVO> selectBbsList(CntntsInfoVO cntntsInfoVO) throws Exception;
	
	/**
	 * 게시판 모듈 구분 확인
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectModuleBbsSe(BbsDataBckpRcvrVO bbsDataBckpRcvrVO) throws Exception;
	
	/**
	 * 게시물  목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<BbsDataBckpRcvrVO> selectNttList(BbsDataBckpRcvrVO bbsDataBckpRcvrVO) throws Exception;
	
	/**
	 * 게시물 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int selectNttListTotCnt(BbsDataBckpRcvrVO bbsDataBckpRcvrVO) throws Exception;	
	
	/**
	 * 커스텀게시판 FUNC
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<BbsDataBckpRcvrVO> selectCustomFuncList(BbsDataBckpRcvrVO bbsDataBckpRcvrVO) throws Exception;
	
	/**
	 * 커스텀게시판 FIELD
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<BbsDataBckpRcvrVO> selectCustomFieldList(BbsDataBckpRcvrVO bbsDataBckpRcvrVO) throws Exception;
	
    /**
     * 게시물 복구
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int insertNttRcvrData(BbsDataBckpRcvrVO bbsDataBckpRcvrVO) throws Exception;	
    
	/**
	 * 첨부파일 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<BbsDataBckpRcvrVO> selectNttFileList(BbsDataBckpRcvrVO bbsDataBckpRcvrVO) throws Exception; 
	
    /**
     * 첨부파일 복구
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int insertNttFileRcvrData(ModuleUploadFileVO ModuleUploadFileVO) throws Exception;	
}
