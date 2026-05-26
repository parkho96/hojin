package egovframework.wzwg.module.ntt.mvp.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.ntt.mvp.service.ModuleNttMvpDataManageService;
import egovframework.wzwg.module.ntt.mvp.service.ModuleNttMvpVO;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileService;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;



@Service("ModuleNttMvpDataManageService")
public class ModuleNttMvpDataManageServiceImpl extends EgovAbstractServiceImpl implements ModuleNttMvpDataManageService {

	
	@Resource(name="ModuleNttMvpDataManageDAO")
    protected ModuleNttMvpDataManageDAO nttMvpDataManageDAO;
	
    @Resource(name="ModuleUploadFileService")
	public ModuleUploadFileService fileService;
    
    
	/**
	 * ㅁ 동영상게시물SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextMvpnttSeq(ModuleNttMvpVO vo) throws Exception {
		return nttMvpDataManageDAO.selectNextMvpnttSeq(vo);
	}
	
	/**
	 * ㅁ 게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttMvpVO> selectNttMvpList(ModuleNttMvpVO vo) throws Exception {
		return nttMvpDataManageDAO.selectNttMvpList(vo);
	}
	
	/**
	 * ㅁ 게시물 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttMvpListTotCnt(ModuleNttMvpVO vo) throws Exception {
		return nttMvpDataManageDAO.selectNttMvpListTotCnt(vo);
	}
	
	/**
	 * ㅁ 조회수 증가
     * @param paramVO
     * @return
     * @throws Exception
     */
	public void modifyNttMvpInqireCnt(ModuleNttMvpVO vo) throws Exception {
		nttMvpDataManageDAO.modifyNttMvpInqireCnt(vo);
	}
	
	/**
	 * ㅁ 게시물 상세정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleNttMvpVO selectNttMvpDetail(ModuleNttMvpVO vo) throws Exception {
		return nttMvpDataManageDAO.selectNttMvpDetail(vo);
	}
	
	/**
	 * ㅁ 게시물 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttMvpInfo(ModuleNttMvpVO vo) throws Exception {
		return nttMvpDataManageDAO.registNttMvpInfo(vo);
	}
	
	/**
	 * ㅁ 게시물 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttMvpInfo(ModuleNttMvpVO vo) throws Exception {
		return nttMvpDataManageDAO.modifyNttMvpInfo(vo);
	}
	
	/**
	 * ㅁ 게시물 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer deleteNttMvpInfo(ModuleNttMvpVO vo) throws Exception {
		
		if(vo.getAtchFileId() != null){
			
			ModuleUploadFileVO fvo = new ModuleUploadFileVO();
			
			fvo.setAtchFileId(vo.getAtchFileId());
			fileService.deleteFileInf(fvo);
		}
		
		return nttMvpDataManageDAO.deleteNttMvpInfo(vo);
	}
	
	/**
	 * ㅁ 게시물 삭제 (체크박스 선택 목록 삭제)
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer deleteCheckNttMvpInfo(ModuleNttMvpVO vo) throws Exception {
		
		String checkNttSeq = StringUtils.defaultString(vo.getCheckNttSeq());
		
		if(!"".equals(checkNttSeq)){
			checkNttSeq = vo.getCheckNttSeq().substring(0, vo.getCheckNttSeq().length()-1);
			vo.setDynamicArr(checkNttSeq.split(","));
		}
		
		return nttMvpDataManageDAO.deleteNttMvpInfo(vo);
	}
	
    /**
     * ㅁ 게시물 목록 - 화면
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<ModuleNttMvpVO> selectNttMvpScrinCntnts(ModuleNttMvpVO vo) throws Exception {
    	return nttMvpDataManageDAO.selectNttMvpScrinCntnts(vo);
    }
	
	/**
	 * ㅁ 휴지통 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttMvpVO> selectNttMvpRecycleList(ModuleNttMvpVO vo) throws Exception {
		return nttMvpDataManageDAO.selectNttMvpRecycleList(vo);
	}
	
	/**
	 * ㅁ 휴지통 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttMvpRecycleListTotCnt(ModuleNttMvpVO vo) throws Exception {
		return nttMvpDataManageDAO.selectNttMvpRecycleListTotCnt(vo);
	}
	
	/**
	 * ㅁ 휴지통 복원
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttMvpRecycle(ModuleNttMvpVO vo) throws Exception {
		return nttMvpDataManageDAO.modifyNttMvpRecycle(vo);
	}
	
	/**
	 * ㅁ  휴지통 복원 (체크박스 선택 목록 복원)
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyCheckNttMvpRecycle(ModuleNttMvpVO vo) throws Exception {
		
		String checkNttSeq = StringUtils.defaultString(vo.getCheckNttSeq());
		
		if(!"".equals(checkNttSeq)){
			checkNttSeq = vo.getCheckNttSeq().substring(0, vo.getCheckNttSeq().length()-1);
			vo.setDynamicArr(checkNttSeq.split(","));
		}
		
		return nttMvpDataManageDAO.modifyNttMvpRecycle(vo);
	}
	
	/**
	 * 휴지통 - 게시물 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public Integer deleteSiteNttMvp(ModuleNttMvpVO vo) throws Exception {
		
		int resultValue = 0;
		
		if(!vo.getDelSe().equals("ALL")) {
			
			String checkNttSeq = StringUtils.defaultString(vo.getCheckNttSeq());
			
			if(!"".equals(checkNttSeq)){
				checkNttSeq = vo.getCheckNttSeq().substring(0, vo.getCheckNttSeq().length()-1);
				vo.setDynamicArr(checkNttSeq.split(","));
			}
			
		}		

		resultValue = nttMvpDataManageDAO.deleteSiteFileDetail(vo);

		resultValue = nttMvpDataManageDAO.deleteSiteFile(vo);
		
		resultValue = nttMvpDataManageDAO.deleteSiteNttMvp(vo);

		resultValue = 1;
			
		return resultValue;
	}

	
}
