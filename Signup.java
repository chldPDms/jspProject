package project;
import java.sql.Timestamp;
public class Signup {
	
	 private int userId;
	 private String id;
	 private String password;
	 private String nickname;
	 private int level;
	 private Timestamp createdAt;
	 private int exp;
	 private String message;
	 private String photo;
	
	
	public Signup() {
		
	}
	
	 public Signup(int userId, String id, String password, String nickname, int level,
             Timestamp createdAt, int exp, String message, String photo) {
   this.userId = userId;
   this.id = id;
   this.password = password;
   this.nickname = nickname;
   this.level = level;
   this.createdAt = createdAt;
   this.exp = exp;
   this.message = message;
   this.photo = photo;
}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public int getExp() {
		return exp;
	}

	public void setExp(int exp) {
		this.exp = exp;
	}
	
	
	
	
}
