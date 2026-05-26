package egovframework.wzwg.module.ntt.module.tag.service;

import java.util.Arrays;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModuleNttTagVO {

	/* 사이트SEQ */
	private String siteSeq;
	
	/* 사용자SEQ */
	private String usrSeq;
	
	/* 게시물SEQ */
	private String nttSeq;
	
	/* 태그SEQ */
	private String tagSeq;
	
	/* 태그명 */
	private String tagNm;
	
	/* 태그배열 */
	private String[] tagArr;
	
	/* 임시 태그배열 */
	private String[] tmpTagArr;
	
	/* 사용여부 */
	private String useAt;
	
	/* 최초등록자ID */
	private String frstRegisterId;
	
	/* 최초등록시점 */
	private String frstRegistPnttm;

	public String[] getTagArr() {
		if(tagArr != null) {
			return Arrays.copyOf(tagArr,tagArr.length);
		}else {
			return null;
		}
	}

	public void setTagArr(String[] tagArr) {
		if (tagArr != null) {
			this.tagArr = Arrays.copyOf(tagArr, tagArr.length);
		} else {
			this.tagArr = null;
		}
	}

	public String[] getTmpTagArr() {
		if(tmpTagArr != null) {
			return Arrays.copyOf(tmpTagArr,tmpTagArr.length);
		}else {
			return null;
		}
	}

	public void setTmpTagArr(String[] tmpTagArr) {
		if (tmpTagArr != null) {
			this.tmpTagArr = Arrays.copyOf(tmpTagArr, tmpTagArr.length);
		} else {
			this.tmpTagArr = null;
		}
	}

}
