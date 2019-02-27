package hotel.dto;

import java.sql.Timestamp;


public class HotelDTO {

	int h_no;
	String h_name;
	String h_content;
	String h_addr;
	String h_caution;
	String h_rule;
	String h_detail;
	Timestamp h_regdate;
	String h_imgpath;
	String h_imgname;
	int h_bestcount;
	int user_no;
	private double Latitude;
	private double Hardness;
	
	
	
	public double getLatitude() {
		return Latitude;
	}
	public void setLatitude(double latitude) {
		Latitude = latitude;
	}
	public double getHardness() {
		return Hardness;
	}
	public void setHardness(double hardness) {
		Hardness = hardness;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	
	public int getH_no() {
		return h_no;
	}
	public void setH_no(int h_no) {
		this.h_no = h_no;
	}
	public String getH_name() {
		return h_name;
	}
	public void setH_name(String h_name) {
		this.h_name = h_name;
	}
	public String getH_content() {
		return h_content;
	}
	public void setH_content(String h_content) {
		this.h_content = h_content;
	}
	public String getH_addr() {
		return h_addr;
	}
	public void setH_addr(String h_addr) {
		this.h_addr = h_addr;
	}
	public String getH_caution() {
		return h_caution;
	}
	public void setH_caution(String h_caution) {
		this.h_caution = h_caution;
	}
	public String getH_rule() {
		return h_rule;
	}
	public void setH_rule(String h_rule) {
		this.h_rule = h_rule;
	}
	public String getH_detail() {
		return h_detail;
	}
	public void setH_detail(String h_detail) {
		this.h_detail = h_detail;
	}
	public Timestamp getH_regdate() {
		return h_regdate;
	}
	public void setH_regdate(Timestamp h_regdate) {
		this.h_regdate = h_regdate;
	}
	public String getH_imgpath() {
		return h_imgpath;
	}
	public void setH_imgpath(String h_imgpath) {
		this.h_imgpath = h_imgpath;
	}
	public String getH_imgname() {
		return h_imgname;
	}
	public void setH_imgname(String h_imgname) {
		this.h_imgname = h_imgname;
	}
	public int getH_bestcount() {
		return h_bestcount;
	}
	public void setH_bestcount(int h_bestcount) {
		this.h_bestcount = h_bestcount;
	}
	
	
	
		
	
}
