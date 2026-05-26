package egovframework.wzwg.sysMngr.siteMngr.siteGroup.service;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@SuppressWarnings("serial")
public class SiteGroupVO implements Serializable {

    /** 순번 **/
    private String rn;
    
    /** 사이트그룹SEQ **/
    private String sitegrpSeq;

    /** 상위그룹SEQ **/
    private String upperGrpSeq;

    /** 차수 **/
    private String odr;

    /** 그룹명 **/
    private String groupNm;

    /** 그룹설명 **/
    private String groupDc;

    /** 사용여부 **/
    private String useAt;

    /** 개수 **/
    private String cnt;

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

}
