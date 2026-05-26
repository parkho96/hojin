package egovframework.wzwg.sysMngr.usrMngr.usrInfo.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.IllegalFormatException;
import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.site.mngr.usrMngr.usrLog.service.SiteUsrLogService;
import egovframework.wzwg.site.mngr.usrMngr.usrLog.service.SiteUsrLogVO;
import egovframework.wzwg.sysMngr.usrMngr.usrInfo.service.SysMngrUsrInfoService;
import egovframework.wzwg.sysMngr.usrMngr.usrInfo.service.SysMngrUsrInfoVO;


/**
 * ㅁ 시스템 - 사용자관리
 * ㅁ DC   
 * - 시스템관리자가 사용자를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author 김c
 *
 */
@Service("SysMngrUsrInfoService")
public class SysMngrUsrInfoServiceImpl extends EgovAbstractServiceImpl implements SysMngrUsrInfoService {

    @Resource(name="SysMngrUsrInfoDAO")
    private SysMngrUsrInfoDAO usrInfoDAO;
    
    @Resource(name="SiteUsrLogService")
    private SiteUsrLogService siteUsrLogService;
    

    /**
	 * ㅁ 시스템 - 사용자 정보 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<SysMngrUsrInfoVO> selectUsrInfoList(SysMngrUsrInfoVO paramVO) throws Exception {
    	return usrInfoDAO.selectUsrInfoList(paramVO);
    }

    /**
     * ㅁ 시스템 - 사용자 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<SysMngrUsrInfoVO> selectUsrList(SysMngrUsrInfoVO paramVO) throws Exception {
        return usrInfoDAO.selectUsrList(paramVO);
    }

    /**
	 * ㅁ 시스템 - 사용자 정보 목록 건수
     * @param paramVO
     * @return
     * @throws Exception
     */
    public Integer selectUsrInfoListCnt(SysMngrUsrInfoVO paramVO) throws Exception {
    	return usrInfoDAO.selectUsrInfoListCnt(paramVO);
    }

    /**
	 * ㅁ 시스템 - 사용자 정보 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteUsrInfo(SysMngrUsrInfoVO paramVO, HttpServletRequest request) {
        
        int retVal = 0;
        
        try {
            String[] chkArr = paramVO.getChk();
            
            if (chkArr != null) {
                
                for (int i=0; i<chkArr.length; i++) {
                    String[] chkVal = chkArr[i].split(":");  
                 
                    if (chkVal.length == 2) {
                        String usrSeq = chkVal[0];
                        String siteSeq = chkVal[1];
                        paramVO.setUsrSeq(usrSeq);
                        paramVO.setSiteSeq(siteSeq);
                        
                        java.util.Enumeration params = request.getParameterNames();
                		String usrlogParam = "";
                		boolean bBadWord= false;
                		while ( params.hasMoreElements() ) {
                			String name = (String)params.nextElement();
                			String value = dggb.util.StringUtils.nvl(request.getParameter(name), "");
                			if(!name.equals("password") && !name.startsWith("hTel")){
                			usrlogParam =usrlogParam+"&"+name+"="+value;
                			}
                		}
                		usrlogParam = usrlogParam.substring(1);
                    	 CmmLoginVO resultVO2 = new CmmLoginVO(); 
                    	SiteUsrLogVO  siteUsrLogVO = new SiteUsrLogVO();
                    	siteUsrLogVO.setConectIp(request.getRemoteAddr());
                    	siteUsrLogVO.setFrstRegisterId(paramVO.getUserId()); 
                    	siteUsrLogVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
                    	siteUsrLogVO.setUsrChngCode("SC00000450"); 
                    	siteUsrLogVO.setUsrlogParam(usrlogParam);
                    	siteUsrLogVO.setUsrlogUrl(request.getRequestURI());
                    	siteUsrLogVO.setUsrlogUsrSeq(CmmSessionUtil.getLoginVO().getUsrSeq());
                    	siteUsrLogVO.setUsrSeq(usrSeq);
                    	siteUsrLogService.insertSiteUsrLog(siteUsrLogVO);
                        
                    	usrInfoDAO.deleteUsrCrtfctInfo(paramVO);
                    	usrInfoDAO.deleteSiteUsrInfo(paramVO);
                        usrInfoDAO.deleteUsrInfo(paramVO);
                        retVal++;
                    } else {
                        retVal = 0;
                        
                        return retVal;
                    }
                }
            } else {
                retVal = 0;
            }
        } catch(NullPointerException e){
          	 retVal = 0;
   	   	}catch(NumberFormatException e){
   	   	 retVal = 0;
   	   	}catch(IllegalFormatException e){
   	   	 retVal = 0;
   	   	}catch(ArrayIndexOutOfBoundsException e){
   	   	 retVal = 0;
   	   	} 
        
        return retVal;
	}

	/**
	 * ㅁ 시스템 - 사용자 정보 상세조회
     * @param paramVO
     * @return
     * @throws Exception
     */
	public SysMngrUsrInfoVO selectUsrInfoDetail(SysMngrUsrInfoVO paramVO) {
		return usrInfoDAO.selectUsrInfoDetail(paramVO);
	}

	/**
	 * ㅁ 시스템 - 사용자 정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyUsrInfo(SysMngrUsrInfoVO paramVO) throws Exception {
		
		/** 비밀번호 암호화 */
		if(!("").equals(paramVO.getPassword())){
			String password = EgovFileScrty.encryptPassword(paramVO.getPassword());
			paramVO.setPassword(password);
			
			String passwordCnfirm = EgovFileScrty.encryptPassword(paramVO.getPasswordCnfirm());
			paramVO.setPasswordCnfirm(passwordCnfirm);
			
		}

		// 사이트 사용자 정보 수정
		usrInfoDAO.modifySiteUsrInfo(paramVO);
		
		// 통합 사용자 정보 수정
		return usrInfoDAO.modifyUsrInfo(paramVO);
	}

    /**
     * ㅁ 시스템 - 사용자 상태 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifyUsrSttus(SysMngrUsrInfoVO paramVO, HttpServletRequest request) throws Exception {
        
        int retVal = 0;
        
        try {
            String[] chkArr = paramVO.getChk();
            
            if (chkArr != null) {
                
                for (int i=0; i<chkArr.length; i++) {
                    String[] chkVal = chkArr[i].split(":");  
                 
                    if (chkVal.length == 2) {
                        String usrSeq = chkVal[0];
                        String siteSeq = chkVal[1];
                        
                        paramVO.setUsrSeq(usrSeq);
                        paramVO.setSiteSeq(siteSeq);
                        
                        java.util.Enumeration params = request.getParameterNames();
                		String usrlogParam = "";
                		boolean bBadWord= false;
                		while ( params.hasMoreElements() ) {
                			String name = (String)params.nextElement();
                			String value = dggb.util.StringUtils.nvl(request.getParameter(name), "");
                			if(!name.equals("password") && !name.startsWith("hTel")){
                			usrlogParam =usrlogParam+"&"+name+"="+value;
                			}
                		}    
                          usrlogParam = usrlogParam.substring(1);
                       	 CmmLoginVO resultVO2 = new CmmLoginVO(); 
                       	SiteUsrLogVO  siteUsrLogVO = new SiteUsrLogVO();
                       	siteUsrLogVO.setConectIp(request.getRemoteAddr());
                       	siteUsrLogVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId()); 
                       	siteUsrLogVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
                       	siteUsrLogVO.setUsrChngCode("SC00000339"); 
                       	siteUsrLogVO.setUsrlogParam(usrlogParam);
                       	siteUsrLogVO.setUsrlogUrl(request.getRequestURI());
                       	siteUsrLogVO.setUsrlogUsrSeq(CmmSessionUtil.getLoginVO().getUsrSeq());
                       	siteUsrLogVO.setUsrSeq(usrSeq);
                       	siteUsrLogService.insertSiteUsrLog(siteUsrLogVO);
                        
                        usrInfoDAO.modifyUsrSttus(paramVO);
                        retVal++;
                    } else {
                        retVal = 0;
                        
                        return retVal;
                    }
                }
            } else {
                retVal = 0;
            }
        } catch(NullPointerException e){
         	 retVal = 0;
  	   	}catch(NumberFormatException e){
  	   	 retVal = 0;
  	   	}catch(IllegalFormatException e){
  	   	 retVal = 0;
  	   	}catch(ArrayIndexOutOfBoundsException e){
  	   	 retVal = 0;
  	   	}catch(IOException e){
  	   	 retVal = 0;
  	   	} catch(SQLException e){
  		   	 retVal = 0;
  	   	}   
        
        return retVal;
    }
    
    public int modifyUsrinfoGroup(SysMngrUsrInfoVO paramVO, HttpServletRequest request) throws Exception {
    	 int retVal = 0;
         
         try {
             String[] chkArr = paramVO.getChk(); 
             if (chkArr != null) {
                 
                 for (int i=0; i<chkArr.length; i++) {
                     String[] chkVal = chkArr[i].split(":");  
                  
                     if (chkVal.length == 2) {
                         String usrSeq = chkVal[0];
                         String siteSeq = chkVal[1];
                         
                         paramVO.setUsrSeq(usrSeq);
                         paramVO.setSiteSeq(siteSeq);
                         
                         java.util.Enumeration params = request.getParameterNames();
                 		String usrlogParam = "";
                 		boolean bBadWord= false;
                 		while ( params.hasMoreElements() ) {
                 			String name = (String)params.nextElement();
                 			String value = dggb.util.StringUtils.nvl(request.getParameter(name), "");
                 			if(!name.equals("password") && !name.startsWith("hTel")){
                 			usrlogParam =usrlogParam+"&"+name+"="+value;
                 			}
                 		}    
                           usrlogParam = usrlogParam.substring(1);
                        	 CmmLoginVO resultVO2 = new CmmLoginVO(); 
                        	SiteUsrLogVO  siteUsrLogVO = new SiteUsrLogVO();
                        	siteUsrLogVO.setConectIp(request.getRemoteAddr());
                        	siteUsrLogVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId()); 
                        	siteUsrLogVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
                        	siteUsrLogVO.setUsrChngCode("SC00000339"); 
                        	siteUsrLogVO.setUsrlogParam(usrlogParam);
                        	siteUsrLogVO.setUsrlogUrl(request.getRequestURI());
                        	siteUsrLogVO.setUsrlogUsrSeq(CmmSessionUtil.getLoginVO().getUsrSeq());
                        	siteUsrLogVO.setUsrSeq(usrSeq);
                        	siteUsrLogService.insertSiteUsrLog(siteUsrLogVO);
                         
                         usrInfoDAO.modifyUsrInfoGroup(paramVO);
                         retVal++;
                     } else {
                         retVal = 0;
                         
                         return retVal;
                     }
                 }
             } else {
                 retVal = 0;
             }
         }catch(NullPointerException e){
           	 retVal = 0;
 	   	}catch(NumberFormatException e){
 	   	 retVal = 0;
 	   	}catch(IllegalFormatException e){
 	   	 retVal = 0;
 	   	}catch(ArrayIndexOutOfBoundsException e){
 	   	 retVal = 0;
 	   	}catch(IOException e){
 	   	 retVal = 0;
 	   	} catch(SQLException e){
 		   	 retVal = 0;
 	   	}   
         
         return retVal;
    }
    
}
