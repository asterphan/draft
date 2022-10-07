package net.asterp.model;

import java.time.LocalDateTime;
import java.util.ArrayList;

public class OrderView {
	private int orderId;
	private String email;
	private int addressId;
	private LocalDateTime orderDate;
	private int paymentType;
	private int statusId;
	private String note;
	private int productId;
	private double unitPrice;
	private int qty;
	public OrderView() {
		super();
		// TODO Auto-generated constructor stub
	}
	public OrderView(int orderId, String email, int addressId, LocalDateTime orderDate, int paymentType,
			int statusId, String note, int productId, double unitPrice, int qty) {
		super();
		this.orderId = orderId;
		this.email = email;
		this.addressId = addressId;
		this.orderDate = orderDate;
		this.paymentType = paymentType;
		this.statusId = statusId;
		this.note = note;
		this.productId = productId;
		this.unitPrice = unitPrice;
		this.qty = qty;
	}
	/**
	 * @return the orderId
	 */
	public int getOrderId() {
		return orderId;
	}
	/**
	 * @param orderId the orderId to set
	 */
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * @return the addressId
	 */
	public int getAddressId() {
		return addressId;
	}
	/**
	 * @param addressId the addressId to set
	 */
	public void setAddressId(int addressId) {
		this.addressId = addressId;
	}
	/**
	 * @return the orderDate
	 */
	public LocalDateTime getOrderDate() {
		return orderDate;
	}
	/**
	 * @param orderDate the orderDate to set
	 */
	public void setOrderDate(LocalDateTime orderDate) {
		this.orderDate = orderDate;
	}
	/**
	 * @return the paymentType
	 */
	public int getPaymentType() {
		return paymentType;
	}
	/**
	 * @param paymentType the paymentType to set
	 */
	public void setPaymentType(int paymentType) {
		this.paymentType = paymentType;
	}
	/**
	 * @return the statusId
	 */
	public int getStatusId() {
		return statusId;
	}
	/**
	 * @param statusId the statusId to set
	 */
	public void setStatusId(int statusId) {
		this.statusId = statusId;
	}
	/**
	 * @return the note
	 */
	public String getNote() {
		return note;
	}
	/**
	 * @param note the note to set
	 */
	public void setNote(String note) {
		this.note = note;
	}
	/**
	 * @return the productId
	 */
	public int getProductId() {
		return productId;
	}
	/**
	 * @param productId the productId to set
	 */
	public void setProductId(int productId) {
		this.productId = productId;
	}
	/**
	 * @return the unitPrice
	 */
	public double getUnitPrice() {
		return unitPrice;
	}
	/**
	 * @param unitPrice the unitPrice to set
	 */
	public void setUnitPrice(double unitPrice) {
		this.unitPrice = unitPrice;
	}
	/**
	 * @return the qty
	 */
	public int getQty() {
		return qty;
	}
	/**
	 * @param qty the qty to set
	 */
	public void setQty(int qty) {
		this.qty = qty;
	}
	
}
