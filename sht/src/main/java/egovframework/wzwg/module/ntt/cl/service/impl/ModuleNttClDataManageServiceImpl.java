package egovframework.wzwg.module.ntt.cl.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.ntt.cl.service.ModuleNttClDataManageService;
import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;



@Service("ModuleNttClDataManageService")
public class ModuleNttClDataManageServiceImpl extends EgovAbstractServiceImpl implements ModuleNttClDataManageService {

	
	@Resource(name="ModuleNttClDataManageDAO")
    protected ModuleNttClDataManageDAO nttCmmnDAO;
	
	@Resource(name="ModuleNttClDataManageDAO")
    protected ModuleNttClDataManageDAO nttClDataManageDAO;
	
	
	/**
	 * ㅁ 게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttList(ModuleNttVO nttVO) throws Exception {
		return nttClDataManageDAO.selectNttList(nttVO);
	}
	
	/**
	 * ㅁ 게시물 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttListTotCnt(ModuleNttVO nttVO) throws Exception {
		return nttClDataManageDAO.selectNttListTotCnt(nttVO);
	}
    
    /**
     * ㅁ 게시물 목록 - 화면
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<ModuleNttVO> selectNttScrinCntnts(ModuleNttVO nttVO) throws Exception {
        return nttClDataManageDAO.selectNttScrinCntnts(nttVO);
    }

	/**
	 * ㅁ 휴지통 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttRecycleList(ModuleNttVO nttVO) throws Exception {
		return nttClDataManageDAO.selectNttRecycleList(nttVO);
	}	
	
	/**
	 * ㅁ 휴지통 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttRecycleListTotCnt(ModuleNttVO nttVO) throws Exception {
		return nttClDataManageDAO.selectNttRecycleListTotCnt(nttVO);
	}
	
	/**
	 * ㅁ 분류 순서 변경
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public Integer modifyNttListOrdr(ModuleNttVO nttVO) throws Exception {
		return nttClDataManageDAO.modifyNttListOrdr(nttVO);
	}
	
}
