package android;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import advertisement.ParameterDTO;
import advertisement.RequestBoardDTO;
import member.MemberDTO;
import member.MemberImpl;
import member.MypageImpl;
import member.SitterImpl;
import member.SitterMemberDTO;
import mutiBoard.DiaryDTO;

@Controller
public class AndroidSitterController {
   
   @Autowired
   SqlSession sqlSession;
   
   // 시터 리스트 보기 페이지 이동 요청명 (메소드)
   @ResponseBody
   @RequestMapping("/android/SitterBoard_list")
   public Map<String, Object> SitterBoardList(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
      //오라클에서 가져온 레코드를 저장하는 lists
      ArrayList<SitterMemberDTO> lists = new ArrayList<>();
      //paramterDTO에 map으로 검색자료를 저장할 map
      Map<String, String> searchmap = new HashMap<String, String>();
      Map<String, Object> map = new HashMap<String, Object>();
      if(parameterDTO.getSearch() != null) {
         if(parameterDTO.getRequest_time() != "" && parameterDTO.getRequest_time() != null)
            searchmap.put("activity_time", parameterDTO.getRequest_time());
         if(parameterDTO.getRegion() != "" && parameterDTO.getRegion() != null) {
            searchmap.put("residence1", parameterDTO.getRegion());
            searchmap.put("residence2", parameterDTO.getRegion());
            searchmap.put("residence3", parameterDTO.getRegion());
         }
         if(parameterDTO.getPay() != "" && parameterDTO.getPay() != null)
            searchmap.put("pay", parameterDTO.getPay());
      }
      
      Iterator<String> itr = searchmap.keySet().iterator();
      
      while(itr.hasNext()) {
         String key = itr.next();
         String value = (String)searchmap.get(key);
         
         System.out.println(key + " : " + value);
      }
      
      
      lists = sqlSession.getMapper(SitterImpl.class).list(parameterDTO);
      for(SitterMemberDTO dto : lists) { 
          String children_name = dto.getName();
          String change_name = children_name.substring(0,1) + "O" + children_name.substring(2);
          System.out.println("변환된시터 : " + change_name);
          dto.setName(change_name);
       }

      map.put("lists", lists);
      return map;
   }
   
   @RequestMapping("/android/SitterBoard_view")
      @ResponseBody
      public Map<String, Object> SitterBoardView(HttpServletRequest req, Model model) {
         
         String id = req.getParameter("id");
         
         Map<String, Object> map = new HashMap<String, Object>();
         SitterMemberDTO dto = sqlSession.getMapper(SitterImpl.class).selectSitter(id);
         
         ArrayList<DiaryDTO> lists = sqlSession.getMapper(MypageImpl.class).CommentList(id);
         
         for(DiaryDTO diary : lists) {
            String temp = diary.getContent().replace("\r\n", "<br/>");
            diary.setContent(temp);
         }
         String children_name = dto.getName();
         String change_name = children_name.substring(0,1) + "O" + children_name.substring(2);
         System.out.println("변환된시터 : " + change_name);
         dto.setName(change_name);
         map.put("dto", dto);
         map.put("lists",lists);
         return map;
      }

   //인터뷰 목록 추가
      @RequestMapping("/android/addList")
      @ResponseBody
      public Map<String, Object> addInterviewList(HttpServletRequest req, HttpSession session){
         
         Map<String, Object> map = new HashMap<String, Object>();
         
         try {
            String user_id = req.getParameter("id");
            String request_time = req.getParameter("activity_time");
            System.out.println("user_id:"+user_id);
            
            
            int ticketCount = sqlSession.getMapper(MypageImpl.class).ticketCount(user_id);
            System.out.println("티켓 몇개?"+ticketCount);
            
            if(0 < ticketCount) {
                  String sitterBoard_id = req.getParameter("sitterBoard_id");
                  
                  System.out.println("id:"+sitterBoard_id);
                  
                  int result = sqlSession.getMapper(MypageImpl.class).parentsApply(user_id, sitterBoard_id, request_time);
                  sqlSession.getMapper(MypageImpl.class).updateCount(user_id);
                  
                  //certificationService.certifiedPhoneNumber(sitdto.getPhone(), pardto.getName(), "interview");
                  
                  System.out.println("result:"+result);
                  map.put("message", "인터뷰 신청이 완료되었습니다");
                  map.put("count", ticketCount-1);
            
            }
            else {
               System.out.println("티켓이 없어요");
               map.put("message", "티켓이 없습니다. 웹사이트에서 이용권 구매후 이용해주세요");
            }
            
         }catch(NumberFormatException e) {
            e.printStackTrace();
         }
         
         catch(Exception e) {
            e.printStackTrace();
         }
         return map;
      }
}