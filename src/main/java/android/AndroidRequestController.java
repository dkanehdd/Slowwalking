package android;

import java.io.File;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import advertisement.RequestBoardDTO;
import advertisement.RequestBoardImpl;
import member.MemberDTO;
import member.MemberImpl;
import member.MypageImpl;
import mutiBoard.DiaryDTO;

@Controller
public class AndroidRequestController {

   @Autowired
   SqlSession sqlSession;
   
   @RequestMapping("/android/requestBoard_list")
   @ResponseBody
   public ArrayList<RequestBoardDTO> ReqeustBoardList(HttpServletRequest req) {
      
      ArrayList<RequestBoardDTO> lists = new ArrayList<RequestBoardDTO>();
      
         
      lists = sqlSession.getMapper(RequestBoardImpl.class).requestBoard();
         
      for(RequestBoardDTO dto : lists) { 
         String children_name = dto.getChildren_name();
         String change_name = children_name.substring(0,1) + 0 + children_name.substring(2);
         System.out.println("변환된 아이의 이름 : " + change_name);
         dto.setChildren_name(change_name);
      }
      

      return lists;
   }
   
   
// 구인의뢰서 상세 보기 페이지 이동 요청명(메소드)
   @RequestMapping("/android/requestBoard_view")
   @ResponseBody
   public Map<String, Object> AndroidReqeustBoardView(HttpServletRequest req) {

      String user_id = "";
      
        Map<String, Object> map = new HashMap<String, Object>();

      int index = Integer.parseInt(req.getParameter("idx"));

      RequestBoardDTO requestBoarddto = sqlSession.getMapper(RequestBoardImpl.class).requestBoardView(index);
      
      map.put("dto", requestBoarddto);
      //시터인지 부모회원인지 확인하는 쿼리문

      return map;
   }
   
   //인터뷰 목록 추가
   @RequestMapping("/android/addRequestList")
   @ResponseBody
   public Map<String, Object> addRequestList(HttpServletRequest req, HttpSession session){
      
      Map<String, Object> map = new HashMap<String, Object>();
      
      try {
         String user_id = req.getParameter("id");
         String request_time = req.getParameter("activity_time");
         System.out.println("user_id:"+user_id);
         
         
         int ticketCount = sqlSession.getMapper(MypageImpl.class).ticketCount(user_id);
         System.out.println("티켓 몇개?"+ticketCount);
         
         if(0 < ticketCount) {
            int request_idx = Integer.parseInt(req.getParameter("idx"));
            String parentsBoard_id = req.getParameter("parents_id");
            
            System.out.println("idx:"+request_idx);
            System.out.println("id:"+parentsBoard_id);
            
            int result = sqlSession.getMapper(MypageImpl.class).sitterApply(request_idx, parentsBoard_id, user_id, request_time);
            sqlSession.getMapper(MypageImpl.class).updateCount(user_id);
            
            //certificationService.certifiedPhoneNumber(pardto.getPhone(), sitdto.getName(), "interview");
            System.out.println("result:"+result);
            
            map.put("message", "인터뷰 신청이 완료 되었습니다");
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