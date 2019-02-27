package hotel.dto;

import java.sql.Timestamp;

public class ReservationDTO {

	private int h_no;
	private int h_rno;
	private int user_no;
	private int total_price;
	private int ckprice;
	private Timestamp ckin;
	private Timestamp ckout;
	private int personnel;
	
	
	
	public int getPersonnel() {
		return personnel;
	}
	public void setPersonnel(int personnel) {
		this.personnel = personnel;
	}
	public int getH_no() {
		return h_no;
	}
	public void setH_no(int h_no) {
		this.h_no = h_no;
	}
	public int getH_rno() {
		return h_rno;
	}
	public void setH_rno(int h_rno) {
		this.h_rno = h_rno;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public int getTotal_price() {
		return total_price;
	}
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}
	
	public int getCkprice() {
		return ckprice;
	}
	public void setCkprice(int ckprice) {
		this.ckprice = ckprice;
	}
	public Timestamp getCkin() {
		return ckin;
	}
	public void setCkin(Timestamp ckin) {
		this.ckin = ckin;
	}
	public Timestamp getCkout() {
		return ckout;
	}
	public void setCkout(Timestamp ckout) {
		this.ckout = ckout;
	}
	
	
	
}
