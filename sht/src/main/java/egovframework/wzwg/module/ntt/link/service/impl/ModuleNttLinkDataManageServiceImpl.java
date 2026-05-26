package egovframework.wzwg.module.ntt.link.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.ntt.link.service.ModuleNttLinkDataManageService;
import egovframework.wzwg.module.ntt.link.service.ModuleNttLinkVO;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileService;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;



@Service("ModuleNttLinkDataManageService")
public class ModuleNttLinkDataManageServiceImpl extends EgovAbstractServiceImpl implements ModuleNttLinkDataManageService {

	
	@Resource(name="ModuleNttLinkDataManageDAO")
    protected ModuleNttLinkDataManageDAO nttLinkDataManageDAO;
	
    @Resource(name="ModuleUploadFileService")
	public ModuleUploadFileService fileService;
    
    
	/**
	 * ㅁ 링크게시물SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextLinknttSeq(ModuleNttLinkVO vo) throws Exception {
		return nttLinkDataManageDAO.selectNextLinknttSeq(vo);
	}
	
	/**
	 * ㅁ 게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttLinkVO> selectNttLinkList(ModuleNttLinkVO vo) throws Exception {
		return nttLinkDataManageDAO.selectNttLinkList(vo);
	}
	
	/**
	 * ㅁ 게시물 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttLinkListTotCnt(ModuleNttLinkVO vo) throws Exception {
		return nttLinkDataManageDAO.selectNttLinkListTotCnt(vo);
	}

	/**
	 * ㅁ 게시물 상세정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleNttLinkVO selectNttLinkDetail(ModuleNttLinkVO vo) throws Exception {
		return nttLinkDataManageDAO.selectNttLinkDetail(vo);
	}
	
	/**
	 * ㅁ 게시물 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttLinkInfo(ModuleNttLinkVO vo) throws Exception {
		return nttLinkDataManageDAO.registNttLinkInfo(vo);
	}
	
	/**
	 * ㅁ 게시물 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttLinkInfo(ModuleNttLinkVO vo) throws Exception {
		return nttLinkDataManageDAO.modifyNttLinkInfo(vo);
	}
	
	/**
	 * ㅁ 게시물 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer deleteNttLinkInfo(ModuleNttLinkVO vo) throws Exception {
		
		if(vo.getAtchFileId() != null){
			
			ModuleUploadFileVO fvo = new ModuleUploadFileVO();
			
			fvo.setAtchFileId(vo.getAtchFileId());
			fileService.deleteFileInf(fvo);
		}
		
		return nttLinkDataManageDAO.deleteNttLinkInfo(vo);
	}
	
	/**
	 * ㅁ 게시물 삭제 (체크박스 선택 목록 삭제)
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer deleteCheckNttLinkInfo(ModuleNttLinkVO vo) throws Exception {
		
		String checkNttSeq = StringUtils.defaultString(vo.getCheckNttSeq());
		
		if(!"".equals(checkNttSeq)){
			checkNttSeq = vo.getCheckNttSeq().substring(0, vo.getCheckNttSeq().length()-1);
			vo.setDynamicArr(checkNttSeq.split(","));
		}
		
		return nttLinkDataManageDAO.deleteNttLinkInfo(vo);
	}
	
    /**
     * ㅁ 게시물 목록 - 화면
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<ModuleNttLinkVO> selectNttLinkScrinCntnts(ModuleNttLinkVO vo) throws Exception {
    	return nttLinkDataManageDAO.selectNttLinkScrinCntnts(vo);
    }
	
	/**
	 * ㅁ 휴지통 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttLinkVO> selectNttLinkRecycleList(ModuleNttLinkVO vo) throws Exception {
		return nttLinkDataManageDAO.selectNttLinkRecycleList(vo);
	}
	
	/**
	 * ㅁ 휴지통 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttLinkRecycleListTotCnt(ModuleNttLinkVO vo) throws Exception {
		return nttLinkDataManageDAO.selectNttLinkRecycleListTotCnt(vo);
	}
	
	/**
	 * ㅁ 휴지통 복원
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttLinkRecycle(ModuleNttLinkVO vo) throws Exception {
		return nttLinkDataManageDAO.modifyNttLinkRecycle(vo);
	}
	
	/**
	 * ㅁ  휴지통 복원 (체크박스 선택 목록 복원)
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyCheckNttLinkRecycle(ModuleNttLinkVO vo) throws Exception {
		
		String checkNttSeq = StringUtils.defaultString(vo.getCheckNttSeq());
		
		if(!"".equals(checkNttSeq)){
			checkNttSeq = vo.getCheckNttSeq().substring(0, vo.getCheckNttSeq().length()-1);
			vo.setDynamicArr(checkNttSeq.split(","));
		}
		
		return nttLinkDataManageDAO.modifyNttLinkRecycle(vo);
	}
	
	/**
	 * 휴지통 - 게시물 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public Integer deleteSiteNttLink(ModuleNttLinkVO vo) throws Exception {
		
		int resultValue = 0;
		
		if(!vo.getDelSe().equals("ALL")) {
			
			String checkNttSeq = StringUtils.defaultString(vo.getCheckNttSeq());
			
			if(!"".equals(checkNttSeq)){
				checkNttSeq = vo.getCheckNttSeq().substring(0, vo.getCheckNttSeq().length()-1);
				vo.setDynamicArr(checkNttSeq.split(","));
			}
			
		}		

		resultValue = nttLinkDataManageDAO.deleteSiteFileDetail(vo);

		resultValue = nttLinkDataManageDAO.deleteSiteFile(vo);
		
		resultValue = nttLinkDataManageDAO.deleteSiteNttLink(vo);

		resultValue = 1;
			
		return resultValue;
	}

	
}
