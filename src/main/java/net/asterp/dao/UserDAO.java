package net.asterp.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import net.asterp.model.User;
import static net.asterp.dbconnection.DBConnection.conn;

public class UserDAO {
	ArrayList<User> list = new ArrayList<User>();
	Statement st;
	PreparedStatement ps;
	ResultSet rs;
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss");

	public UserDAO() {
		super();
	}

	public ArrayList<User> getAll() {
		list.clear();

		String sql = "SELECT * FROM users";

		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);

			while (rs.next()) {
				User u = new User();
				u.setEmail(rs.getString(1));
				u.setPassword(rs.getString(2));
				u.setFname(rs.getNString(3));
				u.setLname(rs.getNString(4));
				u.setPhoneNo(rs.getString(5));
				u.setGender(rs.getString(6));
				u.setRole(rs.getString(7));
				u.setLastLogin((LocalDateTime) rs.getObject(8));
				u.setLastLogout((LocalDateTime) rs.getObject(9));
				list.add(u);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return list;
	}
	
	public ArrayList<User> getAllByRole(String role) {
		
		String sql = "SELECT * FROM users WHERE Role = ?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, role);
			rs = ps.executeQuery();
			
			if (!rs.next()) {
				return null;
			} else {
				do {
					User u = new User();
					u.setEmail(rs.getString(1));
					u.setPassword(rs.getString(2));
					u.setFname(rs.getString(3));
					u.setLname(rs.getString(4));
					u.setPhoneNo(rs.getString(5));
					u.setGender(rs.getString(6));
					u.setRole(rs.getString(7));
					u.setLastLogin((LocalDateTime) rs.getObject(8));
					u.setLastLogout((LocalDateTime) rs.getObject(9));
					list.add(u);
				} while (rs.next());
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}

	public User getUser(String email) {
		User u = new User();

		String sql = "SELECT * FROM users WHERE Email = ?";

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			rs = ps.executeQuery();

			while (rs.next()) {
				u.setEmail(rs.getString(1));
				u.setPassword(rs.getString(2));
				u.setFname(rs.getString(3));
				u.setLname(rs.getString(4));
				u.setPhoneNo(rs.getString(5));
				u.setGender(rs.getString(6));
				u.setRole(rs.getString(7));
				u.setLastLogin((LocalDateTime) rs.getObject(8));
				u.setLastLogout((LocalDateTime) rs.getObject(9));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return u;
	}

	public boolean update(String field, String value, String email) {
		String sql = "UPDATE users SET " + field + " = ? WHERE Email = ?";

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, value);
			ps.setString(2, email);

			return ps.executeUpdate() != 0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return false;
	}

	public boolean insert(User u) {
		String sql = "INSERT INTO users VALUES (?, ?, ?, ?, ?, ?, ?)";
		String role;
		
		if (u.getRole().equals("cus")) {
			role = "Customer";
		} else {
			role = "Admin";
		}
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, u.getEmail());
			ps.setString(2, u.getPassword());
			ps.setString(3, u.getFname());
			ps.setString(4, u.getLname());
			ps.setString(5, u.getPhoneNo());
			ps.setString(6, u.getGender());
			ps.setString(7, role);
			
			return (ps.executeUpdate() > 0);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return false;
	}
	
	public boolean setLastLogin(User u) {
		String sql = "UPDATE users SET LastLogin = ? WHERE Email = ?";
		LocalDateTime now = LocalDateTime.now();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, formatter.format(now));
			ps.setString(2, u.getEmail());
			
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean setLastLogout(User u) {
		String sql = "UPDATE users SET LastLogout = ? WHERE Email = ?";
		LocalDateTime now = LocalDateTime.now();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, formatter.format(now));
			ps.setString(2, u.getEmail());
			
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
}
