package egovframework.wzwg.cmm.authCtrl.service;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;

import egovframework.com.cmm.service.Globals;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.pageCallCtrl.service.PageCallCtrlService;
import egovframework.wzwg.cmm.pageCallCtrl.service.PageCallCtrlVO;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.scrin.service.ScrinCntntsService;
import egovframework.wzwg.module.scrin.service.ScrinCntntsVO;

@Aspect
public class AuthCtrlAspect {

    @Resource(name = "AuthCtrlService")
    private AuthCtrlService authCtrlService;

    @Resource(name = "PageCallCtrlService")
    private PageCallCtrlService pageCallCtrlService;

    @Resource(name = "ScrinCntntsService")
    private ScrinCntntsService scrinCntntsService;

    public void test(JoinPoint jp) throws Throwable {

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest();

        Object[] args = jp.getArgs();

        String menuSeq = (String) args[0];
    }

    public void subMenuAccesAuthCtrl(JoinPoint jp) throws Throwable {

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest();

        Object[] args = jp.getArgs();

        String menuSeq = (String) args[0];

        AuthCtrlVO paramVO = new AuthCtrlVO();

        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        paramVO.setMenuSeq(menuSeq);

        ModelAndView retModel = new ModelAndView();
        retModel.setViewName("wzwg/cmm/errorStringMsgForward");
        retModel.addObject("retUrl", "/index.do");

        String sitecntntsSeq = authCtrlService.selectMenuSeqBySiteCntntsSeq(paramVO);

        if ("".equals(StringUtils.defaultString(sitecntntsSeq))) {

            String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
            PageCallCtrlVO pageVO = new PageCallCtrlVO();

            pageVO.setSiteSeq(siteSeq);
            pageVO.setMenuSeq(menuSeq);
            String menuLinkUrl = "";
            menuLinkUrl = pageCallCtrlService.selectMenuSeqByMenuLinkUrl(pageVO);
            if (menuLinkUrl.equals("")) {
                retModel.addObject("errCd", "authCtrl.err01");
                throw new ModelAndViewDefiningException(retModel);
            }
        }

        request.setAttribute("sitecntntsSeq", sitecntntsSeq);

        paramVO.setSitecntntsSeq(sitecntntsSeq);

        userAuthCtrl(paramVO, request, retModel);
    }

    public void shrtenUrlAuthCtrl(JoinPoint jp) throws Throwable {

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest();

        Object[] args = jp.getArgs();

        String detailCntntsSeq = (String) args[0];

        String menuTySe = (String) args[1];

        AuthCtrlVO paramVO = new AuthCtrlVO();

        paramVO.setMenuTySe(menuTySe);

        ModelAndView retModel = new ModelAndView();
        retModel.setViewName("wzwg/cmm/errorStringMsgForward");
        retModel.addObject("retUrl", "/index.do");

        AuthCtrlVO tableInfo = authCtrlService.selectModuleTable(paramVO);

        tableInfo.setMenuTySe(menuTySe);
        tableInfo.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        tableInfo.setDetailCntntsSeq(detailCntntsSeq);

        if (tableInfo != null) {

            AuthCtrlVO cntntsInfo = authCtrlService.selectCntntsInfo(tableInfo);

            if (cntntsInfo != null) {

                String sitecntntsSeq = cntntsInfo.getSitecntntsSeq();

                tableInfo.setSitecntntsSeq(sitecntntsSeq);

                request.setAttribute("sitecntntsSeq", sitecntntsSeq);
            } else {
                retModel.addObject("errCd", "authCtrl.err01");
                throw new ModelAndViewDefiningException(retModel);
            }

            userAuthCtrl(tableInfo, request, retModel);
        } else {
            retModel.addObject("errCd", "authCtrl.err01");
            throw new ModelAndViewDefiningException(retModel);
        }
    }

    private void userAuthCtrl(AuthCtrlVO paramVO, HttpServletRequest request, ModelAndView retModel) throws Throwable {

        CmmLoginVO loginVO = null;

        if (EgovUserDetailsHelper.isAuthenticated()) {

            loginVO = CmmSessionUtil.getLoginVO();
            paramVO.setUsrSeq(loginVO.getUsrSeq());
            paramVO.setUsrgroupSeq(loginVO.getUsrgroupSeq());
        }

        int sysMngrCnt = (CmmSessionUtil.getSessionBooleanValue(request, "SADMIN_AT")
                || CmmSessionUtil.getSessionBooleanValue(request, "NADMIN_AT")) ? 1 : 0;

        int cntChrgCnt = authCtrlService.selectCntntsChrgCnt(paramVO);

        if ((sysMngrCnt + cntChrgCnt) > 0) {
            CmmSessionUtil.setSessionValue(request, "CNTNTS_ADMIN_AT", true);
        } else {
            CmmSessionUtil.setSessionValue(request, "CNTNTS_ADMIN_AT", false);

            List<AuthCtrlVO> authList = authCtrlService.selectCntntsUsrAuthInfoCnt(paramVO);

            if (authList != null) {

                String nmbrUsrGroup = Globals.NMBR_SITE_USRGROUPSEQ;
                String nmbrAuthorSe = "";
                String usrAuthorSe = "";
                String authorUseAt = authCtrlService.selectMenuSeqByAuthorUseAt(paramVO);
                for (int i = 0; i < authList.size(); i++) {

                    AuthCtrlVO getVO = authList.get(i);

                    if (getVO.getUsrgroupSeq().equals(nmbrUsrGroup)) {
                        nmbrAuthorSe = getVO.getAuthorSe();
                    }
                    if (getVO.getUsrgroupSeq().equals(paramVO.getUsrgroupSeq())) {
                        usrAuthorSe = getVO.getAuthorSe();
                    }
                }

                HttpSession session = request.getSession();
                session.setAttribute("NMBER_AUTHOR", nmbrAuthorSe);
                if (!EgovUserDetailsHelper.isAuthenticated()) {
                    if ("".equals(nmbrAuthorSe) || "N".equals(nmbrAuthorSe)) {
                        if (authorUseAt.equals("Y")) {
                            retModel.addObject("errCd", "fail.common.author");
                            throw new ModelAndViewDefiningException(retModel);
                        }
                    }
                } else {
                    if ("".equals(usrAuthorSe) || "N".equals(usrAuthorSe)) {

                        if ("".equals(nmbrAuthorSe) || "N".equals(nmbrAuthorSe)) {
                            if (authorUseAt.equals("Y")) {
                                retModel.addObject("errCd", "fail.common.author");
                                throw new ModelAndViewDefiningException(retModel);
                            }
                        }
                    }
                }
            } else {
                retModel.addObject("errCd", "fail.common.author");
                throw new ModelAndViewDefiningException(retModel);
            }
        }

    }

    public void tabMenuAccesAuthCtrl(JoinPoint jp) throws Throwable {

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest();

        Object[] args = jp.getArgs();

        ScrinCntntsVO param = (ScrinCntntsVO) args[0];

        ScrinCntntsVO cntntsInfo = null;
        param.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        // if(menuLinkUrl.equals("")){
        // 컨텐츠 정보를 가져옴
        cntntsInfo = scrinCntntsService.selectSitecntntsSeqByModuleInfo(param);

        AuthCtrlVO paramVO = new AuthCtrlVO();

        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));

        ModelAndView retModel = new ModelAndView();
        retModel.setViewName("wzwg/cmm/errorStringMsgForward");
        retModel.addObject("retUrl", "historyBack");

        String sitecntntsSeq = cntntsInfo.getSitecntntsSeq();

        if ("".equals(StringUtils.defaultString(sitecntntsSeq))) {

            String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
            PageCallCtrlVO pageVO = new PageCallCtrlVO();

        }

        request.setAttribute("sitecntntsSeq", sitecntntsSeq);

        paramVO.setSitecntntsSeq(sitecntntsSeq);

        userAuthCtrl(paramVO, request, retModel);
    }

}