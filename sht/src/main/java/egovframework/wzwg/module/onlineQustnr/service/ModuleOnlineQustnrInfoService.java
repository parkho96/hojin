package egovframework.wzwg.module.onlineQustnr.service;

import java.util.List;

public interface ModuleOnlineQustnrInfoService {

	/** 설문 총 카운트 조회 */
	Integer selectOnlineQustnrInfoTotCnt(ModuleOnlineQustnrInfoVO paramVO);

	/** 설문 리스트 조회 */
	List<ModuleOnlineQustnrInfoVO> selectOnlineQustnrInfoList(ModuleOnlineQustnrInfoVO paramVO);

	/** 설문 상세 조회 */
	ModuleOnlineQustnrInfoVO selectOnlineQustnrInfoDetail(ModuleOnlineQustnrInfoVO paramVO);

	/** 설문 등록 */
	int registOnlineQustnrInfo(ModuleOnlineQustnrInfoVO paramVO);

	/** 설문 수정 */
	int modifyOnlineQustnrInfo(ModuleOnlineQustnrInfoVO paramVO);

	/** 설문 삭제 */
	int deleteOnlineQustnrInfo(ModuleOnlineQustnrInfoVO paramVO);

	/** 설문 삭제(다중) */
	int deleteOnlineQustnrInfoArr(ModuleOnlineQustnrInfoVO paramVO);

	/** 설문 대상자 리스트 조회 */
	List<ModuleOnlineQustnrInfoVO> selectOnlineQustnrUsrtyList(ModuleOnlineQustnrInfoVO paramVO);

}
