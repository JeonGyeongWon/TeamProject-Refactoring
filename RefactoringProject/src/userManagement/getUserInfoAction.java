package userManagement;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.HotelDAO;
import dao.UserManagementDAO;
import together.Action;
import together.ActionForward;

public class getUserInfoAction implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		// request로 받은 데이터 한글 처리
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();							//세션에 저장되어 있는 user_email을 가져오기 위해 request를 이용해 세션객체(HttpSession)를 생성한다.
		String user_email = (String) session.getAttribute("user_email");	//세션에 저장되어 있는 user_email값을 문자열 변수 user_email에 저장한다.
		
		UserManagementDAO umdao = new UserManagementDAO();					//user_email값으로 DB작업할 객체 생성
		dto.UserManagementDTO umdto = umdao.getUserInfo(user_email);
		
		int user_no = umdto.getUser_no();
		
		HotelDAO dao = new HotelDAO();
		
		ArrayList list = dao.getReservationRoomList(user_no);
		
		//전달받은 user_email값을 getUserInfo()로 전달해 해당 회원정보를 가져와 DTO객체(umdto)에 저장한다.
		request.setAttribute("umdto", umdto);								//검색결과값이 담긴 umdto를 request영역에 저장한다.
		request.setAttribute("list", list);
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/userManagement/edit.jsp");
		
		return forward;				//결과값을 컨트롤러(UserManagementController)의 "/editPage.um"로 리턴해 action변수에 저장한다.
		
	}

}
