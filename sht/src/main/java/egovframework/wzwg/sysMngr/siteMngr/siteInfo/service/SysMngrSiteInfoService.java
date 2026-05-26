package egovframework.wzwg.sysMngr.siteMngr.siteInfo.service;

import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;

/**
 * ㅁ 시스템 - 사이트관리
 * ㅁ DC   
 * - 시스템관리자가 사이트를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
public interface SysMngrSiteInfoService {

    /**
	 * ㅁ 시스템 - 사이트 정보 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<SysMngrSiteInfoVO> selectSiteInfoList(SysMngrSiteInfoVO paramVO) throws Exception;

    /**
	 * ㅁ 시스템 - 사이트 정보 목록 건수
     * @param paramVO
     * @return
     * @throws Exception
     */
    public Integer selectSiteInfoListCnt(SysMngrSiteInfoVO paramVO) throws Exception;

    /**
	 * ㅁ 시스템 - 사이트 정보 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
    public SysMngrSiteInfoVO selectSiteInfoDetail(SysMngrSiteInfoVO paramVO) throws Exception;
    
    /**
   	 * ㅁ 시스템 - 시스템 관리자 사이트 체크
        * @param paramVO
        * @return
        * @throws Exception
        */
    public int selectSiteInfoSysCheck(SysMngrSiteInfoVO paramVO) throws Exception;

    /**
	 * ㅁ 시스템 - 사이트 정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void registSiteInfo(SysMngrSiteInfoVO paramVO, HttpServletRequest request) throws Exception;

    /**
	 * ㅁ 시스템 - 사이트 정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void modifySiteInfo(SysMngrSiteInfoVO paramVO) throws Exception;

    /**
	 * ㅁ 시스템 - 사이트 상태 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void modifySiteSttus(SysMngrSiteInfoVO paramVO) throws Exception;

    /**
     * ㅁ 시스템 - 조합번호 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
    public Integer selectAsscNoCnt(SysMngrSiteInfoVO paramVO) throws Exception;

    /**
     * ㅁ 시스템 - 사이트정보 엑셀 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<Map<String, String>> registSiteInfoExcel(SysMngrSiteInfoVO paramVO, HttpServletRequest request) throws Exception;
    
    public List<SysMngrSiteInfoVO> selectSiteInfoSignList(SysMngrSiteInfoVO paramVO) throws Exception;

    /**
     * 사이트 키 중복체크
     * @param paramVO
     * @return
     */
	public String selectSiteInfoDplctCheck(SysMngrSiteInfoVO paramVO);
}
