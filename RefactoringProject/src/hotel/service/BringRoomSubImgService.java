package hotel.service;

import dao.HotelDAO;
import hotel.dto.RoomDTO;
import hotel.dto.Room_imgDTO;

public class BringRoomSubImgService {
	
	
	public Room_imgDTO bringSubImg(int h_rno){
	
		
		HotelDAO dao = new HotelDAO();
	Room_imgDTO dto = dao.bringRoom_imgDto(h_rno);
		
	return dto;
	
	}

	public RoomDTO bringRoomInfo(int h_rno) {
		
		HotelDAO dao = new HotelDAO();
		RoomDTO dto = dao.bringRoomDto(h_rno);
		return dto;
	}

	
}
