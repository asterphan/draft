package net.asterp.dbconnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	public static Connection conn = createConnection();

	public static Connection createConnection() {
		Connection conn = null;
		String url = "jdbc:mysql://localhost:3306/nasaspacedb?useUnicode=true&characterEncoding=utf-8";
		String username = "root";
		String password = "aster19";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, username, password);
			System.out.println("Connected");

			/* conn.close(); */
		} catch (SQLException | ClassNotFoundException ex) {
			ex.printStackTrace();
		}
		return conn;
	}
}
