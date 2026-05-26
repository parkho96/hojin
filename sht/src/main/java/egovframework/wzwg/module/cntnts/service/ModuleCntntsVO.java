package egovframework.wzwg.module.cntnts.service;

import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(callSuper = true) // 부모 클래스(ComDefaultVO)의 페이징 필드까지 출력
public class ModuleCntntsVO extends ComDefaultVO {

    private static final long serialVersionUID = 1L;

    /** 컨텐츠 시퀀스 */
    private String cntntsSeq = "";

    /** 템플릿 시퀀스 */
    private String tmplatSeq = "";
    
    /** 템플릿 분류코드 */
    private String tmplatClSeq = "";
    
    /** 컨텐츠명 */
    private String cntntsNm = "";
    
    /** 컨텐츠설명 */
    private String cntntsDc = "";
    
    /** 첨부파일 시퀀스 */
    private String atchFileId = "";
    
    /** 사용여부 */
    private String useAt = "";
    
    /** 유저ID */
    private String userId = "";
    
    /** 사이트 시퀀스 */
    private String siteSeq = "";
    
    /** 모듈명 */
    private String moduleNm = "";
    
    /** 패키지경로 */
    private String pckagePath = "";
    
    /** 페이지경로 */
    private String mngrPageUrl = "";
    
    /** 컨텐츠 내용 시퀀스 */
    private String cntntsCnSeq = "";
    
    /** 컨텐츠 내용 */
    private String cntntsCn = "";
    
    /** 컨텐츠 최초등록 시간 */
    private String frstRegistPnttm = "";
    
    /** 코드시퀀스 */
    private String codeSeq = "";
    
    /** 사이트컨텐츠시퀀스 */
    private String sitecntntsSeq = "";
    
    /** 시스템사이트SEQ */
    private String sysSiteSeq = "";
    
    /** 시스템컨텐츠SEQ */
    private String sysCntntsSeq = "";
    
    /** 컨텐츠버전 */
    private String cntntsVer = "";
    
    /** 메뉴SEQ */
    private String menuSeq = "";
    
    /** 컨텐츠 템플릿 제목 */
    private String tmplatSj = "";

}