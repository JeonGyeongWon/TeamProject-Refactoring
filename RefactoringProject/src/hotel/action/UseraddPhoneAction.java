package hotel.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserManagementDAO;

public class UseraddPhoneAction {
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		UserManagementDAO dao = new UserManagementDAO();
		String user_email = request.getParameter("user_email");
		System.out.println(user_email);
		String user_phone = request.getParameter("user_phone");
		System.out.println(user_phone);
		dao.updateUserPhoneNumber(user_email,user_phone);
		
		return null;
	}
}
