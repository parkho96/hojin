package egovframework.wzwg.cmm.conectCtrl.web;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ConectCtrlLicenseController {
    @RequestMapping("/licenseFail.do")
    public String licenseFail(  HttpServletRequest request
            , Model model) throws Exception {

        
        return "wzwg/cmm/license/licenseFail";
    }
    @RequestMapping("/urlFail.do")
    public String urlFail(  HttpServletRequest request
            , Model model) throws Exception {

        
        return "wzwg/cmm/license/urlFail";
    }
}
