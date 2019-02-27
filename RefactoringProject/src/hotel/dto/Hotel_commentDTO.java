package hotel.dto;

import java.sql.Timestamp;

public class Hotel_commentDTO {

	int h_no;
	int h_c_no;
	String subject;
	String content;
	Timestamp regdate;
	int bestcount;
	int user_no;
	
	public int getH_no() {
		return h_no;
	}
	public void setH_no(int h_no) {
		this.h_no = h_no;
	}
	public int getH_c_no() {
		return h_c_no;
	}
	public void setH_c_no(int h_c_no) {
		this.h_c_no = h_c_no;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getRegdate() {
		return regdate;
	}
	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}
	public int getBestcount() {
		return bestcount;
	}
	public void setBestcount(int bestcount) {
		this.bestcount = bestcount;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	
	
	
}
