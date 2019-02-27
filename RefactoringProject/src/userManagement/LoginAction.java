package userManagement;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserManagementDAO;
import dto.UserManagementDTO;
import together.Action;
import together.ActionForward;

public class LoginAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");						//request 데이터 한글 처리
		String user_email = request.getParameter("user_email");		//login.jsp에서 넘어온 parameter값(user_email)을 String변수에 담는다.
		String user_pass = request.getParameter("user_pass");		//login.jsp에서 넘어온 parameter값(user_pass)을 String변수에 담는다.

		UserManagementDAO umdao = new UserManagementDAO();			//DB작업할 객체(UserManagementDAO)를 생성한다.
		ActionForward forward = new ActionForward();				//리턴할 forward객체를 생성한다. 
		
		int result = umdao.userLogin(user_email, user_pass);		//DAO객체에 있는 userLogin()메서드에 parameter값을 전달하고, 리턴값을 result에 저장한다.
		if(result == -1){											//result값이 -1일 때 = 사용자가 입력한 값과 DB에 저장된 값 중 일치하는 값이 없다.
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('아이디와 비밀번호를 다시 확인하세요.')");
			out.println("history.back()");
			out.println("</script>");
			return null;
		}
		else if(result == 0){										//result가 0일 때 = 사용자가 입력한 user_email은 일치하지만 user_pass는 일치하지 않는다.
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('비밀번호가 일치하지 않습니다.')");
			out.println("history.back()");
			out.println("</script>");
			return null;
		}
		else if(result == 1){										//result가 1일 때 = 사용자가 입력한 user_email과 user_pass가 모두 일치해서 1행의 검색 결과값이 생겼다.
			HttpSession session = request.getSession();				//세션 생성
			session.setAttribute("user_email", user_email);			//세션에서 user_email값 저장

			UserManagementDTO umdto = new UserManagementDTO();
			umdto = umdao.getUserInfo(user_email);
			int user_no = umdto.getUser_no();
			String user_nickname = umdto.getUser_nickname();
			session.setAttribute("user_no", user_no);				//세션에 user_no값 저장
			session.setAttribute("user_nickname", user_nickname);	//세션에 user_nickname값 저장
			
			System.out.println("사용자(회원번호 "+user_no+"번, "+user_nickname+"("+user_email + ")) 로그인");
			forward.setRedirect(false);
			forward.setPath("/main.um");
		}

		return forward;	//결과값을 컨트롤러(UserManagementController)의 "/loginPro.um"로 리턴해 action변수에 저장한다.
	}

}