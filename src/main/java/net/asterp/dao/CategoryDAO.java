package net.asterp.dao;

import net.asterp.model.Category;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import static net.asterp.dbconnection.DBConnection.conn;

public class CategoryDAO {
	ArrayList<Category> list = new ArrayList<Category>();
	PreparedStatement ps;
	Statement st;
	ResultSet rs;

	public CategoryDAO() {
		super();
	}

	public ArrayList<Category> getAll() {
		list.clear();
		String sql = "SELECT * FROM categories";

		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);

			while (rs.next()) {
				Category c = new Category();
				c.setCategoryId(rs.getInt(1));
				c.setCategoryName(rs.getString(2));
				list.add(c);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return list;
	}
	
	public Category getById(int id) {
		String sql = "SELECT * FROM categories WHERE CategoryID = ?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();
			
			if (rs.next()) {
				Category c = new Category();
				c.setCategoryId(rs.getInt(1));
				c.setCategoryName(rs.getString(2));
				return c;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public boolean update(Category c) {
		String sql = "UPDATE categories SET CategoryName = ? WHERE CategoryID = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, c.getCategoryName());
			ps.setInt(2, c.getCategoryId());
			
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
	public int getLastId() {
		String sql = "SELECT CategoryID FROM categories ORDER BY CategoryID DESC LIMIT 1";
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}
	
	public boolean insert(String name) {
		String sql = "INSERT INTO categories VALUES (?, ?)";
		int id = getLastId() + 1;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			ps.setString(2, name);
			
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

}
