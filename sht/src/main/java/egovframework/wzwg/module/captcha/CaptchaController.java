package egovframework.wzwg.module.captcha;

import java.util.HashMap;
import java.util.IllegalFormatException;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/*import nl.captcha.Captcha;
import nl.captcha.audio.AudioCaptcha;
import nl.captcha.backgrounds.GradiatedBackgroundProducer;
import nl.captcha.noise.StraightLineNoiseProducer;
import nl.captcha.servlet.CaptchaServletUtil;
import nl.captcha.text.producer.NumbersAnswerProducer;*/

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.apiclub.captcha.Captcha;
import cn.apiclub.captcha.audio.AudioCaptcha;
import cn.apiclub.captcha.backgrounds.GradiatedBackgroundProducer;
import cn.apiclub.captcha.noise.StraightLineNoiseProducer;
import cn.apiclub.captcha.servlet.CaptchaServletUtil;
import cn.apiclub.captcha.text.producer.NumbersAnswerProducer;

@Controller
public class CaptchaController {
	private final String CAPTCHA_SESSION_KEY = "wzwg_captcha_alskfl@!#";

	@RequestMapping(value= {"/webutil/captcha/selectCaptchaImageAjax.do","/{siteKey}/webutil/captcha/selectCaptchaImageAjax.do"})
	public void selectCaptchaImage(HttpServletRequest request, HttpServletResponse response, String width, String height) throws Exception{
		
		int w = getIntConvert(width, 148);
		int h = getIntConvert(height, 48);
		Captcha captcha = new Captcha.Builder(w, h)
								.addText(new NumbersAnswerProducer(5))
								.addNoise(new StraightLineNoiseProducer()).addNoise()
								.addBackground(new GradiatedBackgroundProducer())
								.build();
		
		CaptchaServletUtil.writeImage(response, captcha.getImage());
		String answer = captcha.getAnswer();
		//System.out.println(answer);
		//request.getSession().setAttribute(CAPTCHA_SESSION_KEY, answer);
		request.getSession().setAttribute(CAPTCHA_SESSION_KEY, captcha);
	}
	
	@RequestMapping(value= {"/webutil/captcha/selectCaptchaAnswerAjax.do","/{siteKey}/webutil/captcha/selectCaptchaAnswerAjax.do"})
	public String selectCaptchaAnswer(HttpServletRequest request, HttpServletResponse response, Model model, String answer) throws Exception{
		
		//String sessionValue = String.valueOf(request.getSession().getAttribute(CAPTCHA_SESSION_KEY));

		Map<String, Object> ajaxResponse = new HashMap<String, Object>();
		Captcha captcha = (Captcha)request.getSession().getAttribute(CAPTCHA_SESSION_KEY);
		String sessionValue = "";
		if (captcha != null) {
			sessionValue = captcha.getAnswer();
		}
		
		if(sessionValue.equals(answer)){
			ajaxResponse.put("result", "success");
		}else{
			ajaxResponse.put("result", "fail");
		}
		
		model.addAttribute("ajaxResponse", ajaxResponse);
		return "wzwg/webModule/json";
		
	}
	
	/* CaptCha Audio 생성 */ 
	@RequestMapping(value= {"/webutil/captcha/selectCaptchaAudioAjax.do","/{siteKey}/webutil/captcha/selectCaptchaAudioAjax.do"})
	@ResponseBody
	public void selectCaptchaAudio(HttpServletRequest req, HttpServletResponse res, String answer) throws Exception {
		HttpSession session = req.getSession();
		Captcha captcha = (Captcha) session.getAttribute(CAPTCHA_SESSION_KEY);
		String getAnswer = answer;
		
		if ((getAnswer == null || "".equals(getAnswer)) && captcha != null) {
			getAnswer = captcha.getAnswer();
		}
		if (getAnswer == null) {
	        res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Captcha session expired.");
	        return; 
	    }
		
//		AudioCaptcha audiocaptcha = new AudioCaptcha.Builder().addAnswer(new SetTextProducer(getAnswer)).addNoise()
//				/* 잡음 추가 */ .build();
		AudioCaptcha audiocaptcha = new AudioCaptcha.Builder().addAnswer(new SetTextProducer(getAnswer))
				/* 잡음 추가 */ .build();
		CaptchaServletUtil.writeAudio(res, audiocaptcha.getChallenge());
	}

	
	
	private int getIntConvert(String src, int i) {
		
		if (src == null) {
	        return i;
	    }
		
		String trimmed = src.trim();
		int returnNum = 0;
		
		if (trimmed.isEmpty()) {
	        return i;
	    }
		
		if (trimmed.length() > 11) {          // 11자 제한으로 DoS 방지	        
	        return i;
	    }		
		
		try {
	        return Integer.parseInt(trimmed);
	    } catch (NumberFormatException e) {   // CWE-209: 민감정보 노출 방지 - 입력값 자체는 로깅하지 않음	        
	    	returnNum = i;
	    }		
		
		return returnNum;
						
//		try {
//			return Integer.parseInt(String.valueOf(src));
//		}catch(NullPointerException e){
//        	return i;
//    	}catch(NumberFormatException e){
//    		return i;
//    	}catch(IllegalFormatException e){
//    		return i;
//    	}catch(ArrayIndexOutOfBoundsException e){
//    		return i;
//    	}  
	}
}
