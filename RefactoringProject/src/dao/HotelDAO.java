package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.catalina.connector.Request;

import db.ConnectionPool;
import hotel.dto.FacilitiesDTO;
import hotel.dto.HotelDTO;
import hotel.dto.Hotel_commentDTO;
import hotel.dto.ReservationDTO;
import hotel.dto.RoomDTO;
import hotel.dto.Room_imgDTO;
import dto.UserManagementDTO;

public class HotelDAO {
	
	Connection con = null;
	PreparedStatement pstmt= null;
	ResultSet rs = null;
	ConnectionPool pool = new ConnectionPool();
	
	
	
	// 모든 호텔 정보를 가져오는 메서드 					//페이징
	public ArrayList<HotelDTO> allselectedHotel(int startRow, int endRow){
		
		ArrayList<HotelDTO> list = new ArrayList<HotelDTO>();
		String sql = "";
		
		try{
			con = pool.getConnection();
			sql = "select * from hotel order by h_no desc limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				HotelDTO dto = new HotelDTO();
				dto.setH_addr(rs.getString("h_addr"));
				dto.setH_bestcount(rs.getInt("bestcount"));
				dto.setH_caution(rs.getString("h_caution"));
				dto.setH_content(rs.getString("h_content"));
				dto.setH_detail(rs.getString("h_detail"));
				dto.setH_imgname(rs.getString("imgname"));
				dto.setH_imgpath(rs.getString("imgpath"));
				dto.setH_name(rs.getString("h_name"));
				dto.setH_no(rs.getInt("h_no"));
				dto.setH_regdate(rs.getTimestamp("regdate"));
				dto.setH_rule(rs.getString("h_rule"));
				dto.setUser_no(rs.getInt("user_no"));
				dto.setHardness(rs.getDouble("Hardness"));
				dto.setLatitude(rs.getDouble("Latitude"));
				list.add(dto);
			}
			
		}catch(Exception e){
			System.out.println("allselectedHotel에서"+e);
		}finally{
			pool.close(con, pstmt, rs);
		}
		return list;
	}
	
	
	//각 호텔 번호를 이용해 룸 정보를 가져오는 메서드
	public ArrayList<RoomDTO> allselectedRoom(int h_no) {
		
		String sql ="";
		ArrayList<RoomDTO> list = new ArrayList<>();
		try{
			con = pool.getConnection();
			sql = "select * from room where h_no =?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, h_no);
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				RoomDTO dto = new RoomDTO();
				dto.setH_rno(rs.getInt("h_rno"));
				dto.setH_no(rs.getInt("h_no"));
				dto.setBed(rs.getInt("bed"));
				dto.setPersonne(rs.getInt("personnel"));
				dto.setBathroom(rs.getInt("bathroom"));
				dto.setRoomsize(rs.getString("roomsize"));
				dto.setWeekprice(rs.getInt("weekprice"));
				dto.setWeekend_price(rs.getInt("weekend_price"));
				dto.setImgname(rs.getString("imgname"));
				dto.setImgpath(rs.getString("imgpath"));
				list.add(dto);
			}
		}catch(Exception e){
			System.out.println("allselectedRoom에서"+e);
		}finally{
			pool.close(con, pstmt, rs);
		}
		
		return list;
	}
	
	
	// 각 호텔 번호를 이용해 편의시설을 가져오는 메서드
	public FacilitiesDTO oneselectedFacilities(int h_no){
		FacilitiesDTO dto = new FacilitiesDTO();
		String sql ="";
		
		try{
			con = pool.getConnection();
			sql = "select * from facilities where h_no = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, h_no);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				dto.setAircon(rs.getInt("aircon"));
				dto.setCloset(rs.getInt("closet"));
				dto.setElevator(rs.getInt("elevator"));
				dto.setEtc(rs.getString("etc"));
				dto.setH_no(rs.getInt("h_no"));
				dto.setHairdry(rs.getInt("hairdry"));
				dto.setHealth(rs.getInt("health"));
				dto.setParking(rs.getInt("parking"));
				dto.setShampoo(rs.getInt("shampoo"));
				dto.setSwim(rs.getInt("swim"));
				dto.setTv(rs.getInt("tv"));
				dto.setWash_dry(rs.getInt("wash_dry"));
				dto.setWifi(rs.getInt("wifi"));
			}
			
		}catch(Exception e){
			System.out.println("allselectedFacilities에서"+e);
		}finally{
			pool.close(con, pstmt, rs);
		}
		return dto;
	}
	
	
	// inserthotel메서드 내부에서 사용할 메서드
	private void insertFaclities(FacilitiesDTO facilities){

		int result = 0;
		
	try{
		con = pool.getConnection();
		String sql2 = "SELECT * FROM hotel order by h_no desc";
		pstmt = con.prepareStatement(sql2);
		
		rs = pstmt.executeQuery();
		rs.next();
		
		int h_no = rs.getInt("h_no");
		
		
		String sql3 = "INSERT INTO facilities"
				+ "(h_no, wifi, shampoo, closet, tv, aircon, hairdry, swim, wash_dry, parking, elevator, health, etc)"
				+ "values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
				
		pstmt=con.prepareStatement(sql3);
		
		pstmt.setInt(1, h_no);
		pstmt.setInt(2, facilities.getWifi());
		pstmt.setInt(3, facilities.getShampoo());
		pstmt.setInt(4, facilities.getCloset());
		pstmt.setInt(5, facilities.getTv());
		pstmt.setInt(6, facilities.getAircon());
		pstmt.setInt(7, facilities.getHairdry());
		pstmt.setInt(8, facilities.getSwim());
		pstmt.setInt(9, facilities.getWash_dry());
		pstmt.setInt(10, facilities.getParking());
		pstmt.setInt(11, facilities.getElevator());
		pstmt.setInt(12, facilities.getHealth());
		pstmt.setString(13, facilities.getEtc());
		
		result = pstmt.executeUpdate();
		
		if(result > 0){
			System.out.println("Facilities테이블 삽입 성공");
		}else{
			System.out.println("Facilities테이블 삽입 실패");
		}
		
		 //회원가입 성공하면 true리턴
		
	}catch(Exception e){
		System.out.println("insertFacilities에서"+e);
	}finally{
		pool.close(con, pstmt, rs);
	}
	
	
	}
	
	//1개의 호텔정보를 가져오는 메서드
	
	public HotelDTO oneHotelInfo(int h_no){
		HotelDTO dto = new HotelDTO();
		String sql ="";
		
		try{
			con = pool.getConnection();
			
			sql = "select * from hotel where h_no = ?";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, h_no);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()){
				dto.setH_addr(rs.getString("h_addr"));
				dto.setH_bestcount(rs.getInt("bestcount"));
				dto.setH_caution(rs.getString("h_caution"));
				dto.setH_content(rs.getString("h_content"));
				dto.setH_detail(rs.getString("h_detail"));
				dto.setH_imgname(rs.getString("imgname"));
				dto.setH_imgpath(rs.getString("imgpath"));
				dto.setH_name(rs.getString("h_name"));
				dto.setH_no(rs.getInt("h_no"));
				dto.setH_regdate(rs.getTimestamp("regdate"));
				dto.setH_rule(rs.getString("h_rule"));
				dto.setUser_no(rs.getInt("user_no"));
				dto.setHardness(rs.getDouble("Hardness"));
				dto.setLatitude(rs.getDouble("Latitude"));
			}
		}catch(Exception e){
			System.out.println("oneHotelInfo에서"+e);
			
		}finally{
			pool.close(con, pstmt, rs);
		}
		
		return dto;
	}
	
	
	//호텔 삽입 메서드
	public int insertHotel(HotelDTO hdto, FacilitiesDTO fdto){
		int result = 0;
		String sql = "";
		
		try{
			con = pool.getConnection();
			sql = "insert into hotel(h_name, h_content, h_addr, h_caution, h_rule, h_detail, regdate,imgpath,imgname,user_no,bestcount,Latitude,Hardness) "+
			"values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
			
			pstmt=con.prepareStatement(sql);
			
			
			pstmt.setString(1, hdto.getH_name());
			pstmt.setString(2, hdto.getH_content());
			pstmt.setString(3, hdto.getH_addr());
			pstmt.setString(4, hdto.getH_caution());
			pstmt.setString(5, hdto.getH_rule());
			pstmt.setString(6, hdto.getH_detail());
			pstmt.setTimestamp(7, null);
			pstmt.setString(8,hdto.getH_imgpath());
			pstmt.setString(9, hdto.getH_imgname());
			pstmt.setInt(10,hdto.getUser_no());
			pstmt.setInt(11, hdto.getH_bestcount());
			pstmt.setDouble(12, hdto.getLatitude());
			pstmt.setDouble(13, hdto.getHardness());
			
			result = pstmt.executeUpdate();
			System.out.println(result);
			System.out.println("호텔 테이블 삽입 성공");
			
			insertFaclities(fdto);
			
			
		}catch(Exception e){
			System.out.println("insertHotel에서"+e);
		}finally{
			pool.close(con, pstmt, rs);
		}
		
		return result;
	}

		//h_no로 조회된 hotel정보를 삭제하는 메서드
		public int deleteHotel(HotelDTO hotel){
			
			String sql = "DELETE * FROM hotel WHERE h_no=?";
			
			
			try {
				con = pool.getConnection();
				pstmt.setInt(1, hotel.getH_no());
				
				pstmt=con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("deleteHotel()내에서 오류 "+e);
			}finally{
				pool.close(con, pstmt, rs);
			}
			
			
			return 0;
			
		}
		
		private int insertSubRoom_img(Room_imgDTO dto){
			
			int result=0;
			String sql="";
			
			try{
				con = pool.getConnection();
				sql = "select * from room order by h_rno desc";
				
				pstmt = con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				rs.next();
				
				int h_rno=rs.getInt("h_rno");
				int h_no =rs.getInt("h_no");
				
				
				
				sql = "insert into room_img value(?,?,?,?)";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, h_no);
				pstmt.setInt(2, h_rno);
				pstmt.setString(3, dto.getImgpath());
				pstmt.setString(4, dto.getImgname());
				
				result = pstmt.executeUpdate();
				
			}catch(Exception e){
				System.out.println("insertSubRoom_img에서"+e);
			}finally{
				pool.close(con, pstmt, rs);
			}
			
			
			return result;
		}
		
		//방 정보를 입력하는 메서드
		public int insertRoom(RoomDTO room, Room_imgDTO roomsub){
			
			String sql = "INSERT INTO room"
					+ "(h_no, personnel, bed, bathroom, roomsize, weekprice, weekend_price, imgpath, imgname) "
					+ "values(?,?,?,?,?,?,?,?,?)";
			
			int result = 0; //입력 성공 여부를 저장할 변수
			
			try {
				con = pool.getConnection();
				
				String sql2 = "SELECT * FROM hotel order by h_no desc";
				
				pstmt=con.prepareStatement(sql2);
				
				rs = pstmt.executeQuery();
				rs.next();
				
				int h_no = rs.getInt("h_no");
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, h_no);
				pstmt.setInt(2, room.getPersonne());
				pstmt.setInt(3, room.getBed());
				pstmt.setInt(4, room.getBathroom());
				pstmt.setString(5, room.getRoomsize());
				pstmt.setInt(6, room.getWeekprice());
				pstmt.setInt(7, room.getWeekend_price());
				pstmt.setString(8, room.getImgpath());
				pstmt.setString(9, room.getImgname());
				
				result = pstmt.executeUpdate();
				
				insertSubRoom_img(roomsub);
				
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("insertRoom()메서드 내에서 오류 : "+e);
			}
			
			return 0;
		}


		public Room_imgDTO bringRoom_imgDto(int h_rno) {
			
			String sql = "";
			Room_imgDTO dto = new Room_imgDTO();
			try{
				con = pool.getConnection();
				sql = "select * from room_img where h_rno = ?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, h_rno);
				
				rs=pstmt.executeQuery();
				
				if(rs.next()){
					dto.setH_no(rs.getInt("h_no"));
					dto.setH_rno(rs.getInt("h_rno"));
					dto.setImgname(rs.getString("imgname"));
					dto.setImgpath(rs.getString("imgpath"));
				}
			}catch(Exception e){
				System.out.println("bringRoom_imgDto에서"+e);
			}finally{
				pool.close(con, pstmt, rs);
			}
			
			return dto;
		}


		//방정보를 가져옴 
		public RoomDTO bringRoomDto(int h_rno) {
			
			RoomDTO dto = new RoomDTO();
			String sql = "";
			try{
				con = pool.getConnection();
				sql = "select * from room where h_rno = ?";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, h_rno);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					dto.setBathroom(rs.getInt("bathroom"));
					dto.setBed(rs.getInt("bed"));
					dto.setH_no(rs.getInt("h_no"));
					dto.setH_rno(rs.getInt("h_rno"));
					dto.setImgname(rs.getString("imgname"));
					dto.setImgpath(rs.getString("imgpath"));
					dto.setPersonne(rs.getInt("personnel"));
					dto.setRoomsize(rs.getString("roomsize"));
					dto.setWeekend_price(rs.getInt("weekend_price"));
					dto.setWeekprice(rs.getInt("weekprice"));
				}
			}catch(Exception e){
				System.out.println("bringRoomDto에서"+e);
			}finally{
				pool.close(con, pstmt, rs);
			}
			
			return dto;
		}

		//서브쿼리썼어요 햇갈리지마요~~ mysql에서는 서브쿼리값이 1줄보다 길면 any 사용 
		public UserManagementDTO bringHotelManageInfo(int user_no) {
			String sql = "";
			
			try{
				con =pool.getConnection();
				sql = "select *" 
					+"from users"
					+ "where user_no = any("
					+ "select user_no"
					+ "from hotel"
					+ "where user_no = ?)";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, user_no);
				rs = pstmt.executeQuery();
				if(rs.next()){
					UserManagementDTO dto = new UserManagementDTO();
					dto.setUser_no(rs.getInt("user_no"));
					dto.setUser_pass(rs.getString("user_pass"));
					dto.setUser_nickname(rs.getString("user_nickname"));
					dto.setUser_birth(rs.getString("user_birth"));
					dto.setUser_gender(rs.getString("user_gender"));
					dto.setUser_point(rs.getInt("user_point"));
					dto.setUser_phone(rs.getString("user_phone"));
					dto.setUser_level(rs.getInt("user_level"));
					dto.setBestcount(rs.getInt("bestcount"));
					dto.setUser_email(rs.getString("user_email"));
				}
				
			}catch(Exception e){
			
			}finally{
				pool.close(con, pstmt, rs);
			}
			return null;
		}

		public int insertComment(Hotel_commentDTO cdto){
			
			int result = 0;
			String sql = "INSERT INTO hotel_comment(h_no,subject,content,regdate,bestcount,user_no)"
					+ "VALUES(?,?,?,?,?,?)";
			
			try {
				con=pool.getConnection();
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, cdto.getH_no());
				pstmt.setString(2, cdto.getSubject());
				pstmt.setString(3, cdto.getContent());
				pstmt.setTimestamp(4, null);
				pstmt.setInt(5, cdto.getBestcount());
				pstmt.setInt(6, cdto.getUser_no());
				pstmt.executeUpdate();
				
				sql = "select h_cno from hotel_comment order by h_cno desc limit 0,1";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					result = rs.getInt(1);
				}
				
			} catch (SQLException e) {
				System.out.println("insertComment()메서드 내에서 오류 "+e);
			}finally{
				pool.close(con, pstmt, rs);
			}
			return result;
			
		}//insertComment()메소드 끝
		
	
		public ArrayList<Hotel_commentDTO> getCommentList(int h_no){
			
			ArrayList<Hotel_commentDTO> list = new ArrayList<>();
				
			try {
				con=pool.getConnection();
				String sql = "SELECT * FROM hotel_comment where h_no = ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, h_no);
				rs=pstmt.executeQuery();
				
				
				while(rs.next()){
					Hotel_commentDTO cdto = new Hotel_commentDTO();
					
					cdto.setH_no(rs.getInt("h_no"));
					cdto.setH_c_no(rs.getInt("h_cno"));
					cdto.setSubject(rs.getString("subject"));
					cdto.setContent(rs.getString("content"));
					cdto.setRegdate(rs.getTimestamp("regdate"));
					cdto.setBestcount(rs.getInt("bestcount"));
					cdto.setUser_no(rs.getInt("user_no"));
					
					list.add(cdto);
				}
				
			} catch (SQLException e) {
				System.out.println("getCommentList()메서드 내에서 오류 "+e);
			}finally{
				pool.close(con, pstmt, rs);
			}
			return list;
			
		} //getCommentList()메서드 끝


		public int insertReservation(ReservationDTO dto) {

			int result=0;
			String sql = "insert into hotel_reservation(h_no,h_rno,user_no,"
					+ "total_price,ckprice,personnel,date,ckout,ckin)"
					+ "values(?,?,?,?,?,?,?,?,?)";
			try{
				con = pool.getConnection();
				pstmt= con.prepareStatement(sql);
				pstmt.setInt(1, dto.getH_no());
				pstmt.setInt(2, dto.getH_rno());
				pstmt.setInt(3, dto.getUser_no());
				pstmt.setInt(4, dto.getTotal_price());
				pstmt.setInt(5, dto.getCkprice());
				pstmt.setInt(6, dto.getPersonnel());
				pstmt.setTimestamp(7,null);
				pstmt.setTimestamp(8,dto.getCkout());
				pstmt.setTimestamp(9,dto.getCkin());
				
				result = pstmt.executeUpdate();
				
			}catch(Exception e){
				System.out.println("inserReservation에서" +e);
			}finally{
				pool.close(con, pstmt, rs);
			}
			return result;
		}


		public void inserPayment(int user_no, int total_price, int h_rno) {
			
			try{
				int ckprice = 0;
				con =pool.getConnection();
				updateCkprice(user_no, h_rno);
				String sql = "select ckprice * hotel_reservation "
						+ " where user_no = ? and total_price = ? and h_rno = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, user_no);
				pstmt.setInt(2, total_price);
				pstmt.setInt(3, h_rno);
				
				rs = pstmt.executeQuery();
				
				// 글정보가 있다면  ckprice값을 가져옴 
				if(rs.next()){
					ckprice = rs.getInt("ckprice");
				}
				
				// 삽입
				
				sql = "insert into hotel_payment(user_no,total_price,ckprice "
						+ "values(?,?,?)";
				pstmt.setInt(1, user_no);
				pstmt.setInt(2, total_price);
				pstmt.setInt(3, ckprice);
				
				pstmt.executeUpdate();
				con.commit();
				
			}catch(Exception e){
				System.out.println("inserPayment에서"+e);
			}finally{
				pool.close(con, pstmt, rs);
			}
		}
		
		public void updateCkprice(int user_no, int h_rno){
			String sql = "update hotel_reservation set ckprice = 1 "
					+ "where h_rno=? and user_no = "
					+ "(select user_no from users where user_no =? and ckprice=0)";
			try{
				con = pool.getConnection();
				con.setAutoCommit(false); 	// ckprice가 1이 됬는데 결제가 실패하면 문제가 생긴다 자동커밋을 하지않고 위에서 한다.
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, h_rno);
				pstmt.setInt(2, user_no);
				
				pstmt.executeUpdate();
				
			}catch(Exception e){
				System.out.println("updateCkprice에서"+e);
			}finally{
				pool.close(con, pstmt, rs);
			}
		}
		
		//페이징 처리를 위한 전체글 들고오기
		
		public int getTotalCount(){
			int total = 0;
			String sql = "select count(*) from hotel";
			try{
				con = pool.getConnection();
				pstmt= con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				if(rs.next()){
					total = rs.getInt(1);
				}
			}catch(Exception e){
				System.out.println("글정보 가져오기에서...");
			}finally{
				pool.close(con, pstmt, rs);
			}
			return total;
		}


		public ArrayList<HotelDTO> getSearchHotel(int key, String word, int startRow, int endRow) {
			ArrayList<HotelDTO> list = new ArrayList<>();
			String sql = "";
			if(key == 0 ){
				//호텔이름
				sql = "select * from hotel where h_name like '%"+word+"%' limit ?,?";
			}else if(key == 1){//지역구
				sql = "select * from hotel where h_addr like '%"+word+"%' limit ?,?";
			}
			try{
				
				con = pool.getConnection();
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					HotelDTO dto = new HotelDTO();
					dto.setH_addr(rs.getString("h_addr"));
					dto.setH_bestcount(rs.getInt("bestcount"));
					dto.setH_caution(rs.getString("h_caution"));
					dto.setH_content(rs.getString("h_content"));
					dto.setH_detail(rs.getString("h_detail"));
					dto.setH_imgname(rs.getString("imgname"));
					dto.setH_imgpath(rs.getString("imgpath"));
					dto.setH_name(rs.getString("h_name"));
					dto.setH_no(rs.getInt("h_no"));
					dto.setH_regdate(rs.getTimestamp("regdate"));
					dto.setH_rule(rs.getString("h_rule"));
					dto.setUser_no(rs.getInt("user_no"));
					dto.setHardness(rs.getDouble("Hardness"));
					dto.setLatitude(rs.getDouble("Latitude"));
					list.add(dto);
				}
			}catch(Exception e){
				System.out.println("getSearchHotel에서"+e);
			}finally{
				pool.close(con, pstmt, rs);
			}
			
			
			return list;
		}


		public Hotel_commentDTO getComment(int h_cno) {
			
			Hotel_commentDTO dto = new Hotel_commentDTO();
			String sql = "select * from hotel_comment where h_cno = ?";
			try{
				con = pool.getConnection();
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, h_cno);
				
				rs=pstmt.executeQuery();
				
				if(rs.next()){
					dto.setBestcount(rs.getInt("bestcount"));
					dto.setContent(rs.getString("content"));
					dto.setH_c_no(rs.getInt("h_cno"));
					dto.setH_no(rs.getInt("h_no"));
					dto.setRegdate(rs.getTimestamp("regdate"));
					dto.setSubject(rs.getString("subject"));
					dto.setUser_no(rs.getInt("user_no"));
				}
			}catch(Exception e){
				System.out.println("getComment에서"+e);
			}finally{
				pool.close(con, pstmt, rs);
			}
			return dto;
		}


		public int upBestCount(int h_no) {
			String sql = "update hotel set bestcount = bestcount+1 where h_no = ?";
			int result = 0;
			try{
				
				con = pool.getConnection();
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, h_no);
				pstmt.executeUpdate();
				
				sql = "select bestcount from hotel where h_no = ?";
				
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, h_no);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					result = rs.getInt(1);
				}
			}catch(Exception e){
				
			}finally{
				pool.close(con, pstmt, rs);
			}
			return result;
		}


		public ArrayList getReservationRoomList(int user_no) {
			// TODO Auto-generated method stub
			String sql = "select * from hotel_reservation where user_no = ?";
			ArrayList list = new ArrayList<>();
			try{
				con = pool.getConnection();
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, user_no);
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					ReservationDTO dto = new ReservationDTO();
					dto.setCkin(rs.getTimestamp("ckin"));
					dto.setCkout(rs.getTimestamp("ckout"));
					dto.setCkprice(rs.getInt("ckprice"));
					dto.setH_no(rs.getInt("h_no"));
					dto.setH_rno(rs.getInt("h_rno"));
					dto.setPersonnel(rs.getInt("personnel"));
					dto.setTotal_price(rs.getInt("total_price"));
					dto.setUser_no(rs.getInt("user_no"));
					list.add(dto);
				}
			}catch(Exception e){
				System.out.println("예약정보가져오기 오류");
			}finally{
				pool.close(con, pstmt, rs);
			}
			
			return list;
		
		}
		
	}

	
	
	


