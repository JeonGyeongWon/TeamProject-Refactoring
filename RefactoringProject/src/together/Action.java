package together;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


//모든 action 클래스들의 최고조상 각 action클래스들의 타입을 하나로받기위해(다형성)
public interface Action  {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception;
}