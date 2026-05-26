package egovframework.wzwg.site.mngr.cntnts.cntntsCharger.service;

import java.util.List;

public interface CntntsChargerService {

    /**
     * ㅁ 컨텐츠담당자정보 - 모듈 컨텐츠 담당자 정보 목록
     * @param CntntsChargerVO
     * @return
     */
    public List<CntntsChargerVO> selectCntntsChargerList(CntntsChargerVO paramVO);
    
    /**
     * ㅁ 컨텐츠권한정보 - 모듈 컨텐츠 권한 정보 등록
     * @param CntntsAuthVO
     * @return
     */
    public int registCntntsCharger(CntntsChargerVO paramVO);
    
    /**
     * ㅁ 컨텐츠권한정보 - 모듈 컨텐츠 권한 정보 삭제
     * @param CntntsAuthVO
     * @return
     */
    public int deleteCntntsCharger(CntntsChargerVO paramVO);
    
}
