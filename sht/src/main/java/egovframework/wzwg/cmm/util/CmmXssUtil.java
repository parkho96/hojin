package egovframework.wzwg.cmm.util;

public class CmmXssUtil {

	/**
     * XSS 방지 처리.
     * 
     * @param data
     * @return
     */
    public static String unscript(String data) {
        if (data == null || data.trim().equals("")) {
            return "";
        }
        
        String ret = data;

        ret = ret.replaceAll("<(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt; script");
        ret = ret.replaceAll("</(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt; /script");
        
    	ret = ret.replaceAll("<(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt; object");
    	ret = ret.replaceAll("</(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt; /object");
    	
    	ret = ret.replaceAll("<(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt; applet");
    	ret = ret.replaceAll("</(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt; /applet");
    	
    	ret = ret.replaceAll("<(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt; embed");
    	ret = ret.replaceAll("</(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt; embed");
    	
    	ret = ret.replaceAll("<(F|f)(O|o)(R|r)(M|m)", "&lt; form");
    	ret = ret.replaceAll("</(F|f)(O|o)(R|r)(M|m)", "&lt; form");
    	
    	//ret = ret.replaceAll("(<[i|I][m|M][g|G])(.*?) ([o|O][N|n]|>)([^>]*?>)", "$1$2$3 $4");
		//ret = ret.replaceAll("(<A\\s* \\w+)(.*?) ([o|O][N|n]|>)([^>]*?>)", "$1$2$3 $4");
		//ret = ret.replaceAll("(<a\\s* \\w+)(.*?) ([o|O][N|n]|>)([^>]*?>)", "$1$2$3 $4");
    	ret = ret.replaceAll("(<\\w+)(.*?) ([o|O][N|n]|>)([^>]*?>)", "$1$2 $3 $4");


        ret = ret.replaceAll("<(I|i)(F|f)(R|r)(A|a)(M|m)(E|e)", "&lt; iframe");
        ret = ret.replaceAll("</(I|i)(F|f)(R|r)(A|a)(M|m)(E|e)", "&lt; /iframe");
        
        return ret;
    }
    
}