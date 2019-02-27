package userManagement;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserManagementDAO;
import dto.UserManagementDTO;
import together.Action;
import together.ActionForward;

public class editUserInfoAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");							//request로 받은 데이터 한글 처리
		String user_email = request.getParameter("user_email");
		String user_nickname = request.getParameter("user_nickname");
		String user_pass = request.getParameter("user_pass");
		String user_birth = request.getParameter("user_birth");
		String user_gender = request.getParameter("user_gender");
		
		UserManagementDTO umdto = new UserManagementDTO();				//DB작업에 사용될 데이터를 저장하는 UserManagementDTO객체 생성 
		umdto.setUser_email(user_email);
		umdto.setUser_nickname(user_nickname);
		umdto.setUser_pass(user_pass);
		umdto.setUser_birth(user_birth);
		umdto.setUser_gender(user_gender);
		
		
		UserManagementDAO umdao = new UserManagementDAO();				//DB작업할 객체 UserManagementDAO객체 생성
		int result = umdao.editUserInfo(umdto);							//회원정보를 수정하는 editUserInfo()메서드에 umdto를 parameter값으로 넘겨주고, 리턴된 결과값을 result변수에 담는다.
		ActionForward forward = new ActionForward();
		if(result == -1) {
			response.setContentType("text/html; charset=UTF-8");		//result가 -1일 때 = DB작업에 실패한 상황
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('회원정보 수정 실패')");
			out.println("history.back()");
			out.println("</script>");
			return null;
		} else if(result == 0) {										//result가 0일 때 = DB작업은 정상적으로 수행했으나 결과값이 없을 때
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('해당하는 정보가 없습니다.')");
			out.println("</script>");
			return null;
		} else {														//result가 1일 때 = DB작업에 성공해서 회원정보가 정상적으로 수정된 상태 
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('정보가 정상적으로 수정되었습니다.')");
			out.println("</script>");
			forward.setRedirect(false);
			forward.setPath("/main.um");
		}
		
		return forward;
	}

}
