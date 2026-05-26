package egovframework.wzwg.cmm.mber.cmm.web;

import java.sql.SQLException;
import java.util.IllegalFormatException;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.wzwg.cmm.mber.cmm.service.CmmRecrtfcService;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.site.mngr.usrMngr.sbscrbCrtfcEstbs.service.SbscrbCrtfcEstbsVO;


@Controller
public class CmmRecrtfcController {

    protected static final Log LOG = LogFactory.getLog(CmmRecrtfcController.class);
    
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
    @Resource(name="CmmRecrtfcService")
    private CmmRecrtfcService recrtfcService;
    
    @RequestMapping(value={"/cmm/mber/recrtfc/recrtfcForm.do","/{siteKey}/cmm/mber/recrtfc/recrtfcForm.do"})
    public String selectRecrtfcForm(
            @ModelAttribute("paramVO") CmmLoginVO paramVO
            , @ModelAttribute("sceVO") SbscrbCrtfcEstbsVO secVO
            , HttpServletRequest request
            , HttpServletResponse response
            , ModelMap model) throws Exception {
        
        String userId = StringUtils.defaultString((String)request.getAttribute("userId"));
        
        if (!"".equals(userId)) {
            paramVO.setUserId(userId);
        }
        
        String crtfcSeCode = recrtfcService.selectUserIdByCrtfctSeCd(paramVO.getUserId());
        
        model.addAttribute("crtfcSeCode", crtfcSeCode);

        model = recrtfcService.getCrtfcEstbsAndNiceModule(request, model, secVO);
        
        return "wzwg/cmm/mber/login/recrtfcForm";
    }
    
    @RequestMapping(value= {"/{siteKey}/cmm/mber/recrtfc/updateRecrtfc.do","/cmm/mber/recrtfc/updateRecrtfc.do"})
    public String updateRecrtfc(
            @ModelAttribute("paramVO") CmmLoginVO paramVO
            , HttpServletRequest request
            , HttpServletResponse response
            , ModelMap model) 
            throws Exception {
        
        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));       
        
        CmmLoginVO resultVO = recrtfcService.selectSiteUsrInfo(paramVO);
        
        if (resultVO != null) {
            
            paramVO.setUsrSeq(resultVO.getUsrSeq());
            
            int crtfcCnt = recrtfcService.selectUsrCrtfctCnt(paramVO);
            
            if (crtfcCnt > 0) {
                try {
                    resultVO.setUserSttusCode(Globals.USR_STTUS_CRTFC_CODE);
                    
                    int result = recrtfcService.updateRecrtfc(resultVO);
                    
                    if (result > 0) {
                        model.addAttribute("retMsg", "success.common.crtfc");
                    } else {
                        model.addAttribute("retMsg", "fail.common.update");
                    }
                } catch (SQLException e) {
                    model.addAttribute("retMsg", "fail.common.crtfc.error");
                } catch (NullPointerException e) {
                    model.addAttribute("retMsg", "fail.common.crtfc.error");
                }catch (NumberFormatException e) {
                    model.addAttribute("retMsg", "fail.common.crtfc.error");
                }catch (IllegalFormatException e) {
                    model.addAttribute("retMsg", "fail.common.crtfc.error");
                }
            } else {
                model.addAttribute("retMsg", "fail.common.crtfc.error");
            }

        } else {
            model.addAttribute("retMsg", "fail.common.crtfc.error");
        }
        
        model.addAttribute("paramVO", paramVO);       
        
        return "wzwg/cmm/mber/login/recrtfcForm";
    }
}