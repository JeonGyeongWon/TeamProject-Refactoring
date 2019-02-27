package userManagement;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import together.Action;
import together.ActionForward;
import dao.UserManagementDAO;
import dto.UserManagementDTO;

//하는일
//1.회원가입 폼(join.jsp)에서 입력한 정보들을 MemberBean객체(자바빈,DTO)에 저장 시키고....
//2.저장시킨 MemberBean객체를 DB작업을 하기위한 DAO객체에 전달하여 insert회원가입 한다
//3.회원가입 성공시.. 로그인 페이지로 이동 시키기 위해...
//  페이지 이동방식 여부값, 이동할 페이지 경로 값을 new ActionForward();객체에 저장하여..
//  MemberFrontController로 리턴 해주는 역할.
public class JoinAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// request로 받은 데이터 한글 처리
		request.setCharacterEncoding("UTF-8");

		// join.jsp에서 넘어온 request의 parameter값을 UserManagementDTO객체에 저장한다.
		UserManagementDTO umdto = new UserManagementDTO();
		umdto.setUser_email(request.getParameter("user_email"));
		umdto.setUser_pass(request.getParameter("user_pass"));
		umdto.setUser_nickname(request.getParameter("user_nickname"));
		umdto.setUser_birth(request.getParameter("user_birth"));
		umdto.setUser_gender(request.getParameter("user_gender"));
//		umdto.setUser_phone(request.getParameter("user_phone"));		//전화번호 입력(선택사항)란 생성 시 사용 

		// 회원가입 성공 여부를 담을 변수 선언
		int result = 0;

		UserManagementDAO umdao = new UserManagementDAO();

		result = umdao.insertMember(umdto); // 회원가입에 성공하면 true, 실패하면 false리턴
		ActionForward forward = new ActionForward();
		System.out.println(result);
		if (result != 1) { // 회원가입에 실패할 경우
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('회원가입에 실패했습니다. 다시 시도해주십시오.')");
			out.println("history.back()");
			out.println("</script>");
		} else { // 회원가입에 성공할 경우
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('회원가입이 완료되었습니다.')");
			out.println("</script>");
			System.out.println("새로운 사용자("+request.getParameter("user_email")+") 가입");
			forward.setRedirect(false);
			forward.setPath("/loginPage.um");
		}

		return forward;
	}
}
