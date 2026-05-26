package egovframework.wzwg.site.mngr.bbsDataBckpRcvr.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
import egovframework.wzwg.site.mngr.bbsDataBckpRcvr.service.BbsDataBckpRcvrService;
import egovframework.wzwg.site.mngr.bbsDataBckpRcvr.service.BbsDataBckpRcvrVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;



@Service("BbsDataBckpRcvrService")
public class BbsDataBckpRcvrServiceImpl extends EgovAbstractServiceImpl implements BbsDataBckpRcvrService {

	@Resource(name="BbsDataBckpRcvrDAO")
    protected BbsDataBckpRcvrDAO bbsDataBckpRcvrDAO;
	
	/**
	 * 게시판 모듈 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<CntntsInfoVO> selectBbsModuleList() throws Exception {
		return bbsDataBckpRcvrDAO.selectBbsModuleList();
	}
	
	/**
	 * 게시판  목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<CntntsInfoVO> selectBbsList(CntntsInfoVO cntntsInfoVO) throws Exception {
		return bbsDataBckpRcvrDAO.selectBbsList(cntntsInfoVO);
	}	
	
	/**
	 * 게시판 모듈 구분 확인
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectModuleBbsSe(BbsDataBckpRcvrVO bbsDataBckpRcvrVO) throws Exception {
		return bbsDataBckpRcvrDAO.selectModuleBbsSe(bbsDataBckpRcvrVO);
	}			

	/**
	 * 게시물  목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<BbsDataBckpRcvrVO> selectNttList(BbsDataBckpRcvrVO bbsDataBckpRcvrVO) throws Exception {
		return bbsDataBckpRcvrDAO.selectNttList(bbsDataBckpRcvrVO);
	}	
	
	/**
	 * 게시물 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int selectNttListTotCnt(BbsDataBckpRcvrVO bbsDataBckpRcvrVO) throws Exception {
		return bbsDataBckpRcvrDAO.selectNttListTotCnt(bbsDataBckpRcvrVO);
	}	
	
	/**
	 * 커스텀게시판 FUNC
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<BbsDataBckpRcvrVO> selectCustomFuncList(BbsDataBckpRcvrVO bbsDataBckpRcvrVO) throws Exception {
		return bbsDataBckpRcvrDAO.selectCustomFuncList(bbsDataBckpRcvrVO);
	}
	
	/**
	 * 커스텀게시판 FIELD
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<BbsDataBckpRcvrVO> selectCustomFieldList(BbsDataBckpRcvrVO bbsDataBckpRcvrVO) throws Exception {
		return bbsDataBckpRcvrDAO.selectCustomFieldList(bbsDataBckpRcvrVO);
	}
	
    /**
     * 게시물 복구
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int insertNttRcvrData(BbsDataBckpRcvrVO bbsDataBckpRcvrVO) throws Exception {
        int result = 0;
        result = bbsDataBckpRcvrDAO.insertNttRcvrData(bbsDataBckpRcvrVO);
        return result;
    }	
    
	/**
	 * 첨부파일 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<BbsDataBckpRcvrVO> selectNttFileList(BbsDataBckpRcvrVO bbsDataBckpRcvrVO) throws Exception {
		return bbsDataBckpRcvrDAO.selectNttFileList(bbsDataBckpRcvrVO);
	}	
	
    /**
     * 첨부파일 복구
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int insertNttFileRcvrData(ModuleUploadFileVO ModuleUploadFileVO) throws Exception {
		int result = 0;		
		result = bbsDataBckpRcvrDAO.insertNttFileRcvrData(ModuleUploadFileVO);   	 
        return result;
    }	
}
