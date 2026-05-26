package egovframework.wzwg.cmm.mber.myPage.service;

import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@SuppressWarnings("serial")
public class CmmMyPageVO extends CmmLoginVO {

    private String stplatSeq;
    private String stplatdetailSeq;
    private String stplatNm;
    private String stplatDc;
    private String stplatDetailNm;
    private String stplatDetailDc;
    private String stplatDetailCn;
    private String essntlAgreAt;
    private String agreRegistPnttm;
    private String stplatRegistPnttm;
    private String stpdetlRegistPnttm;
    private String stpestbsRegistPnttm;
    private int pageIndex = 1;
    private int pageUnit = 10;
    private int pageSize = 10;
    private int firstIndex = 1;
    private int lastIndex = 1;
    private int recordCountPerPage = 10;
    
}
