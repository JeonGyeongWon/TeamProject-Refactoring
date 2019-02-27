package userManagement;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import together.Action;
import together.ActionForward;

public class LogoutAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//로그아웃을 위해 세션 불러오기
		HttpSession session = request.getSession();
		
		//Console에 로그아웃하는 사용자 정보(user_email) 보여주기
		System.out.println("사용자("+session.getAttribute("user_email")+") 로그아웃");
		
		//session 전체를 만료시킨다.
		session.invalidate();
		
		//main페이지로 이동한다.
		response.sendRedirect("./main.um");
		
		return null;
	}

}
