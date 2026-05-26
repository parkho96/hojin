package egovframework.wzwg.module.banner.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.banner.service.ModuleBannerInfoVO;

@Repository("ModuleBannerInfoDAO")
public class ModuleBannerInfoDAO extends EgovAbstractMapper {
	
	/** 배너 시퀀스*/
	public String selectModuleBannerSeq(ModuleBannerInfoVO moduleBannerVO) throws Exception {
		return (String) selectOne("ModuleBannerInfoDAO_selectModuleBannerSeq", moduleBannerVO);
	}
	
	/** 배너 총 카운트 조회 */
	public Integer selectBannerInfoTotCnt(ModuleBannerInfoVO moduleBannerVO) throws Exception {
		return (Integer) selectOne("ModuleBannerInfoDAO_selectBannerInfoTotCnt", moduleBannerVO);
	}
	
	/** 배너 리스트 조회 */
	
	public List<ModuleBannerInfoVO> selectModuleBannerInfoList(ModuleBannerInfoVO moduleBannerVO) throws Exception {
		return  selectList("ModuleBannerInfoDAO_selectModuleBannerInfoList", moduleBannerVO);
	}
	
	/** 배너 리스트 조회 */
	
	public List<ModuleBannerInfoVO> selectModuleBannerProgrsList(ModuleBannerInfoVO moduleBannerVO) throws Exception {
		return  selectList("ModuleBannerInfoDAO_selectModuleBannerProgrsList", moduleBannerVO);
	}

	/** 배너 상세조회 */
	public ModuleBannerInfoVO selectModuleBannerInfoDetail(ModuleBannerInfoVO moduleBannerVO) throws Exception {
		return (ModuleBannerInfoVO)selectOne("ModuleBannerInfoDAO_selectModuleBannerInfoDetail", moduleBannerVO);
	}

	/** 배너 등록 */
	public int registModuleBannerInfo(ModuleBannerInfoVO moduleBannerVO) throws Exception {
		return update("ModuleBannerInfoDAO_registModuleBannerInfo", moduleBannerVO);
	} 

	/** 배너 수정 */
	public int modifyModuleBannerInfo(ModuleBannerInfoVO moduleBannerVO) throws Exception {
		return update("ModuleBannerInfoDAO_modifyModuleBannerInfo", moduleBannerVO);
	}

	/** 배너 삭제 */
	public int deleteModuleBannerInfo(ModuleBannerInfoVO moduleBannerVO) throws Exception {
		return update("ModuleBannerInfoDAO_deleteModuleBannerInfo", moduleBannerVO);
	}
	
	/**메인 배너 리스트 조회 */
	
	public List<ModuleBannerInfoVO> selectModuleMainBannerList(ModuleBannerInfoVO moduleBannerVO) throws Exception {
		return  selectList("ModuleBannerInfoDAO_selectModuleMainBannerList", moduleBannerVO);
	}

}
