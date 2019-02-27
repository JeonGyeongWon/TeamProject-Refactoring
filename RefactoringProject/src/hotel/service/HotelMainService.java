package hotel.service;

import java.util.ArrayList;

import dao.HotelDAO;
import hotel.dto.HotelDTO;

public class HotelMainService {
	
	public ArrayList<HotelDTO>getBringAllHotelInfo(int startRow, int endRow){
		
		HotelDAO dao = new HotelDAO();
		
		ArrayList<HotelDTO> list = dao.allselectedHotel(startRow, endRow);
		for(int i =0; i<list.size(); i++){
			HotelDTO dto = list.get(i);
			
			if(dto.getH_content().length()>30)
			dto.setH_content(dto.getH_content().substring(30)+"......");	//메인에 뿌려줄때 30자만 나오게설정..
		}
		
		return list;
		
	}

	public ArrayList<HotelDTO> getBringSearch(int key, String word, int startRow, int endRow) {
		
		HotelDAO dao = new HotelDAO();
		ArrayList<HotelDTO> list = dao.getSearchHotel(key,word,startRow, endRow);
		return list;
		
	}

	public int getTotalCount() {
		// TODO Auto-generated method stub
		HotelDAO dao = new HotelDAO();
		
		return dao.getTotalCount();
	}
	
}
