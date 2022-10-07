package net.asterp.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import net.asterp.model.OrderStatus;
import static net.asterp.dbconnection.DBConnection.conn;

public class OrderStatusDAO {
	ArrayList<OrderStatus> list = new ArrayList<OrderStatus>();
	PreparedStatement ps;
	Statement st;
	ResultSet rs;

	public OrderStatusDAO() {
		super();
	}

	public ArrayList<OrderStatus> getAll() {
		list.clear();
		String sql = "SELECT * FROM orderstatus";

		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);

			if (rs.next()) {
				do {
					OrderStatus status = new OrderStatus();
					status.setStatusId(rs.getInt(1));
					status.setDesc(rs.getString(2));
					list.add(status);
				} while (rs.next());
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	public OrderStatus getById(int id) {
		String sql = "SELECT * FROM orderstatus WHERE StatusID = ?";

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();

			if (rs.next()) {
				OrderStatus status = new OrderStatus();
				status.setStatusId(rs.getInt(1));
				status.setDesc(rs.getString(2));
				return status;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

}
