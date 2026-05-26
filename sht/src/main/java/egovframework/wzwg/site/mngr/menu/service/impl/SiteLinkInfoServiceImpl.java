package egovframework.wzwg.site.mngr.menu.service.impl;

import java.util.IllegalFormatException;
import java.util.List;

import jakarta.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.site.mngr.menu.service.SiteLinkGrpInfoVO;
import egovframework.wzwg.site.mngr.menu.service.SiteLinkInfoService;

@Service("LinkInfoService")
public class SiteLinkInfoServiceImpl extends EgovAbstractServiceImpl implements SiteLinkInfoService {
	
	@Resource(name="LinkInfoDAO")
	SiteLinkInfoDAO linkInfoDAO;
	
	protected static final Log LOG = LogFactory.getLog(SiteLinkInfoServiceImpl.class);

    public Integer selectLinkInfoListCnt(SiteLinkGrpInfoVO paramVO) {
        return linkInfoDAO.selectLinkInfoListCnt(paramVO);
    }

    public List<SiteLinkGrpInfoVO> selectLinkInfoList(SiteLinkGrpInfoVO paramVO) {
        return linkInfoDAO.selectLinkInfoList(paramVO);
    }

    public int registLinkInfo(SiteLinkGrpInfoVO paramVO) {
        String linkSeq = linkInfoDAO.selectLinkInfoSeq(paramVO);
        
        paramVO.setLinkSeq(linkSeq);
        
        return linkInfoDAO.registLinkInfo(paramVO);
    }

    public SiteLinkGrpInfoVO selectLinkInfoDetail(SiteLinkGrpInfoVO paramVO) {
        return linkInfoDAO.selectLinkInfoDetail(paramVO);
    }

    public int modifyLinkInfo(SiteLinkGrpInfoVO paramVO) {
        return linkInfoDAO.modifyLinkInfo(paramVO);
    }

    public int deleteLinkInfo(SiteLinkGrpInfoVO paramVO) {
        return linkInfoDAO.deleteLinkInfo(paramVO);
    }

    public List<SiteLinkGrpInfoVO> selectLinkGrpMapListAjax(SiteLinkGrpInfoVO paramVO) {
        return linkInfoDAO.selectLinkGrpMapListAjax(paramVO);
    }

    public int deleteLinkGrp(SiteLinkGrpInfoVO paramVO) {
        
        int returnVal = 0;
        
        String[] linkSeqArr = paramVO.getLinkSeqArr();
        
        try {
            if (linkSeqArr != null) {
                for (int i=0; i<linkSeqArr.length; i++) {
                    paramVO.setLinkSeq(linkSeqArr[i]);
                    
                    returnVal = linkInfoDAO.deleteLinkGrp(paramVO);
                    
                    if (returnVal < 1) {
                        return returnVal;
                    }
                }   
            }
        }catch(NullPointerException e){
        	LOG.error("NullPointerException",e);
	   	}catch(NumberFormatException e){
	   		LOG.error("NumberFormatException",e);
	   	}catch(IllegalFormatException e){
	   		LOG.error("IllegalFormatException",e);
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		LOG.error("ArrayIndexOutOfBoundsException",e);	   		
	   	}
        
        return returnVal;
    }

    public int registLinkGrp(SiteLinkGrpInfoVO paramVO) {
        
        int returnVal = 0;
        
        String[] linkSeqArr = paramVO.getLinkSeqArr();
        
        try {
            if (linkSeqArr != null) {
                for (int i=0; i<linkSeqArr.length; i++) {
                    
                    paramVO.setLinkSeq(linkSeqArr[i]);

                    int chkCnt = linkInfoDAO.selectLinkGrpCnt(paramVO);
                    
                    if (chkCnt < 1) {
                        paramVO.setOrdr(linkInfoDAO.selectLinkGrpOrdr(paramVO)); 
                        returnVal = linkInfoDAO.registLinkGrp(paramVO); 
                        
                        if (returnVal < 1) {
                            return returnVal;
                        }
                    }
                }   
            }
        } catch(NullPointerException e){
        	LOG.error("NullPointerException",e);
	   	}catch(NumberFormatException e){
	   		LOG.error("NumberFormatException",e);
	   	}catch(IllegalFormatException e){
	   		LOG.error("IllegalFormatException",e);
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		LOG.error("ArrayIndexOutOfBoundsException",e);
	   	}
        
        return returnVal;
    }

    public List<SiteLinkGrpInfoVO> selectLinkUrlList(SiteLinkGrpInfoVO paramVO) {
        return linkInfoDAO.selectLinkUrlList(paramVO);
    }

    public int modifySiteLinkGrpOrdr(SiteLinkGrpInfoVO paramVO) throws Exception
    {
        SiteLinkGrpInfoVO thisVO = new SiteLinkGrpInfoVO();
        SiteLinkGrpInfoVO targetVO = new SiteLinkGrpInfoVO();
        if(paramVO.getOrdrGubun().equals("U"))
            targetVO = linkInfoDAO.selectSiteLinkGrpOrdrUp(paramVO);
        else
        if(paramVO.getOrdrGubun().equals("D"))
            targetVO = linkInfoDAO.selectSiteLinkGrpOrdrDown(paramVO);
        if(targetVO == null)
        {
            return -1;
        } else
        {
            thisVO.setLinkSeq(paramVO.getLinkSeq());
            thisVO.setLastUpdusrId(paramVO.getLastUpdusrId());
            thisVO.setOrdr(targetVO.getOrdr());
            thisVO.setSiteSeq(paramVO.getSiteSeq());
            targetVO.setLastUpdusrId(paramVO.getLastUpdusrId());
            targetVO.setOrdr(paramVO.getOrdr());
            targetVO.setSiteSeq(paramVO.getSiteSeq());
            int result = 0;
            result += linkInfoDAO.modifySiteLinkGrpOrdr(thisVO);
            result += linkInfoDAO.modifySiteLinkGrpOrdr(targetVO);
            return result;
        }
    }

}
