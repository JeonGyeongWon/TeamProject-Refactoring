package hotel.service;

import dao.HotelDAO;
import hotel.dto.FacilitiesDTO;
import hotel.dto.HotelDTO;
import hotel.dto.RoomDTO;
import hotel.dto.Room_imgDTO;

//호텔정보작업
public class InsertHotelService {
	
	HotelDAO dao = new HotelDAO();
	
	public boolean insertIntoHotel(HotelDTO hdto, FacilitiesDTO fdto){
		
		boolean isInsertHotel = false;
		
	
		int result = dao.insertHotel(hdto, fdto);
		
		System.out.println("InsertInto 서비스 메서드 실행");
		
		if(result > 0){
			isInsertHotel = true;
			System.out.println("dao성공");
		}
		
		return isInsertHotel;
		
	}
	
	public boolean insertIntoRoom(RoomDTO dto, Room_imgDTO roomsub){
		
		boolean isInsertRoom = false;
		
		int result = dao.insertRoom(dto,roomsub);
		
		if(result > 0){
			isInsertRoom = true;
			System.out.println("룸삽입성공");
		}
		
		
		return isInsertRoom;
	
		
	}
	
		
}
