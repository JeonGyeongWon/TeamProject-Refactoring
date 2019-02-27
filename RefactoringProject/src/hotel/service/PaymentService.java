package hotel.service;

import dao.HotelDAO;

public class PaymentService {
	
	HotelDAO dao = new HotelDAO();
	
	public void insertPayment(int user_no, int total_price, int h_rno){
		dao.inserPayment(user_no, total_price, h_rno);
	}
}
