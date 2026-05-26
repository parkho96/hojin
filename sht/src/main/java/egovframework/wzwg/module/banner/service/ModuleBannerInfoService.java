package egovframework.wzwg.module.banner.service;

import java.util.List;

public interface ModuleBannerInfoService {
	
	/** 배너 총 카운트 조회 */
	public Integer selectBannerInfoTotCnt(ModuleBannerInfoVO moduleBannerVO) throws Exception;
	
	/** 배너 리스트 조회 */
	public List<ModuleBannerInfoVO> selectModuleBannerInfoList(ModuleBannerInfoVO moduleBannerVO) throws Exception;
	
	/** 배너 리스트 조회 */
	public List<ModuleBannerInfoVO> selectModuleBannerProgrsList(ModuleBannerInfoVO moduleBannerVO) throws Exception;

	/** 배너 상세조회 */
	public ModuleBannerInfoVO selectModuleBannerInfoDetail(ModuleBannerInfoVO moduleBannerVO) throws Exception;

	/** 배너 등록 */
	public int registModuleBannerInfo(ModuleBannerInfoVO moduleBannerVO) throws Exception;

	/** 배너 수정 */
	public int modifyModuleBannerInfo(ModuleBannerInfoVO moduleBannerVO) throws Exception;

	/** 배너 삭제 */
	public int deleteModuleBannerInfo(ModuleBannerInfoVO moduleBannerVO) throws Exception;
	
	/**메인 베너 리스트 조회 */
	public List<ModuleBannerInfoVO> selectModuleMainBannerList(ModuleBannerInfoVO moduleBannerVO) throws Exception;

}
