package egovframework.wzwg.module.onlineQustnr.service;

import java.util.List;

public interface ModuleOnlineQustnrRespondService {

	/** 온라인 설문 리스트 조회 */
	List<ModuleOnlineQustnrRespondVO> selectOnlineQustnrList(ModuleOnlineQustnrRespondVO paramVO);

	/** 온라인 설문 답변 등록 */
	int registOnlineQustnrRespond(ModuleOnlineQustnrRespondVO paramVO);

	/** 온라인 설문 총 카운트 조회 */
	Integer selectQustnrInfoTotCnt(ModuleOnlineQustnrRespondVO paramVO);

}
