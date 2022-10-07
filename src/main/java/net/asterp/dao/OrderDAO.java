package net.asterp.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.ArrayList;
import net.asterp.model.Order;
import static net.asterp.dbconnection.DBConnection.conn;

public class OrderDAO {
	ArrayList<Order> list = new ArrayList<Order>();
	Statement st;
	PreparedStatement ps;
	ResultSet rs;

	public OrderDAO() {
		super();
	}
	
	public ArrayList<Order> getAll() {
		list.clear();
		String sql = "SELECT * FROM orders";
		
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			
			if (rs.next()) {
				do {
					Order o = new Order();
					o.setOrderId(rs.getInt(1));
					o.setEmail(rs.getString(2));
					o.setAddressId(rs.getInt(3));
					o.setOrderDate((LocalDateTime) rs.getObject(4));
					o.setPaymentType(rs.getInt(5));
					o.setStatusId(rs.getInt(6));
					o.setNote(rs.getString(7));
					list.add(o);
				} while (rs.next());
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	public Order getById(int id) {
		String sql = "SELECT * FROM orders WHERE OrderID = ?";
		Order o = new Order();

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();

			if (rs.next()) {
				o.setOrderId(id);
				o.setEmail(rs.getString("Email"));
				o.setAddressId(rs.getInt("AddressID"));
				o.setOrderDate((LocalDateTime) rs.getObject("OrderDate"));
				o.setPaymentType(rs.getInt("PaymentType"));
				o.setStatusId(rs.getInt("StatusID"));
				o.setNote(rs.getString("Note"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return o;
	}

	public ArrayList<Order> getAllByEmail(String email) {
		list.clear();
		String sql = "SELECT * FROM orders WHERE Email = ? ORDER BY OrderID DESC";

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			rs = ps.executeQuery();

			if (rs.next()) {
				do {
					Order order = new Order();
					order.setOrderId(rs.getInt(1));
					order.setEmail(rs.getString(2));
					order.setAddressId(rs.getInt(3));
					order.setOrderDate((LocalDateTime) rs.getObject(4));
					order.setPaymentType(rs.getInt(5));
					order.setStatusId(rs.getInt(6));
					order.setNote(rs.getString(7));
					list.add(order);
				} while (rs.next());
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	public boolean insert(Order order) {
		String sql = "INSERT INTO orders (Email, AddressID, PaymentType, Note) VALUES (?, ?, ?, ?)";

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, order.getEmail());
			ps.setInt(2, order.getAddressId());
			ps.setInt(3, order.getPaymentType());
			ps.setString(4, order.getNote());

			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public boolean cancel(int id) {
		String sql = "UPDATE orders SET StatusID = 5 WHERE OrderID = ?";

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);

			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public int getLastId() {
		String sql = "SELECT OrderID FROM orders ORDER BY OrderID DESC LIMIT 1";

		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);

			if (rs.next()) {
				do {
					return rs.getInt(1);
				} while (rs.next());
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}

	public boolean updateStatus(int orderId, int sttId) {
		String sql = "UPDATE orders SET StatusID = ? WHERE OrderID = ?";

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, sttId);
			ps.setInt(2, orderId);

			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

}
