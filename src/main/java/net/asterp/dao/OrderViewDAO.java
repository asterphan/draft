package net.asterp.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.ArrayList;
import static net.asterp.dbconnection.DBConnection.conn;
import net.asterp.model.OrderView;

public class OrderViewDAO {
	ArrayList<OrderView> list;
	PreparedStatement ps;
	Statement st;
	ResultSet rs;

	public OrderViewDAO() {
		super();
		list = new ArrayList<OrderView>();
	}

	public ArrayList<OrderView> getAllById(int id) {
		list.clear();
		String sql = "SELECT * FROM orderview WHERE OrderID = ?";

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();

			if (rs.next()) {
				do {
					OrderView ord = new OrderView();
					ord.setOrderId(rs.getInt(1));
					ord.setEmail(rs.getString(2));
					ord.setAddressId(rs.getInt(3));
					ord.setOrderDate((LocalDateTime) rs.getObject(4));
					ord.setPaymentType(rs.getInt(5));
					ord.setStatusId(rs.getInt(6));
					ord.setNote(rs.getString(7));
					ord.setProductId(rs.getInt(8));
					ord.setUnitPrice(rs.getDouble(9));
					ord.setQty(rs.getInt(10));
					list.add(ord);
				} while (rs.next());
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	public double getTotalPriceById(int id) {
		double total = 0;
		String sql = "SELECT * FROM orderview WHERE OrderID = ?";

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();

			if (rs.next()) {
				do {
					total += rs.getInt("Quantity") * rs.getDouble("UnitPrice");
				} while (rs.next());
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return total;
	}
}
