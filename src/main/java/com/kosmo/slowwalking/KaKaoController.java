package com.kosmo.slowwalking;



import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import member.MemberDTO;
import member.MemberImpl;

@Controller
public class KaKaoController {
	
	
	 @Autowired
	 public SqlSession sqlSession;
	            
	
    
	 @RequestMapping("/kakao/callback")
	 public String home(@RequestParam(value = "code", required = false) String code, Model model) throws Exception{
	        System.out.println("#########" + code);
	        String access_Token = getAccessToken(code);
	        HashMap<String, Object> userInfo = getUserInfo(access_Token);
	        System.out.println("###access_Token#### : " + access_Token);
	        System.out.println("###userInfo#### : " + userInfo.get("id"));
	        System.out.println("###userInfo#### : " + userInfo.get("email"));
	        
	        
	        String id = userInfo.get("id").toString();
	        int checkId = sqlSession.getMapper(MemberImpl.class).checkId(id);
	         System.out.println(id + "결과 : "+ checkId);

	         MemberDTO memberDTO = new MemberDTO();
	         String view = "";
	         
	         if(checkId==1) {
	        	 model.addAttribute("id", id);
	             model.addAttribute("pass", "slowwalking!@#$");
	             view = "redirect:../member/loginWithoutForm";
	        	 	
	         }
	         else {
	        	 memberDTO.setId(id);
	        	 memberDTO.setEmail(userInfo.get("email").toString());
	        	 view = "Member/KaKaojoin";
	        	 model.addAttribute("memberDTO",memberDTO);
	         }
	     return view;
	 }

	 public String getAccessToken (String authorize_code) {
	        String access_Token = "";
	        String refresh_Token = "";
	        String reqURL = "https://kauth.kakao.com/oauth/token";
	        
	        try {
	            URL url = new URL(reqURL);
	            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	            
	            //    POST 요청을 위해 기본값이 false인 setDoOutput을 true로
	            conn.setRequestMethod("POST");
	            conn.setDoOutput(true);
	            
	            //    POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
	            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
	            StringBuilder sb = new StringBuilder();
	            sb.append("grant_type=authorization_code");
	            sb.append("&client_id=e1bfbd13b698ee8d3ecba1e269ed3918");
	            sb.append("&redirect_uri=http://localhost:8080/slowwalking/kakao/callback");
	            sb.append("&code=" + authorize_code);
	            bw.write(sb.toString());
	            bw.flush();
	            
	            //    결과 코드가 200이라면 성공
	            int responseCode = conn.getResponseCode();
	            System.out.println("responseCode : " + responseCode);
	 
	            //    요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
	            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	            String line = "";
	            String result = "";
	            
	            while ((line = br.readLine()) != null) {
	                result += line;
	            }
	            System.out.println("response body : " + result);
	            
	            //    Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
	            JsonParser parser = new JsonParser();
	            JsonElement element = parser.parse(result);
	            
	            access_Token = element.getAsJsonObject().get("access_token").getAsString();
	            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
	            
	            System.out.println("access_token : " + access_Token);
	            System.out.println("refresh_token : " + refresh_Token);
	            
	            br.close();
	            bw.close();
	        } catch (IOException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        } 
	        
	        return access_Token;
	    }
	  
	  public HashMap<String, Object> getUserInfo (String access_Token) {
		    
		    //    요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
		    HashMap<String, Object> userInfo = new HashMap();
		    String reqURL = "https://kapi.kakao.com/v2/user/me";
		    try {
		        URL url = new URL(reqURL);
		        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		        conn.setRequestMethod("POST");
		        
		        //    요청에 필요한 Header에 포함될 내용
		        conn.setRequestProperty("Authorization", "Bearer " + access_Token);
		        
		        int responseCode = conn.getResponseCode();
		        System.out.println("responseCode : " + responseCode);
		        
		        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		        
		        String line = "";
		        String result = "";
		        
		        while ((line = br.readLine()) != null) {
		            result += line;
		        }
		        System.out.println("response body : " + result);
		        
		        JSONParser jsonParse = new JSONParser();
		         JSONObject jsonObj = (JSONObject) jsonParse.parse(result);
		         JSONObject personObject = (JSONObject) jsonObj.get("kakao_account");
		        String id = jsonObj.get("id").toString();
		        String email = personObject.get("email").toString();
		        		
		        		
		        userInfo.put("email", email);
		        userInfo.put("id", id);
		        
		    } catch (IOException e) {
		        // TODO Auto-generated catch block
		        e.printStackTrace();
		    } catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		    
		    return userInfo;
		}
}
