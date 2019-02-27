package hotel.service;

import java.util.ArrayList;

import dao.HotelDAO;
import hotel.dto.Hotel_commentDTO;

public class HotelCommentService {

	HotelDAO dao = new HotelDAO();
	
	public boolean insertComment(Hotel_commentDTO cdto){
		
		boolean isInsertComment = false;
		int result = dao.insertComment(cdto);
		
		System.out.println("insertCommentService 메서드 실행");
		
		if(result > 0){
			isInsertComment = true;
			System.out.println("dao성공");
		}
		return isInsertComment;
	}
	
	public ArrayList<Hotel_commentDTO> getCommentList(int h_c_no){
		
		ArrayList<Hotel_commentDTO> list = dao.getCommentList(h_c_no);
		
		return list;
	}
	
}
