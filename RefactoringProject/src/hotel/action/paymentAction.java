package hotel.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hotel.service.PaymentService;
import together.Action;
import together.ActionForward;

public class paymentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//결제 작업을 하는 메서드 (내부적으로 예약테이블 ckprice를 1로 변경시켜줘야함)
		ActionForward forward= null;
		
		int total_price = Integer.parseInt(request.getParameter("total_price"));
		int user_no = Integer.parseInt(request.getParameter("user_no"));
		int h_rno = Integer.parseInt(request.getParameter("h_rno"));
		PaymentService service = new PaymentService();
		service.insertPayment(user_no, total_price, h_rno);
		return forward;
	}

}
