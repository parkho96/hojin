package egovframework.wzwg.cmm.util;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.module.map.service.ModuleMapVO;

/**
 * 
 * @author 조원권
 * @since 2018.08.27
 * Ajax 호출시 자바스크립트에 json 형태로 데이터를 리턴할때 사용
 * 기본적으로 head body html 구조에 각 해당 값을 넣어서 줄수 있다
 * html에 리턴받을 jsp 파일을 매핑하여 완성된 html을 받아서 사용 가능하다
 *
 */
public class CmmJsonAjaxResponser {

	private Map<String, Object> dataMap;
	private Map<String, String> header;
	private Map<String, Object> body;
	private Map<String, String> html;
	
	private String resultJsp = "wzwg/webModule/jsonResponser";
	
	private CmmJsonAjaxResponser() {} // 임의생성 방어코드
	
	/**
	 * JsonResponser 를 인스턴스화 
	 * @return
	 */
	public static CmmJsonAjaxResponser getInstance(){
		CmmJsonAjaxResponser responser = new CmmJsonAjaxResponser();
		responser.dataMap = new HashMap<String, Object>();
		responser.header = new HashMap<String, String>();
		responser.body = new HashMap<String, Object>();
		responser.html = new HashMap<String, String>();
		return responser;
	}
	
	/**
	 * head에 result 값을 넣어준다
	 * @param code
	 * @return
	 */
	public CmmJsonAjaxResponser setResultCode(String code){
		this.header.put("result", code);
		return this;
	}
	
	/**
	 * head에 msg 값을 넣어준다
	 * @param msg
	 * @return
	 */
	public CmmJsonAjaxResponser setResultMsg(String msg){
		this.header.put("msg", msg);
		return this;
	}
	
	/**
	 * head에 값을 넣어준다
	 * @param msg
	 * @return
	 */
	public CmmJsonAjaxResponser setHeadData(String key, String value){
		this.header.put(key, value);
		return this;
	}
	
	/**
	 * body에 Map<String, Object> 타입의 객체를 넣어준다 
	 * 스프링의 controller 에서 작업한 modelMap을 매핑할 수 있다
	 * @param bodyData
	 * @return
	 */
	public CmmJsonAjaxResponser setBody(Map<String, Object> bodyData){
		this.body.putAll(bodyData); 
		return this;
	}
	
	/**
	 * body에 VO 객체타입을 매핑하여 넣어준다 기본적인 getter 메소드만 호출하여 메소드명과 값을 매핑하여준다
	 * 결과값이 null 인 경우는 포함하지 않는다
	 * @param VO
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public CmmJsonAjaxResponser setBody(Object VO){
		try {
			Class c = VO.getClass();
			
			Method []methods = c.getMethods();
			
			for (int i = 0; i < methods.length; i++) {
				Method m = methods[i];
				String value = null;
				if(m.getName().indexOf("get") >= 0 && m.getName().equals("getClass") == false){
					value = validate(m.invoke(VO, null));
					
					if(value != null){
						String fName = m.getName().substring(3, 4).toLowerCase() + m.getName().substring(4, m.getName().length());
						this.body.put(fName, value);
					}
				}
				
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return this;
	}
	
	/**
	 * body에 값을 넣어준다
	 * @param msg
	 * @return
	 */
	public CmmJsonAjaxResponser setBodyData(String key, String value){
		this.body.put(key, value);
		return this;
	}
	
	/**
	 * body에 값을 넣어준다
	 * @param msg
	 * @return
	 */
	public CmmJsonAjaxResponser setBodyData(String key, Object obj){
		this.body.put(key, obj);
		return this;
	}
	
	/**
	 * html 에 기존에 리턴할 jsp 값을 매핑하여준다
	 * 기존과 사용법을 동일하게 뒤에 확장자를 붙여줄 필요가 없다
	 * @param callName
	 * @param path
	 * @return
	 */
	public CmmJsonAjaxResponser setResultJsp(String callName, String path){
		this.html.put(callName, path);
		return this;
	}
	
	/**
	 * ModelAndView 를 리턴값으로 사용하는 controller에서 사용한다
	 * @return ModelAndView
	 */
	public ModelAndView returnModelAndView(){
		ModelAndView resultModel = new ModelAndView();
		resultModel.setViewName(this.resultJsp);
		
		dataBuild();
		
		resultModel.addObject("ajaxResponse", this.dataMap);
		resultModel.addObject("html", this.html);
		
		return resultModel;
	}
	
	/**
	 * ModelAndView 를 리턴값으로 사용하는 controller에서 사용한다
	 * @return ModelAndView
	 */
	public ModelAndView returnModelAndView(ModelAndView mav){
		mav.setViewName(this.resultJsp);
		
		dataBuild();
		
		mav.addObject("ajaxResponse", this.dataMap);
		mav.addObject("html", this.html);
		
		return mav;
	}
	
	/**
	 * 기존에 jsp로 리턴값을 사용하는 controller에서 사용한다
	 * @param model
	 * @return String
	 */
	public String returnJsp(Model model){
		dataBuild();
		model.addAttribute("ajaxResponse", this.dataMap);
		model.addAttribute("html", this.html);
		
		return this.resultJsp;
	}
	
	/**
	 * 기존에 jsp로 리턴값을 사용하는 controller에서 사용한다
	 * @param model
	 * @return String
	 */
	public String returnJsp(ModelMap model){
		dataBuild();
		model.addAttribute("ajaxResponse", this.dataMap);
		model.addAttribute("html", this.html);
		
		return this.resultJsp;
	}
	
	private void dataBuild(){
		this.dataMap.put("head", this.header);
		this.dataMap.put("body", this.body);
		//this.dataMap.put("html", this.html);
	}
	
	private String validate(Object o){
		String value = null;
		if(o != null){
			value = String.valueOf(o);
		}
		return value;
	}
	
	public static void main(String[] args) {
		ModuleMapVO vo = new ModuleMapVO();
		vo.setCntntsSeq("23482389472");
		vo.setImgPath("akjshdfksdjfl");
		
		CmmJsonAjaxResponser responser = getInstance();
		responser.setBody(vo);
	}
}
