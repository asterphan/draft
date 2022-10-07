package net.asterp.dao;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import javax.servlet.http.Part;

import java.sql.Blob;

import static net.asterp.dbconnection.DBConnection.conn;
import net.asterp.model.Product;

public class ProductDAO {
	ArrayList<Product> list = new ArrayList<Product>();
	Statement st;
	ResultSet rs;
	PreparedStatement ps;

	public ProductDAO() {
		super();
	}

	public ArrayList<Product> getAll() {
		list.clear();
		String sql = "SELECT * FROM products";

		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);

			if (rs.next()) {
				do {
					Blob blob = rs.getBlob("ImgBlob");
					String img = convertBlobToBase64(blob);

					Product p = new Product();
					p.setProductId(rs.getInt(1));
					p.setProductName(rs.getString(2));
					p.setDescription(rs.getString(3));
					p.setCategoryId(rs.getInt(4));
					p.setUnitPrice(rs.getDouble(5));
					p.setImgBlob(img);
					p.setStatus(rs.getString(8));
					list.add(p);

				} while (rs.next());
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return list;
	}

	public ArrayList<Product> getEnabledProducts() {
		list.clear();

		String sql = "SELECT * FROM products WHERE Status = 'Enabled'";

		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);

			if (rs.next()) {
				do {
					Blob blob = (Blob) rs.getBlob("ImgBlob");
					String img = convertBlobToBase64(blob);

					Product p = new Product();
					p.setProductId(rs.getInt(1));
					p.setProductName(rs.getString(2));
					p.setDescription(rs.getString(3));
					p.setCategoryId(rs.getInt(4));
					p.setUnitPrice(rs.getDouble(5));
					p.setImgBlob(img);
					p.setStatus(rs.getString(8));
					list.add(p);

				} while (rs.next());
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return list;
	}

	public ArrayList<Product> getRecordsPerPage(int start, int total) {
		list.clear();

		String sql = "SELECT * FROM products WHERE Status = 'Enabled' LIMIT " + (start - 1) + ", " + total;

		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);

			if (rs.next()) {
				do {
					Blob blob = (Blob) rs.getBlob("ImgBlob");
					String img = convertBlobToBase64(blob);

					Product p = new Product();
					p.setProductId(rs.getInt(1));
					p.setProductName(rs.getString(2));
					p.setDescription(rs.getString(3));
					p.setCategoryId(rs.getInt(4));
					p.setUnitPrice(rs.getDouble(5));
					p.setImgBlob(img);
					p.setStatus(rs.getString(8));
					list.add(p);

				} while (rs.next());
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return list;
	}

	public int countAllProducts() {
		int count = 0;

		String sql = "SELECT COUNT(*) AS NumberOfRows FROM products WHERE Status = 'Enabled'";

		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);

			while (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return count;
	}

	public int countProductsByCategoryId(int categoryId) {
		int count = 0;

		String sql = "SELECT COUNT(*) AS NumberOfRows FROM products WHERE Status = 'Enabled' AND CategoryID = ?";

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, categoryId);
			rs = ps.executeQuery();

			while (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return count;
	}

	public ArrayList<Product> getRecordsPerPageByIds(int start, int total, ArrayList<Integer> ids) {
		list.clear();

		String sql = "SELECT * FROM products WHERE Status = 'Enabled' AND CategoryID IN (";

		for (int i = 0; i < ids.size(); i++) {
			sql += ids.get(i);
			if (i != ids.size() - 1) {
				sql += ",";
			}
		}

		sql += ") LIMIT " + (start - 1) + ", " + total;

		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);

			if (rs.next()) {
				do {
					Blob blob = (Blob) rs.getBlob("ImgBlob");
					String img = convertBlobToBase64(blob);

					Product p = new Product();
					p.setProductId(rs.getInt(1));
					p.setProductName(rs.getString(2));
					p.setDescription(rs.getString(3));
					p.setCategoryId(rs.getInt(4));
					p.setUnitPrice(rs.getDouble(5));
					p.setImgBlob(img);
					p.setStatus(rs.getString(8));
					list.add(p);

				} while (rs.next());
			}
		} catch (SQLException e) { // TODO Auto-generated catch block
			e.printStackTrace();
		}

		return list;
	}

	public ArrayList<Product> getRandomProducts(int numberOfProducts) {
		list.clear();

		String sql = "SELECT * FROM products ORDER BY RAND() LIMIT ?";

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, numberOfProducts);
			rs = ps.executeQuery();

			if (rs.next()) {
				do {
					Blob blob = (Blob) rs.getBlob("ImgBlob");
					String img = convertBlobToBase64(blob);

					Product p = new Product();
					p.setProductId(rs.getInt(1));
					p.setProductName(rs.getString(2));
					p.setDescription(rs.getString(3));
					p.setCategoryId(rs.getInt(4));
					p.setUnitPrice(rs.getDouble(5));
					p.setImgBlob(img);
					p.setStatus(rs.getString(8));
					list.add(p);

				} while (rs.next());
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return list;
	}

	public Product getProductById(int id) {
		Product p = new Product();

		String sql = "SELECT * FROM products WHERE ProductID = ?";

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();

			if (rs.next()) {
				Blob blob = (Blob) rs.getBlob("ImgBlob");
				String img = convertBlobToBase64(blob);

				p.setProductId(rs.getInt(1));
				p.setProductName(rs.getString(2));
				p.setDescription(rs.getString(3));
				p.setCategoryId(rs.getInt(4));
				p.setUnitPrice(rs.getDouble(5));
				p.setImgBlob(img);
				p.setStatus(rs.getString(8));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return p;
	}

	public ArrayList<Product> getLatestProducts(int numberofProducts) {
		list.clear();

		String sql = "SELECT * FROM products WHERE Status = 'Enabled' ORDER BY ProductID DESC LIMIT ?";

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, numberofProducts);
			rs = ps.executeQuery();

			if (rs.next()) {
				do {
					Blob blob = (Blob) rs.getBlob("ImgBlob");
					String img = convertBlobToBase64(blob);

					Product p = new Product();
					p.setProductId(rs.getInt(1));
					p.setProductName(rs.getString(2));
					p.setDescription(rs.getString(3));
					p.setCategoryId(rs.getInt(4));
					p.setUnitPrice(rs.getDouble(5));
					p.setImgBlob(img);
					p.setStatus(rs.getString(8));
					list.add(p);

				} while (rs.next());
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return list;
	}

	public String convertBlobToBase64(Blob blob) {
		InputStream inputStream;
		String base64Image = null;
		try {
			inputStream = blob.getBinaryStream();
			ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
			byte[] buffer = new byte[4096];
			int bytesRead = -1;

			while ((bytesRead = inputStream.read(buffer)) != -1) {
				outputStream.write(buffer, 0, bytesRead);
			}

			byte[] imageBytes = outputStream.toByteArray();
			base64Image = Base64.getEncoder().encodeToString(imageBytes);

			inputStream.close();
			outputStream.close();
		} catch (SQLException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return base64Image;

	}

	public double getMaxPrice() {
		String sql = "SELECT MAX(UnitPrice) AS MaxPrice FROM products";

		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);

			if (rs.next()) {
				return rs.getDouble(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}

	public int generateMaxPriceRange() {
		double maxPrice = getMaxPrice();
		return (int) (maxPrice / 10 + 1) * 10;
	}

	public List<String> getAllProductStt() {
		List<String> stt = new ArrayList<>();
		String sql = "SELECT DISTINCT Status FROM products";

		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);

			if (rs.next()) {
				do {
					stt.add(rs.getString(1));
				} while (rs.next());
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return stt;
	}

	public boolean updateProduct(Product p) {
		String sql = "UPDATE products SET ProductName = ?, Description = ?, CategoryID = ?, UnitPrice = ?"
				+ "WHERE ProductID = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, p.getProductName());
			ps.setString(2, p.getDescription());
			ps.setInt(3, p.getCategoryId());
			ps.setDouble(4, p.getUnitPrice());

			ps.setInt(5, p.getProductId());

			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public boolean updateProdImg(Part part, int id) {
		String sql = "UPDATE products SET ImgBlob = ? WHERE ProductID = ?";
		try {
			InputStream stream = part.getInputStream();
			System.out.println(part.getName());
			System.out.println(part.getSize());
			System.out.println(part.getContentType());
			ps = conn.prepareStatement(sql);
			ps.setBlob(1, stream);
			ps.setInt(2, id);

			return ps.executeUpdate() > 0;
		} catch (IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public boolean disableProduct(int id) {
		String sql = "UPDATE products SET Status = ? WHERE ProductID = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, "Disabled");
			ps.setInt(2, id);

			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public int getLastProductID() {
		String sql = "SELECT ProductID FROM products ORDER BY ProductID DESC LIMIT 1";
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

	public boolean insertProduct(Product p, Part part) {
		String sql = "INSERT INTO products(ProductID, ProductName, Description, CategoryID, UnitPrice, Status, ImgBlob) VALUES (?, ?, ?, ?, ?, ?, ?)";
		int id = getLastProductID() + 1;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			ps.setString(2, p.getProductName());
			ps.setString(3, p.getDescription());
			ps.setInt(4, p.getCategoryId());
			ps.setDouble(5, p.getUnitPrice());
			ps.setString(6, "Enabled");
			
			InputStream stream = part.getInputStream();
			System.out.println(part.getName());
			System.out.println(part.getSize());
			System.out.println(part.getContentType());
			ps.setBlob(7, stream);

			return ps.executeUpdate() > 0;
		} catch (SQLException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

}
