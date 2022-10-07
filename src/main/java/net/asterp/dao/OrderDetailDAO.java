package net.asterp.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import static net.asterp.dbconnection.DBConnection.conn;
import net.asterp.model.OrderDetail;

public class OrderDetailDAO {
	PreparedStatement ps;
	ResultSet rs;

	public OrderDetailDAO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public boolean insert(ArrayList<OrderDetail> list) {
		String sql = "INSERT INTO orderdetails VALUES (?, ?, ?, ?)";
		
		try {
			conn.setAutoCommit(false);
			ps = conn.prepareStatement(sql);
			for (OrderDetail od : list) {
				ps.setInt(1, od.getOrderId());
				ps.setInt(2, od.getProductId());
				ps.setDouble(3, od.getUnitPrice());
				ps.setInt(4, od.getQuantity());
				ps.addBatch();
			}
			boolean success = ps.executeBatch().length > 0;
			conn.commit();
			return success;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

}
