package egovframework.wzwg.sysMngr.siteMngr.menuEstbs.service;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@SuppressWarnings("serial")
public class MenuEstbsVO implements Serializable {


	/** 번호 **/
    private String rn;

    /** 메뉴설정정보SEQ **/
    private String estbsinfoSeq;

    /** 사이트대분류SEQ **/
    private String siteLclasGroup;

    /** 사이트대분류명 **/
    private String siteLclasGroupNm;

    /** 사이트중분류SEQ **/
    private String siteMlsfcGroup;

    /** 사이트중분류명 **/
    private String siteMlsfcGroupNm;

    /** 설정정보명 **/
    private String estbsinfoNm;

    /** 설정정보설명 **/
    private String estbsinfoDc;

    /** 설정여부 **/
    private String estbsAt;

    /** 사용여부 **/
    private String useAt;

    /** 최초등록자 **/
    private String frstRegisterId;

    /** 최초등록시점 **/
    private String frstRegistPnttm;

    /** 최종수정자 **/
    private String lastUpdusrId;

    /** 최종수정시점 **/
    private String lastUpdtPnttm;

    /** 현재페이지 */
    private int pageIndex = 1;

    /** 페이지갯수 */
    private int pageUnit = 10;

    /** 페이지사이즈 */
    private int pageSize = 10;

    /** firstIndex */
    private int firstIndex = 1;

    /** lastIndex */
    private int lastIndex = 1;

    /** recordCountPerPage */
    private int recordCountPerPage = 10;
    
    /** 사이트SEQ**/
    private String siteSeq;
    
    /** 시스템사이트SEQ **/
    private String sysSiteSeq;

}
