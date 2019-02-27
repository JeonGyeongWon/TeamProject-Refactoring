package hotel.action;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.security.Provider.Service;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.imageio.stream.FileImageInputStream;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.core.ApplicationContext;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import dao.HotelDAO;
import dao.UserManagementDAO;
import dto.UserManagementDTO;
import hotel.service.InsertHotelService;
import hotel.dto.FacilitiesDTO;
import hotel.dto.HotelDTO;
import hotel.dto.RoomDTO;
import hotel.dto.Room_imgDTO;
import together.Action;
import together.ActionForward;

public class InsertHotelAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception   {
		
		ActionForward forward = null;
		
		/*
		ServletContext context = request.getServletContext();
		String realpath = context.getRealPath("/hotel/upload");
		System.out.println(realpath);
		*/
		String rootPath = request.getSession().getServletContext().getRealPath("/") ; //웹컨텍스트경로까지
		String savepath = rootPath + "/hotel/upload/" ;	//실제파일이 올라가는곳
		String realpath = "upload/";	//DB저장공간
		System.out.println(realpath);
		
		//가상경로 오류로 임시로 절대경로지정
		//String realpath = "E:\\upload";	//메인이미지 경로
		String image = "";
		String subimg = "";	//room 서브이미지
		String roomimg =""; //room 메인이미지
    	int max = 50 * 1024 * 1024;
    	
    	MultipartRequest multi = new MultipartRequest(request, savepath,max, "utf-8",new DefaultFileRenamePolicy());
    	
    	HotelDTO Hdto = new HotelDTO();
    	FacilitiesDTO fdto = new FacilitiesDTO();
    	RoomDTO dto = new RoomDTO();
    	Room_imgDTO RoomSub = new Room_imgDTO();
    	
    	//user_no 값을 얻기 위한 session값을 가져옴
    	HttpSession session = request.getSession();
    	
    	String user_email = (String)session.getAttribute("user_email");
    	
    	//System.out.println(user_email);
    	
    	/* 유저 정보를 넣기위한 udao 생성*/
    	UserManagementDAO udao = new UserManagementDAO();
    	UserManagementDTO udto = udao.getUserInfo(user_email);
    	
    	String addr = "";
    	
    	addr = multi.getParameter("addr");
    	
    	//위도 경도
    	System.out.println(multi.getParameter("Latitude"));
    	System.out.println(multi.getParameter("Hardness"));
    	
    	Double latitude = Double.parseDouble(multi.getParameter("Latitude"));
    	Double hardness = Double.parseDouble(multi.getParameter("Hardness"));
    	
    	System.out.println(latitude);
    	System.out.println(hardness);
    	
    	
    	/*호텔입력부분*/
    	Hdto.setUser_no(udto.getUser_no());
    	Hdto.setH_name(multi.getParameter("h_name"));
    	Hdto.setH_content(multi.getParameter("h_content"));
    	Hdto.setH_addr(addr);
    	Hdto.setH_caution(multi.getParameter("h_caution"));
    	Hdto.setH_rule(multi.getParameter("h_rule"));
    	Hdto.setH_detail(multi.getParameter("h_detail"));
    	Hdto.setH_regdate(null);
    	Hdto.setHardness(hardness);
    	Hdto.setLatitude(latitude);
    	
    	
    	
    	// 파일 업로드 관련 
    	Enumeration e = multi.getFileNames();
    	ArrayList list = new ArrayList();
    	
    	
    	FileInputStream fis = null;
		FileOutputStream fos = null;
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		int fileData = 0;
		
		//git이 저장되어있는곳 원래는 가상경로를 이용해야하나 제컴퓨터가 인식을 못하기에..... git으로 잡았습니다
		// 현재 팀프로젝트 중이므로 workspace가아닌 git경로를 잡으셔야합니다.
		
		/* 학원저장경로 저장경로 */
		String myoutpath ="C:/Users/ITWILL/git/TeamProject/ExTeamProject/WebContent/hotel/upload";
		
		//나으 노트북 저장경로
		//String myoutpath = "C:/Users/전경원/git/TeamProject/ExTeamProject/WebContent/hotel/upload";
		
		e= multi.getFileNames();
		
		while(e.hasMoreElements()){
			String fileName = (String)e.nextElement();
			String uploadfile = multi.getFilesystemName(fileName);
			fis= new FileInputStream(savepath+uploadfile);
			bis = new BufferedInputStream(fis);
			
			fos = new FileOutputStream(myoutpath+"/"+uploadfile);
			bos = new BufferedOutputStream(fos);
			
			while((fileData=bis.read())!=-1){
				bos.write(fileData);
			}
			if(fileName.equals("h_img0")){	//호텔 메인이미지
    			image = multi.getFilesystemName(fileName);
    		}else if(fileName.equals("h_img1")){	//룸 메인이미지
    			roomimg = multi.getFilesystemName(fileName);
    		}else{	//룸 서브이미지
    			subimg = multi.getFilesystemName(fileName)+",";
    			list.add(subimg);
    		}
		}
    	
		
		
		// 읽어들인 호텔메인, 방메인, 방 서브이미지를 나누는작업
		// 제컴퓨터 경로문제때문에 이클립스내에 넣어두겠습니다!
		
		//	C:\Users\ITWILL\git\TeamProject\ExTeamProject\WebContent\hotel\\upload 제 git이 저장되어있는 공간입니다.
		
		//multi중복이 되지않기에 모두같은경로에 있음
		// -> 삭제시에 파일도 같이 설정하게 해둘것! -> 메서드만들어놓겠습니다~
		
    	
    	for(int i = 0; i<list.size(); i++){
    		if(i==0){
    			continue;
    		}
    		subimg += (String)list.get(i);
    	}
    	
    	Hdto.setH_imgpath(realpath);
    	Hdto.setH_imgname(image);	//메인이미지
    	
    	System.out.println("호텔 메인이미지 경로"+realpath);
    	System.out.println("호텔 메인이미지 이름"+image);
    	
    	/*호텔입력 종료*/
    	
    	/*편의시설 입력정보*/
    	if(multi.getParameter("wifi")!=null)
    	fdto.setWifi(Integer.parseInt(multi.getParameter("wifi")));
    	
    	if(multi.getParameter("shampoo")!=null)
    	fdto.setShampoo(Integer.parseInt(multi.getParameter("shampoo")));
    	
    	if(multi.getParameter("closet")!=null)
    	fdto.setCloset(Integer.parseInt(multi.getParameter("closet")));
    	
    	if(multi.getParameter("tv")!=null)
    	fdto.setTv(Integer.parseInt(multi.getParameter("tv")));
    	
    	if(multi.getParameter("aircon")!=null)
    	fdto.setAircon(Integer.parseInt(multi.getParameter("aircon")));
    	
    	if(multi.getParameter("hairdry")!=null)
    	fdto.setHairdry(Integer.parseInt(multi.getParameter("hairdry")));
    	
    	if(multi.getParameter("swim")!=null)
    	fdto.setSwim(Integer.parseInt(multi.getParameter("swim")));
    	
    	if(multi.getParameter("wash_dry")!=null)
    	fdto.setWash_dry(Integer.parseInt(multi.getParameter("wash_dry")));
    	
    	if(multi.getParameter("parking")!=null)
    	fdto.setParking(Integer.parseInt(multi.getParameter("parking")));
    	
    	if(multi.getParameter("elevator")!=null)
    	fdto.setElevator(Integer.parseInt(multi.getParameter("elevator")));
    	
    	if(multi.getParameter("health")!=null)
    	fdto.setHealth(Integer.parseInt(multi.getParameter("health")));
    
    	fdto.setEtc(multi.getParameter("etc"));
    	
    	
    	
    	InsertHotelService service = new InsertHotelService();
    	
    	boolean result = service.insertIntoHotel(Hdto,fdto);
    	
    	/*편의시설 입력종료 */
    	
    	/*Room정보 및 Room 서브이미지 입력*/
    	
    	
    	dto.setBathroom(Integer.parseInt(multi.getParameter("bathroom")));
    	dto.setBed(Integer.parseInt(multi.getParameter("bed")));
    	dto.setPersonne(Integer.parseInt(multi.getParameter("personnel")));
    	dto.setRoomsize(multi.getParameter("roomsize"));
    	dto.setWeekend_price(Integer.parseInt(multi.getParameter("weekend_price")));
    	dto.setWeekprice(Integer.parseInt(multi.getParameter("weekprice")));
    	
    	
    	
    	
   
    	dto.setImgname(roomimg);
    	dto.setImgpath(realpath);
    		//RoomMainImage
    	
    	System.out.println("방 메인이미지 경로"+realpath);
    	System.out.println("방 메인이미지 이름"+roomimg);	//RoomMainImage
    	
    	
    	
    	
    	
    	RoomSub.setImgname(subimg);
    	RoomSub.setImgpath(realpath);
    	
    	System.out.println("방 서브이미지 경로"+realpath);
    	System.out.println("방 서브이미지 이름"+subimg);
    	
    	
    	
    	service.insertIntoRoom(dto,RoomSub);
    	
    	forward = new ActionForward();
    	
    	///hotel/HotelMain.hotel
    	if(result){	
    		PrintWriter out = response.getWriter();
    		out.println("<script>");
    		out.println("alert('호텔 및 방을 등록하였습니다')");
    		out.println("</script>");
    		forward.setRedirect(true);
    		forward.setPath("/ExTeamProject/HotelMain.hotel");
    	}else{	//수정
    		PrintWriter out = response.getWriter();
    		out.println("<script>");
    		out.println("alert('호텔을 등록에 실패했습니다. 다시시도해보세요')");
    		out.println("</script>");
    		forward.setRedirect(false);
    		forward.setPath("../InsertHotelForm.hotel");
    	}
	
		return forward;
	}

}
