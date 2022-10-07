package net.asterp.dao;

import net.asterp.model.Address;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import static net.asterp.dbconnection.DBConnection.conn;

public class AddressDAO {
	ArrayList<Address> list = new ArrayList<Address>();
	ResultSet rs;
	Statement st;
	PreparedStatement ps;

	public AddressDAO() {
		super();
	}

	public ArrayList<Address> getAllAddrByEmail(String email) {
		list.clear();
		String sql = "SELECT * FROM address WHERE Email = ?";

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			rs = ps.executeQuery();

			if (!rs.next()) {
				return null;
			} else {
				do {
					Address a = new Address();
					a.setAddrId(rs.getInt(1));
					a.setEmail(rs.getString(2));
					a.setFirstName(rs.getString(3));
					a.setLastName(rs.getString(4));
					a.setPhone(rs.getString(5));
					a.setCountry(rs.getString(6));
					a.setProvince(rs.getString(7));
					a.setDistrict(rs.getString(8));
					a.setWard(rs.getString(9));
					a.setDetail(rs.getString(10));
					a.setStatus(rs.getString(11));
					if (rs.getInt(12) == 0) {
						a.setDefault(false);
					} else {
						a.setDefault(true);
					}
					list.add(a);
				} while (rs.next());
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	public ArrayList<Address> getEnabledAddrByEmail(String email) {
		list.clear();
		String sql = "SELECT * FROM address WHERE Email = ? AND Status = ? ORDER BY AddressID DESC";

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			ps.setString(2, "Enabled");
			rs = ps.executeQuery();

			if (!rs.next()) {
				return null;
			} else {
				do {
					Address a = new Address();
					a.setAddrId(rs.getInt(1));
					a.setEmail(rs.getString(2));
					a.setFirstName(rs.getString(3));
					a.setLastName(rs.getString(4));
					a.setPhone(rs.getString(5));
					a.setCountry(rs.getString(6));
					a.setProvince(rs.getString(7));
					a.setDistrict(rs.getString(8));
					a.setWard(rs.getString(9));
					a.setDetail(rs.getString(10));
					a.setStatus(rs.getString(11));
					if (rs.getInt(12) == 0) {
						a.setDefault(false);
					} else {
						a.setDefault(true);
					}
					list.add(a);
				} while (rs.next());
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	public ArrayList<Address> getAddrPerPg(int start, int total, String email) {
		list.clear();
		String sql = "SELECT * FROM address WHERE Email = ? AND Status = 'Enabled' ORDER BY isDefault DESC, AddressID DESC LIMIT "
				+ (start - 1) + ", " + total;

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			rs = ps.executeQuery();

			if (!rs.next()) {
				return null;
			} else {
				do {
					Address a = new Address();
					a.setAddrId(rs.getInt(1));
					a.setEmail(rs.getString(2));
					a.setFirstName(rs.getString(3));
					a.setLastName(rs.getString(4));
					a.setPhone(rs.getString(5));
					a.setCountry(rs.getString(6));
					a.setProvince(rs.getString(7));
					a.setDistrict(rs.getString(8));
					a.setWard(rs.getString(9));
					a.setDetail(rs.getString(10));
					a.setStatus(rs.getString(11));
					if (rs.getInt(12) == 0) {
						a.setDefault(false);
					} else {
						a.setDefault(true);
					}
					list.add(a);
				} while (rs.next());
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	public int countRows(String email) {
		String sqlCount = "SELECT COUNT(*) FROM address WHERE Email = ? AND Status = 'Enabled'";
		try {
			ps = conn.prepareStatement(sqlCount);
			ps.setString(1, email);
			rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}

	public boolean insert(Address a) {
		String sql = "INSERT INTO address (Email, FirstName, LastName, PhoneNo, Province, District, Ward, AddressDetail, Status, isDefault) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, a.getEmail());
			ps.setNString(2, a.getFirstName());
			ps.setNString(3, a.getLastName());
			ps.setString(4, a.getPhone());
			ps.setNString(5, a.getProvince());
			ps.setNString(6, a.getDistrict());
			ps.setNString(7, a.getWard());
			ps.setNString(8, a.getDetail());
			ps.setString(9, "Enabled");
			ps.setInt(10, 0);

			return (ps.executeUpdate() > 0);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public boolean update(Address a) {
		String sql = "UPDATE address SET FirstName = ?, LastName = ?, PhoneNo = ?, Province = ?, District = ?, Ward = ?, AddressDetail = ? WHERE AddressID = ?";

		try {
			ps = conn.prepareStatement(sql);
			ps.setNString(1, a.getFirstName());
			ps.setNString(2, a.getLastName());
			ps.setString(3, a.getPhone());
			ps.setNString(4, a.getProvince());
			ps.setNString(5, a.getDistrict());
			ps.setNString(6, a.getWard());
			ps.setNString(7, a.getDetail());
			ps.setInt(8, a.getAddrId());

			return (ps.executeUpdate() > 0);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public boolean updateDefault(Address a) {
		String sql = "UPDATE address SET isDefault = ? WHERE AddressID = ?";
		try {
			ps = conn.prepareStatement(sql);
			if (a.isDefault()) {
				ps.setInt(1, 1);
			} else {
				ps.setInt(1, 0);
			}
			ps.setInt(2, a.getAddrId());
			return (ps.executeUpdate() > 0);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public Address searchDefault(String email) {
		String sql = "SELECT * FROM address WHERE Email = ? AND Status = 'Enabled' AND isDefault = 1";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			rs = ps.executeQuery();
			if (rs.next()) {
				Address a = new Address();
				a.setAddrId(rs.getInt(1));
				a.setEmail(rs.getString(2));
				a.setFirstName(rs.getString(3));
				a.setLastName(rs.getString(4));
				a.setPhone(rs.getString(5));
				a.setCountry(rs.getString(6));
				a.setProvince(rs.getString(7));
				a.setDistrict(rs.getString(8));
				a.setWard(rs.getString(9));
				a.setDetail(rs.getString(10));
				a.setStatus(rs.getString(11));
				if (rs.getInt(12) == 0) {
					a.setDefault(false);
				} else {
					a.setDefault(true);
				}
				return a;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public boolean changeDefault(String email, Address a) {
		String sqlUnsetCurrent = "UPDATE address SET isDefault = 0 WHERE Email = ? AND Status = 'Enabled' AND isDefault = 1";
		String sqlSetDefault = "UPDATE address SET isDefault = ? WHERE AddressID = ?";

		try {
			ps = conn.prepareStatement(sqlUnsetCurrent);
			ps.setString(1, email);
			if (ps.executeUpdate() > 0) {
				ps = conn.prepareStatement(sqlSetDefault);
				if (a.isDefault()) {
					ps.setInt(1, 1);
				} else {
					ps.setInt(1, 0);
				}
				ps.setInt(2, a.getAddrId());
				return (ps.executeUpdate() > 0);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public boolean updateStatus(Address a) {
		String sql = "UPDATE address SET Status = ? WHERE AddressID = ?";

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, a.getStatus());
			ps.setInt(2, a.getAddrId());

			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public int isDefault(Address a) {
		String sql = "SELECT isDefault FROM address WHERE AddressID = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, a.getAddrId());
			rs = ps.executeQuery();

			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}

	public Address getLastAddress(String email) {
		String sql = "SELECT * FROM address WHERE Email = ? AND Status = 'Enabled' ORDER BY AddressID DESC LIMIT 1";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			rs = ps.executeQuery();

			if (rs.next()) {
				Address a = new Address();
				a.setAddrId(rs.getInt(1));
				a.setEmail(rs.getString(2));
				a.setFirstName(rs.getString(3));
				a.setLastName(rs.getString(4));
				a.setPhone(rs.getString(5));
				a.setCountry(rs.getString(6));
				a.setProvince(rs.getString(7));
				a.setDistrict(rs.getString(8));
				a.setWard(rs.getString(9));
				a.setDetail(rs.getString(10));
				a.setStatus(rs.getString(11));
				if (rs.getInt(12) == 0) {
					a.setDefault(false);
				} else {
					a.setDefault(true);
				}
				return a;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public Address getAddrById(int id) {
		String sql = "SELECT * FROM address WHERE AddressID = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();

			if (rs.next()) {
				Address a = new Address();
				a.setAddrId(rs.getInt(1));
				a.setEmail(rs.getString(2));
				a.setFirstName(rs.getString(3));
				a.setLastName(rs.getString(4));
				a.setPhone(rs.getString(5));
				a.setCountry(rs.getString(6));
				a.setProvince(rs.getString(7));
				a.setDistrict(rs.getString(8));
				a.setWard(rs.getString(9));
				a.setDetail(rs.getString(10));
				a.setStatus(rs.getString(11));
				if (rs.getInt(12) == 0) {
					a.setDefault(false);
				} else {
					a.setDefault(true);
				}
				
//				System.out.println(new String(rs.getString(10).getBytes("UTF-8")));
				System.out.println(rs.getString(10));
				return a;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

}
