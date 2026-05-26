package egovframework.wzwg.sysMngr.usrMngr.usrInfo.service;

import java.io.Serializable;
import java.util.Arrays;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@SuppressWarnings("serial")
public class SysMngrUsrInfoVO implements Serializable {

	/** 사이트SEQ */
	private String siteSeq		= "";

    /** 사이트명 */
	private String siteFullNm   = "";
	
	/** 회원SEQ */
	private String usrSeq		= "";
    
    /** 회원 아이디 */
    private String userId		= "";
    
    /** 회원 비밀번호 */
    private String password		= "";
    
    /** 회원 비밀번호 확인 */
    private String passwordCnfirm="";
    
    /** 회원 이름 */
    private String userNm		= "";
    
    /** 회원 이메일주소 */
    private String emailAdres	= "";

    /** 휴대전화번호 앞자리 **/
    private String hTelnoF;

    /** 휴대전화번호 중간자리 **/
    private String hTelnoC;

    /** 휴대전화번호 끝자리 **/
    private String hTelnoL;

    /** 전화번호 앞자리 **/
    private String mTelnoF;

    /** 전화번호 중간자리 **/
    private String mTelnoC;

    /** 전화번호 끝자리 **/
    private String mTelnoL;
    
    /** 우편번호 **/
    private String zip;

    /** 기본주소 **/
    private String bassAdres;

    /** 상세주소 **/
    private String detailAdres;
	
	/** 회원상태코드 */
	private String usrSttusCode	= "";
	
	/** 회원가입일 */
	private String sbscrbPnttm  = "";
	
	/** 회원유형 시퀀스 */
	private String usrtySeq		= "";
	
	/** 사용여부 */
	private String useAt		= "";
	
	/** 최종수정자ID */
	private String lastUpdusrId = "";
	
	/** 회원그룹 SEQ */
	private String usrGroupSeq	= "";

    /** 회원상태코드명 */
    private String usrSttusCodeNm = "";

    /** 사이트회원상태코드명 */
    private String siteUsrSttusCodeNm = "";
    
    /** 사용자그룹 명 */
    private String usrGroupNm		=	"";
    
    /** 사용자유형코드 */
    private String usrTyCode = "";

    /** 사용자유형코드명 */
    private String usrTyCodeNm = "";

    /** 사용자세부유형명 */
    private String usrDetailTyNm = "";
    
    /** 체크 데이터 사용자SEQ:사이트SEQ **/
    private String[] chk;
    
    private String[] chknon;
	
	/* 전자정부프레임워크 페이징 */
    
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

    /** 검색구분 */
    private String searchCondition = "";
    
    /** 검색keyword */
    private String searchKeyword   = "";
    
    /** 언어 코드 */
    private String langCode;

    
    private String nonUsrGroupSeq;
    /*--------------------------*/
    
    private String crtfctSeCode;
    
    public String[] getChk() {
    	if(chk != null) {
        	return Arrays.copyOf(chk, chk.length);
    	}else {
    		return null;
    	}
    }

    public void setChk(String[] chk) {
		if (chk != null) {
			this.chk = Arrays.copyOf(chk, chk.length);
		} else {
			this.chk = null;
		}
    }

    public String[] getChknon() {
    	if(chknon != null) {
        	return Arrays.copyOf(chknon, chknon.length);
    	}else {
    		return null;
    	}
    }

    public void setChknon(String[] chknon) {
		if (chknon != null) {
			this.chknon = Arrays.copyOf(chknon, chknon.length);
		} else {
			this.chknon = null;
		}
    }

}
