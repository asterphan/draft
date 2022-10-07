package net.asterp.model;

import java.time.LocalDateTime;
import java.util.Objects;

public class User {
	private String email;
	private String password;
	private String fname;
	private String lname;
	private String phoneNo;
	private String gender;
	private String role;
	private LocalDateTime lastLogin;
	private LocalDateTime lastLogout;

	public User() {
		super();
		// TODO Auto-generated constructor stub
	}

	public User(String email, String password, String fname, String lname, String phoneNo, String gender, String role,
			LocalDateTime lastLogin, LocalDateTime lastLogout) {
		super();
		this.email = email;
		this.password = password;
		this.fname = fname;
		this.lname = lname;
		this.phoneNo = phoneNo;
		this.gender = gender;
		this.role = role;
		this.lastLogin = lastLogin;
		this.lastLogout = lastLogout;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getLname() {
		return lname;
	}

	public void setLname(String lname) {
		this.lname = lname;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	/**
	 * @return the lastLogin
	 */
	public LocalDateTime getLastLogin() {
		return lastLogin;
	}

	/**
	 * @param lastLogin the lastLogin to set
	 */
	public void setLastLogin(LocalDateTime lastLogin) {
		this.lastLogin = lastLogin;
	}

	/**
	 * @return the lastLogout
	 */
	public LocalDateTime getLastLogout() {
		return lastLogout;
	}

	/**
	 * @param lastLogout the lastLogout to set
	 */
	public void setLastLogout(LocalDateTime lastLogout) {
		this.lastLogout = lastLogout;
	}

	@Override
	public int hashCode() {
		return Objects.hash(email, password, role);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		User other = (User) obj;
		return Objects.equals(email, other.email) && Objects.equals(password, other.password)
				&& Objects.equals(role, other.role);
	}
	
	public String getFullName() {
		return getFname() + " " + getLname();
	}

}
