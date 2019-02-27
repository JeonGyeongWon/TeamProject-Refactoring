package together;

public class ActionForward {
	private boolean isRedirect=false;
	private String path=null;
	
	public void setRedirect(boolean b){
		isRedirect=b;
	}
	public boolean isRedirect(){
		return isRedirect;
	}
	
	public void setPath(String path){
		this.path=path;
	}
	public String getPath(){
		return path;
	}
	
	
	
	
}
