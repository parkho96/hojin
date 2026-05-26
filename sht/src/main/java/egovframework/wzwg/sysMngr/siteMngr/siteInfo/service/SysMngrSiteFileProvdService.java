package egovframework.wzwg.sysMngr.siteMngr.siteInfo.service;

/**
 * ㅁ 시스템 - 사이트관리
 * ㅁ DC   
 * - 시스템관리자가 사이트를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
public interface SysMngrSiteFileProvdService {

	/**
     * ㅁ 시스템 - 사이트 첨부파일 허용용량 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifySiteFileProvd(SysMngrSiteAdiInfoVO paramVO) throws Exception;
    
}
