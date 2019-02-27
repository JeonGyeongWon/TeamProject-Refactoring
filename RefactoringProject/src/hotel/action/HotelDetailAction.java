package hotel.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.User;

import dao.UserManagementDAO;
import dto.UserManagementDTO;
import hotel.dto.FacilitiesDTO;
import hotel.dto.HotelDTO;
import hotel.dto.Hotel_commentDTO;
import hotel.dto.RoomDTO;
import hotel.dto.UsersDTO;
import hotel.service.HotelDetailService;
import together.Action;
import together.ActionForward;

public class HotelDetailAction implements Action {

	//호텔정보 및 방정보를 보여주는곳
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int h_no = Integer.parseInt(request.getParameter("h_no"));
		
		HttpSession session = request.getSession();
		
		//현재 로그인한 사람이있으면 해당 정보를 Detail에 같이넘겨줌 -> 예약과 결제떄문에
			
		
		UserManagementDTO udto = null;
		if(session.getAttribute("user_email")!=null){
			UserManagementDAO dao = new UserManagementDAO();
			udto = dao.getUserInfo((String)session.getAttribute("user_email"));
		}
		
		ActionForward forward = new ActionForward();
		
		HotelDetailService service = new HotelDetailService();
		
		HotelDTO hdto = service.getBringoneHotelInfo(h_no);
		FacilitiesDTO fdto = service.getBringAllFacilities(h_no);
		ArrayList<RoomDTO> rlist = service.getBringAllRoomInfo(h_no);
		ArrayList<Hotel_commentDTO> commentlist = service.getBringComment(h_no);
		// 호텔번호를 이용해 해당 판매자의 정보를 가져옴 ! -> 서브쿼리사용했어요
		int user_no = hdto.getUser_no();
		
		UserManagementDTO manager = service.bringHotelManageInfo(user_no);
		
		//얘는 호텔주인이고 
		request.setAttribute("manager", manager);
		//얘는 현재로그인한사람
		if(udto != null){
			request.setAttribute("udto", udto);
		}
		request.setAttribute("hdto", hdto);
		request.setAttribute("fdto", fdto);
		request.setAttribute("rlist", rlist);
		request.setAttribute("commentList", commentlist);
		
		forward.setRedirect(false);
		forward.setPath("hotel/hotelDetail.jsp");
		
		return forward;
	}

}
