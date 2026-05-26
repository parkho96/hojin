package egovframework.wzwg.module.ntt.schdul.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.ntt.schdul.service.ModuleNttSchdulDataManageService;
import egovframework.wzwg.module.ntt.schdul.service.ModuleNttSchdulDataManageVO;

@Service("ModuleNttSchdulDataManageService")
public class ModuleNttSchdulDataManageServiceImpl extends EgovAbstractServiceImpl implements ModuleNttSchdulDataManageService {
	
	@Resource(name="ModuleNttSchdulDataManageDAO")
    protected ModuleNttSchdulDataManageDAO nttSchdulDataManageDAO;
	
	/**
	 * ㅁ 일정 데이터  목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttSchdulDataManageVO> selectNttSchdulDataList(ModuleNttSchdulDataManageVO paramVO) throws Exception {
		return nttSchdulDataManageDAO.selectNttSchdulDataList(paramVO);
	}
	
	/**
	 * ㅁ 일정 데이터 기본정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleNttSchdulDataManageVO selectNttSchdulDataDetail(ModuleNttSchdulDataManageVO paramVO) throws Exception {
		return nttSchdulDataManageDAO.selectNttSchdulDataDetail(paramVO);
	}

	/**
     * ㅁ 일정 데이터 기본정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registNttSchdulData(ModuleNttSchdulDataManageVO paramVO) throws Exception {
    	
    	//게시물 아이디를 취득한다.
    	String schdetaSeq = nttSchdulDataManageDAO.selectNttSchdulDataNextSeq();
    	paramVO.setSchdetaSeq(schdetaSeq);
    	
    	if("".equals(StringUtils.defaultString(paramVO.getOthbcAt()))) {
    		paramVO.setOthbcAt("N");
    	}
    	if("".equals(StringUtils.defaultString(paramVO.getUseAt()))) {
    		paramVO.setUseAt("Y");
    	}
    	
    	//일정등록
    	int result = nttSchdulDataManageDAO.registNttSchdulData(paramVO);
    	
    	//일정 부가정보 등록
    	if(result > 0) {
    		nttSchdulDataManageDAO.registNttSchdulAdiData(paramVO);
    	}
    	return result;
    }
    
	
	/**
     * ㅁ 일정 데이터 기본정보 수정(일반, 급식)
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttSchdulData(ModuleNttSchdulDataManageVO paramVO) throws Exception {
		
		if("".equals(StringUtils.defaultString(paramVO.getOthbcAt()))) {
    		paramVO.setOthbcAt("N");
    	}
    	if("".equals(StringUtils.defaultString(paramVO.getUseAt()))) {
    		paramVO.setUseAt("Y");
    	}
		
		//일정수정
    	int result = nttSchdulDataManageDAO.modifyNttSchdulData(paramVO);
    	
    	//일정 부가정보 수정
    	if(result > 0) {
    		nttSchdulDataManageDAO.modifyNttSchdulAdiData(paramVO);
    	}
    	
    	return result;
	}
	
    
    /**
     * ㅁ 일정 데이터 기본정보 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int deleteNttSchdulData(ModuleNttSchdulDataManageVO paramVO) throws Exception {
    	//일정 부가정보 삭제
    	int result = nttSchdulDataManageDAO.deleteNttSchdulData(paramVO);
    	
//	    if(result > 0) {
//	    	nttSchdulDataManageDAO.deleteNttSchdulAdiData(paramVO);
//	    }
    	return result;
    }
    
    /**
     * ㅁ 달력정보 셋팅함
     * @param paramVO
     * @return
     * @throws Exception
     */
    public Map<String, Object> createCalendarData (ModuleNttSchdulDataManageVO paramVO) throws Exception {
    	
    	//최종 결과
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	//스케줄 정보목록
    	List<ModuleNttSchdulDataManageVO>  schdulList = selectNttSchdulDataList(paramVO);
    	
    	int year = Integer.parseInt(paramVO.getSearchYear());
		int month = Integer.parseInt(paramVO.getSearchMonth());
		
		String strYear = "";
		String strMonth = "";
		String strDate = "";
		
		int searchDate = 0;
    	
    	//현재달
		Calendar cal = Calendar.getInstance();
		
		cal.set(year, month-1, 1);
		
		//지난달
		Calendar cal2 = Calendar.getInstance();
		cal2.set(year, month-1, 1);
		
		//지난달로 셋팅
		cal2.set(Calendar.MONTH, cal.get(Calendar.MONTH)-1);
		
		Map<Integer, Integer> calendarMap = new HashMap<Integer, Integer>();
		
		//리턴될 달력정보 리스트
		List<Map<Integer, Integer>> calendarList = new ArrayList<Map<Integer,Integer>>();
		//리턴될 일정 정보 리스트
		List<Map<Integer, Object>> resultSchdulList = new ArrayList<Map<Integer,Object>>();
		
		Map<Integer, Object> shcdulResultMap = new HashMap<Integer, Object>();
		
		//현재달 1일이 일요일이 아니면 지난달 넘어오는 날짜 셋팅
		if(cal.get(Calendar.DAY_OF_WEEK) != 1) {
			
			//조회하는 달의 첫번째 요일까지 루프를 돌린다.
			for (int i = 1; i < cal.get(Calendar.DAY_OF_WEEK); i++) {
				
				int position = i-1;
				int date = (cal2.getActualMaximum(Calendar.DATE) - (cal.get(Calendar.DAY_OF_WEEK)-i) + 1);
				int beforeMonth = (cal2.get(Calendar.MONTH)+1);
				//달력정보 저장
				calendarMap.put(position, date);
				
				
				//해당 날짜에 일정이 있는지 확인
				strYear = Integer.toString(cal2.get(Calendar.YEAR));
				strMonth = beforeMonth>9? beforeMonth+"":"0"+beforeMonth;
				strDate = date>9? date+"":"0"+date;
				
				searchDate = Integer.parseInt(strYear + strMonth + strDate);
				
				List<Map<String, String>> dataList = new ArrayList<Map<String, String>>();
				
				//스케줄 정보를 검색함
				for (int j = 0; j < schdulList.size(); j++) {
					
					ModuleNttSchdulDataManageVO schdulVO = schdulList.get(j);
					
					
					if(Integer.parseInt(schdulVO.getBgnde()) <= searchDate && Integer.parseInt(schdulVO.getEndde()) >= searchDate) {
						Map<String, String> data = new HashMap<String, String>();
						
						data.put("schdetaSeq",schdulVO.getSchdetaSeq());
						data.put("schdulNm",schdulVO.getSchdulNm());
						data.put("ctgryColorCode",schdulVO.getCtgryColorCode());
						
						dataList.add(data);
					}
				}
				
				shcdulResultMap.put(cal.get(Calendar.DAY_OF_WEEK)-1, dataList);
			}
		}
		
		
		int thisMonth = cal.get(Calendar.MONTH);
		
		
		//현재달 달력 정보 셋팅
		while (thisMonth == cal.get(Calendar.MONTH)) {
			for (int j = cal.get(Calendar.DAY_OF_WEEK); j < 8; j++) {
				//달력정보를 저장함
				calendarMap.put(j-1, cal.get(Calendar.DATE));
				
				/** 스케줄정보 시작 **/
				
				//해당 날짜에 일정이 있는지 확인
				strYear = Integer.toString(cal.get(Calendar.YEAR));
				strMonth = month>9? month+"":"0"+month;
				strDate = cal.get(Calendar.DATE)>9? cal.get(Calendar.DATE)+"":"0"+cal.get(Calendar.DATE);
				
				searchDate = Integer.parseInt(strYear + strMonth + strDate);
				
				
				List<Map<String, String>> dataList = new ArrayList<Map<String, String>>();

				//스케줄 정보를 검색함
				for (int k = 0; k < schdulList.size(); k++) {
					
					
					ModuleNttSchdulDataManageVO schdulVO = schdulList.get(k);
					
					if(Integer.parseInt(schdulVO.getBgnde()) <= searchDate && Integer.parseInt(schdulVO.getEndde()) >= searchDate) {
						
						Map<String, String> data = new HashMap<String, String>();
						
						data.put("schdetaSeq",schdulVO.getSchdetaSeq());
						data.put("schdulNm",schdulVO.getSchdulNm());
						data.put("ctgryColorCode",schdulVO.getCtgryColorCode());
						
						dataList.add(data);
					}
				}
				
				shcdulResultMap.put(cal.get(Calendar.DAY_OF_WEEK)-1, dataList);
				
				
				/** 스케줄정보 종료 **/
				
				//일자 올림
				cal.set(Calendar.DATE, cal.get(Calendar.DATE)+1);
			}
			
			if(shcdulResultMap.size() == 0) {
				shcdulResultMap.put(cal.get(Calendar.DAY_OF_WEEK)-1, null);
			}
			
			//스케줄 정보 셋팅
			Map<Integer, Object> shcdulResultMapTmp = new HashMap<Integer, Object>();
			shcdulResultMapTmp.putAll(shcdulResultMap);
			resultSchdulList.add(shcdulResultMapTmp);
			
			shcdulResultMap.clear();
			
			
			//달력정보 셋팅
			Map<Integer, Integer> calendarMapTmp = new HashMap<Integer, Integer>();
			calendarMapTmp.putAll(calendarMap);
			calendarList.add(calendarMapTmp);
			
			calendarMap.clear();
		}
		
		resultMap.put("calendarList", calendarList);
		resultMap.put("resultSchdulList", resultSchdulList);
		
		return resultMap;
    }
	
}
