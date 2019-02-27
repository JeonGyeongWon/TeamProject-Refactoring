package hotel.service;

import dao.HotelDAO;
import hotel.dto.ReservationDTO;

public class reservationService {
	
	
	HotelDAO dao = new HotelDAO();
			
	public int insertReservation(ReservationDTO dto){
		
		int result = dao.insertReservation(dto);
		
		return result;
	}
}
