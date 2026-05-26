package egovframework.wzwg.sysMngr.usrMngr.usrInfo.service;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;

/**
 * ㅁ 시스템 - 사용자관리
 * ㅁ DC   
 * - 시스템관리자가 사용자를 관리
 * - 생선된 사용자는 사용자 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
public interface SysMngrUsrInfoService {

    /**
	 * ㅁ 시스템 - 사용자 정보 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<SysMngrUsrInfoVO> selectUsrInfoList(SysMngrUsrInfoVO paramVO) throws Exception;

    /**
     * ㅁ 시스템 - 사용자 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<SysMngrUsrInfoVO> selectUsrList(SysMngrUsrInfoVO paramVO) throws Exception;

    /**
	 * ㅁ 시스템 - 사용자 정보 목록 건수
     * @param paramVO
     * @return
     * @throws Exception
     */
    public Integer selectUsrInfoListCnt(SysMngrUsrInfoVO paramVO) throws Exception;

    /**
	 * ㅁ 시스템 - 사용자 정보 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteUsrInfo(SysMngrUsrInfoVO paramVO, HttpServletRequest request);

	/**
	 * ㅁ 시스템 - 사용자 정보 상세조회
     * @param paramVO
     * @return
     * @throws Exception
     */
	public SysMngrUsrInfoVO selectUsrInfoDetail(SysMngrUsrInfoVO paramVO);

    /**
     * ㅁ 시스템 - 사용자 정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifyUsrInfo(SysMngrUsrInfoVO paramVO) throws Exception;

    /**
     * ㅁ 시스템 - 사용자 상태 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifyUsrSttus(SysMngrUsrInfoVO paramVO, HttpServletRequest request) throws Exception;
    
    public int modifyUsrinfoGroup(SysMngrUsrInfoVO paramVO, HttpServletRequest request) throws Exception;
	
}
