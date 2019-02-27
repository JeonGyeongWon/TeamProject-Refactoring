package hotel.service;

import java.util.ArrayList;

import dao.HotelDAO;
import dao.UserManagementDAO;
import dto.UserManagementDTO;
import hotel.dto.FacilitiesDTO;
import hotel.dto.HotelDTO;
import hotel.dto.Hotel_commentDTO;
import hotel.dto.RoomDTO;
import hotel.dto.Room_imgDTO;
import hotel.dto.UsersDTO;

public class HotelDetailService {
	
	HotelDAO dao = new HotelDAO();
	
	//한 호텔정보를 가져옴
	public HotelDTO getBringoneHotelInfo(int h_no){
		HotelDTO dto = dao.oneHotelInfo(h_no);
		return dto;
	}
	
	//호텔편의시설을 가져옴
	public FacilitiesDTO getBringAllFacilities(int h_no){
		FacilitiesDTO dto = dao.oneselectedFacilities(h_no);
		return dto;
	}
	
	//호텔 룸에 대한 정보를 가져옴 -> 내부적으로 room_img도 들고와야함!!
	public ArrayList<RoomDTO> getBringAllRoomInfo(int h_no){
		ArrayList<RoomDTO> list = dao.allselectedRoom(h_no);
		
		return list;
	}

	//호텔 주인?에 정보를 들고옴
	public UserManagementDTO bringHotelManageInfo(int user_no) {
	
		UserManagementDTO dto = dao.bringHotelManageInfo(user_no);
		
		return dto;
	}
	// reservationAction에서 사용될 방정보 1개의 서브이미지를 들고오는 메서드 
	public Room_imgDTO getBringRoom_imgInfo(int h_rno){
		
		Room_imgDTO r_imgdto = dao.bringRoom_imgDto(h_rno); 
		return r_imgdto;
	}
	
	// reservationAction에서 사용될 방정보 1개를 들고오는 메서드
	public RoomDTO getBringRoom(int h_rno){
		
		RoomDTO rdto = dao.bringRoomDto(h_rno);
		return rdto;
	
	}

	public ArrayList<Hotel_commentDTO> getBringComment(int h_no) {

		ArrayList<Hotel_commentDTO> comment= dao.getCommentList(h_no);
		return comment;
	}
	
	
	
	
	


	
}
