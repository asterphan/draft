package net.asterp.dao;

import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import net.asterp.model.Address;
import net.asterp.model.Invoice;
import net.asterp.model.Order;
import net.asterp.model.OrderView;
import net.asterp.model.Product;
import net.asterp.model.User;

public class InvoiceDAO {
	ArrayList<Invoice> list = new ArrayList<Invoice>();

	public ArrayList<Invoice> getProductDetail(int orderId) {
		ArrayList<OrderView> ov = new OrderViewDAO().getAllById(orderId);
		if (!ov.isEmpty()) {
			int no = 1;
			for (OrderView v : ov) {
				Invoice i = new Invoice();
				Product p = new ProductDAO().getProductById(v.getProductId());
				i.setNo(no++);
				i.setItemName(p.getProductName());
				i.setQty(v.getQty());
				i.setUnitPrice(v.getUnitPrice());
				i.setTotal(v.getQty() * v.getUnitPrice());
				list.add(i);
			}
		}
		return list;
	}

	public HashMap<String, Object> getOrderInfo(int orderId) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		Order o = new OrderDAO().getById(orderId);
		System.out.println(o == null);
		User u = new UserDAO().getUser(o.getEmail());
		Address a = new AddressDAO().getAddrById(o.getAddressId());

		String rawString = a.getDetail() + ", " + a.getWard() + ", " + a.getDistrict() + ", " + a.getProvince() + ", "
				+ a.getCountry();
		HashMap<String, Object> info = new HashMap<String, Object>();
		info.put("orderId", o.getOrderId());
		info.put("orderDate", formatter.format(o.getOrderDate()));
		info.put("customerName", u.getFullName().toUpperCase());
		info.put("email", o.getEmail());
		info.put("receiver", a.getFullname().toUpperCase());
		info.put("phone", a.getPhone());
		info.put("address", rawString);
//		info.put("address", VNCharacterUtils.removeAccent(rawString));
		return info;
	}
}
