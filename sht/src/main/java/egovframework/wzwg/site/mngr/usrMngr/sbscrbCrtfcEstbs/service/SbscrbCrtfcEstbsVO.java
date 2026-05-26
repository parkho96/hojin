package egovframework.wzwg.site.mngr.usrMngr.sbscrbCrtfcEstbs.service;

import java.util.Arrays;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SbscrbCrtfcEstbsVO {
	
	/** 사이트SEQ **/
	private String siteSeq;

	/** 회원유형코드 **/
	private String usrTyCode;

	/** 사이트회원유형SEQ **/
	private String usrtySeq;

	/** 사이트회원유형명 **/
	private String tyNm;

	/** 사이트회원유형설정 **/
	private String tyDc;

	/** 회원인증설정코드 **/
	private String ucrtfcEstbsCode;

	/** 설정여부 **/
	private String estbsAt;

	/** 설정여부 **/
	private String[] estbsAtArr;

	/** 최초등록자ID **/
	private String frstRegisterId;

	/** 최종수정자ID **/
	private String lastUpdusrId;
	
	public String[] getEstbsAtArr() {
		if(estbsAtArr != null) {
			return Arrays.copyOf(estbsAtArr,estbsAtArr.length);
		}else {
			return null;
		}
	}

	public void setEstbsAtArr(String[] estbsAtArr) {
		if (estbsAtArr != null) {
			this.estbsAtArr = Arrays.copyOf(estbsAtArr, estbsAtArr.length);
		} else {
			this.estbsAtArr = null;
		}
	}
}
