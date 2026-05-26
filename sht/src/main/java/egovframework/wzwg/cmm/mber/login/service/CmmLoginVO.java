package egovframework.wzwg.cmm.mber.login.service;

import java.io.Serializable;
import java.util.List;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.interceptor.service.MngrAuthVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CmmLoginVO extends LoginVO implements Serializable {

    private static final long serialVersionUID = -8274004534207618049L;

    private String siteSeq;
    private String usrSeq;
    private String userId;

    @ToString.Exclude // 로그 출력 시 비밀번호 유출 방지
    private String password;

    private String userNm;
    private String emailAdres;
    private String usrSttusCode;
    private String siteUsrSttusCode;
    private String sbscrbPnttm;
    private String usrtySeq;
    private String usrgroupSeq;
    private String userSttusCode;
    private String useAt;
    private String lastUpdusrId;
    private String lastUpdtPnttm;
    private String ip;
    private String errMsg;
    private String snsCrtfcSe;
    private String snsCrtfcId;
    private String pwUpdtPnttm;
    private String pwUpdtDe;
    private String lastUpdtDe;
    private String crtfctSeCode;
    private String crtfctDn;
    private String crtfcSe;
    private String crtfcSns;

    private String passFailDiff = "";

    private String passFailCnt = "";

    List<MngrAuthVO> mngrAuthList;

}
