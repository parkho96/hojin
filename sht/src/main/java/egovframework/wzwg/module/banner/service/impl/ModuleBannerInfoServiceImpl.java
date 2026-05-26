package egovframework.wzwg.module.banner.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.banner.service.ModuleBannerInfoService;
import egovframework.wzwg.module.banner.service.ModuleBannerInfoVO;

@Service("ModuleBannerInfoService")
public class ModuleBannerInfoServiceImpl extends EgovAbstractServiceImpl implements ModuleBannerInfoService {
	
	@Resource(name="ModuleBannerInfoDAO")
	ModuleBannerInfoDAO moduleBannerInfoDAO;

	/** 배너 총 카운트 조회 */
	public Integer selectBannerInfoTotCnt(ModuleBannerInfoVO moduleBannerVO) throws Exception {
		return moduleBannerInfoDAO.selectBannerInfoTotCnt(moduleBannerVO);
	}
	
	/** 배너 리스트 조회 */
	public List<ModuleBannerInfoVO> selectModuleBannerInfoList(ModuleBannerInfoVO moduleBannerVO) throws Exception {
		return moduleBannerInfoDAO.selectModuleBannerInfoList(moduleBannerVO);
	}
	
	/** 진행중인 배너 리스트 조회 */
	public List<ModuleBannerInfoVO> selectModuleBannerProgrsList(ModuleBannerInfoVO moduleBannerVO) throws Exception {
		return moduleBannerInfoDAO.selectModuleBannerProgrsList(moduleBannerVO);
	}

	/** 배너 상세조회 */
	public ModuleBannerInfoVO selectModuleBannerInfoDetail(ModuleBannerInfoVO moduleBannerVO) throws Exception {
		return moduleBannerInfoDAO.selectModuleBannerInfoDetail(moduleBannerVO);
	}

	/** 배너 등록 */
	public int registModuleBannerInfo(ModuleBannerInfoVO moduleBannerVO) throws Exception {
		moduleBannerVO.setBannerSeq(moduleBannerInfoDAO.selectModuleBannerSeq(moduleBannerVO));
		return moduleBannerInfoDAO.registModuleBannerInfo(moduleBannerVO);
	} 

	/** 배너 수정 */
	public int modifyModuleBannerInfo(ModuleBannerInfoVO moduleBannerVO) throws Exception {
		return moduleBannerInfoDAO.modifyModuleBannerInfo(moduleBannerVO);
	}

	/** 배너 삭제 */
	public int deleteModuleBannerInfo(ModuleBannerInfoVO moduleBannerVO) throws Exception {
		return moduleBannerInfoDAO.deleteModuleBannerInfo(moduleBannerVO);
	}
	
	/** 배너 리스트 조회 */
	public List<ModuleBannerInfoVO> selectModuleMainBannerList(ModuleBannerInfoVO moduleBannerVO) throws Exception {
		return moduleBannerInfoDAO.selectModuleMainBannerList(moduleBannerVO);
	}
	
}
