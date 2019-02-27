package hotel.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import hotel.dto.RoomDTO;
import hotel.dto.Room_imgDTO;
import hotel.service.BringRoomSubImgService;


//ajax이므로 action 인터페이스를 상속할 이유가 없다.
public class BringRoomSubImgAction  {	

	// 서브이미지를 들고옴 (ajax)
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer values = new StringBuffer("");
		int h_rno = Integer.parseInt(request.getParameter("h_rno"));
		System.out.println(h_rno);
		BringRoomSubImgService service = new BringRoomSubImgService();
		Room_imgDTO subimg = service.bringSubImg(h_rno);
		//해당 방번호에 맞는 방정보도 들고옴
		RoomDTO roomDto = service.bringRoomInfo(h_rno);
		System.out.println("서브이미지 들고오기 ajax");
		if(subimg == null){
			values.append("{\"imgname\":\"" +"왜안될까?" +"\"}");
		}else{
		values.append("{\"imgname\":\"" +subimg.getImgname() +"\",");
		values.append("\"imgpath\":\"" +subimg.getImgpath() +"\",");
		// 호텔번호, 호텔방번호, 메인이미지 경로, 이름은 필요없으므로 json으로 보내지않음
		values.append("\"h_no\":\""+roomDto.getH_no()+"\",");
		values.append("\"h_rno\":\""+roomDto.getH_rno()+"\",");
		values.append("\"bed\":\""+roomDto.getBed()+"\",");
		values.append("\"bathroom\":\""+roomDto.getBathroom()+"\",");
		values.append("\"roomsize\":\""+roomDto.getRoomsize()+"\",");
		values.append("\"weekprice\":\""+roomDto.getWeekend_price()+"\",");
		values.append("\"weekend_price\":\""+roomDto.getWeekend_price()+"\"}");
		}
		
		
		System.out.println(values);
		
 		
		return values.toString();
		
	}

}
