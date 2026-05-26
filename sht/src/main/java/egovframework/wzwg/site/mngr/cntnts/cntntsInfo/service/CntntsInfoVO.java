package egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service;

import java.util.Arrays;

import egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service.SysModuleInfoVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CntntsInfoVO extends SysModuleInfoVO {

	private static final long serialVersionUID = 1L;

	/*사이트SEQ*/
	private String siteSeq;
	
	/*사이트컨텐츠SEQ*/
	private String sitecntntsSeq;

	/*컨텐츠SEQ*/
	private String cntntsSeq;

	/*컨텐츠명*/
	private String cntntsNm;

	/*컨텐츠내용*/
	private String cntntsDc;

	/*사용여부*/
	private String useAt;

	/*최초등록자ID*/
	private String frstRegisterId;

	/*최초등록시점*/
	private String frstRegistPnttm;

	/*최종수정자ID*/
	private String lastUpdusrId;

	/*최종수정시점*/
	private String lastUpdtPnttm;

	/*모듈by컨텐츠no*/
	private String childNo;
    
	/*삭제할 데이터 배열*/
    private String[] chkDelArr;

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
    
    private String searchCntntsSeq;
    
    // 정렬 - 추가

    // 페이지유형 정렬 기준
    private String moduleNmOrdr;
    
    // 컨텐츠명 정렬 기준
    private String cntntsNmOrdr;
    
    // 생성일 정렬 기준
    private String frstRegistPnttmOrdr;
    
    // 모듈 영문명
    private String moduleNmEng;
    
    
    /* 컨텐츠 대시보드용 */
    private String moduleKey;
    private String moduleCnt;
	
	public String[] getChkDelArr() {
		if(chkDelArr != null) {
			return Arrays.copyOf(chkDelArr,chkDelArr.length);
		}else {
			return null;
		}
	}

	public void setChkDelArr(String[] chkDelArr) {
		if (chkDelArr != null) {
			this.chkDelArr = Arrays.copyOf(chkDelArr, chkDelArr.length);
		} else {
			this.chkDelArr = null;
		}
	}

}
