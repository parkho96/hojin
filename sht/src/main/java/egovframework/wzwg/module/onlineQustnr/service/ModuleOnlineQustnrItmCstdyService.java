package egovframework.wzwg.module.onlineQustnr.service;

import java.util.List;

public interface ModuleOnlineQustnrItmCstdyService {

	/** 내 문항 총 카운트 조회 */
	Integer selectOnlineQustnrItmCstdyTotCnt(ModuleOnlineQustnrInfoVO paramVO);

	/** 내 문항에 저장된 리스트 조회 */
	List<ModuleOnlineQustnrInfoVO> selectOnlineQustnrItmCstdyList(ModuleOnlineQustnrInfoVO paramVO);

	/** 내 문항에 저장 */
	int registOnlineQustnrItmCstdy(ModuleOnlineQustnrInfoVO paramVO);

	/** 내 문항에서 삭제 */
	int deleteOnlineQustnrItmCstdyArr(ModuleOnlineQustnrInfoVO paramVO);

	/** 내 문항 -> 현재 설문에 저장 */
	int registOnlineQustnrItmCstdyNowQustnr(ModuleOnlineQustnrInfoVO paramVO);

}
