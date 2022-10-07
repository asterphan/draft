package net.asterp.dao;
import static net.asterp.dbconnection.DBConnection.conn;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.asterp.model.PaymentType;

public class PaymentTypeDAO {
	ArrayList<PaymentType> list;
	PreparedStatement ps;
	Statement st;
	ResultSet rs;

	public PaymentTypeDAO() {
		super();
		list = new ArrayList<PaymentType>();
	}
	
	public ArrayList<PaymentType> getAll() {
		list.clear();
		String sql = "SELECT * FROM paymenttypes";
		
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			
			if (rs.next()) {
				do {
					PaymentType type = new PaymentType();
					type.setTypeId(rs.getInt(1));
					type.setTypeName(rs.getString(2));
					type.setDesc(rs.getString(3));
					list.add(type);
				} while (rs.next());
			} else {
				return null;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	
	public PaymentType getById(int id) {
		PaymentType p = new PaymentType();
		String sql = "SELECT * FROM paymenttypes WHERE TypeID = ?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();
			
			if (rs.next()) {
				p.setTypeId(rs.getInt(1));
				p.setTypeName(rs.getString(2));
				p.setDesc(rs.getString(3));
			} else {
				return null;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return p;
	}
	
}
