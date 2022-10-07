package net.asterp.dao;

import java.sql.Blob;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import static net.asterp.dbconnection.DBConnection.conn;
import net.asterp.model.CartItem;
import net.asterp.model.Product;

public class ShoppingCart {
	private ArrayList<CartItem> cartList;
	PreparedStatement ps;
	Statement st;
	ResultSet rs;

	public ShoppingCart() {
		super();
		cartList = new ArrayList<CartItem>();
	}

	public ShoppingCart(ArrayList<CartItem> cartList) {
		super();
		this.cartList = cartList;
	}

	public ArrayList<CartItem> getCartList() {
		return cartList;
	}

	public void setCartList(ArrayList<CartItem> cartList) {
		this.cartList = cartList;
	}

	public void addItem(CartItem cartItem) {
		cartList.add(cartItem);
	}

	public void deleteItem(CartItem cartItem) {
		cartList.remove(cartItem);
	}

	public void removeItem(int id) {
		CartItem item = getExistedItem(id);
		deleteItem(item);
	}

	public boolean isExisted(int id) {
		CartItem i = new CartItem();
		i.setProductId(id);
		for (CartItem item : cartList) {
			if (item.equals(i)) {
				return true;
			}
		}
		return false;
	}

	public CartItem getExistedItem(int id) {
		for (CartItem item : cartList) {
			if (item.getProductId() == id) {
				return item;
			}
		}
		return null;
	}

	public int getExistedItemIndex(int id) {
		for (int i = 0; i < cartList.size(); i++) {
			if (cartList.get(i).getProductId() == id) {
				return i;
			}
		}
		return -1;
	}

	public void addToCart(int id, int qty) {
		if (isExisted(id)) {
			int index = getExistedItemIndex(id);
			int newQty = cartList.get(index).getQuantity() + qty;
			cartList.get(index).setQuantity(newQty);
		} else {
			Product p = new ProductDAO().getProductById(id);
			CartItem cartItem = new CartItem();
			cartItem.setProductId(p.getProductId());
			cartItem.setProductName(p.getProductName());
			cartItem.setImgBlob(p.getImgBlob());
			cartItem.setUnitPrice(p.getUnitPrice());
			cartItem.setQuantity(qty);
			addItem(cartItem);
		}
	}

	public void changeQty(int id, int qty) {
		if (isExisted(id)) {
			int index = getExistedItemIndex(id);
			cartList.get(index).setQuantity(qty);
		}
	}

	public int countItem() {
		return cartList.size();
	}

	public ArrayList<CartItem> loadCartFromDb(String email) {
		cartList.clear();
		String sql = "SELECT * FROM cartview WHERE Email = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			rs = ps.executeQuery();

			if (rs.next()) {
				do {
					Blob blob = rs.getBlob("ImgBlob");
					String img = new ProductDAO().convertBlobToBase64(blob);
					CartItem item = new CartItem();
					item.setProductId(rs.getInt("ProductID"));
					item.setProductName(rs.getString("ProductName"));
					item.setImgBlob(img);
					item.setQuantity(rs.getInt("Qty"));
					item.setUnitPrice(rs.getDouble("UnitPrice"));
					cartList.add(item);
				} while (rs.next());
			}
			deleteCartInDb(email);
			return cartList;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public void deleteCartInDb(String email) {
		String sqlSelect = "SELECT * FROM cart WHERE Email = ?";
		String sqlDelete = "DELETE FROM cartdetails WHERE CartID = ?";
		String sqlDelete2 = "DELETE FROM cart WHERE CartID = ?";
		int cartId = 0;
		try {
			ps = conn.prepareStatement(sqlSelect);
			ps.setString(1, email);
			rs = ps.executeQuery();

			if (rs.next()) {
				cartId = rs.getInt("CartID");
			}
			ps = conn.prepareStatement(sqlDelete);
			ps.setInt(1, cartId);
			ps.executeUpdate();
			ps = conn.prepareStatement(sqlDelete2);
			ps.setInt(1, cartId);
			ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public boolean storeCartInDb(String email) {
		String sqlCart = "INSERT INTO cart(Email, LastUpdate) VALUES (?, ?)";
		String sqlGetID = "SELECT * FROM cart WHERE Email = ? ORDER BY CartID DESC LIMIT 1";
		String sqlCartDet = "INSERT INTO cartdetails(CartID, ProductID, Qty) VALUES (?, ?, ?)";
		int cartId = 0;

		try {
			Date date = new Date();
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String currentDateTime = format.format(date);

			ps = conn.prepareStatement(sqlCart);
			ps.setString(1, email);
			ps.setString(2, currentDateTime);

			if (ps.executeUpdate() > 0) {
				ps = conn.prepareStatement(sqlGetID);
				ps.setString(1, email);
				rs = ps.executeQuery();
				if (rs.next()) {
					cartId = rs.getInt("CartID");
				}
			}

			conn.setAutoCommit(false);
			ps = conn.prepareStatement(sqlCartDet);
			for (CartItem item : cartList) {
				ps.setInt(1, cartId);
				ps.setInt(2, item.getProductId());
				ps.setInt(3, item.getQuantity());
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

	public double totalPrice() {
		double total = 0;
		for (CartItem item : cartList) {
			total += item.getUnitPrice() * item.getQuantity();
		}
		return total;
	}
	
	public void clearCart() {
		cartList.clear();
	}

}
