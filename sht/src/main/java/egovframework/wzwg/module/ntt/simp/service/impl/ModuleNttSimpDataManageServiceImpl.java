package egovframework.wzwg.module.ntt.simp.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.ntt.simp.service.ModuleNttSimpDataManageService;
import egovframework.wzwg.module.ntt.simp.service.ModuleNttSimpVO;



@Service("ModuleNttSimpDataManageService")
public class ModuleNttSimpDataManageServiceImpl extends EgovAbstractServiceImpl implements ModuleNttSimpDataManageService {

	@Resource(name="ModuleNttSimpDataManageDAO")
    protected ModuleNttSimpDataManageDAO nttSimpDataManageDAO;
	
	
	/**
	 * ㅁ 게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttSimpVO> selectNttSimpList(ModuleNttSimpVO nttSimpVO) throws Exception {
		return nttSimpDataManageDAO.selectNttSimpList(nttSimpVO);
	}
	
	/**
	 * ㅁ 간단게시물 작성자
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNttSimpNtcrId(ModuleNttSimpVO nttSimpVO) throws Exception {
		return nttSimpDataManageDAO.selectNttSimpNtcrId(nttSimpVO);
	}	
	
	/**
	 * ㅁ 게시물 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registNttSimpInfo(ModuleNttSimpVO nttSimpVO) throws Exception {
		return nttSimpDataManageDAO.registNttSimpInfo(nttSimpVO);
	}
	
	/**
	 * ㅁ 간단게시물 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttSimpInfo(ModuleNttSimpVO nttSimpVO) throws Exception {
		return nttSimpDataManageDAO.modifyNttSimpInfo(nttSimpVO);
	}
	
	/**
	 * ㅁ 간단게시물 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteNttSimpInfo(ModuleNttSimpVO nttSimpVO) throws Exception {
		return nttSimpDataManageDAO.deleteNttSimpInfo(nttSimpVO);
	}

	/**
	 * ㅁ 간단게시물 삭제 (체크박스 선택 목록 삭제)
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteCheckNttSimpInfo(ModuleNttSimpVO nttSimpVO) throws Exception {
		
		String checkSimpnttSeq = StringUtils.defaultString(nttSimpVO.getCheckSimpnttSeq());
		
		if(!"".equals(checkSimpnttSeq)){
			checkSimpnttSeq = nttSimpVO.getCheckSimpnttSeq().substring(0, nttSimpVO.getCheckSimpnttSeq().length()-1);
			nttSimpVO.setDynamicArr(checkSimpnttSeq.split(","));
		}
		
		return nttSimpDataManageDAO.deleteNttSimpInfo(nttSimpVO);
	}	
    
    /**
     * ㅁ 게시물 목록 - 화면
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<ModuleNttSimpVO> selectNttSimpScrinCntnts(ModuleNttSimpVO nttVO) throws Exception {
        return nttSimpDataManageDAO.selectNttSimpList(nttVO);
    }

	/**
	 * ㅁ 휴지통 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttSimpVO> selectNttSimpRecycleList(ModuleNttSimpVO nttSimpVO) throws Exception {
		return nttSimpDataManageDAO.selectNttSimpRecycleList(nttSimpVO);
	}	
	
	/**
	 * ㅁ 휴지통 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttSimpRecycleListTotCnt(ModuleNttSimpVO nttSimpVO) throws Exception {
		return nttSimpDataManageDAO.selectNttSimpRecycleListTotCnt(nttSimpVO);
	}
	
	/**
	 * ㅁ 휴지통 복원
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttSimpRecycle(ModuleNttSimpVO nttSimpVO) throws Exception {
		return nttSimpDataManageDAO.modifyNttSimpRecycle(nttSimpVO);
	}	
	
	/**
	 * ㅁ  휴지통 복원 (체크박스 선택 목록 삭제)
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyCheckNttSimpRecycle(ModuleNttSimpVO nttSimpVO) throws Exception {
		
		String checkSimpnttSeq = StringUtils.defaultString(nttSimpVO.getCheckSimpnttSeq());
		
		if(!"".equals(checkSimpnttSeq)){
			checkSimpnttSeq = nttSimpVO.getCheckSimpnttSeq().substring(0, nttSimpVO.getCheckSimpnttSeq().length()-1);
			nttSimpVO.setDynamicArr(checkSimpnttSeq.split(","));
		}
		
		return nttSimpDataManageDAO.modifyNttSimpRecycle(nttSimpVO);
	}	
	
	/**
	 * 휴지통 - 게시물 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSiteSimpNtt(ModuleNttSimpVO nttSimpVO) throws Exception {
		
		int resultValue = 0;
		
		if(!nttSimpVO.getDelSe().equals("ALL")) {
		
			String checkSimpnttSeq = StringUtils.defaultString(nttSimpVO.getCheckSimpnttSeq());
			
			if(!"".equals(checkSimpnttSeq)){
				checkSimpnttSeq = nttSimpVO.getCheckSimpnttSeq().substring(0, nttSimpVO.getCheckSimpnttSeq().length()-1);
				nttSimpVO.setDynamicArr(checkSimpnttSeq.split(","));
			}
			
		}

		resultValue = nttSimpDataManageDAO.deleteSiteSimpNttAnswer(nttSimpVO);

		resultValue = nttSimpDataManageDAO.deleteSiteSimpNtt(nttSimpVO);
		
		resultValue = 1;

		return resultValue;
	}	
}
