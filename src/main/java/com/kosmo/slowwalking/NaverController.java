package com.kosmo.slowwalking;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import member.MemberDTO;
import member.MemberImpl;


@Controller
public class NaverController {

	@Autowired
	SqlSession sqlSession;
	
	@RequestMapping("/naver/callback")
	public String callback(HttpServletRequest req, Model model) {
		String clientId = "MMNYqKIa7wxHjRIOOA6z";//애플리케이션 클라이언트 아이디값";
		String clientSecret = "FgdQerMvdz";//애플리케이션 클라이언트 시크릿값";
		String code = req.getParameter("code");
		String state = req.getParameter("state");
		String redirectURI = null;
		try {
			redirectURI = URLEncoder.encode("http://localhost:8080/slowwalking/naver/callback", "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String apiURL;
		apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
		apiURL += "client_id=" + clientId;
		apiURL += "&client_secret=" + clientSecret;
		apiURL += "&redirect_uri=" + redirectURI;
		apiURL += "&code=" + code;
		apiURL += "&state=" + state;
		String access_token = "";
		String refresh_token = "";
		System.out.println("apiURL=" + apiURL);
		try {
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			int responseCode = con.getResponseCode();
			BufferedReader br;
			System.out.println("responseCode=" + responseCode);
			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer res = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();
			if (responseCode == 200) {
				String responseBody = res.toString();
				System.out.println(responseBody);
				String token="";
				try {
					JSONParser jsonParse = new JSONParser();
					JSONObject jsonObj = (JSONObject) jsonParse.parse(responseBody);
					token = (String) jsonObj.get("access_token");
					System.out.println(token); 
					model.addAttribute("token", token);
				}
				catch (ParseException e) {
					e.printStackTrace();
				}
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		
		return "redirect:../naver/join";
	}
	
	@RequestMapping("/naver/join")
	public String Navercallback(HttpServletRequest req, Model model) {
		String token = req.getParameter("token");
		
		String header = "Bearer " + token; // Bearer 다음에 공백 추가

		String apiURL = "https://openapi.naver.com/v1/nid/me";

		Map<String, String> requestHeaders = new HashMap();
		requestHeaders.put("Authorization", header);
		String responseBody = get(apiURL, requestHeaders);
		MemberDTO dto = new MemberDTO();
		System.out.println(responseBody);
		String view = "";
		try {
			JSONParser jsonParse = new JSONParser();
			JSONObject jsonObj = (JSONObject) jsonParse.parse(responseBody);
			JSONObject personObject = (JSONObject) jsonObj.get("response");
			String id = personObject.get("id").toString();
			int checkId = sqlSession.getMapper(MemberImpl.class).checkId(id);
			System.out.println(id + "결과 : "+ checkId);
			
			System.out.println(personObject.get("id")); 
			System.out.println(personObject.get("email")); 
			System.out.println(personObject.get("mobile").toString().replace("-", "")); 
			System.out.println(personObject.get("gender").toString().equals("M")?"남":"여"); 
			System.out.println(personObject.get("name")); 
			System.out.println(personObject.get("birthday")); 
			dto.setId(personObject.get("id").toString());
			dto.setEmail(personObject.get("email").toString());
			dto.setPhone(personObject.get("mobile").toString().replace("-", ""));
			dto.setGender(personObject.get("gender").toString().equals("M")?"남":"여");
			dto.setName(personObject.get("name").toString());
			dto.setPw("slowwalking!@#$");
			if(checkId==1) {
				model.addAttribute("id", id);
				model.addAttribute("pass", "slowwalking!@#$");
				view = "redirect:../member/loginWithoutForm";
			}
			else {
				view = "Member/NaverJoin";
			}
		}
		catch (ParseException e) {
			e.printStackTrace();
		}
		model.addAttribute("dto", dto);
		return view;
	}
	
	
	private static String get(String apiUrl, Map<String, String> requestHeaders) {
		HttpURLConnection con = connect(apiUrl);
		try {
			con.setRequestMethod("GET");
			for (Map.Entry<String, String> header : requestHeaders.entrySet()) {
				con.setRequestProperty(header.getKey(), header.getValue());
			}

			int responseCode = con.getResponseCode();
			if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
				return readBody(con.getInputStream());
			} else { // 에러 발생
				return readBody(con.getErrorStream());
			}
		} catch (IOException e) {
			throw new RuntimeException("API 요청과 응답 실패", e);
		} finally {
			con.disconnect();
		}
	}

	private static HttpURLConnection connect(String apiUrl) {
		try {
			URL url = new URL(apiUrl);
			return (HttpURLConnection) url.openConnection();
		} catch (MalformedURLException e) {
			throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
		} catch (IOException e) {
			throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
		}
	}

	private static String readBody(InputStream body) {
		InputStreamReader streamReader = new InputStreamReader(body);

		try (BufferedReader lineReader = new BufferedReader(streamReader)) {
			StringBuilder responseBody = new StringBuilder();

			String line;
			while ((line = lineReader.readLine()) != null) {
				responseBody.append(line);
			}
 
			return responseBody.toString();
		} catch (IOException e) {
			throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
		}
	}
	
}
