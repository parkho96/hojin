package egovframework.wzwg.site.mngr.bbsDataBckpRcvr.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
import egovframework.wzwg.site.mngr.bbsDataBckpRcvr.service.BbsDataBckpRcvrVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;


@Repository("BbsDataBckpRcvrDAO")

public class BbsDataBckpRcvrDAO extends EgovAbstractMapper {
	
	/**
	 * 게시판 모듈 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<CntntsInfoVO> selectBbsModuleList() throws Exception {
		return selectList("BbsDataBckpRcvrDAO_selectBbsModuleList_S");
	}
	
	/**
	 * 게시판  목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<CntntsInfoVO> selectBbsList(CntntsInfoVO cntntsInfoVO) throws Exception {
		return selectList("BbsDataBckpRcvrDAO_selectBbsList_S", cntntsInfoVO);
	}	
	
	/**
	 * 게시판 모듈 구분 확인
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectModuleBbsSe(BbsDataBckpRcvrVO bbsDataBckpRcvrVO) throws Exception {
		return (String) selectOne("BbsDataBckpRcvrDAO_selectModuleBbsSe_S", bbsDataBckpRcvrVO);
	}		
   	
	/**
	 * 게시물  목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<BbsDataBckpRcvrVO> selectNttList(BbsDataBckpRcvrVO bbsDataBckpRcvrVO) throws Exception {
		
		if(bbsDataBckpRcvrVO.getModuleSe().equals("simp")) {
			return selectList("BbsDataBckpRcvrDAO_selectSimpNttList_S", bbsDataBckpRcvrVO);
		}else if(bbsDataBckpRcvrVO.getModuleSe().equals("mvp")){
			return selectList("BbsDataBckpRcvrDAO_selectMvpNttList_S", bbsDataBckpRcvrVO);
		}else if(bbsDataBckpRcvrVO.getModuleSe().equals("link")){
			return selectList("BbsDataBckpRcvrDAO_selectLinkNttList_S", bbsDataBckpRcvrVO);
		}else{
			return selectList("BbsDataBckpRcvrDAO_selectNttList_S", bbsDataBckpRcvrVO);
		}
		
	}	
	
	/**
	 * 게시물 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int selectNttListTotCnt(BbsDataBckpRcvrVO bbsDataBckpRcvrVO) throws Exception {
		
		if(bbsDataBckpRcvrVO.getModuleSe().equals("simp")) {
			return (Integer) selectOne("BbsDataBckpRcvrDAO_selectSimpNttListTotCnt_S", bbsDataBckpRcvrVO);
		}else if(bbsDataBckpRcvrVO.getModuleSe().equals("mvp")){
			return (Integer) selectOne("BbsDataBckpRcvrDAO_selectMvpNttListTotCnt_S", bbsDataBckpRcvrVO);
		}else if(bbsDataBckpRcvrVO.getModuleSe().equals("link")){
			return (Integer) selectOne("BbsDataBckpRcvrDAO_selectLinkNttListTotCnt_S", bbsDataBckpRcvrVO);
		}else{
			return (Integer) selectOne("BbsDataBckpRcvrDAO_selectNttListTotCnt_S", bbsDataBckpRcvrVO);		
		}

	}	
	
	/**
	 * 커스텀게시판 FUNC
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<BbsDataBckpRcvrVO> selectCustomFuncList(BbsDataBckpRcvrVO bbsDataBckpRcvrVO) throws Exception {
		return selectList("BbsDataBckpRcvrDAO_selectCustomNttFuncList_S", bbsDataBckpRcvrVO);
	}
	
	/**
	 * 커스텀게시판 FIELD
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<BbsDataBckpRcvrVO> selectCustomFieldList(BbsDataBckpRcvrVO bbsDataBckpRcvrVO) throws Exception {
		return selectList("BbsDataBckpRcvrDAO_selectCustomNttFieldList_S", bbsDataBckpRcvrVO);
	}
	
    /**
     * 게시물 복구
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int insertNttRcvrData(BbsDataBckpRcvrVO bbsDataBckpRcvrVO) throws Exception {
    	
		int result = 0;		
		
		if(bbsDataBckpRcvrVO.getModuleSe().equals("simp")) {
			result = update("BbsDataBckpRcvrDAO_insertSimpNttRcvrData_I", bbsDataBckpRcvrVO);
		}else if(bbsDataBckpRcvrVO.getModuleSe().equals("mvp")){
			result = update("BbsDataBckpRcvrDAO_insertMvpNttRcvrData_I", bbsDataBckpRcvrVO);
		}else if(bbsDataBckpRcvrVO.getModuleSe().equals("link")){
			result = update("BbsDataBckpRcvrDAO_insertLinkNttRcvrData_I", bbsDataBckpRcvrVO);
		}else{
			result = update("BbsDataBckpRcvrDAO_insertNttRcvrData_I", bbsDataBckpRcvrVO);
			
			if(result > 0){
				// 게시물 부가정보 등록
				result = update("BbsDataBckpRcvrDAO_insertNttAdiRcvrData_I", bbsDataBckpRcvrVO);
			}
		}
		
        return result;
    }	
    
	/**
	 * 첨부파일 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<BbsDataBckpRcvrVO> selectNttFileList(BbsDataBckpRcvrVO bbsDataBckpRcvrVO) throws Exception {
		if(bbsDataBckpRcvrVO.getModuleSe().equals("mvp")){
			return selectList("BbsDataBckpRcvrDAO_selectMvpNttFileList_S", bbsDataBckpRcvrVO);
		}else if(bbsDataBckpRcvrVO.getModuleSe().equals("link")){
			return selectList("BbsDataBckpRcvrDAO_selectLinkNttFileList_S", bbsDataBckpRcvrVO);
		}else if(bbsDataBckpRcvrVO.getModuleSe().equals("image")){
			return selectList("BbsDataBckpRcvrDAO_selectImageNttFileList_S", bbsDataBckpRcvrVO);
		}else{
			return selectList("BbsDataBckpRcvrDAO_selectNttFileList_S", bbsDataBckpRcvrVO);
		}
	}	    

    /**
     * 첨부파일 복구
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int insertNttFileRcvrData(ModuleUploadFileVO ModuleUploadFileVO) throws Exception {
		int result = 0;		
		// 첨부파일  등록
		result = update("BbsDataBckpRcvrDAO_insertNttFileRcvrData_I", ModuleUploadFileVO);
		if(result > 0){
			// 첨부파일 상세정보 등록
			result = update("BbsDataBckpRcvrDAO_insertNttFileDetailRcvrData_I", ModuleUploadFileVO);
		}    	 
        return result;
    }	
}
