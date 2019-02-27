package hotel.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import dao.HotelDAO;
import hotel.dto.Hotel_commentDTO;

public class insertcommentAction {
	
public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
	
		request.setCharacterEncoding("utf-8");
		//JSON객체 새로 만들기
		System.out.println("현재객체로 들어왔습니다.");
		//클라이언트에서 넘겨준 commentJson을 가져옴 
		String jsonObject = (request.getParameter("commentJson"));
		//Json형태의 string을 JSon 객체로 만든다
		JSONObject obj = (JSONObject)JSONValue.parse(jsonObject);
		// JSON객체에서 키값을 꺼내 댓글을 넣는다
		Hotel_commentDTO dto = new Hotel_commentDTO();
		
		dto.setH_no(Integer.parseInt((obj.get("h_no").toString())));
		dto.setBestcount(Integer.parseInt((obj.get("bestcount").toString())));
		dto.setContent((String)obj.get("content"));
		dto.setRegdate(null);
		dto.setSubject((String)obj.get("subject"));
		dto.setUser_no(Integer.parseInt((obj.get("user_no").toString())));
		
		HotelDAO dao = new HotelDAO();
		int resultdao = dao.insertComment(dto);
		
		JSONObject h_cno = new JSONObject();
		h_cno.put("h_cno", resultdao);
		
		return h_cno.toJSONString();

	} 
}
