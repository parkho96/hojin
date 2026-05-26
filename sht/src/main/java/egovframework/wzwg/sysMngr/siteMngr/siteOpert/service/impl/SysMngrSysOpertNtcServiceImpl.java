package egovframework.wzwg.sysMngr.siteMngr.siteOpert.service.impl;

import java.util.IllegalFormatException;
import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.siteMngr.siteOpert.service.SysMngrSysOpertNtcService;
import egovframework.wzwg.sysMngr.siteMngr.siteOpert.service.SysMngrSysOpertNtcVO;

@Service("SysOpertNtcService")
public class SysMngrSysOpertNtcServiceImpl extends EgovAbstractServiceImpl implements SysMngrSysOpertNtcService {
	
	@Resource(name="SysOpertNtcDAO")
	SysMngrSysOpertNtcDAO sysOpertNtcDAO;

	/**
	 * 작업알림 총 카운트 조회
	 */
	public Integer selectSysOpertNtcTotCnt(SysMngrSysOpertNtcVO sysOpertNtcVO) {
		return sysOpertNtcDAO.selectSysOpertNtcTotCnt(sysOpertNtcVO);
	}

	/**
	 * 작업알림 리스트 조회
	 */
	public List<SysMngrSysOpertNtcVO> selectSysOpertNtcList(SysMngrSysOpertNtcVO sysOpertNtcVO) {
		return sysOpertNtcDAO.selectSysOpertNtcList(sysOpertNtcVO);
	}

	/**
	 * 작업알림 상세조회
	 */
	public SysMngrSysOpertNtcVO selectSysOpertNtcDetail(SysMngrSysOpertNtcVO sysOpertNtcVO) {
		return sysOpertNtcDAO.selectSysOpertNtcDetail(sysOpertNtcVO);
	}

	/**
	 * 작업알림 등록
	 */
	public int registSysOpertNtc(SysMngrSysOpertNtcVO sysOpertNtcVO) {
		String opertSeq = sysOpertNtcDAO.selectSysOpertNtcSeq();
		sysOpertNtcVO.setSysopertSeq(opertSeq);
		
		return sysOpertNtcDAO.registSysOpertNtc(sysOpertNtcVO);
	}

	/**
	 * 작업알림 수정
	 */
	public int modifySysOpertNtc(SysMngrSysOpertNtcVO sysOpertNtcVO) {
		return sysOpertNtcDAO.modifySysOpertNtc(sysOpertNtcVO);
	}

	/**
	 * 작업알림 삭제
	 */
	public int deleteSysOpertNtc(SysMngrSysOpertNtcVO sysOpertNtcVO) {
		return sysOpertNtcDAO.deleteSysOpertNtc(sysOpertNtcVO);
	}

	/**
	 * 작업알림 체크박스 삭제
	 */
	public int deleteSysOpertNtcArr(SysMngrSysOpertNtcVO sysOpertNtcVO) {
		int result = 0;
		
		try {
			String[] seqArr = sysOpertNtcVO.getSysopertSeqArr();
			
			if(seqArr != null && seqArr.length > 0){
				for(int i=0; i<seqArr.length; i++){
					String opertSeq = seqArr[i];
					if(!"".equals(opertSeq)){
						sysOpertNtcVO.setSysopertSeq(opertSeq);
						result += sysOpertNtcDAO.deleteSysOpertNtc(sysOpertNtcVO);
					}
				}
			}
			
		} catch(NullPointerException e){			
			result = 0;
  	   	}catch(NumberFormatException e){
  	   		result = 0;
  	   	}catch(IllegalFormatException e){
  	   		result = 0;
  	   	}catch(ArrayIndexOutOfBoundsException e){
  	   		result = 0;
  	   	}  
		return result;
	}

    /**
     * @Method Name : selectSiteOpertNtcDetail
     * @Method 설명 : 사이트 작업알림 - 접속제어 인터셉터에서 사용
     *
     * @param paramVO
     * @return
     *
     * @변경이력 : 
     */
    public SysMngrSysOpertNtcVO selectConectCtrlSysOpertntc(SysMngrSysOpertNtcVO sysOpertNtcVO) {
        return sysOpertNtcDAO.selectConectCtrlSysOpertntc(sysOpertNtcVO);
    }

    /**
     * @Method Name : selectSiteOpertNtcDetail
     * @Method 설명 : 사이트 작업알림 - 접속제어 인터셉터에서 사용
     *
     * @param paramVO
     * @return
     *
     * @변경이력 : 
     */
    public Integer selectConectCtrlSysOpertntcChk(SysMngrSysOpertNtcVO sysOpertNtcVO) {
        return sysOpertNtcDAO.selectConectCtrlSysOpertntcChk(sysOpertNtcVO);
    }

}
