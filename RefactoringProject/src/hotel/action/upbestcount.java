package hotel.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.HotelDAO;

public class upbestcount {
	
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		

		int h_no = Integer.parseInt(request.getParameter("h_no"));
		
		HotelDAO dao = new HotelDAO();
		int s = dao.upBestCount(h_no);
		
		JSONObject obj = new JSONObject();
		
		obj.put("bestcount", s);
		
		return obj.toJSONString();
	}
	
}
