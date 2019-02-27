package hotel.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import dao.HotelDAO;
import hotel.dto.Hotel_commentDTO;

public class getCommentListAction {
	
	public String execute(HttpServletRequest request, HttpServletResponse response ) throws Exception {
		
		
		/* 전체리스트 불러오기.. 배열형태로 전달했으나 되지않아 나중에 시도
		 * int h_no = Integer.parseInt(request.getParameter("h_no"));
		
		HotelDAO dao = new HotelDAO();
		
		ArrayList<Hotel_commentDTO> commentList = dao.getCommentList(h_no);
		JSONArray array = new JSONArray();
		System.out.println("값확인");
		JSONObject obj = new JSONObject();
		JSONObject data = new JSONObject();
		for(int i = 0; i< commentList.size(); i++){
			
			//각 값들을 담아줄 JSONObject 객체
			
			obj.put("bestcount", commentList.get(i).getBestcount());
			obj.put("content", commentList.get(i).getContent());
			obj.put("h_cno", commentList.get(i).getH_c_no());
			obj.put("h_no", commentList.get(i).getH_no());
			obj.put("regdate", commentList.get(i).getRegdate());
			obj.put("subject", commentList.get(i).getSubject());
			obj.put("user_no", commentList.get(i).getUser_no());
			array.add(obj);
		}
			
		
		//JSONType으로 전달시켜줄 JSON객체
		
		//array객체 자체를 JSONObject에 담는다 그리고 JSON타입으로 String변환후 보낸다
		data.put("comment", array.toJSONString());
		return data.toJSONString();*/
		
		int h_cno = Integer.parseInt(request.getParameter("h_cno"));
		HotelDAO dao = new HotelDAO();
		Hotel_commentDTO dto = dao.getComment(h_cno);
		
		JSONObject obj = new JSONObject();
		JSONObject data = new JSONObject();
		/*제목 : ${comment.subject } <br>
    	내용 : ${comment.content } <br>
    	작성날짜 : ${comment.regdate } <br>
    	추천수 : ${comment.bestcount }*/
		obj.put("subject", dto.getSubject());
		obj.put("content", dto.getContent());
		obj.put("regdate", dto.getRegdate()+"");
		obj.put("bestcount", dto.getBestcount());
		
		data.put("key", obj);
		System.out.println(obj.toJSONString());
		System.out.println(data.toJSONString());
		return obj.toJSONString();
	}
}
